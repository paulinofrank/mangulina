BEGIN;

-- Revierte 20260915013000_rewrite_juan_francisco_garcia_biography.sql con los documentos, campos
-- que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-francisco-garcia' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'juan-francisco-garcia') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan Francisco García stands as one of the most important figures in early twentieth-century Dominican art music. Born in 1892 in Santiago de los Caballeros, the country''s second city and a cultural hub in its own right, García devoted his life to composing, teaching, and documenting the musical heritage of his nation. His work spanned classical composition and academic music while also drawing deeply from Dominican folkloric traditions, making him a bridge between the European art music canon he studied and the vernacular sounds that surrounded him.","type":"text"}]},{"type":"paragraph","content":[{"text":"He was a pioneering musicologist as well as a composer, producing scholarly work on Dominican music that preserved knowledge which might otherwise have been lost. García''s compositions reflect a nuanced understanding of both formal structure and national identity, and his influence rippled through generations of Dominican musicians who followed him. He died in 1974 at the age of eighty-one, having spent more than half a century shaping the intellectual and artistic landscape of Dominican music.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-francisco-garcia';
UPDATE artists SET bio_en = 'Juan Francisco García stands as one of the most important figures in early twentieth-century Dominican art music. Born in 1892 in Santiago de los Caballeros, the country''s second city and a cultural hub in its own right, García devoted his life to composing, teaching, and documenting the musical heritage of his nation. His work spanned classical composition and academic music while also drawing deeply from Dominican folkloric traditions, making him a bridge between the European art music canon he studied and the vernacular sounds that surrounded him.

He was a pioneering musicologist as well as a composer, producing scholarly work on Dominican music that preserved knowledge which might otherwise have been lost. García''s compositions reflect a nuanced understanding of both formal structure and national identity, and his influence rippled through generations of Dominican musicians who followed him. He died in 1974 at the age of eighty-one, having spent more than half a century shaping the intellectual and artistic landscape of Dominican music.', bio_es = NULL, first_name = 'Juan',
       occupations = '["musician","bandleader"]'::jsonb,
       instruments = ARRAY[]::text[] WHERE slug = 'juan-francisco-garcia';

COMMIT;
