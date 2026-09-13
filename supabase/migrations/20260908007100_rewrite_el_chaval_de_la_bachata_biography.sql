BEGIN;

-- Rewrite the catalogue entry for El Chaval de la Bachata.
--
-- El Chaval de la Bachata. DECIMOQUINTA de las 211. 1.419 caracteres y la peor
-- ficha de dato que he encontrado en toda la corrida: TRES ERRORES, uno de
-- ellos un nombre inventado y otro un pueblo equivocado sobre el que el texto
-- construyó un párrafo entero de comentario geopolítico.
--
-- ---------------------------------------------------------------------------
-- ERROR 1: EL NOMBRE LEGAL PUBLICADO ES INVENTADO
--
-- El texto abría: "El Chaval de la Bachata, born NELSON SURIEL in 1978". No hay
-- ninguna fuente para eso. Se llama LINAR DE JESÚS ESPINAL NÚÑEZ.
--
-- ERROR 2: LOS APELLIDOS DE LA FILA TAMBIÉN ESTÁN MAL
--
-- La fila guardaba last_name 'Mora' y second_last_name 'Mercedes', y sort_name
-- 'Mora Mercedes, Linar Espinal'. Wikipedia en español da ESPINAL NÚÑEZ y
-- nombra a sus padres, Jesús Espinal y María Núñez; Wikidata guarda "Linar
-- Espinal" como nombre de nacimiento con referencia; Bachata Republic dice
-- "cuyo nombre de pila es Linar Espinal". Mora Mercedes no sale de ningún
-- sitio. Se corrige el reparto entero.
--
-- O sea que había DOS nombres falsos distintos: uno en la prosa y otro en los
-- campos, y ninguno de los dos era el bueno.
--
-- ERROR 3: EL PUEBLO ESTÁ MAL, Y ES EL PEOR DE LOS TRES
--
-- La fila decía DAJABÓN. Nació en JUNCALITO, del municipio de JÁNICO, provincia
-- SANTIAGO -- lo dicen Wikipedia (referenciada a Listín Diario y El Caribe),
-- Wikidata y Bachata Republic. Dajabón está en la frontera, en la otra punta
-- del Cibao.
--
-- Y sobre ese dato falso el texto publicado montó un párrafo entero: "Hailing
-- from the border region, he brought to his music a sense of cultural
-- complexity -- Dajabón is a place where Dominican and Haitian cultures have
-- coexisted in tension and intimacy for generations -- that informs the depth
-- of his artistry."
--
-- Es comentario inventado sobre una premisa falsa, y de paso no dice nada sobre
-- su música. Fuera entero.
-- ---------------------------------------------------------------------------
--
-- LA FECHA SÍ ESTABA BIEN Y NO SE TOCA: 4 de diciembre de 1978. Wikidata la da
-- con DOS referencias y Wikipedia la repite. Bachata Republic dice 5 de
-- diciembre de 1979 y es el único que lo dice; se descarta.
--
-- LOS ALIAS SE LIMPIAN, y uno de ellos era un grupo:
--   'Linar Espinal'              -> el nombre legal duplicando los campos.
--                                   Patrón de 157 filas. Sale.
--   'Los Infantiles del Amargue' -> NO ES UN ALIAS SUYO: ES LA AGRUPACIÓN que
--                                   fundó en 1994. Sale de aquí.
-- Entra 'El Chaval', que es como también se le llama y no estaba.
--
-- ---------------------------------------------------------------------------
-- EL GRUPO YA TIENE FICHA, CON EL OTRO NOMBRE
--
-- 'Los Infantiles del Amargue' se llamó después LOS JÓVENES DEL AMARGUE, y ESE
-- SÍ tiene ficha: `los-jovenes-del-amargue`, publicada, de Santiago, con una
-- biografía de 284 caracteres que no dice nada.
--
-- Así que el alias no se pierde: SE MUEVE A LA FILA DEL GRUPO, que es de quien
-- es. Va en la migración de premios para no mezclarlo con el documento.
--
-- La ficha del grupo hay que reescribirla -- está en 284 caracteres, sin
-- acentos en el nombre y con primary_role 'singer' sobre una fila de tipo
-- 'group' --, pero eso es otra ficha y otro día.
-- ---------------------------------------------------------------------------
--
-- LO QUE FALTABA, QUE ES TODO:
--
--   EMPEZÓ CON EL ACORDEÓN y lo cambió por la guitarra a los siete años, ya en
--   Santiago, donde lo engancharon las bachatas de BLAS DURÁN.
--
--   RECOGÍA METALES PARA VENDER EN EL MERCADO y aportar en su casa mientras
--   estudiaba. Entra como historia laboral, mismo criterio que con Don Miguelo
--   y Joe Veras. NO ENTRA la frase "de niño pasé mucha hambre" de la entrevista
--   de Hoy: eso es penuria personal, no oficio.
--
--   A LOS TRECE conoció a JUAN TAVÁREZ, que tenía un grupo de bachata con su
--   hijo JOEL TAVÁREZ, de ocho años. Con ellos formó Los Infantiles del
--   Amargue, donde era voz principal y segunda guitarra.
--
--   1997: en solitario como El Chaval de la Bachata. "SENTIMIENTO ÚNICO", con
--   "CUANDO EL AMOR SE VA", y DISCO DE ORO.
--
--   2004: "DEVUÉLVEME TODO", que incluye un HOMENAJE A LUIS SEGURA y "ESTOY
--   PERDIDO". En 2021 rehízo esa canción con LA ROSS MARÍA.
--
--   2007: "YA ME CANSÉ", con "DONDE ESTÁN ESOS AMIGOS". PRIMERA ENTRADA SUYA EN
--   BILLBOARD, décimo puesto en Tropical Albums.
--
--   2019: cantó "CANALLA" con Romeo Santos en "Utopía" y se presentó con él en
--   el METLIFE STADIUM ante más de ochenta mil personas.
--
--   2022: veinticinco años de carrera en el UNITED PALACE de Nueva York, con
--   entradas agotadas tres semanas antes, acompañado por RAULÍN RODRÍGUEZ,
--   FRANK REYES y DON MIGUELO.
--
--   2023: "ALAYAH #15", con "La plata", homenaje en vallenato al colombiano
--   Diomedes Díaz, y "Contrato de amantes", escrita por Romeo Santos.
--
--   MARZO DE 2026: BACHATERO DEL AÑO en la 41.ª entrega de los Soberano. Es la
--   misma gala en la que Frank Reyes se llevó la bachata del año, ficha que
--   escribí hace un rato.
--
-- EL DISCO DE ORO SÍ ENTRA Y LAS COPIAS NO. La fuente da "más de 200 mil
-- copias"; eso es cifra de ventas en unidades y no se escribe. La
-- certificación sí.
--
-- LOS OCHENTA MIL DEL METLIFE SÍ ENTRAN: es aforo de un concierto documentado,
-- no una métrica de plataforma.
--
-- LO QUE SE DEJA FUERA: sus dos matrimonios, sus tres hijos, los nombres de sus
-- padres y que es el menor de cuatro hermanos. Y que estudió psicología clínica
-- en la UTESA, que es biografía personal y no obra.
--
-- occupations SE COMPLETA: estaba ["composer","musician"]. 'musician' es vago;
-- las fuentes coinciden en PRODUCTOR y en que toca la guitarra.
--
-- LAS TRES REDES DE LA FILA RESPONDEN. Nada que corregir.
--
-- DIEZ ENLACES: Blas Durán (influencia declarada), Los Jóvenes del Amargue (su
-- propio grupo), Luis Segura (el homenaje de 2004 y el dúo del Añoñado III),
-- La Ross María (la remezcla de 2021), Raulín Rodríguez, Frank Reyes y Don
-- Miguelo (el concierto de los veinticinco años), y Luis Vargas, Leonardo
-- Paniagua y Luis Miguel del Amargue, con quienes ha grabado.
--
-- ROMEO SANTOS, otra vez sin ficha. Sexta de la semana.
--
-- FUENTES: Wikipedia en español, muy bien referenciada -- Listín Diario, El
-- Caribe, El Nacional, Diario Libre, Hoy Digital, Ocio Latino, Monitor Latino y
-- las listas de nominados de Casandra y Soberano. Wikidata, para la fecha y el
-- nombre de nacimiento. Bachata Republic para la etapa de Los Infantiles.
-- Diario Libre, El Día y Revista Mercado del 18 y 19 de marzo de 2026 para el
-- Soberano.
--
-- NOTA DE BÚSQUEDA: el artículo de Wikipedia existe pero está titulado "El
-- chaval de la bachata", TODO EN MINÚSCULAS menos la primera letra. Buscarlo
-- con mayúsculas da "no existe". Es el mismo tipo de fallo por el que casi
-- declaro ausente a Vicente García esta mañana.
--
-- AUSENCIAS NUEVAS: JUAN TAVÁREZ y JOEL TAVÁREZ (padre e hijo, el segundo
-- guitarrista desde los ocho años), NEPO NÚÑEZ (empresario y sello que lo
-- lanzó) y VLADIMIR GARCÍA (director de 829Music Mundial). Los cuatro para
-- MUSICOS_PENDIENTES.
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
       name = 'El Chaval de la Bachata',
       sort_name = 'Espinal Núñez, Linar de Jesús',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1978-12-04',
       birth_year = 1978,
       date_of_death = NULL,
       birth_place = 'Juncalito',
       province = 'Santiago',
       first_name = 'Linar',
       middle_name = 'de Jesús',
       last_name = 'Espinal',
       second_last_name = 'Núñez',
       stage_name = 'El Chaval de la Bachata',
       aliases = ARRAY['El Chaval']::text[],
       occupations = '["composer","producer","guitarist"]'::jsonb,
       instruments = ARRAY['voice', 'guitar']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@ElChavaldelaBachata',
       facebook = 'elchavaldelabachata01',
       instagram = 'elchavaldelabachata',
       disambiguation = 'Bachata singer, composer and producer from Juncalito; Bachatero del Año at the 2026 Soberano',
       bio_en = 'Linar de Jesús Espinal Núñez, who performs as El Chaval de la Bachata, is a Dominican bachata singer, composer, guitarist and producer. He has been recording since 1994, took bachata of the year at the Casandra awards in 2009 and bachata singer of the year at the Soberano in 2026, and has spent most of the intervening years on the nomination lists.

