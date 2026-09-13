-- Correction to 20260909100100.
--
-- That migration ended with REVOKE ALL ... FROM PUBLIC before granting anon,
-- authenticated and service_role. The site was unaffected -- src/lib/supabase.ts
-- uses the anon key on both the browser and the server -- but it left
-- get_related_songs as the only function in public without the implicit PUBLIC
-- EXECUTE grant that every sibling RPC carries (get_artist_discography,
-- get_artist_profile_page, global_search, get_release_summaries_by_ids, ...).
--
-- The practical effect was that read-only roles could not call it:
-- supabase_read_only_user, which the Supabase MCP and any audit tooling run
-- as, got "permission denied for function get_related_songs".
--
-- Restoring PUBLIC EXECUTE grants nothing that anon did not already have. The
-- function is STABLE, SECURITY INVOKER, and reads only rows the caller's own
-- RLS already permits.

GRANT EXECUTE ON FUNCTION public.get_related_songs(uuid) TO PUBLIC;

-- DOWN (manual rollback):
--   REVOKE EXECUTE ON FUNCTION public.get_related_songs(uuid) FROM PUBLIC;

INSERT INTO supabase_migrations.schema_migrations (version, name)
VALUES ('20260909100900', 'align_get_related_songs_grants')
ON CONFLICT (version) DO NOTHING;
