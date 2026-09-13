BEGIN;

-- Rewrite the catalogue entry for Ramón Leonardo.
--
-- Ramón Leonardo. Novena de las dieciséis fichas publicadas que estaban EN
-- BLANCO. Se le llama el padre de la canción protesta en la República
-- Dominicana y su página no decía nada.
--
-- UNA DECISIÓN EDITORIAL QUE TOMO Y QUE EL EDITOR PUEDE REVERTIR
--
-- La regla dice que no van los asuntos penales. Este caso obliga a distinguir.
-- A Ramón Leonardo lo encarcelaron CINCO VECES en los años setenta y le
-- prohibieron entrar a ciudades donde tenía que actuar, POR SUS CANCIONES. No
-- pudo cantar en la apertura de "7 Días con el Pueblo", en 1974, porque estaba
-- presó.
--
-- Eso no es un antecedente penal que manche a nadie: es censura y persecución
-- de una obra, y es la razón por la que se le llama el padre de la canción
-- protesta. Callarlo dejaría la ficha diciendo algo falso por omisión: que un
-- cantautor social de los setenta simplemente cantaba.
--
-- Se escribe, y se escribe como lo que es: lo que el Estado le hizo a su
-- música. Si el editor prefiere quitarlo, la línea es el párrafo de la sección
-- "La canción protesta" / "Protest song".
--
-- SE EXCLUYE, EN CAMBIO, LA POLÍTICA ELECTORAL: en 1996 aspiró a la sindicatura
-- de Santiago como candidato independiente por el MIUCA. Mismo criterio que
-- apliqué con Yaqui Núñez del Risco y con Félix D'Oleo. Su militancia sí
-- aparece, porque es el contenido de las canciones, no un cargo.
--
-- SE EXCLUYE TODA LA FAMILIA, y en esta ficha cuesta. Wikipedia detalla que su
-- madre fue voz primera del dueto Apolo, que su padre era declamador, que dos
-- tíos suyos eran músicos -- uno dirigió una orquesta ligada a la Fania All
-- Stars --, y que su primer disco lo grabó auspiciado por uno de ellos. Todo
-- eso es oficio de familiares y queda fuera. El disco se menciona sin el
-- padrino. Igual con el hijo que dirigió musicalmente su álbum reciente.
--
-- CONFLICTO DE APELLIDO QUE NO RESUELVO Y QUE REPORTO. La fila guarda QUESADA.
-- El encabezado de Wikipedia dice QUEZADA y el cuerpo del mismo artículo dice
-- QUESADA; EcuRed dice Quezada; Wikiwand y SRO Records dicen Quesada. No hay
-- mayoría clara ni documento oficial. NO SE TOCA lo que ya estaba guardado.
--
-- UN SOLO ENLACE: expresion-joven, el grupo que nació de sus primeras canciones
-- sociales y que él lideraba musicalmente. Ya existe en la base como group.
--
-- NO ESTÁN EN LA BASE y van a la lista: Cholo Brenes, que colideraba Expresión
-- Joven con él; Chico González, autor de las letras que él musicalizó; y
-- Bienvenido Rodríguez, fundador de Karen Records, que es una omisión grande
-- porque ese sello publicó a media música dominicana.
--
-- GÉNERO: la fila dice ballads y es correcto -- sus éxitos de venta son
-- románticos. Se agrega bolero en genres, que Wikipedia lista y no repite el
-- primario. La canción protesta no es un género de la taxonomía; va en prosa.
--
-- INSTRUMENTS: voz y guitarra, que Wikipedia lista y que sostiene toda su obra
-- de cantautor. OCCUPATIONS: composer y songwriter, sin repetir singer.
--
-- FUENTES: Wikipedia en español, que está marcada como necesitada de
-- referencias pero cuyos datos coinciden con las demás. EcuRed. El Diccionario
-- Cultural Dominicano de Funglode. almomento.net. reporteromocano, abril de
-- 2024, entrevista donde él mismo describe su primer álbum.
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
       name = 'Ramón Leonardo',
       sort_name = 'Blanco Quesada, Ramón Leonardo',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'ballads',
       date_of_birth = '1948-02-28',
       birth_year = 1948,
       date_of_death = NULL,
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Ramón',
       middle_name = 'Leonardo',
       last_name = 'Blanco',
       second_last_name = 'Quesada',
       stage_name = 'Ramón Leonardo',
       aliases = ARRAY[]::text[],
       occupations = '["composer","songwriter"]'::jsonb,
       instruments = ARRAY['voice', 'guitar']::text[],
       genres = ARRAY['bolero']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = 'ramon.leonardo.cantautor.de.la.patria',
       instagram = 'ramonleonardocantautor',
       disambiguation = 'Singer-songwriter called the father of Dominican protest song; also a hit writer of romantic ballads',
       bio_en = 'Ramón Leonardo Blanco Quesada, known as Ramón Leonardo, is a Dominican singer-songwriter. He is widely called the father of protest song in the Dominican Republic, and he ran a parallel career as a writer of romantic ballads that sold heavily through the seventies and eighties.

