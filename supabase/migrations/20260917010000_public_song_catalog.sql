BEGIN;

-- Public read projections over the existing ontology. No identity/credit writes.
-- Release status is Official/Bootleg/etc., not an editorial publication flag.
CREATE VIEW public.public_song_recordings WITH (security_invoker = true) AS
SELECT r.id, r.slug, r.title, w.id AS work_id, w.slug AS work_slug,
       w.preferred_title AS work_title, owner.id AS artist_id, owner.name AS artist_name,
       owner.slug AS artist_slug, r.duration, r.recording_year, r.isrcs,
       coalesce(first_release.release_year, r.recording_year) AS year,
       coalesce(first_release.id, representative.id) AS cover_release_id,
       coalesce(first_release.has_cover_image, representative.has_cover_image, false) AS has_cover_image
FROM public.recordings r
LEFT JOIN public.releases representative ON representative.id = r.release_id
LEFT JOIN public.artists owner ON owner.id = coalesce(r.artist_id, representative.release_artist_id)
LEFT JOIN public.works w ON w.id = r.work_id AND w.status = 'published'
LEFT JOIN LATERAL (
  SELECT rel.id, coalesce(rel.release_year, rel.year, extract(year FROM rel.date)::integer) AS release_year,
         rel.has_cover_image
  FROM public.tracks t JOIN public.releases rel ON rel.id = t.release_id
  LEFT JOIN public.artists a ON a.id = rel.release_artist_id
  WHERE t.recording_id = r.id AND (rel.release_artist_id IS NULL OR a.status = 'published')
  ORDER BY coalesce(rel.release_year, rel.year, extract(year FROM rel.date)::integer) NULLS LAST,
           rel.date NULLS LAST, rel.id
  LIMIT 1
) first_release ON true
WHERE coalesce(r.artist_id, representative.release_artist_id) IS NULL OR owner.status = 'published';

GRANT SELECT ON public.public_song_recordings TO anon, authenticated, service_role;

CREATE FUNCTION public.get_artist_song_discography(artist_uuid uuid)
RETURNS jsonb LANGUAGE sql STABLE SECURITY INVOKER SET search_path = '' AS $$
 SELECT coalesce(jsonb_agg(to_jsonb(s) ORDER BY s.year NULLS LAST, s.title, s.id), '[]'::jsonb)
 FROM public.public_song_recordings s
 WHERE EXISTS (SELECT 1 FROM public.artists a WHERE a.id = artist_uuid AND a.status = 'published')
 AND (s.artist_id = artist_uuid OR EXISTS (
   SELECT 1 FROM public.recording_credits c WHERE c.recording_id = s.id AND c.artist_id = artist_uuid
   AND c.role IN ('lead_performer','featured_performer','guest_performer','vocalist','performer','featured_artist')
 ));
$$;

CREATE FUNCTION public.get_public_song_directory(page_number integer DEFAULT 1, search_text text DEFAULT '')
RETURNS jsonb LANGUAGE sql STABLE SECURITY INVOKER SET search_path = '' AS $$
 WITH entries AS (
   SELECT 'work:' || w.id::text AS identity, w.preferred_title AS title,
          'work-' || coalesce(w.slug, w.id::text) AS slug,
          example.year, example.cover_release_id, coalesce(example.has_cover_image, false) AS has_cover_image
   FROM public.works w
   LEFT JOIN LATERAL (
     SELECT s.year, s.cover_release_id, s.has_cover_image FROM public.public_song_recordings s
     WHERE s.work_id = w.id ORDER BY s.year NULLS LAST, s.id LIMIT 1
   ) example ON true
   WHERE w.status = 'published'
   UNION ALL
   SELECT 'recording:' || s.id::text, s.title, coalesce(s.slug, s.id::text),
          s.year, s.cover_release_id, s.has_cover_image
   FROM public.public_song_recordings s WHERE s.work_id IS NULL
 ), filtered AS (
   SELECT * FROM entries WHERE strpos(lower(title), lower(left(coalesce(search_text,''),120))) > 0
 ), page AS (
   SELECT * FROM filtered ORDER BY title, identity
   LIMIT 48 OFFSET (greatest(1, least(coalesce(page_number,1),100000))-1)*48
 )
 SELECT jsonb_build_object('total',(SELECT count(*) FROM filtered),
   'entries',coalesce((SELECT jsonb_agg(to_jsonb(p) ORDER BY p.title,p.identity) FROM page p),'[]'::jsonb));
$$;

