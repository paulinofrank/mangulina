BEGIN;

-- Ficha de Darío Estrella.
--
-- La biografía de relleno hablaba en términos genéricos de su "enfoque del jazz latino" sin
-- nombrar una sola orquesta, colega, arreglo o año concreto. instruments añadido
-- (saxophone, piano), per su propio relato y la disambiguation de MusicBrainz.

UPDATE artists SET instruments = ARRAY['saxophone','piano']::text[] WHERE slug = 'dario-estrella';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Darío Estrella is a Dominican pianist, saxophonist, composer and arranger, born in 1951, whose career has moved between Dominican merengue and the New York and Puerto Rico salsa and jazz circuits for more than five decades."}]},{"type":"paragraph","content":[{"type":"text","text":"From merengue orchestras to Miguelito Valdez","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Raised in Valverde Mao within reach of Cuban radio signals, he took up saxophone as a boy and was playing professionally in orchestras by fourteen. His first arranging credit, in 1969, was for the Cuban singer Miguelito Valdez, at the request of bandleader Papa Molina — Valdez praised the results for sounding authentically Cuban."}]},{"type":"paragraph","content":[{"type":"text","text":"New York","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He emigrated to New York in the 1970s, where he played alongside Mario Bauzá, Tito Puente, La Sonora Matancera backing Celia Cruz, Ismael Rivera y Los Cachimbos, and Joe Cuba’s band fronted by Cheo Feliciano."}]},{"type":"paragraph","content":[{"type":"text","text":"«Merengue-Jazz» and Fania","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1976, Fania Records brought him in to record a merengue-jazz arrangement he had written four years earlier; "},{"type":"artistReference","attrs":{"occurrenceId":"2b4c40b9-44c7-4e39-8ff2-0f30f0b2c7ed","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":" had heard it and included it on his LP «Punto y Aparte». Estrella went on to originate a run of merengue fusions — merengue-jazz, merengue-hustle, merengue-funky — years before such crossovers became common."}]},{"type":"paragraph","content":[{"type":"text","text":"Puerto Rico and «Batacumbele»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Moving to Puerto Rico in 1980, he arranged and directed for the Peruvian bandleader Tito Suviaga’s orchestra, working alongside Charlie Palmieri, Cortijo and Juancito Torres, and played with the storied group Batacumbele alongside percussionists Cachete Maldonado and Giovanni Hidalgo."}]},{"type":"paragraph","content":[{"type":"text","text":"Back home","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In the 1990s he reunited with the Dominican salsa musician "},{"type":"artistReference","attrs":{"occurrenceId":"a7e9f906-a831-4715-aaae-4838aa72d349","artistId":"f8531cdb-3d19-4dd2-9ec1-a49dc5516252","displayText":"José Bello"}},{"type":"text","text":", releasing «Merengue-Jazz & Capricornio» through BMG. In 2014 he composed and premiered the symphonic-choral work «Duarte y Los Trinitarios» at Santo Domingo’s Teatro Nacional in honor of independence leader Juan Pablo Duarte, following it with a companion piece for Duarte’s 2018 bicentennial."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"From a teenage saxophonist in Cibao dance bands to an arranger trusted by some of the biggest names in New York and Puerto Rican salsa, Darío Estrella built a career on proving that Dominican merengue could hold its own inside jazz’s harmonic language."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dario-estrella'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'dario-estrella' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2b4c40b9-44c7-4e39-8ff2-0f30f0b2c7ed', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dario-estrella' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a7e9f906-a831-4715-aaae-4838aa72d349', 'artist', 'f8531cdb-3d19-4dd2-9ec1-a49dc5516252' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dario-estrella' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Darío Estrella is a Dominican pianist, saxophonist, composer and arranger, born in 1951, whose career has moved between Dominican merengue and the New York and Puerto Rico salsa and jazz circuits for more than five decades.

**From merengue orchestras to Miguelito Valdez**

