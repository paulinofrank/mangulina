-- PROPOSAL - NOT APPLIED. Human owner must review and apply.
-- Enables the existing public instrument presentation after the approved
-- Cómo quisiera instrument links were saved on 2026-10-31.
-- Adds only the pre-existing safe projection of normalized instruments;
-- preserves the full song-context behavior and excludes internal metadata.
BEGIN;

CREATE OR REPLACE FUNCTION public.get_public_recording_credit_details(recording_uuid uuid)
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = ''
AS $$
  SELECT coalesce(jsonb_agg(jsonb_build_object(
    'role', rc.role,
    'role_family', cr.role_family,
    'identity_type', CASE WHEN rc.artist_id IS NOT NULL THEN 'artist' ELSE 'external_contributor' END,
    'identity_id', coalesce(rc.artist_id, rc.external_contributor_id),
    'display_name', coalesce(nullif(rc.credited_as, ''), a.name, e.preferred_name),
    'artist_slug', a.slug,
    'country', coalesce(e.country, e.country_code),
    'instruments', coalesce((
      SELECT jsonb_agg(jsonb_build_object(
        'code', i.code,
        'name_en', i.display_name_en,
        'name_es', i.display_name_es
      ) ORDER BY rci.sequence, i.display_name_en)
      FROM public.recording_credit_instruments rci
      JOIN public.instruments i ON i.id = rci.instrument_id AND i.status = 'active'
      WHERE rci.recording_credit_id = rc.id
    ), '[]'::jsonb)
  ) ORDER BY coalesce(cr.display_order, 10000), rc.display_order, rc.id), '[]'::jsonb)
  FROM public.recording_credits rc
  LEFT JOIN public.credit_roles cr ON cr.id = rc.role_id
  LEFT JOIN public.artists a ON a.id = rc.artist_id AND a.status = 'published'
  LEFT JOIN public.external_contributors e ON e.id = rc.external_contributor_id AND e.status = 'verified'
  WHERE rc.recording_id = recording_uuid
    AND (a.id IS NOT NULL OR e.id IS NOT NULL);
$$;

REVOKE ALL ON FUNCTION public.get_public_recording_credit_details(uuid) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.get_public_recording_credit_details(uuid) TO anon, authenticated, service_role;
COMMENT ON FUNCTION public.get_public_recording_credit_details(uuid) IS
  'Public recording personnel projection with controlled role family and normalized instruments; excludes draft contributors, free-text details, internal notes, and evidence.';

NOTIFY pgrst, 'reload schema';


DO $$
DECLARE old_definition text; new_definition text;
BEGIN
 SELECT pg_get_functiondef('public.get_public_song_context(uuid,text)'::regprocedure) INTO old_definition;
 IF position('public.get_public_recording_credit_details(s.id)' IN old_definition) > 0 THEN
   RETURN;
 END IF;
 new_definition := replace(old_definition,
   'coalesce((SELECT jsonb_agg(to_jsonb(c)) FROM public.get_public_recording_credits(s.id) c),''[]''::jsonb)',
   'public.get_public_recording_credit_details(s.id)');
 IF new_definition = old_definition THEN
   RAISE EXCEPTION 'Song context differs from reviewed definition; stop for review';
 END IF;
 EXECUTE new_definition;
END $$;
COMMIT;

-- Verify as anon after applying (read-only):
-- SELECT public.get_public_song_context(recording_uuid => 'bb2ecc6a-e88a-4fd2-aa72-205119032c0a'::uuid);
-- Confirm all four instruments in recordings[].credits[].instruments in both languages.
-- Then refresh only como-quisiera-alex-bueno and work-como-quisiera.
-- Rollback: restore the reviewed prior get_public_song_context definition,
-- replacing public.get_public_recording_credit_details(s.id) with
-- coalesce((SELECT jsonb_agg(to_jsonb(c)) FROM public.get_public_recording_credits(s.id) c),'[]'::jsonb)
-- before dropping public.get_public_recording_credit_details(uuid), if newly installed.
-- This does not reverse instrument data or the approved links.
