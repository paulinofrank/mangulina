BEGIN;

-- Revierte 20260916004100_create_suenala_mikey.sql eliminando la ficha nueva por completo.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'suenala-mikey' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'suenala-mikey') AND document_type = 'artist_biography';
DELETE FROM artists WHERE slug = 'suenala-mikey';

COMMIT;
