BEGIN;

-- Ficha de Kinito Méndez, SEGUNDA VERSIÓN.
--
-- La primera (20260909012100) siguió el orden de Wikipedia con dos bloques
-- permutados. Esta se organiza alrededor de una tesis propia —es compositor
-- antes que director— y usa material que aquel artículo no tiene:
--
--  * Vendió sus dos primeras composiciones, "Catalina" y "Casimiro", a la
--    orquesta de Richie Ricardo. Está en nuestra propia ficha de Richie
--    Ricardo y la primera versión no lo recogía.
--  * Rokabanda se fundó en 1992, con Bobby Rafael, el año en que los dos
--    dejaron la Cocoband, y ganó Orquesta Revelación del Año en los
--    Casandra. Nuestra ficha de Rokabanda lo documenta; la primera versión
--    puso 1991 copiando la relación invertida que había en la base.
--  * El "refranero popular" y el cálculo de unas 400 canciones son suyos,
--    de una entrevista en Fenomenal Magazine de abril de 2021.
--
-- Se corrige de paso el año de la relación founder_of con Rokabanda.

-- 1. Año de la fundación de Rokabanda
UPDATE artist_relationships r
   SET start_year = 1992,
       notes = 'Founded it with Bobby Rafael the year both left Pochy y su Cocoband; his first turn as bandleader'
  FROM artists k, artists b
 WHERE r.source_artist_id = k.id AND r.target_artist_id = b.id
   AND k.slug = 'kinito-mendez' AND b.slug = 'rokabanda' AND r.relationship_type = 'founder_of';

