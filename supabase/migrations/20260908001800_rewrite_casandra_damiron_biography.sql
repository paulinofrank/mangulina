BEGIN;

-- Rewrite the catalogue entry for Casandra Damirón.
--
-- Casandra Damirón. UNDÉCIMA de las dieciocho, y la omisión más grande que he
-- visto en todo el lote.
--
-- LA FICHA NO DECÍA QUE LOS PREMIOS CASANDRA LLEVAN SU NOMBRE. El galardón más
-- importante del medio artístico dominicano se llama así por ella, y su
-- biografía en este catálogo no lo mencionaba. Tampoco decía que le decían LA
-- SOBERANA, que es de donde sale El Soberano.
--
-- Y HAY MÁS: eso explica algo que reporté hace dos días como defecto de la base
-- -- que existan "Premios Casandra" y "Premios Soberano" como dos entidades con
-- la misma organización, Acroarte. NO SON UN DUPLICADO. Son el mismo premio
-- antes y después de 2012, cuando cambió de nombre A RAÍZ DE UN CONFLICTO ENTRE
-- ACROARTE Y LA FAMILIA DE LA ARTISTA POR EL DERECHO SOBRE EL NOMBRE. Retiro mi
-- sospecha: la separación de las dos filas está bien hecha.
--
-- ESE CONFLICTO ENTRA EN LA BIOGRAFÍA. Es una disputa por derechos sobre un
-- nombre artístico, que es exactamente la clase de asunto que sí se registra,
-- igual que las disputas de créditos y regalías. No es vida privada.
--
-- LO DEMÁS QUE FALTABA, que es todo lo concreto: los 1.498 caracteres viejos no
-- nombraban una sola canción, ni un año, ni un escenario, ni un premio.
--
--   1955, LA FERIA DE LA PAZ. No había grupo que representara al país
--   anfitrión, y ella reunió casi de improviso a los mejores bailarines de la
--   isla y armó una compañía de danza folclórica: merengues, palos, mangulinas
--   y carabinés. De ahí salieron sus giras por Francia, Suiza, España, Suecia,
--   Estados Unidos y Argentina.
--
--   SU REPERTORIO ES CASI TODO DE LUIS RIVERA GONZÁLEZ. Catorce de las quince
--   canciones que la enciclopedia lista como suyas están firmadas por él.
--
--   "AQUÍ NOSOTROS", el programa de televisión folclórico que creó a mediados
--   de los setenta, los domingos por Radio Televisión Dominicana.
--
-- LUIS RIVERA ESTABA EN EL CATÁLOGO Y CASI DIGO QUE NO. Mi consulta directa por
-- nombre -- ilike '%luis rivera%' -- devolvió cero, porque la fila se llama
-- "Luis Armando Rivera González" y la cadena no aparece contigua. Es LA MISMA
-- TRAMPA de Luis "Terror" Días. verificar-faltantes.cjs lo encontró:
-- luis-armando-rivera-gonzalez, 1901, San Fernando de Monte Cristi,
-- primary_role composer. Coincide con la enciclopedia, que lo hace nativo de
-- Montecristi. Es él.
--
-- EL MATRIMONIO CON ÉL VA A LA TABLA, no a la prosa: se casaron el 4 de junio
-- de 1948 y siguieron casados hasta la muerte de ella en 1983, así que
-- relationship_status = 'ended_by_death'. Migración aparte.
--
-- SU TÍO FELLO DAMIRÓN SE NOMBRA SIN ENLAZAR, y a propósito. Fue quien le
-- preparó las presentaciones en La Voz del Yuna. El catálogo tiene un 'damiron'
-- que es Francisco Alberto Simó Damirón, el pianista. NO SÉ SI SON EL MISMO
-- HOMBRE. "Fello" podría ser hipocorístico de Francisco, pero podría no serlo,
-- y enlazar a un tío que a lo mejor no lo es sería inventar un parentesco.
-- Queda reportado como pregunta.
--
-- CINCO DEFECTOS DE LA FILA:
--
--   first_name decía 'Cassandra' CON DOS ESES, mientras que name dice
--   "Casandra Damirón" con una. La fuente escribe Casandra en todo el
--   artículo. Se alinea con name y QUEDA REPORTADO, porque no descarto que su
--   nombre de pila registral fuera con dos.
--
--   last_name estaba en NULL y sort_name también.
--
--   aliases estaba VACÍO, sin "La Soberana", que es el apodo del que sale el
--   nombre de un premio nacional.
--
--   occupations e instruments, vacíos los dos. Tocaba piano y guitarra.
--
-- NO SE AÑADE 'folklorist' A occupations aunque la enciclopedia la llama
-- folclorista, porque ese valor NO EXISTE en el vocabulario del catálogo y
-- ROLE_DICTIONARY.md dice que no se inventan roles. El trabajo folclórico se
-- cuenta en la prosa, que es donde cabe entero.
--
-- LO QUE SE DEJA FUERA: sus dos matrimonios en prosa, sus tres hijos, y la
-- causa de muerte, que es diagnóstico. La FERIA DE LA PAZ SÍ ENTRA aunque fuera
-- la conmemoración de los veinticinco años de Trujillo: es el marco en que
-- ocurrió su trabajo, y omitirlo dejaría sin explicar de dónde salió su
-- compañía de danza y por qué pudo viajar. Se cuenta el hecho, no se celebra.
--
-- LA CITA DE LA PRENSA FRANCESA SE PARAFRASEA y no se reproduce. Está traducida
-- del francés al español en la fuente y no tengo el original.
--
-- DOS ENLACES: luis-armando-rivera-gonzalez, autor de casi todo su repertorio,
-- y sonia-silvestre, a quien escogió en 1974 para atender a la delegación
-- cultural cubana. El segundo cierra por los dos lados, porque acabo de
-- escribirlo también en la ficha de Sonia.
--
-- EL RECONOCIMIENTO DEL SENADO VA EN MIGRACIÓN APARTE. Tenía CERO premios.
--
-- FUENTES: Wikipedia en español, que en su caso es larga y detallada. La fila
-- de luis-armando-rivera-gonzalez para confirmar la identidad del compositor.
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
       name = 'Casandra Damirón',
       sort_name = 'Damirón, Casandra',
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1919-03-12',
       birth_year = 1919,
       date_of_death = '1983-12-05',
       birth_place = 'Barahona',
       province = 'Barahona',
       first_name = 'Casandra',
       middle_name = NULL,
       last_name = 'Damirón',
       second_last_name = NULL,
       stage_name = NULL,
       aliases = ARRAY['La Soberana', 'La Soberana de la Canción']::text[],
       occupations = '["dancer","music educator"]'::jsonb,
       instruments = ARRAY['voice', 'piano', 'guitar']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Singer and folk dancer called La Soberana; the national arts awards carry her name',
       bio_en = 'Casandra Damirón was a Dominican singer, dancer and folklorist known throughout the country as La Soberana. She built the first Dominican folk dance company to travel abroad, and the highest awards in Dominican arts have carried her name since two years after her death.

