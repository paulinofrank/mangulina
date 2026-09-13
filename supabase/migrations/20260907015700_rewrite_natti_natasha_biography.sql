BEGIN;

-- Rewrite the catalogue entry for Natti Natasha.
--
-- Natti Natasha. TERCERA de las 235 del lote de mayo: veinte premios
-- registrados y noventa y un discos a su nombre, la cifra más alta del grupo.
--
-- SE REESCRIBEN LOS DOS IDIOMAS, y esta vez había que hacerlo por algo más que
-- pobreza de datos.
--
-- EL TEXTO PUBLICADO AFIRMABA UNA COLABORACIÓN CON DRAKE. No existe. Wikipedia
-- en español detalla su carrera colaboración por colaboración -- Gyptian, Don
-- Omar, Farruko, Tony Dize, Ken-Y, Lápiz Conciente, Daddy Yankee, Ozuna,
-- Thalía, Bad Bunny, Becky G, Kany García, Anitta, los Jonas Brothers,
-- Sebastián Yatra, Prince Royce -- y Drake no aparece en ninguna parte, ni en
-- su discografía ni en la de él. Atribuirle a una artista un trabajo con uno de
-- los músicos más grandes del mundo, en una ficha publicada, es el tipo de
-- error que se cita y que después hay que desmentir. Se elimina.
--
-- TAMBIÉN SE ELIMINA que fue "la dominicana más seguida en redes sociales del
-- mundo en varios momentos de su carrera". Es una métrica de seguidores, que
-- aquí no se escriben, y además no se puede verificar a posteriori.
--
-- TRES ERRORES DE LA FILA QUE SE CORRIGEN:
--
--   aliases guardaba ['Natti Natasha', 'Natalia Alexandra Gutiérrez Batista'].
--   LAS DOS SOBRAN: la primera es el propio campo name y la segunda es su
--   nombre legal, ya desglosado en los cuatro campos de nombre. Es el tercer
--   caso del mismo defecto hoy, después de Martín de León y Eddy Herrera.
--   Entran en su lugar los apodos reales que registra Wikipedia: Natti-Nat y La
--   Dura de las Duras.
--
--   sort_name decía "Natasha, Natti", que ordena por el nombre artístico. La
--   convención del catálogo es ordenar por el nombre legal, como en "Herrera de
--   los Ríos, Eduardo José". Pasa a "Gutiérrez Batista, Natalia Alexandra".
--
--   youtube guardaba la ruta heredada c/NattiNatasha. COMPROBÉ LAS DOS FORMAS Y
--   LAS DOS RESUELVEN, pero @NattiNatasha es el handle actual y además se
--   muestra como handle en la ficha, mientras que la ruta c/ se mostraba como
--   texto pelado.
--
-- DOS ENLACES, LOS ÚNICOS DOMINICANOS DE SU LISTA: lapiz-conciente, en cuyo
-- álbum "Latidos" ella canta "Magia"; y prince-royce, con quien grabó "Antes
-- Que Salga el Sol". El resto de sus colaboradores son puertorriqueños,
-- brasileños, mexicanos o estadounidenses y no pertenecen a este catálogo.
--
-- NO SE ESCRIBEN CIFRAS: ni los dos mil millones de reproducciones de
-- "Criminal" que menciona Wikipedia, ni las siete mil unidades de la primera
-- semana de "Iluminatti". SÍ ENTRAN LAS POSICIONES DE LISTA, que no son
-- conteos sino clasificaciones, y el hecho comparativo de que fue la mejor
-- semana de estreno de un álbum latino de una mujer desde el de Shakira.
--
-- SE DEJA FUERA: matrimonios, embarazos, hijas y su veganismo. SÍ ENTRA que fue
-- la primera artista femenina firmada por Pina Records, que es un hecho de
-- industria, aunque el dueño del sello sea después su cónyuge. Lo uno es
-- profesional y lo otro privado.
--
-- occupations SE QUEDA COMO ESTÁ, solo songwriter. Wikipedia lista además
-- "actriz" en el encabezado pero no da un solo papel, y no voy a añadir un
-- oficio sobre una palabra suelta.
--
-- FUENTES: Wikipedia en español, extensa y referenciada. La tabla de premios de
-- la propia base, que aporta el Guinness por más nominaciones a Premio Lo
-- Nuestro y los Premios Juventud recientes que el artículo no recoge.
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
       name = 'Natti Natasha',
       sort_name = 'Gutiérrez Batista, Natalia Alexandra',
       type = 'solo_artist',
       status = 'published',
       gender = 'female',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'urban-reggaeton',
       date_of_birth = '1986-12-10',
       birth_year = 1986,
       date_of_death = NULL,
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Natalia',
       middle_name = 'Alexandra',
       last_name = 'Gutiérrez',
       second_last_name = 'Batista',
       stage_name = 'Natti Natasha',
       aliases = ARRAY['Natti-Nat', 'La Dura de las Duras']::text[],
       occupations = '["songwriter"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY['bachata', 'urbano']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = 'https://nattinatasha.com',
       youtube = '@NattiNatasha',
       facebook = 'NattiNatashaOfficial',
       instagram = 'nattinatasha',
       disambiguation = 'Reggaeton and bachata singer; the most internationally successful Dominican woman in urban music',
       bio_en = 'Natalia Alexandra Gutiérrez Batista, known as Natti Natasha, is a Dominican singer and songwriter. She works across reggaeton, Latin pop and bachata, and is the most internationally successful Dominican woman in urban music, with a catalogue built largely on collaboration.

