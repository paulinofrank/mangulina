BEGIN;

-- Revierte 20260907011800. Quita los cuatro premios y las tres categorías
-- creadas para ellos, en ese orden porque artist_awards referencia a
-- award_categories.

DELETE FROM artist_awards
 WHERE artist_id = 'e8ba0f32-1d96-494d-9861-b1dc3937331e'::uuid
   AND category_id IN (
     'a1f60c78-2d94-4b55-8e17-93cb70d18a26'::uuid,
     '3c7e91a5-40b8-4d21-9f6e-2a1c85d3b70f'::uuid,
     '8b5d2f14-6c9a-4e03-b7d8-51f04a6c2e93'::uuid
   );

DELETE FROM award_categories
 WHERE id IN (
   'a1f60c78-2d94-4b55-8e17-93cb70d18a26'::uuid,
   '3c7e91a5-40b8-4d21-9f6e-2a1c85d3b70f'::uuid,
   '8b5d2f14-6c9a-4e03-b7d8-51f04a6c2e93'::uuid
 );

COMMIT;
