BEGIN;

-- Reverts 20260908004400_rewrite_johnny_pacheco_biography.sql.
--
-- Restores the artist row, both editorial documents and every reference row
-- to the exact state captured immediately before the rewrite.

UPDATE artists SET
       name = 'Johnny Pacheco',
       sort_name = 'Pacheco Knipping, Juan Azarías',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'instrumentalist',
       primary_genre = 'salsa',
       date_of_birth = '1935-03-25',
       birth_year = 1935,
       date_of_death = '2021-02-15',
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Juan',
       middle_name = 'Azarías',
       last_name = 'Pacheco',
       second_last_name = 'Knipping',
       stage_name = 'Johnny Pacheco',
       aliases = ARRAY['El Zorro de Plata', 'El Maestro']::text[],
       occupations = '["arranger","bandleader","composer","producer","executive"]'::jsonb,
       instruments = ARRAY['flute', 'congas', 'bongos', 'percussion', 'saxophone', 'accordion']::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = 'https://johnnypacheco.com',
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Flautist and bandleader; cofounded Fania Records and assembled the Fania All Stars',
       bio_en = 'Juan Azarías Pacheco Knipping, known as Johnny Pacheco, was a Dominican flautist, bandleader, arranger, composer and record producer. He cofounded Fania Records, assembled the Fania All Stars and fixed the word salsa onto the music, which places a man from Santiago at the centre of a genre the world files under Cuba and Puerto Rico.

**Santiago and the Santa Cecilia**

He was born in 1935 in Los Pepines, a working neighbourhood of Santiago de los Caballeros. His first instrument came from his father, Rafael Azarías Pacheco, a clarinettist who directed the Orquesta Santa Cecilia, and by the time the family left for New York in 1946 he had also picked up the accordion, the violin, the saxophone and the flute.

Other musicians stood on the same family tree. The pianist Damirón, who did much to carry merengue abroad, was a second cousin of his mother, and the singer Maridalia Hernández descends from a great-grandaunt of his on another branch of the family.

In New York he went to Brooklyn Technical High School and trained as an electrical engineer, worked briefly in the field and left it. He studied percussion at Juilliard instead, and from 1953 played with dance bands across the city, among them the orchestras of Tito Puente, Xavier Cugat and the Dominican Dioris Valladares.

**The pachanga**

In 1958 he met the pianist Charlie Palmieri, and the two built the charanga La Duboney, where Pacheco took up the flute. He left after a single album to start a band of his own in 1960.

Pacheco y su Charanga signed to Alegre Records, and its records set off a dance craze named from his own surname: pachanga, from Pacheco and charanga. The style ran on an uptempo cross of cha-cha-chá and merengue, which carried the music of his childhood into the New York Latin scene. In 1962 and again in 1963 the band became the first Latin group to headline the Apollo Theater.

**Fania**

At the end of 1963 he met a lawyer named Jerry Masucci, and the two founded Fania Records, taking the name from a Cuban song. Pacheco served as vice-president, creative director and house producer, and he remained at the artistic centre of the label for the whole of its life, signing and developing most of the roster that salsa is now remembered by.

For the first release he rebuilt his charanga into a conjunto, trading violins for trumpets, and cut Mi Nuevo Tumbao… Cañonazo in 1964 with Pete “El Conde” Rodríguez singing. The two went on recording together for twenty-five years.

**The word salsa**

In 1968 he gathered the label’s musicians into a single band, the Fania All Stars, and recorded them live at the Red Garter. The concert at the Cheetah in 1971 turned a roster into a movement, and the documentary Our Latin Thing, for which he was musical director, carried it past New York the following year.

The term salsa was not his coinage, but it was his label and his band that fastened it to the music until it held.

**The flute**

