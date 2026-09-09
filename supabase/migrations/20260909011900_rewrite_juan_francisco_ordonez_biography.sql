BEGIN;

-- Ficha de Juan Francisco Ordóñez.
--
-- Limpia además un alias mal colocado por partida doble: "Transporte
-- Urbano" figuraba como alias de Ordóñez Y de Luis "Terror" Días. No es
-- ninguno de los dos: es la banda que ambos fundaron a finales de 1982 y
-- que no tiene fila propia. Queda anotada en ARTISTAS_FALTANTES.md.
--
-- De paso, la fila de Días traía "El Terror" repetido dos veces.
--
-- Sin enlazar por no estar publicado: Héctor Santana, bajista de OFS y de
-- Trilogía, cuya fila está en needs_review.

-- 1. Alias mal colocados
UPDATE artists SET aliases = array_remove(aliases, 'Transporte Urbano') WHERE slug = 'juan-francisco-ordonez';
UPDATE artists SET aliases = ARRAY['El Terror', 'Luis Díaz', 'Luis Dias']::text[] WHERE slug = 'luis-terror-dias';

-- 2. Documentos editoriales, referencias y espejo markdown legacy
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Francisco Ordóñez is a Dominican guitarist, composer and arranger, born in Santo Domingo on 4 October 1961. His work sits where blues, rock and jazz meet the colour of bachata and son, and he is credited with changing what the guitar does in Dominican music. He co-founded Transporte Urbano with "},{"type":"artistReference","attrs":{"occurrenceId":"1391c35b-3219-4da5-9c84-a5dab809f781","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":" and was its lead guitarist for close to twenty-five years."}]},{"type":"paragraph","content":[{"type":"text","text":"San Carlos and the guitar","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ordóñez was born in the San Carlos barrio of Santo Domingo, son of José Ordóñez García and Crisanta González, Asturian immigrants. He was schooled at the Colegio Dominicano De La Salle and took a degree in economics at the Universidad Autónoma de Santo Domingo. He began the guitar at eleven with the teacher Blas Carrasco and carried on by himself, learning to read music with Sonia de Piña."}]},{"type":"paragraph","content":[{"type":"text","text":"Convite and Transporte Urbano","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Between 1976 and 1977 he played in Convite, the group that did most to recover and rework Dominican folklore in that decade. At the end of 1982 he founded Transporte Urbano with Luis \"Terror\" Días and stayed as its lead guitarist for close to twenty-five years. In 1985 he went to Moscow with Días and the singer Patricia Pereyra to play the World Festival of Youth and Students."}]},{"type":"paragraph","content":[{"type":"text","text":"The trios","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He worked in small fusion groups throughout. OFS, with Guy Frómeta on drums and Héctor Santana on bass, travelled to Peru in 1986 for the Festival de la Nueva Canción Latinoamericana, on a bill with "},{"type":"artistReference","attrs":{"occurrenceId":"ce762edc-6267-4314-8b8f-c4dc667ded01","artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre"}},{"type":"text","text":", and to Montreal that June for the Carnaval du Soleil with Patricia Pereyra. In the nineties he formed Trilogía with Santana and the percussionist "},{"type":"artistReference","attrs":{"occurrenceId":"d175ec3d-481d-4260-9494-da75d471b31b","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":". In November 2012 the Ordóñez Trío opened the sixteenth DR Jazz Festival, alongside Pancho Amat and Pedro Guzmán."}]},{"type":"paragraph","content":[{"type":"text","text":"Records","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Trilogía came out on cassette in 1988 and was reissued on CD in 2004. Cabaret Azul, co-produced with Patricia Pereyra in 1989 and reissued in 2002, was placed on ACROARTE’s list of the hundred essential albums of Dominican music in July 2013. Radio Recuerdo followed in 2001 and El Trío Vol. 1 in 2019."}]},{"type":"paragraph","content":[{"type":"text","text":"In 2005 he was co-producer, arranger and guitarist on Bachata entre Amigos, the "},{"type":"artistReference","attrs":{"occurrenceId":"c38a320d-2ea7-47b2-8eae-ff7a6fd26ef9","artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor"}},{"type":"text","text":" album that brought in Joaquín Sabina, Joan Manuel Serrat, Silvio Rodríguez, Pablo Milanés, Pedro Guerra, Fito Páez and Víctor Manuel. He has also written for film: the short Frente al mar, from Hilma Contreras’s story, and León Ichaso’s Azúcar amarga."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ordóñez directed La Vellonera, the group that accompanied Víctor Víctor on stage until the singer’s death in 2020. He has played jam sessions with Paquito D’Rivera, Charlie Haden and Don Cherry, worked as a session guitarist across the Dominican Republic, Latin America and Spain, and taught several generations of Dominican guitarists."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-francisco-ordonez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1391c35b-3219-4da5-9c84-a5dab809f781', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ce762edc-6267-4314-8b8f-c4dc667ded01', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd175ec3d-481d-4260-9494-da75d471b31b', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c38a320d-2ea7-47b2-8eae-ff7a6fd26ef9', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Juan Francisco Ordóñez is a Dominican guitarist, composer and arranger, born in Santo Domingo on 4 October 1961. His work sits where blues, rock and jazz meet the colour of bachata and son, and he is credited with changing what the guitar does in Dominican music. He co-founded Transporte Urbano with Luis "Terror" Días and was its lead guitarist for close to twenty-five years.

**San Carlos and the guitar**

Ordóñez was born in the San Carlos barrio of Santo Domingo, son of José Ordóñez García and Crisanta González, Asturian immigrants. He was schooled at the Colegio Dominicano De La Salle and took a degree in economics at the Universidad Autónoma de Santo Domingo. He began the guitar at eleven with the teacher Blas Carrasco and carried on by himself, learning to read music with Sonia de Piña.

**Convite and Transporte Urbano**

Between 1976 and 1977 he played in Convite, the group that did most to recover and rework Dominican folklore in that decade. At the end of 1982 he founded Transporte Urbano with Luis "Terror" Días and stayed as its lead guitarist for close to twenty-five years. In 1985 he went to Moscow with Días and the singer Patricia Pereyra to play the World Festival of Youth and Students.

**The trios**

He worked in small fusion groups throughout. OFS, with Guy Frómeta on drums and Héctor Santana on bass, travelled to Peru in 1986 for the Festival de la Nueva Canción Latinoamericana, on a bill with Sonia Silvestre, and to Montreal that June for the Carnaval du Soleil with Patricia Pereyra. In the nineties he formed Trilogía with Santana and the percussionist Chichi Peralta. In November 2012 the Ordóñez Trío opened the sixteenth DR Jazz Festival, alongside Pancho Amat and Pedro Guzmán.

**Records**

Trilogía came out on cassette in 1988 and was reissued on CD in 2004. Cabaret Azul, co-produced with Patricia Pereyra in 1989 and reissued in 2002, was placed on ACROARTE’s list of the hundred essential albums of Dominican music in July 2013. Radio Recuerdo followed in 2001 and El Trío Vol. 1 in 2019.

In 2005 he was co-producer, arranger and guitarist on Bachata entre Amigos, the Víctor Víctor album that brought in Joaquín Sabina, Joan Manuel Serrat, Silvio Rodríguez, Pablo Milanés, Pedro Guerra, Fito Páez and Víctor Manuel. He has also written for film: the short Frente al mar, from Hilma Contreras’s story, and León Ichaso’s Azúcar amarga.

**Legacy**

Ordóñez directed La Vellonera, the group that accompanied Víctor Víctor on stage until the singer’s death in 2020. He has played jam sessions with Paquito D’Rivera, Charlie Haden and Don Cherry, worked as a session guitarist across the Dominican Republic, Latin America and Spain, and taught several generations of Dominican guitarists.' WHERE slug = 'juan-francisco-ordonez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Francisco Ordóñez es guitarrista, compositor y arreglista dominicano, nacido en Santo Domingo el 4 de octubre de 1961. Su trabajo está donde el blues, el rock y el jazz se cruzan con el color de la bachata y el son, y se le reconoce haber cambiado lo que la guitarra hace en la música dominicana. Fundó Transporte Urbano con "},{"type":"artistReference","attrs":{"occurrenceId":"cf399115-886c-42d4-a16f-669c9bd01f7f","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":" y fue su guitarrista líder durante casi veinticinco años."}]},{"type":"paragraph","content":[{"type":"text","text":"San Carlos y la guitarra","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ordóñez nació en el barrio de San Carlos de Santo Domingo, hijo de José Ordóñez García y Crisanta González, emigrantes asturianos. Estudió en el Colegio Dominicano De La Salle y se licenció en Ciencias Económicas en la Universidad Autónoma de Santo Domingo. Empezó la guitarra a los once años con el profesor Blas Carrasco y siguió de forma autodidacta; aprendió lectura musical con la profesora Sonia de Piña."}]},{"type":"paragraph","content":[{"type":"text","text":"Convite y Transporte Urbano","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Entre 1976 y 1977 tocó en Convite, el grupo que más hizo por rescatar y transformar el folclore dominicano en esa década. A finales de 1982 fundó Transporte Urbano con Luis «Terror» Días y se quedó como guitarrista líder durante casi veinticinco años. En 1985 viajó a Moscú con Días y la cantante Patricia Pereyra para el Festival Mundial de la Juventud y los Estudiantes."}]},{"type":"paragraph","content":[{"type":"text","text":"Los tríos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Trabajó siempre en formaciones pequeñas de fusión. OFS, con Guy Frómeta en la batería y Héctor Santana en el bajo, viajó a Perú en 1986 al Festival de la Nueva Canción Latinoamericana, en cartel con "},{"type":"artistReference","attrs":{"occurrenceId":"19da57d9-26fc-4222-81ce-f4c11abb0d5c","artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre"}},{"type":"text","text":", y a Montreal ese junio al Carnaval du Soleil con Patricia Pereyra. En los noventa armó Trilogía con Santana y el percusionista "},{"type":"artistReference","attrs":{"occurrenceId":"997f94bf-bcf6-4514-810a-a7f64deb7d7b","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":". En noviembre de 2012 el Ordóñez Trío abrió la decimosexta edición del DR Jazz Festival, junto a Pancho Amat y Pedro Guzmán."}]},{"type":"paragraph","content":[{"type":"text","text":"Discos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Trilogía salió en casete en 1988 y se reeditó en CD en 2004. Cabaret Azul, coproducido con Patricia Pereyra en 1989 y reeditado en 2002, entró en la lista de los cien álbumes esenciales de la música dominicana que ACROARTE publicó en julio de 2013. Radio Recuerdo vino en 2001 y El Trío Vol. 1 en 2019."}]},{"type":"paragraph","content":[{"type":"text","text":"En 2005 fue coproductor, arreglista y guitarrista de Bachata entre Amigos, el disco de "},{"type":"artistReference","attrs":{"occurrenceId":"94298c21-f441-4b40-99d6-e6da80a646bd","artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor"}},{"type":"text","text":" en el que participaron Joaquín Sabina, Joan Manuel Serrat, Silvio Rodríguez, Pablo Milanés, Pedro Guerra, Fito Páez y Víctor Manuel. Ha escrito además para cine: el corto Frente al mar, sobre el cuento de Hilma Contreras, y Azúcar amarga, de León Ichaso."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ordóñez dirigió La Vellonera, el grupo que acompañó a Víctor Víctor en escena hasta la muerte del cantautor en 2020. Ha compartido descargas con Paquito D’Rivera, Charlie Haden y Don Cherry, ha trabajado de guitarrista de sesión en la República Dominicana, Iberoamérica y España, y ha enseñado a varias generaciones de guitarristas dominicanos."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-francisco-ordonez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cf399115-886c-42d4-a16f-669c9bd01f7f', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '19da57d9-26fc-4222-81ce-f4c11abb0d5c', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '997f94bf-bcf6-4514-810a-a7f64deb7d7b', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '94298c21-f441-4b40-99d6-e6da80a646bd', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Juan Francisco Ordóñez es guitarrista, compositor y arreglista dominicano, nacido en Santo Domingo el 4 de octubre de 1961. Su trabajo está donde el blues, el rock y el jazz se cruzan con el color de la bachata y el son, y se le reconoce haber cambiado lo que la guitarra hace en la música dominicana. Fundó Transporte Urbano con Luis "Terror" Días y fue su guitarrista líder durante casi veinticinco años.

**San Carlos y la guitarra**

Ordóñez nació en el barrio de San Carlos de Santo Domingo, hijo de José Ordóñez García y Crisanta González, emigrantes asturianos. Estudió en el Colegio Dominicano De La Salle y se licenció en Ciencias Económicas en la Universidad Autónoma de Santo Domingo. Empezó la guitarra a los once años con el profesor Blas Carrasco y siguió de forma autodidacta; aprendió lectura musical con la profesora Sonia de Piña.

**Convite y Transporte Urbano**

Entre 1976 y 1977 tocó en Convite, el grupo que más hizo por rescatar y transformar el folclore dominicano en esa década. A finales de 1982 fundó Transporte Urbano con Luis «Terror» Días y se quedó como guitarrista líder durante casi veinticinco años. En 1985 viajó a Moscú con Días y la cantante Patricia Pereyra para el Festival Mundial de la Juventud y los Estudiantes.

**Los tríos**

Trabajó siempre en formaciones pequeñas de fusión. OFS, con Guy Frómeta en la batería y Héctor Santana en el bajo, viajó a Perú en 1986 al Festival de la Nueva Canción Latinoamericana, en cartel con Sonia Silvestre, y a Montreal ese junio al Carnaval du Soleil con Patricia Pereyra. En los noventa armó Trilogía con Santana y el percusionista Chichi Peralta. En noviembre de 2012 el Ordóñez Trío abrió la decimosexta edición del DR Jazz Festival, junto a Pancho Amat y Pedro Guzmán.

**Discos**

Trilogía salió en casete en 1988 y se reeditó en CD en 2004. Cabaret Azul, coproducido con Patricia Pereyra en 1989 y reeditado en 2002, entró en la lista de los cien álbumes esenciales de la música dominicana que ACROARTE publicó en julio de 2013. Radio Recuerdo vino en 2001 y El Trío Vol. 1 en 2019.

En 2005 fue coproductor, arreglista y guitarrista de Bachata entre Amigos, el disco de Víctor Víctor en el que participaron Joaquín Sabina, Joan Manuel Serrat, Silvio Rodríguez, Pablo Milanés, Pedro Guerra, Fito Páez y Víctor Manuel. Ha escrito además para cine: el corto Frente al mar, sobre el cuento de Hilma Contreras, y Azúcar amarga, de León Ichaso.

**Legado**

Ordóñez dirigió La Vellonera, el grupo que acompañó a Víctor Víctor en escena hasta la muerte del cantautor en 2020. Ha compartido descargas con Paquito D’Rivera, Charlie Haden y Don Cherry, ha trabajado de guitarrista de sesión en la República Dominicana, Iberoamérica y España, y ha enseñado a varias generaciones de guitarristas dominicanos.' WHERE slug = 'juan-francisco-ordonez';

COMMIT;
