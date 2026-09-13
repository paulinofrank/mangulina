BEGIN;

-- Rewrite the catalogue entry for Ilegales.
--
-- Ilegales. SEXTA de las 235 y la primera AGRUPACIÓN del grupo. Ochenta y dos
-- discos a su nombre en la base y dieciocho biografías que la citan.
--
-- LA FICHA ERA UN SOLO PÁRRAFO DE ABSTRACCIONES: ni un integrante, ni una
-- canción, ni un disco, ni una fecha. Describía "el sonido" y nada más. Para
-- una banda con treinta años de trayectoria, catorce álbumes y una nominación
-- al Latin Grammy.
--
-- OTRA CONFUSIÓN PERSONA / AGRUPACIÓN, y de las claras: aliases guardaba
-- 'Vladimir Dotel'. Dotel es EL FUNDADOR Y LÍDER del grupo, una persona, no un
-- nombre alternativo de la banda. Es el mismo defecto que encontré en Johnny
-- Ventura, donde 'El Combo Show' -- su orquesta -- estaba guardado como alias
-- suyo. Van dos casos del mismo error en direcciones opuestas: allá el grupo
-- metido en la persona, aquí la persona metida en el grupo.
--
-- Se quita. VLADIMIR DOTEL NO TIENE FICHA PROPIA y debería tenerla; queda en la
-- lista. Se conserva 'Los Ilegales', que sí es un nombre alternativo real y que
-- Wikipedia registra.
--
-- SE LLENA birth_year CON 1995, que en una fila de tipo group significa AÑO DE
-- FORMACIÓN y no de nacimiento. Estaba vacío. La banda debutó ese año en la
-- Fortaleza Ozama de la Zona Colonial, dato que ellos mismos recordaron en una
-- entrevista de 2011.
--
-- SE LIMPIA occupations, que tenía 'musician' en una fila de agrupación.
--
-- QUEDA SIN TOCAR, Y REPORTADO: primary_role dice 'singer' en una fila de tipo
-- group, que no significa nada. Es parte del trabajo de tipado de agrupaciones
-- que ya tengo inventariado, y prefiero hacerlo de una vez y no ficha por
-- ficha.
--
-- EL SITIO WEB SÍ FUNCIONA, al contrario que los de Villalona y Sergio Vargas.
-- Lo comprobé y REDIRIGE A HTTPS, mientras el campo guardaba http. Se corrige
-- el esquema.
--
-- LA MUERTE DE JASON GONZÁLEZ SE CUENTA SIN LA CAUSA. Murió en enero de 1998,
-- días después de grabar el video de "Sueño Contigo", y el Festival de Viña del
-- Mar le rindió homenaje un mes más tarde. Que murió y cuándo es historia de la
-- alineación y va; cómo murió es lo que la regla excluye, igual que en todas
-- las demás fichas.
--
-- CUATRO ENLACES: johnny-ventura y vakero, que colaboran en "Esto Es" de 2010;
-- monchy-alexandra, en "La Otra"; y proyecto-uno, que Wikipedia registra como
-- artista relacionado y que es la otra banda grande del merengue house.
--
-- NO SE ENLAZA A BRYAN DOTEL. Está en la base y comparte apellido con el
-- fundador, pero nada indica que sean parientes y enlazar por apellido sería
-- inventar una identidad.
--
-- NO SE ESCRIBEN CIFRAS de reproducciones. SÍ ENTRAN las posiciones de lista,
-- que son clasificaciones: "Ayántame" estuvo cuatro semanas en el número uno de
-- Billboard.
--
-- FUENTES: Wikipedia en español, artículo "Ilegales (banda dominicana)", con
-- alineaciones, discografía y cronología detalladas. Su sitio oficial,
-- comprobado hoy.
--
-- NOMBRES NUEVOS PARA LA LISTA: VLADIMIR DOTEL (prioridad: fundador y líder,
-- sin ficha), David Díaz y Junior Pimentel (integrantes actuales), Álvaro
-- Guzmán, Jason González, Lenny Medina, Anthony de la Cruz, Rafael "Raffy"
-- Rivera, Juan Carlos Campos, Carlos "Monty" Montaner, Danny Silveira, Aneudy
-- Pimentel, Leny Pimentel y Pamel Mancebo (exintegrantes). También Magic Juan y
-- Gisselle, que colaboran en el disco de 2006.
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
       name = 'Ilegales',
       sort_name = 'Ilegales',
       type = 'group',
       status = 'published',
       gender = 'group',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = NULL,
       birth_year = 1995,
       date_of_death = NULL,
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = 'Ilegales',
       aliases = ARRAY['Los Ilegales']::text[],
       occupations = '[]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['urbano', 'fusion', 'ballads']::text[],
       artist_tags = ARRAY['secular']::text[],
       website = 'https://losilegales.com',
       youtube = '@Ilegalesvevo',
       facebook = '100035952771011',
       instagram = 'ilegalesoficial',
       disambiguation = 'Merengue house group founded in 1995 and led by Vladimir Dotel',
       bio_en = 'Ilegales, also billed as Los Ilegales, is a Dominican group founded in 1995 and led since then by Vladimir Dotel. It began as a merengue house act, the electronic-leaning form of merengue that dominated the middle of that decade, and has since worked in hip hop, Latin pop and ballad across more than a dozen albums.

