BEGIN;

-- Registra los cinco reconocimientos de Aramis Camilo, ficha creada hoy, y crea
-- el premio panameño Búho de Oro y la categoría Soberano Especial.
--
-- CONTEXTO: Aramis Camilo NO EXISTÍA en el catálogo. Salió dos veces el mismo
-- día al reescribir a Yoskar Sarante y a Benny Sadel, que pasaron los dos por su
-- orquesta, y el editor lo marcó como prioridad absoluta. Su ficha se creó en la
-- migración 20260908003100.
--
-- UN PREMIO NUEVO
--
--   "Búho de Oro", galardón panameño que recibió en 1984 por su popularidad en
--   ese país. El catálogo no tenía ninguna entidad panameña.
--
-- UNA CATEGORÍA NUEVA
--
--   "Soberano Especial" bajo Premios Soberano. OJO, PORQUE HAY DOS VECINAS Y NO
--   SON LO MISMO: el premio ya tiene "Casandra Especial" -- que es el nombre
--   anterior a 2012, cuando el galardón se llamaba Casandra -- y "Soberano al
--   Mérito", que es otra distinción. Acroarte llamó a esta, en su comunicado de
--   marzo de 2025, "Soberano Especial", y con ese nombre se registra. Si el
--   editor determina que "Casandra Especial" y "Soberano Especial" son la misma
--   distinción en sus dos épocas, se funden; mientras tanto cada una conserva el
--   nombre con que se entregó.
--
-- SE REUTILIZAN TRES CATEGORÍAS EXISTENTES: "Revelación del Año" de Premios El
-- Dorado, "Keys to the City" y "Gold Records" de Sales Certifications.
--
-- LAS CINCO ADJUDICACIONES
--
--   1984  Premios El Dorado      Revelación del Año     La Organización Secreta
--   1984  Búho de Oro            Panamá
--   1986  Keys to the City       Nueva York
--   1990  Sales Certifications   Gold Records           Candela pa' los Pies
--   2025  Premios Soberano       Soberano Especial      40 aniversario
--
-- EL PREMIO EL DORADO DE 1984 SE LO DIERON A LA ORQUESTA, NO A ÉL. La fuente
-- dice que ganó "La Organización Secreta" como revelación del año, por su auge
-- durante 1983. La orquesta NO TIENE FILA PROPIA todavía -- queda pendiente en
-- el inventario de separación persona/grupo -- así que la adjudicación cuelga
-- de su director, que es lo único que el catálogo puede sostener hoy, Y EL
-- CAMPO work LO DICE EXPRESAMENTE para que el día que exista la fila del grupo
-- se pueda mover sin perder el matiz.
--
-- LA FUENTE DEL SOBERANO ESPECIAL ES LA BUENA: Listín Diario, 16 de marzo de
-- 2025, con declaraciones de la presidenta de Acroarte, Wanda Sánchez, y del
-- propio artista. La ceremonia fue el 25 de marzo en el Teatro Nacional Eduardo
-- Brito. Los otros cuatro salen de la biografía de Fausto Polanco, republicada
-- por Conéctate: es UNA fuente, no dos, y así queda anotado.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- PARA REVERTIR: supabase/rollback/20260908003200_revert_aramis_camilo_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO awards (id, name, organization, country)
VALUES
  ('7e93236e-96dd-4c90-9bb8-46969104f7cd'::uuid,
   'Búho de Oro', 'Premios Búho de Oro', 'Panamá')
ON CONFLICT (id) DO NOTHING;

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('242e3b34-aaa5-411f-bb5c-60c1083724ff'::uuid,
   '7e93236e-96dd-4c90-9bb8-46969104f7cd'::uuid, 'Búho de Oro'),
  ('56bc3ef9-25e5-4a1e-b077-df85018f5d11'::uuid,
   'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid, 'Soberano Especial')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ((select id from artists where slug = 'aramis-camilo'),
   'c1a7f402-58d3-4e19-9b6a-73f0e2c5148d'::uuid,
   '0a51c7d3-4e86-4b19-9f27-c8035ad6e14b'::uuid, 1984,
   'Otorgado a la orquesta La Organización Secreta por su auge durante 1983; el premio lo daba la empresa Bermúdez', true,
   'Fausto Polanco, biografía de 2015, republicada por Conéctate en 2025'),

  ((select id from artists where slug = 'aramis-camilo'),
   '7e93236e-96dd-4c90-9bb8-46969104f7cd'::uuid,
   '242e3b34-aaa5-411f-bb5c-60c1083724ff'::uuid, 1984, 'Panamá', true,
   'Fausto Polanco, biografía de 2015, republicada por Conéctate en 2025'),

  ((select id from artists where slug = 'aramis-camilo'),
   '32809733-7cd4-4852-a177-5e097acde0b5'::uuid,
   '769a84a7-7fb7-46fb-bdd1-18de8de7362b'::uuid, 1986,
   'Nueva York, un año después de su presentación en el Lincoln Center', true,
   'Fausto Polanco, biografía de 2015, republicada por Conéctate en 2025'),

  ((select id from artists where slug = 'aramis-camilo'),
   'd5fa3fdd-b0bf-426a-bead-1e7ff4a657b5'::uuid,
   'ea68bb41-6dc4-4b72-885c-25d3450082d1'::uuid, 1990,
   'Candela pa'' los Pies', true,
   'Fausto Polanco, biografía de 2015, republicada por Conéctate en 2025'),

  ((select id from artists where slug = 'aramis-camilo'),
   'dec5d9e2-427b-414a-975f-41580488a7fd'::uuid,
   '56bc3ef9-25e5-4a1e-b077-df85018f5d11'::uuid, 2025,
   'Edición del 40 aniversario, 25 de marzo, Teatro Nacional Eduardo Brito; por 42 años de trayectoria', true,
   'Listín Diario, 16 de marzo de 2025, con declaraciones de Acroarte');

COMMIT;
