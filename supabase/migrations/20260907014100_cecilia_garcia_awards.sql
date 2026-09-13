BEGIN;

-- Registra siete premios de Cecilia García y crea las categorías que faltaban.
--
-- Salió al crear su ficha, que el editor marcó como obligatoria.
--
-- EL GRAN DORADO VA COMO CATEGORÍA, NO COMO PREMIO NUEVO. Al documentarla
-- apareció que el "Gran Dorado" es el máximo galardón de los mismos Premios El
-- Dorado que creé para Olga Lara, no una premiación aparte. Se añade como
-- categoría dentro de esa entidad. Si se hubiera creado como premio propio
-- habrían quedado dos filas para una sola premiación.
--
-- LAS SIETE ADJUDICACIONES QUE ENTRAN, todas con año y obra identificados:
--
--   1975  El Dorado   Actriz Cómica del Año
--   1975  El Dorado   Realizadora del Mejor Espectáculo   "100% Cecilia"
--   1984  El Dorado   Gran Dorado, Artista del Año
--   1988  Casandra    Espectáculo del Año                 "Evita"
--   2005  Casandra    Mejor Actriz                        "Victor Victoria"
--   2017  Soberano    Soberano a las Artes Escénicas
--   2017  Soberano    Mejor Actriz                        "Al Final del Arcoíris"
--
-- DOS PRIMERAS VECES QUE CONVIENE TENER PRESENTES, porque son el motivo de que
-- estos premios importen más que su conteo: el de 1975 como realizadora fue la
-- primera vez que una mujer lo recibía en la historia de esa premiación, y el
-- Soberano a las Artes Escénicas de 2017 fue el PRIMERO que se entregó en esa
-- categoría, estrenado con ella.
--
-- LO QUE NO SE REGISTRA, Y POR QUÉ:
--
--   Wikipedia dice que fue "la primera mujer en recibir en TRES ocasiones
--   diferentes el premio Gran Dorado". Solo una de las tres está fechada, la de
--   1984. Las otras dos existieron pero no tienen año en ninguna fuente que
--   encontré, y no se inventan. Faltan dos filas.
--
--   También ganó un Casandra a Mejor Actriz por "El Beso de la Mujer Araña".
--   Wikipedia no da el año de esa temporada. Falta una fila.
--
-- No se usa aquí la convención agregada de "Multiple Category Wins" porque en
-- este caso sí se sabe qué premios son y qué obra los ganó; lo único que falta
-- es el año. Agregarlos escondería información que ya tenemos.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260907014100_revert_cecilia_garcia_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('a17b3d94-5e26-4c81-9034-7fb2ae5d1c68'::uuid,
   'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid, 'Actriz Cómica del Año'),
  ('b28c4ea5-6f37-4d92-a145-80c3bf6e2d79'::uuid,
   'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid, 'Realizadora del Mejor Espectáculo del Año'),
  ('c39d5fb6-7048-4ea3-b256-91d4c07f3e8a'::uuid,
   'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid, 'Gran Dorado, Artista del Año'),
  ('d4ae60c7-8159-4fb4-c367-a2e5d1804f9b'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid, 'Mejor Actriz'),
  ('e5bf71d8-926a-4ac5-d478-b3f6e29150ac'::uuid,
   'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid, 'Soberano a las Artes Escénicas'),
  ('f6c082e9-a37b-4bd6-e589-c407f3a261bd'::uuid,
   'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid, 'Mejor Actriz')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('1abe0eae-4c2d-4706-a210-b176b2dfe7b2'::uuid,
   'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
   'a17b3d94-5e26-4c81-9034-7fb2ae5d1c68'::uuid,
   1975, NULL, true, 'Wikipedia (es)'),
  ('1abe0eae-4c2d-4706-a210-b176b2dfe7b2'::uuid,
   'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
   'b28c4ea5-6f37-4d92-a145-80c3bf6e2d79'::uuid,
   1975, '100% Cecilia', true,
   'Wikipedia (es); primera mujer en recibirlo en la historia de esa premiación'),
  ('1abe0eae-4c2d-4706-a210-b176b2dfe7b2'::uuid,
   'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
   'c39d5fb6-7048-4ea3-b256-91d4c07f3e8a'::uuid,
   1984, NULL, true,
   'Wikipedia (es); primera mujer en recibir el Gran Dorado'),
  ('1abe0eae-4c2d-4706-a210-b176b2dfe7b2'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'f860b57c-cc72-4891-aa43-9e06d8c10b98'::uuid,
   1988, 'Evita', true, 'Wikipedia (es)'),
  ('1abe0eae-4c2d-4706-a210-b176b2dfe7b2'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'd4ae60c7-8159-4fb4-c367-a2e5d1804f9b'::uuid,
   2005, 'Victor Victoria', true, 'Wikipedia (es)'),
  ('1abe0eae-4c2d-4706-a210-b176b2dfe7b2'::uuid,
   'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   'e5bf71d8-926a-4ac5-d478-b3f6e29150ac'::uuid,
   2017, NULL, true,
   'Wikipedia (es); primer Soberano a las Artes Escénicas entregado, estrenado con ella'),
  ('1abe0eae-4c2d-4706-a210-b176b2dfe7b2'::uuid,
   'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   'f6c082e9-a37b-4bd6-e589-c407f3a261bd'::uuid,
   2017, 'Al Final del Arcoíris', true, 'Wikipedia (es)');

COMMIT;
