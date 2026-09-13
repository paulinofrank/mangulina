BEGIN;

-- Fusiona las entidades de premio duplicadas de `awards`, unifica las
-- categorias que eran la misma escrita de dos maneras, y borra dos
-- adjudicaciones que estaban registradas dos veces.
--
-- Lo pidio el editor. Las duplicidades se venian anotando ficha a ficha desde
-- que aparecieron los cuatro cuerpos Billboard al escribir El Chaval de la
-- Bachata, y ya eran cinco grupos.
--
-- ===========================================================================
-- 1. CINCO ENTIDADES QUE ERAN LA MISMA
-- ===========================================================================
--
--   Grammy Awards                          -> Grammy
--   Premios Latin Grammy                   -> Latin Grammy
--   Premios Billboard de la Musica Latina  -> Billboard Latin Music Awards
--   Premios ACE                            -> Premio ACE
--   ASCAP Latin Music                      -> ASCAP Latin Music Awards
--
-- El canonico se escoge por numero de filas, salvo en ASCAP, donde se escoge
-- el NOMBRE OFICIAL de la premiacion aunque la otra entidad tuviera menos
-- filas: los ASCAP Latin Heritage Award y Silver Pen Award se entregan en los
-- ASCAP Latin Music Awards.
--
-- `Billboard Latin Women in Music` NO SE TOCA: es una premiacion distinta,
-- creada en 2023, no una variante de nombre.
--
-- ===========================================================================
-- 2. BILLBOARD NECESITA UNA DECISION APARTE, Y LA EXPLICO
-- ===========================================================================
--
-- La entidad `Billboard Latin Music` mezclaba dos cosas distintas:
--
--   TRES CATEGORIAS DE LA PREMIACION -- Tropical Album of the Year, y las dos
--   del premio a la trayectoria -- que se van a `Billboard Latin Music Awards`.
--
--   UNA LISTA EDITORIAL DE LA REVISTA -- "50 Greatest Latin Artists of All
--   Time" -- que no es un premio de gala sino un ranking publicado.
--
-- Se separan. La entidad se queda con la lista y SE RENOMBRA A `Billboard`,
-- que es lo que de verdad es: la revista.
--
-- Esto sigue el patron que abri hoy mismo con `Rolling Stone`, creada para el
-- puesto 244 de Edilio Paredes en los 250 mejores guitarristas. Una revista que
-- publica rankings y una premiacion anual son dos emisores distintos, y
-- tenerlos con nombres casi iguales es lo que produjo el enredo.
--
-- ===========================================================================
-- 3. SIETE CATEGORIAS QUE ERAN LA MISMA ESCRITA DE DOS MANERAS
-- ===========================================================================
--
--   Grammy
--     Best Latin Tropical Performance  -> Best Tropical Latin Performance
--     (el nombre oficial de la categoria es el segundo; el primero tenia las
--      palabras cambiadas de sitio)
--
--   Latin Grammy
--     Mejor Album de Merengue          -> Best Merengue Album
--     Mejor Album de Merengue/Bachata  -> Best Merengue/Bachata Album
--     Lifetime Achievement Award       -> Premio a la Excelencia Musical
--     Person of the Year               -> Latin Recording Academy Person of the Year
--
--   Billboard Latin Music Awards
--     Premio a la Trayectoria Artistica -> Premio Billboard a la Trayectoria Artistica
--     Album Tropical del Ano            -> Tropical Album of the Year
--
-- EL CASO DE "Lifetime Achievement Award" MERECE NOTA. Bajo Latin Grammy tenia
-- tres filas (Pacheco 2005, Ventura 2006, Milly Quezada 2021) y "Premio a la
-- Excelencia Musical" cuatro (Joseito Mateo 2010, Rafael Solano 2016, Cuco
-- Valoy 2017, Wilfrido Vargas 2018). **Son el mismo galardon**: la Academia
-- Latina de la Grabacion lo llama Premio a la Excelencia Musical en espanol y
-- Lifetime Achievement Award en ingles. Siete artistas del catalogo lo tienen y
-- estaban repartidos en dos filas de categoria segun en que idioma se leyo la
-- fuente.
--
-- Se conserva el nombre en espanol, que es el que usa la propia Academia en sus
-- comunicaciones en espanol y el que tenia mas filas.
--
-- OJO: `Lifetime Achievement Award` TAMBIEN existe bajo `International Latin
-- Music Hall of Fame`. Esa NO se toca: es otro cuerpo y otro premio.
--
-- ===========================================================================
-- 4. DOS ADJUDICACIONES QUE ESTABAN DOS VECES
-- ===========================================================================
--
-- No son variantes de nombre: son **el mismo premio, al mismo artista, el mismo
-- ano, insertado dos veces** con dos nombres de categoria y dos fuentes.
--
--   Juan Luis Guerra, Billboard, 2005, premio a la trayectoria artistica
--     fila dd7e48c9 (fuente "Billboard Archive")            <- SE BORRA
--     fila 63c1ebec (fuente "Billboard Music Awards Database")
--
--   Juan Luis Guerra, Latin Grammy, 2007, persona del ano
--     fila 69a5f16a (fuente "LatinGrammy.com")              <- SE BORRA
--     fila 8ca1a579 (fuente "Latin Recording Academy")
--
-- En los dos casos se conserva la fila cuya categoria sobrevive a la fusion, lo
-- que ademas evita un UPDATE. **La tabla no tiene ninguna restriccion unica
-- sobre (artista, premio, categoria, ano)**, que es por lo que nadie impidio
-- estas dos filas. No la anado aqui: es un cambio de esquema y merece su propia
-- decision.
--
-- ===========================================================================
-- RESULTADO ESPERADO
-- ===========================================================================
--
--   awards            59 -> 54
--   award_categories  ?  -> menos 7
--   artist_awards    341 -> 339
--
-- Ningun artista pierde un premio real: los dos que se van estaban duplicados.
--
-- PARA REVERTIR: supabase/rollback/20260908009300_revert_merge_duplicate_award_bodies.sql
--
-- Aplicado directamente por DATABASE_URL. No corrio ninguna funcion de Vercel
-- y no se revalido nada.

