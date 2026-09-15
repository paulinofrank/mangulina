BEGIN;

-- Añade el Facebook de Ángel Dior (verificado, encontrado por el usuario).
UPDATE artists SET facebook = '100086242967490' WHERE slug = 'angel-dior';

COMMIT;
