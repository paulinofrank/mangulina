BEGIN;

-- Revierte 20260916000900_rewrite_hugo_perez_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'hugo-perez-y-sus-quisqueyanos-modernos' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'hugo-perez-y-sus-quisqueyanos-modernos') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Hugo Pérez y sus Quisqueyanos Modernos is a Dominican music ensemble whose name honors the indigenous Taíno name for Hispaniola — Quisqueya — while gesturing toward modernity in their musical approach. Working in merengue and tropical, the group was part of the rich tradition of Dominican ensembles that have used creative names to announce their identity and ambitions. By calling themselves the Modern Quisqueyans, the group claimed both rootedness in Dominican heritage and a forward-looking musical perspective. Such ensembles were a vital part of the Dominican popular music world through much of the twentieth century, providing the live orchestral sound that defined merengue before the era of electronic production transformed the genre.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'hugo-perez-y-sus-quisqueyanos-modernos';
UPDATE artists SET bio_en = 'Hugo Pérez y sus Quisqueyanos Modernos is a Dominican music ensemble whose name honors the indigenous Taíno name for Hispaniola — Quisqueya — while gesturing toward modernity in their musical approach. Working in merengue and tropical, the group was part of the rich tradition of Dominican ensembles that have used creative names to announce their identity and ambitions. By calling themselves the Modern Quisqueyans, the group claimed both rootedness in Dominican heritage and a forward-looking musical perspective. Such ensembles were a vital part of the Dominican popular music world through much of the twentieth century, providing the live orchestral sound that defined merengue before the era of electronic production transformed the genre.', bio_es = NULL,
       birth_place = 'Santo Domingo', province = 'Distrito Nacional', genres = ARRAY[]::text[]
       WHERE slug = 'hugo-perez-y-sus-quisqueyanos-modernos';

COMMIT;
