BEGIN;

-- Archaios: banda de death metal melódico (antes Legion, desde 1994). genres vacío, sin tag emerging, origen Santo Domingo.

UPDATE artists SET birth_place = 'Santo Domingo', province = 'Distrito Nacional', genres = '{}'::text[], birth_year = 1994, artist_tags = ARRAY['secular']::text[] WHERE slug = 'archaios';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Archaios is a melodic death metal band from Santo Domingo. It began in 1994 as Legion and took the name Archaios, which means “ancient”, in 2003."}]},{"type":"paragraph","content":[{"type":"text","text":"As Legion","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Under its first name the band appeared with «Eterno Sufrimiento» and «Desperdida» on «Metal por un Tubo», a 1997 compilation CD issued by the magazine Radioactiva."}]},{"type":"paragraph","content":[{"type":"text","text":"Albums","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Its first album, «Out of the Shadows», came out in 2005, and the second, «The Distant», on 11 November 2011 through «Dark Canvas Records». The international metal database Encyclopaedia Metallum lists its subjects as inner struggles, existentialism, vengeance and despair. Reviewing «The Distant» for Heavy Metal Tribune, a critic scored it 14 out of 20 and called it a modern update of the melodic death metal of Soilwork and In Flames, with guitar solos of an almost neo-classical feel; he said it was the first band from the Dominican Republic he had come across."}]},{"type":"paragraph","content":[{"type":"text","text":"Abroad","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The band’s tracks reached international compilations: «The Distant» on Metal Hammer’s «Global Metal Vol. 3» (2011), «Legions (In Remembrance Of...)» on Terrorizer’s «Fear Candy 102» (2012) and «The Distant» again on «Global Domination Vol. 1», a digital release of «No Remorse Records» in April 2014."}]},{"type":"paragraph","content":[{"type":"text","text":"Members","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The guitarist Eric Cruz has been in the band since 2003 and is the only current member listed. Past members include the guitarists JC Castillo, who played until his death in 2019, Joel Solano and Albert de Peña; the bassists Koresh and David Masalles, who has also played in"},{"type":"artistReference","attrs":{"occurrenceId":"942e3465-f8b3-41a8-98a6-9eda83c8eb1d","artistId":"ea2d1a26-e4d8-4daf-b487-52fe68faad36","displayText":"Soul of Death"}},{"type":"text","text":"; the drummers Johandy Ureña, Alfredo Baltrá and Silvio “El Chivo”, who has also played in «Necro»; and the vocalist Rubén Cruz."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2022 the metal site MetalSucks included Archaios in a list of fifteen bands from the Dominican Republic, and the international archives list it as active."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'archaios'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'archaios' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '942e3465-f8b3-41a8-98a6-9eda83c8eb1d', 'artist', 'ea2d1a26-e4d8-4daf-b487-52fe68faad36' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'archaios' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Archaios is a melodic death metal band from Santo Domingo. It began in 1994 as Legion and took the name Archaios, which means “ancient”, in 2003.

**As Legion**

Under its first name the band appeared with «Eterno Sufrimiento» and «Desperdida» on «Metal por un Tubo», a 1997 compilation CD issued by the magazine Radioactiva.

**Albums**

Its first album, «Out of the Shadows», came out in 2005, and the second, «The Distant», on 11 November 2011 through «Dark Canvas Records». The international metal database Encyclopaedia Metallum lists its subjects as inner struggles, existentialism, vengeance and despair. Reviewing «The Distant» for Heavy Metal Tribune, a critic scored it 14 out of 20 and called it a modern update of the melodic death metal of Soilwork and In Flames, with guitar solos of an almost neo-classical feel; he said it was the first band from the Dominican Republic he had come across.

**Abroad**

The band’s tracks reached international compilations: «The Distant» on Metal Hammer’s «Global Metal Vol. 3» (2011), «Legions (In Remembrance Of...)» on Terrorizer’s «Fear Candy 102» (2012) and «The Distant» again on «Global Domination Vol. 1», a digital release of «No Remorse Records» in April 2014.

**Members**

The guitarist Eric Cruz has been in the band since 2003 and is the only current member listed. Past members include the guitarists JC Castillo, who played until his death in 2019, Joel Solano and Albert de Peña; the bassists Koresh and David Masalles, who has also played inSoul of Death; the drummers Johandy Ureña, Alfredo Baltrá and Silvio “El Chivo”, who has also played in «Necro»; and the vocalist Rubén Cruz.

**Legacy**

