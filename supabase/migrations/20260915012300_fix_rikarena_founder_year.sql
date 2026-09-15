BEGIN;

-- Corrige el año de la relación founder_of Kinito Méndez -> Rikarena: 1990 -> 1994,
-- para que coincida con formation_year (migración 20260915012200).
UPDATE artist_relationships SET start_year = 1994 WHERE id = '753aa4c2-ec56-484c-861f-c15a2a6b09bd';

COMMIT;
