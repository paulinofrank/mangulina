BEGIN;

-- Ficha de Los Toros Band.
--
-- Correcciones de campo, con dos fuentes coincidentes en cada una:
--  * birth_year 1989. Lo dan Hoy (10 de junio de 2026, por su corresponsal
--    en Monseñor Nouel) y BuenaMusica.
--  * Fundada en SANTO DOMINGO, no en Bonao. Lo dicen las mismas dos fuentes
--    y su propio canal de YouTube. Bonao es de donde reclutaron a Héctor
--    Acosta, que cantaba allí en Los Gentiles: de ahí venía la confusión.
--    province pasa de Monseñor Nouel a Distrito Nacional.
--  * ended sigue en false, con prueba: gira contratada para 2026 y nota de
--    prensa de junio de ese año.
--
-- Sin registrar por falta de año: las cinco categorías de los Premios
-- Casandra que BuenaMusica sitúa "a principios del año 2000", la nominación
-- del Premio ACE a mejor orquesta tropical y la de Premio Lo Nuestro en
-- salsa tropical, las dos hacia 1994.
--
-- Ojo con un falso positivo: la fila "Indhira Rubiera" del catálogo es una
-- soprano lírica de ópera, no la merenguera Indhira que entró en 2006. No
-- se enlaza; queda anotada como ausencia.

-- 1. Fundación y lugar
UPDATE artists SET birth_year = 1989, birth_place = 'Santo Domingo', province = 'Distrito Nacional'
 WHERE slug = 'los-toros-band';

