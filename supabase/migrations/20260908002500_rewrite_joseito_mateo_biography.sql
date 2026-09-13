BEGIN;

-- Rewrite the catalogue entry for Joseíto Mateo.
--
-- Joseíto Mateo. DECIMOSEXTA de las dieciocho. 1.267 caracteres para setenta
-- años de carrera, sin una canción, sin un disco, sin un premio y sin una
-- fecha. Del hombre al que llaman El Rey del Merengue.
--
-- UN ERROR DE EDAD QUE ESTABA PUBLICADO: "passed away in 2018 at the age of
-- NINETY-SEVEN". Nació el 6 de abril de 1920. Murió en 2018 después de su
-- cumpleaños, o sea con NOVENTA Y OCHO, que es lo que dice Wikipedia y lo que
-- dan las fechas de la propia fila. Se corrige.
--
-- CONFLICTO DE FECHA QUE NO RESUELVO. La fila guarda el 1 DE JUNIO de 2018 y
-- Wikipedia dice el 31 DE MAYO. Un día de diferencia, que puede ser hora de
-- deceso contra hora de anuncio. NO TOCO LA FILA y el texto dice solo "2018".
-- Queda para el editor.
--
-- LA HISTORIA MÁS GRANDE DE SU VIDA NO LA ESCRIBO, Y ME CUESTA. Wikipedia
-- cuenta que la SEECO lo requirió para grabar en La Habana con la Sonora
-- Matancera, que bajo Trujillo hacía falta permiso de salida y a él se lo
-- negaron, y que su lugar lo ocupó ALBERTO BELTRÁN, que desde entonces fue "El
-- Negrito del Batey" en lugar de su verdadero inspirador.
--
-- Es exactamente la clase de episodio que este catálogo existe para registrar:
-- el Estado interviniendo sobre el trabajo de un músico y cambiándole la vida.
-- PERO WIKIPEDIA LA MARCA [CITA REQUERIDA] Y NO ENCONTRÉ NINGUNA OTRA FUENTE.
-- Escribirla sería regalarle a la ficha su mejor párrafo a cambio de su
-- credibilidad. Queda reportada para buscarle fuente. Si aparece, se escribe.
--
-- Por la misma razón NO SE ESCRIBE que fue el primer cantante en tocar con El
-- Gran Combo de Puerto Rico: también está marcada sin cita. SÍ SE ESCRIBE la
-- gira de 1962 a Panamá y el disco "El Gran Combo con Joseíto Mateo", que van
-- con su propio testimonio citado y que además son comprobables como disco.
--
-- LO QUE FALTABA Y SÍ ENTRA:
--
--   LAS CANCIONES: "Madame Chuchí", "Dame la Visa", "La Cotorra de Rosa", "La
--   Patrulla", "Merenguero Hasta la Tambora", "Juanita Morel".
--
--   LOS DISCOS CON AÑO: King of Merengue! (1950), Merenchanga Pa' la Pachanga
--   (1956), la tanda de 1960, El Verdadero Rey del Merengue (1964), Caña Brava
--   Vol. 3 y Merengues Vol. 2 (1966), Salsa Explosiva (1970).
--
--   LOS DOS PREMIOS MAYORES, que no estaban ni en la prosa ni en la tabla: EL
--   GRAN SOBERANO de 2004, máximo galardón de Acroarte, y el PREMIO A LA
--   EXCELENCIA MUSICAL del Latin Grammy, el 11 de noviembre de 2010.
--
--   QUE BAILABA. Las fuentes insisten en que su aporte no fue solo vocal sino
--   escénico, por su manera de bailar cantando. Entra 'dancer' en occupations.
--
-- SU REGRESO DE PUERTO RICO ENTRA, con cuidado y en sus propias palabras
-- parafraseadas: volvió a Santo Domingo a limpiar su nombre porque después de
-- 1961 se perseguía a quienes habían trabajado bajo Trujillo y de él se decía
-- que era espía. Es persecución política que le costó un puesto en una orquesta
-- mayor, o sea historia de su carrera. Mismo criterio que con Ramón Leonardo.
--
-- LO QUE SE DEJA FUERA: la causa de muerte, que es diagnóstico médico, y el
-- cementerio.
--
-- aliases traía 'Jose Tamarez Mateo', el nombre legal SIN ACENTOS. NOVENO caso
-- del mismo defecto en esta corrida. Sale; queda "El Rey del Merengue".
--
-- sort_name decía 'Mateo, Joseíto', con el nombre artístico. Pasa a 'Tamárez
-- Mateo, José'.
--
-- DOS ENLACES: luis-kalaff, con quien grabó un disco de merengues en 1979 y de
-- quien grabó "Cuando Yo Me Muera" -- enlace recíproco, porque acabo de
-- escribirlo también en la ficha de Kalaff hace un rato -- y cheche-abreu, que
-- habló en su velatorio y cuya frase resume lo que significó para los
-- merengueros que vinieron detrás.
--
-- LOS PREMIOS VAN EN MIGRACIÓN APARTE. Tenía CERO, y las dos categorías que
-- hacen falta YA EXISTEN: "Premio a la Excelencia Musical" bajo Latin Grammy y
-- "El Gran Soberano" bajo Premios Soberano.
--
-- FUENTES: Wikipedia en español, con su discografía larga y sus dos referencias
-- de premios. Se descartaron a propósito los tres pasajes marcados [cita
-- requerida].
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
       name = 'Joseíto Mateo',
       sort_name = 'Tamárez Mateo, José',
       type = 'solo_artist',
       status = 'published',
       gender = 'male',
       ended = TRUE,
       primary_role = 'singer',
       primary_genre = 'merengue',
       date_of_birth = '1920-04-06',
       birth_year = 1920,
       date_of_death = '2018-06-01',
       birth_place = 'Santo Domingo',
       province = 'Distrito Nacional',
       first_name = 'José',
       middle_name = NULL,
       last_name = 'Tamárez',
       second_last_name = 'Mateo',
       stage_name = 'Joseíto Mateo',
       aliases = ARRAY['El Rey del Merengue']::text[],
       occupations = '["bandleader","composer","dancer"]'::jsonb,
       instruments = ARRAY['voice']::text[],
       genres = ARRAY['bolero']::text[],
       artist_tags = ARRAY['secular', 'legend']::text[],
       website = NULL,
       youtube = NULL,
       facebook = 'joseitomateoelreydelmerengue',
       instagram = NULL,
       disambiguation = 'Singer called the King of Merengue; worked from the nineteen-thirties until his death',
       bio_en = 'José Tamárez Mateo, known as Joseíto Mateo and called the King of Merengue, was a Dominican singer. He began performing in the nineteen-thirties and was still working at the end of his life, which gave him a career of more than seventy years and made him the longest continuous presence in Dominican popular music.

