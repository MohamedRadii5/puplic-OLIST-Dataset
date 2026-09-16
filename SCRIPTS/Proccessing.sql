 -- EDA & Proccessing
 --=========================================================
        /* (1) product_category_name_translation Table */
Select * from product_category_name_translation;
-- Purpose: Add 'product_id' column to translation table and populate it 

-- 1. Add the new product_id column to the translation table
ALTER TABLE product_category_name_translation
ADD product_id VARCHAR(255); -- (Adjust data type to INT or VARCHAR based on your schema)

-- 2. Update and populate product_id using INNER JOIN on category name
UPDATE t
SET t.product_id = p.product_id
FROM product_category_name_translation t
INNER JOIN products p 
ON t.product_category_name = p.product_category_name;





