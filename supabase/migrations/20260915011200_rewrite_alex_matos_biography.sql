BEGIN;

-- Ficha de Alex Matos.
--
-- Alias: la fila decía "El Fiscal de la Salsa", apodo de otro salsero (Robert Rodríguez);
-- corregido a "El salsero de ahora" (Wikipedia, título de su álbum de 2013).
-- Nombre real: Alexis Hipólito Suero Matos (la fila tenía el nombre artístico repetido en
-- first_name/last_name). Premios: 4, cada uno con ≥2 fuentes o cita directa de prensa; no
-- se registra Premios Estrella Internacional 2013 por falta de segunda fuente.

UPDATE artists SET first_name = 'Alexis', middle_name = 'Hipólito', last_name = 'Suero',
       second_last_name = 'Matos', aliases = ARRAY['El salsero de ahora']::text[] WHERE slug = 'alex-matos';

INSERT INTO awards (name, organization, country, description)
SELECT 'Premios Latino', NULL, 'Estados Unidos',
       'Premios de la comunidad latina, otorgados anualmente a figuras de la música y el entretenimiento hispano.'
 WHERE NOT EXISTS (SELECT 1 FROM awards WHERE name = 'Premios Latino');

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Salsero del Año' FROM awards a WHERE a.name = 'Premios Latino'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Salsero del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2011, NULL, true, 'El Día, "Alex Matos gana Premio Latino" (consultado 6 nov 2011, vía Wikipedia)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'alex-matos' AND a.name = 'Premios Latino' AND cat.name = 'Salsero del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2011);

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Salsero del Año' FROM awards a WHERE a.name = 'Premios Casandra'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Salsero del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2012, NULL, true, 'El Día (14 mar 2012); Fiestas y Personalidades; El Periódico; Gazcue Es Arte; El Playero Digital'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'alex-matos' AND a.name = 'Premios Casandra' AND cat.name = 'Salsero del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2012);

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Salsero del Año' FROM awards a WHERE a.name = 'Premios Soberano'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Salsero del Año');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2013, 'El salsero de ahora', true, 'Diario Libre; El Caribe; La Crónica; delazonaoriental.net (lista oficial); Ensegundos.do (10 abr 2013)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'alex-matos' AND a.name = 'Premios Soberano' AND cat.name = 'Salsero del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2013);

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Revelación Tropical' FROM awards a WHERE a.name = 'Premio Lo Nuestro'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Revelación Tropical');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2014, NULL, true, 'Wikipedia; El Caribe (6 mar 2014)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'alex-matos' AND a.name = 'Premio Lo Nuestro' AND cat.name = 'Revelación Tropical'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2014);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Alex Matos — Alexis Hipólito Suero Matos, born in Santo Domingo on 12 February 1976 — is a Dominican salsa singer and songwriter known as El salsero de ahora, who spent much of the 2010s among the most decorated names in Dominican salsa."}]},{"type":"paragraph","content":[{"type":"text","text":"The neighbourhood group","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He was singing lead for a small group of children from his neighbourhood at five. He later studied voice with the teacher Marianela Sánchez, who helped set his musical direction toward salsa and pop ballad, and with the arranger Sandy Jorge he made his first record, «Ponte en salsa» (2009): ten songs, eight of them new, seven of Matos’s own composition, plus an adaptation, «Piel de ángel», and a tribute to the Puerto Rican sonero Ismael Rivera."}]},{"type":"paragraph","content":[{"type":"text","text":"«Si entendieras»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2011, working with the arranger "},{"type":"artistReference","attrs":{"occurrenceId":"a045f829-0ecf-4adf-845e-095e54a2855c","artistId":"95010ba2-3d12-4976-938d-141737fb2daa","displayText":"Víctor Waill"}},{"type":"text","text":", he released «Si entendieras», a song that became better known through "},{"type":"artistReference","attrs":{"occurrenceId":"f6f1551a-2215-406c-884b-a03321c276c7","artistId":"081c1484-bf1c-4b11-ba01-d68446b7b111","displayText":"Anthony Ríos"}},{"type":"text","text":"’s recording of it than his own. «Una noche no es bastante», «El cariño es como una flor» and «Amor perfecto» followed, along with «Quiero decirte que te amo» and «Que pena me das», his own compositions, which established him as a singer-songwriter rather than only an interpreter."}]},{"type":"paragraph","content":[{"type":"text","text":"«El salsero de ahora»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"On his first European tour he met Roberto Ferrante, president of Planet Records, who signed the production and distribution rights to «El salsero de ahora» (2013): twelve tracks, six adaptations and six new songs, three of them his own. Promoted first on the U.S. East Coast, the album reached number 8 on Billboard’s Latin Tropical Albums chart, and «Una noche no es bastante» reached number 7 on the Tropical Airplay chart. Matos appeared on «Un Nuevo Día», «Acceso Total», «Despierta América», «Sábado Gigante» and Jaime Bayly’s programme as the record spread his name beyond the salsa circuit."}]},{"type":"paragraph","content":[{"type":"text","text":"Awards and later records","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Salsa Sabor y Sentimiento» followed in 2017 and «Para ti Anthony, el tributo», an homage to "},{"type":"artistReference","attrs":{"occurrenceId":"558934be-0033-4bb4-af8a-75a4b74a99d9","artistId":"081c1484-bf1c-4b11-ba01-d68446b7b111","displayText":"Anthony Ríos"}},{"type":"text","text":", in 2021. His collaborations include «Prefiero la soledad», with "},{"type":"artistReference","attrs":{"occurrenceId":"23f7ab9b-4b09-44d6-aa54-d18da725903e","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":" (2013), «Quién controla el amor», with "},{"type":"artistReference","attrs":{"occurrenceId":"6771359a-59ca-4958-b10c-0d7e589dd9be","artistId":"969a3c82-6b31-4ea0-878d-8643001ca839","displayText":"Yanfourd"}},{"type":"text","text":" (2015), and «Corazón suavecito», with "},{"type":"artistReference","attrs":{"occurrenceId":"ff451a62-83c4-43dc-81a3-e8fe5e3df6fe","artistId":"c48f976c-c4cc-4d8c-a777-844a2e865147","displayText":"Chiquito Team Band"}},{"type":"text","text":" (2019). Between 2011 and 2014 he won Salsero del Año at the Premios Latino, the Premios Casandra and the Premios Soberano, and was named Revelación Tropical at the Premio Lo Nuestro — four wins in a row that made him, for that stretch, salsa’s most recognised Dominican name."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Matos built a career in a genre without deep Dominican roots by writing much of his own catalogue rather than only interpreting it, and by the mid-2010s his songs — carried as often by other singers’ recordings as his own — had made him one of the country’s standard-bearers for salsa romántica."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alex-matos'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'alex-matos' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a045f829-0ecf-4adf-845e-095e54a2855c', 'artist', '95010ba2-3d12-4976-938d-141737fb2daa' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-matos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f6f1551a-2215-406c-884b-a03321c276c7', 'artist', '081c1484-bf1c-4b11-ba01-d68446b7b111' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-matos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '558934be-0033-4bb4-af8a-75a4b74a99d9', 'artist', '081c1484-bf1c-4b11-ba01-d68446b7b111' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-matos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '23f7ab9b-4b09-44d6-aa54-d18da725903e', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-matos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6771359a-59ca-4958-b10c-0d7e589dd9be', 'artist', '969a3c82-6b31-4ea0-878d-8643001ca839' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-matos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ff451a62-83c4-43dc-81a3-e8fe5e3df6fe', 'artist', 'c48f976c-c4cc-4d8c-a777-844a2e865147' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-matos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Alex Matos — Alexis Hipólito Suero Matos, born in Santo Domingo on 12 February 1976 — is a Dominican salsa singer and songwriter known as El salsero de ahora, who spent much of the 2010s among the most decorated names in Dominican salsa.

