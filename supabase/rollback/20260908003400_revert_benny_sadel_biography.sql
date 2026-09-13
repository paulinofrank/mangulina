BEGIN;

-- Reverts 20260908003400_rewrite_benny_sadel_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Benny Sadel',
       sort_name = 'Sadel, Benny',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1960-03-27',
       birth_year = 1960,
       date_of_death = '2015-11-05',
       birth_place = 'Uvilla, Tamayo',
       province = 'Bahoruco',
       first_name = 'Emmanuel',
       middle_name = NULL,
       last_name = 'Jiménez',
       second_last_name = NULL,
       stage_name = 'Benny Sadel',
       aliases = ARRAY['El Cacique', 'El Cacique del Merengue']::text[],
       occupations = '["bandleader"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Merengue singer known as El Cacique; passed through five orchestras before forming his own',
       bio_en = 'Benny Sadel was a Dominican merengue singer known as El Cacique. He spent a decade moving through other people’s orchestras before he built one of his own, and the route he took — a village band in the south, the capital, Venezuela, Boston and New York — is a fair map of how a Dominican singer of his generation made a career.

**Uvilla**

He was born in 1960 in Uvilla, a settlement in Tamayo, in the southwestern province of Bahoruco. He started singing at birthdays and patron-saint festivals, and in 1977 joined Los X-1 del Sabor, the band of his own town. His music teacher there, Arturo Méndez, told him he would have to go to Santo Domingo, and he went.

**The orchestras**

He was hired by Gerardo Veras for Los Diamantes the day after he arrived in the capital, stayed two years, and moved on to the Santo Domingo All Star Band. When El Equipo was being put together, Dioni Fernández y El Equipo and Sandy Reyes brought him in as a vocalist, and he stayed a year and seven months.

He then went to Venezuela and formed his own group there, Los Jacarandosos de Benny Sadel, with Dominican and Venezuelan players. Wilfrido Vargas offered him a place in his orchestra and he came home for it, but his visa renewal was not processed in time and he was left out of the international tour after only four performances with the band. He went back to Venezuela and picked up his own group again.

In 1983 he joined La Organización Secreta, the orchestra of Aramis Camilo, and it was there that his name travelled: Ven Llévame Contigo and Querida were sung across the continent.

**Caciquiando**

He formed his own orchestra in 1987, putting it together in Boston, and named the first album Caciquiando, which is where the nickname comes from. Alza Tu Copa, Te He Prometido and Yo Soy Así came out of that first stretch, and the group worked Boston and then New York before going to Santo Domingo to record.

The records kept coming through the nineties: Escucha Escucha in 1988, Morenaza in 1992, Majao Majao in 1993, Seguimos Majando in 1995 and Llegó Papá in 1997. Majao Majao, Dicen, Cada Vez Más, Te Seguiré Queriendo, Algo de Mí, Maldita Sea and Amor Amor are the ones people still ask for. Tanto Amor followed in 1998 and Vuelve in 2005.

**Los Toros Band**

In 2008 he joined Los Toros Band as its lead figure, which took him back into a large orchestra after two decades of running his own. He died in New York on 5 November 2015, at fifty-five. Sergio Vargas sang at his wake.',
       bio_es = 'Benny Sadel fue un cantante de merengue dominicano conocido como El Cacique. Pasó una década por orquestas ajenas antes de montar la suya, y el camino que recorrió — una banda de pueblo en el sur, la capital, Venezuela, Boston y Nueva York — es un mapa bastante fiel de cómo se hacía una carrera siendo cantante dominicano de su generación.

**Uvilla**

Nació en 1960 en Uvilla, un paraje de Tamayo, en la provincia sureña de Bahoruco. Empezó cantando en cumpleaños y fiestas patronales, y en 1977 entró a Los X-1 del Sabor, la orquesta de su propio pueblo. Su maestro de música allí, Arturo Méndez, le dijo que tenía que irse a Santo Domingo, y se fue.

**Las orquestas**

Gerardo Veras lo contrató para Los Diamantes al día siguiente de llegar a la capital, se quedó dos años y pasó a la Santo Domingo All Star Band. Cuando se estaba armando El Equipo, Dioni Fernández y El Equipo y Sandy Reyes lo metieron como vocalista, y estuvo un año y siete meses.

Después se fue a Venezuela y montó allá su propio grupo, Los Jacarandosos de Benny Sadel, con músicos dominicanos y venezolanos. Wilfrido Vargas le ofreció un puesto en su orquesta y él volvió al país por eso, pero no le renovaron el visado a tiempo y se quedó fuera de la gira internacional después de apenas cuatro presentaciones con la banda. Regresó a Venezuela y retomó su grupo.

