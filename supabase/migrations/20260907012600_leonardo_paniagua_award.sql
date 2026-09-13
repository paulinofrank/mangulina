BEGIN;

-- Registra el Soberano al Mérito 2017 de Leonardo Paniagua, que no tenía
-- ningún premio en la base.
--
-- Salió al escribir su ficha, que era una de las dieciséis publicadas sin una
-- sola línea de biografía.
--
-- NO SE CREA NINGUNA CATEGORÍA. "Soberano al Mérito" ya existe bajo "Premios
-- Soberano" (award dec5d9e2), así que esto es una sola fila en artist_awards.
--
-- CUATRO FUENTES INDEPENDIENTES lo confirman, y se anotan porque un premio mal
-- atribuido es de los errores que más caro cuestan:
--
--   El Caribe, lista de ganadores de los premios Soberano 2017:
--     "Soberano al Mérito: Leonardo Paniagua (por su trayectoria en bachata)."
--   Hoy Digital, "Paniagua, feliz por Soberano al Mérito", que además precisa
--     que lo entregó la Asociación de Cronistas de Arte (Acroarte).
--   La Crónica y Herrera Digital, con la misma lista de la ceremonia.
--
-- En esa misma edición el Gran Soberano fue para Cuco Valoy y el Soberano al
-- Mérito se entregó también a Josefina Miniño y Papa Molina. Se anota para que
-- quien revise sepa que la categoría admite varios galardonados por año y que
-- esta fila no es la única legítima de 2017.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260907012600_revert_leonardo_paniagua_award.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('31915623-3206-4052-b13a-2170226671b9'::uuid,
   'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   '1a744371-df83-426b-941f-e0b3be82efdc'::uuid,
   2017, NULL, true,
   'El Caribe y Hoy Digital, lista de ganadores de Premios Soberano 2017');

COMMIT;
