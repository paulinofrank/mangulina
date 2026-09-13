BEGIN;

-- Rewrite the catalogue entry for Edilio Paredes.
--
-- Edilio Paredes. DECIMOSEXTA de las 211. 1.228 caracteres sobre EL HOMBRE QUE
-- LE PUSO LA GUITARRA A LA BACHATA, y no nombraba a un solo artista con el que
-- hubiera tocado, ni una canción, ni un año, ni el instrumento que toca.
--
-- Peor: lo llamaba "a Dominican bachata and bolero ARTIST". No es un cantante.
-- Es el REQUINTISTA Y ARREGLISTA que grabó la primera guitarra de más de mil
-- temas y cuyos arreglos separaron la bachata del bolero del que venía. La
-- propia fila lo sabía —primary_role 'instrumentalist', instruments ['guitar']—
-- y el texto no.
--
-- ---------------------------------------------------------------------------
-- EL DATO QUE FALTABA Y QUE CAMBIA LA FICHA ENTERA
--
-- EN 2023 LA REVISTA ROLLING STONE LO PUSO EN EL PUESTO 244 DE LOS 250 MEJORES
-- GUITARRISTAS DE TODOS LOS TIEMPOS. Lo confirman las dos Wikipedias citando la
-- lista original del 13 de octubre de 2023 y una docena de reproducciones
-- independientes de la lista completa.
--
-- Va a la tabla de premios en migración aparte, con entidad nueva. El catálogo
-- ya registra colocaciones en listas de revista: tiene "50 Greatest Latin
-- Artists of All Time" bajo Billboard Latin Music.
-- ---------------------------------------------------------------------------
--
-- CONFLICTO DE PUEBLO QUE SE RESUELVE A FAVOR DE LA FILA, y conviene explicar
-- por qué.
--
-- La fila dice SAN FRANCISCO DE MACORÍS. Wikipedia en español dice que nació en
-- "San Felipe, comunidad del municipio de Pimentel". Pero la biografía de iASO
-- Records —la más detallada que existe, escrita por David C. Wayne— dice que es
-- natural de LA GALANA, un campo cerca de San Francisco de Macorís, y que a los
-- ocho años había "cruzado el río hasta el vecino SAN FELIPE".
--
-- O sea que Wikipedia convirtió en lugar de nacimiento lo que en la fuente es
-- una anécdota de infancia. El artículo además está marcado desde 2023 por
-- falta de referencias. LA FILA SE QUEDA, y la prosa nombra La Galana, que es
-- el dato preciso. Las tres versiones están en la provincia Duarte.
--
-- LO QUE FALTABA, QUE ES TODA SU VIDA:
--
--   LA PRIMERA GUITARRA FUE UN TRES SOBRE EL MOSTRADOR DE UN COLMADO. Tenía
--   cuatro años y tuvo que ponerse de puntillas para alcanzarlo; sacó tres
--   merengues de los que sonaban entonces. Rompió una cuerda, el dueño se
--   enfureció, y a los cuatro años juró no volver a tocar música nunca. A los
--   ocho se retractó.
--
--   FORMÓ GRUPO CON SU HERMANO NELSON Y CON RAMÓN CORDERO, amigo de infancia
--   que llegaría a ser figura de la bachata. La guitarra y las primeras
--   nociones se las dio un tío de Cordero; por lo demás es AUTODIDACTA. Tocaban
--   a Odilio González, Julio Jaramillo y Blanca Iris Villafañe, y él quería
--   tocar como el puertorriqueño Yomo Toro.
--
--   A LOS TRECE se fue a la capital y entró a trabajar en CASA ALEGRE, la
--   tienda de música de CUCO VALOY, que además tenía sello. Grabó allí con
--   BERNARDO ORTIZ, RAFAEL ENCARNACIÓN y MÉLIDA PÉREZ, y desplazó a los
--   guitarristas mayores como el más solicitado para grabar "bolero campesino".
--
--   RADIO GUARACHITA. Pasó a grabar para RADHAMÉS ARACENA, dueño de la única
--   emisora nacional que ponía música de guitarra y de los sellos donde se
--   grababa. AQUÍ ESTÁ EL DATO MÁS PRECISO DE LA FICHA: como era el requinto
--   principal de la Guarachita, prácticamente TODOS los bachateros que grabaron
--   allí trabajaron con él, salvo los pocos que tocaban su propia primera
--   guitarra, ENTRE ELLOS LUIS SEGURA. Escribí la ficha de Segura ayer y este
--   detalle la completa por el otro lado.
--
--   LA GÜIRA DESPLAZÓ A LAS MARACAS en los setenta y entraron elementos de son
--   y merengue en las líneas de guitarra. Él estuvo en ese cambio, y como era
--   quien hacía los arreglos, el cambio pasó por sus manos.
--
--   SU NOMBRE VA UNIDO AL DE RAMÓN CORDERO, y trabajó además con MARINO PÉREZ,
--   BOLÍVAR PERALTA, LEONARDO PANIAGUA y JOSÉ MANUEL CALDERÓN, entre otros.
--   También publicó obra propia.
--
--   HOY GIRA CON SUPER UBA Y PUERTO PLATA y ha estado en las giras de Bachata
--   Roja con LEONARDO PANIAGUA y JOAN SORIANO.
--
-- LA FAMILIA MUSICAL SE NOMBRA EN PROSA Y NO EN LA TABLA, y explico por qué:
-- su hermano NELSON y sus tres hijos DAVID, SAMUEL y NANO son músicos, pero
-- NINGUNO TIENE FICHA, y artist_family_relationships necesita las dos filas.
-- Quedan anotados como ausencias marcadas, para que al crearlos se registren
-- los parentescos. Nelson entra además por crédito: fue su compañero de grupo a
-- los ocho años.
--
-- LO QUE NO ENTRA: la comparación de la fuente entre él y Yomo Toro o Compay
-- Segundo, y su queja de que no se le estima en su país como a ellos en los
-- suyos. Es opinión del autor, que además es el dueño del sello que lo edita.
-- TAMPOCO ENTRA su explicación de por qué la sociedad dominicana marginó la
-- bachata —presiones de la industria del merengue, elitismo, reacción puritana—:
-- la propia fuente dice que eso se trata mejor en otro contexto, y es historia
-- del género, no de él.
--
-- occupations SE AFINA: estaba ["musician","arranger","composer"]. 'musician'
-- es vago para el mejor requintista del género; entra 'guitarist'.
--
-- instruments GANA 'requinto', que es literalmente el puesto que ocupaba en la
-- Guarachita y el instrumento de sus solos.
--
-- EL ALIAS 'El Maestro' SE QUEDA PERO QUEDA ANOTADO: Wikipedia en español
-- escribe "su amigo de la infancia Ramón Cordero el Maestro", o sea que le
-- atribuye el mismo apodo a Cordero. No lo resuelvo aquí.
--
-- NO TIENE REDES GUARDADAS Y NO LE ENCONTRÉ NINGUNA propia. Tiene setenta y
-- nueve años y su presencia en línea es la de su sello y la de terceros. Los
-- campos se quedan vacíos antes que meter una página de aficionados.
--
-- DIEZ ENLACES, todos por crédito documentado.
--
-- FUENTES: la biografía de iASO Records por David C. Wayne, que es con
-- diferencia la mejor y la que tiene los detalles concretos. Wikipedia en
-- inglés y en español —las dos marcadas por falta de referencias, y la española
-- además equivocada en el pueblo— para el dato de Rolling Stone y las giras.
-- La lista de Rolling Stone del 13 de octubre de 2023, comprobada aparte.
--
-- AUSENCIAS NUEVAS: NELSON PAREDES (hermano), DAVID, SAMUEL y NANO PAREDES
-- (hijos), BOLÍVAR PERALTA, BERNARDO ORTIZ, MÉLIDA PÉREZ y SUPER UBA. Los ocho
-- para MUSICOS_PENDIENTES, y los cuatro Paredes marcados para parentesco.
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
       name = 'Edilio Paredes',
       sort_name = 'Paredes, Edilio',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'instrumentalist',
       primary_genre = 'bachata',
       date_of_birth = '1945-09-10',
       birth_year = 1945,
       date_of_death = NULL,
       birth_place = 'San Francisco de Macorís',
       province = 'Duarte',
       first_name = 'Edilio',
       middle_name = NULL,
       last_name = 'Paredes',
       second_last_name = NULL,
       stage_name = 'Edilio Paredes',
       aliases = ARRAY['El Maestro']::text[],
       occupations = '["arranger","composer","guitarist"]'::jsonb,
       instruments = ARRAY['guitar', 'requinto']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Requinto player and arranger who shaped bachata guitar; Rolling Stone ranked him among the 250 greatest guitarists',
       bio_en = 'Edilio Paredes is a Dominican guitarist and arranger, and the musician who did most to give bachata a guitar style of its own. He recorded the lead guitar on well over a thousand tracks across three decades, and it was his arrangements that separated bachata from the bolero it grew out of. In 2023 Rolling Stone placed him at number 244 on its list of the 250 greatest guitarists of all time.

