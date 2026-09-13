BEGIN;

-- Reverts 20260907013600_rewrite_amaury_sanchez_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Amaury Sánchez',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'instrumentalist',
       primary_genre = 'instrumental',
       date_of_birth = '1963-07-22',
       birth_year = 1963,
       date_of_death = NULL,
       birth_place = 'Santo Domingo',
       province = 'Santo Domingo',
       first_name = 'Luis',
       middle_name = 'Amaury',
       last_name = 'Sánchez',
       second_last_name = 'Lembert',
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '["conductor","composer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = 'amaury.sanchez.566',
       instagram = 'amaurysanchez',
       disambiguation = NULL,
       bio_en = NULL,
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'amaury-sanchez';

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'amaury-sanchez')
   AND locale NOT IN ('');

COMMIT;
