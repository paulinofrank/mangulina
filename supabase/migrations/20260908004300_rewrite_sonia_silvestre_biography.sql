BEGIN;

-- Rewrite the catalogue entry for Sonia Silvestre.
--
-- Sonia Silvestre. DÉCIMA de las dieciocho. Mismo molde: 1.518 caracteres, cero
-- títulos de canción, cero discos, cero premios, y la única fecha además de
-- nacer y morir es "the 1970s". De una de las voces mayores del país.
--
-- El texto viejo decía "her recordings became standards in the repertoire of
-- Dominican popular music" sin nombrar una sola grabación, y "she was unafraid
-- to engage with politically sensitive material" sin decir cuál.
--
-- CONFLICTO DE FECHA QUE NO RESUELVO Y REPORTO. La fila guarda 17 DE ABRIL de
-- 2014. Wikipedia en español dice 19 DE ABRIL, con cita a una nota archivada el
-- 20 de abril de 2014. Busqué una tercera fuente y no la encontré. NO TOCO LA
-- FILA y el texto dice solo "abril de 2014", sin día, que es lo único que las
-- dos sostienen. Queda para el editor.
--
-- LO QUE FALTABA, QUE ES LA FICHA ENTERA:
--
--   CÓMO EMPEZÓ. Cecilia García la metió de corista en jingles publicitarios
--   siendo adolescente. Su debut fue en mayo de 1970 en el programa "Gente",
--   de Freddy Ginebra. En 1971 quedó segunda en el IV Festival de la Canción de
--   AMUCABA con un tema de Leonor Porcella de Brea, y de ahí salió su primer
--   LP.
--
--   NUEVA FORMA, con Víctor Víctor, y Siete Días con el Pueblo en noviembre de
--   1974.
--
--   CUBA, que es un capítulo entero y no estaba. Casandra Damirón la escogió en
--   1974 para atender al Conjunto Folclórico Nacional de Cuba en los Juegos
--   Centroamericanos; Silvio Rodríguez y Noel Nicola la invitaron en Siete
--   Días; viajó en 1975 con Víctor Víctor y la orquesta Irakere; el ICAIC le
--   hizo un documental dirigido por JUAN CARLOS TABÍO; y en 2008 fue designada
--   ministra consejera de asuntos culturales de la embajada dominicana en La
--   Habana.
--
--   "SONIA CANTA A POETAS DE LA PATRIA", con el que fue LA PRIMERA CANTANTE
--   POPULAR EN DAR UN CONCIERTO EN EL TEATRO NACIONAL, acompañada por la
--   Sinfónica Nacional bajo Jorge Taveras.
--
--   "YO QUIERO ANDAR" y el tecnoamargue. Giró con el grupo Trilogía -- Chichí
--   Peralta, Héctor Santana y Juan Francisco Ordóñez -- y ese trabajo maduró un
--   género levantado sobre las bachatas de Luis Días. Y "Corazón de Vellonera",
--   canción de Luis Días cuyo video ganó premio en 1984.
--
--   NUEVE PREMIOS, incluido EL SOBERANO de 2000. Tenía CERO registrados.
--
-- EL CARGO PÚBLICO ENTRA porque lo ejerció: dirigió las Casas de Cultura del
-- Ministerio y fue ministra consejera en La Habana. Mismo criterio que con
-- Johnny Ventura y Sergio Vargas -- cargo efectivamente ocupado, sí; candidatura
-- que no prosperó, no.
--
-- SU MATRIMONIO CON YAQUI NÚÑEZ DEL RISCO NO VA EN LA PROSA. Los dos están
-- publicados en el catálogo, así que es parentesco entre artistas y va a
-- artist_family_relationships, en migración aparte. Wikipedia dice
-- explícitamente que hubo divorcio, así que relationship_status = 'former' está
-- documentado y no es suposición.
--
-- LO QUE SE DEJA FUERA: los nombres de sus padres, sus dos hijos, su segundo
-- matrimonio con un fotógrafo venezolano que no pertenece al catálogo, y la
-- causa de muerte, que es diagnóstico médico.
--
-- AÑO DE "YO QUIERO ANDAR": NO SE ESCRIBE. La discografía de Wikipedia lo pone
-- en 1988 y el texto de la misma página lo asocia a los noventa, citando un
-- blog archivado que lo fecha en 1990. Con la fuente peleándose consigo misma,
-- se nombra el disco sin año.
--
-- SEIS ENLACES: victor-victor (Nueva Forma, la gira cubana y el disco Verde y
-- Negro), cecilia-garcia (la metió en el oficio), casandra-damiron (la escogió
-- para la delegación cubana), luis-terror-dias (el tecnoamargue y "Corazón de
-- Vellonera"), juan-francisco-ordonez y chichi-peralta (Trilogía).
--
-- HÉCTOR SANTANA SE NOMBRA SIN ENLAZAR. Está en el catálogo pero en
-- 'needs_review', y una biografía no debe apuntar a una página que nadie puede
-- abrir. Va en texto plano hasta que se publique.
--
-- primary_genre = 'ballads' SE QUEDA Y SE REPORTA. Wikipedia la clasifica en
-- bachata, bolero y nueva canción. Es decisión de género, o sea del editor.
--
-- FUENTES: Wikipedia en español, que en su caso está bien documentada y con
-- citas a Listín Diario. Las categorías de premios se cotejaron contra las que
-- el catálogo ya tiene.
--
-- PARA EL INVENTARIO DE SEPARACIÓN, hallazgo lateral y feo: "TRANSPORTE URBANO"
-- no tiene ficha propia y aparece como ALIAS PERSONAL en DOS músicos a la vez,
-- luis-terror-dias y juan-francisco-ordonez. Un grupo no puede ser el apodo de
-- dos personas distintas. Corrijo además mi propia nota anterior, que lo daba
-- por presente en el catálogo: lo que el comparador encontró eran esos alias.
-- REVISION POSTERIOR, MISMO DÍA. Un detector que escribí después -- nombres-sin-
-- enlazar.cjs -- encontro que esta ficha nombraba en texto plano a DOS artistas
-- QUE SI ESTAN EN EL CATALOGO: leonor-porcella-de-brea, la compositora que la
-- escogio para el festival de 1971, y jorge-taveras, que dirigio la Sinfonica en
-- su concierto del Teatro Nacional. Peor: yo habia anotado a Leonor como
-- AUSENCIA en la lista de musicos pendientes. Ahora van enlazados.
--
-- Applied directly over DATABASE_URL as part of an editorial pass. No Vercel
-- function ran and nothing was revalidated; the profile reaches the public site
-- on its own within the 31-day ISR fallback for artist profiles, or sooner if a
-- targeted revalidation is run for the slug.
--
-- This file reproduces the change from the pre-pass state. Both it and its
-- rollback were generated from state captured live either side of the write,
-- not reconstructed afterwards.

UPDATE artists SET
       name = 'Sonia Silvestre',
       sort_name = 'Silvestre Ortiz, Sonia Margarita',
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'ballads',
       date_of_birth = '1952-08-16',
       birth_year = 1952,
       date_of_death = '2014-04-17',
       birth_place = 'San Pedro de Macorís',
       province = 'San Pedro de Macorís',
       first_name = 'Sonia',
       middle_name = 'Margarita',
       last_name = 'Silvestre',
       second_last_name = 'Ortiz',
       stage_name = NULL,
       aliases = ARRAY[]::text[],
       occupations = '["radio_host"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Singer of the nueva canción generation who later gave bachata a concert-hall reading',
       bio_en = 'Sonia Margarita Silvestre Ortiz was a Dominican singer and broadcaster. She came up through the protest song of the seventies and spent the second half of her career on bachata, which she sang without lowering it or dressing it up, and she is one of the few Dominican singers whose repertoire is argued about as a body of work rather than as a run of hits.

**Hato Mayor del Rey**

She was born in a hospital in San Pedro de Macorís in 1952 because the town her parents lived in had none, and she always said she was from Hato Mayor del Rey, where she was raised until she was almost eleven. Next to her grandmother’s house stood the largest bar in town, and its jukebox ran through boleros and whatever else Latin America was listening to. The family moved to Santo Domingo in 1962. She later studied education and languages at university.

**Gente**

She got into the business through Cecilia García, who brought her in as a backing voice on advertising jingles while she was still a teenager. Her official debut came in May 1970 on the television programme Gente, produced by Freddy Ginebra, and she went on to sing at the Boite la Oficina and the other rooms of the moment with the group Los Bemols.

The turn came in 1971, when the composer Leonor Porcella de Brea picked her to sing ¿Dónde Podré Gritarte Que Te Quiero? at the fourth Dominican Song Festival. She came second, finished the same year as a finalist in Bogotá, and recorded her first album, Esta Es Sonia Silvestre.

**Nueva Forma**

Her politics took her into the nueva canción. She joined Nueva Forma, an experimental group of social song whose members included Víctor Víctor, and the group appeared at Siete Días con el Pueblo in November 1974, the week-long festival that became the reference point for Dominican song under political repression.

After Nueva Forma broke up she recorded Sonia Canta a Poetas de la Patria for Karen Records, and took it to the Teatro Nacional with the National Symphony Orchestra under Jorge Taveras. No popular singer had given a concert in that hall before.

**Cuba**

Her long association with Cuba began in 1974, when Casandra Damirón chose her to look after the Cuban National Folkloric Ensemble during the Central American and Caribbean Games in Santo Domingo. At Siete Días con el Pueblo that November, Silvio Rodríguez and Noel Nicola invited her to the island, and she went the following year, touring it with Víctor Víctor and the orchestra Irakere.

The Cuban film institute made a documentary about her, directed by Juan Carlos Tabío, one of the first it devoted to a single performer. She returned in 1988 for a tour billed as Tres Mujeres del Caribe alongside Lucecita Benítez and Sara González, and in 2008 she was appointed cultural minister-counsellor at the Dominican embassy in Havana.

**Yo Quiero Andar**

The album Yo Quiero Andar, produced by Cholo Brenes, moved her into bachata and gave her the largest audience of her life. She toured it with the group Trilogía — Chichi Peralta on percussion, Héctor Santana on bass and Juan Francisco Ordóñez on guitar — and that work matured the tecnoamargue, a style built on the bachatas of Luis "Terror" Días.

The two of them worked the genre together for years. Her reading of his Corazón de Vellonera became a video that won its category in 1984, and in 2010 she filled the Palacio de Bellas Artes with a concert in his memory. Amor y Desamor and Mi Corazón Te Seguirá followed in the nineties, and in 2007 she made Verde y Negro with Víctor Víctor.

**The honours**

She was named most popular singer at the Premios El Dorado three years running from 1975, and took the same award for best show in 1977. The Casandra Awards gave her most outstanding singer and best video in 1990; Puerto Rico gave her the Premio Paoli as international artist of the year in 1991; and in 2000 she won El Soberano, the highest of the Dominican awards.

The Senate declared her a national glory of popular song in March 2004, and BanReservas placed her in its national musical reserve in 2011. She spent the early two thousands running the Casas de Cultura for the Ministry of Culture. She died in Santo Domingo in April 2014.',
       bio_es = 'Sonia Margarita Silvestre Ortiz fue una cantante y locutora dominicana. Se formó en la canción protesta de los setenta y dedicó la segunda mitad de su carrera a la bachata, que cantó sin rebajarla ni disfrazarla, y es de las pocas cantantes dominicanas cuyo repertorio se discute como obra y no como sucesión de éxitos.

**Hato Mayor del Rey**

Nació en un hospital de San Pedro de Macorís en 1952 porque el pueblo donde vivían sus padres no tenía, y siempre dijo que era de Hato Mayor del Rey, donde se crió hasta casi los once años. Al lado de la casa de su abuela quedaba el bar más grande del pueblo, y su vellonera recorría boleros y lo que sonara entonces en América Latina. La familia se mudó a Santo Domingo en 1962. Más adelante estudió pedagogía e idiomas en la universidad.

**Gente**

Entró al oficio por Cecilia García, que la metió de corista en jingles publicitarios cuando todavía era adolescente. Su debut oficial fue en mayo de 1970 en el programa de televisión Gente, de Freddy Ginebra, y de ahí pasó a cantar en la Boite la Oficina y en las demás salas del momento con el grupo Los Bemols.

El giro llegó en 1971, cuando la compositora Leonor Porcella de Brea la escogió para cantar ¿Dónde Podré Gritarte Que Te Quiero? en el IV Festival de la Canción Dominicana. Quedó segunda, terminó ese mismo año como finalista en Bogotá, y grabó su primer disco, Esta Es Sonia Silvestre.

**Nueva Forma**

Su posición política la llevó a la nueva canción. Entró a Nueva Forma, grupo experimental de música social entre cuyos integrantes estaba Víctor Víctor, y el grupo se presentó en Siete Días con el Pueblo en noviembre de 1974, la semana que quedó como referencia de la canción dominicana bajo la represión.

Deshecho Nueva Forma, grabó Sonia Canta a Poetas de la Patria para Karen Records y lo llevó al Teatro Nacional con la Orquesta Sinfónica Nacional dirigida por Jorge Taveras. Ninguna cantante popular había dado un concierto en esa sala.

**Cuba**

Su vínculo con Cuba empezó en 1974, cuando Casandra Damirón la escogió para atender al Conjunto Folclórico Nacional de Cuba durante los Juegos Centroamericanos y del Caribe en Santo Domingo. En Siete Días con el Pueblo, ese noviembre, Silvio Rodríguez y Noel Nicola la invitaron a la isla, y viajó al año siguiente, recorriéndola con Víctor Víctor y la orquesta Irakere.

El instituto de cine cubano le hizo un documental dirigido por Juan Carlos Tabío, de los primeros que dedicó a una sola intérprete. Volvió en 1988 en una gira titulada Tres Mujeres del Caribe junto a Lucecita Benítez y Sara González, y en 2008 fue designada ministra consejera de asuntos culturales de la embajada dominicana en La Habana.

**Yo Quiero Andar**

El álbum Yo Quiero Andar, producido por Cholo Brenes, la pasó a la bachata y le dio el público más amplio de su vida. Lo giró con el grupo Trilogía — Chichi Peralta en la percusión, Héctor Santana en el bajo y Juan Francisco Ordóñez en la guitarra — y ese trabajo maduró el tecnoamargue, estilo levantado sobre las bachatas de Luis "Terror" Días.

Los dos trabajaron el género juntos durante años. Su versión de Corazón de Vellonera, de él, se convirtió en un video que ganó su categoría en 1984, y en 2010 llenó el Palacio de Bellas Artes con un concierto en su memoria. Amor y Desamor y Mi Corazón Te Seguirá vinieron en los noventa, y en 2007 hizo Verde y Negro con Víctor Víctor.

**Los reconocimientos**

Fue cantante más popular de los Premios El Dorado tres años seguidos desde 1975, y ganó el mismo premio al mejor espectáculo en 1977. Los Premios Casandra le dieron cantante más destacada y mejor videoclip en 1990; Puerto Rico le dio el Premio Paoli como artista internacional del año en 1991; y en 2000 ganó El Soberano, el máximo galardón dominicano.

El Senado la declaró gloria nacional del canto popular en marzo de 2004, y el Banco de Reservas la incluyó en su reserva musical del país en 2011. A principios de los dos mil dirigió las Casas de Cultura del Ministerio de Cultura. Murió en Santo Domingo en abril de 2014.',
       updated_at = now()
 WHERE slug = 'sonia-silvestre';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Sonia Margarita Silvestre Ortiz was a Dominican singer and broadcaster. She came up through the protest song of the seventies and spent the second half of her career on bachata, which she sang without lowering it or dressing it up, and she is one of the few Dominican singers whose repertoire is argued about as a body of work rather than as a run of hits.","type":"text"}]},{"type":"paragraph","content":[{"text":"Hato Mayor del Rey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She was born in a hospital in San Pedro de Macorís in 1952 because the town her parents lived in had none, and she always said she was from Hato Mayor del Rey, where she was raised until she was almost eleven. Next to her grandmother’s house stood the largest bar in town, and its jukebox ran through boleros and whatever else Latin America was listening to. The family moved to Santo Domingo in 1962. She later studied education and languages at university.","type":"text"}]},{"type":"paragraph","content":[{"text":"Gente","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She got into the business through ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1abe0eae-4c2d-4706-a210-b176b2dfe7b2","displayText":"Cecilia García","occurrenceId":"e834d3bf-2c88-42b7-9a75-7209cf2ad058"}},{"text":", who brought her in as a backing voice on advertising jingles while she was still a teenager. Her official debut came in May 1970 on the television programme Gente, produced by Freddy Ginebra, and she went on to sing at the Boite la Oficina and the other rooms of the moment with the group Los Bemols.","type":"text"}]},{"type":"paragraph","content":[{"text":"The turn came in 1971, when the composer ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7aa05a4d-6647-41b0-8a1c-59786dee2d01","displayText":"Leonor Porcella de Brea","occurrenceId":"f7145325-0082-4a19-a0a2-88b36ce371ae"}},{"text":" picked her to sing ¿Dónde Podré Gritarte Que Te Quiero? at the fourth Dominican Song Festival. She came second, finished the same year as a finalist in Bogotá, and recorded her first album, Esta Es Sonia Silvestre.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nueva Forma","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Her politics took her into the nueva canción. She joined Nueva Forma, an experimental group of social song whose members included ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor","occurrenceId":"69441d4c-eaa4-45e0-b6d1-ec4872c9636b"}},{"text":", and the group appeared at Siete Días con el Pueblo in November 1974, the week-long festival that became the reference point for Dominican song under political repression.","type":"text"}]},{"type":"paragraph","content":[{"text":"After Nueva Forma broke up she recorded Sonia Canta a Poetas de la Patria for Karen Records, and took it to the Teatro Nacional with the National Symphony Orchestra under ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c958758c-a949-4bd9-963d-6d48bc750b60","displayText":"Jorge Taveras","occurrenceId":"77fec282-a296-4ef1-83ee-230f918d2d3f"}},{"text":". No popular singer had given a concert in that hall before.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cuba","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Her long association with Cuba began in 1974, when ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a81458f1-ccaa-451a-8cd5-2afd4d27affb","displayText":"Casandra Damirón","occurrenceId":"a9a94fa1-c6ad-4907-9dae-a1ef1871f320"}},{"text":" chose her to look after the Cuban National Folkloric Ensemble during the Central American and Caribbean Games in Santo Domingo. At Siete Días con el Pueblo that November, Silvio Rodríguez and Noel Nicola invited her to the island, and she went the following year, touring it with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor","occurrenceId":"d5bd6b75-afdb-4d64-a3f3-d2358846bb64"}},{"text":" and the orchestra Irakere.","type":"text"}]},{"type":"paragraph","content":[{"text":"The Cuban film institute made a documentary about her, directed by Juan Carlos Tabío, one of the first it devoted to a single performer. She returned in 1988 for a tour billed as Tres Mujeres del Caribe alongside Lucecita Benítez and Sara González, and in 2008 she was appointed cultural minister-counsellor at the Dominican embassy in Havana.","type":"text"}]},{"type":"paragraph","content":[{"text":"Yo Quiero Andar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The album Yo Quiero Andar, produced by Cholo Brenes, moved her into bachata and gave her the largest audience of her life. She toured it with the group Trilogía — ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta","occurrenceId":"ff5e65ec-6c56-4632-ab85-e5e7e3f3b616"}},{"text":" on percussion, Héctor Santana on bass and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8769e02a-52d7-4818-ac19-e5dd46d7075f","displayText":"Juan Francisco Ordóñez","occurrenceId":"d8e0f9af-6aa7-4e3f-89ba-e4aa497e34e1"}},{"text":" on guitar — and that work matured the tecnoamargue, a style built on the bachatas of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días","occurrenceId":"32b6a156-da11-4875-8088-27027b4beaac"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"The two of them worked the genre together for years. Her reading of his Corazón de Vellonera became a video that won its category in 1984, and in 2010 she filled the Palacio de Bellas Artes with a concert in his memory. Amor y Desamor and Mi Corazón Te Seguirá followed in the nineties, and in 2007 she made Verde y Negro with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor","occurrenceId":"7d371f76-cf35-4963-ad8f-3d19c6b96ee1"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"The honours","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She was named most popular singer at the Premios El Dorado three years running from 1975, and took the same award for best show in 1977. The Casandra Awards gave her most outstanding singer and best video in 1990; Puerto Rico gave her the Premio Paoli as international artist of the year in 1991; and in 2000 she won El Soberano, the highest of the Dominican awards.","type":"text"}]},{"type":"paragraph","content":[{"text":"The Senate declared her a national glory of popular song in March 2004, and BanReservas placed her in its national musical reserve in 2011. She spent the early two thousands running the Casas de Cultura for the Ministry of Culture. She died in Santo Domingo in April 2014.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'sonia-silvestre'), 4)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Sonia Margarita Silvestre Ortiz fue una cantante y locutora dominicana. Se formó en la canción protesta de los setenta y dedicó la segunda mitad de su carrera a la bachata, que cantó sin rebajarla ni disfrazarla, y es de las pocas cantantes dominicanas cuyo repertorio se discute como obra y no como sucesión de éxitos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Hato Mayor del Rey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en un hospital de San Pedro de Macorís en 1952 porque el pueblo donde vivían sus padres no tenía, y siempre dijo que era de Hato Mayor del Rey, donde se crió hasta casi los once años. Al lado de la casa de su abuela quedaba el bar más grande del pueblo, y su vellonera recorría boleros y lo que sonara entonces en América Latina. La familia se mudó a Santo Domingo en 1962. Más adelante estudió pedagogía e idiomas en la universidad.","type":"text"}]},{"type":"paragraph","content":[{"text":"Gente","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Entró al oficio por ","type":"text"},{"type":"artistReference","attrs":{"artistId":"1abe0eae-4c2d-4706-a210-b176b2dfe7b2","displayText":"Cecilia García","occurrenceId":"eacc498e-4ffe-415c-9cf8-0f789a376661"}},{"text":", que la metió de corista en jingles publicitarios cuando todavía era adolescente. Su debut oficial fue en mayo de 1970 en el programa de televisión Gente, de Freddy Ginebra, y de ahí pasó a cantar en la Boite la Oficina y en las demás salas del momento con el grupo Los Bemols.","type":"text"}]},{"type":"paragraph","content":[{"text":"El giro llegó en 1971, cuando la compositora ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7aa05a4d-6647-41b0-8a1c-59786dee2d01","displayText":"Leonor Porcella de Brea","occurrenceId":"77acc377-3a2b-4aa2-94cc-cb2d8b01e731"}},{"text":" la escogió para cantar ¿Dónde Podré Gritarte Que Te Quiero? en el IV Festival de la Canción Dominicana. Quedó segunda, terminó ese mismo año como finalista en Bogotá, y grabó su primer disco, Esta Es Sonia Silvestre.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nueva Forma","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su posición política la llevó a la nueva canción. Entró a Nueva Forma, grupo experimental de música social entre cuyos integrantes estaba ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor","occurrenceId":"e49acc02-530a-418e-be32-b6afcab2c1b7"}},{"text":", y el grupo se presentó en Siete Días con el Pueblo en noviembre de 1974, la semana que quedó como referencia de la canción dominicana bajo la represión.","type":"text"}]},{"type":"paragraph","content":[{"text":"Deshecho Nueva Forma, grabó Sonia Canta a Poetas de la Patria para Karen Records y lo llevó al Teatro Nacional con la Orquesta Sinfónica Nacional dirigida por ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c958758c-a949-4bd9-963d-6d48bc750b60","displayText":"Jorge Taveras","occurrenceId":"a0e9b125-a3b4-4107-8dc5-a8cf4895401c"}},{"text":". Ninguna cantante popular había dado un concierto en esa sala.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cuba","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su vínculo con Cuba empezó en 1974, cuando ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a81458f1-ccaa-451a-8cd5-2afd4d27affb","displayText":"Casandra Damirón","occurrenceId":"fcd8c286-a774-486b-904c-ede297c778d6"}},{"text":" la escogió para atender al Conjunto Folclórico Nacional de Cuba durante los Juegos Centroamericanos y del Caribe en Santo Domingo. En Siete Días con el Pueblo, ese noviembre, Silvio Rodríguez y Noel Nicola la invitaron a la isla, y viajó al año siguiente, recorriéndola con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor","occurrenceId":"9567f896-1b70-4438-8be3-2a896ced7887"}},{"text":" y la orquesta Irakere.","type":"text"}]},{"type":"paragraph","content":[{"text":"El instituto de cine cubano le hizo un documental dirigido por Juan Carlos Tabío, de los primeros que dedicó a una sola intérprete. Volvió en 1988 en una gira titulada Tres Mujeres del Caribe junto a Lucecita Benítez y Sara González, y en 2008 fue designada ministra consejera de asuntos culturales de la embajada dominicana en La Habana.","type":"text"}]},{"type":"paragraph","content":[{"text":"Yo Quiero Andar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El álbum Yo Quiero Andar, producido por Cholo Brenes, la pasó a la bachata y le dio el público más amplio de su vida. Lo giró con el grupo Trilogía — ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta","occurrenceId":"7ba69d17-b3d4-4d30-b1b7-80561b7c1f61"}},{"text":" en la percusión, Héctor Santana en el bajo y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8769e02a-52d7-4818-ac19-e5dd46d7075f","displayText":"Juan Francisco Ordóñez","occurrenceId":"08f0534b-597e-40be-b144-ffe6cd00a261"}},{"text":" en la guitarra — y ese trabajo maduró el tecnoamargue, estilo levantado sobre las bachatas de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días","occurrenceId":"4704c073-1a07-401a-8451-3a590841ba03"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Los dos trabajaron el género juntos durante años. Su versión de Corazón de Vellonera, de él, se convirtió en un video que ganó su categoría en 1984, y en 2010 llenó el Palacio de Bellas Artes con un concierto en su memoria. Amor y Desamor y Mi Corazón Te Seguirá vinieron en los noventa, y en 2007 hizo Verde y Negro con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor","occurrenceId":"935c49dc-b340-42a2-b062-0cc045be81b0"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Los reconocimientos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Fue cantante más popular de los Premios El Dorado tres años seguidos desde 1975, y ganó el mismo premio al mejor espectáculo en 1977. Los Premios Casandra le dieron cantante más destacada y mejor videoclip en 1990; Puerto Rico le dio el Premio Paoli como artista internacional del año en 1991; y en 2000 ganó El Soberano, el máximo galardón dominicano.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Senado la declaró gloria nacional del canto popular en marzo de 2004, y el Banco de Reservas la incluyó en su reserva musical del país en 2011. A principios de los dos mil dirigió las Casas de Cultura del Ministerio de Cultura. Murió en Santo Domingo en abril de 2014.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'sonia-silvestre'), 2)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'en'), '32b6a156-da11-4875-8088-27027b4beaac', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'en'), '69441d4c-eaa4-45e0-b6d1-ec4872c9636b', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'en'), '77fec282-a296-4ef1-83ee-230f918d2d3f', 'artist', 'c958758c-a949-4bd9-963d-6d48bc750b60');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'en'), '7d371f76-cf35-4963-ad8f-3d19c6b96ee1', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'en'), 'a9a94fa1-c6ad-4907-9dae-a1ef1871f320', 'artist', 'a81458f1-ccaa-451a-8cd5-2afd4d27affb');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'en'), 'd5bd6b75-afdb-4d64-a3f3-d2358846bb64', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'en'), 'd8e0f9af-6aa7-4e3f-89ba-e4aa497e34e1', 'artist', '8769e02a-52d7-4818-ac19-e5dd46d7075f');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'en'), 'e834d3bf-2c88-42b7-9a75-7209cf2ad058', 'artist', '1abe0eae-4c2d-4706-a210-b176b2dfe7b2');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'en'), 'f7145325-0082-4a19-a0a2-88b36ce371ae', 'artist', '7aa05a4d-6647-41b0-8a1c-59786dee2d01');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'en'), 'ff5e65ec-6c56-4632-ab85-e5e7e3f3b616', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'es'), '08f0534b-597e-40be-b144-ffe6cd00a261', 'artist', '8769e02a-52d7-4818-ac19-e5dd46d7075f');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'es'), '4704c073-1a07-401a-8451-3a590841ba03', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'es'), '77acc377-3a2b-4aa2-94cc-cb2d8b01e731', 'artist', '7aa05a4d-6647-41b0-8a1c-59786dee2d01');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'es'), '7ba69d17-b3d4-4d30-b1b7-80561b7c1f61', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'es'), '935c49dc-b340-42a2-b062-0cc045be81b0', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'es'), '9567f896-1b70-4438-8be3-2a896ced7887', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'es'), 'a0e9b125-a3b4-4107-8dc5-a8cf4895401c', 'artist', 'c958758c-a949-4bd9-963d-6d48bc750b60');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'es'), 'e49acc02-530a-418e-be32-b6afcab2c1b7', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'es'), 'eacc498e-4ffe-415c-9cf8-0f789a376661', 'artist', '1abe0eae-4c2d-4706-a210-b176b2dfe7b2');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sonia-silvestre') AND locale = 'es'), 'fcd8c286-a774-486b-904c-ede297c778d6', 'artist', 'a81458f1-ccaa-451a-8cd5-2afd4d27affb');

COMMIT;
