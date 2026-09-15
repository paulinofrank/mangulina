BEGIN;

-- Revierte 20260915012300_fix_rikarena_founder_year.sql.
UPDATE artist_relationships SET start_year = 1990 WHERE id = '753aa4c2-ec56-484c-861f-c15a2a6b09bd';

COMMIT;
