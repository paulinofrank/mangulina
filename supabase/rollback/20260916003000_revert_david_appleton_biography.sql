BEGIN;

-- Revierte 20260916003000_rewrite_david_appleton_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'david-appleton' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'david-appleton') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"David Appleton is a Dominican composer and multi-instrumentalist born in 1974 in Santo Domingo whose work spans classical music, genre-crossing fusion, and cinematic composition. This breadth of interest has made him one of the more distinctive voices in contemporary Dominican instrumental music, equally comfortable writing concert works and scoring for visual media.","type":"text"}]},{"type":"paragraph","content":[{"text":"Appleton''s cinematic sensibility gives his music a narrative quality — an ability to conjure mood and movement that goes beyond pure abstract form — while his classical training ensures structural rigor beneath the surface. His fusion work draws on a wide palette of influences, combining elements of world music, jazz, and Dominican folk traditions with Western classical frameworks.","type":"text"}]},{"type":"paragraph","content":[{"text":"As both a performer and composer, Appleton has contributed to the internationalization of Dominican art music, bringing the island''s creative output into conversation with global contemporary music trends.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'david-appleton';
UPDATE artists SET bio_en = 'David Appleton is a Dominican composer and multi-instrumentalist born in 1974 in Santo Domingo whose work spans classical music, genre-crossing fusion, and cinematic composition. This breadth of interest has made him one of the more distinctive voices in contemporary Dominican instrumental music, equally comfortable writing concert works and scoring for visual media.

Appleton''s cinematic sensibility gives his music a narrative quality — an ability to conjure mood and movement that goes beyond pure abstract form — while his classical training ensures structural rigor beneath the surface. His fusion work draws on a wide palette of influences, combining elements of world music, jazz, and Dominican folk traditions with Western classical frameworks.

As both a performer and composer, Appleton has contributed to the internationalization of Dominican art music, bringing the island''s creative output into conversation with global contemporary music trends.', bio_es = NULL,
       primary_genre = 'instrumental-classical', occupations = '["producer","composer","arranger"]'::jsonb
       WHERE slug = 'david-appleton';

COMMIT;
