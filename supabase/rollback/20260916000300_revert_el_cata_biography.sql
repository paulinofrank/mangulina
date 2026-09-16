BEGIN;

-- Revierte 20260916000300_rewrite_el_cata_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'el-cata' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-cata') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"El Cata, born in 1972 in Barahona, is a Dominican artist whose work in merengue de calle and urban music has made him a recognized presence in the Dominican popular music world. Known for high-energy performances and a sound rooted in the street merengue tradition, he built his reputation in the neighborhoods and clubs of Santo Domingo before expanding his reach through recordings and collaborations. El Cata''s music captures the festive, percussive energy that defines merengue de calle — a sound that emerged from working-class communities and has always maintained its connection to those origins even as it achieved mainstream popularity. His career reflects the vitality of Dominican urban popular culture and its capacity to produce distinct, regionally rooted artists.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = 'el-cata';
UPDATE artists SET bio_en = 'El Cata, born in 1972 in Barahona, is a Dominican artist whose work in merengue de calle and urban music has made him a recognized presence in the Dominican popular music world. Known for high-energy performances and a sound rooted in the street merengue tradition, he built his reputation in the neighborhoods and clubs of Santo Domingo before expanding his reach through recordings and collaborations. El Cata''s music captures the festive, percussive energy that defines merengue de calle — a sound that emerged from working-class communities and has always maintained its connection to those origins even as it achieved mainstream popularity. His career reflects the vitality of Dominican urban popular culture and its capacity to produce distinct, regionally rooted artists.', bio_es = NULL,
       middle_name = NULL, occupations = '["composer","producer"]'::jsonb, genres = ARRAY[]::text[]
       WHERE slug = 'el-cata';

COMMIT;
