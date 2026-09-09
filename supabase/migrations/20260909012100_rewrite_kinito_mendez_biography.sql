BEGIN;

-- Ficha de Kinito Méndez.
--
-- Apellidos corregidos. La fila tenía last_name "Méndez" y
-- second_last_name vacío. MusicBrainz lo trae tipado como Legal name
-- ("José del Carmen Ramírez", con sort-name "Ramírez, José del Carmen") y
-- Wikipedia (es) da la forma completa "José del Carmen Ramírez Méndez".
-- El apellido paterno es Ramírez; se le conoce por el materno.
--
-- Dos alias de banda retirados: "La Coco Band" y "La Rokabanda". Las dos
-- agrupaciones tienen fila propia y publicada, y Rokabanda ya lleva
-- "La Rokabanda" como alias suyo, que ahí sí corresponde. Es el mismo
-- patrón corregido en Héctor Acosta, Juan Francisco Ordóñez, Luis "Terror"
-- Días y Jandy Feliz.
--
-- Y una relación invertida: la base decía
--   Rokabanda --founder_of--> Kinito Méndez
-- o sea la banda como fundadora de su fundador.

-- 1. Apellidos y alias
UPDATE artists
   SET last_name        = 'Ramírez',
       second_last_name = 'Méndez',
       aliases          = array_remove(array_remove(aliases, 'La Coco Band'), 'La Rokabanda')
 WHERE slug = 'kinito-mendez';

-- 2. Relaciones de agrupación
DELETE FROM artist_relationships r USING artists b, artists k
 WHERE r.source_artist_id = b.id AND r.target_artist_id = k.id
   AND b.slug = 'rokabanda' AND k.slug = 'kinito-mendez' AND r.relationship_type = 'founder_of';
INSERT INTO artist_relationships (source_artist_id, target_artist_id, relationship_type, start_year, end_year, notes)
SELECT k.id, g.id, 'founder_of', 1991, 1995, 'Founded it and led it between the Coco Band and his solo career'
  FROM artists k, artists g WHERE k.slug = 'kinito-mendez' AND g.slug = 'rokabanda'
   AND NOT EXISTS (SELECT 1 FROM artist_relationships r WHERE r.source_artist_id = k.id
                     AND r.target_artist_id = g.id AND r.relationship_type = 'founder_of');
INSERT INTO artist_relationships (source_artist_id, target_artist_id, relationship_type, start_year, end_year, notes)
SELECT k.id, g.id, 'founder_of', 1990, NULL, 'Founded it and writes for it; does not front it'
  FROM artists k, artists g WHERE k.slug = 'kinito-mendez' AND g.slug = 'rikarena'
   AND NOT EXISTS (SELECT 1 FROM artist_relationships r WHERE r.source_artist_id = k.id
                     AND r.target_artist_id = g.id AND r.relationship_type = 'founder_of');
INSERT INTO artist_relationships (source_artist_id, target_artist_id, relationship_type, start_year, end_year, notes)
SELECT k.id, g.id, 'member_of', NULL, NULL, 'Singer; where he began, with "El cacu", "El coronel", "El boche" and "La manito"'
  FROM artists k, artists g WHERE k.slug = 'kinito-mendez' AND g.slug = 'pochy-y-su-cocoband'
   AND NOT EXISTS (SELECT 1 FROM artist_relationships r WHERE r.source_artist_id = k.id
                     AND r.target_artist_id = g.id AND r.relationship_type = 'member_of');

