CREATE TABLE IF NOT EXISTS genre(
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS singer(
    id SERIAL PRIMARY KEY,
    nikname VARCHAR(40) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS genre_singer(
    genre_id INTEGER REFERENCES genre(id),
    singer_id INTEGER REFERENCES singer(id),
    CONSTRAINT pk PRIMARY KEY (genre_id, singer_id)
);
CREATE TABLE IF NOT EXISTS album(
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    release_year INTEGER NOT NULL,
    CHECK(release_year >= 1900 AND release_year <= 2023)
);
CREATE TABLE IF NOT EXISTS album_singer(
    album_id INTEGER REFERENCES album(id),
    singer_id INTEGER REFERENCES singer(id),
    CONSTRAINT pr PRIMARY KEY (album_id, singer_id)
);
CREATE TABLE IF NOT EXISTS track(
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    duration INTEGER NOT NULL,
    CHECK(duration > 0 AND duration < 1000),
    album_id INTEGER REFERENCES album(id)
);
CREATE TABLE IF NOT EXISTS collection(
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    release_year INTEGER NOT NULL,
    CHECK(release_year >= 1900 AND release_year <= 2023)
);
CREATE TABLE IF NOT EXISTS track_collection(
    collection_id INTEGER REFERENCES collection(id),
    track_id INTEGER REFERENCES track(id),
    CONSTRAINT prk PRIMARY KEY (collection_id, track_id)
);