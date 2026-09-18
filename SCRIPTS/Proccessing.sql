 -- EDA & Proccessing
 --=========================================================
                  /* (1) product_category_name_translation Table */
Select * from product_category_name_translation;
-- Purpose: Add 'product_id' column to translation table and populate it 
-- 1. Add the new product_id column to the translation table
ALTER TABLE product_category_name_translation
ADD product_id VARCHAR(255); -- (Adjust data type to INT or VARCHAR based on your schema)
GO

-- 2. Update and populate product_id using INNER JOIN on category name
UPDATE t
SET t.product_id = p.product_id
FROM product_category_name_translation t
INNER JOIN products p 
    ON t.product_category_name = p.product_category_name;
GO

-- 1. Check for null values
Select * from dbo.product_category_name_translation
WHERE product_id is null            -- No Null Values in product category name translation Table

-- 2. Check for Duplicates 
SELECT product_id,
COUNT(*) AS Duplictes
FROM dbo.product_category_name_translation
Group by product_id
HAVING COUNT(*) > 1               -- No Duplicate Values in product category name translation Table

--------------------------------------------------------------------------------
                  /* (2) customers Table */
-- 1. Check for null values
SELECT * FROM customers
WHERE  customer_id is null
OR customer_city is null
OR customer_state is null    -- No Null values in customers Table

-- 2. Check for Duplicates
SELECT 
customer_id, 
COUNT(*) AS Duplicates
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1    -- No Duplicates in customers Table
 
-------------------------------------------------------------------------------------
                  /* (3) geolocation Table */
-- 1. Check for null values
SELECT * FROM geolocation
WHERE  geolocation_zip_code_prefix is null
OR geolocation_zip_code_prefix is null
OR geolocation_zip_code_prefix is null   -- No Null values in geolocation Table

-- 2. Check for Duplicates                
SELECT  Distinct geolocation_state,
geolocation_zip_code_prefix, 
COUNT(*) AS Duplicates
FROM geolocation
GROUP BY geolocation_zip_code_prefix,  geolocation_state
HAVING COUNT(*) > 1 

-- Show what we have 
Select Distinct geolocation_city, geolocation_state
FROM geolocation;

Select Distinct geolocation_zip_code_prefix, geolocation_city
FROM geolocation;

-- Handling Duplicates in geolocation_city
With LOC_CTE AS (
SELECT *
, ROW_NUMBER() OVER (Partition by geolocation_state order by (Select Null)) AS Duplicates
FROM geolocation
)
DELETE FROM LOC_CTE 
WHERE Duplicates > 1          -- Now it's fixed temporary (But there is duplicates in sao paulo only)

-- Fix sao paulo rows
Update geolocation
SET geolocation_city = 'SP'
WHERE geolocation_state = 'são paulo'
Update geolocation
SET geolocation_city = 'SP'
WHERE geolocation_state = 'sao paulo'
Update geolocation
SET geolocation_city = 'sao paulo'
WHERE geolocation_state = 'SP'

-- Fix cidade rows
Update geolocation
SET geolocation_city = 'cidade'
WHERE geolocation_city = '* cidade'

--                              <-> that's was difficult table but i smashed it very hard [Hahahahahaha] <-> 


