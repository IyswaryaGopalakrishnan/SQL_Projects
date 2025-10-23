### Overview

This project is a practice exercise focused on SQL joins using a mini Netflix dataset. It demonstrates how to structure normalized tables and apply different types of joins to answer analytical questions.

### Database Structure

### Database Name: practice_joins_netflix

Tables:

**1. shows:** – Basic details about each Netflix title.

**-Columns:** show_id, type, title, release_year, rating, duration

**2.production:**– Information about directors, countries, and added dates.

**-Columns:** show_id, director, country, date_added

**3.details:** – Genre and description details for each show.

**-Columns:** show_id, listed_in, description

Each table is connected by the foreign key **show_id**.

### Relationships:

1. shows ⟶ production: One-to-One

2. shows ⟶ details: One-to-One

Combined together, they form a relational Netflix dataset.

### Data Cleaning

Before performing joins, missing values were handled for clarity and consistency:

-Replaced NULL values in director and country columns with 'Unknown'.

-Ensured each table had unique show_id values.

-Verified referential integrity between tables.

### 3. Data Analysis & Findings:

The following SQL queries were developed to answer specific business questions:

1.  Join all three tables
```sql
SELECT * FROm shows
JOIN production 
on shows.show_id= production.show_id
JOIN details
on shows.show_id =details.show_id;
```
```sql
SELECT s.show_id,s.type,s.title,s.release_year,s.rating,p.director,p.country,p.date_added,d.listed_in from shows as s
JOIN production as p on s.show_id= p.show_id
JOIN details as d on s.show_id= d.show_id order by CAST(substring(s.show_id,2) as UNSIGNED);
```
2. Find all movies directed by a specific director:
```sql
SELECT s.type,s.title, p.director from shows as s 
JOIN production as p on
s.show_id=p.show_id WHERE p.director= 'Julien Leclercq';
 ```
3. Count how many titles each country produced:
 ```sql
SELECT p.country,COUNT(s.show_id) as title_counts from production as p 
 JOIN shows as s on
p.show_id= s.show_id GROUP BY p.country ORDER BY title_counts DESC ;
```
4. List TV shows and their genres added after 2020:
```sql
SELECT s.type,s.release_year, d.listed_in from shows as s
JOIN details as d ON
s.show_id=d.show_id where s.release_year>2020 AND s.type="TV Show";
```
5. Find average release year per content type:
```sql
select s.type, ROUND(AVG(s.release_year),2) 
from shows as s GROUP BY s.type;
```
6. Top genres by count:
```sql
SELECT d.listed_in,COUNT(*) as total_counts
 from details as d 
 GROUP by d.listed_in Order by count(*) DESC;
```

### Key Learnings

1. Practiced INNER JOINs across multiple tables
2.Learned how to structure normalized relational tables
3.Strengthened understanding of foreign keys and data linkage
4.Gained experience writing analytical SQL queries using joins, grouping, and filtering

### Tools Used

-MySQL Workbench 8.0
-SQL Queries and Schema Design
-Sample Netflix Dataset (manually curated)
