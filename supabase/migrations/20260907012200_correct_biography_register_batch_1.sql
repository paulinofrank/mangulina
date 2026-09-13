BEGIN;

-- Lote 1 de corrección de registro. Nueve fichas, veintidós sustituciones.
-- 
-- Todas las fichas de este lote son buenas salvo por una o dos oraciones que
-- comentan el dato en vez de exponerlo, o que le hablan al lector. Se cambia
-- esa oración y nada más: no se toca ningún hecho, ninguna fecha, ningún
-- nombre y ningún enlace.
-- 
-- SE APROVECHA PARA QUITAR UNA CIFRA DE PÚBLICO en zawezo-del-patio, que decía
-- "un público de ciento sesenta mil personas en su canal". Escrita con letras
-- pasó por delante de todas las revisiones, pero es un conteo de suscriptores y
-- esos no van. Se queda la afirmación, que es la que importa: que sostiene
-- público sin éxito, sin radio y sin sello.
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
-- PARA REVERTIR: supabase/rollback/20260907012200_revert_correct_biography_register_batch_1.sql

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'a rock band called Hierro de Fuego. That is a genuinely unusual door into merengue, and it is the first thing to know about how his records sound.', 'a rock band called Hierro de Fuego, an uncommon point of entry into merengue that carried into the sound of his records.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dioni-fernandez-y-el-equipo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('a rock band called Hierro de Fuego. That is a genuinely unusual door into merengue, and it is the first thing to know about how his records sound.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'a rock band called Hierro de Fuego. That is a genuinely unusual door into merengue, and it is the first thing to know about how his records sound.', 'a rock band called Hierro de Fuego, an uncommon point of entry into merengue that carried into the sound of his records.'),
       updated_at = now()
 WHERE slug = 'dioni-fernandez-y-el-equipo'
   AND position('a rock band called Hierro de Fuego. That is a genuinely unusual door into merengue, and it is the first thing to know about how his records sound.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'una banda de rock llamada Hierro de Fuego. Es una puerta de entrada al merengue genuinamente rara, y es lo primero que hay que saber para entender cómo suenan sus discos.', 'una banda de rock llamada Hierro de Fuego, una puerta de entrada al merengue poco frecuente que se trasladó al sonido de sus discos.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dioni-fernandez-y-el-equipo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('una banda de rock llamada Hierro de Fuego. Es una puerta de entrada al merengue genuinamente rara, y es lo primero que hay que saber para entender cómo suenan sus discos.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'una banda de rock llamada Hierro de Fuego. Es una puerta de entrada al merengue genuinamente rara, y es lo primero que hay que saber para entender cómo suenan sus discos.', 'una banda de rock llamada Hierro de Fuego, una puerta de entrada al merengue poco frecuente que se trasladó al sonido de sus discos.'),
       updated_at = now()
 WHERE slug = 'dioni-fernandez-y-el-equipo'
   AND position('una banda de rock llamada Hierro de Fuego. Es una puerta de entrada al merengue genuinamente rara, y es lo primero que hay que saber para entender cómo suenan sus discos.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'If you had done a season with El Equipo you could go anywhere, and if you had not, you had something to prove.', 'A musician who had done a season with El Equipo could go anywhere; one who had not still had something to prove.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dioni-fernandez-y-el-equipo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('If you had done a season with El Equipo you could go anywhere, and if you had not, you had something to prove.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'If you had done a season with El Equipo you could go anywhere, and if you had not, you had something to prove.', 'A musician who had done a season with El Equipo could go anywhere; one who had not still had something to prove.'),
       updated_at = now()
 WHERE slug = 'dioni-fernandez-y-el-equipo'
   AND position('If you had done a season with El Equipo you could go anywhere, and if you had not, you had something to prove.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Si uno había hecho una temporada con El Equipo podía ir a cualquier parte, y si no la había hecho, tenía algo que demostrar.', 'Quien había hecho una temporada con El Equipo podía ir a cualquier parte; quien no la había hecho todavía tenía algo que demostrar.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dioni-fernandez-y-el-equipo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Si uno había hecho una temporada con El Equipo podía ir a cualquier parte, y si no la había hecho, tenía algo que demostrar.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Si uno había hecho una temporada con El Equipo podía ir a cualquier parte, y si no la había hecho, tenía algo que demostrar.', 'Quien había hecho una temporada con El Equipo podía ir a cualquier parte; quien no la había hecho todavía tenía algo que demostrar.'),
       updated_at = now()
 WHERE slug = 'dioni-fernandez-y-el-equipo'
   AND position('Si uno había hecho una temporada con El Equipo podía ir a cualquier parte, y si no la había hecho, tenía algo que demostrar.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'If you have heard a merengue recorded in the two decades either side of 1990, you have almost certainly heard him, and the sleeve almost certainly did not say so.', 'He played on a large share of the merengue recorded in the two decades either side of 1990, most often without a credit on the sleeve.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'crispin-fernandez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('If you have heard a merengue recorded in the two decades either side of 1990, you have almost certainly heard him, and the sleeve almost certainly did not say so.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'If you have heard a merengue recorded in the two decades either side of 1990, you have almost certainly heard him, and the sleeve almost certainly did not say so.', 'He played on a large share of the merengue recorded in the two decades either side of 1990, most often without a credit on the sleeve.'),
       updated_at = now()
 WHERE slug = 'crispin-fernandez'
   AND position('If you have heard a merengue recorded in the two decades either side of 1990, you have almost certainly heard him, and the sleeve almost certainly did not say so.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Si alguien ha oído un merengue grabado en las dos décadas alrededor de 1990, casi con seguridad lo ha oído a él, y casi con seguridad la carátula no lo decía.', 'Participó en buena parte del merengue grabado en las dos décadas alrededor de 1990, casi siempre sin que la carátula lo acreditara.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'crispin-fernandez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Si alguien ha oído un merengue grabado en las dos décadas alrededor de 1990, casi con seguridad lo ha oído a él, y casi con seguridad la carátula no lo decía.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Si alguien ha oído un merengue grabado en las dos décadas alrededor de 1990, casi con seguridad lo ha oído a él, y casi con seguridad la carátula no lo decía.', 'Participó en buena parte del merengue grabado en las dos décadas alrededor de 1990, casi siempre sin que la carátula lo acreditara.'),
       updated_at = now()
 WHERE slug = 'crispin-fernandez'
   AND position('Si alguien ha oído un merengue grabado en las dos décadas alrededor de 1990, casi con seguridad lo ha oído a él, y casi con seguridad la carátula no lo decía.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That single fact explains most of what is unusual about him and most of why he is hard to find.', 'The choice of language sets him apart from his Dominican contemporaries and is the main reason his catalogue is difficult to trace.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'king-streetz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That single fact explains most of what is unusual about him and most of why he is hard to find.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That single fact explains most of what is unusual about him and most of why he is hard to find.', 'The choice of language sets him apart from his Dominican contemporaries and is the main reason his catalogue is difficult to trace.'),
       updated_at = now()
 WHERE slug = 'king-streetz'
   AND position('That single fact explains most of what is unusual about him and most of why he is hard to find.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Ese solo dato explica casi todo lo raro que tiene y casi todo lo que cuesta encontrarlo.', 'La elección del idioma lo separa de sus contemporáneos dominicanos y es la razón principal de que su catálogo cueste rastrear.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'king-streetz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Ese solo dato explica casi todo lo raro que tiene y casi todo lo que cuesta encontrarlo.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Ese solo dato explica casi todo lo raro que tiene y casi todo lo que cuesta encontrarlo.', 'La elección del idioma lo separa de sus contemporáneos dominicanos y es la razón principal de que su catálogo cueste rastrear.'),
       updated_at = now()
 WHERE slug = 'king-streetz'
   AND position('Ese solo dato explica casi todo lo raro que tiene y casi todo lo que cuesta encontrarlo.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is unusual and it matters. Dominican tropical music has produced world-class engineering and almost no written record of how it is done; a two-hour video of somebody actually working the desk is the closest thing the genre has to documentation.', 'Material of this kind is scarce. Dominican tropical music has produced world-class engineering and almost no written record of how it is done, and a two-hour video of an engineer working the desk is among the few documents the field has.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'luis-mansilla'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is unusual and it matters. Dominican tropical music has produced world-class engineering and almost no written record of how it is done; a two-hour video of somebody actually working the desk is the closest thing the genre has to documentation.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is unusual and it matters. Dominican tropical music has produced world-class engineering and almost no written record of how it is done; a two-hour video of somebody actually working the desk is the closest thing the genre has to documentation.', 'Material of this kind is scarce. Dominican tropical music has produced world-class engineering and almost no written record of how it is done, and a two-hour video of an engineer working the desk is among the few documents the field has.'),
       updated_at = now()
 WHERE slug = 'luis-mansilla'
   AND position('That is unusual and it matters. Dominican tropical music has produced world-class engineering and almost no written record of how it is done; a two-hour video of somebody actually working the desk is the closest thing the genre has to documentation.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Eso es poco común y pesa. La música tropical dominicana ha producido ingeniería de primer nivel y casi ningún registro escrito de cómo se hace; un video de dos horas de alguien trabajando la consola de verdad es lo más parecido a documentación que el género tiene.', 'Material de ese tipo escasea. La música tropical dominicana ha producido ingeniería de primer nivel y casi ningún registro escrito de cómo se hace, y un video de dos horas de un ingeniero trabajando la consola está entre los pocos documentos con que cuenta el oficio.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'luis-mansilla'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Eso es poco común y pesa. La música tropical dominicana ha producido ingeniería de primer nivel y casi ningún registro escrito de cómo se hace; un video de dos horas de alguien trabajando la consola de verdad es lo más parecido a documentación que el género tiene.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Eso es poco común y pesa. La música tropical dominicana ha producido ingeniería de primer nivel y casi ningún registro escrito de cómo se hace; un video de dos horas de alguien trabajando la consola de verdad es lo más parecido a documentación que el género tiene.', 'Material de ese tipo escasea. La música tropical dominicana ha producido ingeniería de primer nivel y casi ningún registro escrito de cómo se hace, y un video de dos horas de un ingeniero trabajando la consola está entre los pocos documentos con que cuenta el oficio.'),
       updated_at = now()
 WHERE slug = 'luis-mansilla'
   AND position('Eso es poco común y pesa. La música tropical dominicana ha producido ingeniería de primer nivel y casi ningún registro escrito de cómo se hace; un video de dos horas de alguien trabajando la consola de verdad es lo más parecido a documentación que el género tiene.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is a real job rather than an absence of one. In the Dominican Christian urban scene', 'The distribution reflects how the scene works. In the Dominican Christian urban scene')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'nj-melody'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is a real job rather than an absence of one. In the Dominican Christian urban scene' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is a real job rather than an absence of one. In the Dominican Christian urban scene', 'The distribution reflects how the scene works. In the Dominican Christian urban scene'),
       updated_at = now()
 WHERE slug = 'nj-melody'
   AND position('That is a real job rather than an absence of one. In the Dominican Christian urban scene' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Eso es un oficio de verdad y no la ausencia de uno. En la escena urbana cristiana dominicana', 'Ese reparto refleja cómo funciona la escena. En la escena urbana cristiana dominicana')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'nj-melody'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Eso es un oficio de verdad y no la ausencia de uno. En la escena urbana cristiana dominicana' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Eso es un oficio de verdad y no la ausencia de uno. En la escena urbana cristiana dominicana', 'Ese reparto refleja cómo funciona la escena. En la escena urbana cristiana dominicana'),
       updated_at = now()
 WHERE slug = 'nj-melody'
   AND position('Eso es un oficio de verdad y no la ausencia de uno. En la escena urbana cristiana dominicana' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'introduced him to a producer with a label. That is the hinge. A Bronx kid writing bilingual songs could have gone half a dozen directions; somebody pointed him at his parents’ music.', 'introduced him to a producer with a label. The intervention was decisive: a Bronx teenager writing bilingual songs could have gone in several directions, and this one turned him toward his parents’ music.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'prince-royce'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('introduced him to a producer with a label. That is the hinge. A Bronx kid writing bilingual songs could have gone half a dozen directions; somebody pointed him at his parents’ music.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'introduced him to a producer with a label. That is the hinge. A Bronx kid writing bilingual songs could have gone half a dozen directions; somebody pointed him at his parents’ music.', 'introduced him to a producer with a label. The intervention was decisive: a Bronx teenager writing bilingual songs could have gone in several directions, and this one turned him toward his parents’ music.'),
       updated_at = now()
 WHERE slug = 'prince-royce'
   AND position('introduced him to a producer with a label. That is the hinge. A Bronx kid writing bilingual songs could have gone half a dozen directions; somebody pointed him at his parents’ music.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'le presentó a un productor con sello. Ahí está la bisagra. Un muchacho del Bronx que escribía canciones bilingües podía haber ido por media docena de caminos; alguien le señaló la música de sus padres.', 'le presentó a un productor con sello. La intervención fue decisiva: un muchacho del Bronx que escribía canciones bilingües podía haber ido por varios caminos, y esa lo orientó hacia la música de sus padres.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'prince-royce'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('le presentó a un productor con sello. Ahí está la bisagra. Un muchacho del Bronx que escribía canciones bilingües podía haber ido por media docena de caminos; alguien le señaló la música de sus padres.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'le presentó a un productor con sello. Ahí está la bisagra. Un muchacho del Bronx que escribía canciones bilingües podía haber ido por media docena de caminos; alguien le señaló la música de sus padres.', 'le presentó a un productor con sello. La intervención fue decisiva: un muchacho del Bronx que escribía canciones bilingües podía haber ido por varios caminos, y esa lo orientó hacia la música de sus padres.'),
       updated_at = now()
 WHERE slug = 'prince-royce'
   AND position('le presentó a un productor con sello. Ahí está la bisagra. Un muchacho del Bronx que escribía canciones bilingües podía haber ido por media docena de caminos; alguien le señaló la música de sus padres.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That single is the thesis of the whole career and it was there from the first record. Take a song the whole hemisphere already knows in English, put it over a bachata guitar, sing it in both languages, and let two audiences hear something that belongs to each of them. Nothing he has done since departs from it.', 'The single established the method he has worked with ever since: take a song the hemisphere already knows in English, set it over a bachata guitar, sing it in both languages, and give two audiences something that belongs to each of them. Little of what he has recorded since departs from it.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'prince-royce'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That single is the thesis of the whole career and it was there from the first record. Take a song the whole hemisphere already knows in English, put it over a bachata guitar, sing it in both languages, and let two audiences hear something that belongs to each of them. Nothing he has done since departs from it.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That single is the thesis of the whole career and it was there from the first record. Take a song the whole hemisphere already knows in English, put it over a bachata guitar, sing it in both languages, and let two audiences hear something that belongs to each of them. Nothing he has done since departs from it.', 'The single established the method he has worked with ever since: take a song the hemisphere already knows in English, set it over a bachata guitar, sing it in both languages, and give two audiences something that belongs to each of them. Little of what he has recorded since departs from it.'),
       updated_at = now()
 WHERE slug = 'prince-royce'
   AND position('That single is the thesis of the whole career and it was there from the first record. Take a song the whole hemisphere already knows in English, put it over a bachata guitar, sing it in both languages, and let two audiences hear something that belongs to each of them. Nothing he has done since departs from it.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Ese sencillo es la tesis de toda la carrera y ya estaba en el primer disco. Agarrar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas, y dejar que dos públicos oigan algo que le pertenece a cada uno. Nada de lo que ha hecho después se aparta de eso.', 'El sencillo fijó el método con el que ha trabajado desde entonces: tomar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas y darle a dos públicos algo que le pertenece a cada uno. Poco de lo que ha grabado después se aparta de ese planteamiento.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'prince-royce'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Ese sencillo es la tesis de toda la carrera y ya estaba en el primer disco. Agarrar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas, y dejar que dos públicos oigan algo que le pertenece a cada uno. Nada de lo que ha hecho después se aparta de eso.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Ese sencillo es la tesis de toda la carrera y ya estaba en el primer disco. Agarrar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas, y dejar que dos públicos oigan algo que le pertenece a cada uno. Nada de lo que ha hecho después se aparta de eso.', 'El sencillo fijó el método con el que ha trabajado desde entonces: tomar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas y darle a dos públicos algo que le pertenece a cada uno. Poco de lo que ha grabado después se aparta de ese planteamiento.'),
       updated_at = now()
 WHERE slug = 'prince-royce'
   AND position('Ese sencillo es la tesis de toda la carrera y ya estaba en el primer disco. Agarrar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas, y dejar que dos públicos oigan algo que le pertenece a cada uno. Nada de lo que ha hecho después se aparta de eso.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'holds an audience of a hundred and sixty thousand on his channel without a hit, without radio and without a label behind him.', 'sustains an audience on his channel without a hit, without radio and without a label behind him.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'zawezo-del-patio'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('holds an audience of a hundred and sixty thousand on his channel without a hit, without radio and without a label behind him.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'holds an audience of a hundred and sixty thousand on his channel without a hit, without radio and without a label behind him.', 'sustains an audience on his channel without a hit, without radio and without a label behind him.'),
       updated_at = now()
 WHERE slug = 'zawezo-del-patio'
   AND position('holds an audience of a hundred and sixty thousand on his channel without a hit, without radio and without a label behind him.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'sostiene un público de ciento sesenta mil personas en su canal sin un éxito, sin radio y sin sello detrás.', 'sostiene un público propio en su canal sin un éxito, sin radio y sin sello detrás.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'zawezo-del-patio'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('sostiene un público de ciento sesenta mil personas en su canal sin un éxito, sin radio y sin sello detrás.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'sostiene un público de ciento sesenta mil personas en su canal sin un éxito, sin radio y sin sello detrás.', 'sostiene un público propio en su canal sin un éxito, sin radio y sin sello detrás.'),
       updated_at = now()
 WHERE slug = 'zawezo-del-patio'
   AND position('sostiene un público de ciento sesenta mil personas en su canal sin un éxito, sin radio y sin sello detrás.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'That is an unusual thing for a Dominican rapper to have built. The genre at home runs on the single that works this season; his catalogue is designed to be followed rather than sampled, and enough people are following it.', 'The arrangement is uncommon among Dominican rappers. The genre at home runs on the single that works this season, while his catalogue is built to be followed as a body of work.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'zawezo-del-patio'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('That is an unusual thing for a Dominican rapper to have built. The genre at home runs on the single that works this season; his catalogue is designed to be followed rather than sampled, and enough people are following it.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'That is an unusual thing for a Dominican rapper to have built. The genre at home runs on the single that works this season; his catalogue is designed to be followed rather than sampled, and enough people are following it.', 'The arrangement is uncommon among Dominican rappers. The genre at home runs on the single that works this season, while his catalogue is built to be followed as a body of work.'),
       updated_at = now()
 WHERE slug = 'zawezo-del-patio'
   AND position('That is an unusual thing for a Dominican rapper to have built. The genre at home runs on the single that works this season; his catalogue is designed to be followed rather than sampled, and enough people are following it.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Eso es una cosa rara de haber construido para un rapero dominicano. El género en casa funciona con el sencillo que sirve esta temporada; su catálogo está hecho para seguirse y no para picotearse, y hay bastante gente siguiéndolo.', 'El planteamiento es poco frecuente entre los raperos dominicanos. El género en casa funciona con el sencillo que sirve esta temporada, mientras que su catálogo está hecho para seguirse como obra.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'zawezo-del-patio'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Eso es una cosa rara de haber construido para un rapero dominicano. El género en casa funciona con el sencillo que sirve esta temporada; su catálogo está hecho para seguirse y no para picotearse, y hay bastante gente siguiéndolo.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Eso es una cosa rara de haber construido para un rapero dominicano. El género en casa funciona con el sencillo que sirve esta temporada; su catálogo está hecho para seguirse y no para picotearse, y hay bastante gente siguiéndolo.', 'El planteamiento es poco frecuente entre los raperos dominicanos. El género en casa funciona con el sencillo que sirve esta temporada, mientras que su catálogo está hecho para seguirse como obra.'),
       updated_at = now()
 WHERE slug = 'zawezo-del-patio'
   AND position('Eso es una cosa rara de haber construido para un rapero dominicano. El género en casa funciona con el sencillo que sirve esta temporada; su catálogo está hecho para seguirse y no para picotearse, y hay bastante gente siguiéndolo.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Eso exige una voz que pueda hacer de verdad las dos cosas.', 'El resultado exige una voz capaz de sostener los dos registros.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'carlos-alfredo-fatule'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Eso exige una voz que pueda hacer de verdad las dos cosas.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Eso exige una voz que pueda hacer de verdad las dos cosas.', 'El resultado exige una voz capaz de sostener los dos registros.'),
       updated_at = now()
 WHERE slug = 'carlos-alfredo-fatule'
   AND position('Eso exige una voz que pueda hacer de verdad las dos cosas.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'abrieron con el himno y no con los boleros, que probablemente sea lo justo y desde luego es lo que él habría esperado.', 'abrieron con el himno y no con los boleros.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'anibal-de-pena'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('abrieron con el himno y no con los boleros, que probablemente sea lo justo y desde luego es lo que él habría esperado.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'abrieron con el himno y no con los boleros, que probablemente sea lo justo y desde luego es lo que él habría esperado.', 'abrieron con el himno y no con los boleros.'),
       updated_at = now()
 WHERE slug = 'anibal-de-pena'
   AND position('abrieron con el himno y no con los boleros, que probablemente sea lo justo y desde luego es lo que él habría esperado.' in bio_es) > 0;

COMMIT;
