BEGIN;

-- Registra los tres Premios Casandra de Joe Veras, que no tenía ninguno
-- guardado. No hace falta crear categorías: las dos ya existen.
--
-- Salió al reescribir su ficha, la decimocuarta de las 211 que seguían solo en
-- inglés.
--
-- LAS TRES ADJUDICACIONES
--
--   1997  Premios Casandra  Bachatero del Año
--   2004  Premios Casandra  Bachatero del Año   Carta de Verano
--   2006  Premios Casandra  Bachata del Año     La Pared (comp. Enrique Félix)
--
-- LAS TRES BAJO "PREMIOS CASANDRA" y no Soberano: son anteriores al cambio de
-- nombre de 2012.
--
-- EL DE 1997 VA SIN OBRA, Y ES DELIBERADO. Mi fuente se contradice consigo
-- misma: el palmarés de Bachata Republic atribuye ese premio a "Con más amor"
-- (1996) y la biografía del mismo sitio se lo atribuye a "Así es la vida"
-- (1997). Las dos lecturas son defendibles -- el premio de una ceremonia suele
-- ser por el trabajo del año anterior, lo que favorece a "Con más amor", pero
-- la biografía es explícita en la otra dirección. Sin desempate, `work` se
-- queda vacío antes que afirmar el disco equivocado.
--
-- "LA PARED" LLEVA EL COMPOSITOR ESCRITO en `work`, como en la migración de
-- Frank Reyes: la categoría premia la canción, el intérprete recoge la
-- estatuilla y la letra no es suya. Enrique Félix no tiene ficha; queda anotado
-- como ausencia.
--
-- OJO CON LA GRAFÍA DEL COMPOSITOR: el palmarés de Bachata Republic lo escribe
-- "Enrique Féliz" con zeta y su biografía de Joe Veras lo escribe "Enrique
-- Félix" con equis, citando a El Nacional. Uso la forma con equis, que es la
-- del artículo referenciado, y lo dejo anotado para cuando se le haga ficha.
--
-- year ES EL AÑO DE LA CEREMONIA, como en el resto de la tabla.
--
-- FUENTE: Bachata Republic, biografía de Joe Veras y palmarés de Bachatero del
-- Año y de Bachata del Año (Luis Becker Cabrera, 8, 15 y 20 de julio de 2021),
-- referenciados a ACROARTE, Hoy Digital, El Día, El Caribe y Diario Libre.
--
-- PARA REVERTIR: supabase/rollback/20260908007000_revert_joe_veras_awards.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('aec32df5-cc5a-43c2-ac33-02bc8caa1cf5'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'ba7087a5-4bf5-4a90-888c-554e335217d2'::uuid, 1997, NULL, true,
   'Bachata Republic, palmarés de Bachatero del Año y biografía de Joe Veras; las dos fuentes discrepan sobre el disco premiado'),

  ('aec32df5-cc5a-43c2-ac33-02bc8caa1cf5'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   'ba7087a5-4bf5-4a90-888c-554e335217d2'::uuid, 2004, 'Carta de Verano', true,
   'Bachata Republic, palmarés de Bachatero del Año, referenciado a ACROARTE y prensa dominicana'),

  ('aec32df5-cc5a-43c2-ac33-02bc8caa1cf5'::uuid, 'ead83dcf-9e2c-4f69-a557-dad604716a5e'::uuid,
   '4e6a932d-4c49-4a48-95e1-cc8ecadf1d1f'::uuid, 2006, 'La Pared, compuesta por Enrique Félix', true,
   'Bachata Republic, palmarés de Bachata del Año y biografía de Joe Veras, citando a El Nacional');

COMMIT;