He wrote or recorded more than 150 songs, among them La Dicha Mía, Quítate Tú, Acuyuyé, El Rey de la Puntualidad and El Número Cien. From 1974 he made a long series of duo albums with Celia Cruz, produced across the Fania catalogue, and kept the flute at the front of his own records to the end; his last studio album, ¡Sima!, appeared in 1993.

He worked in film as well, scoring Mondo New York and, with David Byrne, Something Wild, and contributing to the soundtrack of The Mambo Kings. When the Dominican rapper Mangú made Calle Luna y Calle Sol, Pacheco wrote the arrangements, sang in the chorus and played the flute.

**A night at the Estadio Olímpico**

In August 1976 the Fania All Stars played the Estadio Olímpico in Santo Domingo, with the Dominican band Los Hijos del Rey opening in front of twenty thousand people. The Fania road manager did not want the local group on stage. Tito Kenton, who danced in that band and would later lead Los Kenton, went to find Pacheco. Pacheco walked out before a crowd that had erupted believing Fania was starting, quieted it, and asked that the Dominicans be given their two numbers.

**The honours**

El Maestro made him the first Dominican nominated for a Grammy in 1975, and eight further nominations and ten gold records followed. President Joaquín Balaguer conferred the Presidential Medal of Honour on him in 1996, the year he also became the first Latin music producer to receive the Governor’s Award of the National Academy of Recording Arts and Sciences.

The Bobby Capó Lifetime Achievement Award came in 1997, induction into the International Latin Music Hall of Fame in 1998 and its Lifetime Achievement Award in 2002, the ASCAP Silver Pen Award in 2004 and the Latin Grammy Lifetime Achievement Award in 2005. At home, Acroarte gave him El Soberano in 2009.

**El Maestro Vive Cima**

He died in Teaneck, New Jersey, in February 2021, at eighty-five. A year later José Alberto "El Canario" released El Maestro Vive Cima, ten of his songs rebuilt from three of his albums and named for the shout he used from the bandstand. A scholarship fund he founded in 1994 and an annual festival at Lehman College carry his name.',
       bio_es = 'Juan Azarías Pacheco Knipping, conocido como Johnny Pacheco, fue un flautista, director de orquesta, arreglista, compositor y productor discográfico dominicano. Cofundó Fania Records, armó la Fania All Stars y fijó la palabra salsa sobre esa música, lo que coloca a un hombre de Santiago en el centro de un género que el mundo archiva como cubano y puertorriqueño.

**Los Pepines**

Nació en 1935 en Los Pepines, barrio trabajador de Santiago de los Caballeros. Su primer instrumento se lo dio su padre, Rafael Azarías Pacheco, clarinetista que dirigió la Orquesta Santa Cecilia, y para cuando la familia se marchó a Nueva York en 1946 había aprendido además acordeón, violín, saxofón y flauta.

En el mismo árbol familiar hay otros músicos. El pianista Damirón, que hizo mucho por sacar el merengue del país, era primo segundo de su madre, y la cantante Maridalia Hernández desciende de una tía bisabuela suya por otra rama de la familia.

En Nueva York estudió en la Brooklyn Technical High School y se formó como ingeniero eléctrico, trabajó poco tiempo en el oficio y lo dejó. Estudió percusión en Juilliard y desde 1953 tocó con orquestas de baile por toda la ciudad, entre ellas las de Tito Puente, Xavier Cugat y el dominicano Dioris Valladares.

**La pachanga**

En 1958 conoció al pianista Charlie Palmieri, y juntos armaron la charanga La Duboney, donde Pacheco se puso a la flauta. Se fue tras un solo disco para montar orquesta propia en 1960.

Pacheco y su Charanga firmó con Alegre Records, y sus discos desataron un baile que tomó el nombre de su apellido: pachanga, de Pacheco y charanga. El estilo se armó sobre un cruce acelerado de cha-cha-chá y merengue, y por ahí entró la música de su infancia en el ambiente latino neoyorquino. En 1962 y otra vez en 1963 la orquesta fue la primera agrupación latina en encabezar el Teatro Apollo.

