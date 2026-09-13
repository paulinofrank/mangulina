BEGIN;

-- Registra las siete adjudicaciones de Elvis Martinez, que no tenia ninguna
-- guardada, y crea las dos categorias que faltaban.
--
-- Salio al reescribir su ficha, la vigesimocuarta de las 211 que seguian solo
-- en ingles.
--
--   1998  Premio ACE          Revelacion del Ano                Todo Se Paga
--   2004  Premios Casandra    Bachata del Ano                   Asi Te Amo
--   2004  Premio Lo Nuestro   Artista Tropical Tradicional      (NOMINACION)
--   2021  Premios Soberano    Bachatero del Ano
--   2021  Premios Soberano    Colaboracion del Ano              Millonario
--   2023  Premios Soberano    Bachatero del Ano
--   2023  Premios Soberano    Bachata del Ano                   Saco e' sal
--
-- ---------------------------------------------------------------------------
-- SE DESCARTAN DOS PREMIOS QUE WIKIPEDIA LE ATRIBUYE
--
-- La tabla de premios de Wikipedia le da CUATRO estatuillas en los Soberano de
-- 2021: colaboracion, bachatero, CONCIERTO DEL ANO y BACHATA DEL ANO por "El
-- placer del sexo".
--
-- La lista de ganadores de esa gala dice otra cosa. El Dia, 16 de junio de
-- 2021, escribe "Elvis Martinez quien se alzo con DOS estatuillas", y en el
-- listado por renglones el concierto streaming del ano fue para HECTOR ACOSTA y
-- la bachata del ano 2019 para ROMEO SANTOS ft. KIKO RODRIGUEZ.
--
-- Se registran las dos que la prensa confirma. Las otras dos NO se insertan.
-- ---------------------------------------------------------------------------
--
-- LOS ANOS SON LOS DE LA GALA, no los del periodo premiado, que es la
-- convencion del resto de la tabla. La gala de marzo de 2023 premio 2021 y 2022
-- a la vez, igual que la de junio de 2021 premio 2019 y 2020: por eso los
-- titulos de renglon de la prensa llevan anos que no coinciden con la fecha de
-- entrega. Queda escrito en `work` donde hace falta.
--
-- POR LA MISMA RAZON SOLO REGISTRO UN "Bachatero del Ano" EN 2023 y no dos.
-- Algunas listas hablan del bachatero de 2021 y del de 2022 como galardones
-- distintos entregados esa noche y otras lo dan como uno solo. Sin desempate,
-- una fila.
--
-- DOS CATEGORIAS NUEVAS
--
--   "Revelacion del Ano" bajo Premio ACE, que solo tenia "Premio ACE" y
--   "Multiple Honors", ninguna de ellas util para un renglon concreto.
--
--   "Artista Tropical Tradicional del Ano" bajo Premio Lo Nuestro, que tiene
--   "Artista Tropical del Ano" pero no la tradicional, que es otro renglon.
--
-- ADVERTENCIA SOBRE LA ENTIDAD ACE: el catalogo tiene "Premio ACE" (2 usos) y
-- "Premios ACE" (1 uso), que son el mismo cuerpo, la Asociacion de Cronistas de
-- Espectaculos de Nueva York. Uso el primero por tener mas filas. NO
-- CONSOLIDO: la fusion de entidades duplicadas es un trabajo aparte y ya
-- estaba en la lista.
--
-- DISCREPANCIA DE NOMBRE EN EL CASANDRA DE 2004: Wikipedia lo llama "Mejor
-- Cancion del Ano" y el palmares de Bachata Republic lo registra como "Bachata
-- del Ano", que es la categoria que el catalogo tiene. Uso esa y lo dejo dicho.
--
-- LA COMPOSICION AJENA VA ESCRITA en `work`: "Asi Te Amo" la compuso Wason
-- Brazoban. "Saco e' sal" la escribio el mismo, y tambien se dice.
--
-- PARA REVERTIR: supabase/rollback/20260908009200_revert_elvis_martinez_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrio ninguna funcion de Vercel
-- y no se revalido nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('5b853910-d844-474e-9131-df7e43ea32a7'::uuid,
   '373d49e3-4311-4f21-9aa4-c0f40bab9fa6'::uuid, 'Revelación del Año'),
  ('824c9af3-6def-4fb6-bcc0-1e9ab35e7621'::uuid,
   'f289c627-bc9e-48c5-8da3-d8fe3e9b0f60'::uuid, 'Artista Tropical Tradicional del Año')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('e566c763-02c1-4f96-8a82-edbba9fc0bb2'::uuid, '373d49e3-4311-4f21-9aa4-c0f40bab9fa6'::uuid,
   '5b853910-d844-474e-9131-df7e43ea32a7'::uuid, 1998, 'Todo Se Paga', true,
   'Wikipedia (es), citando a AllMusic'),

  ('e566c763-02c1-4f96-8a82-edbba9fc0bb2'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '4e6a932d-4c49-4a48-95e1-cc8ecadf1d1f'::uuid, 2004,
   'Así Te Amo, compuesta por Wason Brazobán', true,
   'Bachata Republic, palmarés de Bachata del Año; Wikipedia (es) lo llama Mejor Canción del Año'),

  ('e566c763-02c1-4f96-8a82-edbba9fc0bb2'::uuid, 'f289c627-bc9e-48c5-8da3-d8fe3e9b0f60'::uuid,
   '824c9af3-6def-4fb6-bcc0-1e9ab35e7621'::uuid, 2004, NULL, false,
   'Wikipedia (es), citando a AllMusic'),

  ('e566c763-02c1-4f96-8a82-edbba9fc0bb2'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   'e016ac69-513d-4a40-b636-e148aae081c0'::uuid, 2021,
   'Gala del 15 de junio de 2021', true,
   'El Día y Listín Diario, 16 de junio de 2021, listado de ganadores'),

  ('e566c763-02c1-4f96-8a82-edbba9fc0bb2'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   'b7661f5a-b7e9-4667-a590-d56284151e93'::uuid, 2021,
   'Millonario, con Romeo Santos; renglón de colaboración del año 2019', true,
   'El Día y Listín Diario, 16 de junio de 2021, listado de ganadores'),

  ('e566c763-02c1-4f96-8a82-edbba9fc0bb2'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   'e016ac69-513d-4a40-b636-e148aae081c0'::uuid, 2023,
   'Gala de marzo de 2023, que premió 2021 y 2022 a la vez', true,
   'Listín Diario, 22 de marzo de 2023'),

  ('e566c763-02c1-4f96-8a82-edbba9fc0bb2'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   '3ba3ced3-dcbf-4436-8356-5f9f41f1546e'::uuid, 2023,
   'Saco e'' sal, compuesta por él mismo', true,
   'Diario Libre, Listín Diario y Acento, 22 y 23 de marzo de 2023');

COMMIT;
