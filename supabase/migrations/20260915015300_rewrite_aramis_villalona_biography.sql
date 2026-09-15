BEGIN;

-- Ficha de Aramis Villalona.
--
-- La biografía de relleno no nombraba a la Orquesta Fernando Villalona, a sus hermanos, ni
-- ninguna canción o álbum. second_last_name añadido (Évora, por consistencia con sus
-- hermanos ya publicados, cuya madre es Virginia Arcadia Évora).

UPDATE artists SET second_last_name = 'Évora' WHERE slug = 'aramis-villalona';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Aramis Villalona is a Dominican merengue singer and composer from Loma de Cabrera, in the northwestern province of Dajabón, one of the many children of Ángel Ramón Villalona and Virginia Arcadia Évora and a younger brother of "},{"type":"artistReference","attrs":{"occurrenceId":"a5b14f60-94c9-40cb-a2cc-dafb0273bd8f","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"0385f0a2-9175-431f-845d-7ec599b877f0","artistId":"e82dde2c-19a8-4138-b337-800296c425d4","displayText":"Angelito Villalona"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Orquesta Fernando Villalona","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began his professional career in the early 1980s inside his brother’s orchestra, where he sang lead on «Cerveza y Mesa», a José L. Carballo composition from the 1986 album «Para mi pueblo todo», and, in 1989, on «Agua de coco» — both of which became lasting merengue standards under the Villalona name."}]},{"type":"paragraph","content":[{"type":"text","text":"Solo career","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"After more than a decade and a half as a featured voice in his brother’s band, he formed his own dance orchestra in the late 1990s, recording dancefloor hits such as «La toita» and «A la roca» and, later, the more romantic «Solo tú», carrying the orquesta-style merengue of the 1980s into later decades and touring the Dominican circuit and its diaspora abroad."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"From coming up in one of Dominican merengue’s defining family orchestras to leading his own for decades after, Aramis Villalona has kept the horn-driven merengue de orquesta of his generation in circulation for dancers who grew up on it and for the ones who came after."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'aramis-villalona'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'aramis-villalona' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a5b14f60-94c9-40cb-a2cc-dafb0273bd8f', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'aramis-villalona' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0385f0a2-9175-431f-845d-7ec599b877f0', 'artist', 'e82dde2c-19a8-4138-b337-800296c425d4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'aramis-villalona' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Aramis Villalona is a Dominican merengue singer and composer from Loma de Cabrera, in the northwestern province of Dajabón, one of the many children of Ángel Ramón Villalona and Virginia Arcadia Évora and a younger brother of Fernando Villalona and Angelito Villalona.

**Orquesta Fernando Villalona**

He began his professional career in the early 1980s inside his brother’s orchestra, where he sang lead on «Cerveza y Mesa», a José L. Carballo composition from the 1986 album «Para mi pueblo todo», and, in 1989, on «Agua de coco» — both of which became lasting merengue standards under the Villalona name.

**Solo career**

After more than a decade and a half as a featured voice in his brother’s band, he formed his own dance orchestra in the late 1990s, recording dancefloor hits such as «La toita» and «A la roca» and, later, the more romantic «Solo tú», carrying the orquesta-style merengue of the 1980s into later decades and touring the Dominican circuit and its diaspora abroad.

**Legacy**

From coming up in one of Dominican merengue’s defining family orchestras to leading his own for decades after, Aramis Villalona has kept the horn-driven merengue de orquesta of his generation in circulation for dancers who grew up on it and for the ones who came after.' WHERE slug = 'aramis-villalona';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Aramis Villalona es cantante y compositor dominicano de merengue, nacido en Loma de Cabrera, provincia noroccidental de Dajabón, uno de los muchos hijos de Ángel Ramón Villalona y Virginia Arcadia Évora y hermano menor de "},{"type":"artistReference","attrs":{"occurrenceId":"8dcccd62-000c-4a5f-b642-dfd75086875c","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":" y de "},{"type":"artistReference","attrs":{"occurrenceId":"0f65db84-837b-439c-9a49-302cdc7bf737","artistId":"e82dde2c-19a8-4138-b337-800296c425d4","displayText":"Angelito Villalona"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Orquesta Fernando Villalona","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Comenzó su carrera profesional a principios de los años ochenta dentro de la orquesta de su hermano, donde cantó a voz principal «Cerveza y Mesa», composición de José L. Carballo incluida en el álbum de 1986 «Para mi pueblo todo», y, en 1989, «Agua de coco» — ambas convertidas en clásicos duraderos del merengue bajo el apellido Villalona."}]},{"type":"paragraph","content":[{"type":"text","text":"Carrera como solista","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Tras más de quince años como voz destacada en la banda de su hermano, formó su propia orquesta bailable a finales de los noventa, grabando éxitos de pista como «La toita» y «A la roca» y, más adelante, la más romántica «Solo tú», llevando el merengue de orquesta de los ochenta a décadas posteriores y recorriendo con giras el circuito dominicano y su diáspora en el exterior."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De foguearse en una de las orquestas familiares más importantes del merengue dominicano a dirigir la suya propia durante décadas, Aramis Villalona ha mantenido en circulación el merengue de orquesta de metales de su generación, tanto para quienes bailaron con él en su origen como para las generaciones que llegaron después."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'aramis-villalona'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'aramis-villalona' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '8dcccd62-000c-4a5f-b642-dfd75086875c', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'aramis-villalona' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '0f65db84-837b-439c-9a49-302cdc7bf737', 'artist', 'e82dde2c-19a8-4138-b337-800296c425d4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'aramis-villalona' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Aramis Villalona es cantante y compositor dominicano de merengue, nacido en Loma de Cabrera, provincia noroccidental de Dajabón, uno de los muchos hijos de Ángel Ramón Villalona y Virginia Arcadia Évora y hermano menor de Fernando Villalona y de Angelito Villalona.

**Orquesta Fernando Villalona**

Comenzó su carrera profesional a principios de los años ochenta dentro de la orquesta de su hermano, donde cantó a voz principal «Cerveza y Mesa», composición de José L. Carballo incluida en el álbum de 1986 «Para mi pueblo todo», y, en 1989, «Agua de coco» — ambas convertidas en clásicos duraderos del merengue bajo el apellido Villalona.

**Carrera como solista**

Tras más de quince años como voz destacada en la banda de su hermano, formó su propia orquesta bailable a finales de los noventa, grabando éxitos de pista como «La toita» y «A la roca» y, más adelante, la más romántica «Solo tú», llevando el merengue de orquesta de los ochenta a décadas posteriores y recorriendo con giras el circuito dominicano y su diáspora en el exterior.

**Legado**

De foguearse en una de las orquestas familiares más importantes del merengue dominicano a dirigir la suya propia durante décadas, Aramis Villalona ha mantenido en circulación el merengue de orquesta de metales de su generación, tanto para quienes bailaron con él en su origen como para las generaciones que llegaron después.' WHERE slug = 'aramis-villalona';

COMMIT;
