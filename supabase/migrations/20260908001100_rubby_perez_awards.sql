BEGIN;

-- Registra cinco reconocimientos de Rubby Pérez, que no tenía NI UNO guardado,
-- y crea la categoría "Orquesta del Año" bajo Premios Casandra.
--
-- Salió al reescribir su ficha, que era una de las 229 publicadas solo en
-- inglés. artist_awards devolvió cero filas para un artista con casi cincuenta
-- años de carrera.
--
-- UNA CATEGORÍA NUEVA
--
--   "Orquesta del Año" bajo Premios Casandra. El premio ya existía y ya tenía
--   "Merengue del Año" y "Orquesta Revelación del Año", pero no la de orquesta
--   consagrada. NO SE REUTILIZA la "Orquesta del Año" que existe bajo Premios
--   Soberano: el catálogo trata Casandra y Soberano como entidades distintas
--   —son las dos etapas del galardón de Acroarte— y mezclarlas perdería la
--   época a la que pertenece cada adjudicación.
--
--   OJO CON EL NOMBRE: las fuentes lo escriben distinto. Las dos Wikipedias
--   dicen "Orquesta del año"; Prensa Latina RD dice "Orquesta de Merengue". Se
--   registra con el nombre de Acroarte, que es el de las Wikipedias, y la
--   variante queda anotada en source.
--
-- LAS CINCO ADJUDICACIONES, TODAS CON DOS FUENTES
--
--   1988  Sales Certifications  Gold Records      ventas en Venezuela
--   1988  Sales Certifications  Platinum Records  ventas en Venezuela
--   2005  Premios Casandra      Merengue del Año
--   2005  Premios Casandra      Orquesta del Año
--   2011  Keys to the City      West New York, Nueva Jersey
--
-- EL AÑO DE LAS CERTIFICACIONES ES 1988 y lo dan las dos fuentes, pero
-- DISCREPAN EN EL DISCO: Wikipedia en inglés dice que fue por "Buscando Tus
-- Besos", su primer álbum como solista, y Prensa Latina RD dice que fue por el
-- LP homónimo "Rubby Pérez". No se elige entre las dos; el campo work recoge
-- lo que ambas sostienen —oro y platino por ventas en Venezuela— y el conflicto
-- queda escrito en source para quien pueda resolverlo.
--
-- QUEDAN REPORTADOS Y SIN REGISTRAR, POR FUENTE ÚNICA. Prensa Latina RD publica
-- una lista bastante más larga que no pude corroborar en ningún otro sitio, y
-- varios de esos galardones obligarían además a crear entidades nuevas:
--
--   Premios Globos, mejor canción por "Tú Vas a Volar" (2000)
--   Premios Exa, cantante más destacado del año (2003)
--   Premios Estrellas, artista del año en merengue (2008) y regreso musical
--     del año (2012, y otro sin fecha)
--   Premio Orquídea de Plata / Venevisión (sin fecha)
--   Dominican American National Roundtable, Lifetime Achievement (2011)
--   Special Congressional Recognition (2012)
--   Aportación en la Industria Artística y Musical (2012)
--
-- No se descartan: se sostienen hasta tener una segunda fuente. Crear siete
-- entidades de premio sobre una sola página de prensa regional es más riesgo
-- que valor en un catálogo que se lee como referencia.
--
-- LAS POSICIONES DE LISTA NO VAN AQUÍ. El quince de Tropical Albums, el
-- veintinueve de las listas latinas y el séptimo puesto póstumo de abril de
-- 2025 son datos de gráfico, no adjudicaciones, y están escritos en la
-- biografía.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908001100_revert_rubby_perez_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('51b1d03e-fe3d-432a-98b0-389facbd6a2e'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'Orquesta del Año')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('cff70c92-8632-4c66-b5a0-81622c8128b0'::uuid,
   'd5fa3fdd-b0bf-426a-bead-1e7ff4a657b5'::uuid,
   'ea68bb41-6dc4-4b72-885c-25d3450082d1'::uuid,
   1988, 'Por ventas en Venezuela', true,
   'Wikipedia (en) y Prensa Latina RD; discrepan en el disco, Buscando Tus Besos o el LP homónimo'),

  ('cff70c92-8632-4c66-b5a0-81622c8128b0'::uuid,
   'd5fa3fdd-b0bf-426a-bead-1e7ff4a657b5'::uuid,
   'f9c96520-c8ff-4342-bc7b-91b50878f74f'::uuid,
   1988, 'Por ventas en Venezuela', true,
   'Wikipedia (en) y Prensa Latina RD; discrepan en el disco, Buscando Tus Besos o el LP homónimo'),

  ('cff70c92-8632-4c66-b5a0-81622c8128b0'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'fd798175-f2c4-4195-8967-b7ce424267c2'::uuid,
   2005, NULL, true,
   'Wikipedia (es) y (en) dan la categoría; Prensa Latina RD da el año'),

  ('cff70c92-8632-4c66-b5a0-81622c8128b0'::uuid,
   'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '51b1d03e-fe3d-432a-98b0-389facbd6a2e'::uuid,
   2005, NULL, true,
   'Wikipedia (es) y (en) la llaman Orquesta del año; Prensa Latina RD la llama Orquesta de Merengue y da el año'),

  ('cff70c92-8632-4c66-b5a0-81622c8128b0'::uuid,
   '32809733-7cd4-4852-a177-5e097acde0b5'::uuid,
   '769a84a7-7fb7-46fb-bdd1-18de8de7362b'::uuid,
   2011, 'West New York, Nueva Jersey', true,
   'Prensa Latina RD');

COMMIT;
