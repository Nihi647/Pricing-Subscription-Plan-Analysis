# 📊 SaaS Subscription & Pricing Audit
### Identifying Growth Opportunities Through Data-Driven Insights

---

## 📌 Project Overview

This project performs a **data-driven audit of SaaS subscription tiers** to uncover opportunities for **revenue growth, pricing optimization, and churn reduction**.

Using SQL-based analysis of subscription data, the project evaluates **user behavior, churn trends, revenue patterns, and unit economics** to generate actionable insights for business decision-making.

The analysis highlights **revenue leakage, high-risk subscription tiers, and geographic growth opportunities**, enabling SaaS companies to optimize pricing strategies and improve customer retention.

---

## 🎯 Business Questions Addressed

This analysis answers several key business questions:

### 1️⃣ Revenue Growth
- What is the **Month-over-Month (MoM) revenue trend**?
- Are revenues growing consistently or stagnating?

### 2️⃣ Churn Risk
- Which subscription tiers have **high churn rates (>20%)**?
- Which customer segments require retention strategies?

### 3️⃣ Unit Economics
- What is the **Average Revenue Per User (ARPU)** across subscription plans?
- Which plan generates the most sustainable revenue?

### 4️⃣ Revenue Leakage
- Are there users on **paid plans generating $0 revenue**?
- Are billing integrations working correctly?

---

## 🛠️ SQL Techniques Used

The analysis uses advanced SQL techniques to ensure scalability and maintainability.

**Key techniques include:**

- **Self Joins**
  - Used for **time-series comparisons** such as Month-over-Month revenue growth.

- **Conditional Logic (`CASE WHEN`)**
  - Automated segmentation of plans into:
    - High Risk
    - Medium Risk
    - Healthy

- **Aggregations**
  - Calculated:
    - Churn Rate
    - Average Revenue Per User (ARPU)
    - Plan-wise revenue contribution

- **Data Integrity Auditing**
  - Identified inconsistencies in billing data
  - Compared **Free vs Paid conversion ratios**

---

## 📁 Project Structure

```
SaaS-Subscription-Audit/
│
├── Subscription_Analysis.sql
│   Clean and optimized SQL queries used for analysis
│
├── Sample_Subscription_Dataset.csv
│   Dataset containing 200+ user records with
│   geographic, subscription, and revenue data
│
└── README.md
    Project overview and insights
```

---

## 📈 Key Insights & Recommendations

| Insight | Recommendation | Expected Impact |
|------|------|------|
| **High Churn in Basic Plan** | Introduce a **10% loyalty discount for annual renewals** | +12% retention |
| **Revenue Leakage Detected** | Audit billing integration for **Premium & Enterprise plans** | +5% monthly revenue |
| **Geographic Revenue Concentration** | USA & Australia contribute **60% of revenue** | Expand marketing & localized pricing |
| **Untapped Indian Market** | Introduce **localized pricing for India** | +20% user acquisition |

---

## 💡 Business Value

This project demonstrates how **SQL analytics can drive strategic decisions** in SaaS businesses by:

- Identifying **revenue leaks and billing inconsistencies**
- Detecting **high churn subscription tiers**
- Improving **pricing strategies**
- Revealing **new geographic growth opportunities**

---

## 🧰 Tools Used

- **SQL (PostgreSQL / MySQL compatible)**
- Data Analysis Techniques
- Business Analytics
- SaaS Metrics Analysis

---

## 🔮 Future Improvements

- Build a **Power BI / Tableau dashboard** for interactive insights
- Add **cohort analysis for retention tracking**
- Implement **predictive churn modeling using machine learning**
