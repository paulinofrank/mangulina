BEGIN;

-- Ficha de Adriel Music: biografía corta y verificable (el relleno era especulación). Sin cambios de campo.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Adriel Music is an emerging Dominican urban artist who began writing songs in New York as a young teenager and has released his music from Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"Style","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"According to a 2021 press note, he had tried trap and dembow before settling on a fusion of styles that leans on his range, his flow and danceable rhythms, and which he says is what audiences demand at parties and clubs."}]},{"type":"paragraph","content":[{"type":"text","text":"Releases","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His single «La calle ta prendía», released in May 2021, was presented as a dance track for a public who wanted to enjoy themselves again after the pandemic; its video is on his YouTube channel. The channel also carries the official video of «Desde Abajo», credited with Mario TSB."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His work is recent and documented mainly by his channel and by the press note on «La calle ta prendía»."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'adriel-music'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'adriel-music' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Adriel Music is an emerging Dominican urban artist who began writing songs in New York as a young teenager and has released his music from Santo Domingo.

**Style**

According to a 2021 press note, he had tried trap and dembow before settling on a fusion of styles that leans on his range, his flow and danceable rhythms, and which he says is what audiences demand at parties and clubs.

**Releases**

His single «La calle ta prendía», released in May 2021, was presented as a dance track for a public who wanted to enjoy themselves again after the pandemic; its video is on his YouTube channel. The channel also carries the official video of «Desde Abajo», credited with Mario TSB.

**Legacy**

His work is recent and documented mainly by his channel and by the press note on «La calle ta prendía».' WHERE slug = 'adriel-music';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Adriel Music es un artista urbano dominicano emergente que empezó a escribir canciones en Nueva York siendo un adolescente y ha publicado su música desde Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"Estilo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Según una nota de prensa de 2021, había probado el trap y el dembow antes de quedarse con una fusión de estilos que se apoya en su registro, su manera de frasear y unos ritmos bailables, y que según él es lo que reclama el público en fiestas y discotecas."}]},{"type":"paragraph","content":[{"type":"text","text":"Lanzamientos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su sencillo «La calle ta prendía», de mayo de 2021, se presentó como un tema para bailar dirigido a un público que quería volver a divertirse después de la pandemia; su video está en su canal de YouTube. El canal incluye también el video oficial de «Desde Abajo», acreditado con Mario TSB."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su obra es reciente y está documentada sobre todo en su canal y en la nota de prensa sobre «La calle ta prendía»."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'adriel-music'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'adriel-music' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Adriel Music es un artista urbano dominicano emergente que empezó a escribir canciones en Nueva York siendo un adolescente y ha publicado su música desde Santo Domingo.

**Estilo**

Según una nota de prensa de 2021, había probado el trap y el dembow antes de quedarse con una fusión de estilos que se apoya en su registro, su manera de frasear y unos ritmos bailables, y que según él es lo que reclama el público en fiestas y discotecas.

**Lanzamientos**

Su sencillo «La calle ta prendía», de mayo de 2021, se presentó como un tema para bailar dirigido a un público que quería volver a divertirse después de la pandemia; su video está en su canal de YouTube. El canal incluye también el video oficial de «Desde Abajo», acreditado con Mario TSB.

**Legado**

Su obra es reciente y está documentada sobre todo en su canal y en la nota de prensa sobre «La calle ta prendía».' WHERE slug = 'adriel-music';

COMMIT;
