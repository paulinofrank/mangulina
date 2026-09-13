BEGIN;

-- Rewrite the catalogue entry for Fernando Villalona.
--
-- Fernando Villalona. CUARTA de las 235, y la segunda ficha más citada del
-- catálogo después de Johnny Ventura: cincuenta y cuatro biografías lo nombran.
--
-- ESTA NO ERA COMO LAS OTRAS. El texto inglés del lote de mayo era largo y con
-- datos de verdad, no el molde de cuatro párrafos. Pero tenía tres errores de
-- hecho y una violación de las reglas editoriales, y ninguna sección.
--
-- LO QUE SE CORRIGE DEL TEXTO PUBLICADO:
--
--   1. DECÍA QUE QUEDÓ TERCERO en el Festival de la Voz de 1971. Wikipedia dice
--      QUINTO LUGAR, y lo dice DOS VECES, además de dar el detalle que lo
--      sostiene: tenía quince años y cantó "Lágrimas para un recuerdo". Se
--      escribe quinto.
--
--   2. OMITÍA A RAFAEL SOLANO POR COMPLETO. Solano organizó aquel primer
--      Festival de la Voz y fue quien lo descubrió y le grabó su primera
--      producción. El texto viejo saltaba directo a Wilfrido Vargas. Solano
--      está en el catálogo y ahora queda enlazado.
--
--   3. DETALLABA UNA DEPENDENCIA DE DROGAS. Eso es vida privada y salud, y no
--      va, igual que no fue la artritis de Eladio Romero Santos ni la causa de
--      muerte de nadie. SÍ ENTRA EL HECHO PROFESIONAL, que además es el
--      interesante: se retiró de la vida pública durante un período y NO DEJÓ
--      DE GRABAR, y de esos años salen algunas de sus mejores canciones.
--
-- CONFLICTO DE LUGAR DE NACIMIENTO QUE NO RESUELVO Y QUE HAY QUE DECIDIR.
--
--   La fila guarda LOMA DE CABRERA, provincia Dajabón, y el texto inglés decía
--   lo mismo. Wikipedia dice, en el encabezado Y en el cuerpo, que NACIÓ EN
--   MONTECRISTI y que pasó su infancia y adolescencia en Loma de Cabrera.
--
--   Las dos fuentes coinciden en que se crió en Loma de Cabrera. Difieren en
--   dónde nació. NO TOCO LA FILA y ESCRIBO SOLO LO QUE AMBAS SOSTIENEN: que se
--   crió en Loma de Cabrera. La ficha no afirma un municipio de nacimiento
--   hasta que el editor decida. Es preferible a elegir uno y equivocarse.
--
-- DOS ERRORES DE LA FILA QUE SE CORRIGEN:
--
--   aliases guardaba 'El Nino Mimado', SIN LA EÑE. Es "El Niño Mimado", y viene
--   de su etapa como solista desde 1981; hasta tiene un álbum con ese título en
--   1993. Otra eñe perdida.
--
--   aliases guardaba 'Ramon Fernando Villalona Evora', que además de ser su
--   nombre legal ya desglosado en los cuatro campos, venía SIN NINGÚN ACENTO:
--   ni Ramón ni Évora. Cuarto caso hoy de nombre legal duplicado como alias.
--   Se quita y se añade "Fernandito Villalona", que Wikipedia registra como
--   otro nombre suyo y que sí es un nombre alternativo real.
--
-- LA ETIMOLOGÍA DE "EL MAYIMBE" SE REBAJA. El texto viejo afirmaba que viene
-- del taíno y significa jefe tribal. En el habla dominicana mayimbe es "el
-- jefe", eso no está en duda, pero el origen taíno es una atribución que no
-- pude verificar y que también se le adjudica a raíces africanas. Se escribe lo
-- que significa, no de dónde viene.
--
-- NO SE GUARDA SITIO WEB. Wikipedia da elmayimbe.com.do y LO PROBÉ: no
-- resuelve. El campo se queda vacío.
--
-- CINCO ENLACES, TODOS DOCUMENTADOS: rafael-solano lo descubre;
-- wilfrido-vargas crea la orquesta donde debuta; bonny-cepeda y raulin-rosendo
-- son sus compañeros en ella; y tatico-henriquez da nombre a uno de los temas
-- que Villalona popularizó allí.
--
-- EL PREMIO DE 2013 ESTÁ BIEN EN LA BASE: figura con won = false, que es
-- correcto, fue nominación y no victoria. No se toca.
--
-- SE DEJA FUERA: esposas, cinco hijos y el hijo adoptado. También su conversión
-- religiosa como tal; SÍ ENTRA el álbum cristiano de 2011, que es un hecho
-- discográfico.
--
-- FUENTES: Wikipedia en español, con discografía completa de veintiocho
-- álbumes. La tabla de premios de la base, que aporta los dos Latin Grammy y el
-- Soberano de 2003.
--
-- NOMBRES NUEVOS PARA LA LISTA: Papito Andújar, su primer maestro; Tito Kenton,
-- compañero en Los Hijos del Rey; Victoria Daly, con quien grabó "El color de
-- tu mirada"; Raúl Jurany, autor de "Me he enamorado"; y la propia orquesta
-- LOS HIJOS DEL REY, que no está en el catálogo pese a ser la escuela de media
-- generación.
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
       name = 'Fernando Villalona',
       sort_name = 'Villalona Évora, Ramón Fernando',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = FALSE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1955-05-07',
       birth_year = 1955,
       date_of_death = NULL,
       birth_place = 'Loma de Cabrera',
       province = 'Dajabón',
       first_name = 'Ramón',
       middle_name = 'Fernando',
       last_name = 'Villalona',
       second_last_name = 'Évora',
       stage_name = 'Fernando Villalona',
       aliases = ARRAY['El Mayimbe', 'El Niño Mimado', 'Fernandito Villalona']::text[],
       occupations = '["bandleader","composer"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY['bolero', 'ballads']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = '@fernandovillalona',
       facebook = 'Fernandovillalonard',
       instagram = 'elmayimbe',
       disambiguation = 'Merengue singer known as El Mayimbe; a defining voice of the golden years and one of the most cited artists in the catalogue',
       bio_en = 'Ramón Fernando Villalona Évora, known as Fernando Villalona and called El Mayimbe, is a Dominican singer. He is a lyric tenor who made his name in ballad and bolero before becoming one of the defining voices of merengue, and he has recorded more than twenty albums across five decades.

