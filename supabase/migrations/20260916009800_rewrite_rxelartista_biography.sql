BEGIN;

-- RXelArtista (Rx el artista, Rafael Castillo): artista urbano latino de Santo Domingo, nacido el 14 de julio de 2000; el relleno era un párrafo genérico sobre el nombre artístico. Fuentes: descripción de su canal oficial de YouTube (nombre civil, Santo Domingo, mezcla de reguetón, afrobeat y trap melódico), lanzamientos del canal (La Baby, MMG, Tus ojos, Pa romperla, Darte, El Negri, Diablita, El Joker, One Love), MusicBrainz (nacimiento 2000-07-14, etiqueta reguetón, 'Artista de música urbana de República Dominicana'). Ficha mínima: solo fuentes propias, sin prensa. Campos: aliases Rx el artista y RX The Artist. Sin vistas ni suscriptores (regla 6).

UPDATE artists SET aliases = ARRAY['Rx el artista','RX The Artist']::text[] WHERE slug = 'rxelartista';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"RXelArtista —Rafael Castillo, born on 14 July 2000 in Santo Domingo— is a Dominican urban artist who goes by Rx el artista and describes his music as a blend of reggaeton, Afrobeat, melodic trap and emotional storytelling."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His official YouTube channel includes the videos «La Baby», «MMG» and «Tus ojos», and streaming releases such as «Pa romperla» and «Darte», followed in 2026 by the project «El Negri» and the songs «Diablita», «El Joker» and «One Love»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He belongs to the new generation of Dominican urban artists and is documented through his own channels and his releases on streaming platforms."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'rxelartista'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'rxelartista' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'RXelArtista —Rafael Castillo, born on 14 July 2000 in Santo Domingo— is a Dominican urban artist who goes by Rx el artista and describes his music as a blend of reggaeton, Afrobeat, melodic trap and emotional storytelling.

**Songs**

His official YouTube channel includes the videos «La Baby», «MMG» and «Tus ojos», and streaming releases such as «Pa romperla» and «Darte», followed in 2026 by the project «El Negri» and the songs «Diablita», «El Joker» and «One Love».

**Legacy**

He belongs to the new generation of Dominican urban artists and is documented through his own channels and his releases on streaming platforms.' WHERE slug = 'rxelartista';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"RXelArtista —Rafael Castillo, nacido el 14 de julio de 2000 en Santo Domingo— es un artista urbano dominicano que se presenta como Rx el artista y describe su música como una mezcla de reguetón, afrobeat, trap melódico y narración emocional."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su canal oficial de YouTube incluye los videos «La Baby», «MMG» y «Tus ojos», y lanzamientos en plataformas como «Pa romperla» y «Darte», seguidos en 2026 por el proyecto «El Negri» y las canciones «Diablita», «El Joker» y «One Love»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Pertenece a la nueva generación de artistas urbanos dominicanos y está documentado a través de sus propios canales y de sus lanzamientos en las plataformas de streaming."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'rxelartista'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'rxelartista' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'RXelArtista —Rafael Castillo, nacido el 14 de julio de 2000 en Santo Domingo— es un artista urbano dominicano que se presenta como Rx el artista y describe su música como una mezcla de reguetón, afrobeat, trap melódico y narración emocional.

**Canciones**

Su canal oficial de YouTube incluye los videos «La Baby», «MMG» y «Tus ojos», y lanzamientos en plataformas como «Pa romperla» y «Darte», seguidos en 2026 por el proyecto «El Negri» y las canciones «Diablita», «El Joker» y «One Love».

**Legado**

Pertenece a la nueva generación de artistas urbanos dominicanos y está documentado a través de sus propios canales y de sus lanzamientos en las plataformas de streaming.' WHERE slug = 'rxelartista';

COMMIT;
