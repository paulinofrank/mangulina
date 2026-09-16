BEGIN;

-- Revierte 20260916001100_rewrite_ysrael_casado_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'ysrael-casado' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ysrael-casado') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Israel Casado is a Dominican merengue and tropical musician connected to Santo Domingo whose career has contributed to the popular music landscape of the Dominican capital. Working within the merengue and tropical traditions that define Dominican popular entertainment, Casado has been part of the active community of Santo Domingo musicians whose recordings and performances have kept these genres vital for audiences at home and in the diaspora. His music reflects the energy and festive spirit that merengue carries as the national music of the Dominican Republic, and his work within the tropical idiom demonstrates a commitment to the broader Caribbean popular music tradition of which Dominican music is a proud and central part.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'ysrael-casado';
UPDATE artists SET bio_en = 'Israel Casado is a Dominican merengue and tropical musician connected to Santo Domingo whose career has contributed to the popular music landscape of the Dominican capital. Working within the merengue and tropical traditions that define Dominican popular entertainment, Casado has been part of the active community of Santo Domingo musicians whose recordings and performances have kept these genres vital for audiences at home and in the diaspora. His music reflects the energy and festive spirit that merengue carries as the national music of the Dominican Republic, and his work within the tropical idiom demonstrates a commitment to the broader Caribbean popular music tradition of which Dominican music is a proud and central part.', bio_es = NULL,
       birth_place = 'Santo Domingo', occupations = '["musician","producer","composer"]'::jsonb
       WHERE slug = 'ysrael-casado';

COMMIT;
