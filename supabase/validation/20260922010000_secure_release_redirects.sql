-- Run as the database owner after migration. Raises on unsafe permissions.
DO $$
DECLARE
  reader text;
  privilege text;
BEGIN
  IF NOT (SELECT relrowsecurity FROM pg_class
          WHERE oid = 'public.release_redirects'::regclass) THEN
    RAISE EXCEPTION 'release_redirects RLS is disabled';
  END IF;
  FOREACH reader IN ARRAY ARRAY['anon', 'authenticated'] LOOP
    IF NOT has_table_privilege(reader, 'public.release_redirects', 'SELECT') THEN
      RAISE EXCEPTION '% cannot read redirects', reader;
    END IF;
    FOREACH privilege IN ARRAY ARRAY['INSERT', 'UPDATE', 'DELETE', 'TRUNCATE', 'REFERENCES', 'TRIGGER'] LOOP
      IF has_table_privilege(reader, 'public.release_redirects', privilege) THEN
        RAISE EXCEPTION '% still has % privilege', reader, privilege;
      END IF;
      IF NOT has_table_privilege('service_role', 'public.release_redirects', privilege) THEN
        RAISE EXCEPTION 'service_role lost % privilege', privilege;
      END IF;
    END LOOP;
  END LOOP;
END $$;

-- These counts should match the owner count; public lookup must survive RLS.
BEGIN READ ONLY;
SELECT count(*) AS owner_redirect_count FROM public.release_redirects;
SET LOCAL ROLE anon;
SELECT count(*) AS anon_redirect_count FROM public.release_redirects;
RESET ROLE;
SET LOCAL ROLE authenticated;
SELECT count(*) AS authenticated_redirect_count FROM public.release_redirects;
ROLLBACK;