-- 2. Documentos editoriales, referencias y espejo markdown legacy
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Kinito Méndez — José del Carmen Ramírez Méndez, born in Padre Las Casas, Azua, on 18 November 1963 — is a Dominican composer and merengue singer. He puts his own output at around four hundred songs, and he wrote most of them for other people’s orchestras: he sold his first two to "},{"type":"artistReference","attrs":{"occurrenceId":"06903a50-ce33-4b06-a2d3-118452f28145","artistId":"4361e223-5102-4fee-be4a-05bea6281807","displayText":"Richie Ricardo"}},{"type":"text","text":", wrote a good part of what made "},{"type":"artistReference","attrs":{"occurrenceId":"be882d48-74f2-4dc5-a303-440621763127","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":" famous, founded "},{"type":"artistReference","attrs":{"occurrenceId":"7d69a564-21e8-4dd4-8786-b61da51fc282","artistId":"86172ade-a3b0-47e3-803b-f913afe8072c","displayText":"Rokabanda"}},{"type":"text","text":" and built "},{"type":"artistReference","attrs":{"occurrenceId":"ece7c8d1-ee00-41cb-a45c-4f31e595567f","artistId":"6fb949c4-2d6f-437f-8e7f-5f9efec847da","displayText":"Rikarena"}},{"type":"text","text":" for singers other than himself. He did not front a band under his own name until 1995."}]},{"type":"paragraph","content":[{"type":"text","text":"Catalina and Casimiro","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His entry into the business was as a supplier. He sold his first two compositions, \"Catalina\" and \"Casimiro\", to Richie Ricardo’s orchestra, which in those years served as a way in for a number of musicians and arrangers who later mattered — Pochy Familia and Bobby Rafael among them. By his own count he had been working professionally for thirty-four years by 2021, which places the start around 1987."}]},{"type":"paragraph","content":[{"type":"text","text":"The refranero popular","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Pochy Familia put the Cocoband together in 1988 and Méndez was there from the first lineup, singing and writing. What he says they brought to merengue was the refranero popular: the sayings people already had in their mouths, set to a dance rhythm. It worked at a scale the genre still quotes — around seventy consecutive hits between 1988 and 1995, with every track on the first seven albums landing. \"El cacu\", \"El coronel\", \"El boche\" and \"La manito\" are his from those years; the last of them turned up in Kindergarten Cop, the 1990 film with Arnold Schwarzenegger. His catchphrases went the same way as his songs: \"y eh, eh, loca que está\" is ordinary Dominican speech now."}]},{"type":"paragraph","content":[{"type":"text","text":"Two orchestras that were not his","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He founded Rikarena in 1990 and has written for it ever since without fronting it; the orchestra works a more romantic line than his own, and by 1999 it was doing better in Colombia than at home. Then in 1992 he and Bobby Rafael left the Cocoband to start Rokabanda — his first turn as bandleader — which took Orquesta Revelación del Año at the Premios Casandra in its first full season and put out \"El ají titi\", \"El vacano\", \"El cibaeño\", \"El tamarindo\", \"Rechenchén\" and \"Los hombres maduros\". He still plays Rokabanda nights and still calls the crowd rokabanderos."}]},{"type":"paragraph","content":[{"type":"text","text":"El hombre merengue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Only in 1995, after hits with three orchestras that carried other people’s names, did he release a record under his own: El hombre merengue. A dozen followed at roughly one every year or two — El decreto de Kinito Méndez (1997), A caballo (1998), Su amigo (1999), D’Colores (2000), A palo limpio (2001), Sigo siendo el hombre merengue (2002), Celebra conmigo (2004), Con sabor a mí (2006), La fábrica (2008). \"Cachamba\" and \"El hoyo\" are the ones he credits with opening Central and South America, and Colombia in particular. He recorded \"Me da tres pito\" with "},{"type":"artistReference","attrs":{"occurrenceId":"3bf50d24-a937-442b-a0ed-3028e7dfc218","artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"cda87d94-79cd-41c6-b36c-683b524249f5","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"El Vuelo 587","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"American Airlines Flight 587 came down in Queens on 12 November 2001, minutes after taking off for Santo Domingo; most of those aboard were Dominican. Méndez wrote part of the lyrics of \"El Vuelo 587\" and recorded it with Johnny Ventura."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Méndez sorts his own catalogue by subject rather than by record: love and its failures, tigueraje, cultural pieces built on palos, and social ones such as \"El asilo\". The through-line of the career is that the songs travelled under several different band names before they travelled under his, and that he has gone on writing for orchestras he does not lead."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'kinito-mendez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'kinito-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '06903a50-ce33-4b06-a2d3-118452f28145', 'artist', '4361e223-5102-4fee-be4a-05bea6281807'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'be882d48-74f2-4dc5-a303-440621763127', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7d69a564-21e8-4dd4-8786-b61da51fc282', 'artist', '86172ade-a3b0-47e3-803b-f913afe8072c'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ece7c8d1-ee00-41cb-a45c-4f31e595567f', 'artist', '6fb949c4-2d6f-437f-8e7f-5f9efec847da'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3bf50d24-a937-442b-a0ed-3028e7dfc218', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cda87d94-79cd-41c6-b36c-683b524249f5', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Kinito Méndez — José del Carmen Ramírez Méndez, born in Padre Las Casas, Azua, on 18 November 1963 — is a Dominican composer and merengue singer. He puts his own output at around four hundred songs, and he wrote most of them for other people’s orchestras: he sold his first two to Richie Ricardo, wrote a good part of what made Pochy y su Cocoband famous, founded Rokabanda and built Rikarena for singers other than himself. He did not front a band under his own name until 1995.

**Catalina and Casimiro**

His entry into the business was as a supplier. He sold his first two compositions, "Catalina" and "Casimiro", to Richie Ricardo’s orchestra, which in those years served as a way in for a number of musicians and arrangers who later mattered — Pochy Familia and Bobby Rafael among them. By his own count he had been working professionally for thirty-four years by 2021, which places the start around 1987.

**The refranero popular**

Pochy Familia put the Cocoband together in 1988 and Méndez was there from the first lineup, singing and writing. What he says they brought to merengue was the refranero popular: the sayings people already had in their mouths, set to a dance rhythm. It worked at a scale the genre still quotes — around seventy consecutive hits between 1988 and 1995, with every track on the first seven albums landing. "El cacu", "El coronel", "El boche" and "La manito" are his from those years; the last of them turned up in Kindergarten Cop, the 1990 film with Arnold Schwarzenegger. His catchphrases went the same way as his songs: "y eh, eh, loca que está" is ordinary Dominican speech now.

**Two orchestras that were not his**

He founded Rikarena in 1990 and has written for it ever since without fronting it; the orchestra works a more romantic line than his own, and by 1999 it was doing better in Colombia than at home. Then in 1992 he and Bobby Rafael left the Cocoband to start Rokabanda — his first turn as bandleader — which took Orquesta Revelación del Año at the Premios Casandra in its first full season and put out "El ají titi", "El vacano", "El cibaeño", "El tamarindo", "Rechenchén" and "Los hombres maduros". He still plays Rokabanda nights and still calls the crowd rokabanderos.

**El hombre merengue**

Only in 1995, after hits with three orchestras that carried other people’s names, did he release a record under his own: El hombre merengue. A dozen followed at roughly one every year or two — El decreto de Kinito Méndez (1997), A caballo (1998), Su amigo (1999), D’Colores (2000), A palo limpio (2001), Sigo siendo el hombre merengue (2002), Celebra conmigo (2004), Con sabor a mí (2006), La fábrica (2008). "Cachamba" and "El hoyo" are the ones he credits with opening Central and South America, and Colombia in particular. He recorded "Me da tres pito" with Johnny Ventura and Miriam Cruz.

**El Vuelo 587**

American Airlines Flight 587 came down in Queens on 12 November 2001, minutes after taking off for Santo Domingo; most of those aboard were Dominican. Méndez wrote part of the lyrics of "El Vuelo 587" and recorded it with Johnny Ventura.

**Legacy**

Méndez sorts his own catalogue by subject rather than by record: love and its failures, tigueraje, cultural pieces built on palos, and social ones such as "El asilo". The through-line of the career is that the songs travelled under several different band names before they travelled under his, and that he has gone on writing for orchestras he does not lead.' WHERE slug = 'kinito-mendez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Kinito Méndez —José del Carmen Ramírez Méndez, nacido en Padre Las Casas, Azua, el 18 de noviembre de 1963— es compositor y cantante de merengue dominicano. Él mismo calcula unas cuatrocientas canciones escritas, y la mayoría las hizo para orquestas ajenas: le vendió las dos primeras a "},{"type":"artistReference","attrs":{"occurrenceId":"670ae6fd-0325-4721-9337-c9f530cdd17c","artistId":"4361e223-5102-4fee-be4a-05bea6281807","displayText":"Richie Ricardo"}},{"type":"text","text":", escribió buena parte de lo que hizo famosa a "},{"type":"artistReference","attrs":{"occurrenceId":"51953d40-52b2-4490-b985-bc743e59ccb4","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":", fundó "},{"type":"artistReference","attrs":{"occurrenceId":"8aadb5ee-bfa7-4562-b4bf-8d173dbe4a71","artistId":"86172ade-a3b0-47e3-803b-f913afe8072c","displayText":"Rokabanda"}},{"type":"text","text":" y armó "},{"type":"artistReference","attrs":{"occurrenceId":"5d9c8b81-8f8d-4c64-8979-3422290302a3","artistId":"6fb949c4-2d6f-437f-8e7f-5f9efec847da","displayText":"Rikarena"}},{"type":"text","text":" para que cantaran otros. No encabezó una orquesta con su nombre hasta 1995."}]},{"type":"paragraph","content":[{"type":"text","text":"Catalina y Casimiro","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Entró al negocio como proveedor. Sus dos primeras composiciones, «Catalina» y «Casimiro», se las vendió a la orquesta de Richie Ricardo, que en esos años funcionó de puerta de entrada para varios músicos y arreglistas que después pesaron, entre ellos Pochy Familia y Bobby Rafael. Por su propia cuenta, en 2021 llevaba treinta y cuatro años de profesión, lo que sitúa el arranque hacia 1987."}]},{"type":"paragraph","content":[{"type":"text","text":"El refranero popular","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Pochy Familia armó la Cocoband en 1988 y Méndez estuvo desde la primera formación, cantando y escribiendo. Lo que según él le llevaron al merengue fue el refranero popular: los dichos que la gente ya tenía en la boca, puestos sobre ritmo de baile. Funcionó a una escala que el género todavía cita —cerca de setenta éxitos seguidos entre 1988 y 1995, con los siete primeros discos pegando de la primera a la última canción—. De esos años son suyas «El cacu», «El coronel», «El boche» y «La manito», que acabó en Kindergarten Cop, la película de 1990 con Arnold Schwarzenegger. Con sus muletillas pasó lo mismo que con sus canciones: «y eh, eh, loca que está» es habla dominicana corriente."}]},{"type":"paragraph","content":[{"type":"text","text":"Dos orquestas que no eran suyas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fundó Rikarena en 1990 y le escribe desde entonces sin encabezarla; la orquesta lleva una línea más romántica que la suya, y para 1999 le iba mejor en Colombia que en casa. Después, en 1992, él y Bobby Rafael dejaron la Cocoband para montar Rokabanda —su primera vez como director de orquesta—, que se llevó el premio a Orquesta Revelación del Año en los Casandra en su primera temporada completa y sacó «El ají titi», «El vacano», «El cibaeño», «El tamarindo», «Rechenchén» y «Los hombres maduros». Todavía hace noches de material de Rokabanda y todavía le dice rokabanderos a su público."}]},{"type":"paragraph","content":[{"type":"text","text":"El hombre merengue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Solo en 1995, después de pegar con tres orquestas que llevaban nombres ajenos, sacó un disco con el suyo: El hombre merengue. Detrás vino una docena, a razón de uno cada uno o dos años: El decreto de Kinito Méndez (1997), A caballo (1998), Su amigo (1999), D’Colores (2000), A palo limpio (2001), Sigo siendo el hombre merengue (2002), Celebra conmigo (2004), Con sabor a mí (2006), La fábrica (2008). «Cachamba» y «El hoyo» son las que él señala como las que le abrieron Centroamérica y Suramérica, y Colombia en particular. Grabó «Me da tres pito» con "},{"type":"artistReference","attrs":{"occurrenceId":"64a8f6d5-a714-45c2-89b7-fcd78e1456c1","artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"b2324568-d56c-437b-960b-332441d30381","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"El Vuelo 587","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El vuelo 587 de American Airlines cayó en Queens el 12 de noviembre de 2001, minutos después de despegar hacia Santo Domingo; la mayoría de quienes iban a bordo eran dominicanos. Méndez escribió parte de la letra de «El Vuelo 587» y la grabó con Johnny Ventura."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Méndez ordena su propio catálogo por asunto y no por disco: amor y desamor, tigueraje, piezas culturales levantadas sobre palos, y sociales como «El asilo». La línea que atraviesa la carrera es que sus canciones viajaron bajo varios nombres de banda antes de viajar bajo el suyo, y que sigue escribiendo para orquestas que no dirige."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'kinito-mendez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'kinito-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '670ae6fd-0325-4721-9337-c9f530cdd17c', 'artist', '4361e223-5102-4fee-be4a-05bea6281807'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '51953d40-52b2-4490-b985-bc743e59ccb4', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '8aadb5ee-bfa7-4562-b4bf-8d173dbe4a71', 'artist', '86172ade-a3b0-47e3-803b-f913afe8072c'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5d9c8b81-8f8d-4c64-8979-3422290302a3', 'artist', '6fb949c4-2d6f-437f-8e7f-5f9efec847da'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '64a8f6d5-a714-45c2-89b7-fcd78e1456c1', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b2324568-d56c-437b-960b-332441d30381', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Kinito Méndez —José del Carmen Ramírez Méndez, nacido en Padre Las Casas, Azua, el 18 de noviembre de 1963— es compositor y cantante de merengue dominicano. Él mismo calcula unas cuatrocientas canciones escritas, y la mayoría las hizo para orquestas ajenas: le vendió las dos primeras a Richie Ricardo, escribió buena parte de lo que hizo famosa a Pochy y su Cocoband, fundó Rokabanda y armó Rikarena para que cantaran otros. No encabezó una orquesta con su nombre hasta 1995.

**Catalina y Casimiro**

Entró al negocio como proveedor. Sus dos primeras composiciones, «Catalina» y «Casimiro», se las vendió a la orquesta de Richie Ricardo, que en esos años funcionó de puerta de entrada para varios músicos y arreglistas que después pesaron, entre ellos Pochy Familia y Bobby Rafael. Por su propia cuenta, en 2021 llevaba treinta y cuatro años de profesión, lo que sitúa el arranque hacia 1987.

**El refranero popular**

Pochy Familia armó la Cocoband en 1988 y Méndez estuvo desde la primera formación, cantando y escribiendo. Lo que según él le llevaron al merengue fue el refranero popular: los dichos que la gente ya tenía en la boca, puestos sobre ritmo de baile. Funcionó a una escala que el género todavía cita —cerca de setenta éxitos seguidos entre 1988 y 1995, con los siete primeros discos pegando de la primera a la última canción—. De esos años son suyas «El cacu», «El coronel», «El boche» y «La manito», que acabó en Kindergarten Cop, la película de 1990 con Arnold Schwarzenegger. Con sus muletillas pasó lo mismo que con sus canciones: «y eh, eh, loca que está» es habla dominicana corriente.

**Dos orquestas que no eran suyas**

Fundó Rikarena en 1990 y le escribe desde entonces sin encabezarla; la orquesta lleva una línea más romántica que la suya, y para 1999 le iba mejor en Colombia que en casa. Después, en 1992, él y Bobby Rafael dejaron la Cocoband para montar Rokabanda —su primera vez como director de orquesta—, que se llevó el premio a Orquesta Revelación del Año en los Casandra en su primera temporada completa y sacó «El ají titi», «El vacano», «El cibaeño», «El tamarindo», «Rechenchén» y «Los hombres maduros». Todavía hace noches de material de Rokabanda y todavía le dice rokabanderos a su público.

**El hombre merengue**

Solo en 1995, después de pegar con tres orquestas que llevaban nombres ajenos, sacó un disco con el suyo: El hombre merengue. Detrás vino una docena, a razón de uno cada uno o dos años: El decreto de Kinito Méndez (1997), A caballo (1998), Su amigo (1999), D’Colores (2000), A palo limpio (2001), Sigo siendo el hombre merengue (2002), Celebra conmigo (2004), Con sabor a mí (2006), La fábrica (2008). «Cachamba» y «El hoyo» son las que él señala como las que le abrieron Centroamérica y Suramérica, y Colombia en particular. Grabó «Me da tres pito» con Johnny Ventura y Miriam Cruz.

**El Vuelo 587**

El vuelo 587 de American Airlines cayó en Queens el 12 de noviembre de 2001, minutos después de despegar hacia Santo Domingo; la mayoría de quienes iban a bordo eran dominicanos. Méndez escribió parte de la letra de «El Vuelo 587» y la grabó con Johnny Ventura.

**Legado**

Méndez ordena su propio catálogo por asunto y no por disco: amor y desamor, tigueraje, piezas culturales levantadas sobre palos, y sociales como «El asilo». La línea que atraviesa la carrera es que sus canciones viajaron bajo varios nombres de banda antes de viajar bajo el suyo, y que sigue escribiendo para orquestas que no dirige.' WHERE slug = 'kinito-mendez';

COMMIT;
