BEGIN;

-- Revierte 20260908001700_sonia_silvestre_awards.sql.
--
-- NO SE TOCAN las cuatro categorías preexistentes que la migración reutilizó:
-- Female Artist of the Year, Videoclip del Año, El Soberano y Reserva Musical
-- Nacional. Las usan otras fichas.

DELETE FROM artist_awards
 WHERE artist_id = '2cc97ca9-126d-48c5-922f-e9d5c8b0360d'::uuid
   AND category_id IN (
     '3aa0c007-c004-41f0-9fc9-93d5d5be8d5a'::uuid,
     '6578feb5-704f-486e-b053-aa894a521506'::uuid,
     '2f16077d-d314-4bb6-8579-cd3efc6264bc'::uuid,
     '2bc60fbf-2024-4f99-88ba-a60009e7a769'::uuid,
     '44c68aef-7ce3-4d58-a287-069f2816056b'::uuid,
     'a828f9ca-5b81-4c2e-aad2-ee2b93fefcc7'::uuid,
     '6d483d83-448c-4007-861d-89d53ce5f8fb'::uuid,
     '5e90b7c4-6dc8-4f3a-b145-80a3ec2d6f7b'::uuid
   );

DELETE FROM award_categories ac
 WHERE ac.id IN (
     '3aa0c007-c004-41f0-9fc9-93d5d5be8d5a'::uuid,
     '6578feb5-704f-486e-b053-aa894a521506'::uuid,
     '2f16077d-d314-4bb6-8579-cd3efc6264bc'::uuid,
     '2bc60fbf-2024-4f99-88ba-a60009e7a769'::uuid
   )
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

DELETE FROM awards a
 WHERE a.id = '8a093a7b-6986-4701-a2ae-3ce96d08f778'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.award_id = a.id)
   AND NOT EXISTS (SELECT 1 FROM award_categories x WHERE x.award_id = a.id);

COMMIT;
