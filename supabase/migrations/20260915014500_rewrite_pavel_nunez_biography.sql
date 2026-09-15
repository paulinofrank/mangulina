BEGIN;

-- Ficha de Pavel Núñez.
--
-- La biografía de relleno lo describía en términos genéricos sin nombrar un solo disco,
-- banda o premio concreto. Nombre completo: first_name Pavel Elías, last_name Núñez
-- (la fila lo tenía en NULL), second_last_name Ramírez. Tres premios registrados: Latin
-- Grammy 2010 (nominación, no ganó), Soberano Álbum del Año 2016, Soberano Mejor Cantante
-- Masculino 2014. José Antonio Rodríguez, Homero Guerrero y Arturo Piña no tienen ficha:
-- ver ARTISTAS_FALTANTES.md y MUSICOS_PENDIENTES.md.

UPDATE artists SET first_name = 'Pavel Elías', last_name = 'Núñez',
       second_last_name = 'Ramírez' WHERE slug = 'pavel-nunez';

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2010, NULL, false, 'Wikipedia (es), con referencia'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'pavel-nunez' AND a.name = 'Latin Grammy' AND cat.name = 'Best Singer-Songwriter Album'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2010);

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2016, 'De Mis Insomnios', true, 'Wikipedia (es); Premios Soberano (sitio oficial)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'pavel-nunez' AND a.name = 'Premios Soberano' AND cat.name = 'Álbum del Año'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2016);

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Mejor Cantante Masculino' FROM awards a WHERE a.name = 'Premios Soberano'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Mejor Cantante Masculino');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2014, NULL, true, 'Wikipedia (es); Premios Soberano (sitio oficial)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'pavel-nunez' AND a.name = 'Premios Soberano' AND cat.name = 'Mejor Cantante Masculino'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2014);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Pavel Núñez — Pavel Elías Núñez Ramírez, born 2 March 1979 in Santo Domingo — is a Dominican singer-songwriter whose songs and live shows have made him one of the most decorated solo artists of his generation, with eleven Casandra and Soberano awards, an Emmy and a Latin Grammy nomination behind him."}]},{"type":"paragraph","content":[{"type":"text","text":"Bands before a name of his own","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He started in 1995 with Homero Guerrero in the band Código Genético, steeped in Cuban trova and inflected with blues, funk and folk; a year later the two started over as Los Fulanos, aiming for something more their own. A 1997 tour of local bars sent him to New York to sharpen his musicianship, and on his return he formed El Corredor de la 27 — the same name he would put on an album more than twenty years later. That year, an invitation from José Antonio Rodríguez and "},{"type":"artistReference","attrs":{"occurrenceId":"cb73b61c-0296-45b8-9c76-4c8b89f70140","artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor"}},{"type":"text","text":" to open for them earned him the nickname «El Buen Hijo de la Zona Colonial»."}]},{"type":"paragraph","content":[{"type":"text","text":"Going solo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Signed exclusively to RCC Records in 2001, he released his debut, «Paso a Paso», the following year, and followed it with «De Vuelta a Casa» (2003) and «Atlantis» (2005) — both of which paired him in duet with the Puerto Rican singer Danny Rivera, who later, in 2016, chose Núñez to produce one of his own albums."}]},{"type":"paragraph","content":[{"type":"text","text":"A discography built one record at a time","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Rather than one breakthrough hit, Núñez built a catalogue: «Antología de un principiante» (2006), «El tiempo del viento» (2010), the two-part «Big Band Núñez» (2012–13), «Cantor urbano», a full tribute to "},{"type":"artistReference","attrs":{"occurrenceId":"b680a443-360a-41db-bb08-f3e44057500b","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":" (2013), «De mis insomnios» (2015), «Sentimientos» (2018) and «Oratoria y otras historias», recorded with El Corredor de la 27 (2018). In 2019 he made his merengue debut on «Yo te quiero querer», a duet with "},{"type":"artistReference","attrs":{"occurrenceId":"104b2b76-39b8-4a47-8ae3-75b8572be7e9","artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Awards","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His live TV special «Big Band Núñez» won an Emmy in 2013 from the National Academy of Television Arts and Sciences’ Suncoast chapter, and that same November he took two Premios La Silla from ADOCINE — Best Original Song for a Film and Best Musicalization, the latter shared with the sound engineer Arturo Piña — for his film work. He has eleven Casandra and Soberano awards to his name, among them Revelación del Año, Solista del Año, Concierto del Año, Mejor Cantante Masculino (2014) and Álbum del Año for «De mis insomnios» (2016), plus a 2010 Latin Grammy nomination for Best Singer-Songwriter Album."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"More than a quarter-century after two friends built a band around Cuban trova and whatever else was on the radio, Núñez marked his 26th year in music in 2026 with a stage musical and another Soberano, for Best Male Solo Artist — a career made, record by record, on the strength of the songs themselves."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'pavel-nunez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'pavel-nunez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cb73b61c-0296-45b8-9c76-4c8b89f70140', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'pavel-nunez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b680a443-360a-41db-bb08-f3e44057500b', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'pavel-nunez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '104b2b76-39b8-4a47-8ae3-75b8572be7e9', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'pavel-nunez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Pavel Núñez — Pavel Elías Núñez Ramírez, born 2 March 1979 in Santo Domingo — is a Dominican singer-songwriter whose songs and live shows have made him one of the most decorated solo artists of his generation, with eleven Casandra and Soberano awards, an Emmy and a Latin Grammy nomination behind him.

