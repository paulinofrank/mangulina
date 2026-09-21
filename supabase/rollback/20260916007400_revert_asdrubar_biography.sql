BEGIN;

-- Revierte 20260916007400_rewrite_asdrubar_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'asdrubar' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'asdrubar') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Asdrubar is a Dominican salsa and tropical musician from Santo Domingo whose career reflects the Dominican contribution to the salsa tradition — a genre that the island has embraced and made its own despite salsa''s primary historical identification with Puerto Rico and New York. His work in both salsa and tropical places him within the broader Caribbean popular music conversation, connecting Dominican musical culture to the pan-Caribbean rhythmic dialogue that has always informed the island''s artists. Asdrubar has performed and recorded in the festive, dance-oriented tradition of tropical and salsa music, contributing to a scene that values the communal, celebratory experience of Caribbean popular entertainment.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'asdrubar';
UPDATE artists SET bio_en = 'Asdrubar is a Dominican salsa and tropical musician from Santo Domingo whose career reflects the Dominican contribution to the salsa tradition — a genre that the island has embraced and made its own despite salsa''s primary historical identification with Puerto Rico and New York. His work in both salsa and tropical places him within the broader Caribbean popular music conversation, connecting Dominican musical culture to the pan-Caribbean rhythmic dialogue that has always informed the island''s artists. Asdrubar has performed and recorded in the festive, dance-oriented tradition of tropical and salsa music, contributing to a scene that values the communal, celebratory experience of Caribbean popular entertainment.', bio_es = NULL, first_name = 'Asdrúbar', middle_name = NULL, last_name = 'Báez', second_last_name = NULL, date_of_birth = NULL, province = 'Distrito Nacional' WHERE slug = 'asdrubar';

COMMIT;
