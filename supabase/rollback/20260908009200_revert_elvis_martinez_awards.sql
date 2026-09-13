BEGIN;

-- Revierte 20260908009200_elvis_martinez_awards.sql.

DELETE FROM artist_awards
 WHERE artist_id = 'e566c763-02c1-4f96-8a82-edbba9fc0bb2'::uuid
   AND category_id IN (
     '5b853910-d844-474e-9131-df7e43ea32a7'::uuid,
     '4e6a932d-4c49-4a48-95e1-cc8ecadf1d1f'::uuid,
     '824c9af3-6def-4fb6-bcc0-1e9ab35e7621'::uuid,
     'e016ac69-513d-4a40-b636-e148aae081c0'::uuid,
     'b7661f5a-b7e9-4667-a590-d56284151e93'::uuid,
     '3ba3ced3-dcbf-4436-8356-5f9f41f1546e'::uuid
   );

-- Solo borra las dos categorias nuevas si no quedo nadie usandolas.
DELETE FROM award_categories ac
 WHERE ac.id IN (
     '5b853910-d844-474e-9131-df7e43ea32a7'::uuid,
     '824c9af3-6def-4fb6-bcc0-1e9ab35e7621'::uuid
   )
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

COMMIT;
