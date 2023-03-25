-- Количество исполнителей в каждом жанре
SELECT name, COUNT (name) FROM genre_singer gs
JOIN genre g ON gs.genre_id = g.id
GROUP BY name;

-- Количество треков вошедших в альбомы 2019-2020 годов
SELECT COUNT (*) FROM track t
JOIN album a ON t.album_id = a.id
WHERE release_year BETWEEN 2019 and 2020;

-- Средняя продолжительность треков по каждому альбому
SELECT a.name, AVG(duration) FROM track t
JOIN album a ON t.album_id = a.id
GROUP BY a.name;

-- Все исполнители, которые не выпустили альбомы в 2020 году
SELECT nikname FROM singer
WHERE nikname NOT IN (SELECT nikname FROM album_singer as2
                      JOIN singer s ON as2.singer_id = s.id
                      JOIN album a ON as2.album_id = a.id
                      WHERE release_year IN (2020));

-- Названия сборников, в которых присутствует конкретный исполнитель(Баста)
SELECT c.name FROM track t
JOIN album a ON t.album_id = a.id
JOIN album_singer as2 ON as2.album_id = a.id
JOIN singer s ON as2.singer_id = s.id
JOIN track_collection tc ON tc.track_id = t.id
JOIN collection c ON tc.collection_id = c.id
WHERE nikname LIKE 'Баста'
GROUP BY c.name;

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT  a.name FROM album a
JOIN album_singer as2 ON as2.album_id = a.id
JOIN singer s ON as2.singer_id = s.id
JOIN genre_singer gs ON gs.singer_id = s.id
JOIN genre g ON gs.genre_id = g.id
GROUP BY a.name
HAVING COUNT(a.name) > 1;

-- Наименования треков, которые не входят в сборники
SELECT name FROM track
WHERE name NOT IN (SELECT t.name FROM track t
JOIN track_collection tc ON tc.track_id = t.id
JOIN collection c ON tc.collection_id = c.id);

-- или так
SELECT name FROM track
WHERE id NOT IN (SELECT track_id FROM track_collection);

-- Исполнители, написавшие самый короткий по продолжительности трек
SELECT nikname, duration FROM singer s
JOIN album_singer as2 ON as2.singer_id = s.id
JOIN album a ON as2.album_id = a.id
JOIN track t ON t.album_id = a.id
WHERE duration = (SELECT MIN(duration) FROM track);

-- Названия альбомов, содержащих наименьшее количество треков
SELECT a.name, COUNT(a.name)FROM album a
JOIN track t ON t.album_id = a.id
GROUP BY a.name
HAVING COUNT(a.name) = (SELECT COUNT(a.name)FROM album a
                        JOIN track t ON t.album_id = a.id
                        GROUP BY a.name
                        ORDER BY a.name DESC
                        LIMIT 1)