-- 2. Documentos editoriales, referencias y espejo markdown legacy
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Los Toros Band is a Dominican merengue orchestra founded in Santo Domingo in 1989 by the producer brothers Gerardo Díaz, known as El Toro, and Juan Pablo Díaz. It belongs to them rather than to whoever is singing in front of it, and that is the fact that organises everything else about it: the band has outlasted every one of its lead voices, including "},{"type":"artistReference","attrs":{"occurrenceId":"1a162a91-60b4-4b9b-80d5-1b053281d962","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":", who fronted it for fifteen years and left in a contract fight. It is still working in 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"The Díaz brothers","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Gerardo and Juan Pablo Díaz set the orchestra up in the capital as producers, not as players, and built it for a sound they wanted: a full orchestral structure, musical discipline, and romantic merengue rather than the rougher style of the moment. In 1989 they found their singer in Bonao — "},{"type":"artistReference","attrs":{"occurrenceId":"f29a9287-4b93-453f-a70b-b21dcc2d3256","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":" was then the vocalist of a local group, «Los Gentiles» — and recruited him to front the new band. The nickname El Torito comes from that hiring."}]},{"type":"paragraph","content":[{"type":"text","text":"The Torito years","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The first record, «Se soltaron los toros», came out in 1991, and «Calentando» and «¡Recio!» followed. In 1994 Polygram extended them to a multinational contract, which brought nominations: best tropical orchestra from the «Premio ACE» in New York, and a «Premio Lo Nuestro» nomination in tropical salsa. "},{"type":"artistReference","attrs":{"occurrenceId":"713b9dad-61d3-4014-9d10-e575b3a452b2","artistId":"1519cbca-ae0a-4ede-924b-244a49c9024e","displayText":"Henry Jiménez"}},{"type":"text","text":" had arranged «La Morenita» for them in 1991, which was Acosta’s first hit."}]},{"type":"paragraph","content":[{"type":"text","text":"«Formidables», «Románticos», «El mambo del toro» and «Raíces», the last in 1997, carried them into Colombia, Venezuela and Central America, into Spain, Germany, Sweden and Switzerland, and across the Dominican circuit in the United States. «Quizás sí, quizás no», «Llegó tu marido» and «A pasito lento» are the three that outlived the era. In the early 2000s they took five categories at the «Premios Casandra» in a single night, and put out «Pa’ la calle», «Indestructibles», «En vivo» and «Las 2 caras del toro» — that last one split between merengue and bachata, and it closed the Acosta period."}]},{"type":"paragraph","content":[{"type":"text","text":"The split","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Acosta left in 2005 over the group’s finances, saying he had never been told what a tour earned and had received nothing from Dominican record sales. What followed was a public contract fight with «Los Toros Records», the Díaz brothers’ company, which barred him from performing until it was settled; the settlement came in February 2006, after he paid a substantial sum. It is one of the documented Dominican cases of a lead singer separating from an orchestra owned by its producers, and "},{"type":"artistReference","attrs":{"occurrenceId":"c71310e0-7f09-43c7-b651-78b4e597f1f5","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":" went on to a solo career that took him to the Gran Soberano and to the Senate."}]},{"type":"paragraph","content":[{"type":"text","text":"After Acosta","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The Díaz brothers kept the orchestra and rebuilt the front line. Between 2006 and 2012 the singer Indhira brought a female voice to a band that had not had one, and Javy Javier, Yader Romero and Osiris Vega passed through. In 2008 "},{"type":"artistReference","attrs":{"occurrenceId":"78ce74fd-b9c7-441b-bcad-bc4d32528d27","artistId":"15775d55-9e10-46bc-8516-ee7468724ec0","displayText":"Benny Sadel"}},{"type":"text","text":" joined as its principal figure, which returned him to a large orchestra after two decades fronting his own; he died in New York on 5 November 2015, at fifty-five, and "},{"type":"artistReference","attrs":{"occurrenceId":"30d225f3-504b-45fd-bd30-c97f085d5fc1","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":" sang at his wake. «Los Toros Band: el regreso» dates from this period. Through the 2010s the band worked its back catalogue, reissued its hits as bachata, and marked its twenty-fifth and thirtieth anniversaries with concerts that brought former members back."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los Toros Band is the clearest Dominican case of an orchestra as a producer-owned institution rather than a singer’s vehicle. Four decades in, the brand still books tours across Latin America and the United States — Juan Pablo Díaz was describing a full 2026 schedule in the Dominican press that June — and the catalogue it built between 1991 and 2005 is what fills the rooms."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'los-toros-band'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'los-toros-band' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1a162a91-60b4-4b9b-80d5-1b053281d962', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-toros-band' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f29a9287-4b93-453f-a70b-b21dcc2d3256', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-toros-band' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '713b9dad-61d3-4014-9d10-e575b3a452b2', 'artist', '1519cbca-ae0a-4ede-924b-244a49c9024e'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-toros-band' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c71310e0-7f09-43c7-b651-78b4e597f1f5', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-toros-band' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '78ce74fd-b9c7-441b-bcad-bc4d32528d27', 'artist', '15775d55-9e10-46bc-8516-ee7468724ec0'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-toros-band' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '30d225f3-504b-45fd-bd30-c97f085d5fc1', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-toros-band' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Los Toros Band is a Dominican merengue orchestra founded in Santo Domingo in 1989 by the producer brothers Gerardo Díaz, known as El Toro, and Juan Pablo Díaz. It belongs to them rather than to whoever is singing in front of it, and that is the fact that organises everything else about it: the band has outlasted every one of its lead voices, including Héctor Acosta “El Torito”, who fronted it for fifteen years and left in a contract fight. It is still working in 2026.

**The Díaz brothers**

Gerardo and Juan Pablo Díaz set the orchestra up in the capital as producers, not as players, and built it for a sound they wanted: a full orchestral structure, musical discipline, and romantic merengue rather than the rougher style of the moment. In 1989 they found their singer in Bonao — Héctor Acosta “El Torito” was then the vocalist of a local group, «Los Gentiles» — and recruited him to front the new band. The nickname El Torito comes from that hiring.

**The Torito years**

The first record, «Se soltaron los toros», came out in 1991, and «Calentando» and «¡Recio!» followed. In 1994 Polygram extended them to a multinational contract, which brought nominations: best tropical orchestra from the «Premio ACE» in New York, and a «Premio Lo Nuestro» nomination in tropical salsa. Henry Jiménez had arranged «La Morenita» for them in 1991, which was Acosta’s first hit.

«Formidables», «Románticos», «El mambo del toro» and «Raíces», the last in 1997, carried them into Colombia, Venezuela and Central America, into Spain, Germany, Sweden and Switzerland, and across the Dominican circuit in the United States. «Quizás sí, quizás no», «Llegó tu marido» and «A pasito lento» are the three that outlived the era. In the early 2000s they took five categories at the «Premios Casandra» in a single night, and put out «Pa’ la calle», «Indestructibles», «En vivo» and «Las 2 caras del toro» — that last one split between merengue and bachata, and it closed the Acosta period.

**The split**

Acosta left in 2005 over the group’s finances, saying he had never been told what a tour earned and had received nothing from Dominican record sales. What followed was a public contract fight with «Los Toros Records», the Díaz brothers’ company, which barred him from performing until it was settled; the settlement came in February 2006, after he paid a substantial sum. It is one of the documented Dominican cases of a lead singer separating from an orchestra owned by its producers, and Héctor Acosta “El Torito” went on to a solo career that took him to the Gran Soberano and to the Senate.

**After Acosta**

The Díaz brothers kept the orchestra and rebuilt the front line. Between 2006 and 2012 the singer Indhira brought a female voice to a band that had not had one, and Javy Javier, Yader Romero and Osiris Vega passed through. In 2008 Benny Sadel joined as its principal figure, which returned him to a large orchestra after two decades fronting his own; he died in New York on 5 November 2015, at fifty-five, and Sergio Vargas sang at his wake. «Los Toros Band: el regreso» dates from this period. Through the 2010s the band worked its back catalogue, reissued its hits as bachata, and marked its twenty-fifth and thirtieth anniversaries with concerts that brought former members back.

**Legacy**

Los Toros Band is the clearest Dominican case of an orchestra as a producer-owned institution rather than a singer’s vehicle. Four decades in, the brand still books tours across Latin America and the United States — Juan Pablo Díaz was describing a full 2026 schedule in the Dominican press that June — and the catalogue it built between 1991 and 2005 is what fills the rooms.' WHERE slug = 'los-toros-band';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Los Toros Band es una orquesta de merengue dominicana fundada en Santo Domingo en 1989 por los hermanos productores Gerardo Díaz, apodado El Toro, y Juan Pablo Díaz. Es de ellos y no de quien cante delante, y ese es el hecho que ordena todo lo demás: la agrupación ha sobrevivido a todas sus voces principales, incluida la de "},{"type":"artistReference","attrs":{"occurrenceId":"398170a3-6a67-406b-9ce9-549b2c1acfe9","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":", que la encabezó quince años y salió en medio de un litigio. Sigue trabajando en 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"Los hermanos Díaz","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Gerardo y Juan Pablo Díaz montaron la orquesta en la capital como productores, no como músicos, y la armaron para un sonido que tenían en la cabeza: estructura orquestal completa, disciplina musical y merengue romántico antes que el estilo más crudo de la época. En 1989 encontraron a su cantante en Bonao —"},{"type":"artistReference","attrs":{"occurrenceId":"bcfbe408-5f43-4aea-9e65-9695ad8a2a25","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":" era entonces vocalista de un grupo local, «Los Gentiles»— y lo reclutaron para ponerlo al frente. De esa contratación viene el apodo de El Torito."}]},{"type":"paragraph","content":[{"type":"text","text":"Los años de El Torito","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El primer disco, «Se soltaron los toros», salió en 1991, y detrás vinieron «Calentando» y «¡Recio!». En 1994 Polygram les extendió un contrato multinacional, y con él llegaron las nominaciones: mejor orquesta tropical en los «Premio ACE» de Nueva York, y una nominación en los «Premio Lo Nuestro» en salsa tropical. "},{"type":"artistReference","attrs":{"occurrenceId":"315e6c00-f08a-4405-8f31-97dbc2fa31c8","artistId":"1519cbca-ae0a-4ede-924b-244a49c9024e","displayText":"Henry Jiménez"}},{"type":"text","text":" les había arreglado «La Morenita» en 1991, que fue el primer éxito de Acosta."}]},{"type":"paragraph","content":[{"type":"text","text":"«Formidables», «Románticos», «El mambo del toro» y «Raíces», este último de 1997, los llevaron a Colombia, Venezuela y Centroamérica, a España, Alemania, Suecia y Suiza, y al circuito dominicano de Estados Unidos. «Quizás sí, quizás no», «Llegó tu marido» y «A pasito lento» son las tres que sobrevivieron a la época. A principios de los 2000 se llevaron cinco categorías en los «Premios Casandra» en una sola noche, y publicaron «Pa’ la calle», «Indestructibles», «En vivo» y «Las 2 caras del toro», este último repartido entre merengue y bachata, que cerró la etapa de Acosta."}]},{"type":"paragraph","content":[{"type":"text","text":"La salida","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Acosta se fue en 2005 por el manejo financiero del grupo: declaró que nunca se le informó cuánto producía una gira ni recibió nada del mercado dominicano del disco. Siguió un pleito público con «Los Toros Records», la empresa de los hermanos Díaz, que le impidió presentarse hasta resolverlo; el acuerdo llegó en febrero de 2006, tras el pago de una suma considerable. Es uno de los casos documentados de un vocalista dominicano que se separa de una orquesta propiedad de sus productores, y "},{"type":"artistReference","attrs":{"occurrenceId":"82ad689c-92b8-40ec-8d14-3ff4341ce549","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":" siguió a una carrera solista que lo llevó al Gran Soberano y al Senado."}]},{"type":"paragraph","content":[{"type":"text","text":"Después de Acosta","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los hermanos Díaz se quedaron con la orquesta y rehicieron el frente. Entre 2006 y 2012 la cantante Indhira le puso una voz femenina a una banda que no la había tenido, y pasaron por sus filas Javy Javier, Yader Romero y Osiris Vega. En 2008 entró "},{"type":"artistReference","attrs":{"occurrenceId":"f0b00c45-eb33-466a-99a1-2f05840aef78","artistId":"15775d55-9e10-46bc-8516-ee7468724ec0","displayText":"Benny Sadel"}},{"type":"text","text":" como figura principal, lo que lo devolvió a una orquesta grande después de dos décadas al frente de la suya; murió en Nueva York el 5 de noviembre de 2015, a los cincuenta y cinco años, y "},{"type":"artistReference","attrs":{"occurrenceId":"70d27d4e-fdf6-4a95-9e4a-2c081e277bd1","artistId":"059a9e99-5d11-433e-97b9-9c35e57908f1","displayText":"Sergio Vargas"}},{"type":"text","text":" cantó en su velatorio. De esta etapa es «Los Toros Band: el regreso». Durante los años diez la banda trabajó su catálogo viejo, reeditó sus éxitos en bachata y celebró los veinticinco y los treinta años con conciertos que trajeron de vuelta a antiguos integrantes."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los Toros Band es el caso dominicano más claro de una orquesta como institución de sus productores y no como vehículo de un cantante. Cuatro décadas después la marca sigue contratando giras por América Latina y Estados Unidos —Juan Pablo Díaz describía una agenda apretada para 2026 en la prensa dominicana de ese junio— y lo que llena las salas es el catálogo que construyeron entre 1991 y 2005."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'los-toros-band'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'los-toros-band' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '398170a3-6a67-406b-9ce9-549b2c1acfe9', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-toros-band' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'bcfbe408-5f43-4aea-9e65-9695ad8a2a25', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-toros-band' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '315e6c00-f08a-4405-8f31-97dbc2fa31c8', 'artist', '1519cbca-ae0a-4ede-924b-244a49c9024e'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-toros-band' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '82ad689c-92b8-40ec-8d14-3ff4341ce549', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-toros-band' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f0b00c45-eb33-466a-99a1-2f05840aef78', 'artist', '15775d55-9e10-46bc-8516-ee7468724ec0'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-toros-band' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '70d27d4e-fdf6-4a95-9e4a-2c081e277bd1', 'artist', '059a9e99-5d11-433e-97b9-9c35e57908f1'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-toros-band' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Los Toros Band es una orquesta de merengue dominicana fundada en Santo Domingo en 1989 por los hermanos productores Gerardo Díaz, apodado El Toro, y Juan Pablo Díaz. Es de ellos y no de quien cante delante, y ese es el hecho que ordena todo lo demás: la agrupación ha sobrevivido a todas sus voces principales, incluida la de Héctor Acosta “El Torito”, que la encabezó quince años y salió en medio de un litigio. Sigue trabajando en 2026.

**Los hermanos Díaz**

Gerardo y Juan Pablo Díaz montaron la orquesta en la capital como productores, no como músicos, y la armaron para un sonido que tenían en la cabeza: estructura orquestal completa, disciplina musical y merengue romántico antes que el estilo más crudo de la época. En 1989 encontraron a su cantante en Bonao —Héctor Acosta “El Torito” era entonces vocalista de un grupo local, «Los Gentiles»— y lo reclutaron para ponerlo al frente. De esa contratación viene el apodo de El Torito.

**Los años de El Torito**

El primer disco, «Se soltaron los toros», salió en 1991, y detrás vinieron «Calentando» y «¡Recio!». En 1994 Polygram les extendió un contrato multinacional, y con él llegaron las nominaciones: mejor orquesta tropical en los «Premio ACE» de Nueva York, y una nominación en los «Premio Lo Nuestro» en salsa tropical. Henry Jiménez les había arreglado «La Morenita» en 1991, que fue el primer éxito de Acosta.

«Formidables», «Románticos», «El mambo del toro» y «Raíces», este último de 1997, los llevaron a Colombia, Venezuela y Centroamérica, a España, Alemania, Suecia y Suiza, y al circuito dominicano de Estados Unidos. «Quizás sí, quizás no», «Llegó tu marido» y «A pasito lento» son las tres que sobrevivieron a la época. A principios de los 2000 se llevaron cinco categorías en los «Premios Casandra» en una sola noche, y publicaron «Pa’ la calle», «Indestructibles», «En vivo» y «Las 2 caras del toro», este último repartido entre merengue y bachata, que cerró la etapa de Acosta.

**La salida**

Acosta se fue en 2005 por el manejo financiero del grupo: declaró que nunca se le informó cuánto producía una gira ni recibió nada del mercado dominicano del disco. Siguió un pleito público con «Los Toros Records», la empresa de los hermanos Díaz, que le impidió presentarse hasta resolverlo; el acuerdo llegó en febrero de 2006, tras el pago de una suma considerable. Es uno de los casos documentados de un vocalista dominicano que se separa de una orquesta propiedad de sus productores, y Héctor Acosta “El Torito” siguió a una carrera solista que lo llevó al Gran Soberano y al Senado.

**Después de Acosta**

Los hermanos Díaz se quedaron con la orquesta y rehicieron el frente. Entre 2006 y 2012 la cantante Indhira le puso una voz femenina a una banda que no la había tenido, y pasaron por sus filas Javy Javier, Yader Romero y Osiris Vega. En 2008 entró Benny Sadel como figura principal, lo que lo devolvió a una orquesta grande después de dos décadas al frente de la suya; murió en Nueva York el 5 de noviembre de 2015, a los cincuenta y cinco años, y Sergio Vargas cantó en su velatorio. De esta etapa es «Los Toros Band: el regreso». Durante los años diez la banda trabajó su catálogo viejo, reeditó sus éxitos en bachata y celebró los veinticinco y los treinta años con conciertos que trajeron de vuelta a antiguos integrantes.

**Legado**

Los Toros Band es el caso dominicano más claro de una orquesta como institución de sus productores y no como vehículo de un cantante. Cuatro décadas después la marca sigue contratando giras por América Latina y Estados Unidos —Juan Pablo Díaz describía una agenda apretada para 2026 en la prensa dominicana de ese junio— y lo que llena las salas es el catálogo que construyeron entre 1991 y 2005.' WHERE slug = 'los-toros-band';

COMMIT;
