BEGIN;

-- Registra los cinco reconocimientos de Carlos Piantini, que no tenía ninguno,
-- crea la Orden Andrés Bello de Venezuela y una categoría de Premios Casandra.
--
-- Salió al reescribir su ficha, que era la más vacía de las 229 publicadas solo
-- en inglés: no nombraba una orquesta, un cargo ni una fecha.
--
-- UN PREMIO NUEVO
--
--   "Orden Andrés Bello", condecoración del Estado venezolano al mérito
--   educativo y cultural. El catálogo no tenía ninguna entidad venezolana de
--   este tipo, y con la cantidad de músicos dominicanos que trabajaron en
--   Venezuela va a volver a hacer falta.
--
-- UNA CATEGORÍA NUEVA
--
--   "Mejor Artista Clásico en el Exterior" bajo Premios Casandra, que la ganó
--   DOS VECES. El premio ya tenía "Proyección Internacional", que es distinta:
--   aquella reconoce el alcance de un artista, esta es una categoría de música
--   clásica. Fundirlas perdería que Acroarte premiaba clásica por separado.
--
-- SE REUTILIZAN DOS ÓRDENES DOMINICANAS QUE YA EXISTEN, las dos bajo Gobierno
-- de la República Dominicana: la Orden Heráldica de Cristóbal Colón y la Orden
-- del Mérito de Duarte, Sánchez y Mella. Esta última la creé al escribir a
-- Julio Alberto Hernández y la reutilizó Luis Kalaff; van ya tres artistas con
-- ella, lo que confirma que valía la pena registrarla como categoría y meter el
-- grado en work.
--
-- LAS CINCO ADJUDICACIONES
--
--   1989  Premios Casandra  Mejor Artista Clásico en el Exterior
--   1992  Premios Casandra  Mejor Artista Clásico en el Exterior
--   --    Orden Andrés Bello (Venezuela)
--   --    Gobierno RD       Orden Heráldica de Cristóbal Colón
--   --    Gobierno RD       Orden del Mérito de Duarte, Sánchez y Mella
--
-- LAS TRES ÓRDENES VAN SIN AÑO Y SIN GRADO. La fuente las enumera sin fechar ni
-- precisar el grado, y year admite NULL. No se inventa ninguno de los dos
-- datos; quedan para quien encuentre los decretos.
--
-- FUENTE ÚNICA Y DECLARADA: Diccionario Cultural Dominicano de FUNGLODE,
-- entrada "Piantini, Carlos". No es enciclopedia abierta sino obra de
-- referencia, y es la única fuente sustancial que encontré sobre él: no existe
-- artículo de Wikipedia en español a su nombre.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908003000_revert_carlos_piantini_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO awards (id, name, organization, country)
VALUES
  ('a083d32d-26ee-4ef8-a2da-906d87815514'::uuid,
   'Orden Andrés Bello', 'Gobierno de Venezuela', 'Venezuela')
ON CONFLICT (id) DO NOTHING;

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('8db219a6-f19b-4327-a978-9fd8d1e61dd4'::uuid,
   'a083d32d-26ee-4ef8-a2da-906d87815514'::uuid, 'Orden Andrés Bello'),
  ('cf9689f4-6d58-4191-bf9e-20e7e86d819d'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid, 'Mejor Artista Clásico en el Exterior')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('ebd75bb5-0571-4199-9474-22d173b3d072'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'cf9689f4-6d58-4191-bf9e-20e7e86d819d'::uuid, 1989, NULL, true,
   'Diccionario Cultural Dominicano, FUNGLODE'),
  ('ebd75bb5-0571-4199-9474-22d173b3d072'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'cf9689f4-6d58-4191-bf9e-20e7e86d819d'::uuid, 1992, NULL, true,
   'Diccionario Cultural Dominicano, FUNGLODE'),
  ('ebd75bb5-0571-4199-9474-22d173b3d072'::uuid, 'a083d32d-26ee-4ef8-a2da-906d87815514'::uuid,
   '8db219a6-f19b-4327-a978-9fd8d1e61dd4'::uuid, NULL, 'Condecoración del Estado venezolano', true,
   'Diccionario Cultural Dominicano, FUNGLODE; la fuente no da año ni grado'),
  ('ebd75bb5-0571-4199-9474-22d173b3d072'::uuid, 'be773efd-7e6d-444d-90be-00d74f8a2cf4'::uuid,
   'e1ecf47b-1afe-451a-853b-c8f002ecddeb'::uuid, NULL, NULL, true,
   'Diccionario Cultural Dominicano, FUNGLODE; la fuente no da año ni grado'),
  ('ebd75bb5-0571-4199-9474-22d173b3d072'::uuid, 'be773efd-7e6d-444d-90be-00d74f8a2cf4'::uuid,
   'a4c19e35-7b62-4d08-9e41-3fa7c25d60b8'::uuid, NULL, NULL, true,
   'Diccionario Cultural Dominicano, FUNGLODE; la fuente no da año ni grado');

COMMIT;
