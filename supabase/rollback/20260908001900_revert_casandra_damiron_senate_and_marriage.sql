BEGIN;

-- Revierte 20260908001900_casandra_damiron_senate_and_marriage.sql.
--
-- Se comprobó antes de aplicar que el parentesco NO existía previamente, así
-- que borrarlo aquí no destruye trabajo anterior.

DELETE FROM artist_family_relationships
 WHERE relationship_type = 'spouse'
   AND artist_id = 'a81458f1-ccaa-451a-8cd5-2afd4d27affb'::uuid
   AND related_artist_id = 'aefd5b14-694e-4f3e-ad31-ade13f14ca64'::uuid;

DELETE FROM artist_awards
 WHERE artist_id = 'a81458f1-ccaa-451a-8cd5-2afd4d27affb'::uuid
   AND category_id = 'f9f6625a-ee8f-47a6-bcdb-71b007fffe9e'::uuid;

DELETE FROM award_categories ac
 WHERE ac.id = 'f9f6625a-ee8f-47a6-bcdb-71b007fffe9e'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

COMMIT;
