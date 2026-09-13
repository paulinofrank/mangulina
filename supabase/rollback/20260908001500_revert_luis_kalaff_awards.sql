BEGIN;

-- Revierte 20260908001500_luis_kalaff_awards.sql.
--
-- NO SE TOCA la categoría "Orden del Mérito de Duarte, Sánchez y Mella", que ya
-- existía antes de esta migración y que usa también Julio Alberto Hernández.

DELETE FROM artist_awards
 WHERE artist_id = 'dab6636c-21fd-4e34-a0a2-e59e9e147bbd'::uuid
   AND category_id IN (
     'a4c19e35-7b62-4d08-9e41-3fa7c25d60b8'::uuid,
     '162603e4-8662-4b5d-a812-842f7e91074f'::uuid
   );

DELETE FROM award_categories ac
 WHERE ac.id = '162603e4-8662-4b5d-a812-842f7e91074f'::uuid
   AND NOT EXISTS (SELECT 1 FROM artist_awards x WHERE x.category_id = ac.id);

COMMIT;
