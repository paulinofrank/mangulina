BEGIN;

-- Revierte 20260907013700_amaury_sanchez_awards.sql.
-- La fila agregada de Casandra usa una categoría preexistente que NO se borra.

DELETE FROM artist_awards
 WHERE artist_id = 'ead3e58c-4592-489b-b5d4-0319f1f6f374'::uuid
   AND (category_id = '58976d07-ec31-4b93-aeac-8130c62bb9e1'::uuid
     OR award_id   = '7e3b95c4-1d68-4f27-9a03-4c81eb2d5f36'::uuid);

DELETE FROM award_categories
 WHERE id = '8f4ca6d5-2e79-4a38-b114-5d92fc3e6047'::uuid;

DELETE FROM awards
 WHERE id = '7e3b95c4-1d68-4f27-9a03-4c81eb2d5f36'::uuid;

COMMIT;
