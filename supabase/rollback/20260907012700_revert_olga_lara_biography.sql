BEGIN;

-- Reverts 20260907012700_rewrite_olga_lara_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Olga Lara',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'ballads',
       date_of_birth = '1953-09-16',
       birth_year = 1953,
       date_of_death = NULL,
       birth_place = 'Azua',
       province = 'Azua',
       first_name = 'Olga',
       middle_name = 'Francia Elena',
       last_name = 'Lara',
       second_last_name = 'D''Soto',
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
 WHERE slug = 'olga-lara';

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'olga-lara')
   AND locale NOT IN ('');

COMMIT;
