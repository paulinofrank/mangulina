BEGIN;

-- Revierte 20260908002600_joseito_mateo_awards.sql.
--
-- Solo borra las dos adjudicaciones. NO se tocan las categorías, que ya
-- existían antes de esta migración y las usan otras fichas.

DELETE FROM artist_awards
 WHERE artist_id = '8c784f57-4ee4-41b5-b140-c45d0da1c5f6'::uuid
   AND category_id IN (
     '26e1ac30-c00d-4cc8-922f-bd7fd58502ce'::uuid,
     'd2799d5d-a14f-4f49-a317-52199253a8f5'::uuid
   );

COMMIT;