**The tres on the counter**

He was born on 10 September 1945 in La Galana, a small country settlement near San Francisco de Macorís, in the province of Duarte, and was the first person in his family to sing or play anything. He first touched an instrument at four: the owner of the local shop kept a tres on the counter, and Paredes had to stand on his toes to reach it. He picked out three merengues that were going around at the time. Then he broke a string, the owner lost his temper, and the four-year-old swore off music for good.

He went back on that at eight, and formed a group with his brother Nelson and with Ramón Cordero, a childhood friend who would become a major figure in the music himself. The guitar and the first instruction came from an uncle of Cordero’s; beyond that Paredes taught himself. They played parties around the area, working through the songs of Odilio González, Julio Jaramillo and Blanca Iris Villafañe, and what he wanted was to play like the Puerto Rican Yomo Toro.

**Casa Alegre**

At thirteen he left for Santo Domingo and took a job at Casa Alegre, the music shop belonging to Cuco Valoy, who also ran a record label. He began recording there, cutting sides with Bernardo Ortiz, Rafael Encarnación and Mélida Pérez, and within a short time he had displaced the older players as the most sought-after guitarist for what was then called bolero campesino — the music that would later be called bachata.

**Radio Guarachita**

He moved on to recording for Radhamés Aracena, who owned Radio Guarachita. It was the only national station that played guitar music, and everything it played had been recorded on one of the labels Aracena himself owned, so almost every bachatero in the country passed through at some point.

