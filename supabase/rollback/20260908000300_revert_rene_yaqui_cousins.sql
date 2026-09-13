BEGIN;

-- Revierte 20260908000300_rene_yaqui_cousins.sql, sin depender de la dirección.

DELETE FROM artist_family_relationships
 WHERE (pair_low, pair_high) = (
   LEAST('c1575281-d275-4f34-a721-9f02736132d2'::uuid,'faff18bd-3dbc-477a-bc38-859d611887f0'::uuid),
   GREATEST('c1575281-d275-4f34-a721-9f02736132d2'::uuid,'faff18bd-3dbc-477a-bc38-859d611887f0'::uuid));

COMMIT;
