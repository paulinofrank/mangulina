BEGIN;

-- Revierte 20260916000100_rewrite_manuel_troncoso_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-troncoso' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'manuel-troncoso') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Manuel Troncoso was a Dominican musician born in 1927 whose career spanned the better part of the twentieth century, placing him among the many unsung contributors to Dominican popular music history. Active across several decades, he was part of the rich musical ecosystem that sustained Dominican merengue and tropical music through its evolution from regional folk tradition to nationally and internationally recognized genre. Troncoso performed and contributed to the musical life of the Dominican Republic during a period of tremendous social and cultural change, and his work represents an important thread in the fabric of the country''s popular music heritage. He passed away in 2012, leaving behind a legacy recognized by those who knew the depth and breadth of Dominican musical history.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manuel-troncoso';
UPDATE artists SET bio_en = 'Manuel Troncoso was a Dominican musician born in 1927 whose career spanned the better part of the twentieth century, placing him among the many unsung contributors to Dominican popular music history. Active across several decades, he was part of the rich musical ecosystem that sustained Dominican merengue and tropical music through its evolution from regional folk tradition to nationally and internationally recognized genre. Troncoso performed and contributed to the musical life of the Dominican Republic during a period of tremendous social and cultural change, and his work represents an important thread in the fabric of the country''s popular music heritage. He passed away in 2012, leaving behind a legacy recognized by those who knew the depth and breadth of Dominican musical history.', bio_es = NULL,
       primary_role = 'singer', primary_genre = 'merengue',
       date_of_birth = '1927-09-27',
       birth_place = NULL, province = NULL,
       second_last_name = NULL
       WHERE slug = 'manuel-troncoso';

COMMIT;
