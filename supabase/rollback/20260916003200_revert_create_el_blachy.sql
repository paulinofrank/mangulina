BEGIN;

-- Revierte 20260916003200_create_el_blachy.sql eliminando la ficha nueva por completo.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-blachy' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-blachy') AND document_type = 'artist_biography';
DELETE FROM artist_awards WHERE artist_id = (SELECT id FROM artists WHERE slug = 'el-blachy');
DELETE FROM artists WHERE slug = 'el-blachy';
DELETE FROM award_categories WHERE award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd' AND name = 'Conjunto Típico del Año'
  AND NOT EXISTS (SELECT 1 FROM artist_awards WHERE category_id = award_categories.id);

COMMIT;
