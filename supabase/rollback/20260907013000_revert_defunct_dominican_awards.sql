BEGIN;

-- Revierte 20260907013000_add_defunct_dominican_awards.sql.
--
-- Se borra en orden inverso: primero las adjudicaciones, luego las categorías,
-- luego los premios, porque las claves foráneas van en esa dirección.

DELETE FROM artist_awards
 WHERE award_id IN ('c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
                    'd4b8e615-2c07-4a3f-81de-96af1b70c359'::uuid,
                    'e7c93b28-6f41-4d80-a2b5-1e8dc4076f9a'::uuid,
                    'f2d146ae-9b35-4c72-8e60-5a37cb91d284'::uuid);

DELETE FROM award_categories
 WHERE award_id IN ('c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
                    'd4b8e615-2c07-4a3f-81de-96af1b70c359'::uuid,
                    'e7c93b28-6f41-4d80-a2b5-1e8dc4076f9a'::uuid,
                    'f2d146ae-9b35-4c72-8e60-5a37cb91d284'::uuid);

DELETE FROM awards
 WHERE id IN ('c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
              'd4b8e615-2c07-4a3f-81de-96af1b70c359'::uuid,
              'e7c93b28-6f41-4d80-a2b5-1e8dc4076f9a'::uuid,
              'f2d146ae-9b35-4c72-8e60-5a37cb91d284'::uuid);

COMMIT;
