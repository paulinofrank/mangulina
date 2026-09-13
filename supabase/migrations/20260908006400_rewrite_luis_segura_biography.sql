BEGIN;

-- Rewrite the catalogue entry for Luis Segura.
--
-- Luis Segura. DUODÉCIMA de las 211, y la primera del bloque con 12 enlaces
-- entrantes. La ficha vieja tenía 2.127 caracteres en CUATRO PÁRRAFOS SEGUIDOS,
-- sin secciones, sin enlaces, sin premios y SIN UN SOLO DATO CONCRETO.
--
-- No nombraba "Pena por ti". No nombraba "Cariñito de mi vida". No daba el día
-- de nacimiento que la propia fila guarda, ni un año de disco, ni un premio, ni
-- un colaborador. Decía "his recording career spanned several decades and
-- produced hundreds of songs" y "his contributions have been honored by music
-- historians and fellow artists alike". Es la ficha del amargue, no la suya.
--
-- ---------------------------------------------------------------------------
-- EL NOMBRE LEGAL ESTABA A MEDIAS: se llama LUIS GONZAGA SEGURA. La fila
-- guardaba first_name 'Luis' y nada más. Lo confirman Wikipedia en español y,
-- mejor todavía, LA LÍNEA DE CRÉDITOS DE SU PROPIO CANAL: "Composición: Luis
-- Gonzaga Segura". Metadato de derechos, no prosa de enciclopedia. Se añade
-- middle_name 'Gonzaga' y se corrige sort_name.
--
-- El apellido de la madre es Segura; el padre se apellidaba Valenzuela. NO
-- invento un segundo apellido: second_last_name se queda en NULL.
-- ---------------------------------------------------------------------------
--
-- EL ALIAS ESTABA MAL ESCRITO: la fila guardaba "El Papa de la Bachata", sin
-- tilde, que es otra cosa. Se corrige a "El Papá de la Bachata" y se añade "El
-- Añoñaito", que es su otro sobrenombre y no estaba.
--
-- LA GRAFÍA DE ESE SEGUNDO ALIAS QUEDA ANOTADA PARA EL PROCESO DE ORTOGRAFÍA:
-- Wikipedia lo escribe "El añoñaíto" en el infobox y "El Añoñaito" en el
-- cuerpo; su disco de 1989 y los títulos de su propio canal usan "Añoñaito".
-- Guardo la forma que usan él y la prensa.
--
-- LO QUE FALTABA, QUE ES TODO:
--
--   "CARIÑITO DE MI VIDA" (1964), con la que se hace conocido y con la que el
--   público le pone "El Añoñaito" por la melancolía de su manera de cantar.
--
--   "PENA POR TI", compuesta en 1981 y publicada en 1982. FUE DE LAS PRIMERAS
--   BACHATAS EN SONAR EN FM, cuando el género vivía en AM y en el campo, y su
--   éxito ayudó a fijar la palabra "bachata" en lugar de "música de amargue".
--   Ese es el dato que la ficha vieja intentaba decir con adjetivos.
--
--   RADIO GUARACHITA: en 1966 RADHAMÉS ARACENA lo mete en su emisora. Aracena
--   ya está en el catálogo y ya enlazaba hacia él; ahora el enlace es mutuo.
--
--   JOSÉ MANUEL CALDERÓN grabó "Cariñito de mi vida" en ranchera y después "Me
--   siento conmovido" y "Agonía". También estaba en el catálogo enlazándolo.
--
--   EL PALACIO NACIONAL, 1997: primer bachatero en presentarse allí.
--
--   LA UNESCO, 11 de diciembre de 2019, y el récord Guinness DOS AÑOS DESPUÉS
--   AL DÍA: 489 parejas bailando "Pena por ti" a la vez en la George
--   Washington. Tocaron en vivo Joe Veras, Alexandra, Kiko Rodríguez, Daniel
--   Santacruz y él.
--
--   EL ÁLBUM DE 2020 CON CUARENTA DÚOS, nominado al Latin Grammy.
--
--   SU RETIRO EN 2023 con el concierto "Fin de la historia".
--
-- LA PROHIBICIÓN DE LA UASD ENTRA. En 1983 ASODEMU lo invitó al aula magna y el
-- rector JOSÉ JOAQUÍN BIDÓ MEDINA se opuso; el 15 de julio circuló una demanda
-- a las autoridades universitarias para que cesaran esas presentaciones, que
-- según él fomentaban "bajas pasiones sexuales". Cantó igual.
--
-- Es censura sobre la obra, mismo criterio por el que entraron "Maniquí" de
-- Chimbala esta tarde, "Desacato Escolar" de Tokischa y los viajes prohibidos
-- de Víctor Víctor. Y como en Chimbala, el matiz importa: no prosperó.
--
-- LA DISPUTA DE AUTORÍA CON BONNY CEPEDA ENTRA, y es de los datos que más me
-- costó decidir. Segura demandó a Cepeda ante la Octava Cámara Civil y
-- Comercial del Distrito Nacional por los derechos de "Pena por ti",
-- reclamando daños y violación al derecho de autor. CEPEDA LO NIEGA en público
-- y por escrito: "Nunca me he atribuido la autoría del tema Pena por ti, que
-- entiendo es del señor Luis Segura".
--
-- ES CIVIL, NO PENAL, así que no choca con la regla de asuntos penales; y es
-- exactamente el caso que la regla de disputas de crédito y autoría manda
-- incluir. Se escribe SIN TOMAR PARTIDO: lo que Segura alega, lo que Cepeda
-- responde, y que en 2026 seguía en tribunales. No hay sentencia que reportar.
--
-- LO QUE SE DEJA FUERA: que su madre se oponía a que cantara bachata, quién es
-- su madre y quién su padre, y que su mánager es su hijo. Vida privada. TAMPOCO
-- ENTRA que su padre fuera acordeonista, aunque sea su primera influencia
-- musical: la regla dice oficios de los padres, y la regla manda. QUEDA ANOTADO
-- EN MUSICOS_PENDIENTES por si el editor decide otra cosa.
--
-- NO SE ESCRIBEN LAS REPRODUCCIONES ni los seguidores.
--
-- EL VALOR DE 489 PAREJAS: hay fuentes que dicen 500 y una que dice 600. Uso
-- 489, que es la que repiten Infobae, la prensa que cubrió la homologación y
-- las notas oficiales. Las otras dos son redondeos de titular.
--
-- LAS REDES ESTABAN TODAS VACÍAS y su propio sitio tiene un enlace roto: manda
-- a facebook.com/luiseguraelpapa, con una sola ese, y esa página no existe. La
-- buena es luisseguraelpapa. Verificadas una por una en el navegador:
--   facebook  luisseguraelpapa   (Page - Artist, enlaza a su sitio oficial)
--   instagram luisseguraelpapa   ("Mi vida es una Bachata")
--   youtube   @LuisSeguraElPapa  (su canal de artista)
--   website   luisseguraoficial.com
-- SU SITIO ENLAZA AL CANAL SECUNDARIO ("Añoña Las de Papá", UCu3Dt2...), no al
-- suyo. Guardo el del artista. El de X (@LuisSeguraPage) es real pero la tabla
-- no tiene columna para X.
--
-- CATORCE ENLACES, todos por crédito documentado. Es mucho, y es correcto: este
-- hombre es un nodo. TREINTA Y DOS DE LOS CUARENTA ARTISTAS del álbum de 2020
-- ya están en el catálogo.
--
-- FUENTES: Wikipedia en español, bien referenciada. Su sitio oficial, para la
-- discografía y el reparto completo de los cuatro volúmenes. Wikipedia en
-- inglés para VERIFICAR APARTE la nominación al Latin Grammy, que su propio
-- sitio anuncia y que yo no iba a dar por buena sin lista oficial: está en las
-- nominaciones finales de la 22.ª entrega. Diario Libre (22 oct 2025) para la
-- historia de "Pena por ti", la FM y el récord. RD Música (13 ene 2025) para la
-- demanda y la respuesta de Cepeda. Listín Diario, El Nuevo Diario y Primera
-- Hora para las fechas del proceso. ACROARTE para el Gran Soberano.
--
-- AUSENCIAS REALES, del reparto del álbum:
--   ROMEO SANTOS. Es la cuarta ficha que lo nombra y sigue sin estar.
--   YIYO SARANTE, ANDY ANDY, EDWARD SEGURA, ODALÍ FERRERAS.
--   RAFY MERCENARIO, productor, ya anotado desde Don Miguelo.
--
-- ---------------------------------------------------------------------------
-- MI BUSCADOR TENÍA UN FALLO DE ACENTOS Y ME INVENTÓ CUATRO AUSENCIAS
--
-- Escribí primero que VICENTE GARCÍA no estaba. Está, publicado, y lo cazó
-- nombres-sin-enlazar.cjs cuando ya había aplicado la ficha. El buscador hacía
-- un ILIKE crudo: '%vicente garcia%' no casa con "Vicente García" por la tilde
-- de la í, ni con el slug 'vicente-garcia' por el guion.
--
-- Al arreglarlo aparecieron otras tres que había dado por ausentes hoy mismo:
-- RAFAEL ENCARNACIÓN, MÁRTIRES DE LEÓN y, por el mismo motivo de forma larga,
-- EL CHAVAL DE LA BACHATA. Las cuatro estaban publicadas.
--
-- like.cjs ahora normaliza acentos y trata guiones y espacios como lo mismo, y
-- distingue "coincide por nombre" de "coincide solo por alias". Toca repasar
-- ARTISTAS_FALTANTES.md entero con el buscador corregido.
-- ---------------------------------------------------------------------------
--
-- SE AÑADE EL ENLACE A VICENTE GARCÍA en el párrafo de la Unesco, donde ya
-- estaba nombrado sin enlazar.
--
-- ---------------------------------------------------------------------------
-- CORRECCIÓN, unas horas después de aplicar la ficha
--
-- ESCRIBÍ QUE ERA "EL SEGUNDO BACHATERO" EN RECIBIR EL GRAN SOBERANO. NO LO ES,
-- Y LA FRASE SALE.
--
-- La saqué de un pie de Instagram de ACROARTE que decía exactamente eso. Al
-- preparar la ficha de Frank Reyes fui a la lista completa de ganadores y
-- aparecieron, antes que él: ANTONY SANTOS (2019), AVENTURA (2010) y ROMEO
-- SANTOS (2021). Tres de bachata, no uno.
--
-- No sé qué contaba ACROARTE en ese pie -- puede que excluyera a los nacidos
-- fuera del país, puede que fuera un descuido--, pero la lista de treinta y un
-- galardones desmiente la frase, así que la frase se va. Queda el dato duro:
-- lo recibió en marzo de 2023 y Antony Santos lo tenía desde cuatro años antes.
--
-- EL AÑO AL QUE CORRESPONDE EL PREMIO TAMBIÉN QUEDA EN DISPUTA y se retira del
-- campo `work`: la prensa dominicana lo llamó "Gran Soberano 2021" y la tabla
-- de Wikipedia lo coloca en 2022. Lo indiscutible es la 38.ª entrega, marzo de
-- 2023, y eso es lo que se guarda.
--
-- De paso salieron CINCO CONFLICTOS entre lo que guarda la tabla de premios y
-- el historial de ACROARTE, que NO toco y quedan reportados en
-- PREMIOS_GRAN_SOBERANO.md.
-- ---------------------------------------------------------------------------
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
       name = 'Luis Segura',
       sort_name = 'Segura, Luis Gonzaga',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'bachata',
       date_of_birth = '1939-06-21',
       birth_year = 1939,
       date_of_death = NULL,
       birth_place = 'Mao',
       province = 'Valverde',
       first_name = 'Luis',
       middle_name = 'Gonzaga',
       last_name = 'Segura',
       second_last_name = NULL,
       stage_name = 'Luis Segura',
       aliases = ARRAY['El Papá de la Bachata', 'El Añoñaito']::text[],
       occupations = '["composer","guitarist"]'::jsonb,
       instruments = ARRAY['voice', 'guitar', 'requinto']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = 'https://www.luisseguraoficial.com',
       youtube = '@LuisSeguraElPapa',
       facebook = 'luisseguraelpapa',
       instagram = 'luisseguraelpapa',
       disambiguation = 'Founding bachata singer and composer of Pena por ti, known as El Papá de la Bachata',
       bio_en = 'Luis Gonzaga Segura, who records as Luis Segura, is a Dominican bachata singer, composer and guitarist from Mao. He recorded without interruption from 1964 until his retirement in 2023, an unbroken run of nearly sixty years that no other performer in the genre has matched, and he is known across the country as El Papá de la Bachata.

