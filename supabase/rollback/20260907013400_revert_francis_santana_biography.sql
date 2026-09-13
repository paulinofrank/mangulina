BEGIN;

-- Reverts 20260907013400_rewrite_francis_santana_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Francis Santana',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'bolero',
       date_of_birth = '1929-06-20',
       birth_year = 1929,
       date_of_death = '2014-01-11',
       birth_place = 'Santo Domingo',
       province = 'Santo Domingo',
       first_name = 'Juan',
       middle_name = 'Francisco',
       last_name = 'Santana',
       second_last_name = 'Solís',
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
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
 WHERE slug = 'francis-santana';

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'francis-santana')
   AND locale NOT IN ('');

COMMIT;
