BEGIN;

-- Ficha de Manuel Miller.
--
-- name corregido de "DJ Miller" (que ninguna fuente usa) a "Manuel Miller" (coincide con slug,
-- sort_name y todas las fuentes); "DJ Miller" pasa a alias junto a "DJ Mastermix".
-- El documento en inglés ya existente era relleno genérico pese a tener mb_metadata real.
-- primary_genre puesto a "electronic". occupations ampliado con "music educator".

UPDATE artists SET name = 'Manuel Miller', aliases = ARRAY['DJ Miller','DJ Mastermix']::text[],
       primary_genre = 'electronic', occupations = '["producer","music educator"]'::jsonb
       WHERE slug = 'manuel-miller';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manuel Miller —born Manuel de Jesús Díaz Miller in Santo Domingo in January 1983— is a Dominican DJ, producer and music educator who has worked in the country’s electronic music scene since 1996."}]},{"type":"paragraph","content":[{"type":"text","text":"From «DJ Mastermix» to Manuel Miller","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Drawn to electronic music as a child by artists including Pink Floyd, Herbie Hancock, Giorgio Moroder and "},{"type":"artistReference","attrs":{"occurrenceId":"4854b6bb-722b-45c0-892e-de1b56ba98a6","artistId":"da791d26-8bab-45e4-b7d1-f09314869f09","displayText":"Michel Camilo"}},{"type":"text","text":", and later by the overnight electronic programming of the radio station «X 102», he began DJing in September 1996 under the name «DJ Mastermix», soon replacing it with his own name. A year later he held a residency at Club Naco’s teen disco, going on to play clubs across Santo Domingo including «Schizo» and «Bambú»."}]},{"type":"paragraph","content":[{"type":"text","text":"Production and radio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He moved into production in 1999, and by 2002 was releasing his own tracks, including «Dominican Groove» and «Hearing My Roots», which reached rotation on Dominican stations such as «La X 102» and «Radio Listín». He went on to release «Salsation» (2009), «Mi Mesa E.P.» (2010) and «Mi Mesa Special Edition» (2011) through the label «Latitud Records», and hosted electronic-music radio programs including «Santo Domingo Electrónico» (2001–2003) and «Feel Electro On Live Radio»."}]},{"type":"paragraph","content":[{"type":"text","text":"Manuel Miller DJ School","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In July 2004 he founded the Manuel Miller DJ School, described as the first DJ school in the Dominican Republic. Its graduates include DJs Bayoan Soto and DJ Gem, and Gaspary, of the duo «Technopolis»; two decades later the school remains active in Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Manuel Miller has continued releasing music and performing into the mid-2020s, including a 2024 remix of his own «Dominican Groove» and a 2026 Dominican Independence Day radio mix, and Dominican outlets have described him as a key figure in training much of the electronic scene’s current generation — a rare institution-building career in a national music industry usually associated with merengue and bachata rather than house and techno."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manuel-miller'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manuel-miller' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '4854b6bb-722b-45c0-892e-de1b56ba98a6', 'artist', 'da791d26-8bab-45e4-b7d1-f09314869f09' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-miller' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Manuel Miller —born Manuel de Jesús Díaz Miller in Santo Domingo in January 1983— is a Dominican DJ, producer and music educator who has worked in the country’s electronic music scene since 1996.

**From «DJ Mastermix» to Manuel Miller**

Drawn to electronic music as a child by artists including Pink Floyd, Herbie Hancock, Giorgio Moroder and Michel Camilo, and later by the overnight electronic programming of the radio station «X 102», he began DJing in September 1996 under the name «DJ Mastermix», soon replacing it with his own name. A year later he held a residency at Club Naco’s teen disco, going on to play clubs across Santo Domingo including «Schizo» and «Bambú».

**Production and radio**

He moved into production in 1999, and by 2002 was releasing his own tracks, including «Dominican Groove» and «Hearing My Roots», which reached rotation on Dominican stations such as «La X 102» and «Radio Listín». He went on to release «Salsation» (2009), «Mi Mesa E.P.» (2010) and «Mi Mesa Special Edition» (2011) through the label «Latitud Records», and hosted electronic-music radio programs including «Santo Domingo Electrónico» (2001–2003) and «Feel Electro On Live Radio».

**Manuel Miller DJ School**

In July 2004 he founded the Manuel Miller DJ School, described as the first DJ school in the Dominican Republic. Its graduates include DJs Bayoan Soto and DJ Gem, and Gaspary, of the duo «Technopolis»; two decades later the school remains active in Santo Domingo.

**Legacy**

