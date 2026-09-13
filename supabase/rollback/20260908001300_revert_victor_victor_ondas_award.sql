BEGIN;

-- Revierte 20260908001300_victor_victor_ondas_award.sql.
--
-- Borra la adjudicación, después la categoría y por último el premio, y cada
-- uno solo si ninguna otra ficha llegó a usarlo entre tanto.

DELETE FROM artist_awards
 WHERE artist_id = '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3'::uuid
   AND category_id = '52bc54a3-a08c-417a-a3ad-9c94b532e6ae'::uuid;

DELETE FROM award_categories ac
 WHERE ac.id = '52bc54a3-a08c-417a-a3ad-9c94b532e6ae'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

DELETE FROM awards a
 WHERE a.id = '24822599-3ffa-4b6a-9b11-163e51c3b64f'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.award_id = a.id)
   AND NOT EXISTS (SELECT 1 FROM award_categories x WHERE x.award_id = a.id);

COMMIT;
