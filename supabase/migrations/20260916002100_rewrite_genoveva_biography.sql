BEGIN;

-- Ficha de Genoveva (Genoveva La Patrona).
--
-- La biografía de relleno dedicaba un párrafo a aclarar que ella "no es una artista
-- cristiana", sin mencionar el hecho central de su historia: fue esposa de Luis "Terror"
-- Días, el padre del rock dominicano, y grabó un homenaje a una de sus canciones tras su
-- muerte.
-- first_name/middle_name/last_name/second_last_name corregidos al nombre legal completo
-- (Cristina Genoveva Almonte Rodríguez). occupations ampliado con guitarist. genres
-- depurado (se retira merengue, sin respaldo). Matrimonio con Luis "Terror" Días registrado
-- en artist_family_relationships.

UPDATE artists SET first_name = 'Cristina', middle_name = 'Genoveva', last_name = 'Almonte',
       second_last_name = 'Rodríguez', occupations = '["songwriter","guitarist"]'::jsonb,
       genres = ARRAY['urban-reggaeton']::text[]
       WHERE slug = 'genoveva-la-patrona';

INSERT INTO artist_family_relationships (artist_id, related_artist_id, relationship_type, relationship_status)
  SELECT a.id, b.id, 'spouse', 'ended_by_death' FROM artists a, artists b
   WHERE a.slug = 'genoveva-la-patrona' AND b.slug = 'luis-terror-dias'
  ON CONFLICT (pair_low, pair_high) DO NOTHING;

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Genoveva —full name Cristina Genoveva Almonte Rodríguez, born in Pimentel, Duarte, on 24 August 1977— is a Dominican bachata singer-songwriter known as «La Patrona», whose signature recording is a bachata-reggaeton tribute to her late husband, the songwriter and guitarist "},{"type":"artistReference","attrs":{"occurrenceId":"de6034e0-b699-417c-9c69-74cb42339176","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"A student, then a wife","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She sang in her school choir from the age of eight. In January 2001 she began studying voice and guitar under "},{"type":"artistReference","attrs":{"occurrenceId":"e8a15e7f-3559-4be6-9cb8-24b741d803aa","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":", and that same year traveled with him, "},{"type":"artistReference","attrs":{"occurrenceId":"2939e6bc-95f3-4979-8e08-1fadde75e492","artistId":"0dee2e87-7680-4300-8038-a57c419e76c3","displayText":"Crispín Fernández"}},{"type":"text","text":" and the percussionist José Duluc to Japan for the «Isla Salsa» event, teaching Caribbean dance workshops to promote Dominican culture abroad. She later took part in a 2006 tribute concert to Días at the Cultural Festival of the Africa-Caribbean-Pacific Group of States, for which the Ministry of Culture recognized her as a cultural asset. The two married in February 2008."}]},{"type":"paragraph","content":[{"type":"text","text":"«Yo Quiero Andar»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Días died on 8 December 2009. In tribute, Genoveva recorded a bachata-reggaeton version of his composition «Yo Quiero Andar», a song originally popularized in the 1980s by "},{"type":"artistReference","attrs":{"occurrenceId":"b05ac558-9aea-492f-8aee-bf480a14aeb0","artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre"}},{"type":"text","text":", with arrangements credited to Moisés Sánchez, Ernesto Anderson Paredes and herself."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Genoveva has continued recording independently through her own label, Genoveva Records, releasing further singles including «Sin Competencia» and «Me Dejaste Sola»."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'genoveva-la-patrona'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'genoveva-la-patrona' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'de6034e0-b699-417c-9c69-74cb42339176', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'genoveva-la-patrona' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'e8a15e7f-3559-4be6-9cb8-24b741d803aa', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'genoveva-la-patrona' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '2939e6bc-95f3-4979-8e08-1fadde75e492', 'artist', '0dee2e87-7680-4300-8038-a57c419e76c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'genoveva-la-patrona' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'b05ac558-9aea-492f-8aee-bf480a14aeb0', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'genoveva-la-patrona' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Genoveva —full name Cristina Genoveva Almonte Rodríguez, born in Pimentel, Duarte, on 24 August 1977— is a Dominican bachata singer-songwriter known as «La Patrona», whose signature recording is a bachata-reggaeton tribute to her late husband, the songwriter and guitarist Luis "Terror" Días.

**A student, then a wife**

She sang in her school choir from the age of eight. In January 2001 she began studying voice and guitar under Luis "Terror" Días, and that same year traveled with him, Crispín Fernández and the percussionist José Duluc to Japan for the «Isla Salsa» event, teaching Caribbean dance workshops to promote Dominican culture abroad. She later took part in a 2006 tribute concert to Días at the Cultural Festival of the Africa-Caribbean-Pacific Group of States, for which the Ministry of Culture recognized her as a cultural asset. The two married in February 2008.

**«Yo Quiero Andar»**

Días died on 8 December 2009. In tribute, Genoveva recorded a bachata-reggaeton version of his composition «Yo Quiero Andar», a song originally popularized in the 1980s by Sonia Silvestre, with arrangements credited to Moisés Sánchez, Ernesto Anderson Paredes and herself.

**Legacy**

Genoveva has continued recording independently through her own label, Genoveva Records, releasing further singles including «Sin Competencia» and «Me Dejaste Sola».' WHERE slug = 'genoveva-la-patrona';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Genoveva —nombre completo Cristina Genoveva Almonte Rodríguez, nacida en Pimentel, Duarte, el 24 de agosto de 1977— es cantautora dominicana de bachata conocida como «La Patrona», cuya grabación más emblemática es un homenaje en clave de bachata-reguetón a su difunto esposo, el compositor y guitarrista "},{"type":"artistReference","attrs":{"occurrenceId":"531c577b-2772-435a-bb61-d0479cc2d069","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Alumna, y después esposa","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cantó en el coro de su escuela desde los ocho años. En enero de 2001 empezó a estudiar canto y guitarra con "},{"type":"artistReference","attrs":{"occurrenceId":"b9d388ff-e837-4553-a379-6ed8ec081d89","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":", y ese mismo año viajó con él, "},{"type":"artistReference","attrs":{"occurrenceId":"eac597a9-f71d-4b76-b0b9-964911ad8f7f","artistId":"0dee2e87-7680-4300-8038-a57c419e76c3","displayText":"Crispín Fernández"}},{"type":"text","text":" y el percusionista José Duluc a Japón para el evento «Isla Salsa», impartiendo talleres de baile caribeño para promover la cultura dominicana en el exterior. Más tarde participó en un concierto homenaje a Días en 2006, dentro del Festival Cultural del Grupo de Estados de África, el Caribe y el Pacífico, por el cual el Ministerio de Cultura la reconoció como valor cultural. Los dos se casaron en febrero de 2008."}]},{"type":"paragraph","content":[{"type":"text","text":"«Yo Quiero Andar»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Días murió el 8 de diciembre de 2009. En homenaje, Genoveva grabó una versión en bachata-reguetón de su composición «Yo Quiero Andar», canción popularizada originalmente en los años ochenta por "},{"type":"artistReference","attrs":{"occurrenceId":"15c55578-608d-4abc-97c2-51afc38afe85","artistId":"2cc97ca9-126d-48c5-922f-e9d5c8b0360d","displayText":"Sonia Silvestre"}},{"type":"text","text":", con arreglos acreditados a Moisés Sánchez, Ernesto Anderson Paredes y ella misma."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Genoveva ha seguido grabando de forma independiente a través de su propio sello, Genoveva Records, publicando otros sencillos como «Sin Competencia» y «Me Dejaste Sola»."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'genoveva-la-patrona'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'genoveva-la-patrona' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '531c577b-2772-435a-bb61-d0479cc2d069', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'genoveva-la-patrona' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'b9d388ff-e837-4553-a379-6ed8ec081d89', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'genoveva-la-patrona' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'eac597a9-f71d-4b76-b0b9-964911ad8f7f', 'artist', '0dee2e87-7680-4300-8038-a57c419e76c3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'genoveva-la-patrona' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '15c55578-608d-4abc-97c2-51afc38afe85', 'artist', '2cc97ca9-126d-48c5-922f-e9d5c8b0360d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'genoveva-la-patrona' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Genoveva —nombre completo Cristina Genoveva Almonte Rodríguez, nacida en Pimentel, Duarte, el 24 de agosto de 1977— es cantautora dominicana de bachata conocida como «La Patrona», cuya grabación más emblemática es un homenaje en clave de bachata-reguetón a su difunto esposo, el compositor y guitarrista Luis "Terror" Días.

**Alumna, y después esposa**

Cantó en el coro de su escuela desde los ocho años. En enero de 2001 empezó a estudiar canto y guitarra con Luis "Terror" Días, y ese mismo año viajó con él, Crispín Fernández y el percusionista José Duluc a Japón para el evento «Isla Salsa», impartiendo talleres de baile caribeño para promover la cultura dominicana en el exterior. Más tarde participó en un concierto homenaje a Días en 2006, dentro del Festival Cultural del Grupo de Estados de África, el Caribe y el Pacífico, por el cual el Ministerio de Cultura la reconoció como valor cultural. Los dos se casaron en febrero de 2008.

**«Yo Quiero Andar»**

Días murió el 8 de diciembre de 2009. En homenaje, Genoveva grabó una versión en bachata-reguetón de su composición «Yo Quiero Andar», canción popularizada originalmente en los años ochenta por Sonia Silvestre, con arreglos acreditados a Moisés Sánchez, Ernesto Anderson Paredes y ella misma.

**Legado**

Genoveva ha seguido grabando de forma independiente a través de su propio sello, Genoveva Records, publicando otros sencillos como «Sin Competencia» y «Me Dejaste Sola».' WHERE slug = 'genoveva-la-patrona';

COMMIT;