**The guitars he built**

He was born on 21 June 1939 in Mao, in the province of Valverde, in the north-west of the country. From the age of eight he lived in a rural part of the municipality, where he made guitars out of whatever materials came to hand and played them walking through the streets; the constant noise earned him the nickname Guirí Guirí. He also learned güira, tambora, maracas and several stringed instruments.

At twelve he moved to Santo Domingo and began entering music festivals and radio competitions, where he was noticed as an instrumentalist as much as a singer and where he leaned particularly on the requinto.

**Cariñito de mi vida**

Cariñito de mi vida, released in 1964, made his name at home. Audiences gave him a second nickname, El Añoñaito, for the melancholy his delivery produced, and it stayed with him for the rest of his career. Bachata had almost no radio in that decade, and the following he assembled was built without it.

Other performers took up his songs early. José Manuel Calderón recorded Cariñito de mi vida as a ranchera and later cut Me siento conmovido and Agonía. In 1966 Radhamés Aracena brought him into Radio Guarachita, the station he ran for bachata and guitar music, and from that point the records had somewhere to be heard.

**Pena por ti**

He wrote Pena por ti in 1981 and released it the following year. It is the song by which the genre is identified, and he has called it his anthem.

Part of what made it matter is where it was played. It was among the first bachatas to reach FM stations, at a time when the music was confined to AM and to rural audiences, and it crossed the class barrier that had kept the genre off urban Dominican radio. Its success also helped settle the word bachata as the name of the music, in place of música de amargue, the term under which the press had filed it.

