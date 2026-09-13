BEGIN;

-- Registra los premios de Amaury Sánchez, que no tenía ninguno guardado pese a
-- ser uno de los artistas más premiados del catálogo.
--
-- Salió al escribir su ficha, que era una de las dieciséis publicadas sin una
-- sola línea de biografía.
--
-- EL PROBLEMA DE ESTA MIGRACIÓN: LOS NUEVE CASANDRA NO SE PUEDEN FECHAR.
--
-- Conectate.com.do, que es la única biografía detallada que existe de él,
-- afirma que ganó nueve Premios Casandra "en las categorías de Arreglista del
-- Año, Espectáculo Popular del Año, Mejor Musical, Mejor Concierto, entre
-- otras, así como otras 23 nominaciones". No da un solo año, y ninguna otra
-- fuente los desglosa.
--
-- Tres salidas posibles y por qué se elige la tercera:
--
--   a) Inventar nueve años plausibles. Descartado: es exactamente el error que
--      convierte un catálogo en algo que nadie puede citar.
--   b) No registrar nada. Descartado: son nueve premios reales y el editor pidió
--      expresamente que se registre todo lo que aparezca.
--   c) UNA SOLA FILA AGREGADA, con year en NULL y el detalle en work. Es la
--      convención que LA BASE YA USA para este caso: así están registrados
--      Johnny Ventura ("Multiple performance, video, production, and musical
--      category wins"), Fernando Villalona ("Several Soberano wins") y Eddy
--      Herrera ("More than seven Casandra Awards"), todos con year NULL sobre la
--      categoría "Multiple Category Wins".
--
-- Se sigue esa convención. Cuando aparezca el desglose año por año, esta fila se
-- sustituye por las nueve reales.
--
-- SE REGISTRA APARTE EL JAYCEES DE 2002, que sí tiene año. Requiere crear la
-- entidad: los Jaycees (Cámara Junior) premian anualmente a jóvenes
-- sobresalientes dominicanos en distintas áreas, no solo artísticas.
--
-- NO SE REGISTRA "Fernando Villalona Sinfónico" como premio suyo. Ese concierto
-- ganó Concierto del Año en los Soberano 2018 y él lo produjo, pero el galardón
-- es del concierto y le corresponde a Villalona en la tabla. Que Sánchez fuera
-- el productor se cuenta en la prosa de su ficha, que es donde se puede
-- explicar. En esa misma edición él estuvo NOMINADO como arreglista, y una
-- nominación no ganada tampoco se guarda como fila con won en true.
--
-- PARA REVERTIR: supabase/rollback/20260907013700_revert_amaury_sanchez_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO awards (id, name, organization, country, description)
VALUES
  ('7e3b95c4-1d68-4f27-9a03-4c81eb2d5f36'::uuid, 'Premios Jaycees',
   'Cámara Junior de la República Dominicana',
   'República Dominicana',
   'Distinción anual a jóvenes dominicanos sobresalientes en distintas áreas, entre ellas las artísticas.')
ON CONFLICT (id) DO NOTHING;

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('8f4ca6d5-2e79-4a38-b114-5d92fc3e6047'::uuid,
   '7e3b95c4-1d68-4f27-9a03-4c81eb2d5f36'::uuid, 'Joven Sobresaliente del Año')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  -- Los nueve Casandra, agregados, sin año. Ver la explicación de arriba.
  ('ead3e58c-4592-489b-b5d4-0319f1f6f374'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '58976d07-ec31-4b93-aeac-8130c62bb9e1'::uuid,
   NULL,
   'Nueve premios en categorías de arreglo, espectáculo popular, musical y concierto, más veintitrés nominaciones',
   true,
   'Conectate.com.do, 27 de marzo de 2023; la fuente no desglosa los años'),
  ('ead3e58c-4592-489b-b5d4-0319f1f6f374'::uuid,
   '7e3b95c4-1d68-4f27-9a03-4c81eb2d5f36'::uuid,
   '8f4ca6d5-2e79-4a38-b114-5d92fc3e6047'::uuid,
   2002, NULL, true,
   'Conectate.com.do, 27 de marzo de 2023');

COMMIT;
