BEGIN;

-- Reverts 20260908009100_rewrite_elvis_martinez_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Elvis Martínez',
       sort_name = 'Martínez, Elvis',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1976-01-05',
       birth_year = 1976,
       date_of_death = NULL,
       birth_place = 'San Francisco de Macorís',
       province = 'Duarte',
       first_name = 'Elvis',
       middle_name = NULL,
       last_name = 'Martínez',
       second_last_name = NULL,
       stage_name = 'Elvis Martínez',
       aliases = ARRAY['El Camaron']::text[],
       occupations = '["composer","musician"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular']::text[],
       website = NULL,
       youtube = '@elvismartinez',
       facebook = 'elvismartinezeljefe',
       instagram = 'elvismartinezeljefe',
       disambiguation = NULL,
       bio_en = 'Elvis Martínez is a Dominican bachata singer born in 1976 in San Francisco de Macorís who built one of the most enduring careers in the genre''s modern era. Emerging in the 1990s at a time when bachata was transitioning from its underground roots to broader mainstream acceptance, Martínez developed a style that combined the genre''s traditional emotional rawness with polished contemporary production.

His voice — expressive, versatile, and capable of conveying both heartbreak and joy — became one of the most recognizable in Dominican bachata, and his recordings produced a string of hits that resonated with audiences across the Dominican Republic and its diaspora. He has collaborated with a wide range of artists and has maintained his popularity across several decades by consistently delivering recordings that honor the essence of bachata while evolving with the times.

Elvis Martínez is regarded as one of the key figures of the bachata boom that transformed the genre from a local phenomenon into an international musical force.',
       bio_es = NULL,
       updated_at = now()
 WHERE slug = 'elvis-martinez';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'elvis-martinez')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'elvis-martinez')
   AND locale NOT IN ('en');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Elvis Martínez is a Dominican bachata singer born in 1976 in San Francisco de Macorís who built one of the most enduring careers in the genre''s modern era. Emerging in the 1990s at a time when bachata was transitioning from its underground roots to broader mainstream acceptance, Martínez developed a style that combined the genre''s traditional emotional rawness with polished contemporary production.","type":"text"}]},{"type":"paragraph","content":[{"text":"His voice — expressive, versatile, and capable of conveying both heartbreak and joy — became one of the most recognizable in Dominican bachata, and his recordings produced a string of hits that resonated with audiences across the Dominican Republic and its diaspora. He has collaborated with a wide range of artists and has maintained his popularity across several decades by consistently delivering recordings that honor the essence of bachata while evolving with the times.","type":"text"}]},{"type":"paragraph","content":[{"text":"Elvis Martínez is regarded as one of the key figures of the bachata boom that transformed the genre from a local phenomenon into an international musical force.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'elvis-martinez'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

COMMIT;
