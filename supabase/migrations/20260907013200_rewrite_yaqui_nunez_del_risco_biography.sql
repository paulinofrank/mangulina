BEGIN;

-- Rewrite the catalogue entry for Yaqui Núñez del Risco.
--
-- Yaqui Núñez del Risco. Sexta de las dieciséis fichas publicadas que estaban
-- EN BLANCO, y un caso raro: la base lo tiene como compositor de merengue, que
-- es correcto, pero fuera del catálogo se le recuerda sobre todo como locutor y
-- presentador. Las dos cosas son la misma carrera y así se cuenta.
--
-- LO QUE YA TENÍA LA FILA SE CONFIRMA Y NO SE TOCA: Pedro Antonio Núñez del
-- Risco, 4 de mayo de 1939 en Santiago, muerte el 8 de septiembre de 2014,
-- ended en true, primary_role compositor, primary_genre merengue.
--
-- WIKIPEDIA DA EL NOMBRE COMPLETO COMO "Pedro Antonio Yaqui Núñez del Risco",
-- con Yaqui dentro del nombre de pila. La fila guarda first_name Pedro y
-- middle_name Antonio. NO SE TOCA: no sé si "Yaqui" es nombre de registro o
-- apodo incorporado, y cambiar un nombre legal por una lectura de encabezado de
-- Wikipedia es justo el tipo de error que no se nota hasta que alguien lo cita.
--
-- CASI TODO LO QUE TRAE WIKIPEDIA ES VIDA PRIVADA Y NO ENTRA: cuatro
-- matrimonios, siete hijos, el reparto de su herencia, el derrame cerebral de
-- diciembre de 2008, los ingresos hospitalarios y el tratamiento en Miami. Su
-- salida de los medios a finales de 2008 SÍ entra como hecho profesional, pero
-- sin la causa.
--
-- TAMPOCO ENTRAN LOS PARENTESCOS ARTÍSTICOS que Wikipedia detalla -- primo de
-- René del Risco, tío de Pavel Núñez, hermano del mánager de Milly Quezada --
-- aunque sean verificables y tentadores. Son relaciones de familia, y la regla
-- de vida privada no hace excepción porque el pariente sea famoso.
--
-- SE DEJA FUERA LA POLÍTICA ELECTORAL: en 1994 fue candidato a senador a
-- petición de Joaquín Balaguer, y fue asesor del Senado y director del Condex.
-- No aporta nada musical y este es un catálogo de música. SÍ ENTRA, en cambio,
-- su gestión del aeropuerto de Las Américas desde 1990, porque lo que hizo allí
-- fue convertirlo en sala de exposición con el Museo de Arte Moderno y el
-- Instituto del Folklore. Eso es trabajo cultural.
--
-- CONFLICTO RESUELTO SOBRE EL RECONOCIMIENTO DE LA UASD. El cuerpo de Wikipedia
-- dice "Profesor Honorario" y el título de su propia referencia dice "Doctorado
-- Honoris Causa". Fui a la fuente: Hoy, 6 de junio de 2013, dice que la UASD lo
-- invistió como PROFESOR HONORIS CAUSA en la Biblioteca Pedro Mir. Eso es lo
-- que se escribe. No es doctorado.
--
-- DIEZ ENLACES, TODOS INTÉRPRETES DE CANCIONES SUYAS O SOCIOS DE TELEVISIÓN
-- documentados por Wikipedia: rafael-solano (con quien hizo "Letra y Música"),
-- fernando-villalona, anthony-rios, sonia-silvestre, johnny-ventura,
-- tono-rosario, milly-quezada, dioni-fernandez-y-el-equipo, anibal-bravo y
-- wilfrido-vargas.
--
-- A SONIA SILVESTRE SE LA NOMBRA SOLO COMO INTÉRPRETE de "Hoy me siento así".
-- Estuvo casada con él, y eso no se menciona: el dato que le importa al
-- catálogo es quién grabó la canción.
--
-- NO ESTÁN EN LA BASE y quedan para la lista: Cecilia García, que grabó "Hola
-- nuevo día", y Félix D'Oleo, que grabó "Hoy somos una canción". Tampoco está
-- Freddy Beras-Goico, que es su socio televisivo de toda la vida y una omisión
-- grande del catálogo.
--
-- OCCUPATIONS sin repetir primary_role: lyricist, television_host, radio_host,
-- producer y writer. Los cinco ya existen en el vocabulario. NO se inventa
-- "publicista" ni "locutor", que no están en el diccionario; radio_host cubre
-- lo segundo.
--
-- GENRES LLEVA BALLADS: su catálogo de autor no es solo merengue -- lo de Sonia
-- Silvestre y Anthony Ríos es balada. No repite el primario.
--
-- SIN REDES: murió en 2014 y no se le inventa ninguna.
--
-- LOS PREMIOS VAN EN MIGRACIÓN APARTE. Son cinco y hay que crear tres entidades
-- nuevas, lo que es decisión de catálogo y no debe ir escondido en una ficha.
--
-- FUENTES: Wikipedia en español, muy referenciada. Hoy, 6 de junio de 2013,
-- para el título de la UASD.
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
       name = 'Yaqui Núñez del Risco',
       sort_name = 'Núñez del Risco, Pedro Antonio',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'composer',
       primary_genre = 'merengue',
       date_of_birth = '1939-05-04',
       birth_year = 1939,
       date_of_death = '2014-09-08',
       birth_place = 'Santiago de los Caballeros',
       province = 'Santiago',
       first_name = 'Pedro',
       middle_name = 'Antonio',
       last_name = 'Núñez',
       second_last_name = 'del Risco',
       stage_name = 'Yaqui Núñez del Risco',
       aliases = ARRAY[]::text[],
       occupations = '["lyricist","television_host","radio_host","producer","writer"]'::jsonb,
       instruments = ARRAY[]::text[],
       genres = ARRAY['ballads']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = NULL,
       instagram = NULL,
       disambiguation = 'Broadcaster, television producer and lyricist; wrote songs recorded across Dominican merengue and ballad',
       bio_en = 'Pedro Antonio Núñez del Risco, known as Yaqui Núñez del Risco, was a Dominican broadcaster, television producer and lyricist. He wrote songs recorded by a large part of the country’s merengue and ballad establishment, and as a presenter he was one of the platforms through which that music reached a national audience.

