BEGIN;

-- Revierte 20260907012900_restore_spanish_accents.sql.
--
-- Devuelve los nombres sin acentos y vuelve a partir en dos la categoría
-- "Merengue del Año". La categoría fusionada se recrea con su id original para
-- que las dos adjudicaciones de Eddy Herrera regresen a donde estaban.

-- 4. Lugar de nacimiento
UPDATE artists SET birth_place = 'La Pena', updated_at = now()
 WHERE slug = 'el-gringo-de-la-bachata' AND birth_place = 'La Peña';

-- 3. Títulos de obra
UPDATE artist_awards SET work = 'Demasiado Nina'          WHERE work = 'Demasiado Niña';
UPDATE artist_awards SET work = 'Pegame Tu Vicio'         WHERE work = 'Pégame Tu Vicio';
UPDATE artist_awards SET work = 'Es merengue ¿Algun Problema?'
                                                          WHERE work = 'Es merengue ¿Algún Problema?';
UPDATE artist_awards SET work = 'Este es mi pais'         WHERE work = 'Este es mi país';
UPDATE artist_awards SET work = 'La Mejor Version de Mi'  WHERE work = 'La Mejor Versión de Mí';
UPDATE artist_awards SET work = 'Solo Tu y Yo'            WHERE work = 'Solo Tú y Yo';
UPDATE artist_awards SET work = 'Soy Mama (remix)'        WHERE work = 'Soy Mama (remix)';

-- 2. Nombres de premios
UPDATE awards SET name = 'Congreso Nacional de la Republica Dominicana'
 WHERE id = '748be643-80ea-4c18-9558-b9a1a414f4f9'::uuid;

UPDATE awards SET name = 'Festival Internacional de la Cancion de Vina del Mar'
 WHERE id = '4a53f454-d352-4e19-99a6-bff6cbbc8845'::uuid;

UPDATE awards SET name = 'Premios Tu Musica Urbano'
 WHERE id = '32d73576-29be-40c4-b529-a7ce943fe2ec'::uuid;

-- 1. Categorías: se deshace la fusión primero, luego los renombrados.
INSERT INTO award_categories (id, award_id, name)
VALUES ('1379b724-049a-4908-b75f-ec91c58e496e'::uuid,
        'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
        'Merengue del Ano')
ON CONFLICT (id) DO NOTHING;

UPDATE artist_awards
   SET category_id = '1379b724-049a-4908-b75f-ec91c58e496e'::uuid
 WHERE category_id = 'fd798175-f2c4-4195-8967-b7ce424267c2'::uuid
   AND year IN (2000, 2001);

UPDATE award_categories SET name = 'Espectaculo del Ano'
 WHERE id = 'f860b57c-cc72-4891-aa43-9e06d8c10b98'::uuid;

UPDATE award_categories SET name = 'Orquesta Revelacion del Ano'
 WHERE id = 'b3f0d496-d3f4-4e72-af92-5a9e5115c25b'::uuid;

UPDATE award_categories SET name = 'Proyeccion Internacional'
 WHERE id = '22e479e2-e09f-4550-a76d-ff7675a77793'::uuid;

UPDATE award_categories SET name = 'Videoclip del Ano'
 WHERE id = 'a828f9ca-5b81-4c2e-aad2-ee2b93fefcc7'::uuid;

COMMIT;
