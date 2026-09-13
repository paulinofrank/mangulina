BEGIN;

-- Quita 'bachata' de genres en la ficha de Jeff (Jeffrey Henríquez Rijo).
--
-- Decisión del editor, 8 de septiembre de 2026, sobre lo que quedó reportado al
-- reescribir su biografía.
--
-- POR QUÉ SE REPORTÓ EN VEZ DE QUITARLO ENTONCES. En la misma pasada retiré de
-- esa fila 'instrumental-classical' de genres e 'instrumental' de artist_tags,
-- porque el propio texto publicado los declaraba erróneos: decía que su música
-- prioriza melodías y ritmos "over the traditional classical structures
-- mistakenly attributed to him previously". Eso es un error autodeclarado y
-- corregirlo no es una decisión de género.
--
-- 'bachata' era otra cosa. No encontré una sola bachata suya -- su catálogo
-- entero es reguetón romántico: Llora y Llora, Mientes, Ya No Te Quiero,
-- Perfecta, Mi Adicción, No Valió la Pena, Le Fallé al Amor -- pero el género
-- es decisión editorial y no un error que la ficha misma reconozca. Se dejó y
-- se preguntó.
--
-- ESTADO RESULTANTE: genres queda solo con 'urban-reggaeton'. primary_genre
-- sigue siendo 'urbano' y no se toca, así que la regla de que genres no repita
-- primary_genre se mantiene.
--
-- NO SE TOCA LA BIOGRAFÍA. El texto nunca dijo que hiciera bachata, así que no
-- hay nada que reescribir; el error estaba solo en el campo.
--
-- PARA REVERTIR: supabase/rollback/20260908000900_restore_bachata_in_jeff_genres.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

UPDATE artists
   SET genres = array_remove(genres, 'bachata'),
       updated_at = now()
 WHERE slug = 'jeffrey-henriquez-rijo'
   AND 'bachata' = ANY(genres);

COMMIT;
