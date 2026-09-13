BEGIN;

-- Registra los dos grandes reconocimientos de Joseíto Mateo, que no tenía
-- ninguno guardado.
--
-- Salió al reescribir su ficha, que era una de las 229 publicadas solo en
-- inglés y que no nombraba ni uno de los dos pese a llamarlo "the undisputed
-- king of Dominican merengue".
--
-- NINGUNA CATEGORÍA NUEVA, NINGÚN PREMIO NUEVO. Las dos que hacen falta ya
-- existen:
--
--   "El Gran Soberano" bajo Premios Soberano, el máximo galardón de Acroarte.
--   "Premio a la Excelencia Musical" bajo Latin Grammy.
--
-- SOBRE LA SEGUNDA, UNA NOTA QUE CONVIENE DEJAR ESCRITA: el catálogo tiene bajo
-- Latin Grammy DOS categorías que probablemente son la misma cosa con dos
-- nombres, "Lifetime Achievement Award" y "Premio a la Excelencia Musical".
-- Johnny Pacheco quedó registrado hace unas horas con la primera, porque
-- Wikipedia en inglés lo llama así, y Joseíto queda con la segunda, porque la
-- fuente en español lo llama así y la ceremonia se lo entregó con ese nombre.
-- NO LAS FUNDO POR MI CUENTA: es decisión del editor, y mientras tanto cada
-- adjudicación queda con el nombre que le da su fuente.
--
-- LAS DOS ADJUDICACIONES
--
--   2004  Premios Soberano  El Gran Soberano
--   2010  Latin Grammy      Premio a la Excelencia Musical
--
-- LA FECHA EXACTA DE LA SEGUNDA la da la fuente: 11 de noviembre de 2010, en la
-- undécima entrega. Como la tabla guarda solo el año, el día va en work.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908002600_revert_joseito_mateo_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('8c784f57-4ee4-41b5-b140-c45d0da1c5f6'::uuid,
   'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   '26e1ac30-c00d-4cc8-922f-bd7fd58502ce'::uuid,
   2004, 'Máximo galardón de Acroarte', true, 'Wikipedia (es)'),

  ('8c784f57-4ee4-41b5-b140-c45d0da1c5f6'::uuid,
   '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid,
   'd2799d5d-a14f-4f49-a317-52199253a8f5'::uuid,
   2010, 'Entregado el 11 de noviembre, en la undécima entrega', true, 'Wikipedia (es)');

COMMIT;