**Santiago and San Francisco**

He was born in Santiago de los Caballeros in 1939 and grew up in San Francisco de Macorís. At fifteen he was already working in the press there, as a sports writer for La Nación and entertainment editor for El Sol, and standing in as an announcer at local radio stations. He later studied law at the Universidad Autónoma de Santo Domingo, took courses in public relations and journalism in Caracas and in Germany, and taught advertising at the Pontificia Universidad Católica Madre y Maestra.

**Letra y Música**

His television career began with Letra y Música, made with the composer Rafael Solano for the state broadcaster. He then worked with Freddy Beras-Goico on Nosotros a las Ocho, and the two joined El Show del Mediodía, the midday programme where he became a fixture of Dominican television.

He went on to produce and present a long list of his own programmes, among them Otra Vez con Yaqui, De Noche, La Alegría del País and Comida y Comidilla, and returned in 2004 with En Resumidas Cuentas. He also wrote columns for Hoy, El Nacional and Listín Diario, and produced radio, including Aquí Yaqui.

**The lyricist**

His work as an author runs across the Dominican songbook of the seventies and eighties. Fernando Villalona recorded Compañera, Paloma and La Reina; Anthony Ríos recorded Fuera de Tiempo; Sonia Silvestre recorded Hoy Me Siento Así; and Cecilia García recorded Hola Nuevo Día.

Others followed. Johnny Ventura recorded Mamá Tingó, named for the peasant leader; Toño Rosario recorded Yo Soy Toño; Milly Quezada recorded Cuando No Estás and La Mujer de Hoy; and Félix D’Oleo recorded Hoy Somos Una Canción. His songs were also taken up by Dioni Fernández y El Equipo, Aníbal Bravo and Wilfrido Vargas.

**The airport as a gallery**

In December 1990 he was appointed to run Las Américas International Airport. He reorganised it and turned the building into an exhibition space, working with the Museo de Arte Moderno and the folklore institute to bring visual art and folk culture into the terminal.

**Recognition**

He received a Casandra award for merit in 2004 and was recognised in New Jersey the following year. The Dominican government declared him a national figure of broadcasting in 2011, and the Universidad Autónoma de Santo Domingo made him an honorary professor in 2013. He left broadcasting at the end of 2008 and died in Santo Domingo six years later.',
       bio_es = 'Pedro Antonio Núñez del Risco, conocido como Yaqui Núñez del Risco, fue un locutor, productor de televisión y letrista dominicano. Escribió canciones grabadas por buena parte del merengue y la balada del país, y como presentador fue una de las plataformas por las que esa música llegó al público nacional.

**Santiago y San Francisco**

