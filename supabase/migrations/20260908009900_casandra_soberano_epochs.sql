BEGIN;

-- Coloca en su época las adjudicaciones de ACROARTE que estaban bajo el premio
-- equivocado, y deja escrito en las descripciones cuál era el nombre de cada
-- galardón en cada etapa, para que la confusión no vuelva.
--
-- ===========================================================================
-- LAS DOS ÉPOCAS, Y CÓMO SE LLAMABA CADA COSA EN CADA UNA
-- ===========================================================================
--
--   1985-2012  Premios Casandra   premio regular: el Casandra
--                                 máxima distinción: EL SOBERANO
--
--   2013-      Premios Soberano   premio regular: el Soberano
--                                 máxima distinción: EL GRAN SOBERANO
--
-- Es decir que "Soberano" cambia de significado en 2013: antes nombraba a la
-- distinción máxima; después nombra a la estatuilla corriente, y la máxima
-- pasa a llamarse "Gran Soberano". Ese desplazamiento es el que había metido
-- adjudicaciones de los ochenta y los noventa bajo el premio de 2013.
--
-- La prensa de la última gala Casandra, marzo de 2012, es unánime: Listín
-- Diario, Diario Libre, Acento, El Día y la nota de EFE en El Diario NY dicen
-- todas que Los Hermanos Rosario ganaron "El Soberano, el máximo galardón de
-- los premios Casandra". Y el titular de Hoy del 23 de marzo de 2004 dice
-- "Joseíto Mateo gana El Soberano de los premios Casandra".
--
-- ===========================================================================
-- LO QUE SE MUEVE
-- ===========================================================================
--
--   Wilfrido Vargas 2002   El Gran Soberano  ->  Premios Casandra, El Soberano
--   Joseíto Mateo 2004     El Gran Soberano  ->  Premios Casandra, El Soberano
--   Wilfrido Vargas 1999   Casandra Especial ->  Premios Casandra
--   Félix del Rosario      Casandra Especial ->  Premios Casandra
--   Wilfrido Vargas 1985   Orquesta del Año  ->  Premios Casandra
--
-- La categoría `Casandra Especial` colgaba entera de `Premios Soberano`, que
-- es imposible: lleva el nombre del premio de la primera etapa. Su otra
-- adjudicación, la de Wilfrido Vargas por sus 25 años de carrera, está fechada
-- en 1999 y lo confirma sin necesidad de fuente externa.
--
-- ===========================================================================
-- Y UN AÑO QUE APARECE
-- ===========================================================================
--
-- La adjudicación de Félix del Rosario no tenía año y su nota decía "la fuente
-- no fecha la entrega". Ahora sí: **1996**. Lo dice la propia ACROARTE en su
-- nota necrológica del 27 de octubre de 2012 -- "Acroarte reconoció su
-- trayectoria en el año 1996 otorgándole un Casandra Especial" -- y lo repiten
-- El Día, El Caribe y Hoy con la misma fecha. El Caribe lo amplía: "en 1996,
-- cuando Acroarte le entregó un Casandra Especial por su trayectoria".
--
-- 1996 cae de lleno en la etapa Casandra, así que confirma el traslado por
-- partida doble.
--
-- La descripción de la categoría decía "Reconocimiento a bodas de plata de
-- carrera". Eso describe el caso de Wilfrido Vargas, no el de Félix del
-- Rosario, que lo recibió por trayectoria a secas. Se amplía.
--
-- NO TOCA NINGUNA BIOGRAFÍA. La prosa de Joseíto Mateo, que llama "Gran
-- Soberano" a lo que en 2004 se llamaba "El Soberano", se corrige aparte.
--
-- PARA REVERTIR: supabase/rollback/20260908009900_revert_casandra_soberano_epochs.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

-- ---------------------------------------------------------------------------
-- 1. La categoría `Casandra Especial` pasa a los Premios Casandra
-- ---------------------------------------------------------------------------
UPDATE award_categories
   SET award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e',
       description = 'Distinción especial de los Premios Casandra (1985-2012), entregada fuera de concurso a una trayectoria o a una efeméride de carrera.'
 WHERE id = 'b336bbd9-0dfa-4331-8567-0b3e5a874252';

UPDATE artist_awards
   SET award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e'
 WHERE category_id = 'b336bbd9-0dfa-4331-8567-0b3e5a874252';

-- ---------------------------------------------------------------------------
-- 2. Félix del Rosario: el Casandra Especial ya tiene año
-- ---------------------------------------------------------------------------
UPDATE artist_awards
   SET year = 1996,
       work = 'Por su trayectoria',
       source = 'ACROARTE, nota necrológica del 27 de octubre de 2012; El Día, El Caribe y Hoy, 27 y 28 de octubre de 2012'
 WHERE id = '425b79bf-b210-497d-92a6-85dc93cc787a';

-- ---------------------------------------------------------------------------
-- 3. Wilfrido Vargas 1985, Orquesta del Año: a la categoría homónima de
--    Premios Casandra, que ya existía
-- ---------------------------------------------------------------------------
UPDATE artist_awards
   SET award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e',
       category_id = '51b1d03e-fe3d-432a-98b0-389facbd6a2e'
 WHERE id = 'a005e0a6-d146-42f0-9f00-46e901c94e47';

-- ---------------------------------------------------------------------------
-- 4. Las dos máximas distinciones que se entregaron en la etapa Casandra
-- ---------------------------------------------------------------------------

-- Wilfrido Vargas, 2002. Se lo entregó el presidente Hipólito Mejía.
UPDATE artist_awards
   SET award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e',
       category_id = '6d483d83-448c-4007-861d-89d53ce5f8fb',
       work = 'Máxima distinción de los Premios Casandra; se la entregó el presidente Hipólito Mejía',
       source = 'Tropicana (Colombia), 14 de febrero de 2002: "recibió en la noche del martes El Soberano, la más alta distinción"; El Caribe, TBTCaribe'
 WHERE id = '32c682c0-e758-4f94-89c7-c25a0bef9063';

-- Joseíto Mateo, 2004.
UPDATE artist_awards
   SET award_id = 'ead83dcf-9e2c-4f69-a557-dad604716a5e',
       category_id = '6d483d83-448c-4007-861d-89d53ce5f8fb',
       work = 'Máxima distinción de los Premios Casandra',
       source = 'Hoy, 23 de marzo de 2004, "Joseíto Mateo gana El Soberano de los premios Casandra"; El Caribe, TBTCaribe'
 WHERE id = '8d29f64d-a831-4dce-a05e-71d55e5bef0e';

-- ---------------------------------------------------------------------------
-- 5. Las descripciones dicen ahora a qué etapa pertenece cada galardón
-- ---------------------------------------------------------------------------
UPDATE award_categories
   SET description = 'Máxima distinción de ACROARTE durante la etapa de los Premios Casandra, 1985-2012. Al pasar los premios a llamarse Soberano en 2013, esta distinción se renombró El Gran Soberano.'
 WHERE id = '6d483d83-448c-4007-861d-89d53ce5f8fb';

UPDATE award_categories
   SET description = 'Máxima distinción de ACROARTE desde 2013, cuando los premios pasaron a llamarse Soberano. Hasta 2012 la misma distinción se llamaba El Soberano y se entregaba dentro de los Premios Casandra.'
 WHERE id = '26e1ac30-c00d-4cc8-922f-bd7fd58502ce';

COMMIT;
