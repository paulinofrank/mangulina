BEGIN;

-- Bladimir Vásquez (Jovanny Bladimir Nery Vásquez): cantante, rapero y compositor germano-dominicano de Santiago criado desde los 15 en Hamburgo; no un músico de merengue, bachata y tropical como decía el relleno. Fuentes: biografía de IMDb, de redacción propia (nacimiento 20 dic. 1995, Santiago, mudanza a Hamburgo, primer sencillo «Te Buscaré», remix con Juanga el Galáctico 2016, 2017 «Como Quisiera», «Guaya Guaya», «No Es Amor» con Oregon 77); créditos de «Lucharé» (Audiomack, Shazam, Musixmatch, Genius: 1 abr. 2020, escrita por Jovanny Nery Vásquez y Tobias Topic; CD Baby; video con Topic); perfil oficial de YouTube. Nombre: la fila tenía first_name Bladimir / last_name Vásquez (nombre artístico); nombre civil Jovanny Bladimir Nery Vásquez sale de la biografía propia y de los créditos (Shazam, Musixmatch): se reparte en first/middle/last/second. Campos: occupations rapper y songwriter (el relleno tenía arranger, musician, bandleader), tag diaspora. Se descartó una línea de Last.fm que le atribuye 'Home' con Nico Santos (certificado en Alemania y Australia): no es suya. La ficha de Bladimir no se apoya en prensa independiente; lo temprano queda atribuido a su propia biografía.

UPDATE artists SET first_name = 'Jovanny', middle_name = 'Bladimir', last_name = 'Nery', second_last_name = 'Vásquez', occupations = '["rapper","songwriter"]'::jsonb, artist_tags = ARRAY['secular','diaspora']::text[] WHERE slug = 'bladimir-vasquez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Bladimir Vásquez —Jovanny Bladimir Nery Vásquez, born on 20 December 1995 in Santiago de los Caballeros— is a German-Dominican singer, rapper and songwriter whose music mixes Spanish-language R&B, reggaeton and Latin urban pop."}]},{"type":"paragraph","content":[{"type":"text","text":"From Santiago to Hamburg","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In a biography he wrote for the film database IMDb he says that as a child he began writing songs and that at thirteen he ran a music blog in which he interviewed Dominican artists. Shortly before his sixteenth birthday he moved with his parents and siblings to Hamburg, Germany, where he began his solo career, performed in Latin clubs and festivals in several German states, and shared events with the Brazilian MC Fioti and the German rapper PA Sports."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"At nineteen he began posting songs on YouTube under his stage name. His first single, «Te Buscaré», was produced by the Dominican producer Juan Gabriel Payano Luna; a remix with Juanga el Galáctico followed in 2016, and in 2017 came «Como Quisiera», «Guaya Guaya» and «No Es Amor», the latter with Oregon 77. On 1 April 2020 he released «Lucharé», with the German producer Tobias Topic, known as Topic, who wrote it with him; the song appears on his official channel and in a video credited to Topic."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Lucharé» carries the credits of both writers, Bladimir Vásquez and Topic, on the streaming platforms and is the release where his work is best documented."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bladimir-vasquez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'bladimir-vasquez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Bladimir Vásquez —Jovanny Bladimir Nery Vásquez, born on 20 December 1995 in Santiago de los Caballeros— is a German-Dominican singer, rapper and songwriter whose music mixes Spanish-language R&B, reggaeton and Latin urban pop.

**From Santiago to Hamburg**

In a biography he wrote for the film database IMDb he says that as a child he began writing songs and that at thirteen he ran a music blog in which he interviewed Dominican artists. Shortly before his sixteenth birthday he moved with his parents and siblings to Hamburg, Germany, where he began his solo career, performed in Latin clubs and festivals in several German states, and shared events with the Brazilian MC Fioti and the German rapper PA Sports.

**Songs**