**Santiago**

He was born in Santiago de los Caballeros in 1948. His social formation came through the youth pastoral movement of his city, where he led study groups, and later through courses on Catholic social doctrine at CEFASA, the centre for social and agrarian training run by Jesuits. That grounding shaped the subject matter of everything he wrote afterwards.

**Yo Canto al Amor**

His first album, Yo Canto al Amor, was recorded in the United States and set out the shape of his catalogue: six romantic songs on one side and six of social and Christian content on the other, all of them his own. Todos Somos Iguales and Juventud circulated quickly, and he made his professional debut in April 1970, at twenty-two.

He then recorded for Karen Records, where his romantic material became commercial success: Camino Hacia el Altar, Lo Que Yo Quiero de Ti, La Vida Se Va y No Vuelve, Los Celos, Un Gran Amor y Nada Más and La Distancia among them.

**Protest song**

The social songs on that first record led to the founding of Expresión Joven, which he led musically alongside Cholo Brenes. Through the seventies he set lyrics by the writer Chico González, and the results reached the radio under the government of Joaquín Balaguer.

The state answered the songs directly. He was jailed on five separate occasions and barred from entering cities where he was booked to perform. When the festival Siete Días con el Pueblo opened at the end of November 1974, he was in prison and could not appear, though he was one of the figures the event was built around. Francisco Alberto, Abran las Rejas, Soldado and Universidad belong to those years, and the album Obrero Acepta Mi Mano was released in 1974.

**Writing**

He has published books alongside the music: a volume on popular art, society and commitment written during a stay in New Jersey, one on national democratic socialism, and Historia de Mi Voz, which he issued to mark more than forty years of singing.

**Still committed**

He has continued to record social material, most recently on an album whose title states the position plainly, Mucho Más Comprometido.',
       bio_es = 'Ramón Leonardo Blanco Quesada, conocido como Ramón Leonardo, es un cantautor dominicano. Se le llama de manera generalizada el padre de la canción protesta en la República Dominicana, y llevó en paralelo una carrera de autor de baladas románticas que vendieron mucho a lo largo de los setenta y los ochenta.

**Santiago**

Nació en Santiago de los Caballeros en 1948. Su formación social le vino de la pastoral juvenil de su ciudad, donde dirigió grupos de estudio, y después de los cursos sobre doctrina social de la Iglesia en el CEFASA, el centro de formación social y agraria de los jesuitas. Ese cimiento marcó los temas de todo lo que escribió después.

**Yo Canto al Amor**

Su primer álbum, Yo Canto al Amor, lo grabó en Estados Unidos y ya traía la forma de todo su catálogo: seis canciones románticas de un lado y seis de contenido social y cristiano del otro, todas de su autoría. Todos Somos Iguales y Juventud circularon rápido, y debutó profesionalmente en abril de 1970, a los veintidós años.

