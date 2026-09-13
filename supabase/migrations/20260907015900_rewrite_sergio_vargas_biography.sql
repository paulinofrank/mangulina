BEGIN;

-- Rewrite the catalogue entry for Sergio Vargas.
--
-- Sergio Vargas. QUINTA de las 235, y el caso más desproporcionado hasta ahora
-- entre lo que el artista es y lo que la ficha decía.
--
-- TENÍA DOS PÁRRAFOS DE ADJETIVOS: ni una canción, ni un disco, ni un premio.
-- Para un hombre que tiene EL GRAN SOBERANO -- el galardón mayor que entrega la
-- crónica de arte dominicana -- y DOS LATIN GRAMMY, ambos ya registrados en la
-- base. La ficha no mencionaba ninguno de los tres.
--
-- LA FILA ESTABA CASI VACÍA. Sin sort_name, sin stage_name, sin aliases, sin
-- segundo nombre ni segundo apellido, sin instrumentos, con occupations en un
-- 'musician' que no dice nada de un cantante. Se completa todo desde Wikipedia:
-- SERGIO PASCUAL VARGAS PARRA, apodado EL NEGRITO DE VILLA, tenor lírico
-- ligero.
--
-- SE LIMPIA occupations. Tenía 'musician', que para alguien cuyo primary_role
-- ya es singer no aporta nada. Queda vacío: el rol principal lo dice todo.
--
-- genres SE LLENA con bolero, bachata y salsa, que Wikipedia lista junto al
-- merengue. No repiten el primario.
--
-- NO SE GUARDA SITIO WEB. Wikipedia da sergiovargas.com.do y LO PROBÉ: no
-- resuelve, igual que el de Fernando Villalona. Dos de dos sitios oficiales
-- caídos en artistas de este nivel; puede que valga la pena revisar todos los
-- websites guardados.
--
-- EL PARENTESCO YA ESTABA BIEN. Wikipedia dice que sus hermanos Kaki y Johnny
-- también son merengueros y lo han acompañado buena parte de sus carreras.
-- COMPROBÉ LA TABLA y la relación sergio-vargas / kaki-vargas YA ESTÁ
-- REGISTRADA como 'sibling'. No hace falta migración. A Kaki se le enlaza en la
-- prosa por lo profesional, no por lo familiar, que es lo que corresponde:
-- el parentesco lo muestra la tabla.
--
-- SE CRUZAN TRES FICHAS QUE ESCRIBÍ HOY MISMO:
--
--   rafael-solano organizó el Festival de la Voz donde Vargas quedó SEGUNDO.
--   Es el mismo festival donde Villalona quedó quinto, y el mismo hombre que lo
--   descubrió. Solano aparece ya en tres fichas de esta corrida.
--
--   fernando-villalona y raulin-rosendo encabezaban Los Hijos del Rey cuando
--   Vargas entró como vocalista líder. La ficha de Villalona, escrita hace un
--   rato, cuenta la misma orquesta desde el otro lado.
--
--   jose-alberto-el-canario grabó "Torero" a dúo con él.
--
-- LUIS DÍAS NO ESTÁ EN EL CATÁLOGO y es una ausencia seria: escribió "Marola" y
-- "Las Vampiras", esta última el videoclip que le dio un Casandra a Vargas en
-- 1988. Ya había aparecido al verificar a Juan Francisco Ordóñez, con quien
-- fundó Transporte Urbano. Va a la lista con prioridad.
--
-- NO SE ENLAZA A "DIONIS FERNÁNDEZ", con quien Wikipedia dice que grabó "Los
-- Diseñadores" y "Al Ritmo de la Noche". En la base hay
-- dioni-fernandez-y-el-equipo y MUY PROBABLEMENTE sea el mismo hombre con la
-- grafía cambiada, pero enlazar por parecido es inventar una identidad. Se
-- menciona sin enlace y queda anotado para verificar.
--
-- LA POLÍTICA ENTRA, con el mismo criterio que apliqué a Johnny Ventura: fue
-- DIPUTADO por Villa Altagracia entre 2006 y 2010. No es una candidatura que no
-- prosperó como las de Yaqui o Félix D'Oleo; ocupó el cargo cuatro años.
--
-- SE DEJA FUERA: sus nueve hijos.
--
-- FUENTES: Wikipedia en español, artículo "Sergio Vargas (cantante)" -- OJO, el
-- título "Sergio Vargas" a secas es una desambiguación que lista además a dos
-- futbolistas chilenos y a un cantautor mexicano. La tabla de premios de la
-- base para el Gran Soberano y los dos Latin Grammy.
--
-- NOMBRES NUEVOS PARA LA LISTA: Luis Días (prioridad), Johnny Vargas (hermano),
-- Sonny Ovalles (arreglista), Juan Valdez (pianista), Diómedes Núñez y Orvis
-- García (músicos de Los Hijos del Rey), Gisselle (dúos), y la orquesta LOS
-- HIJOS DEL REY, que ya venía anotada desde Villalona.
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
       name = 'Sergio Vargas',
       sort_name = 'Vargas Parra, Sergio Pascual',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = NULL,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1960-03-15',
       birth_year = 1960,
       date_of_death = NULL,
       birth_place = 'Villa Altagracia',
       province = 'San Cristóbal',
       first_name = 'Sergio',
       middle_name = 'Pascual',
       last_name = 'Vargas',
       second_last_name = 'Parra',
       stage_name = 'Sergio Vargas',
       aliases = ARRAY['El Negrito de Villa']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY['bolero', 'bachata', 'salsa']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = '422849571084732',
       instagram = 'sergiovargas3',
       disambiguation = 'Merengue singer known as El Negrito de Villa; winner of El Gran Soberano and two Latin Grammy awards',
       bio_en = 'Sergio Pascual Vargas Parra, known as Sergio Vargas and nicknamed El Negrito de Villa, is a Dominican singer. A light lyric tenor, he came up through the orchestras of the golden years of merengue and has stayed at the front of the genre for four decades, working equally in bolero, bachata and salsa.

