BEGIN;

-- Revierte 20260908003900_rafael_solano_awards.sql.
--
-- Solo borra las cuatro adjudicaciones. NO se toca ninguna categoría: las
-- cuatro ya existían antes de esta migración y las usan otras fichas.

DELETE FROM artist_awards
 WHERE artist_id = 'ba42e200-51b0-437b-99ac-1daf39ade337'::uuid
   AND category_id IN (
     'c39d5fb6-7048-4ea3-b256-91d4c07f3e8a'::uuid,
     '6d483d83-448c-4007-861d-89d53ce5f8fb'::uuid,
     'd2799d5d-a14f-4f49-a317-52199253a8f5'::uuid,
     'a4c19e35-7b62-4d08-9e41-3fa7c25d60b8'::uuid
   );

COMMIT;
