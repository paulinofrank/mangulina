BEGIN;

-- Revierte 20260908005800_chimbala_awards.sql.
--
-- NO SE TOCAN las tres categorías preexistentes que reutilizó.

DELETE FROM artist_awards
 WHERE artist_id = 'cf438c62-e0b8-4ba9-8e4b-f328ddce0c9b'::uuid
   AND category_id IN (
     'ea2b8a92-90c7-4a79-a1fa-b8da8fa9d155'::uuid,
     '3cf41179-5375-4e4e-a229-52ce949e9e73'::uuid,
     '96cd0802-d976-4d4b-8ff2-cc17bcd6a2ae'::uuid,
     'b6815c83-548d-471e-87a3-645664e5a80f'::uuid,
     '84338039-8f45-480f-b07a-dff00529f772'::uuid,
     'f9c96520-c8ff-4342-bc7b-91b50878f74f'::uuid
   );

DELETE FROM award_categories ac
 WHERE ac.id IN (
     '3cf41179-5375-4e4e-a229-52ce949e9e73'::uuid,
     'b6815c83-548d-471e-87a3-645664e5a80f'::uuid,
     '84338039-8f45-480f-b07a-dff00529f772'::uuid
   )
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

COMMIT;
