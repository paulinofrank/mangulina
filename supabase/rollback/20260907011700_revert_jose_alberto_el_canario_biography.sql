BEGIN;

-- Reverts 20260907011700_rewrite_jose_alberto_el_canario_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'José Alberto "El Canario"',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'salsa',
       date_of_birth = '1958-12-22',
       birth_year = 1958,
       date_of_death = NULL,
       birth_place = 'Villa Consuelo',
       province = 'Distrito Nacional',
       first_name = 'José',
       middle_name = 'Alberto',
       last_name = 'Justiniano',
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
 WHERE slug = 'jose-alberto-el-canario';

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-alberto-el-canario')
   AND locale NOT IN ('');

COMMIT;
