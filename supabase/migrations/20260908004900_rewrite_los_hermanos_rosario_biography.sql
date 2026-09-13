BEGIN;

-- Rewrite the catalogue entry for Los Hermanos Rosario.
--
-- Los Hermanos Rosario. SÉPTIMA de las 211, con 16 enlaces entrantes. La ficha
-- vieja no era mala de tono -- nombraba "La Dueña del Swing" y "Me Tiene Loco"
-- -- pero fallaba en lo esencial de una BANDA FAMILIAR: NO NOMBRABA A UN SOLO
-- HERMANO. Ni a los tres que la sostienen hoy ni a los cuatro que pasaron.
--
-- Y le faltaba el AÑO DE FUNDACIÓN, que en una fila de tipo 'group' tiene campo
-- propio y estaba en NULL. Se fundó el 1 DE MAYO DE 1978, debutando en Salvaleón
-- de Higüey ante las autoridades municipales en un acto del Día del Trabajo. Se
-- llena date_of_birth y birth_year, que en filas de grupo significan formación.
--
-- Esto NO es la conflación persona/grupo que dejé sin tocar en
-- pochy-y-su-cocoband. Allí el campo guardaba la fecha de nacimiento de una
-- persona; aquí estaba vacío y se llena con lo que el campo pide.
--
-- SE QUITA UNA AFIRMACIÓN DE VENTAS SIN FUENTE. El texto viejo decía: "At their
-- commercial height they were THE BEST-SELLING LATIN ACT IN THE WORLD, with
-- albums that sold millions of copies". La primera mitad no la sostiene ninguna
-- fuente que encontré, y la segunda es cifra de ventas cruda, que aquí no se
-- escribe. SE SUSTITUYE POR LO QUE SÍ ESTÁ DOCUMENTADO Y DICE MÁS: discos de
-- oro, platino y doble platino, y certificaciones de la RIAA por tres
-- producciones concretas.
--
-- TAMPOCO SE ESCRIBEN las 500.000 copias de "Los Dueños del Swing" que da la
-- fuente. Misma razón.
--
-- LO QUE FALTABA:
--
--   LOS HERMANOS, que son el grupo: Rafa, Tony y Luis siguen; pasaron Pepe,
--   Francis, Rossy y Toño.
--
--   PEPE ROSARIO, fundador, pianista y director musical, muerto en marzo de
--   1983. La ficha vieja no lo mencionaba. Acabo de crearle ficha propia a
--   petición del editor, así que ahora va enlazado.
--
--   EL PRIMER SENCILLO, "María Guayando", y el primer disco de 1980 con "Las
--   Locas", "Vengo Acabando" y "Bonifacio", que la gente llama "El Lápiz".
--
--   "PECADORA" ESTÁ EN LA BANDA SONORA DE "TACONES LEJANOS", DE PEDRO
--   ALMODÓVAR. Ese dato solo vale la ficha entera y no aparecía.
--
--   EL LOGRO DE BILLBOARD, que es el más citable: con "Morena Ven", de 1993,
--   fueron LA PRIMERA AGRUPACIÓN DE MERENGUE en entrar al top 10 de Billboard.
--   Antes solo lo había conseguido Juan Luis Guerra, que por eso se enlaza.
--
--   "LOS DUEÑOS DEL SWING" (1995) fue ÁLBUM TROPICAL DEL AÑO de Billboard.
--
--   EL RÉCORD GUINNESS: junto a Andy Montañez tienen el de más personas frente
--   a una tarima en los carnavales de Canarias.
--
--   LOS CONGOS DE ORO de Barranquilla, varias veces, incluido un SÚPER CONGO DE
--   ORO.
--
-- EL PLEITO CON KAREN RECORDS ENTRA. Un litigio judicial con su antigua casa
-- discográfica los dejó CINCO AÑOS sin publicar disco nuevo. Es una disputa
-- contractual sobre la obra, del mismo tipo que la de autoría de Bulin 47 y la
-- del nombre de los Premios Casandra, y esas sí se registran. No es asunto
-- penal ni vida privada: es la razón documentada de un hueco de cinco años en
-- una discografía.
--
-- LA MUERTE DE PEPE SE ESCRIBE SIN CIRCUNSTANCIAS, igual que en su propia
-- ficha: fue un homicidio y los homicidios no entran. Sí entra que el grupo
-- paró y estuvo a punto de disolverse, que es historia de la agrupación.
--
-- EL SITIO WEB ESTÁ VIVO, comprobado: loshermanosrosario.net responde con y sin
-- www. Se conserva como estaba.
--
-- CINCO ENLACES: pepe-rosario (recién creado), tono-rosario y rafa-rosario
-- (hermanos), pochy-y-su-cocoband -- porque Pochy Familia fue arreglista y
-- compositor de esta orquesta antes de fundar la suya, y lo escribí en su ficha
-- hace un rato, así que cierra por los dos lados -- y juan-luis-guerra, por el
-- antecedente de Billboard.
--
-- FUENTES: Wikipedia en español, con la reserva de que el artículo está marcado
-- como falto de referencias desde 2010, para la cronología y la discografía. El
-- Nacional, 19 de marzo de 2021, que repite el mismo relato de fundación y añade
-- el detalle de las canciones que sonaban al morir Pepe. Comprobación propia del
-- sitio web.
--
-- NOMBRES NUEVOS PARA LA LISTA: TONY, LUIS, FRANCIS y ROSSY ROSARIO, los cuatro
-- hermanos sin ficha; SANTO HERNÁNDEZ, bailarín principal del grupo entre 1978 y
-- 1983; y CHIQUITÍN PAYÁN, que los contrató para el Hotel Romana.
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
       name = 'Los Hermanos Rosario',
       sort_name = 'Los Hermanos Rosario',
       type = 'group',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1978-05-01',
       birth_year = 1978,
       date_of_death = NULL,
       birth_place = 'Salvaleón de Higüey',
       province = 'La Altagracia',
       first_name = NULL,
       middle_name = NULL,
       last_name = NULL,
       second_last_name = NULL,
       stage_name = 'Los Hermanos Rosario',
       aliases = ARRAY['Los Rosario', 'Los Dueños del Swing']::text[],
       occupations = '["musician"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY[]::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = 'https://www.loshermanosrosario.net',
       youtube = '@loshermanosrosario',
       facebook = 'loshermanosrosario',
       instagram = 'hermanosrosario',
       disambiguation = 'Merengue orchestra of seven brothers from Higüey; first merengue act in the Billboard top ten',
       bio_en = 'Los Hermanos Rosario are a Dominican merengue orchestra formed by seven brothers from Higüey. They were the first merengue group to reach the top ten of the Billboard charts, and across four decades they have been the band the genre is measured against.

