BEGIN;

-- Ficha de Chichi Peralta.
--
-- Limpia el alias "Son Familia", que figuraba en la fila de Jandy Feliz.
-- Son Familia es la agrupación de Peralta —Chichi Peralta y Son Familia—,
-- de la que Feliz fue cantante hasta que se lanzó como solista. Mismo
-- patrón que "Transporte Urbano" en la ficha anterior: el nombre de una
-- banda sin fila propia, colgado de una persona que tocó en ella. La
-- agrupación queda anotada en ARTISTAS_FALTANTES.md.
--
-- Dos adjudicaciones tomadas de latingrammy.com, la propia academia. Ojo:
-- para la nominación de 2006 Wikipedia (es) e IMDb dicen "tropical
-- contemporáneo", pero la academia la registra como Merengue/Bachata.
--
-- No se registra el Premio Lo Nuestro de 1998 (revelación del año, género
-- tropical): el catálogo no tiene esa categoría y la sección de premios de
-- Wikipedia que lo recoge lleva aviso de falta de referencias.

-- 1. Alias mal colocado
UPDATE artists SET aliases = array_remove(aliases, 'Son Familia') WHERE slug = 'jandy-feliz';

-- 2. Adjudicaciones
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2001, '...De Vuelta Al Barrio', true, 'latingrammy.com; 2.ª edición de los Latin Grammy'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'chichi-peralta' AND a.name = 'Latin Grammy' AND cat.name = 'Best Merengue Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2001);
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2006, 'Más Que Suficiente', false, 'latingrammy.com; 7.ª edición. Wikipedia (es) e IMDb dan la categoría como tropical contemporáneo; manda la academia'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'chichi-peralta' AND a.name = 'Latin Grammy' AND cat.name = 'Best Merengue/Bachata Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2006);