**Barahona**

She was born in Barahona in 1919 and was performing at six, in the evenings the Teatro La Unión put on there. She learned piano and guitar as a girl, made her first formal appearance at eleven at the town’s cultural centre, and moved with her family to the colonial quarter of Santo Domingo in 1933.

**Club Antillas**

Her debut in the capital came in 1939 at the Club Antillas. She returned the following year on the night the Antillas orchestra opened there, directed by the pianist and composer Luis Armando Rivera González, newly back from Cuba, and sang a bolero of Agustín Lara’s in front of a full room. He began training her repertoire with her in the afternoons at the Ateneo Dominicano.

Her uncle Fello Damirón arranged a series of appearances for her on La Voz del Yuna, the Bonao station that then decided which Dominican performers the country heard. She stayed in Bonao, where the musicians passing through included Lope Balaguer, Esther Borja and Olga Chorens.

**La Soberana**

The songs that fixed her were Cosita Linda and Maldición Gitana, by the Panamanian composer Avelino Muñoz, in 1946. A contract in San Juan followed, her first season outside the country, and then Havana, where she worked the television programmes and the nightclubs alongside Benny Moré and came home with a stack of awards. The Cuban magazines of the period covered her as a visiting star rather than as a curiosity.

**The dance company**

In 1955 the government mounted a world’s fair in Santo Domingo, and the best folk companies of Europe and the Americas came to it while the host country had nothing formally representing it. Damirón gathered the best dancers on the island almost on the spot and made one: merengues, palos, mangulinas and carabinés, danced by people who had grown up with them.

