-- Restore the live pre-change RPC. Roll back application first.
BEGIN;
CREATE OR REPLACE FUNCTION public.global_search(search_text text)
 RETURNS jsonb
 LANGUAGE sql
 STABLE
 SET search_path TO 'public', 'extensions'
AS $function$
      with q as (
        select public.search_normalize(trim(search_text)) as term
      ),

      artist_results as (
        select
          'artist' as type,
          a.id::text as id,
          a.name as title,
          a.slug,
          null::text as subtitle,
          null::integer as year,
          'https://srulenjahemkuxtkfmzt.supabase.co/storage/v1/object/public/artists-images/' ||
            a.id::text ||
            '.webp' as cover_url
        from public.artists a, q
        where public.search_normalize(a.name) like '%' || q.term || '%'
          and a.status = 'published'
        order by
          case
            when public.search_normalize(a.name) = q.term then 0
            when public.search_normalize(a.name) like q.term || '%' then 1
            else 2
          end,
          a.name
        limit 25
      ),

      song_results as (
        select distinct on (r.id)
          'song' as type,
          r.id::text as id,
          r.title as title,
          null::text as slug,
          coalesce(a.name, rel_artist.name) as subtitle,
          coalesce(r.recording_year, rel.release_year, rel.year) as year,
          case
            when rel.id is not null then
              'https://srulenjahemkuxtkfmzt.supabase.co/storage/v1/object/public/cover-art/' ||
              rel.id::text ||
              '.webp'
            else null
          end as cover_url
        from public.recordings r
        left join public.artists a
          on a.id = r.artist_id
         and a.status = 'published'
        left join public.tracks t
          on t.recording_id = r.id
        left join public.releases rel
          on rel.id = t.release_id
        left join public.artists rel_artist
          on rel_artist.id = rel.release_artist_id
         and rel_artist.status = 'published',
        q
        where public.search_normalize(r.title) like '%' || q.term || '%'
          and (
            r.artist_id is null
            or a.id is not null
            or rel_artist.id is not null
          )
        order by r.id, r.title
        limit 15
      ),

      release_results as (
        select
          'release' as type,
          rel.id::text as id,
          rel.title as title,
          null::text as slug,
          a.name as subtitle,
          coalesce(rel.release_year, rel.year) as year,
          'https://srulenjahemkuxtkfmzt.supabase.co/storage/v1/object/public/cover-art/' ||
            rel.id::text ||
            '.webp' as cover_url
        from public.releases rel
        join public.artists a
          on a.id = rel.release_artist_id
         and a.status = 'published',
        q
        where public.search_normalize(rel.title) like '%' || q.term || '%'
        order by rel.title
        limit 15
      )

      select jsonb_build_object(
        'artists', coalesce((select jsonb_agg(artist_results order by title) from artist_results), '[]'::jsonb),
        'songs', coalesce((select jsonb_agg(song_results order by title) from song_results), '[]'::jsonb),
        'releases', coalesce((select jsonb_agg(release_results order by title) from release_results), '[]'::jsonb)
      );
      $function$
;
COMMIT;
