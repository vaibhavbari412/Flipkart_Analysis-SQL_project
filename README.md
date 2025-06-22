# Flipkart E-commerce SQL Project

![Project Banner Placeholder](https://github.com/vaibhavbari412/Flipkart_Analysis-SQL_project/blob/main/flipkart.jpg)

Welcome to my SQL project, where I analyze real-time data from **Flipkart**! This project uses a dataset of **20,000+ sales records** and additional tables for payments, products, and shipping data to explore and analyze e-commerce transactions, product sales, and customer interactions. The project aims to solve business problems through SQL queries, helping Flipkart make informed decisions.

## Table of Contents
- [Introduction](#introduction)
- [Project Structure](#project-structure)
- [Database Schema](#database-schema)
- [Business Problems](#business-problems)
- [SQL Queries & Analysis](#sql-queries--analysis)
- [Getting Started](#getting-started)
- [Questions & Feedback](#questions--feedback)
- [Contact Me](#contact-me)

---

## Introduction

This project demonstrates essential SQL skills by analyzing e-commerce data from **Flipkart**, focusing on sales, payments, products, and customer data. Through SQL, we answer critical business questions, uncover trends, and derive actionable insights that help improve business strategies and customer experiences. The project covers different SQL techniques including **Joins**, **Group By**, **Aggregations**, and **Date Functions**.

## Project Structure

1. **SQL Scripts**: Contains code to create the database schema and write queries for analysis.
2. **Dataset**: Real-time data representing e-commerce transactions, product details, customer information, and shipping status.
3. **Analysis**: SQL queries crafted to solve business problems, each focusing on understanding e-commerce sales and performance.

---

## Database Schema

Here’s an overview of the database structure:

### 1. **Customers Table**
- **customer_id**: Unique identifier for each customer
- **customer_name**: Name of the customer
- **state**: Location (state) of the customer

### 2. **Products Table**
- **product_id**: Unique identifier for each product
- **product_name**: Name of the product
- **price**: Price of the product
- **cogs**: Cost of goods sold
- **category**: Category of the product
- **brand**: Brand name of the product

### 3. **Sales Table**
- **order_id**: Unique order identifier
- **order_date**: Date the order was placed
- **customer_id**: Linked to the `customers` table
- **order_status**: Status of the order (e.g., Completed, Cancelled)
- **product_id**: Linked to the `products` table
- **quantity**: Quantity of products sold
- **price_per_unit**: Price per unit of the product

### 4. **Payments Table**
- **payment_id**: Unique payment identifier
- **order_id**: Linked to the `sales` table
- **payment_date**: Date the payment was made
- **payment_status**: Status of the payment (e.g., Payment Successed, Payment Failed)

### 5. **Shippings Table**
- **shipping_id**: Unique shipping identifier
- **order_id**: Linked to the `sales` table
- **shipping_date**: Date the order was shipped
- **return_date**: Date the order was returned (if applicable)
- **shipping_providers**: Shipping provider (e.g., Ekart, Bluedart)
- **delivery_status**: Status of delivery (e.g., Delivered, Returned)

## Business Problems

The following queries were created to solve specific business questions. Each query is designed to provide insights based on sales, payments, products, and customer data.

## 🟢 Easy Level:

---

### 1. List Customers and Products Purchased
Retrieve a list of all customers with their corresponding product names they ordered.

```sql
SELECT c.customer_id, c.customer_name, p.product_name
FROM customers c
INNER JOIN sales s ON s.customer_id = c.customer_id
INNER JOIN products p ON p.product_id = s.product_id
ORDER BY c.customer_id;
```

---

### 2. Find All Orders Placed in 2023
List all orders that were placed in the year 2023.

```sql
SELECT *
FROM sales
WHERE EXTRACT(YEAR FROM order_date) = 2023;
```

---

### 3. Find Orders without Shipping Records
List all orders and their shipping status, including orders with no shipping records.

```sql
SELECT s.order_id, s.product_id, sp.shipping_id, sp.delivery_status
FROM sales s
LEFT JOIN shippings sp ON sp.order_id = s.order_id
ORDER BY 3;
```

---

### 4. Find Customers Who Have Not Made Any Payments
Retrieve a list of customers who have not made any payment for their orders.

```sql
SELECT c.customer_name, s.order_id
FROM customers c
INNER JOIN sales s ON s.customer_id = c.customer_id
LEFT JOIN payments pm ON pm.order_id = s.order_id
WHERE pm.order_id IS NULL;
```

---

## 🔶 Medium to Hard Level:

---

### 1. Total Sales Per Customer in Delhi Exceeding ₹50,000
Find total sales per customer in Delhi where the order status is 'Completed' and total sales exceed ₹50,000.

```sql
SELECT c.customer_name,
       SUM(s.quantity * s.price_per_unit)
FROM sales s
INNER JOIN customers c ON c.customer_id = s.customer_id
WHERE c.state = 'Delhi' AND s.order_status = 'Completed'
GROUP BY 1
HAVING SUM(s.quantity * s.price_per_unit) > 50000
ORDER BY 2;
```

---

### 2. Average Payment Value for Customers with More than 3 Orders
Retrieve customers who placed more than 3 orders along with their average payment value.

```sql
SELECT c.customer_name,
       COUNT(s.order_id) AS total_order,
       AVG(s.quantity * s.price_per_unit) AS avg_payment_value
FROM customers c
INNER JOIN sales s ON s.customer_id = c.customer_id
INNER JOIN payments pm ON pm.order_id = s.order_id
GROUP BY c.customer_name
HAVING COUNT(s.order_id) > 3;
```

---

### 3. Total Sales by Product Category Exceeding ₹1,00,000
Retrieve total sales for each product category where sales exceed ₹1,00,000.

```sql
SELECT SUM(s.quantity * s.price_per_unit) AS total_sales,
       p.category
FROM sales s
INNER JOIN products p ON p.product_id = s.product_id
GROUP BY p.category
HAVING SUM(s.quantity * s.price_per_unit) > 100000;
```

---

### 4. Most Popular Product in 2023
Find the product with the highest quantity sold in the year 2023.

```sql
SELECT p.product_name,
       COUNT(s.quantity) AS total_quantity
FROM sales s
INNER JOIN products p ON p.product_id = s.product_id
WHERE EXTRACT(YEAR FROM s.order_date) = 2023
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
```

   
---

## SQL Queries & Analysis

The `queries.sql` file contains all SQL queries developed for this project. Each query corresponds to a business problem and demonstrates skills in SQL syntax, data filtering, aggregation, grouping, and ordering.

---

## Getting Started

### Prerequisites
- PostgreSQL (or any SQL-compatible database)
- Basic understanding of SQL

### Steps
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/flipkart-sql-project.git
   ```
2. **Set Up the Database**:
   - Run the `Schema.sql` script to set up tables and insert sample data.

3. **Run Queries**:
   - Execute each query in above files to explore and analyze the data.

---

## Questions & Feedback

Feel free to add your questions and code snippets below and submit them as issues for further feedback!

**Example Questions**:
1. **Question**: How can I filter orders placed in the last 6 months?
   **Code Snippet**:
   ```sql
   SELECT * FROM sales
   WHERE order_date >= CURRENT_DATE - INTERVAL '6 months';
   ```

---

## Contact Me

📄 **[Resume](#)**  
📧 **[vaibhavbari412@gmail.com](mailto:vaibhavbari412@gmail.com)**  
📞 **Phone**: +91 7083848369  

---

## ERD (Entity-Relationship Diagram)

## Notice:
All customer names and data used in this project are computer-generated using AI and random
functions. They do not represent real data associated with Amazon or any other entity. This
project is solely for learning and educational purposes, and any resemblance to actual persons,
businesses, or events is purely coincidental.

![ERD Placeholder](https://github.com/vaibhavbari412/Flipkart_Analysis-SQL_project/blob/main/Flipkart%20ERD.png)