**Fortaleza Ozama**

The group debuted in 1995 at the Fortaleza Ozama, in the colonial quarter of Santo Domingo, as a quartet: Dotel alongside Álvaro Guzmán, Anthony de la Cruz and Jason González. Their first record carried their own name and won them prizes in Mexico and Chile.

**Rebotando**

Their second production appeared in 1997 with Sueño Contigo, Rebotando, El Taqui Taqui and Como un Trueno, and with it the first move toward romantic material. Guzmán had left before the recording and was replaced by Rafael Rivera.

In January 1998, days after they filmed the video for Sueño Contigo, Jason González died. The group was three years old. A month later the Viña del Mar festival paid tribute to him, and the band reorganised around a new line-up.

**The line-ups**

The membership has changed more than a dozen times. En la Mira came in 1998 with Enamorao and Baila; a live album recorded in Santo Domingo the following year collected the hits of the first three. On Time turned the quartet into a trio and carried Una Copa de Licor, Chocolate and El Termómetro. Marca Registrada, In the Room and La República followed, the last of them with a duet alongside Monchy & Alexandra.

**Esto Es**

The group opened the following decade with a single recorded alongside Johnny Ventura and Vakeró, pairing the founding voice of modern merengue with one of the country’s urban rappers on the same track.

**Ayántame**

Ayántame, released in 2012, reached number one on the Billboard tropical chart and stayed there four weeks. Chucuchá followed the next year with a merengue built on electronic production, and La Pastilla entered the Dominican charts in 2015. The albums have kept coming: El Sonido, Inagotable, Tropicalia and others.

**The company they keep**

They belong to the same movement as Proyecto Uno, the other large Dominican group of the merengue house era, and their catalogue is one of the fullest records of what that fusion sounded like. They were nominated for a Latin Grammy for best pop album and for a Billboard award as tropical group, and have been recognised at the Viña del Mar festival more than once.',
       bio_es = 'Ilegales, anunciada también como Los Ilegales, es una agrupación dominicana fundada en 1995 y dirigida desde entonces por Vladimir Dotel. Empezó como grupo de merengue house, la variante electrónica del merengue que dominó la mitad de aquella década, y desde entonces ha trabajado el hip hop, el pop latino y la balada a lo largo de más de una docena de álbumes.

**La Fortaleza Ozama**

El grupo debutó en 1995 en la Fortaleza Ozama, en la Zona Colonial de Santo Domingo, como cuarteto: Dotel junto a Álvaro Guzmán, Anthony de la Cruz y Jason González. Su primer disco llevó el nombre de la banda y les valió premios en México y en Chile.

**Rebotando**

Su segunda producción salió en 1997 con Sueño Contigo, Rebotando, El Taqui Taqui y Como un Trueno, y con ella el primer giro hacia el material romántico. Guzmán había salido antes de la grabación y lo reemplazó Rafael Rivera.

En enero de 1998, días después de grabar el video de Sueño Contigo, murió Jason González. El grupo tenía tres años. Un mes más tarde el Festival de Viña del Mar le rindió homenaje, y la banda se reorganizó alrededor de una alineación nueva.

**Las alineaciones**

La membresía ha cambiado más de una docena de veces. En la Mira salió en 1998 con Enamorao y Baila; un disco en vivo grabado en Santo Domingo al año siguiente recogió los éxitos de los tres primeros. On Time convirtió al cuarteto en trío y trajo Una Copa de Licor, Chocolate y El Termómetro. Detrás vinieron Marca Registrada, In the Room y La República, este último con un dúo junto a Monchy & Alexandra.

