BEGIN;

-- Ficha de Mario de Jesús Báez.
--
-- La biografía de relleno hablaba en términos genéricos de "unified creative ecosystem" sin
-- nombrar una sola canción, intérprete, premio o año concreto.
-- Nombre corregido: el nombre de nacimiento es "Mario César de Jesús Báez" ("de Jesús" es el
-- apellido paterno que usó como nombre artístico, "Báez" el materno); la fila invertía esto
-- guardando "Báez" como last_name. middle_name -> César, last_name -> de Jesús,
-- second_last_name -> Báez.
-- date_of_death corregido de 2008-07-20 a 2008-07-25 (cuerpo del artículo de Wikipedia y El
-- Nuevo Diario, contra el infobox de Wikipedia que coincidía con la fila).
-- Se registra el premio ASCAP 1995 por "Ni con la vida te pago".

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT a.id, aw.id, ac.id, 1995, 'Ni con la vida te pago', true,
  'Wikipedia (es) y El Nuevo Diario (1 feb. 2025), ambos citando el premio ASCAP 1995 a la canción regional mexicana más destacada, interpretada por Vicente Fernández'
FROM artists a, awards aw, award_categories ac
WHERE a.slug = 'mario-de-jesus-baez' AND aw.name = 'ASCAP Latin Music Awards' AND ac.award_id = aw.id AND ac.name = 'Winning Songs';
UPDATE artists SET middle_name = 'César', last_name = 'de Jesús', second_last_name = 'Báez',
       sort_name = 'de Jesús, Mario César Báez', date_of_death = '2008-07-25' WHERE slug = 'mario-de-jesus-baez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Mario César de Jesús Báez, born in San Pedro de Macorís on 18 August 1924 and died in Mexico City on 25 July 2008, was a Dominican songwriter and music publisher who, writing simply as Mario de Jesús, became one of the most recorded bolero composers of the twentieth century — so identified with Mexico that many Mexicans assumed he was one of their own."}]},{"type":"paragraph","content":[{"type":"text","text":"From journalism to Peer International","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began as an entertainment columnist for the newspaper La Nación and the magazine Revista Salón Fígaro in the Dominican Republic before moving to New York in the late 1940s to write for Revista Teatral. Hired by the publisher Peer International in 1950, he had his first hit two years later with «No toques ese disco», recorded by Bienvenido Granda with La Sonora Matancera."}]},{"type":"paragraph","content":[{"type":"text","text":"A catalogue recorded across a continent","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He relocated to Mexico in 1959 and was later naturalized there, building a catalogue of some 300 songs recorded by an extraordinary range of singers: Javier Solís, Vicente Fernández, Luis Miguel, Plácido Domingo, Julio Iglesias, Los Panchos, Pedro Infante, Celia Cruz, Lucho Gatica and his fellow Dominican "},{"type":"artistReference","attrs":{"occurrenceId":"8c47952a-e2ca-4de9-99fb-4de1d8967c62","artistId":"9e585186-f3b8-4720-979b-505f6198558e","displayText":"Charytin"}},{"type":"text","text":", among many others. His songs included «Y…», «Se me olvidó tu nombre» and «Voy a perder la cabeza por tu amor», a signature hit for José Luis Rodríguez «El Puma». He also founded two publishing houses, Editorial Musical Latinoamericana (1968) and Editora Leo Musical (1975), to represent his own and other composers’ work."}]},{"type":"paragraph","content":[{"type":"text","text":"A career of honors","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His awards spanned four decades and several countries, from the Ángel Viloria trophy in New York in 1950 to Venezuela’s Guaicaipuro de Oro in 1980 and an ASCAP award in 1995 for «Ni con la vida te pago», recorded by Vicente Fernández. In 2007 the Dominican Republic named him a Knight of the Order of Merit of Duarte, Sánchez y Mella."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Mario de Jesús died in the country that had adopted him as a composer, but his catalogue — still recorded by new generations of singers — remains as Dominican as the artist who signed it."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'mario-de-jesus-baez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'mario-de-jesus-baez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '8c47952a-e2ca-4de9-99fb-4de1d8967c62', 'artist', '9e585186-f3b8-4720-979b-505f6198558e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'mario-de-jesus-baez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Mario César de Jesús Báez, born in San Pedro de Macorís on 18 August 1924 and died in Mexico City on 25 July 2008, was a Dominican songwriter and music publisher who, writing simply as Mario de Jesús, became one of the most recorded bolero composers of the twentieth century — so identified with Mexico that many Mexicans assumed he was one of their own.

**From journalism to Peer International**

He began as an entertainment columnist for the newspaper La Nación and the magazine Revista Salón Fígaro in the Dominican Republic before moving to New York in the late 1940s to write for Revista Teatral. Hired by the publisher Peer International in 1950, he had his first hit two years later with «No toques ese disco», recorded by Bienvenido Granda with La Sonora Matancera.

**A catalogue recorded across a continent**

He relocated to Mexico in 1959 and was later naturalized there, building a catalogue of some 300 songs recorded by an extraordinary range of singers: Javier Solís, Vicente Fernández, Luis Miguel, Plácido Domingo, Julio Iglesias, Los Panchos, Pedro Infante, Celia Cruz, Lucho Gatica and his fellow Dominican Charytin, among many others. His songs included «Y…», «Se me olvidó tu nombre» and «Voy a perder la cabeza por tu amor», a signature hit for José Luis Rodríguez «El Puma». He also founded two publishing houses, Editorial Musical Latinoamericana (1968) and Editora Leo Musical (1975), to represent his own and other composers’ work.

**A career of honors**

