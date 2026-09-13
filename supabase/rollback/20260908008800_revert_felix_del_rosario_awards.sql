BEGIN;

-- Revierte 20260908008800_felix_del_rosario_awards.sql.
--
-- No borra ninguna categoria: las tres ya existian antes y las usan otros
-- artistas.

DELETE FROM artist_awards
 WHERE artist_id = '8fc78100-e51e-48a8-91e9-3007f4c67ec0'::uuid
   AND category_id IN (
     '7e334a61-76b4-4f04-aca1-ad5416f8749f'::uuid,
     'b336bbd9-0dfa-4331-8567-0b3e5a874252'::uuid,
     'a4c19e35-7b62-4d08-9e41-3fa7c25d60b8'::uuid
   );

COMMIT;
