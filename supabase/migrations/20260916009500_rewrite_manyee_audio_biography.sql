BEGIN;

-- Manyee Audio (antes Mangee Audio): DJ y productor dominicano basado en Tórtola, Islas Vírgenes Británicas; la ficha solo tenía una frase vacía y lo llamaba grupo. Fuentes: su propio sitio manyeeaudio.com (biografía: primeros cinco años en Los Mina, luego Tórtola, estudios de producción de audio en Boston y de DJ en Nueva York), su biografía de Spotify y SoundBetter, Mixcloud (nacido en Santo Domingo), Chartmetric, MusicBrainz (etiquetas dj, dancehall, reguetón, calipso, soca, dembow, Tórtola, BVI; inicio 1986-03-22, sin corroborar: no se usa la fecha). Ficha de una sola fuente (la propia): el texto la atribuye y omite adjetivos promocionales ('entre los mejores de RD y el Caribe'). Campos: aliases Mangee Audio, birth_place Santo Domingo / Santo Domingo, tag diaspora, occupations producer y engineer; primary_role dj se mantiene.

UPDATE artists SET aliases = ARRAY['Mangee Audio']::text[], birth_place = 'Santo Domingo', province = 'Santo Domingo', occupations = '["producer","engineer"]'::jsonb, artist_tags = ARRAY['secular','diaspora']::text[] WHERE slug = 'manyee-audio';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manyee Audio, formerly Mangee Audio, is a Dominican DJ and producer born in Santo Domingo and based in Tortola, in the British Virgin Islands."}]},{"type":"paragraph","content":[{"type":"text","text":"From Los Mina to Tortola","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"According to the biography on his own website, he lived the first five years of his life in the Los Mina district of Santo Domingo, after which he emigrated with his family to the island of Tortola, where his grandmother was from, and grew up there until finishing high school. He later studied audio production in Boston and the art of the disc jockey in New York."}]},{"type":"paragraph","content":[{"type":"text","text":"Music","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He presents his work as a natural fusion of Latin, Caribbean and urban rhythms, with bilingual sets for clubs, festivals and international audiences, supported by his own productions, riddims and edits made for live performance. His releases include songs, albums and instrumental riddims, some of them collaborations with artists, DJs and other producers. His YouTube channel carries a series of live sessions under the name «Mangee Audio en vivo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Manyee Audio is documented through his own website and channels, where he describes himself as a DJ and producer of bilingual experiences and Caribbean rhythms."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manyee-audio'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manyee-audio' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Manyee Audio, formerly Mangee Audio, is a Dominican DJ and producer born in Santo Domingo and based in Tortola, in the British Virgin Islands.

**From Los Mina to Tortola**

According to the biography on his own website, he lived the first five years of his life in the Los Mina district of Santo Domingo, after which he emigrated with his family to the island of Tortola, where his grandmother was from, and grew up there until finishing high school. He later studied audio production in Boston and the art of the disc jockey in New York.

**Music**

He presents his work as a natural fusion of Latin, Caribbean and urban rhythms, with bilingual sets for clubs, festivals and international audiences, supported by his own productions, riddims and edits made for live performance. His releases include songs, albums and instrumental riddims, some of them collaborations with artists, DJs and other producers. His YouTube channel carries a series of live sessions under the name «Mangee Audio en vivo».

**Legacy**

Manyee Audio is documented through his own website and channels, where he describes himself as a DJ and producer of bilingual experiences and Caribbean rhythms.' WHERE slug = 'manyee-audio';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manyee Audio, antes conocido como Mangee Audio, es un DJ y productor dominicano nacido en Santo Domingo y radicado en Tórtola, en las Islas Vírgenes Británicas."}]},{"type":"paragraph","content":[{"type":"text","text":"De Los Mina a Tórtola","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Según la biografía de su propio sitio web, vivió los primeros cinco años de su vida en el barrio Los Mina de Santo Domingo, tras lo cual emigró con su familia a la isla de Tórtola, de donde era su abuela, y se crio allí hasta terminar el bachillerato. Más tarde estudió producción de audio en Boston y el arte del disc jockey en Nueva York."}]},{"type":"paragraph","content":[{"type":"text","text":"Música","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Presenta su trabajo como una fusión natural de ritmos latinos, caribeños y urbanos, con sets bilingües para clubes, festivales y públicos internacionales, apoyados en sus propias producciones, riddims y ediciones hechas para presentaciones en vivo. Sus lanzamientos incluyen canciones, álbumes y riddims instrumentales, algunos en colaboración con artistas, DJs y otros productores. Su canal de YouTube tiene una serie de sesiones en vivo bajo el nombre «Mangee Audio en vivo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Manyee Audio está documentado a través de su propio sitio web y sus canales, donde se describe como DJ y productor de experiencias bilingües y ritmos caribeños."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manyee-audio'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manyee-audio' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Manyee Audio, antes conocido como Mangee Audio, es un DJ y productor dominicano nacido en Santo Domingo y radicado en Tórtola, en las Islas Vírgenes Británicas.

**De Los Mina a Tórtola**

Según la biografía de su propio sitio web, vivió los primeros cinco años de su vida en el barrio Los Mina de Santo Domingo, tras lo cual emigró con su familia a la isla de Tórtola, de donde era su abuela, y se crio allí hasta terminar el bachillerato. Más tarde estudió producción de audio en Boston y el arte del disc jockey en Nueva York.

**Música**

Presenta su trabajo como una fusión natural de ritmos latinos, caribeños y urbanos, con sets bilingües para clubes, festivales y públicos internacionales, apoyados en sus propias producciones, riddims y ediciones hechas para presentaciones en vivo. Sus lanzamientos incluyen canciones, álbumes y riddims instrumentales, algunos en colaboración con artistas, DJs y otros productores. Su canal de YouTube tiene una serie de sesiones en vivo bajo el nombre «Mangee Audio en vivo».

**Legado**

Manyee Audio está documentado a través de su propio sitio web y sus canales, donde se describe como DJ y productor de experiencias bilingües y ritmos caribeños.' WHERE slug = 'manyee-audio';

COMMIT;
