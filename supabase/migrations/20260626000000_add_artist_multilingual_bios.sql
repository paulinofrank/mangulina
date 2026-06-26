ALTER TABLE public.artists
  ADD COLUMN IF NOT EXISTS bio_en text,
  ADD COLUMN IF NOT EXISTS bio_es text;

UPDATE public.artists
SET bio_en = bio
WHERE bio_en IS NULL
  AND bio IS NOT NULL
  AND trim(bio) <> '';
