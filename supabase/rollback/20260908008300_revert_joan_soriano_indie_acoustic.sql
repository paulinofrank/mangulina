BEGIN;

-- Revierte 20260908008300_joan_soriano_indie_acoustic.sql.
--
-- Borra la adjudicacion y, solo si nadie mas las usa, la categoria y la entidad
-- que esta migracion creo.

DELETE FROM artist_awards
 WHERE artist_id = '4d9ac6ac-6802-47f4-8731-5fa567713513'::uuid
   AND category_id = 'bd9cd8a7-49a7-46f6-b38e-0565fd455fd1'::uuid;

DELETE FROM award_categories ac
 WHERE ac.id = 'bd9cd8a7-49a7-46f6-b38e-0565fd455fd1'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

DELETE FROM awards aw
 WHERE aw.id = 'ddfd9121-8fcd-47d5-b0d9-44cbac324ee3'::uuid
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = aw.id)
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.award_id = aw.id);

COMMIT;