Manuel Miller has continued releasing music and performing into the mid-2020s, including a 2024 remix of his own «Dominican Groove» and a 2026 Dominican Independence Day radio mix, and Dominican outlets have described him as a key figure in training much of the electronic scene’s current generation — a rare institution-building career in a national music industry usually associated with merengue and bachata rather than house and techno.' WHERE slug = 'manuel-miller';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manuel Miller —nacido Manuel de Jesús Díaz Miller en Santo Domingo en enero de 1983— es DJ, productor y educador musical dominicano que ha trabajado en la escena de música electrónica del país desde 1996."}]},{"type":"paragraph","content":[{"type":"text","text":"De «DJ Mastermix» a Manuel Miller","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Atraído por la música electrónica desde niño por artistas como Pink Floyd, Herbie Hancock, Giorgio Moroder y "},{"type":"artistReference","attrs":{"occurrenceId":"f34f2d6f-3f36-41f5-b8c4-a9b1ad74ad56","artistId":"da791d26-8bab-45e4-b7d1-f09314869f09","displayText":"Michel Camilo"}},{"type":"text","text":", y más tarde por la programación electrónica nocturna de la emisora «X 102», empezó como DJ en septiembre de 1996 con el nombre «DJ Mastermix», que pronto reemplazó por su propio nombre. Un año después obtuvo una residencia en la discoteca juvenil del Club Naco, y pasó a tocar en clubes de Santo Domingo como «Schizo» y «Bambú»."}]},{"type":"paragraph","content":[{"type":"text","text":"Producción y radio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Pasó a la producción en 1999, y hacia 2002 ya publicaba sus propios temas, entre ellos «Dominican Groove» y «Hearing My Roots», que sonaron en emisoras dominicanas como «La X 102» y «Radio Listín». Publicó luego «Salsation» (2009), «Mi Mesa E.P.» (2010) y «Mi Mesa Special Edition» (2011) a través del sello «Latitud Records», y condujo programas de radio de música electrónica como «Santo Domingo Electrónico» (2001-2003) y «Feel Electro On Live Radio»."}]},{"type":"paragraph","content":[{"type":"text","text":"Manuel Miller DJ School","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En julio de 2004 fundó Manuel Miller DJ School, descrita como la primera escuela de DJs de República Dominicana. Entre sus egresados están los DJs Bayoan Soto y DJ Gem, y Gaspary, del dúo «Technopolis»; dos décadas después la escuela sigue activa en Santo Domingo."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Manuel Miller ha seguido publicando música y presentándose hasta mediados de los años 2020, incluido un remix de 2024 de su propio «Dominican Groove» y una mezcla radial por la Independencia Dominicana en 2026, y medios dominicanos lo han descrito como una figura clave en la formación de buena parte de la generación actual de la escena electrónica — una trayectoria de construcción institucional poco común en una industria musical nacional asociada sobre todo al merengue y la bachata, no al house y el techno."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manuel-miller'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manuel-miller' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'f34f2d6f-3f36-41f5-b8c4-a9b1ad74ad56', 'artist', 'da791d26-8bab-45e4-b7d1-f09314869f09' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'manuel-miller' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Manuel Miller —nacido Manuel de Jesús Díaz Miller en Santo Domingo en enero de 1983— es DJ, productor y educador musical dominicano que ha trabajado en la escena de música electrónica del país desde 1996.

**De «DJ Mastermix» a Manuel Miller**

Atraído por la música electrónica desde niño por artistas como Pink Floyd, Herbie Hancock, Giorgio Moroder y Michel Camilo, y más tarde por la programación electrónica nocturna de la emisora «X 102», empezó como DJ en septiembre de 1996 con el nombre «DJ Mastermix», que pronto reemplazó por su propio nombre. Un año después obtuvo una residencia en la discoteca juvenil del Club Naco, y pasó a tocar en clubes de Santo Domingo como «Schizo» y «Bambú».

**Producción y radio**

Pasó a la producción en 1999, y hacia 2002 ya publicaba sus propios temas, entre ellos «Dominican Groove» y «Hearing My Roots», que sonaron en emisoras dominicanas como «La X 102» y «Radio Listín». Publicó luego «Salsation» (2009), «Mi Mesa E.P.» (2010) y «Mi Mesa Special Edition» (2011) a través del sello «Latitud Records», y condujo programas de radio de música electrónica como «Santo Domingo Electrónico» (2001-2003) y «Feel Electro On Live Radio».

**Manuel Miller DJ School**

En julio de 2004 fundó Manuel Miller DJ School, descrita como la primera escuela de DJs de República Dominicana. Entre sus egresados están los DJs Bayoan Soto y DJ Gem, y Gaspary, del dúo «Technopolis»; dos décadas después la escuela sigue activa en Santo Domingo.

**Legado**

Manuel Miller ha seguido publicando música y presentándose hasta mediados de los años 2020, incluido un remix de 2024 de su propio «Dominican Groove» y una mezcla radial por la Independencia Dominicana en 2026, y medios dominicanos lo han descrito como una figura clave en la formación de buena parte de la generación actual de la escena electrónica — una trayectoria de construcción institucional poco común en una industria musical nacional asociada sobre todo al merengue y la bachata, no al house y el techno.' WHERE slug = 'manuel-miller';

COMMIT;
