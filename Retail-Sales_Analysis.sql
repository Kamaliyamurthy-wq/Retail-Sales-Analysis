Retail Sales Analysis

--Create table
CREATE TABLE sales (
transaction_id TEXT PRIMARY KEY,
sale_date TEXT,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR(15),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sales FLOAT
);

SELECT * FROM sales LIMIT 10;

SELECT * FROM sales;

2. DATA CLEANING
--CHECK NULL VALUES
SELECT *
FROM sales
WHERE category IS NULL;
--HANDLE NULL VALUES
UPDATE sales
SET category = 'Unknown'
WHERE category IS NULL;

--CHECK DUPLICATES
SELECT transaction_id, COUNT(*)
FROM sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;

--convert sale_date to date formate
ALTER TABLE sales
ALTER COLUMN sale_date TYPE DATE
USING sale_date::DATE;

3.DATA ANALYSIS
--Total revenue
SELECT SUM(total_sales) AS total_revenue
FROM sales;

--Revenue by category
SELECT category,
SUM(total_sales) AS revenue
FROM sales
GROUP BY category
ORDER BY revenue DESC;

--Revenue by Gender
SELECT gender,
SUM(total_sales) AS revenue
FROM sales
GROUP BY gender;

--Monthly Sales Trend
SELECT DATE_TRUNC('month', sale_date) AS month,
SUM(total_sales) AS revenue
FROM sales
GROUP BY month
ORDER BY month;

--Top 10 Customers
SELECT customer_id,
SUM(total_sales) AS total_spent
FROM sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

--Avg customer age
SELECT AVG(age)
FROM sales;

--Age Froup Analysis
SELECT 
CASE 
  WHEN age < 25 THEN 'Below 25'
  WHEN age BETWEEN 25 AND 35 THEN '25-35'
  WHEN age BETWEEN 36 AND 50 THEN '36-50'
  ELSE '50+'
END AS age_group,
SUM(total_sales) AS revenue
FROM sales
GROUP BY age_group
ORDER BY revenue DESC;

--Quantity sold by category
SELECT category, SUM(quantity) AS total_quantity
FROM sales
GROUP BY category
ORDER BY total_quantity DESC;

--Average order value
SELECT AVG(total_sales) AS avg_order_value
FROM sales;

--Peak sales hours
SELECT EXTRACT(HOUR FROM sale_time) AS hour,
SUM(total_sales) AS revenue
FROM sales
GROUP BY hour
ORDER BY revenue DESC;

--top 5 sales time slot
SELECT sale_time,SUM(total_sales) AS revenue
FROM sales
GROUP BY sale_time
ORDER BY revenue DESC
LIMIT 5;

--Profit Analysis
SELECT SUM(total_sales - cogs) AS total_profit
FROM sales;

--Category Performance by Gender
SELECT gender, category,
SUM(total_sales) AS revenue
FROM sales
GROUP BY gender, category
ORDER BY gender, revenue DESC;

--Repeat customer
SELECT customer_id,
COUNT(*) AS orders
FROM sales
GROUP BY customer_id
HAVING COUNT(*) > 1;

--END PROJECT
