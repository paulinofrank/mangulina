-- Extend the existing public Works & Credits RPC with the optional performer
-- identity added in 20260718000000. The text credit remains authoritative for display.
DROP FUNCTION IF EXISTS public.get_artist_credited_works_with_roles(uuid);

CREATE OR REPLACE FUNCTION public.get_artist_credited_works_with_roles(p_artist_id uuid)
RETURNS TABLE(
  id uuid,
  title text,
  performer_artist_id uuid,
  performer_text text,
  performer_artist_slug text,
  performer_artist_name text,
  release_title text,
  release_type text,
  release_year integer,
  label text,
  track_number text,
  source_confidence text,
  roles text[],
  created_at timestamptz
)
LANGUAGE sql
STABLE
SECURITY INVOKER
SET search_path = public
AS $$
  SELECT
    cw.id,
    cw.title,
    cw.performer_artist_id,
    cw.performer_text,
    performer_artist.slug,
    performer_artist.name,
    cw.release_title,
    NULL::text AS release_type,
    cw.release_year,
    NULL::text AS label,
    NULL::text AS track_number,
    NULL::text AS source_confidence,
    ARRAY_AGG(cwc.role ORDER BY cwc.role) AS roles,
    cw.created_at
  FROM public.credited_works cw
  INNER JOIN public.credited_work_credits cwc ON cwc.credited_work_id = cw.id
  LEFT JOIN public.artists performer_artist ON performer_artist.id = cw.performer_artist_id
  WHERE cwc.artist_id = p_artist_id
  GROUP BY cw.id, performer_artist.id
  ORDER BY cw.release_year DESC NULLS LAST, cw.title ASC;
$$;

GRANT EXECUTE ON FUNCTION public.get_artist_credited_works_with_roles(uuid)
  TO anon, authenticated, service_role;

-- Rollback: reapply the previous function definition from
-- 20260705000010_fix_rpc_functions_for_simplified_schema.sql.
