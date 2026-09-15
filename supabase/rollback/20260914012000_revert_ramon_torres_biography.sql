BEGIN;

-- Revierte 20260914012000_rewrite_ramon_torres_biography.sql con los documentos y
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'ramon-torres' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-torres') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ramón Torres is a Dominican bachata artist born in 1949 in Higüey, La Altagracia, who belongs to the pioneering generation that developed bachata from its rough acoustic origins into a recognizable and ultimately beloved genre. Growing up in the eastern Dominican Republic, Torres was part of the cultural environment that produced both Los Hermanos Rosario and a significant number of other important Dominican artists. His work in bachata during the genre''s formative decades contributed to establishing the conventions and emotional vocabulary that later artists would inherit and transform. Bachata''s journey from stigmatized music of the poor to one of the world''s most recognized Latin genres owes something to every artist who committed to it before it was fashionable, and Torres is among those whose contribution deserves recognition.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'ramon-torres';
UPDATE artists SET bio_en = 'Ramón Torres is a Dominican bachata artist born in 1949 in Higüey, La Altagracia, who belongs to the pioneering generation that developed bachata from its rough acoustic origins into a recognizable and ultimately beloved genre. Growing up in the eastern Dominican Republic, Torres was part of the cultural environment that produced both Los Hermanos Rosario and a significant number of other important Dominican artists. His work in bachata during the genre''s formative decades contributed to establishing the conventions and emotional vocabulary that later artists would inherit and transform. Bachata''s journey from stigmatized music of the poor to one of the world''s most recognized Latin genres owes something to every artist who committed to it before it was fashionable, and Torres is among those whose contribution deserves recognition.', bio_es = NULL, aliases = ARRAY['El Poeta de la Bachata', 'Francisco Pache Torres']::text[] WHERE slug = 'ramon-torres';

COMMIT;
