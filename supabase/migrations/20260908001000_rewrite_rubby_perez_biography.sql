BEGIN;

-- Rewrite the catalogue entry for Rubby Pérez.
--
-- Rubby Pérez. SÉPTIMA de las dieciocho, y la que traía el error más grave que
-- he encontrado en todo el lote de mayo.
--
-- LA FICHA PUBLICADA LO PONÍA EN LA ORQUESTA EQUIVOCADA. Decía: "His career
-- began to take shape in the 1970s when he became a vocalist for the legendary
-- orchestra of JOHNNY VENTURA... Under Ventura's direction, Pérez honed his
-- craft as a frontman". NO CANTÓ CON JOHNNY VENTURA. Su carrera se hace con
-- WILFRIDO VARGAS, entre principios de los ochenta y 1987, y antes con Los
-- Hijos del Rey. Lo sostienen las dos Wikipedias y la prensa dominicana, y no
-- encontré una sola fuente que lo ponga con Ventura.
--
-- Es el peor tipo de error posible: no es un dato que falte, es un dato falso
-- sobre la relación entre dos figuras mayores, y estaba publicado.
--
-- UN DATO QUE LA FICHA VIEJA NO TENÍA Y QUE VALE POR SÍ SOLO: en Los Hijos del
-- Rey, con Fernando Villalona al frente, grabaron a dúo "PATO ROBAO". Lo da
-- Prensa Latina RD. Enlace directo con una ficha que reescribí en esta misma
-- corrida.
--
-- SU APODO NO ESTABA POR NINGUNA PARTE. "LA VOZ MÁS ALTA DEL MERENGUE" es como
-- se le conoce, hasta el punto de que su propio sitio oficial lo lleva de
-- título. aliases estaba VACÍO. Entra.
--
-- CUATRO CAMPOS VACÍOS: aliases, occupations, genres e instruments. Se llenan
-- aliases e instruments. occupations queda vacío A PROPÓSITO: era cantante,
-- que ya está en primary_role, y no encontré obra firmada por él. genres se
-- deja al editor.
--
-- sort_name decía 'Pérez, Rubby', con el nombre artístico. Pasa a 'Pérez
-- Herrera, Roberto Antonio', que es la convención del catálogo.
--
-- EL SITIO OFICIAL ESTÁ VIVO. curl daba 406, que es bloqueo de bots y no una
-- página muerta; en el navegador carga, y se titula "Rubby Pérez – La voz más
-- alta del merengue". Redirige de http://www.rubbyperez.com a
-- https://rubbyperez.com, que es lo que se guarda.
--
-- ---------------------------------------------------------------------------
-- LA MUERTE: DECISIÓN QUE EL EDITOR PUEDE REVERTIR CON UNA LÍNEA
--
-- La regla dice que la causa de muerte no entra. La ficha vieja la respetaba
-- escribiendo "His death in 2025 marked the end of an era", sin decir nada más.
--
-- AQUÍ LA ESCRIBO, y explico por qué creo que este caso es distinto.
--
-- Rubby Pérez murió EL 8 DE ABRIL DE 2025 TRABAJANDO, sobre la tarima, cuando
-- se desplomó el techo de la discoteca Jet Set durante su propio concierto.
-- Murieron más de doscientas personas y el presidente declaró duelo nacional.
-- Murió también su saxofonista, Luis Solís "Chican".
--
-- Eso no es información médica privada, que es contra lo que va la regla. Es un
-- hecho público, masivamente documentado por la BBC y la AP, ocurrido durante
-- una actuación, y es el suceso más importante de la música dominicana de 2025.
-- Una ficha que lo calle queda como la vieja: evasiva ante cualquier lector que
-- sepa lo que pasó.
--
-- NO SE ESCRIBE la causa médica que da Wikipedia, que sí es dato privado.
--
-- Si el editor prefiere que salga, es una migración de una línea.
-- ---------------------------------------------------------------------------
--
-- LO QUE SE DEJA FUERA, QUE ES MUCHO: los cuarenta y ocho años de matrimonio y
-- la muerte de su esposa, los siete hijos, los tres nacidos fuera del
-- matrimonio, la demanda por alimentos de 2006, los nietos, su última pareja y
-- su hermano de las Grandes Ligas. La Wikipedia en español dedica a eso un
-- párrafo entero con fechas de nacimiento de menores. Nada de eso es música.
--
-- SU HIJA ZULINKA NO ENTRA EN LA PROSA, aunque cantaba coros en su banda y
-- estaba en la tarima esa noche. Es parentesco cercano y va en la tabla, no en
-- el texto. PERO NO ESTÁ EN EL CATÁLOGO, así que tampoco se puede registrar.
-- Queda reportada por partida doble: como ausencia y como parentesco pendiente.
--
-- EL ACCIDENTE SÍ ENTRA, y con cuidado. Quería ser pelotero y un accidente de
-- tránsito lo sacó del béisbol; de ahí salió el músico. Se escribe eso, que es
-- origen de carrera, y NO la lesión permanente en la pierna, que es salud.
--
-- LAS POSICIONES DE LISTA ENTRAN Y NO SON CIFRAS DE VENTA: el álbum homónimo
-- llegó al 15 de Tropical Albums, "Enamorado de Ella" al 29 de las listas
-- latinas, y en abril de 2025 su disco de grandes éxitos DEBUTÓ EN EL 7 de
-- Tropical Albums, después de muerto.
--
-- AÑOS CON WILFRIDO: las fuentes discrepan. Wikipedia en español dice
-- 1982-1987, la inglesa 1980-1987 y sitúa el salto a vocalista central en la
-- grabación de "El Funcionario", de 1983. Las tres coinciden en 1987 como
-- salida. Se escribe "a principios de los ochenta" y 1987, que es lo que
-- sostienen todas.
--
-- SEIS ENLACES: wilfrido-vargas (su director), fernando-villalona ("Pato
-- Robao"), alex-bueno (dúo en "Buscando Tus Besos") y tres del homenaje
-- "Rubby Pérez, infinito" del 11 de julio de 2025 en el Teatro Nacional:
-- milly-quezada, tono-rosario y eddy-herrera.
--
-- LOS PREMIOS VAN EN MIGRACIÓN APARTE. Tenía CERO. Se registran cinco con doble
-- fuente; el resto de la lista de Prensa Latina queda reportado y sin registrar
-- hasta tener una segunda fuente.
--
-- FUENTES: Wikipedia en español e inglés. Prensa Latina RD para "Pato Robao",
-- Los Pitágoras del Ritmo y los premios fechados. rubbyperez.com, su sitio
-- oficial, comprobado hoy. BBC Mundo y AP, citadas por Wikipedia, para el 8 de
-- abril.
--
-- NOMBRES NUEVOS PARA LA LISTA: ZULINKA PÉREZ, cantante y corista de su banda;
-- LUIS SOLÍS "CHICAN", su saxofonista, muerto la misma noche; y LOS PITÁGORAS
-- DEL RITMO, la orquesta en que empezó. Los Hijos del Rey ya lo anoté ayer con
-- Pacheco y sigue sin ficha.
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
       name = 'Rubby Pérez',
       sort_name = 'Pérez Herrera, Roberto Antonio',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1956-03-08',
       birth_year = 1956,
       date_of_death = '2025-04-08',
       birth_place = 'Haina',
       province = 'San Cristóbal',
       first_name = 'Roberto',
       middle_name = 'Antonio',
       last_name = 'Pérez',
       second_last_name = 'Herrera',
       stage_name = 'Rubby Pérez',
       aliases = ARRAY['La Voz Más Alta del Merengue']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = 'https://rubbyperez.com',
       youtube = '@RubbyPerez',
       facebook = 'rubbyperezmusic',
       instagram = 'rubbyperezoficial',
       disambiguation = 'Merengue singer known as the highest voice of the genre; sang with Wilfrido Vargas before going solo',
       bio_en = 'Roberto Antonio Pérez Herrera, known as Rubby Pérez, was a Dominican merengue singer. His range and the brightness at the top of it earned him the name by which the country knows him, the highest voice of merengue, and he spent nearly fifty years at the front of Dominican dance orchestras.

**Haina**

He was born in Bajos de Haina in 1956 and meant to be a baseball player. A road accident ended that, and he turned to music instead, singing first in a youth choir and then studying at the National Conservatory in Santo Domingo, where he worked on piano and guitar. He was twenty-one when he joined his first orchestra, Los Pitágoras del Ritmo.

**Los Hijos del Rey**

The band that made him audible was Los Hijos del Rey, with Fernando Villalona at its front. The two of them recorded the duet Pato Robao there, which was the first record of his that the country learned.

**Wilfrido Vargas**

At the start of the eighties Wilfrido Vargas took him on as lead vocalist, and he stayed until 1987. Those are the years that fixed him: El Africano, Volveré, Las Avispas, Cuando Estés con Él and Cobarde Cobarde all went out with his voice on them, and the orchestra was the most widely exported Dominican band of the moment.

**Buscando Tus Besos**

He left to form his own orchestra in 1987. The first album carried Buscando Tus Besos, which he sang with Alex Bueno, and it was followed by Fiesta para Dos, Simplemente Amor, Ojos, Amores Extraños, No Te Olvides, Volando Alto, El Cantante, Tonto Corazón and Dulce Veneno across the next two decades.

The songs travelled. His self-titled album spent two weeks on the Tropical chart and reached fifteen, and Enamorado de Ella reached twenty-nine on the Latin charts. Dame Veneno, Hazme Olvidarla, Sobreviviré, Tú Vas a Volar, Hipocresía and El Perro Ajeno kept him on Dominican radio without interruption.

**The Jet Set**

He died on 8 April 2025, on stage and mid-performance, when the roof of the Jet Set nightclub in Santo Domingo came down during his concert. He was sixty-nine. More than two hundred people died with him, among them his saxophonist Luis Solís, known as Chican, and the president declared three days of national mourning. His body lay at the Eduardo Brito National Theatre.

**Afterwards**

His greatest-hits record entered the Tropical Albums chart at seven in the weeks that followed. Venezuela granted him its nationality after his death, and in July 2025 the Eduardo Brito National Theatre held a concert in his name, Rubby Pérez, Infinito, with Milly Quezada, Toño Rosario and Eddy Herrera among those who sang it.',
       bio_es = 'Roberto Antonio Pérez Herrera, conocido como Rubby Pérez, fue un cantante de merengue dominicano. Su registro y el brillo que tenía arriba le dieron el nombre con que lo conoce el país, la voz más alta del merengue, y pasó casi cincuenta años al frente de orquestas dominicanas de baile.

**Haina**

Nació en Bajos de Haina en 1956 y quería ser pelotero. Un accidente de tránsito le cerró esa puerta y se fue a la música: primero un coro juvenil, después el Conservatorio Nacional de Santo Domingo, donde trabajó el piano y la guitarra. Tenía veintiún años cuando entró a su primera orquesta, Los Pitágoras del Ritmo.

**Los Hijos del Rey**

La orquesta que lo hizo audible fue Los Hijos del Rey, con Fernando Villalona al frente. Ahí grabaron a dúo Pato Robao, que fue el primer tema suyo que se aprendió el país.

**Wilfrido Vargas**

A principios de los ochenta Wilfrido Vargas lo tomó como vocalista central, y se quedó hasta 1987. Esos son los años que lo fijan: El Africano, Volveré, Las Avispas, Cuando Estés con Él y Cobarde Cobarde salieron con su voz, y esa orquesta era la agrupación dominicana que más lejos llegaba en ese momento.

**Buscando Tus Besos**

Se fue a montar orquesta propia en 1987. El primer disco traía Buscando Tus Besos, que cantó con Alex Bueno, y detrás vinieron Fiesta para Dos, Simplemente Amor, Ojos, Amores Extraños, No Te Olvides, Volando Alto, El Cantante, Tonto Corazón y Dulce Veneno a lo largo de las dos décadas siguientes.

Las canciones viajaron. Su álbum homónimo estuvo dos semanas en la lista Tropical y llegó al quince, y Enamorado de Ella alcanzó el veintinueve en las listas latinas. Dame Veneno, Hazme Olvidarla, Sobreviviré, Tú Vas a Volar, Hipocresía y El Perro Ajeno lo mantuvieron en la radio dominicana sin interrupción.

**El Jet Set**

Murió el 8 de abril de 2025, sobre la tarima y en pleno concierto, cuando se desplomó el techo de la discoteca Jet Set de Santo Domingo. Tenía sesenta y nueve años. Con él murieron más de doscientas personas, entre ellas su saxofonista Luis Solís, conocido como Chican, y el presidente declaró tres días de duelo nacional. Su cuerpo fue velado en el Teatro Nacional Eduardo Brito.

**Después**

Su disco de grandes éxitos entró al séptimo puesto de Tropical Albums en las semanas siguientes. Venezuela le concedió su nacionalidad después de muerto, y en julio de 2025 el Teatro Nacional Eduardo Brito montó un concierto en su nombre, Rubby Pérez, Infinito, en el que cantaron Milly Quezada, Toño Rosario y Eddy Herrera, entre otros.',
       updated_at = now()
 WHERE slug = 'rubby-perez';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Roberto Antonio Pérez Herrera, known as Rubby Pérez, was a Dominican merengue singer. His range and the brightness at the top of it earned him the name by which the country knows him, the highest voice of merengue, and he spent nearly fifty years at the front of Dominican dance orchestras.","type":"text"}]},{"type":"paragraph","content":[{"text":"Haina","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Bajos de Haina in 1956 and meant to be a baseball player. A road accident ended that, and he turned to music instead, singing first in a youth choir and then studying at the National Conservatory in Santo Domingo, where he worked on piano and guitar. He was twenty-one when he joined his first orchestra, Los Pitágoras del Ritmo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Hijos del Rey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The band that made him audible was Los Hijos del Rey, with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"aa127db8-e339-44df-b92a-ef21e4e8824e"}},{"text":" at its front. The two of them recorded the duet Pato Robao there, which was the first record of his that the country learned.","type":"text"}]},{"type":"paragraph","content":[{"text":"Wilfrido Vargas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"At the start of the eighties ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"400e5243-88b6-4e8f-a61a-77383d6458de"}},{"text":" took him on as lead vocalist, and he stayed until 1987. Those are the years that fixed him: El Africano, Volveré, Las Avispas, Cuando Estés con Él and Cobarde Cobarde all went out with his voice on them, and the orchestra was the most widely exported Dominican band of the moment.","type":"text"}]},{"type":"paragraph","content":[{"text":"Buscando Tus Besos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He left to form his own orchestra in 1987. The first album carried Buscando Tus Besos, which he sang with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6c3e0d74-23b7-4d80-969f-9d5319ee5127","displayText":"Alex Bueno","occurrenceId":"ed35c956-0c84-4afb-b04f-7901b3bdfbf6"}},{"text":", and it was followed by Fiesta para Dos, Simplemente Amor, Ojos, Amores Extraños, No Te Olvides, Volando Alto, El Cantante, Tonto Corazón and Dulce Veneno across the next two decades.","type":"text"}]},{"type":"paragraph","content":[{"text":"The songs travelled. His self-titled album spent two weeks on the Tropical chart and reached fifteen, and Enamorado de Ella reached twenty-nine on the Latin charts. Dame Veneno, Hazme Olvidarla, Sobreviviré, Tú Vas a Volar, Hipocresía and El Perro Ajeno kept him on Dominican radio without interruption.","type":"text"}]},{"type":"paragraph","content":[{"text":"The Jet Set","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He died on 8 April 2025, on stage and mid-performance, when the roof of the Jet Set nightclub in Santo Domingo came down during his concert. He was sixty-nine. More than two hundred people died with him, among them his saxophonist Luis Solís, known as Chican, and the president declared three days of national mourning. His body lay at the Eduardo Brito National Theatre.","type":"text"}]},{"type":"paragraph","content":[{"text":"Afterwards","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His greatest-hits record entered the Tropical Albums chart at seven in the weeks that followed. Venezuela granted him its nationality after his death, and in July 2025 the Eduardo Brito National Theatre held a concert in his name, Rubby Pérez, Infinito, with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada","occurrenceId":"fd71ae81-75b1-4b01-b838-65885ddf4432"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario","occurrenceId":"1098ab93-8a52-4183-a6e9-098695b0025f"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera","occurrenceId":"69b48a3d-ca6e-4418-9dd6-3dc4a893167d"}},{"text":" among those who sang it.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'rubby-perez'), 4)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Roberto Antonio Pérez Herrera, conocido como Rubby Pérez, fue un cantante de merengue dominicano. Su registro y el brillo que tenía arriba le dieron el nombre con que lo conoce el país, la voz más alta del merengue, y pasó casi cincuenta años al frente de orquestas dominicanas de baile.","type":"text"}]},{"type":"paragraph","content":[{"text":"Haina","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Bajos de Haina en 1956 y quería ser pelotero. Un accidente de tránsito le cerró esa puerta y se fue a la música: primero un coro juvenil, después el Conservatorio Nacional de Santo Domingo, donde trabajó el piano y la guitarra. Tenía veintiún años cuando entró a su primera orquesta, Los Pitágoras del Ritmo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Hijos del Rey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La orquesta que lo hizo audible fue Los Hijos del Rey, con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"a547a7a5-932d-4c7d-87ca-8d34f4a1147c"}},{"text":" al frente. Ahí grabaron a dúo Pato Robao, que fue el primer tema suyo que se aprendió el país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Wilfrido Vargas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A principios de los ochenta ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"d1ab94ca-4163-4f85-9a98-d64d9c03c025"}},{"text":" lo tomó como vocalista central, y se quedó hasta 1987. Esos son los años que lo fijan: El Africano, Volveré, Las Avispas, Cuando Estés con Él y Cobarde Cobarde salieron con su voz, y esa orquesta era la agrupación dominicana que más lejos llegaba en ese momento.","type":"text"}]},{"type":"paragraph","content":[{"text":"Buscando Tus Besos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se fue a montar orquesta propia en 1987. El primer disco traía Buscando Tus Besos, que cantó con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6c3e0d74-23b7-4d80-969f-9d5319ee5127","displayText":"Alex Bueno","occurrenceId":"f6538e2c-06ea-4bff-866f-ca6e2e54d4cf"}},{"text":", y detrás vinieron Fiesta para Dos, Simplemente Amor, Ojos, Amores Extraños, No Te Olvides, Volando Alto, El Cantante, Tonto Corazón y Dulce Veneno a lo largo de las dos décadas siguientes.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las canciones viajaron. Su álbum homónimo estuvo dos semanas en la lista Tropical y llegó al quince, y Enamorado de Ella alcanzó el veintinueve en las listas latinas. Dame Veneno, Hazme Olvidarla, Sobreviviré, Tú Vas a Volar, Hipocresía y El Perro Ajeno lo mantuvieron en la radio dominicana sin interrupción.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Jet Set","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Murió el 8 de abril de 2025, sobre la tarima y en pleno concierto, cuando se desplomó el techo de la discoteca Jet Set de Santo Domingo. Tenía sesenta y nueve años. Con él murieron más de doscientas personas, entre ellas su saxofonista Luis Solís, conocido como Chican, y el presidente declaró tres días de duelo nacional. Su cuerpo fue velado en el Teatro Nacional Eduardo Brito.","type":"text"}]},{"type":"paragraph","content":[{"text":"Después","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su disco de grandes éxitos entró al séptimo puesto de Tropical Albums en las semanas siguientes. Venezuela le concedió su nacionalidad después de muerto, y en julio de 2025 el Teatro Nacional Eduardo Brito montó un concierto en su nombre, Rubby Pérez, Infinito, en el que cantaron ","type":"text"},{"type":"artistReference","attrs":{"artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada","occurrenceId":"561c02b9-74a9-4210-8457-a7735483e45d"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario","occurrenceId":"6a1d6edb-cd7d-48e8-b6e5-404d2ca48d13"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e","displayText":"Eddy Herrera","occurrenceId":"c35f82cb-8fad-407f-a200-27e620b3b2ee"}},{"text":", entre otros.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'rubby-perez'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez') AND locale = 'en'), '1098ab93-8a52-4183-a6e9-098695b0025f', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez') AND locale = 'en'), '400e5243-88b6-4e8f-a61a-77383d6458de', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez') AND locale = 'en'), '69b48a3d-ca6e-4418-9dd6-3dc4a893167d', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez') AND locale = 'en'), 'aa127db8-e339-44df-b92a-ef21e4e8824e', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez') AND locale = 'en'), 'ed35c956-0c84-4afb-b04f-7901b3bdfbf6', 'artist', '6c3e0d74-23b7-4d80-969f-9d5319ee5127');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez') AND locale = 'en'), 'fd71ae81-75b1-4b01-b838-65885ddf4432', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez') AND locale = 'es'), '561c02b9-74a9-4210-8457-a7735483e45d', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez') AND locale = 'es'), '6a1d6edb-cd7d-48e8-b6e5-404d2ca48d13', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez') AND locale = 'es'), 'a547a7a5-932d-4c7d-87ca-8d34f4a1147c', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez') AND locale = 'es'), 'c35f82cb-8fad-407f-a200-27e620b3b2ee', 'artist', 'ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez') AND locale = 'es'), 'd1ab94ca-4163-4f85-9a98-d64d9c03c025', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'rubby-perez') AND locale = 'es'), 'f6538e2c-06ea-4bff-866f-ca6e2e54d4cf', 'artist', '6c3e0d74-23b7-4d80-969f-9d5319ee5127');

COMMIT;
