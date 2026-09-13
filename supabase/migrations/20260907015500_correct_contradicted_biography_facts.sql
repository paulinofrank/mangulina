BEGIN;

-- Corrige las once fichas donde la PROSA PUBLICADA contradice los campos de la
-- propia fila. Son del lote de mayo de 2026.
-- 
-- SE VERIFICÓ CADA UNA CONTRA FUENTES EXTERNAS antes de tocar nada, porque el
-- campo podía ser el equivocado. NO LO FUE EN NINGÚN CASO COMPROBABLE: diez de
-- diez le dan la razón al campo. La prosa es el lado que falla.
-- 
--   raulin-rosendo        1957  EcuRed, BuenaMusica, La Nación Dominicana
--                               (cumpleaños 69 en agosto de 2026)
--   juan-francisco-ordonez 1961 Wikipedia (es), con Wikidata
--   jandy-feliz           1977  EcuRed, BuenaMusica, El Día Que Nací
--   kinito-mendez         1963  BuscaBiografías, Grokipedia, agenda56,
--                               Merengazo del Atlántico
--   dioris-valladares     1916  Ansonia Records, archivo de veteranos
--                               dominicanos de CUNY, Grokipedia
--   dary-hezz             2003  su propio canal de YouTube y Genius
--   el-cata           Barahona  BuenaMusica y Conectate
--   23thierno    San Cristóbal  BuenaMusica y su propio canal
--   tokischa       Los Frailes  LatinTRENDS y sunoti (Santo Domingo Este)
-- 
-- DOS CASOS QUE NO SE ARREGLAN CON UN AÑO
-- 
--   LA MATERIALISTA. La prosa dice "born Dianabel Rodríguez in 1987". Los dos
--   datos están mal o en disputa:
--     - EL NOMBRE ES OTRO. La fila guarda Yameyry Ynfante y las fuentes la
--       llaman Yameiry Infante o Ynfante. "Dianabel Rodríguez" no aparece en
--       ninguna parte. Es un nombre inventado en una ficha publicada.
--     - EL AÑO ESTÁ EN DISPUTA A TRES BANDAS: la fila dice 1985, MSN dice 1987
--       y djlagrena dice 1986. Las tres coinciden en el 19 de marzo.
--   Se corrige el nombre y SE QUITA EL AÑO de la prosa. La fila conserva 1985 y
--   queda como única afirmación, hasta que aparezca fuente que zanje.
-- 
--   JOSÉ EL CALVO. La prosa dice San José de las Matas, provincia Santiago; la
--   fila dice Imbert, Puerto Plata. NO ENCONTRÉ NINGUNA FUENTE sobre él. Sin
--   forma de saber cuál es correcto, se alinea la prosa con la fila, que es el
--   registro del catálogo, y queda anotado que NINGUNO de los dos está
--   verificado externamente.
-- 
-- LO QUE ESTO NO ARREGLA. Estas once siguen siendo fichas del lote de mayo:
-- cuatro párrafos, sin secciones, sin títulos de canciones. Esta migración
-- quita la contradicción, que es lo urgente porque es lo que se puede
-- desmentir citando nuestra propia página. La reescritura completa va por el
-- orden de relevancia.
--
-- El documento y el espejo markdown se mueven juntos: la página pública sirve
-- el documento, pero una ficha en borrador cae al espejo, y dejar los dos
-- diciendo cosas distintas es un fallo invisible hasta que alguien lo lee.
--
-- Solo cambia texto. Ningún nodo artistReference se toca, así que los enlaces
-- y sus occurrence_id quedan como estaban y editorial_entity_references no se
-- reconstruye.
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.
--
-- PARA REVERTIR: supabase/rollback/20260907015500_revert_correct_contradicted_biography_facts.sql

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Born in 1928 in San Pedro de Macorís', 'Born in 1957 in San Pedro de Macorís')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'raulin-rosendo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Born in 1928 in San Pedro de Macorís' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Born in 1928 in San Pedro de Macorís', 'Born in 1957 in San Pedro de Macorís'),
       updated_at = now()
 WHERE slug = 'raulin-rosendo'
   AND position('Born in 1928 in San Pedro de Macorís' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Born in 1953 in Santo Domingo', 'Born in 1961 in Santo Domingo')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'juan-francisco-ordonez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Born in 1953 in Santo Domingo' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Born in 1953 in Santo Domingo', 'Born in 1961 in Santo Domingo'),
       updated_at = now()
 WHERE slug = 'juan-francisco-ordonez'
   AND position('Born in 1953 in Santo Domingo' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'born in 1971 in Barahona', 'born in 1977 in Barahona')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'jandy-feliz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('born in 1971 in Barahona' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'born in 1971 in Barahona', 'born in 1977 in Barahona'),
       updated_at = now()
 WHERE slug = 'jandy-feliz'
   AND position('born in 1971 in Barahona' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'born in 1961 in Padre Las Casas', 'born in 1963 in Padre Las Casas')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'kinito-mendez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('born in 1961 in Padre Las Casas' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'born in 1961 in Padre Las Casas', 'born in 1963 in Padre Las Casas'),
       updated_at = now()
 WHERE slug = 'kinito-mendez'
   AND position('born in 1961 in Padre Las Casas' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'born in 1912 in San Pedro de Macorís', 'born in 1916 in San Pedro de Macorís')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dioris-valladares'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('born in 1912 in San Pedro de Macorís' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'born in 1912 in San Pedro de Macorís', 'born in 1916 in San Pedro de Macorís'),
       updated_at = now()
 WHERE slug = 'dioris-valladares'
   AND position('born in 1912 in San Pedro de Macorís' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'born in 2000 in Santo Domingo', 'born in 2003 in Santo Domingo')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dary-hezz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('born in 2000 in Santo Domingo' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'born in 2000 in Santo Domingo', 'born in 2003 in Santo Domingo'),
       updated_at = now()
 WHERE slug = 'dary-hezz'
   AND position('born in 2000 in Santo Domingo' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'La Materialista, born Dianabel Rodríguez in 1987 in Santiago de los Caballeros,', 'La Materialista, born Yameyry Ynfante in Santiago de los Caballeros,')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'la-materialista'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('La Materialista, born Dianabel Rodríguez in 1987 in Santiago de los Caballeros,' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'La Materialista, born Dianabel Rodríguez in 1987 in Santiago de los Caballeros,', 'La Materialista, born Yameyry Ynfante in Santiago de los Caballeros,'),
       updated_at = now()
 WHERE slug = 'la-materialista'
   AND position('La Materialista, born Dianabel Rodríguez in 1987 in Santiago de los Caballeros,' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'El Cata, born in 1972 in Santo Domingo,', 'El Cata, born in 1972 in Barahona,')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'el-cata'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('El Cata, born in 1972 in Santo Domingo,' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'El Cata, born in 1972 in Santo Domingo,', 'El Cata, born in 1972 in Barahona,'),
       updated_at = now()
 WHERE slug = 'el-cata'
   AND position('El Cata, born in 1972 in Santo Domingo,' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'born in 2001 in Santo Domingo who participates', 'born in 2001 in San Cristóbal who participates')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = '23thierno'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('born in 2001 in Santo Domingo who participates' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'born in 2001 in Santo Domingo who participates', 'born in 2001 in San Cristóbal who participates'),
       updated_at = now()
 WHERE slug = '23thierno'
   AND position('born in 2001 in Santo Domingo who participates' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'was born in 1996 in Los Alcarrizos, a working-class neighborhood on the outskirts of Santo Domingo', 'was born in 1996 in Los Frailes, a working-class neighbourhood of Santo Domingo Este')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'tokischa'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('was born in 1996 in Los Alcarrizos, a working-class neighborhood on the outskirts of Santo Domingo' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'was born in 1996 in Los Alcarrizos, a working-class neighborhood on the outskirts of Santo Domingo', 'was born in 1996 in Los Frailes, a working-class neighbourhood of Santo Domingo Este'),
       updated_at = now()
 WHERE slug = 'tokischa'
   AND position('was born in 1996 in Los Alcarrizos, a working-class neighborhood on the outskirts of Santo Domingo' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'born in 1956 in San José de las Matas, a mountain town in Santiago province known for its cool climate and deep roots in traditional Cibao culture', 'born in 1956 in Imbert, in the northern province of Puerto Plata, a region with deep roots in traditional Cibao culture')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'jose-el-calvo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('born in 1956 in San José de las Matas, a mountain town in Santiago province known for its cool climate and deep roots in traditional Cibao culture' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'born in 1956 in San José de las Matas, a mountain town in Santiago province known for its cool climate and deep roots in traditional Cibao culture', 'born in 1956 in Imbert, in the northern province of Puerto Plata, a region with deep roots in traditional Cibao culture'),
       updated_at = now()
 WHERE slug = 'jose-el-calvo'
   AND position('born in 1956 in San José de las Matas, a mountain town in Santiago province known for its cool climate and deep roots in traditional Cibao culture' in bio_en) > 0;

COMMIT;
