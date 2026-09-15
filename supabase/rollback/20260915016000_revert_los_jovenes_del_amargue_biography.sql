BEGIN;

-- Revierte 20260915016000_rewrite_los_jovenes_del_amargue_biography.sql con los documentos y campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'los-jovenes-del-amargue' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-jovenes-del-amargue') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Los Jovenes Del Amargue is a Dominican music group whose work is associated with Bachata and Tropical. The group is documented for its contribution to Dominican music and its related scenes.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'los-jovenes-del-amargue';
UPDATE artists SET bio_en = 'Los Jovenes Del Amargue is a Dominican music group whose work is associated with Bachata and Tropical. The group is documented for its contribution to Dominican music and its related scenes.', bio_es = NULL, formation_year = NULL
       WHERE slug = 'los-jovenes-del-amargue';

COMMIT;
