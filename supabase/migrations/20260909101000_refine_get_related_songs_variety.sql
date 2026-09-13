-- Refinement of get_related_songs (20260909100100), found while verifying it
-- against real data.
--
-- The first version ordered by tier, then views, then title. Because most
-- recordings carry views = 0, the ranking collapsed to alphabetical after the
-- first few rows, and nothing stopped one artist from filling the rail: the
-- seed "14 Fevrier (Feat. Cocolo-RD)" returned Natti Natasha four times,
-- followed by an A-to-Z run ("1 DE NOVIEMBRE", "7 siente", "About Me",
-- "Aerofobia", "Aguanta", ...). That reads as arbitrary rather than related.
--
-- This version keeps one recording per artist -- each artist's strongest match
-- -- so the rail shows twelve different artists working in the same genre
-- space. Tier (subgenre match before genre match) and views still drive the
-- order; the title tiebreaker now only separates artists with equal standing
-- rather than dictating most of the list.

CREATE OR REPLACE FUNCTION public.get_related_songs(song_id uuid)
RETURNS TABLE (
  id          uuid,
  title       text,
  artist_name text,
  artist_id   uuid
)
LANGUAGE sql
STABLE
SET search_path = public, pg_catalog
AS $$
  WITH seed AS (
    SELECT r.id, r.genre_id, r.subgenre_id, r.artist_id
    FROM public.recordings r
    WHERE r.id = song_id
  ),
  candidates AS (
    SELECT
      r.id,
      r.title,
      a.name AS artist_name,
      r.artist_id,
      CASE
        WHEN s.subgenre_id IS NOT NULL AND r.subgenre_id = s.subgenre_id THEN 0
        ELSE 1
      END AS tier,
      COALESCE(r.views, 0) AS views
    FROM public.recordings r
    JOIN public.artists a
      ON a.id = r.artist_id
     AND a.status = 'published'
    CROSS JOIN seed s
    WHERE r.id <> s.id
      AND r.artist_id IS NOT NULL
      AND r.artist_id IS DISTINCT FROM s.artist_id
      AND (
        (s.subgenre_id IS NOT NULL AND r.subgenre_id = s.subgenre_id)
        OR
        (s.genre_id IS NOT NULL AND r.genre_id = s.genre_id)
      )
  ),
  one_per_artist AS (
    SELECT DISTINCT ON (c.artist_id) c.*
    FROM candidates c
    ORDER BY c.artist_id, c.tier, c.views DESC, c.title ASC
  )
  SELECT o.id, o.title, o.artist_name, o.artist_id
  FROM one_per_artist o
  ORDER BY o.tier, o.views DESC, o.title ASC
  LIMIT 12;
$$;

COMMENT ON FUNCTION public.get_related_songs(uuid) IS
  'Songs in the same subgenre/genre as the seed recording, one per artist, by artists other than the seed''s. Backs the Related Songs rail on /songs/[slug]. Subgenre matches rank above genre matches; the seed artist is excluded because the page renders their catalogue separately.';

GRANT EXECUTE ON FUNCTION public.get_related_songs(uuid) TO PUBLIC;
GRANT EXECUTE ON FUNCTION public.get_related_songs(uuid) TO anon, authenticated, service_role;

-- DOWN (manual rollback): re-apply 20260909100100.

INSERT INTO supabase_migrations.schema_migrations (version, name)
VALUES ('20260909101000', 'refine_get_related_songs_variety')
ON CONFLICT (version) DO NOTHING;
