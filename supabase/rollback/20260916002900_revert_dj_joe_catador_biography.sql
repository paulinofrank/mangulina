BEGIN;

-- Revierte 20260916002900_rewrite_dj_joe_catador_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'dj-joe-catador' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'dj-joe-catador') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"DJ Joe Catador, born Joel Tapia in the Dominican Republic, built one of the most recognizable brands in Dominican Latin urban entertainment through a combination of nightclub work, radio broadcasting, television appearances, and live performance. His stage name became synonymous with high-energy events and a knack for reading crowds, qualities that translated equally well into media work where his personality and knowledge of Dominican urban music made him a compelling on-air presence. Tapia''s career reflected the evolution of Dominican DJ culture from the nightclub booth into the broader entertainment industry, where DJs increasingly became full-spectrum media personalities. His ability to connect with audiences across multiple platforms — from the dance floor to the radio dial to the television screen — gave him a durability that many of his contemporaries lacked, and he remained a recognized voice in Dominican urban entertainment across different eras of the genre''s development.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dj-joe-catador';
UPDATE artists SET bio_en = 'DJ Joe Catador, born Joel Tapia in the Dominican Republic, built one of the most recognizable brands in Dominican Latin urban entertainment through a combination of nightclub work, radio broadcasting, television appearances, and live performance. His stage name became synonymous with high-energy events and a knack for reading crowds, qualities that translated equally well into media work where his personality and knowledge of Dominican urban music made him a compelling on-air presence. Tapia''s career reflected the evolution of Dominican DJ culture from the nightclub booth into the broader entertainment industry, where DJs increasingly became full-spectrum media personalities. His ability to connect with audiences across multiple platforms — from the dance floor to the radio dial to the television screen — gave him a durability that many of his contemporaries lacked, and he remained a recognized voice in Dominican urban entertainment across different eras of the genre''s development.', bio_es = NULL,
       first_name = 'Joel', middle_name = NULL, second_last_name = NULL,
       occupations = '[]'::jsonb,
       primary_genre = NULL, genres = ARRAY['urbano','urban-reggaeton']::text[]
       WHERE slug = 'dj-joe-catador';

COMMIT;
