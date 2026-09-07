BEGIN;

-- Quita de nino-freestyle el género que ya lleva en primary_genre.
--
-- La higiene de campos que fija docs/AI_INSTRUCTIONS.md prohíbe que una columna
-- de lista repita su escalar: genres no debe repetir primary_genre, igual que
-- occupations no debe repetir primary_role. Esta fila llevaba
-- primary_genre = 'urban-rap-hip-hop' y genres = {urban-rap-hip-hop}.
--
-- Era la única de las 728 filas con ese defecto; la comprobación de occupations
-- contra primary_role sale limpia.
--
-- PARA REVERTIR: supabase/rollback/20260907011500_restore_nino_freestyle_genre.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel y
-- no se revalidó nada.

UPDATE artists
   SET genres = '{}'::text[], updated_at = now()
 WHERE slug = 'nino-freestyle'
   AND genres = ARRAY['urban-rap-hip-hop']::text[];

COMMIT;
