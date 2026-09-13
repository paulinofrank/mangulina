-- Fix: release_artists was invisible to every public reader.
--
-- The policy release_artists_select_published required
--   releases.status = 'published'
-- but releases.status does not hold an editorial publish state. It holds the
-- MusicBrainz release status: Official (3096), NULL (56), Promotion (6),
-- Bootleg (4), Withdrawn (1). Nothing has ever equalled 'published', so the
-- policy matched zero rows and anon could not read a single release_artists
-- row -- all 3163 of them, always.
--
-- Consequences observed in production:
--   * getReleaseArtistInfo() (src/lib/releaseApi.ts) always fell through to the
--     legacy releases.release_artist_id branch, which returns credited_as NULL.
--     All 3163 credited_as values -- the historical credit text this project
--     exists to preserve -- have never rendered on a page.
--   * The .single() on the always-empty result produced ~1484 PostgREST 406s
--     per day.
--
-- The 'published' convention belongs to artists.status, not releases.status.
-- The parent table's own policy (releases_public_select) is USING (true): every
-- release row is already publicly readable. Gating the artist link more tightly
-- than the release it belongs to grants nothing and hides everything, so this
-- restores release_artists to exactly the visibility its parent already has.
-- Per-artist visibility is still enforced by artists_public_select
-- (status = 'published') through the join, and in application code by
-- getPublishedArtistIds()/isPublicReleaseArtist().
--
-- Reversible: the original policy is restored by the DOWN block at the bottom.

DROP POLICY IF EXISTS release_artists_select_published ON public.release_artists;

CREATE POLICY release_artists_public_select
  ON public.release_artists
  FOR SELECT
  TO anon, authenticated
  USING (true);

-- DOWN (manual rollback):
--   DROP POLICY IF EXISTS release_artists_public_select ON public.release_artists;
--   CREATE POLICY release_artists_select_published ON public.release_artists
--     FOR SELECT USING (EXISTS (
--       SELECT 1 FROM public.releases
--       WHERE releases.id = release_artists.release_id
--         AND releases.status = 'published'));
