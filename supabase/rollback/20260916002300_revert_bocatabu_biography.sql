BEGIN;

-- Revierte 20260916002300_rewrite_bocatabu_biography.sql con los documentos, el premio y los
-- campos que la ficha tenía justo antes de aplicarla (capturados por el script).

DELETE FROM artist_awards WHERE id = '9d6bd077-2916-47cc-a037-cdac19f8b13b';
DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'bocatabu' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'bocatabu') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Bocatabú is a Dominican rock band that has distinguished itself within the country''s alternative music scene through a sound that blends pop rock, indie sensibility, and alternative textures into an accessible but artistically serious body of work. Operating in a musical landscape dominated by tropical and urban genres, the band has consistently championed the idea that Dominican artists can make compelling rock and indie music that speaks to local experiences without being derivative of foreign models.","type":"text"}]},{"type":"paragraph","content":[{"text":"Their recordings demonstrate tight ensemble playing, strong melodic instincts, and a lyrical voice that engages with the realities of contemporary Dominican life in ways that connect with an audience hungry for that kind of honest reflection. Bocatabú has been part of a small but vital community of Dominican rock and alternative artists who have worked to build the infrastructure — venues, media, fan communities — necessary to sustain their kind of music in a market that does not automatically prioritize it.","type":"text"}]},{"type":"paragraph","content":[{"text":"Their persistence and artistic integrity have earned them a devoted following among Dominican music fans who seek out sounds beyond the mainstream.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bocatabu';
UPDATE artists SET bio_en = 'Bocatabú is a Dominican rock band that has distinguished itself within the country''s alternative music scene through a sound that blends pop rock, indie sensibility, and alternative textures into an accessible but artistically serious body of work. Operating in a musical landscape dominated by tropical and urban genres, the band has consistently championed the idea that Dominican artists can make compelling rock and indie music that speaks to local experiences without being derivative of foreign models.

Their recordings demonstrate tight ensemble playing, strong melodic instincts, and a lyrical voice that engages with the realities of contemporary Dominican life in ways that connect with an audience hungry for that kind of honest reflection. Bocatabú has been part of a small but vital community of Dominican rock and alternative artists who have worked to build the infrastructure — venues, media, fan communities — necessary to sustain their kind of music in a market that does not automatically prioritize it.

Their persistence and artistic integrity have earned them a devoted following among Dominican music fans who seek out sounds beyond the mainstream.', bio_es = NULL,
       formation_year = NULL,
       occupations = '[]'::jsonb
       WHERE slug = 'bocatabu';

COMMIT;