Raised in Valverde Mao within reach of Cuban radio signals, he took up saxophone as a boy and was playing professionally in orchestras by fourteen. His first arranging credit, in 1969, was for the Cuban singer Miguelito Valdez, at the request of bandleader Papa Molina — Valdez praised the results for sounding authentically Cuban.

**New York**

He emigrated to New York in the 1970s, where he played alongside Mario Bauzá, Tito Puente, La Sonora Matancera backing Celia Cruz, Ismael Rivera y Los Cachimbos, and Joe Cuba’s band fronted by Cheo Feliciano.

**«Merengue-Jazz» and Fania**

In 1976, Fania Records brought him in to record a merengue-jazz arrangement he had written four years earlier; Wilfrido Vargas had heard it and included it on his LP «Punto y Aparte». Estrella went on to originate a run of merengue fusions — merengue-jazz, merengue-hustle, merengue-funky — years before such crossovers became common.

**Puerto Rico and «Batacumbele»**

Moving to Puerto Rico in 1980, he arranged and directed for the Peruvian bandleader Tito Suviaga’s orchestra, working alongside Charlie Palmieri, Cortijo and Juancito Torres, and played with the storied group Batacumbele alongside percussionists Cachete Maldonado and Giovanni Hidalgo.

**Back home**

In the 1990s he reunited with the Dominican salsa musician José Bello, releasing «Merengue-Jazz & Capricornio» through BMG. In 2014 he composed and premiered the symphonic-choral work «Duarte y Los Trinitarios» at Santo Domingo’s Teatro Nacional in honor of independence leader Juan Pablo Duarte, following it with a companion piece for Duarte’s 2018 bicentennial.

**Legacy**

From a teenage saxophonist in Cibao dance bands to an arranger trusted by some of the biggest names in New York and Puerto Rican salsa, Darío Estrella built a career on proving that Dominican merengue could hold its own inside jazz’s harmonic language.' WHERE slug = 'dario-estrella';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Darío Estrella es pianista, saxofonista, compositor y arreglista dominicano, nacido en 1951, cuya carrera se ha movido entre el merengue dominicano y los circuitos de salsa y jazz de Nueva York y Puerto Rico durante más de cinco décadas."}]},{"type":"paragraph","content":[{"type":"text","text":"De las orquestas de merengue a Miguelito Valdez","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Criado en Valverde Mao, al alcance de las señales de radio cubanas, empezó con el saxofón de niño y ya a los catorce años tocaba profesionalmente en orquestas. Su primer crédito como arreglista, en 1969, fue para el cantante cubano Miguelito Valdez, a pedido del director Papa Molina; Valdez elogió el resultado por sonar auténticamente cubano."}]},{"type":"paragraph","content":[{"type":"text","text":"Nueva York","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Emigró a Nueva York en los años setenta, donde tocó junto a Mario Bauzá, Tito Puente, La Sonora Matancera respaldando a Celia Cruz, Ismael Rivera y Los Cachimbos, y la banda de Joe Cuba con Cheo Feliciano al frente."}]},{"type":"paragraph","content":[{"type":"text","text":"«Merengue-Jazz» y Fania","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1976, Fania Records lo llamó a grabar un arreglo de merengue-jazz que había escrito cuatro años antes; "},{"type":"artistReference","attrs":{"occurrenceId":"1384ed64-7e21-4361-8057-c741c3482b75","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":" lo había escuchado y lo incluyó en su LP «Punto y Aparte». Estrella siguió creando una serie de fusiones del merengue —merengue-jazz, merengue-hustle, merengue-funky— años antes de que ese tipo de cruces se volviera común."}]},{"type":"paragraph","content":[{"type":"text","text":"Puerto Rico y «Batacumbele»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Al mudarse a Puerto Rico en 1980, arregló y dirigió para la orquesta del director peruano Tito Suviaga, trabajando junto a Charlie Palmieri, Cortijo y Juancito Torres, y tocó con el legendario grupo Batacumbele junto a los percusionistas Cachete Maldonado y Giovanni Hidalgo."}]},{"type":"paragraph","content":[{"type":"text","text":"De vuelta en casa","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En los años noventa se reencontró con el salsero dominicano "},{"type":"artistReference","attrs":{"occurrenceId":"61b710e5-b221-4a75-9326-d2999273b9a3","artistId":"f8531cdb-3d19-4dd2-9ec1-a49dc5516252","displayText":"José Bello"}},{"type":"text","text":", con quien publicó «Merengue-Jazz & Capricornio» a través de BMG. En 2014 compuso y estrenó la obra sinfónico-coral «Duarte y Los Trinitarios» en el Teatro Nacional de Santo Domingo en homenaje al prócer Juan Pablo Duarte, seguida de una pieza complementaria para el bicentenario de Duarte en 2018."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De saxofonista adolescente en las bandas de baile del Cibao a arreglista de confianza de algunos de los nombres más grandes de la salsa neoyorquina y puertorriqueña, Darío Estrella construyó una carrera demostrando que el merengue dominicano podía sostenerse por sí solo dentro del lenguaje armónico del jazz."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dario-estrella'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'dario-estrella' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1384ed64-7e21-4361-8057-c741c3482b75', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dario-estrella' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '61b710e5-b221-4a75-9326-d2999273b9a3', 'artist', 'f8531cdb-3d19-4dd2-9ec1-a49dc5516252' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'dario-estrella' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Darío Estrella es pianista, saxofonista, compositor y arreglista dominicano, nacido en 1951, cuya carrera se ha movido entre el merengue dominicano y los circuitos de salsa y jazz de Nueva York y Puerto Rico durante más de cinco décadas.

