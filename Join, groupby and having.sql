/* ●	Find the total quantity of each product ordered by customers from 'Delhi' and only include products with a quantity greater than 5 
(use INNER JOIN with sales, customers, and products and group by product).*/
SELECT
	COUNT(c.customer_name),
	p.product_id
FROM customers c 
INNER JOIN 
sales s 
ON s.customer_id = c.customer_id 
INNER JOIN 
products p
ON p.product_id = s.product_id
WHERE c.state='Delhi'
GROUP BY 2
HAVING COUNT(c.customer_name) >5

/*●	Get the average payment amount per customer who has placed more than 3 orders 
(use INNER JOIN between paymentsand sales, group by customer, and apply a HAVING clause). */
SELECT
	c.customer_name,
	COUNT(s.order_id) as total_order,
	AVG(s.quantity * s.price_per_unit) as avg_payment_value
FROM customers c 
INNER JOIN 
sales s 
ON s.customer_id = c.customer_id
INNER JOIN 
payments pm
ON pm.order_id = s.order_id
GROUP BY c.customer_name
HAVING COUNT(s.order_id)>3

/* ●	Retrieve the total sales for each product category and only include categories where the total sales exceed 100,000 
(use INNER JOIN between sales and products, group by category).*/

SELECT
	SUM(s.quantity*s.price_per_unit) as total_sales,
	p.category
FROM
sales s 
INNER JOIN 
products p 
ON p.product_id = s.product_id
GROUP BY p.category
HAVING SUM(s.quantity*s.price_per_unit) >1000000;

/* ●	Show the number of customers in each state who have made purchases with a total spend greater than 50,000 
(use INNER JOIN between sales and customers).*/
SELECT
	c.state,
	COUNT(c.customer_id)
FROM
customers c
INNER JOIN 
sales s 
ON s.customer_id = c.customer_id
GROUP BY 1
HAVING SUM(s.quantity * s.price_per_unit)>50000;

/*●	List the total sales by brand for products that have been ordered more than 10 times 
(use INNER JOIN between salesand products, group by brand).*/
SELECT
	p.brand,
	SUM(s.quantity * s.price_per_unit)
FROM
sales s
INNER JOIN
products p
ON p.product_id = s.product_id
GROUP BY 1
HAVING COUNT(s.order_id)>10;

