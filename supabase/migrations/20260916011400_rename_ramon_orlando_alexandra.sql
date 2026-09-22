BEGIN;

-- Renombra ramon-orlando y alexandra-queen a la forma que sus propias biografías y 13 fichas ajenas ya usaban; el nombre anterior queda como alias.

UPDATE artists SET name = 'Ramón Orlando',
      aliases = array(SELECT DISTINCT unnest(aliases || ARRAY['Ramón Orlando & Orquesta Internacional']))
    WHERE slug = 'ramon-orlando';
UPDATE artists SET name = 'Alexandra', sort_name = 'Alexandra', stage_name = 'Alexandra',
      aliases = array(SELECT DISTINCT unnest(aliases || ARRAY['Alexandra Queen']))
    WHERE slug = 'alexandra-queen';

COMMIT;