**Santo Domingo and Havana**

He was born in Santo Domingo in 1920 and started singing as a young man, building an audience through the thirties and forties. On one of his trips to Cuba he stayed on to sing at CMQ, then the largest station on the island, alongside Celia Cruz and the Sonora Matancera, at the point when Cuban radio was setting the terms for the whole Caribbean.

**El Gran Combo**

After the killing of Trujillo in 1961 he went to try his luck in Puerto Rico, and in 1962 he sang with El Gran Combo on the group’s first tour to Panama, promoting the album El Gran Combo con Joseíto Mateo. He adapted to their repertoire, singing plena, bomba, guaracha and bolero, and it was on that trip that he met the young Pellín Rodríguez and Andy Montañez, who took his place in the band.

He gave a plain reason for leaving. He had to go back to Santo Domingo to clear his name: in the years after the dictatorship anyone who had worked under it was being pursued, and he was being called a spy at home while he was singing abroad.

**The songs**

His catalogue is enormous and began early. King of Merengue! appeared in 1950 and Merenchanga Pa’ la Pachanga in 1956, and through the sixties he released album after album — El Verdadero Rey del Merengue in 1964, Caña Brava Vol. 3 and Merengues Vol. 2 in 1966, Salsa Explosiva in 1970.

The songs that stayed are Madame Chuchí, Dame la Visa, La Cotorra de Rosa, La Patrulla, Juanita Morel and Merenguero Hasta la Tambora. In 1979 he made an album of merengues with Luis Kalaff, whose Cuando Yo Me Muera he had also recorded.

