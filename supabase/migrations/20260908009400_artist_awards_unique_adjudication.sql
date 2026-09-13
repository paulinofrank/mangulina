BEGIN;

-- Anade a `artist_awards` la restriccion unica que faltaba, para que la misma
-- adjudicacion no se pueda insertar dos veces.
--
-- La pidio el editor despues de la fusion de entidades duplicadas
-- (`20260908009300`), donde aparecieron DOS FILAS REPETIDAS DE VERDAD: Juan
-- Luis Guerra tenia dos veces el premio Billboard a la trayectoria de 2005 y
-- dos veces la persona del ano del Latin Grammy de 2007. La tabla no tenia nada
-- que lo impidiera.
--
-- ===========================================================================
-- LA CLAVE INCLUYE LA OBRA, Y NO ES UN DETALLE
-- ===========================================================================
--
-- La clave evidente seria (artista, premio, categoria, ano). **No sirve**, y lo
-- comprobe antes de escribir esto: con esa clave hay DOS COLISIONES LEGITIMAS
-- en los datos actuales.
--
--   Natti Natasha, ASCAP Latin Music Awards, "Winning Songs", 2020
--     -> "Me Gusta" y "No Lo Trates". Son dos canciones premiadas la misma
--        noche en el mismo renglon. Las dos son ciertas.
--
--   Chimbala, Sales Certifications, "Platinum Records", 2022
--     -> "Loco" y "Wow BB". Dos certificaciones distintas del mismo ano.
--
-- Con `work` dentro de la clave, **cero colisiones** sobre las 339 filas.
--
-- ===========================================================================
-- NULLS NOT DISTINCT ES LO QUE HACE QUE LA RESTRICCION SIRVA
-- ===========================================================================
--
-- Por omision, PostgreSQL considera que dos NULL son distintos, asi que una
-- clave con columnas nulas no impide nada. Y en esta tabla los nulos son la
-- norma, no la excepcion:
--
--   work       NULL en 102 de 339 filas
--   year       NULL en  31
--   category   NULL en   2
--
-- Sin `NULLS NOT DISTINCT`, cualquier fila sin obra -- que son casi un tercio --
-- se podria duplicar libremente, y la restriccion seria decorativa. Requiere
-- PostgreSQL 15 o superior; el servidor corre 17.6.
--
-- ===========================================================================
-- LO QUE ESTA RESTRICCION NO EVITA, Y CONVIENE SABERLO
-- ===========================================================================
--
-- **No habria impedido las dos filas de Juan Luis Guerra que motivaron el
-- encargo.** Aquellas estaban bajo DOS CATEGORIAS DISTINTAS -- "Person of the
-- Year" y "Latin Recording Academy Person of the Year" -- que eran la misma
-- cosa con dos nombres. Ninguna restriccion de columnas caza eso; solo lo caza
-- un humano leyendo, o el cotejo contra la lista oficial del premio.
--
-- Lo que si evita es el error mecanico: volver a correr una migracion, insertar
-- dos veces la misma fila desde dos fuentes, o duplicar al registrar un premio
-- que ya estaba.
--
-- ===========================================================================
-- RIESGO PARA LA APLICACION
-- ===========================================================================
--
-- La restriccion solo rechaza INSERT y UPDATE que produzcan un duplicado
-- exacto. No cambia lecturas ni afecta a ninguna consulta existente. El unico
-- codigo que podria romperse es uno que insertara adjudicaciones sin comprobar
-- antes; los pases editoriales van por migracion y no lo hacen.
--
-- SE APLICA CON `IF NOT EXISTS` HECHO A MANO, porque ALTER TABLE ADD CONSTRAINT
-- no lo admite: asi correrla dos veces no falla.
--
-- COMPROBADO SOBRE LOS DATOS ACTUALES en una transaccion con rollback: la
-- restriccion se crea sin error y sin violaciones.
--
-- PARA REVERTIR: supabase/rollback/20260908009400_revert_artist_awards_unique_adjudication.sql
--
-- ESTA MIGRACION NO SE APLICO POR DATABASE_URL. Es un cambio de esquema y queda
-- para el proximo despliegue, como pidio el editor.

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
     WHERE conname = 'artist_awards_unique_adjudication'
       AND conrelid = 'public.artist_awards'::regclass
  ) THEN
    ALTER TABLE public.artist_awards
      ADD CONSTRAINT artist_awards_unique_adjudication
      UNIQUE NULLS NOT DISTINCT (artist_id, award_id, category_id, year, work);
  END IF;
END
$$;

COMMENT ON CONSTRAINT artist_awards_unique_adjudication ON public.artist_awards IS
  'Una adjudicacion no se registra dos veces. La obra entra en la clave porque '
  'un artista puede ganar el mismo renglon el mismo ano con dos obras distintas '
  '(Natti Natasha, ASCAP 2020). NULLS NOT DISTINCT porque casi un tercio de las '
  'filas no tiene obra y sin eso la restriccion no impediria nada.';

COMMIT;
