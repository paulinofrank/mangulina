BEGIN;

-- Ficha de Anon Müller. Nombre civil Oscar Ricardo Feliz Ramírez; primary_role singer -> producer; occupations composer, writer.

UPDATE artists SET first_name = 'Oscar', middle_name = 'Ricardo', last_name = 'Feliz', second_last_name = 'Ramírez',
       aliases = ARRAY['AnonMüller','Anon Muller']::text[], primary_role = 'producer', occupations = '["composer","writer"]'::jsonb
       WHERE slug = 'anon-muller';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Anon Müller —born Oscar Ricardo Feliz Ramírez on 19 May 1986— is a Dominican producer, composer and writer who releases electronic pop and house-leaning music under that name."}]},{"type":"paragraph","content":[{"type":"text","text":"Releases","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His catalogue on the streaming platforms dates from 2019, when he released the single «Rindin Pop», the EPs «Maniac Skills» and «Looking For» and the single «XXX Creepy in Da House». «Space Delivery» followed in 2020. Song credits list him as writer and producer of his own tracks; «Break Your Mind», released on 15 March 2019, is tagged as pop and house. His YouTube channel carries music videos for «Rindin Pop», «Extraction», «Knife Into», «Blackhead», «First Last Time» and «In That World»."}]},{"type":"paragraph","content":[{"type":"text","text":"Writing","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Besides music he has published a book, «Las Cartas de Solitarias», a 65-page Spanish-language e-book that appeared on 6 April 2020."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His body of work is small and recent, and it is documented mainly by platform credits and his own pages, which describe him as a music and video producer, director, writer and composer."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'anon-muller'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'anon-muller' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Anon Müller —born Oscar Ricardo Feliz Ramírez on 19 May 1986— is a Dominican producer, composer and writer who releases electronic pop and house-leaning music under that name.

**Releases**

His catalogue on the streaming platforms dates from 2019, when he released the single «Rindin Pop», the EPs «Maniac Skills» and «Looking For» and the single «XXX Creepy in Da House». «Space Delivery» followed in 2020. Song credits list him as writer and producer of his own tracks; «Break Your Mind», released on 15 March 2019, is tagged as pop and house. His YouTube channel carries music videos for «Rindin Pop», «Extraction», «Knife Into», «Blackhead», «First Last Time» and «In That World».

**Writing**

Besides music he has published a book, «Las Cartas de Solitarias», a 65-page Spanish-language e-book that appeared on 6 April 2020.

**Legacy**

His body of work is small and recent, and it is documented mainly by platform credits and his own pages, which describe him as a music and video producer, director, writer and composer.' WHERE slug = 'anon-muller';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Anon Müller —nacido Oscar Ricardo Feliz Ramírez el 19 de mayo de 1986— es un productor, compositor y escritor dominicano que publica con ese nombre música de pop electrónico con inclinación al house."}]},{"type":"paragraph","content":[{"type":"text","text":"Lanzamientos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su catálogo en las plataformas de streaming arranca en 2019, cuando publicó el sencillo «Rindin Pop», los EP «Maniac Skills» y «Looking For» y el sencillo «XXX Creepy in Da House». «Space Delivery» llegó en 2020. Los créditos de sus canciones lo señalan como autor y productor de sus propios temas; «Break Your Mind», lanzada el 15 de marzo de 2019, aparece etiquetada como pop y house. Su canal de YouTube reúne videos musicales de «Rindin Pop», «Extraction», «Knife Into», «Blackhead», «First Last Time» e «In That World»."}]},{"type":"paragraph","content":[{"type":"text","text":"Escritura","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Además de música ha publicado un libro, «Las Cartas de Solitarias», un libro electrónico en español de 65 páginas que salió el 6 de abril de 2020."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su obra es breve y reciente, y está documentada sobre todo en los créditos de las plataformas y en sus propias páginas, que lo describen como productor de música y video, director, escritor y compositor."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'anon-muller'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'anon-muller' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Anon Müller —nacido Oscar Ricardo Feliz Ramírez el 19 de mayo de 1986— es un productor, compositor y escritor dominicano que publica con ese nombre música de pop electrónico con inclinación al house.

**Lanzamientos**

Su catálogo en las plataformas de streaming arranca en 2019, cuando publicó el sencillo «Rindin Pop», los EP «Maniac Skills» y «Looking For» y el sencillo «XXX Creepy in Da House». «Space Delivery» llegó en 2020. Los créditos de sus canciones lo señalan como autor y productor de sus propios temas; «Break Your Mind», lanzada el 15 de marzo de 2019, aparece etiquetada como pop y house. Su canal de YouTube reúne videos musicales de «Rindin Pop», «Extraction», «Knife Into», «Blackhead», «First Last Time» e «In That World».

**Escritura**

Además de música ha publicado un libro, «Las Cartas de Solitarias», un libro electrónico en español de 65 páginas que salió el 6 de abril de 2020.

**Legado**

Su obra es breve y reciente, y está documentada sobre todo en los créditos de las plataformas y en sus propias páginas, que lo describen como productor de música y video, director, escritor y compositor.' WHERE slug = 'anon-muller';

COMMIT;
