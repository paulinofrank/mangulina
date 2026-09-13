BEGIN;

-- Create the catalogue entry for Aramis Camilo.
--
-- Aramis Camilo. FICHA NUEVA, y una ausencia que no debió existir. Salió DOS
-- VECES en el mismo día -- escribiendo a Yoskar Sarante y escribiendo a Benny
-- Sadel, los dos pasaron por su orquesta -- y el editor la marcó como prioridad
-- absoluta.
--
-- COMPROBADO ANTES DE CREAR, y con todas las grafías, porque el precedente de
-- Luis "Terror" Días obliga: se buscó '%aramis%', '%aramys%', '%camilo%',
-- '%organizacion secreta%' y '%organización secreta%' contra name, slug,
-- stage_name Y dentro del arreglo aliases. Cuatro coincidencias, NINGUNA es él:
-- aramis-villalona (otra persona), michel-camilo (el pianista de jazz),
-- calacote (alias 'Camilo Marichal') y mecal (alias con 'Camilo'). No estaba.
--
-- NO HAY ARTÍCULO DE WIKIPEDIA SOBRE ÉL, ni en español ni en inglés. Es la
-- segunda ficha de hoy en esa situación, después de Carlos Piantini, y explica
-- por qué el lote de mayo no lo tenía: quien lo armó trabajaba con lo que
-- Wikipedia le diera.
--
-- LAS FUENTES, Y SU INDEPENDENCIA REAL:
--
--   La biografía que circula en la prensa dominicana -- Conéctate, noviembre de
--   2025 -- ES UNA REPUBLICACIÓN de un texto de FAUSTO POLANCO publicado en
--   Facebook en julio de 2015. NO SON DOS FUENTES: es una, dos veces. Conviene
--   dejarlo escrito para que nadie cuente doble.
--
--   La fuente independiente de verdad es LISTÍN DIARIO, que tiene dieciocho
--   entradas suyas, entre ellas el anuncio del Soberano Especial de 2025 con
--   declaraciones de Acroarte. De ahí sale lo actual y lo verificable.
--
-- EL DATO QUE RESUELVE UNA INCONSISTENCIA. La biografía de Polanco dice que
-- empezó "a principios de los años 70" en la orquesta de Luichy Herrera, en
-- Baní. Nació en 1962, así que eso lo pondría cantando a los ocho años. Listín
-- Diario, citando a Acroarte en 2025, habla de 42 AÑOS DE TRAYECTORIA, o sea
-- desde 1983, que es cuando fundó su orquesta. Aquí se escribe que empezó de
-- adolescente, en la segunda mitad de los setenta, que es lo único compatible
-- con las dos cosas, Y NO SE INVENTA UN AÑO.
--
-- LA FECHA DE NACIMIENTO SÍ ESTÁ DOBLEMENTE SOSTENIDA: 23 de noviembre de 1962,
-- Villa Tapia. Polanco dice "Villa Tapia, Salcedo" y Conéctate "Villa Tapia,
-- Hermanas Mirabal", que es la misma provincia con su nombre viejo y su nombre
-- actual. Se guarda el actual, que es el que usa el catálogo.
--
-- EL PADRE ENTRA COMO FORMACIÓN MUSICAL: Ernesto Camilo era TROMPETISTA. Mismo
-- criterio que con Johnny Pacheco y Tatico Henríquez. NO ENTRA el nombre de la
-- madre.
--
-- LO QUE HACE ESTA FICHA, Y NO ES SOLO CANTAR: CAMBIÓ CÓMO SE VESTÍAN LOS
-- MERENGUEROS. Antes de él ninguno se atrevía con ropa extravagante. Lentes
-- oscuros, guantes, botas blancas, sombrero de ala ancha y una varita -- y el
-- público lo copiaba. La varita le dio además una canción. Es un aporte de
-- puesta en escena y va contado como tal, no como anécdota de vestuario.
--
-- EL NOMBRE DE LA ORQUESTA NO SE LO PUSO ÉL: fue JUAN PACHANGA, bailarín de
-- Dioni Fernández. El dato está en Polanco y Conéctate lo recorta a "el
-- bailarín de Dioni Fernández", sin nombre. Se escribe completo.
--
-- LA ORQUESTA NO SE CREA COMO FILA, Y ES DELIBERADO. "Aramis Camilo y La
-- Organización Secreta" merece fila propia de tipo 'group', pero crearla ahora
-- sin discografía ni alineación documentada sería repetir el defecto que llevo
-- toda la semana inventariando: mezclar persona y agrupación. La orquesta se
-- nombra en la prosa y VA AL INVENTARIO DE SEPARACIÓN como fila pendiente.
-- TAMPOCO se mete en aliases, que es exactamente lo que hicieron con
-- blas-duran y johnny-pacheco.
--
-- CUATRO ENLACES, TODOS POR CRÉDITO: benny-sadel y su compañero de frente
-- cantaron en La Organización Secreta y grabaron "Señorita" y "Llévame
-- Contigo" -- lo que además cierra por los dos lados, porque escribí la ficha
-- de Benny hace un rato; dioni-fernandez-y-el-equipo, cuyo bailarín bautizó a
-- la orquesta; fernando-villalona, con quien la prensa y el público lo
-- comparaban en su mejor momento; y manny-cruz, con quien tocó "El Motor" en
-- Premio Lo Nuestro en febrero de 2025.
--
-- LO QUE SE DEJA FUERA: la visita a Nicolás Maduro de 2022 y las críticas que
-- trajo, que es política y no música; y el titular de 2021 sobre su situación
-- económica, que es vida privada. Tampoco entra el nombre de su madre.
--
-- CINCO PREMIOS EN MIGRACIÓN APARTE, incluido el SOBERANO ESPECIAL DE 2025, que
-- es lo más reciente y lo más alto: se lo dio Acroarte en la edición del 40
-- aniversario, el 25 de marzo de 2025 en el Teatro Nacional.
--
-- SIGUE ACTIVO Y LA FICHA LO DICE. Vive en Nueva York desde mediados de los
-- noventa, forma parte de "Los Años Dorados del Merengue" desde 2008, y en sus
-- propias palabras de marzo de 2025 anda de gira nacional e internacional con
-- una nueva Organización Secreta.
--
-- NOMBRES NUEVOS PARA LA LISTA: LENNY CAMACHO (cantante de su frente), RAPHY
-- D'OLEO (el empresario que lo sacó), LUICHY HERRERA (su primera orquesta, en
-- Baní), JUAN PACHANGA (el bailarín que bautizó la orquesta) y ALBERTO BERNABÉ
-- "BEBETO" (productor de Los Años Dorados del Merengue). Ninguno está.
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
       name = 'Aramis Camilo',
       sort_name = 'Camilo, Aramis',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1962-11-23',
       birth_year = 1962,
       date_of_death = NULL,
       birth_place = 'Villa Tapia',
       province = 'Hermanas Mirabal',
       first_name = 'Aramis',
       middle_name = NULL,
       last_name = 'Camilo',
       second_last_name = NULL,
       stage_name = 'Aramis Camilo',
       aliases = ARRAY['El Padrino']::text[],
       occupations = '["bandleader"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Merengue singer and bandleader of La Organización Secreta; changed how merengueros dressed on stage',
       bio_en = 'Aramis Camilo is a Dominican merengue singer and bandleader, known as El Padrino. He led La Organización Secreta through the golden decade of merengue in the eighties, and he did something no Dominican singer had tried before him: he changed what a merenguero was allowed to look like on stage.

