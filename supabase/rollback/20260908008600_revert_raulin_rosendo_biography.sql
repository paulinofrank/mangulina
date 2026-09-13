BEGIN;

-- Reverts 20260908008600_rewrite_raulin_rosendo_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Raulín Rosendo',
       sort_name = NULL,
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1957-08-30',
       birth_year = 1957,
       date_of_death = NULL,
       birth_place = 'Villa Duarte',
       province = 'Santo Domingo',
       first_name = 'Raúl',
       middle_name = NULL,
       last_name = 'Martínez',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY['El Sonero del Pueblo']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@RaulinRosendo-xz6hf',
       facebook = 'morenaraulin',
       instagram = 'raulinrosendooficial',
       disambiguation = 'Salsa singer who came up fronting the merengue orchestra Los Hijos del Rey',
       bio_en = 'Raúl Martínez, who sings as Raulín Rosendo, is a Dominican salsa singer. He came up in merengue, fronting one of the biggest Dominican orchestras of the nineteen-seventies, and made his name a second time in New York in the nineties as a sonero.

**Los Hijos del Rey**

He was born on 30 August 1957 in Villa Duarte, on the eastern edge of Santo Domingo, and began performing at twelve with a merengue group called El Chivo y su Banda.

In the seventies he became one of the two lead voices of Los Hijos del Rey, the orchestra Wilfrido Vargas had put together. He fronted it alongside Fernando Villalona, with Bonny Cepeda directing from the piano and writing the arrangements, and the records came out on Karen. Marisela, La Mazorca, La Boda de Marisela and La Tetera y la Tijera date from those years. Sergio Vargas would front the same orchestra later.

**New York**

He moved to New York and worked there with Conjunto Clásico and with Milly, Jocelyn y Los Vecinos. His own records began with Salsa con Amor in 1988 and Salsa, Solamente Salsa in 1991, and by 1993 he was recording in the city with the producer Ricky González, who cut Amor en Secreto and Santo Domingo with him.

**El sonero que el pueblo prefiere**

The record of that title, from 1995, was the best-selling album of its year and carried Uno Se Cura, which is the song most people name first. It brought him a nomination at the Casandra awards at home and another at the A.C.E. awards in New York.

The albums that followed put him among the most widely heard salsa singers of the decade: Dominicano Para el Mundo, ¡Simplemente! ¡Contrólate!, Llegó la Ley and Donde Me Coja la Noche, one a year from 1996. He has gone on recording since — En Venezuela, De Aquí Pa’ Allá, La Fama Es Peligrosa, Dame Otra Oportunidad and, in 2021, Tranquilo Que Yo Controlo.

**The sonero**

He is billed as El Sonero del Pueblo, and what the billing points at is the improvising: a sonero is judged on what he invents over the montuno, not on what he memorised. It is also what makes his career legible as a single line rather than two — the same singer who traded verses at the front of a merengue orchestra spent the nineties trading them over a salsa rhythm section.',
       bio_es = 'Raúl Martínez, que canta como Raulín Rosendo, es un salsero dominicano. Se hizo en el merengue, al frente de una de las orquestas dominicanas más grandes de los años setenta, y volvió a hacerse un nombre en Nueva York en los noventa como sonero.

**Los Hijos del Rey**

Nació el 30 de agosto de 1957 en Villa Duarte, en el extremo este de Santo Domingo, y empezó a cantar a los doce años en un grupo de merengue llamado El Chivo y su Banda.

En los setenta pasó a ser una de las dos voces principales de Los Hijos del Rey, la orquesta que había armado Wilfrido Vargas. Estaba al frente junto a Fernando Villalona, con Bonny Cepeda dirigiendo desde el piano y firmando los arreglos, y los discos salían por Karen. De esos años son Marisela, La Mazorca, La Boda de Marisela y La Tetera y la Tijera. Sergio Vargas encabezaría esa misma orquesta más adelante.

**Nueva York**

Se fue a Nueva York y allí trabajó con el Conjunto Clásico y con Milly, Jocelyn y Los Vecinos. Sus discos propios empiezan con Salsa con Amor, de 1988, y Salsa, Solamente Salsa, de 1991, y en 1993 ya grababa en la ciudad con el productor Ricky González, que le sacó Amor en Secreto y Santo Domingo.

**El sonero que el pueblo prefiere**