-- --- 1. Las dos filas duplicadas, antes de mover nada ----------------------
DELETE FROM artist_awards WHERE id = 'dd7e48c9-e236-479c-92a1-e5ab73538632'::uuid;
DELETE FROM artist_awards WHERE id = '69a5f16a-157c-4177-9230-34a830c4d009'::uuid;

-- --- 2. Mover categorias a la entidad canonica -----------------------------
-- Grammy Awards -> Grammy
UPDATE award_categories SET award_id = '71b372a9-1781-400c-933a-4cbf2daed818'::uuid
 WHERE award_id = '93604ee1-2864-4a3f-b570-80869fe89023'::uuid;
UPDATE artist_awards SET award_id = '71b372a9-1781-400c-933a-4cbf2daed818'::uuid
 WHERE award_id = '93604ee1-2864-4a3f-b570-80869fe89023'::uuid;

-- Premios Latin Grammy -> Latin Grammy
UPDATE award_categories SET award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid
 WHERE award_id = 'ef51dad4-2ec1-4288-b088-bb7cbed902b1'::uuid;
UPDATE artist_awards SET award_id = '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid
 WHERE award_id = 'ef51dad4-2ec1-4288-b088-bb7cbed902b1'::uuid;

-- Premios ACE -> Premio ACE
UPDATE award_categories SET award_id = '373d49e3-4311-4f21-9aa4-c0f40bab9fa6'::uuid
 WHERE award_id = 'e22e93db-bac3-4634-a261-0303bc68001b'::uuid;
UPDATE artist_awards SET award_id = '373d49e3-4311-4f21-9aa4-c0f40bab9fa6'::uuid
 WHERE award_id = 'e22e93db-bac3-4634-a261-0303bc68001b'::uuid;

-- ASCAP Latin Music -> ASCAP Latin Music Awards
UPDATE award_categories SET award_id = '998b0e1f-0943-423e-b45a-c8d53fb7a6fd'::uuid
 WHERE award_id = 'f11eef13-ed65-4bfd-a198-7ecfcca8ea82'::uuid;
UPDATE artist_awards SET award_id = '998b0e1f-0943-423e-b45a-c8d53fb7a6fd'::uuid
 WHERE award_id = 'f11eef13-ed65-4bfd-a198-7ecfcca8ea82'::uuid;

-- Premios Billboard de la Musica Latina -> Billboard Latin Music Awards
UPDATE award_categories SET award_id = 'f65d6113-2c65-45fd-a5bc-2035220eb5d4'::uuid
 WHERE award_id = '8289b930-1899-4160-8af8-e8c1d59d2c9c'::uuid;
