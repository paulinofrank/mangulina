BEGIN;

-- Revierte 20260915015600_rewrite_korven_brox_biography.sql con los documentos y campos que
-- la ficha tenía justo antes de aplicarla.
--
-- Nota: el script w374 se ejecutó dos veces (la primera con un error de tipo en la columna
-- genres, corregido antes de la segunda corrida), así que su captura automática de "previos"
-- reflejaba ya el estado corregido, no el original. Este rollback se reescribió a mano con el
-- bio_en de relleno y los valores de campo capturados en la primera lectura de la fila, antes de
-- cualquier cambio.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'korven-brox' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'korven-brox') AND document_type = 'artist_biography';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1,
  '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Korven Brox is a very young Dominican urban artist born in 2006 who represents the absolute cutting edge of the generation currently shaping Dominican music. Coming of age entirely within the era of global Dominican dembow and digital music consumption, Korven Brox is among the artists who will define what Dominican urban music sounds like in the years and decades to come. His early work in urban music reflects an artist absorbing influences and developing the skills and aesthetic identity that will eventually characterize his mature career. The Dominican Republic has demonstrated a remarkable capacity to produce new urban music talent in rapid succession, and Korven Brox is part of that continuing renewal."}]}]}'::jsonb,
  'published', id, 1 FROM artists WHERE slug = 'korven-brox';

UPDATE artists SET
  bio_en = 'Korven Brox is a very young Dominican urban artist born in 2006 who represents the absolute cutting edge of the generation currently shaping Dominican music. Coming of age entirely within the era of global Dominican dembow and digital music consumption, Korven Brox is among the artists who will define what Dominican urban music sounds like in the years and decades to come. His early work in urban music reflects an artist absorbing influences and developing the skills and aesthetic identity that will eventually characterize his mature career. The Dominican Republic has demonstrated a remarkable capacity to produce new urban music talent in rapid succession, and Korven Brox is part of that continuing renewal.',
  bio_es = NULL,
  birth_place = NULL, province = NULL, primary_genre = 'urbano',
  genres = ARRAY[]::text[], occupations = '[]'::jsonb, instruments = ARRAY[]::text[]
WHERE slug = 'korven-brox';

COMMIT;
