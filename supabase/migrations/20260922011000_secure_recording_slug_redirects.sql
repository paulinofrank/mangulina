-- Preserve public slug lookups while restricting maintenance to the service role.
BEGIN;
SET LOCAL lock_timeout = '5s';

ALTER TABLE public.recording_slug_redirects ENABLE ROW LEVEL SECURITY;
CREATE POLICY recording_slug_redirects_public_select
ON public.recording_slug_redirects FOR SELECT TO anon, authenticated
USING (true);

-- RLS does not cover TRUNCATE; remove public maintenance privileges too.
REVOKE INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER
ON public.recording_slug_redirects FROM PUBLIC, anon, authenticated;
GRANT SELECT ON public.recording_slug_redirects TO anon, authenticated;

-- Supabase's service_role bypasses RLS; retain its existing maintenance grants.
NOTIFY pgrst, 'reload schema';
COMMIT;
