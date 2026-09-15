BEGIN;

-- Ficha de Manuel Sánchez Acosta.
--
-- La biografía de relleno lo describía en términos genéricos y calculaba mal su edad al
-- morir (92; murió a los 91, antes de cumplir 92 en agosto). date_of_birth: 18 de agosto de
-- 1914 (la fila decía 14; coinciden numerosas fuentes independientes en el 18). primary_role:
-- composer (decía singer; nunca fue intérprete). occupations: pianist. instruments: piano,
-- drums.

UPDATE artists SET date_of_birth = '1914-08-18', primary_role = 'composer',
       occupations = '["pianist"]'::jsonb, instruments = ARRAY['piano', 'drums']::text[] WHERE slug = 'manuel-sanchez-acosta';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manuel Sánchez Acosta — born 18 August 1914 in Santiago de los Caballeros, died 19 April 2006 — was a Dominican physician, pianist and composer whose double life put him at the source of some of the country’s best-known boleros and merengues without ever making him a performer in his own name."}]},{"type":"paragraph","content":[{"type":"text","text":"A doctor’s other calling","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He was already playing drums at eight, but built his working life as a physician, composing on the side. Writers who covered Dominican jazz later called him, without much exaggeration, the father of the country’s fusion between jazz and folklore, for the songs that bent his classical training toward its own popular material."}]},{"type":"paragraph","content":[{"type":"text","text":"«Ven», and the Orquesta Presidente Trujillo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1944 the singer Rafael Colón, newly signed to "},{"type":"artistReference","attrs":{"occurrenceId":"05e1af2d-9354-495b-ba9c-8611a01c8813","artistId":"360bec27-421a-466f-8604-3598aa46a7a4","displayText":"Luis Alberti"}},{"type":"text","text":"’s Orquesta Presidente Trujillo — the most prestigious dance band of its day — made his first-ever recording with the bolero «Ven», written by Sánchez Acosta."}]},{"type":"paragraph","content":[{"type":"text","text":"«Papá Bocó»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Two decades later he wrote «Papá Bocó» for "},{"type":"artistReference","attrs":{"occurrenceId":"d5bcc6a5-1643-4446-b094-cea9efd792c5","artistId":"8fc78100-e51e-48a8-91e9-3007f4c67ec0","displayText":"Félix del Rosario"}},{"type":"text","text":", whose Magos del Ritmo kept the merengue in its repertoire for years alongside «Víctor y Memelo», «Mal Pelao» and «La Caperucita»."}]},{"type":"paragraph","content":[{"type":"text","text":"A door onto television","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His reach went beyond songwriting: it was Sánchez Acosta, already an established composer in Dominican broadcasting, who brought a teenage "},{"type":"artistReference","attrs":{"occurrenceId":"41d07ace-8ae3-4289-8550-5824406a0a38","artistId":"1abe0eae-4c2d-4706-a210-b176b2dfe7b2","displayText":"Cecilia García"}},{"type":"text","text":" onto «La Taberna de Babín», the state-channel program that gave her career in television its start."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He died in 2006, at ninety-one, leaving a catalogue better known through the voices and orchestras that carried it than through his own name — the mark of a composer who worked from the wings."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manuel-sanchez-acosta'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manuel-sanchez-acosta' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '05e1af2d-9354-495b-ba9c-8611a01c8813', 'artist', '360bec27-421a-466f-8604-3598aa46a7a4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manuel-sanchez-acosta' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd5bcc6a5-1643-4446-b094-cea9efd792c5', 'artist', '8fc78100-e51e-48a8-91e9-3007f4c67ec0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manuel-sanchez-acosta' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '41d07ace-8ae3-4289-8550-5824406a0a38', 'artist', '1abe0eae-4c2d-4706-a210-b176b2dfe7b2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manuel-sanchez-acosta' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Manuel Sánchez Acosta — born 18 August 1914 in Santiago de los Caballeros, died 19 April 2006 — was a Dominican physician, pianist and composer whose double life put him at the source of some of the country’s best-known boleros and merengues without ever making him a performer in his own name.

**A doctor’s other calling**

He was already playing drums at eight, but built his working life as a physician, composing on the side. Writers who covered Dominican jazz later called him, without much exaggeration, the father of the country’s fusion between jazz and folklore, for the songs that bent his classical training toward its own popular material.

**«Ven», and the Orquesta Presidente Trujillo**

In 1944 the singer Rafael Colón, newly signed to Luis Alberti’s Orquesta Presidente Trujillo — the most prestigious dance band of its day — made his first-ever recording with the bolero «Ven», written by Sánchez Acosta.

**«Papá Bocó»**

Two decades later he wrote «Papá Bocó» for Félix del Rosario, whose Magos del Ritmo kept the merengue in its repertoire for years alongside «Víctor y Memelo», «Mal Pelao» and «La Caperucita».

**A door onto television**

His reach went beyond songwriting: it was Sánchez Acosta, already an established composer in Dominican broadcasting, who brought a teenage Cecilia García onto «La Taberna de Babín», the state-channel program that gave her career in television its start.

**Legacy**

