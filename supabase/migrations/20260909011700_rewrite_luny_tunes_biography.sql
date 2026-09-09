BEGIN;

-- Ficha de Luny Tunes.
--
-- Corrige además una relación invertida: la base tenía
--   Luny Tunes --member_of--> Luny
-- es decir el dúo como miembro de uno de sus propios integrantes. La
-- dirección correcta, y la que ya tenía la fila de Tunes, es
--   Luny --member_of--> Luny Tunes
--
-- Sin tocar, para las fichas de los integrantes: Wikipedia da a Saldaña
-- nacido el 23 de junio de 1979 en Santiago de los Caballeros y a Cabrera
-- en El Seibo. La base dice 18 de junio para Saldaña, sin lugar, y Santo
-- Domingo para Cabrera. Fuente única de cada lado; se anota, no se decide.

-- 1. Relación invertida
DELETE FROM artist_relationships r
 USING artists d, artists m
 WHERE r.source_artist_id = d.id AND r.target_artist_id = m.id
   AND d.slug = 'luny-tunes' AND m.slug = 'luny' AND r.relationship_type = 'member_of';
INSERT INTO artist_relationships (source_artist_id, target_artist_id, relationship_type, notes)
SELECT m.id, d.id, 'member_of', 'One half of the duo, with Tunes'
  FROM artists m, artists d WHERE m.slug = 'luny' AND d.slug = 'luny-tunes'
   AND NOT EXISTS (SELECT 1 FROM artist_relationships r WHERE r.source_artist_id = m.id
                     AND r.target_artist_id = d.id AND r.relationship_type = 'member_of');

