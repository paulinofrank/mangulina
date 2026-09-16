BEGIN;

-- Revierte 20260916000400_rewrite_musiquito_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'musiquito' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'musiquito') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Musiquito was a Dominican musician whose name — little music, or little musician — carries the playful, affectionate quality common to Dominican popular nicknames. His work contributed to the Dominican music scene through recordings and credits that connected him to the popular music traditions of the island. While his public profile was more limited than those of the country''s most commercially prominent artists, Musiquito belonged to the essential community of working musicians who keep Dominican popular music alive through their participation in the recording sessions, live performances, and local events that form the backbone of the country''s music industry. His name, in its very smallness, suggests an artist who approached music with humility and genuine love.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = 'musiquito';
UPDATE artists SET bio_en = 'Musiquito was a Dominican musician whose name — little music, or little musician — carries the playful, affectionate quality common to Dominican popular nicknames. His work contributed to the Dominican music scene through recordings and credits that connected him to the popular music traditions of the island. While his public profile was more limited than those of the country''s most commercially prominent artists, Musiquito belonged to the essential community of working musicians who keep Dominican popular music alive through their participation in the recording sessions, live performances, and local events that form the backbone of the country''s music industry. His name, in its very smallness, suggests an artist who approached music with humility and genuine love.', bio_es = NULL,
       birth_year = NULL, birth_place = NULL, province = NULL,
       occupations = '[]'::jsonb
       WHERE slug = 'musiquito';

COMMIT;
