BEGIN;

-- Ficha de Juan Francisco García.
--
-- La biografía de relleno lo describía en términos genéricos ("bridge between the European
-- art music canon"), sin nombrar una sola obra. first_name: Juan Francisco (completo).
-- occupations: conductor, music educator, writer (sustituye musician, bandleader, que no
-- describían bien su perfil). instruments: piano, cello (autodidacta en ambos). Juan
-- Espínola, José García Oviedo y Margarita Luna de Espaillat no tienen ficha: ver
-- ARTISTAS_FALTANTES.md.

UPDATE artists SET first_name = 'Juan Francisco', occupations = '["conductor","music educator","writer"]'::jsonb,
       instruments = ARRAY['piano', 'cello']::text[] WHERE slug = 'juan-francisco-garcia';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Francisco García — born 16 June 1892 in Santiago de los Caballeros, died 18 November 1974 in Santo Domingo — was a Dominican composer, conductor and music educator, one of the founding figures of the nationalist movement in Dominican art music in the early twentieth century."}]},{"type":"paragraph","content":[{"type":"text","text":"An ear, and no formal path","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He showed musical aptitude early, studying theory under José García Oviedo before teaching himself cello and piano. His method for composition followed that of the Belgian theorist François-Joseph Fétis, and from it he built an extensive catalogue spanning genres."}]},{"type":"paragraph","content":[{"type":"text","text":"The 1922 ensemble","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"That year he wrote his String Quartet No. 1, not premiered in Santiago de los Caballeros until 1929, and also played cornet in a small touring ensemble led by the pianist "},{"type":"artistReference","attrs":{"occurrenceId":"e905c6ea-9653-484b-9f5d-61db0be7068b","artistId":"0e61046c-e96d-400b-819c-f9de8cbacba1","displayText":"Julio Alberto Hernández"}},{"type":"text","text":", which took Dominican and Cuban repertoire through Dajabón, Montecristi and Cap-Haïtien."}]},{"type":"paragraph","content":[{"type":"text","text":"Cuba, and a poem by Guillén","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1925 he traveled to Cuba as accompanist to the tenor Susano Polanco. There he met the Cuban poet Nicolás Guillén, who gave him verses that became the song «Espejo», premiered on that same tour; "},{"type":"artistReference","attrs":{"occurrenceId":"a4b499a0-d49f-4b70-b220-bc41c2e6e840","artistId":"ec0423fc-fe53-42e9-8d0f-f2ae902512d3","displayText":"Eduardo Brito"}},{"type":"text","text":" recorded it in New York in 1930, carrying it to a wider audience."}]},{"type":"paragraph","content":[{"type":"text","text":"«Quisqueyana»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His best-known large-scale work, the Symphony No. 1, «Quisqueyana», completed in 1935, drew on Dominican folk material inside a symphonic frame; the Orquesta Sinfónica de Santo Domingo premiered it at the Teatro Olimpia on 21 March 1941. He also wrote «Simastral», a symphonic fantasy premiered in 1947, and a Fantasía Concertante for piano and orchestra in 1949, alongside a large catalogue of nationalist piano pieces, among them the four-movement, Taíno-themed «Fantasía Indígena» and the piece «Sambumbia»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His songs «Mal de amores» and the criolla «Margarita del Campo» entered the popular repertoire, and his «Himno a la Bandera» became one of the country’s patriotic standards. He also taught — his pupils included the pianist Margarita Luna de Espaillat — and wrote on Dominican music history and folklore. He died in Santo Domingo in 1974, at eighty-two, after more than half a century spent building, alongside contemporaries such as "},{"type":"artistReference","attrs":{"occurrenceId":"a29a7124-3bff-4158-b506-fc798e628ca8","artistId":"0e61046c-e96d-400b-819c-f9de8cbacba1","displayText":"Julio Alberto Hernández"}},{"type":"text","text":" and Juan Espínola, an art-music tradition that drew its material directly from Dominican folklore rather than importing it from Europe."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-francisco-garcia'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-francisco-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e905c6ea-9653-484b-9f5d-61db0be7068b', 'artist', '0e61046c-e96d-400b-819c-f9de8cbacba1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a4b499a0-d49f-4b70-b220-bc41c2e6e840', 'artist', 'ec0423fc-fe53-42e9-8d0f-f2ae902512d3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a29a7124-3bff-4158-b506-fc798e628ca8', 'artist', '0e61046c-e96d-400b-819c-f9de8cbacba1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-garcia' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Juan Francisco García — born 16 June 1892 in Santiago de los Caballeros, died 18 November 1974 in Santo Domingo — was a Dominican composer, conductor and music educator, one of the founding figures of the nationalist movement in Dominican art music in the early twentieth century.

**An ear, and no formal path**

He showed musical aptitude early, studying theory under José García Oviedo before teaching himself cello and piano. His method for composition followed that of the Belgian theorist François-Joseph Fétis, and from it he built an extensive catalogue spanning genres.

**The 1922 ensemble**

That year he wrote his String Quartet No. 1, not premiered in Santiago de los Caballeros until 1929, and also played cornet in a small touring ensemble led by the pianist Julio Alberto Hernández, which took Dominican and Cuban repertoire through Dajabón, Montecristi and Cap-Haïtien.

**Cuba, and a poem by Guillén**

In 1925 he traveled to Cuba as accompanist to the tenor Susano Polanco. There he met the Cuban poet Nicolás Guillén, who gave him verses that became the song «Espejo», premiered on that same tour; Eduardo Brito recorded it in New York in 1930, carrying it to a wider audience.

**«Quisqueyana»**

His best-known large-scale work, the Symphony No. 1, «Quisqueyana», completed in 1935, drew on Dominican folk material inside a symphonic frame; the Orquesta Sinfónica de Santo Domingo premiered it at the Teatro Olimpia on 21 March 1941. He also wrote «Simastral», a symphonic fantasy premiered in 1947, and a Fantasía Concertante for piano and orchestra in 1949, alongside a large catalogue of nationalist piano pieces, among them the four-movement, Taíno-themed «Fantasía Indígena» and the piece «Sambumbia».

**Legacy**

His songs «Mal de amores» and the criolla «Margarita del Campo» entered the popular repertoire, and his «Himno a la Bandera» became one of the country’s patriotic standards. He also taught — his pupils included the pianist Margarita Luna de Espaillat — and wrote on Dominican music history and folklore. He died in Santo Domingo in 1974, at eighty-two, after more than half a century spent building, alongside contemporaries such as Julio Alberto Hernández and Juan Espínola, an art-music tradition that drew its material directly from Dominican folklore rather than importing it from Europe.' WHERE slug = 'juan-francisco-garcia';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Juan Francisco García —nacido el 16 de junio de 1892 en Santiago de los Caballeros, fallecido el 18 de noviembre de 1974 en Santo Domingo— fue un compositor, director y educador musical dominicano, una de las figuras fundadoras del movimiento nacionalista de la música académica dominicana en los primeros años del siglo XX."}]},{"type":"paragraph","content":[{"type":"text","text":"Un oído, y ningún camino formal","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Mostró aptitud musical desde temprano, estudiando teoría con José García Oviedo antes de aprender por su cuenta el cello y el piano. Su método de composición siguió el del teórico belga François-Joseph Fétis, y a partir de él construyó un catálogo extenso a través de varios géneros."}]},{"type":"paragraph","content":[{"type":"text","text":"El conjunto de 1922","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ese año escribió su Cuarteto de Cuerdas n.º 1, que no se estrenó en Santiago de los Caballeros hasta 1929, y también tocó corneta en un pequeño conjunto de gira dirigido por el pianista "},{"type":"artistReference","attrs":{"occurrenceId":"46ec9b71-805b-47c5-a7e3-f35dde838d02","artistId":"0e61046c-e96d-400b-819c-f9de8cbacba1","displayText":"Julio Alberto Hernández"}},{"type":"text","text":", que llevó repertorio dominicano y cubano por Dajabón, Montecristi y Cabo Haitiano."}]},{"type":"paragraph","content":[{"type":"text","text":"Cuba, y un poema de Guillén","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1925 viajó a Cuba como acompañante del tenor Susano Polanco. Allí conoció al poeta cubano Nicolás Guillén, quien le dio unos versos que se convirtieron en la canción «Espejo», estrenada en esa misma gira; "},{"type":"artistReference","attrs":{"occurrenceId":"ab2acc8c-6f4a-44d0-83c6-b52d6e1a64b4","artistId":"ec0423fc-fe53-42e9-8d0f-f2ae902512d3","displayText":"Eduardo Brito"}},{"type":"text","text":" la grabó en Nueva York en 1930, llevándola a un público más amplio."}]},{"type":"paragraph","content":[{"type":"text","text":"«Quisqueyana»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su obra mayor más conocida, la Sinfonía n.º 1, «Quisqueyana», terminada en 1935, tomó material folclórico dominicano dentro de un marco sinfónico; la Orquesta Sinfónica de Santo Domingo la estrenó en el Teatro Olimpia el 21 de marzo de 1941. Escribió además «Simastral», fantasía sinfónica estrenada en 1947, y una Fantasía Concertante para piano y orquesta en 1949, junto a un catálogo amplio de piezas nacionalistas para piano, entre ellas la «Fantasía Indígena», en cuatro movimientos sobre mitología taína, y la pieza «Sambumbia»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Sus canciones «Mal de amores» y la criolla «Margarita del Campo» entraron al repertorio popular, y su «Himno a la Bandera» se volvió uno de los clásicos patrióticos del país. También dio clases —entre sus alumnos estuvo la pianista Margarita Luna de Espaillat— y escribió sobre historia y folclore de la música dominicana. Murió en Santo Domingo en 1974, a los ochenta y dos años, después de más de medio siglo construyendo, junto a contemporáneos como "},{"type":"artistReference","attrs":{"occurrenceId":"6b58d89e-6886-40d0-8e4d-1166301de5db","artistId":"0e61046c-e96d-400b-819c-f9de8cbacba1","displayText":"Julio Alberto Hernández"}},{"type":"text","text":" y Juan Espínola, una tradición de música académica que tomaba su material directamente del folclore dominicano en lugar de importarlo de Europa."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'juan-francisco-garcia'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'juan-francisco-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '46ec9b71-805b-47c5-a7e3-f35dde838d02', 'artist', '0e61046c-e96d-400b-819c-f9de8cbacba1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ab2acc8c-6f4a-44d0-83c6-b52d6e1a64b4', 'artist', 'ec0423fc-fe53-42e9-8d0f-f2ae902512d3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '6b58d89e-6886-40d0-8e4d-1166301de5db', 'artist', '0e61046c-e96d-400b-819c-f9de8cbacba1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'juan-francisco-garcia' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Juan Francisco García —nacido el 16 de junio de 1892 en Santiago de los Caballeros, fallecido el 18 de noviembre de 1974 en Santo Domingo— fue un compositor, director y educador musical dominicano, una de las figuras fundadoras del movimiento nacionalista de la música académica dominicana en los primeros años del siglo XX.

**Un oído, y ningún camino formal**

Mostró aptitud musical desde temprano, estudiando teoría con José García Oviedo antes de aprender por su cuenta el cello y el piano. Su método de composición siguió el del teórico belga François-Joseph Fétis, y a partir de él construyó un catálogo extenso a través de varios géneros.

**El conjunto de 1922**

Ese año escribió su Cuarteto de Cuerdas n.º 1, que no se estrenó en Santiago de los Caballeros hasta 1929, y también tocó corneta en un pequeño conjunto de gira dirigido por el pianista Julio Alberto Hernández, que llevó repertorio dominicano y cubano por Dajabón, Montecristi y Cabo Haitiano.

**Cuba, y un poema de Guillén**

En 1925 viajó a Cuba como acompañante del tenor Susano Polanco. Allí conoció al poeta cubano Nicolás Guillén, quien le dio unos versos que se convirtieron en la canción «Espejo», estrenada en esa misma gira; Eduardo Brito la grabó en Nueva York en 1930, llevándola a un público más amplio.

**«Quisqueyana»**

Su obra mayor más conocida, la Sinfonía n.º 1, «Quisqueyana», terminada en 1935, tomó material folclórico dominicano dentro de un marco sinfónico; la Orquesta Sinfónica de Santo Domingo la estrenó en el Teatro Olimpia el 21 de marzo de 1941. Escribió además «Simastral», fantasía sinfónica estrenada en 1947, y una Fantasía Concertante para piano y orquesta en 1949, junto a un catálogo amplio de piezas nacionalistas para piano, entre ellas la «Fantasía Indígena», en cuatro movimientos sobre mitología taína, y la pieza «Sambumbia».

**Legado**

Sus canciones «Mal de amores» y la criolla «Margarita del Campo» entraron al repertorio popular, y su «Himno a la Bandera» se volvió uno de los clásicos patrióticos del país. También dio clases —entre sus alumnos estuvo la pianista Margarita Luna de Espaillat— y escribió sobre historia y folclore de la música dominicana. Murió en Santo Domingo en 1974, a los ochenta y dos años, después de más de medio siglo construyendo, junto a contemporáneos como Julio Alberto Hernández y Juan Espínola, una tradición de música académica que tomaba su material directamente del folclore dominicano en lugar de importarlo de Europa.' WHERE slug = 'juan-francisco-garcia';

COMMIT;
