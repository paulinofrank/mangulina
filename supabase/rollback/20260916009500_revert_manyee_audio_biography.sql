BEGIN;

-- Revierte 20260916009500_rewrite_manyee_audio_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manyee-audio' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'manyee-audio') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Manyee Audio is a Dominican music group. The group is documented for its contribution to Dominican music and its related scenes.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manyee-audio';
UPDATE artists SET bio_en = 'Manyee Audio is a Dominican music group. The group is documented for its contribution to Dominican music and its related scenes.', bio_es = NULL, aliases = ARRAY[]::text[], birth_place = NULL, province = NULL, occupations = '["producer"]'::jsonb, artist_tags = ARRAY['secular']::text[] WHERE slug = 'manyee-audio';

COMMIT;
