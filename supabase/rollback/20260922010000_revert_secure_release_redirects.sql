-- Emergency rollback only: restores the previously insecure public write access.
-- Prefer correcting a policy over running this rollback.
BEGIN;
SET LOCAL lock_timeout = '5s';
DROP POLICY IF EXISTS release_redirects_public_select ON public.release_redirects;
ALTER TABLE public.release_redirects DISABLE ROW LEVEL SECURITY;
GRANT INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER
ON public.release_redirects TO anon, authenticated;
NOTIFY pgrst, 'reload schema';
COMMIT;
