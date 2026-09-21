BEGIN;

-- La Banda X: orquesta de merengue de mambo o merengue urbano dirigida por Richie Herrera; la ficha solo tenía una frase vacía. Fuentes: El Nacional (19 ago. 2009, entrevista a Richie Herrera: más de quince años al frente, Tajevi, Travesura, 'padre del merengue urbano', vive en EE. UU.), descripciones de discos de DJ Intokable (Ta' Heavy 1995, Discomanía; Te va bien 1998; Ese soy yo 2000, sello MP), Spotify y Apple Music (Back to the Mambo, 2000 y 2002), AllMusic (créditos de Richie Herrera), Instagram de Oye Merengue (Así es que lo quiero, 1998, 'Dale cintura'), Telemicro (actuación en 'Extremo a Extremo', 2025), un video de Paul Bouche (integrantes de Puerto Rico y RD). Campos: aliases Richie Herrera y La Banda X y Banda X; occupations bandleader; lugar de origen (Santiago) sin respaldo: se conserva porque la fila lo trae, sin decirlo en el texto. Sin cifras vivas. Título de 'padre del merengue urbano' es dicho del propio Herrera y va atribuido.

UPDATE artists SET aliases = ARRAY['Richie Herrera y La Banda X','Banda X']::text[], occupations = '["bandleader"]'::jsonb WHERE slug = 'la-banda-x';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"La Banda X, also known as Richie Herrera y La Banda X, is a Dominican merengue group led by the singer, composer and producer Richie Herrera, associated with the mambo and urban merengue that took off in the 1990s."}]},{"type":"paragraph","content":[{"type":"text","text":"Richie Herrera and the band","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2009 the newspaper El Nacional described Herrera as leader of the well-known Banda X for more than fifteen years and as a merenguero who had lived for several years in the United States. In that interview he called himself the “father of urban merengue”, said the music of the street merengue singers could not travel beyond the country and announced the song «Travesura» for the band’s next album. He is also the singer of «Tajevi»."}]},{"type":"paragraph","content":[{"type":"text","text":"Records","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The band’s album «Ta’ Heavy» (1995) appeared on Discomanía, «Así es que lo quiero» (1998) includes «Dale cintura», written and produced by Herrera, and «Te va bien» dates from the same year. In 2000 came «Ese soy yo», on the label MP, and the album «Back to the Mambo», which includes «Me la llevo», «La caraqueña» and «Chequeando», is dated 2000 and 2002 depending on the edition. AllMusic credits Herrera with vocals, bass, composition and production in the band’s records."}]},{"type":"paragraph","content":[{"type":"text","text":"Later years","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The group has kept performing with musicians from Puerto Rico and the Dominican Republic, and in 2025 it played on the Telemicro program «Extremo a Extremo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La Banda X is documented through its albums of the 1990s and 2000s and through the interviews with its leader; the title he gives himself, “father of urban merengue”, is his own."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'la-banda-x'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'la-banda-x' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'La Banda X, also known as Richie Herrera y La Banda X, is a Dominican merengue group led by the singer, composer and producer Richie Herrera, associated with the mambo and urban merengue that took off in the 1990s.

**Richie Herrera and the band**

In 2009 the newspaper El Nacional described Herrera as leader of the well-known Banda X for more than fifteen years and as a merenguero who had lived for several years in the United States. In that interview he called himself the “father of urban merengue”, said the music of the street merengue singers could not travel beyond the country and announced the song «Travesura» for the band’s next album. He is also the singer of «Tajevi».

**Records**

The band’s album «Ta’ Heavy» (1995) appeared on Discomanía, «Así es que lo quiero» (1998) includes «Dale cintura», written and produced by Herrera, and «Te va bien» dates from the same year. In 2000 came «Ese soy yo», on the label MP, and the album «Back to the Mambo», which includes «Me la llevo», «La caraqueña» and «Chequeando», is dated 2000 and 2002 depending on the edition. AllMusic credits Herrera with vocals, bass, composition and production in the band’s records.

**Later years**

The group has kept performing with musicians from Puerto Rico and the Dominican Republic, and in 2025 it played on the Telemicro program «Extremo a Extremo».

**Legacy**

La Banda X is documented through its albums of the 1990s and 2000s and through the interviews with its leader; the title he gives himself, “father of urban merengue”, is his own.' WHERE slug = 'la-banda-x';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"La Banda X, también conocida como Richie Herrera y La Banda X, es una agrupación dominicana de merengue dirigida por el cantante, compositor y productor Richie Herrera, asociada al merengue de mambo y al merengue urbano que despegó en los años noventa."}]},{"type":"paragraph","content":[{"type":"text","text":"Richie Herrera y la banda","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2009 el periódico El Nacional describió a Herrera como líder de la reconocida Banda X por más de quince años y como un merenguero radicado durante varios años en Estados Unidos. En esa entrevista se llamó a sí mismo el “papá del merengue urbano”, dijo que la música de los merengueros de calle no podía trascender las fronteras y anunció el tema «Travesura» para el próximo disco de la banda. Es también el cantante de «Tajevi»."}]},{"type":"paragraph","content":[{"type":"text","text":"Discos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El álbum «Ta’ Heavy» (1995) salió en Discomanía, «Así es que lo quiero» (1998) incluye «Dale cintura», escrita y producida por Herrera, y «Te va bien» es del mismo año. En 2000 llegó «Ese soy yo», en el sello MP, y el álbum «Back to the Mambo», que incluye «Me la llevo», «La caraqueña» y «Chequeando», se fecha en 2000 y 2002 según la edición. AllMusic acredita a Herrera con voz, bajo, composición y producción en los discos de la banda."}]},{"type":"paragraph","content":[{"type":"text","text":"Años recientes","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El grupo ha seguido presentándose con músicos de Puerto Rico y de República Dominicana, y en 2025 actuó en el programa de Telemicro «Extremo a Extremo»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La Banda X está documentada a través de sus discos de los años noventa y dos mil y de las entrevistas con su líder; el título de “papá del merengue urbano” es una afirmación propia."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'la-banda-x'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'la-banda-x' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'La Banda X, también conocida como Richie Herrera y La Banda X, es una agrupación dominicana de merengue dirigida por el cantante, compositor y productor Richie Herrera, asociada al merengue de mambo y al merengue urbano que despegó en los años noventa.

**Richie Herrera y la banda**

En 2009 el periódico El Nacional describió a Herrera como líder de la reconocida Banda X por más de quince años y como un merenguero radicado durante varios años en Estados Unidos. En esa entrevista se llamó a sí mismo el “papá del merengue urbano”, dijo que la música de los merengueros de calle no podía trascender las fronteras y anunció el tema «Travesura» para el próximo disco de la banda. Es también el cantante de «Tajevi».

**Discos**

El álbum «Ta’ Heavy» (1995) salió en Discomanía, «Así es que lo quiero» (1998) incluye «Dale cintura», escrita y producida por Herrera, y «Te va bien» es del mismo año. En 2000 llegó «Ese soy yo», en el sello MP, y el álbum «Back to the Mambo», que incluye «Me la llevo», «La caraqueña» y «Chequeando», se fecha en 2000 y 2002 según la edición. AllMusic acredita a Herrera con voz, bajo, composición y producción en los discos de la banda.

**Años recientes**

El grupo ha seguido presentándose con músicos de Puerto Rico y de República Dominicana, y en 2025 actuó en el programa de Telemicro «Extremo a Extremo».

**Legado**

La Banda X está documentada a través de sus discos de los años noventa y dos mil y de las entrevistas con su líder; el título de “papá del merengue urbano” es una afirmación propia.' WHERE slug = 'la-banda-x';

COMMIT;
