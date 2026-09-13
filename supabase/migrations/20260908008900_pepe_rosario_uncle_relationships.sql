BEGIN;

-- Registra a Pepe Rosario como tio de Checho Rosario y de Rafely Rosario.
--
-- Lo senalo el editor, y tenia razon: los dos sobrinos ya estaban conectados
-- con sus otros dos tios y no con el tercero.
--
-- LO QUE YA ESTABA EN LA TABLA, y de lo que esto se deduce:
--
--   pepe-rosario  sibling     rafa-rosario
--   pepe-rosario  sibling     tono-rosario
--   tono-rosario  parent      checho-rosario
--   rafa-rosario  parent      rafely-rosario
--   rafa-rosario  uncle_aunt  checho-rosario
--   tono-rosario  uncle_aunt  rafely-rosario
--
-- Es decir: Rafa figuraba como tio del hijo de Tono, y Tono como tio del hijo
-- de Rafa, pero Pepe -- hermano de los dos padres -- no figuraba como tio de
-- ninguno de los dos sobrinos. No es una deduccion mia sobre la familia: sale
-- entera de filas ya guardadas.
--
-- BARRIDO ANTES DE ESCRIBIR. Derive todas las relaciones tio/sobrino que se
-- deducen de la tabla (hermano de un padre) y las compare con las guardadas:
-- **siete implicadas, cinco registradas, dos ausentes**, que son justo estas.
-- Ninguna otra familia del catalogo tiene el hueco, y no hay ninguna fila
-- `uncle_aunt` guardada sin su eslabon detras. La herramienta queda en
-- scratchpad/tios-implicados.cjs y no escribe nada.
--
-- ---------------------------------------------------------------------------
-- DIRECCION DE LA FILA
--
-- `uncle_aunt` es DIRECCIONAL en este esquema: `artist_id` es el tio y
-- `related_artist_id` el sobrino. Lo comprobe sobre las cinco filas existentes,
-- donde el orden de los uuid sale indistinto (tres con el tio mayor, dos con el
-- tio menor), asi que NO es un tipo simetrico y NO aplica el LEAST()/GREATEST()
-- que si usan `sibling` y `cousin`.
--
-- `pair_low` y `pair_high` son GENERATED ALWAYS y no se insertan.
-- ---------------------------------------------------------------------------
--
-- SOBRE LAS FECHAS, porque alguien lo va a preguntar: Pepe Rosario murio en
-- marzo de 1983 y Rafely nacio en 1986, asi que nunca se conocieron. **Da
-- igual.** Esta tabla registra parentesco, no trato: es su tio lo mismo que
-- Tono es tio de Rafely.
--
-- PARA REVERTIR: supabase/rollback/20260908008900_revert_pepe_rosario_uncle_relationships.sql
--
-- Aplicado directamente por DATABASE_URL. No corrio ninguna funcion de Vercel
-- y no se revalido nada.

INSERT INTO artist_family_relationships (artist_id, related_artist_id, relationship_type)
VALUES
  ('03586dc0-5bbe-4b91-859d-f9c0dd580ea4'::uuid,
   '1f33255b-4a75-42d5-8e83-0ab43e5643cf'::uuid, 'uncle_aunt'),
  ('03586dc0-5bbe-4b91-859d-f9c0dd580ea4'::uuid,
   'fb770e9d-a17f-4718-884f-e1bd44a11b61'::uuid, 'uncle_aunt')
ON CONFLICT DO NOTHING;

COMMIT;
