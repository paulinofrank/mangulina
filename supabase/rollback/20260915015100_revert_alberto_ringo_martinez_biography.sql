BEGIN;

-- Revierte 20260915015100_rewrite_alberto_ringo_martinez_biography.sql con los documentos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'alberto-ringo-martinez' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'alberto-ringo-martinez') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Alberto Ringo Martínez is a Dominican merengue and tropical artist from Santo Domingo who has contributed to the country''s popular music scene through performances and recordings in the genres that define Dominican musical identity. His work in merengue and tropical reflects a commitment to the dance music tradition that has sustained Dominican popular culture across generations, bringing audiences together around shared rhythms and celebratory energy. The nickname Ringo — evoking the spirit of a skilled performer in the ring or on the stage — signals an artist comfortable with the competitive, high-energy environment of Dominican popular entertainment. Martínez represents the steady, professional wing of Dominican popular music that maintains the tradition through consistent performance and genuine dedication to the craft.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alberto-ringo-martinez';
UPDATE artists SET bio_en = 'Alberto Ringo Martínez is a Dominican merengue and tropical artist from Santo Domingo who has contributed to the country''s popular music scene through performances and recordings in the genres that define Dominican musical identity. His work in merengue and tropical reflects a commitment to the dance music tradition that has sustained Dominican popular culture across generations, bringing audiences together around shared rhythms and celebratory energy. The nickname Ringo — evoking the spirit of a skilled performer in the ring or on the stage — signals an artist comfortable with the competitive, high-energy environment of Dominican popular entertainment. Martínez represents the steady, professional wing of Dominican popular music that maintains the tradition through consistent performance and genuine dedication to the craft.', bio_es = NULL WHERE slug = 'alberto-ringo-martinez';

COMMIT;
