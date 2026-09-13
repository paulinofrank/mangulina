BEGIN;

-- Reverts 20260908005500_create_taty_salas_biography.sql.
--
-- Taty Salas did not exist in the catalogue before that migration, so undoing
-- it removes the artist row. The editorial documents and their reference rows
-- go with it through the foreign keys.

DELETE FROM artists WHERE slug = 'taty-salas';

COMMIT;
