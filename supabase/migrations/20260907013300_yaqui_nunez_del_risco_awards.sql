BEGIN;

-- Registra los cinco reconocimientos de Yaqui Núñez del Risco y crea las tres
-- entidades que faltaban para poder registrarlos.
--
-- Salió al escribir su ficha, que era una de las dieciséis publicadas sin una
-- sola línea de biografía. No tenía ningún premio guardado.
--
-- Sigue la instrucción del editor de registrar todo galardón que aparezca,
-- aunque la entidad que lo entregaba ya no exista o no sea un premio musical
-- al uso: un reconocimiento recibido es parte del expediente.
--
-- TRES ENTIDADES NUEVAS
--
--   PREMIOS QUISQUEYA. Galardones a dominicanos en Estados Unidos, entregados
--   en Union City, Nueva Jersey. Sin organización documentada en mis fuentes,
--   así que organization queda en NULL.
--
--   UNARED, Unión Nacional de Artistas y Afines de la República Dominicana.
--   Aquí sí hay organización y se escribe.
--
--   UNIVERSIDAD AUTÓNOMA DE SANTO DOMINGO. Una universidad no es una entidad de
--   premios en el sentido corriente, pero sus investiduras honoríficas son
--   reconocimientos públicos y varios artistas del catálogo las tienen. Se crea
--   para poder registrarlas de manera uniforme en vez de dejarlas sueltas en la
--   prosa de cada ficha.
--
-- DOS CATEGORÍAS NUEVAS SOBRE PREMIOS QUE YA EXISTEN
--
--   "Casandra al Mérito" bajo Premios Casandra. Es el antecesor del "Soberano
--   al Mérito" que ya está registrado bajo Premios Soberano, y se mantiene
--   separado porque el premio cambió de nombre en 2013 y la base ya distingue
--   las dos etapas.
--
--   "Gloria Nacional de la Comunicación" bajo Gobierno de la República
--   Dominicana, que hasta ahora solo tenía la Orden Heráldica de Cristóbal
--   Colón.
--
-- UN CONFLICTO RESUELTO ANTES DE ESCRIBIR. Sobre el reconocimiento de la UASD,
-- el cuerpo de Wikipedia dice "Profesor Honorario" y el título de su propia
-- referencia dice "Doctorado Honoris Causa". Fui al periódico Hoy del 6 de
-- junio de 2013: la UASD lo invistió como PROFESOR HONORIS CAUSA, en un acto en
-- la Biblioteca Pedro Mir. No es doctorado, y la categoría se llama como el
-- acto real.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260907013300_revert_yaqui_nunez_del_risco_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO awards (id, name, organization, country, description)
VALUES
  ('a3e51f76-8b24-4c90-bd17-6e2fa8054c31'::uuid, 'Premios Quisqueya', NULL,
   'Estados Unidos',
   'Galardones a figuras dominicanas radicadas o reconocidas en Estados Unidos, entregados en Union City, Nueva Jersey.'),
  ('b4f6208a-9c35-4da1-ce28-7f3ab9165d42'::uuid, 'UNARED', 'Unión Nacional de Artistas y Afines de la República Dominicana',
   'República Dominicana',
   'Reconocimientos del gremio nacional de artistas a la trayectoria de sus figuras.'),
  ('c507319b-ad46-4eb2-df39-803bca276e53'::uuid, 'Universidad Autónoma de Santo Domingo',
   'Universidad Autónoma de Santo Domingo (UASD)', 'República Dominicana',
   'Investiduras y distinciones honoríficas de la universidad estatal dominicana.')
ON CONFLICT (id) DO NOTHING;

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('d618420c-be57-4f13-ea4a-914cdb387f64'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid, 'Casandra al Mérito'),
  ('e729531d-cf68-4a24-fb5b-025edc498075'::uuid,
   'be773efd-7e6d-444d-90be-00d74f8a2cf4'::uuid, 'Gloria Nacional de la Comunicación'),
  ('f83a642e-d079-4b35-0c6c-136fed5a9186'::uuid,
   'a3e51f76-8b24-4c90-bd17-6e2fa8054c31'::uuid, 'Reconocimiento a la Trayectoria'),
  ('094b753f-e18a-4c46-1d7d-247afe6ba297'::uuid,
   'b4f6208a-9c35-4da1-ce28-7f3ab9165d42'::uuid, 'Reconocimiento a la Trayectoria'),
  ('1a5c8640-f29b-4d57-2e8e-358b0f7cb3a8'::uuid,
   'c507319b-ad46-4eb2-df39-803bca276e53'::uuid, 'Profesor Honoris Causa')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('faff18bd-3dbc-477a-bc38-859d611887f0'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'd618420c-be57-4f13-ea4a-914cdb387f64'::uuid,
   2004, NULL, true, 'Wikipedia (es)'),
  ('faff18bd-3dbc-477a-bc38-859d611887f0'::uuid,
   'a3e51f76-8b24-4c90-bd17-6e2fa8054c31'::uuid,
   'f83a642e-d079-4b35-0c6c-136fed5a9186'::uuid,
   2005, NULL, true, 'Wikipedia (es), Premios Quisqueya en Union City, Nueva Jersey'),
  ('faff18bd-3dbc-477a-bc38-859d611887f0'::uuid,
   'b4f6208a-9c35-4da1-ce28-7f3ab9165d42'::uuid,
   '094b753f-e18a-4c46-1d7d-247afe6ba297'::uuid,
   2010, NULL, true, 'Wikipedia (es), reconocimiento del 22 de noviembre de 2010'),
  ('faff18bd-3dbc-477a-bc38-859d611887f0'::uuid,
   'be773efd-7e6d-444d-90be-00d74f8a2cf4'::uuid,
   'e729531d-cf68-4a24-fb5b-025edc498075'::uuid,
   2011, NULL, true, 'Wikipedia (es), declaratoria del gobierno dominicano'),
  ('faff18bd-3dbc-477a-bc38-859d611887f0'::uuid,
   'c507319b-ad46-4eb2-df39-803bca276e53'::uuid,
   '1a5c8640-f29b-4d57-2e8e-358b0f7cb3a8'::uuid,
   2013, NULL, true, 'Hoy, 6 de junio de 2013, investidura en la Biblioteca Pedro Mir');

COMMIT;
