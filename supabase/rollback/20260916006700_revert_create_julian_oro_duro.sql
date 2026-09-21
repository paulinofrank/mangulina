BEGIN;

-- Revierte 20260916006700_create_julian_oro_duro.sql eliminando la ficha nueva y su nominación.

DELETE FROM artist_awards WHERE artist_id = (SELECT id FROM artists WHERE slug = 'julian-oro-duro');
DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id WHERE a.slug = 'julian-oro-duro' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'julian-oro-duro') AND document_type = 'artist_biography';
DELETE FROM artists WHERE slug = 'julian-oro-duro';

COMMIT;
