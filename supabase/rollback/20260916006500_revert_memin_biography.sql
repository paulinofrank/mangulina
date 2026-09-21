BEGIN;

-- Revierte 20260916006500_rewrite_memin_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'memin') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Memín was a Dominican bachata artist born in 1969 whose career placed him within the tradition of romantic bachata that defined Dominican popular music from the 1970s through the early 2000s. His recordings carried the emotional hallmarks of the genre — expressive vocals, acoustic guitar textures, and lyrics that explored the landscape of love, loss, and longing with unguarded directness. Memín built a following among dedicated bachata listeners who valued authenticity and emotional sincerity in an era when the genre was simultaneously gaining mainstream acceptance and being pulled in more commercial directions. He passed away in 2022, and his passing was noted by fans and fellow musicians who recognized in him a genuine heir to the classic bachata tradition.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'memin';
UPDATE artists SET bio_en = 'Memín was a Dominican bachata artist born in 1969 whose career placed him within the tradition of romantic bachata that defined Dominican popular music from the 1970s through the early 2000s. His recordings carried the emotional hallmarks of the genre — expressive vocals, acoustic guitar textures, and lyrics that explored the landscape of love, loss, and longing with unguarded directness. Memín built a following among dedicated bachata listeners who valued authenticity and emotional sincerity in an era when the genre was simultaneously gaining mainstream acceptance and being pulled in more commercial directions. He passed away in 2022, and his passing was noted by fans and fellow musicians who recognized in him a genuine heir to the classic bachata tradition.', bio_es = NULL, primary_role = 'singer', occupations = '["musician","composer","producer","arranger"]'::jsonb, birth_place = NULL, province = NULL WHERE slug = 'memin';

COMMIT;
