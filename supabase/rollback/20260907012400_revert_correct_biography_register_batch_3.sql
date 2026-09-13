BEGIN;

-- Revierte 20260907012400_correct_biography_register_batch_3.sql.
--
-- Devuelve el texto anterior, con el registro conversacional que el editor
-- rechazó. Se conserva solo porque toda migración de este repositorio tiene
-- que ser reversible.

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'An orchestra belonged to', 'That is not a complaint so much as a description of how the business worked. An orchestra belonged to')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'kaki-vargas'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('An orchestra belonged to' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'An orchestra belonged to', 'That is not a complaint so much as a description of how the business worked. An orchestra belonged to'),
       updated_at = now()
 WHERE slug = 'kaki-vargas'
   AND position('An orchestra belonged to' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Una orquesta era de', 'Eso no es tanto una queja como una descripción de cómo funcionaba el negocio. Una orquesta era de')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'kaki-vargas'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Una orquesta era de' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Una orquesta era de', 'Eso no es tanto una queja como una descripción de cómo funcionaba el negocio. Una orquesta era de'),
       updated_at = now()
 WHERE slug = 'kaki-vargas'
   AND position('Una orquesta era de' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'The starting point is uncommon for an electronic producer. Most', 'That is an unusual place for an electronic producer to start. Most')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'mickey-dastinz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('The starting point is uncommon for an electronic producer. Most' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'The starting point is uncommon for an electronic producer. Most', 'That is an unusual place for an electronic producer to start. Most'),
       updated_at = now()
 WHERE slug = 'mickey-dastinz'
   AND position('The starting point is uncommon for an electronic producer. Most' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'El punto de partida es poco frecuente para un productor electrónico. Casi toda', 'Ése es un punto de partida raro para un productor electrónico. Casi toda')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'mickey-dastinz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('El punto de partida es poco frecuente para un productor electrónico. Casi toda' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'El punto de partida es poco frecuente para un productor electrónico. Casi toda', 'Ése es un punto de partida raro para un productor electrónico. Casi toda'),
       updated_at = now()
 WHERE slug = 'mickey-dastinz'
   AND position('El punto de partida es poco frecuente para un productor electrónico. Casi toda' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, '.', '. That is the whole argument for why she matters, stated as a list of names.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'miriam-cruz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, '.', '. That is the whole argument for why she matters, stated as a list of names.'),
       updated_at = now()
 WHERE slug = 'miriam-cruz'
   AND position('.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, '.', '. Ése es el argumento entero de por qué ella importa, dicho como una lista de nombres.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'miriam-cruz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, '.', '. Ése es el argumento entero de por qué ella importa, dicho como una lista de nombres.'),
       updated_at = now()
 WHERE slug = 'miriam-cruz'
   AND position('.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'singing with her: she was signed as an exclusive artist elsewhere.', 'singing with her — she was signed as an exclusive artist elsewhere — which is the sort of detail that explains why reunions in this business are rarer than audiences assume.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'monchy'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('singing with her: she was signed as an exclusive artist elsewhere.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'singing with her: she was signed as an exclusive artist elsewhere.', 'singing with her — she was signed as an exclusive artist elsewhere — which is the sort of detail that explains why reunions in this business are rarer than audiences assume.'),
       updated_at = now()
 WHERE slug = 'monchy'
   AND position('singing with her: she was signed as an exclusive artist elsewhere.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'cantar con ella: estaba firmada como artista exclusiva en otro sitio.', 'cantar con ella —estaba firmada como artista exclusiva en otro sitio—, que es la clase de detalle que explica por qué los reencuentros en este negocio son más raros de lo que el público supone.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'monchy'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('cantar con ella: estaba firmada como artista exclusiva en otro sitio.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'cantar con ella: estaba firmada como artista exclusiva en otro sitio.', 'cantar con ella —estaba firmada como artista exclusiva en otro sitio—, que es la clase de detalle que explica por qué los reencuentros en este negocio son más raros de lo que el público supone.'),
       updated_at = now()
 WHERE slug = 'monchy'
   AND position('cantar con ella: estaba firmada como artista exclusiva en otro sitio.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'The route out was the standard one for a Dominican jazz musician of his generation; the return was not. He came back and stayed.', 'That is the standard route out for a Dominican jazz musician of his generation, and the unusual part is the return: he came back and stayed.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'oscar-micheli'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('The route out was the standard one for a Dominican jazz musician of his generation; the return was not. He came back and stayed.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'The route out was the standard one for a Dominican jazz musician of his generation; the return was not. He came back and stayed.', 'That is the standard route out for a Dominican jazz musician of his generation, and the unusual part is the return: he came back and stayed.'),
       updated_at = now()
 WHERE slug = 'oscar-micheli'
   AND position('The route out was the standard one for a Dominican jazz musician of his generation; the return was not. He came back and stayed.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'La ruta de salida era la corriente para un músico de jazz dominicano de su generación; el regreso no. Volvió y se quedó.', 'Esa es la ruta de salida corriente para un músico de jazz dominicano de su generación, y lo raro es el regreso: volvió y se quedó.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'oscar-micheli'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('La ruta de salida era la corriente para un músico de jazz dominicano de su generación; el regreso no. Volvió y se quedó.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'La ruta de salida era la corriente para un músico de jazz dominicano de su generación; el regreso no. Volvió y se quedó.', 'Esa es la ruta de salida corriente para un músico de jazz dominicano de su generación, y lo raro es el regreso: volvió y se quedó.'),
       updated_at = now()
 WHERE slug = 'oscar-micheli'
   AND position('La ruta de salida era la corriente para un músico de jazz dominicano de su generación; el regreso no. Volvió y se quedó.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'The apprenticeship was an uncommon one for a bandleader: he learned the room', 'That is an unusual apprenticeship for a bandleader: he learned the room')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'raul-acosta'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('The apprenticeship was an uncommon one for a bandleader: he learned the room' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'The apprenticeship was an uncommon one for a bandleader: he learned the room', 'That is an unusual apprenticeship for a bandleader: he learned the room'),
       updated_at = now()
 WHERE slug = 'raul-acosta'
   AND position('The apprenticeship was an uncommon one for a bandleader: he learned the room' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'El aprendizaje fue poco común para un director de orquesta: aprendió la sala', 'Es un aprendizaje raro para un director de orquesta: aprendió la sala')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'raul-acosta'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('El aprendizaje fue poco común para un director de orquesta: aprendió la sala' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'El aprendizaje fue poco común para un director de orquesta: aprendió la sala', 'Es un aprendizaje raro para un director de orquesta: aprendió la sala'),
       updated_at = now()
 WHERE slug = 'raul-acosta'
   AND position('El aprendizaje fue poco común para un director de orquesta: aprendió la sala' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'The effort went well beyond what a hook normally requires. They were not sampling', 'That is an unusual amount of trouble to go to for a hook, and it says what the record was doing. They were not sampling')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'rocko-fara-on'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('The effort went well beyond what a hook normally requires. They were not sampling' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'The effort went well beyond what a hook normally requires. They were not sampling', 'That is an unusual amount of trouble to go to for a hook, and it says what the record was doing. They were not sampling'),
       updated_at = now()
 WHERE slug = 'rocko-fara-on'
   AND position('The effort went well beyond what a hook normally requires. They were not sampling' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'El esfuerzo fue muy superior al que un gancho suele exigir. No estaban sampleando', 'Es una cantidad rara de trabajo para un gancho, y dice lo que estaba haciendo el disco. No estaban sampleando')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'rocko-fara-on'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('El esfuerzo fue muy superior al que un gancho suele exigir. No estaban sampleando' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'El esfuerzo fue muy superior al que un gancho suele exigir. No estaban sampleando', 'Es una cantidad rara de trabajo para un gancho, y dice lo que estaba haciendo el disco. No estaban sampleando'),
       updated_at = now()
 WHERE slug = 'rocko-fara-on'
   AND position('El esfuerzo fue muy superior al que un gancho suele exigir. No estaban sampleando' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'merengue típico died because they are prostituting it.', 'merengue típico died because they are prostituting it, which is not the sort of thing a working bandleader usually says out loud about his own genre.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'shino-aguakate'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('merengue típico died because they are prostituting it.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'merengue típico died because they are prostituting it.', 'merengue típico died because they are prostituting it, which is not the sort of thing a working bandleader usually says out loud about his own genre.'),
       updated_at = now()
 WHERE slug = 'shino-aguakate'
   AND position('merengue típico died because they are prostituting it.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'el merengue típico se murió porque lo están prostituyendo.', 'el merengue típico se murió porque lo están prostituyendo, que no es la clase de cosa que un director de banda en activo suele decir en voz alta de su propio género.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'shino-aguakate'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('el merengue típico se murió porque lo están prostituyendo.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'el merengue típico se murió porque lo están prostituyendo.', 'el merengue típico se murió porque lo están prostituyendo, que no es la clase de cosa que un director de banda en activo suele decir en voz alta de su propio género.'),
       updated_at = now()
 WHERE slug = 'shino-aguakate'
   AND position('el merengue típico se murió porque lo están prostituyendo.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'The statement is an uncommon one in Dominican urban music, where the economics push hard towards the single that works this month, and building an argument across a catalogue is the harder bet.', 'That is an unusual thing to say out loud in Dominican urban music, where the economics push hard towards the single that works this month. Building an argument across a catalogue is the harder bet.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 't-y-s'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('The statement is an uncommon one in Dominican urban music, where the economics push hard towards the single that works this month, and building an argument across a catalogue is the harder bet.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'The statement is an uncommon one in Dominican urban music, where the economics push hard towards the single that works this month, and building an argument across a catalogue is the harder bet.', 'That is an unusual thing to say out loud in Dominican urban music, where the economics push hard towards the single that works this month. Building an argument across a catalogue is the harder bet.'),
       updated_at = now()
 WHERE slug = 't-y-s'
   AND position('The statement is an uncommon one in Dominican urban music, where the economics push hard towards the single that works this month, and building an argument across a catalogue is the harder bet.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'La declaración es poco frecuente en la música urbana dominicana, donde la economía empuja fuerte hacia el sencillo que funciona este mes, y construir un argumento a lo largo de un catálogo es la apuesta difícil.', 'Eso no es algo que se diga en voz alta a menudo en la música urbana dominicana, donde la economía empuja fuerte hacia el sencillo que funciona este mes. Construir un argumento a lo largo de un catálogo es la apuesta difícil.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 't-y-s'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('La declaración es poco frecuente en la música urbana dominicana, donde la economía empuja fuerte hacia el sencillo que funciona este mes, y construir un argumento a lo largo de un catálogo es la apuesta difícil.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'La declaración es poco frecuente en la música urbana dominicana, donde la economía empuja fuerte hacia el sencillo que funciona este mes, y construir un argumento a lo largo de un catálogo es la apuesta difícil.', 'Eso no es algo que se diga en voz alta a menudo en la música urbana dominicana, donde la economía empuja fuerte hacia el sencillo que funciona este mes. Construir un argumento a lo largo de un catálogo es la apuesta difícil.'),
       updated_at = now()
 WHERE slug = 't-y-s'
   AND position('La declaración es poco frecuente en la música urbana dominicana, donde la economía empuja fuerte hacia el sencillo que funciona este mes, y construir un argumento a lo largo de un catálogo es la apuesta difícil.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That sequence is the most consequential episode in his career, and one that a discography cannot record.', 'That sequence is the most consequential thing in his career and it is the kind of thing a discography cannot show.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'topo-la-maskara'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That sequence is the most consequential episode in his career, and one that a discography cannot record.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That sequence is the most consequential episode in his career, and one that a discography cannot record.', 'That sequence is the most consequential thing in his career and it is the kind of thing a discography cannot show.'),
       updated_at = now()
 WHERE slug = 'topo-la-maskara'
   AND position('That sequence is the most consequential episode in his career, and one that a discography cannot record.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Esa secuencia es el episodio más consecuente de su carrera, y uno que una discografía no puede registrar.', 'Esa secuencia es lo más consecuente de su carrera y es justo lo que una discografía no puede mostrar.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'topo-la-maskara'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Esa secuencia es el episodio más consecuente de su carrera, y uno que una discografía no puede registrar.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Esa secuencia es el episodio más consecuente de su carrera, y uno que una discografía no puede registrar.', 'Esa secuencia es lo más consecuente de su carrera y es justo lo que una discografía no puede mostrar.'),
       updated_at = now()
 WHERE slug = 'topo-la-maskara'
   AND position('Esa secuencia es el episodio más consecuente de su carrera, y uno que una discografía no puede registrar.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'It was not unusual for a Dominican bandleader working the New York circuit in those years.', 'That was not unusual for a Dominican bandleader working the New York circuit in those years.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'victor-irizarry-y-su-orquesta'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('It was not unusual for a Dominican bandleader working the New York circuit in those years.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'It was not unusual for a Dominican bandleader working the New York circuit in those years.', 'That was not unusual for a Dominican bandleader working the New York circuit in those years.'),
       updated_at = now()
 WHERE slug = 'victor-irizarry-y-su-orquesta'
   AND position('It was not unusual for a Dominican bandleader working the New York circuit in those years.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'The recognition was uncommon for a debut by a guitarist working outside the commercial genres, and it set the terms for everything after.', 'That is an unusual place for a debut by a guitarist working outside the commercial genres, and it set the terms for everything after.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'yasser-tejeda'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('The recognition was uncommon for a debut by a guitarist working outside the commercial genres, and it set the terms for everything after.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'The recognition was uncommon for a debut by a guitarist working outside the commercial genres, and it set the terms for everything after.', 'That is an unusual place for a debut by a guitarist working outside the commercial genres, and it set the terms for everything after.'),
       updated_at = now()
 WHERE slug = 'yasser-tejeda'
   AND position('The recognition was uncommon for a debut by a guitarist working outside the commercial genres, and it set the terms for everything after.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'El reconocimiento fue poco común para el debut de un guitarrista que trabaja fuera de los géneros comerciales, y fijó los términos de todo lo que vino después.', 'Es un lugar poco común para el debut de un guitarrista que trabaja fuera de los géneros comerciales, y fijó los términos de todo lo que vino después.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'yasser-tejeda'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('El reconocimiento fue poco común para el debut de un guitarrista que trabaja fuera de los géneros comerciales, y fijó los términos de todo lo que vino después.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'El reconocimiento fue poco común para el debut de un guitarrista que trabaja fuera de los géneros comerciales, y fijó los términos de todo lo que vino después.', 'Es un lugar poco común para el debut de un guitarrista que trabaja fuera de los géneros comerciales, y fijó los términos de todo lo que vino después.'),
       updated_at = now()
 WHERE slug = 'yasser-tejeda'
   AND position('El reconocimiento fue poco común para el debut de un guitarrista que trabaja fuera de los géneros comerciales, y fijó los términos de todo lo que vino después.' in bio_es) > 0;

COMMIT;