The company was named ambassadors of Dominican culture, and it took her to France, Switzerland, Spain, Sweden, the United States and Argentina. After a performance in Paris the French press described her as an empress rather than a sovereign, and called her manner velvet and dynamite at once.

**The repertoire**

Almost everything she is remembered for singing was written by Luis Armando Rivera González: Reina, Rosas para Ti, Vida, Llegaste a Mí, Porque Dudas, Yo No Sé, Mi Cielo, Ella, La Salve de Monte Adentro, Baile Mi Merengue, El Merengue y la Plena and Noche Tropical, along with the music for Eres Todo en Mi Vida. Outside that catalogue she took Campanitas de Cristal, by the Puerto Rican Rafael Hernández.

**Aquí Nosotros**

She spent the rest of her life teaching. She founded dance schools, pushed for the arts to be studied in the public schools, and in the middle of the seventies created a folk television programme, Aquí Nosotros, broadcast on Sunday mornings on Dominican state television with the stated aim of teaching young people to dance their own rhythms. In 1974 she chose Sonia Silvestre to receive the Cuban national folkloric company during the games held in Santo Domingo, which is how Cuba first heard her.

**El Soberano**

She died in Santo Domingo in December 1983. Two years later the Association of Art Columnists founded the Premios Casandra in her name, and they ran under it until 2012, when a dispute between the association and her family over the rights to the name led to their being renamed the Premios Soberano — after her nickname rather than her name, which left the honour intact and the argument unresolved.

The Senate declared her a glory of national art and culture. The state television building carries her name by law, as do a station on the first line of the Santo Domingo metro, the avenue into Barahona and a neighbourhood of that city, and she has a star on the walk of fame on Avenida Winston Churchill.',
       bio_es = 'Casandra Damirón fue una cantante, bailarina y folclorista dominicana conocida en todo el país como La Soberana. Armó la primera compañía dominicana de danza folclórica que salió a girar por el mundo, y los máximos galardones de las artes dominicanas llevan su nombre desde dos años después de su muerte.

**Barahona**

Nació en Barahona en 1919 y ya actuaba a los seis años, en las veladas que organizaba allí el Teatro La Unión. Aprendió piano y guitarra de niña, hizo su primera presentación formal a los once en el centro de cultura del pueblo, y en 1933 se mudó con su familia a la Zona Colonial de Santo Domingo.

**Club Antillas**

Su debut en la capital fue en 1939, en el Club Antillas. Volvió al año siguiente, la noche en que estrenaba allí la orquesta Antillas dirigida por el pianista y compositor Luis Armando Rivera González, recién llegado de Cuba, y cantó un bolero de Agustín Lara delante de una sala llena. Él se puso a trabajarle el repertorio por las tardes en el Ateneo Dominicano.

Su tío Fello Damirón le preparó una serie de presentaciones en La Voz del Yuna, la emisora de Bonao que entonces decidía a qué artistas dominicanos oía el país. Se quedó en Bonao, donde por allí pasaban Lope Balaguer, Esther Borja y Olga Chorens.

**La Soberana**

Las canciones que la fijaron fueron Cosita Linda y Maldición Gitana, del compositor panameño Avelino Muñoz, en 1946. Detrás vino un contrato en San Juan, su primera temporada fuera del país, y después La Habana, donde trabajó los programas de televisión y los clubes nocturnos junto a Benny Moré y de donde volvió cargada de reconocimientos. Las revistas cubanas de la época la cubrieron como estrella de visita y no como curiosidad.

**La compañía de danza**

En 1955 el gobierno montó una feria mundial en Santo Domingo, y llegaron a ella las mejores compañías folclóricas de Europa y América mientras el país anfitrión no tenía nada que lo representara formalmente. Damirón reunió casi sobre la marcha a los mejores bailarines de la isla y la armó: merengues, palos, mangulinas y carabinés, bailados por gente que se había criado con ellos.

A la compañía la nombraron embajadora de la cultura dominicana, y con ella viajó a Francia, Suiza, España, Suecia, Estados Unidos y Argentina. Después de una función en París la prensa francesa escribió que no era una soberana sino una emperatriz, y describió su manera como terciopelo y dinamita a la vez.