**The accordion and the guitar**

He was born on 4 December 1978 in Juncalito, a district of the municipality of Jánico, in the province of Santiago. The first instrument he set out to play was the accordion; he traded it for a guitar at seven, by which time the family had moved to the city of Santiago, where what caught him were the bachatas of Blas Durán. As a boy he collected scrap metal to sell at the market and bring money home while he was still at school.

**Los Infantiles del Amargue**

At thirteen he met Juan Tavárez, who ran a bachata group with his eight-year-old son Joel on guitar. Together they formed Los Infantiles del Amargue, with Espinal as lead voice and second guitar, and recorded Si te vas for the businessman Nepo Núñez. The group went on performing under a second name, Los Jovenes Del Amargue.

**Sentimiento Único**

In 1997, after three years with the group, he went out alone under the name El Chaval de la Bachata. Sentimiento Único came out that year on Nepo Núñez Records, and Cuando el amor se va became a standard of the genre; the record earned him a gold certification. Enfermo de amor, Para toda la vida, Para siempre, Volveré and Ayer y hoy followed on the same label.

**Estoy perdido**

Devuélveme todo, from 2004, carried a tribute to Luis Segura and the song Estoy perdido, which worked at home and abroad and was nominated for bachata of the year at the Casandra awards. He remade it in 2021 with La Ross María.

