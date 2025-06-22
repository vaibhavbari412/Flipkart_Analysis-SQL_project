/*●	Retrieve the total sales per customer in 'Delhi' where the order status is 'Completed', only include those with total sales greater than 50,000, 
and order the results by total sales 
(use INNER JOIN between sales and customers).*/

SELECT
	c.customer_name,
	SUM(s.quantity*s.price_per_unit)
FROM
sales s
INNER JOIN
customers c 
ON c.customer_id = s.customer_id
WHERE c.state='Delhi'
AND s.order_status='Completed'
GROUP BY 1
HAVING SUM(s.quantity*s.price_per_unit)>50000
ORDER BY 2

/*●	Show the total quantity sold per product in the 'Accessories' category where the total quantity sold is greater than 50 and
order the results by product name (use INNER JOIN between sales and products).*/
SELECT
	p.product_name,
	COUNT(s.quantity) AS total_quantity
FROM
sales s
INNER JOIN
products p
ON p.product_id = s.product_id 
WHERE p.category ='Accessories'
GROUP BY 1
HAVING COUNT(s.quantity)>50
ORDER BY 1;

/* ●	Find the total number of orders for customers from 'Maharashtra' who have spent more than 1,00,000,
and order the results by the total amount spent (use INNER JOIN between sales and customers).*/
SELECT
	c.customer_name,
	COUNT(s.order_id) AS total_orders,
	SUM(s.quantity * s.price_per_unit) AS total_amount_spent
FROM
sales s
INNER JOIN
customers c 
ON c.customer_id = s.customer_id
WHERE
c.state='Maharashtra'
GROUP BY 1
HAVING SUM(s.quantity * s.price_per_unit)>100000
ORDER BY 3;

/* ●	Get the number of orders per product and filter to include only products that have been ordered more than 10 times,
then order the results by the highest number of orders (use INNER JOIN between sales and products).*/
SELECT
	p.product_name,
	COUNT(s.order_id) AS total_order
FROM
sales s
INNER JOIN
products p
ON p.product_id = s.product_id 
GROUP BY 1
HAVING COUNT(s.order_id) >10
ORDER BY 2 DESC;

/* ●	Retrieve the number of payments made per customer where the payment status is 'Payment Successed' and group by customer,
ordering by payment count (use INNER JOIN between payments and customers).*/
SELECT
	c.customer_name,
	COUNT(pm.payment_id) as payment_count
FROM
customers c
INNER JOIN
sales s
ON s.customer_id = c.customer_id
INNER JOIN
payments pm
ON pm.order_id = s.order_id
WHERE pm.payment_status='Payment Successed'
GROUP BY 1
ORDER BY 2 DESC;