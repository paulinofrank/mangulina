BEGIN;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM public.genres
    WHERE slug = 'fusion-tropical'
      AND active = true
  ) THEN
    RAISE EXCEPTION 'The active Fusion / Tropical genre is missing';
  END IF;
END
$$;

UPDATE public.artists
SET primary_genre = 'fusion-tropical',
    genres = array_remove(COALESCE(genres, ARRAY[]::text[]), 'ballads-singer-songwriter'),
    updated_at = now()
WHERE primary_genre = 'ballads-singer-songwriter';

UPDATE public.artists
SET genres = array_remove(genres, 'ballads-singer-songwriter'),
    updated_at = now()
WHERE genres @> ARRAY['ballads-singer-songwriter']::text[];

DELETE FROM public.genres
WHERE slug = 'ballads-singer-songwriter'
  AND name = 'Singer-Songwriter';

COMMIT;
