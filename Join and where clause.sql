/*	Find the total number of completed orders made by customers from the state 'Delhi' 
(use INNER JOIN between customers and sales and apply a WHERE condition). */
SELECT
	COUNT(s.order_id)
FROM 
sales s 
INNER JOIN 
customers c 
ON c.customer_id = s.customer_id
WHERE s.order_status ='Completed'
AND c.state ='Delhi'

/*●	Retrieve a list of products ordered by customers from the state 'Karnataka' with price greater than 10,000 
(use INNER JOIN between sales, customers, and products).*/
SELECT
	c.customer_name,
	p.product_name,
	s.order_id
FROM customers c
INNER JOIN
sales s 
ON s.customer_id=c.customer_id
INNER JOIN
products p 
ON p.product_id=s.product_id
WHERE
c.state='Karnataka' 
AND 
p.price >10000

/*●	List all customers who have placed orders where the product category is 'Accessories' and the order status is 'Completed' 
(use INNER JOIN with sales, customers, and products).*/
SELECT
	c.customer_name,
	p.product_name,
	s.order_id
FROM customers c
INNER JOIN
sales s 
ON s.customer_id=c.customer_id
INNER JOIN
products p 
ON p.product_id=s.product_id
WHERE p.category ='Accessories'
AND s.order_status = 'Completed'



/*●	Show the order details of customers who have paid for their orders, excluding those who have cancelled their orders 
(use INNER JOIN between sales and payments and apply WHERE for order_status).*/
SELECT
	s.customer_id,
	s.order_status,
	pm.payment_status
FROM sales s 
INNER JOIN 
payments pm 
ON pm.order_id = s.order_id
WHERE s.order_status != 'Cancelled'


/* ●	Retrieve products ordered by customers who are in the 'Gujarat' state and whose total order price is greater than 15,000 
(use INNER JOIN between sales, customers, and products).*/

SELECT
	c.customer_name,
	p.product_name,
	s.order_id,
	(s.quantity * s.price_per_unit) as total_order_price
FROM customers c
INNER JOIN
sales s 
ON s.customer_id=c.customer_id
INNER JOIN
products p 
ON p.product_id=s.product_id
WHERE c.state='Gujarat'
AND (s.quantity * s.price_per_unit) >15000;
