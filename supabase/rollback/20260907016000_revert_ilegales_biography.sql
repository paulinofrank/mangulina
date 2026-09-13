BEGIN;

-- Reverts 20260907016000_rewrite_ilegales_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Ilegales',
       sort_name = 'Ilegales',
       type = 'group',
       status = 'published',
       gender = 'group',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = NULL,
       birth_year = NULL,
       date_of_death = NULL,
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = 'Ilegales',
       aliases = ARRAY['Los Ilegales', 'Vladimir Dotel']::text[],
       occupations = '["musician"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['urbano']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = 'http://losilegales.com',
       youtube = '@Ilegalesvevo',
       facebook = '100035952771011',
       instagram = 'ilegalesoficial',
       disambiguation = NULL,
       bio_en = 'Ilegales is a Dominican musical group that found commercial success by fusing the driving rhythms of merengue house with the accessibility of Latin pop and the energy of urban music, creating a sound that was popular during the height of the merengue house boom in the late 1990s and early 2000s. Their recordings blended electronic production with the rhythmic foundation of merengue, adding vocal hooks and pop sensibility to produce tracks that worked equally well in clubs and on radio. The group was part of a broader movement in Dominican music that sought to modernize the national genre for younger audiences who were increasingly drawn to international dance music styles, and their success demonstrated that merengue''s rhythmic core could absorb electronic influences without losing its essential identity. Ilegales achieved popularity throughout the Dominican Republic and in Dominican diaspora communities, and their recordings from their peak period remain associated with a specific moment in Dominican popular culture when the dance floor and the radio aligned around a fresh and irresistible sound.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'ilegales';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ilegales')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ilegales')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ilegales is a Dominican musical group that found commercial success by fusing the driving rhythms of merengue house with the accessibility of Latin pop and the energy of urban music, creating a sound that was popular during the height of the merengue house boom in the late 1990s and early 2000s. Their recordings blended electronic production with the rhythmic foundation of merengue, adding vocal hooks and pop sensibility to produce tracks that worked equally well in clubs and on radio. The group was part of a broader movement in Dominican music that sought to modernize the national genre for younger audiences who were increasingly drawn to international dance music styles, and their success demonstrated that merengue''s rhythmic core could absorb electronic influences without losing its essential identity. Ilegales achieved popularity throughout the Dominican Republic and in Dominican diaspora communities, and their recordings from their peak period remain associated with a specific moment in Dominican popular culture when the dance floor and the radio aligned around a fresh and irresistible sound.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'ilegales'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
