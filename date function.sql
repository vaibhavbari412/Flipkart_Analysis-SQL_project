/*●	List all orders that were placed within the year 2023 (use order_date with the EXTRACT function).*/
SELECT 
	*
FROM sales
WHERE EXTRACT(YEAR FROM order_date)=2023;

--●	Retrieve customers who have made purchases in the month of January (use order_date and TO_CHAR to extract the month).
SELECT
	c.customer_name,
	s.order_id,
	TO_CHAR(s.order_date,'FMMonth') as month_name
FROM 
customers c 
INNER JOIN
sales s
ON s.customer_id = c.customer_id
WHERE TO_CHAR(s.order_date,'FMMonth')='January'

--●	Calculate the number of days between the payment_date and order_date for each order (use the AGE function).
SELECT
	s.order_id,
	s.order_date,
	pm.payment_date,
	AGE(s.order_date,pm.payment_date) as datediff
FROM
sales s
INNER JOIN 
payments pm 
ON s.order_id=pm.order_id

--●	Find the total sales for each year (use EXTRACT with order_date to group by year).
SELECT
	SUM(quantity * price_per_unit),
	EXTRACT (YEAR FROM order_date) AS sale_year
FROM 
sales
GROUP BY 2
ORDER BY 2

--●	Show all orders where the shipping date is after the payment date (use date comparison).
SELECT
	pm.payment_date,
	sp.shipping_date
FROM
payments pm
INNER JOIN 
shippings sp
ON sp.order_id = pm.order_id
WHERE sp.shipping_date > pm.payment_date
