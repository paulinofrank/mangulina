-- Add a Spotify artist ID column to artists, mirroring the existing
-- youtube/facebook/instagram columns: stores the bare Spotify artist ID
-- (22-character base62, e.g. 2sSqkk6j5gRa7MzeQqMfIN), not a full URL.
ALTER TABLE public.artists
  ADD COLUMN IF NOT EXISTS spotify text NULL;

COMMENT ON COLUMN public.artists.spotify IS
  'Spotify artist ID (22-character base62 id from open.spotify.com/artist/<id>). Bare ID, matching the youtube/facebook/instagram convention, not a full URL.';

NOTIFY pgrst, 'reload schema';
