/* =========================================================
   DATABASE & TABLE SETUP
   ========================================================= */

CREATE DATABASE IF NOT EXISTS pricing_subscription_db;
USE pricing_subscription_db;

CREATE TABLE subscriptions (
    user_id VARCHAR(10) PRIMARY KEY,
    subscription_plan VARCHAR(20),
    start_date DATE,
    end_date DATE,
    revenue DECIMAL(10,2),
    is_churned BOOLEAN,
    country VARCHAR(50)
);


/* =========================================================
   KPI 1: MONTH-OVER-MONTH (MoM) REVENUE GROWTH
   (Advanced SQL required → Window Function)
   ========================================================= */

WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(start_date, '%Y-%m') AS month,
        SUM(revenue) AS revenue
    FROM subscriptions
    GROUP BY DATE_FORMAT(start_date, '%Y-%m')
)
SELECT 
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month)) 
        / LAG(revenue) OVER (ORDER BY month) * 100,
        2
    ) AS mom_growth_pct
FROM monthly_revenue;


/* =========================================================
   KPI 2: CHURN RATE & ARPU BY SUBSCRIPTION PLAN
   (Simplified aggregation – no unnecessary CTE)
   ========================================================= */

SELECT 
    subscription_plan,
    ROUND(SUM(is_churned) * 100.0 / COUNT(*), 2) AS churn_rate_pct,
    ROUND(SUM(revenue) / COUNT(*), 2) AS arpu,
    CASE
        WHEN SUM(is_churned) * 100.0 / COUNT(*) > 20 THEN 'High Risk'
        WHEN SUM(is_churned) * 100.0 / COUNT(*) BETWEEN 10 AND 20 THEN 'Medium Risk'
        ELSE 'Healthy'
    END AS retention_status
FROM subscriptions
GROUP BY subscription_plan
ORDER BY churn_rate_pct DESC;


/* =========================================================
   KPI 3: FREE-TO-PAID CONVERSION RATE
   ========================================================= */

SELECT 
    ROUND(
        COUNT(CASE WHEN subscription_plan <> 'Free' THEN 1 END) 
        * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_pct
FROM subscriptions;


/* =========================================================
   KPI 4: GEOGRAPHIC REVENUE CONCENTRATION
   (Advanced SQL required → Ranking)
   ========================================================= */

SELECT 
    country,
    SUM(revenue) AS total_revenue,
    RANK() OVER (ORDER BY SUM(revenue) DESC) AS revenue_rank
FROM subscriptions
GROUP BY country;