**The aula magna**

In 1983 the university employees’ association ASODEMU invited him to perform at the Universidad Autónoma de Santo Domingo. The rector, José Joaquín Bidó Medina, objected that the music had no place in the university’s cultural programme, and on 15 July of that year he circulated a demand to the university authorities that such performances cease, on the grounds that they encouraged base sexual passions. The performance in the aula magna went ahead.

Institutional acceptance arrived later. In 1997, during the presidency of Leonel Fernández, he became the first bachata performer to appear at the National Palace.

**A heritage declaration**

On 11 December 2019 Unesco inscribed bachata on its list of the intangible cultural heritage of humanity. At the ceremony in Bogotá, Pena por ti was sung by José Antonio Rodríguez, then the Dominican ambassador to Unesco, together with the singer-songwriter Vicente García.

Two years later to the day, 489 couples danced to the same song simultaneously on the avenida George Washington in Santo Domingo, taking the Guinness world record for the largest bachata dance. The music was played live by Joe Veras, Alexandra Queen, Kiko Rodríguez, Daniel Santacruz and Segura himself.

**Forty duets**

On 30 October 2020 he released El Papá de la Bachata, su legado, forty of his own compositions re-recorded as duets with forty other artists and issued in four volumes titled Añoñado I to IV. The guest list crosses genres and generations: Antony Santos, Johnny Ventura, Fefita la Grande, Leonardo Paniagua, Cuco Valoy and El Chaval de la Bachata are on it, along with Romeo Santos, the Puerto Rican Danny Rivera and the Colombian Charlie Zaa.

