
import pandas as pd
import json
import os
import logging
import time
from sqlalchemy import create_engine, text
from sqlalchemy.dialects.mysql import LONGTEXT
from sqlalchemy.exc import SQLAlchemyError

#%%


# =========================
# 🪵 LOGGING SETUP
# =========================
os.makedirs("logs", exist_ok=True)
logging.basicConfig(
    filename="logs/ingestion.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    filemode="a",
)
logging.info(" Ingestion started")

# =========================
# 🔌 DATABASE CONNECTION
# =========================
DB_USER     = "root"
DB_PASSWORD = "1234"     # Changed to string
DB_HOST     = "127.0.0.1"
DB_PORT     = 3306
DB_NAME     = "yelp_db"

# Connect to MySQL without database first to ensure DB exists
temp_engine = create_engine(f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}")
try:
    with temp_engine.connect() as conn:
        conn.execute(text(f"CREATE DATABASE IF NOT EXISTS {DB_NAME}"))
    print(f"Database '{DB_NAME}' verified/created.")
except Exception as e:
    print(f"Error creating database: {e}")

DATABASE_URL = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

try:
    engine = create_engine(DATABASE_URL, pool_pre_ping=True)
    with engine.connect() as conn:
        conn.execute(text("SELECT 1"))
    logging.info(" Database connection established")
    print(" Connected to MySQL")
except SQLAlchemyError as e:
    logging.critical(f" Cannot connect to database: {e}")
    print(f" Database connection failed: {e}")
    raise SystemExit(1)


def clean_nested_columns(df):

    for col in df.columns:

        df[col] = df[col].apply(
            lambda x: json.dumps(x)
            if isinstance(x, (dict, list))
            else x
        )

    return df



# -----------------------------------------
# SMALL / MEDIUM DATASETS
# -----------------------------------------

small_files = {
    "business": "yelp_academic_dataset_business.json",
    "tip": "yelp_academic_dataset_tip.json"
}

# Dictionary to store dataframes for the final summary
dfs = {}

for table_name, file in small_files.items():

     logging.info(f"{table_name} dataset loading start")
     print(f"Loading {table_name}...")

     df = pd.read_json(
        file,
        lines=True
     )
     df = clean_nested_columns(df)
     dfs[table_name] = df # Store reference

     logging.info(df.shape)

     df.to_sql(
        table_name,
        con=engine,
        if_exists="replace",
        index=False
     )
     logging.info(f"{table_name} stored successfully")



# -----------------------------------------
# REVIEW DATASET (VERY LARGE)
# -----------------------------------------

logging.info("Review dataset loading start")
print("Loading reviews (chunked)...")

review_chunks = pd.read_json(
    "yelp_academic_dataset_review.json",
    lines=True,
    chunksize=100000
)

total_review_rows = 0
for i, chunk in enumerate(review_chunks, start=1):
    chunk = clean_nested_columns(chunk)
    total_review_rows += len(chunk)

    chunk.to_sql(
        "review",
        con=engine,
        if_exists="append" if i > 1 else "replace", # Replace on first chunk
        index=False,
        dtype={
            "text": LONGTEXT
        }
    )

    logging.info(f"Review chunk {i} inserted")


# -----------------------------------------
# USER DATASET (LARGE)
# -----------------------------------------
logging.info("User dataset loading start")
print("Loading users (chunked)...")

user_chunks = pd.read_json(
    "yelp_academic_dataset_user.json",
    lines=True,
    chunksize=50000
)

total_user_rows = 0
for i, chunk in enumerate(user_chunks, start=1):
    chunk = clean_nested_columns(chunk)
    total_user_rows += len(chunk)

    chunk.to_sql(
        "user",
        con=engine,
        if_exists="append" if i > 1 else "replace", # Replace on first chunk
        index=False,
        dtype={"friends": LONGTEXT,
               "elite": LONGTEXT}

    )

    logging.info(f"User chunk {i} inserted")

##----------------------------------------------------------------------
print("Loading checkins...")
checkin_df = pd.read_json(
    "yelp_academic_dataset_checkin.json",
    lines=True
)

checkin_df.to_sql(
    "checkin",
    con=engine,
    if_exists="replace",
    index=False,
    dtype={
        "date": LONGTEXT
    }
)

logging.info("Checkin dataset stored successfully")


# -----------------------------------------
# COMPLETED
# -----------------------------------------

logging.info("\nAll Yelp datasets stored successfully!")