**Fania**

A finales de 1963 conoció a un abogado llamado Jerry Masucci, y los dos fundaron Fania Records, con el nombre tomado de una canción cubana. Pacheco fue vicepresidente, director creativo y productor de la casa, y se mantuvo en el centro artístico del sello durante toda su existencia, firmando y desarrollando a casi toda la nómina por la que hoy se recuerda a la salsa.

Para el primer lanzamiento convirtió su charanga en conjunto, cambiando violines por trompetas, y grabó Mi Nuevo Tumbao… Cañonazo en 1964 con Pete “El Conde” Rodríguez en la voz. Siguieron grabando juntos durante veinticinco años.

**La palabra salsa**

En 1968 reunió a los músicos del sello en una sola orquesta, la Fania All Stars, y los grabó en vivo en el Red Garter. El concierto del Cheetah, en 1971, convirtió una nómina en un movimiento, y el documental Our Latin Thing, del que fue director musical, lo sacó de Nueva York al año siguiente.

La palabra salsa no la acuñó él, pero fueron su sello y su orquesta los que la fijaron sobre esa música hasta que quedó.

**La flauta**

Escribió o grabó más de 150 canciones, entre ellas La Dicha Mía, Quítate Tú, Acuyuyé, El Rey de la Puntualidad y El Número Cien. Desde 1974 hizo una larga serie de discos a dúo con Celia Cruz, produjo a lo ancho del catálogo de la Fania y mantuvo la flauta al frente de sus propios discos hasta el final; su último álbum de estudio, ¡Sima!, salió en 1993.

Trabajó también en cine: firmó las músicas de Mondo New York y, junto a David Byrne, de Something Wild, y participó en la banda sonora de The Mambo Kings. Cuando el rapero dominicano Mangú hizo Calle Luna y Calle Sol, Pacheco escribió los arreglos, cantó los coros y tocó la flauta.

**Una noche en el Estadio Olímpico**

En agosto de 1976 la Fania All Stars se presentó en el Estadio Olímpico de Santo Domingo, con la orquesta dominicana Los Hijos del Rey abriendo delante de veinte mil personas. El encargado de la Fania no quería que el grupo local subiera. Tito Kenton, que bailaba en esa orquesta y más adelante dirigiría Los Kenton, fue a buscar a Pacheco. Pacheco salió delante de un público que había estallado creyendo que empezaba la Fania, lo calmó, y pidió que dejaran a los dominicanos hacer sus dos temas.

**Los reconocimientos**

El Maestro lo convirtió en 1975 en el primer dominicano nominado a un Grammy, y detrás vinieron ocho nominaciones más y diez discos de oro. El presidente Joaquín Balaguer le impuso la Medalla Presidencial de Honor en 1996, el mismo año en que fue el primer productor de música latina en recibir el Governor’s Award de la National Academy of Recording Arts and Sciences.

El Bobby Capó Lifetime Achievement Award llegó en 1997, la entrada al International Latin Music Hall of Fame en 1998 y su premio a la trayectoria en 2002, el ASCAP Silver Pen Award en 2004 y el Latin Grammy a la Excelencia Musical en 2005. En el país, Acroarte le dio El Soberano en 2009.

**El Maestro Vive Cima**

