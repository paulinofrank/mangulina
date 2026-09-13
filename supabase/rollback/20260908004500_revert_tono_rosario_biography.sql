BEGIN;

-- Reverts 20260908004500_rewrite_tono_rosario_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Toño Rosario',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1955-11-03',
       birth_year = 1955,
       date_of_death = NULL,
       birth_place = 'Higüey',
       province = 'La Altagracia',
       first_name = 'Máximo',
       middle_name = 'Antonio',
       last_name = 'Rosario',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY['Máximo Antonio del Rosario Almonte', 'Maximo Antonio del Rosario']::text[],
       occupations = '["singer-songwriter"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@ToñoRosario-p8s',
       facebook = 'TonoRosarioGalactico',
       instagram = 'tonogalactico',
       disambiguation = NULL,
       bio_en = 'Toño Rosario, born Antonio Rosario in 1955 in Higüey, La Altagracia, is one of the most charismatic and enduring figures in Dominican merengue. A member of the extended Rosario family that gave Dominican music Los Hermanos Rosario, he developed a solo career that established him as a significant artist in his own right, distinct from the family band''s commercial juggernaut.

Known for his joyful stage presence, his wit, and his ability to connect with audiences of all ages, Toño Rosario became a beloved entertainer who embodied the celebratory spirit at the heart of merengue. His recordings blended humor and romance in a way that was distinctly his own, and he developed a series of hits that audiences in the Dominican Republic and its diaspora know by heart.

Toño Rosario has remained active across decades of shifting musical fashions, sustained by his genuine love of performance and the loyalty of fans who have grown up with his music.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'tono-rosario';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tono-rosario')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'tono-rosario')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Toño Rosario, born Antonio Rosario in 1955 in Higüey, La Altagracia, is one of the most charismatic and enduring figures in Dominican merengue. A member of the extended Rosario family that gave Dominican music Los Hermanos Rosario, he developed a solo career that established him as a significant artist in his own right, distinct from the family band''s commercial juggernaut.","type":"text"}]},{"type":"paragraph","content":[{"text":"Known for his joyful stage presence, his wit, and his ability to connect with audiences of all ages, Toño Rosario became a beloved entertainer who embodied the celebratory spirit at the heart of merengue. His recordings blended humor and romance in a way that was distinctly his own, and he developed a series of hits that audiences in the Dominican Republic and its diaspora know by heart.","type":"text"}]},{"type":"paragraph","content":[{"text":"Toño Rosario has remained active across decades of shifting musical fashions, sustained by his genuine love of performance and the loyalty of fans who have grown up with his music.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'tono-rosario'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
