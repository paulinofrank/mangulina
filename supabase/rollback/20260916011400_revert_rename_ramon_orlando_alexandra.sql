BEGIN;

-- Revierte 20260916011400: restaura name/aliases/sort_name/stage_name previos.

UPDATE artists SET name = 'Alexandra Queen', aliases = ARRAY['La Reina de la Bachata','Alexandra']::text[], sort_name = 'Alexandra Queen', stage_name = 'Alexandra Queen' WHERE slug = 'alexandra-queen';
UPDATE artists SET name = 'Ramón Orlando & Orquesta Internacional', aliases = ARRAY['Ramon Orlando']::text[], sort_name = NULL, stage_name = NULL WHERE slug = 'ramon-orlando';

COMMIT;
