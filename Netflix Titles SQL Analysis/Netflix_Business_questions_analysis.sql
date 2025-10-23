-- 1. List all movies released in 2021:
SELECT * FROM netflix_titles; 
SELECT title,date_converted,type from netflix_titles where type= "Movie" AND release_year=2021;

-- 2. Find all TV Shows added in September 2021:
SELECT title, date_converted, type from netflix_titles 
where type= "TV Show" AND MONTHNAME(date_converted)= "September" 
AND YEAR(date_converted)=2021;

-- 3. Display all shows directed by “Kirsten Johnson”:
SELECT director,type,title,release_year from netflix_titles where director="Kirsten Johnson";

-- 4. Count how many titles belong to each type:
SELECT type, COUNT(title) as title_count from netflix_titles group by type; 

-- 5. List all shows that have a rating of ‘TV-MA’:
SELECT title,type,rating from netflix_titles where rating="TV-MA";

-- 6. Top 5 countries with the highest number of titles:
SELECT country,COUNT(*) as Highest_title from netflix_titles 
where country is not null AND country<> ' ' group by country  
ORDER BY Highest_title DESC LIMIT 5 ;

-- 7.Number of titles released per year (sorted by year):
Select release_year,COUNT(title) as total from netflix_titles GROUP by release_year Order by release_year DESC;

-- 8. Selecting no of Movies per year (sorted by year):
 SELECt type,release_year,Count(*) as total_movies from netflix_titles WHere type="Movie" Group by type,release_year Order BY release_year DESC;
 
--  -- 9. Find all titles with duration > 100 minutes:
--  SELECT title, duration from netflix_titles where duration>100;

-- 10. Find all titles with duration > 100 minutes:
SELECT title, duration,type,
CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS duration_in_minutes 
from netflix_titles where type="Movie" AND CAST(substring_index(duration,' ',1)as Unsigned)>100;

-- 11. Find all titles where description mentions “love” (case-insensitive):
SELECT title,description from netflix_titles where LOWER(description) Like "%love%";

-- 12. Find the Most common rating:
Select rating,count(*) as total_ratings from netflix_titles group by rating ORDER BY total_ratings DESC LIMIT 1;

-- 13. Directors who have directed more than 1 title:
select director,COunt(*) as directors_counts from netflix_titles where director is not null Group by director HAVING count(*)>1 Order by Count(*) desc;

-- 14. Movies older than the average release year:
SELECt type,release_year from netflix_titles 
where type="Movie" AND release_year < (SELECT AVG(release_year)from netflix_titles where type="Movie"
);
 -- 15. Q1. Find all ratings that appear more than 300 times in the dataset:
 SELECT rating,COUNT(*) as counts_0f_ratings from netflix_titles GROUP BY rating HAVING COUNT(*) >300 ORDER BY counts_0f_ratings DESC ;
 
 -- 16. Find all countries that have produced more than 50 “TV Shows”:
 SELECT country, count(*) as total_countrycount from netflix_titles 
 where country is NOT NULL AND type="TV show" GROUP BY country Having count(*) >50 ORDER BY total_countrycount DESC;
 
 -- 17. Q3. Find all titles whose description contains the word “crime” (case-insensitive):
 Select title,description from netflix_titles where LOWER(description) LIKE "%crime%";
 
 -- 18. Find all directors whose name starts with “S”:
 select distinct director from netflix_titles where director like "%S%";
 
 -- 19.Find all titles that have the same rating as the most common rating in the dataset:
 
SELECT title,rating from netflix_titles where 
rating= (SELECT rating from netflix_titles GROUP BY rating Order by COUNT(*) DESC LIMIT 1);

-- 20. Find all movies that were released after the average release year:
Select type,release_year from netflix_titles  where type="Movie" AND 
  release_year>(Select AVG(release_year)  from netflix_titles where type="Movie");
  
-- 
 

