--1.	Retrieve all products along with their total sales revenue from completed orders.
SELECT
	p.product_name,
	SUM(s.quantity * s.price_per_unit) AS total_sales
FROM
sales s
INNER JOIN
products p 
ON p.product_id = s.product_id
WHERE s.order_status='Completed'
GROUP BY 1;

--2.	List all customers and the products they have purchased, showing only those who have ordered more than two products.
SELECT
	c.customer_name,
	COUNT(p.product_id) AS product_purchased
FROM
customers c 
INNER JOIN 
sales s
ON s.customer_id = c.customer_id
INNER JOIN
products p
ON p.product_id = s.product_id
GROUP BY 1
HAVING COUNT(p.product_id) >2

--3.	Find the total amount spent by customers in 'Gujarat' who have ordered products priced greater than 10,000
SELECT
	c.customer_name,
	SUM(s.price_per_unit * s.quantity) as total_amount_spent
FROM
customers c 
INNER JOIN 
sales s
ON s.customer_id = c.customer_id
INNER JOIN
products p
ON p.product_id = s.product_id
WHERE c.state='Gujarat'
GROUP BY 1
HAVING SUM(s.price_per_unit * s.quantity) >10000;

--4.	Retrieve the list of all orders that have not yet been shipped.
SELECT
	s.order_id,
	s.order_status
FROM
sales s 
LEFT JOIN
shippings sp
ON sp.order_id = s.order_id
WHERE sp.order_id IS NULL

--5.	Find the average order value per customer for orders with a quantity of more than 5.
SELECT
	c.customer_name,
	AVG(s.price_per_unit * s.quantity) AS avg_order_price
FROM
customers c 
INNER JOIN 
sales s
ON s.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING COUNT(s.order_id)>5


--6.	Get the top 5 customers by total spending on 'Accessories'.
SELECT 
	c.customer_name,
	SUM(s.price_per_unit * s.quantity) AS total_spending
FROM
customers c 
INNER JOIN 
sales s
ON s.customer_id = c.customer_id
INNER JOIN
products p
ON p.product_id = s.product_id
WHERE p.category='Accessories'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--7.	Retrieve a list of customers who have not made any payment for their orders
SELECT
	c.customer_name,
	s.order_id
FROM
customers c 
INNER JOIN 
sales s
ON s.customer_id = c.customer_id
LEFT JOIN
payments pm
ON pm.order_id = s.order_id
WHERE pm.order_id IS NULL;

--8.	Find the most popular product based on total quantity sold in 2023.
SELECT 
	p.product_name,
	COUNT(s.quantity) AS total_quantity
FROM 
sales s 
INNER JOIN
products p
ON p.product_id = s.product_id
WHERE EXTRACT(YEAR FROM s.order_date)=2023
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--9.	List all orders that were cancelled and the reason for cancellation (if available).
SELECT
	p.product_name,
	s.order_id,
	s.order_status
FROM 
sales s 
INNER JOIN
products p
ON p.product_id = s.product_id
WHERE s.order_status='Cancelled'

--10.	Retrieve the total quantity of products sold by category in 2023.
SELECT
	p.category,
	SUM(s.quantity) AS total_quantity_sold
FROM 
sales s 
INNER JOIN
products p
ON p.product_id = s.product_id
WHERE EXTRACT(YEAR FROM s.order_date)=2023
GROUP BY 1;

--11.	Get the count of returned orders by shipping provider in 2023.
SELECT
	SP.shipping_providers,
	COUNT(SP.order_id) AS total_order_returned
FROM
shippings sp
INNER JOIN
sales s
ON s.order_id = sp.order_id
WHERE EXTRACT(YEAR FROM s.order_date)=2023
GROUP BY 1;

--12.	Show the total revenue generated per month for the year 2023.
SELECT
	TO_CHAR(order_date,'FMMonth'),
	SUM(quantity * price_per_unit) AS total_revenue
FROM 
sales
WHERE EXTRACT(YEAR FROM order_date)=2023
GROUP BY EXTRACT (MONTH FROM order_date),1
ORDER BY EXTRACT (MONTH FROM order_date)

--13.	Find the customers who have made the most purchases in a single month.
SELECT
	c.customer_name,
	EXTRACT (MONTH FROM s.order_date) AS order_month,
	EXTRACT (YEAR FROM s.order_date) AS order_year,
	COUNT(s.order_id) AS total_orders
FROM
customers c
INNER JOIN
sales s
ON s.customer_id = c.customer_id
GROUP BY 1,2,3
ORDER BY 4 DESC;

--14.	Retrieve the number of orders made per product category in 2023 and order by total quantity sold.
SELECT
	p.category,
	COUNT(s.order_id)
FROM
sales s
INNER JOIN
products p
ON p.product_id = s.product_id
WHERE EXTRACT(YEAR FROM order_date)=2023
GROUP BY p.category
ORDER BY SUM(s.quantity) DESC

--15.	List the products that have never been ordered (use LEFT JOIN between products and sales).
SELECT
	p.product_name
FROM
products p
LEFT JOIN
sales s
ON s.product_id = p.product_id
WHERE s.product_id IS NULL









