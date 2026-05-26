CREATE INDEX IF NOT EXISTS artists_genres_gin
ON artists
USING GIN (genres);
