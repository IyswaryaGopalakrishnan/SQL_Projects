CREATE database sql_project_2;
USE sql_project_2;

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
SELECT * FROM netflix_titles;

SELECT * FROM netflix_titles where show_id is null or 
type IS NULL OR title is null or 
director is NULL or casts is null 
OR country is null 
or date_added is null
OR release_year is NULL
OR rating is null
OR duration is null
OR listed_in IS NULL
OR description is NULL;

-- SELECT director from netflix_titles where director IS NULL;

-- SELECT casts
-- FROM netflix_titles
-- WHERE casts IS NULL OR casts = '';

SELECT * FROM netflix_titles;

SELECT COUNT(*) from netflix_titles;

SELECT CONCAT(title,"-", director) as Directorandtitle 
from netflix_titles WHERE director IS NOT NULL AND TRIM(director)<> ' ' 
AND title IS NOT NULL AND TRIM(title)<> '';

SELECT MIN(release_year) from netflix_titles;
SELECT MAX(release_year) from netflix_titles;

SELECT country,COUNT(release_year) as Countsofyears from netflix_titles group by country ORDER BY Countsofyears DESC;

SELECT release_year,COUNT(release_year) as Count_of_release_year from netflix_titles group by release_year ORDER BY Count_of_release_year DESC;

-- SELECT EXTRACT(YEAR from date_added) as Yearofdate, COUNT(*) as total_years from netflix_titles  
-- WHERE date_added is not null Group by EXTRACT(YEAR from date_added) ;

-- SELECT date_added, str_to_date(date_added, '%d-%M-%Y') as converted_date from netflix_titles;

-- -- Changing the date_added column's data type to date format
-- SET SQL_SAFE_UPDATES = 0;
ALTER TABLE netflix_titles
ADD COLUMN date_converted date;

UPDATE netflix_titles
SET date_converted = STR_TO_DATE(date_added, '%M %d, %Y')
WHERE date_added IS NOT NULL AND date_added <> '';

SELECT date_added, date_converted
FROM netflix_titles
LIMIT 10;

SELECT MONTHNAME(date_converted) as Yearofdate, COUNT(*) as total from netflix_titles
 where date_converted is not null group by Yearofdate;
 




