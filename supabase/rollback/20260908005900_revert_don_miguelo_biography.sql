BEGIN;

-- Reverts 20260908005900_rewrite_don_miguelo_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Don Miguelo',
       sort_name = 'Valerio, Miguel Ángel',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urbano',
       date_of_birth = '1981-08-27',
       birth_year = 1981,
       date_of_death = NULL,
       birth_place = 'San Francisco de Macorís',
       province = 'Duarte',
       first_name = 'Miguel',
       middle_name = 'Ángel',
       last_name = 'Valerio',
       second_last_name = 'Lebrón',
       stage_name = 'Don Miguelo',
       aliases = ARRAY['Miguel Angel Valerio', 'El Mejor del Bloque']::text[],
       occupations = '["producer","composer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['urban-dembow', 'urban-reggaeton']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@donmiguelotv',
       facebook = NULL,
       instagram = 'donmiguelo',
       disambiguation = NULL,
       bio_en = 'Don Miguelo, born Miguel Ángel Díaz in 1981 in San Francisco de Macorís, is one of the Dominican Republic''s most celebrated urban and dembow artists. Growing up in the Cibao region, he was immersed in a rich musical environment that would eventually inform his own style — a high-energy fusion of dembow, reggaeton, and urban Dominican sounds. He rose to national prominence in the 2000s and 2010s with a string of hits that captured the raw, irreverent spirit of street culture in the Dominican Republic.

Known for his charisma, humor, and ability to craft earworm melodies, Don Miguelo became a crossover success, collaborating with major artists across Latin urban music. His track record of viral hits and sold-out performances established him as a cornerstone of the Dominican dembow movement, and he has worked to expand his reach internationally while remaining deeply connected to his roots in San Francisco de Macorís.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'don-miguelo';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'don-miguelo')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'don-miguelo')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Don Miguelo, born Miguel Ángel Díaz in 1981 in San Francisco de Macorís, is one of the Dominican Republic''s most celebrated urban and dembow artists. Growing up in the Cibao region, he was immersed in a rich musical environment that would eventually inform his own style — a high-energy fusion of dembow, reggaeton, and urban Dominican sounds. He rose to national prominence in the 2000s and 2010s with a string of hits that captured the raw, irreverent spirit of street culture in the Dominican Republic.","type":"text"}]},{"type":"paragraph","content":[{"text":"Known for his charisma, humor, and ability to craft earworm melodies, Don Miguelo became a crossover success, collaborating with major artists across Latin urban music. His track record of viral hits and sold-out performances established him as a cornerstone of the Dominican dembow movement, and he has worked to expand his reach internationally while remaining deeply connected to his roots in San Francisco de Macorís.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'don-miguelo'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
