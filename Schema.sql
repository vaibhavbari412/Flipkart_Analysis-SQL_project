--DROP TABLE IF EXISTS customers, products, sales, shippings, payments

CREATE TABLE customers
(
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(35),
	state VARCHAR(35)
);

CREATE TABLE products
(
	product_id	INT PRIMARY KEY,
	product_name VARCHAR(45),
	price	FLOAT,
	cogs	FLOAT,
	category VARCHAR(25),	
	brand VARCHAR(25)
);

CREATE TABLE sales
(
	order_id INT PRIMARY KEY,	
	order_date	DATE,
	customer_id	INT REFERENCES customers(customer_id),
	order_status VARCHAR(25),	
	product_id	INT REFERENCES products(product_id),
	quantity	INT,
	price_per_unit FLOAT
--	CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
--	CONSTRAINT fk_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);


CREATE TABLE shippings
(
	shipping_id	INT PRIMARY KEY,
	order_id INT REFERENCES sales(order_id),
	shipping_date DATE,
	return_date	DATE,
	shipping_providers	VARCHAR(25),
	delivery_status VARCHAR(25)
);

CREATE TABLE payments
(
	payment_id INT PRIMARY KEY,	
	order_id INT REFERENCES sales(order_id),
	payment_date DATE,	
	payment_status VARCHAR(25)
);

SELECT 'Database Setup Completed'