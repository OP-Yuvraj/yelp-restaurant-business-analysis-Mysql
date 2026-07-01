# 🍽️ Yelp Restaurant Business Performance Analysis Dashboard

## 📌 Project Overview
This project analyzes restaurant business performance using the Yelp dataset. The goal is to help stakeholders understand restaurant market trends before starting a new restaurant business.

This dashboard provides insights into:
- Top cities for restaurant business
- Restaurant traffic by check-in hour
- Rating distribution
- Seasonal trends
- Top restaurant brand performance

---

# 🎯 Problem Statement
A big tycoon company plans to start a new restaurant business and wants to analyze the restaurant industry before investing.

The stakeholder wants answers to:
- Which city is best for restaurant business?
- What are peak customer traffic hours?
- How are restaurant ratings distributed?
- Which season performs best?
- Which restaurant brands perform best for collaboration?

This dashboard helps stakeholders make data-driven business decisions.

---

# 📂 Dataset
Dataset Used: **Yelp Academic Dataset**

Main Files:
- yelp_academic_dataset_business.json
- yelp_academic_dataset_checkin.json
- yelp_academic_dataset_review.json
- yelp_academic_dataset_tip.json
- yelp_academic_dataset_user.json

---

# 🛠️ Tools & Technologies
- Python
- Pandas
- MySQL
- SQL
- Excel Dashboard
- VS Code

Libraries:
- SQLAlchemy
- PyMySQL

---

# 🧹 Data Cleaning & Processing
Main preprocessing steps:
- Loaded raw JSON files
- Filtered restaurant businesses only
- Removed null values
- Cleaned duplicate brands
- Processed check-in timestamps
- Created restaurant-specific tables in MySQL

---

# 📊 KPI Metrics

| KPI | Value |
|-----|-------|
| Total Restaurants | 46,945 |
| Total Brands | 32,498 |
| Average Rating | 3.47 |
| Average Review Count | 45.95 |

---

# 📈 Dashboard Analysis

## Top Cities by Success Score
- Highest Success: Reno
- Lowest Success: Edmonton

## Restaurant Traffic by Check-in Hour
- Peak Traffic: 5 PM – 12 AM
- Lowest Traffic: 7 AM – 10 AM

## Rating Distribution
- Most restaurants rated: 3.5–4.0 ★
- Least restaurants rated: 1.0–1.5 ★

## Seasonal Trends
- Highest Engagement: Summer
- Lowest Engagement: Fall

## Top Brand Performance
Top performing brands:
- McDonald's
- Chick-fil-A
- Chipotle

---

# 📷 Dashboard Preview

![alt text](<Screenshot (1041).png>)

---

# 🚀 Project Workflow

```bash
Raw Yelp Dataset
      ↓
Python Data Cleaning
      ↓
MySQL Database Storage
      ↓
SQL Analysis
      ↓
CSV Export
      ↓
Excel Dashboard
      ↓
Business Insights
```

---

# 📁 Project Structure

```bash
YELP/
│
├── Dashboard/
│   ├── raw_csv/
│   ├── README.md
│   └── yelp_Dashboard.xlsx
│
├── Data/
│   ├── yelp_academic_dataset_business.json
│   ├── yelp_academic_dataset_checkin.json
│   ├── yelp_academic_dataset_review.json
│   ├── yelp_academic_dataset_tip.json
│   └── yelp_academic_dataset_user.json
│
├── logs/
│   └── ingestion.log
│
├── Notebook/
│   └── yelp_restaurant_analysis.ipynb.ipynb
│
├── Report/
│   ├── Dashboard Report.pdf
│   └── EDA Report.pdf
│
├── Script/
│   ├── database_creation.py
│   └── Ingestion_clean_data.py
│
└── README.md
```

---




# 🔍 Key Business Insights
- Restaurant market contains 46K+ businesses
- Reno offers strongest opportunity for expansion
- Evening traffic dominates restaurant engagement
- Most restaurants fall in 3.5–4 rating range
- Summer shows better performance
- Large brands dominate customer engagement

---

# 💡 Business Recommendations
- Expand in high-success cities
- Focus on evening operations
- Improve customer satisfaction
- Optimize seasonal campaigns
- Study top-performing brands

---

# 🏁 Conclusion
This project demonstrates how Data Analytics and Business Intelligence solve real-world business problems.

The dashboard helps stakeholders understand:
- Market opportunities
- Customer behavior
- Brand performance
- Business strategies

This enables better decision-making before entering the restaurant industry.

---

# 👨‍💻 Author
**Yuvraj Singh**  
BCA Student | Aspiring Data Analyst  
Skills: Python, SQL, Excel, Power BI, Machine Learning