Paredes was the station’s principal requinto — its lead guitarist — which means that nearly all of those singers worked with him. The exceptions were the handful who played their own lead guitar, Luis Segura among them.

**The güira and the arrangement**

Bachata changed a great deal across those years. In the early sixties it was barely distinguishable from the bolero before it; by the middle of the seventies it had become rhythmic and danceable, the güira had displaced the maracas, and elements of son and merengue had entered the guitar lines. Paredes was part of that shift, and since he was the one writing the arrangements, it largely went through his hands.

His name is tied most closely to Ramón Cordero, but he did substantial work with Marino Pérez, Bolívar Peralta, Leonardo Paniagua and José Manuel Calderón as well, and released a good deal of his own material alongside it.

**The touring years**

He has gone on working as a player and bandleader, touring with the groups Super Uba and Puerto Plata, and taking part in the Bachata Roja tours alongside Leonardo Paniagua and Joan Soriano, which carried the older acoustic style to audiences outside the country.

The musicianship stayed in the family: his brother Nelson played with him from the beginning, and his three sons — David, Samuel and Nano — are all working musicians.',
       bio_es = 'Edilio Paredes es un guitarrista y arreglista dominicano, y el músico que más hizo por darle a la bachata un estilo de guitarra propio. Grabó la primera guitarra de bastante más de mil temas a lo largo de tres décadas, y fueron sus arreglos los que separaron la bachata del bolero del que venía. En 2023 la revista Rolling Stone lo colocó en el puesto 244 de su lista de los 250 mejores guitarristas de todos los tiempos.

**El tres sobre el mostrador**

Nació el 10 de septiembre de 1945 en La Galana, un campo cerca de San Francisco de Macorís, provincia Duarte, y fue el primero de su familia en cantar o tocar algo. Tocó un instrumento por primera vez a los cuatro años: el dueño del colmado tenía un tres sobre el mostrador y Paredes tuvo que ponerse de puntillas para alcanzarlo. Le sacó tres merengues de los que sonaban entonces. Después rompió una cuerda, el dueño se enfureció, y el niño de cuatro años juró no volver a tocar música.

