BEGIN;

-- Registra los dos reconocimientos de Estado de Luis Kalaff, que no tenía
-- ninguno guardado, y crea la categoría "Artista Meritísimo" bajo Congreso
-- Nacional de la República Dominicana.
--
-- Salió al reescribir su ficha, que era una de las 229 publicadas solo en
-- inglés y que no nombraba ninguno de los dos.
--
-- UNA CATEGORÍA NUEVA, Y NINGÚN PREMIO NUEVO
--
--   "Artista Meritísimo" bajo Congreso Nacional de la República Dominicana, que
--   hasta ahora solo tenía "Merenguero del Siglo". Es una declaratoria del
--   Senado, no un premio de industria, y el catálogo ya trata al Congreso como
--   entidad otorgante, así que cabe donde debe.
--
--   La Orden al Mérito de Duarte, Sánchez y Mella NO NECESITA CATEGORÍA NUEVA:
--   ya la creé al escribir la ficha de Julio Alberto Hernández, con el criterio
--   de que el GRADO va en el campo work para no multiplicar categorías por cada
--   grado de una misma condecoración. Kalaff la recibió en grado de caballero;
--   Hernández, en grado de oficial. Misma categoría, distinto work.
--
-- LAS DOS ADJUDICACIONES
--
--   1996  Gobierno RD        Orden del Mérito de Duarte, Sánchez y Mella, grado de caballero
--   2000  Congreso Nacional  Artista Meritísimo
--
-- EL AÑO DE LA SEGUNDA ES DERIVADO Y QUEDA DICHO. La fuente escribe "cuatro
-- años más tarde" respecto de 1996, sin dar el año. 1996 + 4 = 2000. Es
-- aritmética sobre la fuente y no un dato que la fuente dé, así que va anotado
-- en source para que quien encuentre la fecha exacta pueda corregirlo sin tener
-- que adivinar de dónde salió.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908001500_revert_luis_kalaff_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('162603e4-8662-4b5d-a812-842f7e91074f'::uuid,
   '748be643-80ea-4c18-9558-b9a1a414f4f9'::uuid,
   'Artista Meritísimo')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('dab6636c-21fd-4e34-a0a2-e59e9e147bbd'::uuid,
   'be773efd-7e6d-444d-90be-00d74f8a2cf4'::uuid,
   'a4c19e35-7b62-4d08-9e41-3fa7c25d60b8'::uuid,
   1996, 'Grado de Caballero; impuesta por el presidente Leonel Fernández', true,
   'Wikipedia (es)'),

  ('dab6636c-21fd-4e34-a0a2-e59e9e147bbd'::uuid,
   '748be643-80ea-4c18-9558-b9a1a414f4f9'::uuid,
   '162603e4-8662-4b5d-a812-842f7e91074f'::uuid,
   2000, 'Declaratoria del Senado de la República', true,
   'Wikipedia (es); la fuente dice "cuatro años más tarde" que 1996, el año está derivado');

COMMIT;