Nació en Santiago de los Caballeros en 1939 y se crió en San Francisco de Macorís. A los quince años ya trabajaba en la prensa de esa ciudad, como cronista deportivo de La Nación y editor de espectáculos de El Sol, y sustituía a los locutores en las emisoras locales. Después estudió derecho en la Universidad Autónoma de Santo Domingo, tomó cursos de relaciones públicas y periodismo en Caracas y en Alemania, y dio clases de publicidad en la Pontificia Universidad Católica Madre y Maestra.

**Letra y Música**

Su carrera en televisión empezó con Letra y Música, que hizo junto al compositor Rafael Solano para la televisión estatal. Después trabajó con Freddy Beras-Goico en Nosotros a las Ocho, y los dos entraron a El Show del Mediodía, el programa meridiano donde se consolidó como figura de la televisión dominicana.

Luego produjo y presentó una larga lista de programas propios, entre ellos Otra Vez con Yaqui, De Noche, La Alegría del País y Comida y Comidilla, y volvió en 2004 con En Resumidas Cuentas. Escribió además columnas en Hoy, El Nacional y Listín Diario, y produjo radio, incluido Aquí Yaqui.

**El letrista**

Su obra como autor recorre el cancionero dominicano de los setenta y los ochenta. Fernando Villalona grabó Compañera, Paloma y La Reina; Anthony Ríos grabó Fuera de Tiempo; Sonia Silvestre grabó Hoy Me Siento Así; y Cecilia García grabó Hola Nuevo Día.

Vinieron otros. Johnny Ventura grabó Mamá Tingó, por la líder campesina; Toño Rosario grabó Yo Soy Toño; Milly Quezada grabó Cuando No Estás y La Mujer de Hoy; y Félix D’Oleo grabó Hoy Somos Una Canción. Sus canciones también las tomaron Dioni Fernández y El Equipo, Aníbal Bravo y Wilfrido Vargas.

**El aeropuerto como sala**

En diciembre de 1990 fue designado al frente del Aeropuerto Internacional de las Américas. Lo reorganizó y convirtió el edificio en sala de exposición, en alianza con el Museo de Arte Moderno y el instituto del folklore, para llevar artes plásticas y cultura popular a la terminal.

**Reconocimientos**

