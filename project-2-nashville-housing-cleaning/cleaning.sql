/*
=====================================================================
 NASHVILLE HOUSING - DATA CLEANING IN SQL  |  SQL Portfolio Project #2
=====================================================================
 Skills demonstrated: Date conversion, self-joins for NULL backfill,
 address parsing (SUBSTR/INSTR), CASE statements, ROW_NUMBER
 deduplication, column management

 Database   : SQLite (self-contained, runs anywhere)
 Data source: Nashville Housing dataset (AlexTheAnalyst/PortfolioProjects)
 Reproduce  : python build_nashville_db.py then python run_cleaning.py
=====================================================================
*/

-----------------------------------------------------------------------
-- 0. INSPECT - what are we working with?
-----------------------------------------------------------------------
SELECT * FROM NashvilleHousing;

-----------------------------------------------------------------------
-- 1. STANDARDIZE THE SALE DATE FORMAT
-----------------------------------------------------------------------
-- Preview the conversion
SELECT sale_date, DATE(sale_date) AS sale_date_converted
FROM NashvilleHousing;

-- Persist a clean date column
ALTER TABLE NashvilleHousing ADD COLUMN sale_date_converted TEXT;
UPDATE NashvilleHousing SET sale_date_converted = DATE(sale_date);

-----------------------------------------------------------------------
-- 2. POPULATE MISSING PROPERTY ADDRESSES
--    Properties with the same ParcelID share the same address,
--    so we backfill NULLs using a self-join.
-----------------------------------------------------------------------
-- (a) How many are missing?
SELECT COUNT(*) AS missing_addresses
FROM NashvilleHousing
WHERE property_address IS NULL;

-- (b) Inspect the pattern: same ParcelID -> same address
SELECT a.parcel_id, a.property_address, b.property_address
FROM NashvilleHousing a
JOIN NashvilleHousing b
  ON a.parcel_id = b.parcel_id
 AND a.unique_id <> b.unique_id
WHERE a.property_address IS NULL
LIMIT 10;

-- (c) Backfill
UPDATE NashvilleHousing AS a
SET property_address = (
  SELECT b.property_address
  FROM NashvilleHousing b
  WHERE b.parcel_id = a.parcel_id
    AND b.unique_id <> a.unique_id
    AND b.property_address IS NOT NULL
  LIMIT 1
)
WHERE a.property_address IS NULL;

-- (d) Confirm zero NULLs remain
SELECT COUNT(*) AS missing_addresses
FROM NashvilleHousing
WHERE property_address IS NULL;

-----------------------------------------------------------------------
-- 3. BREAK PROPERTY ADDRESS INTO (Address, City)
-----------------------------------------------------------------------
ALTER TABLE NashvilleHousing ADD COLUMN property_split_address TEXT;
ALTER TABLE NashvilleHousing ADD COLUMN property_split_city TEXT;

UPDATE NashvilleHousing
SET property_split_address = TRIM(SUBSTR(property_address, 1, INSTR(property_address, ',') - 1)),
    property_split_city    = TRIM(SUBSTR(property_address, INSTR(property_address, ',') + 1));

-----------------------------------------------------------------------
-- 4. BREAK OWNER ADDRESS INTO (Address, City, State)
-----------------------------------------------------------------------
ALTER TABLE NashvilleHousing ADD COLUMN owner_split_address TEXT;
ALTER TABLE NashvilleHousing ADD COLUMN owner_split_city TEXT;
ALTER TABLE NashvilleHousing ADD COLUMN owner_split_state TEXT;

UPDATE NashvilleHousing
SET owner_split_address = TRIM(SUBSTR(owner_address, 1, INSTR(owner_address, ',') - 1)),
    owner_split_city    = TRIM(
                              SUBSTR(SUBSTR(owner_address, INSTR(owner_address, ',') + 1),
                                     1,
                                     INSTR(SUBSTR(owner_address, INSTR(owner_address, ',') + 1), ',') - 1)
                          ),
    owner_split_state   = TRIM(
                              SUBSTR(owner_address,
                                     INSTR(SUBSTR(owner_address, INSTR(owner_address, ',') + 1), ',')
                                       + INSTR(owner_address, ',') + 1)
                          );

-----------------------------------------------------------------------
-- 5. CHANGE 'Y'/'N' TO 'Yes'/'No' IN "SOLD AS VACANT"
-----------------------------------------------------------------------
-- (a) current distribution
SELECT sold_as_vacant, COUNT(*) AS cnt
FROM NashvilleHousing
GROUP BY sold_as_vacant;

-- (b) apply the fix
UPDATE NashvilleHousing
SET sold_as_vacant = CASE
    WHEN sold_as_vacant = 'Y' THEN 'Yes'
    WHEN sold_as_vacant = 'N' THEN 'No'
    ELSE sold_as_vacant
END;

-- (c) confirm clean values
SELECT sold_as_vacant, COUNT(*) AS cnt
FROM NashvilleHousing
GROUP BY sold_as_vacant;

-----------------------------------------------------------------------
-- 6. REMOVE DUPLICATE RECORDS (same parcel, address, price, date, ref)
-----------------------------------------------------------------------
-- (a) count duplicates
WITH row_num_cte AS (
  SELECT unique_id,
         ROW_NUMBER() OVER (
           PARTITION BY parcel_id, property_address, sale_price, sale_date, legal_reference
           ORDER BY unique_id
         ) AS row_num
  FROM NashvilleHousing
)
SELECT COUNT(*) AS duplicate_rows
FROM row_num_cte
WHERE row_num > 1;

-- (b) delete them, keep the first row_number
DELETE FROM NashvilleHousing
WHERE unique_id IN (
  SELECT unique_id
  FROM (
    SELECT unique_id,
           ROW_NUMBER() OVER (
             PARTITION BY parcel_id, property_address, sale_price, sale_date, legal_reference
             ORDER BY unique_id
           ) AS row_num
    FROM NashvilleHousing
  )
  WHERE row_num > 1
);

-----------------------------------------------------------------------
-- 7. DELETE UNUSED COLUMNS
-----------------------------------------------------------------------
ALTER TABLE NashvilleHousing DROP COLUMN owner_address;
ALTER TABLE NashvilleHousing DROP COLUMN tax_district;
ALTER TABLE NashvilleHousing DROP COLUMN property_address;
ALTER TABLE NashvilleHousing DROP COLUMN sale_date;

-----------------------------------------------------------------------
-- 8. FINAL CLEAN OUTPUT
-----------------------------------------------------------------------
SELECT * FROM NashvilleHousing;