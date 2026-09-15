BEGIN;

-- Revierte 20260915012100_add_toque_profundo_youtube.sql.
UPDATE artists SET youtube = NULL WHERE slug = 'toque-profundo';

COMMIT;