**The dancing**

What separated him was not only the voice. He sang while dancing, and the way he moved on stage became part of what merengue looked like as well as what it sounded like, at a moment when the genre was moving from country ensembles into ballrooms and television studios.

**The honours**

Acroarte gave him the Gran Soberano, its highest award, in 2004, and on 11 November 2010 the Latin Recording Academy presented him with its Musical Excellence Award for his contribution to Latin music.

He died in 2018, at ninety-eight. At his wake Cheche Abreu said that Joseíto had been the greatest because everything the rest of them did was copied from him, and that he would never really be dead for the country.',
       bio_es = 'José Tamárez Mateo, conocido como Joseíto Mateo y llamado El Rey del Merengue, fue un cantante dominicano. Empezó a presentarse en los años treinta y seguía trabajando al final de su vida, lo que le dio una carrera de más de setenta años y lo convirtió en la presencia continua más larga de la música popular dominicana.

**Santo Domingo y La Habana**

Nació en Santo Domingo en 1920 y empezó a cantar de joven, ganando público a lo largo de los treinta y los cuarenta. En uno de sus viajes a Cuba se quedó a cantar en la CMQ, entonces la emisora más grande de la isla, junto a Celia Cruz y la Sonora Matancera, justo cuando la radio cubana fijaba las reglas para todo el Caribe.

**El Gran Combo**

Tras el ajusticiamiento de Trujillo en 1961 se fue a probar suerte a Puerto Rico, y en 1962 cantó con El Gran Combo en la primera gira del grupo a Panamá, promocionando el disco El Gran Combo con Joseíto Mateo. Se adaptó a su repertorio, cantando plena, bomba, guaracha y bolero, y en ese viaje conoció a los jóvenes Pellín Rodríguez y Andy Montañez, que terminaron ocupando su lugar en la orquesta.

La razón de su salida la dio él mismo sin rodeos. Tuvo que volver a Santo Domingo a limpiar su nombre: en los años posteriores a la dictadura se perseguía a quien hubiera trabajado bajo ella, y mientras él cantaba afuera en el país lo llamaban espía.

**Las canciones**

Su catálogo es enorme y empezó temprano. King of Merengue! salió en 1950 y Merenchanga Pa’ la Pachanga en 1956, y a lo largo de los sesenta publicó disco tras disco: El Verdadero Rey del Merengue en 1964, Caña Brava Vol. 3 y Merengues Vol. 2 en 1966, Salsa Explosiva en 1970.

Las canciones que quedaron son Madame Chuchí, Dame la Visa, La Cotorra de Rosa, La Patrulla, Juanita Morel y Merenguero Hasta la Tambora. En 1979 hizo un disco de merengues con Luis Kalaff, de quien además había grabado Cuando Yo Me Muera.

**El baile**

Lo que lo separaba no era solo la voz. Cantaba bailando, y su manera de moverse en tarima pasó a formar parte de cómo se veía el merengue y no solo de cómo sonaba, justo cuando el género salía de los conjuntos de campo hacia los salones de baile y los estudios de televisión.

**Los reconocimientos**

Acroarte le dio el Gran Soberano, su máximo galardón, en 2004, y el 11 de noviembre de 2010 la Academia Latina de la Grabación le entregó el Premio a la Excelencia Musical por su aporte a la música latina.

Murió en 2018, a los noventa y ocho años. En su velatorio Cheche Abreu dijo que Joseíto había sido el más grande porque de él lo copiaron todo los demás, y que para el país no iba a morirse nunca.',
       updated_at = now()
 WHERE slug = 'joseito-mateo';

DELETE FROM editorial_entity_references
 WHERE editorial_document_id IN (
   SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joseito-mateo')
 );

DELETE FROM editorial_documents
 WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joseito-mateo')
   AND locale NOT IN ('en', 'es');

INSERT INTO editorial_documents
  (document_type, locale, schema_version, document, status, owner_artist_id, revision)
