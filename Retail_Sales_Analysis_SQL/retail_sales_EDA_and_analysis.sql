-- SQL MINI PROJECT 1--  
CREATE Database SQL_Project_1;
USE SQL_Project_1;
-- CREATING A TABLE--  
CREATE TABLE Retail_sales(
transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(20),
	age INT,
	category VARCHAR(100),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);
SELECT * FROm retail_sales;

SELECT COUNT(*) FROM retail_sales;

-- Data Cleaning--
 SELECT avg(total_sale) from retail_sales;
SELECT * from retail_sales where transactions_id is NULL;
SELECT * from retail_sales where sale_date is NULL;
SELECT * from retail_sales where sale_time IS NULL;
SELECT * from retail_sales where gender IS NULL;
SELECT * from retail_sales where age IS NULL;
SELECT * from retail_sales where category IS NULL;
SELECT * from retail_sales where quantiy IS NULL;
SELECT * from retail_sales where price_per_unit IS NULL;
SELECT * from retail_sales where cogs IS NULL;
SELECT * from retail_sales where total_sale IS NULL;


-- DATA CLEANING WITH OR CONDITION--  
SELECT * from retail_sales where category IS NULL
or
total_sale IS NULL 
or
cogs IS NULL 
OR 
quantiy is null;

-- Data Exploration--
-- 1. How many customers we have ??-- 
SELECT COUNT(customer_id) from retail_sales;
 -- 2. How many female customers do we have?--  
 SELECT COUNT(*) from retail_sales where gender="female";
 -- 3. How many male customers do we have?-- 
 SELECT COUNT(*) from retail_sales where gender="male";
 -- 4. What is the Maximum quantity a customer bought?-- 
SELECT MAX(Quantity) from retail_sales;
 -- 5. What is the Minimum quantity a customer bought?-- 
SELECT MIN(Quantity) from retail_sales;
 -- 6. How many records per each category?--  
SELECT Count(category) from retail_sales Group by category;
 -- 7. What is the total quantity?-- 
SELECT SUM(quantity) from retail_sales;
 -- 8. How many unique customers are there?-- 
SELECT COUNT(DISTINCT customer_id) from retail_sales;
-- 9. What is the Max age of the customer from this table grouped by customer_id?-- 
SELECT MAX(age) as Max_age, customer_id from retail_sales group by customer_id Order by Max_age DESC LIMIT 10;

-- SINCE I TYPED THE WRONG SPELLING FOR QUANTITY COLUMN NAME, Using Alter table to fix this--

ALTER TABLE retail_sales
CHANGE quantiy quantity INT;
-- Exploring date and time--  
SELECT sale_date, Day(sale_date) from retail_sales;
SELECT sale_date, Dayofweek(sale_date) from retail_sales;
SELECT sale_date, Dayofyear(sale_date) from retail_sales;
SELECT sale_date, Monthname(sale_date) from retail_sales;
SELECT sale_date, WEEK(sale_date) from retail_sales;
SELECT sale_date, WEEKOFYEAR(sale_date) from retail_sales;
SELECT sale_date, year(sale_date) from retail_sales;

SELECT 
    sale_date,
    DAY(sale_date) AS day_of_month,
    DAYOFWEEK(sale_date) AS day_of_week,
    MONTHNAME(sale_date) AS month_name,
    YEAR(sale_date) AS year
FROM retail_sales
LIMIT 100;

SELECT sale_time, hour(sale_time) from retail_sales;
SELECT sale_time, minute(sale_time) from retail_sales;
SELECT sale_time, second(sale_time) from retail_sales;

SELECT sale_time, hour(sale_time) as HOUR,  minute(sale_time) AS MINUTE, second(sale_time) AS SECONDS from retail_sales;
 
 -- EXPLORING AGE COLUMN--  
SELECT age AS Middle_Age from retail_sales WHERE age  Between 20 AND 30;
 
 SELECT MIN(AGE) from retail_sales;
SELECT MAX(AGE) from retail_sales;
 
 SELECT Age,
 CASE 
 when age between 18 AND 30  THEN "Youth"
 WHEN age between 31 AND 45 THEN "Middle_age"
 WHEN Age between 46 AND 59 THEN "Getting_Old"
 ELSE "OLD"
 END AS age_categorys 
   From retail_sales ORDER BY Age DESC;
-- Using Concat to merge two columns--    
SELECT CONCAT(category, '-', COUNT(*)) As Total_count from retail_sales Group by category;
