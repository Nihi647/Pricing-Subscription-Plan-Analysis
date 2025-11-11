
-- 1. Create Database
CREATE DATABASE IF NOT EXISTS pricing_subscription_db;
USE pricing_subscription_db;

-- 2. Create Table
CREATE TABLE subscriptions (
    User_ID VARCHAR(10) PRIMARY KEY,
    Subscription_Plan VARCHAR(20),
    Start_Date DATE,
    End_Date DATE,
    Revenue DECIMAL(10,2),
    Is_Churned BOOLEAN,
    Country VARCHAR(50)
);

-- 3. Free-to-Paid Conversion Rate
SELECT 
    COUNT(DISTINCT CASE WHEN Subscription_Plan != 'Free' THEN User_ID END) * 100.0 / 
    COUNT(DISTINCT User_ID) AS conversion_rate
FROM subscriptions;

-- 4. Average Revenue Per User (ARPU)
SELECT 
    Subscription_Plan,
    ROUND(SUM(Revenue) / COUNT(DISTINCT User_ID), 2) AS ARPU
FROM subscriptions
GROUP BY Subscription_Plan;

-- 5. Churn Rate by Plan
SELECT 
    Subscription_Plan,
    COUNT(CASE WHEN Is_Churned = 1 THEN User_ID END) * 100.0 / COUNT(User_ID) AS churn_rate
FROM subscriptions
GROUP BY Subscription_Plan;

-- 6. Total Revenue by Plan
SELECT 
    Subscription_Plan,
    SUM(Revenue) AS Total_Revenue
FROM subscriptions
GROUP BY Subscription_Plan
ORDER BY Total_Revenue DESC;

-- 7. Country-wise Revenue
SELECT 
    Country,
    SUM(Revenue) AS Total_Revenue
FROM subscriptions
GROUP BY Country
ORDER BY Total_Revenue DESC;