**Villa Tapia**

He was born in 1962 in Villa Tapia, in the province of Hermanas Mirabal. His father, Ernesto Camilo, was a trumpet player, and the interest came early — school events and the singing festivals that were then the way a Dominican teenager got heard.

He began professionally as a teenager in the orchestra of Luichy Herrera, in Baní, and stayed four years. At the end of the seventies he moved to the capital and took work at the Piano Bar Don Guillermo, which belonged to Guillermo Henríquez.

**El Tente**

In 1983 he recorded El Tente and put it on the radio himself. It worked well enough that the impresario Raphy D’Oleo went into partnership with him, and the two of them built an orchestra. The name came from outside: Juan Pachanga, a dancer with the band of Dioni Fernández y El Equipo, suggested La Organización Secreta.

The band debuted on 2 August 1983, in the same piano bar where he had been working. Its front line was Lenny Camacho and Benny Sadel, who recorded Señorita and Llévame Contigo before going on to careers of their own.

**The look**

What set him apart was as much visual as musical. Before him no merenguero would risk extravagant clothes; he went out in dark glasses, gloves, white boots and a wide-brimmed hat, and carried a wand, which then gave him a song. His audience copied all of it, wand included.

At his height the press and the public were comparing him with Fernando Villalona, which in the merengue of the eighties was the highest available comparison. El Motor, La Varita, Joselyn, Susana, Nena, El Alicate, Qué Cuerpo, El Repollo, Vuelve and Caballito Frenao are the songs that carried him.

