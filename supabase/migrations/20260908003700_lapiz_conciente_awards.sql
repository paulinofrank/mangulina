BEGIN;

-- Registra los cuatro reconocimientos de Lápiz Conciente, que no tenía ninguno,
-- crea los Latin Music Italian Awards y dos categorías.
--
-- Salió al reescribir su ficha, la primera de las 211 que siguen solo en inglés
-- y la que MÁS ENLACES ENTRANTES tiene de todo el catálogo: 42 biografías
-- ajenas apuntan a ella. Tenía la tabla de premios vacía.
--
-- UN PREMIO NUEVO
--
--   "Latin Music Italian Awards", que se entregan en Italia a música latina.
--   Ganó DOS categorías en la misma edición de 2016.
--
-- DOS CATEGORÍAS NUEVAS SOBRE PREMIOS QUE YA EXISTEN
--
--   "Mi Artista Urbano" bajo Premios Juventud. El premio ya tenía siete
--   categorías, todas de canción, colaboración, álbum o coreografía; ninguna de
--   artista.
--
--   "Mejor Canción Urbana" bajo Latin Grammy. OJO: NO SE REUTILIZA "Mejor
--   Fusión/Interpretación Urbana", que creé ayer para la nominación de
--   Tokischa. Son categorías distintas del mismo premio -- una es de canción y
--   la otra de interpretación -- y fundirlas atribuiría a cada artista una
--   nominación que no tuvo.
--
-- LAS CUATRO ADJUDICACIONES
--
--   2013  Premios Juventud             Mi Artista Urbano                 NOMINACIÓN
--   2014  Sales Certifications         Gold Records      Si No Te Quisiera
--   2016  Latin Music Italian Awards   Best Latin Urban Song of the Year
--   2016  Latin Music Italian Awards   My Favorite Lyrics
--   2017  Latin Grammy                 Mejor Canción Urbana   Papa       NOMINACIÓN
--
-- DOS VAN CON won = false Y ESO IMPORTA. Las de 2013 y 2017 son nominaciones,
-- no premios, y la fuente lo dice expresamente en su tabla de "Premios y
-- nominaciones". Registrarlas como ganadas le atribuiría un Latin Grammy que no
-- tiene, que es exactamente el error que encontré ayer en la ficha de Martha
-- Heredia y que motivó revisar cada premio uno por uno.
--
-- LOS NOMBRES DE LAS CATEGORÍAS ITALIANAS VAN EN INGLÉS porque así los da la
-- fuente, que cita a Diario Libre. No se traducen.
--
-- LA CERTIFICACIÓN DE ORO ES POR "SI NO TE QUISIERA", el tema con Juan Magán y
-- Belinda. La fuente da además cifras de reproducciones que NO se registran:
-- son datos de plataforma, no de industria.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908003700_revert_lapiz_conciente_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO awards (id, name, organization, country)
VALUES
  ('44cd5c30-2d0a-404c-973d-c6955d816ab4'::uuid,
   'Latin Music Italian Awards', 'Latin Music Italian Awards', 'Italia')
ON CONFLICT (id) DO NOTHING;

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('b803cead-aae8-482e-89b5-d19472fd6a02'::uuid,
   '44cd5c30-2d0a-404c-973d-c6955d816ab4'::uuid, 'Best Latin Urban Song of the Year'),
  ('cf5cc764-e539-44a1-8cd1-9f9521d99fd7'::uuid,
   '44cd5c30-2d0a-404c-973d-c6955d816ab4'::uuid, 'My Favorite Lyrics'),
  ('3a6a4278-f26b-422d-8ccb-2af9b2df16a0'::uuid,
   '8304c63b-ff51-40ed-80bb-ea7c4079ca6f'::uuid, 'Mi Artista Urbano'),
  ('2c5a2cc2-1ec0-4872-bfeb-3b2cf242bd5c'::uuid,
   '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid, 'Mejor Canción Urbana')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('102e7b78-ff98-4adc-9a54-ae73791fb176'::uuid, '8304c63b-ff51-40ed-80bb-ea7c4079ca6f'::uuid,
   '3a6a4278-f26b-422d-8ccb-2af9b2df16a0'::uuid, 2013, NULL, false,
   'Wikipedia (es), citando a Acento; nominación, no premio'),

  ('102e7b78-ff98-4adc-9a54-ae73791fb176'::uuid, 'd5fa3fdd-b0bf-426a-bead-1e7ff4a657b5'::uuid,
   'ea68bb41-6dc4-4b72-885c-25d3450082d1'::uuid, 2014,
   'Si No Te Quisiera, con Juan Magán y Belinda', true,
   'Wikipedia (es), citando a Listín Diario'),

  ('102e7b78-ff98-4adc-9a54-ae73791fb176'::uuid, '44cd5c30-2d0a-404c-973d-c6955d816ab4'::uuid,
   'b803cead-aae8-482e-89b5-d19472fd6a02'::uuid, 2016, NULL, true,
   'Wikipedia (es), citando a Diario Libre'),

  ('102e7b78-ff98-4adc-9a54-ae73791fb176'::uuid, '44cd5c30-2d0a-404c-973d-c6955d816ab4'::uuid,
   'cf5cc764-e539-44a1-8cd1-9f9521d99fd7'::uuid, 2016, NULL, true,
   'Wikipedia (es), citando a Diario Libre'),

  ('102e7b78-ff98-4adc-9a54-ae73791fb176'::uuid, '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid,
   '2c5a2cc2-1ec0-4872-bfeb-3b2cf242bd5c'::uuid, 2017, 'Papa, con Vico C', false,
   'Wikipedia (es), citando a El Caribe; nominación, no premio');

COMMIT;
