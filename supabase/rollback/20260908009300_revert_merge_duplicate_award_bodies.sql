BEGIN;

-- Revierte 20260908009300_merge_duplicate_award_bodies.sql.
--
-- Recrea las cinco entidades y las siete categorias con SUS IDENTIFICADORES
-- ORIGINALES, y devuelve cada adjudicacion a donde estaba. Los uuid se
-- conservan a proposito: asi cualquier referencia externa que los guardara
-- sigue resolviendo.
--
-- Las dos adjudicaciones duplicadas se reinsertan con su id original, su fuente
-- original y el resto de sus campos.

-- --- 1. Devolver el nombre de la revista ----------------------------------
UPDATE awards SET name = 'Billboard Latin Music'
 WHERE id = '701d65c9-5441-4372-93ad-a1e320437fe1'::uuid;

-- --- 2. Recrear las cinco entidades ---------------------------------------
INSERT INTO awards (id, name) VALUES
  ('93604ee1-2864-4a3f-b570-80869fe89023'::uuid, 'Grammy Awards'),
  ('ef51dad4-2ec1-4288-b088-bb7cbed902b1'::uuid, 'Premios Latin Grammy'),
  ('e22e93db-bac3-4634-a261-0303bc68001b'::uuid, 'Premios ACE'),
  ('f11eef13-ed65-4bfd-a198-7ecfcca8ea82'::uuid, 'ASCAP Latin Music'),
  ('8289b930-1899-4160-8af8-e8c1d59d2c9c'::uuid, 'Premios Billboard de la Música Latina')
ON CONFLICT (id) DO NOTHING;

