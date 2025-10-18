-- Data Analysis & Findings
-- The following SQL queries were developed to answer specific business questions:

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05':
		SELECT * FROM retail_sales where sale_date='2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
	SELECT category,sale_date,quantity from retail_sales 
	where category='Clothing' AND  
	quantity>=4 AND 
	Month(sale_date)=11 AND 
    YEAR(sale_date) =2022;

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.: 
	SELECT SUM(total_sale) AS Total_sales,category from retail_sales GROUP by category;

-- 4. "For each product category, calculate the total sales revenue and the total number of transactions.
-- Which category generated the highest revenue, and which category had the most transactions?" 

	SELECT category, SUM(total_sale) as Total_sales, COUNT(*) as total_orders 
	from retail_sales GROUP BY category
	ORDER BY Total_sales DESC;

-- 5. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

	SELECT category,ROUND(AVG(age),2) as Average_age_of_customers 
	from retail_sales where category='beauty';

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
	Select gender,category,Count(transactions_id) as Total_Transcations 
    from retail_sales 
    Group BY gender,category 
    ORDER by category;
 
 -- 7. Write a querry to Find profit for each transaction 
	 SELECT transactions_id,total_sale,cogs, 
	 (total_sale-cogs) As profit from retail_sales;

-- 8 Write a querry to Calculate total profit by category?
	SELECT category,ROUND(SUM(total_sale-cogs),2) from retail_sales 
	group by category;

-- 9.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
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

-- 10.  **Write a SQL query to find the top 5 customers based on the highest total sales **:
	Select customer_id,SUM(total_sale) as total_sales 
	from retail_sales 
	Group by customer_id 
	Order by total_sales DESC LIMIT 5;

-- 11. Write a SQL query to find the number of unique customers who purchased items from each category.:
	SELECT COUNT( distinct Customer_id) as unique_customers, category 
	from retail_sales Group by category; 

-- 12. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
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
--  13. Write a SQL query to find the percentage contribution of each category to the total sales.

	SELECT category,ROUND((SUM(total_sale)/ (SELECT SUM(total_sale) from retail_sales))*100,2) as Percentage_contribution 
	from retail_sales
	GROUP BY category
	Order by Percentage_contribution DESC;

 -- 14.  Write a SQL query to identify customers who purchased from more than one category. 
	Select Count(DISTINCT category) as unique_categories,customer_id from retail_sales 
	group by customer_id HAVING unique_categories>1 
	ORDER BY unique_categories DESC;
 

