BEGIN;

-- Registra los doce reconocimientos de Johnny Pacheco, que no tenía NI UNO
-- guardado, y crea el premio y las seis categorías que faltaban.
--
-- Salió al reescribir su ficha, que era una de las 229 publicadas solo en
-- inglés. La consulta a artist_awards devolvió cero filas para el dominicano
-- más condecorado de la música latina del siglo XX.
--
-- DOS FUENTES INDEPENDIENTES Y COINCIDENTES, premio por premio: su sitio
-- oficial johnnypacheco.com, comprobado hoy y en línea, y Wikipedia en inglés.
-- Donde solo lo sostiene una, queda dicho en el campo source.
--
-- UN PREMIO NUEVO
--
--   "Bobby Capó Lifetime Achievement Award", que otorga la oficina del
--   gobernador del estado de Nueva York y que a Pacheco se lo entregó George
--   Pataki en 1997. Es un galardón real, con nombre propio y entidad
--   otorgante, y no cabe dentro de ninguno de los 51 que ya existen.
--
-- SEIS CATEGORÍAS NUEVAS SOBRE PREMIOS QUE YA EXISTEN
--
--   "Best Latin Recording" bajo Grammy. Es la categoría en que fue nominado en
--   1975, la primera vez que un dominicano llegó a una nominación del Grammy.
--   Se registra con won = false: fue nominación, no premio, y la tabla
--   distingue las dos cosas.
--
--   "Governor's Award" bajo Grammy. NO ES UN GRAMMY sino un reconocimiento de
--   capítulo de la misma academia — The Recording Academy, que es justo la
--   organización que la fila del premio ya declara. Va ahí en vez de crear una
--   entidad nueva para el mismo otorgante. El capítulo va en work.
--
--   "Medalla Presidencial de Honor" bajo Gobierno de la República Dominicana,
--   que hasta ahora tenía la Orden Heráldica de Cristóbal Colón, la Orden del
--   Mérito de Duarte, Sánchez y Mella y la Gloria Nacional de la Comunicación.
--   Se la impuso Joaquín Balaguer en 1996.
--
--   "Lifetime Achievement Award" bajo International Latin Music Hall of Fame,
--   que solo tenía "Inductee". Son dos cosas distintas y Pacheco recibió las
--   dos, con cuatro años de diferencia: entró en la primera hornada del salón
--   en 1998 y en 2002 le dieron el premio a la trayectoria.
--
--   "Silver Pen Award" bajo ASCAP Latin Music.
--
--   "Primer Artista Dominicano Internacional" bajo Premios Casandra. LAS DOS
--   FUENTES LO DAN SIN AÑO, así que year queda en NULL, que la columna admite
--   y que es la convención de este catálogo para las adjudicaciones sin fecha.
--   El nombre se traduce del inglés "First International Dominican Artist
--   Award", que es como lo escriben las dos fuentes; queda anotado en source.
--
-- LAS DOCE ADJUDICACIONES
--
--   1975  Grammy        Best Latin Recording        El Maestro     NOMINACIÓN
--   1996  Gobierno RD   Medalla Presidencial de Honor
--   1996  Grammy        Governor's Award            NARAS, capítulo de Nueva York
--   1997  Bobby Capó    Lifetime Achievement
--   1998  ILMHF         Inductee                    primera hornada
--   2002  ILMHF         Lifetime Achievement Award
--   2004  ASCAP         Silver Pen Award
--   2005  Proclamación  estrella en Union City, Nueva Jersey
--   2005  Latin Grammy  Lifetime Achievement Award
--   2009  Premios Casandra  El Soberano
--   --    Premios Casandra  Primer Artista Dominicano Internacional
--   --    Sales Certifications  Gold Records          diez discos de oro
--
-- LOS DIEZ DISCOS DE ORO ENTRAN Y LAS CIFRAS DE VENTAS NO. Una certificación
-- es un hecho de industria y tiene su tabla; las 100.000 copias del primer
-- disco en Alegre, que las fuentes repiten, son cifra cruda y no se guardan.
--
-- QUEDA FUERA, POR FUENTE ÚNICA: la declaratoria del Senado de 2009 como
-- "Gloria de la música nacional y afro antillana", que solo aparece en
-- Wikipedia en español. Si se corrobora, va bajo Congreso Nacional de la
-- República Dominicana, que ya existe.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908000600_revert_johnny_pacheco_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO awards (id, name, organization, country)
VALUES
  ('c0d0fdb4-7179-4a39-84fc-df5fd4af2764'::uuid,
   'Bobby Capó Lifetime Achievement Award',
   'Oficina del Gobernador del Estado de Nueva York',
   'Estados Unidos')
