BEGIN;

-- Revierte 20260916000800_rewrite_raphael_cruz_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'raphael-cruz' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raphael-cruz') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Raphael Cruz was a Dominican musician born in Santo Domingo in 1947 who dedicated his life to performing and preserving the rich traditions of Dominican popular music. Over his career he worked within the merengue and tropical genres that form the backbone of Dominican musical identity, contributing both as a performer and as a keeper of the musical heritage that connects the Dominican Republic to its Afro-Caribbean roots. Cruz was active across several decades, performing for audiences in the Dominican Republic and in diaspora communities where Dominican music served as a powerful reminder of home and cultural belonging. He passed away in 2020 at the age of seventy-three, remembered fondly by those who had enjoyed his music over the years.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'raphael-cruz';
UPDATE artists SET bio_en = 'Raphael Cruz was a Dominican musician born in Santo Domingo in 1947 who dedicated his life to performing and preserving the rich traditions of Dominican popular music. Over his career he worked within the merengue and tropical genres that form the backbone of Dominican musical identity, contributing both as a performer and as a keeper of the musical heritage that connects the Dominican Republic to its Afro-Caribbean roots. Cruz was active across several decades, performing for audiences in the Dominican Republic and in diaspora communities where Dominican music served as a powerful reminder of home and cultural belonging. He passed away in 2020 at the age of seventy-three, remembered fondly by those who had enjoyed his music over the years.', bio_es = NULL,
       birth_place = 'Santo Domingo', province = 'Distrito Nacional', occupations = '[]'::jsonb
       WHERE slug = 'raphael-cruz';

COMMIT;
