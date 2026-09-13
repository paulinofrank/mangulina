BEGIN;

-- Revierte 20260907012200_correct_biography_register_batch_1.sql.
--
-- Devuelve el texto anterior, con el registro conversacional que el editor
-- rechazó. Se conserva solo porque toda migración de este repositorio tiene
-- que ser reversible.

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'a rock band called Hierro de Fuego, an uncommon point of entry into merengue that carried into the sound of his records.', 'a rock band called Hierro de Fuego. That is a genuinely unusual door into merengue, and it is the first thing to know about how his records sound.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dioni-fernandez-y-el-equipo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('a rock band called Hierro de Fuego, an uncommon point of entry into merengue that carried into the sound of his records.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'a rock band called Hierro de Fuego, an uncommon point of entry into merengue that carried into the sound of his records.', 'a rock band called Hierro de Fuego. That is a genuinely unusual door into merengue, and it is the first thing to know about how his records sound.'),
       updated_at = now()
 WHERE slug = 'dioni-fernandez-y-el-equipo'
   AND position('a rock band called Hierro de Fuego, an uncommon point of entry into merengue that carried into the sound of his records.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'una banda de rock llamada Hierro de Fuego, una puerta de entrada al merengue poco frecuente que se trasladó al sonido de sus discos.', 'una banda de rock llamada Hierro de Fuego. Es una puerta de entrada al merengue genuinamente rara, y es lo primero que hay que saber para entender cómo suenan sus discos.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dioni-fernandez-y-el-equipo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('una banda de rock llamada Hierro de Fuego, una puerta de entrada al merengue poco frecuente que se trasladó al sonido de sus discos.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'una banda de rock llamada Hierro de Fuego, una puerta de entrada al merengue poco frecuente que se trasladó al sonido de sus discos.', 'una banda de rock llamada Hierro de Fuego. Es una puerta de entrada al merengue genuinamente rara, y es lo primero que hay que saber para entender cómo suenan sus discos.'),
       updated_at = now()
 WHERE slug = 'dioni-fernandez-y-el-equipo'
   AND position('una banda de rock llamada Hierro de Fuego, una puerta de entrada al merengue poco frecuente que se trasladó al sonido de sus discos.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'A musician who had done a season with El Equipo could go anywhere; one who had not still had something to prove.', 'If you had done a season with El Equipo you could go anywhere, and if you had not, you had something to prove.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dioni-fernandez-y-el-equipo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('A musician who had done a season with El Equipo could go anywhere; one who had not still had something to prove.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'A musician who had done a season with El Equipo could go anywhere; one who had not still had something to prove.', 'If you had done a season with El Equipo you could go anywhere, and if you had not, you had something to prove.'),
       updated_at = now()
 WHERE slug = 'dioni-fernandez-y-el-equipo'
   AND position('A musician who had done a season with El Equipo could go anywhere; one who had not still had something to prove.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Quien había hecho una temporada con El Equipo podía ir a cualquier parte; quien no la había hecho todavía tenía algo que demostrar.', 'Si uno había hecho una temporada con El Equipo podía ir a cualquier parte, y si no la había hecho, tenía algo que demostrar.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'dioni-fernandez-y-el-equipo'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Quien había hecho una temporada con El Equipo podía ir a cualquier parte; quien no la había hecho todavía tenía algo que demostrar.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Quien había hecho una temporada con El Equipo podía ir a cualquier parte; quien no la había hecho todavía tenía algo que demostrar.', 'Si uno había hecho una temporada con El Equipo podía ir a cualquier parte, y si no la había hecho, tenía algo que demostrar.'),
       updated_at = now()
 WHERE slug = 'dioni-fernandez-y-el-equipo'
   AND position('Quien había hecho una temporada con El Equipo podía ir a cualquier parte; quien no la había hecho todavía tenía algo que demostrar.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'He played on a large share of the merengue recorded in the two decades either side of 1990, most often without a credit on the sleeve.', 'If you have heard a merengue recorded in the two decades either side of 1990, you have almost certainly heard him, and the sleeve almost certainly did not say so.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'crispin-fernandez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('He played on a large share of the merengue recorded in the two decades either side of 1990, most often without a credit on the sleeve.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'He played on a large share of the merengue recorded in the two decades either side of 1990, most often without a credit on the sleeve.', 'If you have heard a merengue recorded in the two decades either side of 1990, you have almost certainly heard him, and the sleeve almost certainly did not say so.'),
       updated_at = now()
 WHERE slug = 'crispin-fernandez'
   AND position('He played on a large share of the merengue recorded in the two decades either side of 1990, most often without a credit on the sleeve.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Participó en buena parte del merengue grabado en las dos décadas alrededor de 1990, casi siempre sin que la carátula lo acreditara.', 'Si alguien ha oído un merengue grabado en las dos décadas alrededor de 1990, casi con seguridad lo ha oído a él, y casi con seguridad la carátula no lo decía.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'crispin-fernandez'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Participó en buena parte del merengue grabado en las dos décadas alrededor de 1990, casi siempre sin que la carátula lo acreditara.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Participó en buena parte del merengue grabado en las dos décadas alrededor de 1990, casi siempre sin que la carátula lo acreditara.', 'Si alguien ha oído un merengue grabado en las dos décadas alrededor de 1990, casi con seguridad lo ha oído a él, y casi con seguridad la carátula no lo decía.'),
       updated_at = now()
 WHERE slug = 'crispin-fernandez'
   AND position('Participó en buena parte del merengue grabado en las dos décadas alrededor de 1990, casi siempre sin que la carátula lo acreditara.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'The choice of language sets him apart from his Dominican contemporaries and is the main reason his catalogue is difficult to trace.', 'That single fact explains most of what is unusual about him and most of why he is hard to find.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'king-streetz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('The choice of language sets him apart from his Dominican contemporaries and is the main reason his catalogue is difficult to trace.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'The choice of language sets him apart from his Dominican contemporaries and is the main reason his catalogue is difficult to trace.', 'That single fact explains most of what is unusual about him and most of why he is hard to find.'),
       updated_at = now()
 WHERE slug = 'king-streetz'
   AND position('The choice of language sets him apart from his Dominican contemporaries and is the main reason his catalogue is difficult to trace.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'La elección del idioma lo separa de sus contemporáneos dominicanos y es la razón principal de que su catálogo cueste rastrear.', 'Ese solo dato explica casi todo lo raro que tiene y casi todo lo que cuesta encontrarlo.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'king-streetz'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('La elección del idioma lo separa de sus contemporáneos dominicanos y es la razón principal de que su catálogo cueste rastrear.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'La elección del idioma lo separa de sus contemporáneos dominicanos y es la razón principal de que su catálogo cueste rastrear.', 'Ese solo dato explica casi todo lo raro que tiene y casi todo lo que cuesta encontrarlo.'),
       updated_at = now()
 WHERE slug = 'king-streetz'
   AND position('La elección del idioma lo separa de sus contemporáneos dominicanos y es la razón principal de que su catálogo cueste rastrear.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Material of this kind is scarce. Dominican tropical music has produced world-class engineering and almost no written record of how it is done, and a two-hour video of an engineer working the desk is among the few documents the field has.', 'That is unusual and it matters. Dominican tropical music has produced world-class engineering and almost no written record of how it is done; a two-hour video of somebody actually working the desk is the closest thing the genre has to documentation.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'luis-mansilla'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('Material of this kind is scarce. Dominican tropical music has produced world-class engineering and almost no written record of how it is done, and a two-hour video of an engineer working the desk is among the few documents the field has.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'Material of this kind is scarce. Dominican tropical music has produced world-class engineering and almost no written record of how it is done, and a two-hour video of an engineer working the desk is among the few documents the field has.', 'That is unusual and it matters. Dominican tropical music has produced world-class engineering and almost no written record of how it is done; a two-hour video of somebody actually working the desk is the closest thing the genre has to documentation.'),
       updated_at = now()
 WHERE slug = 'luis-mansilla'
   AND position('Material of this kind is scarce. Dominican tropical music has produced world-class engineering and almost no written record of how it is done, and a two-hour video of an engineer working the desk is among the few documents the field has.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Material de ese tipo escasea. La música tropical dominicana ha producido ingeniería de primer nivel y casi ningún registro escrito de cómo se hace, y un video de dos horas de un ingeniero trabajando la consola está entre los pocos documentos con que cuenta el oficio.', 'Eso es poco común y pesa. La música tropical dominicana ha producido ingeniería de primer nivel y casi ningún registro escrito de cómo se hace; un video de dos horas de alguien trabajando la consola de verdad es lo más parecido a documentación que el género tiene.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'luis-mansilla'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Material de ese tipo escasea. La música tropical dominicana ha producido ingeniería de primer nivel y casi ningún registro escrito de cómo se hace, y un video de dos horas de un ingeniero trabajando la consola está entre los pocos documentos con que cuenta el oficio.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Material de ese tipo escasea. La música tropical dominicana ha producido ingeniería de primer nivel y casi ningún registro escrito de cómo se hace, y un video de dos horas de un ingeniero trabajando la consola está entre los pocos documentos con que cuenta el oficio.', 'Eso es poco común y pesa. La música tropical dominicana ha producido ingeniería de primer nivel y casi ningún registro escrito de cómo se hace; un video de dos horas de alguien trabajando la consola de verdad es lo más parecido a documentación que el género tiene.'),
       updated_at = now()
 WHERE slug = 'luis-mansilla'
   AND position('Material de ese tipo escasea. La música tropical dominicana ha producido ingeniería de primer nivel y casi ningún registro escrito de cómo se hace, y un video de dos horas de un ingeniero trabajando la consola está entre los pocos documentos con que cuenta el oficio.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'The distribution reflects how the scene works. In the Dominican Christian urban scene', 'That is a real job rather than an absence of one. In the Dominican Christian urban scene')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'nj-melody'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('The distribution reflects how the scene works. In the Dominican Christian urban scene' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'The distribution reflects how the scene works. In the Dominican Christian urban scene', 'That is a real job rather than an absence of one. In the Dominican Christian urban scene'),
       updated_at = now()
 WHERE slug = 'nj-melody'
   AND position('The distribution reflects how the scene works. In the Dominican Christian urban scene' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'Ese reparto refleja cómo funciona la escena. En la escena urbana cristiana dominicana', 'Eso es un oficio de verdad y no la ausencia de uno. En la escena urbana cristiana dominicana')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'nj-melody'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('Ese reparto refleja cómo funciona la escena. En la escena urbana cristiana dominicana' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'Ese reparto refleja cómo funciona la escena. En la escena urbana cristiana dominicana', 'Eso es un oficio de verdad y no la ausencia de uno. En la escena urbana cristiana dominicana'),
       updated_at = now()
 WHERE slug = 'nj-melody'
   AND position('Ese reparto refleja cómo funciona la escena. En la escena urbana cristiana dominicana' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'introduced him to a producer with a label. The intervention was decisive: a Bronx teenager writing bilingual songs could have gone in several directions, and this one turned him toward his parents’ music.', 'introduced him to a producer with a label. That is the hinge. A Bronx kid writing bilingual songs could have gone half a dozen directions; somebody pointed him at his parents’ music.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'prince-royce'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('introduced him to a producer with a label. The intervention was decisive: a Bronx teenager writing bilingual songs could have gone in several directions, and this one turned him toward his parents’ music.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'introduced him to a producer with a label. The intervention was decisive: a Bronx teenager writing bilingual songs could have gone in several directions, and this one turned him toward his parents’ music.', 'introduced him to a producer with a label. That is the hinge. A Bronx kid writing bilingual songs could have gone half a dozen directions; somebody pointed him at his parents’ music.'),
       updated_at = now()
 WHERE slug = 'prince-royce'
   AND position('introduced him to a producer with a label. The intervention was decisive: a Bronx teenager writing bilingual songs could have gone in several directions, and this one turned him toward his parents’ music.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'le presentó a un productor con sello. La intervención fue decisiva: un muchacho del Bronx que escribía canciones bilingües podía haber ido por varios caminos, y esa lo orientó hacia la música de sus padres.', 'le presentó a un productor con sello. Ahí está la bisagra. Un muchacho del Bronx que escribía canciones bilingües podía haber ido por media docena de caminos; alguien le señaló la música de sus padres.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'prince-royce'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('le presentó a un productor con sello. La intervención fue decisiva: un muchacho del Bronx que escribía canciones bilingües podía haber ido por varios caminos, y esa lo orientó hacia la música de sus padres.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'le presentó a un productor con sello. La intervención fue decisiva: un muchacho del Bronx que escribía canciones bilingües podía haber ido por varios caminos, y esa lo orientó hacia la música de sus padres.', 'le presentó a un productor con sello. Ahí está la bisagra. Un muchacho del Bronx que escribía canciones bilingües podía haber ido por media docena de caminos; alguien le señaló la música de sus padres.'),
       updated_at = now()
 WHERE slug = 'prince-royce'
   AND position('le presentó a un productor con sello. La intervención fue decisiva: un muchacho del Bronx que escribía canciones bilingües podía haber ido por varios caminos, y esa lo orientó hacia la música de sus padres.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'The single established the method he has worked with ever since: take a song the hemisphere already knows in English, set it over a bachata guitar, sing it in both languages, and give two audiences something that belongs to each of them. Little of what he has recorded since departs from it.', 'That single is the thesis of the whole career and it was there from the first record. Take a song the whole hemisphere already knows in English, put it over a bachata guitar, sing it in both languages, and let two audiences hear something that belongs to each of them. Nothing he has done since departs from it.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'prince-royce'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('The single established the method he has worked with ever since: take a song the hemisphere already knows in English, set it over a bachata guitar, sing it in both languages, and give two audiences something that belongs to each of them. Little of what he has recorded since departs from it.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'The single established the method he has worked with ever since: take a song the hemisphere already knows in English, set it over a bachata guitar, sing it in both languages, and give two audiences something that belongs to each of them. Little of what he has recorded since departs from it.', 'That single is the thesis of the whole career and it was there from the first record. Take a song the whole hemisphere already knows in English, put it over a bachata guitar, sing it in both languages, and let two audiences hear something that belongs to each of them. Nothing he has done since departs from it.'),
       updated_at = now()
 WHERE slug = 'prince-royce'
   AND position('The single established the method he has worked with ever since: take a song the hemisphere already knows in English, set it over a bachata guitar, sing it in both languages, and give two audiences something that belongs to each of them. Little of what he has recorded since departs from it.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'El sencillo fijó el método con el que ha trabajado desde entonces: tomar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas y darle a dos públicos algo que le pertenece a cada uno. Poco de lo que ha grabado después se aparta de ese planteamiento.', 'Ese sencillo es la tesis de toda la carrera y ya estaba en el primer disco. Agarrar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas, y dejar que dos públicos oigan algo que le pertenece a cada uno. Nada de lo que ha hecho después se aparta de eso.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'prince-royce'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('El sencillo fijó el método con el que ha trabajado desde entonces: tomar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas y darle a dos públicos algo que le pertenece a cada uno. Poco de lo que ha grabado después se aparta de ese planteamiento.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'El sencillo fijó el método con el que ha trabajado desde entonces: tomar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas y darle a dos públicos algo que le pertenece a cada uno. Poco de lo que ha grabado después se aparta de ese planteamiento.', 'Ese sencillo es la tesis de toda la carrera y ya estaba en el primer disco. Agarrar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas, y dejar que dos públicos oigan algo que le pertenece a cada uno. Nada de lo que ha hecho después se aparta de eso.'),
       updated_at = now()
 WHERE slug = 'prince-royce'
   AND position('El sencillo fijó el método con el que ha trabajado desde entonces: tomar una canción que el hemisferio entero se sabe en inglés, montarla sobre una guitarra de bachata, cantarla en los dos idiomas y darle a dos públicos algo que le pertenece a cada uno. Poco de lo que ha grabado después se aparta de ese planteamiento.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'sustains an audience on his channel without a hit, without radio and without a label behind him.', 'holds an audience of a hundred and sixty thousand on his channel without a hit, without radio and without a label behind him.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'zawezo-del-patio'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('sustains an audience on his channel without a hit, without radio and without a label behind him.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'sustains an audience on his channel without a hit, without radio and without a label behind him.', 'holds an audience of a hundred and sixty thousand on his channel without a hit, without radio and without a label behind him.'),
       updated_at = now()
 WHERE slug = 'zawezo-del-patio'
   AND position('sustains an audience on his channel without a hit, without radio and without a label behind him.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'sostiene un público propio en su canal sin un éxito, sin radio y sin sello detrás.', 'sostiene un público de ciento sesenta mil personas en su canal sin un éxito, sin radio y sin sello detrás.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'zawezo-del-patio'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('sostiene un público propio en su canal sin un éxito, sin radio y sin sello detrás.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'sostiene un público propio en su canal sin un éxito, sin radio y sin sello detrás.', 'sostiene un público de ciento sesenta mil personas en su canal sin un éxito, sin radio y sin sello detrás.'),
       updated_at = now()
 WHERE slug = 'zawezo-del-patio'
   AND position('sostiene un público propio en su canal sin un éxito, sin radio y sin sello detrás.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'The arrangement is uncommon among Dominican rappers. The genre at home runs on the single that works this season, while his catalogue is built to be followed as a body of work.', 'That is an unusual thing for a Dominican rapper to have built. The genre at home runs on the single that works this season; his catalogue is designed to be followed rather than sampled, and enough people are following it.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'zawezo-del-patio'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'en'
   AND position('The arrangement is uncommon among Dominican rappers. The genre at home runs on the single that works this season, while his catalogue is built to be followed as a body of work.' in d.document::text) > 0;

UPDATE artists
   SET bio_en = replace(bio_en, 'The arrangement is uncommon among Dominican rappers. The genre at home runs on the single that works this season, while his catalogue is built to be followed as a body of work.', 'That is an unusual thing for a Dominican rapper to have built. The genre at home runs on the single that works this season; his catalogue is designed to be followed rather than sampled, and enough people are following it.'),
       updated_at = now()
 WHERE slug = 'zawezo-del-patio'
   AND position('The arrangement is uncommon among Dominican rappers. The genre at home runs on the single that works this season, while his catalogue is built to be followed as a body of work.' in bio_en) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'El planteamiento es poco frecuente entre los raperos dominicanos. El género en casa funciona con el sencillo que sirve esta temporada, mientras que su catálogo está hecho para seguirse como obra.', 'Eso es una cosa rara de haber construido para un rapero dominicano. El género en casa funciona con el sencillo que sirve esta temporada; su catálogo está hecho para seguirse y no para picotearse, y hay bastante gente siguiéndolo.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'zawezo-del-patio'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('El planteamiento es poco frecuente entre los raperos dominicanos. El género en casa funciona con el sencillo que sirve esta temporada, mientras que su catálogo está hecho para seguirse como obra.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'El planteamiento es poco frecuente entre los raperos dominicanos. El género en casa funciona con el sencillo que sirve esta temporada, mientras que su catálogo está hecho para seguirse como obra.', 'Eso es una cosa rara de haber construido para un rapero dominicano. El género en casa funciona con el sencillo que sirve esta temporada; su catálogo está hecho para seguirse y no para picotearse, y hay bastante gente siguiéndolo.'),
       updated_at = now()
 WHERE slug = 'zawezo-del-patio'
   AND position('El planteamiento es poco frecuente entre los raperos dominicanos. El género en casa funciona con el sencillo que sirve esta temporada, mientras que su catálogo está hecho para seguirse como obra.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'El resultado exige una voz capaz de sostener los dos registros.', 'Eso exige una voz que pueda hacer de verdad las dos cosas.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'carlos-alfredo-fatule'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('El resultado exige una voz capaz de sostener los dos registros.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'El resultado exige una voz capaz de sostener los dos registros.', 'Eso exige una voz que pueda hacer de verdad las dos cosas.'),
       updated_at = now()
 WHERE slug = 'carlos-alfredo-fatule'
   AND position('El resultado exige una voz capaz de sostener los dos registros.' in bio_es) > 0;

UPDATE editorial_documents d
   SET document = replace(d.document::text, 'abrieron con el himno y no con los boleros.', 'abrieron con el himno y no con los boleros, que probablemente sea lo justo y desde luego es lo que él habría esperado.')::jsonb,
       revision = d.revision + 1,
       updated_at = now()
  FROM artists a
 WHERE d.owner_artist_id = a.id
   AND a.slug = 'anibal-de-pena'
   AND d.document_type = 'artist_biography'
   AND d.locale = 'es'
   AND position('abrieron con el himno y no con los boleros.' in d.document::text) > 0;

UPDATE artists
   SET bio_es = replace(bio_es, 'abrieron con el himno y no con los boleros.', 'abrieron con el himno y no con los boleros, que probablemente sea lo justo y desde luego es lo que él habría esperado.'),
       updated_at = now()
 WHERE slug = 'anibal-de-pena'
   AND position('abrieron con el himno y no con los boleros.' in bio_es) > 0;

COMMIT;
