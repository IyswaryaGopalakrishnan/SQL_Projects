SQL Project 1 – Retail Sales Analysis
 **Project Overview**
**Project Title**: Retail Sales Analysis 
**Level**: Beginner 
**Database**: SQL_Project_1 
This project demonstrates how SQL can be used to clean, analyze, and derive insights from retail sales data. It focuses on understanding customer behavior, sales performance, and product category trends using structured SQL queries.
This project is ideal for beginners looking to build a solid foundation in SQL for data analytics and business insights.

**Objectives**

1. Database Setup: Create and organize a retail sales database.
2.Data Cleaning: Identify and handle missing or incorrect values.
3.Exploratory Data Analysis (EDA): Explore and summarize key data metrics.
4.Business Insights: Solve real-world questions using SQL.

**Tools & Technologies**
-SQL: MySQL
-IDE: MySQL Workbench
-Dataset: Simulated retail transaction data

**Techniques Used:**

-Aggregate functions (SUM, AVG, COUNT)
-Conditional logic (CASE WHEN)
-Common Table Expressions (CTEs)
-Window functions (RANK, PARTITION BY)
-Date and time functions

**Project Structure**

-retail_sales_basic.sql → Contains setup, data cleaning, and exploratory queries
-retail_sales_business_queries.sql → Contains advanced business analysis queries
-README.md → Project documentation and explanation

1. Database Setup:
'''sql
CREATE DATABASE SQL_Project_1;
USE SQL_Project_1;

CREATE TABLE Retail_sales(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(20),
    age INT,
    category VARCHAR(100),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
'''
2. Data Cleaning & Exploration:
2.1 Record Count
'''sql
SELECT COUNT(*) FROM retail_sales;
'''
2.2 Customer Analysis
'''sql
SELECT COUNT(customer_id) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT COUNT(*) FROM retail_sales WHERE gender='female';
SELECT COUNT(*) FROM retail_sales WHERE gender='male';
'''
2.3 Category Analysis
'''sql
SELECT DISTINCT category FROM retail_sales;
SELECT category, COUNT(*) FROM retail_sales GROUP BY category;
'''
2.4 Quantity & Sales Insights
'''sql
SELECT MAX(quantity), MIN(quantity) FROM retail_sales;
SELECT SUM(quantity) FROM retail_sales;
'''
2.5 Null Value Check & Cleaning
'''sql
SELECT * FROM retail_sales 
WHERE category IS NULL 
   OR total_sale IS NULL 
   OR cogs IS NULL 
   OR quantity IS NULL;
'''
2.6 Corrected Column name to replace mispelled word
'''sql
ALTER TABLE retail_sales
CHANGE quantiy quantity INT;
'''
'''sql
DELETE FROM retail_sales
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
      gender IS NULL OR age IS NULL OR category IS NULL OR 
      quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;
'''
2.7 Age Analysis
'''sql
SELECT Age,
       CASE 
           WHEN age BETWEEN 18 AND 30 THEN 'Youth'
           WHEN age BETWEEN 31 AND 45 THEN 'Middle_age'
           WHEN age BETWEEN 46 AND 59 THEN 'Getting_Old'
           ELSE 'Old'
       END AS age_category
FROM retail_sales
ORDER BY Age DESC;
'''
2.8 Date & Time Exploration
'''sql
SELECT sale_date,
       DAY(sale_date) AS day_of_month,
       DAYOFWEEK(sale_date) AS day_of_week,
       MONTHNAME(sale_date) AS month_name,
       YEAR(sale_date) AS year
FROM retail_sales;

SELECT sale_time,
       HOUR(sale_time) AS hour,
       MINUTE(sale_time) AS minute,
       SECOND(sale_time) AS second
FROM retail_sales;
'''
2.9 Concatenated Insights
'''sql
SELECT CONCAT(category, '-', COUNT(*)) AS total_count
FROM retail_sales
GROUP BY category;
'''
 **Summary of Findings**

