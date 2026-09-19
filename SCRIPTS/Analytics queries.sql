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
