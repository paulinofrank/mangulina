BEGIN;

-- Registra las diez adjudicaciones de Frank Reyes, que no tenía ninguna
-- guardada. No hace falta crear categorías: las cuatro ya existen.
--
-- Salió al reescribir su ficha, la decimotercera de las 211 que seguían solo en
-- inglés. Es el dato que define su carrera y la biografía no lo tenía.
--
-- SIETE VECES BACHATERO DEL AÑO, QUE ES EL RÉCORD DE LA CATEGORÍA
--
--   1999  Premios Casandra  Vine A Decirte Adiós
--   2002  Premios Casandra  Amor en Silencio
--   2003  Premios Casandra  Déjame Entrar En Ti
--   2005  Premios Casandra  Cuando Se Quiere Se Puede
--   2015  Premios Soberano  Soy Tuyo
--   2017  Premios Soberano  Noche de Pasión
--   2018  Premios Soberano  Devuélveme Mi Libertad
--
-- Por delante de Zacarías Ferreira (6), Antony Santos (5), Raulín Rodríguez
-- (3), Joe Veras (2) y una cada uno de Teodoro Reyes, Luis Miguel del Amargue
-- y Elvis Martínez.
--
-- TRES VECES BACHATA DEL AÑO, que premia la canción y no al intérprete
--
--   2005  Premios Casandra  Quién Eres Tú
--   2007  Premios Casandra  Princesa          (comp. Rafael Martín Céspedes)
--   2026  Premios Soberano  Quién Te Dio El Derecho  (comp. Ángela Milagros Santos)
--
-- LAS DOS COMPOSICIONES AJENAS VAN DICHAS EN `work`. El premio es del
-- intérprete, pero la letra no es suya y el catálogo no debe sugerir que sí.
--
-- EL REPARTO ENTRE CASANDRA Y SOBERANO LO DECIDE LA FECHA, como en las
-- migraciones anteriores: el galardón cambió de nombre en 2012.
--
-- ---------------------------------------------------------------------------
-- ERRATA QUE ENCUENTRO Y NO CORRIJO AQUÍ
--
-- La categoría de Premios Soberano se llama en la base "Bachatero de Año", sin
-- el "del". Es una errata, no una variante: bajo Premios Casandra la misma
-- categoría está bien escrita, "Bachatero del Año".
--
-- NO SE TOCA EN ESTA MIGRACIÓN porque es una entidad compartida y arreglarla
-- cambia lo que se muestra en las fichas de otros artistas. Queda anotada en
-- ORTOGRAFIA_PENDIENTE.md, que es donde se están juntando estas cosas para un
-- pase único.
-- ---------------------------------------------------------------------------
--
-- NO SE REGISTRA la nominación a Mejor Vídeo Musical de Bachata en los Premios
-- Videoclip Awards 2016 por "Cómo Sanar": el catálogo no tiene esa entidad, la
-- fuente es una sola y no encontré el listado oficial de la premiación. Si
-- aparece, es un `INSERT` de una fila.
--
-- TAMPOCO SE REGISTRA que en 2001 las cadenas de radio y televisión dominicanas
-- lo nombraran artista bachatero del año. No es un galardón con entidad ni con
-- listado; está en la biografía como lo que es, un reconocimiento de los medios.
--
-- FUENTE de las diez: Bachata Republic, "Ganadores del premio Bachatero del
-- Año" y "Ganadores de Bachata del Año en Premios Soberano" (Luis Becker
-- Cabrera, 15 y 20 de julio de 2021), que publican los palmarés completos
-- referenciados a ACROARTE, Listín Diario, Diario Libre, Hoy y El Día. La de
-- 2026 la dan El Nuevo Diario, Listín Diario y Conectate del 18 al 20 de marzo
-- de 2026, con el listado completo de esa gala. La de 2018 la confirma además
-- Wikipedia en español.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla. El disco o la
-- canción premiados suelen ser del año anterior.
--
-- PARA REVERTIR: supabase/rollback/20260908006800_revert_frank_reyes_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  -- Bachatero del Año, etapa Premios Casandra
  ('3dd83e6b-2058-4d04-ac68-38e11d9348a9'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'ba7087a5-4bf5-4a90-888c-554e335217d2'::uuid, 1999, 'Vine A Decirte Adiós', true,
   'Bachata Republic, palmarés de Bachatero del Año, referenciado a ACROARTE y prensa dominicana'),
  ('3dd83e6b-2058-4d04-ac68-38e11d9348a9'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'ba7087a5-4bf5-4a90-888c-554e335217d2'::uuid, 2002, 'Amor en Silencio', true,
   'Bachata Republic, palmarés de Bachatero del Año, referenciado a ACROARTE y prensa dominicana'),
  ('3dd83e6b-2058-4d04-ac68-38e11d9348a9'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'ba7087a5-4bf5-4a90-888c-554e335217d2'::uuid, 2003, 'Déjame Entrar En Ti', true,
   'Bachata Republic, palmarés de Bachatero del Año, referenciado a ACROARTE y prensa dominicana'),
  ('3dd83e6b-2058-4d04-ac68-38e11d9348a9'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'ba7087a5-4bf5-4a90-888c-554e335217d2'::uuid, 2005, 'Cuando Se Quiere Se Puede', true,
   'Bachata Republic; Hoy Digital del 22 de febrero de 2005, "Frank Reyes, máximo ganador"'),

  -- Bachatero del Año, etapa Premios Soberano
  ('3dd83e6b-2058-4d04-ac68-38e11d9348a9'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   'e016ac69-513d-4a40-b636-e148aae081c0'::uuid, 2015, 'Soy Tuyo', true,
   'Bachata Republic, palmarés de Bachatero del Año, referenciado a ACROARTE y prensa dominicana'),
  ('3dd83e6b-2058-4d04-ac68-38e11d9348a9'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   'e016ac69-513d-4a40-b636-e148aae081c0'::uuid, 2017, 'Noche de Pasión', true,
   'Bachata Republic, citando la lista de ganadores de Diario Libre del 29 de marzo de 2017'),
  ('3dd83e6b-2058-4d04-ac68-38e11d9348a9'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   'e016ac69-513d-4a40-b636-e148aae081c0'::uuid, 2018, 'Devuélveme Mi Libertad', true,
   'Bachata Republic, citando la lista oficial de ACROARTE de 2018; Wikipedia (es)'),

  -- Bachata del Año
  ('3dd83e6b-2058-4d04-ac68-38e11d9348a9'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '4e6a932d-4c49-4a48-95e1-cc8ecadf1d1f'::uuid, 2005, 'Quién Eres Tú', true,
   'Bachata Republic, palmarés de Bachata del Año'),
  ('3dd83e6b-2058-4d04-ac68-38e11d9348a9'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '4e6a932d-4c49-4a48-95e1-cc8ecadf1d1f'::uuid, 2007, 'Princesa, compuesta por Rafael Martín Céspedes', true,
   'Bachata Republic, palmarés de Bachata del Año'),
  ('3dd83e6b-2058-4d04-ac68-38e11d9348a9'::uuid, 'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   '3ba3ced3-dcbf-4436-8356-5f9f41f1546e'::uuid, 2026, 'Quién Te Dio El Derecho, compuesta por Ángela Milagros Santos', true,
   'El Nuevo Diario, Listín Diario y Conectate, listado de ganadores de los Premios Soberano 2026');

COMMIT;