**The albums**

The records came almost yearly through the boom: Joselyn in 1983, El Alicate in 1984, Susana in 1985, El Candado in 1986, Caballito Frenao in 1988, Candela in 1990, En Punto in 1992 and Realidad in 1994.

**Outside the country**

Panama gave him the Búho de Oro in 1984, the year the Premios El Dorado named La Organización Secreta the revelation of the year. He played the Lincoln Center in New York in 1985 and received the key to the city the following year, and the orchestra performed in Japan, Rome and other places where merengue had barely been heard.

In 1987 the designer Oscar de la Renta took him to the White House to perform for the first lady, Nancy Reagan. In 1990 Candela pa’ los Pies earned him a gold record, and he had a large following in Venezuela.

**Soberano Especial**

He has lived in New York since the middle of the nineties, and since 2008 has been part of Los Años Dorados del Merengue, the touring project built around the generation that made the eighties. He still fronts a new Organización Secreta, and in February 2025 he played El Motor at Premio Lo Nuestro alongside Manny Cruz.

In March 2025 Acroarte announced that he would receive a Soberano Especial at the fortieth edition of the awards, held that month at the Teatro Nacional Eduardo Brito, for a career that by then ran to forty-two years.',
       bio_es = 'Aramis Camilo es un cantante y director de orquesta de merengue dominicano, conocido como El Padrino. Dirigió La Organización Secreta durante la década dorada del merengue en los ochenta, e hizo algo que ningún cantante dominicano había intentado antes que él: cambió cómo podía verse un merenguero en tarima.

**Villa Tapia**

Nació en 1962 en Villa Tapia, provincia Hermanas Mirabal. Su padre, Ernesto Camilo, era trompetista, y el interés le vino temprano: actos de la escuela y los festivales de la voz, que entonces eran la manera en que se hacía oír un adolescente dominicano.

Empezó profesionalmente siendo adolescente en la orquesta de Luichy Herrera, en Baní, donde estuvo cuatro años. A finales de los setenta se mudó a la capital y consiguió trabajo en el Piano Bar Don Guillermo, de Guillermo Henríquez.

**El Tente**

En 1983 grabó El Tente y él mismo la llevó a la radio. Funcionó lo suficiente como para que el empresario Raphy D’Oleo se asociara con él, y entre los dos armaron una orquesta. El nombre vino de afuera: Juan Pachanga, bailarín de la banda de Dioni Fernández y El Equipo, propuso La Organización Secreta.

La orquesta debutó el 2 de agosto de 1983, en el mismo piano bar donde él trabajaba. Al frente tenía a Lenny Camacho y a Benny Sadel, que grabaron Señorita y Llévame Contigo antes de seguir cada uno su propia carrera.

**La pinta**

Lo que lo distinguía era tanto visual como musical. Antes de él ningún merenguero se arriesgaba con ropa extravagante; él salía con lentes oscuros, guantes, botas blancas y sombrero de ala ancha, y cargaba una varita, que después le dio una canción. Su público lo copiaba todo, varita incluida.

