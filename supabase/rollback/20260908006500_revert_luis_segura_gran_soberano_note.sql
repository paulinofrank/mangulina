BEGIN;

-- Revierte 20260908006500_correct_luis_segura_gran_soberano_note.sql,
-- devolviendo la nota que afirmaba el año 2021.

UPDATE artist_awards
   SET work = 'Gran Soberano correspondiente a 2021, entregado en la 38.a entrega, marzo de 2023'
 WHERE artist_id = '5ceceef0-765d-4e01-8017-85422a263357'::uuid
   AND category_id = '26e1ac30-c00d-4cc8-922f-bd7fd58502ce'::uuid;

COMMIT;