Murió en Teaneck, Nueva Jersey, en febrero de 2021, a los ochenta y cinco años. Un año después José Alberto "El Canario" publicó El Maestro Vive Cima, diez canciones suyas rearmadas a partir de tres de sus discos y titulado con el grito que usaba desde la tarima. Un fondo de becas que fundó en 1994 y un festival anual en Lehman College llevan su nombre.',
       updated_at = now()
 WHERE slug = 'johnny-pacheco';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan Azarías Pacheco Knipping, known as Johnny Pacheco, was a Dominican flautist, bandleader, arranger, composer and record producer. He cofounded Fania Records, assembled the Fania All Stars and fixed the word salsa onto the music, which places a man from Santiago at the centre of a genre the world files under Cuba and Puerto Rico.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santiago and the Santa Cecilia","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in 1935 in Los Pepines, a working neighbourhood of Santiago de los Caballeros. His first instrument came from his father, Rafael Azarías Pacheco, a clarinettist who directed the Orquesta Santa Cecilia, and by the time the family left for New York in 1946 he had also picked up the accordion, the violin, the saxophone and the flute.","type":"text"}]},{"type":"paragraph","content":[{"text":"Other musicians stood on the same family tree. The pianist ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fa592bc6-78af-41e8-a1ff-f6fe59fae250","displayText":"Damirón","occurrenceId":"8e217805-9081-4589-a804-1d8ac2499b39"}},{"text":", who did much to carry merengue abroad, was a second cousin of his mother, and the singer ","type":"text"},{"type":"artistReference","attrs":{"artistId":"080c0205-8b66-4f16-915e-1d867acf82cc","displayText":"Maridalia Hernández","occurrenceId":"c42a69eb-bae8-4642-9b0a-10035d606c27"}},{"text":" descends from a great-grandaunt of his on another branch of the family.","type":"text"}]},{"type":"paragraph","content":[{"text":"In New York he went to Brooklyn Technical High School and trained as an electrical engineer, worked briefly in the field and left it. He studied percussion at Juilliard instead, and from 1953 played with dance bands across the city, among them the orchestras of Tito Puente, Xavier Cugat and the Dominican ","type":"text"},{"type":"artistReference","attrs":{"artistId":"439a9467-df91-459c-9c87-aa8640b780f8","displayText":"Dioris Valladares","occurrenceId":"9176b8e4-7cfe-483d-b536-7b7ff0d8d93d"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"The pachanga","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1958 he met the pianist Charlie Palmieri, and the two built the charanga La Duboney, where Pacheco took up the flute. He left after a single album to start a band of his own in 1960.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pacheco y su Charanga signed to Alegre Records, and its records set off a dance craze named from his own surname: pachanga, from Pacheco and charanga. The style ran on an uptempo cross of cha-cha-chá and merengue, which carried the music of his childhood into the New York Latin scene. In 1962 and again in 1963 the band became the first Latin group to headline the Apollo Theater.","type":"text"}]},{"type":"paragraph","content":[{"text":"Fania","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"At the end of 1963 he met a lawyer named Jerry Masucci, and the two founded Fania Records, taking the name from a Cuban song. Pacheco served as vice-president, creative director and house producer, and he remained at the artistic centre of the label for the whole of its life, signing and developing most of the roster that salsa is now remembered by.","type":"text"}]},{"type":"paragraph","content":[{"text":"For the first release he rebuilt his charanga into a conjunto, trading violins for trumpets, and cut Mi Nuevo Tumbao… Cañonazo in 1964 with Pete “El Conde” Rodríguez singing. The two went on recording together for twenty-five years.","type":"text"}]},{"type":"paragraph","content":[{"text":"The word salsa","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In 1968 he gathered the label’s musicians into a single band, the Fania All Stars, and recorded them live at the Red Garter. The concert at the Cheetah in 1971 turned a roster into a movement, and the documentary Our Latin Thing, for which he was musical director, carried it past New York the following year.","type":"text"}]},{"type":"paragraph","content":[{"text":"The term salsa was not his coinage, but it was his label and his band that fastened it to the music until it held.","type":"text"}]},{"type":"paragraph","content":[{"text":"The flute","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He wrote or recorded more than 150 songs, among them La Dicha Mía, Quítate Tú, Acuyuyé, El Rey de la Puntualidad and El Número Cien. From 1974 he made a long series of duo albums with Celia Cruz, produced across the Fania catalogue, and kept the flute at the front of his own records to the end; his last studio album, ¡Sima!, appeared in 1993.","type":"text"}]},{"type":"paragraph","content":[{"text":"He worked in film as well, scoring Mondo New York and, with David Byrne, Something Wild, and contributing to the soundtrack of The Mambo Kings. When the Dominican rapper Mangú made Calle Luna y Calle Sol, Pacheco wrote the arrangements, sang in the chorus and played the flute.","type":"text"}]},{"type":"paragraph","content":[{"text":"A night at the Estadio Olímpico","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In August 1976 the Fania All Stars played the Estadio Olímpico in Santo Domingo, with the Dominican band Los Hijos del Rey opening in front of twenty thousand people. The Fania road manager did not want the local group on stage. Tito Kenton, who danced in that band and would later lead ","type":"text"},{"type":"artistReference","attrs":{"artistId":"dc89c826-c298-48c8-aa05-50e77d85264a","displayText":"Los Kenton","occurrenceId":"ba061721-290c-4afb-8ebf-0634e522bb8f"}},{"text":", went to find Pacheco. Pacheco walked out before a crowd that had erupted believing Fania was starting, quieted it, and asked that the Dominicans be given their two numbers.","type":"text"}]},{"type":"paragraph","content":[{"text":"The honours","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El Maestro made him the first Dominican nominated for a Grammy in 1975, and eight further nominations and ten gold records followed. President Joaquín Balaguer conferred the Presidential Medal of Honour on him in 1996, the year he also became the first Latin music producer to receive the Governor’s Award of the National Academy of Recording Arts and Sciences.","type":"text"}]},{"type":"paragraph","content":[{"text":"The Bobby Capó Lifetime Achievement Award came in 1997, induction into the International Latin Music Hall of Fame in 1998 and its Lifetime Achievement Award in 2002, the ASCAP Silver Pen Award in 2004 and the Latin Grammy Lifetime Achievement Award in 2005. At home, Acroarte gave him El Soberano in 2009.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Maestro Vive Cima","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He died in Teaneck, New Jersey, in February 2021, at eighty-five. A year later ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e8ba0f32-1d96-494d-9861-b1dc3937331e","displayText":"José Alberto \"El Canario\"","occurrenceId":"a8fbab92-e11c-4ade-9338-cf79a6471986"}},{"text":" released El Maestro Vive Cima, ten of his songs rebuilt from three of his albums and named for the shout he used from the bandstand. A scholarship fund he founded in 1994 and an annual festival at Lehman College carry his name.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'johnny-pacheco'), 3)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Juan Azarías Pacheco Knipping, conocido como Johnny Pacheco, fue un flautista, director de orquesta, arreglista, compositor y productor discográfico dominicano. Cofundó Fania Records, armó la Fania All Stars y fijó la palabra salsa sobre esa música, lo que coloca a un hombre de Santiago en el centro de un género que el mundo archiva como cubano y puertorriqueño.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Pepines","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en 1935 en Los Pepines, barrio trabajador de Santiago de los Caballeros. Su primer instrumento se lo dio su padre, Rafael Azarías Pacheco, clarinetista que dirigió la Orquesta Santa Cecilia, y para cuando la familia se marchó a Nueva York en 1946 había aprendido además acordeón, violín, saxofón y flauta.","type":"text"}]},{"type":"paragraph","content":[{"text":"En el mismo árbol familiar hay otros músicos. El pianista ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fa592bc6-78af-41e8-a1ff-f6fe59fae250","displayText":"Damirón","occurrenceId":"8c815f2b-3a37-4732-aa6a-296f62e19829"}},{"text":", que hizo mucho por sacar el merengue del país, era primo segundo de su madre, y la cantante ","type":"text"},{"type":"artistReference","attrs":{"artistId":"080c0205-8b66-4f16-915e-1d867acf82cc","displayText":"Maridalia Hernández","occurrenceId":"654c81c8-b918-4561-855c-aabbcee5351f"}},{"text":" desciende de una tía bisabuela suya por otra rama de la familia.","type":"text"}]},{"type":"paragraph","content":[{"text":"En Nueva York estudió en la Brooklyn Technical High School y se formó como ingeniero eléctrico, trabajó poco tiempo en el oficio y lo dejó. Estudió percusión en Juilliard y desde 1953 tocó con orquestas de baile por toda la ciudad, entre ellas las de Tito Puente, Xavier Cugat y el dominicano ","type":"text"},{"type":"artistReference","attrs":{"artistId":"439a9467-df91-459c-9c87-aa8640b780f8","displayText":"Dioris Valladares","occurrenceId":"289af799-60e3-40bb-994f-7822668a48a9"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"La pachanga","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1958 conoció al pianista Charlie Palmieri, y juntos armaron la charanga La Duboney, donde Pacheco se puso a la flauta. Se fue tras un solo disco para montar orquesta propia en 1960.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pacheco y su Charanga firmó con Alegre Records, y sus discos desataron un baile que tomó el nombre de su apellido: pachanga, de Pacheco y charanga. El estilo se armó sobre un cruce acelerado de cha-cha-chá y merengue, y por ahí entró la música de su infancia en el ambiente latino neoyorquino. En 1962 y otra vez en 1963 la orquesta fue la primera agrupación latina en encabezar el Teatro Apollo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Fania","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A finales de 1963 conoció a un abogado llamado Jerry Masucci, y los dos fundaron Fania Records, con el nombre tomado de una canción cubana. Pacheco fue vicepresidente, director creativo y productor de la casa, y se mantuvo en el centro artístico del sello durante toda su existencia, firmando y desarrollando a casi toda la nómina por la que hoy se recuerda a la salsa.","type":"text"}]},{"type":"paragraph","content":[{"text":"Para el primer lanzamiento convirtió su charanga en conjunto, cambiando violines por trompetas, y grabó Mi Nuevo Tumbao… Cañonazo en 1964 con Pete “El Conde” Rodríguez en la voz. Siguieron grabando juntos durante veinticinco años.","type":"text"}]},{"type":"paragraph","content":[{"text":"La palabra salsa","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En 1968 reunió a los músicos del sello en una sola orquesta, la Fania All Stars, y los grabó en vivo en el Red Garter. El concierto del Cheetah, en 1971, convirtió una nómina en un movimiento, y el documental Our Latin Thing, del que fue director musical, lo sacó de Nueva York al año siguiente.","type":"text"}]},{"type":"paragraph","content":[{"text":"La palabra salsa no la acuñó él, pero fueron su sello y su orquesta los que la fijaron sobre esa música hasta que quedó.","type":"text"}]},{"type":"paragraph","content":[{"text":"La flauta","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Escribió o grabó más de 150 canciones, entre ellas La Dicha Mía, Quítate Tú, Acuyuyé, El Rey de la Puntualidad y El Número Cien. Desde 1974 hizo una larga serie de discos a dúo con Celia Cruz, produjo a lo ancho del catálogo de la Fania y mantuvo la flauta al frente de sus propios discos hasta el final; su último álbum de estudio, ¡Sima!, salió en 1993.","type":"text"}]},{"type":"paragraph","content":[{"text":"Trabajó también en cine: firmó las músicas de Mondo New York y, junto a David Byrne, de Something Wild, y participó en la banda sonora de The Mambo Kings. Cuando el rapero dominicano Mangú hizo Calle Luna y Calle Sol, Pacheco escribió los arreglos, cantó los coros y tocó la flauta.","type":"text"}]},{"type":"paragraph","content":[{"text":"Una noche en el Estadio Olímpico","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En agosto de 1976 la Fania All Stars se presentó en el Estadio Olímpico de Santo Domingo, con la orquesta dominicana Los Hijos del Rey abriendo delante de veinte mil personas. El encargado de la Fania no quería que el grupo local subiera. Tito Kenton, que bailaba en esa orquesta y más adelante dirigiría ","type":"text"},{"type":"artistReference","attrs":{"artistId":"dc89c826-c298-48c8-aa05-50e77d85264a","displayText":"Los Kenton","occurrenceId":"4f75c6cc-4780-47e5-83a5-56d1d6ccb4d8"}},{"text":", fue a buscar a Pacheco. Pacheco salió delante de un público que había estallado creyendo que empezaba la Fania, lo calmó, y pidió que dejaran a los dominicanos hacer sus dos temas.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los reconocimientos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El Maestro lo convirtió en 1975 en el primer dominicano nominado a un Grammy, y detrás vinieron ocho nominaciones más y diez discos de oro. El presidente Joaquín Balaguer le impuso la Medalla Presidencial de Honor en 1996, el mismo año en que fue el primer productor de música latina en recibir el Governor’s Award de la National Academy of Recording Arts and Sciences.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Bobby Capó Lifetime Achievement Award llegó en 1997, la entrada al International Latin Music Hall of Fame en 1998 y su premio a la trayectoria en 2002, el ASCAP Silver Pen Award en 2004 y el Latin Grammy a la Excelencia Musical en 2005. En el país, Acroarte le dio El Soberano en 2009.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Maestro Vive Cima","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Murió en Teaneck, Nueva Jersey, en febrero de 2021, a los ochenta y cinco años. Un año después ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e8ba0f32-1d96-494d-9861-b1dc3937331e","displayText":"José Alberto \"El Canario\"","occurrenceId":"7d9fcbfa-01f3-44af-92df-3a8d150d5a37"}},{"text":" publicó El Maestro Vive Cima, diez canciones suyas rearmadas a partir de tres de sus discos y titulado con el grito que usaba desde la tarima. Un fondo de becas que fundó en 1994 y un festival anual en Lehman College llevan su nombre.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'johnny-pacheco'), 2)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco') AND locale = 'en'), '8e217805-9081-4589-a804-1d8ac2499b39', 'artist', 'fa592bc6-78af-41e8-a1ff-f6fe59fae250');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco') AND locale = 'en'), '9176b8e4-7cfe-483d-b536-7b7ff0d8d93d', 'artist', '439a9467-df91-459c-9c87-aa8640b780f8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco') AND locale = 'en'), 'a8fbab92-e11c-4ade-9338-cf79a6471986', 'artist', 'e8ba0f32-1d96-494d-9861-b1dc3937331e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco') AND locale = 'en'), 'ba061721-290c-4afb-8ebf-0634e522bb8f', 'artist', 'dc89c826-c298-48c8-aa05-50e77d85264a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco') AND locale = 'en'), 'c42a69eb-bae8-4642-9b0a-10035d606c27', 'artist', '080c0205-8b66-4f16-915e-1d867acf82cc');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco') AND locale = 'es'), '289af799-60e3-40bb-994f-7822668a48a9', 'artist', '439a9467-df91-459c-9c87-aa8640b780f8');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco') AND locale = 'es'), '4f75c6cc-4780-47e5-83a5-56d1d6ccb4d8', 'artist', 'dc89c826-c298-48c8-aa05-50e77d85264a');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco') AND locale = 'es'), '654c81c8-b918-4561-855c-aabbcee5351f', 'artist', '080c0205-8b66-4f16-915e-1d867acf82cc');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco') AND locale = 'es'), '7d9fcbfa-01f3-44af-92df-3a8d150d5a37', 'artist', 'e8ba0f32-1d96-494d-9861-b1dc3937331e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'johnny-pacheco') AND locale = 'es'), '8c815f2b-3a37-4732-aa6a-296f62e19829', 'artist', 'fa592bc6-78af-41e8-a1ff-f6fe59fae250');

COMMIT;
