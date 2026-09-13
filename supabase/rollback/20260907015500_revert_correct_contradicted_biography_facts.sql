BEGIN;

-- Revierte 20260907015500_correct_contradicted_biography_facts.sql.
--
-- Devuelve el texto anterior, con el registro conversacional que el editor
-- rechazó. Se conserva solo porque toda migración de este repositorio tiene
-- que ser reversible.

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Born in 1957 in San Pedro de Macorís', 'Born in 1928 in San Pedro de Macorís')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'raulin-rosendo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Born in 1957 in San Pedro de Macorís' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Born in 1957 in San Pedro de Macorís', 'Born in 1928 in San Pedro de Macorís'),
       updated_at = now()
 WHERE slug = 'raulin-rosendo'
   AND position('Born in 1957 in San Pedro de Macorís' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Born in 1961 in Santo Domingo', 'Born in 1953 in Santo Domingo')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'juan-francisco-ordonez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Born in 1961 in Santo Domingo' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Born in 1961 in Santo Domingo', 'Born in 1953 in Santo Domingo'),
       updated_at = now()
 WHERE slug = 'juan-francisco-ordonez'
   AND position('Born in 1961 in Santo Domingo' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'born in 1977 in Barahona', 'born in 1971 in Barahona')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'jandy-feliz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('born in 1977 in Barahona' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'born in 1977 in Barahona', 'born in 1971 in Barahona'),
       updated_at = now()
 WHERE slug = 'jandy-feliz'
   AND position('born in 1977 in Barahona' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'born in 1963 in Padre Las Casas', 'born in 1961 in Padre Las Casas')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'kinito-mendez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('born in 1963 in Padre Las Casas' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'born in 1963 in Padre Las Casas', 'born in 1961 in Padre Las Casas'),
       updated_at = now()
 WHERE slug = 'kinito-mendez'
   AND position('born in 1963 in Padre Las Casas' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'born in 1916 in San Pedro de Macorís', 'born in 1912 in San Pedro de Macorís')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dioris-valladares'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('born in 1916 in San Pedro de Macorís' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'born in 1916 in San Pedro de Macorís', 'born in 1912 in San Pedro de Macorís'),
       updated_at = now()
 WHERE slug = 'dioris-valladares'
   AND position('born in 1916 in San Pedro de Macorís' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'born in 2003 in Santo Domingo', 'born in 2000 in Santo Domingo')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dary-hezz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('born in 2003 in Santo Domingo' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'born in 2003 in Santo Domingo', 'born in 2000 in Santo Domingo'),
       updated_at = now()
 WHERE slug = 'dary-hezz'
   AND position('born in 2003 in Santo Domingo' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'La Materialista, born Yameyry Ynfante in Santiago de los Caballeros,', 'La Materialista, born Dianabel Rodríguez in 1987 in Santiago de los Caballeros,')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'la-materialista'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('La Materialista, born Yameyry Ynfante in Santiago de los Caballeros,' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'La Materialista, born Yameyry Ynfante in Santiago de los Caballeros,', 'La Materialista, born Dianabel Rodríguez in 1987 in Santiago de los Caballeros,'),
       updated_at = now()
 WHERE slug = 'la-materialista'
   AND position('La Materialista, born Yameyry Ynfante in Santiago de los Caballeros,' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'El Cata, born in 1972 in Barahona,', 'El Cata, born in 1972 in Santo Domingo,')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'el-cata'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('El Cata, born in 1972 in Barahona,' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'El Cata, born in 1972 in Barahona,', 'El Cata, born in 1972 in Santo Domingo,'),
       updated_at = now()
 WHERE slug = 'el-cata'
   AND position('El Cata, born in 1972 in Barahona,' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'born in 2001 in San Cristóbal who participates', 'born in 2001 in Santo Domingo who participates')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = '23thierno'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('born in 2001 in San Cristóbal who participates' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'born in 2001 in San Cristóbal who participates', 'born in 2001 in Santo Domingo who participates'),
       updated_at = now()
 WHERE slug = '23thierno'
   AND position('born in 2001 in San Cristóbal who participates' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'was born in 1996 in Los Frailes, a working-class neighbourhood of Santo Domingo Este', 'was born in 1996 in Los Alcarrizos, a working-class neighborhood on the outskirts of Santo Domingo')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'tokischa'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('was born in 1996 in Los Frailes, a working-class neighbourhood of Santo Domingo Este' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'was born in 1996 in Los Frailes, a working-class neighbourhood of Santo Domingo Este', 'was born in 1996 in Los Alcarrizos, a working-class neighborhood on the outskirts of Santo Domingo'),
       updated_at = now()
 WHERE slug = 'tokischa'
   AND position('was born in 1996 in Los Frailes, a working-class neighbourhood of Santo Domingo Este' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'born in 1956 in Imbert, in the northern province of Puerto Plata, a region with deep roots in traditional Cibao culture', 'born in 1956 in San José de las Matas, a mountain town in Santiago province known for its cool climate and deep roots in traditional Cibao culture')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'jose-el-calvo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('born in 1956 in Imbert, in the northern province of Puerto Plata, a region with deep roots in traditional Cibao culture' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'born in 1956 in Imbert, in the northern province of Puerto Plata, a region with deep roots in traditional Cibao culture', 'born in 1956 in San José de las Matas, a mountain town in Santiago province known for its cool climate and deep roots in traditional Cibao culture'),
       updated_at = now()
 WHERE slug = 'jose-el-calvo'
   AND position('born in 1956 in Imbert, in the northern province of Puerto Plata, a region with deep roots in traditional Cibao culture' in bio_en) > 0;

COMMIT;