In 2022 the metal site MetalSucks included Archaios in a list of fifteen bands from the Dominican Republic, and the international archives list it as active.' WHERE slug = 'archaios';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Archaios es una banda de death metal melódico de Santo Domingo. Empezó en 1994 como Legion y tomó el nombre de Archaios, que significa “antiguo”, en 2003."}]},{"type":"paragraph","content":[{"type":"text","text":"Como Legion","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Con su primer nombre la banda apareció con «Eterno Sufrimiento» y «Desperdida» en «Metal por un Tubo», un CD recopilatorio de 1997 editado por la revista Radioactiva."}]},{"type":"paragraph","content":[{"type":"text","text":"Discos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su primer álbum, «Out of the Shadows», salió en 2005 y el segundo, «The Distant», el 11 de noviembre de 2011 con «Dark Canvas Records». La base de datos internacional Encyclopaedia Metallum anota como temas las luchas interiores, el existencialismo, la venganza y la desesperación. Al reseñar «The Distant» para Heavy Metal Tribune, un crítico le puso 14 sobre 20 y lo describió como una actualización moderna del death metal melódico de Soilwork e In Flames, con solos de guitarra de aire casi neoclásico; dijo que era la primera banda dominicana con la que se topaba."}]},{"type":"paragraph","content":[{"type":"text","text":"En el exterior","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Los temas de la banda llegaron a recopilatorios internacionales: «The Distant» en «Global Metal Vol. 3» de Metal Hammer (2011), «Legions (In Remembrance Of...)» en «Fear Candy 102» de Terrorizer (2012) y otra vez «The Distant» en «Global Domination Vol. 1», un lanzamiento digital de «No Remorse Records» de abril de 2014."}]},{"type":"paragraph","content":[{"type":"text","text":"Integrantes","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El guitarrista Eric Cruz está en la banda desde 2003 y es el único integrante actual que figura en las bases de datos. Entre los anteriores están los guitarristas JC Castillo, que tocó hasta su muerte en 2019, Joel Solano y Albert de Peña; los bajistas Koresh y David Masalles, que también ha tocado en"},{"type":"artistReference","attrs":{"occurrenceId":"58cef1cb-c373-4a00-87ce-9470dc9a87d8","artistId":"ea2d1a26-e4d8-4daf-b487-52fe68faad36","displayText":"Soul of Death"}},{"type":"text","text":"; los bateristas Johandy Ureña, Alfredo Baltrá y Silvio “El Chivo”, que también ha tocado en «Necro»; y el vocalista Rubén Cruz."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2022 el sitio de metal MetalSucks incluyó a Archaios en una lista de quince bandas de República Dominicana, y los archivos internacionales la registran como activa."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'archaios'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'archaios' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '58cef1cb-c373-4a00-87ce-9470dc9a87d8', 'artist', 'ea2d1a26-e4d8-4daf-b487-52fe68faad36' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'archaios' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Archaios es una banda de death metal melódico de Santo Domingo. Empezó en 1994 como Legion y tomó el nombre de Archaios, que significa “antiguo”, en 2003.

**Como Legion**

Con su primer nombre la banda apareció con «Eterno Sufrimiento» y «Desperdida» en «Metal por un Tubo», un CD recopilatorio de 1997 editado por la revista Radioactiva.

**Discos**

Su primer álbum, «Out of the Shadows», salió en 2005 y el segundo, «The Distant», el 11 de noviembre de 2011 con «Dark Canvas Records». La base de datos internacional Encyclopaedia Metallum anota como temas las luchas interiores, el existencialismo, la venganza y la desesperación. Al reseñar «The Distant» para Heavy Metal Tribune, un crítico le puso 14 sobre 20 y lo describió como una actualización moderna del death metal melódico de Soilwork e In Flames, con solos de guitarra de aire casi neoclásico; dijo que era la primera banda dominicana con la que se topaba.

**En el exterior**

Los temas de la banda llegaron a recopilatorios internacionales: «The Distant» en «Global Metal Vol. 3» de Metal Hammer (2011), «Legions (In Remembrance Of...)» en «Fear Candy 102» de Terrorizer (2012) y otra vez «The Distant» en «Global Domination Vol. 1», un lanzamiento digital de «No Remorse Records» de abril de 2014.

**Integrantes**

El guitarrista Eric Cruz está en la banda desde 2003 y es el único integrante actual que figura en las bases de datos. Entre los anteriores están los guitarristas JC Castillo, que tocó hasta su muerte en 2019, Joel Solano y Albert de Peña; los bajistas Koresh y David Masalles, que también ha tocado enSoul of Death; los bateristas Johandy Ureña, Alfredo Baltrá y Silvio “El Chivo”, que también ha tocado en «Necro»; y el vocalista Rubén Cruz.

**Legado**

En 2022 el sitio de metal MetalSucks incluyó a Archaios en una lista de quince bandas de República Dominicana, y los archivos internacionales la registran como activa.' WHERE slug = 'archaios';

COMMIT;
