
-- preparation
SELECT * FROM Manufacture;

DESCRIBE Manufacture;

CREATE TABLE Manufacture_duplicate AS
SELECT * FROM Manufacture;

UPDATE manufacture_duplicate
SET Date = STR_TO_DATE(Date, '%d/%m/%Y');

SELECT * FROM manufacture_duplicate;

ALTER TABLE manufacture_duplicate
MODIFY Date DATE;

UPDATE manufacture_duplicate
SET Defects = 0
WHERE Defects = '' OR Defects IS NULL;

ALTER TABLE manufacture_duplicate
MODIFY Defects INT;


SELECT
  COUNT(*) AS total_rows,
  SUM(Defects IS NULL) AS defects_null,
  SUM(Production_Time_Hours IS NULL) AS prod_time_null,
  SUM(Maintenance_Hours IS NULL) AS maintenance_null,
  SUM(Down_time_Hours IS NULL) AS downtime_null,
  SUM(Rework_Hours IS NULL) AS rework_null
FROM manufacture_duplicate;






-- EXPLORATION DATA


-- OVERALL PERFORMANCE
SELECT
	SUM(Units_Produced) AS Total_Unit,
    SUM(Defects) AS Total_Defects,
    ROUND(SUM(Defects) / SUM(Units_Produced),4) AS Rate_Defects,
    ROUND(AVG(Down_Time_Hours),2) AS avg_downtime,
    ROUND(AVG(Scrap_Rate), 3) AS avg_scrap
FROM manufacture_duplicate;



-- DEFECT RATE PER PRODUCT TYPE
SELECT 
	Product_type,
    SUM(Units_Produced) AS Total_Unit,
    SUM(Defects) AS Total_Defects,
    ROUND(SUM(Defects) / SUM(Units_Produced),4) AS Rate_Defects
FROM manufacture_duplicate
GROUP BY Product_type
ORDER BY Rate_Defects desc;
 
 
 
 -- Analisis untuk mengetahui shift mana yang paling bermasalah
 SELECT 
	Shift,
    SUM(Units_Produced) AS Total_Unit,
    SUM(Defects) AS Total_Defects,
    ROUND(SUM(Defects) / SUM(Units_Produced),4) AS Rate_Defects,
    ROUND(
        (SUM(Defects) / NULLIF(SUM(Units_Produced), 0)) * 100,
        2
    ) AS defect_rate_percent
FROM manufacture_duplicate
GROUP BY Shift
ORDER BY Rate_Defects desc;
 




 

-- DEFECT RATE PER SHIFT DAN PRODUCT TYPE
SELECT 
	Shift,
	Product_type,
    SUM(Units_Produced) AS Total_Unit,
    SUM(Defects) AS Total_Defects,
    ROUND(SUM(Defects) / SUM(Units_Produced),4) AS Rate_Defects,
    ROUND(
        (SUM(Defects) / NULLIF(SUM(Units_Produced), 0)) * 100,
        2
    ) AS defect_rate_percent
FROM manufacture_duplicate
GROUP BY Shift, Product_Type
ORDER BY Shift, Rate_Defects desc;



-- DEFECT RATE PER SHIFT UNTUK PRODUCT TYPE: TEXTILES
SELECT 
	Shift,
	Product_type,
    SUM(Units_Produced) AS Total_Unit,
    SUM(Defects) AS Total_Defects,
    ROUND(SUM(Defects) / SUM(Units_Produced),4) AS Rate_Defects,
    ROUND(
        (SUM(Defects) / NULLIF(SUM(Units_Produced), 0)) * 100,
        2
    ) AS defect_rate_percent
FROM manufacture_duplicate
WHERE Product_Type = 'Textiles'
GROUP BY Shift, Product_Type
ORDER BY Rate_Defects desc;



-- DEFECT RATE PER SHIFT UNTUK PRODUCT TYPE: TEXTILES
SELECT 
	Shift,
	Product_type,
    SUM(Units_Produced) AS Total_Unit,
    SUM(Defects) AS Total_Defects,
    ROUND(SUM(Defects) / SUM(Units_Produced),4) AS Rate_Defects,
    ROUND(
        (SUM(Defects) / NULLIF(SUM(Units_Produced), 0)) * 100,
        2
    ) AS defect_rate_percent
