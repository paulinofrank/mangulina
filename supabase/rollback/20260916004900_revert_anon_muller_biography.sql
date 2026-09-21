BEGIN;

-- Revierte 20260916004900_rewrite_anon_muller_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'anon-muller' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'anon-muller') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Anon Müller is a Dominican artist born in 1986 who works in experimental, electronic, and indie music, occupying a creative space at some distance from Dominican popular music conventions. His German-sounding surname alongside a Dominican identity suggests a multicultural background that may inform the particular blend of experimental electronic and indie aesthetics he pursues. Working in experimental and electronic music requires a commitment to process, texture, and sound design that differs fundamentally from the song-based approach of commercial popular music, and Anon Müller''s engagement with this tradition reflects a genuine artistic curiosity about sound as a medium for expression beyond entertainment. He contributes to the small but significant community of Dominican experimental artists.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'anon-muller';
UPDATE artists SET bio_en = 'Anon Müller is a Dominican artist born in 1986 who works in experimental, electronic, and indie music, occupying a creative space at some distance from Dominican popular music conventions. His German-sounding surname alongside a Dominican identity suggests a multicultural background that may inform the particular blend of experimental electronic and indie aesthetics he pursues. Working in experimental and electronic music requires a commitment to process, texture, and sound design that differs fundamentally from the song-based approach of commercial popular music, and Anon Müller''s engagement with this tradition reflects a genuine artistic curiosity about sound as a medium for expression beyond entertainment. He contributes to the small but significant community of Dominican experimental artists.', bio_es = NULL, first_name = 'Anon', middle_name = NULL,
       last_name = 'Müller', second_last_name = NULL, aliases = ARRAY[]::text[],
       primary_role = 'singer', occupations = '["producer"]'::jsonb
       WHERE slug = 'anon-muller';

COMMIT;
