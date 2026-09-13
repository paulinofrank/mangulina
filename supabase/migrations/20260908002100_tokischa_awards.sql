BEGIN;

-- Registra los cinco reconocimientos de Tokischa, que no tenía ninguno, y crea
-- dos categorías.
--
-- Salió al reescribir su ficha. Es de las artistas dominicanas contemporáneas
-- con mayor proyección internacional y la tabla de premios estaba vacía.
--
-- DOS CATEGORÍAS NUEVAS, NINGÚN PREMIO NUEVO
--
--   "Mejor Colaboración Femenina" bajo Premio Lo Nuestro. El premio ya tenía
--   ocho categorías, todas tropicales o de trayectoria salvo "Mejor Canción
--   Dembow"; ninguna sirve para una colaboración femenina.
--
--   "Mejor Fusión/Interpretación Urbana" bajo Latin Grammy. Las dieciséis
--   categorías que el catálogo tenía bajo ese premio son tropicales, de
--   trayectoria o generales; no había ninguna urbana, y va a hacer falta para
--   más artistas de esta generación.
--
-- SE REUTILIZAN TRES: "Best Dembow Song" de Premios Juventud, y "Platinum
-- Records" y "Gold Records" de Sales Certifications.
--
--   OJO CON PREMIOS JUVENTUD: tiene "Best Dembow Song" Y "Mejor Colaboración
--   Dembow", que son categorías distintas y las dos existen. "Delincuente" ganó
--   la de canción, no la de colaboración, pese a ser una colaboración. Se
--   respeta lo que dice la fuente.
--
-- LAS CINCO ADJUDICACIONES
--
--   2023  Premios Juventud       Best Dembow Song               Delincuente
--   2025  Premio Lo Nuestro      Mejor Colaboración Femenina    Chulo pt. 2
--   2025  Latin Grammy           Mejor Fusión/Interpretación Urbana  De Maravisha  NOMINACIÓN
--   --    Sales Certifications   Platinum Records               Chulo pt. 2, séxtuple platino latino
--   --    Sales Certifications   Gold Records                   Chulo pt. 2, oro en México
--
-- LA NOMINACIÓN VA CON won = false. Es su primera al Latin Grammy y la fuente
-- la registra como nominación, no como premio. La tabla distingue las dos cosas
-- y aquí importa: confundirlas le atribuiría un galardón que no tiene.
--
-- LAS CERTIFICACIONES VAN SIN AÑO porque la fuente no lo da: dice que "Chulo
-- pt. 2" está certificada séxtuple platino latino por la RIAA y oro en México
-- por AMPROFON, sin fecha de certificación. year admite NULL.
--
-- NO SE REGISTRAN COMO PREMIOS: la inclusión en la lista de Billboard de
-- artistas que cambiaron el juego para el público queer, ni la selección de
-- Time entre las mejores canciones del año por "Delincuente". Son listas
-- periodísticas, no adjudicaciones, y están en la biografía.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908002100_revert_tokischa_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('0ef1e90e-cf63-4ee3-a36f-58b32f4045b6'::uuid,
   'f289c627-bc9e-48c5-8da3-d8fe3e9b0f60'::uuid, 'Mejor Colaboración Femenina'),
  ('762af833-e017-429d-952d-e92bcc06bc26'::uuid,
   '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid, 'Mejor Fusión/Interpretación Urbana')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('3e1718be-c12d-42f5-85e7-2156d9574940'::uuid, '8304c63b-ff51-40ed-80bb-ea7c4079ca6f'::uuid,
   'd7ec9884-2cdc-4b77-b794-1f7e88aa3cf7'::uuid, 2023, 'Delincuente', true, 'Wikipedia (es)'),

  ('3e1718be-c12d-42f5-85e7-2156d9574940'::uuid, 'f289c627-bc9e-48c5-8da3-d8fe3e9b0f60'::uuid,
   '0ef1e90e-cf63-4ee3-a36f-58b32f4045b6'::uuid, 2025, 'Chulo pt. 2', true, 'Wikipedia (es)'),

  ('3e1718be-c12d-42f5-85e7-2156d9574940'::uuid, '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid,
   '762af833-e017-429d-952d-e92bcc06bc26'::uuid, 2025, 'De Maravisha', false,
   'Wikipedia (es); primera nominación al Latin Grammy, no ganó'),

  ('3e1718be-c12d-42f5-85e7-2156d9574940'::uuid, 'd5fa3fdd-b0bf-426a-bead-1e7ff4a657b5'::uuid,
   'f9c96520-c8ff-4342-bc7b-91b50878f74f'::uuid, NULL,
   'Chulo pt. 2; séxtuple platino en el campo latino, RIAA', true, 'Wikipedia (es)'),

  ('3e1718be-c12d-42f5-85e7-2156d9574940'::uuid, 'd5fa3fdd-b0bf-426a-bead-1e7ff4a657b5'::uuid,
   'ea68bb41-6dc4-4b72-885c-25d3450082d1'::uuid, NULL,
   'Chulo pt. 2; oro en México, AMPROFON', true, 'Wikipedia (es)');

COMMIT;
