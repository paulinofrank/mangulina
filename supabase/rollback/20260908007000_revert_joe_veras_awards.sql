BEGIN;

-- Revierte 20260908007000_joe_veras_awards.sql.
--
-- No borra ninguna categoría: las dos ya existían antes y las usan otros
-- artistas.

DELETE FROM artist_awards
 WHERE artist_id = 'aec32df5-cc5a-43c2-ac33-02bc8caa1cf5'::uuid
   AND category_id IN (
     'ba7087a5-4bf5-4a90-888c-554e335217d2'::uuid,
     '4e6a932d-4c49-4a48-95e1-cc8ecadf1d1f'::uuid
   );

COMMIT;
