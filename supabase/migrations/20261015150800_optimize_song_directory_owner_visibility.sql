-- Applied to Mangulina production on October 15, 2026 with user approval.
-- Query-only optimization; no access-control or catalog-data changes.
DO $guard$ BEGIN
IF pg_get_functiondef('public.get_public_song_directory(integer,text)'::regprocedure) IS DISTINCT FROM $expected$CREATE OR REPLACE FUNCTION public.get_public_song_directory(page_number integer DEFAULT 1, search_text text DEFAULT ''::text)
 RETURNS jsonb
 LANGUAGE sql
 STABLE
 SET search_path TO ''
AS $function$
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
$function$
$expected$ THEN RAISE EXCEPTION 'Song directory changed since reviewed snapshot'; END IF;
END $guard$;
CREATE OR REPLACE FUNCTION public.get_public_song_directory(page_number integer DEFAULT 1, search_text text DEFAULT ''::text)
 RETURNS jsonb
 LANGUAGE sql
 STABLE
 SET search_path TO ''
AS $function$
 WITH entries AS (
   SELECT 'work:' || w.id::text AS identity, w.preferred_title AS title,
          'work-' || coalesce(w.slug,w.id::text) AS slug,
          w.id AS work_id, NULL::uuid AS recording_id
   FROM public.works w WHERE w.status='published'
   UNION ALL
   SELECT 'recording:' || r.id::text, r.title, coalesce(r.slug,r.id::text), NULL::uuid, r.id
   FROM public.recordings r
   LEFT JOIN public.releases rel ON rel.id=r.release_id
   LEFT JOIN public.works w ON w.id=r.work_id AND w.status='published'
   WHERE w.id IS NULL AND (coalesce(r.artist_id,rel.release_artist_id) IS NULL OR coalesce(r.artist_id,rel.release_artist_id) IN (
     SELECT a.id FROM public.artists a WHERE a.status='published'
   ))
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
$function$;
DO $guard$ DECLARE p record; BEGIN
SELECT prosecdef,proconfig,proacl::text AS acl,pg_get_userbyid(proowner) AS owner INTO p FROM pg_proc WHERE oid='public.get_public_song_directory(integer,text)'::regprocedure;
IF p.prosecdef IS DISTINCT FROM false OR p.proconfig IS DISTINCT FROM ARRAY['search_path=""']::text[] OR p.acl IS DISTINCT FROM '{postgres=X/postgres,anon=X/postgres,authenticated=X/postgres,service_role=X/postgres}' OR p.owner IS DISTINCT FROM 'postgres' THEN RAISE EXCEPTION 'Function security metadata changed'; END IF;
END $guard$;
