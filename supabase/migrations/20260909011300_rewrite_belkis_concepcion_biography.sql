BEGIN;

-- Ficha de Belkis Concepción: documentos editoriales en y es, referencias,
-- espejo legacy y la relación de fundación con Las Chicas del Can.
--
-- El relleno anterior en inglés no nombraba ni una vez a Las Chicas del Can:
-- la fundadora de la primera orquesta femenina de merengue del país, y su
-- ficha no mencionaba la orquesta.
--
-- Un Casandra "Revelación del Año" que Diario Libre documenta con foto de la
-- estatuilla queda sin registrar: ninguna fuente lo fecha.

-- 1. Relación de fundación
INSERT INTO artist_relationships (source_artist_id, target_artist_id, relationship_type, start_year, end_year, notes)
SELECT s.id, g.id, 'founder_of', 1976, NULL, 'Founded the ensemble as Las Muchachas in 1976; named Las Chicas del Can on air in 1981'
  FROM artists s, artists g
 WHERE s.slug = 'belkis-concepcion' AND g.slug = 'las-chicas-del-can'
   AND NOT EXISTS (SELECT 1 FROM artist_relationships r
                    WHERE r.source_artist_id = s.id AND r.target_artist_id = g.id
                      AND r.relationship_type = 'founder_of');

