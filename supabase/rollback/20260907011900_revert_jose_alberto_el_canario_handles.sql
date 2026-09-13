BEGIN;

-- Revierte 20260907011900. Vuelve a dejar los dos campos vacíos.

UPDATE artists
   SET youtube = NULL, facebook = NULL, updated_at = now()
 WHERE slug = 'jose-alberto-el-canario';

COMMIT;
