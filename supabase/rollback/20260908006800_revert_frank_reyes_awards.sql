BEGIN;

-- Revierte 20260908006800_frank_reyes_awards.sql.
--
-- No borra ninguna categoría: las cuatro ya existían antes y las usan otros
-- artistas.

DELETE FROM artist_awards
 WHERE artist_id = '3dd83e6b-2058-4d04-ac68-38e11d9348a9'::uuid
   AND category_id IN (
     'ba7087a5-4bf5-4a90-888c-554e335217d2'::uuid,
     'e016ac69-513d-4a40-b636-e148aae081c0'::uuid,
     '4e6a932d-4c49-4a48-95e1-cc8ecadf1d1f'::uuid,
     '3ba3ced3-dcbf-4436-8356-5f9f41f1546e'::uuid
   );

COMMIT;
