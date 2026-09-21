BEGIN;

-- Revierte 20260916006900_rewrite_johnny_chocolate_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johnny-chocolate' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-chocolate') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Johnny Chocolate is a Dominican musician from Santo Domingo whose work in merengue, salsa, and tropical places him within the broad tradition of Caribbean popular dance music. His stage name carries a warmth and sweetness that suits the emotional register of the tropical and romantic music he performs, suggesting an artist whose appeal is rooted in pleasure and accessibility. Working across merengue and salsa — two of the Caribbean''s most beloved dance traditions — Chocolate brings a versatility that has allowed him to perform for audiences with different musical preferences while remaining connected to the rhythmic core that all these genres share. His career contributes to the ongoing vitality of Dominican and Caribbean popular entertainment.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'johnny-chocolate';
UPDATE artists SET bio_en = 'Johnny Chocolate is a Dominican musician from Santo Domingo whose work in merengue, salsa, and tropical places him within the broad tradition of Caribbean popular dance music. His stage name carries a warmth and sweetness that suits the emotional register of the tropical and romantic music he performs, suggesting an artist whose appeal is rooted in pleasure and accessibility. Working across merengue and salsa — two of the Caribbean''s most beloved dance traditions — Chocolate brings a versatility that has allowed him to perform for audiences with different musical preferences while remaining connected to the rhythmic core that all these genres share. His career contributes to the ongoing vitality of Dominican and Caribbean popular entertainment.', bio_es = NULL, occupations = '[]'::jsonb, instruments = ARRAY['tambora']::text[] WHERE slug = 'johnny-chocolate';

COMMIT;