His awards spanned four decades and several countries, from the Ángel Viloria trophy in New York in 1950 to Venezuela’s Guaicaipuro de Oro in 1980 and an ASCAP award in 1995 for «Ni con la vida te pago», recorded by Vicente Fernández. In 2007 the Dominican Republic named him a Knight of the Order of Merit of Duarte, Sánchez y Mella.

**Legacy**

Mario de Jesús died in the country that had adopted him as a composer, but his catalogue — still recorded by new generations of singers — remains as Dominican as the artist who signed it.' WHERE slug = 'mario-de-jesus-baez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Mario César de Jesús Báez, nacido en San Pedro de Macorís el 18 de agosto de 1924 y fallecido en Ciudad de México el 25 de julio de 2008, fue compositor y editor musical dominicano que, firmando simplemente como Mario de Jesús, se convirtió en uno de los compositores de bolero más grabados del siglo XX — tan identificado con México que muchos mexicanos lo creían uno de los suyos."}]},{"type":"paragraph","content":[{"type":"text","text":"Del periodismo a Peer Internacional","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Comenzó como cronista de espectáculos para el periódico La Nación y la Revista Salón Fígaro en la República Dominicana, antes de mudarse a Nueva York a finales de los años cuarenta para escribir en la Revista Teatral. Contratado por la editora Peer Internacional en 1950, tuvo su primer éxito dos años después con «No toques ese disco», grabada por Bienvenido Granda con La Sonora Matancera."}]},{"type":"paragraph","content":[{"type":"text","text":"Un catálogo grabado por todo un continente","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Se radicó en México en 1959 y más tarde se naturalizó mexicano, construyendo un catálogo de unas 300 canciones grabadas por una extraordinaria variedad de intérpretes: Javier Solís, Vicente Fernández, Luis Miguel, Plácido Domingo, Julio Iglesias, Los Panchos, Pedro Infante, Celia Cruz, Lucho Gatica y su compatriota dominicana "},{"type":"artistReference","attrs":{"occurrenceId":"7f74add4-f76f-4e78-ac29-6a8cf2d9e0b9","artistId":"9e585186-f3b8-4720-979b-505f6198558e","displayText":"Charytin"}},{"type":"text","text":", entre muchos otros. Entre sus canciones están «Y…», «Se me olvidó tu nombre» y «Voy a perder la cabeza por tu amor», éxito insignia de José Luis Rodríguez «El Puma». También fundó dos editoriales, Editorial Musical Latinoamericana (1968) y Editora Leo Musical (1975), para representar su obra y la de otros compositores."}]},{"type":"paragraph","content":[{"type":"text","text":"Una carrera de reconocimientos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Sus premios abarcaron cuatro décadas y varios países, desde el trofeo Ángel Viloria en Nueva York en 1950 hasta el Guaicaipuro de Oro venezolano en 1980 y un premio ASCAP en 1995 por «Ni con la vida te pago», grabada por Vicente Fernández. En 2007 la República Dominicana lo nombró Caballero de la Orden al Mérito de Duarte, Sánchez y Mella."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Mario de Jesús murió en el país que lo había adoptado como compositor, pero su catálogo —todavía grabado por nuevas generaciones de intérpretes— sigue siendo tan dominicano como el artista que lo firmó."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'mario-de-jesus-baez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'mario-de-jesus-baez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7f74add4-f76f-4e78-ac29-6a8cf2d9e0b9', 'artist', '9e585186-f3b8-4720-979b-505f6198558e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'mario-de-jesus-baez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Mario César de Jesús Báez, nacido en San Pedro de Macorís el 18 de agosto de 1924 y fallecido en Ciudad de México el 25 de julio de 2008, fue compositor y editor musical dominicano que, firmando simplemente como Mario de Jesús, se convirtió en uno de los compositores de bolero más grabados del siglo XX — tan identificado con México que muchos mexicanos lo creían uno de los suyos.

**Del periodismo a Peer Internacional**

Comenzó como cronista de espectáculos para el periódico La Nación y la Revista Salón Fígaro en la República Dominicana, antes de mudarse a Nueva York a finales de los años cuarenta para escribir en la Revista Teatral. Contratado por la editora Peer Internacional en 1950, tuvo su primer éxito dos años después con «No toques ese disco», grabada por Bienvenido Granda con La Sonora Matancera.

**Un catálogo grabado por todo un continente**

Se radicó en México en 1959 y más tarde se naturalizó mexicano, construyendo un catálogo de unas 300 canciones grabadas por una extraordinaria variedad de intérpretes: Javier Solís, Vicente Fernández, Luis Miguel, Plácido Domingo, Julio Iglesias, Los Panchos, Pedro Infante, Celia Cruz, Lucho Gatica y su compatriota dominicana Charytin, entre muchos otros. Entre sus canciones están «Y…», «Se me olvidó tu nombre» y «Voy a perder la cabeza por tu amor», éxito insignia de José Luis Rodríguez «El Puma». También fundó dos editoriales, Editorial Musical Latinoamericana (1968) y Editora Leo Musical (1975), para representar su obra y la de otros compositores.

**Una carrera de reconocimientos**

Sus premios abarcaron cuatro décadas y varios países, desde el trofeo Ángel Viloria en Nueva York en 1950 hasta el Guaicaipuro de Oro venezolano en 1980 y un premio ASCAP en 1995 por «Ni con la vida te pago», grabada por Vicente Fernández. En 2007 la República Dominicana lo nombró Caballero de la Orden al Mérito de Duarte, Sánchez y Mella.

**Legado**

Mario de Jesús murió en el país que lo había adoptado como compositor, pero su catálogo —todavía grabado por nuevas generaciones de intérpretes— sigue siendo tan dominicano como el artista que lo firmó.' WHERE slug = 'mario-de-jesus-baez';

COMMIT;