UPDATE artist_awards SET award_id = 'f65d6113-2c65-45fd-a5bc-2035220eb5d4'::uuid
 WHERE award_id = '8289b930-1899-4160-8af8-e8c1d59d2c9c'::uuid;

-- Las tres categorias de premiacion que estaban en `Billboard Latin Music`
UPDATE award_categories SET award_id = 'f65d6113-2c65-45fd-a5bc-2035220eb5d4'::uuid
 WHERE id IN ('9ad70fe5-bc53-4a0a-8abb-6a94fea5e640'::uuid,
              '2f46a4e9-22ee-44e3-a6d6-9470ece5a0f5'::uuid,
              '0ab78cc0-30c3-47e7-b10d-1eeb01c5e36d'::uuid);
UPDATE artist_awards SET award_id = 'f65d6113-2c65-45fd-a5bc-2035220eb5d4'::uuid
 WHERE category_id IN ('9ad70fe5-bc53-4a0a-8abb-6a94fea5e640'::uuid,
                       '2f46a4e9-22ee-44e3-a6d6-9470ece5a0f5'::uuid,
                       '0ab78cc0-30c3-47e7-b10d-1eeb01c5e36d'::uuid);

-- --- 3. Unificar las categorias equivalentes -------------------------------
UPDATE artist_awards SET category_id = '3e7865cd-10bb-4a24-a5b8-bfeda934daec'::uuid
 WHERE category_id = '5a60d1ee-553b-467b-983b-57d37602c7ee'::uuid;
UPDATE artist_awards SET category_id = 'da5e48ff-cbfa-4df1-80a7-19391ee21aae'::uuid
 WHERE category_id = 'dbe52a98-d062-44f7-8876-2b8c5e92ac84'::uuid;
UPDATE artist_awards SET category_id = '9ea19c30-6990-48fd-9fe6-e42d3c8cbb78'::uuid
 WHERE category_id = '1abd8f21-082e-4036-8c85-21157d7c9138'::uuid;
UPDATE artist_awards SET category_id = 'd2799d5d-a14f-4f49-a317-52199253a8f5'::uuid
 WHERE category_id = '13a8654e-ea10-495c-ba3b-9b38a147725d'::uuid;
UPDATE artist_awards SET category_id = '02141d03-88bb-4c2a-ae80-1fa20742c203'::uuid
 WHERE category_id = 'e5de61aa-fd7d-48a0-aec2-e46ddaa1d764'::uuid;
UPDATE artist_awards SET category_id = '0ab78cc0-30c3-47e7-b10d-1eeb01c5e36d'::uuid
 WHERE category_id = '2f46a4e9-22ee-44e3-a6d6-9470ece5a0f5'::uuid;
UPDATE artist_awards SET category_id = '9ad70fe5-bc53-4a0a-8abb-6a94fea5e640'::uuid
 WHERE category_id = '86214c8b-f336-4c28-b9be-95db2dda2827'::uuid;

DELETE FROM award_categories WHERE id IN (
  '5a60d1ee-553b-467b-983b-57d37602c7ee'::uuid,
  'dbe52a98-d062-44f7-8876-2b8c5e92ac84'::uuid,
  '1abd8f21-082e-4036-8c85-21157d7c9138'::uuid,
  '13a8654e-ea10-495c-ba3b-9b38a147725d'::uuid,
  'e5de61aa-fd7d-48a0-aec2-e46ddaa1d764'::uuid,
  '2f46a4e9-22ee-44e3-a6d6-9470ece5a0f5'::uuid,
  '86214c8b-f336-4c28-b9be-95db2dda2827'::uuid);

-- --- 4. Borrar las entidades vaciadas --------------------------------------
DELETE FROM awards WHERE id IN (
  '93604ee1-2864-4a3f-b570-80869fe89023'::uuid,
  'ef51dad4-2ec1-4288-b088-bb7cbed902b1'::uuid,
  'e22e93db-bac3-4634-a261-0303bc68001b'::uuid,
  'f11eef13-ed65-4bfd-a198-7ecfcca8ea82'::uuid,
  '8289b930-1899-4160-8af8-e8c1d59d2c9c'::uuid);

-- --- 5. La revista, con su nombre --------------------------------------------
UPDATE awards SET name = 'Billboard'
 WHERE id = '701d65c9-5441-4372-93ad-a1e320437fe1'::uuid;

COMMIT;
