BEGIN;

-- Revierte 20260908008900_pepe_rosario_uncle_relationships.sql.
--
-- Borra solo las dos filas que esa migracion inserto. Las de Rafa y Tono como
-- tios, que ya existian antes, no se tocan.

DELETE FROM artist_family_relationships
 WHERE relationship_type = 'uncle_aunt'
   AND artist_id = '03586dc0-5bbe-4b91-859d-f9c0dd580ea4'::uuid
   AND related_artist_id IN (
     '1f33255b-4a75-42d5-8e83-0ab43e5643cf'::uuid,
     'fb770e9d-a17f-4718-884f-e1bd44a11b61'::uuid
   );

COMMIT;
