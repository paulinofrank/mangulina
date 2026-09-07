BEGIN;

-- Revierte 20260907011500.

UPDATE artists
   SET genres = ARRAY['urban-rap-hip-hop']::text[], updated_at = now()
 WHERE slug = 'nino-freestyle';

COMMIT;
