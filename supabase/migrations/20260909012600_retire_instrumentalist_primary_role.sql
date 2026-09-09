BEGIN;

-- Retira "instrumentalist" como primary_role de todo el catálogo.
--
-- Decisión editorial: el término no es de uso popular. Quien toca un
-- instrumento es, para el lector, un músico. El propio ROLE_DICTIONARY.md ya
-- lo desaconsejaba —"DON'T: Use generic instrumentalist unless truly no other
-- information available"— pero 38 filas seguían usándolo, entre ellas Michel
-- Camilo, Johnny Pacheco, Félix del Rosario, Damirón y Mario Rivera.
--
-- El valor "musician" ya existía como primary_role, con 16 filas.
--
-- Higiene de campos: occupations no puede repetir primary_role, así que de las
-- 14 filas que traían "musician" ahí se retira. Seis quedan con occupations
-- vacío, que es un estado válido y ya presente en el catálogo: lo que decían
-- esas listas ahora lo dice primary_role, sin pérdida.
--
-- El instrumento concreto no se pierde en ningún caso: sigue en `instruments`
-- y, donde estaba, en los valores específicos de occupations (saxophonist,
-- pianist, guitarist, drummer...).

-- 1. El rol
UPDATE artists
   SET primary_role = 'musician'
 WHERE primary_role = 'instrumentalist';

-- 2. Higiene: occupations deja de repetir el nuevo primary_role
UPDATE artists
   SET occupations = occupations - 'musician'
 WHERE primary_role = 'musician'
   AND occupations @> '["musician"]'::jsonb;

-- 3. El mismo término dentro de occupations, en la única fila que lo usaba
--    (carolina-camacho, cuyo primary_role es singer y no se toca)
UPDATE artists
   SET occupations = (occupations - 'instrumentalist') || '["musician"]'::jsonb
 WHERE occupations @> '["instrumentalist"]'::jsonb;

COMMIT;
