-- Version allocated by Supabase apply_migration on 2026-11-20 UTC.
-- Additive artist URL history. Existing artists policies continue to apply.
-- Apply before deploying the URL resolver. Change public slugs after deployment.
ALTER TABLE public.artists
  ADD COLUMN IF NOT EXISTS slug_history text[] NOT NULL DEFAULT '{}';

CREATE INDEX IF NOT EXISTS artists_slug_history_gin
  ON public.artists USING gin (slug_history);

CREATE FUNCTION public.preserve_artist_slug_history()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
  previous_slugs text[] := '{}';
BEGIN
  IF TG_OP = 'UPDATE' THEN
    IF NEW.slug IS NOT DISTINCT FROM OLD.slug
       AND NEW.slug_history IS NOT DISTINCT FROM OLD.slug_history THEN
      RETURN NEW;
    END IF;
    previous_slugs := OLD.slug_history;
    IF OLD.slug IS DISTINCT FROM NEW.slug AND OLD.slug IS NOT NULL THEN
      previous_slugs := array_append(previous_slugs, OLD.slug);
    END IF;
  END IF;

  -- Serialize URL ownership changes, including claims of historical slugs.
  PERFORM pg_catalog.pg_advisory_xact_lock(179431, 1);
  IF NEW.slug IS NULL OR btrim(NEW.slug) = '' THEN
    RAISE EXCEPTION 'An artist URL slug cannot be empty.' USING ERRCODE = '23514';
  END IF;

  SELECT coalesce(array_agg(DISTINCT candidate ORDER BY candidate), '{}')
    INTO NEW.slug_history
    FROM unnest(previous_slugs || coalesce(NEW.slug_history, '{}')) AS history(candidate)
    WHERE candidate IS NOT NULL AND candidate <> NEW.slug AND candidate <> '';

  IF EXISTS (
    SELECT 1 FROM unnest(NEW.slug_history) AS history(candidate)
    WHERE candidate <> btrim(candidate) OR candidate ~ '[/#?]'
  ) THEN
    RAISE EXCEPTION 'Historical slugs must contain only the slug, without a URL or path.'
      USING ERRCODE = '23514';
  END IF;

  IF EXISTS (
    SELECT 1 FROM public.artists a
    WHERE a.id <> NEW.id AND (
      a.slug = NEW.slug
      OR a.slug_history @> ARRAY[NEW.slug]
      OR NEW.slug_history @> ARRAY[a.slug]
      OR a.slug_history && NEW.slug_history
    )
  ) THEN
    RAISE EXCEPTION 'This artist URL is already reserved by another artist.'
      USING ERRCODE = '23505';
  END IF;
  RETURN NEW;
END;
$$;

-- Run after artists_slug_trigger, which fills a new artist's initial slug.
CREATE TRIGGER zz_artists_preserve_slug_history
  BEFORE INSERT OR UPDATE OF slug, name, slug_history ON public.artists
  FOR EACH ROW EXECUTE FUNCTION public.preserve_artist_slug_history();

COMMENT ON COLUMN public.artists.slug_history IS
  'Previous URL slugs reserved to this artist UUID. Preserve indefinitely. Public redirects resolve directly to the current slug of a published artist.';