**Donde están esos amigos**

Ya me cansé, in 2007, contained Donde están esos amigos and gave him his first entry on a Billboard chart, arriving at number ten on Tropical Albums. Two years later he was up for three Casandra awards at once — bachata singer of the year, songwriter of the year and bachata of the year — and won the last of them with that song, which was also nominated at the Billboard Latin Music Awards.

The albums kept coming: Lo que me pidas, Por el maldito dinero, Sincrodestino, whose single No soy tu marido was nominated in 2017, and Mil historias. In 2014 he recorded Tres semanas, written by the Mexican Marco Antonio Solís.

**Canalla**

He sang Canalla with Romeo Santos on Utopía, and in 2019 appeared with him at the MetLife Stadium in New York in front of more than eighty thousand people. He has also recorded with Luis Vargas, Leonardo Paniagua and Luis Miguel del Amargue, and with Luis Segura on the four-volume record that closed that singer’s career.

**Twenty-five years**

He marked twenty-five years in music in October 2022 with a concert at the United Palace in New York that sold out three weeks ahead, alongside Raulín Rodríguez, Frank Reyes and Don Miguelo. The following year he released Alayah #15, a set of more than twenty songs including a vallenato tribute to the Colombian Diomedes Díaz and Contrato de amantes, written for him by Romeo Santos.