**El repertorio**

Casi todo lo que se recuerda cantado por ella lo escribió Luis Armando Rivera González: Reina, Rosas para Ti, Vida, Llegaste a Mí, Porque Dudas, Yo No Sé, Mi Cielo, Ella, La Salve de Monte Adentro, Baile Mi Merengue, El Merengue y la Plena y Noche Tropical, además de la música de Eres Todo en Mi Vida. Fuera de ese catálogo tomó Campanitas de Cristal, del puertorriqueño Rafael Hernández.

**Aquí Nosotros**

El resto de su vida lo dedicó a enseñar. Fundó escuelas de baile, empujó para que las artes se estudiaran en la escuela pública, y a mediados de los setenta creó un programa de televisión folclórico, Aquí Nosotros, que salía los domingos por la mañana en la televisión estatal con el propósito declarado de que los jóvenes aprendieran a bailar sus propios ritmos. En 1974 escogió a Sonia Silvestre para atender a la compañía folclórica nacional de Cuba durante los juegos celebrados en Santo Domingo, y así fue como Cuba la oyó por primera vez.

**El Soberano**

Murió en Santo Domingo en diciembre de 1983. Dos años después la Asociación de Cronistas de Arte fundó en su nombre los Premios Casandra, que se celebraron así hasta 2012, cuando un conflicto entre la asociación y la familia de la artista por el derecho sobre el nombre llevó a rebautizarlos Premios Soberano — por su apodo en vez de por su nombre, lo que dejó el homenaje en pie y la discusión sin resolver.

