BEGIN;

-- Revierte 20260908007200_el_chaval_awards_and_group_alias.sql.

DELETE FROM artist_awards
 WHERE artist_id = '8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6'::uuid
   AND category_id IN (
     '4e6a932d-4c49-4a48-95e1-cc8ecadf1d1f'::uuid,
     'ba7087a5-4bf5-4a90-888c-554e335217d2'::uuid,
     '7e32c2ae-1b52-4624-b03e-0d4934cc6fee'::uuid,
     '41088954-85ae-4896-baa3-fff570b811f0'::uuid,
     '3ba3ced3-dcbf-4436-8356-5f9f41f1546e'::uuid,
     'e016ac69-513d-4a40-b636-e148aae081c0'::uuid
   );

-- Solo borra la categoría nueva si no quedó nadie usándola.
DELETE FROM award_categories ac
 WHERE ac.id = '41088954-85ae-4896-baa3-fff570b811f0'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

UPDATE artists
   SET aliases = '{}'
 WHERE slug = 'los-jovenes-del-amargue'
   AND aliases = ARRAY['Los Infantiles del Amargue'];

COMMIT;
