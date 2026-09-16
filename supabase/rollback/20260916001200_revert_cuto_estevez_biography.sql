BEGIN;

-- Revierte 20260916001200_rewrite_cuto_estevez_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'cuto-estevez' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'cuto-estevez') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Cuto Estévez was a Dominican musician born in 1915 whose career placed him at the origins of the modern Dominican popular music tradition. Active during the mid-twentieth century, he was among the artists who helped define the sound and character of Dominican merengue and tropical music during its formative decades, when the genre was crystallizing into the form that would eventually become the nation''s musical signature. Estévez performed and recorded during a time when Dominican music was shaped by live performance and direct community engagement, before the age of mass media transformed the industry. He passed away in 1985, and his life''s work stands as part of the foundational history of Dominican musical culture.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'cuto-estevez';
UPDATE artists SET bio_en = 'Cuto Estévez was a Dominican musician born in 1915 whose career placed him at the origins of the modern Dominican popular music tradition. Active during the mid-twentieth century, he was among the artists who helped define the sound and character of Dominican merengue and tropical music during its formative decades, when the genre was crystallizing into the form that would eventually become the nation''s musical signature. Estévez performed and recorded during a time when Dominican music was shaped by live performance and direct community engagement, before the age of mass media transformed the industry. He passed away in 1985, and his life''s work stands as part of the foundational history of Dominican musical culture.', bio_es = NULL,
       middle_name = 'Elias Elíseo', primary_genre = 'merengue',
       occupations = '["composer","conductor"]'::jsonb, genres = ARRAY[]::text[]
       WHERE slug = 'cuto-estevez';

COMMIT;
