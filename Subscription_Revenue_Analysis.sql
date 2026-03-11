/* =========================================================
   KPI 1: MONTH-OVER-MONTH (MoM) REVENUE GROWTH
   (Simple Solution: Uses a "Self-Join" instead of LAG)
   ========================================================= */

-- Step 1: We create two versions of the same monthly data (a and b)
-- Step 2: We join them where 'b' is exactly one month before 'a'
SELECT 
    cur.month,
    cur.revenue AS current_month_revenue,
    prev.revenue AS previous_month_revenue,
    ROUND(((cur.revenue - prev.revenue) / prev.revenue) * 100, 2) AS mom_growth_pct
FROM (
    SELECT DATE_FORMAT(Start_Date, '%Y-%m') AS month, SUM(Revenue) AS revenue
    FROM subscriptions GROUP BY 1
) cur
LEFT JOIN (
    SELECT DATE_FORMAT(Start_Date, '%Y-%m') AS month, SUM(Revenue) AS revenue
    FROM subscriptions GROUP BY 1
) prev 
ON PERIOD_DIFF(REPLACE(cur.month, '-', ''), REPLACE(prev.month, '-', '')) = 1
ORDER BY cur.month;


/* =========================================================
   KPI 2: CHURN RATE & ARPU BY PLAN
   (Simple Solution: Removed CTE and used AVG for math)
   ========================================================= */

SELECT 
    Subscription_Plan,
    ROUND(AVG(Is_Churned) * 100, 2) AS churn_rate_pct,
    ROUND(AVG(Revenue), 2) AS arpu,
    CASE 
        WHEN AVG(Is_Churned) > 0.20 THEN 'High Risk'
        WHEN AVG(Is_Churned) BETWEEN 0.10 AND 0.20 THEN 'Medium Risk'
        ELSE 'Healthy'
    END AS retention_status
FROM subscriptions
GROUP BY Subscription_Plan
ORDER BY churn_rate_pct DESC;


/* =========================================================
   KPI 3: FREE-TO-PAID CONVERSION RATE
   ========================================================= */

SELECT 
    ROUND(
        COUNT(CASE WHEN Subscription_Plan <> 'Free' THEN 1 END) * 100.0 / COUNT(*), 
        2
    ) AS conversion_rate_pct
FROM subscriptions;


/* =========================================================
   KPI 4: GEOGRAPHIC REVENUE CONCENTRATION
   (Simple Solution: Simple Order By effectively ranks the data)
   ========================================================= */

SELECT 
    Country,
    SUM(Revenue) AS total_revenue
FROM subscriptions
GROUP BY Country
ORDER BY total_revenue DESC;


/* =========================================================
   BONUS: DATA INTEGRITY AUDIT
   (Identifying inconsistencies mentioned in your Project Overview)
   ========================================================= */

SELECT 
    User_ID, 
    Subscription_Plan, 
    Revenue
FROM subscriptions
WHERE Subscription_Plan <> 'Free' AND Revenue = 0; 
-- This flags "Paid" users who aren't being charged (Revenue Leakage)
