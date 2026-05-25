CREATE INDEX IF NOT EXISTS artists_occupations_gin
ON artists
USING GIN (occupations);
