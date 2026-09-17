BEGIN;

-- Ficha de DJ Joe El Catador.
--
-- El relleno adivinaba mal el nombre real y no nombraba canción, emisora ni el reconocimiento
-- del Consulado dominicano en Barcelona (2025). Nombre corregido a Antonio Joel Tapia Peralta.
-- occupations poblado. primary_genre puesto a "urban-reggaeton"; genres ajustado.

UPDATE artists SET first_name = 'Antonio', middle_name = 'Joel', second_last_name = 'Peralta',
       occupations = '["radio_host","television_host"]'::jsonb,
       primary_genre = 'urban-reggaeton', genres = ARRAY['urbano','urban-dembow']::text[]
       WHERE slug = 'dj-joe-catador';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"DJ Joe El Catador —born Antonio Joel Tapia Peralta on 13 June 1978 in the Dominican Republic— is a Dominican DJ, radio and television host known for hits including «Seguridad, Sácalo», «Dembow del Pitillo» and «A Lo Que Tú Diga»."}]},{"type":"paragraph","content":[{"type":"text","text":"From nightclubs to «Kiss 94.9»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began his career working Dominican nightclubs before moving into radio as a host on «Kiss 94.9», later appearing on a Channel 11 series as well as the QTV programs «Azcona» and «Digital 15». He has also performed as part of the «SNP Deejays» collective, alongside DJs including DJ Negro and DJ 3men2."}]},{"type":"paragraph","content":[{"type":"text","text":"Streaming reach and collaborations","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His tracks passed 12 million streams across platforms in 2024 alone, and his self-titled YouTube channel has drawn more than 750,000 subscribers. In 2025 he released «El Gueso» with accordionist Geovanny Polanco."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In March 2025, the Consulate General of the Dominican Republic in Barcelona recognized DJ Joe El Catador, alongside salsa singer Yiyo Sarante, for his work as a cultural promoter of Dominican music on international stages, citing a European tour that took him through Spain, Switzerland, Italy, the Netherlands and Germany. The recognition credited his mixes, spread through digital platforms, with reaching not only the Dominican diaspora but a wider international audience."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dj-joe-catador'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'dj-joe-catador' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'DJ Joe El Catador —born Antonio Joel Tapia Peralta on 13 June 1978 in the Dominican Republic— is a Dominican DJ, radio and television host known for hits including «Seguridad, Sácalo», «Dembow del Pitillo» and «A Lo Que Tú Diga».

**From nightclubs to «Kiss 94.9»**

He began his career working Dominican nightclubs before moving into radio as a host on «Kiss 94.9», later appearing on a Channel 11 series as well as the QTV programs «Azcona» and «Digital 15». He has also performed as part of the «SNP Deejays» collective, alongside DJs including DJ Negro and DJ 3men2.

**Streaming reach and collaborations**

His tracks passed 12 million streams across platforms in 2024 alone, and his self-titled YouTube channel has drawn more than 750,000 subscribers. In 2025 he released «El Gueso» with accordionist Geovanny Polanco.

**Legacy**

In March 2025, the Consulate General of the Dominican Republic in Barcelona recognized DJ Joe El Catador, alongside salsa singer Yiyo Sarante, for his work as a cultural promoter of Dominican music on international stages, citing a European tour that took him through Spain, Switzerland, Italy, the Netherlands and Germany. The recognition credited his mixes, spread through digital platforms, with reaching not only the Dominican diaspora but a wider international audience.' WHERE slug = 'dj-joe-catador';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"DJ Joe El Catador —nacido Antonio Joel Tapia Peralta el 13 de junio de 1978 en República Dominicana— es DJ, presentador de radio y televisión dominicano, conocido por éxitos como «Seguridad, Sácalo», «Dembow del Pitillo» y «A Lo Que Tú Diga»."}]},{"type":"paragraph","content":[{"type":"text","text":"De las discotecas a «Kiss 94.9»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó su carrera trabajando en discotecas dominicanas antes de pasar a la radio como presentador de «Kiss 94.9», y luego apareció en una serie del Canal 11 y en los programas de QTV «Azcona» y «Digital 15». También se ha presentado como parte del colectivo «SNP Deejays», junto a DJs como DJ Negro y DJ 3men2."}]},{"type":"paragraph","content":[{"type":"text","text":"Alcance en streaming y colaboraciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Sus canciones superaron los 12 millones de reproducciones en plataformas solo en 2024, y su canal de YouTube homónimo ha reunido a más de 750,000 suscriptores. En 2025 publicó «El Gueso» junto al acordeonista Geovanny Polanco."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En marzo de 2025, el Consulado General de República Dominicana en Barcelona reconoció a DJ Joe El Catador, junto al salsero Yiyo Sarante, por su labor como promotor cultural de la música dominicana en escenarios internacionales, citando una gira europea que lo llevó por España, Suiza, Italia, los Países Bajos y Alemania. El reconocimiento atribuyó a sus mezclas, difundidas a través de plataformas digitales, el alcanzar no solo a la diáspora dominicana sino a un público internacional más amplio."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dj-joe-catador'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'dj-joe-catador' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'DJ Joe El Catador —nacido Antonio Joel Tapia Peralta el 13 de junio de 1978 en República Dominicana— es DJ, presentador de radio y televisión dominicano, conocido por éxitos como «Seguridad, Sácalo», «Dembow del Pitillo» y «A Lo Que Tú Diga».

**De las discotecas a «Kiss 94.9»**

Empezó su carrera trabajando en discotecas dominicanas antes de pasar a la radio como presentador de «Kiss 94.9», y luego apareció en una serie del Canal 11 y en los programas de QTV «Azcona» y «Digital 15». También se ha presentado como parte del colectivo «SNP Deejays», junto a DJs como DJ Negro y DJ 3men2.

**Alcance en streaming y colaboraciones**

Sus canciones superaron los 12 millones de reproducciones en plataformas solo en 2024, y su canal de YouTube homónimo ha reunido a más de 750,000 suscriptores. En 2025 publicó «El Gueso» junto al acordeonista Geovanny Polanco.

**Legado**

En marzo de 2025, el Consulado General de República Dominicana en Barcelona reconoció a DJ Joe El Catador, junto al salsero Yiyo Sarante, por su labor como promotor cultural de la música dominicana en escenarios internacionales, citando una gira europea que lo llevó por España, Suiza, Italia, los Países Bajos y Alemania. El reconocimiento atribuyó a sus mezclas, difundidas a través de plataformas digitales, el alcanzar no solo a la diáspora dominicana sino a un público internacional más amplio.' WHERE slug = 'dj-joe-catador';

COMMIT;
