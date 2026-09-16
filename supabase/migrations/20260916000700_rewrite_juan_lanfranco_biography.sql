BEGIN;

-- Ficha de Juan Lanfranco.
--
-- La biografía de relleno era genérica, sin nombrar canción, colaborador ni hecho alguno de
-- su carrera.
-- birth_year/date_of_birth añadidos (1951-11-24). middle_name añadido (de la Cruz).
-- birth_place/province corregidos de Santo Domingo/Distrito Nacional a Cotuí/Sánchez
-- Ramírez.

UPDATE artists SET birth_year = 1951, date_of_birth = '1951-11-24', middle_name = 'de la Cruz',
       birth_place = 'Cotuí', province = 'Sánchez Ramírez'
       WHERE slug = 'juan-lanfranco';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Lanfranco —full name Juan De La Cruz Lanfranco, born in Cotuí, Sánchez Ramírez, on 24 November 1951, died in Santo Domingo on 12 November 2018— was a Dominican balada singer and one of the era’s most prolific songwriters for other artists, best remembered for «El Amor Es Libre»."}]},{"type":"paragraph","content":[{"type":"text","text":"A stand-in who stayed","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As a boy in Cotuí he happened to pass by a rehearsal of La Orquesta Universal, directed by the trumpeter and teacher Miguel Emilio Peña, just as its lead singer had failed to show up; asked to fill in, he left everyone in awe. He went on to study singing and composition locally and later at the National Conservatory of Music, and recorded his first song, the self-written «Aunque Tú Te Vayas», with the same orchestra, before also performing in programs alongside "},{"type":"artistReference","attrs":{"occurrenceId":"d89ec158-7cf4-48ac-aba3-82fbbd7f0178","artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"New York, and the first Dominican at Madison Square Garden","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He moved to New York in 1974, recording five albums with Primitivo Santos’s orchestra; his album «Poema» earned him a gold record, presented to him at Madison Square Garden, making him the first Dominican artist to perform on that stage. He later also played with José Meriño’s orchestra."}]},{"type":"paragraph","content":[{"type":"text","text":"«El Amor Es Libre», Argentina and Mexico","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Going solo, he recorded what became arguably his most important song, «El Amor Es Libre», while in Argentina, earning recognition across Latin America. In Mexico he built connections with José José and Juan Gabriel, an experience that inspired «Delirante Amor» — a hit for both "},{"type":"artistReference","attrs":{"occurrenceId":"8c85d6cc-4d93-41d2-8675-acacf7befc40","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":" and himself — and «Te Siento». After a brief stay in Spain, he returned to the Dominican Republic in the early 1980s to introduce his catalogue to his own country."}]},{"type":"paragraph","content":[{"type":"text","text":"A songwriter for others","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As a composer he wrote hits for other artists, including "},{"type":"artistReference","attrs":{"occurrenceId":"fa2cc752-2c70-458b-8bde-c0abe6fc8bc0","artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada"}},{"type":"text","text":"’s «Tengo Derecho», "},{"type":"artistReference","attrs":{"occurrenceId":"35314a3d-85a2-4bcb-8585-b72a653cde98","artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura"}},{"type":"text","text":"’s «El Cachimbito», "},{"type":"artistReference","attrs":{"occurrenceId":"0ff49cae-23ed-48a9-a430-ee08a7d8160a","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":"’s «La Carta», and "},{"type":"artistReference","attrs":{"occurrenceId":"e58d0344-564a-4255-aa54-11f3afde7e90","artistId":"faf3e4cb-808e-419c-87ff-5126eed85e73","displayText":"Raulín Rosendo"}},{"type":"text","text":"’s «Llegó la Ley»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Despite his success, Lanfranco kept a reputation for humility, known to sit and talk with anyone in his hometown streets. In his final years he suffered from bronchopneumonia, heart problems and diabetes, and was reportedly turned away from several Santo Domingo hospitals for lacking health insurance before being treated at a private clinic in October 2017. He died of pulmonary edema on 12 November 2018 at the Francisco Moscoso Puello Hospital in Santo Domingo, and Cotuí’s municipal council declared two days of mourning."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-lanfranco'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-lanfranco' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd89ec158-7cf4-48ac-aba3-82fbbd7f0178', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-lanfranco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '8c85d6cc-4d93-41d2-8675-acacf7befc40', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-lanfranco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'fa2cc752-2c70-458b-8bde-c0abe6fc8bc0', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-lanfranco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '35314a3d-85a2-4bcb-8585-b72a653cde98', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-lanfranco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '0ff49cae-23ed-48a9-a430-ee08a7d8160a', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-lanfranco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'e58d0344-564a-4255-aa54-11f3afde7e90', 'artist', 'faf3e4cb-808e-419c-87ff-5126eed85e73' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-lanfranco' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Juan Lanfranco —full name Juan De La Cruz Lanfranco, born in Cotuí, Sánchez Ramírez, on 24 November 1951, died in Santo Domingo on 12 November 2018— was a Dominican balada singer and one of the era’s most prolific songwriters for other artists, best remembered for «El Amor Es Libre».

**A stand-in who stayed**

As a boy in Cotuí he happened to pass by a rehearsal of La Orquesta Universal, directed by the trumpeter and teacher Miguel Emilio Peña, just as its lead singer had failed to show up; asked to fill in, he left everyone in awe. He went on to study singing and composition locally and later at the National Conservatory of Music, and recorded his first song, the self-written «Aunque Tú Te Vayas», with the same orchestra, before also performing in programs alongside Rafael Solano.

**New York, and the first Dominican at Madison Square Garden**

He moved to New York in 1974, recording five albums with Primitivo Santos’s orchestra; his album «Poema» earned him a gold record, presented to him at Madison Square Garden, making him the first Dominican artist to perform on that stage. He later also played with José Meriño’s orchestra.

**«El Amor Es Libre», Argentina and Mexico**

Going solo, he recorded what became arguably his most important song, «El Amor Es Libre», while in Argentina, earning recognition across Latin America. In Mexico he built connections with José José and Juan Gabriel, an experience that inspired «Delirante Amor» — a hit for both Fernando Villalona and himself — and «Te Siento». After a brief stay in Spain, he returned to the Dominican Republic in the early 1980s to introduce his catalogue to his own country.

**A songwriter for others**

As a composer he wrote hits for other artists, including Milly Quezada’s «Tengo Derecho», Johnny Ventura’s «El Cachimbito», Wilfrido Vargas’s «La Carta», and Raulín Rosendo’s «Llegó la Ley».

**Legacy**

Despite his success, Lanfranco kept a reputation for humility, known to sit and talk with anyone in his hometown streets. In his final years he suffered from bronchopneumonia, heart problems and diabetes, and was reportedly turned away from several Santo Domingo hospitals for lacking health insurance before being treated at a private clinic in October 2017. He died of pulmonary edema on 12 November 2018 at the Francisco Moscoso Puello Hospital in Santo Domingo, and Cotuí’s municipal council declared two days of mourning.' WHERE slug = 'juan-lanfranco';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Lanfranco —nombre completo Juan De La Cruz Lanfranco, nacido en Cotuí, Sánchez Ramírez, el 24 de noviembre de 1951, fallecido en Santo Domingo el 12 de noviembre de 2018— fue cantante dominicano de balada y uno de los compositores más prolíficos de su época para otros artistas, recordado sobre todo por «El Amor Es Libre»."}]},{"type":"paragraph","content":[{"type":"text","text":"Un suplente que se quedó","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De niño en Cotuí pasaba por casualidad frente a un ensayo de La Orquesta Universal, dirigida por el trompetista y profesor Miguel Emilio Peña, justo cuando su cantante principal no se había presentado; al pedirle que lo sustituyera, dejó a todos maravillados. Estudió canto y composición en su pueblo y luego en el Conservatorio Nacional de Música, y grabó su primera canción, la propia «Aunque Tú Te Vayas», con esa misma orquesta, antes de participar también en programas junto a "},{"type":"artistReference","attrs":{"occurrenceId":"1a58d475-2798-4ad0-9cc0-41b933443c02","artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Nueva York, y el primer dominicano en el Madison Square Garden","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Se trasladó a Nueva York en 1974, donde grabó cinco discos con la orquesta de Primitivo Santos; su álbum «Poema» le valió un disco de oro, entregado en el Madison Square Garden, con lo que se convirtió en el primer artista dominicano en pisar ese escenario. Más tarde militó también en la orquesta de José Meriño."}]},{"type":"paragraph","content":[{"type":"text","text":"«El Amor Es Libre», Argentina y México","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ya como solista, grabó en Argentina la que sería quizás su canción más importante, «El Amor Es Libre», que le mereció reconocimiento en todo el continente. En México hizo contactos con José José y Juan Gabriel, experiencia que inspiró «Delirante Amor» —éxito tanto para "},{"type":"artistReference","attrs":{"occurrenceId":"f7519dc4-8be5-48b3-9638-9531f5eebb1b","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":" como para él mismo— y «Te Siento». Tras una breve estadía en España, regresó a República Dominicana a inicios de los años ochenta para dar a conocer su catálogo en su propio país."}]},{"type":"paragraph","content":[{"type":"text","text":"Compositor para otros","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Como compositor escribió éxitos para otros artistas, entre ellos «Tengo Derecho» de "},{"type":"artistReference","attrs":{"occurrenceId":"831402a1-bfb2-4c9b-b911-052667373496","artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada"}},{"type":"text","text":", «El Cachimbito» de "},{"type":"artistReference","attrs":{"occurrenceId":"2e95fbfc-6796-4068-a389-4714940eae53","artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura"}},{"type":"text","text":", «La Carta» de "},{"type":"artistReference","attrs":{"occurrenceId":"6dceefb8-f0b6-41ed-a652-2cba8ced5b21","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":", y «Llegó la Ley» de "},{"type":"artistReference","attrs":{"occurrenceId":"bc44f07f-73dc-455d-adcd-288fbca4d0b2","artistId":"faf3e4cb-808e-419c-87ff-5126eed85e73","displayText":"Raulín Rosendo"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A pesar de su éxito, Lanfranco mantuvo fama de humilde, capaz de sentarse a conversar con cualquiera en las calles de su pueblo. En sus últimos años padeció bronconeumonía, problemas cardíacos y diabetes, y según se reportó fue rechazado en varios hospitales de Santo Domingo por no tener seguro médico, antes de ser atendido en un centro privado en octubre de 2017. Murió de un edema pulmonar el 12 de noviembre de 2018 en el hospital Francisco Moscoso Puello de Santo Domingo, y el ayuntamiento de Cotuí declaró dos días de duelo."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-lanfranco'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-lanfranco' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '1a58d475-2798-4ad0-9cc0-41b933443c02', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-lanfranco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'f7519dc4-8be5-48b3-9638-9531f5eebb1b', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-lanfranco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '831402a1-bfb2-4c9b-b911-052667373496', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-lanfranco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '2e95fbfc-6796-4068-a389-4714940eae53', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-lanfranco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '6dceefb8-f0b6-41ed-a652-2cba8ced5b21', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-lanfranco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'bc44f07f-73dc-455d-adcd-288fbca4d0b2', 'artist', 'faf3e4cb-808e-419c-87ff-5126eed85e73' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'juan-lanfranco' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Juan Lanfranco —nombre completo Juan De La Cruz Lanfranco, nacido en Cotuí, Sánchez Ramírez, el 24 de noviembre de 1951, fallecido en Santo Domingo el 12 de noviembre de 2018— fue cantante dominicano de balada y uno de los compositores más prolíficos de su época para otros artistas, recordado sobre todo por «El Amor Es Libre».

**Un suplente que se quedó**

De niño en Cotuí pasaba por casualidad frente a un ensayo de La Orquesta Universal, dirigida por el trompetista y profesor Miguel Emilio Peña, justo cuando su cantante principal no se había presentado; al pedirle que lo sustituyera, dejó a todos maravillados. Estudió canto y composición en su pueblo y luego en el Conservatorio Nacional de Música, y grabó su primera canción, la propia «Aunque Tú Te Vayas», con esa misma orquesta, antes de participar también en programas junto a Rafael Solano.

**Nueva York, y el primer dominicano en el Madison Square Garden**

Se trasladó a Nueva York en 1974, donde grabó cinco discos con la orquesta de Primitivo Santos; su álbum «Poema» le valió un disco de oro, entregado en el Madison Square Garden, con lo que se convirtió en el primer artista dominicano en pisar ese escenario. Más tarde militó también en la orquesta de José Meriño.

**«El Amor Es Libre», Argentina y México**

Ya como solista, grabó en Argentina la que sería quizás su canción más importante, «El Amor Es Libre», que le mereció reconocimiento en todo el continente. En México hizo contactos con José José y Juan Gabriel, experiencia que inspiró «Delirante Amor» —éxito tanto para Fernando Villalona como para él mismo— y «Te Siento». Tras una breve estadía en España, regresó a República Dominicana a inicios de los años ochenta para dar a conocer su catálogo en su propio país.

**Compositor para otros**

Como compositor escribió éxitos para otros artistas, entre ellos «Tengo Derecho» de Milly Quezada, «El Cachimbito» de Johnny Ventura, «La Carta» de Wilfrido Vargas, y «Llegó la Ley» de Raulín Rosendo.

**Legado**

A pesar de su éxito, Lanfranco mantuvo fama de humilde, capaz de sentarse a conversar con cualquiera en las calles de su pueblo. En sus últimos años padeció bronconeumonía, problemas cardíacos y diabetes, y según se reportó fue rechazado en varios hospitales de Santo Domingo por no tener seguro médico, antes de ser atendido en un centro privado en octubre de 2017. Murió de un edema pulmonar el 12 de noviembre de 2018 en el hospital Francisco Moscoso Puello de Santo Domingo, y el ayuntamiento de Cotuí declaró dos días de duelo.' WHERE slug = 'juan-lanfranco';

COMMIT;
