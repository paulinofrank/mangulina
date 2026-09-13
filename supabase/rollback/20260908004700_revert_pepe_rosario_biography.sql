BEGIN;

-- Reverts 20260908004700_create_pepe_rosario_biography.sql.
--
-- Pepe Rosario did not exist in the catalogue before that migration, so undoing
-- it removes the artist row. The editorial documents and their reference rows
-- go with it through the foreign keys.

DELETE FROM artists WHERE slug = 'pepe-rosario';

COMMIT;
