BEGIN;

-- Reverts 20260908004900_rewrite_los_hermanos_rosario_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Los Hermanos Rosario',
       sort_name = 'Los Hermanos Rosario',
       type = 'group',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = NULL,
       birth_year = NULL,
       date_of_death = NULL,
       birth_place = 'Salvaleón de Higüey',
       province = 'La Altagracia',
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = 'Los Hermanos Rosario',
       aliases = ARRAY['Los Rosario', 'Los Dueños del Swing']::text[],
       occupations = '["musician"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = 'https://www.loshermanosrosario.net',
       youtube = '@loshermanosrosario',
       facebook = 'loshermanosrosario',
       instagram = 'hermanosrosario',
       disambiguation = NULL,
       bio_en = 'Los Hermanos Rosario are the most commercially successful merengue band in the history of the Dominican Republic, a family group from Higüey in the La Altagracia province whose career has spanned more than four decades and reshaped the sound of Dominican popular music. The group was formed by brothers from the Rosario family in the 1970s and rose to national and then international prominence in the 1980s and 1990s, becoming the standard-bearers of merengue at its peak of global popularity.

Their sound was defined by propulsive brass arrangements, infectious rhythms, and an ability to craft melodies that lodged permanently in the memory of anyone who heard them. At their commercial height they were the best-selling Latin act in the world, with albums that sold millions of copies across the Americas and Europe. Songs like La Dueña del Swing and Me Tiene Loco became anthems of an era, playing at every party and celebration in the Dominican world and beyond.

The group''s longevity is remarkable: despite changes in lineup and the shifting fortunes of merengue as a genre, Los Hermanos Rosario have continued performing and recording, drawing on an unmatched catalog of classics and a loyal audience that has followed them across generations. They are the defining institution of Dominican merengue.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'los-hermanos-rosario';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Los Hermanos Rosario are the most commercially successful merengue band in the history of the Dominican Republic, a family group from Higüey in the La Altagracia province whose career has spanned more than four decades and reshaped the sound of Dominican popular music. The group was formed by brothers from the Rosario family in the 1970s and rose to national and then international prominence in the 1980s and 1990s, becoming the standard-bearers of merengue at its peak of global popularity.","type":"text"}]},{"type":"paragraph","content":[{"text":"Their sound was defined by propulsive brass arrangements, infectious rhythms, and an ability to craft melodies that lodged permanently in the memory of anyone who heard them. At their commercial height they were the best-selling Latin act in the world, with albums that sold millions of copies across the Americas and Europe. Songs like La Dueña del Swing and Me Tiene Loco became anthems of an era, playing at every party and celebration in the Dominican world and beyond.","type":"text"}]},{"type":"paragraph","content":[{"text":"The group''s longevity is remarkable: despite changes in lineup and the shifting fortunes of merengue as a genre, Los Hermanos Rosario have continued performing and recording, drawing on an unmatched catalog of classics and a loyal audience that has followed them across generations. They are the defining institution of Dominican merengue.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
