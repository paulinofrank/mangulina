BEGIN;

-- Revierte 20260916000700_rewrite_juan_lanfranco_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-lanfranco' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'juan-lanfranco') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan Lanfranco was a Dominican musician from Santo Domingo whose work in balada, merengue, and tropical reflected the romantic and festive dimensions of Dominican popular music. The balada — the Spanish-language ballad — has been a staple of Latin American popular song for decades, providing the emotional counterweight to the energetic dance music that otherwise dominates the region''s popular culture. Lanfranco''s engagement with balada alongside merengue and tropical suggests an artist who moved comfortably between the introspective world of the love song and the communal energy of the dance floor, two emotional registers that have always coexisted within Dominican musical life. His career contributed to the breadth of Dominican popular song.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = 'juan-lanfranco';
UPDATE artists SET bio_en = 'Juan Lanfranco was a Dominican musician from Santo Domingo whose work in balada, merengue, and tropical reflected the romantic and festive dimensions of Dominican popular music. The balada — the Spanish-language ballad — has been a staple of Latin American popular song for decades, providing the emotional counterweight to the energetic dance music that otherwise dominates the region''s popular culture. Lanfranco''s engagement with balada alongside merengue and tropical suggests an artist who moved comfortably between the introspective world of the love song and the communal energy of the dance floor, two emotional registers that have always coexisted within Dominican musical life. His career contributed to the breadth of Dominican popular song.', bio_es = NULL,
       birth_year = NULL, date_of_birth = NULL, middle_name = NULL,
       birth_place = 'Santo Domingo', province = 'Distrito Nacional'
       WHERE slug = 'juan-lanfranco';

COMMIT;
