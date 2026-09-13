BEGIN;

-- Reverts 20260907013800_create_felix_doleo_biography.sql.
--
-- Félix D'Oleo did not exist in the catalogue before that migration, so undoing
-- it removes the artist row. The editorial documents and their reference rows
-- go with it through the foreign keys.

DELETE FROM artists WHERE slug = 'felix-doleo';

COMMIT;
