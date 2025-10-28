# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `SQL_Project_1 `

This project demonstrates how SQL can be used to clean, analyze, and derive insights from retail sales data. It focuses on understanding customer behavior, sales performance, and product category trends using structured SQL queries.
This project is ideal for beginners looking to build a solid foundation in SQL for data analytics and business insights.

## Objectives

1. **Database Setup**: Create and organize a retail sales database
2. **Data Cleaning**: Identify and handle missing or incorrect valuess.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Solve real-world questions using SQL

**Tools & Technologies**
**1. SQL**: MySQL
**2. IDE**: MySQL Workbench
**3. Dataset**: Simulated retail transaction data
**Techniques Used:**

-Aggregate functions (SUM, AVG, COUNT)
-Conditional logic (CASE WHEN)
-Common Table Expressions (CTEs)
-Window functions (RANK, PARTITION BY)
-Date and time functions

## Project Structure
-retail_sales_basic.sql → Contains setup, data cleaning, and exploratory queries
-retail_sales_business_queries.sql → Contains advanced business analysis queries
-README.md → Project documentation and explanation

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL_Project_1 `.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * FROM retail_sales 
where sale_date='2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT category,sale_date,quantity from retail_sales 
	where category='Clothing' AND  
	quantity>=4 AND 
	Month(sale_date)=11 AND 
    YEAR(sale_date) =2022;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT SUM(total_sale) AS Total_sales,category 
from retail_sales 
GROUP by category;
```
4. **For each product category, calculate the total sales revenue and the total number of transactions.
-- Which category generated the highest revenue, and which category had the most transactions?**
```sql
SELECT category, SUM(total_sale) as Total_sales, COUNT(*) as total_orders 
	from retail_sales GROUP BY category
	ORDER BY Total_sales DESC;
```

5. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT category,ROUND(AVG(age),2) as Average_age_of_customers 
	from retail_sales 
where category='beauty';
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category**:
```sql
Select gender,category,Count(transactions_id) as Total_Transcations 
    from retail_sales 
    Group BY gender,category 
    ORDER by category;
```

7. *Write a querry to Find profit for each transaction:**:
```sql
SELECT transactions_id,total_sale,cogs, 
	 (total_sale-cogs) As profit from retail_sales;
```

8. **Write a querry to Calculate total profit by category?**:
```sql
 SELECT category,ROUND(SUM(total_sale-cogs),2) from retail_sales 
	group by category;
```

9. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:**
```sql
SELECT year,month,avg_sale
	FROM ( 
	SELECT  
	EXTRACT(YEAR FROm sale_date) as year,
	EXTRACT(Month from sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER(Partition by EXTRACT(YEAR from sale_date) 
	ORDER BY avg(total_sale) DESC) as Top_Rank 
	from retail_sales GROUP BY year,month) as monthly_average 
	WHERE Top_Rank =1 Order by year ;
```

10. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
Select customer_id,SUM(total_sale) as total_sales 
	from retail_sales 
	Group by customer_id 
	Order by total_sales DESC LIMIT 5;
```
11. **Write a SQL query to find the number of unique customers who purchased items from each category:**
 ```sql
SELECT COUNT( distinct Customer_id) as unique_customers, category 
	from retail_sales Group by category; 
```   
     
12. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
```
13. **Write a SQL query to find the percentage contribution of each category to the total sales:**
 ```sql
SELECT category,ROUND((SUM(total_sale)/ (SELECT SUM(total_sale) from retail_sales))*100,2) as Percentage_contribution 
	from retail_sales
	GROUP BY category
	Order by Percentage_contribution DESC;
```

14. **Write a SQL query to identify customers who purchased from more than one category:**
 ```sql
 Select Count(DISTINCT category) as unique_categories,customer_id from retail_sales 
	group by customer_id HAVING unique_categories>1 
	ORDER BY unique_categories DESC
```


## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.



