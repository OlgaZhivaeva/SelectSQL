SELECT name, release_year FROM album
WHERE release_year = 2020;

SELECT name, duration FROM track
ORDER BY duration DESC
LIMIT 1;

SELECT name FROM track
WHERE duration >= 210;

SELECT name FROM collection
WHERE release_year BETWEEN 2021 AND 2022;

SELECT nikname FROM singer
WHERE nikname NOT LIKE '% %';

SELECT track FROM track
WHERE name LIKE '%мой%' OR name LIKE '%my%';
