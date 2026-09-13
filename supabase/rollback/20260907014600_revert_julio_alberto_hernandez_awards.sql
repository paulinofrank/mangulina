BEGIN;

-- Revierte 20260907014600_julio_alberto_hernandez_awards.sql.
-- Los dos premios que alojan las categorías (Gobierno y UASD) NO se tocan.

DELETE FROM artist_awards
 WHERE artist_id = '0e61046c-e96d-400b-819c-f9de8cbacba1'::uuid
   AND category_id IN ('a4c19e35-7b62-4d08-9e41-3fa7c25d60b8'::uuid,
                       'b5d20f46-8c73-4e19-af52-40b8d36e71c9'::uuid);

DELETE FROM award_categories
 WHERE id IN ('a4c19e35-7b62-4d08-9e41-3fa7c25d60b8'::uuid,
              'b5d20f46-8c73-4e19-af52-40b8d36e71c9'::uuid);

COMMIT;
