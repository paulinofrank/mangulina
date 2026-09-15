BEGIN;

-- Ficha de Josean Jacobo.
--
-- La biografía de relleno lo describía en términos genéricos, sin nombrar a Tumbao, «Cimarrón»
-- ni ningún hecho verificable.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Josean Jacobo — born 17 August 1983 in Santo Domingo — is a Dominican jazz pianist, composer and bandleader whose group «Tumbao» has carried Afro-Dominican jazz onto international jazz charts."}]},{"type":"paragraph","content":[{"type":"text","text":"From improvised melodies to Berklee","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He started piano at eleven, teaching himself to improvise before any formal training. Studies at Berklee College of Music, in Boston, are where he began writing his own material, and he went on to play international festivals including Barranquijazz in Colombia, the Panama Jazz Festival, a jazz festival in Guadeloupe and the Dominican Republic’s own."}]},{"type":"paragraph","content":[{"type":"text","text":"«Tumbao»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"With his ensemble Tumbao he built a sound that fuses jazz with Dominican folk rhythm, neo-soul and electronic dance music, rooted specifically in Afro-Dominican percussion rather than the Cuban or American models most Latin jazz measures itself against. The group’s albums include «Balsié» (2017) and «Herencia Criolla» (2022)."}]},{"type":"paragraph","content":[{"type":"text","text":"«Cimarrón», and international attention","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Cimarrón» (2019) became the group’s biggest crossover: it reached the top 100 of the Jazz Week chart and the top 50 on ABC Jazz Australia, made the BBC’s list of most-requested jazz records, and was named one of the year’s best albums by Jazziz magazine."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2017 "},{"type":"artistReference","attrs":{"occurrenceId":"7ded87c4-412c-48d4-bd06-b3d8dd00c865","artistId":"9c57ee5c-6abd-4191-ac88-959ff86f0f7c","displayText":"Oscar Micheli"}},{"type":"text","text":"’s own recognition at the Dominican Republic’s International Jazz Day celebrations named Jacobo among the generation of Dominican musicians — Micheli included — who made it possible to build a career playing jazz alone, something that was not true a generation before either of them."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'josean-jacobo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'josean-jacobo' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7ded87c4-412c-48d4-bd06-b3d8dd00c865', 'artist', '9c57ee5c-6abd-4191-ac88-959ff86f0f7c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'josean-jacobo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Josean Jacobo — born 17 August 1983 in Santo Domingo — is a Dominican jazz pianist, composer and bandleader whose group «Tumbao» has carried Afro-Dominican jazz onto international jazz charts.

**From improvised melodies to Berklee**

He started piano at eleven, teaching himself to improvise before any formal training. Studies at Berklee College of Music, in Boston, are where he began writing his own material, and he went on to play international festivals including Barranquijazz in Colombia, the Panama Jazz Festival, a jazz festival in Guadeloupe and the Dominican Republic’s own.

**«Tumbao»**

With his ensemble Tumbao he built a sound that fuses jazz with Dominican folk rhythm, neo-soul and electronic dance music, rooted specifically in Afro-Dominican percussion rather than the Cuban or American models most Latin jazz measures itself against. The group’s albums include «Balsié» (2017) and «Herencia Criolla» (2022).

**«Cimarrón», and international attention**

«Cimarrón» (2019) became the group’s biggest crossover: it reached the top 100 of the Jazz Week chart and the top 50 on ABC Jazz Australia, made the BBC’s list of most-requested jazz records, and was named one of the year’s best albums by Jazziz magazine.

**Legacy**

In 2017 Oscar Micheli’s own recognition at the Dominican Republic’s International Jazz Day celebrations named Jacobo among the generation of Dominican musicians — Micheli included — who made it possible to build a career playing jazz alone, something that was not true a generation before either of them.' WHERE slug = 'josean-jacobo';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Josean Jacobo —nacido el 17 de agosto de 1983 en Santo Domingo— es pianista, compositor y director de orquesta dominicano de jazz, cuyo grupo «Tumbao» ha llevado el jazz afrodominicano a listas internacionales de jazz."}]},{"type":"paragraph","content":[{"type":"text","text":"De melodías improvisadas a Berklee","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó a tocar piano a los once años, enseñándose a sí mismo a improvisar antes de cualquier formación reglada. Sus estudios en el Berklee College of Music, en Boston, son donde empezó a escribir su propio material, y de ahí pasó a tocar en festivales internacionales como el Barranquijazz en Colombia, el Panama Jazz Festival, un festival de jazz en Guadalupe y el propio Festival de Jazz de República Dominicana."}]},{"type":"paragraph","content":[{"type":"text","text":"«Tumbao»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Con su agrupación Tumbao armó un sonido que fusiona el jazz con el ritmo folclórico dominicano, el neo soul y la música electrónica de baile, arraigado específicamente en la percusión afrodominicana y no en los modelos cubano o estadounidense con los que suele medirse el jazz latino. Los discos del grupo incluyen «Balsié» (2017) y «Herencia Criolla» (2022)."}]},{"type":"paragraph","content":[{"type":"text","text":"«Cimarrón», y la atención internacional","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Cimarrón» (2019) se convirtió en el mayor cruce del grupo hacia el público internacional: llegó al top 100 de la lista Jazz Week y al top 50 de ABC Jazz Australia, entró en la lista de discos de jazz más solicitados de la BBC, y la revista Jazziz lo nombró uno de los mejores álbumes del año."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2017, el propio reconocimiento que "},{"type":"artistReference","attrs":{"occurrenceId":"eb663b64-82a8-45bc-9d37-32d7855bcc7b","artistId":"9c57ee5c-6abd-4191-ac88-959ff86f0f7c","displayText":"Oscar Micheli"}},{"type":"text","text":" recibió en las celebraciones del Día Internacional del Jazz en República Dominicana nombró a Jacobo dentro de la generación de músicos dominicanos —Micheli incluido— que hizo posible construir una carrera tocando solo jazz, algo que no era cierto una generación antes de ninguno de los dos."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'josean-jacobo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'josean-jacobo' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'eb663b64-82a8-45bc-9d37-32d7855bcc7b', 'artist', '9c57ee5c-6abd-4191-ac88-959ff86f0f7c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'josean-jacobo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Josean Jacobo —nacido el 17 de agosto de 1983 en Santo Domingo— es pianista, compositor y director de orquesta dominicano de jazz, cuyo grupo «Tumbao» ha llevado el jazz afrodominicano a listas internacionales de jazz.

**De melodías improvisadas a Berklee**

Empezó a tocar piano a los once años, enseñándose a sí mismo a improvisar antes de cualquier formación reglada. Sus estudios en el Berklee College of Music, en Boston, son donde empezó a escribir su propio material, y de ahí pasó a tocar en festivales internacionales como el Barranquijazz en Colombia, el Panama Jazz Festival, un festival de jazz en Guadalupe y el propio Festival de Jazz de República Dominicana.

**«Tumbao»**

Con su agrupación Tumbao armó un sonido que fusiona el jazz con el ritmo folclórico dominicano, el neo soul y la música electrónica de baile, arraigado específicamente en la percusión afrodominicana y no en los modelos cubano o estadounidense con los que suele medirse el jazz latino. Los discos del grupo incluyen «Balsié» (2017) y «Herencia Criolla» (2022).

**«Cimarrón», y la atención internacional**

«Cimarrón» (2019) se convirtió en el mayor cruce del grupo hacia el público internacional: llegó al top 100 de la lista Jazz Week y al top 50 de ABC Jazz Australia, entró en la lista de discos de jazz más solicitados de la BBC, y la revista Jazziz lo nombró uno de los mejores álbumes del año.

**Legado**

En 2017, el propio reconocimiento que Oscar Micheli recibió en las celebraciones del Día Internacional del Jazz en República Dominicana nombró a Jacobo dentro de la generación de músicos dominicanos —Micheli incluido— que hizo posible construir una carrera tocando solo jazz, algo que no era cierto una generación antes de ninguno de los dos.' WHERE slug = 'josean-jacobo';

COMMIT;
