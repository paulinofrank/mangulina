BEGIN;

-- Revierte 20260908003000_carlos_piantini_awards.sql.
--
-- NO SE TOCAN las dos órdenes dominicanas, que ya existían y las usan Julio
-- Alberto Hernández y Luis Kalaff.

DELETE FROM artist_awards
 WHERE artist_id = 'ebd75bb5-0571-4199-9474-22d173b3d072'::uuid
   AND category_id IN (
     'cf9689f4-6d58-4191-bf9e-20e7e86d819d'::uuid,
     '8db219a6-f19b-4327-a978-9fd8d1e61dd4'::uuid,
     'e1ecf47b-1afe-451a-853b-c8f002ecddeb'::uuid,
     'a4c19e35-7b62-4d08-9e41-3fa7c25d60b8'::uuid
   );

DELETE FROM award_categories ac
 WHERE ac.id IN (
     'cf9689f4-6d58-4191-bf9e-20e7e86d819d'::uuid,
     '8db219a6-f19b-4327-a978-9fd8d1e61dd4'::uuid
   )
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

DELETE FROM awards a
 WHERE a.id = 'a083d32d-26ee-4ef8-a2da-906d87815514'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.award_id = a.id)
   AND NOT EXISTS (SELECT 1 FROM award_categories x WHERE x.award_id = a.id);

COMMIT;
