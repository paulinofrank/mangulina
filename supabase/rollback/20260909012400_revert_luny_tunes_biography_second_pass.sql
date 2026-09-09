BEGIN;

-- Revierte 20260909012400_rewrite_luny_tunes_biography_second_pass.sql
--
-- Ojo: no se guarda copia del documento de la primera versión, así que
-- revertir deja la ficha sin documentos y sin espejo, deshaciendo también
-- 20260909011700. La corrección de la relación member_of que hizo aquella
-- NO se toca aquí: para eso está su propio rollback.

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'luny-tunes' AND d.document_type = 'artist_biography');

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luny-tunes')
   AND document_type = 'artist_biography';

UPDATE artists SET bio_es = NULL, bio_en = NULL WHERE slug = 'luny-tunes';

COMMIT;
