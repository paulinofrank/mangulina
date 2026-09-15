BEGIN;

-- Ficha de Amarfis y La Banda de Atakke.
--
-- La biografía de relleno se contradecía a sí misma: llamaba a Amarfis "Sabana Grande de
-- Boyá-born" en el texto mientras la fila guardaba birth_place='Nueva York'. Corregido a
-- Sabana Grande de Boyá / Monte Plata. formation_year fijado en 1998.

UPDATE artists SET birth_place = 'Sabana Grande de Boyá', province = 'Monte Plata', formation_year = 1998
       WHERE slug = 'amarfis-y-la-banda-de-atakke';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Amarfis y La Banda de Atakke is a Dominican merengue de calle and mambo band fronted by Amarfis Aquino, formed in New York in 1998 and among the genre’s most durable acts on the Dominican diaspora circuit."}]},{"type":"paragraph","content":[{"type":"text","text":"Amarfis Aquino","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Born in Sabana Grande de Boyá, in what is now Monte Plata province, Aquino moved to New York as a teenager in the mid-1980s, where he studied engineering and music at City College and trained privately in jazz, R&B, Afro-Caribbean rhythm and composition. He first made his name as an arranger and director for Grupo Flash before writing and arranging hits for "},{"type":"artistReference","attrs":{"occurrenceId":"29edc80c-f546-4ea4-bb6f-6c7db9680d24","artistId":"3936e42a-8f2c-407d-9903-553128ea76b3","displayText":"Ricky Castro y su Banda Soberbia"}},{"type":"text","text":" («El Sun Sun», «La Vecina») and building a client list of merengue de calle acts before starting a band of his own."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Banda de Atakke»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The band debuted in 1998 with singles including «El Liqueo» and «Los Grilleros», riding the same wave of horn-driven, street-level merengue that produced acts like Fulanito and Proyecto Uno out of New York’s Dominican community. It went on to record some of the genre’s most recognizable dance hits, among them «El Pollo», from the 2009 album «7ma Sinfonía de Mambo», and «La Langosta»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"More than two decades after its debut, Amarfis y La Banda de Atakke remains a fixture of merengue de calle’s New York-born, horn-and-percussion sound, still drawing crowds on both sides of the Dominican diaspora."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'amarfis-y-la-banda-de-atakke'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'amarfis-y-la-banda-de-atakke' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '29edc80c-f546-4ea4-bb6f-6c7db9680d24', 'artist', '3936e42a-8f2c-407d-9903-553128ea76b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'amarfis-y-la-banda-de-atakke' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Amarfis y La Banda de Atakke is a Dominican merengue de calle and mambo band fronted by Amarfis Aquino, formed in New York in 1998 and among the genre’s most durable acts on the Dominican diaspora circuit.

**Amarfis Aquino**

Born in Sabana Grande de Boyá, in what is now Monte Plata province, Aquino moved to New York as a teenager in the mid-1980s, where he studied engineering and music at City College and trained privately in jazz, R&B, Afro-Caribbean rhythm and composition. He first made his name as an arranger and director for Grupo Flash before writing and arranging hits for Ricky Castro y su Banda Soberbia («El Sun Sun», «La Vecina») and building a client list of merengue de calle acts before starting a band of his own.

**«La Banda de Atakke»**

The band debuted in 1998 with singles including «El Liqueo» and «Los Grilleros», riding the same wave of horn-driven, street-level merengue that produced acts like Fulanito and Proyecto Uno out of New York’s Dominican community. It went on to record some of the genre’s most recognizable dance hits, among them «El Pollo», from the 2009 album «7ma Sinfonía de Mambo», and «La Langosta».

**Legacy**

More than two decades after its debut, Amarfis y La Banda de Atakke remains a fixture of merengue de calle’s New York-born, horn-and-percussion sound, still drawing crowds on both sides of the Dominican diaspora.' WHERE slug = 'amarfis-y-la-banda-de-atakke';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Amarfis y La Banda de Atakke es una agrupación dominicana de merengue de calle y mambo liderada por Amarfis Aquino, formada en Nueva York en 1998 y una de las más duraderas del género en el circuito de la diáspora dominicana."}]},{"type":"paragraph","content":[{"type":"text","text":"Amarfis Aquino","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Nacido en Sabana Grande de Boyá, hoy provincia de Monte Plata, Aquino se mudó a Nueva York en su adolescencia, a mediados de los años ochenta, donde estudió ingeniería y música en el City College y se formó de manera privada en jazz, R&B, ritmo afrocaribeño y composición. Se dio a conocer primero como arreglista y director de Grupo Flash, antes de escribir y arreglar éxitos para "},{"type":"artistReference","attrs":{"occurrenceId":"3130d4f4-cc70-4275-9b28-ebb9bd3c2ae4","artistId":"3936e42a-8f2c-407d-9903-553128ea76b3","displayText":"Ricky Castro y su Banda Soberbia"}},{"type":"text","text":" («El Sun Sun», «La Vecina») y construir una cartera de clientes del merengue de calle antes de formar su propia banda."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Banda de Atakke»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La agrupación debutó en 1998 con sencillos como «El Liqueo» y «Los Grilleros», dentro de la misma ola de merengue urbano de metales y calle que dio a agrupaciones como Fulanito y Proyecto Uno desde la comunidad dominicana de Nueva York. Con el tiempo grabó algunos de los bailables más reconocibles del género, entre ellos «El Pollo», del álbum de 2009 «7ma Sinfonía de Mambo», y «La Langosta»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Más de dos décadas después de su debut, Amarfis y La Banda de Atakke sigue siendo un referente del sonido de metales y percusión del merengue de calle nacido en Nueva York, convocando público a ambos lados de la diáspora dominicana."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'amarfis-y-la-banda-de-atakke'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'amarfis-y-la-banda-de-atakke' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3130d4f4-cc70-4275-9b28-ebb9bd3c2ae4', 'artist', '3936e42a-8f2c-407d-9903-553128ea76b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'amarfis-y-la-banda-de-atakke' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Amarfis y La Banda de Atakke es una agrupación dominicana de merengue de calle y mambo liderada por Amarfis Aquino, formada en Nueva York en 1998 y una de las más duraderas del género en el circuito de la diáspora dominicana.

**Amarfis Aquino**

Nacido en Sabana Grande de Boyá, hoy provincia de Monte Plata, Aquino se mudó a Nueva York en su adolescencia, a mediados de los años ochenta, donde estudió ingeniería y música en el City College y se formó de manera privada en jazz, R&B, ritmo afrocaribeño y composición. Se dio a conocer primero como arreglista y director de Grupo Flash, antes de escribir y arreglar éxitos para Ricky Castro y su Banda Soberbia («El Sun Sun», «La Vecina») y construir una cartera de clientes del merengue de calle antes de formar su propia banda.

**«La Banda de Atakke»**

La agrupación debutó en 1998 con sencillos como «El Liqueo» y «Los Grilleros», dentro de la misma ola de merengue urbano de metales y calle que dio a agrupaciones como Fulanito y Proyecto Uno desde la comunidad dominicana de Nueva York. Con el tiempo grabó algunos de los bailables más reconocibles del género, entre ellos «El Pollo», del álbum de 2009 «7ma Sinfonía de Mambo», y «La Langosta».

**Legado**

Más de dos décadas después de su debut, Amarfis y La Banda de Atakke sigue siendo un referente del sonido de metales y percusión del merengue de calle nacido en Nueva York, convocando público a ambos lados de la diáspora dominicana.' WHERE slug = 'amarfis-y-la-banda-de-atakke';

COMMIT;