He died in 2006, at ninety-one, leaving a catalogue better known through the voices and orchestras that carried it than through his own name — the mark of a composer who worked from the wings.' WHERE slug = 'manuel-sanchez-acosta';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manuel Sánchez Acosta —nacido el 18 de agosto de 1914 en Santiago de los Caballeros, fallecido el 19 de abril de 2006— fue un médico, pianista y compositor dominicano, cuya doble vida lo puso en el origen de algunos de los boleros y merengues más conocidos del país sin convertirlo nunca en intérprete de su propio nombre."}]},{"type":"paragraph","content":[{"type":"text","text":"El otro llamado de un médico","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A los ocho años ya tocaba la batería, pero construyó su vida de trabajo como médico, componiendo en paralelo. Quienes escribieron después sobre el jazz dominicano lo llamaron, sin mucha exageración, el padre de la fusión del país entre el jazz y el folclor, por las canciones que doblaban su formación clásica hacia su propio material popular."}]},{"type":"paragraph","content":[{"type":"text","text":"«Ven», y la Orquesta Presidente Trujillo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1944 el cantante Rafael Colón, recién contratado por la Orquesta Presidente Trujillo de "},{"type":"artistReference","attrs":{"occurrenceId":"9f0b9d8d-a211-4b2b-a326-acfb07428f9a","artistId":"360bec27-421a-466f-8604-3598aa46a7a4","displayText":"Luis Alberti"}},{"type":"text","text":" —la agrupación de baile más prestigiosa de su época—, hizo su primera grabación con el bolero «Ven», escrito por Sánchez Acosta."}]},{"type":"paragraph","content":[{"type":"text","text":"«Papá Bocó»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Dos décadas después escribió «Papá Bocó» para "},{"type":"artistReference","attrs":{"occurrenceId":"d2a4755b-c4de-4e1c-bd06-72c040c0d402","artistId":"8fc78100-e51e-48a8-91e9-3007f4c67ec0","displayText":"Félix del Rosario"}},{"type":"text","text":", cuyos Magos del Ritmo mantuvieron el merengue en su repertorio por años junto a «Víctor y Memelo», «Mal Pelao» y «La Caperucita»."}]},{"type":"paragraph","content":[{"type":"text","text":"Una puerta a la televisión","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su alcance iba más allá de componer: fue Sánchez Acosta, ya compositor establecido en la radiodifusión dominicana, quien llevó a una adolescente "},{"type":"artistReference","attrs":{"occurrenceId":"10220a34-1c46-4baf-8e71-2b630f03174a","artistId":"1abe0eae-4c2d-4706-a210-b176b2dfe7b2","displayText":"Cecilia García"}},{"type":"text","text":" a «La Taberna de Babín», el programa del canal estatal con el que empezó su carrera en televisión."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Murió en 2006, a los noventa y un años, dejando un catálogo más conocido por las voces y orquestas que lo llevaron que por su propio nombre —la marca de un compositor que trabajó desde bastidores."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manuel-sanchez-acosta'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manuel-sanchez-acosta' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9f0b9d8d-a211-4b2b-a326-acfb07428f9a', 'artist', '360bec27-421a-466f-8604-3598aa46a7a4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manuel-sanchez-acosta' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd2a4755b-c4de-4e1c-bd06-72c040c0d402', 'artist', '8fc78100-e51e-48a8-91e9-3007f4c67ec0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manuel-sanchez-acosta' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '10220a34-1c46-4baf-8e71-2b630f03174a', 'artist', '1abe0eae-4c2d-4706-a210-b176b2dfe7b2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manuel-sanchez-acosta' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Manuel Sánchez Acosta —nacido el 18 de agosto de 1914 en Santiago de los Caballeros, fallecido el 19 de abril de 2006— fue un médico, pianista y compositor dominicano, cuya doble vida lo puso en el origen de algunos de los boleros y merengues más conocidos del país sin convertirlo nunca en intérprete de su propio nombre.

**El otro llamado de un médico**

A los ocho años ya tocaba la batería, pero construyó su vida de trabajo como médico, componiendo en paralelo. Quienes escribieron después sobre el jazz dominicano lo llamaron, sin mucha exageración, el padre de la fusión del país entre el jazz y el folclor, por las canciones que doblaban su formación clásica hacia su propio material popular.

**«Ven», y la Orquesta Presidente Trujillo**

En 1944 el cantante Rafael Colón, recién contratado por la Orquesta Presidente Trujillo de Luis Alberti —la agrupación de baile más prestigiosa de su época—, hizo su primera grabación con el bolero «Ven», escrito por Sánchez Acosta.

**«Papá Bocó»**

Dos décadas después escribió «Papá Bocó» para Félix del Rosario, cuyos Magos del Ritmo mantuvieron el merengue en su repertorio por años junto a «Víctor y Memelo», «Mal Pelao» y «La Caperucita».

**Una puerta a la televisión**

Su alcance iba más allá de componer: fue Sánchez Acosta, ya compositor establecido en la radiodifusión dominicana, quien llevó a una adolescente Cecilia García a «La Taberna de Babín», el programa del canal estatal con el que empezó su carrera en televisión.

**Legado**

Murió en 2006, a los noventa y un años, dejando un catálogo más conocido por las voces y orquestas que lo llevaron que por su propio nombre —la marca de un compositor que trabajó desde bastidores.' WHERE slug = 'manuel-sanchez-acosta';

COMMIT;
