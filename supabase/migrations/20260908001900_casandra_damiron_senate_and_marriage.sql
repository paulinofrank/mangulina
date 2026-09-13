BEGIN;

-- Dos cosas sobre Casandra Damirón que salieron al reescribir su ficha: su
-- declaratoria del Senado, y su matrimonio con Luis Armando Rivera González.
--
-- No tenía NI UN premio guardado NI UN parentesco, siendo la artista por la que
-- se llama el galardón más importante del país.
--
-- UNA CATEGORÍA NUEVA
--
--   "Gloria del Arte y la Cultura Nacional" bajo Congreso Nacional de la
--   República Dominicana, que ya tenía "Merenguero del Siglo", "Artista
--   Meritísimo" y "Gloria Nacional del Canto Popular". Son cuatro declaratorias
--   distintas del mismo cuerpo y cada una tiene su nombre propio; fundirlas
--   perdería cuál recibió cada artista.
--
--   SIN AÑO. La fuente no lo da y year admite NULL, que es la convención del
--   catálogo para adjudicaciones sin fecha.
--
-- EL MATRIMONIO VA EN artist_family_relationships Y NO EN LA PROSA, que es la
-- regla para parentescos entre dos artistas del catálogo.
--
--   'ended_by_death' Y NO 'former'. Se casaron el 4 de junio de 1948 y siguieron
--   casados hasta que ella murió, en diciembre de 1983; él murió en 1986. Es el
--   caso contrario al de Sonia Silvestre y Yaqui Núñez del Risco, donde la
--   fuente dice expresamente que hubo divorcio y por eso allí va 'former'.
--
--   ORDEN DEL PAR: 'spouse' es simétrico y artist_id lleva el uuid MENOR, como
--   hace src/lib/artistFamilyRelationships.ts. a81458f1 (Casandra) < aefd5b14
--   (Rivera). pair_low y pair_high son GENERATED ALWAYS y no se insertan.
--
-- CASI NO ENCUENTRO A RIVERA. Buscarlo por nombre con ilike '%luis rivera%'
-- devuelve CERO, porque la fila se llama "Luis Armando Rivera González" y esa
-- cadena no aparece contigua. Es la misma trampa de Luis "Terror" Días.
-- Aparece con verificar-faltantes.cjs, que compara por similitud. La identidad
-- se confirmó por la fila: 1901, San Fernando de Monte Cristi, primary_role
-- composer, y la enciclopedia lo hace nativo de Montecristi y compositor.
--
-- PARA REVERTIR: supabase/rollback/20260908001900_revert_casandra_damiron_senate_and_marriage.sql
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.

INSERT INTO award_categories (id, award_id, name)
VALUES
  ('f9f6625a-ee8f-47a6-bcdb-71b007fffe9e'::uuid,
   '748be643-80ea-4c18-9558-b9a1a414f4f9'::uuid,
   'Gloria del Arte y la Cultura Nacional')
ON CONFLICT (id) DO NOTHING;

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
VALUES
  ('a81458f1-ccaa-451a-8cd5-2afd4d27affb'::uuid,
   '748be643-80ea-4c18-9558-b9a1a414f4f9'::uuid,
   'f9f6625a-ee8f-47a6-bcdb-71b007fffe9e'::uuid,
   NULL, 'Declaratoria del Senado de la República', true,
   'Wikipedia (es); la fuente no da el año');

INSERT INTO artist_family_relationships
  (artist_id, related_artist_id, relationship_type, relationship_status)
VALUES
  ('a81458f1-ccaa-451a-8cd5-2afd4d27affb'::uuid,
   'aefd5b14-694e-4f3e-ad31-ade13f14ca64'::uuid,
   'spouse', 'ended_by_death')
ON CONFLICT (pair_low, pair_high) DO NOTHING;

COMMIT;
