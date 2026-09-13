BEGIN;

-- Registra tres premios de Olga Lara, que no tenía ninguno en la base.
--
-- Salió al escribir su ficha, que era una de las dieciséis publicadas sin una
-- sola línea de biografía.
--
-- SOLO ENTRAN TRES, Y ES A PROPÓSITO. Su lista real de galardones es mucho más
-- larga, pero las dos fuentes principales SE CONTRADICEN en los años de varios
-- de ellos:
--
--   El Dorado, Cantante del Año -- olgalara.com: 1982, 1984 y 1985.
--                                  Wikipedia (es): 1981 y 1982.
--   Casandra, Cantante del Año  -- olgalara.com: 1985 y 1987.
--                                  Wikipedia (es): "Cantante más popular", 1981.
--
-- Ninguno de esos se guarda. Un premio con el año equivocado es peor que un
-- premio ausente: el ausente se nota y se corrige, el equivocado se cita.
--
-- Los tres que sí entran están confirmados por las dos fuentes o verificados
-- aparte:
--
--   1987  Casandra   Espectáculo del Año  "Héctor, que todos te conozcan y que
--                                          todos te quieran", homenaje al poeta
--                                          Héctor J. Díaz.
--   1995  Casandra   Espectáculo del Año  "Cristal", su despedida de los
--                                          escenarios en el Teatro Nacional.
--   2015  Soberano   Soberano al Mérito   Ceremonia del 14 de abril de 2015,
--                                          compartido con Vickiana. Cubierto por
--                                          La Crónica e idominicanas.
--
-- NO SE CREA NINGUNA CATEGORÍA NI NINGÚN PREMIO. Las tres filas usan entidades
-- que ya existen.
--
-- DEUDA QUE DEJO ANOTADA, y que es decisión de catálogo, no de esta ficha:
--
--   a) Los premios EL DORADO, EL ÁNGEL, EL GORDO DEL AÑO y MERENGUE DEL AÑO no
--      existen en la tabla awards. Son galardones dominicanos reales de los
--      ochenta y faltan para toda esa generación, no solo para ella.
--   b) En las categorías de "Premios Casandra" conviven "Merengue del Ano" y
--      "Merengue del Año" como filas distintas, y "Espectaculo del Ano" está sin
--      acentos mientras la de "Premios Soberano" sí los lleva. Aquí se usa la
--      que existe para Casandra, pero esas duplicaciones habría que fusionarlas.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260907012800_revert_olga_lara_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('f84b208b-dd57-43ad-b2bf-d5099e2f0e0e'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'f860b57c-cc72-4891-aa43-9e06d8c10b98'::uuid,
   1987, 'Héctor, que todos te conozcan y que todos te quieran', true,
   'olgalara.com y Wikipedia (es), coincidentes'),
  ('f84b208b-dd57-43ad-b2bf-d5099e2f0e0e'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'f860b57c-cc72-4891-aa43-9e06d8c10b98'::uuid,
   1995, 'Cristal', true,
   'olgalara.com y Wikipedia (es), coincidentes'),
  ('f84b208b-dd57-43ad-b2bf-d5099e2f0e0e'::uuid,
   'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   '1a744371-df83-426b-941f-e0b3be82efdc'::uuid,
   2015, NULL, true,
   'La Crónica e idominicanas, ceremonia del 14 de abril de 2015');

COMMIT;
