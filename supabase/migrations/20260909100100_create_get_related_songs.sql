-- Fix: get_related_songs() was called 12026 times a day and did not exist.
--
-- src/lib/queries/songs.ts:387 calls supabase.rpc("get_related_songs", ...)
-- from the song page server component. The function was never created in any
-- migration or by hand, so PostgREST returned 404 on every call. The client
-- does `if (error) return []`, so the section rendered empty instead of
-- erroring and the break was silent. Those 12026 daily 404s were essentially
-- the site's entire 404 volume.
--
-- Contract required by the caller (RelatedSongRecord minus slug, which the
-- client resolves separately from recordings):
--   id uuid, title text, artist_name text, artist_id uuid
--
-- Editorial definition of "related" used here:
--   Same subgenre is a stronger signal than same genre, so subgenre matches
--   rank first. The seed recording's own artist is excluded on purpose -- the
--   song page already renders a separate "more songs by this artist" rail
--   (getMoreSongsByArtist), and repeating that catalogue here would make the
--   two sections duplicates of each other. Related therefore means: other
--   Dominican artists working in the same genre space.
--
-- Visibility: SECURITY INVOKER, so artists_public_select and
-- recordings_public_select apply to the caller as usual. The explicit
-- status = 'published' predicate keeps the result identical when the function
-- is called with the service role, which bypasses RLS.

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
  )
  SELECT
    r.id,
    r.title,
    a.name AS artist_name,
    r.artist_id
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
  ORDER BY
    CASE
      WHEN s.subgenre_id IS NOT NULL AND r.subgenre_id = s.subgenre_id THEN 0
      ELSE 1
    END,
    COALESCE(r.views, 0) DESC,
    r.title ASC
  LIMIT 12;
$$;

COMMENT ON FUNCTION public.get_related_songs(uuid) IS
  'Songs in the same subgenre/genre as the seed recording, by other artists. Backs the Related Songs rail on /songs/[slug]. Subgenre matches rank above genre matches; the seed artist is excluded because the page renders their catalogue separately.';

REVOKE ALL ON FUNCTION public.get_related_songs(uuid) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.get_related_songs(uuid) TO anon, authenticated, service_role;

-- DOWN (manual rollback):
--   DROP FUNCTION IF EXISTS public.get_related_songs(uuid);
