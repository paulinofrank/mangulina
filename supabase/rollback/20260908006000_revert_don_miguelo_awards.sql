BEGIN;

-- Revierte 20260908006000_don_miguelo_awards.sql.

DELETE FROM artist_awards
 WHERE artist_id = '6321da6c-e2d5-490a-a4e8-416bbee81edf'::uuid
   AND category_id IN (
     '95c67e14-0db9-4ea7-a0ab-6244773ea7f2'::uuid,
     'fb384842-d27c-45c7-9634-dcacd1e46493'::uuid
   );

DELETE FROM award_categories ac
 WHERE ac.id IN (
     '95c67e14-0db9-4ea7-a0ab-6244773ea7f2'::uuid,
     'fb384842-d27c-45c7-9634-dcacd1e46493'::uuid
   )
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

COMMIT;
