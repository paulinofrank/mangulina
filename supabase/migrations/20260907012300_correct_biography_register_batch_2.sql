BEGIN;

-- Lote 2 de corrección de registro. Once fichas, veintiuna sustituciones.
-- 
-- Mismo criterio que el lote 1: se cambia la oración que comenta el dato o le
-- habla al lector, y no se toca ningún hecho, fecha, nombre ni enlace.
-- 
-- DOS CASOS VAN MÁS ALLÁ DEL TONO Y POR ESO SE ANOTAN:
-- 
--   dj-mari-d decía "por eso lo que hay que describir es la serie de fiestas y
--   no una discografía". Eso no es tono: es el redactor explicando cómo decidió
--   redactar la ficha, dentro de la ficha. Se reescribe para que la oración
--   hable de la obra de ella y no de mi decisión editorial.
-- 
--   ebenezer-guerra glosaba una declaración suya con "que es la clase de
--   detalle que da un artista cuando no está vistiendo la historia", que además
--   de coloquial atribuye una intención que nadie puede verificar. Se cae la
--   glosa y se queda el hecho, que es lo que él dijo.
-- 
-- TRES MARCAS DEL DETECTOR SE DESCARTAN POR FALSAS:
-- 
--   the-cat-lady   -- "If You Say So" es el título de su EP, no segunda persona.
--   daniel-arias   -- "The performer is remembered and the author is not" es
--                     prosa declarativa normal; el patrón de concesión era
--                     demasiado suelto y se aprieta en mk.cjs.
--   jazmin-heredia -- "dan por supuesto un oyente" es el verbo dar por
--                     supuesto, no la muletilla "por supuesto".
--
-- El documento y el espejo markdown se mueven juntos: la página pública sirve
-- el documento, pero una ficha en borrador cae al espejo, y dejar los dos
-- diciendo cosas distintas es un fallo invisible hasta que alguien lo lee.
--
-- Solo cambia texto. Ningún nodo artistReference se toca, así que los enlaces
-- y sus occurrence_id quedan como estaban y editorial_entity_references no se
-- reconstruye.
--
-- Aplicado directamente por DATABASE_URL. No corrió ninguna función de Vercel
-- y no se revalidó nada.
--
-- PARA REVERTIR: supabase/rollback/20260907012300_revert_correct_biography_register_batch_2.sql

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is an unusual amount of patience for the child of a star, and Dominican audiences noticed it.', 'He served an unusually long apprenticeship for the child of a star, and Dominican audiences noticed it.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'checho-rosario'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is an unusual amount of patience for the child of a star, and Dominican audiences noticed it.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is an unusual amount of patience for the child of a star, and Dominican audiences noticed it.', 'He served an unusually long apprenticeship for the child of a star, and Dominican audiences noticed it.'),
       updated_at = now()
 WHERE slug = 'checho-rosario'
   AND position('That is an unusual amount of patience for the child of a star, and Dominican audiences noticed it.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Esa es una cantidad rara de paciencia para el hijo de una estrella, y el público dominicano lo notó.', 'Cumplió un aprendizaje inusualmente largo para el hijo de una estrella, y el público dominicano lo notó.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'checho-rosario'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Esa es una cantidad rara de paciencia para el hijo de una estrella, y el público dominicano lo notó.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Esa es una cantidad rara de paciencia para el hijo de una estrella, y el público dominicano lo notó.', 'Cumplió un aprendizaje inusualmente largo para el hijo de una estrella, y el público dominicano lo notó.'),
       updated_at = now()
 WHERE slug = 'checho-rosario'
   AND position('Esa es una cantidad rara de paciencia para el hijo de una estrella, y el público dominicano lo notó.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Naming a bachata after artificial intelligence is the kind of thing a twenty-three-year-old does and a fifty-year-old does not, and it sits on the same record as songs that could have been written in 1994. That is roughly the whole shape of his music.', 'A bachata named after artificial intelligence sits on the same record as songs that could have been written in 1994, and that range is characteristic of his catalogue.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dalvin-la-melodia'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Naming a bachata after artificial intelligence is the kind of thing a twenty-three-year-old does and a fifty-year-old does not, and it sits on the same record as songs that could have been written in 1994. That is roughly the whole shape of his music.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Naming a bachata after artificial intelligence is the kind of thing a twenty-three-year-old does and a fifty-year-old does not, and it sits on the same record as songs that could have been written in 1994. That is roughly the whole shape of his music.', 'A bachata named after artificial intelligence sits on the same record as songs that could have been written in 1994, and that range is characteristic of his catalogue.'),
       updated_at = now()
 WHERE slug = 'dalvin-la-melodia'
   AND position('Naming a bachata after artificial intelligence is the kind of thing a twenty-three-year-old does and a fifty-year-old does not, and it sits on the same record as songs that could have been written in 1994. That is roughly the whole shape of his music.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Ponerle a una bachata el nombre de la inteligencia artificial es cosa que hace alguien de veintitrés años y no alguien de cincuenta, y está en el mismo disco que canciones que podrían haberse escrito en 1994. Esa es más o menos la forma completa de su música.', 'Una bachata con el nombre de la inteligencia artificial convive en el mismo disco con canciones que podrían haberse escrito en 1994, y ese rango es característico de su catálogo.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dalvin-la-melodia'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Ponerle a una bachata el nombre de la inteligencia artificial es cosa que hace alguien de veintitrés años y no alguien de cincuenta, y está en el mismo disco que canciones que podrían haberse escrito en 1994. Esa es más o menos la forma completa de su música.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Ponerle a una bachata el nombre de la inteligencia artificial es cosa que hace alguien de veintitrés años y no alguien de cincuenta, y está en el mismo disco que canciones que podrían haberse escrito en 1994. Esa es más o menos la forma completa de su música.', 'Una bachata con el nombre de la inteligencia artificial convive en el mismo disco con canciones que podrían haberse escrito en 1994, y ese rango es característico de su catálogo.'),
       updated_at = now()
 WHERE slug = 'dalvin-la-melodia'
   AND position('Ponerle a una bachata el nombre de la inteligencia artificial es cosa que hace alguien de veintitrés años y no alguien de cincuenta, y está en el mismo disco que canciones que podrían haberse escrito en 1994. Esa es más o menos la forma completa de su música.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'when she decided to change what she did for a living. That is an unusual route into merengue, where most careers start in a band at fifteen.', 'when she decided to change what she did for a living, an unusual route into merengue, where most careers start in a band at fifteen.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'didi-hernandez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('when she decided to change what she did for a living. That is an unusual route into merengue, where most careers start in a band at fifteen.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'when she decided to change what she did for a living. That is an unusual route into merengue, where most careers start in a band at fifteen.', 'when she decided to change what she did for a living, an unusual route into merengue, where most careers start in a band at fifteen.'),
       updated_at = now()
 WHERE slug = 'didi-hernandez'
   AND position('when she decided to change what she did for a living. That is an unusual route into merengue, where most careers start in a band at fifteen.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'cuando decidió cambiar de oficio. Esa es una entrada poco común al merengue, donde casi todas las carreras empiezan en una banda a los quince años.', 'cuando decidió cambiar de oficio, una entrada poco común al merengue, donde casi todas las carreras empiezan en una banda a los quince años.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'didi-hernandez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('cuando decidió cambiar de oficio. Esa es una entrada poco común al merengue, donde casi todas las carreras empiezan en una banda a los quince años.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'cuando decidió cambiar de oficio. Esa es una entrada poco común al merengue, donde casi todas las carreras empiezan en una banda a los quince años.', 'cuando decidió cambiar de oficio, una entrada poco común al merengue, donde casi todas las carreras empiezan en una banda a los quince años.'),
       updated_at = now()
 WHERE slug = 'didi-hernandez'
   AND position('cuando decidió cambiar de oficio. Esa es una entrada poco común al merengue, donde casi todas las carreras empiezan en una banda a los quince años.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is a more interesting development than it sounds. New York has had', 'New York has had')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dj-mari-d'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is a more interesting development than it sounds. New York has had' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is a more interesting development than it sounds. New York has had', 'New York has had'),
       updated_at = now()
 WHERE slug = 'dj-mari-d'
   AND position('That is a more interesting development than it sounds. New York has had' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Es un desarrollo más interesante de lo que parece. Nueva York lleva', 'Nueva York lleva')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dj-mari-d'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Es un desarrollo más interesante de lo que parece. Nueva York lleva' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Es un desarrollo más interesante de lo que parece. Nueva York lleva', 'Nueva York lleva'),
       updated_at = now()
 WHERE slug = 'dj-mari-d'
   AND position('Es un desarrollo más interesante de lo que parece. Nueva York lleva' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is curation with immediate consequences, and it is why the party series and not a discography is the thing to describe.', 'The role is curatorial and its effects are immediate, and her body of work takes the form of a party series rather than a discography.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dj-mari-d'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is curation with immediate consequences, and it is why the party series and not a discography is the thing to describe.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is curation with immediate consequences, and it is why the party series and not a discography is the thing to describe.', 'The role is curatorial and its effects are immediate, and her body of work takes the form of a party series rather than a discography.'),
       updated_at = now()
 WHERE slug = 'dj-mari-d'
   AND position('That is curation with immediate consequences, and it is why the party series and not a discography is the thing to describe.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Eso es curaduría con consecuencias inmediatas, y por eso lo que hay que describir es la serie de fiestas y no una discografía.', 'El papel es de curaduría y sus efectos son inmediatos, y su obra toma la forma de una serie de fiestas y no de una discografía.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dj-mari-d'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Eso es curaduría con consecuencias inmediatas, y por eso lo que hay que describir es la serie de fiestas y no una discografía.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Eso es curaduría con consecuencias inmediatas, y por eso lo que hay que describir es la serie de fiestas y no una discografía.', 'El papel es de curaduría y sus efectos son inmediatos, y su obra toma la forma de una serie de fiestas y no de una discografía.'),
       updated_at = now()
 WHERE slug = 'dj-mari-d'
   AND position('Eso es curaduría con consecuencias inmediatas, y por eso lo que hay que describir es la serie de fiestas y no una discografía.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'in his house they moved the cooking pots around, which is the sort of detail an artist gives when he is not dressing the story up.', 'in his house they moved the cooking pots around.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'ebenezer-guerra'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('in his house they moved the cooking pots around, which is the sort of detail an artist gives when he is not dressing the story up.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'in his house they moved the cooking pots around, which is the sort of detail an artist gives when he is not dressing the story up.', 'in his house they moved the cooking pots around.'),
       updated_at = now()
 WHERE slug = 'ebenezer-guerra'
   AND position('in his house they moved the cooking pots around, which is the sort of detail an artist gives when he is not dressing the story up.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'en su casa movían los calderos, que es la clase de detalle que da un artista cuando no está vistiendo la historia.', 'en su casa movían los calderos.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'ebenezer-guerra'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('en su casa movían los calderos, que es la clase de detalle que da un artista cuando no está vistiendo la historia.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'en su casa movían los calderos, que es la clase de detalle que da un artista cuando no está vistiendo la historia.', 'en su casa movían los calderos.'),
       updated_at = now()
 WHERE slug = 'ebenezer-guerra'
   AND position('en su casa movían los calderos, que es la clase de detalle que da un artista cuando no está vistiendo la historia.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is an unusual direction of travel for a Dominican artist and it is the shape of everything he has done since.', 'The reverse flow is uncommon for a Dominican artist, and it has shaped everything he has done since.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'francikario'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is an unusual direction of travel for a Dominican artist and it is the shape of everything he has done since.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is an unusual direction of travel for a Dominican artist and it is the shape of everything he has done since.', 'The reverse flow is uncommon for a Dominican artist, and it has shaped everything he has done since.'),
       updated_at = now()
 WHERE slug = 'francikario'
   AND position('That is an unusual direction of travel for a Dominican artist and it is the shape of everything he has done since.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Es una dirección de viaje rara para un artista dominicano y es la forma de todo lo que ha hecho después.', 'El recorrido inverso es poco frecuente para un artista dominicano, y ha marcado todo lo que ha hecho después.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'francikario'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Es una dirección de viaje rara para un artista dominicano y es la forma de todo lo que ha hecho después.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Es una dirección de viaje rara para un artista dominicano y es la forma de todo lo que ha hecho después.', 'El recorrido inverso es poco frecuente para un artista dominicano, y ha marcado todo lo que ha hecho después.'),
       updated_at = now()
 WHERE slug = 'francikario'
   AND position('Es una dirección de viaje rara para un artista dominicano y es la forma de todo lo que ha hecho después.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Scroll his catalogue and it is mostly other people’s names beside his own.', 'Across his catalogue, what appears beside his own name is mostly other people’s.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'haraca-kiko'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Scroll his catalogue and it is mostly other people’s names beside his own.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Scroll his catalogue and it is mostly other people’s names beside his own.', 'Across his catalogue, what appears beside his own name is mostly other people’s.'),
       updated_at = now()
 WHERE slug = 'haraca-kiko'
   AND position('Scroll his catalogue and it is mostly other people’s names beside his own.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Si uno baja por su catálogo, lo que hay al lado de su nombre son casi siempre nombres ajenos.', 'A lo largo de su catálogo, lo que aparece al lado de su nombre son casi siempre nombres ajenos.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'haraca-kiko'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Si uno baja por su catálogo, lo que hay al lado de su nombre son casi siempre nombres ajenos.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Si uno baja por su catálogo, lo que hay al lado de su nombre son casi siempre nombres ajenos.', 'A lo largo de su catálogo, lo que aparece al lado de su nombre son casi siempre nombres ajenos.'),
       updated_at = now()
 WHERE slug = 'haraca-kiko'
   AND position('Si uno baja por su catálogo, lo que hay al lado de su nombre son casi siempre nombres ajenos.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'de expresar algo, que suena a lo que dicen todos los artistas hasta que uno nota que el disco es un alegato por un lugar y no por él.', 'de expresar algo. El disco, sin embargo, es un alegato por un lugar antes que por él mismo.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'inka'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('de expresar algo, que suena a lo que dicen todos los artistas hasta que uno nota que el disco es un alegato por un lugar y no por él.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'de expresar algo, que suena a lo que dicen todos los artistas hasta que uno nota que el disco es un alegato por un lugar y no por él.', 'de expresar algo. El disco, sin embargo, es un alegato por un lugar antes que por él mismo.'),
       updated_at = now()
 WHERE slug = 'inka'
   AND position('de expresar algo, que suena a lo que dicen todos los artistas hasta que uno nota que el disco es un alegato por un lugar y no por él.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is a rare route for a Dominican singer and it shows in what he is hired for.', 'The route is a rare one for a Dominican singer, and it shows in what he is hired for.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'jhoni-the-voice'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is a rare route for a Dominican singer and it shows in what he is hired for.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is a rare route for a Dominican singer and it shows in what he is hired for.', 'The route is a rare one for a Dominican singer, and it shows in what he is hired for.'),
       updated_at = now()
 WHERE slug = 'jhoni-the-voice'
   AND position('That is a rare route for a Dominican singer and it shows in what he is hired for.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Es una ruta poco común para un cantante dominicano y se le nota en lo que lo contratan.', 'La ruta es poco común para un cantante dominicano, y se le nota en lo que lo contratan.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'jhoni-the-voice'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Es una ruta poco común para un cantante dominicano y se le nota en lo que lo contratan.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Es una ruta poco común para un cantante dominicano y se le nota en lo que lo contratan.', 'La ruta es poco común para un cantante dominicano, y se le nota en lo que lo contratan.'),
       updated_at = now()
 WHERE slug = 'jhoni-the-voice'
   AND position('Es una ruta poco común para un cantante dominicano y se le nota en lo que lo contratan.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That detail matters more than it looks. These are not lyrics written for songs.', 'These are not lyrics written for songs.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'joaquin-balaguer'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That detail matters more than it looks. These are not lyrics written for songs.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That detail matters more than it looks. These are not lyrics written for songs.', 'These are not lyrics written for songs.'),
       updated_at = now()
 WHERE slug = 'joaquin-balaguer'
   AND position('That detail matters more than it looks. These are not lyrics written for songs.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Ese detalle importa más de lo que parece. No son letras escritas para canciones.', 'No son letras escritas para canciones.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'joaquin-balaguer'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Ese detalle importa más de lo que parece. No son letras escritas para canciones.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Ese detalle importa más de lo que parece. No son letras escritas para canciones.', 'No son letras escritas para canciones.'),
       updated_at = now()
 WHERE slug = 'joaquin-balaguer'
   AND position('Ese detalle importa más de lo que parece. No son letras escritas para canciones.' in bio_es) > 0;

COMMIT;
