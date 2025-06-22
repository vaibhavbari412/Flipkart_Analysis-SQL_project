--1.Retrieve a list of all customers with their corresponding product names they ordered (use an INNER JOIN between customers and sales tables).
SELECT c.customer_id,c.customer_name, p.product_name
FROM customers c
INNER JOIN
sales s
ON s.customer_id = c.customer_id
INNER JOIN
products p 
ON p.product_id = s.product_id
ORDER BY c.customer_id

--2.List all products and show the details of customers who have placed orders for them. Include products that have no orders (use a LEFT JOIN between products and sales tables).
SELECT 
	p.product_id,
	p.product_name,
	s.order_id
FROM products p 
LEFT JOIN sales s
ON s.product_id = p.product_id
ORDER BY 1

--3.List all orders and their shipping status. Include orders that do not have any shipping records (use a LEFT JOINbetween sales and shippings tables).
SELECT 
	s.order_id,
	s.product_id,
	sp.shipping_id,
	sp.delivery_status
FROM sales s 
LEFT JOIN shippings sp
ON sp.order_id = s.order_id
--WHERE sp.shipping_id IS NULL
ORDER BY 3

--4.Retrieve all products, including those with no orders, along with their price. Use a RIGHT JOIN between the products and sales tables.
SELECT *,
	p.product_id,
	p.product_name,
	p.price,
	s.order_id
FROM products p
RIGHT JOIN sales s
ON s.product_id = p.product_id

--5.Get a list of all customers who have placed orders, including those with no payment records. Use a FULL OUTER JOIN between the customers and payments tables.
SELECT
	*
FROM products p 
INNER JOIN sales s
ON s.product_id = p.product_id
FULL OUTER JOIN payments pm
ON pm.order_id = s.order_id