**Salvaleón de Higüey**

The group played its first date on 1 May 1978, in its own town, for the municipal authorities at a Labour Day event. Santo Hernández danced at the front of it from that year until 1983. They worked the eastern towns until the bandleader Chiquitín Payán hired them for the Hotel Romana at Casa de Campo, which was the booking that took them out of the province.

They had already recorded a first single, María Guayando, when they moved to the capital in 1980 and made an album. Las Locas came off it and went to the top of every Dominican chart, alongside Vengo Acabando and Bonifacio, which everyone calls El Lápiz.

**Nineteen eighty-three**

The founder, pianist and musical director was Pepe Rosario. He died in March 1983, and the group stopped playing. The brothers considered giving it up and going home.

They went on instead, with Toño Rosario and Rafa Rosario in front. Acabando appeared in 1987 with Borrón y Cuenta Nueva, Adolescente and La Luna Coqueta, and from there the run did not stop.

**Bomba**

Otra Vez, Fuera de Serie and Insuperables made them the most played orchestra in the country: Rubia de Fuego, Ingrata, Mi Tonto Amor, Bomba, Cumandé, Loquito Por Ti, Dime, Esa Morena, Bríndame Una Copa, Desde Que la Vi and Mil Horas. Pecadora, from the same stretch, was used by Pedro Almodóvar on the soundtrack of Tacones Lejanos.

Pochy Familia had arranged and written for them before founding Pochy y su Cocoband, which is one of the reasons the two catalogues sound related.

**Morena Ven**

Los Mundialmente Sabrosos, in 1993, took them out of the country for good. Amor, Amor went to number one on the tropical charts of the United States, Puerto Rico, Panama, Venezuela, Colombia, Central America and home, and put them on Billboard for the first time. The second single, Morena Ven, made them the first merengue group to enter the Billboard top ten — something only Juan Luis Guerra 4.40 had managed before.

