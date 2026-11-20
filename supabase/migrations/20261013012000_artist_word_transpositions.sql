-- Review only: apply to staging first. Preserves global_search signature,
-- invoker behavior, existing search_path, publication rules and all indexes.
-- search_normalize is deliberately unchanged. Final ranking lives in the
-- application and runs on at most 120 candidates per category.
BEGIN;
CREATE OR REPLACE FUNCTION public.global_search(search_text text)
RETURNS jsonb LANGUAGE sql STABLE
SET search_path TO 'public', 'extensions'
AS $function$
WITH q AS MATERIALIZED (
  SELECT public.search_normalize(left(trim(search_text),80)) term
), tokens AS MATERIALIZED (
  SELECT word FROM q, unnest(string_to_array(q.term,' ')) word
  WHERE length(word)>=3 AND word <> ALL(ARRAY['quien','quienes','que','cual','cuales','como','donde','cuando','son','los','las','del','una','por','para','padre','padres','dibujo','who','what','which','how','where','when','are','the','for','and','drawing'])
  GROUP BY word ORDER BY length(word) DESC,word LIMIT 8
), terms AS MATERIALIZED (
  SELECT term FROM q WHERE length(term)>=3 UNION SELECT word FROM tokens
), artist_hits AS MATERIALIZED (
  SELECT a.id FROM terms x CROSS JOIN LATERAL (
    SELECT a.id FROM artists a WHERE a.status='published'
      AND public.search_normalize(a.name) LIKE '%'||x.term||'%'
    ORDER BY (public.search_normalize(a.name)=x.term) DESC,a.name,a.id LIMIT 40
  ) a
  UNION ALL
  SELECT a.id FROM q CROSS JOIN LATERAL (
    SELECT a.id FROM artists a WHERE a.status='published' AND length(q.term)>=4
      AND NOT EXISTS(SELECT 1 FROM artists exact WHERE exact.status='published' AND public.search_normalize(exact.name) LIKE '%'||q.term||'%')
      AND public.search_normalize(a.name) OPERATOR(extensions.%) q.term
    ORDER BY extensions.similarity(public.search_normalize(a.name),q.term) DESC,a.name,a.id LIMIT 40
  ) a
  UNION ALL
  -- One meaningful artist word: at most 23 adjacent swaps, 40 hits/path.
  -- Uses existing normalized trigram LIKE index, never a fuzzy table scan.
  SELECT a.id FROM q CROSS JOIN LATERAL (
    SELECT t.word FROM tokens t WHERE length(t.word) BETWEEN 5 AND 24
      AND (SELECT count(*) FROM tokens)=1
      AND NOT EXISTS(SELECT 1 FROM artists exact WHERE exact.status='published'
        AND public.search_normalize(exact.name) LIKE '%'||q.term||'%')
  ) t CROSS JOIN LATERAL (
    SELECT DISTINCT left(t.word,i-1)||substr(t.word,i+1,1)||substr(t.word,i,1)||substr(t.word,i+2) term
    FROM generate_series(1,length(t.word)-1) i WHERE substr(t.word,i,1)<>substr(t.word,i+1,1)
  ) variant CROSS JOIN LATERAL (
    SELECT a.id FROM artists a WHERE a.status='published'
      AND public.search_normalize(a.name) LIKE '%'||variant.term||'%'
      AND (' '||public.search_normalize(a.name)||' ') LIKE '% '||variant.term||' %'
    ORDER BY a.name,a.id LIMIT 40
  ) a
  UNION ALL
  -- The artist catalog is small. Aliases are exact/token candidates only;
  -- no similarity scan over artist aliases or the recording catalog.
  SELECT a.id FROM artists a,q WHERE a.status='published' AND q.term<>'' AND (
    (length(q.term)=2 AND public.search_normalize(a.name) LIKE q.term||'%') OR
    EXISTS(SELECT 1 FROM unnest(a.aliases) alias WHERE public.search_normalize(alias)=q.term
      OR (length(q.term)=2 AND public.search_normalize(alias) LIKE q.term||'%')
      OR EXISTS(SELECT 1 FROM tokens t WHERE public.search_normalize(alias) LIKE '%'||t.word||'%'))
  )
), artist_ids AS MATERIALIZED (
  SELECT h.id,count(*) hits FROM artist_hits h JOIN artists a ON a.id=h.id CROSS JOIN q
  GROUP BY h.id,a.name,a.aliases,q.term
  ORDER BY (public.search_normalize(a.name)=q.term) DESC,
    (q.term=ANY(SELECT public.search_normalize(alias) FROM unnest(a.aliases) alias)) DESC,count(*) DESC,h.id LIMIT 120
), recording_hits AS MATERIALIZED (
  SELECT r.id FROM terms x CROSS JOIN LATERAL (
    SELECT r.id FROM recordings r WHERE public.search_normalize(r.title) LIKE '%'||x.term||'%'
    ORDER BY (public.search_normalize(r.title)=x.term) DESC,r.title,r.id LIMIT 40
  ) r
  UNION ALL
  SELECT r.id FROM q CROSS JOIN LATERAL (
    SELECT r.id FROM recordings r WHERE length(q.term)>=4
      AND NOT EXISTS(SELECT 1 FROM recordings exact WHERE public.search_normalize(exact.title) LIKE '%'||q.term||'%')
      AND public.search_normalize(r.title) OPERATOR(extensions.%) q.term
    ORDER BY extensions.similarity(public.search_normalize(r.title),q.term) DESC,r.title,r.id LIMIT 40
  ) r
  UNION ALL
  SELECT r.id FROM q CROSS JOIN LATERAL (
    SELECT r.id FROM recordings r WHERE length(q.term)=2
      AND to_tsvector('english',r.title) @@ plainto_tsquery('english',q.term)
    ORDER BY (public.search_normalize(r.title)=q.term) DESC,r.title,r.id LIMIT 40
  ) r
), recording_ids AS MATERIALIZED (
  SELECT h.id,count(*) hits FROM recording_hits h
  CROSS JOIN LATERAL (SELECT r.title FROM recordings r WHERE r.id=h.id OFFSET 0) r CROSS JOIN q
  GROUP BY h.id,r.title,q.term ORDER BY (public.search_normalize(r.title)=q.term) DESC,count(*) DESC,h.id LIMIT 120
), release_hits AS MATERIALIZED (
  SELECT r.id FROM terms x CROSS JOIN LATERAL (
    SELECT r.id FROM releases r WHERE public.search_normalize(r.title) LIKE '%'||x.term||'%'
    ORDER BY (public.search_normalize(r.title)=x.term) DESC,r.title,r.id LIMIT 40
  ) r
  UNION ALL
  SELECT r.id FROM q CROSS JOIN LATERAL (
    SELECT r.id FROM releases r WHERE length(q.term)>=4
      AND NOT EXISTS(SELECT 1 FROM releases exact WHERE public.search_normalize(exact.title) LIKE '%'||q.term||'%')
      AND public.search_normalize(r.title) OPERATOR(extensions.%) q.term
    ORDER BY extensions.similarity(public.search_normalize(r.title),q.term) DESC,r.title,r.id LIMIT 40
  ) r
  UNION ALL
  SELECT r.id FROM q CROSS JOIN LATERAL (
    SELECT r.id FROM releases r WHERE length(q.term)=2
      AND to_tsvector('english',r.title) @@ plainto_tsquery('english',q.term)
    ORDER BY (public.search_normalize(r.title)=q.term) DESC,r.title,r.id LIMIT 40
  ) r
), release_ids AS MATERIALIZED (
  SELECT h.id,count(*) hits FROM release_hits h
  CROSS JOIN LATERAL (SELECT r.title FROM releases r WHERE r.id=h.id OFFSET 0) r CROSS JOIN q
  GROUP BY h.id,r.title,q.term ORDER BY (public.search_normalize(r.title)=q.term) DESC,count(*) DESC,h.id LIMIT 120
), artist_results AS (
  SELECT 'artist' type,a.id::text id,a.name title,a.slug,a.aliases,
    null::text subtitle,null::integer AS year,null::text cover_url,i.hits
  FROM artist_ids i JOIN artists a ON a.id=i.id WHERE a.status='published'
), song_results AS (
  SELECT 'song' type,r.id::text id,r.title,r.slug,coalesce(a.name,edition.artist_name) subtitle,
    coalesce(r.recording_year,edition.year) AS year,
    CASE WHEN edition.release_id IS NOT NULL THEN 'https://srulenjahemkuxtkfmzt.supabase.co/storage/v1/object/public/cover-art/'||edition.release_id::text||'.webp' ELSE NULL END cover_url,i.hits
  FROM recording_ids i CROSS JOIN LATERAL (SELECT r.* FROM recordings r WHERE r.id=i.id OFFSET 0) r
  LEFT JOIN artists a ON a.id=r.artist_id AND a.status='published'
  LEFT JOIN LATERAL (
    SELECT rel.id release_id,ra.name artist_name,coalesce(rel.release_year,rel.year) AS year
    FROM tracks t JOIN releases rel ON rel.id=t.release_id
    LEFT JOIN artists ra ON ra.id=rel.release_artist_id AND ra.status='published'
    WHERE t.recording_id=r.id ORDER BY (ra.id IS NOT NULL) DESC,coalesce(rel.release_year,rel.year) NULLS LAST,rel.id LIMIT 1
  ) edition ON true
  WHERE r.artist_id IS NULL OR a.id IS NOT NULL OR edition.artist_name IS NOT NULL
), release_results AS (
  SELECT 'release' type,r.id::text id,r.title,r.slug,a.name subtitle,
    coalesce(r.release_year,r.year) AS year,null::text cover_url,i.hits
  FROM release_ids i CROSS JOIN LATERAL (SELECT r.* FROM releases r WHERE r.id=i.id OFFSET 0) r
  JOIN artists a ON a.id=r.release_artist_id AND a.status='published'
)
SELECT jsonb_build_object(
  'artists',coalesce((SELECT jsonb_agg(to_jsonb(a)-'hits' ORDER BY hits DESC,title,id) FROM artist_results a),'[]'::jsonb),
  'songs',coalesce((SELECT jsonb_agg(to_jsonb(s)-'hits' ORDER BY hits DESC,title,id) FROM song_results s),'[]'::jsonb),
  'releases',coalesce((SELECT jsonb_agg(to_jsonb(r)-'hits' ORDER BY hits DESC,title,id) FROM release_results r),'[]'::jsonb)
);
$function$;
COMMIT;