In March 2026, at the forty-first Premios Soberano, he was named bachata singer of the year.',
       bio_es = 'Linar de Jesús Espinal Núñez, que se presenta como El Chaval de la Bachata, es un cantante, compositor, guitarrista y productor dominicano de bachata. Graba desde 1994, se llevó la bachata del año en los Casandra de 2009 y el bachatero del año en los Soberano de 2026, y ha pasado buena parte de los años intermedios en las listas de nominados.

**El acordeón y la guitarra**

Nació el 4 de diciembre de 1978 en Juncalito, distrito del municipio de Jánico, provincia Santiago. El primer instrumento que se propuso tocar fue el acordeón; lo cambió por la guitarra a los siete años, ya con la familia en la ciudad de Santiago, donde lo engancharon las bachatas de Blas Durán. De niño recogía metales para venderlos en el mercado y aportar en su casa mientras estudiaba.

**Los Infantiles del Amargue**

A los trece conoció a Juan Tavárez, que llevaba un grupo de bachata con su hijo Joel, de ocho años, en la guitarra. Con ellos formó Los Infantiles del Amargue, donde Espinal era voz principal y segunda guitarra, y grabó Si te vas para el empresario Nepo Núñez. La agrupación siguió tocando con un segundo nombre, Los Jovenes Del Amargue.

**Sentimiento Único**

En 1997, tras tres años con el grupo, salió en solitario con el nombre de El Chaval de la Bachata. Sentimiento Único se publicó ese año bajo el sello Nepo Nuñez Records, y Cuando el amor se va se volvió un clásico del género; el disco obtuvo certificación de oro. Después vinieron Enfermo de amor, Para toda la vida, Para siempre, Volveré y Ayer y hoy, todos con el mismo sello.

**Estoy perdido**

Devuélveme todo, de 2004, traía un homenaje a Luis Segura y la canción Estoy perdido, que funcionó dentro y fuera del país y fue nominada a bachata del año en los Casandra. La rehízo en 2021 con La Ross María.

**Donde están esos amigos**

Ya me cansé, de 2007, contenía Donde están esos amigos y le dio su primera entrada en una lista de Billboard, en el décimo puesto de Tropical Albums. Dos años después optaba a tres Casandra a la vez —bachatero del año, compositor del año y bachata del año— y ganó el último con esa canción, nominada además en los Premios Billboard de la Música Latina.

Los discos siguieron: Lo que me pidas, Por el maldito dinero, Sincrodestino, cuyo sencillo No soy tu marido fue nominado en 2017, y Mil historias. En 2014 grabó Tres semanas, escrita por el mexicano Marco Antonio Solís.

**Canalla**

Cantó Canalla con Romeo Santos en Utopía, y en 2019 se presentó con él en el MetLife Stadium de Nueva York ante más de ochenta mil personas. Ha grabado además con Luis Vargas, Leonardo Paniagua y Luis Miguel del Amargue, y con Luis Segura en el disco de cuatro volúmenes con el que aquel cerró su carrera.

**Veinticinco años**

Celebró sus veinticinco años en la música en octubre de 2022 con un concierto en el United Palace de Nueva York que agotó las entradas tres semanas antes, acompañado por Raulín Rodríguez, Frank Reyes y Don Miguelo. Al año siguiente publicó Alayah #15, más de veinte canciones entre las que hay un homenaje en vallenato al colombiano Diomedes Díaz y Contrato de amantes, que le escribió Romeo Santos.

