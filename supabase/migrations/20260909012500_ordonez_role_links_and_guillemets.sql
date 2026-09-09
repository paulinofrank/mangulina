BEGIN;

-- Ficha de Juan Francisco Ordóñez, TERCERA VERSIÓN.
-- Tres correcciones señaladas por el editor:
--
--  1. primary_role pasa de "instrumentalist" a "musician". El término no es
--     de uso popular y el propio ROLE_DICTIONARY.md ya lo desaconseja. Como
--     occupations no puede repetir primary_role, sale "musician" de ahí.
--     Quedan 38 filas más con instrumentalist: barrido aparte.
--  2. artistReference en TODAS las menciones, no solo en la primera. El
--     documento de formato lo pide y yo venía enlazando una sola vez.
--  3. «...» en obras y en entidades sin ficha, en los dos idiomas, según la
--     nueva Regla 4b de docs/EDITORIAL_BIOGRAPHY_FORMAT.md.

-- 1. Rol e higiene de campos
UPDATE artists SET primary_role = 'musician', occupations = '["composer","arranger"]'::jsonb
 WHERE slug = 'juan-francisco-ordonez';

-- 2. Documentos editoriales, referencias y espejo markdown legacy
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Francisco Ordóñez is a Dominican guitarist, composer and arranger, born in Santo Domingo on 4 October 1961. He has spent his career inside other people’s projects at the moment those projects were inventing something: "},{"type":"artistReference","attrs":{"occurrenceId":"80936934-5bcf-411f-bdf1-5981263387e9","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":"’s «Transporte Urbano», where Dominican rock is generally said to begin; the trio behind "},{"type":"artistReference","attrs":{"occurrenceId":"0981fe38-fd36-47d5-ba8e-33fb84a622b7","artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre"}},{"type":"text","text":" when she was making tecnoamargue; and the records of "},{"type":"artistReference","attrs":{"occurrenceId":"f4f74eaa-a019-44aa-af53-c1a2e254849a","artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor"}},{"type":"text","text":". He is credited with changing what the guitar does in Dominican music."}]},{"type":"paragraph","content":[{"type":"text","text":"Learning","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ordóñez was born in the San Carlos barrio, son of José Ordóñez García and Crisanta González, Asturian immigrants. He was schooled at the Colegio Dominicano De La Salle and took a degree in economics at the Universidad Autónoma de Santo Domingo. He started the guitar at eleven with Blas Carrasco and carried on alone; Sonia de Piña taught him to read music. In 1976 and 1977 he was in «Convite», less a band than a research project with instruments, which went looking for rhythms that had survived in corners of the island without ever reaching a studio."}]},{"type":"paragraph","content":[{"type":"text","text":"The rock that did not exist","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"artistReference","attrs":{"occurrenceId":"f4a90cff-0f9b-4d0e-b073-a18de4b05995","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":" came back from New York in 1982 with punk in his ears and «Convite»’s fieldwork behind him, and assembled «Transporte Urbano»: Ordóñez on electric guitar, Guy Frómeta on drums, Héctor Santana on bass — later Peter Nova — Bruno Ranson on saxophone and "},{"type":"artistReference","attrs":{"occurrenceId":"9329d62d-1157-40f9-aa3a-ec19beba6f6f","artistId":"41fa2ce2-dd3d-44b8-82b5-ab2df86f9a8a","displayText":"Duluc"}},{"type":"text","text":" on percussion. The band is treated as the beginning of Dominican rock, not because Dominicans were playing rock but because this rock was built out of merengue, bachata, mangulina, salve and dozens of other Dominican and Haitian rhythms. Within a few years it had contracted to a power trio, which put most of the weight on the guitar. It never played anyone else’s songs."}]},{"type":"paragraph","content":[{"type":"text","text":"They played the amphitheatre at Altos de Chavón in February 1983 with Bob James, and again that April with «The English Beat». In 1984 they scored the short «Las pausas del silencio» alongside "},{"type":"artistReference","attrs":{"occurrenceId":"7b1fe1b8-9ed5-46d0-840e-4404056feb0e","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"10c91e7e-ab20-4e2b-8f06-9016cf98a528","artistId":"080c0205-8b66-4f16-915e-1d867acf82cc","displayText":"Maridalia Hernández"}},{"type":"text","text":" and Tavito Vásquez, and the music took best soundtrack at the Philadelphia international film festival. The LP they cut at Audiolab in 1985 sat unreleased for want of money until 2000, when it appeared as «"},{"type":"artistReference","attrs":{"occurrenceId":"18056722-db79-4e63-8dc0-108f89020ac5","artistId":"20610d35-0190-4733-90c0-8c7db5cbe7e0","displayText":"Vickiana"}},{"type":"text","text":": las sesiones del 1985». At the «Varadero» festival in Cuba in April 1987 the band’s volume and stage manner were judged improper by some authorities and its members were invited to leave the country the day after they played; the Cuban youth press took their side, and Pablo Milanés said so publicly. Ordóñez stayed close to twenty-five years, until "},{"type":"artistReference","attrs":{"occurrenceId":"e1f76720-fc6e-42c6-a1c0-07ea4964d17e","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":"’s band wound up in 2004."}]},{"type":"paragraph","content":[{"type":"text","text":"Tecnoamargue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He worked in trios alongside all of that. «OFS», with Frómeta and Héctor Santana, went to Peru in 1986 for the «Festival de la Nueva Canción Latinoamericana» and to Montreal that June for the «Carnaval du Soleil», with the singer Patricia Pereyra. «Trilogía», with Santana and the percussionist "},{"type":"artistReference","attrs":{"occurrenceId":"a4fac438-a19d-4a67-9174-5b74cdeab879","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":", became the band that toured "},{"type":"artistReference","attrs":{"occurrenceId":"d0a95d6f-749d-4c7d-9e06-b0bf7fb27ee9","artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre"}},{"type":"text","text":"’s «Yo quiero andar» — the record that moved her into bachata and gave her the widest audience of her career — and it was in that work that tecnoamargue, the style built on the bachatas of "},{"type":"artistReference","attrs":{"occurrenceId":"f037fe97-fa24-49d4-9610-2578d7d65ce4","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":", came of age."}]},{"type":"paragraph","content":[{"type":"text","text":"His own records","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Trilogía» was issued on cassette in 1988 and on CD in 2004. «Cabaret Azul», made with Patricia Pereyra in 1989 and reissued in 2002, was placed on «ACROARTE»’s hundred essential albums of Dominican music in 2013. «Radio Recuerdo» followed in 2001 and «El Trío Vol. 1» in 2019; by then the «Ordóñez Trío» had opened the sixteenth «DR Jazz Festival», in November 2012, on a bill with Pancho Amat and Pedro Guzmán."}]},{"type":"paragraph","content":[{"type":"text","text":"Behind other people","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2005 he co-produced, arranged and played on "},{"type":"artistReference","attrs":{"occurrenceId":"dc7653c8-ddce-4a75-b864-817b0ec6fab9","artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor"}},{"type":"text","text":"’s «Bachata entre amigos», which put songs by Joaquín Sabina, Joan Manuel Serrat, Silvio Rodríguez, Pablo Milanés, Pedro Guerra and Fito Páez into bachata as duets with their authors. He went on to direct «La Vellonera», the group that backed "},{"type":"artistReference","attrs":{"occurrenceId":"8a98e4f6-f0ae-4cb4-8d06-8c082ea9b778","artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor"}},{"type":"text","text":" on stage until the singer died in 2020. He has written for film — the short «Frente al mar», from Hilma Contreras’s story, and León Ichaso’s «Azúcar amarga» — and worked as a session guitarist in the Dominican Republic, Latin America and Spain."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ordóñez has played jam sessions with Paquito D’Rivera, Charlie Haden and Don Cherry, and has taught several generations of Dominican guitarists. His playing is on the founding record of Dominican rock, on the record where tecnoamargue came of age, and on the one that carried bachata to a roomful of Iberoamerican songwriters — in each case as the guitarist rather than the author."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-francisco-ordonez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '80936934-5bcf-411f-bdf1-5981263387e9', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0981fe38-fd36-47d5-ba8e-33fb84a622b7', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f4f74eaa-a019-44aa-af53-c1a2e254849a', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f4a90cff-0f9b-4d0e-b073-a18de4b05995', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9329d62d-1157-40f9-aa3a-ec19beba6f6f', 'artist', '41fa2ce2-dd3d-44b8-82b5-ab2df86f9a8a'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7b1fe1b8-9ed5-46d0-840e-4404056feb0e', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '10c91e7e-ab20-4e2b-8f06-9016cf98a528', 'artist', '080c0205-8b66-4f16-915e-1d867acf82cc'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '18056722-db79-4e63-8dc0-108f89020ac5', 'artist', '20610d35-0190-4733-90c0-8c7db5cbe7e0'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e1f76720-fc6e-42c6-a1c0-07ea4964d17e', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a4fac438-a19d-4a67-9174-5b74cdeab879', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd0a95d6f-749d-4c7d-9e06-b0bf7fb27ee9', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f037fe97-fa24-49d4-9610-2578d7d65ce4', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dc7653c8-ddce-4a75-b864-817b0ec6fab9', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '8a98e4f6-f0ae-4cb4-8d06-8c082ea9b778', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Juan Francisco Ordóñez is a Dominican guitarist, composer and arranger, born in Santo Domingo on 4 October 1961. He has spent his career inside other people’s projects at the moment those projects were inventing something: Luis "Terror" Días’s «Transporte Urbano», where Dominican rock is generally said to begin; the trio behind Sonia Silvestre when she was making tecnoamargue; and the records of Víctor Víctor. He is credited with changing what the guitar does in Dominican music.

**Learning**

Ordóñez was born in the San Carlos barrio, son of José Ordóñez García and Crisanta González, Asturian immigrants. He was schooled at the Colegio Dominicano De La Salle and took a degree in economics at the Universidad Autónoma de Santo Domingo. He started the guitar at eleven with Blas Carrasco and carried on alone; Sonia de Piña taught him to read music. In 1976 and 1977 he was in «Convite», less a band than a research project with instruments, which went looking for rhythms that had survived in corners of the island without ever reaching a studio.

**The rock that did not exist**

Luis "Terror" Días came back from New York in 1982 with punk in his ears and «Convite»’s fieldwork behind him, and assembled «Transporte Urbano»: Ordóñez on electric guitar, Guy Frómeta on drums, Héctor Santana on bass — later Peter Nova — Bruno Ranson on saxophone and Duluc on percussion. The band is treated as the beginning of Dominican rock, not because Dominicans were playing rock but because this rock was built out of merengue, bachata, mangulina, salve and dozens of other Dominican and Haitian rhythms. Within a few years it had contracted to a power trio, which put most of the weight on the guitar. It never played anyone else’s songs.

They played the amphitheatre at Altos de Chavón in February 1983 with Bob James, and again that April with «The English Beat». In 1984 they scored the short «Las pausas del silencio» alongside Juan Luis Guerra 4.40, Maridalia Hernández and Tavito Vásquez, and the music took best soundtrack at the Philadelphia international film festival. The LP they cut at Audiolab in 1985 sat unreleased for want of money until 2000, when it appeared as «Vickiana: las sesiones del 1985». At the «Varadero» festival in Cuba in April 1987 the band’s volume and stage manner were judged improper by some authorities and its members were invited to leave the country the day after they played; the Cuban youth press took their side, and Pablo Milanés said so publicly. Ordóñez stayed close to twenty-five years, until Luis "Terror" Días’s band wound up in 2004.

**Tecnoamargue**

He worked in trios alongside all of that. «OFS», with Frómeta and Héctor Santana, went to Peru in 1986 for the «Festival de la Nueva Canción Latinoamericana» and to Montreal that June for the «Carnaval du Soleil», with the singer Patricia Pereyra. «Trilogía», with Santana and the percussionist Chichi Peralta, became the band that toured Sonia Silvestre’s «Yo quiero andar» — the record that moved her into bachata and gave her the widest audience of her career — and it was in that work that tecnoamargue, the style built on the bachatas of Luis "Terror" Días, came of age.

**His own records**

«Trilogía» was issued on cassette in 1988 and on CD in 2004. «Cabaret Azul», made with Patricia Pereyra in 1989 and reissued in 2002, was placed on «ACROARTE»’s hundred essential albums of Dominican music in 2013. «Radio Recuerdo» followed in 2001 and «El Trío Vol. 1» in 2019; by then the «Ordóñez Trío» had opened the sixteenth «DR Jazz Festival», in November 2012, on a bill with Pancho Amat and Pedro Guzmán.

**Behind other people**

In 2005 he co-produced, arranged and played on Víctor Víctor’s «Bachata entre amigos», which put songs by Joaquín Sabina, Joan Manuel Serrat, Silvio Rodríguez, Pablo Milanés, Pedro Guerra and Fito Páez into bachata as duets with their authors. He went on to direct «La Vellonera», the group that backed Víctor Víctor on stage until the singer died in 2020. He has written for film — the short «Frente al mar», from Hilma Contreras’s story, and León Ichaso’s «Azúcar amarga» — and worked as a session guitarist in the Dominican Republic, Latin America and Spain.

**Legacy**

Ordóñez has played jam sessions with Paquito D’Rivera, Charlie Haden and Don Cherry, and has taught several generations of Dominican guitarists. His playing is on the founding record of Dominican rock, on the record where tecnoamargue came of age, and on the one that carried bachata to a roomful of Iberoamerican songwriters — in each case as the guitarist rather than the author.' WHERE slug = 'juan-francisco-ordonez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Francisco Ordóñez, guitarrista, compositor y arreglista dominicano nacido en Santo Domingo el 4 de octubre de 1961, ha hecho carrera dentro de proyectos ajenos justo cuando esos proyectos estaban inventando algo: el «Transporte Urbano» de "},{"type":"artistReference","attrs":{"occurrenceId":"1aa7fd82-2e3f-4979-b64d-4826587ff7f0","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":", donde suele situarse el nacimiento del rock dominicano; el trío que respaldó a "},{"type":"artistReference","attrs":{"occurrenceId":"9ff03996-e87d-46bf-ad63-057f7d49c4d8","artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre"}},{"type":"text","text":" en su etapa de tecnoamargue; y los discos de "},{"type":"artistReference","attrs":{"occurrenceId":"3ae1e953-1f5e-47f6-9dd3-657340b80f9e","artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor"}},{"type":"text","text":". Se le reconoce haber cambiado lo que la guitarra hace en la música dominicana."}]},{"type":"paragraph","content":[{"type":"text","text":"Aprendizaje","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Nació en el barrio de San Carlos, hijo de José Ordóñez García y Crisanta González, emigrantes asturianos. Del Colegio Dominicano De La Salle pasó a la Universidad Autónoma de Santo Domingo, donde se licenció en Ciencias Económicas. La guitarra la empezó a los once con Blas Carrasco y la siguió por su cuenta; la lectura musical se la enseñó Sonia de Piña. En 1976 y 1977 estuvo en «Convite», que era menos una banda que un proyecto de investigación con instrumentos, dedicado a buscar ritmos que habían sobrevivido en rincones de la isla sin llegar nunca a un estudio."}]},{"type":"paragraph","content":[{"type":"text","text":"El rock que no existía","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"artistReference","attrs":{"occurrenceId":"8e2066ab-3914-4e30-b488-a2c612b59b8e","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":" volvió de Nueva York en 1982 con el punk encima y el trabajo de campo de «Convite» detrás, y montó «Transporte Urbano»: Ordóñez en la guitarra eléctrica, Guy Frómeta en la batería, Héctor Santana en el bajo —después Peter Nova—, Bruno Ranson en el saxofón y "},{"type":"artistReference","attrs":{"occurrenceId":"4b92bb00-9907-411b-a92f-bfc3e069ee2f","artistId":"41fa2ce2-dd3d-44b8-82b5-ab2df86f9a8a","displayText":"Duluc"}},{"type":"text","text":" en la percusión. A la banda se la tiene por el comienzo del rock dominicano, no porque hubiera dominicanos tocando rock sino porque ese rock estaba armado con merengue, bachata, mangulina, salve y decenas de ritmos dominicanos y haitianos más. En pocos años se redujo a power trío, lo que cargó casi todo el peso sobre la guitarra. Nunca tocó canciones de otros autores."}]},{"type":"paragraph","content":[{"type":"text","text":"Se presentaron en el anfiteatro de Altos de Chavón en febrero de 1983 con Bob James, y en abril con los ingleses «The English Beat». En 1984 grabaron la banda sonora del corto «Las pausas del silencio» junto a "},{"type":"artistReference","attrs":{"occurrenceId":"4d38fe3a-471d-4b8a-8460-9dc7e31c7163","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"eddf1e3e-1ca6-4078-b894-871fbd2b2745","artistId":"080c0205-8b66-4f16-915e-1d867acf82cc","displayText":"Maridalia Hernández"}},{"type":"text","text":" y Tavito Vásquez, y esa música ganó el premio a mejor banda sonora en el festival internacional de cine de Filadelfia. El LP que registraron en Audiolab en 1985 se quedó sin publicar por falta de recursos hasta el año 2000, cuando salió como «"},{"type":"artistReference","attrs":{"occurrenceId":"b999d441-3c92-43e9-9a47-3a50b16bc25d","artistId":"20610d35-0190-4733-90c0-8c7db5cbe7e0","displayText":"Vickiana"}},{"type":"text","text":": las sesiones del 1985». En el festival «Varadero» de Cuba, en abril de 1987, algunas autoridades consideraron impropios el volumen y la presencia escénica del grupo, y a sus integrantes se los invitó a abandonar el país al día siguiente de tocar; la prensa juvenil cubana se puso de su lado y Pablo Milanés lo dijo en público. Ordóñez se quedó casi veinticinco años, hasta que la banda de "},{"type":"artistReference","attrs":{"occurrenceId":"aec1a8f7-fa3a-4ac4-8f91-802e1e6c525e","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":" cerró en 2004."}]},{"type":"paragraph","content":[{"type":"text","text":"Tecnoamargue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En paralelo trabajó en tríos. «OFS», con Frómeta y Héctor Santana, fue a Perú en 1986 al «Festival de la Nueva Canción Latinoamericana» y a Montreal ese junio al «Carnaval du Soleil», con la cantante Patricia Pereyra. «Trilogía», con Santana y el percusionista "},{"type":"artistReference","attrs":{"occurrenceId":"ae3220ab-f9ff-4b83-9a83-16a9b7c3d283","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":", terminó siendo la banda que giró «Yo quiero andar», de "},{"type":"artistReference","attrs":{"occurrenceId":"dbdfafac-40bf-4ffd-a512-291a4dfa7d28","artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre"}},{"type":"text","text":" —el disco que la pasó a la bachata y le dio el público más amplio de su carrera—, y fue en ese trabajo donde maduró el tecnoamargue, el estilo levantado sobre las bachatas de "},{"type":"artistReference","attrs":{"occurrenceId":"d46cd1d1-1bf7-42d8-b96d-d02dc8b6b451","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Discos propios","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Trilogía» salió en casete en 1988 y en CD en 2004. «Cabaret Azul», hecho con Patricia Pereyra en 1989 y reeditado en 2002, entró en 2013 en los cien álbumes esenciales de la música dominicana de «ACROARTE». «Radio Recuerdo» es de 2001 y «El Trío Vol. 1» de 2019; para entonces el «Ordóñez Trío» ya había abierto la decimosexta edición del «DR Jazz Festival», en noviembre de 2012, en cartel con Pancho Amat y Pedro Guzmán."}]},{"type":"paragraph","content":[{"type":"text","text":"Detrás de otros","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2005 coprodujo, arregló y tocó en «Bachata entre amigos», de "},{"type":"artistReference","attrs":{"occurrenceId":"6ff0199b-bb5b-4c87-a3a8-acc30f10796c","artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor"}},{"type":"text","text":", que puso en bachata canciones de Joaquín Sabina, Joan Manuel Serrat, Silvio Rodríguez, Pablo Milanés, Pedro Guerra y Fito Páez, cantadas a dúo con sus autores. Después dirigió «La Vellonera», el grupo que respaldó a "},{"type":"artistReference","attrs":{"occurrenceId":"e29e3a8c-ce81-451c-ae44-d9a580ce2333","artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor"}},{"type":"text","text":" en escena hasta la muerte del cantautor en 2020. Ha escrito para cine —el corto «Frente al mar», sobre el cuento de Hilma Contreras, y «Azúcar amarga», de León Ichaso— y ha trabajado de guitarrista de sesión en la República Dominicana, Iberoamérica y España."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ordóñez ha compartido descargas con Paquito D’Rivera, Charlie Haden y Don Cherry, y ha enseñado a varias generaciones de guitarristas dominicanos. Su manera de tocar está en el disco fundacional del rock dominicano, en el disco donde maduró el tecnoamargue y en el que llevó la bachata a una sala llena de cantautores iberoamericanos: en los tres como guitarrista, no como autor."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-francisco-ordonez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1aa7fd82-2e3f-4979-b64d-4826587ff7f0', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9ff03996-e87d-46bf-ad63-057f7d49c4d8', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3ae1e953-1f5e-47f6-9dd3-657340b80f9e', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '8e2066ab-3914-4e30-b488-a2c612b59b8e', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4b92bb00-9907-411b-a92f-bfc3e069ee2f', 'artist', '41fa2ce2-dd3d-44b8-82b5-ab2df86f9a8a'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4d38fe3a-471d-4b8a-8460-9dc7e31c7163', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'eddf1e3e-1ca6-4078-b894-871fbd2b2745', 'artist', '080c0205-8b66-4f16-915e-1d867acf82cc'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b999d441-3c92-43e9-9a47-3a50b16bc25d', 'artist', '20610d35-0190-4733-90c0-8c7db5cbe7e0'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'aec1a8f7-fa3a-4ac4-8f91-802e1e6c525e', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ae3220ab-f9ff-4b83-9a83-16a9b7c3d283', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dbdfafac-40bf-4ffd-a512-291a4dfa7d28', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd46cd1d1-1bf7-42d8-b96d-d02dc8b6b451', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6ff0199b-bb5b-4c87-a3a8-acc30f10796c', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e29e3a8c-ce81-451c-ae44-d9a580ce2333', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-ordonez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Juan Francisco Ordóñez, guitarrista, compositor y arreglista dominicano nacido en Santo Domingo el 4 de octubre de 1961, ha hecho carrera dentro de proyectos ajenos justo cuando esos proyectos estaban inventando algo: el «Transporte Urbano» de Luis "Terror" Días, donde suele situarse el nacimiento del rock dominicano; el trío que respaldó a Sonia Silvestre en su etapa de tecnoamargue; y los discos de Víctor Víctor. Se le reconoce haber cambiado lo que la guitarra hace en la música dominicana.

**Aprendizaje**

Nació en el barrio de San Carlos, hijo de José Ordóñez García y Crisanta González, emigrantes asturianos. Del Colegio Dominicano De La Salle pasó a la Universidad Autónoma de Santo Domingo, donde se licenció en Ciencias Económicas. La guitarra la empezó a los once con Blas Carrasco y la siguió por su cuenta; la lectura musical se la enseñó Sonia de Piña. En 1976 y 1977 estuvo en «Convite», que era menos una banda que un proyecto de investigación con instrumentos, dedicado a buscar ritmos que habían sobrevivido en rincones de la isla sin llegar nunca a un estudio.

**El rock que no existía**

Luis "Terror" Días volvió de Nueva York en 1982 con el punk encima y el trabajo de campo de «Convite» detrás, y montó «Transporte Urbano»: Ordóñez en la guitarra eléctrica, Guy Frómeta en la batería, Héctor Santana en el bajo —después Peter Nova—, Bruno Ranson en el saxofón y Duluc en la percusión. A la banda se la tiene por el comienzo del rock dominicano, no porque hubiera dominicanos tocando rock sino porque ese rock estaba armado con merengue, bachata, mangulina, salve y decenas de ritmos dominicanos y haitianos más. En pocos años se redujo a power trío, lo que cargó casi todo el peso sobre la guitarra. Nunca tocó canciones de otros autores.

Se presentaron en el anfiteatro de Altos de Chavón en febrero de 1983 con Bob James, y en abril con los ingleses «The English Beat». En 1984 grabaron la banda sonora del corto «Las pausas del silencio» junto a Juan Luis Guerra 4.40, Maridalia Hernández y Tavito Vásquez, y esa música ganó el premio a mejor banda sonora en el festival internacional de cine de Filadelfia. El LP que registraron en Audiolab en 1985 se quedó sin publicar por falta de recursos hasta el año 2000, cuando salió como «Vickiana: las sesiones del 1985». En el festival «Varadero» de Cuba, en abril de 1987, algunas autoridades consideraron impropios el volumen y la presencia escénica del grupo, y a sus integrantes se los invitó a abandonar el país al día siguiente de tocar; la prensa juvenil cubana se puso de su lado y Pablo Milanés lo dijo en público. Ordóñez se quedó casi veinticinco años, hasta que la banda de Luis "Terror" Días cerró en 2004.

**Tecnoamargue**

En paralelo trabajó en tríos. «OFS», con Frómeta y Héctor Santana, fue a Perú en 1986 al «Festival de la Nueva Canción Latinoamericana» y a Montreal ese junio al «Carnaval du Soleil», con la cantante Patricia Pereyra. «Trilogía», con Santana y el percusionista Chichi Peralta, terminó siendo la banda que giró «Yo quiero andar», de Sonia Silvestre —el disco que la pasó a la bachata y le dio el público más amplio de su carrera—, y fue en ese trabajo donde maduró el tecnoamargue, el estilo levantado sobre las bachatas de Luis "Terror" Días.

**Discos propios**

«Trilogía» salió en casete en 1988 y en CD en 2004. «Cabaret Azul», hecho con Patricia Pereyra en 1989 y reeditado en 2002, entró en 2013 en los cien álbumes esenciales de la música dominicana de «ACROARTE». «Radio Recuerdo» es de 2001 y «El Trío Vol. 1» de 2019; para entonces el «Ordóñez Trío» ya había abierto la decimosexta edición del «DR Jazz Festival», en noviembre de 2012, en cartel con Pancho Amat y Pedro Guzmán.

**Detrás de otros**

En 2005 coprodujo, arregló y tocó en «Bachata entre amigos», de Víctor Víctor, que puso en bachata canciones de Joaquín Sabina, Joan Manuel Serrat, Silvio Rodríguez, Pablo Milanés, Pedro Guerra y Fito Páez, cantadas a dúo con sus autores. Después dirigió «La Vellonera», el grupo que respaldó a Víctor Víctor en escena hasta la muerte del cantautor en 2020. Ha escrito para cine —el corto «Frente al mar», sobre el cuento de Hilma Contreras, y «Azúcar amarga», de León Ichaso— y ha trabajado de guitarrista de sesión en la República Dominicana, Iberoamérica y España.

**Legado**

Ordóñez ha compartido descargas con Paquito D’Rivera, Charlie Haden y Don Cherry, y ha enseñado a varias generaciones de guitarristas dominicanos. Su manera de tocar está en el disco fundacional del rock dominicano, en el disco donde maduró el tecnoamargue y en el que llevó la bachata a una sala llena de cantautores iberoamericanos: en los tres como guitarrista, no como autor.' WHERE slug = 'juan-francisco-ordonez';

COMMIT;