**Loma de Cabrera**

He grew up in Loma de Cabrera, in the north-western province of Dajabón, near the Haitian border, alongside nine siblings. He did his early schooling there and began performing under a local teacher, appearing at school and children’s events from a young age.

**The voice festival**

At fifteen he represented his town at the first Festival de la Voz, organised by Rafael Solano and broadcast on the state channel in June 1971. He sang Lágrimas para un Recuerdo and finished fifth. Not winning it turned out to matter more than winning: the final round provoked the largest public protest ever seen at a Dominican talent contest, and the country learned his name.

Solano discovered him in that same period and recorded a first production with him, but Villalona returned to Loma de Cabrera for a time before the career resumed.

**Los Hijos del Rey**

The orchestra Los Hijos del Rey, created in the middle of the seventies by Wilfrido Vargas, is where he came back to music and made his professional debut, on a bill with the Fania All Stars. The band was a school for a generation: Bonny Cepeda and Raulín Rosendo were in it alongside him.

He popularised a long list of songs there — among them A Tatico Henríquez, written for Tatico Henríquez, along with Barahona, Santo Domingo, Así es la Vida, La Ambulancia, Jardinera and Compadre Pedro Juan. His own following outgrew the group, and he left at the end of the decade.

**El Niño Mimado**

He began as a soloist in 1981 and the eighties belonged to him. Tabaco y Ron, Celos, Te Amo Demasiado, La Hamaquita, Dominicano Soy, Sonámbulo and Carnaval come from those years, and the affection of the audience gave him the second nickname he still carries, the spoiled child. The first one, El Mayimbe, means the boss in Dominican speech, and it stuck from the seventies onward.

