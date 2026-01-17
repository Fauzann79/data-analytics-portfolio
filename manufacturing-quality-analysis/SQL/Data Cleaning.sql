
-- DATA CLEANING
-- ================================

-- Convert Date column to DATE format
UPDATE manufacture_duplicate
SET Date = STR_TO_DATE(Date, '%d/%m/%Y');

ALTER TABLE manufacture_duplicate
MODIFY Date DATE;

-- Handle missing or invalid defect values
UPDATE manufacture_duplicate
SET Defects = 0
WHERE Defects = '' OR Defects IS NULL;

ALTER TABLE manufacture_duplicate
MODIFY Defects INT;

-- Check missing values across important columns
SELECT
    COUNT(*) AS total_rows,
    SUM(Defects IS NULL) AS defects_null,
    SUM(Production_Time_Hours IS NULL) AS prod_time_null,
    SUM(Maintenance_Hours IS NULL) AS maintenance_null,
    SUM(Down_Time_Hours IS NULL) AS downtime_null,
    SUM(Rework_Hours IS NULL) AS rework_null
FROM manufacture_duplicate;