En marzo de 2026, en la 41.ª entrega de los Premios Soberano, fue nombrado bachatero del año.',
       updated_at = now()
 WHERE slug = 'el-chaval-de-la-bachata';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Linar de Jesús Espinal Núñez, who performs as El Chaval de la Bachata, is a Dominican bachata singer, composer, guitarist and producer. He has been recording since 1994, took bachata of the year at the Casandra awards in 2009 and bachata singer of the year at the Soberano in 2026, and has spent most of the intervening years on the nomination lists.","type":"text"}]},{"type":"paragraph","content":[{"text":"The accordion and the guitar","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born on 4 December 1978 in Juncalito, a district of the municipality of Jánico, in the province of Santiago. The first instrument he set out to play was the accordion; he traded it for a guitar at seven, by which time the family had moved to the city of Santiago, where what caught him were the bachatas of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2b644026-3e99-4229-a729-003f04103f30","displayText":"Blas Durán","occurrenceId":"ddc017d1-e281-4801-928c-045d923b2c28"}},{"text":". As a boy he collected scrap metal to sell at the market and bring money home while he was still at school.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Infantiles del Amargue","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"At thirteen he met Juan Tavárez, who ran a bachata group with his eight-year-old son Joel on guitar. Together they formed Los Infantiles del Amargue, with Espinal as lead voice and second guitar, and recorded Si te vas for the businessman Nepo Núñez. The group went on performing under a second name, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ad2932a5-9ca5-4e96-88a2-d2bdf42440b0","displayText":"Los Jovenes Del Amargue","occurrenceId":"4c56592c-4de5-48aa-baf5-26bda53146c5"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Sentimiento Único","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1997, after three years with the group, he went out alone under the name El Chaval de la Bachata. Sentimiento Único came out that year on Nepo Núñez Records, and Cuando el amor se va became a standard of the genre; the record earned him a gold certification. Enfermo de amor, Para toda la vida, Para siempre, Volveré and Ayer y hoy followed on the same label.","type":"text"}]},{"type":"paragraph","content":[{"text":"Estoy perdido","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Devuélveme todo, from 2004, carried a tribute to ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"78e7f0da-3ab6-43d9-a0c2-b17762e7144c"}},{"text":" and the song Estoy perdido, which worked at home and abroad and was nominated for bachata of the year at the Casandra awards. He remade it in 2021 with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a57b4811-f39b-438b-ab4b-01c6775f678b","displayText":"La Ross María","occurrenceId":"7c2ceb51-d2f9-4ebc-8c0d-4f25177d0c30"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Donde están esos amigos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Ya me cansé, in 2007, contained Donde están esos amigos and gave him his first entry on a Billboard chart, arriving at number ten on Tropical Albums. Two years later he was up for three Casandra awards at once — bachata singer of the year, songwriter of the year and bachata of the year — and won the last of them with that song, which was also nominated at the Billboard Latin Music Awards.","type":"text"}]},{"type":"paragraph","content":[{"text":"The albums kept coming: Lo que me pidas, Por el maldito dinero, Sincrodestino, whose single No soy tu marido was nominated in 2017, and Mil historias. In 2014 he recorded Tres semanas, written by the Mexican Marco Antonio Solís.","type":"text"}]},{"type":"paragraph","content":[{"text":"Canalla","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He sang Canalla with Romeo Santos on Utopía, and in 2019 appeared with him at the MetLife Stadium in New York in front of more than eighty thousand people. He has also recorded with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas","occurrenceId":"91852e19-bc56-4e81-8469-0e2398e60088"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"31915623-3206-4052-b13a-2170226671b9","displayText":"Leonardo Paniagua","occurrenceId":"168aeeb7-ee41-417f-a307-1bb34046406f"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6302aca6-2203-456f-ad96-6bd2f26ee9b3","displayText":"Luis Miguel del Amargue","occurrenceId":"2b70a722-c0e2-458d-ad0a-21e8544cf5b7"}},{"text":", and with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"3c84afd9-8991-4597-b793-9f5c3f91eadc"}},{"text":" on the four-volume record that closed that singer’s career.","type":"text"}]},{"type":"paragraph","content":[{"text":"Twenty-five years","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He marked twenty-five years in music in October 2022 with a concert at the United Palace in New York that sold out three weeks ahead, alongside ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"9cdecf34-393e-4939-975e-442a02972f86"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes","occurrenceId":"ac60f8d3-b92e-4d75-bbbf-56e36a1073e1"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"39e8a1f7-3efa-42ce-820c-c0e4b8f2c526"}},{"text":". The following year he released Alayah #15, a set of more than twenty songs including a vallenato tribute to the Colombian Diomedes Díaz and Contrato de amantes, written for him by Romeo Santos.","type":"text"}]},{"type":"paragraph","content":[{"text":"In March 2026, at the forty-first Premios Soberano, he was named bachata singer of the year.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Linar de Jesús Espinal Núñez, que se presenta como El Chaval de la Bachata, es un cantante, compositor, guitarrista y productor dominicano de bachata. Graba desde 1994, se llevó la bachata del año en los Casandra de 2009 y el bachatero del año en los Soberano de 2026, y ha pasado buena parte de los años intermedios en las listas de nominados.","type":"text"}]},{"type":"paragraph","content":[{"text":"El acordeón y la guitarra","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació el 4 de diciembre de 1978 en Juncalito, distrito del municipio de Jánico, provincia Santiago. El primer instrumento que se propuso tocar fue el acordeón; lo cambió por la guitarra a los siete años, ya con la familia en la ciudad de Santiago, donde lo engancharon las bachatas de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2b644026-3e99-4229-a729-003f04103f30","displayText":"Blas Durán","occurrenceId":"55799cd3-14c9-411e-98d5-28e4379f4c24"}},{"text":". De niño recogía metales para venderlos en el mercado y aportar en su casa mientras estudiaba.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Infantiles del Amargue","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A los trece conoció a Juan Tavárez, que llevaba un grupo de bachata con su hijo Joel, de ocho años, en la guitarra. Con ellos formó Los Infantiles del Amargue, donde Espinal era voz principal y segunda guitarra, y grabó Si te vas para el empresario Nepo Núñez. La agrupación siguió tocando con un segundo nombre, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ad2932a5-9ca5-4e96-88a2-d2bdf42440b0","displayText":"Los Jovenes Del Amargue","occurrenceId":"ff21de80-dbc3-424a-8264-c926dcba3398"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Sentimiento Único","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1997, tras tres años con el grupo, salió en solitario con el nombre de El Chaval de la Bachata. Sentimiento Único se publicó ese año bajo el sello Nepo Nuñez Records, y Cuando el amor se va se volvió un clásico del género; el disco obtuvo certificación de oro. Después vinieron Enfermo de amor, Para toda la vida, Para siempre, Volveré y Ayer y hoy, todos con el mismo sello.","type":"text"}]},{"type":"paragraph","content":[{"text":"Estoy perdido","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Devuélveme todo, de 2004, traía un homenaje a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"68b45893-f56c-4c5a-aa1b-ffa1a73697b7"}},{"text":" y la canción Estoy perdido, que funcionó dentro y fuera del país y fue nominada a bachata del año en los Casandra. La rehízo en 2021 con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a57b4811-f39b-438b-ab4b-01c6775f678b","displayText":"La Ross María","occurrenceId":"af25e720-1f58-4367-adfe-5414274eb917"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Donde están esos amigos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Ya me cansé, de 2007, contenía Donde están esos amigos y le dio su primera entrada en una lista de Billboard, en el décimo puesto de Tropical Albums. Dos años después optaba a tres Casandra a la vez —bachatero del año, compositor del año y bachata del año— y ganó el último con esa canción, nominada además en los Premios Billboard de la Música Latina.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los discos siguieron: Lo que me pidas, Por el maldito dinero, Sincrodestino, cuyo sencillo No soy tu marido fue nominado en 2017, y Mil historias. En 2014 grabó Tres semanas, escrita por el mexicano Marco Antonio Solís.","type":"text"}]},{"type":"paragraph","content":[{"text":"Canalla","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Cantó Canalla con Romeo Santos en Utopía, y en 2019 se presentó con él en el MetLife Stadium de Nueva York ante más de ochenta mil personas. Ha grabado además con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas","occurrenceId":"60ec8233-24ed-4830-a72f-285811b4f5cb"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"31915623-3206-4052-b13a-2170226671b9","displayText":"Leonardo Paniagua","occurrenceId":"153b78bf-d328-45e3-a064-66ca3e439d4a"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6302aca6-2203-456f-ad96-6bd2f26ee9b3","displayText":"Luis Miguel del Amargue","occurrenceId":"456ad5eb-c0f4-4bba-8faa-273e7e1598ae"}},{"text":", y con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"586e4faf-cd57-455e-b751-a38b6151c2fe"}},{"text":" en el disco de cuatro volúmenes con el que aquel cerró su carrera.","type":"text"}]},{"type":"paragraph","content":[{"text":"Veinticinco años","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Celebró sus veinticinco años en la música en octubre de 2022 con un concierto en el United Palace de Nueva York que agotó las entradas tres semanas antes, acompañado por ","type":"text"},{"type":"artistReference","attrs":{"artistId":"96e69c00-dbb0-4cb4-ab48-ea46be9c4591","displayText":"Raulín Rodríguez","occurrenceId":"e16f5b34-7876-4dd5-a0bc-3f29ee9a9897"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes","occurrenceId":"d4feac78-27cc-4846-8d80-efc906a5547f"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6321da6c-e2d5-490a-a4e8-416bbee81edf","displayText":"Don Miguelo","occurrenceId":"b5c59b73-e110-41d0-b2af-06d15a6714c5"}},{"text":". Al año siguiente publicó Alayah #15, más de veinte canciones entre las que hay un homenaje en vallenato al colombiano Diomedes Díaz y Contrato de amantes, que le escribió Romeo Santos.","type":"text"}]},{"type":"paragraph","content":[{"text":"En marzo de 2026, en la 41.ª entrega de los Premios Soberano, fue nombrado bachatero del año.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'en'), '168aeeb7-ee41-417f-a307-1bb34046406f', 'artist', '31915623-3206-4052-b13a-2170226671b9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'en'), '2b70a722-c0e2-458d-ad0a-21e8544cf5b7', 'artist', '6302aca6-2203-456f-ad96-6bd2f26ee9b3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'en'), '39e8a1f7-3efa-42ce-820c-c0e4b8f2c526', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'en'), '3c84afd9-8991-4597-b793-9f5c3f91eadc', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'en'), '4c56592c-4de5-48aa-baf5-26bda53146c5', 'artist', 'ad2932a5-9ca5-4e96-88a2-d2bdf42440b0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'en'), '78e7f0da-3ab6-43d9-a0c2-b17762e7144c', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'en'), '7c2ceb51-d2f9-4ebc-8c0d-4f25177d0c30', 'artist', 'a57b4811-f39b-438b-ab4b-01c6775f678b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'en'), '91852e19-bc56-4e81-8469-0e2398e60088', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'en'), '9cdecf34-393e-4939-975e-442a02972f86', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'en'), 'ac60f8d3-b92e-4d75-bbbf-56e36a1073e1', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'en'), 'ddc017d1-e281-4801-928c-045d923b2c28', 'artist', '2b644026-3e99-4229-a729-003f04103f30');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'es'), '153b78bf-d328-45e3-a064-66ca3e439d4a', 'artist', '31915623-3206-4052-b13a-2170226671b9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'es'), '456ad5eb-c0f4-4bba-8faa-273e7e1598ae', 'artist', '6302aca6-2203-456f-ad96-6bd2f26ee9b3');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'es'), '55799cd3-14c9-411e-98d5-28e4379f4c24', 'artist', '2b644026-3e99-4229-a729-003f04103f30');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'es'), '586e4faf-cd57-455e-b751-a38b6151c2fe', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'es'), '60ec8233-24ed-4830-a72f-285811b4f5cb', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'es'), '68b45893-f56c-4c5a-aa1b-ffa1a73697b7', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'es'), 'af25e720-1f58-4367-adfe-5414274eb917', 'artist', 'a57b4811-f39b-438b-ab4b-01c6775f678b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'es'), 'b5c59b73-e110-41d0-b2af-06d15a6714c5', 'artist', '6321da6c-e2d5-490a-a4e8-416bbee81edf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'es'), 'd4feac78-27cc-4846-8d80-efc906a5547f', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'es'), 'e16f5b34-7876-4dd5-a0bc-3f29ee9a9897', 'artist', '96e69c00-dbb0-4cb4-ab48-ea46be9c4591');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'el-chaval-de-la-bachata') AND locale = 'es'), 'ff21de80-dbc3-424a-8264-c926dcba3398', 'artist', 'ad2932a5-9ca5-4e96-88a2-d2bdf42440b0');

COMMIT;
