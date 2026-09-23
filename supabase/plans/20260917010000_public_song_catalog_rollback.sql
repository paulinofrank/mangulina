BEGIN;
DROP FUNCTION public.get_public_song_context(uuid,text);
DROP FUNCTION public.get_public_song_directory(integer,text);
DROP FUNCTION public.get_artist_song_discography(uuid);
DROP VIEW public.public_song_recordings;
NOTIFY pgrst, 'reload schema';
COMMIT;