Se retractó a los ocho y formó un grupo con su hermano Nelson y con Ramón Cordero, amigo de infancia que llegaría a ser una figura del género por su cuenta. La guitarra y las primeras nociones se las dio un tío de Cordero; lo demás lo aprendió solo. Tocaban en fiestas de la zona lo de Odilio González, Julio Jaramillo y Blanca Iris Villafañe, y lo que él quería era tocar como el puertorriqueño Yomo Toro.

**Casa Alegre**

A los trece se fue a Santo Domingo y entró a trabajar en Casa Alegre, la tienda de música de Cuco Valoy, que además tenía sello discográfico. Allí empezó a grabar, con Bernardo Ortiz, Rafael Encarnación y Mélida Pérez, y en poco tiempo había desplazado a los músicos mayores como el guitarrista más solicitado para grabar lo que entonces se llamaba bolero campesino, la música que después se llamaría bachata.

**Radio Guarachita**

Pasó a grabar para Radhamés Aracena, dueño de Radio Guarachita. Era la única emisora nacional que ponía música de guitarra, y todo lo que ponía estaba grabado en alguno de los sellos del propio Aracena, de modo que casi cualquier bachatero del país pasó por allí en algún momento.

Paredes era el requinto principal de la emisora, es decir, la primera guitarra, lo que significa que casi todos esos cantantes grabaron con él. Las excepciones eran los pocos que tocaban su propia primera guitarra, Luis Segura entre ellos.

**La güira y el arreglo**

La bachata cambió mucho en esos años. A principios de los sesenta apenas se distinguía del bolero anterior; a mediados de los setenta era rítmica y bailable, la güira había desplazado a las maracas y habían entrado elementos de son y de merengue en las líneas de guitarra. Paredes estuvo dentro de ese cambio y, como era quien hacía los arreglos, el cambio pasó en buena medida por sus manos.

Su nombre va unido sobre todo al de Ramón Cordero, pero hizo trabajo de peso con Marino Pérez, Bolívar Peralta, Leonardo Paniagua y José Manuel Calderón, y publicó además bastante obra propia.

**Los años de gira**

Ha seguido tocando y dirigiendo grupos, de gira con Super Uba y con Puerto Plata, y ha participado en las giras de Bachata Roja junto a Leonardo Paniagua y Joan Soriano, que llevaron el estilo acústico antiguo a públicos de fuera del país.

