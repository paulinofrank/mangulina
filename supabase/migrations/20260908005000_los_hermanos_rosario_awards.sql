BEGIN;

-- Registra los cinco reconocimientos de Los Hermanos Rosario, que no tenía
-- ninguno, y crea una categoría bajo Guinness World Records.
--
-- Salió al reescribir su ficha, la séptima de las 211 que siguen solo en inglés
-- por enlaces entrantes.
--
-- UNA CATEGORÍA NUEVA
--
--   "Mayor Público Frente a una Tarima" bajo Guinness World Records, que hasta
--   ahora solo tenía una categoría y muy específica ("Most Premio Lo Nuestro
--   nominations in a single year (female)"). El récord es de los carnavales de
--   las Islas Canarias y lo comparten con el puertorriqueño Andy Montañez.
--
-- SE REUTILIZAN CUATRO CATEGORÍAS EXISTENTES
--
--   "Tropical Album of the Year" bajo Billboard Latin Music. OJO: el catálogo
--   tiene TRES entidades Billboard -- "Billboard Latin Music", "Billboard Latin
--   Music Awards" y "Premios Billboard de la Música Latina" -- que muy
--   probablemente sean la misma y están reportadas como duplicado pendiente. Se
--   usa la primera, que es la que más adjudicaciones tiene (seis) y por tanto
--   la que menos habría que mover el día que se fundan.
--
--   "Congo de Oro" de la entidad del mismo nombre, de los Carnavales de
--   Barranquilla. NO se usa "Merengue Extranjero", que también existe: la
--   fuente dice "premiados en múltiples ocasiones con los Congos de Oro" sin
--   precisar categoría, y elegir una sería inventarla.
--
--   "Gold Records" y "Platinum Records" de Sales Certifications.
--
-- LAS CINCO ADJUDICACIONES, TODAS SIN AÑO
--
--   Billboard Latin Music   Tropical Album of the Year   Los Dueños del Swing
--   Congo de Oro            Congo de Oro                 varias veces, incluido un Súper Congo de Oro
--   Guinness                Mayor Público Frente a una Tarima
--   Sales Certifications    Gold Records                 seis producciones
--   Sales Certifications    Platinum Records             incluye doble platino
--
-- NINGUNA LLEVA AÑO Y ESO ES DELIBERADO. La fuente enumera los reconocimientos
-- sin fecharlos: dice que Billboard premió "Los Dueños del Swing" pero no en
-- qué ceremonia, y dice "múltiples ocasiones" de los Congos de Oro sin listar
-- años. Poner 1996 para el Billboard porque el disco es de 1995 sería deducir,
-- no registrar. year admite NULL y para eso está.
--
-- LO QUE NO SE REGISTRA, Y ES MUCHO MÁS DE LO QUE SE REGISTRA. La fuente da
-- cifras de ventas -- 500.000 copias de "Los Dueños del Swing" -- y la ficha
-- vieja afirmaba que fueron "the best-selling Latin act in the world". Las
-- cifras de ventas crudas no van a esta tabla ni a la prosa; las
-- CERTIFICACIONES sí, porque son hechos de industria verificables, y son las
-- dos filas de Sales Certifications que sí entran.
--
-- TAMPOCO SE REGISTRA como premio el que "Pecadora" esté en la banda sonora de
-- "Tacones Lejanos", de Almodóvar. Es un crédito, no una adjudicación, y está
-- en la biografía.
--
-- PARA REVERTIR: supabase/rollback/20260908005000_revert_los_hermanos_rosario_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('be2c9d51-79a2-4f1c-9ae4-8e2f0b6d4a37'::uuid,
   '4a21b93b-25b1-4b20-981e-9880fdb0f3f8'::uuid, 'Mayor Público Frente a una Tarima')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('3422883e-7048-48af-bb03-c68c8c557ee4'::uuid, '701d65c9-5441-4372-93ad-a1e320437fe1'::uuid,
   '9ad70fe5-bc53-4a0a-8abb-6a94fea5e640'::uuid, NULL, 'Los Dueños del Swing', true,
   'Wikipedia (es); la fuente no da el año de la ceremonia'),

  ('3422883e-7048-48af-bb03-c68c8c557ee4'::uuid, 'd86f297c-3b97-48bf-953b-ef64a7b74a08'::uuid,
   '491dc7fe-129c-47b9-bfb8-e3258a2205a4'::uuid, NULL,
   'Ganado en varias ocasiones en los Carnavales de Barranquilla, incluido un Súper Congo de Oro', true,
   'Wikipedia (es); la fuente no fecha ninguna de las ocasiones'),

  ('3422883e-7048-48af-bb03-c68c8c557ee4'::uuid, '4a21b93b-25b1-4b20-981e-9880fdb0f3f8'::uuid,
   'be2c9d51-79a2-4f1c-9ae4-8e2f0b6d4a37'::uuid, NULL,
   'Carnavales de las Islas Canarias; récord compartido con Andy Montañez', true,
   'Wikipedia (es)'),

  ('3422883e-7048-48af-bb03-c68c8c557ee4'::uuid, 'd5fa3fdd-b0bf-426a-bead-1e7ff4a657b5'::uuid,
   'ea68bb41-6dc4-4b72-885c-25d3450082d1'::uuid, NULL,
   'Otra Vez, Fuera de Serie, Insuperables, Los Mundialmente Sabrosos, Los Dueños del Swing y Y Es Fácil!', true,
   'Wikipedia (es)'),

  ('3422883e-7048-48af-bb03-c68c8c557ee4'::uuid, 'd5fa3fdd-b0bf-426a-bead-1e7ff4a657b5'::uuid,
   'f9c96520-c8ff-4342-bc7b-91b50878f74f'::uuid, NULL,
   'Incluye doble platino; la RIAA certificó ventas de Los Mundialmente Sabrosos, Los Dueños del Swing e Y Es Fácil!', true,
   'Wikipedia (es)');

COMMIT;
