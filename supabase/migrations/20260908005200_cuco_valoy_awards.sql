BEGIN;

-- Registra los cinco reconocimientos de Cuco Valoy, que no tenía ninguno, y
-- crea la categoría "Rey del Pueblo" bajo Congo de Oro.
--
-- Salió al reescribir su ficha, la octava de las 211 que siguen solo en inglés
-- por enlaces entrantes.
--
-- UNA CATEGORÍA NUEVA
--
--   "Rey del Pueblo" bajo Congo de Oro, la distinción del Festival de Orquestas
--   del Carnaval de Barranquilla. No es una categoría de género como las cuatro
--   que ya existen -- Congo de Oro, Salsa, Merengue y Merengue Extranjero --
--   sino un reconocimiento de trayectoria, y por eso va aparte. Se la dieron en
--   2015, treinta y dos años después de su segundo Congo.
--
-- SE REUTILIZAN TRES CATEGORÍAS EXISTENTES: "Salsa" de Congo de Oro, "El Gran
-- Soberano" de Premios Soberano, y "Premio a la Excelencia Musical" de Latin
-- Grammy.
--
--   SOBRE "SALSA": la fuente escribe la categoría como "Combo Salsa" en su
--   tabla. El catálogo tiene "Salsa" bajo ese mismo premio y se reutiliza en
--   vez de crear una variante casi idéntica; la forma exacta de la fuente queda
--   en el campo work.
--
-- LAS CINCO ADJUDICACIONES
--
--   1981  Congo de Oro       Salsa
--   1983  Congo de Oro       Salsa
--   2015  Congo de Oro       Rey del Pueblo
--   2017  Premios Soberano   El Gran Soberano
--   2017  Latin Grammy       Premio a la Excelencia Musical
--
-- CONFLICTO INTERNO DE LA FUENTE, RESUELTO A FAVOR DE LO VERIFICABLE. El texto
-- del artículo dice que ganó el Congo de Oro "por cuatro veces consecutivas",
-- pero la tabla del MISMO artículo lista TRES, y en años que no son
-- consecutivos: 1981, 1983 y 2015. Se registran las tres que la tabla fecha. Si
-- aparece la cuarta, se añade.
--
-- LOS DOS PREMIOS DE 2017 CAYERON EL MISMO AÑO y no es coincidencia de fechas
-- mal copiadas: Acroarte le dio el Gran Soberano en marzo y la Academia Latina
-- de la Grabación su Premio a la Excelencia Musical ese mismo año, junto a
-- Lucecita Benítez, Ilan Chester, Víctor Heredia, Joao Bosco y Guadalupe
-- Pineda. Quedan las dos filas.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908005200_revert_cuco_valoy_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('49479a22-46c0-401a-b5df-e8028dc7f235'::uuid,
   'd86f297c-3b97-48bf-953b-ef64a7b74a08'::uuid, 'Rey del Pueblo')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('c11c2dda-ffa1-4f09-9d24-00dc4473bc8d'::uuid, 'd86f297c-3b97-48bf-953b-ef64a7b74a08'::uuid,
   'a1f60c78-2d94-4b55-8e17-93cb70d18a26'::uuid, 1981,
   'Festival de Orquestas del Carnaval de Barranquilla; la fuente escribe la categoría como Combo Salsa', true,
   'Wikipedia (es), tabla de Congos de Oro'),

  ('c11c2dda-ffa1-4f09-9d24-00dc4473bc8d'::uuid, 'd86f297c-3b97-48bf-953b-ef64a7b74a08'::uuid,
   'a1f60c78-2d94-4b55-8e17-93cb70d18a26'::uuid, 1983,
   'Festival de Orquestas del Carnaval de Barranquilla; la fuente escribe la categoría como Combo Salsa', true,
   'Wikipedia (es), tabla de Congos de Oro'),

  ('c11c2dda-ffa1-4f09-9d24-00dc4473bc8d'::uuid, 'd86f297c-3b97-48bf-953b-ef64a7b74a08'::uuid,
   '49479a22-46c0-401a-b5df-e8028dc7f235'::uuid, 2015,
   'Festival de Orquestas del Carnaval de Barranquilla', true,
   'Wikipedia (es), tabla de Congos de Oro'),

  ('c11c2dda-ffa1-4f09-9d24-00dc4473bc8d'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   '26e1ac30-c00d-4cc8-922f-bd7fd58502ce'::uuid, 2017,
   'Máximo galardón de Acroarte', true,
   'Wikipedia (es), citando a Diario Libre del 28 de marzo de 2017'),

  ('c11c2dda-ffa1-4f09-9d24-00dc4473bc8d'::uuid, '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid,
   'd2799d5d-a14f-4f49-a317-52199253a8f5'::uuid, 2017, NULL, true,
   'Wikipedia (es)');

COMMIT;
