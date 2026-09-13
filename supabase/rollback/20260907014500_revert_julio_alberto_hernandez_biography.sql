BEGIN;

-- Reverts 20260907014500_rewrite_julio_alberto_hernandez_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Julio Alberto Hernández',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'composer',
       primary_genre = 'instrumental-classical',
       date_of_birth = '1900-09-27',
       birth_year = 1900,
       date_of_death = '1999-04-02',
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Julio',
       middle_name = 'Alberto',
       last_name = 'Hernández',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '["Singer","musician"]'::jsonb,
       instruments = ARRAY['piano', 'saxophone']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = NULL,
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'julio-alberto-hernandez';

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'julio-alberto-hernandez')
   AND locale NOT IN ('');

COMMIT;
