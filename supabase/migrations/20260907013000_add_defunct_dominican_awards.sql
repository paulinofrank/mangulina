BEGIN;

-- Crea cuatro premios dominicanos que ya no se celebran y registra las
-- adjudicaciones de Olga Lara que les corresponden.
--
-- Instrucción del editor: "registra todos los premios que vayas encontrando,
-- sabemos que algunos hace años no se celebran, pero estuvieron ahí". Correcto:
-- un galardón desaparecido sigue siendo parte del expediente de quien lo ganó,
-- y omitirlo deja la carrera de toda una generación contada a medias.
--
-- LOS CUATRO PREMIOS
--
--   PREMIOS EL DORADO. Galardones dominicanos de los años ochenta, entregados
--   en el Palacio de Bellas Artes de Santo Domingo y televisados. IMDb conserva
--   fichas de las galas de 1983, 1984, 1985 y 1986, con Freddy Beras Goico y
--   José Armando Bermúdez entre los presentes. NO SE INVENTA LA ORGANIZACIÓN:
--   ninguna fuente que encontré dice qué entidad los convocaba, así que el
--   campo organization queda en NULL.
--
--   PREMIO EL ÁNGEL. Galardón dominicano de la misma época. Igual: sin
--   organización documentada.
--
--   EL GORDO DEL AÑO. Premio de popularidad decidido por el público.
--
--   PREMIO MERENGUE DEL AÑO. Galardón dedicado al género.
--
--   OJO CON LA HOMONIMIA: "Merengue del Año" existe también como CATEGORÍA
--   dentro de Premios Casandra. Son cosas distintas -- una categoría dentro de
--   otro premio, y un premio propio -- y por eso conviven sin fusionarse.
--
-- LAS ADJUDICACIONES QUE SÍ ENTRAN
--
--   El Dorado        1980  Revelación del Año        olgalara.com y Wikipedia
--   El Dorado        1982  Cantante del Año          olgalara.com y Wikipedia
--   El Ángel         1981  Cantante del Año          Wikipedia (es)
--   El Ángel         1982  Cantante del Año          Wikipedia (es)
--   El Gordo del Año 1983  Cantante Más Destacada    ambas, coincidentes
--   El Gordo del Año 1984  Disco del Año             ambas, coincidentes
--   El Gordo del Año 1985  Cantante del Año          ambas, coincidentes
--   Merengue del Año 1985  Disco del Año             Wikipedia (es)
--
-- El Gordo del Año entra completo porque las dos fuentes concuerdan: su sitio
-- dice que lo ganó "tres veces seguidas, de 1983 a 1985" y Wikipedia detalla
-- exactamente esos tres años. El Ángel entra con una sola fuente, pero eso es
-- AUSENCIA en la otra, no contradicción: su sitio simplemente no lo menciona.
--
-- LO QUE SIGUE SIN REGISTRARSE, Y POR QUÉ
--
--   El Dorado, Cantante del Año, años 1981, 1984 y 1985. Tres fuentes dicen que
--   ganó ese premio CUATRO VECES y ninguna coincide en cuáles:
--     olgalara.com     -> 1982, 1984 y 1985
--     Wikipedia (es)   -> 1981 y 1982
--     Yo Creo en Azua  -> "cuatro veces", sin años
--   Solo 1982 aparece en dos de ellas, y es el único que se guarda. Faltan tres
--   filas que existieron de verdad; se registrarán en cuanto aparezca una
--   fuente que fije los años, por ejemplo la hemeroteca de las galas.
--
--   Casandra, Cantante del Año. Mismo problema: su sitio dice 1985 y 1987;
--   Wikipedia dice "Cantante más popular" en 1981; la página de Azua dice
--   cuatro veces. Los dos Casandra que ya están guardados (Espectáculo del Año
--   1987 y 1995) no se tocan, porque esos sí son firmes.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260907013000_revert_defunct_dominican_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO awards (id, name, organization, country, description)
VALUES
  ('c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid, 'Premios El Dorado', NULL,
   'República Dominicana',
   'Galardones dominicanos de la década de 1980, entregados en el Palacio de Bellas Artes de Santo Domingo y televisados. Descontinuados.'),
  ('d4b8e615-2c07-4a3f-81de-96af1b70c359'::uuid, 'Premio El Ángel', NULL,
   'República Dominicana',
   'Galardón dominicano de la década de 1980 al desempeño artístico del año. Descontinuado.'),
  ('e7c93b28-6f41-4d80-a2b5-1e8dc4076f9a'::uuid, 'El Gordo del Año', NULL,
   'República Dominicana',
   'Premio dominicano de popularidad decidido por el público. Descontinuado.'),
  ('f2d146ae-9b35-4c72-8e60-5a37cb91d284'::uuid, 'Premio Merengue del Año', NULL,
   'República Dominicana',
   'Galardón dominicano dedicado al merengue. Distinto de la categoría homónima de Premios Casandra. Descontinuado.')
