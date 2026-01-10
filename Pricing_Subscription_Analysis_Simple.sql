-- 1. Database & Table Setup
CREATE DATABASE IF NOT EXISTS pricing_subscription_db;
USE pricing_subscription_db;

CREATE TABLE subscriptions (
    User_ID VARCHAR(10) PRIMARY KEY,
    Subscription_Plan VARCHAR(20),
    Start_Date DATE,
    End_Date DATE,
    Revenue DECIMAL(10,2),
    Is_Churned BOOLEAN,
    Country VARCHAR(50)
);

-- 2. ADVANCED KPI: Month-over-Month (MoM) Revenue Growth
-- This uses a CTE and Window Functions (LAG) to show growth trends
WITH MonthlyRevenue AS (
    SELECT 
        DATE_FORMAT(Start_Date, '%Y-%m') AS month,
        SUM(Revenue) AS current_month_rev
    FROM subscriptions
    GROUP BY 1
)
SELECT 
    month,
    current_month_rev,
    LAG(current_month_rev) OVER (ORDER BY month) AS previous_month_rev,
    ROUND(((current_month_rev - LAG(current_month_rev) OVER (ORDER BY month)) / 
           NULLIF(LAG(current_month_rev) OVER (ORDER BY month), 0)) * 100, 2) AS mom_growth_pct
FROM MonthlyRevenue;

-- 3. ADVANCED ANALYSIS: Churn Risk by Plan vs. Average Revenue
-- This uses CTEs to calculate multiple metrics in one clean view
WITH PlanMetrics AS (
    SELECT 
        Subscription_Plan,
        COUNT(User_ID) AS total_users,
        SUM(CASE WHEN Is_Churned = 1 THEN 1 ELSE 0 END) AS churned_users,
        SUM(Revenue) AS total_rev
    FROM subscriptions
    GROUP BY Subscription_Plan
)
SELECT 
    Subscription_Plan,
    ROUND((churned_users * 100.0 / total_users), 2) AS churn_rate_pct,
    ROUND((total_rev / total_users), 2) AS ARPU, -- Average Revenue Per User
    CASE 
        WHEN (churned_users * 100.0 / total_users) > 20 THEN 'High Risk'
        WHEN (churned_users * 100.0 / total_users) BETWEEN 10 AND 20 THEN 'Medium Risk'
        ELSE 'Healthy'
    END AS retention_status
FROM PlanMetrics
ORDER BY churn_rate_pct DESC;

-- 4. BUSINESS INSIGHT: Free-to-Paid Conversion Rate
SELECT 
    COUNT(DISTINCT CASE WHEN Subscription_Plan != 'Free' THEN User_ID END) * 100.0 / 
    COUNT(DISTINCT User_ID) AS conversion_rate_pct
FROM subscriptions;

-- 5. GEOGRAPHICAL ANALYSIS: Revenue Concentration
-- Ranking countries by revenue using Window Functions
SELECT 
    Country,
    SUM(Revenue) AS Total_Revenue,
    RANK() OVER (ORDER BY SUM(Revenue) DESC) as revenue_rank
FROM subscriptions
GROUP BY Country;