The album was nominated for best merengue or bachata album at the twenty-second Latin Grammy Awards in 2021. At its launch the Senate of the Dominican Republic handed him a resolution naming him the father of bachata.

**Fin de la historia**

He announced his retirement in 2023 and closed the career with a concert of that name at the Gran Arena del Cibao in Santiago. Behind him were some thirty productions and more than five hundred songs of his own writing.

The municipality of Mao named a street after him in November 2008. ACROARTE gave him the Casandra al Mérito in 2010, and at the thirty-eighth Premios Soberano, in March 2023, the same body gave him El Gran Soberano, the highest distinction a Dominican artist receives at home. Antony Santos had received it four years earlier.

**The authorship of Pena por ti**

Segura brought a civil claim against Bonny Cepeda before the eighth civil and commercial chamber of the National District, alleging that Cepeda had improperly taken the authors’ rights to Pena por ti and altered the composition without permission, and seeking damages. Cepeda answered in public that he had never claimed the authorship, that he had always understood the song to belong to Segura, and that the notification wrongly named him as its author. The matter was still before the courts in 2026.',
       bio_es = 'Luis Gonzaga Segura, que graba como Luis Segura, es un cantante, compositor y guitarrista dominicano de bachata, natural de Mao. Grabó sin interrupción desde 1964 hasta su retiro en 2023, casi sesenta años seguidos que ningún otro intérprete del género ha igualado, y en todo el país se le conoce como El Papá de la Bachata.

**Las guitarras que fabricaba**

Nació el 21 de junio de 1939 en Mao, provincia Valverde, en el noroeste del país. Desde los ocho años vivió en una zona rural del municipio, donde armaba guitarras con los materiales que tuviera a mano y las tocaba caminando por las calles; del ruido constante le vino el apodo de Guirí Guirí. Aprendió además güira, tambora, maracas y varios instrumentos de cuerda.

A los doce se fue a Santo Domingo y empezó a presentarse en festivales y en programas de concurso, donde llamó la atención tanto por su ejecución como por su voz y donde se apoyó sobre todo en el requinto.

**Cariñito de mi vida**

Cariñito de mi vida, de 1964, lo dio a conocer en el país. El público le puso entonces el segundo apodo, El Añoñaito, por la melancolía que producía su manera de cantar, y le quedó para el resto de la carrera. En esa década la bachata casi no tenía radio, y el público que reunió lo reunió sin ella.

Otros intérpretes tomaron sus canciones temprano. José Manuel Calderón grabó Cariñito de mi vida en ranchera y más adelante Me siento conmovido y Agonía. En 1966 Radhamés Aracena lo incorporó a Radio Guarachita, la emisora que sostenía para la bachata y la música de cuerda, y desde ahí sus discos tuvieron dónde sonar.

**Pena por ti**

Compuso Pena por ti en 1981 y la publicó al año siguiente. Es la canción con la que se identifica el género, y él mismo la ha llamado su himno.

Parte de su peso está en dónde sonó. Fue de las primeras bachatas en llegar a emisoras de frecuencia modulada, cuando la música vivía en la amplitud modulada y en el público rural, y atravesó la barrera de clase que había mantenido al género fuera de la radio urbana dominicana. Su éxito ayudó además a asentar la palabra bachata como nombre de la música, en lugar de música de amargue, que era el término con que la prensa la despachaba.

**El aula magna**

En 1983 la asociación de empleados universitarios ASODEMU lo invitó a presentarse en la Universidad Autónoma de Santo Domingo. El rector, José Joaquín Bidó Medina, se opuso alegando que esa música no debía formar parte del programa cultural de la universidad, y el 15 de julio de ese año circuló una demanda a las autoridades universitarias para que cesaran las presentaciones de ese tipo, por entender que fomentaban bajas pasiones sexuales. La presentación en el aula magna se hizo igual.

La aceptación institucional llegó después. En 1997, durante la presidencia de Leonel Fernández, fue el primer bachatero en presentarse en el Palacio Nacional.

**Patrimonio de la humanidad**

El 11 de diciembre de 2019 la Unesco inscribió la bachata en la lista del patrimonio cultural inmaterial de la humanidad. En la ceremonia, celebrada en Bogotá, Pena por ti la cantaron José Antonio Rodríguez, entonces embajador dominicano ante la Unesco, y el cantautor Vicente García.

Dos años después, el mismo día, 489 parejas bailaron esa canción a la vez en la avenida George Washington de Santo Domingo y obtuvieron el récord Guinness del baile de bachata más grande. La música la tocaron en vivo Joe Veras, Alexandra Queen, Kiko Rodríguez, Daniel Santacruz y el propio Segura.

**Cuarenta dúos**

El 30 de octubre de 2020 publicó El Papá de la Bachata, su legado: cuarenta composiciones suyas regrabadas a dúo con otros tantos artistas y repartidas en cuatro volúmenes titulados Añoñado I a IV. El reparto cruza géneros y generaciones: están Antony Santos, Johnny Ventura, Fefita la Grande, Leonardo Paniagua, Cuco Valoy y El Chaval de la Bachata, junto a Romeo Santos, el puertorriqueño Danny Rivera y el colombiano Charlie Zaa.

El álbum fue nominado a mejor álbum de merengue o bachata en la vigésima segunda entrega de los Latin Grammy, en 2021. En su lanzamiento el Senado de la República le entregó una resolución que lo declaraba padre de la bachata.

