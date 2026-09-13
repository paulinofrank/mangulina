BEGIN;

-- Revierte 20260908005000_los_hermanos_rosario_awards.sql.
--
-- NO SE TOCAN las cuatro categorías preexistentes que reutilizó.

DELETE FROM artist_awards
 WHERE artist_id = '3422883e-7048-48af-bb03-c68c8c557ee4'::uuid
   AND category_id IN (
     '9ad70fe5-bc53-4a0a-8abb-6a94fea5e640'::uuid,
     '491dc7fe-129c-47b9-bfb8-e3258a2205a4'::uuid,
     'be2c9d51-79a2-4f1c-9ae4-8e2f0b6d4a37'::uuid,
     'ea68bb41-6dc4-4b72-885c-25d3450082d1'::uuid,
     'f9c96520-c8ff-4342-bc7b-91b50878f74f'::uuid
   );

DELETE FROM award_categories ac
 WHERE ac.id = 'be2c9d51-79a2-4f1c-9ae4-8e2f0b6d4a37'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

COMMIT;
