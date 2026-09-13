BEGIN;

-- Reverts 20260908003300_rewrite_yoskar_sarante_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Yoskar Sarante',
       sort_name = 'Sarante Ventura, Yoskar',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1970-01-02',
       birth_year = 1970,
       date_of_death = '2019-01-28',
       birth_place = 'Villas Agrícolas, Santo Domingo',
       province = 'Peravia',
       first_name = 'Yoskar',
       middle_name = NULL,
       last_name = 'Sarante',
       second_last_name = 'Ventura',
       stage_name = NULL,
       aliases = ARRAY['El Prabú', 'La Voz Más Alta de la Bachata']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = 'yoskarsaranteoficial',
       disambiguation = 'Bachata singer known as El Prabú; came out of merengue orchestras before Llora Alma Mía',
       bio_en = 'Yoskar Sarante Ventura, known as El Prabú, was a Dominican bachata singer. He had a high, unforced voice that could hold a line without pushing it, and for a stretch at the start of the century he was one of the two most heard bachateros in the country.

**Villas Agrícolas**

He was born in 1970 in Villas Agrícolas, a barrio of Santo Domingo. As a boy he sang in parks and public squares while his older brother played guitar, and what they collected went to the household. He entered the children’s singing contests on Dominican television, among them Mundo Infantil, and later enrolled at the Iris del Valle music school in Los Mina, paying for it with work on building sites.

**The merengue orchestras**

His professional career began in merengue rather than bachata. He sang with Grupo Internacional Melao, and after finishing at the music school passed through the orchestras of Tomás Barrera, Cheche Abreu, Aramis Camilo and Guancho Viloria. The years in front of merengue bands gave him the breath control and the projection that later separated him inside a slower genre.

**Llora Alma Mía**

He turned to bachata and released El Prabú in 1994, the record that gave him his name, followed by Niña Sedienta in 1996 and Si Fuera Ella in 1998. The album that made him was Llora Alma Mía, in 2000: La Noche, No Te Detengas, Si Te Llego a Perder and the title song are all still standards of the genre.

No Es Casualidad followed in 2002 and Viví in 2004. Between those records he and Elvis Martínez were the two bachateros the country listened to most, at the moment when bachata was finishing its move from the margins to the centre of Dominican radio. He was invited to New York and sang at the Mets stadium in front of the city’s mayor, which opened the United States to him.

**The later records**

Parada 37 came in 2006 and Vuelve Vuelve in 2008, and he kept releasing into the following decade. The songs that stayed are the slow ones: Vas a Llorar, Guitarra, Por una Mentira, Perdido, Perdóname, No Tengo Suerte en el Amor, El Amor es Libre, He Tenido que Llorar and Guerra de Amor.

He also recorded within the wider revival of the genre, appearing on collections such as Bachata Típico and The Rough Guide to Bachata, which carried Dominican bachata to listeners who had come to it from outside. He died in a hospital in Orlando, Florida, on 28 January 2019.',
       bio_es = 'Yoskar Sarante Ventura, conocido como El Prabú, fue un cantante de bachata dominicano. Tenía una voz aguda y sin esfuerzo, capaz de sostener una frase sin forzarla, y durante un tramo de principios de siglo fue uno de los dos bachateros más escuchados del país.

**Villas Agrícolas**

Nació en 1970 en Villas Agrícolas, barrio de Santo Domingo. De niño cantaba en parques y plazas públicas mientras su hermano mayor tocaba la guitarra, y lo que recogían iba al sustento de la casa. Concursó en los programas infantiles de canto de la televisión dominicana, entre ellos Mundo Infantil, y más adelante se inscribió en la Escuela de Música Iris del Valle, en Los Mina, que pagó trabajando en construcción.

**Las orquestas de merengue**

Su carrera profesional empezó en el merengue y no en la bachata. Cantó con el Grupo Internacional Melao y, al graduarse de la escuela de música, pasó por las orquestas de Tomás Barrera, Cheche Abreu, Aramis Camilo y Guancho Viloria. Los años delante de bandas de merengue le dieron el aire y la proyección que después lo distinguieron dentro de un género más lento.

**Llora Alma Mía**

