BEGIN;

-- Revierte 20260916009100_rewrite_lapiitoh_dangers_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'lapiitoh-dangers' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'lapiitoh-dangers') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Lapiitoh Dangers is a very young Dominican dembow and urban artist born in 2004 who represents the next wave of artists emerging from the Dominican urban music ecosystem. Growing up in an era when Dominican dembow had already established itself as a globally recognized genre through the success of artists like El Alfa, Lapiitoh Dangers entered the scene with the advantage of a fully formed sonic template and a global audience hungry for new Dominican voices. His music is part of the ongoing generational renewal of Dominican urban music, as younger artists absorb the aesthetic lessons of their predecessors and begin adding their own variations and personalities to the genre''s evolving sound.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'lapiitoh-dangers';
UPDATE artists SET bio_en = 'Lapiitoh Dangers is a very young Dominican dembow and urban artist born in 2004 who represents the next wave of artists emerging from the Dominican urban music ecosystem. Growing up in an era when Dominican dembow had already established itself as a globally recognized genre through the success of artists like El Alfa, Lapiitoh Dangers entered the scene with the advantage of a fully formed sonic template and a global audience hungry for new Dominican voices. His music is part of the ongoing generational renewal of Dominican urban music, as younger artists absorb the aesthetic lessons of their predecessors and begin adding their own variations and personalities to the genre''s evolving sound.', bio_es = NULL, first_name = 'Lapiitoh', middle_name = NULL, last_name = 'Dangers', second_last_name = NULL, birth_place = NULL, province = NULL, aliases = ARRAY[]::text[] WHERE slug = 'lapiitoh-dangers';

COMMIT;
