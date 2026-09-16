BEGIN;

-- Revierte 20260916001000_rewrite_jose_bello_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-bello' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'jose-bello') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José Bello is a Dominican musician from Santo Domingo whose work in salsa, son, and tropical reflects an engagement with the Afro-Caribbean musical traditions that connect the Dominican Republic to the broader Caribbean musical world. Salsa and son — the Cuban-rooted genres that have shaped popular music across the Spanish-speaking Caribbean — provide the framework for Bello''s artistic identity, while his engagement with tropical situates him within the mainstream of Dominican popular entertainment. His work represents the Dominican contribution to the pan-Caribbean salsa tradition, a tradition in which the island has produced significant artists despite being less internationally associated with salsa than Puerto Rico or Cuba.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jose-bello';
UPDATE artists SET bio_en = 'José Bello is a Dominican musician from Santo Domingo whose work in salsa, son, and tropical reflects an engagement with the Afro-Caribbean musical traditions that connect the Dominican Republic to the broader Caribbean musical world. Salsa and son — the Cuban-rooted genres that have shaped popular music across the Spanish-speaking Caribbean — provide the framework for Bello''s artistic identity, while his engagement with tropical situates him within the mainstream of Dominican popular entertainment. His work represents the Dominican contribution to the pan-Caribbean salsa tradition, a tradition in which the island has produced significant artists despite being less internationally associated with salsa than Puerto Rico or Cuba.', bio_es = NULL,
       birth_year = NULL, date_of_birth = NULL, death_year = NULL, date_of_death = NULL,
       middle_name = NULL, second_last_name = NULL, ended = false,
       occupations = '["bandleader"]'::jsonb, genres = ARRAY[]::text[]
       WHERE slug = 'jose-bello';

COMMIT;
