BEGIN;

-- Registra los tres galardones de Luis Segura, que no tenía ninguno guardado.
--
-- Salió al reescribir su ficha, la duodécima de las 211 que seguían solo en
-- inglés. No hace falta crear ninguna categoría: las tres ya existen.
--
-- LAS TRES ADJUDICACIONES
--
--   2010  Premios Casandra  Casandra al Mérito
--   2021  Latin Grammy      Best Merengue/Bachata Album   (NOMINACIÓN)
--   2023  Premios Soberano  El Gran Soberano
--
-- LA NOMINACIÓN AL LATIN GRAMMY SE VERIFICÓ APARTE Y A PROPÓSITO. La anuncia su
-- propio sitio oficial, que no es fuente independiente, y este catálogo ya
-- arrastró una vez un Latin Grammy inexistente en la ficha de Martha Heredia.
-- Así que fui a la lista: "El Papá de la Bachata, Su Legado (Añoñado I, II,
-- III, IV)" está entre los nominados de la 22.ª entrega, en la categoría que
-- ganó Sergio Vargas con "Es Merengue ¿Algún Problema?". Va con won = false.
--
-- EL AÑO DEL GRAN SOBERANO NECESITA EXPLICACIÓN. Lo recibió en la 38.ª entrega
-- de los Premios Soberano, celebrada en marzo de 2023, pero el galardón es el
-- correspondiente a 2021: esa noche se entregaron dos, el de 2021 a Segura y
-- el siguiente a la periodista Alicia Ortega. Toda la prensa lo llama "Gran
-- Soberano 2021".
--
-- SE GUARDA 2023, que es el año de la ceremonia y la convención del resto de la
-- tabla, y la designación de 2021 queda escrita en `source` para que nadie lo
-- registre otra vez como adjudicación separada de 2021.
--
-- CON ESTA, EL CATÁLOGO TIENE OCHO GRAN SOBERANOS. Segura es el segundo
-- bachatero en recibirlo, después de Antony Santos en 2019, y eso lo dice
-- ACROARTE, no yo.
--
-- EL CASANDRA AL MÉRITO VA BAJO "PREMIOS CASANDRA" Y NO "PREMIOS SOBERANO":
-- es de 2010 y el galardón cambió de nombre en 2012. Mismo criterio que en la
-- migración de Don Miguelo.
--
-- NO SE REGISTRAN COMO PREMIOS: la calle que el ayuntamiento de Mao le dedicó
-- en noviembre de 2008, la resolución del Senado de octubre de 2020 ni el
-- récord Guinness de diciembre de 2021, que no es suyo sino del país y de la
-- canción. Los tres están en la biografía.
--
-- PARA REVERTIR: supabase/rollback/20260908006200_revert_luis_segura_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('5ceceef0-765d-4e01-8017-85422a263357'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'd618420c-be57-4f13-ea4a-914cdb387f64'::uuid, 2010,
   NULL, true,
   'ACROARTE; Wikipedia (es), citando a Acroarte'),

  ('5ceceef0-765d-4e01-8017-85422a263357'::uuid, '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid,
   '9ea19c30-6990-48fd-9fe6-e42d3c8cbb78'::uuid, 2021,
   'El Papá de la Bachata, Su Legado (Añoñado I, II, III, IV)', false,
   'Nominaciones finales de la 22.a entrega, Latin Recording Academy'),

  ('5ceceef0-765d-4e01-8017-85422a263357'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   '26e1ac30-c00d-4cc8-922f-bd7fd58502ce'::uuid, 2023,
   'Gran Soberano correspondiente a 2021, entregado en la 38.a entrega, marzo de 2023', true,
   'ACROARTE; Diario Libre y El Día, 23 de marzo de 2023');

COMMIT;
