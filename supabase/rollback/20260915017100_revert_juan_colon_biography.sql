BEGIN;

-- Revierte 20260915017100_rewrite_juan_colon_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla.
--
-- Nota: el script w389 se ejecutó dos veces (la primera con genres=['jazz'] duplicando el
-- primary_genre recién corregido, detectado por verificar.cjs y corregido antes de la segunda
-- corrida), así que su captura automática de "previos" reflejaba ya el estado corregido, no el
-- original. Este rollback se reescribió a mano con el bio_en de relleno y los valores de campo
-- capturados en la primera lectura de la fila, antes de cualquier cambio.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-colon' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'juan-colon') AND document_type = 'artist_biography';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Colón is a Dominican musician born in 1948 in Mao, a city in the northwestern Valverde province, whose career has navigated the interlinked worlds of merengue, Latin jazz, and tropical music. Mao sits in a region with its own musical character shaped by the agricultural rhythms and cultural traditions of the Cibao''s western reaches, and Colón''s musical identity reflects those roots even as his work expanded into the more cosmopolitan territory of Latin jazz. His blending of merengue''s rhythmic urgency with jazz harmony and tropical warmth places him within a tradition of Dominican musicians who have worked to demonstrate the sophistication that Caribbean popular music contains when taken seriously as an art form. Colón''s career has unfolded over several decades, contributing to the richness of Dominican music both as a performer and as a figure who carried regional musical identity into broader national and international contexts."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-colon';

UPDATE artists SET bio_en = 'Juan Colón is a Dominican musician born in 1948 in Mao, a city in the northwestern Valverde province, whose career has navigated the interlinked worlds of merengue, Latin jazz, and tropical music. Mao sits in a region with its own musical character shaped by the agricultural rhythms and cultural traditions of the Cibao''s western reaches, and Colón''s musical identity reflects those roots even as his work expanded into the more cosmopolitan territory of Latin jazz. His blending of merengue''s rhythmic urgency with jazz harmony and tropical warmth places him within a tradition of Dominican musicians who have worked to demonstrate the sophistication that Caribbean popular music contains when taken seriously as an art form. Colón''s career has unfolded over several decades, contributing to the richness of Dominican music both as a performer and as a figure who carried regional musical identity into broader national and international contexts.', bio_es = NULL,
       primary_genre = 'merengue', occupations = '[]'::jsonb, genres = ARRAY['jazz']::text[]
WHERE slug = 'juan-colon';

COMMIT;
