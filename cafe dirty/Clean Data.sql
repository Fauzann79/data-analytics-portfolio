SELECT *
FROM cafe_dirty;

SELECT distinct payment_method, location
from cafe_dirty;

describe cafe_dirty;

ALTER TABLE cafe_dirty
CHANGE `Transaction id` transaction_id VARCHAR(50);

ALTER TABLE cafe_dirty
CHANGE `Transaction Date` transaction_date VARCHAR(50);

ALTER TABLE cafe_dirty
CHANGE `Payment Method` payment_method VARCHAR(50);

ALTER TABLE cafe_dirty
CHANGE `price` price int(50);

ALTER TABLE cafe_dirty
CHANGE `Total Spent` total int(10);


-- Cek Nul Value dan Duplikasi Pada Transaction_id
SELECT COUNT(*) AS null_txn
FROM cafe_dirty
WHERE transaction_id IS NULL
   OR transaction_id = '';
   
   
-- CEK DUPLIKASI   
SELECT transaction_id, COUNT(*) AS total
FROM cafe_dirty
GROUP BY transaction_id
HAVING COUNT(*) > 1;


-- CEK ITEM
SELECT
  COUNT(*) AS total,
  SUM(Item IS NULL OR Item = '') AS null_product,
  SUM(Item = 'UNKNOWN') AS unknown_product
FROM cafe_dirty;

SELECT DISTINCT Item, Price
FROM cafe_dirty;

SELECT distinct Item, Price
from cafe_dirty ;




-- cek item hilang dari harga
SELECT 
    Item,
    price,
    COUNT(*) AS jumlah
FROM cafe_dirty
WHERE Item IN ('', 'UNKNOWN', 'ERROR')
  AND price IN (1, 2, 3, 4)
GROUP BY Item, price
ORDER BY item, price;

SELECT 
    location,
    COUNT(*) AS jumlah
FROM cafe_dirty
WHERE location IN ('', 'UNKNOWN', 'ERROR')
GROUP BY location;





-- Replace Nilai Kosong
WITH cleaned AS (
  SELECT
    CASE
    
    -- COFFEE
      WHEN Item = 'UNKNOWN' AND Price = 2
        THEN 'Coffee'
	  WHEN Item = '' AND Price = 2
		THEN 'Coffee'
	 WHEN Item = 'ERROR' AND Price = 2
		THEN 'Coffee'
        
    -- CAKE    
	  WHEN Item = '' AND Price = 3
		THEN 'Cake'
	  WHEN Item = 'UNKNOWN' AND Price = 3
		THEN 'Cake'
	  WHEN Item = 'ERROR' AND Price = 3
		THEN 'Cake'
        
   -- SMOOTHIE AND SANDWICH     
	  WHEN Item = 'UNKNOWN' AND Price = 4
		THEN 'Smoothie'
	  WHEN Item = 'ERROR' AND Price = 4
		THEN 'Sandwich'
	  WHEN Item = '' AND Price = 4
		THEN 'Sandwich'
	
    -- COOKIE
	  WHEN Item = 'UNKNOWN' AND Price = 1
		THEN 'Cookie'
	  WHEN Item = 'ERROR' AND Price = 1
		THEN 'Cookie'
	  WHEN Item = '' AND Price = 1
		THEN 'Cookie'
     
     -- SALAD
	  WHEN Item = 'UNKNOWN' AND Price = 5
		THEN 'Salad'
	  WHEN Item = 'ERROR' AND Price = 5
		THEN 'Salad'
	  WHEN Item = '' AND Price = 5
		THEN 'Salad'
        
      ELSE Item
    END AS Item,
    Price,
    Quantity,
	Quantity * Price AS total_spent_clean,
    
    -- PAYMENT METODE
	CASE
      WHEN payment_method IS NULL
        OR payment_method = ''
        OR payment_method IN ('UNKNOWN', 'ERROR')
      THEN 'Unknown'
      ELSE payment_method
    END AS payment_method_clean,
    
  -- LOCATION  
    CASE
      WHEN location IS NULL
        OR location = ''
        OR location IN ('UNKNOWN', 'ERROR')
      THEN 'Unknown'
      ELSE location
    END AS location_clean,
    
    -- TRANSACTION DATE
	CASE 
      WHEN transaction_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
        THEN STR_TO_DATE(transaction_date, '%d-%m-%Y')
	WHEN transaction_date IS NULL
        OR transaction_date = ''
        OR transaction_date IN ('UNKNOWN', 'ERROR')
	THEN 'Unknown'
	else transaction_date
	END AS Clean_date
    FROM cafe_dirty)
SELECT *
FROM cleaned











