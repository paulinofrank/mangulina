-- Normalizes primary_genre, genres, and artist_tags for 52 urban artists.
-- Enforces that 'urbano' is an umbrella category, not a primary genre.
-- Preserves Christian context in artist_tags, maps to specific musical subgenres,
-- and cleans up field hygiene so primary_genre never repeats in genres[].
BEGIN;

SELECT pg_advisory_xact_lock(hashtext('mangulina-urban-artist-genre-normalization-20261110'));

-- Safety backup snapshot before update
CREATE TABLE IF NOT EXISTS public.artists_backup_before_urban_genre_update_20261110 AS
SELECT id, slug, primary_genre, genres, artist_tags, updated_at
FROM public.artists
WHERE slug IN (
  '23thierno', 'alex-linares', 'anmily', 'brayan-booz', 'candelario', 'chris-lebron',
  'cocolo-rd', 'cromo-x', 'daniel-checo', 'dary-hezz', 'david-appleton', 'don-miguelo',
  'donny-whey', 'el-cherry-scom', 'haraca-kiko', 'hennessy', 'jezzy', 'kendall-hill',
  'king-caballero', 'la-materialista', 'lapiz-conciente', 'madiel-lara', 'mike-el-beta',
  'nico-clinico', 'reychesta-secret-weapon', 'akinohayley', 'alnastry', 'bryan-dotel',
  'chelo-home', 'chimbala', 'chris-alflow', 'donaty', 'el-cata', 'fortuna-la-super-f',
  'frecox-unic', 'jeffrey-henriquez-rijo', 'joly-sc', 'la-pajarita-la-paul',
  'luigui-bleand', 'luny-tunes', 'manny-pena-adpi', 'marielle-hazlo', 'mr-yeison',
  'musicologo-the-libro', 'rl-and-vanessa', 'rxelartista', 'sarah-la-profeta',
  'shecka-sanchez', 'vizkel', 'young-grin', 'bladimir-vasquez', 'mark-b'
);

