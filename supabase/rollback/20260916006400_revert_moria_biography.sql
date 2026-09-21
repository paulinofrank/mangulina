BEGIN;

-- Revierte 20260916006400_rewrite_moria_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'moria' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'moria') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"MÓRIA is a young Dominican artist born in 1997 whose stage name — drawn from the Tolkien mythology of a great underground kingdom — suggests an artistic personality drawn to the dramatic, the mythological, and the epic. Working in the contemporary Dominican music environment, MÓRIA brings a naming sensibility that sets them apart from the more streetwise aliases common in urban Dominican music, signaling an interest in storytelling, world-building, and the kind of artistic ambition that draws on fantasy and myth as well as lived experience. Their work participates in the diverse and evolving landscape of Dominican popular music, adding a distinctive creative voice to a scene known for its rhythmic vitality and its capacity to absorb and transform diverse influences.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'moria';
UPDATE artists SET bio_en = 'MÓRIA is a young Dominican artist born in 1997 whose stage name — drawn from the Tolkien mythology of a great underground kingdom — suggests an artistic personality drawn to the dramatic, the mythological, and the epic. Working in the contemporary Dominican music environment, MÓRIA brings a naming sensibility that sets them apart from the more streetwise aliases common in urban Dominican music, signaling an interest in storytelling, world-building, and the kind of artistic ambition that draws on fantasy and myth as well as lived experience. Their work participates in the diverse and evolving landscape of Dominican popular music, adding a distinctive creative voice to a scene known for its rhythmic vitality and its capacity to absorb and transform diverse influences.', bio_es = NULL, gender = NULL, occupations = '[]'::jsonb,
       aliases = ARRAY[]::text[] WHERE slug = 'moria';

COMMIT;