-- 3. Documentos editoriales, referencias y espejo markdown legacy
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Kinito Méndez — José del Carmen Ramírez Méndez, born in Padre Las Casas, Azua, on 18 November 1963 — is a Dominican merengue singer and composer. He sang with "},{"type":"artistReference","attrs":{"occurrenceId":"21cca750-6112-4468-9c49-906a0a612abc","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":" and then with "},{"type":"artistReference","attrs":{"occurrenceId":"2b5a4123-f6ed-4980-9f0a-10d87c824f5a","artistId":"86172ade-a3b0-47e3-803b-f913afe8072c","displayText":"Rokabanda"}},{"type":"text","text":" before going out under his own name in 1995 with El hombre merengue. He also founded and writes for a second orchestra, "},{"type":"artistReference","attrs":{"occurrenceId":"1d266a16-2d39-4f47-b0ee-27c01ff7a99f","artistId":"6fb949c4-2d6f-437f-8e7f-5f9efec847da","displayText":"Rikarena"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"La Coco Band","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Méndez began his career in Pochy y su Cocoband, where he sang \"El cacu\", \"El coronel\", \"El boche\" and \"La manito\". The last of those travelled unusually far for a merengue: it was used in Kindergarten Cop, the 1990 film with Arnold Schwarzenegger."}]},{"type":"paragraph","content":[{"type":"text","text":"Rokabanda","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He left and founded Rokabanda, which he ran from 1991 to 1995, and where \"El tamarindo\", \"Rechenchén\", \"El llorón\" and \"Los hombres maduros\" came out."}]},{"type":"paragraph","content":[{"type":"text","text":"El hombre merengue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1995 he went solo with El hombre merengue and kept up a record every year or two through the following decade: El decreto de Kinito Méndez (1997), A caballo (1998), Su amigo (1999), D’Colores (2000), A palo limpio (2001), Sigo siendo el hombre merengue (2002), Celebra conmigo (2004), Con sabor a mí (2006) and La fábrica (2008). \"Cachamba\", \"El baile del sua sua\", \"El suero de amor\" and \"Hony tu si Jony\" are among the ones that stayed. He recorded \"Me da tres pito\" with "},{"type":"artistReference","attrs":{"occurrenceId":"90f60760-b8de-4997-8d96-0af94246a412","artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"ca1b2209-d2c8-455d-ac67-bd3ee9912ba6","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Rikarena","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He founded Rikarena in 1990 and has written for it since. The orchestra works a more romantic line than his own, with a similar rhythmic signature, and by 1999 it was doing better in Colombia than at home, playing there more often than in the Dominican Republic."}]},{"type":"paragraph","content":[{"type":"text","text":"El Vuelo 587","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"American Airlines Flight 587 came down in Queens on 12 November 2001, minutes after taking off for Santo Domingo; most of those on board were Dominican. Méndez wrote part of the lyrics of \"El Vuelo 587\" and recorded it with Johnny Ventura."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Méndez has spent his career writing merengue that reports on ordinary Dominican life — the neighbourhood, the job, the argument, the holiday — and his records are among those that come back every December. He has written as much for other people’s orchestras as for his own, and Rikarena, which he founded and does not front, is the clearest case of it."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'kinito-mendez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'kinito-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '21cca750-6112-4468-9c49-906a0a612abc', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2b5a4123-f6ed-4980-9f0a-10d87c824f5a', 'artist', '86172ade-a3b0-47e3-803b-f913afe8072c'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '1d266a16-2d39-4f47-b0ee-27c01ff7a99f', 'artist', '6fb949c4-2d6f-437f-8e7f-5f9efec847da'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '90f60760-b8de-4997-8d96-0af94246a412', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ca1b2209-d2c8-455d-ac67-bd3ee9912ba6', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Kinito Méndez — José del Carmen Ramírez Méndez, born in Padre Las Casas, Azua, on 18 November 1963 — is a Dominican merengue singer and composer. He sang with Pochy y su Cocoband and then with Rokabanda before going out under his own name in 1995 with El hombre merengue. He also founded and writes for a second orchestra, Rikarena.

**La Coco Band**

Méndez began his career in Pochy y su Cocoband, where he sang "El cacu", "El coronel", "El boche" and "La manito". The last of those travelled unusually far for a merengue: it was used in Kindergarten Cop, the 1990 film with Arnold Schwarzenegger.

**Rokabanda**

He left and founded Rokabanda, which he ran from 1991 to 1995, and where "El tamarindo", "Rechenchén", "El llorón" and "Los hombres maduros" came out.

**El hombre merengue**

In 1995 he went solo with El hombre merengue and kept up a record every year or two through the following decade: El decreto de Kinito Méndez (1997), A caballo (1998), Su amigo (1999), D’Colores (2000), A palo limpio (2001), Sigo siendo el hombre merengue (2002), Celebra conmigo (2004), Con sabor a mí (2006) and La fábrica (2008). "Cachamba", "El baile del sua sua", "El suero de amor" and "Hony tu si Jony" are among the ones that stayed. He recorded "Me da tres pito" with Johnny Ventura and Miriam Cruz.

**Rikarena**

He founded Rikarena in 1990 and has written for it since. The orchestra works a more romantic line than his own, with a similar rhythmic signature, and by 1999 it was doing better in Colombia than at home, playing there more often than in the Dominican Republic.

**El Vuelo 587**

American Airlines Flight 587 came down in Queens on 12 November 2001, minutes after taking off for Santo Domingo; most of those on board were Dominican. Méndez wrote part of the lyrics of "El Vuelo 587" and recorded it with Johnny Ventura.

**Legacy**

Méndez has spent his career writing merengue that reports on ordinary Dominican life — the neighbourhood, the job, the argument, the holiday — and his records are among those that come back every December. He has written as much for other people’s orchestras as for his own, and Rikarena, which he founded and does not front, is the clearest case of it.' WHERE slug = 'kinito-mendez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Kinito Méndez —José del Carmen Ramírez Méndez, nacido en Padre Las Casas, Azua, el 18 de noviembre de 1963— es cantante y compositor de merengue dominicano. Cantó en "},{"type":"artistReference","attrs":{"occurrenceId":"7e6fb8f4-dae3-4d2f-b353-6bda162bfb4b","artistId":"001831dd-3baa-4512-88f5-f420ec7c2619","displayText":"Pochy y su Cocoband"}},{"type":"text","text":" y después en "},{"type":"artistReference","attrs":{"occurrenceId":"260d5f5f-8377-4426-960a-de19888c780c","artistId":"86172ade-a3b0-47e3-803b-f913afe8072c","displayText":"Rokabanda"}},{"type":"text","text":" antes de salir con su propio nombre en 1995 con El hombre merengue. Fundó además una segunda orquesta, para la que compone: "},{"type":"artistReference","attrs":{"occurrenceId":"b1deb7df-2066-4dbd-b402-91a860e1a256","artistId":"6fb949c4-2d6f-437f-8e7f-5f9efec847da","displayText":"Rikarena"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"La Coco Band","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Méndez empezó su carrera en Pochy y su Cocoband, donde cantó «El cacu», «El coronel», «El boche» y «La manito». Esta última viajó más lejos de lo que suele viajar un merengue: se usó en Kindergarten Cop, la película de 1990 con Arnold Schwarzenegger."}]},{"type":"paragraph","content":[{"type":"text","text":"Rokabanda","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Salió de allí y fundó Rokabanda, que dirigió de 1991 a 1995 y de donde salieron «El tamarindo», «Rechenchén», «El llorón» y «Los hombres maduros»."}]},{"type":"paragraph","content":[{"type":"text","text":"El hombre merengue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1995 se lanzó solo con El hombre merengue y sostuvo un disco cada uno o dos años durante la década siguiente: El decreto de Kinito Méndez (1997), A caballo (1998), Su amigo (1999), D’Colores (2000), A palo limpio (2001), Sigo siendo el hombre merengue (2002), Celebra conmigo (2004), Con sabor a mí (2006) y La fábrica (2008). Entre las que se quedaron están «Cachamba», «El baile del sua sua», «El suero de amor» y «Hony tu si Jony». Grabó «Me da tres pito» con "},{"type":"artistReference","attrs":{"occurrenceId":"dee71c34-3918-41dd-9e07-9f13c79e5bfd","artistId":"3f8bafec-e5ee-415d-8405-9551cceeeb9b","displayText":"Johnny Ventura"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"e8ad49e4-2661-45f2-892a-2829c09166cf","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Rikarena","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fundó Rikarena en 1990 y compone para ella desde entonces. La orquesta lleva una línea más romántica que la suya, con un sello rítmico parecido, y para 1999 le iba mejor en Colombia que en casa: se presentaba allá más seguido que en la República Dominicana."}]},{"type":"paragraph","content":[{"type":"text","text":"El Vuelo 587","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El vuelo 587 de American Airlines cayó en Queens el 12 de noviembre de 2001, minutos después de despegar hacia Santo Domingo; la mayoría de quienes iban a bordo eran dominicanos. Méndez escribió parte de la letra de «El Vuelo 587» y la grabó con Johnny Ventura."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Méndez ha hecho carrera escribiendo merengue que reporta la vida dominicana corriente —el barrio, el trabajo, la discusión, la fiesta—, y sus discos están entre los que vuelven cada diciembre. Ha compuesto tanto para orquestas ajenas como para la propia, y Rikarena, que fundó y no encabeza, es el caso más claro."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'kinito-mendez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'kinito-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7e6fb8f4-dae3-4d2f-b353-6bda162bfb4b', 'artist', '001831dd-3baa-4512-88f5-f420ec7c2619'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '260d5f5f-8377-4426-960a-de19888c780c', 'artist', '86172ade-a3b0-47e3-803b-f913afe8072c'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b1deb7df-2066-4dbd-b402-91a860e1a256', 'artist', '6fb949c4-2d6f-437f-8e7f-5f9efec847da'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dee71c34-3918-41dd-9e07-9f13c79e5bfd', 'artist', '3f8bafec-e5ee-415d-8405-9551cceeeb9b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e8ad49e4-2661-45f2-892a-2829c09166cf', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'kinito-mendez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Kinito Méndez —José del Carmen Ramírez Méndez, nacido en Padre Las Casas, Azua, el 18 de noviembre de 1963— es cantante y compositor de merengue dominicano. Cantó en Pochy y su Cocoband y después en Rokabanda antes de salir con su propio nombre en 1995 con El hombre merengue. Fundó además una segunda orquesta, para la que compone: Rikarena.

**La Coco Band**

Méndez empezó su carrera en Pochy y su Cocoband, donde cantó «El cacu», «El coronel», «El boche» y «La manito». Esta última viajó más lejos de lo que suele viajar un merengue: se usó en Kindergarten Cop, la película de 1990 con Arnold Schwarzenegger.

**Rokabanda**

Salió de allí y fundó Rokabanda, que dirigió de 1991 a 1995 y de donde salieron «El tamarindo», «Rechenchén», «El llorón» y «Los hombres maduros».

**El hombre merengue**

En 1995 se lanzó solo con El hombre merengue y sostuvo un disco cada uno o dos años durante la década siguiente: El decreto de Kinito Méndez (1997), A caballo (1998), Su amigo (1999), D’Colores (2000), A palo limpio (2001), Sigo siendo el hombre merengue (2002), Celebra conmigo (2004), Con sabor a mí (2006) y La fábrica (2008). Entre las que se quedaron están «Cachamba», «El baile del sua sua», «El suero de amor» y «Hony tu si Jony». Grabó «Me da tres pito» con Johnny Ventura y Miriam Cruz.

**Rikarena**

Fundó Rikarena en 1990 y compone para ella desde entonces. La orquesta lleva una línea más romántica que la suya, con un sello rítmico parecido, y para 1999 le iba mejor en Colombia que en casa: se presentaba allá más seguido que en la República Dominicana.

**El Vuelo 587**

El vuelo 587 de American Airlines cayó en Queens el 12 de noviembre de 2001, minutos después de despegar hacia Santo Domingo; la mayoría de quienes iban a bordo eran dominicanos. Méndez escribió parte de la letra de «El Vuelo 587» y la grabó con Johnny Ventura.

**Legado**

Méndez ha hecho carrera escribiendo merengue que reporta la vida dominicana corriente —el barrio, el trabajo, la discusión, la fiesta—, y sus discos están entre los que vuelven cada diciembre. Ha compuesto tanto para orquestas ajenas como para la propia, y Rikarena, que fundó y no encabeza, es el caso más claro.' WHERE slug = 'kinito-mendez';

COMMIT;