El disco de ese título, de 1995, fue el más vendido de su año y traía Uno Se Cura, que es la canción que la gente nombra primero. Le valió una nominación en los Premios Casandra en el país y otra en los premios A.C.E. de Nueva York.

Los discos siguientes lo pusieron entre los salseros más escuchados de la década: Dominicano Para el Mundo, ¡Simplemente! ¡Contrólate!, Llegó la Ley y Donde Me Coja la Noche, uno por año desde 1996. Ha seguido grabando después: En Venezuela, De Aquí Pa’ Allá, La Fama Es Peligrosa, Dame Otra Oportunidad y, en 2021, Tranquilo Que Yo Controlo.

**El sonero**

Se anuncia como El Sonero del Pueblo, y lo que ese nombre señala es la improvisación: a un sonero se le juzga por lo que inventa sobre el montuno, no por lo que trae aprendido. Es también lo que deja leer su carrera como una sola línea y no como dos, porque el mismo cantante que cruzaba versos al frente de una orquesta de merengue se pasó los noventa cruzándolos sobre una sección rítmica de salsa.',
       updated_at = now()
 WHERE slug = 'raulin-rosendo';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Raúl Martínez, who sings as Raulín Rosendo, is a Dominican salsa singer. He came up in merengue, fronting one of the biggest Dominican orchestras of the nineteen-seventies, and made his name a second time in New York in the nineties as a sonero.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Hijos del Rey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born on 30 August 1957 in Villa Duarte, on the eastern edge of Santo Domingo, and began performing at twelve with a merengue group called El Chivo y su Banda.","type":"text"}]},{"type":"paragraph","content":[{"text":"In the seventies he became one of the two lead voices of Los Hijos del Rey, the orchestra ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"4c5a967d-82db-492d-b437-1bdf747b7127"}},{"text":" had put together. He fronted it alongside ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"4ec0847b-7e28-4491-844c-06d50c5cf555"}},{"text":", with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc4db4c6-c96f-4eb7-af95-ac637785c5bf","displayText":"Bonny Cepeda","occurrenceId":"991577a8-b3c6-477b-b42d-45b4506f4ef0"}},{"text":" directing from the piano and writing the arrangements, and the records came out on Karen. Marisela, La Mazorca, La Boda de Marisela and La Tetera y la Tijera date from those years. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"b93711ac-15d6-49b2-ad27-9442857f1151"}},{"text":" would front the same orchestra later.","type":"text"}]},{"type":"paragraph","content":[{"text":"New York","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He moved to New York and worked there with Conjunto Clásico and with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"241703d2-a7f0-457d-b020-704f3a02b0d4","displayText":"Milly, Jocelyn y Los Vecinos","occurrenceId":"438afcf0-7d37-47d2-bfc1-7f9d24951536"}},{"text":". His own records began with Salsa con Amor in 1988 and Salsa, Solamente Salsa in 1991, and by 1993 he was recording in the city with the producer Ricky González, who cut Amor en Secreto and Santo Domingo with him.","type":"text"}]},{"type":"paragraph","content":[{"text":"El sonero que el pueblo prefiere","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The record of that title, from 1995, was the best-selling album of its year and carried Uno Se Cura, which is the song most people name first. It brought him a nomination at the Casandra awards at home and another at the A.C.E. awards in New York.","type":"text"}]},{"type":"paragraph","content":[{"text":"The albums that followed put him among the most widely heard salsa singers of the decade: Dominicano Para el Mundo, ¡Simplemente! ¡Contrólate!, Llegó la Ley and Donde Me Coja la Noche, one a year from 1996. He has gone on recording since — En Venezuela, De Aquí Pa’ Allá, La Fama Es Peligrosa, Dame Otra Oportunidad and, in 2021, Tranquilo Que Yo Controlo.","type":"text"}]},{"type":"paragraph","content":[{"text":"The sonero","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He is billed as El Sonero del Pueblo, and what the billing points at is the improvising: a sonero is judged on what he invents over the montuno, not on what he memorised. It is also what makes his career legible as a single line rather than two — the same singer who traded verses at the front of a merengue orchestra spent the nineties trading them over a salsa rhythm section.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'raulin-rosendo'), 3)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Raúl Martínez, que canta como Raulín Rosendo, es un salsero dominicano. Se hizo en el merengue, al frente de una de las orquestas dominicanas más grandes de los años setenta, y volvió a hacerse un nombre en Nueva York en los noventa como sonero.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Hijos del Rey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació el 30 de agosto de 1957 en Villa Duarte, en el extremo este de Santo Domingo, y empezó a cantar a los doce años en un grupo de merengue llamado El Chivo y su Banda.","type":"text"}]},{"type":"paragraph","content":[{"text":"En los setenta pasó a ser una de las dos voces principales de Los Hijos del Rey, la orquesta que había armado ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"05eae37f-b1bf-4fbc-9b5b-6aed114e0d94"}},{"text":". Estaba al frente junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"bae98d59-714f-49d7-9e82-92b6eac57b03"}},{"text":", con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc4db4c6-c96f-4eb7-af95-ac637785c5bf","displayText":"Bonny Cepeda","occurrenceId":"e7c2cc68-40b4-4ccf-862b-134733b53987"}},{"text":" dirigiendo desde el piano y firmando los arreglos, y los discos salían por Karen. De esos años son Marisela, La Mazorca, La Boda de Marisela y La Tetera y la Tijera. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"08e331cb-a466-4bf5-8eb2-9da75df59b6c"}},{"text":" encabezaría esa misma orquesta más adelante.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nueva York","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se fue a Nueva York y allí trabajó con el Conjunto Clásico y con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"241703d2-a7f0-457d-b020-704f3a02b0d4","displayText":"Milly, Jocelyn y Los Vecinos","occurrenceId":"34936c33-4d58-4831-b889-f3a81fc15eae"}},{"text":". Sus discos propios empiezan con Salsa con Amor, de 1988, y Salsa, Solamente Salsa, de 1991, y en 1993 ya grababa en la ciudad con el productor Ricky González, que le sacó Amor en Secreto y Santo Domingo.","type":"text"}]},{"type":"paragraph","content":[{"text":"El sonero que el pueblo prefiere","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El disco de ese título, de 1995, fue el más vendido de su año y traía Uno Se Cura, que es la canción que la gente nombra primero. Le valió una nominación en los Premios Casandra en el país y otra en los premios A.C.E. de Nueva York.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los discos siguientes lo pusieron entre los salseros más escuchados de la década: Dominicano Para el Mundo, ¡Simplemente! ¡Contrólate!, Llegó la Ley y Donde Me Coja la Noche, uno por año desde 1996. Ha seguido grabando después: En Venezuela, De Aquí Pa’ Allá, La Fama Es Peligrosa, Dame Otra Oportunidad y, en 2021, Tranquilo Que Yo Controlo.","type":"text"}]},{"type":"paragraph","content":[{"text":"El sonero","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se anuncia como El Sonero del Pueblo, y lo que ese nombre señala es la improvisación: a un sonero se le juzga por lo que inventa sobre el montuno, no por lo que trae aprendido. Es también lo que deja leer su carrera como una sola línea y no como dos, porque el mismo cantante que cruzaba versos al frente de una orquesta de merengue se pasó los noventa cruzándolos sobre una sección rítmica de salsa.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'raulin-rosendo'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'en'), '438afcf0-7d37-47d2-bfc1-7f9d24951536', 'artist', '241703d2-a7f0-457d-b020-704f3a02b0d4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'en'), '4c5a967d-82db-492d-b437-1bdf747b7127', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'en'), '4ec0847b-7e28-4491-844c-06d50c5cf555', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'en'), '991577a8-b3c6-477b-b42d-45b4506f4ef0', 'artist', 'bc4db4c6-c96f-4eb7-af95-ac637785c5bf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'en'), 'b93711ac-15d6-49b2-ad27-9442857f1151', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'es'), '05eae37f-b1bf-4fbc-9b5b-6aed114e0d94', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'es'), '08e331cb-a466-4bf5-8eb2-9da75df59b6c', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'es'), '34936c33-4d58-4831-b889-f3a81fc15eae', 'artist', '241703d2-a7f0-457d-b020-704f3a02b0d4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'es'), 'bae98d59-714f-49d7-9e82-92b6eac57b03', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'raulin-rosendo') AND locale = 'es'), 'e7c2cc68-40b4-4ccf-862b-134733b53987', 'artist', 'bc4db4c6-c96f-4eb7-af95-ac637785c5bf');

COMMIT;
