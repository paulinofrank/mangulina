BEGIN;

-- Revierte 20260915016500_rewrite_negrito_chapuseaux_biography.sql con los documentos y campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'negrito-chapuseaux' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'negrito-chapuseaux') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Negrito Chapuseaux was a Dominican singer and entertainer born in 1911 in Santo Domingo whose career unfolded across the golden decades of merengue, bolero, and Cuban-influenced son. A performer of considerable charisma and vocal warmth, Chapuseaux worked in an era when Dominican popular musicians looked both inward to their own rhythmic traditions and outward to the pan-Caribbean musical dialogue that connected Santo Domingo with Havana, San Juan, and New York.","type":"text"}]},{"type":"paragraph","content":[{"text":"His recordings in bolero captured the romantic intensity that made the genre a vehicle for the deepest expressions of longing and passion across Latin America, while his merengue work reflected the festive energy of Dominican popular culture at its most vibrant. Chapuseaux was part of a generation of Dominican artists who established the infrastructure of the country''s recording and performance industry during its formative period. He passed away in 1986, leaving behind recordings that document a crucial era in Dominican musical history.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'negrito-chapuseaux';
UPDATE artists SET bio_en = 'Negrito Chapuseaux was a Dominican singer and entertainer born in 1911 in Santo Domingo whose career unfolded across the golden decades of merengue, bolero, and Cuban-influenced son. A performer of considerable charisma and vocal warmth, Chapuseaux worked in an era when Dominican popular musicians looked both inward to their own rhythmic traditions and outward to the pan-Caribbean musical dialogue that connected Santo Domingo with Havana, San Juan, and New York.

His recordings in bolero captured the romantic intensity that made the genre a vehicle for the deepest expressions of longing and passion across Latin America, while his merengue work reflected the festive energy of Dominican popular culture at its most vibrant. Chapuseaux was part of a generation of Dominican artists who established the infrastructure of the country''s recording and performance industry during its formative period. He passed away in 1986, leaving behind recordings that document a crucial era in Dominican musical history.', bio_es = NULL,
       second_last_name = NULL, occupations = '["composer"]'::jsonb
       WHERE slug = 'negrito-chapuseaux';

COMMIT;
