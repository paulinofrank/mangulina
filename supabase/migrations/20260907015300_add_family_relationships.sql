BEGIN;

-- Registra dos parentescos entre artistas del catálogo que estaban
-- documentados en las fuentes pero no en la base.
--
--   Guarionex Aquino Reyes  ->  Guarionex Aquino Hijo    padre e hijo
--   Monchy Capricho        <->  Martín de León           primos
--
-- POR QUÉ ESTO NO IBA EN LA PROSA. Vengo dejando fuera los parentescos por la
-- regla de vida privada, y en general es correcto: matrimonios, hijos y oficios
-- de los padres no van en una biografía de este catálogo. Pero la regla apunta
-- al TEXTO, y la base tiene artist_family_relationships, con 'parent' y
-- 'cousin' entre sus siete tipos válidos y treinta y siete filas ya cargadas.
-- La ficha pública renderiza esas relaciones. El sitio para un parentesco entre
-- dos artistas registrados es esa tabla, no el párrafo.
--
-- LAS DOS FUENTES
--
--   Padre e hijo: lo dicen Grokipedia y la entrevista que Glenda Galán le hizo
--   al percusionista para dominicanaenmiami.com, donde él habla de su padre
--   barítono y de haber tocado con él a los nueve años. Además es la razón de
--   que la fila del hijo se llame "Hijo": el catálogo ya los estaba
--   distinguiendo sin registrar por qué.
--
--   Primos: El Tiempo, 25 de noviembre de 2024, al reseñar a Martín de León
--   dice que formó parte de la orquesta de "Monchi Capricho, su primo".
--
-- DIRECCIÓN DE LA FILA, que en esta tabla importa:
--
--   En 'parent', artist_id ES EL PADRE y related_artist_id el hijo. Se
--   comprueba en las diez filas existentes: Cuco Valoy -> Ramón Orlando,
--   Johnny Ventura -> Jandy Ventura, y los años de nacimiento lo confirman.
--   El front-end invierte la etiqueta según desde qué ficha se mire.
--
--   En 'cousin', que es simétrico, artistFamilyRelationships.ts ordena el par
--   de modo que artist_id sea el menor de los dos uuid. Se respeta ese orden
--   para que la fila entre igual que si se hubiera creado desde el admin.
--
-- NO SE INSERTAN pair_low NI pair_high: son columnas GENERATED ALWAYS, LEAST y
-- GREATEST de los dos uuid, y existen para que la restricción UNIQUE impida
-- guardar el mismo par dos veces en direcciones opuestas.
--
-- relationship_status VA EN NULL, que es lo que exige la restricción para todo
-- tipo que no sea 'spouse'.
--
-- PARA REVERTIR: supabase/rollback/20260907015300_revert_family_relationships.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO artist_family_relationships (artist_id, related_artist_id, relationship_type, relationship_status)
VALUES
  -- El barítono es el padre del percusionista.
  ('2d8316d2-1e25-4b42-a44e-873ec1711672'::uuid,
   '977db71a-8bf6-4006-a63d-5e604e99336c'::uuid,
   'parent', NULL),
  -- Primos. Monchy Capricho lleva el uuid menor, así que va primero.
  ('97249298-9041-4d41-904c-2c788ac2963e'::uuid,
   '990631fd-edfa-4a9a-8652-7e336d64010f'::uuid,
   'cousin', NULL)
ON CONFLICT (pair_low, pair_high) DO NOTHING;

COMMIT;
