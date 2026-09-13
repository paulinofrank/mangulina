BEGIN;

-- Revierte 20260907014100_cecilia_garcia_awards.sql.
-- La fila de 1988 usa la categoría preexistente "Espectáculo del Año" de
-- Premios Casandra, que NO se borra.

DELETE FROM artist_awards
 WHERE artist_id = '1abe0eae-4c2d-4706-a210-b176b2dfe7b2'::uuid;

DELETE FROM award_categories
 WHERE id IN ('a17b3d94-5e26-4c81-9034-7fb2ae5d1c68'::uuid,
              'b28c4ea5-6f37-4d92-a145-80c3bf6e2d79'::uuid,
              'c39d5fb6-7048-4ea3-b256-91d4c07f3e8a'::uuid,
              'd4ae60c7-8159-4fb4-c367-a2e5d1804f9b'::uuid,
              'e5bf71d8-926a-4ac5-d478-b3f6e29150ac'::uuid,
              'f6c082e9-a37b-4bd6-e589-c407f3a261bd'::uuid);

COMMIT;
