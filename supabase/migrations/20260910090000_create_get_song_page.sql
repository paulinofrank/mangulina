-- PROPOSED -- NOT APPLIED. Written for review.
--
-- get_song_page(song_slug, bio_locale): one call in place of the query storm a
-- song page currently issues.
--
-- ============================================================================
-- What the page does today
-- ============================================================================
-- src/app/[locale]/songs/[slug]/page.tsx, traced through src/lib/queries/songs.ts:
--
--   getSongBySlug            recordings by slug                          1
--     -> isPublicRecording   recordings, releases, artists          up to 3
--     -> getSongById         recordings_with_release_info                1
--                            releases (slug, has_cover_image)            1
--     -> getRecordingEditorial  recording_editorial                      1
--   [Promise.all]
--     getSongCredits         rpc get_public_recording_credits            1
--     getSongFunFacts        recording_fun_facts                         1
--     getSongSlang           recording_expressions + expressions         1
--     getSongSources         recording_sources + sources                 1
--     getSongMedia           recording_media + sources                   1
--     getRelatedSongs        rpc + artists + recordings (slugs)          3
--     getSongPlatformLinks   recording_platform_links                    1
--     getMoreSongsByArtist   view + releases + recordings (slugs)        3
--     artist preview         artists                                     1
--   getPublishedEditorialPlainText  3 queries, service-role client       3
--
-- Roughly 19-24 queries per render, at a critical-path depth near ten. The
-- first six are strictly sequential: nothing else can start until the slug
-- resolves and the visibility gate passes.
--
-- This function returns all of it except the biography as one jsonb document,
-- taking the page to 1 + 3.
--
-- ============================================================================
-- Why the biography is deliberately NOT in here
-- ============================================================================
-- getPublishedEditorialPlainText runs on the SERVICE ROLE client
-- (src/lib/editorial/publicData.ts), reads editorial_documents and
-- editorial_entity_references, and then resolves the document to plain text in
-- TypeScript (editorialDocumentToPlainText).
--
-- Folding it in would mean exposing editorial documents through an
-- anon-callable RPC. That is a security decision, not a performance one, and it
-- does not belong inside an optimization. It stays on its own path.
--
-- ============================================================================
-- Behavioural parity
-- ============================================================================
-- * Visibility gate is the same rule as getPublicRecordingIds: a recording is
--   public when its owner -- recordings.artist_id, else the release's
--   release_artist_id -- is null or belongs to a published artist. Returns NULL
--   for a recording that fails it, which the caller maps to notFound().
-- * The UUID fallback in getSongBySlug is preserved: a slug that is not found
--   but parses as a UUID is retried as an id.
-- * The editorial overlay applies in the same precedence order as
--   applyEditorial(): story -> song_about, inspiration -> inspiration,
--   cultural_significance ?? historical_context -> cultural_context,
--   notes -> notes. jsonb_strip_nulls keeps a NULL editorial column from
--   overwriting a value the view already supplied, matching the ?? chain.
-- * Ordering in every collection matches the .order() chains in songs.ts,
--   including nullsFirst/nullsLast placement.
-- * Empty collections come back as [] and not null, so the caller needs no
--   coalescing.
-- * related uses get_related_songs and joins recordings for slug, which removes
--   the two follow-up queries the client makes today. Its published-artist
--   filter is already applied inside that function, so the client-side
--   getPublishedArtistIds pass becomes redundant.
--
-- SECURITY INVOKER: every table read here is already readable by anon under its
-- own policy, and RLS continues to apply to the caller as it does now. The one
-- exception is the credits RPC, which is SECURITY DEFINER today and is called
-- here exactly as the page calls it.

CREATE OR REPLACE FUNCTION public.get_song_page(
  song_slug  text,
  bio_locale text DEFAULT 'en'
)
RETURNS jsonb
LANGUAGE plpgsql
STABLE
SET search_path = public, pg_catalog
AS $fn$
DECLARE
  rec_id    uuid;
  owner_id  uuid;
  v_artist  uuid;
  v_release uuid;