**La Dueña del Swing**

Los Dueños del Swing followed in 1995 and is the record they are known by. Billboard named it tropical album of the year, and La Dueña del Swing became one of the most widely played merengues ever recorded. Un Día en Nueva York, La Cleptómana, Caramelo, Oleila and Mujer Prohibida came off the same album.

Y Es Fácil! arrived in 1997, Bomba 2000 in 1999 and Swing a Domicilio in 2002, carrying El Rompecintura, El Fin de Semana, Siento and Ya Me Liberé. Otra Vez, Fuera de Serie, Insuperables, Los Mundialmente Sabrosos, Los Dueños del Swing and Y Es Fácil! all earned gold, platinum or double platinum, and the American recording industry association certified sales on the last three.

**The rooms and the halt**

They have played Carnegie Hall, Madison Square Garden, Lincoln Center and Radio City Music Hall, the Poliedro in Venezuela, and festivals and halls in Milan, Rome, London, Madrid, Amsterdam, Brussels, Zurich and Berlin. Barranquilla has given them the Congo de Oro more than once, including a Súper Congo de Oro, and they hold a Guinness-certified record, shared with Andy Montañez, for the largest crowd ever gathered in front of a stage at the Canary Islands carnival.

A legal dispute with their former label, Karen Records, then kept them out of the studio for five years. They came back with Aura, released through J&N Records, and they are still working.',
       bio_es = 'Los Hermanos Rosario son una orquesta de merengue dominicana formada por siete hermanos de Higüey. Fueron la primera agrupación de merengue en llegar al top diez de las listas de Billboard, y a lo largo de cuatro décadas han sido la banda con la que se mide el género.

**Salvaleón de Higüey**

El grupo tocó por primera vez el 1 de mayo de 1978, en su propio pueblo, para las autoridades municipales en un acto del Día del Trabajo. Santo Hernández bailó al frente desde ese año hasta 1983. Se abrieron camino por los pueblos del este hasta que el maestro Chiquitín Payán los contrató para el Hotel Romana, en Casa de Campo, que fue la contratación que los sacó de la provincia.

Ya habían grabado un primer sencillo, María Guayando, cuando se mudaron a la capital en 1980 e hicieron un disco. De ahí salió Las Locas, que encabezó todas las listas dominicanas, junto a Vengo Acabando y Bonifacio, que todo el mundo llama El Lápiz.

**Mil novecientos ochenta y tres**

El fundador, pianista y director musical era Pepe Rosario. Murió en marzo de 1983 y el grupo dejó de tocar. Los hermanos llegaron a plantearse dejarlo y volverse al pueblo.

Siguieron en cambio, con Toño Rosario y Rafa Rosario al frente. Acabando salió en 1987 con Borrón y Cuenta Nueva, Adolescente y La Luna Coqueta, y desde ahí la racha no paró.

**Bomba**

Otra Vez, Fuera de Serie e Insuperables los convirtieron en la orquesta más sonada del país: Rubia de Fuego, Ingrata, Mi Tonto Amor, Bomba, Cumandé, Loquito Por Ti, Dime, Esa Morena, Bríndame Una Copa, Desde Que la Vi y Mil Horas. Pecadora, de esa misma tanda, la usó Pedro Almodóvar en la banda sonora de Tacones Lejanos.

Pochy Familia había arreglado y compuesto para ellos antes de fundar Pochy y su Cocoband, que es una de las razones por las que los dos catálogos suenan emparentados.

**Morena Ven**

Los Mundialmente Sabrosos, de 1993, los sacó del país para siempre. Amor, Amor llegó al primer lugar de las carteleras tropicales de Estados Unidos, Puerto Rico, Panamá, Venezuela, Colombia, Centroamérica y el país, y los puso en Billboard por primera vez. El segundo corte, Morena Ven, los convirtió en la primera agrupación de merengue en entrar al top diez de Billboard, algo que hasta entonces solo había conseguido Juan Luis Guerra 4.40.

**La Dueña del Swing**

Los Dueños del Swing vino en 1995 y es el disco por el que se les conoce. Billboard lo nombró álbum tropical del año, y La Dueña del Swing se convirtió en uno de los merengues más difundidos que se hayan grabado. Un Día en Nueva York, La Cleptómana, Caramelo, Oleila y Mujer Prohibida salieron del mismo álbum.

