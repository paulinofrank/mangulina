BEGIN;

-- Revierte 20260908003700_lapiz_conciente_awards.sql.
--
-- NO SE TOCA "Gold Records", que ya existía y la usan otras fichas.

DELETE FROM artist_awards
 WHERE artist_id = '102e7b78-ff98-4adc-9a54-ae73791fb176'::uuid
   AND category_id IN (
     '3a6a4278-f26b-422d-8ccb-2af9b2df16a0'::uuid,
     'ea68bb41-6dc4-4b72-885c-25d3450082d1'::uuid,
     'b803cead-aae8-482e-89b5-d19472fd6a02'::uuid,
     'cf5cc764-e539-44a1-8cd1-9f9521d99fd7'::uuid,
     '2c5a2cc2-1ec0-4872-bfeb-3b2cf242bd5c'::uuid
   );

DELETE FROM award_categories ac
 WHERE ac.id IN (
     'b803cead-aae8-482e-89b5-d19472fd6a02'::uuid,
     'cf5cc764-e539-44a1-8cd1-9f9521d99fd7'::uuid,
     '3a6a4278-f26b-422d-8ccb-2af9b2df16a0'::uuid,
     '2c5a2cc2-1ec0-4872-bfeb-3b2cf242bd5c'::uuid
   )
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

DELETE FROM awards a
 WHERE a.id = '44cd5c30-2d0a-404c-973d-c6955d816ab4'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.award_id = a.id)
   AND NOT EXISTS (SELECT 1 FROM award_categories x WHERE x.award_id = a.id);

COMMIT;
