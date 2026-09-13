BEGIN;

-- Reverts 20260908003100_create_aramis_camilo_biography.sql.
--
-- Aramis Camilo did not exist in the catalogue before that migration, so undoing
-- it removes the artist row. The editorial documents and their reference rows
-- go with it through the foreign keys.

DELETE FROM artists WHERE slug = 'aramis-camilo';

COMMIT;
