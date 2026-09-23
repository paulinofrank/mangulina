-- public_song_recordings uses this table to suppress obsolete identities.
-- Allow public reads while keeping every maintenance operation restricted.
BEGIN;
SET LOCAL lock_timeout = '5s';

ALTER TABLE public.recording_redirects ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS recording_redirects_public_select
ON public.recording_redirects;

CREATE POLICY recording_redirects_public_select
ON public.recording_redirects FOR SELECT TO anon, authenticated
USING (true);

REVOKE INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER
ON public.recording_redirects FROM PUBLIC, anon, authenticated;
GRANT SELECT ON public.recording_redirects TO anon, authenticated;

NOTIFY pgrst, 'reload schema';
COMMIT;