**Out of sight, still recording**

Quisqueya, No Podrás, Música Latina, Retorno and Me He Enamorado kept him at the front of merengue through the following decade. He also withdrew from public life for a stretch of those years, and the notable thing is that he never stopped recording: some of his best-regarded songs date from exactly that period, and his records stayed at number one in the country while he was out of sight.

**Mal Acostumbrado**

The album Mal Acostumbrado brought him the Latin Grammy for best merengue or bachata album, and a nomination at the Grammy ceremony held at Madison Square Garden the following year. In that same period he took El Soberano, the highest award of the Dominican critics’ association. He also sang on the Spanish-language version of We Are the World recorded for Haiti.

**Mi Luz**

He marked forty years in music in 2011 with Mi Luz, a Christian album on which he sang about his own past and what had changed in it. The following year he recorded El Color de tu Mirada as a duet, and its video was nominated for music video of the year.

**Insensatez**

The album Insensatez won him a second Latin Grammy in 2021, four decades after he began as a soloist. The Dominican Senate formally recognised fifty years of his career in May 2022.',
       bio_es = 'Ramón Fernando Villalona Évora, conocido como Fernando Villalona y llamado El Mayimbe, es un cantante dominicano. Es un tenor lírico que se dio a conocer en la balada y el bolero antes de convertirse en una de las voces que definen el merengue, y ha grabado más de veinte álbumes a lo largo de cinco décadas.

**Loma de Cabrera**

Se crió en Loma de Cabrera, en la provincia noroccidental de Dajabón, cerca de la frontera con Haití, junto a nueve hermanos. Allí cursó sus estudios iniciales y empezó a presentarse bajo la tutela de un maestro del pueblo, actuando desde niño en veladas escolares e infantiles.

**El Festival de la Voz**

A los quince años representó a su pueblo en el primer Festival de la Voz, organizado por Rafael Solano y transmitido por el canal estatal en junio de 1971. Cantó Lágrimas para un Recuerdo y quedó en quinto lugar. No ganar resultó más importante que ganar: la ronda final provocó la mayor protesta pública que se había visto en un concurso de talentos dominicano, y el país aprendió su nombre.

Solano lo descubrió por esos mismos días y le grabó una primera producción, pero Villalona regresó por un tiempo a Loma de Cabrera antes de que la carrera arrancara de verdad.

**Los Hijos del Rey**

La orquesta Los Hijos del Rey, creada a mediados de los setenta por Wilfrido Vargas, es donde vuelve a la música y donde debuta profesionalmente, en un cartel junto a la Fania All Stars. La banda fue escuela de toda una generación: allí estuvieron con él Bonny Cepeda y Raulín Rosendo.

Popularizó allí una lista larga de temas, entre ellos A Tatico Henríquez, escrito para Tatico Henríquez, además de Barahona, Santo Domingo, Así es la Vida, La Ambulancia, Jardinera y Compadre Pedro Juan. Su público propio terminó siendo más grande que el grupo, y salió de él al final de la década.

**El Niño Mimado**

Empezó como solista en 1981 y los ochenta fueron suyos. Tabaco y Ron, Celos, Te Amo Demasiado, La Hamaquita, Dominicano Soy, Sonámbulo y Carnaval son de esos años, y el cariño del público le puso el segundo apodo que todavía carga. El primero, El Mayimbe, significa el jefe en el habla dominicana, y se le quedó desde los setenta.

**Fuera de la vista, grabando**

