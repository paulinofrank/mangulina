BEGIN;

-- Revierte 20260915010100_rewrite_juan_bautista_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-bautista' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'juan-bautista') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan Bautista was a Dominican bachata artist born in 1955 in Salcedo, a municipality in the Hermanas Mirabal province of the Cibao, whose career placed him within the foundational tradition of Dominican bachata. The Hermanas Mirabal province — named for the three sisters martyred under the Trujillo dictatorship — is part of the Cibao''s cultural landscape, and Bautista''s origins there connected him to the rich popular music heritage of the region. His work in bachata during the genre''s formative decades contributed to the tradition that would eventually become one of the most internationally recognized forms of Dominican music. He passed away in 2013, and his recordings remain as part of the historical record of bachata''s development as a genre.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-bautista';
UPDATE artists SET bio_en = 'Juan Bautista was a Dominican bachata artist born in 1955 in Salcedo, a municipality in the Hermanas Mirabal province of the Cibao, whose career placed him within the foundational tradition of Dominican bachata. The Hermanas Mirabal province — named for the three sisters martyred under the Trujillo dictatorship — is part of the Cibao''s cultural landscape, and Bautista''s origins there connected him to the rich popular music heritage of the region. His work in bachata during the genre''s formative decades contributed to the tradition that would eventually become one of the most internationally recognized forms of Dominican music. He passed away in 2013, and his recordings remain as part of the historical record of bachata''s development as a genre.', bio_es = NULL,
       first_name = 'Juan', middle_name = NULL, last_name = 'Bautista',
       second_last_name = NULL, birth_place = 'Salcedo', province = 'Hermanas Mirabal',
       occupations = '["musician","composer"]'::jsonb
 WHERE slug = 'juan-bautista';

COMMIT;
