BEGIN;

-- Reverts 20260907013100_rewrite_eladio_romero_santos_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Eladio Romero Santos',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1937-02-12',
       birth_year = 1937,
       date_of_death = '2001-04-24',
       birth_place = 'Cenoví',
       province = 'Duarte',
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = NULL,
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'eladio-romero-santos';

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'eladio-romero-santos')
   AND locale NOT IN ('');

COMMIT;
