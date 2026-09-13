BEGIN;

-- Registra el premio al mejor album world beat que gano "El Duque de la
-- Bachata", de Joan Soriano, en los Indie Acoustic Project Awards.
--
-- Salio al reescribir su ficha, la decimonovena de las 211 que seguian solo en
-- ingles. No tenia ninguna adjudicacion guardada.
--
-- ---------------------------------------------------------------------------
-- POR QUE SE CREA UNA ENTIDAD NUEVA
--
-- Busque antes: no hay nada parecido entre las 58 entidades de `awards`. Los
-- Indie Acoustic Project Awards premian discos independientes de raiz acustica
-- y no cuelgan de ningun cuerpo que el catalogo ya tenga.
--
-- Es la segunda entidad que abro hoy, despues de Rolling Stone para el puesto
-- 244 de Edilio Paredes. Las dos por la misma razon: el catalogo ya registra
-- este tipo de reconocimiento -- tiene "50 Greatest Latin Artists of All Time"
-- bajo Billboard y una entidad de Guinness World Records -- y lo que faltaba
-- era el emisor, no el patron.
-- ---------------------------------------------------------------------------
--
-- EL AÑO NECESITA EXPLICACION Y POR ESO VA COMO VA.
--
-- Wikipedia en ingles dice "best World Beat Album of 2011". World Music
-- Central, que es especializada, titula su nota del 16 de mayo de 2011 "Indie
-- Acoustic Project 2010 Winners Announced" y dentro dice que Soriano gano la
-- categoria World Beat con "El Duque de la Bachata".
--
-- Es decir: EDICION DE 2010, ANUNCIADA EN MAYO DE 2011. Se guarda 2010, que es
-- la edicion, y el anuncio queda escrito en `work` para que nadie lo registre
-- otra vez como un premio distinto de 2011. Misma disciplina que con el Gran
-- Soberano de Luis Segura.
--
-- La ficha del Kennedy Center confirma el premio sin dar año, lo que no
-- desempata pero si respalda que existe.
--
-- NO SE REGISTRAN AQUI las posiciones de lista -- semanas en el top diez de
-- Tropical Albums para "El Duque de la Bachata" y debut en el numero tres para
-- "La Familia Soriano" --. Son posiciones de cartelera, no adjudicaciones, y
-- estan en la biografia.
--
-- PARA REVERTIR: supabase/rollback/20260908008300_revert_joan_soriano_indie_acoustic.sql
--
-- Aplicado directamente por DATABASE_URL. No corrio ninguna funcion de Vercel
-- y no se revalido nada.

INSERT INTO awards (id, name)
VALUES ('ddfd9121-8fcd-47d5-b0d9-44cbac324ee3'::uuid, 'Indie Acoustic Project Awards')
ON CONFLICT (id) DO NOTHING;

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('bd9cd8a7-49a7-46f6-b38e-0565fd455fd1'::uuid,
   'ddfd9121-8fcd-47d5-b0d9-44cbac324ee3'::uuid,
   'Best World Beat Album')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('4d9ac6ac-6802-47f4-8731-5fa567713513'::uuid,
   'ddfd9121-8fcd-47d5-b0d9-44cbac324ee3'::uuid,
   'bd9cd8a7-49a7-46f6-b38e-0565fd455fd1'::uuid, 2010,
   'El Duque de la Bachata; edicion de 2010, ganadores anunciados en mayo de 2011', true,
   'World Music Central, 16 de mayo de 2011; ficha de artista del Kennedy Center');

COMMIT;