-- 2. Documentos editoriales, referencias y espejo markdown legacy
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Belkis María Concepción Hernández, known as Belkis Concepción, is a Dominican pianist, singer, arranger and bandleader, born in Santo Domingo on 20 June 1961. She founded "},{"type":"artistReference","attrs":{"occurrenceId":"24d861af-345c-4f92-9423-9e587c453833","artistId":"6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5","displayText":"Las Chicas del Can"}},{"type":"text","text":", the first all-female merengue orchestra in the Dominican Republic, and lost the name to her business partner while she was too ill to work. She has led orchestras of her own ever since."}]},{"type":"paragraph","content":[{"type":"text","text":"A question at nine","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Concepción was the daughter of Julio César Concepción Pacheco and María Hernández de Concepción. At nine she asked her mother why there were no all-female merengue orchestras, was told the work was too hard for women, and answered that she would form the first one. She took her bachillerato at the Colegio Santa Luisa de Marillac, studied piano at the Conservatorio Nacional de Música, and began a law degree at the Universidad Nacional Pedro Henríquez Ureña. While still at school she put together a band with classmates to play at its own functions."}]},{"type":"paragraph","content":[{"type":"text","text":"Las Muchachas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1976 she formed Las Muchachas, which worked private parties, social clubs and television. Three years later she started something more ambitious: a complete dance orchestra of women — trumpets and trombones, saxophone, bass, conga, tambora and the güira that became its signature — recruited largely from the Escuela Iris del Valle in Los Mina. Concepción directed it from the piano and keyboards, and "},{"type":"artistReference","attrs":{"occurrenceId":"eb05e93e-5dd2-4a41-8724-c787213ec10e","artistId":"8fc78100-e51e-48a8-91e9-3007f4c67ec0","displayText":"Félix del Rosario"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"c550c71c-f233-412d-9ba0-e447e2684704","artistId":"a56451fa-dccb-462f-9fdb-8cc8a576d6fb","displayText":"Bertico Sosa"}},{"type":"text","text":" helped as it took shape."}]},{"type":"paragraph","content":[{"type":"text","text":"Las Chicas del Can","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The orchestra debuted in 1981 on El Show del Mediodía, the television variety programme produced by "},{"type":"artistReference","attrs":{"occurrenceId":"86a31fab-4cc1-4636-85dc-eb2c4b531c27","artistId":"faff18bd-3dbc-477a-bc38-859d611887f0","displayText":"Yaqui Núñez del Risco"}},{"type":"text","text":", who named them Las Chicas del Can on air. They were billed as La Pionera Belkis Concepción y Las Chicas del Can. "},{"type":"artistReference","attrs":{"occurrenceId":"cd532cf1-6ab2-46d4-a7bb-f8a5399b6557","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":" came in as musical adviser and, from behind the scenes, shaped the group’s most successful years. The project had not been registered when the alliance was made, and it was put in his name."}]},{"type":"paragraph","content":[{"type":"text","text":"Concepción made \"La media María\", \"El higuerón\" and \"Comején\" popular with them, and took the orchestra to the United States, Venezuela, Puerto Rico, Colombia, Curaçao and Aruba."}]},{"type":"paragraph","content":[{"type":"text","text":"In 1985, six years after the orchestra first took shape, Guillain-Barré syndrome forced her to stop working. Vargas, who held the registration, kept the group and its players. She has said since that the name was taken while she was in bed, that having never registered it she had no way to hold it, and that she and Vargas nonetheless remained on good terms. Her place went to the group’s second vocalist, "},{"type":"artistReference","attrs":{"occurrenceId":"c8457337-40fc-4a90-927a-20921df6cb8f","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Her own orchestras","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"After recovering she returned with Belkis Concepción y su Orquesta, registered in her own name, which opened at the Maunaloa Night Club and Casino in Santo Domingo and went on to play France, the Netherlands, Spain, the United States and Côte d’Ivoire. \"La vecina\", \"Señora\", \"Luna mágica\" and \"El hombre que yo amo\" come from those years. She later assembled Belkis Concepción y las Estrellas del Merengue, with Dominican players alongside Colombians from Barranquilla."}]},{"type":"paragraph","content":[{"type":"text","text":"El Reencuentro","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"\"Las Chicas del Can: El Reencuentro\" brought former members of every era together at the Teatro La Fiesta of the Hotel Jaragua in October 2024, and returned to the same stage on 21 February 2025. Concepción, who had proposed the idea nine years earlier, said the singers who took part had acknowledged her as the founder of the movement. She continues to tour a Las Chicas del Can across Latin America — four dates in Costa Rica in May 2025 — and places the group’s fiftieth anniversary in 2026, counting from Las Muchachas in 1976. The Corporación Wilfrido Vargas has since stated that the name is its registered mark and requires prior authorisation; Concepción restated her own claim to have created the group on Color Visión in October 2025."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Concepción was the first woman in the Dominican Republic to assemble and direct a full merengue orchestra of women — not a vocal group with hired players, but an ensemble whose horns and percussion were women as well. The orchestra she founded was the first all-female group to take merengue to Africa. She has worked in music for close to half a century and is known as La Pionera."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'belkis-concepcion'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'belkis-concepcion' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '24d861af-345c-4f92-9423-9e587c453833', 'artist', '6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'belkis-concepcion' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'eb05e93e-5dd2-4a41-8724-c787213ec10e', 'artist', '8fc78100-e51e-48a8-91e9-3007f4c67ec0'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'belkis-concepcion' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c550c71c-f233-412d-9ba0-e447e2684704', 'artist', 'a56451fa-dccb-462f-9fdb-8cc8a576d6fb'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'belkis-concepcion' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '86a31fab-4cc1-4636-85dc-eb2c4b531c27', 'artist', 'faff18bd-3dbc-477a-bc38-859d611887f0'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'belkis-concepcion' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cd532cf1-6ab2-46d4-a7bb-f8a5399b6557', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'belkis-concepcion' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c8457337-40fc-4a90-927a-20921df6cb8f', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'belkis-concepcion' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Belkis María Concepción Hernández, known as Belkis Concepción, is a Dominican pianist, singer, arranger and bandleader, born in Santo Domingo on 20 June 1961. She founded Las Chicas del Can, the first all-female merengue orchestra in the Dominican Republic, and lost the name to her business partner while she was too ill to work. She has led orchestras of her own ever since.

**A question at nine**

Concepción was the daughter of Julio César Concepción Pacheco and María Hernández de Concepción. At nine she asked her mother why there were no all-female merengue orchestras, was told the work was too hard for women, and answered that she would form the first one. She took her bachillerato at the Colegio Santa Luisa de Marillac, studied piano at the Conservatorio Nacional de Música, and began a law degree at the Universidad Nacional Pedro Henríquez Ureña. While still at school she put together a band with classmates to play at its own functions.

**Las Muchachas**

In 1976 she formed Las Muchachas, which worked private parties, social clubs and television. Three years later she started something more ambitious: a complete dance orchestra of women — trumpets and trombones, saxophone, bass, conga, tambora and the güira that became its signature — recruited largely from the Escuela Iris del Valle in Los Mina. Concepción directed it from the piano and keyboards, and Félix del Rosario and Bertico Sosa helped as it took shape.

**Las Chicas del Can**

The orchestra debuted in 1981 on El Show del Mediodía, the television variety programme produced by Yaqui Núñez del Risco, who named them Las Chicas del Can on air. They were billed as La Pionera Belkis Concepción y Las Chicas del Can. Wilfrido Vargas came in as musical adviser and, from behind the scenes, shaped the group’s most successful years. The project had not been registered when the alliance was made, and it was put in his name.

Concepción made "La media María", "El higuerón" and "Comején" popular with them, and took the orchestra to the United States, Venezuela, Puerto Rico, Colombia, Curaçao and Aruba.

In 1985, six years after the orchestra first took shape, Guillain-Barré syndrome forced her to stop working. Vargas, who held the registration, kept the group and its players. She has said since that the name was taken while she was in bed, that having never registered it she had no way to hold it, and that she and Vargas nonetheless remained on good terms. Her place went to the group’s second vocalist, Miriam Cruz.

**Her own orchestras**

After recovering she returned with Belkis Concepción y su Orquesta, registered in her own name, which opened at the Maunaloa Night Club and Casino in Santo Domingo and went on to play France, the Netherlands, Spain, the United States and Côte d’Ivoire. "La vecina", "Señora", "Luna mágica" and "El hombre que yo amo" come from those years. She later assembled Belkis Concepción y las Estrellas del Merengue, with Dominican players alongside Colombians from Barranquilla.

**El Reencuentro**

"Las Chicas del Can: El Reencuentro" brought former members of every era together at the Teatro La Fiesta of the Hotel Jaragua in October 2024, and returned to the same stage on 21 February 2025. Concepción, who had proposed the idea nine years earlier, said the singers who took part had acknowledged her as the founder of the movement. She continues to tour a Las Chicas del Can across Latin America — four dates in Costa Rica in May 2025 — and places the group’s fiftieth anniversary in 2026, counting from Las Muchachas in 1976. The Corporación Wilfrido Vargas has since stated that the name is its registered mark and requires prior authorisation; Concepción restated her own claim to have created the group on Color Visión in October 2025.

**Legacy**

Concepción was the first woman in the Dominican Republic to assemble and direct a full merengue orchestra of women — not a vocal group with hired players, but an ensemble whose horns and percussion were women as well. The orchestra she founded was the first all-female group to take merengue to Africa. She has worked in music for close to half a century and is known as La Pionera.' WHERE slug = 'belkis-concepcion';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Belkis María Concepción Hernández, conocida como Belkis Concepción, es pianista, cantante, arreglista y directora de orquesta dominicana, nacida en Santo Domingo el 20 de junio de 1961. Fundó "},{"type":"artistReference","attrs":{"occurrenceId":"69603d00-91e2-4a5b-b0fd-0a1920c0183a","artistId":"6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5","displayText":"Las Chicas del Can"}},{"type":"text","text":", la primera orquesta de merengue enteramente femenina de la República Dominicana, y perdió el nombre a manos de su socio mientras estaba demasiado enferma para trabajar. Desde entonces dirige orquestas propias."}]},{"type":"paragraph","content":[{"type":"text","text":"Una pregunta a los nueve años","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Hija de Julio César Concepción Pacheco y María Hernández de Concepción, a los nueve años le preguntó a su madre por qué no había orquestas de merengue de mujeres. La respuesta fue que ese trabajo era demasiado duro para ellas; la niña contestó que iba a formar la primera. Hizo el bachillerato en el Colegio Santa Luisa de Marillac, estudió piano en el Conservatorio Nacional de Música y empezó Derecho en la Universidad Nacional Pedro Henríquez Ureña. Todavía en el colegio armó con sus compañeras un grupo para tocar en las fiestas del propio plantel."}]},{"type":"paragraph","content":[{"type":"text","text":"Las Muchachas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1976 formó Las Muchachas, que amenizó fiestas privadas, clubes sociales y televisión. Tres años después emprendió algo más ambicioso: una orquesta bailable completa de mujeres —trompetas y trombones, saxofón, bajo, conga, tambora y la güira que sería su marca—, reclutada en buena parte en la Escuela Iris del Valle de Los Mina. Concepción la dirigía desde el piano y los teclados, y "},{"type":"artistReference","attrs":{"occurrenceId":"47a9494a-64a1-41ad-a003-1e5921a06b3d","artistId":"8fc78100-e51e-48a8-91e9-3007f4c67ec0","displayText":"Félix del Rosario"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"f3c86df7-5001-4f6f-8036-ee5428cda810","artistId":"a56451fa-dccb-462f-9fdb-8cc8a576d6fb","displayText":"Bertico Sosa"}},{"type":"text","text":" ayudaron a que cuajara."}]},{"type":"paragraph","content":[{"type":"text","text":"Las Chicas del Can","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La orquesta debutó en 1981 en El Show del Mediodía, el programa de variedades que producía "},{"type":"artistReference","attrs":{"occurrenceId":"6e629cb3-0ccd-4229-be83-1091b530d0c9","artistId":"faff18bd-3dbc-477a-bc38-859d611887f0","displayText":"Yaqui Núñez del Risco"}},{"type":"text","text":", quien las bautizó Las Chicas del Can en plena actuación. Se anunciaban como La Pionera Belkis Concepción y Las Chicas del Can. "},{"type":"artistReference","attrs":{"occurrenceId":"5245168c-cb5f-4748-8bb3-ad03ccd2e683","artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas"}},{"type":"text","text":" entró como asesor musical y, desde detrás de bambalinas, moldeó los años de mayor éxito del grupo. El proyecto no estaba registrado cuando se hizo la alianza, y quedó a nombre de él."}]},{"type":"paragraph","content":[{"type":"text","text":"Con ellas Concepción popularizó «La media María», «El higuerón» y «Comején», y llevó la orquesta a Estados Unidos, Venezuela, Puerto Rico, Colombia, Curazao y Aruba."}]},{"type":"paragraph","content":[{"type":"text","text":"En 1985, seis años después de armada la orquesta, el síndrome de Guillain-Barré la obligó a parar. Vargas, que tenía el registro, se quedó con el grupo y con las integrantes. Ella ha contado que le quitaron el nombre estando en cama, que al no haberlo registrado no tuvo cómo retenerlo, y que aun así siguieron llevándose bien. Su lugar lo ocupó la segunda vocalista, "},{"type":"artistReference","attrs":{"occurrenceId":"e80f1855-b5b5-44f5-8f10-cb07893bfe81","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Orquestas propias","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Repuesta, volvió con Belkis Concepción y su Orquesta, registrada a su nombre, que debutó en el Maunaloa Night Club and Casino de Santo Domingo y llegó a presentarse en Francia, Holanda, España, Estados Unidos y Costa de Marfil. De esos años son «La vecina», «Señora», «Luna mágica» y «El hombre que yo amo». Más adelante armó Belkis Concepción y las Estrellas del Merengue, con dominicanas y colombianas de Barranquilla."}]},{"type":"paragraph","content":[{"type":"text","text":"El Reencuentro","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Las Chicas del Can: El Reencuentro» juntó en octubre de 2024, en el Teatro La Fiesta del Hotel Jaragua, a integrantes de todas las etapas, y volvió al mismo escenario el 21 de febrero de 2025. Concepción, que había propuesto la idea nueve años antes, dijo que las cantantes que participaron la reconocieron como fundadora del movimiento. Sigue girando con unas Chicas del Can por América Latina —cuatro fechas en Costa Rica en mayo de 2025— y sitúa el cincuentenario del grupo en 2026, contando desde Las Muchachas en 1976. La Corporación Wilfrido Vargas ha declarado desde entonces que el nombre es marca registrada suya y requiere autorización previa; Concepción reafirmó su versión en Color Visión en octubre de 2025."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Concepción fue la primera mujer en la República Dominicana en armar y dirigir una orquesta de merengue íntegramente femenina: no un grupo vocal con músicos contratados, sino un conjunto donde los metales y la percusión también eran de mujeres. La orquesta que fundó fue la primera agrupación femenina que llevó el merengue a África. Lleva casi medio siglo en la música y se la conoce como La Pionera."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'belkis-concepcion'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'belkis-concepcion' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '69603d00-91e2-4a5b-b0fd-0a1920c0183a', 'artist', '6778e4a3-8f63-420f-bdd4-9a0a7e5cacc5'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'belkis-concepcion' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '47a9494a-64a1-41ad-a003-1e5921a06b3d', 'artist', '8fc78100-e51e-48a8-91e9-3007f4c67ec0'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'belkis-concepcion' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f3c86df7-5001-4f6f-8036-ee5428cda810', 'artist', 'a56451fa-dccb-462f-9fdb-8cc8a576d6fb'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'belkis-concepcion' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6e629cb3-0ccd-4229-be83-1091b530d0c9', 'artist', 'faff18bd-3dbc-477a-bc38-859d611887f0'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'belkis-concepcion' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5245168c-cb5f-4748-8bb3-ad03ccd2e683', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'belkis-concepcion' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e80f1855-b5b5-44f5-8f10-cb07893bfe81', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'belkis-concepcion' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Belkis María Concepción Hernández, conocida como Belkis Concepción, es pianista, cantante, arreglista y directora de orquesta dominicana, nacida en Santo Domingo el 20 de junio de 1961. Fundó Las Chicas del Can, la primera orquesta de merengue enteramente femenina de la República Dominicana, y perdió el nombre a manos de su socio mientras estaba demasiado enferma para trabajar. Desde entonces dirige orquestas propias.

**Una pregunta a los nueve años**

Hija de Julio César Concepción Pacheco y María Hernández de Concepción, a los nueve años le preguntó a su madre por qué no había orquestas de merengue de mujeres. La respuesta fue que ese trabajo era demasiado duro para ellas; la niña contestó que iba a formar la primera. Hizo el bachillerato en el Colegio Santa Luisa de Marillac, estudió piano en el Conservatorio Nacional de Música y empezó Derecho en la Universidad Nacional Pedro Henríquez Ureña. Todavía en el colegio armó con sus compañeras un grupo para tocar en las fiestas del propio plantel.

**Las Muchachas**

En 1976 formó Las Muchachas, que amenizó fiestas privadas, clubes sociales y televisión. Tres años después emprendió algo más ambicioso: una orquesta bailable completa de mujeres —trompetas y trombones, saxofón, bajo, conga, tambora y la güira que sería su marca—, reclutada en buena parte en la Escuela Iris del Valle de Los Mina. Concepción la dirigía desde el piano y los teclados, y Félix del Rosario y Bertico Sosa ayudaron a que cuajara.

**Las Chicas del Can**

La orquesta debutó en 1981 en El Show del Mediodía, el programa de variedades que producía Yaqui Núñez del Risco, quien las bautizó Las Chicas del Can en plena actuación. Se anunciaban como La Pionera Belkis Concepción y Las Chicas del Can. Wilfrido Vargas entró como asesor musical y, desde detrás de bambalinas, moldeó los años de mayor éxito del grupo. El proyecto no estaba registrado cuando se hizo la alianza, y quedó a nombre de él.

Con ellas Concepción popularizó «La media María», «El higuerón» y «Comején», y llevó la orquesta a Estados Unidos, Venezuela, Puerto Rico, Colombia, Curazao y Aruba.

En 1985, seis años después de armada la orquesta, el síndrome de Guillain-Barré la obligó a parar. Vargas, que tenía el registro, se quedó con el grupo y con las integrantes. Ella ha contado que le quitaron el nombre estando en cama, que al no haberlo registrado no tuvo cómo retenerlo, y que aun así siguieron llevándose bien. Su lugar lo ocupó la segunda vocalista, Miriam Cruz.

**Orquestas propias**

Repuesta, volvió con Belkis Concepción y su Orquesta, registrada a su nombre, que debutó en el Maunaloa Night Club and Casino de Santo Domingo y llegó a presentarse en Francia, Holanda, España, Estados Unidos y Costa de Marfil. De esos años son «La vecina», «Señora», «Luna mágica» y «El hombre que yo amo». Más adelante armó Belkis Concepción y las Estrellas del Merengue, con dominicanas y colombianas de Barranquilla.

**El Reencuentro**

«Las Chicas del Can: El Reencuentro» juntó en octubre de 2024, en el Teatro La Fiesta del Hotel Jaragua, a integrantes de todas las etapas, y volvió al mismo escenario el 21 de febrero de 2025. Concepción, que había propuesto la idea nueve años antes, dijo que las cantantes que participaron la reconocieron como fundadora del movimiento. Sigue girando con unas Chicas del Can por América Latina —cuatro fechas en Costa Rica en mayo de 2025— y sitúa el cincuentenario del grupo en 2026, contando desde Las Muchachas en 1976. La Corporación Wilfrido Vargas ha declarado desde entonces que el nombre es marca registrada suya y requiere autorización previa; Concepción reafirmó su versión en Color Visión en octubre de 2025.

**Legado**

Concepción fue la primera mujer en la República Dominicana en armar y dirigir una orquesta de merengue íntegramente femenina: no un grupo vocal con músicos contratados, sino un conjunto donde los metales y la percusión también eran de mujeres. La orquesta que fundó fue la primera agrupación femenina que llevó el merengue a África. Lleva casi medio siglo en la música y se la conoce como La Pionera.' WHERE slug = 'belkis-concepcion';

COMMIT;