**Esto Es**

El grupo abrió la década siguiente con un sencillo grabado junto a Johnny Ventura y Vakeró, poniendo en un mismo tema a la voz fundadora del merengue moderno y a uno de los raperos urbanos del país.

**Ayántame**

Ayántame, publicada en 2012, llegó al número uno de la lista tropical de Billboard y se mantuvo allí cuatro semanas. Al año siguiente vino Chucuchá, un merengue armado sobre producción electrónica, y en 2015 La Pastilla entró en las listas dominicanas. Los álbumes han seguido saliendo: El Sonido, Inagotable, Tropicalia y otros.

**La compañía que tienen**

Pertenecen al mismo movimiento que Proyecto Uno, la otra agrupación dominicana grande de la era del merengue house, y su catálogo es uno de los registros más completos de cómo sonaba aquella fusión. Fueron nominados al Latin Grammy al mejor álbum pop y a un premio Billboard como grupo tropical, y han sido reconocidos más de una vez en el festival de Viña del Mar.',
       updated_at = now()
 WHERE slug = 'ilegales';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ilegales')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ilegales')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ilegales, also billed as Los Ilegales, is a Dominican group founded in 1995 and led since then by Vladimir Dotel. It began as a merengue house act, the electronic-leaning form of merengue that dominated the middle of that decade, and has since worked in hip hop, Latin pop and ballad across more than a dozen albums.","type":"text"}]},{"type":"paragraph","content":[{"text":"Fortaleza Ozama","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The group debuted in 1995 at the Fortaleza Ozama, in the colonial quarter of Santo Domingo, as a quartet: Dotel alongside Álvaro Guzmán, Anthony de la Cruz and Jason González. Their first record carried their own name and won them prizes in Mexico and Chile.","type":"text"}]},{"type":"paragraph","content":[{"text":"Rebotando","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Their second production appeared in 1997 with Sueño Contigo, Rebotando, El Taqui Taqui and Como un Trueno, and with it the first move toward romantic material. Guzmán had left before the recording and was replaced by Rafael Rivera.","type":"text"}]},{"type":"paragraph","content":[{"text":"In January 1998, days after they filmed the video for Sueño Contigo, Jason González died. The group was three years old. A month later the Viña del Mar festival paid tribute to him, and the band reorganised around a new line-up.","type":"text"}]},{"type":"paragraph","content":[{"text":"The line-ups","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The membership has changed more than a dozen times. En la Mira came in 1998 with Enamorao and Baila; a live album recorded in Santo Domingo the following year collected the hits of the first three. On Time turned the quartet into a trio and carried Una Copa de Licor, Chocolate and El Termómetro. Marca Registrada, In the Room and La República followed, the last of them with a duet alongside ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra","occurrenceId":"5e4a3e3c-3c98-411f-99d2-8180a0d16d88"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Esto Es","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The group opened the following decade with a single recorded alongside ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"590493ec-0ad4-4ab6-b17a-84af4ee1bbbe"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ec8ba439-3772-49ff-a218-05f5dc615763","displayText":"Vakeró","occurrenceId":"8d3705bf-77e5-48d5-abe8-39465838d222"}},{"text":", pairing the founding voice of modern merengue with one of the country’s urban rappers on the same track.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ayántame","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Ayántame, released in 2012, reached number one on the Billboard tropical chart and stayed there four weeks. Chucuchá followed the next year with a merengue built on electronic production, and La Pastilla entered the Dominican charts in 2015. The albums have kept coming: El Sonido, Inagotable, Tropicalia and others.","type":"text"}]},{"type":"paragraph","content":[{"text":"The company they keep","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"They belong to the same movement as ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f838ab51-002f-4737-ab38-17f65beec9ab","displayText":"Proyecto Uno","occurrenceId":"c213effb-69c6-41c2-a6d2-78cd5923e2df"}},{"text":", the other large Dominican group of the merengue house era, and their catalogue is one of the fullest records of what that fusion sounded like. They were nominated for a Latin Grammy for best pop album and for a Billboard award as tropical group, and have been recognised at the Viña del Mar festival more than once.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'ilegales'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ilegales, anunciada también como Los Ilegales, es una agrupación dominicana fundada en 1995 y dirigida desde entonces por Vladimir Dotel. Empezó como grupo de merengue house, la variante electrónica del merengue que dominó la mitad de aquella década, y desde entonces ha trabajado el hip hop, el pop latino y la balada a lo largo de más de una docena de álbumes.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Fortaleza Ozama","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El grupo debutó en 1995 en la Fortaleza Ozama, en la Zona Colonial de Santo Domingo, como cuarteto: Dotel junto a Álvaro Guzmán, Anthony de la Cruz y Jason González. Su primer disco llevó el nombre de la banda y les valió premios en México y en Chile.","type":"text"}]},{"type":"paragraph","content":[{"text":"Rebotando","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su segunda producción salió en 1997 con Sueño Contigo, Rebotando, El Taqui Taqui y Como un Trueno, y con ella el primer giro hacia el material romántico. Guzmán había salido antes de la grabación y lo reemplazó Rafael Rivera.","type":"text"}]},{"type":"paragraph","content":[{"text":"En enero de 1998, días después de grabar el video de Sueño Contigo, murió Jason González. El grupo tenía tres años. Un mes más tarde el Festival de Viña del Mar le rindió homenaje, y la banda se reorganizó alrededor de una alineación nueva.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las alineaciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La membresía ha cambiado más de una docena de veces. En la Mira salió en 1998 con Enamorao y Baila; un disco en vivo grabado en Santo Domingo al año siguiente recogió los éxitos de los tres primeros. On Time convirtió al cuarteto en trío y trajo Una Copa de Licor, Chocolate y El Termómetro. Detrás vinieron Marca Registrada, In the Room y La República, este último con un dúo junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"7c732c88-a17c-4234-8033-d7605e0a9310","displayText":"Monchy & Alexandra","occurrenceId":"ad13c087-64b1-4fe6-999b-ef71423a4a8a"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Esto Es","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El grupo abrió la década siguiente con un sencillo grabado junto a ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"627489bc-72e9-4757-adc0-dff03c28f161"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ec8ba439-3772-49ff-a218-05f5dc615763","displayText":"Vakeró","occurrenceId":"1f4d1cb6-6e45-414b-b039-5c7caa780683"}},{"text":", poniendo en un mismo tema a la voz fundadora del merengue moderno y a uno de los raperos urbanos del país.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ayántame","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Ayántame, publicada en 2012, llegó al número uno de la lista tropical de Billboard y se mantuvo allí cuatro semanas. Al año siguiente vino Chucuchá, un merengue armado sobre producción electrónica, y en 2015 La Pastilla entró en las listas dominicanas. Los álbumes han seguido saliendo: El Sonido, Inagotable, Tropicalia y otros.","type":"text"}]},{"type":"paragraph","content":[{"text":"La compañía que tienen","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Pertenecen al mismo movimiento que ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f838ab51-002f-4737-ab38-17f65beec9ab","displayText":"Proyecto Uno","occurrenceId":"84f8c5a6-0a58-458f-873a-90a30cb746bf"}},{"text":", la otra agrupación dominicana grande de la era del merengue house, y su catálogo es uno de los registros más completos de cómo sonaba aquella fusión. Fueron nominados al Latin Grammy al mejor álbum pop y a un premio Billboard como grupo tropical, y han sido reconocidos más de una vez en el festival de Viña del Mar.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'ilegales'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ilegales') AND locale = 'en'), '590493ec-0ad4-4ab6-b17a-84af4ee1bbbe', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ilegales') AND locale = 'en'), '5e4a3e3c-3c98-411f-99d2-8180a0d16d88', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ilegales') AND locale = 'en'), '8d3705bf-77e5-48d5-abe8-39465838d222', 'artist', 'ec8ba439-3772-49ff-a218-05f5dc615763');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ilegales') AND locale = 'en'), 'c213effb-69c6-41c2-a6d2-78cd5923e2df', 'artist', 'f838ab51-002f-4737-ab38-17f65beec9ab');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ilegales') AND locale = 'es'), '1f4d1cb6-6e45-414b-b039-5c7caa780683', 'artist', 'ec8ba439-3772-49ff-a218-05f5dc615763');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ilegales') AND locale = 'es'), '627489bc-72e9-4757-adc0-dff03c28f161', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ilegales') AND locale = 'es'), '84f8c5a6-0a58-458f-873a-90a30cb746bf', 'artist', 'f838ab51-002f-4737-ab38-17f65beec9ab');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'ilegales') AND locale = 'es'), 'ad13c087-64b1-4fe6-999b-ef71423a4a8a', 'artist', '7c732c88-a17c-4234-8033-d7605e0a9310');

COMMIT;
