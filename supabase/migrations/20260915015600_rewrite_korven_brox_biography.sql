BEGIN;

-- Ficha de Korven Brox.
--
-- La biografía de relleno lo llamaba genéricamente "urban artist" del dembow dominicano; la
-- propia disambiguation de MusicBrainz y toda su discografía desde noviembre de 2024 lo
-- identifican como cantante y guitarrista principal de la banda de rock/grunge Grunjeo.
-- primary_genre corregido de 'urbano' a 'rock'; occupations e instruments añadidos.

UPDATE artists SET birth_place = 'Santo Domingo', province = 'Distrito Nacional',
       primary_genre = 'rock', occupations = '["producer"]'::jsonb,
       instruments = ARRAY['voice','guitar']::text[] WHERE slug = 'korven-brox';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Korven Brox, born in Santo Domingo on 7 August 2006, is a Dominican musician and producer who came up as a teenage solo act before becoming the singer, guitarist and principal songwriter of the rock band "},{"type":"artistReference","attrs":{"occurrenceId":"219272af-a0b5-49de-b98b-e03234e97e19","artistId":"d2d1dde7-94a6-4463-9a41-7be7245e3f55","displayText":"Grunjeo"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"A teenage start","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Signed to Jowmena Records as a minor, he released his first singles in the urban and trap register that dominates young Dominican music, including «Oh My Gang» (Remix), featuring 6DejhaeMc, in 2022, and «Finjo» in 2024."}]},{"type":"paragraph","content":[{"type":"text","text":"«Grunjeo»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In November 2024 he co-founded "},{"type":"artistReference","attrs":{"occurrenceId":"dc968c54-b107-4908-804b-b3425839c309","artistId":"d2d1dde7-94a6-4463-9a41-7be7245e3f55","displayText":"Grunjeo"}},{"type":"text","text":", a grunge and alternative rock band that met on TikTok and, over its nineteen-month run, became one of the few visible faces of guitar-driven rock in a country whose popular music runs almost entirely on dance rhythm. Korven sang, played guitar and wrote most of its material until the band ended in June 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"From a teenager releasing urban singles for a Dominican label to fronting one of the country’s rare working rock bands, Korven Brox’s short career already traces a path through two of the furthest-apart currents in Dominican youth music."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'korven-brox'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'korven-brox' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '219272af-a0b5-49de-b98b-e03234e97e19', 'artist', 'd2d1dde7-94a6-4463-9a41-7be7245e3f55' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'korven-brox' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dc968c54-b107-4908-804b-b3425839c309', 'artist', 'd2d1dde7-94a6-4463-9a41-7be7245e3f55' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'korven-brox' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Korven Brox, born in Santo Domingo on 7 August 2006, is a Dominican musician and producer who came up as a teenage solo act before becoming the singer, guitarist and principal songwriter of the rock band Grunjeo.

**A teenage start**

Signed to Jowmena Records as a minor, he released his first singles in the urban and trap register that dominates young Dominican music, including «Oh My Gang» (Remix), featuring 6DejhaeMc, in 2022, and «Finjo» in 2024.

**«Grunjeo»**

In November 2024 he co-founded Grunjeo, a grunge and alternative rock band that met on TikTok and, over its nineteen-month run, became one of the few visible faces of guitar-driven rock in a country whose popular music runs almost entirely on dance rhythm. Korven sang, played guitar and wrote most of its material until the band ended in June 2026.

**Legacy**

From a teenager releasing urban singles for a Dominican label to fronting one of the country’s rare working rock bands, Korven Brox’s short career already traces a path through two of the furthest-apart currents in Dominican youth music.' WHERE slug = 'korven-brox';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Korven Brox, nacido en Santo Domingo el 7 de agosto de 2006, es músico y productor dominicano que empezó como solista adolescente antes de convertirse en cantante, guitarrista y compositor principal de la banda de rock "},{"type":"artistReference","attrs":{"occurrenceId":"76091aad-ea84-4186-888a-3fbbc2f64505","artistId":"d2d1dde7-94a6-4463-9a41-7be7245e3f55","displayText":"Grunjeo"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Un comienzo adolescente","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Firmado con Jowmena Records siendo menor de edad, publicó sus primeros sencillos dentro del registro urbano y trap que domina la música joven dominicana, entre ellos «Oh My Gang» (Remix), con 6DejhaeMc, en 2022, y «Finjo» en 2024."}]},{"type":"paragraph","content":[{"type":"text","text":"«Grunjeo»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En noviembre de 2024 cofundó "},{"type":"artistReference","attrs":{"occurrenceId":"6f8446bc-5536-4793-a0a0-e473de7eb610","artistId":"d2d1dde7-94a6-4463-9a41-7be7245e3f55","displayText":"Grunjeo"}},{"type":"text","text":", una banda de grunge y rock alternativo que se conoció por TikTok y que, en sus diecinueve meses de vida, se convirtió en una de las pocas caras visibles del rock de guitarras en un país cuya música popular corre casi por entero sobre ritmo de baile. Korven cantó, tocó guitarra y escribió la mayor parte de su material hasta que la banda terminó en junio de 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De adolescente publicando sencillos urbanos para un sello dominicano a frente de una de las pocas bandas de rock del país en activo, la corta carrera de Korven Brox ya traza un recorrido entre dos de las corrientes más distantes de la música joven dominicana."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'korven-brox'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'korven-brox' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '76091aad-ea84-4186-888a-3fbbc2f64505', 'artist', 'd2d1dde7-94a6-4463-9a41-7be7245e3f55' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'korven-brox' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6f8446bc-5536-4793-a0a0-e473de7eb610', 'artist', 'd2d1dde7-94a6-4463-9a41-7be7245e3f55' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'korven-brox' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Korven Brox, nacido en Santo Domingo el 7 de agosto de 2006, es músico y productor dominicano que empezó como solista adolescente antes de convertirse en cantante, guitarrista y compositor principal de la banda de rock Grunjeo.

**Un comienzo adolescente**

Firmado con Jowmena Records siendo menor de edad, publicó sus primeros sencillos dentro del registro urbano y trap que domina la música joven dominicana, entre ellos «Oh My Gang» (Remix), con 6DejhaeMc, en 2022, y «Finjo» en 2024.

**«Grunjeo»**

En noviembre de 2024 cofundó Grunjeo, una banda de grunge y rock alternativo que se conoció por TikTok y que, en sus diecinueve meses de vida, se convirtió en una de las pocas caras visibles del rock de guitarras en un país cuya música popular corre casi por entero sobre ritmo de baile. Korven cantó, tocó guitarra y escribió la mayor parte de su material hasta que la banda terminó en junio de 2026.

**Legado**

De adolescente publicando sencillos urbanos para un sello dominicano a frente de una de las pocas bandas de rock del país en activo, la corta carrera de Korven Brox ya traza un recorrido entre dos de las corrientes más distantes de la música joven dominicana.' WHERE slug = 'korven-brox';

COMMIT;
