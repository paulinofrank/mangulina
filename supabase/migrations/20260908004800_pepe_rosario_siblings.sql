BEGIN;

-- Registra a Pepe Rosario como hermano de Toño y de Rafa Rosario.
--
-- Salió al crear su ficha (migración 20260908004700), a petición del editor.
-- Los tres cantaban en Los Hermanos Rosario y los tres están publicados, así
-- que es parentesco entre artistas del catálogo y su sitio es esta tabla.
--
-- EL PAR RAFA-TOÑO YA ESTABA REGISTRADO y no se toca. Faltaban los dos que
-- involucran a Pepe, que hasta hoy no existía como fila.
--
-- ORDEN DEL PAR RESUELTO EN SQL Y NO A OJO. 'sibling' es simétrico y la
-- convención del catálogo -- la misma que aplica src/lib/artistFamilyRelationships.ts
-- al crear filas desde el admin -- es que artist_id lleve el uuid MENOR. En vez
-- de comparar los uuid a mano y arriesgarme a invertirlos, se calcula con LEAST
-- y GREATEST, que además es lo mismo que hacen las columnas generadas pair_low
-- y pair_high.
--
-- pair_low y pair_high son GENERATED ALWAYS y NO SE INSERTAN.
--
-- relationship_status va NULL porque la CHECK del esquema solo admite valor
-- para 'spouse'.
--
-- PARA REVERTIR: supabase/rollback/20260908004800_revert_pepe_rosario_siblings.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO artist_family_relationships
  (artist_id, related_artist_id, relationship_type, relationship_status)
SELECT LEAST(p.id, o.id), GREATEST(p.id, o.id), 'sibling', NULL
  FROM artists p
  JOIN artists o ON o.slug IN ('tono-rosario', 'rafa-rosario')
 WHERE p.slug = 'pepe-rosario'
ON CONFLICT (pair_low, pair_high) DO NOTHING;

COMMIT;
