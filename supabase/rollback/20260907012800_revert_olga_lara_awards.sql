BEGIN;

-- Revierte 20260907012800_olga_lara_awards.sql.
--
-- Borra solo las tres filas insertadas por esa migración. No toca las
-- categorías ni los premios, que ya existían y que usan otros artistas.

DELETE FROM artist_awards
 WHERE artist_id = 'f84b208b-dd57-43ad-b2bf-d5099e2f0e0e'::uuid
   AND ( (award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid AND year IN (1987, 1995))
      OR (award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid AND year = 2015) );

COMMIT;
