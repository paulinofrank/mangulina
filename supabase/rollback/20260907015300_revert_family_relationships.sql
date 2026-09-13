BEGIN;

-- Revierte 20260907015300_add_family_relationships.sql.
-- Se borra por par, sin depender de la dirección con que se guardó.

DELETE FROM artist_family_relationships
 WHERE (pair_low, pair_high) IN (
   (LEAST('2d8316d2-1e25-4b42-a44e-873ec1711672'::uuid, '977db71a-8bf6-4006-a63d-5e604e99336c'::uuid),
    GREATEST('2d8316d2-1e25-4b42-a44e-873ec1711672'::uuid, '977db71a-8bf6-4006-a63d-5e604e99336c'::uuid)),
   (LEAST('97249298-9041-4d41-904c-2c788ac2963e'::uuid, '990631fd-edfa-4a9a-8652-7e336d64010f'::uuid),
    GREATEST('97249298-9041-4d41-904c-2c788ac2963e'::uuid, '990631fd-edfa-4a9a-8652-7e336d64010f'::uuid))
 );

COMMIT;