WITH updates(slug, new_primary, new_genres, new_tags) AS (
  VALUES
    ('23thierno', 'urban-trap', ARRAY[]::text[], ARRAY['secular', 'emerging']::text[]),
    ('alex-linares', 'urban-reggaeton', ARRAY[]::text[], ARRAY['christian']::text[]),
    ('anmily', 'urban-reggaeton', ARRAY[]::text[], ARRAY['christian']::text[]),
    ('brayan-booz', 'urban-trap', ARRAY[]::text[], ARRAY['christian']::text[]),
    ('candelario', 'urban-reggaeton', ARRAY[]::text[], ARRAY['christian']::text[]),
    ('chris-lebron', 'urban-reggaeton', ARRAY[]::text[], ARRAY['secular']::text[]),
    ('cocolo-rd', 'urban-rap-hip-hop', ARRAY['urban-dembow']::text[], ARRAY['secular', 'emerging']::text[]),
    ('cromo-x', 'urban-trap', ARRAY['urban-reggaeton', 'urban-dembow', 'urban-rap-hip-hop']::text[], ARRAY['secular']::text[]),
    ('daniel-checo', 'fusion', ARRAY['urban-reggaeton']::text[], ARRAY['secular']::text[]),
    ('dary-hezz', 'urban-reggaeton', ARRAY['urban-dembow']::text[], ARRAY['secular', 'emerging']::text[]),
    ('david-appleton', 'fusion', ARRAY[]::text[], ARRAY['secular', 'instrumental']::text[]),
    ('don-miguelo', 'urban-dembow', ARRAY['urban-reggaeton']::text[], ARRAY['secular']::text[]),
    ('donny-whey', 'urban-dembow', ARRAY[]::text[], ARRAY['secular', 'emerging']::text[]),
    ('el-cherry-scom', 'urban-dembow', ARRAY['urban-reggaeton']::text[], ARRAY['secular']::text[]),
    ('haraca-kiko', 'urban-dembow', ARRAY[]::text[], ARRAY['secular']::text[]),
    ('hennessy', 'urban-reggaeton', ARRAY['urban-trap']::text[], ARRAY['christian', 'emerging']::text[]),
    ('jezzy', 'urban-dembow', ARRAY[]::text[], ARRAY['secular']::text[]),
    ('kendall-hill', 'urban-rap-hip-hop', ARRAY['worship-gospel']::text[], ARRAY['christian', 'emerging']::text[]),
    ('king-caballero', 'urban-reggaeton', ARRAY[]::text[], ARRAY['secular']::text[]),
    ('la-materialista', 'urban-dembow', ARRAY[]::text[], ARRAY['secular']::text[]),
    ('lapiz-conciente', 'urban-rap-hip-hop', ARRAY[]::text[], ARRAY['secular', 'legend']::text[]),
    ('madiel-lara', 'urban-trap', ARRAY[]::text[], ARRAY['christian', 'latin_trap', 'producer', 'grammy_winner']::text[]),
    ('mike-el-beta', 'urban-reggaeton', ARRAY[]::text[], ARRAY['secular']::text[]),
    ('nico-clinico', 'urban-dembow', ARRAY['urban-reggaeton']::text[], ARRAY['secular']::text[]),
    ('reychesta-secret-weapon', 'urban-rap-hip-hop', ARRAY['urban-trap', 'urban-reggaeton']::text[], ARRAY['secular']::text[]),
    ('akinohayley', 'urban-rap-hip-hop', ARRAY['urban-dembow']::text[], ARRAY['secular', 'emerging']::text[]),
    ('alnastry', 'urban-rap-hip-hop', ARRAY[]::text[], ARRAY['secular', 'emerging']::text[]),
    ('bryan-dotel', 'merengue-urbano', ARRAY[]::text[], ARRAY['secular', 'emerging']::text[]),
    ('chelo-home', 'urban-rap-hip-hop', ARRAY[]::text[], ARRAY['christian']::text[]),
    ('chimbala', 'urban-dembow', ARRAY['urban-reggaeton']::text[], ARRAY['secular']::text[]),
    ('chris-alflow', 'urban-reggaeton', ARRAY['urban-dembow']::text[], ARRAY['secular']::text[]),
    ('donaty', 'urban-dembow', ARRAY[]::text[], ARRAY['secular']::text[]),
    ('el-cata', 'merengue-urbano', ARRAY['urban-rap-hip-hop']::text[], ARRAY['secular', 'legend']::text[]),
    ('fortuna-la-super-f', 'merengue-urbano', ARRAY['urban-reggaeton']::text[], ARRAY['secular']::text[]),
    ('frecox-unic', 'urban-dembow', ARRAY[]::text[], ARRAY['secular']::text[]),
    ('jeffrey-henriquez-rijo', 'urban-reggaeton', ARRAY[]::text[], ARRAY['secular', 'emerging']::text[]),
    ('joly-sc', 'urban-reggaeton', ARRAY['urban-rap-hip-hop', 'urban-dembow']::text[], ARRAY['secular', 'emerging']::text[]),
    ('la-pajarita-la-paul', 'urban-dembow', ARRAY[]::text[], ARRAY['secular']::text[]),
    ('luigui-bleand', 'urban-reggaeton', ARRAY['urban-rap-hip-hop', 'reggae']::text[], ARRAY['secular']::text[]),
    ('luny-tunes', 'urban-reggaeton', ARRAY[]::text[], ARRAY['secular', 'legend']::text[]),
    ('manny-pena-adpi', 'urban-reggaeton', ARRAY[]::text[], ARRAY['secular', 'emerging']::text[]),
    ('marielle-hazlo', 'urban-reggaeton', ARRAY[]::text[], ARRAY['secular']::text[]),
    ('mr-yeison', 'urban-rap-hip-hop', ARRAY['urban-dembow']::text[], ARRAY['christian']::text[]),
    ('musicologo-the-libro', 'urban-dembow', ARRAY['urban-reggaeton', 'urban-rap-hip-hop']::text[], ARRAY['secular']::text[]),
    ('rl-and-vanessa', 'urban-reggaeton', ARRAY['merengue-urbano', 'urban-rap-hip-hop']::text[], ARRAY['christian', 'duo']::text[]),
    ('rxelartista', 'bachata', ARRAY[]::text[], ARRAY['secular', 'emerging']::text[]),
    ('sarah-la-profeta', 'urban-rap-hip-hop', ARRAY[]::text[], ARRAY['christian', 'pioneer']::text[]),
    ('shecka-sanchez', 'urban-rap-hip-hop', ARRAY['urban-trap']::text[], ARRAY['secular']::text[]),
    ('vizkel', 'urban-rap-hip-hop', ARRAY['merengue-house']::text[], ARRAY['secular']::text[]),
    ('young-grin', 'urban-rap-hip-hop', ARRAY['urban-trap']::text[], ARRAY['secular']::text[]),
    ('bladimir-vasquez', 'urban-reggaeton', ARRAY[]::text[], ARRAY['secular', 'diaspora']::text[]),
    ('mark-b', 'urban-dembow', ARRAY[]::text[], ARRAY['secular']::text[])
)
UPDATE public.artists a
SET primary_genre = u.new_primary,
    genres = u.new_genres,
    artist_tags = u.new_tags,
    updated_at = now()
