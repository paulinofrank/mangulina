BEGIN;

-- Ficha de Flow 28.
--
-- La biografía de relleno era pura descripción de género sin un solo hecho. Sin nombre real
-- ni fecha de nacimiento exacta encontrados; se mantiene el año 2004 ya presente en la fila
-- (consistente con "18 años" en feb 2023). No se registran las dos nominaciones a los
-- Premios Núcleo Urbano RD 2023 como filas de premio: los nombres exactos de categoría no
-- se pudieron confirmar; se mencionan en la prosa.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Flow 28 — Carlos Flores, born in 2004 in Santo Domingo — is a Dominican dembow artist from the Herrera neighbourhood who broke through as a teenager with a song built out of a TikTok comment."}]},{"type":"paragraph","content":[{"type":"text","text":"Discovered at a competition","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He had been making music since he was small when a manager known as Gotera spotted him at a local competition and approached him to meet the next day in Cristo Rey; by early 2023 the two had been working together about a year. Flow has credited his mother and brother, who backed him from before he was known at all, with keeping him on track."}]},{"type":"paragraph","content":[{"type":"text","text":"«Po po po»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He filmed a video with the producer Talvia and posted it to TikTok, where it took off; within days "},{"type":"artistReference","attrs":{"occurrenceId":"ff54fb06-2f60-4986-9b54-b5fe5875ce92","artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47"}},{"type":"text","text":" commented on it, telling him he had a hit coming and that the year was his. That contact led their managers to put the two together on «Po po po», the song that became Flow’s breakthrough — released when he was eighteen — and has since passed 58 million views on YouTube."}]},{"type":"paragraph","content":[{"type":"text","text":"After the hit","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The songs that followed included «Se comenta», «Cuba», «Tambora» and «Lo rafaguié», with "},{"type":"artistReference","attrs":{"occurrenceId":"5b028a68-7a41-4fc5-8b53-e6a3e8438bf8","artistId":"9be0ed08-6eb6-4ca0-bb68-d5126190aeb1","displayText":"Kiko el Crazy"}},{"type":"text","text":", along with «Gugle», with "},{"type":"artistReference","attrs":{"occurrenceId":"9299ec3a-4a99-44c1-bee8-4cf9d52d5935","artistId":"8243655e-17a7-4dea-98ee-1c16674c38cd","displayText":"DJ Adoni"}},{"type":"text","text":", «El punto», with "},{"type":"artistReference","attrs":{"occurrenceId":"24d9f53f-87ca-4499-afd4-fc3a1dd0665d","artistId":"741eb4c0-4ab8-4ad5-8a64-2f156da6a395","displayText":"Ceky Viciny"}},{"type":"text","text":", and «No saben», with the Puerto Rican artists De La Ghetto and Chris Lebrón. In 2023 he picked up two nominations at the first Premios Núcleo Urbano RD."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Flow 28 belongs to the group that "},{"type":"artistReference","attrs":{"occurrenceId":"a0e849ad-f335-4e22-a094-6710bc2d83b7","artistId":"775a5598-26f8-45ee-9583-8c3193db5934","displayText":"Papaa Tyga"}},{"type":"text","text":" has named as the centre of the current dembow scene, alongside "},{"type":"artistReference","attrs":{"occurrenceId":"39b1ea49-ddca-4469-9b27-8a314c7ec0f7","artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"c5550140-1558-446b-a68e-7a808cc34995","artistId":"741eb4c0-4ab8-4ad5-8a64-2f156da6a395","displayText":"Ceky Viciny"}},{"type":"text","text":", Yaisel and Jey One — a run of young Santo Domingo artists who took the genre from the street clip that first got him noticed to a viral catalogue of his own."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'flow-28'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'flow-28' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ff54fb06-2f60-4986-9b54-b5fe5875ce92', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5b028a68-7a41-4fc5-8b53-e6a3e8438bf8', 'artist', '9be0ed08-6eb6-4ca0-bb68-d5126190aeb1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9299ec3a-4a99-44c1-bee8-4cf9d52d5935', 'artist', '8243655e-17a7-4dea-98ee-1c16674c38cd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '24d9f53f-87ca-4499-afd4-fc3a1dd0665d', 'artist', '741eb4c0-4ab8-4ad5-8a64-2f156da6a395' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a0e849ad-f335-4e22-a094-6710bc2d83b7', 'artist', '775a5598-26f8-45ee-9583-8c3193db5934' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '39b1ea49-ddca-4469-9b27-8a314c7ec0f7', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c5550140-1558-446b-a68e-7a808cc34995', 'artist', '741eb4c0-4ab8-4ad5-8a64-2f156da6a395' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Flow 28 — Carlos Flores, born in 2004 in Santo Domingo — is a Dominican dembow artist from the Herrera neighbourhood who broke through as a teenager with a song built out of a TikTok comment.

**Discovered at a competition**

He had been making music since he was small when a manager known as Gotera spotted him at a local competition and approached him to meet the next day in Cristo Rey; by early 2023 the two had been working together about a year. Flow has credited his mother and brother, who backed him from before he was known at all, with keeping him on track.

**«Po po po»**

He filmed a video with the producer Talvia and posted it to TikTok, where it took off; within days Bulin 47 commented on it, telling him he had a hit coming and that the year was his. That contact led their managers to put the two together on «Po po po», the song that became Flow’s breakthrough — released when he was eighteen — and has since passed 58 million views on YouTube.

**After the hit**

The songs that followed included «Se comenta», «Cuba», «Tambora» and «Lo rafaguié», with Kiko el Crazy, along with «Gugle», with DJ Adoni, «El punto», with Ceky Viciny, and «No saben», with the Puerto Rican artists De La Ghetto and Chris Lebrón. In 2023 he picked up two nominations at the first Premios Núcleo Urbano RD.

**Legacy**

Flow 28 belongs to the group that Papaa Tyga has named as the centre of the current dembow scene, alongside Bulin 47, Ceky Viciny, Yaisel and Jey One — a run of young Santo Domingo artists who took the genre from the street clip that first got him noticed to a viral catalogue of his own.' WHERE slug = 'flow-28';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Flow 28 —Carlos Flores, nacido en 2004 en Santo Domingo— es un artista de dembow dominicano del sector Herrera que se dio a conocer siendo adolescente con una canción que nació de un comentario en TikTok."}]},{"type":"paragraph","content":[{"type":"text","text":"Descubierto en una competencia","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Llevaba haciendo música desde pequeño cuando un mánager conocido como Gotera lo vio en una competencia local y lo abordó para verse al día siguiente en Cristo Rey; a comienzos de 2023 ya llevaban cerca de un año trabajando juntos. Flow le ha dado el crédito a su madre y a su hermano, que apostaron por él desde antes de ser conocido, por mantenerlo enfocado."}]},{"type":"paragraph","content":[{"type":"text","text":"«Po po po»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Grabó un video con el productor Talvia y lo subió a TikTok, donde se disparó; a los pocos días "},{"type":"artistReference","attrs":{"occurrenceId":"a2a6033a-5f18-4720-aff0-c73b0ffd9d94","artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47"}},{"type":"text","text":" le comentó el video, diciéndole que se iba a pegar y que el año era suyo. Ese contacto llevó a que los mánagers de ambos los juntaran en «Po po po», la canción que fue el despegue de Flow —lanzada cuando tenía dieciocho años— y que desde entonces ha pasado los 58 millones de reproducciones en YouTube."}]},{"type":"paragraph","content":[{"type":"text","text":"Después del éxito","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Le siguieron temas como «Se comenta», «Cuba», «Tambora» y «Lo rafaguié», con "},{"type":"artistReference","attrs":{"occurrenceId":"45e86a47-e6f8-4d92-8aad-42b663474fa9","artistId":"9be0ed08-6eb6-4ca0-bb68-d5126190aeb1","displayText":"Kiko el Crazy"}},{"type":"text","text":", además de «Gugle», con "},{"type":"artistReference","attrs":{"occurrenceId":"6f46cd37-8164-4c18-8893-903e9f2e0778","artistId":"8243655e-17a7-4dea-98ee-1c16674c38cd","displayText":"DJ Adoni"}},{"type":"text","text":", «El punto», con "},{"type":"artistReference","attrs":{"occurrenceId":"6464ad08-f5e5-4134-a21d-b75045f8e215","artistId":"741eb4c0-4ab8-4ad5-8a64-2f156da6a395","displayText":"Ceky Viciny"}},{"type":"text","text":", y «No saben», con los puertorriqueños De La Ghetto y Chris Lebrón. En 2023 sumó dos nominaciones a los primeros Premios Núcleo Urbano RD."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Flow 28 pertenece al grupo que "},{"type":"artistReference","attrs":{"occurrenceId":"8ebb7e53-207d-42ba-a928-ef6cc0dd00be","artistId":"775a5598-26f8-45ee-9583-8c3193db5934","displayText":"Papaa Tyga"}},{"type":"text","text":" ha señalado como el centro de la escena actual del dembow, junto a "},{"type":"artistReference","attrs":{"occurrenceId":"bf3c67e1-3996-4a10-9f45-1a00aca0ad44","artistId":"550df3b5-6488-4aec-a476-a5d28d52ceea","displayText":"Bulin 47"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"de8a78ff-b387-4524-bfd9-ce4bc663343e","artistId":"741eb4c0-4ab8-4ad5-8a64-2f156da6a395","displayText":"Ceky Viciny"}},{"type":"text","text":", Yaisel y Jey One —una camada de artistas jóvenes de Santo Domingo que llevó el género desde el video callejero que lo dio a conocer hasta un catálogo propio y viral."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'flow-28'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'flow-28' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a2a6033a-5f18-4720-aff0-c73b0ffd9d94', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '45e86a47-e6f8-4d92-8aad-42b663474fa9', 'artist', '9be0ed08-6eb6-4ca0-bb68-d5126190aeb1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6f46cd37-8164-4c18-8893-903e9f2e0778', 'artist', '8243655e-17a7-4dea-98ee-1c16674c38cd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6464ad08-f5e5-4134-a21d-b75045f8e215', 'artist', '741eb4c0-4ab8-4ad5-8a64-2f156da6a395' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '8ebb7e53-207d-42ba-a928-ef6cc0dd00be', 'artist', '775a5598-26f8-45ee-9583-8c3193db5934' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'bf3c67e1-3996-4a10-9f45-1a00aca0ad44', 'artist', '550df3b5-6488-4aec-a476-a5d28d52ceea' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'de8a78ff-b387-4524-bfd9-ce4bc663343e', 'artist', '741eb4c0-4ab8-4ad5-8a64-2f156da6a395' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'flow-28' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Flow 28 —Carlos Flores, nacido en 2004 en Santo Domingo— es un artista de dembow dominicano del sector Herrera que se dio a conocer siendo adolescente con una canción que nació de un comentario en TikTok.

**Descubierto en una competencia**

Llevaba haciendo música desde pequeño cuando un mánager conocido como Gotera lo vio en una competencia local y lo abordó para verse al día siguiente en Cristo Rey; a comienzos de 2023 ya llevaban cerca de un año trabajando juntos. Flow le ha dado el crédito a su madre y a su hermano, que apostaron por él desde antes de ser conocido, por mantenerlo enfocado.

**«Po po po»**

Grabó un video con el productor Talvia y lo subió a TikTok, donde se disparó; a los pocos días Bulin 47 le comentó el video, diciéndole que se iba a pegar y que el año era suyo. Ese contacto llevó a que los mánagers de ambos los juntaran en «Po po po», la canción que fue el despegue de Flow —lanzada cuando tenía dieciocho años— y que desde entonces ha pasado los 58 millones de reproducciones en YouTube.

**Después del éxito**

Le siguieron temas como «Se comenta», «Cuba», «Tambora» y «Lo rafaguié», con Kiko el Crazy, además de «Gugle», con DJ Adoni, «El punto», con Ceky Viciny, y «No saben», con los puertorriqueños De La Ghetto y Chris Lebrón. En 2023 sumó dos nominaciones a los primeros Premios Núcleo Urbano RD.

**Legado**

Flow 28 pertenece al grupo que Papaa Tyga ha señalado como el centro de la escena actual del dembow, junto a Bulin 47, Ceky Viciny, Yaisel y Jey One —una camada de artistas jóvenes de Santo Domingo que llevó el género desde el video callejero que lo dio a conocer hasta un catálogo propio y viral.' WHERE slug = 'flow-28';

COMMIT;