**Villa Altagracia**

He was born in Villa Altagracia, in the province of San Cristóbal, in 1960, and still lives there. The town gave him the name he has been billed under ever since.

**The voice festival**

He entered the Festival de la Voz organised by Rafael Solano and finished second. It was the same competition, run by the same man, that had launched an earlier generation of Dominican singers.

**Los Hijos del Rey**

He recorded with the orchestra of Dionis Fernández before joining Los Hijos del Rey as lead vocalist. The band was then headed by Fernando Villalona and Raulín Rosendo, and it was there that his following began to grow: the orchestra had fan clubs in Puerto Rico, Venezuela, Panama and along the east coast of the United States.

Por Ella, Mi Orgullo, Un Hombre y Una Mujer and Oh Mariana date from those years. La Tierra Tembló, recorded with the band in 1987, was the record that made the case for a solo career.

**La Quiero a Morir**

His first album under his own name appeared in 1986 and carried La Quiero a Morir, a Spanish reading of a song by the French singer Francis Cabrel. When he finally went out on his own, almost the entire band went with him.

The singles that followed set the pattern of his catalogue: Ciclón, Marola, Al Otro Lado del Sol, Bamboleo, Esta Casa Humilde and Perla Negra. Marola and Las Vampiras were both written for him by the composer Luis Días.

**The Casandra years**

A concert of his own name was named show of the year by the Dominican critics’ association, and in the same round Las Vampiras took the award for music video of the year. He signed with an international label at the end of that decade, and a television programme he took part in brought him two further awards, one of them for international projection.

**The interpreter**

A large part of his catalogue is other people’s songs remade as merengue or bolero: material by Luis Miguel, Roberto Carlos, Juan Luis Guerra, José Feliciano, Pablo Milanés and the Gipsy Kings, among many others. He recorded Torero as a duet with José Alberto "El Canario", and has released joint collections with several of his contemporaries. His brother Kaki Vargas has worked alongside him for much of both their careers.

**El Gran Soberano**

He received El Gran Soberano, the highest honour of the Dominican critics’ association, and used the acceptance speech to argue for formal education for Dominican musicians. He has since won the Latin Grammy for best merengue or bachata album twice, and took a Congo de Oro at the Barranquilla carnival.

**Public office**

