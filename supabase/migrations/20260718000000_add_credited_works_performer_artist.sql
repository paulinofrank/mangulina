-- Add an optional structured performer identity while preserving the historical
-- performer_text snapshot used by existing Works & Credits presentation.
BEGIN;

ALTER TABLE public.credited_works
  ADD COLUMN IF NOT EXISTS performer_artist_id uuid NULL
  REFERENCES public.artists(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_credited_works_performer_artist_id
  ON public.credited_works(performer_artist_id);

COMMENT ON COLUMN public.credited_works.performer_artist_id IS
  'Optional canonical Mangulina performer. Independent from creator credits; performer_text remains the historical display credit.';

COMMIT;

-- Rollback:
-- DROP INDEX IF EXISTS public.idx_credited_works_performer_artist_id;
-- ALTER TABLE public.credited_works DROP COLUMN IF EXISTS performer_artist_id;
