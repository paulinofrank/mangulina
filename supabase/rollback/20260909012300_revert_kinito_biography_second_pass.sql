BEGIN;

-- Revierte 20260909012300_rewrite_kinito_biography_second_pass.sql
--
-- Ojo: no se guarda copia del documento de la primera versión, así que
-- revertir deja la ficha en el relleno legacy, deshaciendo también
-- 20260909012100. Los apellidos y los alias que aquella corrigió NO se tocan
-- aquí: para eso está su propio rollback.

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'kinito-mendez' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'kinito-mendez')
   AND document_type = 'artist_biography';

UPDATE artists SET bio_es = NULL, bio_en = NULL WHERE slug = 'kinito-mendez';

-- El año de fundación de Rokabanda vuelve al valor anterior
UPDATE artist_relationships r
   SET start_year = 1991, notes = NULL
  FROM artists k, artists b
 WHERE r.source_artist_id = k.id AND r.target_artist_id = b.id
   AND k.slug = 'kinito-mendez' AND b.slug = 'rokabanda' AND r.relationship_type = 'founder_of';

COMMIT;
