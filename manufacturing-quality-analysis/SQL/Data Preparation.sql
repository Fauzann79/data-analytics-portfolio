
-- DATA PREPARATION
-- ====================

-- Preview raw data
SELECT * FROM Manufacture;

DESCRIBE Manufacture;

-- Create duplicate table
CREATE TABLE manufacture_duplicate AS
SELECT * FROM Manufacture;
