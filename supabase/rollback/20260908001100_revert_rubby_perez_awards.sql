BEGIN;

-- Revierte 20260908001100_rubby_perez_awards.sql.
--
-- Borra primero las cinco adjudicaciones y después la categoría nueva, y solo
-- si ninguna otra ficha llegó a usarla entre tanto.
--
-- NO SE TOCAN las categorías preexistentes que esta migración se limitó a
-- reutilizar: Gold Records, Platinum Records, Merengue del Año y Keys to the
-- City. Borrarlas rompería fichas ajenas.

DELETE FROM artist_awards
 WHERE artist_id = 'cff70c92-8632-4c66-b5a0-81622c8128b0'::uuid
   AND category_id IN (
     'ea68bb41-6dc4-4b72-885c-25d3450082d1'::uuid,
     'f9c96520-c8ff-4342-bc7b-91b50878f74f'::uuid,
     'fd798175-f2c4-4195-8967-b7ce424267c2'::uuid,
     '51b1d03e-fe3d-432a-98b0-389facbd6a2e'::uuid,
     '769a84a7-7fb7-46fb-bdd1-18de8de7362b'::uuid
   );

DELETE FROM award_categories ac
 WHERE ac.id = '51b1d03e-fe3d-432a-98b0-389facbd6a2e'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

COMMIT;