**The neighbourhood group**

He was singing lead for a small group of children from his neighbourhood at five. He later studied voice with the teacher Marianela Sánchez, who helped set his musical direction toward salsa and pop ballad, and with the arranger Sandy Jorge he made his first record, «Ponte en salsa» (2009): ten songs, eight of them new, seven of Matos’s own composition, plus an adaptation, «Piel de ángel», and a tribute to the Puerto Rican sonero Ismael Rivera.

**«Si entendieras»**

In 2011, working with the arranger Víctor Waill, he released «Si entendieras», a song that became better known through Anthony Ríos’s recording of it than his own. «Una noche no es bastante», «El cariño es como una flor» and «Amor perfecto» followed, along with «Quiero decirte que te amo» and «Que pena me das», his own compositions, which established him as a singer-songwriter rather than only an interpreter.

**«El salsero de ahora»**

On his first European tour he met Roberto Ferrante, president of Planet Records, who signed the production and distribution rights to «El salsero de ahora» (2013): twelve tracks, six adaptations and six new songs, three of them his own. Promoted first on the U.S. East Coast, the album reached number 8 on Billboard’s Latin Tropical Albums chart, and «Una noche no es bastante» reached number 7 on the Tropical Airplay chart. Matos appeared on «Un Nuevo Día», «Acceso Total», «Despierta América», «Sábado Gigante» and Jaime Bayly’s programme as the record spread his name beyond the salsa circuit.

