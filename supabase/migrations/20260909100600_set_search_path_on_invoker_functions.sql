-- Fix: 18 functions had no search_path pinned, so the caller's search_path
-- decided which schema their unqualified table references resolved to.
--
-- All 18 are SECURITY INVOKER, so the exposure is smaller than it would be for
-- a SECURITY DEFINER function -- there is no privilege to capture -- but a
-- caller with a hostile search_path can still steer them to shadow tables.
--
-- These are pinned to 'public, pg_catalog' rather than the empty string used
-- elsewhere in this schema: their bodies reference public tables unqualified,
-- so search_path = '' would break them. Pinning the resolution order fixes the
-- advisory without rewriting 18 function bodies.
--
-- Every remaining function in public already had a search_path set, including
-- all 41 SECURITY DEFINER ones.

ALTER FUNCTION public.get_artist_creative_role_summary(p_artist_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_artist_creative_works(p_artist_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_artist_recording_credits(artist_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_artist_releases(p_artist_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_artist_role_summary(p_artist_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_legacy_performer_credits() SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_primary_recording_performer(recording_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_primary_release_artist(p_release_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_recording_credit_count(recording_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_recording_performer_credit(recording_id uuid, artist_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_recording_performers(recording_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_recording_performers_by_role(recording_id uuid, role text) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_recording_performers_summary(recording_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_release_artist_credit(p_release_id uuid, p_artist_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_release_artists(p_release_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.get_release_credit_count(p_release_id uuid) SET search_path = public, pg_catalog;
ALTER FUNCTION public.update_credited_works_timestamp() SET search_path = public, pg_catalog;
ALTER FUNCTION public.update_timestamp() SET search_path = public, pg_catalog;

-- DOWN (manual rollback): ALTER FUNCTION public.<name>(<args>) RESET search_path;
