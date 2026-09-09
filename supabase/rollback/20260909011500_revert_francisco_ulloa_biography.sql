BEGIN;

-- Revierte 20260909011500_rewrite_francisco_ulloa_biography.sql
--
-- Aviso: el estado anterior incluye birth_year 1941, sin fuente, y un texto
-- de relleno que da por muerto a Francisco Ulloa, que está vivo. Restaurar
-- esto vuelve a publicar ambos errores.

-- 1. Referencias y documentos editoriales
DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'francisco-ulloa' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'francisco-ulloa')
   AND document_type = 'artist_biography';

-- 2. Campos y espejo legacy: estado anterior a la reescritura
UPDATE artists SET
  birth_year  = 1941,
  occupations = '["musician","bandleader","composer"]'::jsonb,
  instruments = NULL,
  bio_es      = NULL,
  bio_en      = 'Francisco Ulloa was one of the most beloved and influential accordion players in Dominican merengue típico, born in 1941 in Altamira in the Puerto Plata province. He dedicated his life to the button accordion — the instrument at the heart of merengue típico — and became one of its foremost practitioners, playing with a joyful, improvisational style that made his performances feel simultaneously disciplined and completely alive.

Ulloa was a master of the perico ripiao tradition, the raw and earthy form of merengue that preceded the big-band arrangements of the mid-twentieth century and that remains the living root of Dominican popular music. His recordings documented an essential strand of Dominican musical heritage and introduced the típico tradition to audiences who might otherwise never have encountered it.

Ulloa performed internationally, bringing the sounds of the Dominican countryside to concert halls and festivals around the world, and he was widely recognized as an ambassador of authentic Dominican folk music. His death was mourned by musicians and music lovers who understood that in Francisco Ulloa, the Dominican Republic had possessed a musician of rare gifts and even rarer authenticity.'
WHERE slug = 'francisco-ulloa';

COMMIT;
