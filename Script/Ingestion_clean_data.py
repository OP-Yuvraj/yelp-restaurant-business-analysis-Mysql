import os
import logging
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError

# =========================
# LOGGING SETUP
# =========================
os.makedirs("logs", exist_ok=True)

logging.basicConfig(
    filename="logs/ingestion.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    filemode="a"
)

logging.info("Pipeline Started")

# =========================
# DATABASE CONNECTION
# =========================
DB_USER = "root"
DB_PASSWORD = "1234"
DB_HOST = "127.0.0.1"
DB_PORT = 3306
DB_NAME = "yelp_db"

DATABASE_URL = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

try:
    engine = create_engine(DATABASE_URL)
    conn = engine.connect()
    logging.info("Connected to MySQL")
    print("Connected to MySQL")
except SQLAlchemyError as e:
    logging.error(f"Connection Failed: {e}")
    raise


# =========================
# IQR OUTLIER REMOVAL FUNCTION
# =========================
def remove_outliers_iqr(connection, table_name, column_name):

    query = f"""
    SELECT {column_name}
    FROM {table_name}
    ORDER BY {column_name}
    """

    values = connection.execute(text(query)).fetchall()
    values = [row[0] for row in values]

    n = len(values)

    q1_index = int(n * 0.25)
    q3_index = int(n * 0.75)

    q1 = values[q1_index]
    q3 = values[q3_index]

    iqr = q3 - q1
    lower_bound = q1 - 1.5 * iqr
    upper_bound = q3 + 1.5 * iqr

    print(f"Q1={q1}, Q3={q3}")
    print(f"IQR={iqr}")
    print(f"Lower={lower_bound}, Upper={upper_bound}")

    delete_query = f"""
    DELETE FROM {table_name}
    WHERE {column_name} < {lower_bound}
       OR {column_name} > {upper_bound}
    """

    connection.execute(text(delete_query))
    connection.commit()
 


    logging.info(f"Outliers removed from {table_name}.{column_name}")


# =========================
# CLEAN BUSINESS TABLE
# =========================
conn.execute(text("DROP TABLE IF EXISTS restaurant_business"))

conn.execute(text("""
CREATE TABLE restaurant_business AS
SELECT DISTINCT business_id,
       name,
       city,
       state,
       stars,
       review_count,
       categories
FROM business
WHERE LOWER(categories) LIKE '%restaurant%'
AND business_id IS NOT NULL
AND name IS NOT NULL
AND city IS NOT NULL
AND state IS NOT NULL
AND stars IS NOT NULL
AND review_count IS NOT NULL
"""))

conn.commit()
logging.info("restaurant_business created")

# Remove Outliers
remove_outliers_iqr(conn, "restaurant_business", "review_count")


# =========================
# CLEAN REVIEW TABLE
# =========================
conn.execute(text("DROP TABLE IF EXISTS restaurant_review"))

conn.execute(text("""
CREATE TABLE restaurant_review AS
SELECT DISTINCT r.*
FROM review r
JOIN restaurant_business rb
ON r.business_id = rb.business_id
WHERE r.review_id IS NOT NULL
AND r.user_id IS NOT NULL
AND r.text IS NOT NULL
AND r.stars IS NOT NULL
"""))

conn.commit()
logging.info("restaurant_review created")


# =========================
# CLEAN TIP TABLE
# =========================
conn.execute(text("DROP TABLE IF EXISTS restaurant_tip"))

conn.execute(text("""
CREATE TABLE restaurant_tip AS
SELECT DISTINCT t.*
FROM tip t
JOIN restaurant_business rb
ON t.business_id = rb.business_id
WHERE t.text IS NOT NULL
"""))

conn.commit()
logging.info("restaurant_tip created")


# =========================
# CLEAN CHECKIN TABLE
# =========================
conn.execute(text("DROP TABLE IF EXISTS restaurant_checkin"))

conn.execute(text("""
CREATE TABLE restaurant_checkin AS
SELECT DISTINCT c.*
FROM checkin c
JOIN restaurant_business rb
ON c.business_id = rb.business_id
WHERE c.date IS NOT NULL
"""))

conn.commit()
logging.info("restaurant_checkin created")


# =========================
# CLEAN USER TABLE
# =========================
conn.execute(text("DROP TABLE IF EXISTS clean_user"))

conn.execute(text("""
CREATE TABLE clean_user AS
SELECT DISTINCT u.*
FROM user u
JOIN restaurant_review rr
ON u.user_id = rr.user_id
WHERE u.user_id IS NOT NULL
AND u.name IS NOT NULL
"""))

conn.commit()
logging.info("clean_user created")

conn.close()
logging.info("Pipeline Completed Successfully")
print("All cleaned tables created successfully.")

