BEGIN;

-- Revierte 20260908009400_artist_awards_unique_adjudication.sql.
--
-- Quita la restriccion unica. No toca ninguna fila: la tabla vuelve a admitir
-- adjudicaciones repetidas, que es como estaba antes.

ALTER TABLE public.artist_awards
  DROP CONSTRAINT IF EXISTS artist_awards_unique_adjudication;

COMMIT;