**Bands before a name of his own**

He started in 1995 with Homero Guerrero in the band Código Genético, steeped in Cuban trova and inflected with blues, funk and folk; a year later the two started over as Los Fulanos, aiming for something more their own. A 1997 tour of local bars sent him to New York to sharpen his musicianship, and on his return he formed El Corredor de la 27 — the same name he would put on an album more than twenty years later. That year, an invitation from José Antonio Rodríguez and Víctor Víctor to open for them earned him the nickname «El Buen Hijo de la Zona Colonial».

**Going solo**

Signed exclusively to RCC Records in 2001, he released his debut, «Paso a Paso», the following year, and followed it with «De Vuelta a Casa» (2003) and «Atlantis» (2005) — both of which paired him in duet with the Puerto Rican singer Danny Rivera, who later, in 2016, chose Núñez to produce one of his own albums.

**A discography built one record at a time**

Rather than one breakthrough hit, Núñez built a catalogue: «Antología de un principiante» (2006), «El tiempo del viento» (2010), the two-part «Big Band Núñez» (2012–13), «Cantor urbano», a full tribute to Luis "Terror" Días (2013), «De mis insomnios» (2015), «Sentimientos» (2018) and «Oratoria y otras historias», recorded with El Corredor de la 27 (2018). In 2019 he made his merengue debut on «Yo te quiero querer», a duet with Milly Quezada.

**Awards**

His live TV special «Big Band Núñez» won an Emmy in 2013 from the National Academy of Television Arts and Sciences’ Suncoast chapter, and that same November he took two Premios La Silla from ADOCINE — Best Original Song for a Film and Best Musicalization, the latter shared with the sound engineer Arturo Piña — for his film work. He has eleven Casandra and Soberano awards to his name, among them Revelación del Año, Solista del Año, Concierto del Año, Mejor Cantante Masculino (2014) and Álbum del Año for «De mis insomnios» (2016), plus a 2010 Latin Grammy nomination for Best Singer-Songwriter Album.

**Legacy**

