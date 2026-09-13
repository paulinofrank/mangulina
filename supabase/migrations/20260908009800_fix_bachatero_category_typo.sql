BEGIN;

-- Corrige la errata del nombre de la categoria "Bachatero de Ano" bajo Premios
-- Soberano, que le falta el "del".
--
-- Bajo Premios Casandra la MISMA categoria esta bien escrita, "Bachatero del
-- Ano", asi que la ficha de un bachatero premiado antes y despues de 2012
-- mostraba el renglon escrito de dos maneras distintas. Frank Reyes, que lo
-- gano cuatro veces bajo Casandra y tres bajo Soberano, es el caso visible.
--
-- ESTO NO MUEVE NINGUNA FILA: solo cambia el texto de la categoria. Las siete
-- adjudicaciones que cuelgan de ella siguen exactamente donde estan.
--
-- NO HAY COLISION: Premios Soberano no tiene ninguna otra categoria llamada
-- "Bachatero del Ano", y la restriccion unica de `award_categories` es sobre
-- (award_id, name).
--
-- LO QUE NO SE TOCA, y queda reportado: la categoria "Casandra Especial"
-- cuelga de `Premios Soberano` cuando el galardon se llamo Casandra hasta 2012.
-- Esa NO se mueve porque su unica adjudicacion -- la de Felix del Rosario -- no
-- lleva ano, asi que ni por fecha se puede decidir a que epoca pertenece.
--
-- PARA REVERTIR: supabase/rollback/20260908009800_revert_fix_bachatero_category_typo.sql
--
-- Aplicado directamente por DATABASE_URL. No corrio ninguna funcion de Vercel
-- y no se revalido nada.

UPDATE award_categories
   SET name = 'Bachatero del Año'
 WHERE id = 'e016ac69-513d-4a40-b636-e148aae081c0'::uuid
   AND name = 'Bachatero de Año';

COMMIT;
