BEGIN;

-- Revierte 20260916011600_create_el_clasicom.sql eliminando la ficha nueva.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id WHERE a.slug = 'el-clasicom' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-clasicom') AND document_type = 'artist_biography';
DELETE FROM artists WHERE slug = 'el-clasicom';

COMMIT;
