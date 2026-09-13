BEGIN;

-- Registra la colocación de Edilio Paredes en la lista de los 250 mejores
-- guitarristas de todos los tiempos de Rolling Stone, publicada el 13 de
-- octubre de 2023. Quedó en el puesto 244.
--
-- Salió al reescribir su ficha, la decimosexta de las 211 que seguían solo en
-- inglés. No tenía ninguna adjudicación guardada, y esta es la distinción
-- internacional más alta que ha recibido un guitarrista de bachata.
--
-- ---------------------------------------------------------------------------
-- POR QUÉ SE CREA UNA ENTIDAD NUEVA EN VEZ DE COLGARLO DE UNA EXISTENTE
--
-- Busqué antes: no hay ninguna entidad de revista en `awards` -- ni Rolling
-- Stone, ni ninguna otra -- entre las 57 que existen.
--
-- El catálogo YA REGISTRA colocaciones en listas de revista como
-- adjudicaciones: existe la categoría "50 Greatest Latin Artists of All Time"
-- bajo `Billboard Latin Music`, con una fila en uso. O sea que el patrón está
-- establecido y solo falta el cuerpo emisor.
--
-- Rolling Stone no es Billboard y no cabe bajo ninguna de las cuatro entidades
-- Billboard que ya existen, así que la alternativa a crearla sería perder el
-- dato o colgarlo de un emisor falso. Se crea.
-- ---------------------------------------------------------------------------
--
-- EL PUESTO VA EN `work`. La tabla no tiene columna de posición, y ese es el
-- contenido de la distinción: no es "ganó" un premio, es que quedó 244.º de
-- 250. `won` va en true porque figurar en la lista es la distinción; no hay
-- nominados que perdieran.
--
-- VERIFICADO APARTE Y NO SOLO POR WIKIPEDIA. Las dos ediciones de Wikipedia lo
-- dicen, pero las dos están marcadas por falta de referencias, así que fui a la
-- lista: la página de Rolling Stone lo incluye, y una docena de reproducciones
-- independientes de la lista completa lo colocan en el 244, entre Leslie West y
-- los hermanos Dessner.
--
-- year ES EL AÑO DE PUBLICACIÓN DE LA LISTA.
--
-- PARA REVERTIR: supabase/rollback/20260908007400_revert_edilio_paredes_rolling_stone.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO awards (id, name)
VALUES ('ea1d7252-d35e-44c6-bd32-d800f4cd7db0'::uuid, 'Rolling Stone')
ON CONFLICT (id) DO NOTHING;

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('d85ab773-2659-4b2f-9772-5f587f54424b'::uuid,
   'ea1d7252-d35e-44c6-bd32-d800f4cd7db0'::uuid,
   'The 250 Greatest Guitarists of All Time')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('cbda65a4-c7da-4762-8cf8-f29b942d2ac3'::uuid,
   'ea1d7252-d35e-44c6-bd32-d800f4cd7db0'::uuid,
   'd85ab773-2659-4b2f-9772-5f587f54424b'::uuid, 2023,
   'Puesto 244 de 250', true,
   'Rolling Stone, "The 250 Greatest Guitarists of All Time", 13 de octubre de 2023');

COMMIT;
