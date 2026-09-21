BEGIN;

-- Revierte 20260916004500_create_las_gemelas_de_la_bachata.sql eliminando la ficha nueva.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id WHERE a.slug = 'las-gemelas-de-la-bachata' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'las-gemelas-de-la-bachata') AND document_type = 'artist_biography';
DELETE FROM artists WHERE slug = 'las-gemelas-de-la-bachata';

COMMIT;
