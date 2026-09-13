BEGIN;

-- Reverts 20260908001000_rewrite_rubby_perez_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Rubby Pérez',
       sort_name = 'Pérez, Rubby',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1956-03-08',
       birth_year = 1956,
       date_of_death = '2025-04-08',
       birth_place = 'Haina',
       province = 'San Cristóbal',
       first_name = 'Roberto',
       middle_name = 'Antonio',
       last_name = 'Pérez',
       second_last_name = 'Herrera',
       stage_name = 'Rubby Pérez',
       aliases = ARRAY[]::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = 'http://www.rubbyperez.com',
       youtube = '@RubbyPerez',
       facebook = 'rubbyperezmusic',
       instagram = 'rubbyperezoficial',
       disambiguation = NULL,
       bio_en = 'Rubby Pérez was one of the most charismatic and enduring figures in Dominican merengue, a singer whose powerful voice and magnetic stage presence made him a beloved star for over four decades. Born on March 8, 1956, in Haina, an industrial town just west of Santo Domingo, he grew up surrounded by the music of the capital and its surroundings, developing a deep love for merengue, salsa, and the broader spectrum of Caribbean tropical music.

His career began to take shape in the 1970s when he became a vocalist for the legendary orchestra of Johnny Ventura, one of the most important bands in the history of Dominican merengue. Under Ventura''s direction, Pérez honed his craft as a frontman, learning how to command an audience and deliver high-energy performances that left crowds exhilarated. He eventually launched a successful solo career, releasing albums that blended classic merengue energy with touches of salsa and bolero that demonstrated the full range of his vocal abilities.

His recordings were hits not only in the Dominican Republic but across Latin America, the Caribbean, and the growing Dominican diaspora communities in the United States and Europe. Throughout his career Pérez was known for his professionalism, his warmth toward fans, and his commitment to the festive spirit that merengue embodies at its best. He received numerous awards and recognitions over the years and continued performing and recording well into the 2010s and beyond.

His death in 2025 marked the end of an era and was mourned across the Dominican Republic and by Latin music fans worldwide. Rubby Pérez is remembered as one of the great voices of Dominican merengue, a singer who brought joy to millions and never lost his connection to the music that shaped him.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'rubby-perez';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Rubby Pérez was one of the most charismatic and enduring figures in Dominican merengue, a singer whose powerful voice and magnetic stage presence made him a beloved star for over four decades. Born on March 8, 1956, in Haina, an industrial town just west of Santo Domingo, he grew up surrounded by the music of the capital and its surroundings, developing a deep love for merengue, salsa, and the broader spectrum of Caribbean tropical music.","type":"text"}]},{"type":"paragraph","content":[{"text":"His career began to take shape in the 1970s when he became a vocalist for the legendary orchestra of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"06880bd8-8561-4fa4-a37f-1cdae5624ba0"}},{"text":", one of the most important bands in the history of Dominican merengue. Under Ventura''s direction, Pérez honed his craft as a frontman, learning how to command an audience and deliver high-energy performances that left crowds exhilarated. He eventually launched a successful solo career, releasing albums that blended classic merengue energy with touches of salsa and bolero that demonstrated the full range of his vocal abilities.","type":"text"}]},{"type":"paragraph","content":[{"text":"His recordings were hits not only in the Dominican Republic but across Latin America, the Caribbean, and the growing Dominican diaspora communities in the United States and Europe. Throughout his career Pérez was known for his professionalism, his warmth toward fans, and his commitment to the festive spirit that merengue embodies at its best. He received numerous awards and recognitions over the years and continued performing and recording well into the 2010s and beyond.","type":"text"}]},{"type":"paragraph","content":[{"text":"His death in 2025 marked the end of an era and was mourned across the Dominican Republic and by Latin music fans worldwide. Rubby Pérez is remembered as one of the great voices of Dominican merengue, a singer who brought joy to millions and never lost his connection to the music that shaped him.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'rubby-perez'), 3)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez') AND locale = 'en'), '06880bd8-8561-4fa4-a37f-1cdae5624ba0', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

COMMIT;
