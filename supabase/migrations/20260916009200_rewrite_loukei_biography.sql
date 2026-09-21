BEGIN;

-- Loukei (antes Trainer Slump): artista urbano dominicano nacido el 20 de diciembre de 2001; el relleno le atribuía el nombre 'Trainer Slump' y un párrafo genérico. Fuentes: su canal oficial de YouTube y su biografía de Spotify (empezó a los 12 años con el proyecto 'Money' bajo el alias Trainer Slump; álbum CINEMA, 2024), MusicBrainz (Money, sencillo, 26 mar. 2020; 'Rapper'; etiquetas hip hop y r&b; nacimiento 2001-12-20), Dork (Money, 2020, producción Ignis Team). Ficha mínima: solo fuentes del propio artista; sin prensa. Campos: primary_genre urban-rap-hip-hop (urban-dembow no tenía respaldo: MusicBrainz y su descripción hablan de hip hop, r&b y melodías). Nacimiento: fila y MusicBrainz.

UPDATE artists SET primary_genre = 'urban-rap-hip-hop', genres = ARRAY[]::text[] WHERE slug = 'loukei';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Loukei, who began under the alias Trainer Slump, is a Dominican urban artist from Santo Domingo, born on 20 December 2001, whose music mixes modern beats and soulful melodies."}]},{"type":"paragraph","content":[{"type":"text","text":"Beginnings","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"According to his artist biography on Spotify, he began experimenting with sounds and lyrics at the age of twelve and made his first musical project, «Money», under the alias Trainer Slump. «Money» appears as a single dated 26 March 2020 and as a track of 2020 with production credited to Ignis Team."}]},{"type":"paragraph","content":[{"type":"text","text":"«Cinema»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Under the name Loukei he released «Cinema» in 2024, presented on his official YouTube channel as his single and dated 2024 on streaming platforms as an album; the channel describes him as a rising star from the Dominican Republic known for his blend of modern beats and soulful melodies."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His work is documented through his own channels and the releases on the streaming platforms."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'loukei'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'loukei' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Loukei, who began under the alias Trainer Slump, is a Dominican urban artist from Santo Domingo, born on 20 December 2001, whose music mixes modern beats and soulful melodies.

**Beginnings**

According to his artist biography on Spotify, he began experimenting with sounds and lyrics at the age of twelve and made his first musical project, «Money», under the alias Trainer Slump. «Money» appears as a single dated 26 March 2020 and as a track of 2020 with production credited to Ignis Team.

**«Cinema»**

Under the name Loukei he released «Cinema» in 2024, presented on his official YouTube channel as his single and dated 2024 on streaming platforms as an album; the channel describes him as a rising star from the Dominican Republic known for his blend of modern beats and soulful melodies.

**Legacy**

His work is documented through his own channels and the releases on the streaming platforms.' WHERE slug = 'loukei';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Loukei, que empezó con el alias Trainer Slump, es un artista urbano dominicano de Santo Domingo, nacido el 20 de diciembre de 2001, cuya música mezcla ritmos modernos y melodías soul."}]},{"type":"paragraph","content":[{"type":"text","text":"Inicios","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Según su biografía de artista en Spotify, empezó a experimentar con sonidos y letras a los doce años e hizo su primer proyecto musical, «Money», con el alias Trainer Slump. «Money» figura como un sencillo fechado el 26 de marzo de 2020 y como un tema de 2020 con producción acreditada a Ignis Team."}]},{"type":"paragraph","content":[{"type":"text","text":"«Cinema»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Con el nombre de Loukei publicó «Cinema» en 2024, presentado en su canal oficial de YouTube como su sencillo y fechado en 2024 en las plataformas de streaming como álbum; el canal lo describe como una estrella en ascenso de República Dominicana, conocida por su mezcla de ritmos modernos y melodías soul."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su obra está documentada a través de sus propios canales y de los lanzamientos en las plataformas de streaming."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'loukei'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'loukei' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Loukei, que empezó con el alias Trainer Slump, es un artista urbano dominicano de Santo Domingo, nacido el 20 de diciembre de 2001, cuya música mezcla ritmos modernos y melodías soul.

**Inicios**

Según su biografía de artista en Spotify, empezó a experimentar con sonidos y letras a los doce años e hizo su primer proyecto musical, «Money», con el alias Trainer Slump. «Money» figura como un sencillo fechado el 26 de marzo de 2020 y como un tema de 2020 con producción acreditada a Ignis Team.

**«Cinema»**

Con el nombre de Loukei publicó «Cinema» en 2024, presentado en su canal oficial de YouTube como su sencillo y fechado en 2024 en las plataformas de streaming como álbum; el canal lo describe como una estrella en ascenso de República Dominicana, conocida por su mezcla de ritmos modernos y melodías soul.

**Legado**

Su obra está documentada a través de sus propios canales y de los lanzamientos en las plataformas de streaming.' WHERE slug = 'loukei';

COMMIT;