En 1983 entró a La Organización Secreta, la orquesta de Aramis Camilo, y ahí fue donde su nombre viajó: Ven Llévame Contigo y Querida se cantaron por todo el continente.

**Caciquiando**

Montó orquesta propia en 1987, armándola en Boston, y llamó al primer disco Caciquiando, de donde sale el apodo. Alza Tu Copa, Te He Prometido y Yo Soy Así salieron de esa primera tanda, y el grupo trabajó Boston y luego Nueva York antes de ir a Santo Domingo a grabar.

Los discos siguieron saliendo a lo largo de los noventa: Escucha Escucha en 1988, Morenaza en 1992, Majao Majao en 1993, Seguimos Majando en 1995 y Llegó Papá en 1997. Majao Majao, Dicen, Cada Vez Más, Te Seguiré Queriendo, Algo de Mí, Maldita Sea y Amor Amor son las que la gente sigue pidiendo. Tanto Amor vino en 1998 y Vuelve en 2005.

**Los Toros Band**

En 2008 entró a Los Toros Band como figura principal, lo que lo devolvió a una orquesta grande después de dos décadas al frente de la suya. Murió en Nueva York el 5 de noviembre de 2015, a los cincuenta y cinco años. Sergio Vargas cantó en su velatorio.',
       updated_at = now()
 WHERE slug = 'benny-sadel';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Benny Sadel was a Dominican merengue singer known as El Cacique. He spent a decade moving through other people’s orchestras before he built one of his own, and the route he took — a village band in the south, the capital, Venezuela, Boston and New York — is a fair map of how a Dominican singer of his generation made a career.","type":"text"}]},{"type":"paragraph","content":[{"text":"Uvilla","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1960 in Uvilla, a settlement in Tamayo, in the southwestern province of Bahoruco. He started singing at birthdays and patron-saint festivals, and in 1977 joined Los X-1 del Sabor, the band of his own town. His music teacher there, Arturo Méndez, told him he would have to go to Santo Domingo, and he went.","type":"text"}]},{"type":"paragraph","content":[{"text":"The orchestras","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was hired by Gerardo Veras for Los Diamantes the day after he arrived in the capital, stayed two years, and moved on to the Santo Domingo All Star Band. When El Equipo was being put together, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fb2c703f-5362-47dd-ada0-7c6d5e106f3b","displayText":"Dioni Fernández y El Equipo","occurrenceId":"f73efc4a-61e2-4ef0-85ee-3a5077e6e42c"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"49f8aae7-e066-4b01-a836-126082163c52","displayText":"Sandy Reyes","occurrenceId":"d9a410d9-e0ba-46d8-ab6f-db52f7ae604c"}},{"text":" brought him in as a vocalist, and he stayed a year and seven months.","type":"text"}]},{"type":"paragraph","content":[{"text":"He then went to Venezuela and formed his own group there, Los Jacarandosos de Benny Sadel, with Dominican and Venezuelan players. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"a678e742-e7d6-41a0-8d1a-ab12f93fd0c1"}},{"text":" offered him a place in his orchestra and he came home for it, but his visa renewal was not processed in time and he was left out of the international tour after only four performances with the band. He went back to Venezuela and picked up his own group again.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 1983 he joined La Organización Secreta, the orchestra of Aramis Camilo, and it was there that his name travelled: Ven Llévame Contigo and Querida were sung across the continent.","type":"text"}]},{"type":"paragraph","content":[{"text":"Caciquiando","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He formed his own orchestra in 1987, putting it together in Boston, and named the first album Caciquiando, which is where the nickname comes from. Alza Tu Copa, Te He Prometido and Yo Soy Así came out of that first stretch, and the group worked Boston and then New York before going to Santo Domingo to record.","type":"text"}]},{"type":"paragraph","content":[{"text":"The records kept coming through the nineties: Escucha Escucha in 1988, Morenaza in 1992, Majao Majao in 1993, Seguimos Majando in 1995 and Llegó Papá in 1997. Majao Majao, Dicen, Cada Vez Más, Te Seguiré Queriendo, Algo de Mí, Maldita Sea and Amor Amor are the ones people still ask for. Tanto Amor followed in 1998 and Vuelve in 2005.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Toros Band","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 2008 he joined ","type":"text"},{"type":"artistReference","attrs":{"artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band","occurrenceId":"a6b3f021-5557-409c-a67e-92446fc9a9a9"}},{"text":" as its lead figure, which took him back into a large orchestra after two decades of running his own. He died in New York on 5 November 2015, at fifty-five. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"071c055d-8b45-4a58-aa87-919c27e473d6"}},{"text":" sang at his wake.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'benny-sadel'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Benny Sadel fue un cantante de merengue dominicano conocido como El Cacique. Pasó una década por orquestas ajenas antes de montar la suya, y el camino que recorrió — una banda de pueblo en el sur, la capital, Venezuela, Boston y Nueva York — es un mapa bastante fiel de cómo se hacía una carrera siendo cantante dominicano de su generación.","type":"text"}]},{"type":"paragraph","content":[{"text":"Uvilla","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1960 en Uvilla, un paraje de Tamayo, en la provincia sureña de Bahoruco. Empezó cantando en cumpleaños y fiestas patronales, y en 1977 entró a Los X-1 del Sabor, la orquesta de su propio pueblo. Su maestro de música allí, Arturo Méndez, le dijo que tenía que irse a Santo Domingo, y se fue.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las orquestas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Gerardo Veras lo contrató para Los Diamantes al día siguiente de llegar a la capital, se quedó dos años y pasó a la Santo Domingo All Star Band. Cuando se estaba armando El Equipo, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fb2c703f-5362-47dd-ada0-7c6d5e106f3b","displayText":"Dioni Fernández y El Equipo","occurrenceId":"ab030127-1faa-4ad8-8ba7-d828a2a442c0"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"49f8aae7-e066-4b01-a836-126082163c52","displayText":"Sandy Reyes","occurrenceId":"e1543610-674f-48d3-a118-98302988a302"}},{"text":" lo metieron como vocalista, y estuvo un año y siete meses.","type":"text"}]},{"type":"paragraph","content":[{"text":"Después se fue a Venezuela y montó allá su propio grupo, Los Jacarandosos de Benny Sadel, con músicos dominicanos y venezolanos. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"f29bc7ab-cf71-4275-9787-75f39b1eb21a"}},{"text":" le ofreció un puesto en su orquesta y él volvió al país por eso, pero no le renovaron el visado a tiempo y se quedó fuera de la gira internacional después de apenas cuatro presentaciones con la banda. Regresó a Venezuela y retomó su grupo.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 1983 entró a La Organización Secreta, la orquesta de Aramis Camilo, y ahí fue donde su nombre viajó: Ven Llévame Contigo y Querida se cantaron por todo el continente.","type":"text"}]},{"type":"paragraph","content":[{"text":"Caciquiando","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Montó orquesta propia en 1987, armándola en Boston, y llamó al primer disco Caciquiando, de donde sale el apodo. Alza Tu Copa, Te He Prometido y Yo Soy Así salieron de esa primera tanda, y el grupo trabajó Boston y luego Nueva York antes de ir a Santo Domingo a grabar.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los discos siguieron saliendo a lo largo de los noventa: Escucha Escucha en 1988, Morenaza en 1992, Majao Majao en 1993, Seguimos Majando en 1995 y Llegó Papá en 1997. Majao Majao, Dicen, Cada Vez Más, Te Seguiré Queriendo, Algo de Mí, Maldita Sea y Amor Amor son las que la gente sigue pidiendo. Tanto Amor vino en 1998 y Vuelve en 2005.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Toros Band","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 2008 entró a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"73032c71-e46c-45b1-b02c-8f4de18426ad","displayText":"Los Toros Band","occurrenceId":"44a67e1a-14e6-4793-a1c6-28c617a831f9"}},{"text":" como figura principal, lo que lo devolvió a una orquesta grande después de dos décadas al frente de la suya. Murió en Nueva York el 5 de noviembre de 2015, a los cincuenta y cinco años. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas","occurrenceId":"7846361e-7709-416d-9693-beaeda6e5d45"}},{"text":" cantó en su velatorio.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'benny-sadel'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'en'), '071c055d-8b45-4a58-aa87-919c27e473d6', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'en'), 'a678e742-e7d6-41a0-8d1a-ab12f93fd0c1', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'en'), 'a6b3f021-5557-409c-a67e-92446fc9a9a9', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'en'), 'd9a410d9-e0ba-46d8-ab6f-db52f7ae604c', 'artist', '49f8aae7-e066-4b01-a836-126082163c52');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'en'), 'f73efc4a-61e2-4ef0-85ee-3a5077e6e42c', 'artist', 'fb2c703f-5362-47dd-ada0-7c6d5e106f3b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'es'), '44a67e1a-14e6-4793-a1c6-28c617a831f9', 'artist', '73032c71-e46c-45b1-b02c-8f4de18426ad');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'es'), '7846361e-7709-416d-9693-beaeda6e5d45', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'es'), 'ab030127-1faa-4ad8-8ba7-d828a2a442c0', 'artist', 'fb2c703f-5362-47dd-ada0-7c6d5e106f3b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'es'), 'e1543610-674f-48d3-a118-98302988a302', 'artist', '49f8aae7-e066-4b01-a836-126082163c52');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'benny-sadel') AND locale = 'es'), 'f29bc7ab-cf71-4275-9787-75f39b1eb21a', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

COMMIT;