**Bellas Artes**

She was born in Santiago de los Caballeros in 1986 and first sang in the children’s group of the church she attended. Her parents enrolled her at the city’s school of fine arts when she was eight, and it was there that she took her first singing lessons and decided what she wanted to do.

**The groups that failed**

At eighteen she began writing and recording her own material and performing around Santiago. She formed a group called D’Style with friends, which recorded a few songs and broke up, and sang backing vocals with Ingco Crew, which also broke up. She put the career on hold.

**El Orfanato**

She resumed with the intention of going solo in the urban genre, and reconnected with a producer who by then was working for Don Omar’s label. One of her songs was playing in the studio when Don Omar heard it, and he signed her.

Her recorded debut came in 2010 on a remix with Gyptian and Don Omar, and she appeared on the label’s compilation of new signings. Dutty Love, released with Don Omar the following year, won three Billboard Latin awards. She put out an EP in English in 2012, and her first single as a solo artist, Makossa, reached number one on the Italian reggaeton chart. The contract ended in 2014.

**Pina Records**

She spent a year as a guest voice on other people’s albums, among them Magia, on a record by Lápiz Conciente. In 2016 she became the first woman signed to Pina Records, and her first single for the label, made with Daddy Yankee, went to number one in the Dominican Republic.

**Criminal**

Criminal, released with Ozuna in 2017 and written by the two of them with Jhay Cortez, reached number five on the Hot Latin Songs chart and is the record that moved her from featured vocalist to headline artist.

The year that followed was a run of collaborations — with Thalía, with Bad Bunny, and with Becky G on Sin Pijama, which reached number four on the same chart.

**Iluminatti**

Her first studio album appeared in February 2019 with seventeen tracks and guests including Kany García and Anitta. It entered the United States Latin albums chart at number three, the strongest opening week for a Latin album by a woman since Shakira’s previous release.

**Sony and the return to bachata**

She signed with Sony Music at the start of 2021 and opened that period with a song recorded alongside Prince Royce. Three albums have followed, the most recent of them given over to bachata, which took the award for best tropical album at the Premios Juventud.

**Recognition**

