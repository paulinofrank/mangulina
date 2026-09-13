BEGIN;

-- Revierte 20260908009900_casandra_soberano_epochs.sql.
--
-- Devuelve las cinco adjudicaciones y las tres descripciones exactamente a los
-- valores que tenían antes, incluido el año nulo de Félix del Rosario.

-- 5. Descripciones
UPDATE award_categories
   SET description = 'Máxima distinción no competitiva otorgada a la trayectoria de un artista.'
 WHERE id = '6d483d83-448c-4007-861d-89d53ce5f8fb';

UPDATE award_categories
   SET description = 'El más alto galardón concedido por ACROARTE en la nueva etapa institucional.'
 WHERE id = '26e1ac30-c00d-4cc8-922f-bd7fd58502ce';

-- 4. Las dos máximas distinciones vuelven a El Gran Soberano bajo Premios Soberano
UPDATE artist_awards
   SET award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd',
       category_id = '26e1ac30-c00d-4cc8-922f-bd7fd58502ce',
       work = 'Trayectoria de vida',
       source = 'ACROARTE'
 WHERE id = '32c682c0-e758-4f94-89c7-c25a0bef9063';

UPDATE artist_awards
   SET award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd',
       category_id = '26e1ac30-c00d-4cc8-922f-bd7fd58502ce',
       work = 'Máximo galardón de Acroarte',
       source = 'Wikipedia (es)'
 WHERE id = '8d29f64d-a831-4dce-a05e-71d55e5bef0e';

-- 3. Wilfrido Vargas 1985 vuelve a la Orquesta del Año de Premios Soberano
UPDATE artist_awards
   SET award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd',
       category_id = 'ce362332-515b-4e47-ac54-864ca8a71541'
 WHERE id = 'a005e0a6-d146-42f0-9f00-46e901c94e47';

-- 2. Félix del Rosario vuelve a quedarse sin año
UPDATE artist_awards
   SET year = NULL,
       work = 'La fuente no fecha la entrega',
       source = 'Wikipedia (es); EcuRed'
 WHERE id = '425b79bf-b210-497d-92a6-85dc93cc787a';

-- 1. La categoría Casandra Especial vuelve a colgar de Premios Soberano
UPDATE artist_awards
   SET award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd'
 WHERE category_id = 'b336bbd9-0dfa-4331-8567-0b3e5a874252';

UPDATE award_categories
   SET award_id = 'dec5d9e2-427b-414a-975f-41580488a7fd',
       description = 'Reconocimiento a bodas de plata de carrera'
 WHERE id = 'b336bbd9-0dfa-4331-8567-0b3e5a874252';

COMMIT;