-- --- 3. Recrear las siete categorias unificadas ---------------------------
INSERT INTO award_categories (id, award_id, name) VALUES
  ('5a60d1ee-553b-467b-983b-57d37602c7ee'::uuid, '71b372a9-1781-400c-933a-4cbf2daed818'::uuid, 'Best Latin Tropical Performance'),
  ('dbe52a98-d062-44f7-8876-2b8c5e92ac84'::uuid, 'ef51dad4-2ec1-4288-b088-bb7cbed902b1'::uuid, 'Mejor Álbum de Merengue'),
  ('1abd8f21-082e-4036-8c85-21157d7c9138'::uuid, 'ef51dad4-2ec1-4288-b088-bb7cbed902b1'::uuid, 'Mejor Álbum de Merengue/Bachata'),
  ('13a8654e-ea10-495c-ba3b-9b38a147725d'::uuid, '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid, 'Lifetime Achievement Award'),
  ('e5de61aa-fd7d-48a0-aec2-e46ddaa1d764'::uuid, '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid, 'Person of the Year'),
  ('2f46a4e9-22ee-44e3-a6d6-9470ece5a0f5'::uuid, '701d65c9-5441-4372-93ad-a1e320437fe1'::uuid, 'Premio a la Trayectoria Artística'),
  ('86214c8b-f336-4c28-b9be-95db2dda2827'::uuid, '8289b930-1899-4160-8af8-e8c1d59d2c9c'::uuid, 'Álbum Tropical del Año')
ON CONFLICT (id) DO NOTHING;

-- --- 4. Devolver las adjudicaciones a su categoria original ----------------
UPDATE artist_awards SET category_id = '5a60d1ee-553b-467b-983b-57d37602c7ee'::uuid
 WHERE category_id = '3e7865cd-10bb-4a24-a5b8-bfeda934daec'::uuid
   AND artist_id = (SELECT id FROM artists WHERE slug = 'milly-quezada');
UPDATE artist_awards SET category_id = 'dbe52a98-d062-44f7-8876-2b8c5e92ac84'::uuid
 WHERE category_id = 'da5e48ff-cbfa-4df1-80a7-19391ee21aae'::uuid
   AND artist_id = (SELECT id FROM artists WHERE slug = 'alex-bueno');
UPDATE artist_awards SET category_id = '1abd8f21-082e-4036-8c85-21157d7c9138'::uuid
 WHERE category_id = '9ea19c30-6990-48fd-9fe6-e42d3c8cbb78'::uuid
   AND artist_id = (SELECT id FROM artists WHERE slug = 'alex-bueno');

-- Las dos filas de Alex Bueno vuelven ademas a su entidad. Sin esto quedaban
-- apuntando a `Latin Grammy` con una categoria de `Premios Latin Grammy`, que
-- es un desajuste; lo detecto el ensayo comparando la huella antes y despues.
UPDATE artist_awards SET award_id = 'ef51dad4-2ec1-4288-b088-bb7cbed902b1'::uuid
 WHERE category_id IN ('dbe52a98-d062-44f7-8876-2b8c5e92ac84'::uuid,
                       '1abd8f21-082e-4036-8c85-21157d7c9138'::uuid);
UPDATE artist_awards SET category_id = '13a8654e-ea10-495c-ba3b-9b38a147725d'::uuid
 WHERE category_id = 'd2799d5d-a14f-4f49-a317-52199253a8f5'::uuid
   AND artist_id IN (SELECT id FROM artists WHERE slug IN ('johnny-pacheco','johnny-ventura','milly-quezada'));
UPDATE artist_awards SET category_id = '86214c8b-f336-4c28-b9be-95db2dda2827'::uuid
 WHERE category_id = '9ad70fe5-bc53-4a0a-8abb-6a94fea5e640'::uuid
   AND artist_id = (SELECT id FROM artists WHERE slug = 'luis-vargas');

-- --- 5. Devolver las categorias y adjudicaciones a su entidad original -----
UPDATE award_categories SET award_id = '93604ee1-2864-4a3f-b570-80869fe89023'::uuid
 WHERE id = '3e7865cd-10bb-4a24-a5b8-bfeda934daec'::uuid;
UPDATE artist_awards SET award_id = '93604ee1-2864-4a3f-b570-80869fe89023'::uuid
 WHERE category_id = '3e7865cd-10bb-4a24-a5b8-bfeda934daec'::uuid
   AND artist_id = (SELECT id FROM artists WHERE slug = 'wilfrido-vargas');

UPDATE award_categories SET award_id = 'e22e93db-bac3-4634-a261-0303bc68001b'::uuid
 WHERE id = 'f49184a9-b256-4d10-8f71-25982da4f4ca'::uuid;
UPDATE artist_awards SET award_id = 'e22e93db-bac3-4634-a261-0303bc68001b'::uuid
 WHERE category_id = 'f49184a9-b256-4d10-8f71-25982da4f4ca'::uuid;

UPDATE award_categories SET award_id = 'f11eef13-ed65-4bfd-a198-7ecfcca8ea82'::uuid
 WHERE id IN ('bee7b340-8ac6-46ca-b744-c750f1df6060'::uuid, 'd91419f3-5e96-4d19-84ff-06973de3159b'::uuid);
UPDATE artist_awards SET award_id = 'f11eef13-ed65-4bfd-a198-7ecfcca8ea82'::uuid
 WHERE category_id IN ('bee7b340-8ac6-46ca-b744-c750f1df6060'::uuid, 'd91419f3-5e96-4d19-84ff-06973de3159b'::uuid);

UPDATE award_categories SET award_id = '8289b930-1899-4160-8af8-e8c1d59d2c9c'::uuid
 WHERE id = '41088954-85ae-4896-baa3-fff570b811f0'::uuid;
UPDATE artist_awards SET award_id = '8289b930-1899-4160-8af8-e8c1d59d2c9c'::uuid
 WHERE category_id IN ('41088954-85ae-4896-baa3-fff570b811f0'::uuid,
                       '86214c8b-f336-4c28-b9be-95db2dda2827'::uuid);

UPDATE award_categories SET award_id = '701d65c9-5441-4372-93ad-a1e320437fe1'::uuid
 WHERE id IN ('9ad70fe5-bc53-4a0a-8abb-6a94fea5e640'::uuid,
              '0ab78cc0-30c3-47e7-b10d-1eeb01c5e36d'::uuid);
UPDATE artist_awards SET award_id = '701d65c9-5441-4372-93ad-a1e320437fe1'::uuid
 WHERE category_id IN ('9ad70fe5-bc53-4a0a-8abb-6a94fea5e640'::uuid,
                       '0ab78cc0-30c3-47e7-b10d-1eeb01c5e36d'::uuid,
                       '2f46a4e9-22ee-44e3-a6d6-9470ece5a0f5'::uuid);

-- --- 6. Reinsertar las dos adjudicaciones duplicadas ----------------------
INSERT INTO artist_awards (id, artist_id, award_id, category_id, year, work, won, source) VALUES
  ('dd7e48c9-e236-479c-92a1-e5ab73538632'::uuid,
   (SELECT id FROM artists WHERE slug = 'juan-luis-guerra'),
   '701d65c9-5441-4372-93ad-a1e320437fe1'::uuid,
   '2f46a4e9-22ee-44e3-a6d6-9470ece5a0f5'::uuid, 2005, NULL, true, 'Billboard Archive'),
  ('69a5f16a-157c-4177-9230-34a830c4d009'::uuid,
   (SELECT id FROM artists WHERE slug = 'juan-luis-guerra'),
   '1d8267d6-ad99-4ca6-8425-1315545ad86e'::uuid,
   'e5de61aa-fd7d-48a0-aec2-e46ddaa1d764'::uuid, 2007, NULL, true, 'LatinGrammy.com')
ON CONFLICT (id) DO NOTHING;

COMMIT;