He served as a deputy in the Dominican congress for his home town of Villa Altagracia between 2006 and 2010.',
       bio_es = 'Sergio Pascual Vargas Parra, conocido como Sergio Vargas y apodado El Negrito de Villa, es un cantante dominicano. Tenor lírico ligero, se formó en las orquestas de los años dorados del merengue y lleva cuatro décadas al frente del género, trabajando por igual el bolero, la bachata y la salsa.

**Villa Altagracia**

Nació en Villa Altagracia, provincia de San Cristóbal, en 1960, y allí sigue viviendo. El pueblo le dio el nombre con el que se anuncia desde entonces.

**El Festival de la Voz**

Se presentó al Festival de la Voz que organizaba Rafael Solano y quedó en segundo lugar. Era el mismo concurso, del mismo hombre, que había lanzado a la generación anterior de cantantes dominicanos.

**Los Hijos del Rey**

Grabó con la orquesta de Dionis Fernández antes de entrar a Los Hijos del Rey como vocalista líder. La banda estaba entonces encabezada por Fernando Villalona y Raulín Rosendo, y fue allí donde su público empezó a crecer: la orquesta tenía clubes de fanáticos en Puerto Rico, Venezuela, Panamá y la costa este de Estados Unidos.

Por Ella, Mi Orgullo, Un Hombre y Una Mujer y Oh Mariana son de esos años. La Tierra Tembló, grabada con la banda en 1987, fue el disco que justificó una carrera propia.

**La Quiero a Morir**

Su primer álbum a nombre propio salió en 1986 y traía La Quiero a Morir, lectura en español de una canción del francés Francis Cabrel. Cuando por fin se lanzó por su cuenta, casi toda la banda se fue con él.

Los sencillos que vinieron después fijaron la forma de su catálogo: Ciclón, Marola, Al Otro Lado del Sol, Bamboleo, Esta Casa Humilde y Perla Negra. Marola y Las Vampiras se las escribió el compositor Luis Días.

**Los años del Casandra**

Un concierto con su propio nombre fue declarado espectáculo del año por la crónica de arte dominicana, y en la misma edición Las Vampiras se llevó el premio al videoclip del año. Firmó con un sello internacional al final de esa década, y un programa de televisión en el que participó le dio otros dos galardones, uno de ellos por proyección internacional.

**El intérprete**

Buena parte de su catálogo son canciones ajenas rehechas en merengue o en bolero: material de Luis Miguel, Roberto Carlos, Juan Luis Guerra, José Feliciano, Pablo Milanés y los Gipsy Kings, entre muchos otros. Grabó Torero a dúo con José Alberto "El Canario", y ha publicado recopilaciones conjuntas con varios de sus contemporáneos. Su hermano Kaki Vargas lo ha acompañado durante buena parte de las carreras de ambos.

**El Gran Soberano**

Recibió El Gran Soberano, el máximo honor de la crónica de arte dominicana, y usó el discurso de agradecimiento para reclamar formación académica para los músicos dominicanos. Desde entonces ha ganado dos veces el Latin Grammy al mejor álbum de merengue o bachata, y se llevó un Congo de Oro en el carnaval de Barranquilla.

**El cargo público**

