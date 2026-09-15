BEGIN;

-- Revierte 20260915011700_rewrite_angel_dior_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'angel-dior' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'angel-dior') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Angel Dior is a young Dominican dembow and urban artist born in 2002 in Santo Domingo who has entered the Dominican urban music scene during a period of its maximum global visibility. Working in dembow — the genre that has carried Dominican musical identity to the world stage through artists like El Alfa and Chimbala — Angel Dior participates in the generational renewal of the sound with the energy and perspective of someone who grew up with it as the defining music of his adolescence. His music is part of the ongoing proliferation of Dominican urban talent that keeps dembow fresh and competitive, adding new voices to a conversation that shows no signs of losing momentum.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'angel-dior';
UPDATE artists SET bio_en = 'Angel Dior is a young Dominican dembow and urban artist born in 2002 in Santo Domingo who has entered the Dominican urban music scene during a period of its maximum global visibility. Working in dembow — the genre that has carried Dominican musical identity to the world stage through artists like El Alfa and Chimbala — Angel Dior participates in the generational renewal of the sound with the energy and perspective of someone who grew up with it as the defining music of his adolescence. His music is part of the ongoing proliferation of Dominican urban talent that keeps dembow fresh and competitive, adding new voices to a conversation that shows no signs of losing momentum.', bio_es = NULL,
       date_of_birth = NULL,
       birth_year = 2002 WHERE slug = 'angel-dior';

COMMIT;