FROM manufacture_duplicate
WHERE Product_Type = 'Automotive'
GROUP BY Shift, Product_Type
ORDER BY Rate_Defects desc;



-- DEFECT RATE PER SHIFT UNTUK PRODUCT TYPE: TEXTILES
SELECT 
	Shift,
	Product_type,
    SUM(Units_Produced) AS Total_Unit,
    SUM(Defects) AS Total_Defects,
    ROUND(SUM(Defects) / SUM(Units_Produced),4) AS Rate_Defects,
    ROUND(
        (SUM(Defects) / NULLIF(SUM(Units_Produced), 0)) * 100,
        2
    ) AS defect_rate_percent
FROM manufacture_duplicate
WHERE Product_Type = 'Electronics'
GROUP BY Shift, Product_Type
ORDER BY Rate_Defects desc;



-- DEFECT RATE PER SHIFT UNTUK PRODUCT TYPE: TEXTILES
SELECT 
	Shift,
	Product_type,
    SUM(Units_Produced) AS Total_Unit,
    SUM(Defects) AS Total_Defects,
    ROUND(SUM(Defects) / SUM(Units_Produced),4) AS Rate_Defects,
    ROUND(
        (SUM(Defects) / NULLIF(SUM(Units_Produced), 0)) * 100,
        2
    ) AS defect_rate_percent
FROM manufacture_duplicate
WHERE Product_Type = 'Furniture'
GROUP BY Shift, Product_Type
ORDER BY Rate_Defects desc;



-- DEFECT RATE PER SHIFT UNTUK PRODUCT TYPE: TEXTILES
SELECT 
	Shift,
	Product_type,
    SUM(Units_Produced) AS Total_Unit,
    SUM(Defects) AS Total_Defects,
    ROUND(SUM(Defects) / SUM(Units_Produced),4) AS Rate_Defects,
    ROUND(
        (SUM(Defects) / NULLIF(SUM(Units_Produced), 0)) * 100,
        2
    ) AS defect_rate_percent
FROM manufacture_duplicate
WHERE Product_Type = 'Appliances'
GROUP BY Shift, Product_Type
ORDER BY Shift, Rate_Defects desc;



SELECT 
	Machine_ID, 
	SUM(Units_Produced) AS Total_Unit,
    SUM(Defects) AS total_defects,
	ROUND(SUM(Defects) / SUM(Units_Produced),4) AS Rate_Defects,
		ROUND(
        (SUM(Defects) / NULLIF(SUM(Units_Produced), 0)) * 100,
        2
    ) AS defect_rate_percent
FROM manufacture_duplicate
group by Machine_ID
ORDER BY total_defects DESC;


-- Melihat performa mesin pada setiap shift
SELECT
    Machine_ID,
    Shift,
    SUM(Units_Produced) AS Total_Unit,
    SUM(Defects) AS Total_Defects,
    ROUND(
        SUM(Defects) / NULLIF(SUM(Units_Produced), 0),
        4
    ) AS Rate_Defects,
    ROUND(
        (SUM(Defects) / NULLIF(SUM(Units_Produced), 0)) * 100,
        2
    ) AS defect_rate_percent
FROM manufacture_duplicate
GROUP BY Machine_ID, Shift
ORDER BY Machine_ID, Rate_Defects DESC;


-- Analisis hubungan downtime dan defect
-- Mengukur apakah downtime tinggi diikuti defect rate tinggi

SELECT
    Machine_ID,
    ROUND(AVG(Down_Time_Hours), 2) AS avg_downtime,
    SUM(Units_Produced) AS Total_Unit,
    SUM(Defects) AS Total_Defects,
    ROUND(
        SUM(Defects) / NULLIF(SUM(Units_Produced), 0),
        4
    ) AS defect_rate
FROM manufacture_duplicate
GROUP BY Machine_ID
ORDER BY avg_downtime DESC;

SELECT
    Machine_ID,
    ROUND(AVG(Down_Time_Hours), 2) AS avg_downtime,
    SUM(Units_Produced) AS Total_Unit,
    SUM(Defects) AS Total_Defects,
    ROUND(
        SUM(Defects) / NULLIF(SUM(Units_Produced), 0),
        4
    ) AS defect_rate
FROM manufacture_duplicate
GROUP BY Machine_ID
ORDER BY defect_rate DESC;

