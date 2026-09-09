BEGIN;

-- Revierte 20260909011300_rewrite_belkis_concepcion_biography.sql
-- Devuelve la ficha al relleno legacy en inglés, sin documentos y sin la
-- relación de fundación.

-- 1. Referencias y documentos editoriales
DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'belkis-concepcion' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'belkis-concepcion')
   AND document_type = 'artist_biography';

-- 2. Espejo legacy: texto anterior a la reescritura
UPDATE artists SET
  bio_es = NULL,
  bio_en = 'Belkis Concepción is a Dominican merengue and tropical artist from Santo Domingo whose career has contributed to the ongoing vitality of Dominican popular dance music. Working in two of the genres most central to Dominican musical identity, she has performed and recorded music that connects with the broad audience that has sustained merengue and tropical through decades of changing musical fashions. As a woman in the merengue tradition, Concepción participates in the long line of Dominican female artists who have contributed powerfully to a genre historically dominated by male voices, bringing their own perspective and vocal character to music that represents the national sound of the Dominican Republic.'
WHERE slug = 'belkis-concepcion';

-- 3. Relación de fundación
DELETE FROM artist_relationships
 WHERE source_artist_id = (SELECT id FROM artists WHERE slug = 'belkis-concepcion')
   AND target_artist_id = (SELECT id FROM artists WHERE slug = 'las-chicas-del-can')
   AND relationship_type = 'founder_of';

COMMIT;
