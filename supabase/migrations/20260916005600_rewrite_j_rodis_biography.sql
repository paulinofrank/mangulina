BEGIN;

-- J Rodis (Jorge Luis Rosario Rodríguez): artista urbano, no músico clásico como decía el relleno.
-- name/stage_name J Rodis, genres electronic (sin instrumental-classical), artist_tags secular, occupations composer.

UPDATE artists SET name = 'J Rodis', sort_name = 'Rodis, J', stage_name = 'J Rodis', genres = ARRAY['electronic']::text[],
       artist_tags = ARRAY['secular']::text[], occupations = '["composer"]'::jsonb WHERE slug = 'jorge-luis-rosario-rodriguez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"J Rodis —Jorge Luis Rosario Rodríguez, according to the credits on his songs— is a Dominican urban artist who has released pop, cumbia, reggaeton and electronic dance tracks since 2021."}]},{"type":"paragraph","content":[{"type":"text","text":"Releases","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His catalogue on the platforms begins with «Polos Opuesto» (29 January 2021), followed that year by «Tan Solo Tú», «Desde Que Te Toco», «Goza» and versions of «Mueve la Cadera» made for a TikTok dance trend. The video concept for «Desde Que Te Toco» was filmed at the Manglares of Cayo Arena in Puerto Plata. Later came «Te Confieso», «La Negra», «Ya Te He Olvidado», «Los Viejos Tiempo», «Primavera», «Mi Gran Amor», released as a cumbia in 2023, and «Te Quiero Yo» (2023) and «Morrita Bella». The EP «In The Heights» appeared in 2024, and «Clandestina Remix» was made with Salvatores."}]},{"type":"paragraph","content":[{"type":"text","text":"2025","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2025 he released «Fiesta Loca» on 16 May through the label «Sobrefilo Music», an afro house-style dance track that also has an official video, and the album «Second Awakening», which includes «Bomba». «Techno Energy» was made with «Sobrefilo Music Entertainment» and Jrg 07."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His work is documented mainly on the platforms where it is released, and it moves between urban pop and electronic dance music."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jorge-luis-rosario-rodriguez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jorge-luis-rosario-rodriguez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'J Rodis —Jorge Luis Rosario Rodríguez, according to the credits on his songs— is a Dominican urban artist who has released pop, cumbia, reggaeton and electronic dance tracks since 2021.

**Releases**

His catalogue on the platforms begins with «Polos Opuesto» (29 January 2021), followed that year by «Tan Solo Tú», «Desde Que Te Toco», «Goza» and versions of «Mueve la Cadera» made for a TikTok dance trend. The video concept for «Desde Que Te Toco» was filmed at the Manglares of Cayo Arena in Puerto Plata. Later came «Te Confieso», «La Negra», «Ya Te He Olvidado», «Los Viejos Tiempo», «Primavera», «Mi Gran Amor», released as a cumbia in 2023, and «Te Quiero Yo» (2023) and «Morrita Bella». The EP «In The Heights» appeared in 2024, and «Clandestina Remix» was made with Salvatores.

**2025**

In 2025 he released «Fiesta Loca» on 16 May through the label «Sobrefilo Music», an afro house-style dance track that also has an official video, and the album «Second Awakening», which includes «Bomba». «Techno Energy» was made with «Sobrefilo Music Entertainment» and Jrg 07.

**Legacy**

His work is documented mainly on the platforms where it is released, and it moves between urban pop and electronic dance music.' WHERE slug = 'jorge-luis-rosario-rodriguez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"J Rodis —Jorge Luis Rosario Rodríguez, según los créditos de sus canciones— es un artista urbano dominicano que desde 2021 publica temas de pop, cumbia, reguetón y baile electrónico."}]},{"type":"paragraph","content":[{"type":"text","text":"Lanzamientos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su catálogo en las plataformas arranca con «Polos Opuesto» (29 de enero de 2021), y ese año siguieron «Tan Solo Tú», «Desde Que Te Toco», «Goza» y versiones de «Mueve la Cadera» hechas para una tendencia de baile en TikTok. El video concepto de «Desde Que Te Toco» se filmó en los Manglares de Cayo Arena, en Puerto Plata. Después llegaron «Te Confieso», «La Negra», «Ya Te He Olvidado», «Los Viejos Tiempo», «Primavera», «Mi Gran Amor», lanzada como cumbia en 2023, y «Te Quiero Yo» (2023) y «Morrita Bella». El EP «In The Heights» salió en 2024, y «Clandestina Remix» la hizo con Salvatores."}]},{"type":"paragraph","content":[{"type":"text","text":"2025","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2025 publicó «Fiesta Loca» el 16 de mayo con el sello «Sobrefilo Music», un tema de baile de aire afro house que también tiene video oficial, y el álbum «Second Awakening», que incluye «Bomba». «Techno Energy» la hizo con «Sobrefilo Music Entertainment» y Jrg 07."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su obra está documentada sobre todo en las plataformas donde se publica, y se mueve entre el pop urbano y la música electrónica de baile."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jorge-luis-rosario-rodriguez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jorge-luis-rosario-rodriguez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'J Rodis —Jorge Luis Rosario Rodríguez, según los créditos de sus canciones— es un artista urbano dominicano que desde 2021 publica temas de pop, cumbia, reguetón y baile electrónico.

**Lanzamientos**

Su catálogo en las plataformas arranca con «Polos Opuesto» (29 de enero de 2021), y ese año siguieron «Tan Solo Tú», «Desde Que Te Toco», «Goza» y versiones de «Mueve la Cadera» hechas para una tendencia de baile en TikTok. El video concepto de «Desde Que Te Toco» se filmó en los Manglares de Cayo Arena, en Puerto Plata. Después llegaron «Te Confieso», «La Negra», «Ya Te He Olvidado», «Los Viejos Tiempo», «Primavera», «Mi Gran Amor», lanzada como cumbia en 2023, y «Te Quiero Yo» (2023) y «Morrita Bella». El EP «In The Heights» salió en 2024, y «Clandestina Remix» la hizo con Salvatores.

**2025**

En 2025 publicó «Fiesta Loca» el 16 de mayo con el sello «Sobrefilo Music», un tema de baile de aire afro house que también tiene video oficial, y el álbum «Second Awakening», que incluye «Bomba». «Techno Energy» la hizo con «Sobrefilo Music Entertainment» y Jrg 07.

**Legado**

Su obra está documentada sobre todo en las plataformas donde se publica, y se mueve entre el pop urbano y la música electrónica de baile.' WHERE slug = 'jorge-luis-rosario-rodriguez';

COMMIT;
