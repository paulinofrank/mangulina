BEGIN;

-- Revierte 20260916006100_rewrite_adonis_produciendo_biography.sql con los documentos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'adonis-produciendo' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'adonis-produciendo') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Adonis Produciendo is a Dominican dembow and urban producer born in 2005 in Santo Domingo who has begun building a presence in Dominican urban music at a remarkably young age. Working as both a performing artist and a producer, he participates in the dual creative economy of dembow — a scene in which the producer and the artist are often equally important creative agents, with the beat carrying as much identity as the voice on top of it. Born into a generation that grew up with digital production tools as standard equipment, Adonis Produciendo represents the wave of very young Dominican creators who are shaping the next phase of Dominican urban music from bedrooms and home studios, bypassing the traditional industry infrastructure to release music directly to audiences.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'adonis-produciendo';
UPDATE artists SET bio_en = 'Adonis Produciendo is a Dominican dembow and urban producer born in 2005 in Santo Domingo who has begun building a presence in Dominican urban music at a remarkably young age. Working as both a performing artist and a producer, he participates in the dual creative economy of dembow — a scene in which the producer and the artist are often equally important creative agents, with the beat carrying as much identity as the voice on top of it. Born into a generation that grew up with digital production tools as standard equipment, Adonis Produciendo represents the wave of very young Dominican creators who are shaping the next phase of Dominican urban music from bedrooms and home studios, bypassing the traditional industry infrastructure to release music directly to audiences.', bio_es = NULL, occupations = '["producer","songwriter","dj","beatmaker"]'::jsonb WHERE slug = 'adonis-produciendo';

COMMIT;