She holds a Guinness world record for the most Premio Lo Nuestro nominations, has won repeatedly at the Premios Juventud and the Premios Tu Música Urbano, was named female Hot Latin Songs artist of the year by Billboard, and received Billboard’s Unstoppable Artist award. At home she has twice taken the Soberano for the outstanding Dominican artist abroad.',
       bio_es = 'Natalia Alexandra Gutiérrez Batista, conocida como Natti Natasha, es una cantante y compositora dominicana. Trabaja el reguetón, el pop latino y la bachata, y es la mujer dominicana de mayor alcance internacional en la música urbana, con un catálogo levantado en buena medida sobre la colaboración.

**Bellas Artes**

Nació en Santiago de los Caballeros en 1986 y cantó por primera vez en el grupo infantil de la iglesia a la que asistía. Sus padres la inscribieron a los ocho años en la escuela de bellas artes de la ciudad, y fue allí donde tomó sus primeras clases de canto y decidió a qué quería dedicarse.

**Los grupos que no cuajaron**

A los dieciocho empezó a escribir y grabar material propio y a presentarse por Santiago. Formó con amigos un grupo llamado D’Style, que grabó algunas canciones y se deshizo, y fue corista de Ingco Crew, que también terminó por deshacerse. Puso la carrera en pausa.

**El Orfanato**

La retomó con la intención de lanzarse como solista en el género urbano, y se reencontró con un productor que para entonces trabajaba en el sello de Don Omar. Una canción suya sonaba en el estudio cuando Don Omar la oyó, y la firmó.

Su debut grabado fue en 2010, en una remezcla junto a Gyptian y Don Omar, y apareció en el disco recopilatorio de los nuevos fichajes del sello. Dutty Love, publicada con Don Omar al año siguiente, le valió tres premios Billboard latinos. Sacó un EP en inglés en 2012, y su primer sencillo como solista, Makossa, llegó al número uno de la lista de reguetón italiana. El contrato terminó en 2014.

**Pina Records**

Pasó un año como voz invitada en discos ajenos, entre ellos Magia, de un álbum de Lápiz Conciente. En 2016 se convirtió en la primera mujer firmada por Pina Records, y su primer sencillo para el sello, hecho con Daddy Yankee, llegó al número uno en la República Dominicana.

**Criminal**

Criminal, publicada junto a Ozuna en 2017 y escrita por los dos con Jhay Cortez, alcanzó el número cinco de la lista Hot Latin Songs y es el disco que la movió de voz invitada a artista de cartel.

El año siguiente fue una seguidilla de colaboraciones: con Thalía, con Bad Bunny, y con Becky G en Sin Pijama, que llegó al número cuatro de la misma lista.

**Iluminatti**

Su primer álbum de estudio salió en febrero de 2019, con diecisiete temas e invitadas como Kany García y Anitta. Entró en el número tres de la lista estadounidense de álbumes latinos, la mejor semana de estreno de un álbum latino de una mujer desde el disco anterior de Shakira.

**Sony y la vuelta a la bachata**

Firmó con Sony Music a principios de 2021 y abrió esa etapa con una canción grabada junto a Prince Royce. Detrás vinieron tres álbumes, el más reciente dedicado por entero a la bachata, que se llevó el premio al mejor álbum tropical en los Premios Juventud.

**Reconocimientos**

