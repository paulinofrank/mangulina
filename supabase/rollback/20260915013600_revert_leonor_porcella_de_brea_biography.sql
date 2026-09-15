BEGIN;

-- Revierte 20260915013600_rewrite_leonor_porcella_de_brea_biography.sql con los documentos, campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'leonor-porcella-de-brea' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'leonor-porcella-de-brea') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Leonor Porcella de Brea is a Dominican singer born in 1940 in Santo Domingo whose career has been devoted to balada, bolero, and Latin pop — the romantic genres that defined sophisticated popular taste in the mid-twentieth-century Dominican Republic. Her voice, refined and expressive, made her a natural interpreter of the bolero tradition, and she earned recognition as one of the country''s distinguished female vocalists of her generation. Porcella de Brea performed at a time when Dominican women artists had to navigate significant social and professional barriers, and her persistence and artistry helped open doors for future generations. Her recordings preserve an important chapter in the history of Dominican romantic music, and she is remembered as a vocalist of taste and elegance.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'leonor-porcella-de-brea';
UPDATE artists SET bio_en = 'Leonor Porcella de Brea is a Dominican singer born in 1940 in Santo Domingo whose career has been devoted to balada, bolero, and Latin pop — the romantic genres that defined sophisticated popular taste in the mid-twentieth-century Dominican Republic. Her voice, refined and expressive, made her a natural interpreter of the bolero tradition, and she earned recognition as one of the country''s distinguished female vocalists of her generation. Porcella de Brea performed at a time when Dominican women artists had to navigate significant social and professional barriers, and her persistence and artistry helped open doors for future generations. Her recordings preserve an important chapter in the history of Dominican romantic music, and she is remembered as a vocalist of taste and elegance.', bio_es = NULL, second_last_name = 'Baehr' WHERE slug = 'leonor-porcella-de-brea';

COMMIT;
