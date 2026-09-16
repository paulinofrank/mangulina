BEGIN;

-- Ficha de Alex Díaz.
--
-- La biografía de relleno se contradecía a sí misma: decía que nació en San Francisco de
-- Macorís cuando la propia fila ya tenía correctamente birth_place='Baní'. instruments
-- ampliado con tambora.

UPDATE artists SET instruments = ARRAY['congas','tambora']::text[] WHERE slug = 'alex-diaz';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"José Alexis «Alex» Díaz is a Dominican conguero from Baní, known in his career’s later years as «the Master of Merengue Jazz», one of the New York Latin jazz scene’s most in-demand percussionists."}]},{"type":"paragraph","content":[{"type":"text","text":"From Baní to Los Juveniles del Sabor","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"At sixteen he was already playing with Los Juveniles del Sabor, a band whose lineup at the time featured the future stars "},{"type":"artistReference","attrs":{"occurrenceId":"c5d8b0aa-ec04-4173-a2f0-5e974d7778a1","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"fa828a92-df1b-4b36-8404-a05f1f39d9a8","artistId":"e5129444-0923-4e06-b77d-f82f14c02b7d","displayText":"Aramis Camilo"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"New York","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He moved to New York in 1980 and joined pianist Hilton Ruiz’s band, quickly establishing himself as one of the city’s top conga players. The invitations that followed included stints with Tito Puente, Chucho Valdés, Mario Bauzá’s Afro-Cuban Band, Dizzy Gillespie’s United Nations Orchestra, Xavier Cugat, Celia Cruz, Alfredo «Chocolate» Armenteros and fellow Dominican "},{"type":"artistReference","attrs":{"occurrenceId":"73e2a02f-c0b7-4276-b720-01f18620dc63","artistId":"f0a5c773-b904-4feb-bf20-9d938bead0b1","displayText":"Mario Rivera"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Number Seven»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2013 he released «Number Seven» on his own label, Bani Music, named for his hometown; the album’s «Son Pa Bani» paid it direct tribute. Reviewing it for Latin Jazz Network, critic Raul Da Gama called Díaz «a wonderful rhythmist», «stylish to the point of being hip», praising an approach he described as painterly, drawing on rustic, earthen tones across the record’s Latin jazz and Afro-Cuban repertoire."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"From a teenage sideman in a Dominican dance band to a first-call conguero across four decades of New York Latin jazz, Alex Díaz carried the rhythms of his hometown into rooms that included some of the genre’s most demanding bandleaders."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alex-diaz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'alex-diaz' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c5d8b0aa-ec04-4173-a2f0-5e974d7778a1', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-diaz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'fa828a92-df1b-4b36-8404-a05f1f39d9a8', 'artist', 'e5129444-0923-4e06-b77d-f82f14c02b7d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-diaz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '73e2a02f-c0b7-4276-b720-01f18620dc63', 'artist', 'f0a5c773-b904-4feb-bf20-9d938bead0b1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-diaz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'José Alexis «Alex» Díaz is a Dominican conguero from Baní, known in his career’s later years as «the Master of Merengue Jazz», one of the New York Latin jazz scene’s most in-demand percussionists.

**From Baní to Los Juveniles del Sabor**

At sixteen he was already playing with Los Juveniles del Sabor, a band whose lineup at the time featured the future stars Rubby Pérez and Aramis Camilo.

**New York**

He moved to New York in 1980 and joined pianist Hilton Ruiz’s band, quickly establishing himself as one of the city’s top conga players. The invitations that followed included stints with Tito Puente, Chucho Valdés, Mario Bauzá’s Afro-Cuban Band, Dizzy Gillespie’s United Nations Orchestra, Xavier Cugat, Celia Cruz, Alfredo «Chocolate» Armenteros and fellow Dominican Mario Rivera.

**«Number Seven»**

In 2013 he released «Number Seven» on his own label, Bani Music, named for his hometown; the album’s «Son Pa Bani» paid it direct tribute. Reviewing it for Latin Jazz Network, critic Raul Da Gama called Díaz «a wonderful rhythmist», «stylish to the point of being hip», praising an approach he described as painterly, drawing on rustic, earthen tones across the record’s Latin jazz and Afro-Cuban repertoire.

**Legacy**

From a teenage sideman in a Dominican dance band to a first-call conguero across four decades of New York Latin jazz, Alex Díaz carried the rhythms of his hometown into rooms that included some of the genre’s most demanding bandleaders.' WHERE slug = 'alex-diaz';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"José Alexis «Alex» Díaz es conguero dominicano de Baní, conocido en la etapa posterior de su carrera como «el Maestro del Merengue Jazz», uno de los percusionistas más solicitados de la escena de jazz latino de Nueva York."}]},{"type":"paragraph","content":[{"type":"text","text":"De Baní a Los Juveniles del Sabor","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A los dieciséis años ya tocaba con Los Juveniles del Sabor, una agrupación cuya alineación de entonces incluía a los entonces futuros astros "},{"type":"artistReference","attrs":{"occurrenceId":"fe340851-4043-45c8-adc6-3ce6a9f7d213","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"99bead60-bd06-4679-9bfb-d051fbdde4c4","artistId":"e5129444-0923-4e06-b77d-f82f14c02b7d","displayText":"Aramis Camilo"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Nueva York","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Se mudó a Nueva York en 1980 y se integró a la banda del pianista Hilton Ruiz, consolidándose rápidamente como uno de los mejores congueros de la ciudad. Las invitaciones que siguieron incluyeron pasos por las filas de Tito Puente, Chucho Valdés, la Afro-Cuban Band de Mario Bauzá, la United Nations Orchestra de Dizzy Gillespie, Xavier Cugat, Celia Cruz, Alfredo «Chocolate» Armenteros y su compatriota "},{"type":"artistReference","attrs":{"occurrenceId":"d7939508-28fd-4d8e-95bd-a15a1488d368","artistId":"f0a5c773-b904-4feb-bf20-9d938bead0b1","displayText":"Mario Rivera"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Number Seven»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2013 publicó «Number Seven» bajo su propio sello, Bani Music, en honor a su ciudad natal; el tema «Son Pa Bani» del disco le rindió tributo directo. Al reseñarlo para Latin Jazz Network, el crítico Raul Da Gama llamó a Díaz «un maravilloso ritmista», «elegante al punto de resultar hip», elogiando un enfoque que describió como pictórico, con tonos rústicos y terrosos a lo largo del repertorio de jazz latino y afrocubano del disco."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De sideman adolescente en una banda de baile dominicana a conguero de primera llamada durante cuatro décadas de jazz latino neoyorquino, Alex Díaz llevó los ritmos de su ciudad natal a escenarios que incluyeron a algunos de los directores de orquesta más exigentes del género."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alex-diaz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'alex-diaz' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'fe340851-4043-45c8-adc6-3ce6a9f7d213', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-diaz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '99bead60-bd06-4679-9bfb-d051fbdde4c4', 'artist', 'e5129444-0923-4e06-b77d-f82f14c02b7d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-diaz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd7939508-28fd-4d8e-95bd-a15a1488d368', 'artist', 'f0a5c773-b904-4feb-bf20-9d938bead0b1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-diaz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'José Alexis «Alex» Díaz es conguero dominicano de Baní, conocido en la etapa posterior de su carrera como «el Maestro del Merengue Jazz», uno de los percusionistas más solicitados de la escena de jazz latino de Nueva York.

**De Baní a Los Juveniles del Sabor**

A los dieciséis años ya tocaba con Los Juveniles del Sabor, una agrupación cuya alineación de entonces incluía a los entonces futuros astros Rubby Pérez y Aramis Camilo.

**Nueva York**

Se mudó a Nueva York en 1980 y se integró a la banda del pianista Hilton Ruiz, consolidándose rápidamente como uno de los mejores congueros de la ciudad. Las invitaciones que siguieron incluyeron pasos por las filas de Tito Puente, Chucho Valdés, la Afro-Cuban Band de Mario Bauzá, la United Nations Orchestra de Dizzy Gillespie, Xavier Cugat, Celia Cruz, Alfredo «Chocolate» Armenteros y su compatriota Mario Rivera.

**«Number Seven»**

En 2013 publicó «Number Seven» bajo su propio sello, Bani Music, en honor a su ciudad natal; el tema «Son Pa Bani» del disco le rindió tributo directo. Al reseñarlo para Latin Jazz Network, el crítico Raul Da Gama llamó a Díaz «un maravilloso ritmista», «elegante al punto de resultar hip», elogiando un enfoque que describió como pictórico, con tonos rústicos y terrosos a lo largo del repertorio de jazz latino y afrocubano del disco.

**Legado**

De sideman adolescente en una banda de baile dominicana a conguero de primera llamada durante cuatro décadas de jazz latino neoyorquino, Alex Díaz llevó los ritmos de su ciudad natal a escenarios que incluyeron a algunos de los directores de orquesta más exigentes del género.' WHERE slug = 'alex-diaz';

COMMIT;
