create database practice_joins_netflix;
USE practice_joins_netflix; 

CREATE TABLE shows(

show_id VARCHAR(10) PRIMARY KEY,
type VARCHAR(100),
title VARCHAR(255),
release_year INT,
rating VARCHAR(20),
duration VARCHAR(50)
);

CREATE TABLE production(
show_id VARCHAR(10),
director VARCHAR(300),
country VARCHAR(100),
date_added DATE,
FOREIGN KEY (show_id) REFERENCES shows(show_id)
);

CREATE TABLE details
(
show_id VARCHAR(10),
listed_in VARCHAR(150),
description TEXT,
FOREIGN KEY (show_id) REFERENCES shows(show_id)
);

INSERT INTO shows (show_id,type,title,release_year,rating,duration)
VALUES
('s1', 'Movie', 'Dick Johnson Is Dead', 2020, 'PG-13', '90 min'),
('s2', 'TV Show', 'Blood & Water', 2021, 'TV-MA', '2 Seasons'),
('s3', 'TV Show', 'Ganglands', 2021, 'TV-MA', '1 Season'),
('s4', 'TV Show', 'Jailbirds New Orleans', 2021, 'TV-MA', '1 Season'),
('s5', 'TV Show', 'Kota Factory', 2021, 'TV-MA', '2 Seasons'),
('s6', 'TV Show', 'Midnight Mass', 2021, 'TV-MA', '1 Season'),
('s7', 'Movie', 'My Little Pony: A New Generation', 2021, 'PG', '91 min'),
('s8', 'Movie', 'Sankofa', 1993, 'TV-MA', '125 min'),
('s9', 'TV Show', 'The Great British Baking Show', 2021, 'TV-14', '9 Seasons'),
('s10', 'Movie', 'The Starling', 2021, 'PG-13', '104 min'),
('s11', 'TV Show', 'Vendetta: Truth, Lies and The Mafia', 2021, 'TV-MA', '1 Season'),
('s12', 'TV Show', 'Bangkok Breaking', 2021, 'TV-MA', '1 Season'),
('s13', 'Movie', 'Je Suis Karl', 2021, 'TV-MA', '127 min'),
('s14', 'Movie', 'Confessions of an Invisible Girl', 2021, 'TV-PG', '91 min'),
('s15', 'TV Show', 'Crime Stories: India Detectives', 2021, 'TV-MA', '1 Season'),
('s16', 'TV Show', 'Dear White People', 2021, 'TV-MA', '4 Seasons'),
('s17', 'Movie', 'Europe’s Most Dangerous Man: Otto Skorzeny in Spain', 2020, 'TV-MA', '67 min'),
('s18', 'TV Show', 'Falsa Identidad', 2020, 'TV-MA', '2 Seasons'),
('s19', 'Movie', 'Intrusion', 2021, 'TV-14', '94 min'),
('s20', 'TV Show', 'Jaguar', 2021, 'TV-MA', '1 Season');


INSERT INTO production(show_id,director,country,date_added)
VALUES ('s1', 'Kirsten Johnson', 'United States', '2021-09-25'),
('s2', NULL, 'South Africa', '2021-09-24'),
('s3', 'Julien Leclercq', NULL, '2021-09-24'),
('s4', NULL, NULL, '2021-09-24'),
('s5', NULL, 'India', '2021-09-24'),
('s6', 'Mike Flanagan', NULL, '2021-09-24'),
('s7', 'Robert Cullen, José Luis Ucha', NULL, '2021-09-24'),
('s8', 'Haile Gerima', 'United States, Ghana, Burkina Faso, United Kingdom, Germany, Ethiopia', '2021-09-24'),
('s9', 'Andy Devonshire', 'United Kingdom', '2021-09-24'),
('s10', 'Theodore Melfi', 'United States', '2021-09-24'),
('s11', NULL, NULL, '2021-09-24'),
('s12', 'Kongkiat Komesiri', NULL, '2021-09-23'),
('s13', 'Christian Schwochow', 'Germany, Czech Republic', '2021-09-23'),
('s14', 'Bruno Garotti', NULL, '2021-09-22'),
('s15', NULL, NULL, '2021-09-22'),
('s16', NULL, 'United States', '2021-09-22'),
('s17', 'Pedro de Echave García, Pablo Azorín Williams', NULL, '2021-09-22'),
('s18', NULL, 'Mexico', '2021-09-22'),
('s19', 'Adam Salky', NULL, '2021-09-22'),
('s20', NULL, NULL, '2021-09-22');
-- SET SQL_SAFE_UPDATES = 1;

UPDATE production
Set director ="Unknown"
WHERE director is null or director =' ';

UPDATE production
set country="Unknown"
where country is null or country=' ';

INSERT INTO details(show_id,listed_in,description)
values 
('s1', 'Documentaries', 'As her father nears the end of his life, filmmaker Kirsten Johnson stages his death in inventive and comical ways.'),
('s2', 'International TV Shows, TV Dramas, TV Mysteries', 'A Cape Town teen sets out to prove whether a private-school swimming star is her sister abducted at birth.'),
('s3', 'Crime TV Shows, International TV Shows, TV Action & Adventure', 'A thief and his team are pulled into a violent turf war to protect family.'),
('s4', 'Docuseries, Reality TV', 'Feuds and flirtations go down among incarcerated women in New Orleans.'),
('s5', 'International TV Shows, Romantic TV Shows, TV Comedies', 'An earnest student navigates campus life in a competitive coaching city.'),
('s6', 'TV Dramas, TV Horror, TV Mysteries', 'A young priest brings miracles and mysteries to a dying town.'),
('s7', 'Children & Family Movies', 'A bright-eyed hero believes ponies, pegasi and unicorns should be friends.'),
('s8', 'Dramas, Independent Movies, International Movies', 'An American model travels back in time to witness her ancestral agony.'),
('s9', 'British TV Shows, Reality TV', 'Amateur bakers face off in a 10-week competition in the U.K.'),
('s10', 'Comedies, Dramas', 'A woman struggles with grief and a feisty bird taking over her garden.'),
('s11', 'Crime TV Shows, Docuseries, International TV Shows', 'A Sicilian anti-mafia coalition faces its own accusations.'),
('s12', 'Crime TV Shows, International TV Shows, TV Action & Adventure', 'A rescue worker unravels a citywide conspiracy in Bangkok.'),
('s13', 'Dramas, International Movies', 'After her family is killed, a woman is lured into joining the terrorists.'),
('s14', 'Children & Family Movies, Comedies', 'A socially awkward girl joins a new school and tries to fit in.'),
('s15', 'British TV Shows, Crime TV Shows, Docuseries', 'A rare look into Bengaluru police crime investigations.'),
('s16', 'TV Comedies, TV Dramas', 'Students of color navigate college life and racial politics.'),
('s17', 'Documentaries, International Movies', 'Documents reveal Otto Skorzeny’s post-WWII life in Spain.'),
('s18', 'Crime TV Shows, Spanish-Language TV Shows, TV Dramas', 'Strangers pretend to be a married couple to escape their enemies.'),
('s19', 'Thrillers', 'A woman uncovers danger after a deadly home invasion.'),
('s20', 'International TV Shows, Spanish-Language TV Shows, TV Action & Adventure', 'A Holocaust survivor joins spies to hunt Nazis in Spain.');