VALUES ('artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José Tamárez Mateo, known as Joseíto Mateo and called the King of Merengue, was a Dominican singer. He began performing in the nineteen-thirties and was still working at the end of his life, which gave him a career of more than seventy years and made him the longest continuous presence in Dominican popular music.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santo Domingo and Havana","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"He was born in Santo Domingo in 1920 and started singing as a young man, building an audience through the thirties and forties. On one of his trips to Cuba he stayed on to sing at CMQ, then the largest station on the island, alongside Celia Cruz and the Sonora Matancera, at the point when Cuban radio was setting the terms for the whole Caribbean.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Gran Combo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"After the killing of Trujillo in 1961 he went to try his luck in Puerto Rico, and in 1962 he sang with El Gran Combo on the group’s first tour to Panama, promoting the album El Gran Combo con Joseíto Mateo. He adapted to their repertoire, singing plena, bomba, guaracha and bolero, and it was on that trip that he met the young Pellín Rodríguez and Andy Montañez, who took his place in the band.","type":"text"}]},{"type":"paragraph","content":[{"text":"He gave a plain reason for leaving. He had to go back to Santo Domingo to clear his name: in the years after the dictatorship anyone who had worked under it was being pursued, and he was being called a spy at home while he was singing abroad.","type":"text"}]},{"type":"paragraph","content":[{"text":"The songs","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"His catalogue is enormous and began early. King of Merengue! appeared in 1950 and Merenchanga Pa’ la Pachanga in 1956, and through the sixties he released album after album — El Verdadero Rey del Merengue in 1964, Caña Brava Vol. 3 and Merengues Vol. 2 in 1966, Salsa Explosiva in 1970.","type":"text"}]},{"type":"paragraph","content":[{"text":"The songs that stayed are Madame Chuchí, Dame la Visa, La Cotorra de Rosa, La Patrulla, Juanita Morel and Merenguero Hasta la Tambora. In 1979 he made an album of merengues with ","type":"text"},{"type":"artistReference","attrs":{"artistId":"dab6636c-21fd-4e34-a0a2-e59e9e147bbd","displayText":"Luis Kalaff","occurrenceId":"a6d3b2a2-2617-4e18-a755-38395aa53c8f"}},{"text":", whose Cuando Yo Me Muera he had also recorded.","type":"text"}]},{"type":"paragraph","content":[{"text":"The dancing","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"What separated him was not only the voice. He sang while dancing, and the way he moved on stage became part of what merengue looked like as well as what it sounded like, at a moment when the genre was moving from country ensembles into ballrooms and television studios.","type":"text"}]},{"type":"paragraph","content":[{"text":"The honours","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Acroarte gave him the Gran Soberano, its highest award, in 2004, and on 11 November 2010 the Latin Recording Academy presented him with its Musical Excellence Award for his contribution to Latin music.","type":"text"}]},{"type":"paragraph","content":[{"text":"He died in 2018, at ninety-eight. At his wake ","type":"text"},{"type":"artistReference","attrs":{"artistId":"73691e65-206a-4c71-9b5f-8689f15b2584","displayText":"Cheche Abreu","occurrenceId":"6a5a5bcc-0754-4f41-b420-258fec9c6a1d"}},{"text":" said that Joseíto had been the greatest because everything the rest of them did was copied from him, and that he would never really be dead for the country.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'joseito-mateo'), 2)
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
VALUES ('artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"José Tamárez Mateo, conocido como Joseíto Mateo y llamado El Rey del Merengue, fue un cantante dominicano. Empezó a presentarse en los años treinta y seguía trabajando al final de su vida, lo que le dio una carrera de más de setenta años y lo convirtió en la presencia continua más larga de la música popular dominicana.","type":"text"}]},{"type":"paragraph","content":[{"text":"Santo Domingo y La Habana","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Nació en Santo Domingo en 1920 y empezó a cantar de joven, ganando público a lo largo de los treinta y los cuarenta. En uno de sus viajes a Cuba se quedó a cantar en la CMQ, entonces la emisora más grande de la isla, junto a Celia Cruz y la Sonora Matancera, justo cuando la radio cubana fijaba las reglas para todo el Caribe.","type":"text"}]},{"type":"paragraph","content":[{"text":"El Gran Combo","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Tras el ajusticiamiento de Trujillo en 1961 se fue a probar suerte a Puerto Rico, y en 1962 cantó con El Gran Combo en la primera gira del grupo a Panamá, promocionando el disco El Gran Combo con Joseíto Mateo. Se adaptó a su repertorio, cantando plena, bomba, guaracha y bolero, y en ese viaje conoció a los jóvenes Pellín Rodríguez y Andy Montañez, que terminaron ocupando su lugar en la orquesta.","type":"text"}]},{"type":"paragraph","content":[{"text":"La razón de su salida la dio él mismo sin rodeos. Tuvo que volver a Santo Domingo a limpiar su nombre: en los años posteriores a la dictadura se perseguía a quien hubiera trabajado bajo ella, y mientras él cantaba afuera en el país lo llamaban espía.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las canciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Su catálogo es enorme y empezó temprano. King of Merengue! salió en 1950 y Merenchanga Pa’ la Pachanga en 1956, y a lo largo de los sesenta publicó disco tras disco: El Verdadero Rey del Merengue en 1964, Caña Brava Vol. 3 y Merengues Vol. 2 en 1966, Salsa Explosiva en 1970.","type":"text"}]},{"type":"paragraph","content":[{"text":"Las canciones que quedaron son Madame Chuchí, Dame la Visa, La Cotorra de Rosa, La Patrulla, Juanita Morel y Merenguero Hasta la Tambora. En 1979 hizo un disco de merengues con ","type":"text"},{"type":"artistReference","attrs":{"artistId":"dab6636c-21fd-4e34-a0a2-e59e9e147bbd","displayText":"Luis Kalaff","occurrenceId":"1f023583-ad08-4f83-a554-c5022288530c"}},{"text":", de quien además había grabado Cuando Yo Me Muera.","type":"text"}]},{"type":"paragraph","content":[{"text":"El baile","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Lo que lo separaba no era solo la voz. Cantaba bailando, y su manera de moverse en tarima pasó a formar parte de cómo se veía el merengue y no solo de cómo sonaba, justo cuando el género salía de los conjuntos de campo hacia los salones de baile y los estudios de televisión.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los reconocimientos","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Acroarte le dio el Gran Soberano, su máximo galardón, en 2004, y el 11 de noviembre de 2010 la Academia Latina de la Grabación le entregó el Premio a la Excelencia Musical por su aporte a la música latina.","type":"text"}]},{"type":"paragraph","content":[{"text":"Murió en 2018, a los noventa y ocho años. En su velatorio ","type":"text"},{"type":"artistReference","attrs":{"artistId":"73691e65-206a-4c71-9b5f-8689f15b2584","displayText":"Cheche Abreu","occurrenceId":"05db25ef-26b3-40d2-bea7-6030ff74d410"}},{"text":" dijo que Joseíto había sido el más grande porque de él lo copiaron todo los demás, y que para el país no iba a morirse nunca.","type":"text"}]}]}'::jsonb, 'published', (SELECT id FROM artists WHERE slug = 'joseito-mateo'), 1)
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
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joseito-mateo') AND locale = 'en'), '6a5a5bcc-0754-4f41-b420-258fec9c6a1d', 'artist', '73691e65-206a-4c71-9b5f-8689f15b2584');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joseito-mateo') AND locale = 'en'), 'a6d3b2a2-2617-4e18-a755-38395aa53c8f', 'artist', 'dab6636c-21fd-4e34-a0a2-e59e9e147bbd');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joseito-mateo') AND locale = 'es'), '05db25ef-26b3-40d2-bea7-6030ff74d410', 'artist', '73691e65-206a-4c71-9b5f-8689f15b2584');

INSERT INTO editorial_entity_references
  (editorial_document_id, occurrence_id, entity_type, target_artist_id)
VALUES ((SELECT id FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'joseito-mateo') AND locale = 'es'), '1f023583-ad08-4f83-a554-c5022288530c', 'artist', 'dab6636c-21fd-4e34-a0a2-e59e9e147bbd');

COMMIT;
