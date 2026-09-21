BEGIN;

-- Ficha de DJ Gabriel B.
--
-- La fila se llamaba "DJ Gabriel Beast", forma que ninguna fuente usa; se corrige a "DJ Gabriel B"
-- (Boiler Room), con "Gabriel Beats" y "Gabriel B" como alias. primary_genre "electronic";
-- occupations ["producer"]; gender "male"; instagram verificado.

UPDATE artists SET name = 'DJ Gabriel B', sort_name = 'Gabriel B, DJ', stage_name = 'DJ Gabriel B',
       gender = 'male', aliases = ARRAY['Gabriel Beats','Gabriel B']::text[],
       primary_genre = 'electronic', occupations = '["producer"]'::jsonb, instagram = 'gabriel_beats_music'
       WHERE slug = 'dj-gabriel-b';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"DJ Gabriel B, also known as Gabriel Beats, is a Santo Domingo DJ and producer who began his career in 2019 and works mainly in tech house and afro house, often building tracks from samples and vocals taken from the local urban scene."}]},{"type":"paragraph","content":[{"type":"text","text":"Tech house from Santo Domingo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The music site Discolai describes him as one of the standard-bearers of the new tech house and afro house school in the Dominican capital. He releases tracks such as «Esta Si» and «Flow De Nasa» under the name Gabriel Beats on SoundCloud and Spotify, while Boiler Room lists his set under the genre dembow."}]},{"type":"paragraph","content":[{"type":"text","text":"Boiler Room Dominican Republic","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"On 3 May 2024 he played at the first Boiler Room event held in the Dominican Republic, staged at the Cinco Esquinas in Santo Domingo’s San Carlos neighborhood and tied to the close of "},{"type":"artistReference","attrs":{"occurrenceId":"763b6f7f-467e-4c3a-8294-958880d50a30","artistId":"3e1718be-c12d-42f5-85e7-2156d9574940","displayText":"Tokischa"}},{"type":"text","text":"’s tour. Alongside him on the bill were the DJ Selektor Siete, who opened, the DJ Mohikaa, the producer "},{"type":"artistReference","attrs":{"occurrenceId":"4979d937-bd8b-40b4-b2e1-a491ffcdbf09","artistId":"350e5535-5229-4d49-903e-a5de047e7723","displayText":"Cromo X"}},{"type":"text","text":" and the producer "},{"type":"artistReference","attrs":{"occurrenceId":"1854d711-7d29-4c73-bdf2-c5f713c6a298","artistId":"5cbc8f2b-cb68-4ebd-8006-6837be54bbe4","displayText":"Leo RD"}},{"type":"text","text":". Boiler Room published his set on YouTube on 13 June 2024 as «DJ Gabriel B | Boiler Room Dominican Republic: Tokischa», a fifteen-minute recording that has passed 22,000 views."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As of 2026 he continues to perform and post as a DJ and producer of tech house and house, with a following of about 2,800 on SoundCloud and 18,000 on Instagram, where he uses the handle @gabriel_beats_music. The Boiler Room set is the best documented appearance of his career so far."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dj-gabriel-b'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'dj-gabriel-b' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '763b6f7f-467e-4c3a-8294-958880d50a30', 'artist', '3e1718be-c12d-42f5-85e7-2156d9574940' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'dj-gabriel-b' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '4979d937-bd8b-40b4-b2e1-a491ffcdbf09', 'artist', '350e5535-5229-4d49-903e-a5de047e7723' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'dj-gabriel-b' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '1854d711-7d29-4c73-bdf2-c5f713c6a298', 'artist', '5cbc8f2b-cb68-4ebd-8006-6837be54bbe4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'dj-gabriel-b' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'DJ Gabriel B, also known as Gabriel Beats, is a Santo Domingo DJ and producer who began his career in 2019 and works mainly in tech house and afro house, often building tracks from samples and vocals taken from the local urban scene.

**Tech house from Santo Domingo**

The music site Discolai describes him as one of the standard-bearers of the new tech house and afro house school in the Dominican capital. He releases tracks such as «Esta Si» and «Flow De Nasa» under the name Gabriel Beats on SoundCloud and Spotify, while Boiler Room lists his set under the genre dembow.

**Boiler Room Dominican Republic**

On 3 May 2024 he played at the first Boiler Room event held in the Dominican Republic, staged at the Cinco Esquinas in Santo Domingo’s San Carlos neighborhood and tied to the close of Tokischa’s tour. Alongside him on the bill were the DJ Selektor Siete, who opened, the DJ Mohikaa, the producer Cromo X and the producer Leo RD. Boiler Room published his set on YouTube on 13 June 2024 as «DJ Gabriel B | Boiler Room Dominican Republic: Tokischa», a fifteen-minute recording that has passed 22,000 views.

**Legacy**

As of 2026 he continues to perform and post as a DJ and producer of tech house and house, with a following of about 2,800 on SoundCloud and 18,000 on Instagram, where he uses the handle @gabriel_beats_music. The Boiler Room set is the best documented appearance of his career so far.' WHERE slug = 'dj-gabriel-b';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"DJ Gabriel B, también conocido como Gabriel Beats, es DJ y productor de Santo Domingo que empezó su carrera en 2019 y trabaja sobre todo en tech house y afro house, a menudo armando temas con muestras y voces tomadas de la escena urbana local."}]},{"type":"paragraph","content":[{"type":"text","text":"Tech house desde Santo Domingo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El sitio Discolai lo describe como uno de los abanderados de la nueva escuela del tech house y el afro house en la capital dominicana. Publica temas como «Esta Si» y «Flow De Nasa» con el nombre Gabriel Beats en SoundCloud y Spotify, mientras que Boiler Room clasifica su set bajo el género dembow."}]},{"type":"paragraph","content":[{"type":"text","text":"Boiler Room República Dominicana","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El 3 de mayo de 2024 tocó en el primer evento de Boiler Room realizado en República Dominicana, montado en las Cinco Esquinas del barrio San Carlos de Santo Domingo y ligado al cierre de la gira de "},{"type":"artistReference","attrs":{"occurrenceId":"33dc49ba-07a4-4476-89aa-99864f6e38ad","artistId":"3e1718be-c12d-42f5-85e7-2156d9574940","displayText":"Tokischa"}},{"type":"text","text":". En el cartel lo acompañaron el DJ Selektor Siete, que abrió, el DJ Mohikaa, el productor "},{"type":"artistReference","attrs":{"occurrenceId":"acc54b28-467f-4d52-8c4c-1fc5b1050083","artistId":"350e5535-5229-4d49-903e-a5de047e7723","displayText":"Cromo X"}},{"type":"text","text":" y el productor "},{"type":"artistReference","attrs":{"occurrenceId":"89d5b98c-0305-4ad2-8415-7d5a8e95905b","artistId":"5cbc8f2b-cb68-4ebd-8006-6837be54bbe4","displayText":"Leo RD"}},{"type":"text","text":". Boiler Room publicó su set en YouTube el 13 de junio de 2024 como «DJ Gabriel B | Boiler Room Dominican Republic: Tokischa», una grabación de quince minutos que ha superado las 22 000 vistas."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2026 sigue presentándose y publicando como DJ y productor de tech house y house, con unos 2 800 seguidores en SoundCloud y 18 000 en Instagram, donde usa el nombre @gabriel_beats_music. El set de Boiler Room es la presentación mejor documentada de su carrera hasta ahora."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dj-gabriel-b'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'dj-gabriel-b' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '33dc49ba-07a4-4476-89aa-99864f6e38ad', 'artist', '3e1718be-c12d-42f5-85e7-2156d9574940' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'dj-gabriel-b' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'acc54b28-467f-4d52-8c4c-1fc5b1050083', 'artist', '350e5535-5229-4d49-903e-a5de047e7723' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'dj-gabriel-b' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '89d5b98c-0305-4ad2-8415-7d5a8e95905b', 'artist', '5cbc8f2b-cb68-4ebd-8006-6837be54bbe4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'dj-gabriel-b' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'DJ Gabriel B, también conocido como Gabriel Beats, es DJ y productor de Santo Domingo que empezó su carrera en 2019 y trabaja sobre todo en tech house y afro house, a menudo armando temas con muestras y voces tomadas de la escena urbana local.

**Tech house desde Santo Domingo**

El sitio Discolai lo describe como uno de los abanderados de la nueva escuela del tech house y el afro house en la capital dominicana. Publica temas como «Esta Si» y «Flow De Nasa» con el nombre Gabriel Beats en SoundCloud y Spotify, mientras que Boiler Room clasifica su set bajo el género dembow.

**Boiler Room República Dominicana**

El 3 de mayo de 2024 tocó en el primer evento de Boiler Room realizado en República Dominicana, montado en las Cinco Esquinas del barrio San Carlos de Santo Domingo y ligado al cierre de la gira de Tokischa. En el cartel lo acompañaron el DJ Selektor Siete, que abrió, el DJ Mohikaa, el productor Cromo X y el productor Leo RD. Boiler Room publicó su set en YouTube el 13 de junio de 2024 como «DJ Gabriel B | Boiler Room Dominican Republic: Tokischa», una grabación de quince minutos que ha superado las 22 000 vistas.

**Legado**

En 2026 sigue presentándose y publicando como DJ y productor de tech house y house, con unos 2 800 seguidores en SoundCloud y 18 000 en Instagram, donde usa el nombre @gabriel_beats_music. El set de Boiler Room es la presentación mejor documentada de su carrera hasta ahora.' WHERE slug = 'dj-gabriel-b';

COMMIT;