Y Es Fácil! llegó en 1997, Bomba 2000 en 1999 y Swing a Domicilio en 2002, con El Rompecintura, El Fin de Semana, Siento y Ya Me Liberé. Otra Vez, Fuera de Serie, Insuperables, Los Mundialmente Sabrosos, Los Dueños del Swing e Y Es Fácil! obtuvieron todos oro, platino o doble platino, y la asociación de la industria discográfica estadounidense certificó las ventas de los tres últimos.

**Las salas y el parón**

Se han presentado en el Carnegie Hall, el Madison Square Garden, el Lincoln Center y el Radio City Music Hall, en el Poliedro de Venezuela, y en festivales y salas de Milán, Roma, Londres, Madrid, Ámsterdam, Bruselas, Zúrich y Berlín. Barranquilla les ha dado el Congo de Oro más de una vez, incluido un Súper Congo de Oro, y tienen un récord certificado por Guinness, compartido con Andy Montañez, por la mayor cantidad de personas reunidas frente a una tarima en los carnavales de Canarias.

Un litigio judicial con su antigua casa discográfica, Karen Records, los dejó después cinco años sin entrar a un estudio. Volvieron con Aura, publicado por J&N Records, y siguen en activo.',
       updated_at = now()
 WHERE slug = 'los-hermanos-rosario';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Los Hermanos Rosario are a Dominican merengue orchestra formed by seven brothers from Higüey. They were the first merengue group to reach the top ten of the Billboard charts, and across four decades they have been the band the genre is measured against.","type":"text"}]},{"type":"paragraph","content":[{"text":"Salvaleón de Higüey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The group played its first date on 1 May 1978, in its own town, for the municipal authorities at a Labour Day event. Santo Hernández danced at the front of it from that year until 1983. They worked the eastern towns until the bandleader Chiquitín Payán hired them for the Hotel Romana at Casa de Campo, which was the booking that took them out of the province.","type":"text"}]},{"type":"paragraph","content":[{"text":"They had already recorded a first single, María Guayando, when they moved to the capital in 1980 and made an album. Las Locas came off it and went to the top of every Dominican chart, alongside Vengo Acabando and Bonifacio, which everyone calls El Lápiz.","type":"text"}]},{"type":"paragraph","content":[{"text":"Nineteen eighty-three","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The founder, pianist and musical director was ","type":"text"},{"type":"artistReference","attrs":{"artistId":"03586dc0-5bbe-4b91-859d-f9c0dd580ea4","displayText":"Pepe Rosario","occurrenceId":"b08b3e1d-95a1-4c23-aa3a-3bb11cf8bc1b"}},{"text":". He died in March 1983, and the group stopped playing. The brothers considered giving it up and going home.","type":"text"}]},{"type":"paragraph","content":[{"text":"They went on instead, with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario","occurrenceId":"5662f73d-e9e0-4588-ad03-1f8ca3c8c7b1"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fb033f0-4f8b-4101-a67d-1d445f316dc4","displayText":"Rafa Rosario","occurrenceId":"240ea168-8405-4087-a86f-575e5def6d86"}},{"text":" in front. Acabando appeared in 1987 with Borrón y Cuenta Nueva, Adolescente and La Luna Coqueta, and from there the run did not stop.","type":"text"}]},{"type":"paragraph","content":[{"text":"Bomba","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Otra Vez, Fuera de Serie and Insuperables made them the most played orchestra in the country: Rubia de Fuego, Ingrata, Mi Tonto Amor, Bomba, Cumandé, Loquito Por Ti, Dime, Esa Morena, Bríndame Una Copa, Desde Que la Vi and Mil Horas. Pecadora, from the same stretch, was used by Pedro Almodóvar on the soundtrack of Tacones Lejanos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pochy Familia had arranged and written for them before founding ","type":"text"},{"type":"artistReference","attrs":{"artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband","occurrenceId":"661903b3-a351-4939-b24f-644d30763c86"}},{"text":", which is one of the reasons the two catalogues sound related.","type":"text"}]},{"type":"paragraph","content":[{"text":"Morena Ven","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Los Mundialmente Sabrosos, in 1993, took them out of the country for good. Amor, Amor went to number one on the tropical charts of the United States, Puerto Rico, Panama, Venezuela, Colombia, Central America and home, and put them on Billboard for the first time. The second single, Morena Ven, made them the first merengue group to enter the Billboard top ten — something only ","type":"text"},{"type":"artistReference","attrs":{"artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40","occurrenceId":"be70eee1-9ef8-49a3-8924-cd19abbae4af"}},{"text":" had managed before.","type":"text"}]},{"type":"paragraph","content":[{"text":"La Dueña del Swing","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Los Dueños del Swing followed in 1995 and is the record they are known by. Billboard named it tropical album of the year, and La Dueña del Swing became one of the most widely played merengues ever recorded. Un Día en Nueva York, La Cleptómana, Caramelo, Oleila and Mujer Prohibida came off the same album.","type":"text"}]},{"type":"paragraph","content":[{"text":"Y Es Fácil! arrived in 1997, Bomba 2000 in 1999 and Swing a Domicilio in 2002, carrying El Rompecintura, El Fin de Semana, Siento and Ya Me Liberé. Otra Vez, Fuera de Serie, Insuperables, Los Mundialmente Sabrosos, Los Dueños del Swing and Y Es Fácil! all earned gold, platinum or double platinum, and the American recording industry association certified sales on the last three.","type":"text"}]},{"type":"paragraph","content":[{"text":"The rooms and the halt","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"They have played Carnegie Hall, Madison Square Garden, Lincoln Center and Radio City Music Hall, the Poliedro in Venezuela, and festivals and halls in Milan, Rome, London, Madrid, Amsterdam, Brussels, Zurich and Berlin. Barranquilla has given them the Congo de Oro more than once, including a Súper Congo de Oro, and they hold a Guinness-certified record, shared with Andy Montañez, for the largest crowd ever gathered in front of a stage at the Canary Islands carnival.","type":"text"}]},{"type":"paragraph","content":[{"text":"A legal dispute with their former label, Karen Records, then kept them out of the studio for five years. They came back with Aura, released through J&N Records, and they are still working.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Los Hermanos Rosario son una orquesta de merengue dominicana formada por siete hermanos de Higüey. Fueron la primera agrupación de merengue en llegar al top diez de las listas de Billboard, y a lo largo de cuatro décadas han sido la banda con la que se mide el género.","type":"text"}]},{"type":"paragraph","content":[{"text":"Salvaleón de Higüey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El grupo tocó por primera vez el 1 de mayo de 1978, en su propio pueblo, para las autoridades municipales en un acto del Día del Trabajo. Santo Hernández bailó al frente desde ese año hasta 1983. Se abrieron camino por los pueblos del este hasta que el maestro Chiquitín Payán los contrató para el Hotel Romana, en Casa de Campo, que fue la contratación que los sacó de la provincia.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ya habían grabado un primer sencillo, María Guayando, cuando se mudaron a la capital en 1980 e hicieron un disco. De ahí salió Las Locas, que encabezó todas las listas dominicanas, junto a Vengo Acabando y Bonifacio, que todo el mundo llama El Lápiz.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mil novecientos ochenta y tres","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El fundador, pianista y director musical era ","type":"text"},{"type":"artistReference","attrs":{"artistId":"03586dc0-5bbe-4b91-859d-f9c0dd580ea4","displayText":"Pepe Rosario","occurrenceId":"d463c189-d05a-4e43-b535-73153bce9a4b"}},{"text":". Murió en marzo de 1983 y el grupo dejó de tocar. Los hermanos llegaron a plantearse dejarlo y volverse al pueblo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Siguieron en cambio, con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario","occurrenceId":"cc36a531-828a-4f40-bbd9-fee98327783f"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fb033f0-4f8b-4101-a67d-1d445f316dc4","displayText":"Rafa Rosario","occurrenceId":"557b642c-9fd7-4de7-92d1-8f694d2de0b4"}},{"text":" al frente. Acabando salió en 1987 con Borrón y Cuenta Nueva, Adolescente y La Luna Coqueta, y desde ahí la racha no paró.","type":"text"}]},{"type":"paragraph","content":[{"text":"Bomba","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Otra Vez, Fuera de Serie e Insuperables los convirtieron en la orquesta más sonada del país: Rubia de Fuego, Ingrata, Mi Tonto Amor, Bomba, Cumandé, Loquito Por Ti, Dime, Esa Morena, Bríndame Una Copa, Desde Que la Vi y Mil Horas. Pecadora, de esa misma tanda, la usó Pedro Almodóvar en la banda sonora de Tacones Lejanos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Pochy Familia había arreglado y compuesto para ellos antes de fundar ","type":"text"},{"type":"artistReference","attrs":{"artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband","occurrenceId":"381acce2-abcb-4c16-ac07-087d093b3d4e"}},{"text":", que es una de las razones por las que los dos catálogos suenan emparentados.","type":"text"}]},{"type":"paragraph","content":[{"text":"Morena Ven","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Los Mundialmente Sabrosos, de 1993, los sacó del país para siempre. Amor, Amor llegó al primer lugar de las carteleras tropicales de Estados Unidos, Puerto Rico, Panamá, Venezuela, Colombia, Centroamérica y el país, y los puso en Billboard por primera vez. El segundo corte, Morena Ven, los convirtió en la primera agrupación de merengue en entrar al top diez de Billboard, algo que hasta entonces solo había conseguido ","type":"text"},{"type":"artistReference","attrs":{"artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40","occurrenceId":"9a520d1f-55c7-4079-81de-9357ce759bea"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"La Dueña del Swing","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Los Dueños del Swing vino en 1995 y es el disco por el que se les conoce. Billboard lo nombró álbum tropical del año, y La Dueña del Swing se convirtió en uno de los merengues más difundidos que se hayan grabado. Un Día en Nueva York, La Cleptómana, Caramelo, Oleila y Mujer Prohibida salieron del mismo álbum.","type":"text"}]},{"type":"paragraph","content":[{"text":"Y Es Fácil! llegó en 1997, Bomba 2000 en 1999 y Swing a Domicilio en 2002, con El Rompecintura, El Fin de Semana, Siento y Ya Me Liberé. Otra Vez, Fuera de Serie, Insuperables, Los Mundialmente Sabrosos, Los Dueños del Swing e Y Es Fácil! obtuvieron todos oro, platino o doble platino, y la asociación de la industria discográfica estadounidense certificó las ventas de los tres últimos.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las salas y el parón","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se han presentado en el Carnegie Hall, el Madison Square Garden, el Lincoln Center y el Radio City Music Hall, en el Poliedro de Venezuela, y en festivales y salas de Milán, Roma, Londres, Madrid, Ámsterdam, Bruselas, Zúrich y Berlín. Barranquilla les ha dado el Congo de Oro más de una vez, incluido un Súper Congo de Oro, y tienen un récord certificado por Guinness, compartido con Andy Montañez, por la mayor cantidad de personas reunidas frente a una tarima en los carnavales de Canarias.","type":"text"}]},{"type":"paragraph","content":[{"text":"Un litigio judicial con su antigua casa discográfica, Karen Records, los dejó después cinco años sin entrar a un estudio. Volvieron con Aura, publicado por J&N Records, y siguen en activo.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario') AND locale = 'en'), '240ea168-8405-4087-a86f-575e5def6d86', 'artist', '6fb033f0-4f8b-4101-a67d-1d445f316dc4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario') AND locale = 'en'), '5662f73d-e9e0-4588-ad03-1f8ca3c8c7b1', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario') AND locale = 'en'), '661903b3-a351-4939-b24f-644d30763c86', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario') AND locale = 'en'), 'b08b3e1d-95a1-4c23-aa3a-3bb11cf8bc1b', 'artist', '03586dc0-5bbe-4b91-859d-f9c0dd580ea4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario') AND locale = 'en'), 'be70eee1-9ef8-49a3-8924-cd19abbae4af', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario') AND locale = 'es'), '381acce2-abcb-4c16-ac07-087d093b3d4e', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario') AND locale = 'es'), '557b642c-9fd7-4de7-92d1-8f694d2de0b4', 'artist', '6fb033f0-4f8b-4101-a67d-1d445f316dc4');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario') AND locale = 'es'), '9a520d1f-55c7-4079-81de-9357ce759bea', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario') AND locale = 'es'), 'cc36a531-828a-4f40-bbd9-fee98327783f', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'los-hermanos-rosario') AND locale = 'es'), 'd463c189-d05a-4e43-b535-73153bce9a4b', 'artist', '03586dc0-5bbe-4b91-859d-f9c0dd580ea4');

COMMIT;
