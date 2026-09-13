BEGIN;

-- Crea la entidad Premios Ondas y registra el galardón de Víctor Víctor, que
-- no tenía ninguno guardado.
--
-- Salió al reescribir su ficha, que era una de las 229 publicadas solo en
-- inglés y que no nombraba ni este premio ni "Mesita de Noche".
--
-- UN PREMIO NUEVO, Y DE PESO. Los Premios Ondas los entrega Radio Barcelona
-- desde 1954 y son uno de los galardones de comunicación y música más antiguos
-- de habla hispana. El catálogo no los tenía entre sus 51 premios y van a
-- volver a hacer falta: varios artistas dominicanos han pasado por ahí.
--
-- LA CATEGORÍA SE VERIFICÓ APARTE Y ESO CAMBIÓ LO QUE SE ESCRIBE. La ficha de
-- Wikipedia sobre Víctor Víctor solo dice "Premio Ondas 1993", sin categoría, y
-- sin cita. Con eso no bastaba para crear una entidad de premio. El anexo de
-- Premios Ondas 1993 -- página distinta, con la lista completa de premiados de
-- ese año -- lo confirma y da el nombre exacto: en el bloque de Música, "Mejor
-- artista o grupo revelación latino: Víctor Víctor".
--
-- Vale la pena dejar dicho el método: una segunda página de la misma
-- enciclopedia no es una segunda fuente en sentido estricto, pero una lista de
-- premiados por año es un registro distinto de una ficha biográfica, y da el
-- dato con una precisión que la ficha no tenía.
--
-- LA ADJUDICACIÓN
--
--   1993  Premios Ondas  Mejor Artista o Grupo Revelación Latino
--
-- El año es el de la ceremonia, como en el resto de la tabla. Cae tres años
-- después de Inspiraciones (1990), el disco de "Mesita de Noche", que es lo que
-- lo puso en el radar español.
--
-- PARA REVERTIR: supabase/rollback/20260908001300_revert_victor_victor_ondas_award.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO awards (id, name, organization, country)
VALUES
  ('24822599-3ffa-4b6a-9b11-163e51c3b64f'::uuid,
   'Premios Ondas',
   'Radio Barcelona, Cadena SER',
   'España')
ON CONFLICT (id) DO NOTHING;

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('52bc54a3-a08c-417a-a3ad-9c94b532e6ae'::uuid,
   '24822599-3ffa-4b6a-9b11-163e51c3b64f'::uuid,
   'Mejor Artista o Grupo Revelación Latino')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3'::uuid,
   '24822599-3ffa-4b6a-9b11-163e51c3b64f'::uuid,
   '52bc54a3-a08c-417a-a3ad-9c94b532e6ae'::uuid,
   1993, NULL, true,
   'Anexo:Premios Ondas 1993, lista de premiados; la ficha del artista da el año sin categoría');

COMMIT;
