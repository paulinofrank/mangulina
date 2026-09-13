BEGIN;

-- Reverts 20260907012500_rewrite_leonardo_paniagua_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Leonardo Paniagua',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1945-08-05',
       birth_year = 1945,
       date_of_death = NULL,
       birth_place = 'Las Yayas',
       province = 'La Vega',
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
       youtube = '@LeonardoPaniagua',
       facebook = 'leonardopaniagua01',
       instagram = 'leonardopaniagua01',
       disambiguation = NULL,
       bio_en = NULL,
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'leonardo-paniagua';

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'leonardo-paniagua')
   AND locale NOT IN ('');

COMMIT;
