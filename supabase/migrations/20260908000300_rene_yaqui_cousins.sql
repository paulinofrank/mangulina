BEGIN;

-- Registra el parentesco entre René del Risco Bermúdez y Yaqui Núñez del Risco.
--
-- Wikipedia, en el artículo de René: "Fue primo del publicista, locutor y
-- presentador de televisión Yaqui Núñez del Risco, a quien introdujo al mundo
-- de la publicidad."
--
-- Cuando escribí la ficha de Yaqui dejé este parentesco fuera creyendo que la
-- regla de vida privada lo prohibía. No lo prohíbe: la base tiene
-- artist_family_relationships y la ficha pública la renderiza. Es el mismo
-- caso que Guarionex Aquino padre e hijo y que Monchy Capricho con Martín de
-- León.
--
-- 'cousin' es simétrico, así que artist_id lleva el uuid menor, como hace
-- artistFamilyRelationships.ts al crear la fila desde el admin:
--   c1575281 (René)  <  faff18bd (Yaqui)
--
-- pair_low y pair_high son GENERATED ALWAYS y no se insertan.
-- relationship_status va NULL, que es lo que exige la restricción para todo
-- tipo distinto de 'spouse'.
--
-- PARA REVERTIR: supabase/rollback/20260908000300_revert_rene_yaqui_cousins.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel.

INSERT INTO artist_family_relationships (artist_id, related_artist_id, relationship_type, relationship_status)
VALUES ('c1575281-d275-4f34-a721-9f02736132d2'::uuid,
        'faff18bd-3dbc-477a-bc38-859d611887f0'::uuid,
        'cousin', NULL)
ON CONFLICT (pair_low, pair_high) DO NOTHING;

COMMIT;