**Awards and later records**

«Salsa Sabor y Sentimiento» followed in 2017 and «Para ti Anthony, el tributo», an homage to Anthony Ríos, in 2021. His collaborations include «Prefiero la soledad», with Antony Santos (2013), «Quién controla el amor», with Yanfourd (2015), and «Corazón suavecito», with Chiquito Team Band (2019). Between 2011 and 2014 he won Salsero del Año at the Premios Latino, the Premios Casandra and the Premios Soberano, and was named Revelación Tropical at the Premio Lo Nuestro — four wins in a row that made him, for that stretch, salsa’s most recognised Dominican name.

**Legacy**

Matos built a career in a genre without deep Dominican roots by writing much of his own catalogue rather than only interpreting it, and by the mid-2010s his songs — carried as often by other singers’ recordings as his own — had made him one of the country’s standard-bearers for salsa romántica.' WHERE slug = 'alex-matos';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Alex Matos —Alexis Hipólito Suero Matos, nacido en Santo Domingo el 12 de febrero de 1976— es un cantante y compositor dominicano de salsa conocido como El salsero de ahora, que pasó buena parte de la década de 2010 entre los nombres más premiados de la salsa dominicana."}]},{"type":"paragraph","content":[{"type":"text","text":"El grupo del barrio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A los cinco años ya era la voz principal de un pequeño grupo de niños de su sector. Más adelante estudió canto con la profesora Marianela Sánchez, quien lo orientó hacia la salsa y la balada pop, y con el arreglista Sandy Jorge grabó su primer disco, «Ponte en salsa» (2009): diez temas, ocho inéditos, siete de su autoría, más una adaptación, «Piel de ángel», y un tributo al sonero puertorriqueño Ismael Rivera."}]},{"type":"paragraph","content":[{"type":"text","text":"«Si entendieras»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2011, de la mano del arreglista "},{"type":"artistReference","attrs":{"occurrenceId":"0f134195-e026-453b-a149-190056ca81e6","artistId":"95010ba2-3d12-4976-938d-141737fb2daa","displayText":"Víctor Waill"}},{"type":"text","text":", lanzó «Si entendieras», canción que se hizo más conocida por la versión de "},{"type":"artistReference","attrs":{"occurrenceId":"80f04fc1-26a0-41f7-a1a9-42af687cc315","artistId":"081c1484-bf1c-4b11-ba01-d68446b7b111","displayText":"Anthony Ríos"}},{"type":"text","text":" que por la suya. Le siguieron «Una noche no es bastante», «El cariño es como una flor» y «Amor perfecto», junto a «Quiero decirte que te amo» y «Que pena me das», de su propia autoría, con las que se presentó como cantautor y no solo como intérprete."}]},{"type":"paragraph","content":[{"type":"text","text":"«El salsero de ahora»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En su primera gira por Europa conoció a Roberto Ferrante, presidente de Planet Records, quien firmó la producción y distribución de «El salsero de ahora» (2013): doce temas, seis adaptaciones y seis inéditos, tres de su autoría. Promovido primero en la costa Este de Estados Unidos, el disco llegó al número 8 del Latin Tropical Albums de Billboard, y «Una noche no es bastante» al número 7 del Tropical Airplay. Matos se presentó en «Un Nuevo Día», «Acceso Total», «Despierta América», «Sábado Gigante» y el programa de Jaime Bayly mientras el disco lo sacaba del circuito estrictamente salsero."}]},{"type":"paragraph","content":[{"type":"text","text":"Premios y discos posteriores","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Salsa Sabor y Sentimiento» llegó en 2017 y «Para ti Anthony, el tributo», un homenaje a "},{"type":"artistReference","attrs":{"occurrenceId":"77add183-2c1e-4e74-a092-2143ff023419","artistId":"081c1484-bf1c-4b11-ba01-d68446b7b111","displayText":"Anthony Ríos"}},{"type":"text","text":", en 2021. Entre sus colaboraciones están «Prefiero la soledad», con "},{"type":"artistReference","attrs":{"occurrenceId":"744b21ba-e1dd-4a69-822d-6e0f68398376","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":" (2013), «Quién controla el amor», con "},{"type":"artistReference","attrs":{"occurrenceId":"2cba651e-35b2-4f60-af8e-d10632689954","artistId":"969a3c82-6b31-4ea0-878d-8643001ca839","displayText":"Yanfourd"}},{"type":"text","text":" (2015), y «Corazón suavecito», con "},{"type":"artistReference","attrs":{"occurrenceId":"41da89f3-e9bd-4120-ae7b-51d7b2c40e51","artistId":"c48f976c-c4cc-4d8c-a777-844a2e865147","displayText":"Chiquito Team Band"}},{"type":"text","text":" (2019). Entre 2011 y 2014 ganó Salsero del Año en los Premios Latino, los Premios Casandra y los Premios Soberano, y fue nombrado Revelación Tropical en el Premio Lo Nuestro —cuatro triunfos seguidos que lo hicieron, en ese tramo, el nombre dominicano más reconocido de la salsa."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Matos hizo carrera en un género sin raíces dominicanas profundas escribiendo buena parte de su propio catálogo en lugar de limitarse a interpretarlo, y hacia mediados de la década de 2010 sus canciones —llevadas tanto por grabaciones ajenas como por las suyas— lo habían convertido en uno de los abanderados del país para la salsa romántica."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alex-matos'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'alex-matos' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0f134195-e026-453b-a149-190056ca81e6', 'artist', '95010ba2-3d12-4976-938d-141737fb2daa' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-matos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '80f04fc1-26a0-41f7-a1a9-42af687cc315', 'artist', '081c1484-bf1c-4b11-ba01-d68446b7b111' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-matos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '77add183-2c1e-4e74-a092-2143ff023419', 'artist', '081c1484-bf1c-4b11-ba01-d68446b7b111' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-matos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '744b21ba-e1dd-4a69-822d-6e0f68398376', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-matos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2cba651e-35b2-4f60-af8e-d10632689954', 'artist', '969a3c82-6b31-4ea0-878d-8643001ca839' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-matos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '41da89f3-e9bd-4120-ae7b-51d7b2c40e51', 'artist', 'c48f976c-c4cc-4d8c-a777-844a2e865147' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alex-matos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Alex Matos —Alexis Hipólito Suero Matos, nacido en Santo Domingo el 12 de febrero de 1976— es un cantante y compositor dominicano de salsa conocido como El salsero de ahora, que pasó buena parte de la década de 2010 entre los nombres más premiados de la salsa dominicana.