More than a quarter-century after two friends built a band around Cuban trova and whatever else was on the radio, Núñez marked his 26th year in music in 2026 with a stage musical and another Soberano, for Best Male Solo Artist — a career made, record by record, on the strength of the songs themselves.' WHERE slug = 'pavel-nunez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Pavel Núñez —Pavel Elías Núñez Ramírez, nacido el 2 de marzo de 1979 en Santo Domingo— es un cantautor dominicano cuyas canciones y espectáculos en vivo lo han convertido en uno de los solistas más premiados de su generación, con once premios Casandra y Soberano, un Emmy y una nominación al Latin Grammy en su haber."}]},{"type":"paragraph","content":[{"type":"text","text":"Bandas antes de un nombre propio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó en 1995 con Homero Guerrero en la banda Código Genético, empapada de trova cubana y con toques de blues, funk y folk; un año después los dos volvieron a empezar como Los Fulanos, buscando algo más propio. Una gira de bares locales en 1997 lo mandó a Nueva York a pulir su oficio, y a su regreso formó El Corredor de la 27 —el mismo nombre que le pondría a un álbum más de veinte años después—. Ese año, una invitación de José Antonio Rodríguez y "},{"type":"artistReference","attrs":{"occurrenceId":"583845c9-259f-4800-9737-c46e1932a25f","artistId":"4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3","displayText":"Víctor Víctor"}},{"type":"text","text":" para abrirles le ganó el apodo de «El Buen Hijo de la Zona Colonial»."}]},{"type":"paragraph","content":[{"type":"text","text":"En solitario","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Contratado en exclusiva por RCC Records en 2001, sacó su debut, «Paso a paso», al año siguiente, y siguió con «De vuelta a casa» (2003) y «Atlantis» (2005) —ambos con dúos junto al cantante puertorriqueño Danny Rivera, quien después, en 2016, escogió a Núñez para producirle uno de sus propios discos."}]},{"type":"paragraph","content":[{"type":"text","text":"Una discografía construida disco a disco","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En vez de un solo golpe de suerte, Núñez armó un catálogo: «Antología de un principiante» (2006), «El tiempo del viento» (2010), el díptico «Big Band Núñez» (2012-13), «Cantor urbano», tributo completo a "},{"type":"artistReference","attrs":{"occurrenceId":"660c3afa-e495-4556-8357-b28f645f94bb","artistId":"99537a98-fb19-4487-814d-c60d91c4d10b","displayText":"Luis \"Terror\" Días"}},{"type":"text","text":" (2013), «De mis insomnios» (2015), «Sentimientos» (2018) y «Oratoria y otras historias», grabado con El Corredor de la 27 (2018). En 2019 debutó en el merengue con «Yo te quiero querer», a dúo con "},{"type":"artistReference","attrs":{"occurrenceId":"274c8c2a-8ce8-491e-8f02-d574c0b8f10e","artistId":"070e7449-814e-4ea6-a009-7a091b7e4878","displayText":"Milly Quezada"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Premios","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su especial de televisión en vivo «Big Band Núñez» ganó un Emmy en 2013, entregado por el capítulo Suncoast de la Academia Nacional de las Artes y las Ciencias de la Televisión, y ese mismo noviembre se llevó dos Premios La Silla de ADOCINE —Mejor Canción Original para una Película y Mejor Musicalización, este último compartido con el ingeniero de sonido Arturo Piña— por su trabajo en cine. Tiene once premios Casandra y Soberano, entre ellos Revelación del Año, Solista del Año, Concierto del Año, Mejor Cantante Masculino (2014) y Álbum del Año por «De mis insomnios» (2016), además de una nominación al Latin Grammy 2010 a Mejor Álbum de Cantautor."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Más de un cuarto de siglo después de que dos amigos armaran una banda alrededor de la trova cubana y de lo que sonara en la radio, Núñez cumplió en 2026 su año 26 en la música con un musical de teatro y otro Soberano, a Mejor Solista Masculino —una carrera hecha, disco a disco, sobre la fuerza de las propias canciones."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'pavel-nunez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'pavel-nunez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '583845c9-259f-4800-9737-c46e1932a25f', 'artist', '4b4bf9da-fe4a-4fc6-be40-1b1b5413dfb3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'pavel-nunez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '660c3afa-e495-4556-8357-b28f645f94bb', 'artist', '99537a98-fb19-4487-814d-c60d91c4d10b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'pavel-nunez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '274c8c2a-8ce8-491e-8f02-d574c0b8f10e', 'artist', '070e7449-814e-4ea6-a009-7a091b7e4878' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'pavel-nunez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Pavel Núñez —Pavel Elías Núñez Ramírez, nacido el 2 de marzo de 1979 en Santo Domingo— es un cantautor dominicano cuyas canciones y espectáculos en vivo lo han convertido en uno de los solistas más premiados de su generación, con once premios Casandra y Soberano, un Emmy y una nominación al Latin Grammy en su haber.

**Bandas antes de un nombre propio**

Empezó en 1995 con Homero Guerrero en la banda Código Genético, empapada de trova cubana y con toques de blues, funk y folk; un año después los dos volvieron a empezar como Los Fulanos, buscando algo más propio. Una gira de bares locales en 1997 lo mandó a Nueva York a pulir su oficio, y a su regreso formó El Corredor de la 27 —el mismo nombre que le pondría a un álbum más de veinte años después—. Ese año, una invitación de José Antonio Rodríguez y Víctor Víctor para abrirles le ganó el apodo de «El Buen Hijo de la Zona Colonial».

**En solitario**

Contratado en exclusiva por RCC Records en 2001, sacó su debut, «Paso a paso», al año siguiente, y siguió con «De vuelta a casa» (2003) y «Atlantis» (2005) —ambos con dúos junto al cantante puertorriqueño Danny Rivera, quien después, en 2016, escogió a Núñez para producirle uno de sus propios discos.

**Una discografía construida disco a disco**

En vez de un solo golpe de suerte, Núñez armó un catálogo: «Antología de un principiante» (2006), «El tiempo del viento» (2010), el díptico «Big Band Núñez» (2012-13), «Cantor urbano», tributo completo a Luis "Terror" Días (2013), «De mis insomnios» (2015), «Sentimientos» (2018) y «Oratoria y otras historias», grabado con El Corredor de la 27 (2018). En 2019 debutó en el merengue con «Yo te quiero querer», a dúo con Milly Quezada.

**Premios**

Su especial de televisión en vivo «Big Band Núñez» ganó un Emmy en 2013, entregado por el capítulo Suncoast de la Academia Nacional de las Artes y las Ciencias de la Televisión, y ese mismo noviembre se llevó dos Premios La Silla de ADOCINE —Mejor Canción Original para una Película y Mejor Musicalización, este último compartido con el ingeniero de sonido Arturo Piña— por su trabajo en cine. Tiene once premios Casandra y Soberano, entre ellos Revelación del Año, Solista del Año, Concierto del Año, Mejor Cantante Masculino (2014) y Álbum del Año por «De mis insomnios» (2016), además de una nominación al Latin Grammy 2010 a Mejor Álbum de Cantautor.

**Legado**

Más de un cuarto de siglo después de que dos amigos armaran una banda alrededor de la trova cubana y de lo que sonara en la radio, Núñez cumplió en 2026 su año 26 en la música con un musical de teatro y otro Soberano, a Mejor Solista Masculino —una carrera hecha, disco a disco, sobre la fuerza de las propias canciones.' WHERE slug = 'pavel-nunez';

COMMIT;