**De las orquestas de merengue a Miguelito Valdez**

Criado en Valverde Mao, al alcance de las señales de radio cubanas, empezó con el saxofón de niño y ya a los catorce años tocaba profesionalmente en orquestas. Su primer crédito como arreglista, en 1969, fue para el cantante cubano Miguelito Valdez, a pedido del director Papa Molina; Valdez elogió el resultado por sonar auténticamente cubano.

**Nueva York**

Emigró a Nueva York en los años setenta, donde tocó junto a Mario Bauzá, Tito Puente, La Sonora Matancera respaldando a Celia Cruz, Ismael Rivera y Los Cachimbos, y la banda de Joe Cuba con Cheo Feliciano al frente.

**«Merengue-Jazz» y Fania**

En 1976, Fania Records lo llamó a grabar un arreglo de merengue-jazz que había escrito cuatro años antes; Wilfrido Vargas lo había escuchado y lo incluyó en su LP «Punto y Aparte». Estrella siguió creando una serie de fusiones del merengue —merengue-jazz, merengue-hustle, merengue-funky— años antes de que ese tipo de cruces se volviera común.

**Puerto Rico y «Batacumbele»**

Al mudarse a Puerto Rico en 1980, arregló y dirigió para la orquesta del director peruano Tito Suviaga, trabajando junto a Charlie Palmieri, Cortijo y Juancito Torres, y tocó con el legendario grupo Batacumbele junto a los percusionistas Cachete Maldonado y Giovanni Hidalgo.

**De vuelta en casa**

En los años noventa se reencontró con el salsero dominicano José Bello, con quien publicó «Merengue-Jazz & Capricornio» a través de BMG. En 2014 compuso y estrenó la obra sinfónico-coral «Duarte y Los Trinitarios» en el Teatro Nacional de Santo Domingo en homenaje al prócer Juan Pablo Duarte, seguida de una pieza complementaria para el bicentenario de Duarte en 2018.

**Legado**

De saxofonista adolescente en las bandas de baile del Cibao a arreglista de confianza de algunos de los nombres más grandes de la salsa neoyorquina y puertorriqueña, Darío Estrella construyó una carrera demostrando que el merengue dominicano podía sostenerse por sí solo dentro del lenguaje armónico del jazz.' WHERE slug = 'dario-estrella';

COMMIT;