La música se quedó en la familia: su hermano Nelson tocó con él desde el principio, y sus tres hijos —David, Samuel y Nano— son músicos en activo.',
       updated_at = now()
 WHERE slug = 'edilio-paredes';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Edilio Paredes is a Dominican guitarist and arranger, and the musician who did most to give bachata a guitar style of its own. He recorded the lead guitar on well over a thousand tracks across three decades, and it was his arrangements that separated bachata from the bolero it grew out of. In 2023 Rolling Stone placed him at number 244 on its list of the 250 greatest guitarists of all time.","type":"text"}]},{"type":"paragraph","content":[{"text":"The tres on the counter","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born on 10 September 1945 in La Galana, a small country settlement near San Francisco de Macorís, in the province of Duarte, and was the first person in his family to sing or play anything. He first touched an instrument at four: the owner of the local shop kept a tres on the counter, and Paredes had to stand on his toes to reach it. He picked out three merengues that were going around at the time. Then he broke a string, the owner lost his temper, and the four-year-old swore off music for good.","type":"text"}]},{"type":"paragraph","content":[{"text":"He went back on that at eight, and formed a group with his brother Nelson and with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"449f86a9-d10e-4fff-976f-9581fb3d03a1","displayText":"Ramón Cordero","occurrenceId":"afa60b29-f77e-4b6e-95aa-67758fd2150b"}},{"text":", a childhood friend who would become a major figure in the music himself. The guitar and the first instruction came from an uncle of Cordero’s; beyond that Paredes taught himself. They played parties around the area, working through the songs of Odilio González, Julio Jaramillo and Blanca Iris Villafañe, and what he wanted was to play like the Puerto Rican Yomo Toro.","type":"text"}]},{"type":"paragraph","content":[{"text":"Casa Alegre","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"At thirteen he left for Santo Domingo and took a job at Casa Alegre, the music shop belonging to ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy","occurrenceId":"cdf67046-a6d8-4b71-848e-3d2711c2b1f5"}},{"text":", who also ran a record label. He began recording there, cutting sides with Bernardo Ortiz, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3ae30a9a-5369-4084-8162-b2d470263f1e","displayText":"Rafael Encarnación","occurrenceId":"6ea9f009-206b-4039-affb-1ad86309d867"}},{"text":" and Mélida Pérez, and within a short time he had displaced the older players as the most sought-after guitarist for what was then called bolero campesino — the music that would later be called bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"Radio Guarachita","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He moved on to recording for ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena","occurrenceId":"a96cb42d-dad8-4b86-b347-e8ca24c3b745"}},{"text":", who owned Radio Guarachita. It was the only national station that played guitar music, and everything it played had been recorded on one of the labels Aracena himself owned, so almost every bachatero in the country passed through at some point.","type":"text"}]},{"type":"paragraph","content":[{"text":"Paredes was the station’s principal requinto — its lead guitarist — which means that nearly all of those singers worked with him. The exceptions were the handful who played their own lead guitar, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"73223f08-c961-4e35-945f-7b7771c42a1c"}},{"text":" among them.","type":"text"}]},{"type":"paragraph","content":[{"text":"The güira and the arrangement","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Bachata changed a great deal across those years. In the early sixties it was barely distinguishable from the bolero before it; by the middle of the seventies it had become rhythmic and danceable, the güira had displaced the maracas, and elements of son and merengue had entered the guitar lines. Paredes was part of that shift, and since he was the one writing the arrangements, it largely went through his hands.","type":"text"}]},{"type":"paragraph","content":[{"text":"His name is tied most closely to ","type":"text"},{"type":"artistReference","attrs":{"artistId":"449f86a9-d10e-4fff-976f-9581fb3d03a1","displayText":"Ramón Cordero","occurrenceId":"90ef1e57-3004-4758-aeb0-29a2d721b112"}},{"text":", but he did substantial work with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8faf8748-31f9-4dbc-bfe1-d5b7fd70244e","displayText":"Marino Pérez","occurrenceId":"9b7d6955-8e7f-4cff-b916-96e0356f13f7"}},{"text":", Bolívar Peralta, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"31915623-3206-4052-b13a-2170226671b9","displayText":"Leonardo Paniagua","occurrenceId":"42ca2561-ec74-4ce7-9dca-000e13b5c95c"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón","occurrenceId":"b0b034f9-c5f3-47b7-8389-7032a8aee45f"}},{"text":" as well, and released a good deal of his own material alongside it.","type":"text"}]},{"type":"paragraph","content":[{"text":"The touring years","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He has gone on working as a player and bandleader, touring with the groups Super Uba and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"40b02936-92e3-4149-98e8-0ba1118eeb7c","displayText":"Puerto Plata","occurrenceId":"2171d4ad-a74e-4e09-b19b-c3d39f8d2a42"}},{"text":", and taking part in the Bachata Roja tours alongside ","type":"text"},{"type":"artistReference","attrs":{"artistId":"31915623-3206-4052-b13a-2170226671b9","displayText":"Leonardo Paniagua","occurrenceId":"786a4a46-af97-4b5d-be3b-1f4049e418a6"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4d9ac6ac-6802-47f4-8731-5fa567713513","displayText":"Joan Soriano","occurrenceId":"f57cd09c-7713-4200-b2fe-c29dc9259d13"}},{"text":", which carried the older acoustic style to audiences outside the country.","type":"text"}]},{"type":"paragraph","content":[{"text":"The musicianship stayed in the family: his brother Nelson played with him from the beginning, and his three sons — David, Samuel and Nano — are all working musicians.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'edilio-paredes'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Edilio Paredes es un guitarrista y arreglista dominicano, y el músico que más hizo por darle a la bachata un estilo de guitarra propio. Grabó la primera guitarra de bastante más de mil temas a lo largo de tres décadas, y fueron sus arreglos los que separaron la bachata del bolero del que venía. En 2023 la revista Rolling Stone lo colocó en el puesto 244 de su lista de los 250 mejores guitarristas de todos los tiempos.","type":"text"}]},{"type":"paragraph","content":[{"text":"El tres sobre el mostrador","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació el 10 de septiembre de 1945 en La Galana, un campo cerca de San Francisco de Macorís, provincia Duarte, y fue el primero de su familia en cantar o tocar algo. Tocó un instrumento por primera vez a los cuatro años: el dueño del colmado tenía un tres sobre el mostrador y Paredes tuvo que ponerse de puntillas para alcanzarlo. Le sacó tres merengues de los que sonaban entonces. Después rompió una cuerda, el dueño se enfureció, y el niño de cuatro años juró no volver a tocar música.","type":"text"}]},{"type":"paragraph","content":[{"text":"Se retractó a los ocho y formó un grupo con su hermano Nelson y con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"449f86a9-d10e-4fff-976f-9581fb3d03a1","displayText":"Ramón Cordero","occurrenceId":"8dc9b50d-f233-4a49-a279-73151cd67acd"}},{"text":", amigo de infancia que llegaría a ser una figura del género por su cuenta. La guitarra y las primeras nociones se las dio un tío de Cordero; lo demás lo aprendió solo. Tocaban en fiestas de la zona lo de Odilio González, Julio Jaramillo y Blanca Iris Villafañe, y lo que él quería era tocar como el puertorriqueño Yomo Toro.","type":"text"}]},{"type":"paragraph","content":[{"text":"Casa Alegre","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A los trece se fue a Santo Domingo y entró a trabajar en Casa Alegre, la tienda de música de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy","occurrenceId":"374f4ef7-78ed-48e9-bd24-addf942f93c9"}},{"text":", que además tenía sello discográfico. Allí empezó a grabar, con Bernardo Ortiz, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3ae30a9a-5369-4084-8162-b2d470263f1e","displayText":"Rafael Encarnación","occurrenceId":"87786794-3d5e-4e4b-aeeb-00f1c11e730e"}},{"text":" y Mélida Pérez, y en poco tiempo había desplazado a los músicos mayores como el guitarrista más solicitado para grabar lo que entonces se llamaba bolero campesino, la música que después se llamaría bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"Radio Guarachita","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Pasó a grabar para ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena","occurrenceId":"9120d6c3-35d9-4072-b9f0-95ff9b91e33e"}},{"text":", dueño de Radio Guarachita. Era la única emisora nacional que ponía música de guitarra, y todo lo que ponía estaba grabado en alguno de los sellos del propio Aracena, de modo que casi cualquier bachatero del país pasó por allí en algún momento.","type":"text"}]},{"type":"paragraph","content":[{"text":"Paredes era el requinto principal de la emisora, es decir, la primera guitarra, lo que significa que casi todos esos cantantes grabaron con él. Las excepciones eran los pocos que tocaban su propia primera guitarra, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"5ceceef0-765d-4e01-8017-85422a263357","displayText":"Luis Segura","occurrenceId":"49ca7356-c3a7-4525-9884-51115a472ffb"}},{"text":" entre ellos.","type":"text"}]},{"type":"paragraph","content":[{"text":"La güira y el arreglo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La bachata cambió mucho en esos años. A principios de los sesenta apenas se distinguía del bolero anterior; a mediados de los setenta era rítmica y bailable, la güira había desplazado a las maracas y habían entrado elementos de son y de merengue en las líneas de guitarra. Paredes estuvo dentro de ese cambio y, como era quien hacía los arreglos, el cambio pasó en buena medida por sus manos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Su nombre va unido sobre todo al de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"449f86a9-d10e-4fff-976f-9581fb3d03a1","displayText":"Ramón Cordero","occurrenceId":"a4f556f5-ba4c-4df8-a6c0-23dbcb7920c4"}},{"text":", pero hizo trabajo de peso con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8faf8748-31f9-4dbc-bfe1-d5b7fd70244e","displayText":"Marino Pérez","occurrenceId":"df327277-80d2-464f-85cd-a4c0efaf31c4"}},{"text":", Bolívar Peralta, ","type":"text"},{"type":"artistReference","attrs":{"artistId":"31915623-3206-4052-b13a-2170226671b9","displayText":"Leonardo Paniagua","occurrenceId":"71464a81-1934-4746-bacf-92a1154ec832"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón","occurrenceId":"c5bc3531-c04f-4136-b997-b9a73152ed45"}},{"text":", y publicó además bastante obra propia.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los años de gira","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Ha seguido tocando y dirigiendo grupos, de gira con Super Uba y con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"40b02936-92e3-4149-98e8-0ba1118eeb7c","displayText":"Puerto Plata","occurrenceId":"ce3a0ddb-0682-4288-99b0-336a7c0ce815"}},{"text":", y ha participado en las giras de Bachata Roja junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"31915623-3206-4052-b13a-2170226671b9","displayText":"Leonardo Paniagua","occurrenceId":"fe14498f-1de9-4327-a498-8805a73e943f"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4d9ac6ac-6802-47f4-8731-5fa567713513","displayText":"Joan Soriano","occurrenceId":"e1bee277-321c-4b14-9466-525eb222d595"}},{"text":", que llevaron el estilo acústico antiguo a públicos de fuera del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"La música se quedó en la familia: su hermano Nelson tocó con él desde el principio, y sus tres hijos —David, Samuel y Nano— son músicos en activo.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'edilio-paredes'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'en'), '2171d4ad-a74e-4e09-b19b-c3d39f8d2a42', 'artist', '40b02936-92e3-4149-98e8-0ba1118eeb7c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'en'), '42ca2561-ec74-4ce7-9dca-000e13b5c95c', 'artist', '31915623-3206-4052-b13a-2170226671b9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'en'), '6ea9f009-206b-4039-affb-1ad86309d867', 'artist', '3ae30a9a-5369-4084-8162-b2d470263f1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'en'), '73223f08-c961-4e35-945f-7b7771c42a1c', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'en'), '786a4a46-af97-4b5d-be3b-1f4049e418a6', 'artist', '31915623-3206-4052-b13a-2170226671b9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'en'), '90ef1e57-3004-4758-aeb0-29a2d721b112', 'artist', '449f86a9-d10e-4fff-976f-9581fb3d03a1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'en'), '9b7d6955-8e7f-4cff-b916-96e0356f13f7', 'artist', '8faf8748-31f9-4dbc-bfe1-d5b7fd70244e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'en'), 'a96cb42d-dad8-4b86-b347-e8ca24c3b745', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'en'), 'afa60b29-f77e-4b6e-95aa-67758fd2150b', 'artist', '449f86a9-d10e-4fff-976f-9581fb3d03a1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'en'), 'b0b034f9-c5f3-47b7-8389-7032a8aee45f', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'en'), 'cdf67046-a6d8-4b71-848e-3d2711c2b1f5', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'en'), 'f57cd09c-7713-4200-b2fe-c29dc9259d13', 'artist', '4d9ac6ac-6802-47f4-8731-5fa567713513');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'es'), '374f4ef7-78ed-48e9-bd24-addf942f93c9', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'es'), '49ca7356-c3a7-4525-9884-51115a472ffb', 'artist', '5ceceef0-765d-4e01-8017-85422a263357');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'es'), '71464a81-1934-4746-bacf-92a1154ec832', 'artist', '31915623-3206-4052-b13a-2170226671b9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'es'), '87786794-3d5e-4e4b-aeeb-00f1c11e730e', 'artist', '3ae30a9a-5369-4084-8162-b2d470263f1e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'es'), '8dc9b50d-f233-4a49-a279-73151cd67acd', 'artist', '449f86a9-d10e-4fff-976f-9581fb3d03a1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'es'), '9120d6c3-35d9-4072-b9f0-95ff9b91e33e', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'es'), 'a4f556f5-ba4c-4df8-a6c0-23dbcb7920c4', 'artist', '449f86a9-d10e-4fff-976f-9581fb3d03a1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'es'), 'c5bc3531-c04f-4136-b997-b9a73152ed45', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'es'), 'ce3a0ddb-0682-4288-99b0-336a7c0ce815', 'artist', '40b02936-92e3-4149-98e8-0ba1118eeb7c');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'es'), 'df327277-80d2-464f-85cd-a4c0efaf31c4', 'artist', '8faf8748-31f9-4dbc-bfe1-d5b7fd70244e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'es'), 'e1bee277-321c-4b14-9466-525eb222d595', 'artist', '4d9ac6ac-6802-47f4-8731-5fa567713513');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'edilio-paredes') AND locale = 'es'), 'fe14498f-1de9-4327-a498-8805a73e943f', 'artist', '31915623-3206-4052-b13a-2170226671b9');

COMMIT;
