BEGIN;
CREATE OR REPLACE FUNCTION public.get_public_song_directory(page_number integer DEFAULT 1, search_text text DEFAULT '')
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

NOTIFY pgrst, 'reload schema';
COMMIT;
