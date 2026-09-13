BEGIN;

-- Registra las trece adjudicaciones de El Chaval de la Bachata, que no tenía
-- ninguna guardada, y devuelve a su dueño un alias que estaba en la fila
-- equivocada.
--
-- Salió al reescribir su ficha, la decimoquinta de las 211 que seguían solo en
-- inglés.
--
-- DOS GANADOS
--
--   2009  Premios Casandra  Bachata del Año     Donde están esos amigos
--   2026  Premios Soberano  Bachatero del Año   41.a entrega, 18 de marzo
--
-- ONCE NOMINACIONES, que en este caso valen tanto como los premios: es un
-- artista que lleva veinte años en las listas de nominados de su categoría.
--
--   2006  Casandra   Bachata del Año      Estoy perdido
--   2009  Casandra   Bachatero del Año
--   2009  Casandra   Compositor del Año
--   2009  Billboard  Canción Tropical Airplay   Donde están esos amigos
--   2010  Casandra   Bachata del Año      Lo que me pidas
--   2010  Casandra   Bachatero del Año
--   2017  Soberano   Bachata del Año      No soy tu marido
--   ----  Soberano   Bachata del Año      Dile a él
--   ----  Soberano   Bachatero del Año
--   2024  Soberano   Bachata del Año      Mujer sin alma, con Luis Miguel del Amargue
--   2024  Soberano   Bachatero del Año
--
-- DOS VAN CON year NULL A PROPÓSITO. Las nominaciones por "Dile a él" y la de
-- bachatero del año que la acompaña están documentadas, pero mi fuente las
-- coloca en un tramo narrativo de 2022 a 2024 sin dar la edición. Entre 2022 y
-- 2024 hubo dos galas y no tengo con qué escoger. NULL es la convención de la
-- tabla para adjudicaciones sin fecha, y es preferible a inventar un año.
--
-- UNA CATEGORÍA NUEVA: "Canción Tropical Airplay" bajo Premios Billboard de la
-- Música Latina, que solo tenía "Álbum Tropical del Año".
--
-- ADVERTENCIA SOBRE ESA ENTIDAD: el catálogo tiene CUATRO cuerpos Billboard
-- distintos -- 'Billboard Latin Music', 'Billboard Latin Music Awards',
-- 'Billboard Latin Women in Music' y 'Premios Billboard de la Música Latina' --
-- y al menos los dos primeros y el cuarto son el mismo premio. Uso el de nombre
-- español porque es el que usa mi fuente y el que ya tiene una categoría en
-- español. NO CONSOLIDO NADA AQUÍ: la fusión de esas entidades es un trabajo
-- aparte y ya estaba en la lista de pendientes.
--
-- EL REPARTO CASANDRA / SOBERANO LO DECIDE LA FECHA, como siempre: el galardón
-- cambió de nombre en 2012.
--
-- ---------------------------------------------------------------------------
-- EL ALIAS QUE ESTABA EN LA FILA EQUIVOCADA
--
-- La fila de El Chaval guardaba 'Los Infantiles del Amargue' entre sus alias.
-- NO ES UN ALIAS SUYO: es la agrupación que fundó en 1994 con Juan y Joel
-- Tavárez, y que después pasó a llamarse Los Jóvenes del Amargue.
--
-- Ese grupo SÍ TIENE FICHA, `los-jovenes-del-amargue`, publicada y con los
-- alias vacíos. La migración de la biografía ya sacó el alias de la persona;
-- esta lo pone donde corresponde, en la fila del grupo, para que quien busque
-- "Los Infantiles del Amargue" llegue a la agrupación y no al cantante.
--
-- Es el mismo problema que tiene 'Transporte Urbano', que solo existe como
-- alias sobre dos personas y por eso se dio por presente sin estarlo.
--
-- LA FICHA DEL GRUPO SIGUE HACIENDO FALTA: 284 caracteres, el nombre sin
-- acentos y primary_role 'singer' sobre una fila de tipo 'group'. Aquí no se
-- toca nada de eso.
-- ---------------------------------------------------------------------------
--
-- FUENTES: Wikipedia en español, artículo "El chaval de la bachata",
-- referenciado a Listín Diario (nominados Casandra 2009), Diario Libre
-- (ganadores Casandra 2009 y entrada en Billboard), Ocio Latino, Hoy Digital
-- (nominados Casandra 2006), Diario Digital RD (ganadores Casandra 2010),
-- Monitor Latino y El Nacional. Para el Soberano de 2026, Diario Libre, El Día
-- y Revista Mercado del 18 y 19 de marzo de 2026.
--
-- year ES EL AÑO DE LA CEREMONIA.
--
-- PARA REVERTIR: supabase/rollback/20260908007200_revert_el_chaval_awards_and_group_alias.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('41088954-85ae-4896-baa3-fff570b811f0'::uuid,
   '8289b930-1899-4160-8af8-e8c1d59d2c9c'::uuid, 'Canción Tropical Airplay')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  -- Ganados
  ('8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '4e6a932d-4c49-4a48-95e1-cc8ecadf1d1f'::uuid, 2009, 'Donde están esos amigos', true,
   'Wikipedia (es), citando a Diario Libre y Ocio Latino del 25 de marzo de 2009'),
  ('8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   'e016ac69-513d-4a40-b636-e148aae081c0'::uuid, 2026, '41.a entrega, 18 de marzo de 2026', true,
   'Diario Libre, El Día y Revista Mercado, 18 y 19 de marzo de 2026'),

  -- Nominaciones fechadas
  ('8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '4e6a932d-4c49-4a48-95e1-cc8ecadf1d1f'::uuid, 2006, 'Estoy perdido', false,
   'Wikipedia (es), citando a Hoy Digital del 31 de enero de 2006'),
  ('8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'ba7087a5-4bf5-4a90-888c-554e335217d2'::uuid, 2009, NULL, false,
   'Wikipedia (es), citando la lista de nominados de Listín Diario del 2 de febrero de 2009'),
  ('8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '7e32c2ae-1b52-4624-b03e-0d4934cc6fee'::uuid, 2009, NULL, false,
   'Wikipedia (es), citando la lista de nominados de Listín Diario del 2 de febrero de 2009'),
  ('8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid, '8289b930-1899-4160-8af8-e8c1d59d2c9c'::uuid,
   '41088954-85ae-4896-baa3-fff570b811f0'::uuid, 2009, 'Donde están esos amigos', false,
   'Wikipedia (es), citando a El Nacional del 18 de febrero de 2009'),
  ('8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '4e6a932d-4c49-4a48-95e1-cc8ecadf1d1f'::uuid, 2010, 'Lo que me pidas', false,
   'Wikipedia (es), citando a Diario Digital RD del 17 de marzo de 2010'),
  ('8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'ba7087a5-4bf5-4a90-888c-554e335217d2'::uuid, 2010, 'Lo que me pidas', false,
   'Wikipedia (es), citando a Diario Digital RD del 17 de marzo de 2010'),
  ('8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   '3ba3ced3-dcbf-4436-8356-5f9f41f1546e'::uuid, 2017, 'No soy tu marido', false,
   'Wikipedia (es); Monitor Latino, 28 de junio de 2016'),
  ('8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   '3ba3ced3-dcbf-4436-8356-5f9f41f1546e'::uuid, 2024, 'Mujer sin alma, nominación compartida con Luis Miguel del Amargue', false,
   'Wikipedia (es), tramo de 2024'),
  ('8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   'e016ac69-513d-4a40-b636-e148aae081c0'::uuid, 2024, NULL, false,
   'Wikipedia (es), tramo de 2024'),

  -- Nominaciones sin edición identificada
  ('8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   '3ba3ced3-dcbf-4436-8356-5f9f41f1546e'::uuid, NULL, 'Dile a él; la fuente no identifica la edición, entre 2022 y 2024', false,
   'Wikipedia (es), citando a MinayaPR del 17 de octubre de 2023'),
  ('8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   'e016ac69-513d-4a40-b636-e148aae081c0'::uuid, NULL, 'La fuente no identifica la edición, entre 2022 y 2024', false,
   'Wikipedia (es), citando a MinayaPR del 17 de octubre de 2023');

-- El alias del grupo, devuelto a la fila del grupo.
UPDATE artists
   SET aliases = ARRAY['Los Infantiles del Amargue']
 WHERE slug = 'los-jovenes-del-amargue'
   AND coalesce(cardinality(aliases), 0) = 0;

COMMIT;
