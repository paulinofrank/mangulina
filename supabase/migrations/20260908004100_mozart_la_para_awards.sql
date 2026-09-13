BEGIN;

-- Registra los nueve reconocimientos de Mozart La Para, que no tenía ninguno, y
-- crea dos categorías bajo Premios Soberano.
--
-- Salió al reescribir su ficha, la tercera de las 211 que siguen solo en inglés
-- por enlaces entrantes (26).
--
-- DOS CATEGORÍAS NUEVAS, NINGÚN PREMIO NUEVO
--
--   "Artista Urbano del Año" bajo Premios Soberano. El premio tenía dieciséis
--   categorías y ninguna urbana, lo que es un hueco notable para un galardón
--   dominicano contemporáneo: va a hacer falta para media generación.
--
--   "Soberano del Pueblo" bajo Premios Soberano. NO ES UNA CATEGORÍA MÁS Y POR
--   ESO VA SEPARADA: lo decide el voto del público, no un jurado. Fundirlo con
--   las categorías de jurado mezclaría dos cosas que miden cosas distintas, y
--   este artista lo ganó SEIS AÑOS SEGUIDOS, que es un dato sobre su
--   popularidad y no sobre su valoración crítica.
--
-- LAS NUEVE ADJUDICACIONES
--
--   2013, 2016, 2018              Artista Urbano del Año
--   2013, 2014, 2015, 2016, 2017, 2018   Soberano del Pueblo
--
-- TODAS BAJO "PREMIOS SOBERANO" Y NO BAJO "PREMIOS CASANDRA", y aquí la
-- distinción es fácil: el galardón cambió de nombre en 2012 y todas estas son
-- de 2013 en adelante. El catálogo mantiene las dos entidades separadas para no
-- perder la época de cada adjudicación.
--
-- LA FUENTE DA LOS AÑOS AGRUPADOS y no ficha por ficha: "2013, 2016, 2018" para
-- la primera y "2013, 2014, 2015, 2016, 2017, 2018" para la segunda. Se
-- desglosa en una fila por año, que es como la tabla guarda las adjudicaciones
-- y lo único que permite consultarlas después.
--
-- NO SE REGISTRAN COMO PREMIOS las cinco entradas en las listas de Billboard.
-- Son posiciones de gráfico y están en la biografía.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908004100_revert_mozart_la_para_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('67cf635d-e7db-4205-ae93-245cf295ae4e'::uuid,
   'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid, 'Artista Urbano del Año'),
  ('0abb18f2-9ba3-4fb6-8f9c-a7fa87e6c3a3'::uuid,
   'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid, 'Soberano del Pueblo')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT 'fa9cc802-28ca-4695-b585-f75aa90a2b6c'::uuid,
       'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
       '67cf635d-e7db-4205-ae93-245cf295ae4e'::uuid,
       y, NULL, true, 'Wikipedia (es), tabla de premios'
  FROM (VALUES (2013), (2016), (2018)) AS t(y);

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT 'fa9cc802-28ca-4695-b585-f75aa90a2b6c'::uuid,
       'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
       '0abb18f2-9ba3-4fb6-8f9c-a7fa87e6c3a3'::uuid,
       y, 'Decidido por voto del público', true, 'Wikipedia (es), tabla de premios'
  FROM (VALUES (2013), (2014), (2015), (2016), (2017), (2018)) AS t(y);

COMMIT;
