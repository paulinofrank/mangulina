BEGIN;

-- Revierte 20260916007200_rewrite_donaty_biography.sql con los documentos y campos previos.

DELETE FROM artist_awards WHERE id IN ('ae46b58f-2318-498c-8d6f-316ed911862b');

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'donaty' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'donaty') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Donaty is a young Dominican dembow and urban artist born in 2001 in Santo Domingo who has entered the Dominican urban music scene with the advantage of growing up surrounded by the genre at its mature peak. His music participates in the vibrant ecosystem of Dominican dembow production, contributing a new voice to a scene that has demonstrated a remarkable capacity for self-renewal through the continuous emergence of talented young artists. Donaty''s work reflects the current state of Dominican urban music — a genre that has absorbed international influences from trap, drill, and Afrobeats while retaining the Caribbean rhythmic core that makes it distinctively Dominican. He is part of the next chapter of that ongoing story.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'donaty';
UPDATE artists SET bio_en = 'Donaty is a young Dominican dembow and urban artist born in 2001 in Santo Domingo who has entered the Dominican urban music scene with the advantage of growing up surrounded by the genre at its mature peak. His music participates in the vibrant ecosystem of Dominican dembow production, contributing a new voice to a scene that has demonstrated a remarkable capacity for self-renewal through the continuous emergence of talented young artists. Donaty''s work reflects the current state of Dominican urban music — a genre that has absorbed international influences from trap, drill, and Afrobeats while retaining the Caribbean rhythmic core that makes it distinctively Dominican. He is part of the next chapter of that ongoing story.', bio_es = NULL, first_name = 'Yeifry', last_name = 'Sánchez', second_last_name = NULL, birth_year = 2001 WHERE slug = 'donaty';

COMMIT;
