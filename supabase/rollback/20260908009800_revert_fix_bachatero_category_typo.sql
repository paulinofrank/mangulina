BEGIN;

-- Revierte 20260908009800_fix_bachatero_category_typo.sql.

UPDATE award_categories
   SET name = 'Bachatero de Año'
 WHERE id = 'e016ac69-513d-4a40-b636-e148aae081c0'::uuid;

COMMIT;
