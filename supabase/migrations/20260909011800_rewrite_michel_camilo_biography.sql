BEGIN;

-- Ficha de Michel Camilo.
--
-- Crea dos categorías que el catálogo no tenía: "Best Latin Jazz Album"
-- bajo Grammy y bajo Latin Grammy. A diferencia del caso Casandra, donde la
-- categoría equivalente ya existía con otro nombre en prensa, aquí no hay
-- ninguna a la que mapear: "Best Tropical Latin Album" es otra cosa. El
-- hueco de jazz del catálogo la volverá a necesitar.
--
-- Solo se registran las tres adjudicaciones que pude fechar. Quedan fuera,
-- por falta de año, las que su sitio oficial lista sin fecha: el Emmy por
-- The Goodwill Games Theme, los Latin Grammy por What’s Up? y Rhapsody in
-- Blue, tres Casandra, un Soberano y la Cruz de Plata de Duarte, Sánchez y
-- Mella.

-- 1. Categorías nuevas
INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Best Latin Jazz Album' FROM awards a WHERE a.name = 'Grammy'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Best Latin Jazz Album');
INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Best Latin Jazz Album' FROM awards a WHERE a.name = 'Latin Grammy'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Best Latin Jazz Album');

-- 2. Adjudicaciones fechadas
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2004, 'Live at the Blue Note, con Charles Flores y Horacio "El Negro" Hernández', true, 'grammy.com; anunciado el 8 de febrero de 2004'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'michel-camilo' AND a.name = 'Grammy' AND cat.name = 'Best Latin Jazz Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2004);
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2000, 'Spain, a dúo con el guitarrista flamenco Tomatito', true, 'Primera edición de los Latin Grammy; su sitio oficial y Wikipedia (en y es) coinciden'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'michel-camilo' AND a.name = 'Latin Grammy' AND cat.name = 'Best Latin Jazz Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2000);
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 1992, 'Grado de Caballero', true, 'Wikipedia (es), año a año; el honor figura además en su sitio oficial'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'michel-camilo' AND a.name = 'Gobierno de la República Dominicana' AND cat.name = 'Orden Heráldica de Cristóbal Colón'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 1992);

