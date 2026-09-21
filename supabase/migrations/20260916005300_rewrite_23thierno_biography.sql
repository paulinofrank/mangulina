BEGIN;

-- Ficha de 23Thierno: biografía corta y verificable (el relleno era especulación). Sin cambios de campo.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"23Thierno is an emerging Dominican urban artist, born in 2001 in San Cristóbal, whose catalogue on the streaming platforms begins in 2024."}]},{"type":"paragraph","content":[{"type":"text","text":"Releases","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The earliest of his releases on Apple Music, «Panas Falsos» and «With “U”», date from 2024, along with «Love It», made with Yauri GM, and «No Me Haces Falta», made with Johcrap Marfer. In 2025 came «Monotonía», «Mi Cocola» with FlowYeraldy and «Baby You», a track credited to Angel Fire, 23Thierno and Johcrap Marfer that has an official video on his YouTube channel. He is also the featured artist on «Le Jure» by Angi Fire and DJ Human Star, and his most recent single, «Nena», is dated 27 February 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His work is recent and documented mainly on the platforms where it is released."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = '23thierno'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = '23thierno' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = '23Thierno is an emerging Dominican urban artist, born in 2001 in San Cristóbal, whose catalogue on the streaming platforms begins in 2024.

**Releases**

The earliest of his releases on Apple Music, «Panas Falsos» and «With “U”», date from 2024, along with «Love It», made with Yauri GM, and «No Me Haces Falta», made with Johcrap Marfer. In 2025 came «Monotonía», «Mi Cocola» with FlowYeraldy and «Baby You», a track credited to Angel Fire, 23Thierno and Johcrap Marfer that has an official video on his YouTube channel. He is also the featured artist on «Le Jure» by Angi Fire and DJ Human Star, and his most recent single, «Nena», is dated 27 February 2026.

**Legacy**

His work is recent and documented mainly on the platforms where it is released.' WHERE slug = '23thierno';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"23Thierno es un artista urbano dominicano emergente, nacido en 2001 en San Cristóbal, cuyo catálogo en las plataformas de streaming comienza en 2024."}]},{"type":"paragraph","content":[{"type":"text","text":"Lanzamientos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los más antiguos de sus lanzamientos en Apple Music, «Panas Falsos» y «With “U”», son de 2024, junto con «Love It», hecho con Yauri GM, y «No Me Haces Falta», hecho con Johcrap Marfer. En 2025 llegaron «Monotonía», «Mi Cocola» con FlowYeraldy y «Baby You», tema acreditado a Angel Fire, 23Thierno y Johcrap Marfer que tiene video oficial en su canal de YouTube. También es el invitado de «Le Jure», de Angi Fire y DJ Human Star, y su sencillo más reciente, «Nena», lleva fecha del 27 de febrero de 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su obra es reciente y está documentada sobre todo en las plataformas donde se publica."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = '23thierno'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = '23thierno' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = '23Thierno es un artista urbano dominicano emergente, nacido en 2001 en San Cristóbal, cuyo catálogo en las plataformas de streaming comienza en 2024.

**Lanzamientos**

Los más antiguos de sus lanzamientos en Apple Music, «Panas Falsos» y «With “U”», son de 2024, junto con «Love It», hecho con Yauri GM, y «No Me Haces Falta», hecho con Johcrap Marfer. En 2025 llegaron «Monotonía», «Mi Cocola» con FlowYeraldy y «Baby You», tema acreditado a Angel Fire, 23Thierno y Johcrap Marfer que tiene video oficial en su canal de YouTube. También es el invitado de «Le Jure», de Angi Fire y DJ Human Star, y su sencillo más reciente, «Nena», lleva fecha del 27 de febrero de 2026.

**Legado**

Su obra es reciente y está documentada sobre todo en las plataformas donde se publica.' WHERE slug = '23thierno';

COMMIT;