Después grabó para Karen Records, donde su material romántico se convirtió en éxito de venta: Camino Hacia el Altar, Lo Que Yo Quiero de Ti, La Vida Se Va y No Vuelve, Los Celos, Un Gran Amor y Nada Más y La Distancia, entre otras.

**La canción protesta**

Las canciones sociales de aquel primer disco dieron origen a Expresión Joven, que él lideraba musicalmente junto a Cholo Brenes. Durante los setenta puso música a letras del escritor Chico González, y el resultado llegó a la radio bajo el gobierno de Joaquín Balaguer.

El Estado respondió a las canciones de manera directa. Lo encarcelaron en cinco ocasiones distintas y le impidieron entrar a ciudades donde tenía presentaciones contratadas. Cuando el festival Siete Días con el Pueblo abrió a finales de noviembre de 1974, él estaba preso y no pudo presentarse, pese a ser una de las figuras alrededor de las cuales se armó el evento. Francisco Alberto, Abran las Rejas, Soldado y Universidad son de esos años, y el álbum Obrero Acepta Mi Mano salió en 1974.

**Los libros**

Ha publicado libros junto a la música: uno sobre arte popular, sociedad y compromiso, escrito durante una estadía en Nueva Jersey, otro sobre socialismo nacional democrático, e Historia de Mi Voz, que puso en circulación al cumplir más de cuarenta años de canto.

**Sigue comprometido**

