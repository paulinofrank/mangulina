BEGIN;

-- Franklin the Boss: nacido en Guayabal, Azua (la fila decía Santo Domingo); genres merengue-calle.

UPDATE artists SET birth_place = 'Guayabal', province = 'Azua', genres = ARRAY['merengue-calle']::text[] WHERE slug = 'franklin-the-boss';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Franklin the Boss —José Altagracia de León Corcino, born on 21 October 1980 in Guayabal, Azua, and died on 11 May 2025— was a Dominican merengue singer whose songs «La mantequilla», «El loco», «No me quiero enamorar» and «Tu vigilante enamorado» made him a figure of the street-merengue wave of the 2000s."}]},{"type":"paragraph","content":[{"type":"text","text":"Groups and orchestras","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began in music at thirteen, singing in a string of groups that included «Cherry Banda», «Choboys», «Los Trotamundos», «Karina La Jefa», "},{"type":"artistReference","attrs":{"occurrenceId":"6195f6cc-266b-4143-84d8-b926f4c99b96","artistId":"6fb949c4-2d6f-437f-8e7f-5f9efec847da","displayText":"Rikarena"}},{"type":"text","text":", the orchestra of "},{"type":"artistReference","attrs":{"occurrenceId":"1cfb6962-222b-4171-9ee9-af0e3a137323","artistId":"c73737c2-0106-4a87-8dbe-5f1650d34342","displayText":"Kinito Méndez"}},{"type":"text","text":", «Merengada», «Árabe Manía», «Rico Mambo» and «Swing Divino». In 2005 he launched his own solo project."}]},{"type":"paragraph","content":[{"type":"text","text":"Solo career","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As a soloist he recorded the compilations «El Concepto» and «El Concepto 2.0» and, at the end of 2024, «El Concepto, Vol. 3», seven songs of merengue and bachata released under the label «JAB Latin Music». He lived in Greensboro, North Carolina, where he played events, and in 2025 he was recording new songs for his YouTube channel, among them «Aventura»."}]},{"type":"paragraph","content":[{"type":"text","text":"The 2012 case","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2012 he was detained in Santo Domingo at the request of the United States, where a federal court in North Carolina had opened a case against him. He was released after eleven months, and the American authorities did not continue the proceeding."}]},{"type":"paragraph","content":[{"type":"text","text":"Death","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He died in the early hours of 11 May 2025, at 44, in a head-on collision on a highway in North Carolina."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Colleagues reacted publicly to the news; "},{"type":"artistReference","attrs":{"occurrenceId":"782f3ab8-0840-4b30-a3fd-dd87d9d8536f","artistId":"c73737c2-0106-4a87-8dbe-5f1650d34342","displayText":"Kinito Méndez"}},{"type":"text","text":", in whose orchestra he had worked, lamented his death."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'franklin-the-boss'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'franklin-the-boss' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '6195f6cc-266b-4143-84d8-b926f4c99b96', 'artist', '6fb949c4-2d6f-437f-8e7f-5f9efec847da' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'franklin-the-boss' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '1cfb6962-222b-4171-9ee9-af0e3a137323', 'artist', 'c73737c2-0106-4a87-8dbe-5f1650d34342' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'franklin-the-boss' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '782f3ab8-0840-4b30-a3fd-dd87d9d8536f', 'artist', 'c73737c2-0106-4a87-8dbe-5f1650d34342' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'franklin-the-boss' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Franklin the Boss —José Altagracia de León Corcino, born on 21 October 1980 in Guayabal, Azua, and died on 11 May 2025— was a Dominican merengue singer whose songs «La mantequilla», «El loco», «No me quiero enamorar» and «Tu vigilante enamorado» made him a figure of the street-merengue wave of the 2000s.

**Groups and orchestras**

He began in music at thirteen, singing in a string of groups that included «Cherry Banda», «Choboys», «Los Trotamundos», «Karina La Jefa», Rikarena, the orchestra of Kinito Méndez, «Merengada», «Árabe Manía», «Rico Mambo» and «Swing Divino». In 2005 he launched his own solo project.

**Solo career**

As a soloist he recorded the compilations «El Concepto» and «El Concepto 2.0» and, at the end of 2024, «El Concepto, Vol. 3», seven songs of merengue and bachata released under the label «JAB Latin Music». He lived in Greensboro, North Carolina, where he played events, and in 2025 he was recording new songs for his YouTube channel, among them «Aventura».

**The 2012 case**

In 2012 he was detained in Santo Domingo at the request of the United States, where a federal court in North Carolina had opened a case against him. He was released after eleven months, and the American authorities did not continue the proceeding.

**Death**

He died in the early hours of 11 May 2025, at 44, in a head-on collision on a highway in North Carolina.

**Legacy**

Colleagues reacted publicly to the news; Kinito Méndez, in whose orchestra he had worked, lamented his death.' WHERE slug = 'franklin-the-boss';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Franklin the Boss —José Altagracia de León Corcino, nacido el 21 de octubre de 1980 en Guayabal, Azua, y fallecido el 11 de mayo de 2025— fue un cantante dominicano de merengue cuyas canciones «La mantequilla», «El loco», «No me quiero enamorar» y «Tu vigilante enamorado» lo convirtieron en una figura de la ola del merengue de calle de los años 2000."}]},{"type":"paragraph","content":[{"type":"text","text":"Agrupaciones y orquestas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó en la música a los trece años, cantando en una serie de agrupaciones entre las que estuvieron «Cherry Banda», «Choboys», «Los Trotamundos», «Karina La Jefa», "},{"type":"artistReference","attrs":{"occurrenceId":"c740955b-f785-4da9-9145-912957e6ffd0","artistId":"6fb949c4-2d6f-437f-8e7f-5f9efec847da","displayText":"Rikarena"}},{"type":"text","text":", la orquesta de "},{"type":"artistReference","attrs":{"occurrenceId":"c28c6494-f983-4434-8035-5d30401a658c","artistId":"c73737c2-0106-4a87-8dbe-5f1650d34342","displayText":"Kinito Méndez"}},{"type":"text","text":", «Merengada», «Árabe Manía», «Rico Mambo» y «Swing Divino». En 2005 lanzó su propio proyecto en solitario."}]},{"type":"paragraph","content":[{"type":"text","text":"Carrera en solitario","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Como solista grabó los recopilatorios «El Concepto» y «El Concepto 2.0» y, a finales de 2024, «El Concepto, Vol. 3», siete canciones de merengue y bachata editadas con el sello «JAB Latin Music». Vivía en Greensboro, Carolina del Norte, donde animaba eventos, y en 2025 grababa canciones nuevas para su canal de YouTube, entre ellas «Aventura»."}]},{"type":"paragraph","content":[{"type":"text","text":"El caso de 2012","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2012 fue detenido en Santo Domingo a petición de Estados Unidos, donde un tribunal federal de Carolina del Norte había abierto un caso en su contra. Quedó libre a los once meses y las autoridades estadounidenses no continuaron el proceso."}]},{"type":"paragraph","content":[{"type":"text","text":"Muerte","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Murió en la madrugada del 11 de mayo de 2025, a los 44 años, en un choque frontal en una carretera de Carolina del Norte."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Colegas reaccionaron públicamente a la noticia; "},{"type":"artistReference","attrs":{"occurrenceId":"b59aec53-386f-4c7b-bfe4-1b9c65c782db","artistId":"c73737c2-0106-4a87-8dbe-5f1650d34342","displayText":"Kinito Méndez"}},{"type":"text","text":", en cuya orquesta trabajó, lamentó su muerte."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'franklin-the-boss'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'franklin-the-boss' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c740955b-f785-4da9-9145-912957e6ffd0', 'artist', '6fb949c4-2d6f-437f-8e7f-5f9efec847da' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'franklin-the-boss' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c28c6494-f983-4434-8035-5d30401a658c', 'artist', 'c73737c2-0106-4a87-8dbe-5f1650d34342' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'franklin-the-boss' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'b59aec53-386f-4c7b-bfe4-1b9c65c782db', 'artist', 'c73737c2-0106-4a87-8dbe-5f1650d34342' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'franklin-the-boss' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Franklin the Boss —José Altagracia de León Corcino, nacido el 21 de octubre de 1980 en Guayabal, Azua, y fallecido el 11 de mayo de 2025— fue un cantante dominicano de merengue cuyas canciones «La mantequilla», «El loco», «No me quiero enamorar» y «Tu vigilante enamorado» lo convirtieron en una figura de la ola del merengue de calle de los años 2000.

**Agrupaciones y orquestas**

Empezó en la música a los trece años, cantando en una serie de agrupaciones entre las que estuvieron «Cherry Banda», «Choboys», «Los Trotamundos», «Karina La Jefa», Rikarena, la orquesta de Kinito Méndez, «Merengada», «Árabe Manía», «Rico Mambo» y «Swing Divino». En 2005 lanzó su propio proyecto en solitario.

**Carrera en solitario**

Como solista grabó los recopilatorios «El Concepto» y «El Concepto 2.0» y, a finales de 2024, «El Concepto, Vol. 3», siete canciones de merengue y bachata editadas con el sello «JAB Latin Music». Vivía en Greensboro, Carolina del Norte, donde animaba eventos, y en 2025 grababa canciones nuevas para su canal de YouTube, entre ellas «Aventura».

**El caso de 2012**

En 2012 fue detenido en Santo Domingo a petición de Estados Unidos, donde un tribunal federal de Carolina del Norte había abierto un caso en su contra. Quedó libre a los once meses y las autoridades estadounidenses no continuaron el proceso.

**Muerte**

Murió en la madrugada del 11 de mayo de 2025, a los 44 años, en un choque frontal en una carretera de Carolina del Norte.

**Legado**

Colegas reaccionaron públicamente a la noticia; Kinito Méndez, en cuya orquesta trabajó, lamentó su muerte.' WHERE slug = 'franklin-the-boss';

COMMIT;
