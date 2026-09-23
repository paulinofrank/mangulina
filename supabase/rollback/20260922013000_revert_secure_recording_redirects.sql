BEGIN;
DROP POLICY IF EXISTS recording_redirects_public_select
ON public.recording_redirects;
REVOKE SELECT ON public.recording_redirects FROM anon, authenticated;
COMMIT;
