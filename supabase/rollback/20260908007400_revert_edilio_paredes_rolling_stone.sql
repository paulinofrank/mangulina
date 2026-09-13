BEGIN;

-- Revierte 20260908007400_edilio_paredes_rolling_stone.sql.
--
-- Borra la adjudicación y, solo si nadie más las usa, la categoría y la entidad
-- Rolling Stone que esta migración creó.

DELETE FROM artist_awards
 WHERE artist_id = 'cbda65a4-c7da-4762-8cf8-f29b942d2ac3'::uuid
   AND category_id = 'd85ab773-2659-4b2f-9772-5f587f54424b'::uuid;

DELETE FROM award_categories ac
 WHERE ac.id = 'd85ab773-2659-4b2f-9772-5f587f54424b'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

DELETE FROM awards aw
 WHERE aw.id = 'ea1d7252-d35e-44c6-bd32-d800f4cd7db0'::uuid
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = aw.id)
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.award_id = aw.id);

COMMIT;
