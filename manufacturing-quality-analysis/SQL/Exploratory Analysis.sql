
-- EXPLORATORY DATA ANALYSIS
-- ================================

-- Overall production performance
SELECT
    SUM(Units_Produced) AS total_units,
    SUM(Defects) AS total_defects,
    ROUND(SUM(Defects) / NULLIF(SUM(Units_Produced), 0), 4) AS defect_rate,
    ROUND(AVG(Down_Time_Hours), 2) AS avg_downtime,
    ROUND(AVG(Scrap_Rate), 3) AS avg_scrap_rate
FROM manufacture_duplicate;

-- Defect rate by product type
SELECT
    Product_Type,
    SUM(Units_Produced) AS total_units,
    SUM(Defects) AS total_defects,
    ROUND(SUM(Defects) / NULLIF(SUM(Units_Produced), 0), 4) AS defect_rate
FROM manufacture_duplicate
GROUP BY Product_Type
ORDER BY defect_rate DESC;

-- Defect rate by shift
SELECT
    Shift,
    SUM(Units_Produced) AS total_units,
    SUM(Defects) AS total_defects,
    ROUND(SUM(Defects) / NULLIF(SUM(Units_Produced), 0), 4) AS defect_rate,
    ROUND((SUM(Defects) / NULLIF(SUM(Units_Produced), 0)) * 100, 2) AS defect_rate_percent
FROM manufacture_duplicate
GROUP BY Shift
ORDER BY defect_rate DESC;

-- Defect rate by shift and product type
SELECT
    Product_Type,
    Shift,
    SUM(Units_Produced) AS total_units,
    SUM(Defects) AS total_defects,
    ROUND(SUM(Defects) / NULLIF(SUM(Units_Produced), 0), 4) AS defect_rate
FROM manufacture_duplicate
GROUP BY Product_Type, Shift
ORDER BY Product_Type, defect_rate DESC;

-- Machine-level defect analysis
SELECT
    Machine_ID,
    SUM(Units_Produced) AS total_units,
    SUM(Defects) AS total_defects,
    ROUND(SUM(Defects) / NULLIF(SUM(Units_Produced), 0), 4) AS defect_rate
FROM manufacture_duplicate
GROUP BY Machine_ID
ORDER BY total_defects DESC;

-- Machine performance by shift
SELECT
    Machine_ID,
    Shift,
    SUM(Units_Produced) AS total_units,
    SUM(Defects) AS total_defects,
    ROUND(SUM(Defects) / NULLIF(SUM(Units_Produced), 0), 4) AS defect_rate
FROM manufacture_duplicate
GROUP BY Machine_ID, Shift
ORDER BY Machine_ID, defect_rate DESC;