BEGIN
  -- ---- resolve slug -> recording id (UUID fallback preserved) -------------
  SELECT r.id INTO rec_id FROM public.recordings r WHERE r.slug = song_slug;

  IF rec_id IS NULL
     AND song_slug ~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
  THEN
    SELECT r.id INTO rec_id FROM public.recordings r WHERE r.id = song_slug::uuid;
  END IF;

  IF rec_id IS NULL THEN
    RETURN NULL;
  END IF;

  -- ---- visibility gate ----------------------------------------------------
  SELECT r.artist_id,
         r.release_id,
         COALESCE(r.artist_id, rel.release_artist_id)
    INTO v_artist, v_release, owner_id
  FROM public.recordings r
  LEFT JOIN public.releases rel ON rel.id = r.release_id
  WHERE r.id = rec_id;

  IF owner_id IS NOT NULL
     AND NOT EXISTS (
       SELECT 1 FROM public.artists a
       WHERE a.id = owner_id AND a.status = 'published'
     )
  THEN
    RETURN NULL;
  END IF;

  -- ---- assemble -----------------------------------------------------------
  RETURN jsonb_build_object(

    'song', (
      SELECT to_jsonb(v.*)
             || jsonb_build_object(
                  'release_slug',    rel.slug,
                  'has_cover_image', COALESCE(rel.has_cover_image, false)
                )
             || CASE WHEN ed.recording_id IS NULL THEN '{}'::jsonb ELSE
                  jsonb_strip_nulls(jsonb_build_object(
                    'song_about',       ed.story,
                    'inspiration',      ed.inspiration,
                    'cultural_context', COALESCE(ed.cultural_significance, ed.historical_context),
                    'notes',            ed.notes
                  ))
                END
      FROM public.recordings_with_release_info v
      LEFT JOIN public.releases rel           ON rel.id = v.release_id
      LEFT JOIN public.recording_editorial ed ON ed.recording_id = v.recording_id
      WHERE v.recording_id = rec_id
    ),

    'artist', (
      SELECT to_jsonb(a2)
      FROM (
        SELECT a.id, a.slug, a.name, a.has_image, a.image_updated_at, a.views
        FROM public.artists a
        WHERE a.id = v_artist AND a.status = 'published'
      ) a2
    ),

    'credits', COALESCE(
      (SELECT jsonb_agg(to_jsonb(c))
       FROM public.get_public_recording_credits(rec_id) c),
      '[]'::jsonb),

    'fun_facts', COALESCE((
      SELECT jsonb_agg(to_jsonb(f) ORDER BY f.display_order NULLS LAST, f.id)
      FROM public.recording_fun_facts f
      WHERE f.recording_id = rec_id
    ), '[]'::jsonb),

    'slang', COALESCE((
      SELECT jsonb_agg(
               to_jsonb(re)
               || jsonb_build_object('expression', (
                    SELECT to_jsonb(e2) FROM (
                      SELECT e.id, e.term, e.definition, e.example, e.notes
                      FROM public.expressions e
                      WHERE e.id = re.expression_id
                    ) e2))
               ORDER BY re.display_order NULLS LAST, re.id)
      FROM public.recording_expressions re
      WHERE re.recording_id = rec_id
    ), '[]'::jsonb),

    'sources', COALESCE((
      SELECT jsonb_agg(
               jsonb_build_object(
                 'id',           rs.id,
                 'recording_id', rs.recording_id,
                 'source_usage', rs.source_usage,
                 'source', (
                   SELECT to_jsonb(s2) FROM (
                     SELECT s.id, s.title, s.source_type, s.author, s.publisher,
                            s.url, s.publication_date, s.notes
                     FROM public.sources s WHERE s.id = rs.source_id
                   ) s2)
               ) ORDER BY rs.id)
      FROM public.recording_sources rs
      WHERE rs.recording_id = rec_id
    ), '[]'::jsonb),

    'media', COALESCE((
      SELECT jsonb_agg(
               to_jsonb(rm)
               || jsonb_build_object('source', (
                    SELECT to_jsonb(s2) FROM (
                      SELECT s.id, s.title, s.url
                      FROM public.sources s WHERE s.id = rm.source_id
                    ) s2))
               ORDER BY rm.is_primary DESC NULLS LAST,
                        rm.display_order NULLS LAST,
                        rm.id)
      FROM public.recording_media rm
      WHERE rm.recording_id = rec_id
    ), '[]'::jsonb),

    'platform_links', COALESCE((
      SELECT jsonb_agg(
               jsonb_build_object(
                 'id',            pl.id,
                 'platform',      pl.platform,
                 'url',           pl.url,
                 'label',         pl.label,
                 'link_type',     pl.link_type,
                 'display_order', pl.display_order)
               ORDER BY pl.display_order, pl.platform)
      FROM public.recording_platform_links pl
      WHERE pl.recording_id = rec_id
        AND pl.status IN ('approved_manual', 'approved_auto', 'approved')
    ), '[]'::jsonb),

    'related', COALESCE((
      SELECT jsonb_agg(
               jsonb_build_object(
                 'id',          g.id,
                 'slug',        r.slug,
                 'title',       g.title,
                 'artist_name', g.artist_name,
                 'artist_id',   g.artist_id))
      FROM public.get_related_songs(rec_id) g
      LEFT JOIN public.recordings r ON r.id = g.id
    ), '[]'::jsonb),

    'more_by_artist', COALESCE((
      SELECT jsonb_agg(
               jsonb_build_object(
                 'id',                  m.recording_id,
                 'slug',                mr.slug,
                 'title',               m.recording_title,
                 'artist_name',         m.artist_name,
                 'release_id',          m.release_id,
                 'has_cover_image',     COALESCE(mrel.has_cover_image, false),
                 'release_year_actual', m.release_year_actual,
                 'views',               m.views)
               ORDER BY m.views DESC NULLS LAST)
      FROM (
        SELECT v.recording_id, v.recording_title, v.artist_name, v.release_id,
               v.release_year_actual, v.views
        FROM public.recordings_with_release_info v
        WHERE v.artist_id = v_artist
          AND v.recording_id <> rec_id
        ORDER BY v.views DESC NULLS LAST
        LIMIT 12
      ) m
      LEFT JOIN public.recordings mr   ON mr.id   = m.recording_id
      LEFT JOIN public.releases   mrel ON mrel.id = m.release_id
    ), '[]'::jsonb),

    'bio_locale', to_jsonb(bio_locale)
  );
END;
$fn$;

COMMENT ON FUNCTION public.get_song_page(text, text) IS
  'Everything a song page renders, in one call: song row with editorial overlay, artist preview, credits, fun facts, slang, sources, media, platform links, related songs and more-by-artist. Returns NULL when the recording is not publicly visible. The artist biography is deliberately excluded -- it reads editorial_documents through the service-role client and resolves in TypeScript.';

GRANT EXECUTE ON FUNCTION public.get_song_page(text, text) TO PUBLIC;
GRANT EXECUTE ON FUNCTION public.get_song_page(text, text) TO anon, authenticated, service_role;

-- DOWN (manual rollback):
--   DROP FUNCTION IF EXISTS public.get_song_page(text, text);
