BEGIN;

-- Revierte 20260909012600_retire_instrumentalist_primary_role.sql
--
-- LIMITACIÓN: no se puede distinguir entre las 21 filas que ya eran "musician"
-- antes del barrido y las 38 que lo pasaron a ser. Este rollback devuelve el
-- término a las 38 filas por su slug, que es la única forma exacta de hacerlo.

UPDATE artists SET primary_role = 'instrumentalist'
 WHERE slug IN (
   'amaury-sanchez','carlos-manuel-vargas','carlos-piantini','chris-disla','clark',
   'damiron','draconum-oth','edilio-paredes','enmanuel-richarson','felix-del-rosario',
   'gabriel-del-orbe','hancel-osorius','hector-santana','jacinto-gimbernard',
   'jesus-juan-antonio','johandy-urena','johnny-pacheco','jorge-taveras',
   'jose-batista-fuchi','jose-luis-hernandez-moreno','josean-jacobo','juan-colon',
   'juan-francisco-ordonez','juan-polanco','junior-mayol','kilvin-pena','luis-pimentel',
   'luna-drums','manolin-gonzalez','mario-rivera','michel-camilo','morbid',
   'oscar-micheli','pierre-carbuccia','rafael-labasta','rafael-villanueva',
   'rafael-zoilo-peralta','sandy-gabriel','yasser-tejeda');

-- Y "musician" vuelve a las 14 filas de occupations de donde se retiró
UPDATE artists SET occupations = occupations || '["musician"]'::jsonb
 WHERE slug IN (
   'damiron','enmanuel-richarson','hancel-osorius','hector-santana','jacinto-gimbernard',
   'jesus-juan-antonio','johandy-urena','jose-batista-fuchi','jose-luis-hernandez-moreno',
   'juan-colon','juan-polanco','kilvin-pena','rafael-villanueva','rafael-zoilo-peralta')
   AND NOT (occupations @> '["musician"]'::jsonb);

UPDATE artists
   SET occupations = (occupations - 'musician') || '["instrumentalist"]'::jsonb
 WHERE slug = 'carolina-camacho';

COMMIT;