Recibió un Casandra al Mérito en 2004 y al año siguiente fue reconocido en Nueva Jersey. El gobierno dominicano lo declaró Gloria Nacional de la Comunicación en 2011, y la Universidad Autónoma de Santo Domingo lo invistió como profesor honoris causa en 2013. Salió de los medios a finales de 2008 y murió en Santo Domingo seis años después.',
       updated_at = now()
 WHERE slug = 'yaqui-nunez-del-risco';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Pedro Antonio Núñez del Risco, known as Yaqui Núñez del Risco, was a Dominican broadcaster, television producer and lyricist. He wrote songs recorded by a large part of the country’s merengue and ballad establishment, and as a presenter he was one of the platforms through which that music reached a national audience.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santiago and San Francisco","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Santiago de los Caballeros in 1939 and grew up in San Francisco de Macorís. At fifteen he was already working in the press there, as a sports writer for La Nación and entertainment editor for El Sol, and standing in as an announcer at local radio stations. He later studied law at the Universidad Autónoma de Santo Domingo, took courses in public relations and journalism in Caracas and in Germany, and taught advertising at the Pontificia Universidad Católica Madre y Maestra.","type":"text"}]},{"type":"paragraph","content":[{"text":"Letra y Música","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His television career began with Letra y Música, made with the composer ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"d9c1cc83-05b5-4a5d-b0dc-281ebb1e7715"}},{"text":" for the state broadcaster. He then worked with Freddy Beras-Goico on Nosotros a las Ocho, and the two joined El Show del Mediodía, the midday programme where he became a fixture of Dominican television.","type":"text"}]},{"type":"paragraph","content":[{"text":"He went on to produce and present a long list of his own programmes, among them Otra Vez con Yaqui, De Noche, La Alegría del País and Comida y Comidilla, and returned in 2004 with En Resumidas Cuentas. He also wrote columns for Hoy, El Nacional and Listín Diario, and produced radio, including Aquí Yaqui.","type":"text"}]},{"type":"paragraph","content":[{"text":"The lyricist","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His work as an author runs across the Dominican songbook of the seventies and eighties. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"480cbf19-ee44-4566-a11c-1b55fe9fac75"}},{"text":" recorded Compañera, Paloma and La Reina; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"081c1484-bf1c-4b11-ba01-d68446b7b111","displayText":"Anthony Ríos","occurrenceId":"75956a1c-c9b2-4cd3-92e5-a32cfaf6909a"}},{"text":" recorded Fuera de Tiempo; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre","occurrenceId":"bc714627-d918-41db-90c7-b59c988e96f1"}},{"text":" recorded Hoy Me Siento Así; and Cecilia García recorded Hola Nuevo Día.","type":"text"}]},{"type":"paragraph","content":[{"text":"Others followed. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"d8ea3fd6-c800-411d-929f-b99e59c38e15"}},{"text":" recorded Mamá Tingó, named for the peasant leader; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario","occurrenceId":"bc7c326a-c238-40db-b619-4537a32756a4"}},{"text":" recorded Yo Soy Toño; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada","occurrenceId":"e37f44ba-6da9-45f3-965b-0aeffdec2d35"}},{"text":" recorded Cuando No Estás and La Mujer de Hoy; and Félix D’Oleo recorded Hoy Somos Una Canción. His songs were also taken up by ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fb2c703f-5362-47dd-ada0-7c6d5e106f3b","displayText":"Dioni Fernández y El Equipo","occurrenceId":"f26a7623-82f2-435a-b19c-ff32bfa1dc29"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f050869b-f4c0-4281-b883-bce0120ad9b2","displayText":"Aníbal Bravo","occurrenceId":"041c0539-d4d9-4e00-b1db-006d59c70e79"}},{"text":" and ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"89d2487c-9060-49e7-ac86-895d2c6f33a5"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"The airport as a gallery","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"In December 1990 he was appointed to run Las Américas International Airport. He reorganised it and turned the building into an exhibition space, working with the Museo de Arte Moderno and the folklore institute to bring visual art and folk culture into the terminal.","type":"text"}]},{"type":"paragraph","content":[{"text":"Recognition","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He received a Casandra award for merit in 2004 and was recognised in New Jersey the following year. The Dominican government declared him a national figure of broadcasting in 2011, and the Universidad Autónoma de Santo Domingo made him an honorary professor in 2013. He left broadcasting at the end of 2008 and died in Santo Domingo six years later.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco'), 1)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Pedro Antonio Núñez del Risco, conocido como Yaqui Núñez del Risco, fue un locutor, productor de televisión y letrista dominicano. Escribió canciones grabadas por buena parte del merengue y la balada del país, y como presentador fue una de las plataformas por las que esa música llegó al público nacional.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santiago y San Francisco","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santiago de los Caballeros en 1939 y se crió en San Francisco de Macorís. A los quince años ya trabajaba en la prensa de esa ciudad, como cronista deportivo de La Nación y editor de espectáculos de El Sol, y sustituía a los locutores en las emisoras locales. Después estudió derecho en la Universidad Autónoma de Santo Domingo, tomó cursos de relaciones públicas y periodismo en Caracas y en Alemania, y dio clases de publicidad en la Pontificia Universidad Católica Madre y Maestra.","type":"text"}]},{"type":"paragraph","content":[{"text":"Letra y Música","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su carrera en televisión empezó con Letra y Música, que hizo junto al compositor ","type":"text"},{"type":"artistReference","attrs":{"artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano","occurrenceId":"ed26ca58-d5dc-4488-b2ca-f0194ec184da"}},{"text":" para la televisión estatal. Después trabajó con Freddy Beras-Goico en Nosotros a las Ocho, y los dos entraron a El Show del Mediodía, el programa meridiano donde se consolidó como figura de la televisión dominicana.","type":"text"}]},{"type":"paragraph","content":[{"text":"Luego produjo y presentó una larga lista de programas propios, entre ellos Otra Vez con Yaqui, De Noche, La Alegría del País y Comida y Comidilla, y volvió en 2004 con En Resumidas Cuentas. Escribió además columnas en Hoy, El Nacional y Listín Diario, y produjo radio, incluido Aquí Yaqui.","type":"text"}]},{"type":"paragraph","content":[{"text":"El letrista","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su obra como autor recorre el cancionero dominicano de los setenta y los ochenta. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona","occurrenceId":"53268f79-232b-4d5b-bf7d-d2c7b779140f"}},{"text":" grabó Compañera, Paloma y La Reina; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"081c1484-bf1c-4b11-ba01-d68446b7b111","displayText":"Anthony Ríos","occurrenceId":"9389c05f-20ff-4460-8749-9cd40f425a2e"}},{"text":" grabó Fuera de Tiempo; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre","occurrenceId":"391b2f0c-d929-4ad6-9571-c16ae8d3953a"}},{"text":" grabó Hoy Me Siento Así; y Cecilia García grabó Hola Nuevo Día.","type":"text"}]},{"type":"paragraph","content":[{"text":"Vinieron otros. ","type":"text"},{"type":"artistReference","attrs":{"artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura","occurrenceId":"4d443ed4-d62e-4f48-a517-a91f225227d1"}},{"text":" grabó Mamá Tingó, por la líder campesina; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario","occurrenceId":"951aee02-9a7c-4675-9dcd-f6b1d53bae5a"}},{"text":" grabó Yo Soy Toño; ","type":"text"},{"type":"artistReference","attrs":{"artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada","occurrenceId":"7de4f763-a0a6-44c7-af28-8e5383220f8b"}},{"text":" grabó Cuando No Estás y La Mujer de Hoy; y Félix D’Oleo grabó Hoy Somos Una Canción. Sus canciones también las tomaron ","type":"text"},{"type":"artistReference","attrs":{"artistId":"fb2c703f-5362-47dd-ada0-7c6d5e106f3b","displayText":"Dioni Fernández y El Equipo","occurrenceId":"ce9753d9-9a6c-46d1-98d2-3429f2060e64"}},{"text":", ","type":"text"},{"type":"artistReference","attrs":{"artistId":"f050869b-f4c0-4281-b883-bce0120ad9b2","displayText":"Aníbal Bravo","occurrenceId":"18a7432d-5d2c-4e71-8aaa-48eba54676b0"}},{"text":" y ","type":"text"},{"type":"artistReference","attrs":{"artistId":"2bc36959-dcce-4e10-9ecf-2cd418eaa489","displayText":"Wilfrido Vargas","occurrenceId":"de73f3cd-f255-4411-b26e-a0956464770a"}},{"text":".","type":"text"}]},{"type":"paragraph","content":[{"text":"El aeropuerto como sala","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"En diciembre de 1990 fue designado al frente del Aeropuerto Internacional de las Américas. Lo reorganizó y convirtió el edificio en sala de exposición, en alianza con el Museo de Arte Moderno y el instituto del folklore, para llevar artes plásticas y cultura popular a la terminal.","type":"text"}]},{"type":"paragraph","content":[{"text":"Reconocimientos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Recibió un Casandra al Mérito en 2004 y al año siguiente fue reconocido en Nueva Jersey. El gobierno dominicano lo declaró Gloria Nacional de la Comunicación en 2011, y la Universidad Autónoma de Santo Domingo lo invistió como profesor honoris causa en 2013. Salió de los medios a finales de 2008 y murió en Santo Domingo seis años después.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'en'), '041c0539-d4d9-4e00-b1db-006d59c70e79', 'artist', 'f050869b-f4c0-4281-b883-bce0120ad9b2');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'en'), '480cbf19-ee44-4566-a11c-1b55fe9fac75', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'en'), '75956a1c-c9b2-4cd3-92e5-a32cfaf6909a', 'artist', '081c1484-bf1c-4b11-ba01-d68446b7b111');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'en'), '89d2487c-9060-49e7-ac86-895d2c6f33a5', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'en'), 'bc714627-d918-41db-90c7-b59c988e96f1', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'en'), 'bc7c326a-c238-40db-b619-4537a32756a4', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'en'), 'd8ea3fd6-c800-411d-929f-b99e59c38e15', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'en'), 'd9c1cc83-05b5-4a5d-b0dc-281ebb1e7715', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'en'), 'e37f44ba-6da9-45f3-965b-0aeffdec2d35', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'en'), 'f26a7623-82f2-435a-b19c-ff32bfa1dc29', 'artist', 'fb2c703f-5362-47dd-ada0-7c6d5e106f3b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'es'), '18a7432d-5d2c-4e71-8aaa-48eba54676b0', 'artist', 'f050869b-f4c0-4281-b883-bce0120ad9b2');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'es'), '391b2f0c-d929-4ad6-9571-c16ae8d3953a', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'es'), '4d443ed4-d62e-4f48-a517-a91f225227d1', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'es'), '53268f79-232b-4d5b-bf7d-d2c7b779140f', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'es'), '7de4f763-a0a6-44c7-af28-8e5383220f8b', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'es'), '9389c05f-20ff-4460-8749-9cd40f425a2e', 'artist', '081c1484-bf1c-4b11-ba01-d68446b7b111');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'es'), '951aee02-9a7c-4675-9dcd-f6b1d53bae5a', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'es'), 'ce9753d9-9a6c-46d1-98d2-3429f2060e64', 'artist', 'fb2c703f-5362-47dd-ada0-7c6d5e106f3b');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'es'), 'de73f3cd-f255-4411-b26e-a0956464770a', 'artist', '2bc36959-dcce-4e10-9ecf-2cd418eaa489');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'yaqui-nunez-del-risco') AND locale = 'es'), 'ed26ca58-d5dc-4488-b2ca-f0194ec184da', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337');

COMMIT;
