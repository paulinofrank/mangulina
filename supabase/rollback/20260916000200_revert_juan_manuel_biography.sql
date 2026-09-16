BEGIN;

-- Revierte 20260916000200_rewrite_juan_manuel_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-manuel' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'juan-manuel') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan Manuel is a Dominican merengue and tropical artist from Santo Domingo who has participated in the popular music scene of the Dominican capital with recordings and performances in the festive, dance-oriented genres that define Dominican communal entertainment. His work in merengue and tropical connects him to the national musical traditions that have been the backbone of Dominican popular culture across generations, and his presence in Santo Domingo''s active music scene situates him within a community of performers who collectively sustain those traditions through consistent live performance and recording. Juan Manuel''s music speaks to the enduring appetite of Dominican audiences for the rhythms and sounds that have accompanied their celebrations and daily lives for decades.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-manuel';
UPDATE artists SET bio_en = 'Juan Manuel is a Dominican merengue and tropical artist from Santo Domingo who has participated in the popular music scene of the Dominican capital with recordings and performances in the festive, dance-oriented genres that define Dominican communal entertainment. His work in merengue and tropical connects him to the national musical traditions that have been the backbone of Dominican popular culture across generations, and his presence in Santo Domingo''s active music scene situates him within a community of performers who collectively sustain those traditions through consistent live performance and recording. Juan Manuel''s music speaks to the enduring appetite of Dominican audiences for the rhythms and sounds that have accompanied their celebrations and daily lives for decades.', bio_es = NULL,
       birth_place = 'Santo Domingo', province = 'Distrito Nacional', last_name = NULL,
       aliases = ARRAY['Los Toros Band']::text[], occupations = '[]'::jsonb, genres = ARRAY[]::text[]
       WHERE slug = 'juan-manuel';

COMMIT;