ON CONFLICT (id) DO NOTHING;

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('2b139724-a4fd-4704-b78f-f0340ce85f7f'::uuid,
   '71b372a9-1781-400c-933a-4cbf2daed818'::uuid, 'Best Latin Recording'),
  ('c584e1eb-3fe1-448e-b470-dc2f7d284e9a'::uuid,
   '71b372a9-1781-400c-933a-4cbf2daed818'::uuid, 'Governor''s Award'),
  ('42513103-2a87-486d-a9e0-618186a88e52'::uuid,
   'be773efd-7e6d-444d-90be-00d74f8a2cf4'::uuid, 'Medalla Presidencial de Honor'),
  ('1c541e5e-5ff7-404e-b1a9-8a6c9677ae9a'::uuid,
   '34fe968e-bf0e-4c89-b54a-d147f37ac6be'::uuid, 'Lifetime Achievement Award'),
  ('d91419f3-5e96-4d19-84ff-06973de3159b'::uuid,
   'f11eef13-ed65-4bfd-a198-7ecfcca8ea82'::uuid, 'Silver Pen Award'),
  ('128d01e8-7cf3-4e90-b96d-244841289f6e'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid, 'Primer Artista Dominicano Internacional'),
  ('cd8e83f4-2e6c-484e-86d8-e10d06ecf7bd'::uuid,
   'c0d0fdb4-7179-4a39-84fc-df5fd4af2764'::uuid, 'Lifetime Achievement')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  -- La primera nominación de un dominicano al Grammy.
  ('e005898c-4fcc-45da-b857-c6775e92fa52'::uuid,
   '71b372a9-1781-400c-933a-4cbf2daed818'::uuid,
   '2b139724-a4fd-4704-b78f-f0340ce85f7f'::uuid,
   1975, 'El Maestro', false,
   'Wikipedia (en) y johnnypacheco.com; nominación, no premio'),

  ('e005898c-4fcc-45da-b857-c6775e92fa52'::uuid,
   'be773efd-7e6d-444d-90be-00d74f8a2cf4'::uuid,
   '42513103-2a87-486d-a9e0-618186a88e52'::uuid,
   1996, 'Impuesta por el presidente Joaquín Balaguer', true,
   'johnnypacheco.com y Wikipedia (en); Wikipedia (es) no da el año'),

  ('e005898c-4fcc-45da-b857-c6775e92fa52'::uuid,
   '71b372a9-1781-400c-933a-4cbf2daed818'::uuid,
   'c584e1eb-3fe1-448e-b470-dc2f7d284e9a'::uuid,
   1996, 'NARAS, capítulo de Nueva York; primer productor de música latina en recibirlo', true,
   'johnnypacheco.com y Wikipedia (en), coincidentes'),

  ('e005898c-4fcc-45da-b857-c6775e92fa52'::uuid,
   'c0d0fdb4-7179-4a39-84fc-df5fd4af2764'::uuid,
   'cd8e83f4-2e6c-484e-86d8-e10d06ecf7bd'::uuid,
   1997, 'Entregado por el gobernador George Pataki', true,
   'johnnypacheco.com y Wikipedia (en), coincidentes'),

  ('e005898c-4fcc-45da-b857-c6775e92fa52'::uuid,
   '34fe968e-bf0e-4c89-b54a-d147f37ac6be'::uuid,
   '698144d2-5b22-47b2-a86b-88a5ec328aae'::uuid,
   1998, 'Primera hornada de artistas del salón', true,
   'johnnypacheco.com y Wikipedia (en), coincidentes'),

  ('e005898c-4fcc-45da-b857-c6775e92fa52'::uuid,
   '34fe968e-bf0e-4c89-b54a-d147f37ac6be'::uuid,
   '1c541e5e-5ff7-404e-b1a9-8a6c9677ae9a'::uuid,
   2002, NULL, true,
   'Wikipedia (en)'),

  ('e005898c-4fcc-45da-b857-c6775e92fa52'::uuid,
   'f11eef13-ed65-4bfd-a198-7ecfcca8ea82'::uuid,
   'd91419f3-5e96-4d19-84ff-06973de3159b'::uuid,
   2004, NULL, true,
   'Wikipedia (en)'),

  ('e005898c-4fcc-45da-b857-c6775e92fa52'::uuid,
   '4bffb48f-dde1-4dd6-95ff-f8fb2c87cb92'::uuid,
   'eca0195f-bbb2-479a-9254-088e57a28f82'::uuid,
   2005, 'Estrella en el Paseo de la Fama del Celia Cruz Park, Union City, Nueva Jersey', true,
   'Wikipedia (en); la fuente da el 5 de junio de 2005'),

  ('e005898c-4fcc-45da-b857-c6775e92fa52'::uuid,
   '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid,
   '13a8654e-ea10-495c-ba3b-9b38a147725d'::uuid,
   2005, NULL, true,
   'Wikipedia (en) y (es); la edición en español lo nombra Premio a la Excelencia Musical'),

  ('e005898c-4fcc-45da-b857-c6775e92fa52'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '6d483d83-448c-4007-861d-89d53ce5f8fb'::uuid,
   2009, 'Máxima distinción de Acroarte', true,
   'Wikipedia (en) y (es); la edición en inglés da el 24 de marzo de 2009'),

  -- Sin año en ninguna de las dos fuentes.
  ('e005898c-4fcc-45da-b857-c6775e92fa52'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '128d01e8-7cf3-4e90-b96d-244841289f6e'::uuid,
   NULL, NULL, true,
   'johnnypacheco.com y Wikipedia (en), que lo llaman First International Dominican Artist Award y no lo fechan'),

  ('e005898c-4fcc-45da-b857-c6775e92fa52'::uuid,
   'd5fa3fdd-b0bf-426a-bead-1e7ff4a657b5'::uuid,
   'ea68bb41-6dc4-4b72-885c-25d3450082d1'::uuid,
   NULL, 'Diez discos de oro a lo largo de su carrera', true,
   'johnnypacheco.com y Wikipedia (en), coincidentes; agregado sin fechas');

COMMIT;
