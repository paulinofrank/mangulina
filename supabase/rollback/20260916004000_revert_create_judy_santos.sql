BEGIN;

-- Revierte 20260916004000_create_judy_santos.sql eliminando la ficha nueva por completo.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'judy-santos' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'judy-santos') AND document_type = 'artist_biography';
DELETE FROM artists WHERE slug = 'judy-santos';

COMMIT;
