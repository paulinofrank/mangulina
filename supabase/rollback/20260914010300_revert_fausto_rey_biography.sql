BEGIN;

-- Revierte 20260914010300_rewrite_fausto_rey_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'fausto-rey' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fausto-rey') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Fausto Rey is a Dominican singer and musician born in 1951 in Higüey, the capital of the La Altagracia province on the eastern tip of the island. His career has spanned the genres of balada, bolero, merengue, and tropical music, a breadth that reflects both his musical versatility and his deep immersion in the Dominican musical tradition. He emerged as a prominent figure in Dominican romantic music, developing a style that blended the emotional intensity of the bolero with the rhythmic vitality of merengue and tropical sounds.","type":"text"}]},{"type":"paragraph","content":[{"text":"His recordings won him a devoted following in the Dominican Republic and among Dominican communities abroad, and he has remained an active and respected presence in the country''s music scene. Fausto Rey''s longevity and consistency have made him a touchstone of Dominican popular music across several generations of listeners.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'fausto-rey';
UPDATE artists SET bio_en = 'Fausto Rey is a Dominican singer and musician born in 1951 in Higüey, the capital of the La Altagracia province on the eastern tip of the island. His career has spanned the genres of balada, bolero, merengue, and tropical music, a breadth that reflects both his musical versatility and his deep immersion in the Dominican musical tradition. He emerged as a prominent figure in Dominican romantic music, developing a style that blended the emotional intensity of the bolero with the rhythmic vitality of merengue and tropical sounds.

His recordings won him a devoted following in the Dominican Republic and among Dominican communities abroad, and he has remained an active and respected presence in the country''s music scene. Fausto Rey''s longevity and consistency have made him a touchstone of Dominican popular music across several generations of listeners.', bio_es = NULL,
       occupations = '["composer","musician"]'::jsonb WHERE slug = 'fausto-rey';

COMMIT;
