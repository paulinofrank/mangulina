BEGIN;

-- Revierte 20260908005200_cuco_valoy_awards.sql.
--
-- NO SE TOCAN las tres categorías preexistentes que reutilizó: Salsa de Congo
-- de Oro, El Gran Soberano y Premio a la Excelencia Musical.

DELETE FROM artist_awards
 WHERE artist_id = 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d'::uuid
   AND category_id IN (
     'a1f60c78-2d94-4b55-8e17-93cb70d18a26'::uuid,
     '49479a22-46c0-401a-b5df-e8028dc7f235'::uuid,
     '26e1ac30-c00d-4cc8-922f-bd7fd58502ce'::uuid,
     'd2799d5d-a14f-4f49-a317-52199253a8f5'::uuid
   );

DELETE FROM award_categories ac
 WHERE ac.id = '49479a22-46c0-401a-b5df-e8028dc7f235'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

COMMIT;
