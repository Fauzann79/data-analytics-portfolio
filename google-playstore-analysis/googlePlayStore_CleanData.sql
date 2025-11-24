-- 1. Cek data awal
SELECT *
FROM googleplaystore
LIMIT 20;

-- 2. Cleaning kolom Installs
UPDATE googleplaystore
SET Installs = REPLACE(REPLACE(Installs, '+', ''), ',', '');
ALTER TABLE googleplaystore MODIFY Installs INT;

-- 3. Cleaning kolom Size
UPDATE googleplaystore
SET Size = NULL
WHERE Size = 'Varies with device' OR Size = '';

UPDATE googleplaystore
SET Size = REPLACE(Size, 'M', '')
WHERE Size LIKE '%M';

UPDATE googleplaystore
SET Size = REPLACE(Size, 'k', '') / 1024
WHERE Size LIKE '%k';

ALTER TABLE googleplaystore MODIFY Size FLOAT;

-- 4. Cleaning kolom Reviews
UPDATE googleplaystore
SET Reviews = NULL
WHERE Reviews = '';
ALTER TABLE googleplaystore MODIFY Reviews INT;

-- 5. Cleaning kolom Rating
UPDATE googleplaystore
SET Rating = NULL
WHERE Rating = '';
DELETE FROM googleplaystore WHERE Rating > 5;
ALTER TABLE googleplaystore MODIFY Rating FLOAT;

-- 6. Cleaning kolom Last Updated
UPDATE googleplaystore
SET `Last Updated` = STR_TO_DATE(`Last Updated`, '%M %d, %Y');
ALTER TABLE googleplaystore MODIFY `Last Updated` DATE;

-- 7. Cleaning kolom Android Ver
UPDATE googleplaystore
SET `Android Ver` = SUBSTRING_INDEX(`Android Ver`, 'and up', 1)
WHERE `Android Ver` LIKE '%and up%';

UPDATE googleplaystore
SET `Android Ver` = NULL
WHERE `Android Ver` IN ('NaN', '');

-- 8. Cleaning kolom Price
UPDATE googleplaystore
SET Price = REPLACE(Price, '$', '');
ALTER TABLE googleplaystore MODIFY Price FLOAT;

-- 9. Cleaning kolom Type
UPDATE googleplaystore
SET Type = 'Free'
WHERE Type = '' OR Type IS NULL;

-- 10. Cleaning kolom Genres
UPDATE googleplaystore
SET Genres = SUBSTRING_INDEX(Genres, ';', 1);

-- 11. Cleaning kolom Current Ver
UPDATE googleplaystore
SET `Current Ver` = NULL
WHERE `Current Ver` LIKE '%Varies%' OR `Current Ver` = '';

UPDATE googleplaystore
SET `Current Ver` = SUBSTRING_INDEX(`Current Ver`, '.', 3)
WHERE `Current Ver` REGEXP '^[0-9]+(\.[0-9]+)*$';

UPDATE googleplaystore
SET `Current Ver` = NULL
WHERE `Current Ver` NOT REGEXP '^[0-9]+(\.[0-9]+){0,2}$';

-- 12. Hapus duplikat
DELETE t1 FROM googleplaystore t1
JOIN googleplaystore t2
  ON t1.App = t2.App
 AND t1.Category = t2.Category
 AND t1.rowid > t2.rowid;

-- 13. Cek hasil akhir
SELECT *
FROM googleplaystore
LIMIT 50;

SELECT *
FROM googleplaystore;
