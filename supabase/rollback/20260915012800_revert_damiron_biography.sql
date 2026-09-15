BEGIN;

-- Revierte 20260915012800_rewrite_damiron_biography.sql con los documentos, campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'damiron' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'damiron') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Damirón, born in 1908 in San Francisco de Macorís, was one of the most important figures in the popularization of Dominican merengue during its formative decades. Working alongside his longtime musical partner Chapín, Damirón helped define an intimate, acoustic style of merengue rooted in Dominican folk tradition at a time when the genre was beginning to attract wider national and international attention.","type":"text"}]},{"type":"paragraph","content":[{"text":"The duo of Damirón y Chapín became legendary in Dominican musical history, their recordings documenting a style of merengue that preserved the rural, folkloric character of the music before it was transformed by electrification and big-band arrangements. Damirón''s vocal style was earthy and direct, perfectly suited to the storytelling and communal celebration that lay at the heart of traditional Dominican merengue and folkloric music.","type":"text"}]},{"type":"paragraph","content":[{"text":"San Francisco de Macorís, his birthplace, has produced a remarkable concentration of important Dominican musicians, and Damirón stands among the greatest of them. He passed away in 1992, having lived long enough to witness the global rise of a genre he had helped shape from its roots.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'damiron';
UPDATE artists SET bio_en = 'Damirón, born in 1908 in San Francisco de Macorís, was one of the most important figures in the popularization of Dominican merengue during its formative decades. Working alongside his longtime musical partner Chapín, Damirón helped define an intimate, acoustic style of merengue rooted in Dominican folk tradition at a time when the genre was beginning to attract wider national and international attention.

The duo of Damirón y Chapín became legendary in Dominican musical history, their recordings documenting a style of merengue that preserved the rural, folkloric character of the music before it was transformed by electrification and big-band arrangements. Damirón''s vocal style was earthy and direct, perfectly suited to the storytelling and communal celebration that lay at the heart of traditional Dominican merengue and folkloric music.

San Francisco de Macorís, his birthplace, has produced a remarkable concentration of important Dominican musicians, and Damirón stands among the greatest of them. He passed away in 1992, having lived long enough to witness the global rise of a genre he had helped shape from its roots.', bio_es = NULL, first_name = 'Francisco',
       last_name = 'Damirón', second_last_name = NULL,
       occupations = '["composer","arranger","bandleader"]'::jsonb,
       instruments = ARRAY[]::text[],
       aliases = ARRAY['El Rey del Piano Merengue', 'Los Alegres Tres']::text[] WHERE slug = 'damiron';

COMMIT;
