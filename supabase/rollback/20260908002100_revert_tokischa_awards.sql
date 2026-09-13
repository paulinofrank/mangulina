BEGIN;

-- Revierte 20260908002100_tokischa_awards.sql.
--
-- NO SE TOCAN las tres categorías preexistentes que reutilizó: Best Dembow
-- Song, Platinum Records y Gold Records.

DELETE FROM artist_awards
 WHERE artist_id = '3e1718be-c12d-42f5-85e7-2156d9574940'::uuid
   AND category_id IN (
     'd7ec9884-2cdc-4b77-b794-1f7e88aa3cf7'::uuid,
     '0ef1e90e-cf63-4ee3-a36f-58b32f4045b6'::uuid,
     '762af833-e017-429d-952d-e92bcc06bc26'::uuid,
     'f9c96520-c8ff-4342-bc7b-91b50878f74f'::uuid,
     'ea68bb41-6dc4-4b72-885c-25d3450082d1'::uuid
   );

DELETE FROM award_categories ac
 WHERE ac.id IN (
     '0ef1e90e-cf63-4ee3-a36f-58b32f4045b6'::uuid,
     '762af833-e017-429d-952d-e92bcc06bc26'::uuid
   )
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

COMMIT;
