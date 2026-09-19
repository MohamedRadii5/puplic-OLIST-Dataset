 -- EDA & Analytics
 --=========================================================
### KPIs








	
### ANALYSIS	
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


-- [3] Best Seller From Where and how much he sell 
SELECT TOP 15
	ROW_NUMBER() OVER(ORDER BY SUM(i.price) DESC) AS row_num,
	s.seller_id,
	s.seller_city AS city,
	SUM(i.price) AS sales_amount,
	COUNT(o.order_id) AS orders_count
FROM seller s
JOIN order_items i
	ON s.seller_id = i.seller_id
JOIN orders o
	ON i.order_id = o.order_id
GROUP BY s.seller_id, s.seller_city


-- [4] TOP 10 Customers Sales and order count and from where
SELECT TOP 10
	ROW_NUMBER() OVER(ORDER BY SUM(i.price) DESC) AS row_num,
	c.customer_id,
	SUM(i.price) AS sales_amount
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
JOIN order_items i
	ON o.order_id = i.order_id
GROUP BY c.customer_id


-- [5] Payments 
-- 1. poularity payment type
SELECT 
	s.payment_type,
	COUNT(payment_type) AS count,
	SUM(s.payment_value) AS money
FROM order_payments s
GROUP BY payment_type
ORDER BY COUNT(payment_type) DESC


-- 2. payment sequential deep 
SELECT 
	s.payment_sequential,
	COUNT(order_id) AS count
FROM order_payments s
GROUP BY payment_sequential
ORDER BY COUNT(order_id) DESC


-- 3. payment installments deep 
SELECT 
	s.payment_installments,
	COUNT(order_id) AS count
FROM order_payments s
GROUP BY payment_installments
HAVING payment_installments >= 1
ORDER BY payment_installments ASC



--[6] Score review for orders
SELECT 
	r.review_score AS score,
	COUNT(order_id) AS count
FROM order_reviews r
GROUP BY review_score
ORDER BY COUNT(order_id) DESC


--[7] Trend Analysis

-- 1. Year over Year
SELECT 
	YEAR(o.order_purchase_timestamp) AS Year,
	SUM(i.price) AS sales
FROM orders o 
JOIN order_items i
	ON o.order_id = i.order_id
GROUP BY YEAR(o.order_purchase_timestamp)
ORDER BY YEAR(o.order_purchase_timestamp) ASC;


-- 2. Month over Month
SELECT 
    CONCAT(MONTH(order_purchase_timestamp), '-', YEAR(order_purchase_timestamp)) AS Month_Year,
    SUM(i.price) AS sales
FROM orders o 
JOIN order_items i
    ON o.order_id = i.order_id
GROUP BY 
    YEAR(order_purchase_timestamp), 
    MONTH(order_purchase_timestamp)
ORDER BY 
    YEAR(order_purchase_timestamp) ASC, 
    MONTH(order_purchase_timestamp) ASC;