At nineteen he began posting songs on YouTube under his stage name. His first single, «Te Buscaré», was produced by the Dominican producer Juan Gabriel Payano Luna; a remix with Juanga el Galáctico followed in 2016, and in 2017 came «Como Quisiera», «Guaya Guaya» and «No Es Amor», the latter with Oregon 77. On 1 April 2020 he released «Lucharé», with the German producer Tobias Topic, known as Topic, who wrote it with him; the song appears on his official channel and in a video credited to Topic.

**Legacy**

«Lucharé» carries the credits of both writers, Bladimir Vásquez and Topic, on the streaming platforms and is the release where his work is best documented.' WHERE slug = 'bladimir-vasquez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Bladimir Vásquez —Jovanny Bladimir Nery Vásquez, nacido el 20 de diciembre de 1995 en Santiago de los Caballeros— es un cantante, rapero y compositor germano-dominicano cuya música mezcla R&B en español, reguetón y pop urbano latino."}]},{"type":"paragraph","content":[{"type":"text","text":"De Santiago a Hamburgo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En una biografía que él mismo redactó para la base de datos de cine IMDb cuenta que de niño empezó a escribir canciones y que a los trece años llevaba un blog de música en el que entrevistaba a artistas dominicanos. Poco antes de cumplir dieciséis años se mudó con sus padres y hermanos a Hamburgo, Alemania, donde inició su carrera como solista, actuó en clubes y festivales latinos de varios estados alemanes y compartió eventos con el brasileño MC Fioti y el rapero alemán PA Sports."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A los diecinueve años empezó a publicar canciones en YouTube con su nombre artístico. Su primer sencillo, «Te Buscaré», fue producido por el productor dominicano Juan Gabriel Payano Luna; en 2016 salió un remix con Juanga el Galáctico y en 2017 «Como Quisiera», «Guaya Guaya» y «No Es Amor», este último con Oregon 77. El 1 de abril de 2020 publicó «Lucharé», con el productor alemán Tobias Topic, conocido como Topic, que la escribió con él; la canción figura en su canal oficial y en un video acreditado a Topic."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Lucharé» lleva en las plataformas los créditos de ambos autores, Bladimir Vásquez y Topic, y es el lanzamiento donde su obra está mejor documentada."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bladimir-vasquez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'bladimir-vasquez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Bladimir Vásquez —Jovanny Bladimir Nery Vásquez, nacido el 20 de diciembre de 1995 en Santiago de los Caballeros— es un cantante, rapero y compositor germano-dominicano cuya música mezcla R&B en español, reguetón y pop urbano latino.

**De Santiago a Hamburgo**

En una biografía que él mismo redactó para la base de datos de cine IMDb cuenta que de niño empezó a escribir canciones y que a los trece años llevaba un blog de música en el que entrevistaba a artistas dominicanos. Poco antes de cumplir dieciséis años se mudó con sus padres y hermanos a Hamburgo, Alemania, donde inició su carrera como solista, actuó en clubes y festivales latinos de varios estados alemanes y compartió eventos con el brasileño MC Fioti y el rapero alemán PA Sports.

**Canciones**

A los diecinueve años empezó a publicar canciones en YouTube con su nombre artístico. Su primer sencillo, «Te Buscaré», fue producido por el productor dominicano Juan Gabriel Payano Luna; en 2016 salió un remix con Juanga el Galáctico y en 2017 «Como Quisiera», «Guaya Guaya» y «No Es Amor», este último con Oregon 77. El 1 de abril de 2020 publicó «Lucharé», con el productor alemán Tobias Topic, conocido como Topic, que la escribió con él; la canción figura en su canal oficial y en un video acreditado a Topic.

**Legado**

«Lucharé» lleva en las plataformas los créditos de ambos autores, Bladimir Vásquez y Topic, y es el lanzamiento donde su obra está mejor documentada.' WHERE slug = 'bladimir-vasquez';

COMMIT;
