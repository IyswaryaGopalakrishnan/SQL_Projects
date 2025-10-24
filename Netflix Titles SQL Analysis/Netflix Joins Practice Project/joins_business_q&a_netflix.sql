SELECT * FROM shows;
SELECT * FROM production;
SELECT * FROM details;

-- 1.  Join all three tables
SELECT * FROm shows
JOIN production 
on shows.show_id= production.show_id
JOIN details
on shows.show_id =details.show_id;

SELECT s.show_id,s.type,s.title,s.release_year,s.rating,p.director,p.country,p.date_added,d.listed_in from shows as s
JOIN production as p on s.show_id= p.show_id
JOIN details as d on s.show_id= d.show_id order by CAST(substring(s.show_id,2) as UNSIGNED);

-- 2. Find all movies directed by a specific director:

SELECT s.type,s.title, p.director from shows as s 
JOIN production as p on
s.show_id=p.show_id WHERE p.director= 'Julien Leclercq';
 
 -- 3. Count how many titles each country produced:
 SELECT p.country,COUNT(s.show_id) as title_counts from production as p 
 JOIN shows as s on
p.show_id= s.show_id GROUP BY p.country ORDER BY title_counts DESC ;
 
-- 4. List TV shows and their genres added after 2020:
SELECT s.type,s.release_year, d.listed_in from shows as s
JOIN details as d ON
s.show_id=d.show_id where s.release_year>2020 AND s.type="TV Show";

-- 5. Find average release year per content type:
select s.type, ROUND(AVG(s.release_year),2) 
from shows as s GROUP BY s.type;

-- 6. Top genres by count:
SELECT d.listed_in,COUNT(*) as total_counts
 from details as d 
 GROUP by d.listed_in Order by count(*) DESC;

 

 