-Total Customers: Counted all customers and unique customers
-Gender Distribution: Number of male and female customers
-Category Distribution: Identified categories and records per category
-Quantity Insights: Maximum, minimum, and total quantity purchased
-Age Groups: Categorized customers into Youth, Middle_age, Getting_Old, and Old
-Date & Time Patterns: Explored day, week, month, year, and hour of purchases
-Data Cleaning: Identified and removed null values; corrected column name typos.

3. Business Analysis & Insights

The following SQL queries were developed to answer specific business questions:
1.1. Write a SQL query to retrieve all columns for sales made on '2022-11-05':
'''SQL
SELECT * FROM retail_sales 
where sale_date='2022-11-05';
'''
2.Write a SQL query to retrieve all transactions 
where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
'''SQL
SELECT category,sale_date,quantity from retail_sales 
	where category='Clothing' AND  
	quantity>=4 AND 
	Month(sale_date)=11 AND 
    YEAR(sale_date) =2022;
'''
3. Write a SQL query to calculate the total sales (total_sale) for each category:
'''sql
SELECT SUM(total_sale) AS Total_sales,category 
from retail_sales 
GROUP by category;
'''

4. For each product category, calculate the total sales revenue and the total number of transactions.
-- Which category generated the highest revenue, and which category had the most transactions?
'''sql
SELECT category, SUM(total_sale) as Total_sales, COUNT(*) as total_orders 
	from retail_sales GROUP BY category
	ORDER BY Total_sales DESC;
'''
5. Write a SQL query to find the average age of customers 
who purchased items from the 'Beauty' category.:
'''sql
SELECT category,ROUND(AVG(age),2) as Average_age_of_customers 
	from retail_sales 
where category='beauty';
'''
6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
	
'''sql
Select gender,category,Count(transactions_id) as Total_Transcations 
    from retail_sales 
    Group BY gender,category 
    ORDER by category;
'''
7.Write a querry to Find profit for each transaction:
	 
'''sql
SELECT transactions_id,total_sale,cogs, 
	 (total_sale-cogs) As profit from retail_sales;
'''
8. Write a querry to Calculate total profit by category?
	'''sql
  SELECT category,ROUND(SUM(total_sale-cogs),2) from retail_sales 
	group by category;
'''
9.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
	'''sql
SELECt year,month,avg_sale
	FROM ( 
	SELECT  
	EXTRACT(YEAR FROm sale_date) as year,
	EXTRACT(Month from sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER(Partition by EXTRACT(YEAR from sale_date) 
	ORDER BY avg(total_sale) DESC) as Top_Rank 
	from retail_sales GROUP BY year,month) as monthly_average 
	WHERE Top_Rank =1 Order by year ;
'''
-- 10.  **Write a SQL query to find the top 5 customers based on the highest total sales **:
	'''sql
Select customer_id,SUM(total_sale) as total_sales 
	from retail_sales 
	Group by customer_id 
	Order by total_sales DESC LIMIT 5;
'''
-- 11. Write a SQL query to find the number of unique customers who purchased items from each category.:
	'''sql
SELECT COUNT( distinct Customer_id) as unique_customers, category 
	from retail_sales Group by category; 
'''
-- 12. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
	'''sql
WITH Hourly_sales as 
	(
	SELECT *,
	CASE
	WHEN EXTRACT(Hour FROM sale_time)<12 THEN "Morning" 
	WHEN EXTRACT(Hour FROM sale_time) between 12 and 17 THEN "Afternoon" 
	ELSE "Evening"
	END AS SHIFT
	 FROM retail_sales)
	SELECT 
    shift,
    COUNT(*) as total_orders    
	FROM Hourly_sales
	GROUP BY shift;
'''
--  13. Write a SQL query to find the percentage contribution of each category to the total sales.
'''sql
	SELECT category,ROUND((SUM(total_sale)/ (SELECT SUM(total_sale) from retail_sales))*100,2) as Percentage_contribution 
	from retail_sales
	GROUP BY category
	Order by Percentage_contribution DESC;
'''

 -- 14.  Write a SQL query to identify customers who purchased from more than one category. 
	'''sql
  Select Count(DISTINCT category) as unique_categories,customer_id from retail_sales 
	group by customer_id HAVING unique_categories>1 
	ORDER BY unique_categories DESC;
'''