ON CONFLICT (id) DO NOTHING;

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('0a51c7d3-4e86-4b19-9f27-c8035ad6e14b'::uuid, 'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid, 'Revelación del Año'),
  ('1b62d8e4-5f97-4c2a-a038-d9146be7f25c'::uuid, 'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid, 'Cantante del Año'),
  ('2c73e9f5-60a8-4d3b-b149-ea257cf8036d'::uuid, 'd4b8e615-2c07-4a3f-81de-96af1b70c359'::uuid, 'Cantante del Año'),
  ('3d84fa06-71b9-4e4c-c25a-fb368da9147e'::uuid, 'e7c93b28-6f41-4d80-a2b5-1e8dc4076f9a'::uuid, 'Cantante Más Destacada'),
  ('4e950b17-82ca-4f5d-d36b-0c479eba258f'::uuid, 'e7c93b28-6f41-4d80-a2b5-1e8dc4076f9a'::uuid, 'Disco del Año'),
  ('5fa61c28-93db-4a6e-e47c-1d58afcb3690'::uuid, 'e7c93b28-6f41-4d80-a2b5-1e8dc4076f9a'::uuid, 'Cantante del Año'),
  ('60b72d39-a4ec-4b7f-f58d-2e69badc47a1'::uuid, 'f2d146ae-9b35-4c72-8e60-5a37cb91d284'::uuid, 'Disco del Año')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('f84b208b-dd57-43ad-b2bf-d5099e2f0e0e'::uuid,
   'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
   '0a51c7d3-4e86-4b19-9f27-c8035ad6e14b'::uuid,
   1980, NULL, true, 'olgalara.com y Wikipedia (es), coincidentes'),
  ('f84b208b-dd57-43ad-b2bf-d5099e2f0e0e'::uuid,
   'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
   '1b62d8e4-5f97-4c2a-a038-d9146be7f25c'::uuid,
   1982, NULL, true, 'olgalara.com y Wikipedia (es), coincidentes'),
  ('f84b208b-dd57-43ad-b2bf-d5099e2f0e0e'::uuid,
   'd4b8e615-2c07-4a3f-81de-96af1b70c359'::uuid,
   '2c73e9f5-60a8-4d3b-b149-ea257cf8036d'::uuid,
   1981, NULL, true, 'Wikipedia (es); olgalara.com no menciona este premio'),
  ('f84b208b-dd57-43ad-b2bf-d5099e2f0e0e'::uuid,
   'd4b8e615-2c07-4a3f-81de-96af1b70c359'::uuid,
   '2c73e9f5-60a8-4d3b-b149-ea257cf8036d'::uuid,
   1982, NULL, true, 'Wikipedia (es); olgalara.com no menciona este premio'),
  ('f84b208b-dd57-43ad-b2bf-d5099e2f0e0e'::uuid,
   'e7c93b28-6f41-4d80-a2b5-1e8dc4076f9a'::uuid,
   '3d84fa06-71b9-4e4c-c25a-fb368da9147e'::uuid,
   1983, NULL, true, 'olgalara.com y Wikipedia (es), coincidentes'),
  ('f84b208b-dd57-43ad-b2bf-d5099e2f0e0e'::uuid,
   'e7c93b28-6f41-4d80-a2b5-1e8dc4076f9a'::uuid,
   '4e950b17-82ca-4f5d-d36b-0c479eba258f'::uuid,
   1984, 'Romance y Ritmo', true, 'olgalara.com y Wikipedia (es), coincidentes'),
  ('f84b208b-dd57-43ad-b2bf-d5099e2f0e0e'::uuid,
   'e7c93b28-6f41-4d80-a2b5-1e8dc4076f9a'::uuid,
   '5fa61c28-93db-4a6e-e47c-1d58afcb3690'::uuid,
   1985, NULL, true, 'olgalara.com y Wikipedia (es), coincidentes'),
  ('f84b208b-dd57-43ad-b2bf-d5099e2f0e0e'::uuid,
   'f2d146ae-9b35-4c72-8e60-5a37cb91d284'::uuid,
   '60b72d39-a4ec-4b7f-f58d-2e69badc47a1'::uuid,
   1985, 'Cualquiera Se Engaña', true, 'Wikipedia (es)');

COMMIT;
