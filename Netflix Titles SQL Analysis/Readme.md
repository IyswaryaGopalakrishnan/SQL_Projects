# Netflix Titles Analysis

**Overview**

This project analyzes a Netflix dataset using MySQL. It focuses on performing data cleaning, exploration, and analytical queries to extract valuable insights about movies and TV shows available on Netflix.

The project demonstrates the use of:

-Table creation and schema definition

-Data cleaning and formatting

-Aggregation, filtering, and pattern matching

-Subqueries and date conversions

-Business analysis through SQL questions

**Tools Used:**

**1. SQL**: MySQL
**2. IDE**: MySQL Workbench
**3. Netflix Dataset(Kaggle)**

**Skills Demonstrated:**

1. Data Cleaning & Transformation
2.Aggregate Functions (COUNT, AVG, MIN, MAX)
3. String Functions (LIKE, SUBSTRING, LOWER)
4. Date Functions (YEAR, MONTHNAME, STR_TO_DATE)
5. Subqueries & Nested Queries
6. Grouping & Filtering

**Database Setup**
Database Name: sql_project_2

```sql
CREATE DATABASE sql_project_2;
USE sql_project_2;
```
**Table Creation**: A main table named netflix_titles is created to store information about all titles available on Netflix. The table structure includes columns for show ID, type of content (Movie or TV Show), title, director name, main cast members, country of production, date when the title was added to Netflix, release year, age-based rating, duration (for example, “90 min” or “2 Seasons”), category or genre of the content, and a short description summarizing the show or movie.
```sql
CREATE TABLE netflix_titles
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```

**Data Cleaning Steps**
1. Checking for Missing Values:
```sql
SELECT * FROM netflix_titles 
WHERE show_id IS NULL OR 
type IS NULL OR title IS NULL OR 
director IS NULL OR casts IS NULL OR 
country IS NULL OR date_added IS NULL OR 
release_year IS NULL OR rating IS NULL OR 
duration IS NULL OR listed_in IS NULL OR 
description IS NULL;
```
2. Converting date_added to Proper Date Format:
```sql
ALTER TABLE netflix_titles
ADD COLUMN date_converted DATE;

UPDATE netflix_titles
SET date_converted = STR_TO_DATE(date_added, '%M %d, %Y')
WHERE date_added IS NOT NULL AND date_added <> '';
```
### 3. Data Analysis & Findings:

The following SQL queries were developed to answer specific business questions:

1. **List all movies released in 2021:**
```sql
SELECT * FROM netflix_titles; 
SELECT title,date_converted,type from netflix_titles where type= "Movie" AND release_year=2021;
```
 2. Find all TV Shows added in September 2021:
```sql
SELECT title, date_converted, type from netflix_titles 
where type= "TV Show" AND MONTHNAME(date_converted)= "September" 
AND YEAR(date_converted)=2021;
```
 3. Display all shows directed by “Kirsten Johnson”:
```sql
SELECT director,type,title,release_year from netflix_titles
where director="Kirsten Johnson";
```
4. Count how many titles belong to each type:
```sql
SELECT type, COUNT(title) as title_count
from netflix_titles group by type; 
```
5. List all shows that have a rating of ‘TV-MA’:
```sql
SELECT title,type,rating from netflix_titles
where rating="TV-MA";
```
6. Top 5 countries with the highest number of titles:
```sql
SELECT country,COUNT(*) as Highest_title from netflix_titles 
where country is not null AND country<> ' ' group by country  
ORDER BY Highest_title DESC LIMIT 5 ;
```
7.Number of titles released per year (sorted by year):
```sql
Select release_year,COUNT(title) as total from netflix_titles
GROUP by release_year Order by release_year DESC;
```
8. Selecting no of Movies per year (sorted by year):
```sql
 SELECt type,release_year,Count(*) as total_movies from netflix_titles
 WHere type="Movie" Group by type,release_year Order BY release_year DESC;
 ```
9. Find all titles with duration > 100 minutes:
  ```sql
SELECT title, duration from netflix_titles where duration>100;
```
10. Find all titles with duration > 100 minutes:
```sql
SELECT title, duration,type,
CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS duration_in_minutes 
from netflix_titles where type="Movie" AND CAST(substring_index(duration,' ',1)as Unsigned)>100;
```
11. Find all titles where description mentions “love” (case-insensitive):
```sql
SELECT title,description from netflix_titles
where LOWER(description) Like "%love%";
```
12. Find the Most common rating:
```sql
Select rating,count(*) as total_ratings from netflix_titles
group by rating ORDER BY total_ratings DESC LIMIT 1;
```
13. Directors who have directed more than 1 title:
```sql
select director,COunt(*) as directors_counts from netflix_titles
where director is not null Group by director
HAVING count(*)>1 Order by Count(*) desc;
```
14. Movies older than the average release year:
```sql
SELECt type,release_year from netflix_titles 
where type="Movie" AND release_year < (SELECT AVG(release_year)from netflix_titles where type="Movie"
);
```
15. Q1. Find all ratings that appear more than 300 times in the dataset:
 ```sql
SELECT rating,COUNT(*) as counts_0f_ratings from netflix_titles
GROUP BY rating HAVING COUNT(*) >300 ORDER BY counts_0f_ratings DESC ;
 ```
16. Find all countries that have produced more than 50 “TV Shows”:
```sql
 SELECT country, count(*) as total_countrycount from netflix_titles 
 where country is NOT NULL AND type="TV show"
 GROUP BY country Having count(*) >50 ORDER BY total_countrycount DESC;
 ```
17.Find all titles whose description contains the word “crime” (case-insensitive):
 ```sql
Select title,description from netflix_titles where LOWER(description) LIKE "%crime%";
 ```
18. Find all directors whose name starts with “S”:
 ```sql
select distinct director from netflix_titles
where director like "%S%";
 ```
19.Find all titles that have the same rating as the most common rating in the dataset:
```sql 
SELECT title,rating from netflix_titles where 
rating= (SELECT rating from netflix_titles GROUP BY rating Order by COUNT(*) DESC LIMIT 1);
```
20. Find all movies that were released after the average release year:
```sql
Select type,release_year from netflix_titles  where type="Movie" AND 
  release_year>(Select AVG(release_year)  from netflix_titles where type="Movie");
```

   


