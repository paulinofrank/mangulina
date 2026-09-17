BEGIN;

-- Revierte 20260916002700_rewrite_grupo_rush_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'grupo-rush' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'grupo-rush') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Grupo Rush is a Dominican musical ensemble working in the bachata and tropical traditions, genres that have been central to Dominican popular music for decades. Bachata, with its intimate guitar work, emotional directness, and themes of romantic longing and heartbreak, provides the emotional core of the group''s musical identity, while their engagement with tropical sounds gives their repertoire a breadth that extends their appeal across different segments of the Dominican music audience. Grupo Rush has built a following among fans of traditional Dominican popular music who appreciate the earnestness and musical craftsmanship that good bachata and tropical performance require. Their work contributes to the ongoing vitality of these genres at a time when they must compete with urban and electronic styles for audience attention, and their continued presence on the Dominican music scene reflects the enduring appetite for the sounds that have defined Dominican popular culture across generations.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'grupo-rush';
UPDATE artists SET bio_en = 'Grupo Rush is a Dominican musical ensemble working in the bachata and tropical traditions, genres that have been central to Dominican popular music for decades. Bachata, with its intimate guitar work, emotional directness, and themes of romantic longing and heartbreak, provides the emotional core of the group''s musical identity, while their engagement with tropical sounds gives their repertoire a breadth that extends their appeal across different segments of the Dominican music audience. Grupo Rush has built a following among fans of traditional Dominican popular music who appreciate the earnestness and musical craftsmanship that good bachata and tropical performance require. Their work contributes to the ongoing vitality of these genres at a time when they must compete with urban and electronic styles for audience attention, and their continued presence on the Dominican music scene reflects the enduring appetite for the sounds that have defined Dominican popular culture across generations.', bio_es = NULL,
       formation_year = NULL,
       occupations = '["musician"]'::jsonb
       WHERE slug = 'grupo-rush';

COMMIT;