-- 3. Documentos editoriales, referencias y espejo markdown legacy
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Chichi Peralta — Pedro René Peralta Soto, born in Santo Domingo on 9 July 1966 — is a Dominican percussionist, singer, composer, arranger and producer. He spent the 1980s and 1990s as a working percussionist, eight of those years in the band of "},{"type":"artistReference","attrs":{"occurrenceId":"f2675a1b-29b3-4078-9c46-4e30b5aa89ac","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":", before launching Chichi Peralta y Son Familia and taking a Latin Grammy in 2001 for ...De vuelta al barrio."}]},{"type":"paragraph","content":[{"type":"text","text":"A tambora at four","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Peralta dates his start to the age of four, when he built his first instrument, a tambora. Through the eighties and nineties he played percussion professionally: first with Grupo Fragmento, then seven years with "},{"type":"artistReference","attrs":{"occurrenceId":"7caf46c1-dc6b-4824-a68e-5a5570561958","artistId":"29832daf-f093-4ccb-820d-441cdc3f48c0","displayText":"Fernando Echavarría"}},{"type":"text","text":" and la Familia André, then in Trilogía, the fusion trio "},{"type":"artistReference","attrs":{"occurrenceId":"d515dcf4-9fc2-4eb6-96ce-34a005568454","artistId":"8769e02a-52d7-4818-ac19-e5dd46d7075f","displayText":"Juan Francisco Ordóñez"}},{"type":"text","text":" ran with the bassist Héctor Santana, and finally eight years with Juan Luis Guerra. He also wrote music for documentaries — Trujillo: el poder del Jefe III in 1996 and Camino a Higüey in 2016 — and for advertising."}]},{"type":"paragraph","content":[{"type":"text","text":"Son Familia","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His first album, Trópico adentro, came out in 1995. Pa’ otro la’o was launched internationally on 15 July 1997 with Peralta producing and arranging; \"Amor narcótico\", \"La ciguapa\" and \"Procura\" came off it, and over the following two years the record took gold and platinum certifications in Peru, Chile, Colombia, Bolivia and Central America. Cartagena gave him the keys to the city in June 1998."}]},{"type":"paragraph","content":[{"type":"text","text":"...De vuelta al barrio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The third album appeared on 18 April 2000 and won Best Merengue Album at the second Latin Grammy Awards, in 2001. It was recorded in Paris with the London Symphony Orchestra and the Luz África choirs, and set son against jazz, merengue against guaguancó, bachata against Brazilian and Arabic figures. "},{"type":"artistReference","attrs":{"occurrenceId":"3f304919-b60a-4ccc-9493-609d96560146","artistId":"bd3ad92b-1a26-48dd-a667-8a0debeaf5a3","displayText":"Jandy Feliz"}},{"type":"text","text":" had left to work on his own, and two singers came in to replace him: César Olarte, from Aruba, and René Geraldino."}]},{"type":"paragraph","content":[{"type":"text","text":"After","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Más que suficiente followed on 27 September 2005 and was nominated for Best Merengue/Bachata Album at the Latin Grammys of 2006; it was among the best-selling Latin records in Japan. In 2007 he was named a goodwill ambassador for the Dominican Republic. De aquel la’o del río came in 2009 carrying \"Amor samurái\", built from Caribbean music and traditional Japanese instruments, and De que viene, viene followed in 2012 and Máscara contra cabellera in 2013."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Peralta’s records are usually filed under world music for how much they take in: son with jazz, merengue with pop, African rhythms, hip hop, bachata, guaguancó, Brazilian and Arabic figures, symphonic textures, instruments from India and Japan. \"Amor narcótico\" was recorded again by the American group CNCO on their covers album Déjà Vu in 2021, twenty-four years after he released it."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'chichi-peralta'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'chichi-peralta' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f2675a1b-29b3-4078-9c46-4e30b5aa89ac', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'chichi-peralta' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7caf46c1-dc6b-4824-a68e-5a5570561958', 'artist', '29832daf-f093-4ccb-820d-441cdc3f48c0'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'chichi-peralta' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd515dcf4-9fc2-4eb6-96ce-34a005568454', 'artist', '8769e02a-52d7-4818-ac19-e5dd46d7075f'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'chichi-peralta' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3f304919-b60a-4ccc-9493-609d96560146', 'artist', 'bd3ad92b-1a26-48dd-a667-8a0debeaf5a3'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'chichi-peralta' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Chichi Peralta — Pedro René Peralta Soto, born in Santo Domingo on 9 July 1966 — is a Dominican percussionist, singer, composer, arranger and producer. He spent the 1980s and 1990s as a working percussionist, eight of those years in the band of Juan Luis Guerra 4.40, before launching Chichi Peralta y Son Familia and taking a Latin Grammy in 2001 for ...De vuelta al barrio.

**A tambora at four**

Peralta dates his start to the age of four, when he built his first instrument, a tambora. Through the eighties and nineties he played percussion professionally: first with Grupo Fragmento, then seven years with Fernando Echavarría and la Familia André, then in Trilogía, the fusion trio Juan Francisco Ordóñez ran with the bassist Héctor Santana, and finally eight years with Juan Luis Guerra. He also wrote music for documentaries — Trujillo: el poder del Jefe III in 1996 and Camino a Higüey in 2016 — and for advertising.

**Son Familia**

His first album, Trópico adentro, came out in 1995. Pa’ otro la’o was launched internationally on 15 July 1997 with Peralta producing and arranging; "Amor narcótico", "La ciguapa" and "Procura" came off it, and over the following two years the record took gold and platinum certifications in Peru, Chile, Colombia, Bolivia and Central America. Cartagena gave him the keys to the city in June 1998.

**...De vuelta al barrio**

The third album appeared on 18 April 2000 and won Best Merengue Album at the second Latin Grammy Awards, in 2001. It was recorded in Paris with the London Symphony Orchestra and the Luz África choirs, and set son against jazz, merengue against guaguancó, bachata against Brazilian and Arabic figures. Jandy Feliz had left to work on his own, and two singers came in to replace him: César Olarte, from Aruba, and René Geraldino.

**After**

Más que suficiente followed on 27 September 2005 and was nominated for Best Merengue/Bachata Album at the Latin Grammys of 2006; it was among the best-selling Latin records in Japan. In 2007 he was named a goodwill ambassador for the Dominican Republic. De aquel la’o del río came in 2009 carrying "Amor samurái", built from Caribbean music and traditional Japanese instruments, and De que viene, viene followed in 2012 and Máscara contra cabellera in 2013.

**Legacy**

Peralta’s records are usually filed under world music for how much they take in: son with jazz, merengue with pop, African rhythms, hip hop, bachata, guaguancó, Brazilian and Arabic figures, symphonic textures, instruments from India and Japan. "Amor narcótico" was recorded again by the American group CNCO on their covers album Déjà Vu in 2021, twenty-four years after he released it.' WHERE slug = 'chichi-peralta';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Chichi Peralta —Pedro René Peralta Soto, nacido en Santo Domingo el 9 de julio de 1966— es percusionista, cantante, compositor, arreglista y productor dominicano. Pasó los años ochenta y noventa como percusionista de oficio, ocho de ellos en la agrupación de "},{"type":"artistReference","attrs":{"occurrenceId":"84c0ede6-7573-463a-a491-dfad7198d51b","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":", antes de lanzar Chichi Peralta y Son Familia y ganar un Grammy Latino en 2001 por ...De vuelta al barrio."}]},{"type":"paragraph","content":[{"type":"text","text":"Una tambora a los cuatro años","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Peralta sitúa su comienzo a los cuatro años, cuando construyó su primer instrumento, una tambora. Por los ochenta y los noventa tocó percusión profesionalmente: primero en el Grupo Fragmento, después siete años con "},{"type":"artistReference","attrs":{"occurrenceId":"8a6593e7-e75f-473b-b607-7401a83893dd","artistId":"29832daf-f093-4ccb-820d-441cdc3f48c0","displayText":"Fernando Echavarría"}},{"type":"text","text":" y la Familia André, luego en Trilogía, el trío de fusión que llevaba "},{"type":"artistReference","attrs":{"occurrenceId":"42e6b522-b845-4fb6-a261-d3072ab921cd","artistId":"8769e02a-52d7-4818-ac19-e5dd46d7075f","displayText":"Juan Francisco Ordóñez"}},{"type":"text","text":" con el bajista Héctor Santana, y finalmente ocho años con Juan Luis Guerra. Compuso además música para documentales —Trujillo: el poder del Jefe III, de 1996, y Camino a Higüey, de 2016— y para publicidad."}]},{"type":"paragraph","content":[{"type":"text","text":"Son Familia","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su primer disco, Trópico adentro, salió en 1995. Pa’ otro la’o se lanzó internacionalmente el 15 de julio de 1997, con Peralta como productor y arreglista; de él salieron «Amor narcótico», «La ciguapa» y «Procura», y en los dos años siguientes el disco acumuló discos de oro y platino en Perú, Chile, Colombia, Bolivia y Centroamérica. Cartagena le entregó las llaves de la ciudad en junio de 1998."}]},{"type":"paragraph","content":[{"type":"text","text":"...De vuelta al barrio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El tercer álbum salió el 18 de abril de 2000 y ganó el Mejor Álbum de Merengue en la segunda edición de los Grammy Latinos, en 2001. Se grabó en París con la Orquesta Sinfónica de Londres y los coros de Luz África, y cruzó el son con el jazz, el merengue con el guaguancó y la bachata con figuras brasileñas y árabes. "},{"type":"artistReference","attrs":{"occurrenceId":"a36b2960-1358-499c-9bcd-f445c91996cb","artistId":"bd3ad92b-1a26-48dd-a667-8a0debeaf5a3","displayText":"Jandy Feliz"}},{"type":"text","text":" se había ido a trabajar por su cuenta, y entraron dos cantantes a sustituirlo: César Olarte, de Aruba, y René Geraldino."}]},{"type":"paragraph","content":[{"type":"text","text":"Después","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Más que suficiente salió el 27 de septiembre de 2005 y fue nominado a Mejor Álbum de Merengue/Bachata en los Grammy Latinos de 2006; estuvo entre las producciones latinas más vendidas en Japón. En 2007 fue declarado embajador de buena voluntad de la República Dominicana. De aquel la’o del río llegó en 2009 con «Amor samurái», armado con música caribeña e instrumentos tradicionales japoneses, y detrás vinieron De que viene, viene en 2012 y Máscara contra cabellera en 2013."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los discos de Peralta suelen archivarse como world music por todo lo que admiten: el son con el jazz, el merengue con el pop, ritmos africanos, hip hop, bachata, guaguancó, figuras brasileñas y árabes, texturas sinfónicas, instrumentos de la India y de Japón. «Amor narcótico» volvió a grabarse en 2021, veinticuatro años después, por el grupo estadounidense CNCO en su disco de versiones Déjà Vu."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'chichi-peralta'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'chichi-peralta' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '84c0ede6-7573-463a-a491-dfad7198d51b', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'chichi-peralta' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '8a6593e7-e75f-473b-b607-7401a83893dd', 'artist', '29832daf-f093-4ccb-820d-441cdc3f48c0'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'chichi-peralta' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '42e6b522-b845-4fb6-a261-d3072ab921cd', 'artist', '8769e02a-52d7-4818-ac19-e5dd46d7075f'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'chichi-peralta' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a36b2960-1358-499c-9bcd-f445c91996cb', 'artist', 'bd3ad92b-1a26-48dd-a667-8a0debeaf5a3'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'chichi-peralta' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Chichi Peralta —Pedro René Peralta Soto, nacido en Santo Domingo el 9 de julio de 1966— es percusionista, cantante, compositor, arreglista y productor dominicano. Pasó los años ochenta y noventa como percusionista de oficio, ocho de ellos en la agrupación de Juan Luis Guerra 4.40, antes de lanzar Chichi Peralta y Son Familia y ganar un Grammy Latino en 2001 por ...De vuelta al barrio.

**Una tambora a los cuatro años**

Peralta sitúa su comienzo a los cuatro años, cuando construyó su primer instrumento, una tambora. Por los ochenta y los noventa tocó percusión profesionalmente: primero en el Grupo Fragmento, después siete años con Fernando Echavarría y la Familia André, luego en Trilogía, el trío de fusión que llevaba Juan Francisco Ordóñez con el bajista Héctor Santana, y finalmente ocho años con Juan Luis Guerra. Compuso además música para documentales —Trujillo: el poder del Jefe III, de 1996, y Camino a Higüey, de 2016— y para publicidad.

**Son Familia**

Su primer disco, Trópico adentro, salió en 1995. Pa’ otro la’o se lanzó internacionalmente el 15 de julio de 1997, con Peralta como productor y arreglista; de él salieron «Amor narcótico», «La ciguapa» y «Procura», y en los dos años siguientes el disco acumuló discos de oro y platino en Perú, Chile, Colombia, Bolivia y Centroamérica. Cartagena le entregó las llaves de la ciudad en junio de 1998.

**...De vuelta al barrio**

El tercer álbum salió el 18 de abril de 2000 y ganó el Mejor Álbum de Merengue en la segunda edición de los Grammy Latinos, en 2001. Se grabó en París con la Orquesta Sinfónica de Londres y los coros de Luz África, y cruzó el son con el jazz, el merengue con el guaguancó y la bachata con figuras brasileñas y árabes. Jandy Feliz se había ido a trabajar por su cuenta, y entraron dos cantantes a sustituirlo: César Olarte, de Aruba, y René Geraldino.

**Después**

Más que suficiente salió el 27 de septiembre de 2005 y fue nominado a Mejor Álbum de Merengue/Bachata en los Grammy Latinos de 2006; estuvo entre las producciones latinas más vendidas en Japón. En 2007 fue declarado embajador de buena voluntad de la República Dominicana. De aquel la’o del río llegó en 2009 con «Amor samurái», armado con música caribeña e instrumentos tradicionales japoneses, y detrás vinieron De que viene, viene en 2012 y Máscara contra cabellera en 2013.

**Legado**

Los discos de Peralta suelen archivarse como world music por todo lo que admiten: el son con el jazz, el merengue con el pop, ritmos africanos, hip hop, bachata, guaguancó, figuras brasileñas y árabes, texturas sinfónicas, instrumentos de la India y de Japón. «Amor narcótico» volvió a grabarse en 2021, veinticuatro años después, por el grupo estadounidense CNCO en su disco de versiones Déjà Vu.' WHERE slug = 'chichi-peralta';

COMMIT;
