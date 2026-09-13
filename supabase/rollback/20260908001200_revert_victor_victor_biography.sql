BEGIN;

-- Reverts 20260908001200_rewrite_victor_victor_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Víctor Víctor',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'ballads',
       date_of_birth = '1948-12-11',
       birth_year = 1948,
       date_of_death = '2020-07-16',
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Víctor José',
       middle_name = NULL,
       last_name = 'Victor',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY['Victor Victor', 'Víctor José Víctor Rojas']::text[],
       occupations = '["guitarist","composer","percussionist","musician"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = NULL,
       bio_en = 'Víctor Víctor was a towering intellectual and artistic presence in Dominican culture for more than five decades. Born Víctor Víctor Rojas in 1948 in Santiago de los Caballeros, he grew into one of the most important singer-songwriters the country has ever produced, a figure whose work bridged the intimate world of the trova and the broader currents of Latin American nueva canción.

Coming of age during a period of political repression under the Trujillo dictatorship and its aftermath, Víctor Víctor channeled the anxieties and aspirations of his generation into lyrics of extraordinary literary quality. His songs were populated with vivid characters, social commentary, and an unflinching honesty about Dominican life that resonated deeply with audiences both at home and in the diaspora.

He was equally comfortable composing tender love songs and pointed protest ballads, and his voice — warm, direct, and naturally expressive — gave weight to every line he sang. Over the decades, Víctor Víctor collaborated with many of the leading figures of Dominican and Caribbean music, and his songwriting was recorded by a wide range of artists, cementing his reputation as one of the great composers of his era.

He was also a cultural ambassador for the Dominican Republic, representing his country''s creative spirit in festivals and stages across Latin America, Europe, and the United States. He passed away in 2020, leaving behind a catalog of songs that remain touchstones of Dominican popular music and a legacy that continues to inspire younger generations of songwriters.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'victor-victor';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'victor-victor')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Víctor Víctor was a towering intellectual and artistic presence in Dominican culture for more than five decades. Born Víctor Víctor Rojas in 1948 in Santiago de los Caballeros, he grew into one of the most important singer-songwriters the country has ever produced, a figure whose work bridged the intimate world of the trova and the broader currents of Latin American nueva canción.","type":"text"}]},{"type":"paragraph","content":[{"text":"Coming of age during a period of political repression under the Trujillo dictatorship and its aftermath, Víctor Víctor channeled the anxieties and aspirations of his generation into lyrics of extraordinary literary quality. His songs were populated with vivid characters, social commentary, and an unflinching honesty about Dominican life that resonated deeply with audiences both at home and in the diaspora.","type":"text"}]},{"type":"paragraph","content":[{"text":"He was equally comfortable composing tender love songs and pointed protest ballads, and his voice — warm, direct, and naturally expressive — gave weight to every line he sang. Over the decades, Víctor Víctor collaborated with many of the leading figures of Dominican and Caribbean music, and his songwriting was recorded by a wide range of artists, cementing his reputation as one of the great composers of his era.","type":"text"}]},{"type":"paragraph","content":[{"text":"He was also a cultural ambassador for the Dominican Republic, representing his country''s creative spirit in festivals and stages across Latin America, Europe, and the United States. He passed away in 2020, leaving behind a catalog of songs that remain touchstones of Dominican popular music and a legacy that continues to inspire younger generations of songwriters.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'victor-victor'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