-- Only explicitly selected public fields leave this function. Version profiles
-- and external contributor identities are otherwise service-only. Never return
-- internal editorial notes, assertions, or a draft Work through this endpoint.
CREATE FUNCTION public.get_public_song_context(recording_uuid uuid DEFAULT NULL, work_key text DEFAULT NULL)
RETURNS jsonb LANGUAGE sql STABLE SECURITY DEFINER SET search_path = '' AS $$
 WITH selected_work AS (
   SELECT w.* FROM public.works w WHERE w.status = 'published' AND (
     (work_key IS NOT NULL AND coalesce(w.slug,w.id::text) = work_key) OR
     (recording_uuid IS NOT NULL AND EXISTS (
       SELECT 1 FROM public.public_song_recordings s WHERE s.id=recording_uuid AND s.work_id=w.id
     ))
   )
 ), selected_recordings AS (
   SELECT s.* FROM public.public_song_recordings s
   WHERE (work_key IS NOT NULL AND s.work_id IN (SELECT id FROM selected_work))
      OR (work_key IS NULL AND s.id=recording_uuid)
 )
 SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM selected_work) AND NOT EXISTS (SELECT 1 FROM selected_recordings)
 THEN NULL ELSE jsonb_build_object(
   'work',(SELECT jsonb_build_object('id',w.id,'slug',w.slug,'title',w.preferred_title,
     'language',w.language,'composition_year',w.composition_year,'publication_year',w.publication_year)
     FROM selected_work w),
   'work_credits',coalesce((
     SELECT jsonb_agg(jsonb_build_object('role',c.role,'identity_type',CASE WHEN c.artist_id IS NOT NULL THEN 'artist' ELSE 'external_contributor' END,
       'identity_id',coalesce(c.artist_id,c.external_contributor_id),
       'display_name',coalesce(nullif(c.credited_as,''),a.name,e.preferred_name),
       'artist_slug',a.slug,'country',coalesce(e.country,e.country_code)) ORDER BY c.sequence NULLS LAST,c.id)
     FROM public.work_credits c
     LEFT JOIN public.artists a ON a.id=c.artist_id AND a.status='published'
     LEFT JOIN public.external_contributors e ON e.id=c.external_contributor_id AND e.status IN ('draft','verified')
     WHERE c.work_id IN (SELECT id FROM selected_work) AND c.verification_status <> 'superseded'
       AND (a.id IS NOT NULL OR e.id IS NOT NULL)
   ),'[]'::jsonb),
   'recordings',coalesce((SELECT jsonb_agg(to_jsonb(s) || jsonb_build_object(
     'version', (SELECT jsonb_build_object('performance_kind',v.performance_kind,'derivation_kind',v.derivation_kind,
       'language_code',v.language_code,'performance_context',v.performance_context,'performance_date',v.performance_date,
       'performance_date_precision',v.performance_date_precision) FROM public.recording_version_profiles v WHERE v.recording_id=s.id),
     'credits',coalesce((SELECT jsonb_agg(to_jsonb(c)) FROM public.get_public_recording_credits(s.id) c),'[]'::jsonb),
     'identifiers',coalesce((SELECT jsonb_agg(jsonb_build_object('isrc',i.isrc,'verification_status',i.verification_status) ORDER BY i.isrc)
       FROM public.recording_isrcs i WHERE i.recording_id=s.id AND i.verification_status <> 'superseded'),'[]'::jsonb),
     'platform_links',coalesce((SELECT jsonb_agg(jsonb_build_object('platform',p.platform,'url',p.url,'label',p.label) ORDER BY p.display_order,p.platform,p.id)
       FROM public.recording_platform_links p WHERE p.recording_id=s.id AND p.status IN ('approved_manual','approved_auto','approved')),'[]'::jsonb),
     'appearances',coalesce((SELECT jsonb_agg(jsonb_build_object('track_id',t.id,'release_id',rel.id,'title',rel.title,
       'slug',rel.slug,'year',coalesce(rel.release_year,rel.year),'type',rel.type,'country',rel.country,
       'group_title',g.title,'disc',t.disc_number,'position',coalesce(t.position,t.track_number),'title_override',t.title_override)
       ORDER BY coalesce(rel.release_year,rel.year) NULLS LAST,rel.id,t.disc_number,t.position,t.id)
       FROM public.tracks t JOIN public.releases rel ON rel.id=t.release_id
       LEFT JOIN public.release_groups g ON g.id=rel.release_group_id
       LEFT JOIN public.artists a ON a.id=rel.release_artist_id
       WHERE t.recording_id=s.id AND (rel.release_artist_id IS NULL OR a.status='published')),'[]'::jsonb)
   ) ORDER BY s.year NULLS LAST,s.title,s.id) FROM selected_recordings s),'[]'::jsonb)
 ) END;
$$;

REVOKE ALL ON FUNCTION public.get_artist_song_discography(uuid), public.get_public_song_directory(integer,text),
 public.get_public_song_context(uuid,text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.get_artist_song_discography(uuid), public.get_public_song_directory(integer,text),
 public.get_public_song_context(uuid,text) TO anon, authenticated, service_role;
COMMENT ON VIEW public.public_song_recordings IS 'One row per publicly visible Recording; published Work identity only. Never deduplicate by title or provider identifiers.';
NOTIFY pgrst, 'reload schema';
COMMIT;
