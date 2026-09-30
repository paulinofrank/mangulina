-- Advisor lint 0029 for the public-read SECURITY DEFINER functions. They are
-- called only server-side with the plain anon-key client (src/lib/queries/
-- songs.ts, songCatalog.ts, api/external-contributors/[id]/route.ts), never
-- with a signed-in session, so the authenticated grant is unused. anon and
-- service_role keep EXECUTE; the anon warning remains by design (public API).
--
-- Rollback:
--   GRANT EXECUTE ON FUNCTION public.get_external_contributor_public(uuid) TO authenticated;
--   GRANT EXECUTE ON FUNCTION public.get_public_recording_credits(uuid) TO authenticated;
--   GRANT EXECUTE ON FUNCTION public.get_public_song_context(uuid, text) TO authenticated;
REVOKE EXECUTE ON FUNCTION public.get_external_contributor_public(uuid) FROM authenticated;
REVOKE EXECUTE ON FUNCTION public.get_public_recording_credits(uuid) FROM authenticated;
REVOKE EXECUTE ON FUNCTION public.get_public_song_context(uuid, text) FROM authenticated;
