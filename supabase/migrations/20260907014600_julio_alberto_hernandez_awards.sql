BEGIN;

-- Registra los dos reconocimientos de Julio Alberto Hernández y crea las dos
-- categorías que faltaban.
--
-- Salió al escribir su ficha, que era una de las dieciséis publicadas sin una
-- sola línea de biografía. No tenía ningún premio guardado.
--
-- DOS CATEGORÍAS NUEVAS SOBRE ENTIDADES QUE YA EXISTEN. No hace falta crear
-- ningún premio.
--
--   "Orden del Mérito de Duarte, Sánchez y Mella" bajo Gobierno de la República
--   Dominicana, que hasta ahora solo tenía la Orden Heráldica de Cristóbal
--   Colón y la Gloria Nacional de la Comunicación. Es la condecoración civil
--   dominicana y va a faltar para más artistas, así que se registra el nombre
--   de la orden y el GRADO va en el campo work, que es donde cabe sin
--   multiplicar categorías: un mismo galardón se otorga en varios grados.
--
--   "Profesor Honorario" bajo Universidad Autónoma de Santo Domingo. NO SE
--   REUTILIZA la de "Profesor Honoris Causa" que creé para Yaqui Núñez del
--   Risco. Son distinciones distintas: a él lo invistieron Honoris Causa en un
--   acto de la Biblioteca Pedro Mir, y a Hernández lo declararon Profesor
--   Honorario de la Facultad de Humanidades. Fundirlas perdería la diferencia.
--
-- LAS DOS ADJUDICACIONES
--
--   1966  Gobierno  Orden del Mérito de Duarte, Sánchez y Mella, grado de oficial
--   1977  UASD      Profesor Honorario de la Facultad de Humanidades
--
-- FUENTE ÚNICA: Wikipedia en español, que da los dos años pero no la fecha
-- exacta de ninguno. Queda anotado en el campo source.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260907014600_revert_julio_alberto_hernandez_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('a4c19e35-7b62-4d08-9e41-3fa7c25d60b8'::uuid,
   'be773efd-7e6d-444d-90be-00d74f8a2cf4'::uuid,
   'Orden del Mérito de Duarte, Sánchez y Mella'),
  ('b5d20f46-8c73-4e19-af52-40b8d36e71c9'::uuid,
   'c507319b-ad46-4eb2-df39-803bca276e53'::uuid,
   'Profesor Honorario')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('0e61046c-e96d-400b-819c-f9de8cbacba1'::uuid,
   'be773efd-7e6d-444d-90be-00d74f8a2cf4'::uuid,
   'a4c19e35-7b62-4d08-9e41-3fa7c25d60b8'::uuid,
   1966, 'Grado de Oficial', true,
   'Wikipedia (es); la fuente da el año pero no la fecha'),
  ('0e61046c-e96d-400b-819c-f9de8cbacba1'::uuid,
   'c507319b-ad46-4eb2-df39-803bca276e53'::uuid,
   'b5d20f46-8c73-4e19-af52-40b8d36e71c9'::uuid,
   1977, 'Facultad de Humanidades', true,
   'Wikipedia (es); la fuente da el año pero no la fecha');

COMMIT;
