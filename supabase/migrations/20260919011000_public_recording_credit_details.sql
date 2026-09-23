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
COMMIT;