Fue diputado en el congreso dominicano por su pueblo, Villa Altagracia, entre 2006 y 2010.',
       updated_at = now()
 WHERE slug = 'sergio-vargas';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Sergio Pascual Vargas Parra, known as Sergio Vargas and nicknamed El Negrito de Villa, is a Dominican singer. A light lyric tenor, he came up through the orchestras of the golden years of merengue and has stayed at the front of the genre for four decades, working equally in bolero, bachata and salsa.","type":"text"}]},{"type":"paragraph","content":[{"text":"Villa Altagracia","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Villa Altagracia, in the province of San Cristóbal, in 1960, and still lives there. The town gave him the name he has been billed under ever since.","type":"text"}]},{"type":"paragraph","content":[{"text":"The voice festival","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He entered the Festival de la Voz organised by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"25e349b3-38c1-4f9a-a445-61558b3c5c28"}},{"text":" and finished second. It was the same competition, run by the same man, that had launched an earlier generation of Dominican singers.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Hijos del Rey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He recorded with the orchestra of Dionis Fernández before joining Los Hijos del Rey as lead vocalist. The band was then headed by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"9e62a135-a831-417b-8033-edf81ae79f05"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faf3e4cb-808e-419c-87ff-5126eed85e73","displayText":"Raulín Rosendo","occurrenceId":"4cdb85eb-b36f-4be1-a625-877383ddabf7"}},{"text":", and it was there that his following began to grow: the orchestra had fan clubs in Puerto Rico, Venezuela, Panama and along the east coast of the United States.","type":"text"}]},{"type":"paragraph","content":[{"text":"Por Ella, Mi Orgullo, Un Hombre y Una Mujer and Oh Mariana date from those years. La Tierra Tembló, recorded with the band in 1987, was the record that made the case for a solo career.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Quiero a Morir","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His first album under his own name appeared in 1986 and carried La Quiero a Morir, a Spanish reading of a song by the French singer Francis Cabrel. When he finally went out on his own, almost the entire band went with him.","type":"text"}]},{"type":"paragraph","content":[{"text":"The singles that followed set the pattern of his catalogue: Ciclón, Marola, Al Otro Lado del Sol, Bamboleo, Esta Casa Humilde and Perla Negra. Marola and Las Vampiras were both written for him by the composer Luis Días.","type":"text"}]},{"type":"paragraph","content":[{"text":"The Casandra years","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A concert of his own name was named show of the year by the Dominican critics’ association, and in the same round Las Vampiras took the award for music video of the year. He signed with an international label at the end of that decade, and a television programme he took part in brought him two further awards, one of them for international projection.","type":"text"}]},{"type":"paragraph","content":[{"text":"The interpreter","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A large part of his catalogue is other people’s songs remade as merengue or bolero: material by Luis Miguel, Roberto Carlos, Juan Luis Guerra, José Feliciano, Pablo Milanés and the Gipsy Kings, among many others. He recorded Torero as a duet with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e8ba0f32-1d96-494d-9861-b1dc3937331e","displayText":"José Alberto \"El Canario\"","occurrenceId":"32457fde-a1cd-45e7-bd3e-0f6949ad9920"}},{"text":", and has released joint collections with several of his contemporaries. His brother ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0a36ec1b-2de1-4890-95f2-57d6b19a1d69","displayText":"Kaki Vargas","occurrenceId":"a49286bf-a3dc-473d-8bbd-cc509455a7ff"}},{"text":" has worked alongside him for much of both their careers.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Gran Soberano","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He received El Gran Soberano, the highest honour of the Dominican critics’ association, and used the acceptance speech to argue for formal education for Dominican musicians. He has since won the Latin Grammy for best merengue or bachata album twice, and took a Congo de Oro at the Barranquilla carnival.","type":"text"}]},{"type":"paragraph","content":[{"text":"Public office","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He served as a deputy in the Dominican congress for his home town of Villa Altagracia between 2006 and 2010.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'sergio-vargas'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Sergio Pascual Vargas Parra, conocido como Sergio Vargas y apodado El Negrito de Villa, es un cantante dominicano. Tenor lírico ligero, se formó en las orquestas de los años dorados del merengue y lleva cuatro décadas al frente del género, trabajando por igual el bolero, la bachata y la salsa.","type":"text"}]},{"type":"paragraph","content":[{"text":"Villa Altagracia","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Villa Altagracia, provincia de San Cristóbal, en 1960, y allí sigue viviendo. El pueblo le dio el nombre con el que se anuncia desde entonces.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Festival de la Voz","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se presentó al Festival de la Voz que organizaba ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"322847d8-eda5-456d-b6c8-d4be3969397e"}},{"text":" y quedó en segundo lugar. Era el mismo concurso, del mismo hombre, que había lanzado a la generación anterior de cantantes dominicanos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Hijos del Rey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Grabó con la orquesta de Dionis Fernández antes de entrar a Los Hijos del Rey como vocalista líder. La banda estaba entonces encabezada por ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"67e53df4-270d-4bc0-9860-8c195f7233e1"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faf3e4cb-808e-419c-87ff-5126eed85e73","displayText":"Raulín Rosendo","occurrenceId":"c166ef9e-5339-42ea-aa7e-537006d70014"}},{"text":", y fue allí donde su público empezó a crecer: la orquesta tenía clubes de fanáticos en Puerto Rico, Venezuela, Panamá y la costa este de Estados Unidos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Por Ella, Mi Orgullo, Un Hombre y Una Mujer y Oh Mariana son de esos años. La Tierra Tembló, grabada con la banda en 1987, fue el disco que justificó una carrera propia.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Quiero a Morir","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su primer álbum a nombre propio salió en 1986 y traía La Quiero a Morir, lectura en español de una canción del francés Francis Cabrel. Cuando por fin se lanzó por su cuenta, casi toda la banda se fue con él.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los sencillos que vinieron después fijaron la forma de su catálogo: Ciclón, Marola, Al Otro Lado del Sol, Bamboleo, Esta Casa Humilde y Perla Negra. Marola y Las Vampiras se las escribió el compositor Luis Días.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los años del Casandra","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Un concierto con su propio nombre fue declarado espectáculo del año por la crónica de arte dominicana, y en la misma edición Las Vampiras se llevó el premio al videoclip del año. Firmó con un sello internacional al final de esa década, y un programa de televisión en el que participó le dio otros dos galardones, uno de ellos por proyección internacional.","type":"text"}]},{"type":"paragraph","content":[{"text":"El intérprete","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Buena parte de su catálogo son canciones ajenas rehechas en merengue o en bolero: material de Luis Miguel, Roberto Carlos, Juan Luis Guerra, José Feliciano, Pablo Milanés y los Gipsy Kings, entre muchos otros. Grabó Torero a dúo con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"e8ba0f32-1d96-494d-9861-b1dc3937331e","displayText":"José Alberto \"El Canario\"","occurrenceId":"87595d1e-65f5-4534-920e-9917e7e6059a"}},{"text":", y ha publicado recopilaciones conjuntas con varios de sus contemporáneos. Su hermano ","type":"text"},{"type":"artistReference","attrs":{"artistId":"0a36ec1b-2de1-4890-95f2-57d6b19a1d69","displayText":"Kaki Vargas","occurrenceId":"a3ee3162-ad0f-4e6b-96cd-eaee11ec087f"}},{"text":" lo ha acompañado durante buena parte de las carreras de ambos.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Gran Soberano","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Recibió El Gran Soberano, el máximo honor de la crónica de arte dominicana, y usó el discurso de agradecimiento para reclamar formación académica para los músicos dominicanos. Desde entonces ha ganado dos veces el Latin Grammy al mejor álbum de merengue o bachata, y se llevó un Congo de Oro en el carnaval de Barranquilla.","type":"text"}]},{"type":"paragraph","content":[{"text":"El cargo público","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Fue diputado en el congreso dominicano por su pueblo, Villa Altagracia, entre 2006 y 2010.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'sergio-vargas'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas') AND locale = 'en'), '25e349b3-38c1-4f9a-a445-61558b3c5c28', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas') AND locale = 'en'), '32457fde-a1cd-45e7-bd3e-0f6949ad9920', 'artist', 'e8ba0f32-1d96-494d-9861-b1dc3937331e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas') AND locale = 'en'), '4cdb85eb-b36f-4be1-a625-877383ddabf7', 'artist', 'faf3e4cb-808e-419c-87ff-5126eed85e73');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas') AND locale = 'en'), '9e62a135-a831-417b-8033-edf81ae79f05', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas') AND locale = 'en'), 'a49286bf-a3dc-473d-8bbd-cc509455a7ff', 'artist', '0a36ec1b-2de1-4890-95f2-57d6b19a1d69');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas') AND locale = 'es'), '322847d8-eda5-456d-b6c8-d4be3969397e', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas') AND locale = 'es'), '67e53df4-270d-4bc0-9860-8c195f7233e1', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas') AND locale = 'es'), '87595d1e-65f5-4534-920e-9917e7e6059a', 'artist', 'e8ba0f32-1d96-494d-9861-b1dc3937331e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas') AND locale = 'es'), 'a3ee3162-ad0f-4e6b-96cd-eaee11ec087f', 'artist', '0a36ec1b-2de1-4890-95f2-57d6b19a1d69');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'sergio-vargas') AND locale = 'es'), 'c166ef9e-5339-42ea-aa7e-537006d70014', 'artist', 'faf3e4cb-808e-419c-87ff-5126eed85e73');

COMMIT;
