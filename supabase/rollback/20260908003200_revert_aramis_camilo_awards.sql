BEGIN;

-- Revierte 20260908003200_aramis_camilo_awards.sql.
--
-- NO SE TOCAN las tres categorías preexistentes que reutilizó: Revelación del
-- Año, Keys to the City y Gold Records.

DELETE FROM artist_awards
 WHERE artist_id = (select id from artists where slug = 'aramis-camilo')
   AND category_id IN (
     '0a51c7d3-4e86-4b19-9f27-c8035ad6e14b'::uuid,
     '242e3b34-aaa5-411f-bb5c-60c1083724ff'::uuid,
     '769a84a7-7fb7-46fb-bdd1-18de8de7362b'::uuid,
     'ea68bb41-6dc4-4b72-885c-25d3450082d1'::uuid,
     '56bc3ef9-25e5-4a1e-b077-df85018f5d11'::uuid
   );

DELETE FROM award_categories ac
 WHERE ac.id IN (
     '242e3b34-aaa5-411f-bb5c-60c1083724ff'::uuid,
     '56bc3ef9-25e5-4a1e-b077-df85018f5d11'::uuid
   )
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

DELETE FROM awards a
 WHERE a.id = '7e93236e-96dd-4c90-9bb8-46969104f7cd'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.award_id = a.id)
   AND NOT EXISTS (SELECT 1 FROM award_categories x WHERE x.award_id = a.id);

COMMIT;