Tiene un récord Guinness por la mayor cantidad de nominaciones a Premio Lo Nuestro, ha ganado repetidamente en los Premios Juventud y en los Premios Tu Música Urbano, fue nombrada artista femenina del año de Hot Latin Songs por Billboard, y recibió el premio Unstoppable Artist de esa misma revista. En su país se ha llevado dos veces el Soberano a la artista dominicana destacada en el extranjero.',
       updated_at = now()
 WHERE slug = 'natti-natasha';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'natti-natasha')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'natti-natasha')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Natalia Alexandra Gutiérrez Batista, known as Natti Natasha, is a Dominican singer and songwriter. She works across reggaeton, Latin pop and bachata, and is the most internationally successful Dominican woman in urban music, with a catalogue built largely on collaboration.","type":"text"}]},{"type":"paragraph","content":[{"text":"Bellas Artes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She was born in Santiago de los Caballeros in 1986 and first sang in the children’s group of the church she attended. Her parents enrolled her at the city’s school of fine arts when she was eight, and it was there that she took her first singing lessons and decided what she wanted to do.","type":"text"}]},{"type":"paragraph","content":[{"text":"The groups that failed","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"At eighteen she began writing and recording her own material and performing around Santiago. She formed a group called D’Style with friends, which recorded a few songs and broke up, and sang backing vocals with Ingco Crew, which also broke up. She put the career on hold.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Orfanato","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She resumed with the intention of going solo in the urban genre, and reconnected with a producer who by then was working for Don Omar’s label. One of her songs was playing in the studio when Don Omar heard it, and he signed her.","type":"text"}]},{"type":"paragraph","content":[{"text":"Her recorded debut came in 2010 on a remix with Gyptian and Don Omar, and she appeared on the label’s compilation of new signings. Dutty Love, released with Don Omar the following year, won three Billboard Latin awards. She put out an EP in English in 2012, and her first single as a solo artist, Makossa, reached number one on the Italian reggaeton chart. The contract ended in 2014.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pina Records","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She spent a year as a guest voice on other people’s albums, among them Magia, on a record by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente","occurrenceId":"ba45b97c-d2dc-4085-8586-31325aa0a278"}},{"text":". In 2016 she became the first woman signed to Pina Records, and her first single for the label, made with Daddy Yankee, went to number one in the Dominican Republic.","type":"text"}]},{"type":"paragraph","content":[{"text":"Criminal","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Criminal, released with Ozuna in 2017 and written by the two of them with Jhay Cortez, reached number five on the Hot Latin Songs chart and is the record that moved her from featured vocalist to headline artist.","type":"text"}]},{"type":"paragraph","content":[{"text":"The year that followed was a run of collaborations — with Thalía, with Bad Bunny, and with Becky G on Sin Pijama, which reached number four on the same chart.","type":"text"}]},{"type":"paragraph","content":[{"text":"Iluminatti","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Her first studio album appeared in February 2019 with seventeen tracks and guests including Kany García and Anitta. It entered the United States Latin albums chart at number three, the strongest opening week for a Latin album by a woman since Shakira’s previous release.","type":"text"}]},{"type":"paragraph","content":[{"text":"Sony and the return to bachata","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She signed with Sony Music at the start of 2021 and opened that period with a song recorded alongside ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce","occurrenceId":"e3d5faaf-41b5-49ac-918e-cc832da888b6"}},{"text":". Three albums have followed, the most recent of them given over to bachata, which took the award for best tropical album at the Premios Juventud.","type":"text"}]},{"type":"paragraph","content":[{"text":"Recognition","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"She holds a Guinness world record for the most Premio Lo Nuestro nominations, has won repeatedly at the Premios Juventud and the Premios Tu Música Urbano, was named female Hot Latin Songs artist of the year by Billboard, and received Billboard’s Unstoppable Artist award. At home she has twice taken the Soberano for the outstanding Dominican artist abroad.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'natti-natasha'), 3)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Natalia Alexandra Gutiérrez Batista, conocida como Natti Natasha, es una cantante y compositora dominicana. Trabaja el reguetón, el pop latino y la bachata, y es la mujer dominicana de mayor alcance internacional en la música urbana, con un catálogo levantado en buena medida sobre la colaboración.","type":"text"}]},{"type":"paragraph","content":[{"text":"Bellas Artes","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santiago de los Caballeros en 1986 y cantó por primera vez en el grupo infantil de la iglesia a la que asistía. Sus padres la inscribieron a los ocho años en la escuela de bellas artes de la ciudad, y fue allí donde tomó sus primeras clases de canto y decidió a qué quería dedicarse.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los grupos que no cuajaron","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A los dieciocho empezó a escribir y grabar material propio y a presentarse por Santiago. Formó con amigos un grupo llamado D’Style, que grabó algunas canciones y se deshizo, y fue corista de Ingco Crew, que también terminó por deshacerse. Puso la carrera en pausa.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Orfanato","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La retomó con la intención de lanzarse como solista en el género urbano, y se reencontró con un productor que para entonces trabajaba en el sello de Don Omar. Una canción suya sonaba en el estudio cuando Don Omar la oyó, y la firmó.","type":"text"}]},{"type":"paragraph","content":[{"text":"Su debut grabado fue en 2010, en una remezcla junto a Gyptian y Don Omar, y apareció en el disco recopilatorio de los nuevos fichajes del sello. Dutty Love, publicada con Don Omar al año siguiente, le valió tres premios Billboard latinos. Sacó un EP en inglés en 2012, y su primer sencillo como solista, Makossa, llegó al número uno de la lista de reguetón italiana. El contrato terminó en 2014.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pina Records","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Pasó un año como voz invitada en discos ajenos, entre ellos Magia, de un álbum de ","type":"text"},{"type":"artistReference","attrs":{"artistId":"102e7b78-ff98-4adc-9a54-ae73791fb176","displayText":"Lápiz Conciente","occurrenceId":"4e24627b-f323-4db7-a148-19fc35c02908"}},{"text":". En 2016 se convirtió en la primera mujer firmada por Pina Records, y su primer sencillo para el sello, hecho con Daddy Yankee, llegó al número uno en la República Dominicana.","type":"text"}]},{"type":"paragraph","content":[{"text":"Criminal","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Criminal, publicada junto a Ozuna en 2017 y escrita por los dos con Jhay Cortez, alcanzó el número cinco de la lista Hot Latin Songs y es el disco que la movió de voz invitada a artista de cartel.","type":"text"}]},{"type":"paragraph","content":[{"text":"El año siguiente fue una seguidilla de colaboraciones: con Thalía, con Bad Bunny, y con Becky G en Sin Pijama, que llegó al número cuatro de la misma lista.","type":"text"}]},{"type":"paragraph","content":[{"text":"Iluminatti","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su primer álbum de estudio salió en febrero de 2019, con diecisiete temas e invitadas como Kany García y Anitta. Entró en el número tres de la lista estadounidense de álbumes latinos, la mejor semana de estreno de un álbum latino de una mujer desde el disco anterior de Shakira.","type":"text"}]},{"type":"paragraph","content":[{"text":"Sony y la vuelta a la bachata","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Firmó con Sony Music a principios de 2021 y abrió esa etapa con una canción grabada junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce","occurrenceId":"c4aa3070-927c-4362-a913-a1210dd06ec7"}},{"text":". Detrás vinieron tres álbumes, el más reciente dedicado por entero a la bachata, que se llevó el premio al mejor álbum tropical en los Premios Juventud.","type":"text"}]},{"type":"paragraph","content":[{"text":"Reconocimientos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Tiene un récord Guinness por la mayor cantidad de nominaciones a Premio Lo Nuestro, ha ganado repetidamente en los Premios Juventud y en los Premios Tu Música Urbano, fue nombrada artista femenina del año de Hot Latin Songs por Billboard, y recibió el premio Unstoppable Artist de esa misma revista. En su país se ha llevado dos veces el Soberano a la artista dominicana destacada en el extranjero.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'natti-natasha'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'natti-natasha') AND locale = 'en'), 'ba45b97c-d2dc-4085-8586-31325aa0a278', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'natti-natasha') AND locale = 'en'), 'e3d5faaf-41b5-49ac-918e-cc832da888b6', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'natti-natasha') AND locale = 'es'), '4e24627b-f323-4db7-a148-19fc35c02908', 'artist', '102e7b78-ff98-4adc-9a54-ae73791fb176');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'natti-natasha') AND locale = 'es'), 'c4aa3070-927c-4362-a913-a1210dd06ec7', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d');

COMMIT;