En su mejor momento la prensa y la gente lo comparaban con Fernando Villalona, que en el merengue de los ochenta era la comparación más alta disponible. El Motor, La Varita, Joselyn, Susana, Nena, El Alicate, Qué Cuerpo, El Repollo, Vuelve y Caballito Frenao son las canciones que lo sostuvieron.

**Los discos**

Los discos salieron casi año por año durante el auge: Joselyn en 1983, El Alicate en 1984, Susana en 1985, El Candado en 1986, Caballito Frenao en 1988, Candela en 1990, En Punto en 1992 y Realidad en 1994.

**Fuera del país**

Panamá le dio el Búho de Oro en 1984, el mismo año en que los Premios El Dorado nombraron a La Organización Secreta revelación del año. Se presentó en el Lincoln Center de Nueva York en 1985 y recibió la llave de la ciudad al año siguiente, y la orquesta tocó en Japón, Roma y otros lugares donde el merengue apenas se había oído.

En 1987 el diseñador Oscar de la Renta lo llevó a la Casa Blanca a actuar para la primera dama, Nancy Reagan. En 1990 Candela pa’ los Pies le valió un disco de oro, y tuvo una gran acogida en Venezuela.

**Soberano Especial**

Vive en Nueva York desde mediados de los noventa, y desde 2008 forma parte de Los Años Dorados del Merengue, el proyecto de gira armado alrededor de la generación que hizo los ochenta. Sigue al frente de una nueva Organización Secreta, y en febrero de 2025 tocó El Motor en Premio Lo Nuestro junto a Manny Cruz.

