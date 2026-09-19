 -- EDA & Analytics
 --=========================================================

-- [1] Top Cities Sales. 
SELECT
	ROW_NUMBER() OVER(ORDER BY SUM(price) DESC) AS row_num,
	g.geolocation_city AS city,
	SUM(price) AS sales
FROM geolocation g
JOIN customers c
	ON g.geolocation_zip_code_prefix = c.customer_zip_code_prefix
JOIN orders	 o
	ON c.customer_id = o.customer_id
JOIN order_items i
	ON o.order_id = i.order_id
GROUP BY geolocation_city;   
----------------------------------------------------------------------

-- [2] Top Products Sales.

-- 1. In brazilian language
SELECT 
	ROW_NUMBER() OVER(ORDER BY COUNT(o.order_id) DESC) AS row_num,
	p.product_category_name AS product_category,
	COUNT(o.order_id) AS sales_count
FROM products p
JOIN order_items i
	ON p.product_id = i.product_id
JOIN orders o
	ON i.order_id = o.order_id
GROUP BY product_category_name;

-- 2. In English language
SELECT 
	ROW_NUMBER() OVER(ORDER BY COUNT(o.order_id) DESC) AS row_num,
	t.product_category_name_english AS product_category,
	COUNT(o.order_id) AS sales_count
FROM product_category_name_translation t
JOIN products p
	ON t.product_category_name = p.product_category_name
JOIN order_items i
	ON p.product_id = i.product_id
JOIN orders o
	ON i.order_id = o.order_id
GROUP BY product_category_name_english;
----------------------------------------------------------------------