-- 3. Documentos editoriales, referencias y espejo markdown legacy
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Michel Camilo is a Dominican pianist and composer who works across jazz, classical and Caribbean music. Born in Santo Domingo on 4 April 1954, he was playing with the National Symphony Orchestra of the Dominican Republic at sixteen, moved to New York in 1979, and has since won a Grammy, a Latin Grammy and an Emmy. He writes for orchestra as readily as he plays in trio."}]},{"type":"paragraph","content":[{"type":"text","text":"Santo Domingo and the Conservatory","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Camilo grew up in a musical family. He was given an accordion as a small child, but it was his grandparents’ piano that held him, and at nine he asked for one of his own; his parents sent him first to the Elementary Music School of the National Conservatory and granted the wish a year later. He studied there for thirteen years and was playing with the National Symphony Orchestra at sixteen. He has said he first heard jazz at fourteen and a half, when Art Tatum’s solo reading of \"Tea for Two\" came over the radio."}]},{"type":"paragraph","content":[{"type":"text","text":"When the Harvard University Jazz Band visited the Dominican Republic and heard him at a jam session, its bandleader told him he should be in the United States. He moved to New York in 1979 and studied at Mannes College and the Juilliard School."}]},{"type":"paragraph","content":[{"type":"text","text":"New York","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His opening came in 1983, when Tito Puente’s pianist could not make a date at the Montreal Jazz Festival. Puente took him on a recommendation, without having heard him play. Paquito D’Rivera was in the audience, offered him a place in his band, and Camilo spent four years touring with him and made two records."}]},{"type":"paragraph","content":[{"type":"text","text":"He debuted with his own trio at Carnegie Hall in 1985 and recorded Why Not?, with "},{"type":"artistReference","attrs":{"occurrenceId":"57d6d61b-defe-40a2-b450-f9d5124bcde0","artistId":"977db71a-8bf6-4006-a63d-5e604e99336c","displayText":"Guarionex Aquino Hijo"}},{"type":"text","text":" on percussion, for the Japanese label Electric Bird. His composition \"Why Not!\" travelled further than the record: Manhattan Transfer’s vocal version of it won a Grammy in 1993. In November 1988 he made his major-label debut with Michel Camilo on Sony, which held the top of the jazz albums chart for weeks, and On Fire and On the Other Hand followed."}]},{"type":"paragraph","content":[{"type":"text","text":"In December 1987 he conducted the National Symphony Orchestra of the Dominican Republic for the first time, in a programme of Rimsky-Korsakov, Beethoven and Dvořák that also included his own \"The Goodwill Games Theme\", the piece that won him an Emmy. He was musical director of the Heineken Jazz Festival at home until 1992."}]},{"type":"paragraph","content":[{"type":"text","text":"Spain and Live at the Blue Note","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2000 he recorded Spain with the flamenco guitarist Tomatito, piano and guitar in duo, and it took Best Latin Jazz Album at the first Latin Grammy Awards. The same year Berklee gave him a doctorate in music. Live at the Blue Note, made with Charles Flores and Horacio \"El Negro\" Hernández, won the Grammy for Best Latin Jazz Album in 2004. He also wrote for film — scores for Emilio Martínez-Lázaro’s Los peores años de nuestra vida and Amo tu cama rica, and for Fernando Trueba’s Two Much — and appeared in Trueba’s documentary Calle 54."}]},{"type":"paragraph","content":[{"type":"text","text":"Written for orchestra","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The London Philharmonic commissioned Rhapsody for Two Pianos and Orchestra, premiered by Katia and Marielle Labèque at the Royal Festival Hall in 1992. The National Symphony Orchestra of the Dominican Republic commissioned his Piano Concerto No. 1 and Tango for Ten Pianos, and the Tenerife Auditorium his Piano Concerto No. 2. He has played the White House, holds an honorary doctorate and the Herb Alpert Visiting Professorship at Berklee, and has scholarships in his name at Berklee and at the Duke Ellington School of the Arts."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The Dominican government made him a Knight of the Heraldic Order of Christopher Columbus in 1992 and later awarded him the Silver Cross of the Order of Duarte, Sánchez and Mella. He has recorded and performed with Dominican musicians across the generations, among them "},{"type":"artistReference","attrs":{"occurrenceId":"3f34c0a1-bd7f-462c-b78b-a171dd87570d","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":" and the violinist "},{"type":"artistReference","attrs":{"occurrenceId":"55ccd029-45f6-4424-aa68-ab635fe7267e","artistId":"be6e5b01-4eaa-45ee-bd34-dd567fab6b64","displayText":"Aisha Syed Castro"}},{"type":"text","text":". He remains the Dominican musician whose work is most often heard in concert halls rather than dance halls, and the one who moves between the two without changing his playing."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'michel-camilo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'michel-camilo' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '57d6d61b-defe-40a2-b450-f9d5124bcde0', 'artist', '977db71a-8bf6-4006-a63d-5e604e99336c'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'michel-camilo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3f34c0a1-bd7f-462c-b78b-a171dd87570d', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'michel-camilo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '55ccd029-45f6-4424-aa68-ab635fe7267e', 'artist', 'be6e5b01-4eaa-45ee-bd34-dd567fab6b64'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'michel-camilo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Michel Camilo is a Dominican pianist and composer who works across jazz, classical and Caribbean music. Born in Santo Domingo on 4 April 1954, he was playing with the National Symphony Orchestra of the Dominican Republic at sixteen, moved to New York in 1979, and has since won a Grammy, a Latin Grammy and an Emmy. He writes for orchestra as readily as he plays in trio.

**Santo Domingo and the Conservatory**

Camilo grew up in a musical family. He was given an accordion as a small child, but it was his grandparents’ piano that held him, and at nine he asked for one of his own; his parents sent him first to the Elementary Music School of the National Conservatory and granted the wish a year later. He studied there for thirteen years and was playing with the National Symphony Orchestra at sixteen. He has said he first heard jazz at fourteen and a half, when Art Tatum’s solo reading of "Tea for Two" came over the radio.

When the Harvard University Jazz Band visited the Dominican Republic and heard him at a jam session, its bandleader told him he should be in the United States. He moved to New York in 1979 and studied at Mannes College and the Juilliard School.

**New York**

His opening came in 1983, when Tito Puente’s pianist could not make a date at the Montreal Jazz Festival. Puente took him on a recommendation, without having heard him play. Paquito D’Rivera was in the audience, offered him a place in his band, and Camilo spent four years touring with him and made two records.

He debuted with his own trio at Carnegie Hall in 1985 and recorded Why Not?, with Guarionex Aquino Hijo on percussion, for the Japanese label Electric Bird. His composition "Why Not!" travelled further than the record: Manhattan Transfer’s vocal version of it won a Grammy in 1993. In November 1988 he made his major-label debut with Michel Camilo on Sony, which held the top of the jazz albums chart for weeks, and On Fire and On the Other Hand followed.

In December 1987 he conducted the National Symphony Orchestra of the Dominican Republic for the first time, in a programme of Rimsky-Korsakov, Beethoven and Dvořák that also included his own "The Goodwill Games Theme", the piece that won him an Emmy. He was musical director of the Heineken Jazz Festival at home until 1992.

**Spain and Live at the Blue Note**

In 2000 he recorded Spain with the flamenco guitarist Tomatito, piano and guitar in duo, and it took Best Latin Jazz Album at the first Latin Grammy Awards. The same year Berklee gave him a doctorate in music. Live at the Blue Note, made with Charles Flores and Horacio "El Negro" Hernández, won the Grammy for Best Latin Jazz Album in 2004. He also wrote for film — scores for Emilio Martínez-Lázaro’s Los peores años de nuestra vida and Amo tu cama rica, and for Fernando Trueba’s Two Much — and appeared in Trueba’s documentary Calle 54.

**Written for orchestra**

The London Philharmonic commissioned Rhapsody for Two Pianos and Orchestra, premiered by Katia and Marielle Labèque at the Royal Festival Hall in 1992. The National Symphony Orchestra of the Dominican Republic commissioned his Piano Concerto No. 1 and Tango for Ten Pianos, and the Tenerife Auditorium his Piano Concerto No. 2. He has played the White House, holds an honorary doctorate and the Herb Alpert Visiting Professorship at Berklee, and has scholarships in his name at Berklee and at the Duke Ellington School of the Arts.

**Legacy**

The Dominican government made him a Knight of the Heraldic Order of Christopher Columbus in 1992 and later awarded him the Silver Cross of the Order of Duarte, Sánchez and Mella. He has recorded and performed with Dominican musicians across the generations, among them Juan Luis Guerra 4.40 and the violinist Aisha Syed Castro. He remains the Dominican musician whose work is most often heard in concert halls rather than dance halls, and the one who moves between the two without changing his playing.' WHERE slug = 'michel-camilo';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Michel Camilo es pianista y compositor dominicano, y trabaja entre el jazz, la música clásica y la caribeña. Nació en Santo Domingo el 4 de abril de 1954, a los dieciséis años ya tocaba con la Orquesta Sinfónica Nacional, se mudó a Nueva York en 1979 y desde entonces ha ganado un Grammy, un Latin Grammy y un Emmy. Escribe para orquesta con la misma soltura con que toca en trío."}]},{"type":"paragraph","content":[{"type":"text","text":"Santo Domingo y el Conservatorio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Camilo se crió en una familia de músicos. De niño le dieron un acordeón, pero lo que lo agarró fue el piano de sus abuelos, y a los nueve años pidió uno; sus padres lo mandaron primero a la Escuela Elemental de Música del Conservatorio Nacional y al año siguiente le concedieron el deseo. Estudió allí trece años y a los dieciséis tocaba con la Orquesta Sinfónica Nacional. Ha contado que oyó jazz por primera vez a los catorce años y medio, cuando la radio puso a Art Tatum tocando «Tea for Two» a piano solo."}]},{"type":"paragraph","content":[{"type":"text","text":"Cuando la Harvard University Jazz Band visitó la República Dominicana y lo escuchó en una descarga, su director le dijo que su sitio estaba en Estados Unidos. Se mudó a Nueva York en 1979 y estudió en Mannes College y en la Juilliard School."}]},{"type":"paragraph","content":[{"type":"text","text":"Nueva York","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La entrada le llegó en 1983, cuando el pianista de Tito Puente no pudo cumplir una fecha en el Festival de Jazz de Montreal. Puente lo contrató por recomendación, sin haberlo oído tocar. Paquito D’Rivera estaba entre el público, le ofreció un puesto en su banda, y Camilo pasó cuatro años de gira con él y grabó dos discos."}]},{"type":"paragraph","content":[{"type":"text","text":"Debutó con trío propio en el Carnegie Hall en 1985 y grabó Why Not?, con "},{"type":"artistReference","attrs":{"occurrenceId":"82db22d2-076e-40cf-9c03-089143589a89","artistId":"977db71a-8bf6-4006-a63d-5e604e99336c","displayText":"Guarionex Aquino Hijo"}},{"type":"text","text":" en la percusión, para el sello japonés Electric Bird. Su composición «Why Not!» viajó más lejos que el disco: la versión vocal de Manhattan Transfer ganó un Grammy en 1993. En noviembre de 1988 debutó en un sello mayor con Michel Camilo, por Sony, que encabezó durante semanas la lista de álbumes de jazz, y detrás vinieron On Fire y On the Other Hand."}]},{"type":"paragraph","content":[{"type":"text","text":"En diciembre de 1987 dirigió por primera vez la Orquesta Sinfónica Nacional de la República Dominicana, en un programa de Rimsky-Kórsakov, Beethoven y Dvořák que incluía además «The Goodwill Games Theme», composición suya con la que ganó un Emmy. Fue director musical del Heineken Jazz Festival en el país hasta 1992."}]},{"type":"paragraph","content":[{"type":"text","text":"Spain y Live at the Blue Note","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2000 grabó Spain con el guitarrista flamenco Tomatito, piano y guitarra a dúo, y se llevó el Mejor Álbum de Jazz Latino en la primera edición de los Latin Grammy. Ese mismo año Berklee le dio un doctorado en música. Live at the Blue Note, hecho con Charles Flores y Horacio «El Negro» Hernández, ganó el Grammy al Mejor Álbum de Jazz Latino en 2004. Escribió también para cine —bandas sonoras de Los peores años de nuestra vida y Amo tu cama rica, de Emilio Martínez-Lázaro, y de Two Much, de Fernando Trueba— y apareció en el documental Calle 54, del propio Trueba."}]},{"type":"paragraph","content":[{"type":"text","text":"Escrito para orquesta","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La Orquesta Filarmónica de Londres le encargó Rhapsody for Two Pianos and Orchestra, que Katia y Marielle Labèque estrenaron en el Royal Festival Hall en 1992. La Orquesta Sinfónica Nacional de la República Dominicana le encargó su Concierto para piano n.º 1 y Tango para diez pianos, y el Auditorio de Tenerife el Concierto para piano n.º 2. Ha tocado en la Casa Blanca, tiene doctorado honoris causa y la cátedra Herb Alpert en Berklee, y hay becas con su nombre en Berklee y en la Duke Ellington School of the Arts."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El gobierno dominicano lo hizo Caballero de la Orden Heráldica de Cristóbal Colón en 1992 y después le entregó la Cruz de Plata de la Orden del Mérito de Duarte, Sánchez y Mella. Ha grabado y tocado con músicos dominicanos de varias generaciones, entre ellos "},{"type":"artistReference","attrs":{"occurrenceId":"63920fc5-1ac1-42de-9281-6467d40d0698","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":" y la violinista "},{"type":"artistReference","attrs":{"occurrenceId":"9cfbcbd7-784e-4f0c-af0f-869f99e20a8c","artistId":"be6e5b01-4eaa-45ee-bd34-dd567fab6b64","displayText":"Aisha Syed Castro"}},{"type":"text","text":". Sigue siendo el músico dominicano cuya obra se escucha más en salas de concierto que en salones de baile, y el que pasa de unas a otros sin cambiar de manera de tocar."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'michel-camilo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'michel-camilo' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '82db22d2-076e-40cf-9c03-089143589a89', 'artist', '977db71a-8bf6-4006-a63d-5e604e99336c'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'michel-camilo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '63920fc5-1ac1-42de-9281-6467d40d0698', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'michel-camilo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9cfbcbd7-784e-4f0c-af0f-869f99e20a8c', 'artist', 'be6e5b01-4eaa-45ee-bd34-dd567fab6b64'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'michel-camilo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Michel Camilo es pianista y compositor dominicano, y trabaja entre el jazz, la música clásica y la caribeña. Nació en Santo Domingo el 4 de abril de 1954, a los dieciséis años ya tocaba con la Orquesta Sinfónica Nacional, se mudó a Nueva York en 1979 y desde entonces ha ganado un Grammy, un Latin Grammy y un Emmy. Escribe para orquesta con la misma soltura con que toca en trío.

**Santo Domingo y el Conservatorio**

Camilo se crió en una familia de músicos. De niño le dieron un acordeón, pero lo que lo agarró fue el piano de sus abuelos, y a los nueve años pidió uno; sus padres lo mandaron primero a la Escuela Elemental de Música del Conservatorio Nacional y al año siguiente le concedieron el deseo. Estudió allí trece años y a los dieciséis tocaba con la Orquesta Sinfónica Nacional. Ha contado que oyó jazz por primera vez a los catorce años y medio, cuando la radio puso a Art Tatum tocando «Tea for Two» a piano solo.

Cuando la Harvard University Jazz Band visitó la República Dominicana y lo escuchó en una descarga, su director le dijo que su sitio estaba en Estados Unidos. Se mudó a Nueva York en 1979 y estudió en Mannes College y en la Juilliard School.

**Nueva York**

La entrada le llegó en 1983, cuando el pianista de Tito Puente no pudo cumplir una fecha en el Festival de Jazz de Montreal. Puente lo contrató por recomendación, sin haberlo oído tocar. Paquito D’Rivera estaba entre el público, le ofreció un puesto en su banda, y Camilo pasó cuatro años de gira con él y grabó dos discos.

Debutó con trío propio en el Carnegie Hall en 1985 y grabó Why Not?, con Guarionex Aquino Hijo en la percusión, para el sello japonés Electric Bird. Su composición «Why Not!» viajó más lejos que el disco: la versión vocal de Manhattan Transfer ganó un Grammy en 1993. En noviembre de 1988 debutó en un sello mayor con Michel Camilo, por Sony, que encabezó durante semanas la lista de álbumes de jazz, y detrás vinieron On Fire y On the Other Hand.

En diciembre de 1987 dirigió por primera vez la Orquesta Sinfónica Nacional de la República Dominicana, en un programa de Rimsky-Kórsakov, Beethoven y Dvořák que incluía además «The Goodwill Games Theme», composición suya con la que ganó un Emmy. Fue director musical del Heineken Jazz Festival en el país hasta 1992.

**Spain y Live at the Blue Note**

En 2000 grabó Spain con el guitarrista flamenco Tomatito, piano y guitarra a dúo, y se llevó el Mejor Álbum de Jazz Latino en la primera edición de los Latin Grammy. Ese mismo año Berklee le dio un doctorado en música. Live at the Blue Note, hecho con Charles Flores y Horacio «El Negro» Hernández, ganó el Grammy al Mejor Álbum de Jazz Latino en 2004. Escribió también para cine —bandas sonoras de Los peores años de nuestra vida y Amo tu cama rica, de Emilio Martínez-Lázaro, y de Two Much, de Fernando Trueba— y apareció en el documental Calle 54, del propio Trueba.

**Escrito para orquesta**

La Orquesta Filarmónica de Londres le encargó Rhapsody for Two Pianos and Orchestra, que Katia y Marielle Labèque estrenaron en el Royal Festival Hall en 1992. La Orquesta Sinfónica Nacional de la República Dominicana le encargó su Concierto para piano n.º 1 y Tango para diez pianos, y el Auditorio de Tenerife el Concierto para piano n.º 2. Ha tocado en la Casa Blanca, tiene doctorado honoris causa y la cátedra Herb Alpert en Berklee, y hay becas con su nombre en Berklee y en la Duke Ellington School of the Arts.

**Legado**

El gobierno dominicano lo hizo Caballero de la Orden Heráldica de Cristóbal Colón en 1992 y después le entregó la Cruz de Plata de la Orden del Mérito de Duarte, Sánchez y Mella. Ha grabado y tocado con músicos dominicanos de varias generaciones, entre ellos Juan Luis Guerra 4.40 y la violinista Aisha Syed Castro. Sigue siendo el músico dominicano cuya obra se escucha más en salas de concierto que en salones de baile, y el que pasa de unas a otros sin cambiar de manera de tocar.' WHERE slug = 'michel-camilo';

COMMIT;