Quisqueya, No Podrás, Música Latina, Retorno y Me He Enamorado lo mantuvieron al frente del merengue durante la década siguiente. También se retiró de la vida pública durante una parte de esos años, y lo notable es que no dejó de grabar: algunas de sus canciones más valoradas son justamente de ese período, y sus discos seguían en el número uno del país mientras él estaba fuera de la vista.

**Mal Acostumbrado**

El álbum Mal Acostumbrado le dio el Latin Grammy al mejor álbum de merengue o bachata, y una nominación en la ceremonia del Grammy celebrada en el Madison Square Garden al año siguiente. En esa misma etapa se llevó El Soberano, el galardón mayor de la crónica de arte dominicana. Cantó además en la versión en español de We Are the World grabada para Haití.

**Mi Luz**

Cumplió cuarenta años en la música en 2011 con Mi Luz, un álbum cristiano en el que cantó sobre su propio pasado y sobre lo que había cambiado en él. Al año siguiente grabó a dúo El Color de tu Mirada, cuyo video fue nominado a video musical del año.

**Insensatez**

El álbum Insensatez le dio un segundo Latin Grammy en 2021, cuatro décadas después de haber empezado como solista. El Senado de la República reconoció formalmente sus cincuenta años de carrera en mayo de 2022.',
       updated_at = now()
 WHERE slug = 'fernando-villalona';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ramón Fernando Villalona Évora, known as Fernando Villalona and called El Mayimbe, is a Dominican singer. He is a lyric tenor who made his name in ballad and bolero before becoming one of the defining voices of merengue, and he has recorded more than twenty albums across five decades.","type":"text"}]},{"type":"paragraph","content":[{"text":"Loma de Cabrera","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He grew up in Loma de Cabrera, in the north-western province of Dajabón, near the Haitian border, alongside nine siblings. He did his early schooling there and began performing under a local teacher, appearing at school and children’s events from a young age.","type":"text"}]},{"type":"paragraph","content":[{"text":"The voice festival","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"At fifteen he represented his town at the first Festival de la Voz, organised by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"1bcfd0cd-07b5-4921-8fc0-d88830dfcbf1"}},{"text":" and broadcast on the state channel in June 1971. He sang Lágrimas para un Recuerdo and finished fifth. Not winning it turned out to matter more than winning: the final round provoked the largest public protest ever seen at a Dominican talent contest, and the country learned his name.","type":"text"}]},{"type":"paragraph","content":[{"text":"Solano discovered him in that same period and recorded a first production with him, but Villalona returned to Loma de Cabrera for a time before the career resumed.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Hijos del Rey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The orchestra Los Hijos del Rey, created in the middle of the seventies by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"948160cd-b763-4153-b9de-b715f1b5de60"}},{"text":", is where he came back to music and made his professional debut, on a bill with the Fania All Stars. The band was a school for a generation: ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc4db4c6-c96f-4eb7-af95-ac637785c5bf","displayText":"Bonny Cepeda","occurrenceId":"958eefb2-22e6-46a2-85a4-344577411af0"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faf3e4cb-808e-419c-87ff-5126eed85e73","displayText":"Raulín Rosendo","occurrenceId":"575d4914-ed31-449f-b089-bb2a17808802"}},{"text":" were in it alongside him.","type":"text"}]},{"type":"paragraph","content":[{"text":"He popularised a long list of songs there — among them A Tatico Henríquez, written for ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9b15dfca-0f60-49b3-a139-100a5a329741","displayText":"Tatico Henríquez","occurrenceId":"0a24dfda-110d-4812-aefc-33ed2e870dd1"}},{"text":", along with Barahona, Santo Domingo, Así es la Vida, La Ambulancia, Jardinera and Compadre Pedro Juan. His own following outgrew the group, and he left at the end of the decade.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Niño Mimado","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He began as a soloist in 1981 and the eighties belonged to him. Tabaco y Ron, Celos, Te Amo Demasiado, La Hamaquita, Dominicano Soy, Sonámbulo and Carnaval come from those years, and the affection of the audience gave him the second nickname he still carries, the spoiled child. The first one, El Mayimbe, means the boss in Dominican speech, and it stuck from the seventies onward.","type":"text"}]},{"type":"paragraph","content":[{"text":"Out of sight, still recording","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Quisqueya, No Podrás, Música Latina, Retorno and Me He Enamorado kept him at the front of merengue through the following decade. He also withdrew from public life for a stretch of those years, and the notable thing is that he never stopped recording: some of his best-regarded songs date from exactly that period, and his records stayed at number one in the country while he was out of sight.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mal Acostumbrado","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The album Mal Acostumbrado brought him the Latin Grammy for best merengue or bachata album, and a nomination at the Grammy ceremony held at Madison Square Garden the following year. In that same period he took El Soberano, the highest award of the Dominican critics’ association. He also sang on the Spanish-language version of We Are the World recorded for Haiti.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mi Luz","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He marked forty years in music in 2011 with Mi Luz, a Christian album on which he sang about his own past and what had changed in it. The following year he recorded El Color de tu Mirada as a duet, and its video was nominated for music video of the year.","type":"text"}]},{"type":"paragraph","content":[{"text":"Insensatez","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The album Insensatez won him a second Latin Grammy in 2021, four decades after he began as a soloist. The Dominican Senate formally recognised fifty years of his career in May 2022.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'fernando-villalona'), 3)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Ramón Fernando Villalona Évora, conocido como Fernando Villalona y llamado El Mayimbe, es un cantante dominicano. Es un tenor lírico que se dio a conocer en la balada y el bolero antes de convertirse en una de las voces que definen el merengue, y ha grabado más de veinte álbumes a lo largo de cinco décadas.","type":"text"}]},{"type":"paragraph","content":[{"text":"Loma de Cabrera","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Se crió en Loma de Cabrera, en la provincia noroccidental de Dajabón, cerca de la frontera con Haití, junto a nueve hermanos. Allí cursó sus estudios iniciales y empezó a presentarse bajo la tutela de un maestro del pueblo, actuando desde niño en veladas escolares e infantiles.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Festival de la Voz","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"A los quince años representó a su pueblo en el primer Festival de la Voz, organizado por ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"1eb8b62f-0389-4ae8-b1a4-73a7b5acb772"}},{"text":" y transmitido por el canal estatal en junio de 1971. Cantó Lágrimas para un Recuerdo y quedó en quinto lugar. No ganar resultó más importante que ganar: la ronda final provocó la mayor protesta pública que se había visto en un concurso de talentos dominicano, y el país aprendió su nombre.","type":"text"}]},{"type":"paragraph","content":[{"text":"Solano lo descubrió por esos mismos días y le grabó una primera producción, pero Villalona regresó por un tiempo a Loma de Cabrera antes de que la carrera arrancara de verdad.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los Hijos del Rey","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"La orquesta Los Hijos del Rey, creada a mediados de los setenta por ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"6f0d4426-c64b-48d1-a91e-737471558391"}},{"text":", es donde vuelve a la música y donde debuta profesionalmente, en un cartel junto a la Fania All Stars. La banda fue escuela de toda una generación: allí estuvieron con él ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc4db4c6-c96f-4eb7-af95-ac637785c5bf","displayText":"Bonny Cepeda","occurrenceId":"f5d35d41-a8d3-47c4-ab9b-1fb9c840593b"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"faf3e4cb-808e-419c-87ff-5126eed85e73","displayText":"Raulín Rosendo","occurrenceId":"75788609-b58e-42d8-8281-3c0422deef69"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"Popularizó allí una lista larga de temas, entre ellos A Tatico Henríquez, escrito para ","type":"text"},{"type":"artistReference","attrs":{"artistId":"9b15dfca-0f60-49b3-a139-100a5a329741","displayText":"Tatico Henríquez","occurrenceId":"c3b3f96d-e590-4acc-93f3-8a6e2d7a8d22"}},{"text":", además de Barahona, Santo Domingo, Así es la Vida, La Ambulancia, Jardinera y Compadre Pedro Juan. Su público propio terminó siendo más grande que el grupo, y salió de él al final de la década.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Niño Mimado","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Empezó como solista en 1981 y los ochenta fueron suyos. Tabaco y Ron, Celos, Te Amo Demasiado, La Hamaquita, Dominicano Soy, Sonámbulo y Carnaval son de esos años, y el cariño del público le puso el segundo apodo que todavía carga. El primero, El Mayimbe, significa el jefe en el habla dominicana, y se le quedó desde los setenta.","type":"text"}]},{"type":"paragraph","content":[{"text":"Fuera de la vista, grabando","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Quisqueya, No Podrás, Música Latina, Retorno y Me He Enamorado lo mantuvieron al frente del merengue durante la década siguiente. También se retiró de la vida pública durante una parte de esos años, y lo notable es que no dejó de grabar: algunas de sus canciones más valoradas son justamente de ese período, y sus discos seguían en el número uno del país mientras él estaba fuera de la vista.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mal Acostumbrado","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El álbum Mal Acostumbrado le dio el Latin Grammy al mejor álbum de merengue o bachata, y una nominación en la ceremonia del Grammy celebrada en el Madison Square Garden al año siguiente. En esa misma etapa se llevó El Soberano, el galardón mayor de la crónica de arte dominicana. Cantó además en la versión en español de We Are the World grabada para Haití.","type":"text"}]},{"type":"paragraph","content":[{"text":"Mi Luz","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Cumplió cuarenta años en la música en 2011 con Mi Luz, un álbum cristiano en el que cantó sobre su propio pasado y sobre lo que había cambiado en él. Al año siguiente grabó a dúo El Color de tu Mirada, cuyo video fue nominado a video musical del año.","type":"text"}]},{"type":"paragraph","content":[{"text":"Insensatez","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El álbum Insensatez le dio un segundo Latin Grammy en 2021, cuatro décadas después de haber empezado como solista. El Senado de la República reconoció formalmente sus cincuenta años de carrera en mayo de 2022.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'fernando-villalona'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona') AND locale = 'en'), '0a24dfda-110d-4812-aefc-33ed2e870dd1', 'artist', '9b15dfca-0f60-49b3-a139-100a5a329741');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona') AND locale = 'en'), '1bcfd0cd-07b5-4921-8fc0-d88830dfcbf1', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona') AND locale = 'en'), '575d4914-ed31-449f-b089-bb2a17808802', 'artist', 'faf3e4cb-808e-419c-87ff-5126eed85e73');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona') AND locale = 'en'), '948160cd-b763-4153-b9de-b715f1b5de60', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona') AND locale = 'en'), '958eefb2-22e6-46a2-85a4-344577411af0', 'artist', 'bc4db4c6-c96f-4eb7-af95-ac637785c5bf');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona') AND locale = 'es'), '1eb8b62f-0389-4ae8-b1a4-73a7b5acb772', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona') AND locale = 'es'), '6f0d4426-c64b-48d1-a91e-737471558391', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona') AND locale = 'es'), '75788609-b58e-42d8-8281-3c0422deef69', 'artist', 'faf3e4cb-808e-419c-87ff-5126eed85e73');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona') AND locale = 'es'), 'c3b3f96d-e590-4acc-93f3-8a6e2d7a8d22', 'artist', '9b15dfca-0f60-49b3-a139-100a5a329741');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'fernando-villalona') AND locale = 'es'), 'f5d35d41-a8d3-47c4-ab9b-1fb9c840593b', 'artist', 'bc4db4c6-c96f-4eb7-af95-ac637785c5bf');

COMMIT;
