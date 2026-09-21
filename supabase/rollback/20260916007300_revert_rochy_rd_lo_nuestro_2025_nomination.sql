BEGIN;

-- Revierte 20260916007300_rochy_rd_lo_nuestro_2025_nomination.sql
DELETE FROM artist_awards WHERE id = '45399677-bdbc-4ad8-9b77-411365b72490';

COMMIT;