FROM updates u
WHERE a.slug = u.slug
  AND (
    a.primary_genre IS DISTINCT FROM u.new_primary
    OR a.genres IS DISTINCT FROM u.new_genres
    OR a.artist_tags IS DISTINCT FROM u.new_tags
  );

-- Validation Check 1: Ensure zero artists have primary_genre = 'urbano' in this cohort
DO $$
DECLARE
  urbano_count integer;
BEGIN
  SELECT count(*) INTO urbano_count
  FROM public.artists
  WHERE slug IN (
    '23thierno', 'alex-linares', 'anmily', 'brayan-booz', 'candelario', 'chris-lebron',
    'cocolo-rd', 'cromo-x', 'daniel-checo', 'dary-hezz', 'david-appleton', 'don-miguelo',
    'donny-whey', 'el-cherry-scom', 'haraca-kiko', 'hennessy', 'jezzy', 'kendall-hill',
    'king-caballero', 'la-materialista', 'lapiz-conciente', 'madiel-lara', 'mike-el-beta',
    'nico-clinico', 'reychesta-secret-weapon', 'akinohayley', 'alnastry', 'bryan-dotel',
    'chelo-home', 'chimbala', 'chris-alflow', 'donaty', 'el-cata', 'fortuna-la-super-f',
    'frecox-unic', 'jeffrey-henriquez-rijo', 'joly-sc', 'la-pajarita-la-paul',
    'luigui-bleand', 'luny-tunes', 'manny-pena-adpi', 'marielle-hazlo', 'mr-yeison',
    'musicologo-the-libro', 'rl-and-vanessa', 'rxelartista', 'sarah-la-profeta',
    'shecka-sanchez', 'vizkel', 'young-grin', 'bladimir-vasquez', 'mark-b'
  ) AND primary_genre = 'urbano';

  IF urbano_count > 0 THEN
    RAISE EXCEPTION 'Validation failure: % artists still have generic primary_genre = urbano', urbano_count;
  END IF;
END $$;

-- Validation Check 2: Field Hygiene (no repetition of primary_genre in genres[]) for this cohort
DO $$
DECLARE
  hygiene_violations integer;
BEGIN
  SELECT count(*) INTO hygiene_violations
  FROM public.artists
  WHERE slug IN (
    '23thierno', 'alex-linares', 'anmily', 'brayan-booz', 'candelario', 'chris-lebron',
    'cocolo-rd', 'cromo-x', 'daniel-checo', 'dary-hezz', 'david-appleton', 'don-miguelo',
    'donny-whey', 'el-cherry-scom', 'haraca-kiko', 'hennessy', 'jezzy', 'kendall-hill',
    'king-caballero', 'la-materialista', 'lapiz-conciente', 'madiel-lara', 'mike-el-beta',
    'nico-clinico', 'reychesta-secret-weapon', 'akinohayley', 'alnastry', 'bryan-dotel',
    'chelo-home', 'chimbala', 'chris-alflow', 'donaty', 'el-cata', 'fortuna-la-super-f',
    'frecox-unic', 'jeffrey-henriquez-rijo', 'joly-sc', 'la-pajarita-la-paul',
    'luigui-bleand', 'luny-tunes', 'manny-pena-adpi', 'marielle-hazlo', 'mr-yeison',
    'musicologo-the-libro', 'rl-and-vanessa', 'rxelartista', 'sarah-la-profeta',
    'shecka-sanchez', 'vizkel', 'young-grin', 'bladimir-vasquez', 'mark-b'
  ) AND primary_genre = ANY(genres);

  IF hygiene_violations > 0 THEN
    RAISE EXCEPTION 'Field hygiene violation in cohort: % artists have primary_genre duplicated in genres[]', hygiene_violations;
  END IF;
END $$;

COMMIT;
