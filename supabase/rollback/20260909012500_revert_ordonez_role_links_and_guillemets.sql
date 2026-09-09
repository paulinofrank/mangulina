BEGIN;

-- Revierte 20260909012500_ordonez_role_links_and_guillemets.sql
-- Devuelve primary_role a "instrumentalist" y occupations a su valor previo.
-- Los documentos quedan borrados: para reponerlos hay que volver a correr
-- 20260909012200, que es la versión que esta migración reescribió.

UPDATE artists
   SET primary_role = 'instrumentalist',
       occupations  = '["musician","composer","arranger"]'::jsonb
 WHERE slug = 'juan-francisco-ordonez';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-francisco-ordonez' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'juan-francisco-ordonez')
   AND document_type = 'artist_biography';

UPDATE artists SET bio_es = NULL, bio_en = NULL WHERE slug = 'juan-francisco-ordonez';

COMMIT;
