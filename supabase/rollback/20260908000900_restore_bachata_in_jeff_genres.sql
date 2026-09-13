BEGIN;

-- Revierte 20260908000900_drop_bachata_from_jeff_genres.sql.
--
-- Devuelve 'bachata' a genres en la ficha de Jeff. Se antepone al valor
-- existente para reproducir el orden que tenía la fila antes de la migración,
-- que era ['bachata','urban-reggaeton'], y el guardia de la cláusula NOT
-- impide duplicarlo si el rollback se corre dos veces.

UPDATE artists
   SET genres = ARRAY['bachata']::text[] || genres,
       updated_at = now()
 WHERE slug = 'jeffrey-henriquez-rijo'
   AND NOT ('bachata' = ANY(genres));

COMMIT;