Ha continuado grabando material social, lo más reciente un álbum cuyo título deja clara la posición, Mucho Más Comprometido.',
       updated_at = now()
 WHERE slug = 'ramon-leonardo';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-leonardo')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-leonardo')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ramón Leonardo Blanco Quesada, known as Ramón Leonardo, is a Dominican singer-songwriter. He is widely called the father of protest song in the Dominican Republic, and he ran a parallel career as a writer of romantic ballads that sold heavily through the seventies and eighties.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santiago","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Santiago de los Caballeros in 1948. His social formation came through the youth pastoral movement of his city, where he led study groups, and later through courses on Catholic social doctrine at CEFASA, the centre for social and agrarian training run by Jesuits. That grounding shaped the subject matter of everything he wrote afterwards.","type":"text"}]},{"type":"paragraph","content":[{"text":"Yo Canto al Amor","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His first album, Yo Canto al Amor, was recorded in the United States and set out the shape of his catalogue: six romantic songs on one side and six of social and Christian content on the other, all of them his own. Todos Somos Iguales and Juventud circulated quickly, and he made his professional debut in April 1970, at twenty-two.","type":"text"}]},{"type":"paragraph","content":[{"text":"He then recorded for Karen Records, where his romantic material became commercial success: Camino Hacia el Altar, Lo Que Yo Quiero de Ti, La Vida Se Va y No Vuelve, Los Celos, Un Gran Amor y Nada Más and La Distancia among them.","type":"text"}]},{"type":"paragraph","content":[{"text":"Protest song","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The social songs on that first record led to the founding of ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f838a2ce-b6eb-4200-8d4f-c3c8c28217da","displayText":"Expresión Joven","occurrenceId":"bdf62a63-630f-45e5-bfe3-e8efd14f9be2"}},{"text":", which he led musically alongside Cholo Brenes. Through the seventies he set lyrics by the writer Chico González, and the results reached the radio under the government of Joaquín Balaguer.","type":"text"}]},{"type":"paragraph","content":[{"text":"The state answered the songs directly. He was jailed on five separate occasions and barred from entering cities where he was booked to perform. When the festival Siete Días con el Pueblo opened at the end of November 1974, he was in prison and could not appear, though he was one of the figures the event was built around. Francisco Alberto, Abran las Rejas, Soldado and Universidad belong to those years, and the album Obrero Acepta Mi Mano was released in 1974.","type":"text"}]},{"type":"paragraph","content":[{"text":"Writing","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He has published books alongside the music: a volume on popular art, society and commitment written during a stay in New Jersey, one on national democratic socialism, and Historia de Mi Voz, which he issued to mark more than forty years of singing.","type":"text"}]},{"type":"paragraph","content":[{"text":"Still committed","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He has continued to record social material, most recently on an album whose title states the position plainly, Mucho Más Comprometido.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'ramon-leonardo'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ramón Leonardo Blanco Quesada, conocido como Ramón Leonardo, es un cantautor dominicano. Se le llama de manera generalizada el padre de la canción protesta en la República Dominicana, y llevó en paralelo una carrera de autor de baladas románticas que vendieron mucho a lo largo de los setenta y los ochenta.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santiago","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santiago de los Caballeros en 1948. Su formación social le vino de la pastoral juvenil de su ciudad, donde dirigió grupos de estudio, y después de los cursos sobre doctrina social de la Iglesia en el CEFASA, el centro de formación social y agraria de los jesuitas. Ese cimiento marcó los temas de todo lo que escribió después.","type":"text"}]},{"type":"paragraph","content":[{"text":"Yo Canto al Amor","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su primer álbum, Yo Canto al Amor, lo grabó en Estados Unidos y ya traía la forma de todo su catálogo: seis canciones románticas de un lado y seis de contenido social y cristiano del otro, todas de su autoría. Todos Somos Iguales y Juventud circularon rápido, y debutó profesionalmente en abril de 1970, a los veintidós años.","type":"text"}]},{"type":"paragraph","content":[{"text":"Después grabó para Karen Records, donde su material romántico se convirtió en éxito de venta: Camino Hacia el Altar, Lo Que Yo Quiero de Ti, La Vida Se Va y No Vuelve, Los Celos, Un Gran Amor y Nada Más y La Distancia, entre otras.","type":"text"}]},{"type":"paragraph","content":[{"text":"La canción protesta","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Las canciones sociales de aquel primer disco dieron origen a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f838a2ce-b6eb-4200-8d4f-c3c8c28217da","displayText":"Expresión Joven","occurrenceId":"55c8ebcc-da73-4e0a-935a-295c14c39a44"}},{"text":", que él lideraba musicalmente junto a Cholo Brenes. Durante los setenta puso música a letras del escritor Chico González, y el resultado llegó a la radio bajo el gobierno de Joaquín Balaguer.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Estado respondió a las canciones de manera directa. Lo encarcelaron en cinco ocasiones distintas y le impidieron entrar a ciudades donde tenía presentaciones contratadas. Cuando el festival Siete Días con el Pueblo abrió a finales de noviembre de 1974, él estaba preso y no pudo presentarse, pese a ser una de las figuras alrededor de las cuales se armó el evento. Francisco Alberto, Abran las Rejas, Soldado y Universidad son de esos años, y el álbum Obrero Acepta Mi Mano salió en 1974.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los libros","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Ha publicado libros junto a la música: uno sobre arte popular, sociedad y compromiso, escrito durante una estadía en Nueva Jersey, otro sobre socialismo nacional democrático, e Historia de Mi Voz, que puso en circulación al cumplir más de cuarenta años de canto.","type":"text"}]},{"type":"paragraph","content":[{"text":"Sigue comprometido","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Ha continuado grabando material social, lo más reciente un álbum cuyo título deja clara la posición, Mucho Más Comprometido.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'ramon-leonardo'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-leonardo') AND locale = 'en'), 'bdf62a63-630f-45e5-bfe3-e8efd14f9be2', 'artist', 'f838a2ce-b6eb-4200-8d4f-c3c8c28217da');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ramon-leonardo') AND locale = 'es'), '55c8ebcc-da73-4e0a-935a-295c14c39a44', 'artist', 'f838a2ce-b6eb-4200-8d4f-c3c8c28217da');

COMMIT;
