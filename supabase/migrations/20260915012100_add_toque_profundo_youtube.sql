BEGIN;

-- Añade el YouTube de Toque Profundo (verificado, encontrado por el usuario).
UPDATE artists SET youtube = '@toqueprofund0' WHERE slug = 'toque-profundo';

COMMIT;
