-- REVERT SCRIPT -- NOT A MIGRATION.
-- Restores artists.primary_genre, artists.genres, and artists.artist_tags
-- to the values they held before the 2026-11-10 urban artist genre normalization.
BEGIN;

UPDATE public.artists a
SET primary_genre = b.primary_genre,
    genres = b.genres,
    artist_tags = b.artist_tags,
    updated_at = now()
FROM public.artists_backup_before_urban_genre_update_20261110 b
WHERE a.id = b.id;

COMMIT;
