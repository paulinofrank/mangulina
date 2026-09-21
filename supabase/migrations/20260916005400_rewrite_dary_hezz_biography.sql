BEGIN;

-- Ficha de Dary Hezz: biografía corta y verificable (el relleno era especulación). Sin cambios de campo.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Dary Hezz —the stage name of Fraynel de los Santos Romero, born in Santo Domingo in 2003— is a Dominican rapper, singer and composer of urban music who describes his style as a mix of trap, reggaeton and R&B."}]},{"type":"paragraph","content":[{"type":"text","text":"Releases","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His catalogue on the platforms begins in 2021 with the single «Si Se Me Da» (February) and the EP «El Hezz De Las Baby’s» (May), a title that is also his nickname. In 2024 he released the singles «Llegará» (February) and «Diferentes» (March), the latter with El Onii. His YouTube channel also carries «No Me Dijiste», made with El Onii and Kanyel King, along with «Inmarcesible», «Modelame», «Lealtad» and «Seguimos Normal»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His work is recent and documented mainly on the platforms where it is released."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dary-hezz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'dary-hezz' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Dary Hezz —the stage name of Fraynel de los Santos Romero, born in Santo Domingo in 2003— is a Dominican rapper, singer and composer of urban music who describes his style as a mix of trap, reggaeton and R&B.

**Releases**

His catalogue on the platforms begins in 2021 with the single «Si Se Me Da» (February) and the EP «El Hezz De Las Baby’s» (May), a title that is also his nickname. In 2024 he released the singles «Llegará» (February) and «Diferentes» (March), the latter with El Onii. His YouTube channel also carries «No Me Dijiste», made with El Onii and Kanyel King, along with «Inmarcesible», «Modelame», «Lealtad» and «Seguimos Normal».

**Legacy**

His work is recent and documented mainly on the platforms where it is released.' WHERE slug = 'dary-hezz';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Dary Hezz —nombre artístico de Fraynel de los Santos Romero, nacido en Santo Domingo en 2003— es un rapero, cantante y compositor dominicano de música urbana que describe su estilo como una mezcla de trap, reguetón y R&B."}]},{"type":"paragraph","content":[{"type":"text","text":"Lanzamientos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su catálogo en las plataformas arranca en 2021 con el sencillo «Si Se Me Da» (febrero) y el EP «El Hezz De Las Baby’s» (mayo), título que es también su apodo. En 2024 publicó los sencillos «Llegará» (febrero) y «Diferentes» (marzo), este último con El Onii. Su canal de YouTube incluye además «No Me Dijiste», hecho con El Onii y Kanyel King, junto a «Inmarcesible», «Modelame», «Lealtad» y «Seguimos Normal»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su obra es reciente y está documentada sobre todo en las plataformas donde se publica."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'dary-hezz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'dary-hezz' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Dary Hezz —nombre artístico de Fraynel de los Santos Romero, nacido en Santo Domingo en 2003— es un rapero, cantante y compositor dominicano de música urbana que describe su estilo como una mezcla de trap, reguetón y R&B.

**Lanzamientos**

Su catálogo en las plataformas arranca en 2021 con el sencillo «Si Se Me Da» (febrero) y el EP «El Hezz De Las Baby’s» (mayo), título que es también su apodo. En 2024 publicó los sencillos «Llegará» (febrero) y «Diferentes» (marzo), este último con El Onii. Su canal de YouTube incluye además «No Me Dijiste», hecho con El Onii y Kanyel King, junto a «Inmarcesible», «Modelame», «Lealtad» y «Seguimos Normal».

**Legado**

Su obra es reciente y está documentada sobre todo en las plataformas donde se publica.' WHERE slug = 'dary-hezz';

COMMIT;
