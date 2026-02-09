
SELECT * FROM telco
limit 200;

describe telco;


-- EXECUTIVE SUMMARY METRICS (Calculate the global Churn Rate and Revenue)
WITH ChurnStats AS (
	SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    SUM(MonthlyCharges) AS total_mrr,
    SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) AS lost_mrr
    from telco
   
)
SELECT 
	total_customers,
    churned_customers,
    ROUND((churned_customers * 100 / total_customers),2) AS churn_Rate_Percent,
    ROUND((lost_mrr * 100 / total_mrr), 2) AS revenue_Lost_percet
 FROM ChurnStats;
 
 
 -- CONTRACT SEGMENTATION ANALYSIS (Evaluate the impact of contract duration on customer retention)
 WITH Contract_Analysis AS (
	SELECT 
    Contract,
    COUNT(*) AS total_customer,
    SUM(CASE WHEN Churn = 'Yes' Then 1 ELSE 0 END) AS CHURN_COUNT,
    SUM(MonthlyCharges) AS TOTAL_MRR,
    SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) AS LOST_MRR
    FROM telco
    GROUP BY Contract
 )
 SELECT 
 Contract,
 total_customer,
 CHURN_COUNT,
 ROUND((CHURN_COUNT * 100 / total_customer),2) AS CHURN_RATE_PERCENT,
 ROUND((LOST_MRR * 100.0 / Total_MRR), 2) AS Revenue_Loss_Percent
 FROM Contract_Analysis;
 
 
 
 -- SERVICE PRODUCT ANALYSIS (Identify which internet service categories contribute most to customer attrition)
 WITH internet_analysis AS (
	SELECT 
    InternetService,
    COUNT(*) AS total_customer,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churn_Count,
    SUM(MonthlyCharges) AS TOTAL_MRR,
    SUM(CASE WHEN Churn = 'Yes' Then MonthlyCharges ELSE 0 END) AS LOST_MRR
    FROM telco
    GROUP BY InternetService
 )
 SELECT 
 InternetService,
 CHURN_COUNT,
 ROUND((Churn_Count * 100 / total_customer),2) AS CHURN_RATE_PERCENT,
 ROUND((LOST_MRR * 100.0 / TOTAL_MRR), 2) AS Revenue_Loss_Percent
 FROM internet_analysis;

-- MULTIVARIATE DEEP DIVE: CONTRACT & SERVICE COMBINATION
SELECT 
Contract,
InternetService,
COUNT(*) AS total_customers,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS total_churn,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS Churn_Rate_Percent,
ROUND(SUM(CAST(MonthlyCharges AS FLOAT)), 2) AS Total_MRR,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN CAST(MonthlyCharges AS FLOAT) ELSE 0 END), 2) AS Lost_MRR
FROM telco
GROUP BY Contract, InternetService
ORDER BY Lost_MRR DESC;


-- 
SELECT 
Contract,
InternetService,
ROUND(SUM(CAST(MonthlyCharges AS FLOAT)), 2) AS Total_MRR,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN CAST(MonthlyCharges AS FLOAT) ELSE 0 END), 2) AS Lost_MRR,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) *100 / SUM(CAST(MonthlyCharges AS FLOAT)), 2) AS PERCENT
FROM telco
GROUP BY Contract, InternetService
ORDER BY Lost_MRR DESC;


-- TENURE SEGMENTATION ANALYSIS (Pinpoint exactly when customers are most likely to drop off)
SELECT 
CASE 
	WHEN tenure <= 6 THEN '0-6 Month'
    WHEN tenure <= 12 THEN '6-12 Month'
    WHEN tenure <= 24 THEN '1-2 Years'
    ELSE 'Over Two Years'
END AS Tenure_Group,
COUNT(*) AS TotalCustomer,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM telco
GROUP BY 1;


-- TENURE SEGMENTATION ANALYSIS (Pinpoint exactly when customers are most likely to drop off)
SELECT 
    CASE 
        WHEN tenure <= 6 THEN '0-6 Months'
        WHEN tenure <= 12 THEN '7-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE 'Over 48 Months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_count,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM telco
GROUP BY 1
ORDER BY 1 ASC;


-- SERVICE STICKINESS (Impact of Tech Support on Retention)
SELECT 
    TechSupport,
    OnlineSecurity,
    COUNT(*) AS total_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM telco
GROUP BY TechSupport, OnlineSecurity
ORDER BY churn_rate_pct DESC;