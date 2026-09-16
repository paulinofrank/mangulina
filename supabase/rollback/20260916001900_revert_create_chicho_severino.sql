BEGIN;

-- Revierte 20260916001900_create_chicho_severino.sql eliminando la ficha nueva por completo.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'chicho-severino' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'chicho-severino') AND document_type = 'artist_biography';
DELETE FROM artists WHERE slug = 'chicho-severino';

COMMIT;
