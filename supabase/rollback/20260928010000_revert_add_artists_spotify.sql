-- Reverts 20260928010000_add_artists_spotify.sql
ALTER TABLE public.artists
  DROP COLUMN IF EXISTS spotify;

NOTIFY pgrst, 'reload schema';