El Senado la declaró gloria del arte y la cultura nacional. El edificio de la televisión estatal lleva su nombre por ley, igual que una estación de la línea 1 del metro de Santo Domingo, la avenida de entrada a Barahona y un barrio de esa ciudad, y tiene una estrella en el paseo de la avenida Winston Churchill.',
       updated_at = now()
 WHERE slug = 'casandra-damiron';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'casandra-damiron')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'casandra-damiron')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Casandra Damirón was a Dominican singer, dancer and folklorist known throughout the country as La Soberana. She built the first Dominican folk dance company to travel abroad, and the highest awards in Dominican arts have carried her name since two years after her death.","type":"text"}]},{"type":"paragraph","content":[{"text":"Barahona","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She was born in Barahona in 1919 and was performing at six, in the evenings the Teatro La Unión put on there. She learned piano and guitar as a girl, made her first formal appearance at eleven at the town’s cultural centre, and moved with her family to the colonial quarter of Santo Domingo in 1933.","type":"text"}]},{"type":"paragraph","content":[{"text":"Club Antillas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Her debut in the capital came in 1939 at the Club Antillas. She returned the following year on the night the Antillas orchestra opened there, directed by the pianist and composer ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aefd5b14-694e-4f3e-ad31-ade13f14ca64","displayText":"Luis Armando Rivera González","occurrenceId":"b5598738-39dd-44cf-9a94-7122ce4b4a07"}},{"text":", newly back from Cuba, and sang a bolero of Agustín Lara’s in front of a full room. He began training her repertoire with her in the afternoons at the Ateneo Dominicano.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her uncle Fello Damirón arranged a series of appearances for her on La Voz del Yuna, the Bonao station that then decided which Dominican performers the country heard. She stayed in Bonao, where the musicians passing through included Lope Balaguer, Esther Borja and Olga Chorens.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Soberana","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The songs that fixed her were Cosita Linda and Maldición Gitana, by the Panamanian composer Avelino Muñoz, in 1946. A contract in San Juan followed, her first season outside the country, and then Havana, where she worked the television programmes and the nightclubs alongside Benny Moré and came home with a stack of awards. The Cuban magazines of the period covered her as a visiting star rather than as a curiosity.","type":"text"}]},{"type":"paragraph","content":[{"text":"The dance company","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1955 the government mounted a world’s fair in Santo Domingo, and the best folk companies of Europe and the Americas came to it while the host country had nothing formally representing it. Damirón gathered the best dancers on the island almost on the spot and made one: merengues, palos, mangulinas and carabinés, danced by people who had grown up with them.","type":"text"}]},{"type":"paragraph","content":[{"text":"The company was named ambassadors of Dominican culture, and it took her to France, Switzerland, Spain, Sweden, the United States and Argentina. After a performance in Paris the French press described her as an empress rather than a sovereign, and called her manner velvet and dynamite at once.","type":"text"}]},{"type":"paragraph","content":[{"text":"The repertoire","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Almost everything she is remembered for singing was written by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aefd5b14-694e-4f3e-ad31-ade13f14ca64","displayText":"Luis Armando Rivera González","occurrenceId":"0d02171a-5c79-4822-b983-7ff3afdf9029"}},{"text":": Reina, Rosas para Ti, Vida, Llegaste a Mí, Porque Dudas, Yo No Sé, Mi Cielo, Ella, La Salve de Monte Adentro, Baile Mi Merengue, El Merengue y la Plena and Noche Tropical, along with the music for Eres Todo en Mi Vida. Outside that catalogue she took Campanitas de Cristal, by the Puerto Rican Rafael Hernández.","type":"text"}]},{"type":"paragraph","content":[{"text":"Aquí Nosotros","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She spent the rest of her life teaching. She founded dance schools, pushed for the arts to be studied in the public schools, and in the middle of the seventies created a folk television programme, Aquí Nosotros, broadcast on Sunday mornings on Dominican state television with the stated aim of teaching young people to dance their own rhythms. In 1974 she chose ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre","occurrenceId":"5255d122-020f-4cee-9c49-72b291838112"}},{"text":" to receive the Cuban national folkloric company during the games held in Santo Domingo, which is how Cuba first heard her.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Soberano","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She died in Santo Domingo in December 1983. Two years later the Association of Art Columnists founded the Premios Casandra in her name, and they ran under it until 2012, when a dispute between the association and her family over the rights to the name led to their being renamed the Premios Soberano — after her nickname rather than her name, which left the honour intact and the argument unresolved.","type":"text"}]},{"type":"paragraph","content":[{"text":"The Senate declared her a glory of national art and culture. The state television building carries her name by law, as do a station on the first line of the Santo Domingo metro, the avenue into Barahona and a neighbourhood of that city, and she has a star on the walk of fame on Avenida Winston Churchill.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'casandra-damiron'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Casandra Damirón fue una cantante, bailarina y folclorista dominicana conocida en todo el país como La Soberana. Armó la primera compañía dominicana de danza folclórica que salió a girar por el mundo, y los máximos galardones de las artes dominicanas llevan su nombre desde dos años después de su muerte.","type":"text"}]},{"type":"paragraph","content":[{"text":"Barahona","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Barahona en 1919 y ya actuaba a los seis años, en las veladas que organizaba allí el Teatro La Unión. Aprendió piano y guitarra de niña, hizo su primera presentación formal a los once en el centro de cultura del pueblo, y en 1933 se mudó con su familia a la Zona Colonial de Santo Domingo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Club Antillas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su debut en la capital fue en 1939, en el Club Antillas. Volvió al año siguiente, la noche en que estrenaba allí la orquesta Antillas dirigida por el pianista y compositor ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aefd5b14-694e-4f3e-ad31-ade13f14ca64","displayText":"Luis Armando Rivera González","occurrenceId":"645802e8-1f69-4553-9df8-4a9847a0855e"}},{"text":", recién llegado de Cuba, y cantó un bolero de Agustín Lara delante de una sala llena. Él se puso a trabajarle el repertorio por las tardes en el Ateneo Dominicano.","type":"text"}]},{"type":"paragraph","content":[{"text":"Su tío Fello Damirón le preparó una serie de presentaciones en La Voz del Yuna, la emisora de Bonao que entonces decidía a qué artistas dominicanos oía el país. Se quedó en Bonao, donde por allí pasaban Lope Balaguer, Esther Borja y Olga Chorens.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Soberana","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Las canciones que la fijaron fueron Cosita Linda y Maldición Gitana, del compositor panameño Avelino Muñoz, en 1946. Detrás vino un contrato en San Juan, su primera temporada fuera del país, y después La Habana, donde trabajó los programas de televisión y los clubes nocturnos junto a Benny Moré y de donde volvió cargada de reconocimientos. Las revistas cubanas de la época la cubrieron como estrella de visita y no como curiosidad.","type":"text"}]},{"type":"paragraph","content":[{"text":"La compañía de danza","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1955 el gobierno montó una feria mundial en Santo Domingo, y llegaron a ella las mejores compañías folclóricas de Europa y América mientras el país anfitrión no tenía nada que lo representara formalmente. Damirón reunió casi sobre la marcha a los mejores bailarines de la isla y la armó: merengues, palos, mangulinas y carabinés, bailados por gente que se había criado con ellos.","type":"text"}]},{"type":"paragraph","content":[{"text":"A la compañía la nombraron embajadora de la cultura dominicana, y con ella viajó a Francia, Suiza, España, Suecia, Estados Unidos y Argentina. Después de una función en París la prensa francesa escribió que no era una soberana sino una emperatriz, y describió su manera como terciopelo y dinamita a la vez.","type":"text"}]},{"type":"paragraph","content":[{"text":"El repertorio","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Casi todo lo que se recuerda cantado por ella lo escribió ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aefd5b14-694e-4f3e-ad31-ade13f14ca64","displayText":"Luis Armando Rivera González","occurrenceId":"8d97400d-d14c-4f1e-aa25-d6067d7e8eb2"}},{"text":": Reina, Rosas para Ti, Vida, Llegaste a Mí, Porque Dudas, Yo No Sé, Mi Cielo, Ella, La Salve de Monte Adentro, Baile Mi Merengue, El Merengue y la Plena y Noche Tropical, además de la música de Eres Todo en Mi Vida. Fuera de ese catálogo tomó Campanitas de Cristal, del puertorriqueño Rafael Hernández.","type":"text"}]},{"type":"paragraph","content":[{"text":"Aquí Nosotros","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El resto de su vida lo dedicó a enseñar. Fundó escuelas de baile, empujó para que las artes se estudiaran en la escuela pública, y a mediados de los setenta creó un programa de televisión folclórico, Aquí Nosotros, que salía los domingos por la mañana en la televisión estatal con el propósito declarado de que los jóvenes aprendieran a bailar sus propios ritmos. En 1974 escogió a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre","occurrenceId":"58d61b6d-2fee-4831-aee6-fe94e61c2d3e"}},{"text":" para atender a la compañía folclórica nacional de Cuba durante los juegos celebrados en Santo Domingo, y así fue como Cuba la oyó por primera vez.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Soberano","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Murió en Santo Domingo en diciembre de 1983. Dos años después la Asociación de Cronistas de Arte fundó en su nombre los Premios Casandra, que se celebraron así hasta 2012, cuando un conflicto entre la asociación y la familia de la artista por el derecho sobre el nombre llevó a rebautizarlos Premios Soberano — por su apodo en vez de por su nombre, lo que dejó el homenaje en pie y la discusión sin resolver.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Senado la declaró gloria del arte y la cultura nacional. El edificio de la televisión estatal lleva su nombre por ley, igual que una estación de la línea 1 del metro de Santo Domingo, la avenida de entrada a Barahona y un barrio de esa ciudad, y tiene una estrella en el paseo de la avenida Winston Churchill.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'casandra-damiron'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'casandra-damiron') AND locale = 'en'), '0d02171a-5c79-4822-b983-7ff3afdf9029', 'artist', 'aefd5b14-694e-4f3e-ad31-ade13f14ca64');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'casandra-damiron') AND locale = 'en'), '5255d122-020f-4cee-9c49-72b291838112', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'casandra-damiron') AND locale = 'en'), 'b5598738-39dd-44cf-9a94-7122ce4b4a07', 'artist', 'aefd5b14-694e-4f3e-ad31-ade13f14ca64');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'casandra-damiron') AND locale = 'es'), '58d61b6d-2fee-4831-aee6-fe94e61c2d3e', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'casandra-damiron') AND locale = 'es'), '645802e8-1f69-4553-9df8-4a9847a0855e', 'artist', 'aefd5b14-694e-4f3e-ad31-ade13f14ca64');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'casandra-damiron') AND locale = 'es'), '8d97400d-d14c-4f1e-aa25-d6067d7e8eb2', 'artist', 'aefd5b14-694e-4f3e-ad31-ade13f14ca64');

COMMIT;
