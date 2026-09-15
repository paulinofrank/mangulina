BEGIN;

-- Revierte 20260915011900_add_angel_dior_facebook.sql.
UPDATE artists SET facebook = NULL WHERE slug = 'angel-dior';

COMMIT;
