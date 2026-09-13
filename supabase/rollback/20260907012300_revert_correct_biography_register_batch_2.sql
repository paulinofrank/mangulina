BEGIN;

-- Revierte 20260907012300_correct_biography_register_batch_2.sql.
--
-- Devuelve el texto anterior, con el registro conversacional que el editor
-- rechazó. Se conserva solo porque toda migración de este repositorio tiene
-- que ser reversible.

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'He served an unusually long apprenticeship for the child of a star, and Dominican audiences noticed it.', 'That is an unusual amount of patience for the child of a star, and Dominican audiences noticed it.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'checho-rosario'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('He served an unusually long apprenticeship for the child of a star, and Dominican audiences noticed it.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'He served an unusually long apprenticeship for the child of a star, and Dominican audiences noticed it.', 'That is an unusual amount of patience for the child of a star, and Dominican audiences noticed it.'),
       updated_at = now()
 WHERE slug = 'checho-rosario'
   AND position('He served an unusually long apprenticeship for the child of a star, and Dominican audiences noticed it.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Cumplió un aprendizaje inusualmente largo para el hijo de una estrella, y el público dominicano lo notó.', 'Esa es una cantidad rara de paciencia para el hijo de una estrella, y el público dominicano lo notó.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'checho-rosario'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Cumplió un aprendizaje inusualmente largo para el hijo de una estrella, y el público dominicano lo notó.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Cumplió un aprendizaje inusualmente largo para el hijo de una estrella, y el público dominicano lo notó.', 'Esa es una cantidad rara de paciencia para el hijo de una estrella, y el público dominicano lo notó.'),
       updated_at = now()
 WHERE slug = 'checho-rosario'
   AND position('Cumplió un aprendizaje inusualmente largo para el hijo de una estrella, y el público dominicano lo notó.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'A bachata named after artificial intelligence sits on the same record as songs that could have been written in 1994, and that range is characteristic of his catalogue.', 'Naming a bachata after artificial intelligence is the kind of thing a twenty-three-year-old does and a fifty-year-old does not, and it sits on the same record as songs that could have been written in 1994. That is roughly the whole shape of his music.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dalvin-la-melodia'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('A bachata named after artificial intelligence sits on the same record as songs that could have been written in 1994, and that range is characteristic of his catalogue.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'A bachata named after artificial intelligence sits on the same record as songs that could have been written in 1994, and that range is characteristic of his catalogue.', 'Naming a bachata after artificial intelligence is the kind of thing a twenty-three-year-old does and a fifty-year-old does not, and it sits on the same record as songs that could have been written in 1994. That is roughly the whole shape of his music.'),
       updated_at = now()
 WHERE slug = 'dalvin-la-melodia'
   AND position('A bachata named after artificial intelligence sits on the same record as songs that could have been written in 1994, and that range is characteristic of his catalogue.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Una bachata con el nombre de la inteligencia artificial convive en el mismo disco con canciones que podrían haberse escrito en 1994, y ese rango es característico de su catálogo.', 'Ponerle a una bachata el nombre de la inteligencia artificial es cosa que hace alguien de veintitrés años y no alguien de cincuenta, y está en el mismo disco que canciones que podrían haberse escrito en 1994. Esa es más o menos la forma completa de su música.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dalvin-la-melodia'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Una bachata con el nombre de la inteligencia artificial convive en el mismo disco con canciones que podrían haberse escrito en 1994, y ese rango es característico de su catálogo.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Una bachata con el nombre de la inteligencia artificial convive en el mismo disco con canciones que podrían haberse escrito en 1994, y ese rango es característico de su catálogo.', 'Ponerle a una bachata el nombre de la inteligencia artificial es cosa que hace alguien de veintitrés años y no alguien de cincuenta, y está en el mismo disco que canciones que podrían haberse escrito en 1994. Esa es más o menos la forma completa de su música.'),
       updated_at = now()
 WHERE slug = 'dalvin-la-melodia'
   AND position('Una bachata con el nombre de la inteligencia artificial convive en el mismo disco con canciones que podrían haberse escrito en 1994, y ese rango es característico de su catálogo.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'when she decided to change what she did for a living, an unusual route into merengue, where most careers start in a band at fifteen.', 'when she decided to change what she did for a living. That is an unusual route into merengue, where most careers start in a band at fifteen.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'didi-hernandez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('when she decided to change what she did for a living, an unusual route into merengue, where most careers start in a band at fifteen.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'when she decided to change what she did for a living, an unusual route into merengue, where most careers start in a band at fifteen.', 'when she decided to change what she did for a living. That is an unusual route into merengue, where most careers start in a band at fifteen.'),
       updated_at = now()
 WHERE slug = 'didi-hernandez'
   AND position('when she decided to change what she did for a living, an unusual route into merengue, where most careers start in a band at fifteen.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'cuando decidió cambiar de oficio, una entrada poco común al merengue, donde casi todas las carreras empiezan en una banda a los quince años.', 'cuando decidió cambiar de oficio. Esa es una entrada poco común al merengue, donde casi todas las carreras empiezan en una banda a los quince años.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'didi-hernandez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('cuando decidió cambiar de oficio, una entrada poco común al merengue, donde casi todas las carreras empiezan en una banda a los quince años.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'cuando decidió cambiar de oficio, una entrada poco común al merengue, donde casi todas las carreras empiezan en una banda a los quince años.', 'cuando decidió cambiar de oficio. Esa es una entrada poco común al merengue, donde casi todas las carreras empiezan en una banda a los quince años.'),
       updated_at = now()
 WHERE slug = 'didi-hernandez'
   AND position('cuando decidió cambiar de oficio, una entrada poco común al merengue, donde casi todas las carreras empiezan en una banda a los quince años.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'New York has had', 'That is a more interesting development than it sounds. New York has had')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dj-mari-d'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('New York has had' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'New York has had', 'That is a more interesting development than it sounds. New York has had'),
       updated_at = now()
 WHERE slug = 'dj-mari-d'
   AND position('New York has had' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Nueva York lleva', 'Es un desarrollo más interesante de lo que parece. Nueva York lleva')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dj-mari-d'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Nueva York lleva' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Nueva York lleva', 'Es un desarrollo más interesante de lo que parece. Nueva York lleva'),
       updated_at = now()
 WHERE slug = 'dj-mari-d'
   AND position('Nueva York lleva' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'The role is curatorial and its effects are immediate, and her body of work takes the form of a party series rather than a discography.', 'That is curation with immediate consequences, and it is why the party series and not a discography is the thing to describe.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dj-mari-d'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('The role is curatorial and its effects are immediate, and her body of work takes the form of a party series rather than a discography.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'The role is curatorial and its effects are immediate, and her body of work takes the form of a party series rather than a discography.', 'That is curation with immediate consequences, and it is why the party series and not a discography is the thing to describe.'),
       updated_at = now()
 WHERE slug = 'dj-mari-d'
   AND position('The role is curatorial and its effects are immediate, and her body of work takes the form of a party series rather than a discography.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'El papel es de curaduría y sus efectos son inmediatos, y su obra toma la forma de una serie de fiestas y no de una discografía.', 'Eso es curaduría con consecuencias inmediatas, y por eso lo que hay que describir es la serie de fiestas y no una discografía.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dj-mari-d'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('El papel es de curaduría y sus efectos son inmediatos, y su obra toma la forma de una serie de fiestas y no de una discografía.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'El papel es de curaduría y sus efectos son inmediatos, y su obra toma la forma de una serie de fiestas y no de una discografía.', 'Eso es curaduría con consecuencias inmediatas, y por eso lo que hay que describir es la serie de fiestas y no una discografía.'),
       updated_at = now()
 WHERE slug = 'dj-mari-d'
   AND position('El papel es de curaduría y sus efectos son inmediatos, y su obra toma la forma de una serie de fiestas y no de una discografía.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'in his house they moved the cooking pots around.', 'in his house they moved the cooking pots around, which is the sort of detail an artist gives when he is not dressing the story up.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'ebenezer-guerra'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('in his house they moved the cooking pots around.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'in his house they moved the cooking pots around.', 'in his house they moved the cooking pots around, which is the sort of detail an artist gives when he is not dressing the story up.'),
       updated_at = now()
 WHERE slug = 'ebenezer-guerra'
   AND position('in his house they moved the cooking pots around.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'en su casa movían los calderos.', 'en su casa movían los calderos, que es la clase de detalle que da un artista cuando no está vistiendo la historia.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'ebenezer-guerra'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('en su casa movían los calderos.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'en su casa movían los calderos.', 'en su casa movían los calderos, que es la clase de detalle que da un artista cuando no está vistiendo la historia.'),
       updated_at = now()
 WHERE slug = 'ebenezer-guerra'
   AND position('en su casa movían los calderos.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'The reverse flow is uncommon for a Dominican artist, and it has shaped everything he has done since.', 'That is an unusual direction of travel for a Dominican artist and it is the shape of everything he has done since.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'francikario'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('The reverse flow is uncommon for a Dominican artist, and it has shaped everything he has done since.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'The reverse flow is uncommon for a Dominican artist, and it has shaped everything he has done since.', 'That is an unusual direction of travel for a Dominican artist and it is the shape of everything he has done since.'),
       updated_at = now()
 WHERE slug = 'francikario'
   AND position('The reverse flow is uncommon for a Dominican artist, and it has shaped everything he has done since.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'El recorrido inverso es poco frecuente para un artista dominicano, y ha marcado todo lo que ha hecho después.', 'Es una dirección de viaje rara para un artista dominicano y es la forma de todo lo que ha hecho después.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'francikario'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('El recorrido inverso es poco frecuente para un artista dominicano, y ha marcado todo lo que ha hecho después.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'El recorrido inverso es poco frecuente para un artista dominicano, y ha marcado todo lo que ha hecho después.', 'Es una dirección de viaje rara para un artista dominicano y es la forma de todo lo que ha hecho después.'),
       updated_at = now()
 WHERE slug = 'francikario'
   AND position('El recorrido inverso es poco frecuente para un artista dominicano, y ha marcado todo lo que ha hecho después.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Across his catalogue, what appears beside his own name is mostly other people’s.', 'Scroll his catalogue and it is mostly other people’s names beside his own.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'haraca-kiko'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Across his catalogue, what appears beside his own name is mostly other people’s.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Across his catalogue, what appears beside his own name is mostly other people’s.', 'Scroll his catalogue and it is mostly other people’s names beside his own.'),
       updated_at = now()
 WHERE slug = 'haraca-kiko'
   AND position('Across his catalogue, what appears beside his own name is mostly other people’s.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'A lo largo de su catálogo, lo que aparece al lado de su nombre son casi siempre nombres ajenos.', 'Si uno baja por su catálogo, lo que hay al lado de su nombre son casi siempre nombres ajenos.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'haraca-kiko'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('A lo largo de su catálogo, lo que aparece al lado de su nombre son casi siempre nombres ajenos.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'A lo largo de su catálogo, lo que aparece al lado de su nombre son casi siempre nombres ajenos.', 'Si uno baja por su catálogo, lo que hay al lado de su nombre son casi siempre nombres ajenos.'),
       updated_at = now()
 WHERE slug = 'haraca-kiko'
   AND position('A lo largo de su catálogo, lo que aparece al lado de su nombre son casi siempre nombres ajenos.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'de expresar algo. El disco, sin embargo, es un alegato por un lugar antes que por él mismo.', 'de expresar algo, que suena a lo que dicen todos los artistas hasta que uno nota que el disco es un alegato por un lugar y no por él.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'inka'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('de expresar algo. El disco, sin embargo, es un alegato por un lugar antes que por él mismo.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'de expresar algo. El disco, sin embargo, es un alegato por un lugar antes que por él mismo.', 'de expresar algo, que suena a lo que dicen todos los artistas hasta que uno nota que el disco es un alegato por un lugar y no por él.'),
       updated_at = now()
 WHERE slug = 'inka'
   AND position('de expresar algo. El disco, sin embargo, es un alegato por un lugar antes que por él mismo.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'The route is a rare one for a Dominican singer, and it shows in what he is hired for.', 'That is a rare route for a Dominican singer and it shows in what he is hired for.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'jhoni-the-voice'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('The route is a rare one for a Dominican singer, and it shows in what he is hired for.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'The route is a rare one for a Dominican singer, and it shows in what he is hired for.', 'That is a rare route for a Dominican singer and it shows in what he is hired for.'),
       updated_at = now()
 WHERE slug = 'jhoni-the-voice'
   AND position('The route is a rare one for a Dominican singer, and it shows in what he is hired for.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'La ruta es poco común para un cantante dominicano, y se le nota en lo que lo contratan.', 'Es una ruta poco común para un cantante dominicano y se le nota en lo que lo contratan.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'jhoni-the-voice'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('La ruta es poco común para un cantante dominicano, y se le nota en lo que lo contratan.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'La ruta es poco común para un cantante dominicano, y se le nota en lo que lo contratan.', 'Es una ruta poco común para un cantante dominicano y se le nota en lo que lo contratan.'),
       updated_at = now()
 WHERE slug = 'jhoni-the-voice'
   AND position('La ruta es poco común para un cantante dominicano, y se le nota en lo que lo contratan.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'These are not lyrics written for songs.', 'That detail matters more than it looks. These are not lyrics written for songs.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'joaquin-balaguer'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('These are not lyrics written for songs.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'These are not lyrics written for songs.', 'That detail matters more than it looks. These are not lyrics written for songs.'),
       updated_at = now()
 WHERE slug = 'joaquin-balaguer'
   AND position('These are not lyrics written for songs.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'No son letras escritas para canciones.', 'Ese detalle importa más de lo que parece. No son letras escritas para canciones.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'joaquin-balaguer'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('No son letras escritas para canciones.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'No son letras escritas para canciones.', 'Ese detalle importa más de lo que parece. No son letras escritas para canciones.'),
       updated_at = now()
 WHERE slug = 'joaquin-balaguer'
   AND position('No son letras escritas para canciones.' in bio_es) > 0;

COMMIT;