**Fin de la historia**

Anunció su retiro en 2023 y cerró la carrera con un concierto de ese nombre en la Gran Arena del Cibao, en Santiago. Detrás quedaban una treintena de producciones y más de quinientas canciones de su autoría.

El ayuntamiento de Mao le puso su nombre a una calle en noviembre de 2008. ACROARTE le dio el Casandra al Mérito en 2010 y, en la 38.ª entrega de los Premios Soberano, en marzo de 2023, El Gran Soberano, la distinción mayor que recibe un artista dominicano en su país. Antony Santos lo había recibido cuatro años antes.

**La autoría de Pena por ti**

Segura demandó en lo civil a Bonny Cepeda ante la Octava Cámara Civil y Comercial del Distrito Nacional, alegando que Cepeda se había apropiado indebidamente de los derechos de autor de Pena por ti y había alterado la composición sin permiso, y reclamando daños y perjuicios. Cepeda respondió públicamente que nunca se ha atribuido la autoría, que siempre ha entendido que la canción es de Segura y que la notificación lo señala por error como su autor. En 2026 el caso seguía en los tribunales.',
       updated_at = now()
 WHERE slug = 'luis-segura';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Luis Gonzaga Segura, who records as Luis Segura, is a Dominican bachata singer, composer and guitarist from Mao. He recorded without interruption from 1964 until his retirement in 2023, an unbroken run of nearly sixty years that no other performer in the genre has matched, and he is known across the country as El Papá de la Bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"The guitars he built","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born on 21 June 1939 in Mao, in the province of Valverde, in the north-west of the country. From the age of eight he lived in a rural part of the municipality, where he made guitars out of whatever materials came to hand and played them walking through the streets; the constant noise earned him the nickname Guirí Guirí. He also learned güira, tambora, maracas and several stringed instruments.","type":"text"}]},{"type":"paragraph","content":[{"text":"At twelve he moved to Santo Domingo and began entering music festivals and radio competitions, where he was noticed as an instrumentalist as much as a singer and where he leaned particularly on the requinto.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cariñito de mi vida","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Cariñito de mi vida, released in 1964, made his name at home. Audiences gave him a second nickname, El Añoñaito, for the melancholy his delivery produced, and it stayed with him for the rest of his career. Bachata had almost no radio in that decade, and the following he assembled was built without it.","type":"text"}]},{"type":"paragraph","content":[{"text":"Other performers took up his songs early. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón","occurrenceId":"f99b1343-7dcf-48a4-8ffe-1d079e70147b"}},{"text":" recorded Cariñito de mi vida as a ranchera and later cut Me siento conmovido and Agonía. In 1966 ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena","occurrenceId":"bdbaf841-9ebc-487f-a0a5-7e395b1093c9"}},{"text":" brought him into Radio Guarachita, the station he ran for bachata and guitar music, and from that point the records had somewhere to be heard.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pena por ti","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He wrote Pena por ti in 1981 and released it the following year. It is the song by which the genre is identified, and he has called it his anthem.","type":"text"}]},{"type":"paragraph","content":[{"text":"Part of what made it matter is where it was played. It was among the first bachatas to reach FM stations, at a time when the music was confined to AM and to rural audiences, and it crossed the class barrier that had kept the genre off urban Dominican radio. Its success also helped settle the word bachata as the name of the music, in place of música de amargue, the term under which the press had filed it.","type":"text"}]},{"type":"paragraph","content":[{"text":"The aula magna","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1983 the university employees’ association ASODEMU invited him to perform at the Universidad Autónoma de Santo Domingo. The rector, José Joaquín Bidó Medina, objected that the music had no place in the university’s cultural programme, and on 15 July of that year he circulated a demand to the university authorities that such performances cease, on the grounds that they encouraged base sexual passions. The performance in the aula magna went ahead.","type":"text"}]},{"type":"paragraph","content":[{"text":"Institutional acceptance arrived later. In 1997, during the presidency of Leonel Fernández, he became the first bachata performer to appear at the National Palace.","type":"text"}]},{"type":"paragraph","content":[{"text":"A heritage declaration","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"On 11 December 2019 Unesco inscribed bachata on its list of the intangible cultural heritage of humanity. At the ceremony in Bogotá, Pena por ti was sung by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1","displayText":"José Antonio Rodríguez","occurrenceId":"e940420f-42fb-4a93-a7f8-44569342328c"}},{"text":", then the Dominican ambassador to Unesco, together with the singer-songwriter ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4968d375-0833-49e2-8442-633cbaa39404","displayText":"Vicente García","occurrenceId":"489a1090-1ba4-4f71-9d44-6821cc98260a"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Two years later to the day, 489 couples danced to the same song simultaneously on the avenida George Washington in Santo Domingo, taking the Guinness world record for the largest bachata dance. The music was played live by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aec32df5-cc5a-43c2-ac33-02bc8caa1cf5","displayText":"Joe Veras","occurrenceId":"33005601-e850-4a03-9814-ed45e50c034b"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"14a4dba6-84d2-4e50-bfb7-d40e3009b42a","displayText":"Alexandra Queen","occurrenceId":"da126fc3-ad66-4f72-bb10-59ae5ae50d75"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2a4813af-a826-410e-9475-b2bd1474b234","displayText":"Kiko Rodríguez","occurrenceId":"30482333-cb37-4434-a7a8-ecdc2c7045a3"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"84aba9ce-ba69-4caa-b71b-2bedb2f848fc","displayText":"Daniel Santacruz","occurrenceId":"23ecafb8-0afb-4f9d-9f95-afaa6fadbd81"}},{"text":" and Segura himself.","type":"text"}]},{"type":"paragraph","content":[{"text":"Forty duets","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"On 30 October 2020 he released El Papá de la Bachata, su legado, forty of his own compositions re-recorded as duets with forty other artists and issued in four volumes titled Añoñado I to IV. The guest list crosses genres and generations: ","type":"text"},{"type":"artistReference","attrs":{"artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos","occurrenceId":"ce7b0d17-19fe-4ae6-8cf5-c463a62ef977"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"1c0edfe1-eb1f-453e-baf7-86a00e4d984d"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9333da06-ad03-44eb-9b81-c21d0ccdd0ea","displayText":"Fefita la Grande","occurrenceId":"2d1adae5-2048-41b1-aca9-881d82f5129e"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"31915623-3206-4052-b13a-2170226671b9","displayText":"Leonardo Paniagua","occurrenceId":"86318db5-b7ae-4712-a2da-d8d02a33af02"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy","occurrenceId":"ae327d8a-81cf-46b7-88ab-42082db46119"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6","displayText":"El Chaval de la Bachata","occurrenceId":"e554c8d2-081c-4a2a-b31c-628c88485d91"}},{"text":" are on it, along with Romeo Santos, the Puerto Rican Danny Rivera and the Colombian Charlie Zaa.","type":"text"}]},{"type":"paragraph","content":[{"text":"The album was nominated for best merengue or bachata album at the twenty-second Latin Grammy Awards in 2021. At its launch the Senate of the Dominican Republic handed him a resolution naming him the father of bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"Fin de la historia","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He announced his retirement in 2023 and closed the career with a concert of that name at the Gran Arena del Cibao in Santiago. Behind him were some thirty productions and more than five hundred songs of his own writing.","type":"text"}]},{"type":"paragraph","content":[{"text":"The municipality of Mao named a street after him in November 2008. ACROARTE gave him the Casandra al Mérito in 2010, and at the thirty-eighth Premios Soberano, in March 2023, the same body gave him El Gran Soberano, the highest distinction a Dominican artist receives at home. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos","occurrenceId":"bf75c74e-25a0-4354-b987-981531588972"}},{"text":" had received it four years earlier.","type":"text"}]},{"type":"paragraph","content":[{"text":"The authorship of Pena por ti","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Segura brought a civil claim against ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc4db4c6-c96f-4eb7-af95-ac637785c5bf","displayText":"Bonny Cepeda","occurrenceId":"3745b524-ef58-41cd-98e2-870d16969d51"}},{"text":" before the eighth civil and commercial chamber of the National District, alleging that Cepeda had improperly taken the authors’ rights to Pena por ti and altered the composition without permission, and seeking damages. Cepeda answered in public that he had never claimed the authorship, that he had always understood the song to belong to Segura, and that the notification wrongly named him as its author. The matter was still before the courts in 2026.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'luis-segura'), 4)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Luis Gonzaga Segura, que graba como Luis Segura, es un cantante, compositor y guitarrista dominicano de bachata, natural de Mao. Grabó sin interrupción desde 1964 hasta su retiro en 2023, casi sesenta años seguidos que ningún otro intérprete del género ha igualado, y en todo el país se le conoce como El Papá de la Bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las guitarras que fabricaba","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació el 21 de junio de 1939 en Mao, provincia Valverde, en el noroeste del país. Desde los ocho años vivió en una zona rural del municipio, donde armaba guitarras con los materiales que tuviera a mano y las tocaba caminando por las calles; del ruido constante le vino el apodo de Guirí Guirí. Aprendió además güira, tambora, maracas y varios instrumentos de cuerda.","type":"text"}]},{"type":"paragraph","content":[{"text":"A los doce se fue a Santo Domingo y empezó a presentarse en festivales y en programas de concurso, donde llamó la atención tanto por su ejecución como por su voz y donde se apoyó sobre todo en el requinto.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cariñito de mi vida","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Cariñito de mi vida, de 1964, lo dio a conocer en el país. El público le puso entonces el segundo apodo, El Añoñaito, por la melancolía que producía su manera de cantar, y le quedó para el resto de la carrera. En esa década la bachata casi no tenía radio, y el público que reunió lo reunió sin ella.","type":"text"}]},{"type":"paragraph","content":[{"text":"Otros intérpretes tomaron sus canciones temprano. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"27c82e93-8c8f-4466-86ab-e1afba1e5487","displayText":"José Manuel Calderón","occurrenceId":"a1a8ed9b-62da-41ad-9a98-c9ddacd931ca"}},{"text":" grabó Cariñito de mi vida en ranchera y más adelante Me siento conmovido y Agonía. En 1966 ","type":"text"},{"type":"artistReference","attrs":{"artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena","occurrenceId":"34e19353-d51c-45ed-aa8e-dc9e2b9122f1"}},{"text":" lo incorporó a Radio Guarachita, la emisora que sostenía para la bachata y la música de cuerda, y desde ahí sus discos tuvieron dónde sonar.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pena por ti","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Compuso Pena por ti en 1981 y la publicó al año siguiente. Es la canción con la que se identifica el género, y él mismo la ha llamado su himno.","type":"text"}]},{"type":"paragraph","content":[{"text":"Parte de su peso está en dónde sonó. Fue de las primeras bachatas en llegar a emisoras de frecuencia modulada, cuando la música vivía en la amplitud modulada y en el público rural, y atravesó la barrera de clase que había mantenido al género fuera de la radio urbana dominicana. Su éxito ayudó además a asentar la palabra bachata como nombre de la música, en lugar de música de amargue, que era el término con que la prensa la despachaba.","type":"text"}]},{"type":"paragraph","content":[{"text":"El aula magna","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1983 la asociación de empleados universitarios ASODEMU lo invitó a presentarse en la Universidad Autónoma de Santo Domingo. El rector, José Joaquín Bidó Medina, se opuso alegando que esa música no debía formar parte del programa cultural de la universidad, y el 15 de julio de ese año circuló una demanda a las autoridades universitarias para que cesaran las presentaciones de ese tipo, por entender que fomentaban bajas pasiones sexuales. La presentación en el aula magna se hizo igual.","type":"text"}]},{"type":"paragraph","content":[{"text":"La aceptación institucional llegó después. En 1997, durante la presidencia de Leonel Fernández, fue el primer bachatero en presentarse en el Palacio Nacional.","type":"text"}]},{"type":"paragraph","content":[{"text":"Patrimonio de la humanidad","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El 11 de diciembre de 2019 la Unesco inscribió la bachata en la lista del patrimonio cultural inmaterial de la humanidad. En la ceremonia, celebrada en Bogotá, Pena por ti la cantaron ","type":"text"},{"type":"artistReference","attrs":{"artistId":"25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1","displayText":"José Antonio Rodríguez","occurrenceId":"20086067-aaeb-4185-b90d-ad220dacb184"}},{"text":", entonces embajador dominicano ante la Unesco, y el cantautor ","type":"text"},{"type":"artistReference","attrs":{"artistId":"4968d375-0833-49e2-8442-633cbaa39404","displayText":"Vicente García","occurrenceId":"692c5612-84f5-461d-8bf1-9755f096878e"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Dos años después, el mismo día, 489 parejas bailaron esa canción a la vez en la avenida George Washington de Santo Domingo y obtuvieron el récord Guinness del baile de bachata más grande. La música la tocaron en vivo ","type":"text"},{"type":"artistReference","attrs":{"artistId":"aec32df5-cc5a-43c2-ac33-02bc8caa1cf5","displayText":"Joe Veras","occurrenceId":"99153a0b-2884-422a-ac69-22389a285f62"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"14a4dba6-84d2-4e50-bfb7-d40e3009b42a","displayText":"Alexandra Queen","occurrenceId":"7c57ca3c-9f5f-424c-80d3-fd50e8d3defa"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2a4813af-a826-410e-9475-b2bd1474b234","displayText":"Kiko Rodríguez","occurrenceId":"4bde5837-db0e-49f9-bcc5-5e00fa6e02ec"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"84aba9ce-ba69-4caa-b71b-2bedb2f848fc","displayText":"Daniel Santacruz","occurrenceId":"97f9d723-c981-4c4a-9055-9e033b609085"}},{"text":" y el propio Segura.","type":"text"}]},{"type":"paragraph","content":[{"text":"Cuarenta dúos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El 30 de octubre de 2020 publicó El Papá de la Bachata, su legado: cuarenta composiciones suyas regrabadas a dúo con otros tantos artistas y repartidas en cuatro volúmenes titulados Añoñado I a IV. El reparto cruza géneros y generaciones: están ","type":"text"},{"type":"artistReference","attrs":{"artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos","occurrenceId":"c3ff52fe-70b8-438b-a568-b0742118d9a4"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"d1a37ffd-9621-4ccc-99af-1c5719a27303"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9333da06-ad03-44eb-9b81-c21d0ccdd0ea","displayText":"Fefita la Grande","occurrenceId":"dce74004-3f0f-49fe-8081-b885ce337684"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"31915623-3206-4052-b13a-2170226671b9","displayText":"Leonardo Paniagua","occurrenceId":"9ae025e8-182a-4a74-a6b9-71d2f13713d5"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"c11c2dda-ffa1-4f09-9d24-00dc4473bc8d","displayText":"Cuco Valoy","occurrenceId":"21a25b52-11c8-4126-bece-3fdef0b43b12"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6","displayText":"El Chaval de la Bachata","occurrenceId":"246597ab-5d36-43fc-ac6e-a20e2089e7a8"}},{"text":", junto a Romeo Santos, el puertorriqueño Danny Rivera y el colombiano Charlie Zaa.","type":"text"}]},{"type":"paragraph","content":[{"text":"El álbum fue nominado a mejor álbum de merengue o bachata en la vigésima segunda entrega de los Latin Grammy, en 2021. En su lanzamiento el Senado de la República le entregó una resolución que lo declaraba padre de la bachata.","type":"text"}]},{"type":"paragraph","content":[{"text":"Fin de la historia","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Anunció su retiro en 2023 y cerró la carrera con un concierto de ese nombre en la Gran Arena del Cibao, en Santiago. Detrás quedaban una treintena de producciones y más de quinientas canciones de su autoría.","type":"text"}]},{"type":"paragraph","content":[{"text":"El ayuntamiento de Mao le puso su nombre a una calle en noviembre de 2008. ACROARTE le dio el Casandra al Mérito en 2010 y, en la 38.ª entrega de los Premios Soberano, en marzo de 2023, El Gran Soberano, la distinción mayor que recibe un artista dominicano en su país. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos","occurrenceId":"cc9f1f28-969b-400a-834a-9f20c0558fe1"}},{"text":" lo había recibido cuatro años antes.","type":"text"}]},{"type":"paragraph","content":[{"text":"La autoría de Pena por ti","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Segura demandó en lo civil a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc4db4c6-c96f-4eb7-af95-ac637785c5bf","displayText":"Bonny Cepeda","occurrenceId":"506d4c8b-a6fa-40c7-8d33-bf5729e08564"}},{"text":" ante la Octava Cámara Civil y Comercial del Distrito Nacional, alegando que Cepeda se había apropiado indebidamente de los derechos de autor de Pena por ti y había alterado la composición sin permiso, y reclamando daños y perjuicios. Cepeda respondió públicamente que nunca se ha atribuido la autoría, que siempre ha entendido que la canción es de Segura y que la notificación lo señala por error como su autor. En 2026 el caso seguía en los tribunales.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'luis-segura'), 3)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), '1c0edfe1-eb1f-453e-baf7-86a00e4d984d', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), '23ecafb8-0afb-4f9d-9f95-afaa6fadbd81', 'artist', '84aba9ce-ba69-4caa-b71b-2bedb2f848fc');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), '2d1adae5-2048-41b1-aca9-881d82f5129e', 'artist', '9333da06-ad03-44eb-9b81-c21d0ccdd0ea');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), '30482333-cb37-4434-a7a8-ecdc2c7045a3', 'artist', '2a4813af-a826-410e-9475-b2bd1474b234');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), '33005601-e850-4a03-9814-ed45e50c034b', 'artist', 'aec32df5-cc5a-43c2-ac33-02bc8caa1cf5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), '3745b524-ef58-41cd-98e2-870d16969d51', 'artist', 'bc4db4c6-c96f-4eb7-af95-ac637785c5bf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), '489a1090-1ba4-4f71-9d44-6821cc98260a', 'artist', '4968d375-0833-49e2-8442-633cbaa39404');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), '86318db5-b7ae-4712-a2da-d8d02a33af02', 'artist', '31915623-3206-4052-b13a-2170226671b9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), 'ae327d8a-81cf-46b7-88ab-42082db46119', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), 'bdbaf841-9ebc-487f-a0a5-7e395b1093c9', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), 'bf75c74e-25a0-4354-b987-981531588972', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), 'ce7b0d17-19fe-4ae6-8cf5-c463a62ef977', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), 'da126fc3-ad66-4f72-bb10-59ae5ae50d75', 'artist', '14a4dba6-84d2-4e50-bfb7-d40e3009b42a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), 'e554c8d2-081c-4a2a-b31c-628c88485d91', 'artist', '8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), 'e940420f-42fb-4a93-a7f8-44569342328c', 'artist', '25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'en'), 'f99b1343-7dcf-48a4-8ffe-1d079e70147b', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), '20086067-aaeb-4185-b90d-ad220dacb184', 'artist', '25a420d1-7a98-4fd2-93c8-38d3ed2d2dc1');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), '21a25b52-11c8-4126-bece-3fdef0b43b12', 'artist', 'c11c2dda-ffa1-4f09-9d24-00dc4473bc8d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), '246597ab-5d36-43fc-ac6e-a20e2089e7a8', 'artist', '8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), '34e19353-d51c-45ed-aa8e-dc9e2b9122f1', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), '4bde5837-db0e-49f9-bcc5-5e00fa6e02ec', 'artist', '2a4813af-a826-410e-9475-b2bd1474b234');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), '506d4c8b-a6fa-40c7-8d33-bf5729e08564', 'artist', 'bc4db4c6-c96f-4eb7-af95-ac637785c5bf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), '692c5612-84f5-461d-8bf1-9755f096878e', 'artist', '4968d375-0833-49e2-8442-633cbaa39404');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), '7c57ca3c-9f5f-424c-80d3-fd50e8d3defa', 'artist', '14a4dba6-84d2-4e50-bfb7-d40e3009b42a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), '97f9d723-c981-4c4a-9055-9e033b609085', 'artist', '84aba9ce-ba69-4caa-b71b-2bedb2f848fc');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), '99153a0b-2884-422a-ac69-22389a285f62', 'artist', 'aec32df5-cc5a-43c2-ac33-02bc8caa1cf5');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), '9ae025e8-182a-4a74-a6b9-71d2f13713d5', 'artist', '31915623-3206-4052-b13a-2170226671b9');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), 'a1a8ed9b-62da-41ad-9a98-c9ddacd931ca', 'artist', '27c82e93-8c8f-4466-86ab-e1afba1e5487');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), 'c3ff52fe-70b8-438b-a568-b0742118d9a4', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), 'cc9f1f28-969b-400a-834a-9f20c0558fe1', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), 'd1a37ffd-9621-4ccc-99af-1c5719a27303', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'luis-segura') AND locale = 'es'), 'dce74004-3f0f-49fe-8081-b885ce337684', 'artist', '9333da06-ad03-44eb-9b81-c21d0ccdd0ea');

COMMIT;
