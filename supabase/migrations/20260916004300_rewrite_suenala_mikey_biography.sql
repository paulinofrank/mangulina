BEGIN;

-- Reescritura de la ficha de Suénala Mikey: la primera versión dependía de una sola fuente sin firma
-- y seguía su orden. Se eliminan los datos sin segunda fuente (nacimiento, formación, trabajo de
-- sesión, origen del nombre) y birth_place/province vuelven a null. Nuevo eje: producción de
-- "La Bachata Volvió" (RNN, 7dias, Bacharlando) y relación con Dalvin (Listin Diario).

UPDATE artists SET birth_place = NULL, province = NULL WHERE slug = 'suenala-mikey';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Suénala Mikey is the professional name of Michael Quevedo, a Dominican guitarist, arranger and producer who also works as Mikey Touch. Since early 2024 he has been the studio partner and manager of the bachata singer "},{"type":"artistReference","attrs":{"occurrenceId":"de24d376-d055-4771-a574-cdd42d873fb2","artistId":"4f331050-2568-42a4-a73b-7f9a731f1df4","displayText":"Dalvin la Melodía"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Producer of «La Bachata Volvió»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Dalvin’s first studio album, «La Bachata Volvió», was presented in August 2026 with thirteen songs, among them «Los Niños», «Duele», «Así Se Vende», «Alma Rota» and «Amnesia». The Dominican outlets RNN and 7días reported that Suénala Mikey produced the whole record. His own YouTube channel carries a behind-the-scenes video of the session for «Los Niños», recorded with Las Gemelas de la Bachata."}]},{"type":"paragraph","content":[{"type":"text","text":"Working with Dalvin","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Listín Diario reported in November 2025 that Dalvin, then twenty-two, met the guitarist, arranger and producer Michael Quevedo in early 2024 and began recording his first songs with his team; by then «Mi reina» had passed 33 million views on YouTube and «Chiquilla bonita» 21 million. When "},{"type":"artistReference","attrs":{"occurrenceId":"90beead8-72e0-4c01-932e-aa92c3e6618f","artistId":"8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3","displayText":"Romeo Santos"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"7a387637-1b1e-4274-9587-db1105937911","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":" wanted Dalvin on «Menor», the closing track of their album «Better Late Than Never» (28 November 2025), Romeo Santos had the producer "},{"type":"artistReference","attrs":{"occurrenceId":"a3cdd3ad-bea0-4558-90f6-21c51d12bacb","artistId":"1db77ddd-1046-4d95-b675-65da60234ef0","displayText":"Mártires de León"}},{"type":"text","text":" make the approach, and later recalled that Dalvin and his manager Mikey walked into the studio without knowing what they were about to record."}]},{"type":"paragraph","content":[{"type":"text","text":"On stage","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He also plays guitar in Dalvin’s live band. Dalvin’s six sold-out shows at the Coca-Cola Music Hall in San Juan, from 10 to 19 September 2026, which NotiCel and Telemundo Puerto Rico covered, were prepared with him: the singer’s Facebook page published a last rehearsal of the two before the run."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As of September 2026 he continues as the producer, guitarist and manager of "},{"type":"artistReference","attrs":{"occurrenceId":"e737abad-82da-40a1-906b-1bcb271e1d92","artistId":"4f331050-2568-42a4-a73b-7f9a731f1df4","displayText":"Dalvin la Melodía"}},{"type":"text","text":". His Instagram account, @suenalamikey, has about 278,000 followers, and his YouTube channel describes him as a guitarist, arranger and producer of bachata."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'suenala-mikey'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'suenala-mikey' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'de24d376-d055-4771-a574-cdd42d873fb2', 'artist', '4f331050-2568-42a4-a73b-7f9a731f1df4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'suenala-mikey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '90beead8-72e0-4c01-932e-aa92c3e6618f', 'artist', '8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'suenala-mikey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '7a387637-1b1e-4274-9587-db1105937911', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'suenala-mikey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'a3cdd3ad-bea0-4558-90f6-21c51d12bacb', 'artist', '1db77ddd-1046-4d95-b675-65da60234ef0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'suenala-mikey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'e737abad-82da-40a1-906b-1bcb271e1d92', 'artist', '4f331050-2568-42a4-a73b-7f9a731f1df4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'suenala-mikey' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Suénala Mikey is the professional name of Michael Quevedo, a Dominican guitarist, arranger and producer who also works as Mikey Touch. Since early 2024 he has been the studio partner and manager of the bachata singer Dalvin la Melodía.

**Producer of «La Bachata Volvió»**

Dalvin’s first studio album, «La Bachata Volvió», was presented in August 2026 with thirteen songs, among them «Los Niños», «Duele», «Así Se Vende», «Alma Rota» and «Amnesia». The Dominican outlets RNN and 7días reported that Suénala Mikey produced the whole record. His own YouTube channel carries a behind-the-scenes video of the session for «Los Niños», recorded with Las Gemelas de la Bachata.

**Working with Dalvin**

Listín Diario reported in November 2025 that Dalvin, then twenty-two, met the guitarist, arranger and producer Michael Quevedo in early 2024 and began recording his first songs with his team; by then «Mi reina» had passed 33 million views on YouTube and «Chiquilla bonita» 21 million. When Romeo Santos and Prince Royce wanted Dalvin on «Menor», the closing track of their album «Better Late Than Never» (28 November 2025), Romeo Santos had the producer Mártires de León make the approach, and later recalled that Dalvin and his manager Mikey walked into the studio without knowing what they were about to record.

**On stage**

He also plays guitar in Dalvin’s live band. Dalvin’s six sold-out shows at the Coca-Cola Music Hall in San Juan, from 10 to 19 September 2026, which NotiCel and Telemundo Puerto Rico covered, were prepared with him: the singer’s Facebook page published a last rehearsal of the two before the run.

**Legacy**

As of September 2026 he continues as the producer, guitarist and manager of Dalvin la Melodía. His Instagram account, @suenalamikey, has about 278,000 followers, and his YouTube channel describes him as a guitarist, arranger and producer of bachata.' WHERE slug = 'suenala-mikey';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Suénala Mikey es el nombre profesional de Michael Quevedo, guitarrista, arreglista y productor dominicano que también trabaja como Mikey Touch. Desde principios de 2024 es socio de estudio y mánager del bachatero "},{"type":"artistReference","attrs":{"occurrenceId":"e02fa703-8bc8-4e48-8dea-a4c56303e066","artistId":"4f331050-2568-42a4-a73b-7f9a731f1df4","displayText":"Dalvin la Melodía"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Productor de «La Bachata Volvió»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El primer álbum de estudio de Dalvin, «La Bachata Volvió», se presentó en agosto de 2026 con trece canciones, entre ellas «Los Niños», «Duele», «Así Se Vende», «Alma Rota» y «Amnesia». Los medios dominicanos RNN y 7días informaron de que Suénala Mikey produjo el disco completo. Su propio canal de YouTube tiene un video detrás de cámaras de la sesión de «Los Niños», grabada con Las Gemelas de la Bachata."}]},{"type":"paragraph","content":[{"type":"text","text":"El trabajo con Dalvin","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Listín Diario informó en noviembre de 2025 de que Dalvin, entonces de veintidós años, conoció al guitarrista, arreglista y productor Michael Quevedo a principios de 2024 y empezó a grabar sus primeras canciones con su equipo; para entonces «Mi reina» había superado los 33 millones de vistas en YouTube y «Chiquilla bonita» los 21 millones. Cuando "},{"type":"artistReference","attrs":{"occurrenceId":"15844ed7-5aea-49a5-9f7c-088ecf9211c8","artistId":"8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3","displayText":"Romeo Santos"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"5ca0bfc2-7d3a-491d-a381-4428c1b69a2e","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":" quisieron a Dalvin en «Menor», el último tema de su álbum «Better Late Than Never» (28 de noviembre de 2025), Romeo Santos encargó el acercamiento al productor "},{"type":"artistReference","attrs":{"occurrenceId":"172977c0-2093-456c-a722-7f780cdccf9c","artistId":"1db77ddd-1046-4d95-b675-65da60234ef0","displayText":"Mártires de León"}},{"type":"text","text":", y luego recordó que Dalvin y su mánager Mikey llegaron al estudio sin saber qué iban a grabar."}]},{"type":"paragraph","content":[{"type":"text","text":"En tarima","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"También toca la guitarra en la banda en vivo de Dalvin. Las seis funciones agotadas de Dalvin en el Coca-Cola Music Hall de San Juan, del 10 al 19 de septiembre de 2026, que cubrieron NotiCel y Telemundo Puerto Rico, se prepararon con él: la página de Facebook del cantante publicó un último ensayo de ambos antes de la serie."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En septiembre de 2026 sigue como productor, guitarrista y mánager de "},{"type":"artistReference","attrs":{"occurrenceId":"c40560af-762d-42ea-a3bf-6be63cf8a7d9","artistId":"4f331050-2568-42a4-a73b-7f9a731f1df4","displayText":"Dalvin la Melodía"}},{"type":"text","text":". Su cuenta de Instagram, @suenalamikey, tiene unos 278 000 seguidores, y su canal de YouTube lo describe como guitarrista, arreglista y productor de bachata."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'suenala-mikey'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'suenala-mikey' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'e02fa703-8bc8-4e48-8dea-a4c56303e066', 'artist', '4f331050-2568-42a4-a73b-7f9a731f1df4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'suenala-mikey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '15844ed7-5aea-49a5-9f7c-088ecf9211c8', 'artist', '8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'suenala-mikey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '5ca0bfc2-7d3a-491d-a381-4428c1b69a2e', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'suenala-mikey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '172977c0-2093-456c-a722-7f780cdccf9c', 'artist', '1db77ddd-1046-4d95-b675-65da60234ef0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'suenala-mikey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c40560af-762d-42ea-a3bf-6be63cf8a7d9', 'artist', '4f331050-2568-42a4-a73b-7f9a731f1df4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'suenala-mikey' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Suénala Mikey es el nombre profesional de Michael Quevedo, guitarrista, arreglista y productor dominicano que también trabaja como Mikey Touch. Desde principios de 2024 es socio de estudio y mánager del bachatero Dalvin la Melodía.

**Productor de «La Bachata Volvió»**

El primer álbum de estudio de Dalvin, «La Bachata Volvió», se presentó en agosto de 2026 con trece canciones, entre ellas «Los Niños», «Duele», «Así Se Vende», «Alma Rota» y «Amnesia». Los medios dominicanos RNN y 7días informaron de que Suénala Mikey produjo el disco completo. Su propio canal de YouTube tiene un video detrás de cámaras de la sesión de «Los Niños», grabada con Las Gemelas de la Bachata.

**El trabajo con Dalvin**

Listín Diario informó en noviembre de 2025 de que Dalvin, entonces de veintidós años, conoció al guitarrista, arreglista y productor Michael Quevedo a principios de 2024 y empezó a grabar sus primeras canciones con su equipo; para entonces «Mi reina» había superado los 33 millones de vistas en YouTube y «Chiquilla bonita» los 21 millones. Cuando Romeo Santos y Prince Royce quisieron a Dalvin en «Menor», el último tema de su álbum «Better Late Than Never» (28 de noviembre de 2025), Romeo Santos encargó el acercamiento al productor Mártires de León, y luego recordó que Dalvin y su mánager Mikey llegaron al estudio sin saber qué iban a grabar.

**En tarima**

También toca la guitarra en la banda en vivo de Dalvin. Las seis funciones agotadas de Dalvin en el Coca-Cola Music Hall de San Juan, del 10 al 19 de septiembre de 2026, que cubrieron NotiCel y Telemundo Puerto Rico, se prepararon con él: la página de Facebook del cantante publicó un último ensayo de ambos antes de la serie.

**Legado**

En septiembre de 2026 sigue como productor, guitarrista y mánager de Dalvin la Melodía. Su cuenta de Instagram, @suenalamikey, tiene unos 278 000 seguidores, y su canal de YouTube lo describe como guitarrista, arreglista y productor de bachata.' WHERE slug = 'suenala-mikey';

COMMIT;