-- 2. Documentos editoriales, referencias y espejo markdown legacy
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Luny Tunes is a Dominican production duo — "},{"type":"artistReference","attrs":{"occurrenceId":"524b5645-8243-4ef5-b621-dd7b3bf72644","artistId":"e611e3fc-c00d-46e6-b397-27425787d6d1","displayText":"Luny"}},{"type":"text","text":", born Francisco Saldaña, and "},{"type":"artistReference","attrs":{"occurrenceId":"cf11a7a4-9df7-439c-8153-b2a8be26e5da","artistId":"f78661d2-7e96-48b7-baf3-fd99a94d10e6","displayText":"Tunes"}},{"type":"text","text":", born Víctor Cabrera — whose work shaped the sound of reggaeton over the decade the genre broke internationally. Their Mas Flow albums and their productions for other people’s records, \"Gasolina\" among them, carried their signature onto most of what left Puerto Rico in those years."}]},{"type":"paragraph","content":[{"type":"text","text":"Lawrence and the Harvard dining hall","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Saldaña and Cabrera were born in the Dominican Republic and grew up in Lawrence, Massachusetts. Before any of the records they worked in the Leverett House dining hall at Harvard University, one cooking and the other washing dishes. Neither came out of the industry or a conservatory: they learned production on their own equipment, after their shifts."}]},{"type":"paragraph","content":[{"type":"text","text":"Flow Music","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ivy Queen was the first artist to record with them, on \"Quiero Saber\". Their work on Héctor & Tito’s A La Reconquista, in 2002, reached DJ Nelson, who signed them to his Flow Music label. Mas Flow followed in 2003, made with the producer Noriega and built entirely from new material, with Daddy Yankee, Don Omar, Tego Calderón, Wisin & Yandel, Zion & Lennox, Nicky Jam and Héctor & Tito on it. It sold more than half a million copies."}]},{"type":"paragraph","content":[{"type":"text","text":"Barrio Fino and Mas Flow 2","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2004 they produced \"Gasolina\" for Daddy Yankee’s Barrio Fino, and the record travelled further than anything the genre had sent out before. Within the same two years they also worked on Don Omar’s The Last Don, Tego Calderón’s El Abayarde, Eddie Dee’s Los 12 Discípulos, Ivy Queen’s Diva, Zion & Lennox’s Motivando a la Yal, Nicky Jam’s Vida Escante and Trebol Clan’s Los Bacatranes."}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow, Vol. 2 came in 2005 and passed a million copies, which almost no reggaeton album has done. \"Rakata\", \"Mayor Que Yo\", \"Mírame\" and \"Te He Querido Te He Llorado\" came off it. Mas Flow: Los Benjamins followed in 2006, and with it \"Noche de Entierro\". They also remixed Janet Jackson’s \"Call on Me\"."}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow as a label","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow became a record company in its own right. Assistant producers worked in its orbit, among them Tainy, who went on to become one of the most sought-after producers in Latin music, and other Dominicans passed through, "},{"type":"artistReference","attrs":{"occurrenceId":"d0d0ede4-6dc2-4ff7-818b-8acade881edf","artistId":"f6865535-50d6-46a2-991e-402a5f3b27d6","displayText":"DJ Urba"}},{"type":"text","text":" among them, on Daddy Yankee’s records of the same decade. The duo signed Erre XI in 2008 and Dyland & Lenny in 2009."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Luny Tunes worked continuously until 2021 and resumed in 2023. Their instrumentals were the measure the genre was held to in the years it broke out, and the production line they ran at Mas Flow trained several of the people who took over afterwards. Two Dominicans out of a Massachusetts kitchen produced the decade by which reggaeton is remembered, in a genre still catalogued as Puerto Rican."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luny-tunes'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'luny-tunes' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '524b5645-8243-4ef5-b621-dd7b3bf72644', 'artist', 'e611e3fc-c00d-46e6-b397-27425787d6d1'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cf11a7a4-9df7-439c-8153-b2a8be26e5da', 'artist', 'f78661d2-7e96-48b7-baf3-fd99a94d10e6'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd0d0ede4-6dc2-4ff7-818b-8acade881edf', 'artist', 'f6865535-50d6-46a2-991e-402a5f3b27d6'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Luny Tunes is a Dominican production duo — Luny, born Francisco Saldaña, and Tunes, born Víctor Cabrera — whose work shaped the sound of reggaeton over the decade the genre broke internationally. Their Mas Flow albums and their productions for other people’s records, "Gasolina" among them, carried their signature onto most of what left Puerto Rico in those years.

**Lawrence and the Harvard dining hall**

Saldaña and Cabrera were born in the Dominican Republic and grew up in Lawrence, Massachusetts. Before any of the records they worked in the Leverett House dining hall at Harvard University, one cooking and the other washing dishes. Neither came out of the industry or a conservatory: they learned production on their own equipment, after their shifts.

**Flow Music**

Ivy Queen was the first artist to record with them, on "Quiero Saber". Their work on Héctor & Tito’s A La Reconquista, in 2002, reached DJ Nelson, who signed them to his Flow Music label. Mas Flow followed in 2003, made with the producer Noriega and built entirely from new material, with Daddy Yankee, Don Omar, Tego Calderón, Wisin & Yandel, Zion & Lennox, Nicky Jam and Héctor & Tito on it. It sold more than half a million copies.

**Barrio Fino and Mas Flow 2**

In 2004 they produced "Gasolina" for Daddy Yankee’s Barrio Fino, and the record travelled further than anything the genre had sent out before. Within the same two years they also worked on Don Omar’s The Last Don, Tego Calderón’s El Abayarde, Eddie Dee’s Los 12 Discípulos, Ivy Queen’s Diva, Zion & Lennox’s Motivando a la Yal, Nicky Jam’s Vida Escante and Trebol Clan’s Los Bacatranes.

Mas Flow, Vol. 2 came in 2005 and passed a million copies, which almost no reggaeton album has done. "Rakata", "Mayor Que Yo", "Mírame" and "Te He Querido Te He Llorado" came off it. Mas Flow: Los Benjamins followed in 2006, and with it "Noche de Entierro". They also remixed Janet Jackson’s "Call on Me".

**Mas Flow as a label**

Mas Flow became a record company in its own right. Assistant producers worked in its orbit, among them Tainy, who went on to become one of the most sought-after producers in Latin music, and other Dominicans passed through, DJ Urba among them, on Daddy Yankee’s records of the same decade. The duo signed Erre XI in 2008 and Dyland & Lenny in 2009.

**Legacy**

Luny Tunes worked continuously until 2021 and resumed in 2023. Their instrumentals were the measure the genre was held to in the years it broke out, and the production line they ran at Mas Flow trained several of the people who took over afterwards. Two Dominicans out of a Massachusetts kitchen produced the decade by which reggaeton is remembered, in a genre still catalogued as Puerto Rican.' WHERE slug = 'luny-tunes';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Luny Tunes es un dúo de productores dominicanos —"},{"type":"artistReference","attrs":{"occurrenceId":"7a7161fc-89f5-4a95-bb5f-9e8ca7e28574","artistId":"e611e3fc-c00d-46e6-b397-27425787d6d1","displayText":"Luny"}},{"type":"text","text":", de nombre Francisco Saldaña, y "},{"type":"artistReference","attrs":{"occurrenceId":"dab42f27-015a-4725-a3bc-197b5d565082","artistId":"f78661d2-7e96-48b7-baf3-fd99a94d10e6","displayText":"Tunes"}},{"type":"text","text":", de nombre Víctor Cabrera— cuyo trabajo definió el sonido del reggaetón durante la década en que el género salió al mundo. Sus discos Mas Flow y sus producciones para otros, «Gasolina» entre ellas, dejaron su firma en casi todo lo que salió de Puerto Rico en esos años."}]},{"type":"paragraph","content":[{"type":"text","text":"Lawrence y el comedor de Harvard","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Saldaña y Cabrera nacieron en la República Dominicana y se criaron en Lawrence, Massachusetts. Antes de los discos trabajaban en el comedor de Leverett House, en la Universidad de Harvard: uno cocinando y el otro lavando platos. Ninguno de los dos salió de la industria ni de un conservatorio; aprendieron a producir en sus propios equipos, después del turno."}]},{"type":"paragraph","content":[{"type":"text","text":"Flow Music","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ivy Queen fue la primera en grabar con ellos, en «Quiero Saber». Su trabajo en A La Reconquista, de Héctor & Tito, en 2002, llegó a DJ Nelson, que los firmó para su sello Flow Music. Mas Flow salió en 2003, hecho con el productor Noriega y armado por completo con material nuevo, con Daddy Yankee, Don Omar, Tego Calderón, Wisin & Yandel, Zion & Lennox, Nicky Jam y Héctor & Tito. Vendió más de medio millón de copias."}]},{"type":"paragraph","content":[{"type":"text","text":"Barrio Fino y Mas Flow 2","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2004 produjeron «Gasolina» para Barrio Fino, de Daddy Yankee, y el tema viajó más lejos que nada que el género hubiera mandado antes. En esos mismos dos años trabajaron también en The Last Don, de Don Omar; El Abayarde, de Tego Calderón; Los 12 Discípulos, de Eddie Dee; Diva, de Ivy Queen; Motivando a la Yal, de Zion & Lennox; Vida Escante, de Nicky Jam; y Los Bacatranes, de Trebol Clan."}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow, Vol. 2 llegó en 2005 y pasó el millón de copias, cifra que casi ningún disco de reggaetón ha alcanzado. De él salieron «Rakata», «Mayor Que Yo», «Mírame» y «Te He Querido Te He Llorado». En 2006 vino Mas Flow: Los Benjamins, y con él «Noche de Entierro». Remezclaron además «Call on Me», de Janet Jackson."}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow como sello","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow se volvió disquera por derecho propio. En su órbita trabajaron productores asistentes, entre ellos Tainy, que llegaría a ser uno de los productores más solicitados de la música latina, y por ahí pasaron otros dominicanos, "},{"type":"artistReference","attrs":{"occurrenceId":"e628bff2-cec1-4311-8dd7-e180f28bd18a","artistId":"f6865535-50d6-46a2-991e-402a5f3b27d6","displayText":"DJ Urba"}},{"type":"text","text":" entre ellos, en los discos de Daddy Yankee de esa misma década. El dúo firmó a Erre XI en 2008 y a Dyland & Lenny en 2009."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Luny Tunes trabajó sin pausa hasta 2021 y volvió en 2023. Sus pistas fueron la vara con la que se midió el género en los años en que rompió, y la línea de producción que sostuvieron en Mas Flow formó a varios de los que vinieron después. Dos dominicanos salidos de una cocina de Massachusetts produjeron la década por la que se recuerda al reggaetón, en un género que se sigue catalogando como puertorriqueño."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luny-tunes'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'luny-tunes' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7a7161fc-89f5-4a95-bb5f-9e8ca7e28574', 'artist', 'e611e3fc-c00d-46e6-b397-27425787d6d1'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dab42f27-015a-4725-a3bc-197b5d565082', 'artist', 'f78661d2-7e96-48b7-baf3-fd99a94d10e6'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e628bff2-cec1-4311-8dd7-e180f28bd18a', 'artist', 'f6865535-50d6-46a2-991e-402a5f3b27d6'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Luny Tunes es un dúo de productores dominicanos —Luny, de nombre Francisco Saldaña, y Tunes, de nombre Víctor Cabrera— cuyo trabajo definió el sonido del reggaetón durante la década en que el género salió al mundo. Sus discos Mas Flow y sus producciones para otros, «Gasolina» entre ellas, dejaron su firma en casi todo lo que salió de Puerto Rico en esos años.

**Lawrence y el comedor de Harvard**

Saldaña y Cabrera nacieron en la República Dominicana y se criaron en Lawrence, Massachusetts. Antes de los discos trabajaban en el comedor de Leverett House, en la Universidad de Harvard: uno cocinando y el otro lavando platos. Ninguno de los dos salió de la industria ni de un conservatorio; aprendieron a producir en sus propios equipos, después del turno.

**Flow Music**

Ivy Queen fue la primera en grabar con ellos, en «Quiero Saber». Su trabajo en A La Reconquista, de Héctor & Tito, en 2002, llegó a DJ Nelson, que los firmó para su sello Flow Music. Mas Flow salió en 2003, hecho con el productor Noriega y armado por completo con material nuevo, con Daddy Yankee, Don Omar, Tego Calderón, Wisin & Yandel, Zion & Lennox, Nicky Jam y Héctor & Tito. Vendió más de medio millón de copias.

**Barrio Fino y Mas Flow 2**

En 2004 produjeron «Gasolina» para Barrio Fino, de Daddy Yankee, y el tema viajó más lejos que nada que el género hubiera mandado antes. En esos mismos dos años trabajaron también en The Last Don, de Don Omar; El Abayarde, de Tego Calderón; Los 12 Discípulos, de Eddie Dee; Diva, de Ivy Queen; Motivando a la Yal, de Zion & Lennox; Vida Escante, de Nicky Jam; y Los Bacatranes, de Trebol Clan.

Mas Flow, Vol. 2 llegó en 2005 y pasó el millón de copias, cifra que casi ningún disco de reggaetón ha alcanzado. De él salieron «Rakata», «Mayor Que Yo», «Mírame» y «Te He Querido Te He Llorado». En 2006 vino Mas Flow: Los Benjamins, y con él «Noche de Entierro». Remezclaron además «Call on Me», de Janet Jackson.

**Mas Flow como sello**

Mas Flow se volvió disquera por derecho propio. En su órbita trabajaron productores asistentes, entre ellos Tainy, que llegaría a ser uno de los productores más solicitados de la música latina, y por ahí pasaron otros dominicanos, DJ Urba entre ellos, en los discos de Daddy Yankee de esa misma década. El dúo firmó a Erre XI en 2008 y a Dyland & Lenny en 2009.

**Legado**

Luny Tunes trabajó sin pausa hasta 2021 y volvió en 2023. Sus pistas fueron la vara con la que se midió el género en los años en que rompió, y la línea de producción que sostuvieron en Mas Flow formó a varios de los que vinieron después. Dos dominicanos salidos de una cocina de Massachusetts produjeron la década por la que se recuerda al reggaetón, en un género que se sigue catalogando como puertorriqueño.' WHERE slug = 'luny-tunes';

COMMIT;
