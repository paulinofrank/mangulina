BEGIN;

-- Revierte 20260907012600_leonardo_paniagua_award.sql.
--
-- Borra solo la fila insertada por esa migración. No toca la categoría
-- "Soberano al Mérito" ni el premio "Premios Soberano", que ya existían y que
-- usan otros artistas.

DELETE FROM artist_awards
 WHERE artist_id = '31915623-3206-4052-b13a-2170226671b9'::uuid
   AND award_id  = 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid
   AND category_id = '1a744371-df83-426b-941f-e0b3be82efdc'::uuid
   AND year = 2017;

COMMIT;