Se pasó a la bachata y sacó El Prabú en 1994, el disco que le dio el nombre, seguido de Niña Sedienta en 1996 y Si Fuera Ella en 1998. El álbum que lo hizo fue Llora Alma Mía, de 2000: La Noche, No Te Detengas, Si Te Llego a Perder y el tema que le da título siguen siendo clásicos del género.

Detrás vinieron No Es Casualidad en 2002 y Viví en 2004. Entre esos discos, él y Elvis Martínez eran los dos bachateros que más oía el país, justo cuando la bachata terminaba de pasar del margen al centro de la radio dominicana. Lo invitaron a Nueva York y cantó en el estadio de los Mets delante del alcalde de la ciudad, lo que le abrió Estados Unidos.

**Los discos siguientes**

Parada 37 salió en 2006 y Vuelve Vuelve en 2008, y siguió publicando en la década siguiente. Las canciones que quedaron son las lentas: Vas a Llorar, Guitarra, Por una Mentira, Perdido, Perdóname, No Tengo Suerte en el Amor, El Amor es Libre, He Tenido que Llorar y Guerra de Amor.

Grabó también dentro del rescate más amplio del género, apareciendo en recopilaciones como Bachata Típico y The Rough Guide to Bachata, que llevaron la bachata dominicana a oyentes que llegaron a ella desde afuera. Murió en un hospital de Orlando, Florida, el 28 de enero de 2019.',
       updated_at = now()
 WHERE slug = 'yoskar-sarante';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Yoskar Sarante Ventura, known as El Prabú, was a Dominican bachata singer. He had a high, unforced voice that could hold a line without pushing it, and for a stretch at the start of the century he was one of the two most heard bachateros in the country.","type":"text"}]},{"type":"paragraph","content":[{"text":"Villas Agrícolas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1970 in Villas Agrícolas, a barrio of Santo Domingo. As a boy he sang in parks and public squares while his older brother played guitar, and what they collected went to the household. He entered the children’s singing contests on Dominican television, among them Mundo Infantil, and later enrolled at the Iris del Valle music school in Los Mina, paying for it with work on building sites.","type":"text"}]},{"type":"paragraph","content":[{"text":"The merengue orchestras","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His professional career began in merengue rather than bachata. He sang with Grupo Internacional Melao, and after finishing at the music school passed through the orchestras of Tomás Barrera, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"73691e65-206a-4c71-9b5f-8689f15b2584","displayText":"Cheche Abreu","occurrenceId":"0a3b1c53-b99b-4b54-a278-67d51a6c409b"}},{"text":", Aramis Camilo and Guancho Viloria. The years in front of merengue bands gave him the breath control and the projection that later separated him inside a slower genre.","type":"text"}]},{"type":"paragraph","content":[{"text":"Llora Alma Mía","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He turned to bachata and released El Prabú in 1994, the record that gave him his name, followed by Niña Sedienta in 1996 and Si Fuera Ella in 1998. The album that made him was Llora Alma Mía, in 2000: La Noche, No Te Detengas, Si Te Llego a Perder and the title song are all still standards of the genre.","type":"text"}]},{"type":"paragraph","content":[{"text":"No Es Casualidad followed in 2002 and Viví in 2004. Between those records he and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e566c763-02c1-4f96-8a82-edbba9fc0bb2","displayText":"Elvis Martínez","occurrenceId":"69d6fad2-1d7b-436a-8ea7-a89dd1839bbb"}},{"text":" were the two bachateros the country listened to most, at the moment when bachata was finishing its move from the margins to the centre of Dominican radio. He was invited to New York and sang at the Mets stadium in front of the city’s mayor, which opened the United States to him.","type":"text"}]},{"type":"paragraph","content":[{"text":"The later records","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Parada 37 came in 2006 and Vuelve Vuelve in 2008, and he kept releasing into the following decade. The songs that stayed are the slow ones: Vas a Llorar, Guitarra, Por una Mentira, Perdido, Perdóname, No Tengo Suerte en el Amor, El Amor es Libre, He Tenido que Llorar and Guerra de Amor.","type":"text"}]},{"type":"paragraph","content":[{"text":"He also recorded within the wider revival of the genre, appearing on collections such as Bachata Típico and The Rough Guide to Bachata, which carried Dominican bachata to listeners who had come to it from outside. He died in a hospital in Orlando, Florida, on 28 January 2019.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'yoskar-sarante'), 2)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Yoskar Sarante Ventura, conocido como El Prabú, fue un cantante de bachata dominicano. Tenía una voz aguda y sin esfuerzo, capaz de sostener una frase sin forzarla, y durante un tramo de principios de siglo fue uno de los dos bachateros más escuchados del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Villas Agrícolas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1970 en Villas Agrícolas, barrio de Santo Domingo. De niño cantaba en parques y plazas públicas mientras su hermano mayor tocaba la guitarra, y lo que recogían iba al sustento de la casa. Concursó en los programas infantiles de canto de la televisión dominicana, entre ellos Mundo Infantil, y más adelante se inscribió en la Escuela de Música Iris del Valle, en Los Mina, que pagó trabajando en construcción.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las orquestas de merengue","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su carrera profesional empezó en el merengue y no en la bachata. Cantó con el Grupo Internacional Melao y, al graduarse de la escuela de música, pasó por las orquestas de Tomás Barrera, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"73691e65-206a-4c71-9b5f-8689f15b2584","displayText":"Cheche Abreu","occurrenceId":"57b2b905-591f-4893-82a9-3b10e70c590c"}},{"text":", Aramis Camilo y Guancho Viloria. Los años delante de bandas de merengue le dieron el aire y la proyección que después lo distinguieron dentro de un género más lento.","type":"text"}]},{"type":"paragraph","content":[{"text":"Llora Alma Mía","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se pasó a la bachata y sacó El Prabú en 1994, el disco que le dio el nombre, seguido de Niña Sedienta en 1996 y Si Fuera Ella en 1998. El álbum que lo hizo fue Llora Alma Mía, de 2000: La Noche, No Te Detengas, Si Te Llego a Perder y el tema que le da título siguen siendo clásicos del género.","type":"text"}]},{"type":"paragraph","content":[{"text":"Detrás vinieron No Es Casualidad en 2002 y Viví en 2004. Entre esos discos, él y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e566c763-02c1-4f96-8a82-edbba9fc0bb2","displayText":"Elvis Martínez","occurrenceId":"a35b34e0-49c6-4f63-a7fb-1f9ecba140d7"}},{"text":" eran los dos bachateros que más oía el país, justo cuando la bachata terminaba de pasar del margen al centro de la radio dominicana. Lo invitaron a Nueva York y cantó en el estadio de los Mets delante del alcalde de la ciudad, lo que le abrió Estados Unidos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los discos siguientes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Parada 37 salió en 2006 y Vuelve Vuelve en 2008, y siguió publicando en la década siguiente. Las canciones que quedaron son las lentas: Vas a Llorar, Guitarra, Por una Mentira, Perdido, Perdóname, No Tengo Suerte en el Amor, El Amor es Libre, He Tenido que Llorar y Guerra de Amor.","type":"text"}]},{"type":"paragraph","content":[{"text":"Grabó también dentro del rescate más amplio del género, apareciendo en recopilaciones como Bachata Típico y The Rough Guide to Bachata, que llevaron la bachata dominicana a oyentes que llegaron a ella desde afuera. Murió en un hospital de Orlando, Florida, el 28 de enero de 2019.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'yoskar-sarante'), 1)
ON CONFLICT (document_type, owner_artist_id, locale)
  WHERE document_type = 'artist_biography'
DO UPDATE SET
  document = EXCLUDED.document,
  status = EXCLUDED.status,
  revision = EXCLUDED.revision,
  schema_version = EXCLUDED.schema_version,
  updated_at = now();

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante') AND locale = 'en'), '0a3b1c53-b99b-4b54-a278-67d51a6c409b', 'artist', '73691e65-206a-4c71-9b5f-8689f15b2584');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante') AND locale = 'en'), '69d6fad2-1d7b-436a-8ea7-a89dd1839bbb', 'artist', 'e566c763-02c1-4f96-8a82-edbba9fc0bb2');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante') AND locale = 'es'), '57b2b905-591f-4893-82a9-3b10e70c590c', 'artist', '73691e65-206a-4c71-9b5f-8689f15b2584');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yoskar-sarante') AND locale = 'es'), 'a35b34e0-49c6-4f63-a7fb-1f9ecba140d7', 'artist', 'e566c763-02c1-4f96-8a82-edbba9fc0bb2');

COMMIT;
