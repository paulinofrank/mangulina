BEGIN;

-- Reverts 20260907014000_create_cecilia_garcia_biography.sql.
--
-- Cecilia García did not exist in the catalogue before that migration, so undoing
-- it removes the artist row. The editorial documents and their reference rows
-- go with it through the foreign keys.

DELETE FROM artists WHERE slug = 'cecilia-garcia';

COMMIT;
