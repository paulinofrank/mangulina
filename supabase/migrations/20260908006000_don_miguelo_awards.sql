BEGIN;

-- Registra los dos Premios Casandra de Don Miguelo, que no tenía ninguno
-- guardado, y crea las dos categorías que hacían falta.
--
-- Salió al reescribir su ficha, la undécima de las 211 que siguen solo en
-- inglés por enlaces entrantes.
--
-- DOS CATEGORÍAS NUEVAS BAJO PREMIOS CASANDRA
--
--   "Artista Revelación". El premio ya tiene "Orquesta Revelación del Año",
--   que es para agrupaciones y no sirve para un solista. Son dos categorías
--   distintas del mismo galardón.
--
--   "Mejor Artista Urbano". Es la primera categoría urbana que el catálogo
--   registra bajo Premios Casandra -- la etapa anterior a 2012 -- y confirma
--   algo que ya se veía al crear "Artista Urbano del Año" bajo Premios Soberano
--   para Mozart La Para: Acroarte premiaba lo urbano y el catálogo no tenía
--   dónde ponerlo en ninguna de sus dos épocas.
--
-- LAS DOS ADJUDICACIONES
--
--   2006  Premios Casandra  Artista Revelación     Que Tú Quieres (La Cola de Motora)
--   2012  Premios Casandra  Mejor Artista Urbano
--
-- LAS DOS BAJO "PREMIOS CASANDRA" Y NO "PREMIOS SOBERANO", y aquí la fecha lo
-- resuelve sin ambigüedad: el galardón cambió de nombre en 2012 y estas son de
-- 2006 y de la ceremonia de 2012, en la que además actuó en la apertura.
--
-- EL PRIMERO LLEVA LA OBRA EN work porque la fuente la nombra expresamente
-- como la razón del premio: ganó "gracias al éxito de su primer éxito con la
-- canción Que Tu Quieres, más conocida como La Cola De Motora".
--
-- NO SE REGISTRA como premio la placa de hijo distinguido que le entregó el
-- alcalde de San Francisco de Macorís tras el segundo Casandra. Es un
-- reconocimiento municipal y el catálogo tiene una entidad para eso
-- ("Reconocimientos Municipales de la R.D."), pero la fuente no da fecha ni
-- nombre formal de la distinción. Queda en la biografía y reportado.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908006000_revert_don_miguelo_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('95c67e14-0db9-4ea7-a0ab-6244773ea7f2'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid, 'Artista Revelación'),
  ('fb384842-d27c-45c7-9634-dcacd1e46493'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid, 'Mejor Artista Urbano')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('6321da6c-e2d5-490a-a4e8-416bbee81edf'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '95c67e14-0db9-4ea7-a0ab-6244773ea7f2'::uuid, 2006,
   'Que Tú Quieres, conocida como La Cola de Motora, de su disco Contra el Tiempo', true,
   'Wikipedia (es), citando a El Caribe'),

  ('6321da6c-e2d5-490a-a4e8-416bbee81edf'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'fb384842-d27c-45c7-9634-dcacd1e46493'::uuid, 2012,
   'Actuó además en la ceremonia de apertura', true,
   'Wikipedia (es), citando a El Caribe');

COMMIT;
