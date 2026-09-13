BEGIN;

-- Lote 3 y último de corrección de registro. Doce fichas, veinticuatro
-- sustituciones. Con esto queda limpio todo lo que el detector encuentra.
-- 
-- Mismo criterio de los lotes anteriores. Cuatro de estas oraciones no se
-- reescriben sino que SE CAEN ENTERAS, porque quitado el comentario no queda
-- ningún hecho debajo:
-- 
--   kaki-vargas   -- "Eso no es tanto una queja como una descripción de cómo
--                    funcionaba el negocio." Defiende al texto de una acusación
--                    que nadie le hizo. Lo que sigue ya dice cómo funcionaba.
--   miriam-cruz   -- "Ése es el argumento entero de por qué ella importa, dicho
--                    como una lista de nombres." La lista de nombres ya está
--                    escrita encima; explicar qué demuestra es hacer la lectura
--                    en lugar del lector.
--   monchy        -- "que es la clase de detalle que explica por qué los
--                    reencuentros en este negocio son más raros de lo que el
--                    público supone."
--   shino-aguakate-- "que no es la clase de cosa que un director de banda en
--                    activo suele decir en voz alta de su propio género."
-- 
-- EN victor-irizarry SOLO SE TOCA EL INGLÉS. El español ya decía "No era raro
-- en un director dominicano...", que es exposición normal; el inglés arrancaba
-- con el demostrativo. Se igualan.
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
-- PARA REVERTIR: supabase/rollback/20260907012400_revert_correct_biography_register_batch_3.sql

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is not a complaint so much as a description of how the business worked. An orchestra belonged to', 'An orchestra belonged to')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'kaki-vargas'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is not a complaint so much as a description of how the business worked. An orchestra belonged to' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is not a complaint so much as a description of how the business worked. An orchestra belonged to', 'An orchestra belonged to'),
       updated_at = now()
 WHERE slug = 'kaki-vargas'
   AND position('That is not a complaint so much as a description of how the business worked. An orchestra belonged to' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Eso no es tanto una queja como una descripción de cómo funcionaba el negocio. Una orquesta era de', 'Una orquesta era de')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'kaki-vargas'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Eso no es tanto una queja como una descripción de cómo funcionaba el negocio. Una orquesta era de' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Eso no es tanto una queja como una descripción de cómo funcionaba el negocio. Una orquesta era de', 'Una orquesta era de'),
       updated_at = now()
 WHERE slug = 'kaki-vargas'
   AND position('Eso no es tanto una queja como una descripción de cómo funcionaba el negocio. Una orquesta era de' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is an unusual place for an electronic producer to start. Most', 'The starting point is uncommon for an electronic producer. Most')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'mickey-dastinz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is an unusual place for an electronic producer to start. Most' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is an unusual place for an electronic producer to start. Most', 'The starting point is uncommon for an electronic producer. Most'),
       updated_at = now()
 WHERE slug = 'mickey-dastinz'
   AND position('That is an unusual place for an electronic producer to start. Most' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Ése es un punto de partida raro para un productor electrónico. Casi toda', 'El punto de partida es poco frecuente para un productor electrónico. Casi toda')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'mickey-dastinz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Ése es un punto de partida raro para un productor electrónico. Casi toda' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Ése es un punto de partida raro para un productor electrónico. Casi toda', 'El punto de partida es poco frecuente para un productor electrónico. Casi toda'),
       updated_at = now()
 WHERE slug = 'mickey-dastinz'
   AND position('Ése es un punto de partida raro para un productor electrónico. Casi toda' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, '. That is the whole argument for why she matters, stated as a list of names.', '.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'miriam-cruz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('. That is the whole argument for why she matters, stated as a list of names.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, '. That is the whole argument for why she matters, stated as a list of names.', '.'),
       updated_at = now()
 WHERE slug = 'miriam-cruz'
   AND position('. That is the whole argument for why she matters, stated as a list of names.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, '. Ése es el argumento entero de por qué ella importa, dicho como una lista de nombres.', '.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'miriam-cruz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('. Ése es el argumento entero de por qué ella importa, dicho como una lista de nombres.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, '. Ése es el argumento entero de por qué ella importa, dicho como una lista de nombres.', '.'),
       updated_at = now()
 WHERE slug = 'miriam-cruz'
   AND position('. Ése es el argumento entero de por qué ella importa, dicho como una lista de nombres.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'singing with her — she was signed as an exclusive artist elsewhere — which is the sort of detail that explains why reunions in this business are rarer than audiences assume.', 'singing with her: she was signed as an exclusive artist elsewhere.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'monchy'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('singing with her — she was signed as an exclusive artist elsewhere — which is the sort of detail that explains why reunions in this business are rarer than audiences assume.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'singing with her — she was signed as an exclusive artist elsewhere — which is the sort of detail that explains why reunions in this business are rarer than audiences assume.', 'singing with her: she was signed as an exclusive artist elsewhere.'),
       updated_at = now()
 WHERE slug = 'monchy'
   AND position('singing with her — she was signed as an exclusive artist elsewhere — which is the sort of detail that explains why reunions in this business are rarer than audiences assume.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'cantar con ella —estaba firmada como artista exclusiva en otro sitio—, que es la clase de detalle que explica por qué los reencuentros en este negocio son más raros de lo que el público supone.', 'cantar con ella: estaba firmada como artista exclusiva en otro sitio.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'monchy'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('cantar con ella —estaba firmada como artista exclusiva en otro sitio—, que es la clase de detalle que explica por qué los reencuentros en este negocio son más raros de lo que el público supone.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'cantar con ella —estaba firmada como artista exclusiva en otro sitio—, que es la clase de detalle que explica por qué los reencuentros en este negocio son más raros de lo que el público supone.', 'cantar con ella: estaba firmada como artista exclusiva en otro sitio.'),
       updated_at = now()
 WHERE slug = 'monchy'
   AND position('cantar con ella —estaba firmada como artista exclusiva en otro sitio—, que es la clase de detalle que explica por qué los reencuentros en este negocio son más raros de lo que el público supone.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is the standard route out for a Dominican jazz musician of his generation, and the unusual part is the return: he came back and stayed.', 'The route out was the standard one for a Dominican jazz musician of his generation; the return was not. He came back and stayed.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'oscar-micheli'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is the standard route out for a Dominican jazz musician of his generation, and the unusual part is the return: he came back and stayed.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is the standard route out for a Dominican jazz musician of his generation, and the unusual part is the return: he came back and stayed.', 'The route out was the standard one for a Dominican jazz musician of his generation; the return was not. He came back and stayed.'),
       updated_at = now()
 WHERE slug = 'oscar-micheli'
   AND position('That is the standard route out for a Dominican jazz musician of his generation, and the unusual part is the return: he came back and stayed.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Esa es la ruta de salida corriente para un músico de jazz dominicano de su generación, y lo raro es el regreso: volvió y se quedó.', 'La ruta de salida era la corriente para un músico de jazz dominicano de su generación; el regreso no. Volvió y se quedó.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'oscar-micheli'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Esa es la ruta de salida corriente para un músico de jazz dominicano de su generación, y lo raro es el regreso: volvió y se quedó.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Esa es la ruta de salida corriente para un músico de jazz dominicano de su generación, y lo raro es el regreso: volvió y se quedó.', 'La ruta de salida era la corriente para un músico de jazz dominicano de su generación; el regreso no. Volvió y se quedó.'),
       updated_at = now()
 WHERE slug = 'oscar-micheli'
   AND position('Esa es la ruta de salida corriente para un músico de jazz dominicano de su generación, y lo raro es el regreso: volvió y se quedó.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is an unusual apprenticeship for a bandleader: he learned the room', 'The apprenticeship was an uncommon one for a bandleader: he learned the room')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'raul-acosta'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is an unusual apprenticeship for a bandleader: he learned the room' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is an unusual apprenticeship for a bandleader: he learned the room', 'The apprenticeship was an uncommon one for a bandleader: he learned the room'),
       updated_at = now()
 WHERE slug = 'raul-acosta'
   AND position('That is an unusual apprenticeship for a bandleader: he learned the room' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Es un aprendizaje raro para un director de orquesta: aprendió la sala', 'El aprendizaje fue poco común para un director de orquesta: aprendió la sala')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'raul-acosta'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Es un aprendizaje raro para un director de orquesta: aprendió la sala' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Es un aprendizaje raro para un director de orquesta: aprendió la sala', 'El aprendizaje fue poco común para un director de orquesta: aprendió la sala'),
       updated_at = now()
 WHERE slug = 'raul-acosta'
   AND position('Es un aprendizaje raro para un director de orquesta: aprendió la sala' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is an unusual amount of trouble to go to for a hook, and it says what the record was doing. They were not sampling', 'The effort went well beyond what a hook normally requires. They were not sampling')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'rocko-fara-on'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is an unusual amount of trouble to go to for a hook, and it says what the record was doing. They were not sampling' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is an unusual amount of trouble to go to for a hook, and it says what the record was doing. They were not sampling', 'The effort went well beyond what a hook normally requires. They were not sampling'),
       updated_at = now()
 WHERE slug = 'rocko-fara-on'
   AND position('That is an unusual amount of trouble to go to for a hook, and it says what the record was doing. They were not sampling' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Es una cantidad rara de trabajo para un gancho, y dice lo que estaba haciendo el disco. No estaban sampleando', 'El esfuerzo fue muy superior al que un gancho suele exigir. No estaban sampleando')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'rocko-fara-on'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Es una cantidad rara de trabajo para un gancho, y dice lo que estaba haciendo el disco. No estaban sampleando' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Es una cantidad rara de trabajo para un gancho, y dice lo que estaba haciendo el disco. No estaban sampleando', 'El esfuerzo fue muy superior al que un gancho suele exigir. No estaban sampleando'),
       updated_at = now()
 WHERE slug = 'rocko-fara-on'
   AND position('Es una cantidad rara de trabajo para un gancho, y dice lo que estaba haciendo el disco. No estaban sampleando' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'merengue típico died because they are prostituting it, which is not the sort of thing a working bandleader usually says out loud about his own genre.', 'merengue típico died because they are prostituting it.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'shino-aguakate'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('merengue típico died because they are prostituting it, which is not the sort of thing a working bandleader usually says out loud about his own genre.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'merengue típico died because they are prostituting it, which is not the sort of thing a working bandleader usually says out loud about his own genre.', 'merengue típico died because they are prostituting it.'),
       updated_at = now()
 WHERE slug = 'shino-aguakate'
   AND position('merengue típico died because they are prostituting it, which is not the sort of thing a working bandleader usually says out loud about his own genre.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'el merengue típico se murió porque lo están prostituyendo, que no es la clase de cosa que un director de banda en activo suele decir en voz alta de su propio género.', 'el merengue típico se murió porque lo están prostituyendo.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'shino-aguakate'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('el merengue típico se murió porque lo están prostituyendo, que no es la clase de cosa que un director de banda en activo suele decir en voz alta de su propio género.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'el merengue típico se murió porque lo están prostituyendo, que no es la clase de cosa que un director de banda en activo suele decir en voz alta de su propio género.', 'el merengue típico se murió porque lo están prostituyendo.'),
       updated_at = now()
 WHERE slug = 'shino-aguakate'
   AND position('el merengue típico se murió porque lo están prostituyendo, que no es la clase de cosa que un director de banda en activo suele decir en voz alta de su propio género.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is an unusual thing to say out loud in Dominican urban music, where the economics push hard towards the single that works this month. Building an argument across a catalogue is the harder bet.', 'The statement is an uncommon one in Dominican urban music, where the economics push hard towards the single that works this month, and building an argument across a catalogue is the harder bet.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 't-y-s'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is an unusual thing to say out loud in Dominican urban music, where the economics push hard towards the single that works this month. Building an argument across a catalogue is the harder bet.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is an unusual thing to say out loud in Dominican urban music, where the economics push hard towards the single that works this month. Building an argument across a catalogue is the harder bet.', 'The statement is an uncommon one in Dominican urban music, where the economics push hard towards the single that works this month, and building an argument across a catalogue is the harder bet.'),
       updated_at = now()
 WHERE slug = 't-y-s'
   AND position('That is an unusual thing to say out loud in Dominican urban music, where the economics push hard towards the single that works this month. Building an argument across a catalogue is the harder bet.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Eso no es algo que se diga en voz alta a menudo en la música urbana dominicana, donde la economía empuja fuerte hacia el sencillo que funciona este mes. Construir un argumento a lo largo de un catálogo es la apuesta difícil.', 'La declaración es poco frecuente en la música urbana dominicana, donde la economía empuja fuerte hacia el sencillo que funciona este mes, y construir un argumento a lo largo de un catálogo es la apuesta difícil.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 't-y-s'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Eso no es algo que se diga en voz alta a menudo en la música urbana dominicana, donde la economía empuja fuerte hacia el sencillo que funciona este mes. Construir un argumento a lo largo de un catálogo es la apuesta difícil.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Eso no es algo que se diga en voz alta a menudo en la música urbana dominicana, donde la economía empuja fuerte hacia el sencillo que funciona este mes. Construir un argumento a lo largo de un catálogo es la apuesta difícil.', 'La declaración es poco frecuente en la música urbana dominicana, donde la economía empuja fuerte hacia el sencillo que funciona este mes, y construir un argumento a lo largo de un catálogo es la apuesta difícil.'),
       updated_at = now()
 WHERE slug = 't-y-s'
   AND position('Eso no es algo que se diga en voz alta a menudo en la música urbana dominicana, donde la economía empuja fuerte hacia el sencillo que funciona este mes. Construir un argumento a lo largo de un catálogo es la apuesta difícil.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That sequence is the most consequential thing in his career and it is the kind of thing a discography cannot show.', 'That sequence is the most consequential episode in his career, and one that a discography cannot record.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'topo-la-maskara'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That sequence is the most consequential thing in his career and it is the kind of thing a discography cannot show.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That sequence is the most consequential thing in his career and it is the kind of thing a discography cannot show.', 'That sequence is the most consequential episode in his career, and one that a discography cannot record.'),
       updated_at = now()
 WHERE slug = 'topo-la-maskara'
   AND position('That sequence is the most consequential thing in his career and it is the kind of thing a discography cannot show.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Esa secuencia es lo más consecuente de su carrera y es justo lo que una discografía no puede mostrar.', 'Esa secuencia es el episodio más consecuente de su carrera, y uno que una discografía no puede registrar.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'topo-la-maskara'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Esa secuencia es lo más consecuente de su carrera y es justo lo que una discografía no puede mostrar.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Esa secuencia es lo más consecuente de su carrera y es justo lo que una discografía no puede mostrar.', 'Esa secuencia es el episodio más consecuente de su carrera, y uno que una discografía no puede registrar.'),
       updated_at = now()
 WHERE slug = 'topo-la-maskara'
   AND position('Esa secuencia es lo más consecuente de su carrera y es justo lo que una discografía no puede mostrar.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That was not unusual for a Dominican bandleader working the New York circuit in those years.', 'It was not unusual for a Dominican bandleader working the New York circuit in those years.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'victor-irizarry-y-su-orquesta'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That was not unusual for a Dominican bandleader working the New York circuit in those years.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That was not unusual for a Dominican bandleader working the New York circuit in those years.', 'It was not unusual for a Dominican bandleader working the New York circuit in those years.'),
       updated_at = now()
 WHERE slug = 'victor-irizarry-y-su-orquesta'
   AND position('That was not unusual for a Dominican bandleader working the New York circuit in those years.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is an unusual place for a debut by a guitarist working outside the commercial genres, and it set the terms for everything after.', 'The recognition was uncommon for a debut by a guitarist working outside the commercial genres, and it set the terms for everything after.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'yasser-tejeda'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is an unusual place for a debut by a guitarist working outside the commercial genres, and it set the terms for everything after.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is an unusual place for a debut by a guitarist working outside the commercial genres, and it set the terms for everything after.', 'The recognition was uncommon for a debut by a guitarist working outside the commercial genres, and it set the terms for everything after.'),
       updated_at = now()
 WHERE slug = 'yasser-tejeda'
   AND position('That is an unusual place for a debut by a guitarist working outside the commercial genres, and it set the terms for everything after.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Es un lugar poco común para el debut de un guitarrista que trabaja fuera de los géneros comerciales, y fijó los términos de todo lo que vino después.', 'El reconocimiento fue poco común para el debut de un guitarrista que trabaja fuera de los géneros comerciales, y fijó los términos de todo lo que vino después.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'yasser-tejeda'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Es un lugar poco común para el debut de un guitarrista que trabaja fuera de los géneros comerciales, y fijó los términos de todo lo que vino después.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Es un lugar poco común para el debut de un guitarrista que trabaja fuera de los géneros comerciales, y fijó los términos de todo lo que vino después.', 'El reconocimiento fue poco común para el debut de un guitarrista que trabaja fuera de los géneros comerciales, y fijó los términos de todo lo que vino después.'),
       updated_at = now()
 WHERE slug = 'yasser-tejeda'
   AND position('Es un lugar poco común para el debut de un guitarrista que trabaja fuera de los géneros comerciales, y fijó los términos de todo lo que vino después.' in bio_es) > 0;

COMMIT;
