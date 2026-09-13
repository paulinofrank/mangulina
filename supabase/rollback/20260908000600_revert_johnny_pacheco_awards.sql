BEGIN;

-- Revierte 20260908000600_johnny_pacheco_awards.sql.
--
-- Se borra en orden inverso a la creación: primero las adjudicaciones, después
-- las categorías nuevas, y por último el premio nuevo. Las categorías y el
-- premio solo se borran si ninguna otra ficha llegó a usarlos entre tanto, que
-- es lo que comprueba cada NOT EXISTS.
--
-- NO SE TOCAN las dos categorías que ya existían y que esta migración se limitó
-- a reutilizar: "Inductee" del International Latin Music Hall of Fame, "El
-- Soberano" de Premios Casandra, "Lifetime Achievement Award" de Latin Grammy,
-- "Proclamación Ciudadana y Cultural" y "Gold Records". Borrarlas rompería
-- fichas ajenas.

DELETE FROM artist_awards
 WHERE artist_id = 'e005898c-4fcc-45da-b857-c6775e92fa52'::uuid
   AND category_id IN (
     '2b139724-a4fd-4704-b78f-f0340ce85f7f'::uuid,
     'c584e1eb-3fe1-448e-b470-dc2f7d284e9a'::uuid,
     '42513103-2a87-486d-a9e0-618186a88e52'::uuid,
     '1c541e5e-5ff7-404e-b1a9-8a6c9677ae9a'::uuid,
     'd91419f3-5e96-4d19-84ff-06973de3159b'::uuid,
     '128d01e8-7cf3-4e90-b96d-244841289f6e'::uuid,
     'cd8e83f4-2e6c-484e-86d8-e10d06ecf7bd'::uuid,
     '698144d2-5b22-47b2-a86b-88a5ec328aae'::uuid,
     'eca0195f-bbb2-479a-9254-088e57a28f82'::uuid,
     '13a8654e-ea10-495c-ba3b-9b38a147725d'::uuid,
     '6d483d83-448c-4007-861d-89d53ce5f8fb'::uuid,
     'ea68bb41-6dc4-4b72-885c-25d3450082d1'::uuid
   );

DELETE FROM award_categories ac
 WHERE ac.id IN (
     '2b139724-a4fd-4704-b78f-f0340ce85f7f'::uuid,
     'c584e1eb-3fe1-448e-b470-dc2f7d284e9a'::uuid,
     '42513103-2a87-486d-a9e0-618186a88e52'::uuid,
     '1c541e5e-5ff7-404e-b1a9-8a6c9677ae9a'::uuid,
     'd91419f3-5e96-4d19-84ff-06973de3159b'::uuid,
     '128d01e8-7cf3-4e90-b96d-244841289f6e'::uuid,
     'cd8e83f4-2e6c-484e-86d8-e10d06ecf7bd'::uuid
   )
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

DELETE FROM awards a
 WHERE a.id = 'c0d0fdb4-7179-4a39-84fc-df5fd4af2764'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.award_id = a.id)
   AND NOT EXISTS (SELECT 1 FROM award_categories x WHERE x.award_id = a.id);

COMMIT;
