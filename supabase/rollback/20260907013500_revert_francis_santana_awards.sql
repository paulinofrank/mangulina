BEGIN;

-- Revierte 20260907013500_francis_santana_awards.sql.
-- Orden inverso por las claves foráneas: adjudicaciones, categorías, premios.

DELETE FROM artist_awards
 WHERE artist_id = '3a69af3c-1b9a-402b-8a3f-66e51dacdffe'::uuid
   AND award_id IN ('2b6d84f1-3a95-4c07-8e12-5d70bf9a3c48'::uuid,
                    '3c7e95a2-4ba6-4d18-9f23-6e81ca0b4d59'::uuid,
                    '4d8fa6b3-5cb7-4e29-a034-7f92db1c5e6a'::uuid);

DELETE FROM award_categories
 WHERE award_id IN ('2b6d84f1-3a95-4c07-8e12-5d70bf9a3c48'::uuid,
                    '3c7e95a2-4ba6-4d18-9f23-6e81ca0b4d59'::uuid,
                    '4d8fa6b3-5cb7-4e29-a034-7f92db1c5e6a'::uuid);

DELETE FROM awards
 WHERE id IN ('2b6d84f1-3a95-4c07-8e12-5d70bf9a3c48'::uuid,
              '3c7e95a2-4ba6-4d18-9f23-6e81ca0b4d59'::uuid,
              '4d8fa6b3-5cb7-4e29-a034-7f92db1c5e6a'::uuid);

COMMIT;
