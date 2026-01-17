
-- BUSINESS INSIGHTS & RISK AREAS
-- ================================

-- Machines with highest average downtime
SELECT
    Machine_ID,
    ROUND(AVG(Down_Time_Hours), 2) AS avg_downtime,
    SUM(Units_Produced) AS total_units,
    SUM(Defects) AS total_defects,
    ROUND(SUM(Defects) / NULLIF(SUM(Units_Produced), 0), 4) AS defect_rate
FROM manufacture_duplicate
GROUP BY Machine_ID
ORDER BY avg_downtime DESC;

-- Machines with highest defect rate
SELECT
    Machine_ID,
    ROUND(AVG(Down_Time_Hours), 2) AS avg_downtime,
    SUM(Units_Produced) AS total_units,
    SUM(Defects) AS total_defects,
    ROUND(SUM(Defects) / NULLIF(SUM(Units_Produced), 0), 4) AS defect_rate
FROM manufacture_duplicate
GROUP BY Machine_ID
ORDER BY defect_rate DESC;

-- Top 3 highest-risk machine and shift combinations
SELECT
    Machine_ID,
    Shift,
    SUM(Units_Produced) AS total_units,
    SUM(Defects) AS total_defects,
    ROUND(SUM(Defects) / NULLIF(SUM(Units_Produced), 0), 4) AS defect_rate
FROM manufacture_duplicate
GROUP BY Machine_ID, Shift
ORDER BY defect_rate DESC
LIMIT 3;