En marzo de 2025 Acroarte anunció que recibiría un Soberano Especial en la cuadragésima edición de los premios, celebrada ese mes en el Teatro Nacional Eduardo Brito, por una trayectoria que para entonces llegaba a cuarenta y dos años.',
       updated_at = now()
 WHERE slug = 'aramis-camilo';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aramis-camilo')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aramis-camilo')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Aramis Camilo is a Dominican merengue singer and bandleader, known as El Padrino. He led La Organización Secreta through the golden decade of merengue in the eighties, and he did something no Dominican singer had tried before him: he changed what a merenguero was allowed to look like on stage.","type":"text"}]},{"type":"paragraph","content":[{"text":"Villa Tapia","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1962 in Villa Tapia, in the province of Hermanas Mirabal. His father, Ernesto Camilo, was a trumpet player, and the interest came early — school events and the singing festivals that were then the way a Dominican teenager got heard.","type":"text"}]},{"type":"paragraph","content":[{"text":"He began professionally as a teenager in the orchestra of Luichy Herrera, in Baní, and stayed four years. At the end of the seventies he moved to the capital and took work at the Piano Bar Don Guillermo, which belonged to Guillermo Henríquez.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Tente","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1983 he recorded El Tente and put it on the radio himself. It worked well enough that the impresario Raphy D’Oleo went into partnership with him, and the two of them built an orchestra. The name came from outside: Juan Pachanga, a dancer with the band of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fb2c703f-5362-47dd-ada0-7c6d5e106f3b","displayText":"Dioni Fernández y El Equipo","occurrenceId":"204e8b20-3214-4916-be32-efe792d0f4ee"}},{"text":", suggested La Organización Secreta.","type":"text"}]},{"type":"paragraph","content":[{"text":"The band debuted on 2 August 1983, in the same piano bar where he had been working. Its front line was Lenny Camacho and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"15775d55-9e10-46bc-8516-ee7468724ec0","displayText":"Benny Sadel","occurrenceId":"c3600988-0fe2-4989-95c9-bcb04cd88f43"}},{"text":", who recorded Señorita and Llévame Contigo before going on to careers of their own.","type":"text"}]},{"type":"paragraph","content":[{"text":"The look","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"What set him apart was as much visual as musical. Before him no merenguero would risk extravagant clothes; he went out in dark glasses, gloves, white boots and a wide-brimmed hat, and carried a wand, which then gave him a song. His audience copied all of it, wand included.","type":"text"}]},{"type":"paragraph","content":[{"text":"At his height the press and the public were comparing him with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"1e1cf760-c7ce-402e-af49-2d167bb6eec4"}},{"text":", which in the merengue of the eighties was the highest available comparison. El Motor, La Varita, Joselyn, Susana, Nena, El Alicate, Qué Cuerpo, El Repollo, Vuelve and Caballito Frenao are the songs that carried him.","type":"text"}]},{"type":"paragraph","content":[{"text":"The albums","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The records came almost yearly through the boom: Joselyn in 1983, El Alicate in 1984, Susana in 1985, El Candado in 1986, Caballito Frenao in 1988, Candela in 1990, En Punto in 1992 and Realidad in 1994.","type":"text"}]},{"type":"paragraph","content":[{"text":"Outside the country","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Panama gave him the Búho de Oro in 1984, the year the Premios El Dorado named La Organización Secreta the revelation of the year. He played the Lincoln Center in New York in 1985 and received the key to the city the following year, and the orchestra performed in Japan, Rome and other places where merengue had barely been heard.","type":"text"}]},{"type":"paragraph","content":[{"text":"In 1987 the designer Oscar de la Renta took him to the White House to perform for the first lady, Nancy Reagan. In 1990 Candela pa’ los Pies earned him a gold record, and he had a large following in Venezuela.","type":"text"}]},{"type":"paragraph","content":[{"text":"Soberano Especial","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He has lived in New York since the middle of the nineties, and since 2008 has been part of Los Años Dorados del Merengue, the touring project built around the generation that made the eighties. He still fronts a new Organización Secreta, and in February 2025 he played El Motor at Premio Lo Nuestro alongside ","type":"text"},{"type":"artistReference","attrs":{"artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz","occurrenceId":"67ae2ddd-1fe4-4232-9e6b-d79b0f94599d"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"In March 2025 Acroarte announced that he would receive a Soberano Especial at the fortieth edition of the awards, held that month at the Teatro Nacional Eduardo Brito, for a career that by then ran to forty-two years.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'aramis-camilo'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Aramis Camilo es un cantante y director de orquesta de merengue dominicano, conocido como El Padrino. Dirigió La Organización Secreta durante la década dorada del merengue en los ochenta, e hizo algo que ningún cantante dominicano había intentado antes que él: cambió cómo podía verse un merenguero en tarima.","type":"text"}]},{"type":"paragraph","content":[{"text":"Villa Tapia","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1962 en Villa Tapia, provincia Hermanas Mirabal. Su padre, Ernesto Camilo, era trompetista, y el interés le vino temprano: actos de la escuela y los festivales de la voz, que entonces eran la manera en que se hacía oír un adolescente dominicano.","type":"text"}]},{"type":"paragraph","content":[{"text":"Empezó profesionalmente siendo adolescente en la orquesta de Luichy Herrera, en Baní, donde estuvo cuatro años. A finales de los setenta se mudó a la capital y consiguió trabajo en el Piano Bar Don Guillermo, de Guillermo Henríquez.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Tente","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1983 grabó El Tente y él mismo la llevó a la radio. Funcionó lo suficiente como para que el empresario Raphy D’Oleo se asociara con él, y entre los dos armaron una orquesta. El nombre vino de afuera: Juan Pachanga, bailarín de la banda de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fb2c703f-5362-47dd-ada0-7c6d5e106f3b","displayText":"Dioni Fernández y El Equipo","occurrenceId":"40a27ac3-7f9c-40f0-8319-3ae0f7a5d3e8"}},{"text":", propuso La Organización Secreta.","type":"text"}]},{"type":"paragraph","content":[{"text":"La orquesta debutó el 2 de agosto de 1983, en el mismo piano bar donde él trabajaba. Al frente tenía a Lenny Camacho y a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"15775d55-9e10-46bc-8516-ee7468724ec0","displayText":"Benny Sadel","occurrenceId":"cae06d0d-1461-4ca1-96f3-01a28edf9e24"}},{"text":", que grabaron Señorita y Llévame Contigo antes de seguir cada uno su propia carrera.","type":"text"}]},{"type":"paragraph","content":[{"text":"La pinta","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Lo que lo distinguía era tanto visual como musical. Antes de él ningún merenguero se arriesgaba con ropa extravagante; él salía con lentes oscuros, guantes, botas blancas y sombrero de ala ancha, y cargaba una varita, que después le dio una canción. Su público lo copiaba todo, varita incluida.","type":"text"}]},{"type":"paragraph","content":[{"text":"En su mejor momento la prensa y la gente lo comparaban con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"06d04028-fc0b-4417-857f-f1195493c338"}},{"text":", que en el merengue de los ochenta era la comparación más alta disponible. El Motor, La Varita, Joselyn, Susana, Nena, El Alicate, Qué Cuerpo, El Repollo, Vuelve y Caballito Frenao son las canciones que lo sostuvieron.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los discos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Los discos salieron casi año por año durante el auge: Joselyn en 1983, El Alicate en 1984, Susana en 1985, El Candado en 1986, Caballito Frenao en 1988, Candela en 1990, En Punto en 1992 y Realidad en 1994.","type":"text"}]},{"type":"paragraph","content":[{"text":"Fuera del país","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Panamá le dio el Búho de Oro en 1984, el mismo año en que los Premios El Dorado nombraron a La Organización Secreta revelación del año. Se presentó en el Lincoln Center de Nueva York en 1985 y recibió la llave de la ciudad al año siguiente, y la orquesta tocó en Japón, Roma y otros lugares donde el merengue apenas se había oído.","type":"text"}]},{"type":"paragraph","content":[{"text":"En 1987 el diseñador Oscar de la Renta lo llevó a la Casa Blanca a actuar para la primera dama, Nancy Reagan. En 1990 Candela pa’ los Pies le valió un disco de oro, y tuvo una gran acogida en Venezuela.","type":"text"}]},{"type":"paragraph","content":[{"text":"Soberano Especial","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Vive en Nueva York desde mediados de los noventa, y desde 2008 forma parte de Los Años Dorados del Merengue, el proyecto de gira armado alrededor de la generación que hizo los ochenta. Sigue al frente de una nueva Organización Secreta, y en febrero de 2025 tocó El Motor en Premio Lo Nuestro junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"358ff3da-d3b2-4158-b601-3abc1005f927","displayText":"Manny Cruz","occurrenceId":"3f57b841-010d-4ef8-b09f-4cbfc9c901dd"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"En marzo de 2025 Acroarte anunció que recibiría un Soberano Especial en la cuadragésima edición de los premios, celebrada ese mes en el Teatro Nacional Eduardo Brito, por una trayectoria que para entonces llegaba a cuarenta y dos años.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'aramis-camilo'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aramis-camilo') AND locale = 'en'), '1e1cf760-c7ce-402e-af49-2d167bb6eec4', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aramis-camilo') AND locale = 'en'), '204e8b20-3214-4916-be32-efe792d0f4ee', 'artist', 'fb2c703f-5362-47dd-ada0-7c6d5e106f3b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aramis-camilo') AND locale = 'en'), '67ae2ddd-1fe4-4232-9e6b-d79b0f94599d', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aramis-camilo') AND locale = 'en'), 'c3600988-0fe2-4989-95c9-bcb04cd88f43', 'artist', '15775d55-9e10-46bc-8516-ee7468724ec0');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aramis-camilo') AND locale = 'es'), '06d04028-fc0b-4417-857f-f1195493c338', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aramis-camilo') AND locale = 'es'), '3f57b841-010d-4ef8-b09f-4cbfc9c901dd', 'artist', '358ff3da-d3b2-4158-b601-3abc1005f927');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aramis-camilo') AND locale = 'es'), '40a27ac3-7f9c-40f0-8319-3ae0f7a5d3e8', 'artist', 'fb2c703f-5362-47dd-ada0-7c6d5e106f3b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'aramis-camilo') AND locale = 'es'), 'cae06d0d-1461-4ca1-96f3-01a28edf9e24', 'artist', '15775d55-9e10-46bc-8516-ee7468724ec0');

COMMIT;
