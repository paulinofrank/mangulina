BEGIN;

-- Revierte 20260908004100_mozart_la_para_awards.sql.

DELETE FROM artist_awards
 WHERE artist_id = 'fa9cc802-28ca-4695-b585-f75aa90a2b6c'::uuid
   AND category_id IN (
     '67cf635d-e7db-4205-ae93-245cf295ae4e'::uuid,
     '0abb18f2-9ba3-4fb6-8f9c-a7fa87e6c3a3'::uuid
   );

DELETE FROM award_categories ac
 WHERE ac.id IN (
     '67cf635d-e7db-4205-ae93-245cf295ae4e'::uuid,
     '0abb18f2-9ba3-4fb6-8f9c-a7fa87e6c3a3'::uuid
   )
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

COMMIT;
