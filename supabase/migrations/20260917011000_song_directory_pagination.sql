BEGIN;
-- Apply pagination before resolving release artwork/year. The initial projection
-- resolved every appearance for the whole catalog just to count/page titles,
-- approaching the anonymous query timeout under concurrent requests.
-- Same signature, fields, visibility and grants; no data or access changes.
CREATE OR REPLACE FUNCTION public.get_public_song_directory(page_number integer DEFAULT 1, search_text text DEFAULT '')
RETURNS jsonb LANGUAGE sql STABLE SECURITY INVOKER SET search_path = '' AS $$
 WITH entries AS (
   SELECT 'work:' || w.id::text AS identity, w.preferred_title AS title,
          'work-' || coalesce(w.slug,w.id::text) AS slug,
          w.id AS work_id, NULL::uuid AS recording_id
   FROM public.works w WHERE w.status='published'
   UNION ALL
   SELECT 'recording:' || r.id::text, r.title, coalesce(r.slug,r.id::text), NULL::uuid, r.id
   FROM public.recordings r
   LEFT JOIN public.releases rel ON rel.id=r.release_id
   LEFT JOIN public.artists owner ON owner.id=coalesce(r.artist_id,rel.release_artist_id)
   LEFT JOIN public.works w ON w.id=r.work_id AND w.status='published'
   WHERE w.id IS NULL AND (coalesce(r.artist_id,rel.release_artist_id) IS NULL OR owner.status='published')
 ), filtered AS MATERIALIZED (
   SELECT * FROM entries WHERE strpos(lower(title),lower(left(coalesce(search_text,''),120)))>0
 ), page AS MATERIALIZED (
   SELECT * FROM filtered ORDER BY title,identity
   LIMIT 48 OFFSET (greatest(1,least(coalesce(page_number,1),100000))-1)*48
 ), decorated AS (
   SELECT p.identity,p.title,p.slug,coalesce(r.year,w.year) AS year,
          coalesce(r.cover_release_id,w.cover_release_id) AS cover_release_id,
          coalesce(r.has_cover_image,w.has_cover_image,false) AS has_cover_image
   FROM page p
   LEFT JOIN public.public_song_recordings r ON r.id=p.recording_id
   LEFT JOIN LATERAL (
     SELECT s.year,s.cover_release_id,s.has_cover_image FROM public.public_song_recordings s
     WHERE p.work_id IS NOT NULL AND s.work_id=p.work_id
     ORDER BY s.year NULLS LAST,s.id LIMIT 1
   ) w ON true
 )
 SELECT jsonb_build_object('total',(SELECT count(*) FROM filtered),
   'entries',coalesce((SELECT jsonb_agg(to_jsonb(p) ORDER BY p.title,p.identity) FROM decorated p),'[]'::jsonb));
$$;
NOTIFY pgrst,'reload schema';
COMMIT;
