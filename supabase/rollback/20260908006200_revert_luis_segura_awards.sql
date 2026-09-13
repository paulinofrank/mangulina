BEGIN;

-- Revierte 20260908006200_luis_segura_awards.sql.
--
-- No borra ninguna categoría: las tres ya existían antes y las usan otros
-- artistas.

DELETE FROM artist_awards
 WHERE artist_id = '5ceceef0-765d-4e01-8017-85422a263357'::uuid
   AND category_id IN (
     'd618420c-be57-4f13-ea4a-914cdb387f64'::uuid,
     '9ea19c30-6990-48fd-9fe6-e42d3c8cbb78'::uuid,
     '26e1ac30-c00d-4cc8-922f-bd7fd58502ce'::uuid
   );

COMMIT;
