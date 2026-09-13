BEGIN;

-- Reverts 20260908002700_rewrite_benny_sadel_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Benny Sadel',
       sort_name = 'Sadel, Benny',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1960-03-27',
       birth_year = 1960,
       date_of_death = '2015-11-05',
       birth_place = 'Tamayo',
       province = 'Bahoruco',
       first_name = 'Emmanuel',
       middle_name = NULL,
       last_name = 'Jiménez',
       second_last_name = NULL,
       stage_name = 'Benny Sadel',
       aliases = ARRAY['El Cacique', 'El Cacique del Merengue']::text[],
       occupations = '["bandleader"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Benny Sadel was a beloved figure in Dominican popular music whose warm voice and natural musical charisma made him one of the most popular merengue and tropical performers of his generation. Born in 1960 in Tamayo, a small town in the Bahoruco province of the country''s southwestern region, he built a career that connected him deeply with Dominican audiences across the full range of the island, from the capital to the provinces, and with diaspora communities in the United States and beyond.

His recordings in the merengue and tropical traditions were characterized by a joyful accessibility that made them immediately appealing to broad audiences, and his live performances were celebrated for the warmth and generosity he brought to the stage. Sadel was known for his personal charm as much as his musical talent, and his connection with fans was legendary in Dominican entertainment circles.

He was an active and beloved presence on the Dominican music circuit up until his death in 2015, at the age of 55, a loss that prompted widespread grief among fans who had grown up with his music as a fixture of Dominican cultural life. His recordings remain in active circulation and continue to be enjoyed by listeners who remember him with great affection.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'benny-sadel';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Benny Sadel was a beloved figure in Dominican popular music whose warm voice and natural musical charisma made him one of the most popular merengue and tropical performers of his generation. Born in 1960 in Tamayo, a small town in the Bahoruco province of the country''s southwestern region, he built a career that connected him deeply with Dominican audiences across the full range of the island, from the capital to the provinces, and with diaspora communities in the United States and beyond.","type":"text"}]},{"type":"paragraph","content":[{"text":"His recordings in the merengue and tropical traditions were characterized by a joyful accessibility that made them immediately appealing to broad audiences, and his live performances were celebrated for the warmth and generosity he brought to the stage. Sadel was known for his personal charm as much as his musical talent, and his connection with fans was legendary in Dominican entertainment circles.","type":"text"}]},{"type":"paragraph","content":[{"text":"He was an active and beloved presence on the Dominican music circuit up until his death in 2015, at the age of 55, a loss that prompted widespread grief among fans who had grown up with his music as a fixture of Dominican cultural life. His recordings remain in active circulation and continue to be enjoyed by listeners who remember him with great affection.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'benny-sadel'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
