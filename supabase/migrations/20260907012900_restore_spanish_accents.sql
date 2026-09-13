BEGIN;

-- Restaura acentos y eñes perdidos en premios, categorías, títulos de obra y un
-- lugar de nacimiento.
--
-- Pedido del editor: "Corrige la n por ñ por favor". Salió al escribir la ficha
-- de Olga Lara, donde había que usar la categoría "Espectaculo del Ano" de
-- Premios Casandra, escrita sin acentos, mientras la equivalente de Premios
-- Soberano sí los llevaba.
--
-- SOLO SE CORRIGE LO QUE NO ADMITE DUDA. Los nombres en inglés se quedan como
-- están: "Album of the Year" y "Best Salsa Album" están bien escritos y no son
-- errores de acento.
--
-- 1. CATEGORÍAS DE PREMIOS CASANDRA. Cuatro renombrados y una fusión.
--
--    La fusión es forzada: al ponerle el acento a "Merengue del Ano" quedaría
--    idéntica a "Merengue del Año", que ya existe en el mismo premio. Son la
--    misma categoría partida en dos filas, así que se mueven las dos
--    adjudicaciones de Eddy Herrera a la fila acentuada y se borra la otra.
--    No hay índice único sobre (artist, award, category, year), y de todos
--    modos no hay colisión: los años y los artistas son distintos.
--
-- 2. NOMBRES DE PREMIOS. Tres, incluido "Vina del Mar", que además de la eñe le
--    faltaba el acento de "Canción".
--
-- 3. TÍTULOS DE OBRA en artist_awards. Siete, todos verificables contra el
--    título publicado de la canción o el disco.
--
-- 4. LUGAR DE NACIMIENTO. "La Pena" es "La Peña", distrito municipal de la
--    provincia Duarte.
--
-- LO QUE NO SE TOCA Y QUEDA REPORTADO, porque corregirlo sería adivinar:
--
--    adriel-music guarda last_name "Castanos" y second_last_name "Palin".
--    Casi con seguridad son "Castaños" y "Palín" -- de hecho el first_name
--    "Óscar" sí está acentuado, lo que sugiere una carga a medias --, pero no
--    encontré ninguna fuente que publique su nombre legal, y un apellido
--    inventado es peor que un apellido sin tilde.
--
--    artist_awards guarda la obra "No Te Abondones". No es un problema de
--    acento sino una probable errata de "No Te Abandones". Se deja para
--    verificar contra el título real.
--
--    Los nombres artísticos "Nino Freestyle" y "The Nino" NO se tocan: escribir
--    "Nino" sin eñe puede ser decisión del artista, y el catálogo registra el
--    nombre como se usa.
--
-- PARA REVERTIR: supabase/rollback/20260907012900_revert_spanish_accents.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

-- 1. Categorías de Premios Casandra ------------------------------------------

UPDATE award_categories SET name = 'Espectáculo del Año'
 WHERE id = 'f860b57c-cc72-4891-aa43-9e06d8c10b98'::uuid;

UPDATE award_categories SET name = 'Orquesta Revelación del Año'
 WHERE id = 'b3f0d496-d3f4-4e72-af92-5a9e5115c25b'::uuid;

UPDATE award_categories SET name = 'Proyección Internacional'
 WHERE id = '22e479e2-e09f-4550-a76d-ff7675a77793'::uuid;

UPDATE award_categories SET name = 'Videoclip del Año'
 WHERE id = 'a828f9ca-5b81-4c2e-aad2-ee2b93fefcc7'::uuid;

-- Fusión de "Merengue del Ano" dentro de "Merengue del Año".
UPDATE artist_awards
   SET category_id = 'fd798175-f2c4-4195-8967-b7ce424267c2'::uuid
 WHERE category_id = '1379b724-049a-4908-b75f-ec91c58e496e'::uuid;

DELETE FROM award_categories
 WHERE id = '1379b724-049a-4908-b75f-ec91c58e496e'::uuid;

-- 2. Nombres de premios -------------------------------------------------------

UPDATE awards SET name = 'Congreso Nacional de la República Dominicana'
 WHERE id = '748be643-80ea-4c18-9558-b9a1a414f4f9'::uuid;

UPDATE awards SET name = 'Festival Internacional de la Canción de Viña del Mar'
 WHERE id = '4a53f454-d352-4e19-99a6-bff6cbbc8845'::uuid;

UPDATE awards SET name = 'Premios Tu Música Urbano'
 WHERE id = '32d73576-29be-40c4-b529-a7ce943fe2ec'::uuid;

-- 3. Títulos de obra ----------------------------------------------------------

UPDATE artist_awards SET work = 'Demasiado Niña'          WHERE work = 'Demasiado Nina';
UPDATE artist_awards SET work = 'Pégame Tu Vicio'         WHERE work = 'Pegame Tu Vicio';
UPDATE artist_awards SET work = 'Es merengue ¿Algún Problema?'
                                                          WHERE work = 'Es merengue ¿Algun Problema?';
UPDATE artist_awards SET work = 'Este es mi país'         WHERE work = 'Este es mi pais';
UPDATE artist_awards SET work = 'La Mejor Versión de Mí'  WHERE work = 'La Mejor Version de Mi';
UPDATE artist_awards SET work = 'Solo Tú y Yo'            WHERE work = 'Solo Tu y Yo';
UPDATE artist_awards SET work = 'Soy Mamá (remix)'        WHERE work = 'Soy Mama (remix)';

-- 4. Lugar de nacimiento ------------------------------------------------------

UPDATE artists SET birth_place = 'La Peña', updated_at = now()
 WHERE slug = 'el-gringo-de-la-bachata' AND birth_place = 'La Pena';

COMMIT;
