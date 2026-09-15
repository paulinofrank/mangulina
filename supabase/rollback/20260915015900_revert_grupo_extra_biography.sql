BEGIN;

-- Revierte 20260915015900_rewrite_grupo_extra_biography.sql con los documentos y premios
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM artist_awards WHERE artist_id = (SELECT id FROM artists WHERE slug = 'grupo-extra')
   AND year = 2026 AND won = false;
DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'grupo-extra' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'grupo-extra') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Grupo Extra is a Dominican music group whose work is associated with Bachata, Tropical, and Pop Latino. The group is documented for its contribution to Dominican music and its related scenes.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'grupo-extra';
UPDATE artists SET bio_en = 'Grupo Extra is a Dominican music group whose work is associated with Bachata, Tropical, and Pop Latino. The group is documented for its contribution to Dominican music and its related scenes.', bio_es = NULL WHERE slug = 'grupo-extra';

COMMIT;
