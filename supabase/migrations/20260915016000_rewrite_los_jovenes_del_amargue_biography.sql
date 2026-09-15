BEGIN;

-- Ficha de Los Jóvenes del Amargue.
--
-- La biografía de relleno eran dos frases genéricas sin nombrar a ningún integrante,
-- canción ni la conexión con El Chaval de la Bachata -su hecho más notable-.
-- formation_year fijado en 1994.

UPDATE artists SET formation_year = 1994 WHERE slug = 'los-jovenes-del-amargue';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Los Jóvenes del Amargue was a Dominican child and teenage bachata group formed in Santiago in 1994, best known today as the group that launched the career of "},{"type":"artistReference","attrs":{"occurrenceId":"c827f2bc-a32f-4455-a38f-0261da8bdb99","artistId":"8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6","displayText":"El Chaval de la Bachata"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los Infantiles del Amargue»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The group began under the name Los Infantiles del Amargue, led by Juan Tavárez with his eight-year-old son Joel on guitar; they recruited the thirteen-year-old Linar Espinal as lead singer and second guitar. Their debut, «Si te vas», was recorded for the producer Nepo Núñez and included «Si te vas», «No me debes» and «Te fuiste», followed the same year by «Amor de mis sueños… ahora sí más mambo»."}]},{"type":"paragraph","content":[{"type":"text","text":"A change of name","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As its members grew older, the group became Los Jóvenes del Amargue around 1996, continuing to record for Núñez’s label with songs including «No te alejes corazón», «Te quiero te adoro» and «Amor prefiero morir»."}]},{"type":"paragraph","content":[{"type":"text","text":"The end of an era","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1997, after three years fronting the group, Espinal left to record under his own name, El Chaval de la Bachata, taking with him the sound and following the group had built."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los Jóvenes del Amargue is remembered less for a catalogue of its own than for what came out of it: a teenage bachata group that gave one of the genre’s enduring names his start, in keeping with a Dominican tradition of child and teen ensembles as a training ground for future stars."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'los-jovenes-del-amargue'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'los-jovenes-del-amargue' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c827f2bc-a32f-4455-a38f-0261da8bdb99', 'artist', '8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-jovenes-del-amargue' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Los Jóvenes del Amargue was a Dominican child and teenage bachata group formed in Santiago in 1994, best known today as the group that launched the career of El Chaval de la Bachata.

**«Los Infantiles del Amargue»**

The group began under the name Los Infantiles del Amargue, led by Juan Tavárez with his eight-year-old son Joel on guitar; they recruited the thirteen-year-old Linar Espinal as lead singer and second guitar. Their debut, «Si te vas», was recorded for the producer Nepo Núñez and included «Si te vas», «No me debes» and «Te fuiste», followed the same year by «Amor de mis sueños… ahora sí más mambo».

**A change of name**

As its members grew older, the group became Los Jóvenes del Amargue around 1996, continuing to record for Núñez’s label with songs including «No te alejes corazón», «Te quiero te adoro» and «Amor prefiero morir».

**The end of an era**

In 1997, after three years fronting the group, Espinal left to record under his own name, El Chaval de la Bachata, taking with him the sound and following the group had built.

**Legacy**

Los Jóvenes del Amargue is remembered less for a catalogue of its own than for what came out of it: a teenage bachata group that gave one of the genre’s enduring names his start, in keeping with a Dominican tradition of child and teen ensembles as a training ground for future stars.' WHERE slug = 'los-jovenes-del-amargue';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Los Jóvenes del Amargue fue una agrupación dominicana de bachata infantil y juvenil formada en Santiago en 1994, conocida hoy sobre todo por ser el grupo que lanzó la carrera de "},{"type":"artistReference","attrs":{"occurrenceId":"11b3577b-c32a-45ee-a25e-73dddda4dd90","artistId":"8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6","displayText":"El Chaval de la Bachata"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los Infantiles del Amargue»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El grupo comenzó bajo el nombre Los Infantiles del Amargue, liderado por Juan Tavárez con su hijo Joel, de ocho años, en la guitarra; reclutaron al entonces adolescente de trece años Linar Espinal como voz principal y segunda guitarra. Su debut, «Si te vas», se grabó para el productor Nepo Núñez e incluyó «Si te vas», «No me debes» y «Te fuiste», seguido ese mismo año de «Amor de mis sueños… ahora sí más mambo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Un cambio de nombre","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A medida que sus integrantes crecían, el grupo pasó a llamarse Los Jóvenes del Amargue hacia 1996, y siguió grabando para el sello de Núñez con temas como «No te alejes corazón», «Te quiero te adoro» y «Amor prefiero morir»."}]},{"type":"paragraph","content":[{"type":"text","text":"El fin de una etapa","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1997, tras tres años al frente del grupo, Espinal se marchó para grabar bajo su propio nombre artístico, El Chaval de la Bachata, llevándose consigo el sonido y el público que el grupo había construido."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A Los Jóvenes del Amargue se le recuerda menos por un catálogo propio que por lo que salió de él: una agrupación juvenil de bachata que le dio su primer paso a uno de los nombres duraderos del género, dentro de una tradición dominicana de conjuntos infantiles y juveniles como cantera de futuras estrellas."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'los-jovenes-del-amargue'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'los-jovenes-del-amargue' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '11b3577b-c32a-45ee-a25e-73dddda4dd90', 'artist', '8be8c38c-e6a5-4e0d-83d1-8c8d20813ce6' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'los-jovenes-del-amargue' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Los Jóvenes del Amargue fue una agrupación dominicana de bachata infantil y juvenil formada en Santiago en 1994, conocida hoy sobre todo por ser el grupo que lanzó la carrera de El Chaval de la Bachata.

**«Los Infantiles del Amargue»**

El grupo comenzó bajo el nombre Los Infantiles del Amargue, liderado por Juan Tavárez con su hijo Joel, de ocho años, en la guitarra; reclutaron al entonces adolescente de trece años Linar Espinal como voz principal y segunda guitarra. Su debut, «Si te vas», se grabó para el productor Nepo Núñez e incluyó «Si te vas», «No me debes» y «Te fuiste», seguido ese mismo año de «Amor de mis sueños… ahora sí más mambo».

**Un cambio de nombre**

A medida que sus integrantes crecían, el grupo pasó a llamarse Los Jóvenes del Amargue hacia 1996, y siguió grabando para el sello de Núñez con temas como «No te alejes corazón», «Te quiero te adoro» y «Amor prefiero morir».

**El fin de una etapa**

En 1997, tras tres años al frente del grupo, Espinal se marchó para grabar bajo su propio nombre artístico, El Chaval de la Bachata, llevándose consigo el sonido y el público que el grupo había construido.

**Legado**

A Los Jóvenes del Amargue se le recuerda menos por un catálogo propio que por lo que salió de él: una agrupación juvenil de bachata que le dio su primer paso a uno de los nombres duraderos del género, dentro de una tradición dominicana de conjuntos infantiles y juveniles como cantera de futuras estrellas.' WHERE slug = 'los-jovenes-del-amargue';

COMMIT;