**El grupo del barrio**

A los cinco años ya era la voz principal de un pequeño grupo de niños de su sector. Más adelante estudió canto con la profesora Marianela Sánchez, quien lo orientó hacia la salsa y la balada pop, y con el arreglista Sandy Jorge grabó su primer disco, «Ponte en salsa» (2009): diez temas, ocho inéditos, siete de su autoría, más una adaptación, «Piel de ángel», y un tributo al sonero puertorriqueño Ismael Rivera.

**«Si entendieras»**

En 2011, de la mano del arreglista Víctor Waill, lanzó «Si entendieras», canción que se hizo más conocida por la versión de Anthony Ríos que por la suya. Le siguieron «Una noche no es bastante», «El cariño es como una flor» y «Amor perfecto», junto a «Quiero decirte que te amo» y «Que pena me das», de su propia autoría, con las que se presentó como cantautor y no solo como intérprete.

**«El salsero de ahora»**

En su primera gira por Europa conoció a Roberto Ferrante, presidente de Planet Records, quien firmó la producción y distribución de «El salsero de ahora» (2013): doce temas, seis adaptaciones y seis inéditos, tres de su autoría. Promovido primero en la costa Este de Estados Unidos, el disco llegó al número 8 del Latin Tropical Albums de Billboard, y «Una noche no es bastante» al número 7 del Tropical Airplay. Matos se presentó en «Un Nuevo Día», «Acceso Total», «Despierta América», «Sábado Gigante» y el programa de Jaime Bayly mientras el disco lo sacaba del circuito estrictamente salsero.

**Premios y discos posteriores**

«Salsa Sabor y Sentimiento» llegó en 2017 y «Para ti Anthony, el tributo», un homenaje a Anthony Ríos, en 2021. Entre sus colaboraciones están «Prefiero la soledad», con Antony Santos (2013), «Quién controla el amor», con Yanfourd (2015), y «Corazón suavecito», con Chiquito Team Band (2019). Entre 2011 y 2014 ganó Salsero del Año en los Premios Latino, los Premios Casandra y los Premios Soberano, y fue nombrado Revelación Tropical en el Premio Lo Nuestro —cuatro triunfos seguidos que lo hicieron, en ese tramo, el nombre dominicano más reconocido de la salsa.

**Legado**

Matos hizo carrera en un género sin raíces dominicanas profundas escribiendo buena parte de su propio catálogo en lugar de limitarse a interpretarlo, y hacia mediados de la década de 2010 sus canciones —llevadas tanto por grabaciones ajenas como por las suyas— lo habían convertido en uno de los abanderados del país para la salsa romántica.' WHERE slug = 'alex-matos';

COMMIT;
