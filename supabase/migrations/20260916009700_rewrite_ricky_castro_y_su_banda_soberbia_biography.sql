BEGIN;

-- Ricky Castro y su Banda Soberbia: banda de merengue de los años noventa, conocida por «Después de ti», «El enano», «El pariguayo», «Es duro» y «El sun sun de la carabela»; la ficha solo tenía una frase vacía. Fuentes: AllMusic / iHeart (banda de 'hardcore merengue' y sus éxitos), canal oficial de YouTube (descripción y discos), Apple Music y Spotify (Banda Soberbia 1996, El Beeper 1993, La Mole de Nueva New York 1997, Por qué eres así 1999, Merengue Funkyao), descripciones de discos de DJ Intokable (Después de ti y Deseos, 1997; Espejo, Discomanía), una publicación de República Merengue (gran pegada en 1997-98). Ficha mínima: sin fundación, integrantes ni entrevistas. Campos: occupations bandleader. La fila es solo_artist con nombre de banda: separación pendiente. No se usan vistas ni suscriptores (regla 6).

UPDATE artists SET occupations = '["bandleader"]'::jsonb WHERE slug = 'ricky-castro-y-su-banda-soberbia';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Ricky Castro y su Banda Soberbia is a Dominican merengue band led by the singer Ricky Castro, which AllMusic describes as a hardcore merengue outfit and which was popular in the 1990s."}]},{"type":"paragraph","content":[{"type":"text","text":"Hits","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The band is best known for «Después de ti», «El enano», «El pariguayo», «Es duro» and «El sun sun de la carabela». A merengue page recalls that it was a great hit especially in 1997 and 1998, and a video series of album reissues dates «Después de ti» and «Deseos» to 1997."}]},{"type":"paragraph","content":[{"type":"text","text":"Albums","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Its streaming catalogue includes «El beeper» (1993), «Banda Soberbia» (1996), «La mole de Nueva New York» (1997) and «Por qué eres así» (1999), as well as «Merengue funkyao» and «Espejo», a Discomanía release with «El enano» among its tracks."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ricky Castro’s official channel describes him as a Dominican artist who has taken his style and energy to national and international stages, and the band’s 1990s songs remain in circulation on the platforms."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'ricky-castro-y-su-banda-soberbia'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'ricky-castro-y-su-banda-soberbia' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Ricky Castro y su Banda Soberbia is a Dominican merengue band led by the singer Ricky Castro, which AllMusic describes as a hardcore merengue outfit and which was popular in the 1990s.

**Hits**

The band is best known for «Después de ti», «El enano», «El pariguayo», «Es duro» and «El sun sun de la carabela». A merengue page recalls that it was a great hit especially in 1997 and 1998, and a video series of album reissues dates «Después de ti» and «Deseos» to 1997.

**Albums**

Its streaming catalogue includes «El beeper» (1993), «Banda Soberbia» (1996), «La mole de Nueva New York» (1997) and «Por qué eres así» (1999), as well as «Merengue funkyao» and «Espejo», a Discomanía release with «El enano» among its tracks.

**Legacy**

Ricky Castro’s official channel describes him as a Dominican artist who has taken his style and energy to national and international stages, and the band’s 1990s songs remain in circulation on the platforms.' WHERE slug = 'ricky-castro-y-su-banda-soberbia';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Ricky Castro y su Banda Soberbia es una banda dominicana de merengue dirigida por el cantante Ricky Castro, que AllMusic describe como un grupo de merengue «hardcore» y que fue popular en los años noventa."}]},{"type":"paragraph","content":[{"type":"text","text":"Éxitos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La banda es más conocida por «Después de ti», «El enano», «El pariguayo», «Es duro» y «El sun sun de la carabela». Una página de merengue recuerda que fue una gran pegada sobre todo en 1997 y 1998, y una serie de videos de reediciones de discos fecha «Después de ti» y «Deseos» en 1997."}]},{"type":"paragraph","content":[{"type":"text","text":"Discos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su catálogo en las plataformas incluye «El beeper» (1993), «Banda Soberbia» (1996), «La mole de Nueva New York» (1997) y «Por qué eres así» (1999), además de «Merengue funkyao» y «Espejo», un lanzamiento de Discomanía que tiene «El enano» entre sus temas."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El canal oficial de Ricky Castro lo describe como un artista dominicano que ha llevado su estilo y su energía a escenarios nacionales e internacionales, y las canciones de la banda de los años noventa siguen en circulación en las plataformas."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'ricky-castro-y-su-banda-soberbia'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'ricky-castro-y-su-banda-soberbia' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Ricky Castro y su Banda Soberbia es una banda dominicana de merengue dirigida por el cantante Ricky Castro, que AllMusic describe como un grupo de merengue «hardcore» y que fue popular en los años noventa.

**Éxitos**

La banda es más conocida por «Después de ti», «El enano», «El pariguayo», «Es duro» y «El sun sun de la carabela». Una página de merengue recuerda que fue una gran pegada sobre todo en 1997 y 1998, y una serie de videos de reediciones de discos fecha «Después de ti» y «Deseos» en 1997.

**Discos**

Su catálogo en las plataformas incluye «El beeper» (1993), «Banda Soberbia» (1996), «La mole de Nueva New York» (1997) y «Por qué eres así» (1999), además de «Merengue funkyao» y «Espejo», un lanzamiento de Discomanía que tiene «El enano» entre sus temas.

**Legado**

El canal oficial de Ricky Castro lo describe como un artista dominicano que ha llevado su estilo y su energía a escenarios nacionales e internacionales, y las canciones de la banda de los años noventa siguen en circulación en las plataformas.' WHERE slug = 'ricky-castro-y-su-banda-soberbia';

COMMIT;
