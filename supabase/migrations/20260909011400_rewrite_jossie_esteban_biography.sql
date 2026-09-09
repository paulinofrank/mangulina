BEGIN;

-- Ficha de Jossie Esteban y La Patrulla 15.
--
-- Correcciones de campo, todas con dos fuentes coincidentes:
--  * origen La Vega, no Santo Domingo (Wikipedia es y BuenaMusica).
--  * birth_year 1979, el año en que la orquesta se formaliza.
--  * se retira el alias "Ringo Martinez": es Alberto "Ringo" Martínez,
--    que tiene ficha propia. Mismo patrón persona/agrupación ya limpiado
--    en Héctor Acosta / Los Toros Band.
--  * ended sigue en false, y ahora con prueba: en julio de 2025 el grupo
--    lanzó "Como YO", primer inédito en más de diez años, con fechas
--    contratadas hasta 2026.
--
-- Sin registrar por falta de fecha: el Congo de Oro en Colombia y el
-- Orquesta del Año en Nueva York, que las fuentes citan sin año.

-- 1. Origen, año de formación y alias
UPDATE artists SET birth_place = 'La Vega', province = 'La Vega', birth_year = 1979 WHERE slug = 'jossie-esteban-y-la-patrulla-15';
UPDATE artists SET aliases = array_remove(aliases, 'Ringo Martinez') WHERE slug = 'jossie-esteban-y-la-patrulla-15';

-- 2. Relaciones documentadas
INSERT INTO artist_relationships (source_artist_id, target_artist_id, relationship_type, start_year, end_year, notes)
SELECT s.id, g.id, 'founder_of', 1979, NULL, 'Co-founder, musical director, pianist and arranger'
  FROM artists s, artists g WHERE s.slug = 'alberto-ringo-martinez' AND g.slug = 'jossie-esteban-y-la-patrulla-15'
   AND NOT EXISTS (SELECT 1 FROM artist_relationships r WHERE r.source_artist_id = s.id
                     AND r.target_artist_id = g.id AND r.relationship_type = 'founder_of');
INSERT INTO artist_relationships (source_artist_id, target_artist_id, relationship_type, start_year, end_year, notes)
SELECT s.id, g.id, 'member_of', NULL, NULL, 'Bass and arrangements in the earliest lineups; sources place him in 1975-1977, before the 1979 date they give for the orchestra itself'
  FROM artists s, artists g WHERE s.slug = 'henry-hierro' AND g.slug = 'jossie-esteban-y-la-patrulla-15'
   AND NOT EXISTS (SELECT 1 FROM artist_relationships r WHERE r.source_artist_id = s.id
                     AND r.target_artist_id = g.id AND r.relationship_type = 'member_of');

-- 3. Documentos editoriales, referencias y espejo markdown legacy
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jossie Esteban y La Patrulla 15 is a Dominican merengue orchestra formed in La Vega in 1979 by two childhood friends, the singer Jossie Esteban — born Esteban Grullón — and the pianist and arranger "},{"type":"artistReference","attrs":{"occurrenceId":"285858d3-1443-42bf-bd2d-cb07a979f4a1","artistId":"12263c19-ea47-4a2b-b33f-1c42e397f344","displayText":"Alberto \"Ringo\" Martínez"}},{"type":"text","text":". It was among the most widely booked merengue bands of the 1980s and 1990s, recorded more than twenty albums, and returned to recording in 2025 after a decade away."}]},{"type":"paragraph","content":[{"type":"text","text":"La Vega and Puerto Rico","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Grullón and Martínez had been friends since childhood and both took up music as teenagers. Each left separately to study in Puerto Rico, and for a time neither played. When they met again they decided to go back to it on a professional footing, and the orchestra they assembled — billed at first as Orquesta Jossie Esteban y la Patrulla 15 — mixed Dominican musicians with Puerto Rican ones, an arrangement it kept for the rest of its working life. "},{"type":"artistReference","attrs":{"occurrenceId":"12a32cb0-3265-4550-bf80-5caf0f454ed9","artistId":"db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250","displayText":"Henry Hierro"}},{"type":"text","text":" played bass and arranged for its earliest lineups."}]},{"type":"paragraph","content":[{"type":"text","text":"Twenty years of records","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cuchú Cuchá broke the group, and what followed kept it on Dominican and diaspora radio for two decades: \"Agua de coco\", \"Pirulo\", \"El can\", \"Un hombre busca una mujer\", \"Enamoraíto\", \"El añoñaíto\", \"Noche de copas\", \"Cantinero\", \"El meneíto\" and \"Pegando el pecho\" among them. They recorded for Amapola, Gema, Artomax, Top Ten Hits, Ringo Records and Plátano Records, and took the Congo de Oro in Colombia, Orquesta del Año in New York, and several platinum certifications."}]},{"type":"paragraph","content":[{"type":"text","text":"\"El tiguerón\" reached Latin radio in 1992, a classic-form merengue that stood out against what the genre’s newer generation was doing that decade."}]},{"type":"paragraph","content":[{"type":"text","text":"Jossie Esteban on his own","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Nuestro 20 Aniversario closed the orchestra’s most active run at the end of the 1990s. Jossie Esteban had joined the merengue trio Zona Roja in 1992, and from then on also recorded under his own name, from Internacional (1993) and La Universidad del Merengue (1998) through Despierta (2015) and Ahora se goza más (2017)."}]},{"type":"paragraph","content":[{"type":"text","text":"The return","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In July 2025 the group released \"Como YO\", its first new song in more than ten years, billed as Jossie Esteban, Ringo y La Patrulla 15. The Venezuelan singer-songwriter Carlos Baute wrote it and Martínez, still the band’s musical director, arranged it; Martínez said they had never stopped rehearsing. The single was presented as the opening of a wider project, with an album of collaborations and live dates to follow, and the band was booked into 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The orchestra belonged to the generation that carried merengue through its most commercially expansive years, working the New York circuit as steadily as the one at home. Its personnel list runs past thirty players across two decades, Dominican and Puerto Rican, and included musicians who went on to lead bands of their own, Henry Hierro among them."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jossie-esteban-y-la-patrulla-15'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jossie-esteban-y-la-patrulla-15' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '285858d3-1443-42bf-bd2d-cb07a979f4a1', 'artist', '12263c19-ea47-4a2b-b33f-1c42e397f344'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jossie-esteban-y-la-patrulla-15' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '12a32cb0-3265-4550-bf80-5caf0f454ed9', 'artist', 'db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jossie-esteban-y-la-patrulla-15' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Jossie Esteban y La Patrulla 15 is a Dominican merengue orchestra formed in La Vega in 1979 by two childhood friends, the singer Jossie Esteban — born Esteban Grullón — and the pianist and arranger Alberto "Ringo" Martínez. It was among the most widely booked merengue bands of the 1980s and 1990s, recorded more than twenty albums, and returned to recording in 2025 after a decade away.

**La Vega and Puerto Rico**

Grullón and Martínez had been friends since childhood and both took up music as teenagers. Each left separately to study in Puerto Rico, and for a time neither played. When they met again they decided to go back to it on a professional footing, and the orchestra they assembled — billed at first as Orquesta Jossie Esteban y la Patrulla 15 — mixed Dominican musicians with Puerto Rican ones, an arrangement it kept for the rest of its working life. Henry Hierro played bass and arranged for its earliest lineups.

**Twenty years of records**

Cuchú Cuchá broke the group, and what followed kept it on Dominican and diaspora radio for two decades: "Agua de coco", "Pirulo", "El can", "Un hombre busca una mujer", "Enamoraíto", "El añoñaíto", "Noche de copas", "Cantinero", "El meneíto" and "Pegando el pecho" among them. They recorded for Amapola, Gema, Artomax, Top Ten Hits, Ringo Records and Plátano Records, and took the Congo de Oro in Colombia, Orquesta del Año in New York, and several platinum certifications.

"El tiguerón" reached Latin radio in 1992, a classic-form merengue that stood out against what the genre’s newer generation was doing that decade.

**Jossie Esteban on his own**

Nuestro 20 Aniversario closed the orchestra’s most active run at the end of the 1990s. Jossie Esteban had joined the merengue trio Zona Roja in 1992, and from then on also recorded under his own name, from Internacional (1993) and La Universidad del Merengue (1998) through Despierta (2015) and Ahora se goza más (2017).

**The return**

In July 2025 the group released "Como YO", its first new song in more than ten years, billed as Jossie Esteban, Ringo y La Patrulla 15. The Venezuelan singer-songwriter Carlos Baute wrote it and Martínez, still the band’s musical director, arranged it; Martínez said they had never stopped rehearsing. The single was presented as the opening of a wider project, with an album of collaborations and live dates to follow, and the band was booked into 2026.

**Legacy**

The orchestra belonged to the generation that carried merengue through its most commercially expansive years, working the New York circuit as steadily as the one at home. Its personnel list runs past thirty players across two decades, Dominican and Puerto Rican, and included musicians who went on to lead bands of their own, Henry Hierro among them.' WHERE slug = 'jossie-esteban-y-la-patrulla-15';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jossie Esteban y La Patrulla 15 es una orquesta de merengue dominicana formada en La Vega en 1979 por dos amigos de la infancia: el cantante Jossie Esteban —nacido Esteban Grullón— y el pianista y arreglista "},{"type":"artistReference","attrs":{"occurrenceId":"f0acd6de-af0d-434e-b235-3922d4daf7cb","artistId":"12263c19-ea47-4a2b-b33f-1c42e397f344","displayText":"Alberto \"Ringo\" Martínez"}},{"type":"text","text":". Fue una de las orquestas más contratadas del merengue en los años ochenta y noventa, grabó más de veinte discos y volvió a grabar en 2025 tras una década de silencio."}]},{"type":"paragraph","content":[{"type":"text","text":"La Vega y Puerto Rico","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Grullón y Martínez eran amigos desde niños y los dos empezaron en la música de adolescentes. Cada uno se fue por su lado a estudiar a Puerto Rico y durante un tiempo ninguno tocó. Al reencontrarse decidieron volver, esta vez en serio, y la orquesta que armaron —anunciada al principio como Orquesta Jossie Esteban y la Patrulla 15— juntó músicos dominicanos y puertorriqueños, una mezcla que mantuvo el resto de su vida útil. "},{"type":"artistReference","attrs":{"occurrenceId":"5872db46-0029-4ff5-b098-bc173e9ca6b2","artistId":"db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250","displayText":"Henry Hierro"}},{"type":"text","text":" tocó el bajo e hizo arreglos en sus primeras nóminas."}]},{"type":"paragraph","content":[{"type":"text","text":"Veinte años de discos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cuchú Cuchá abrió el camino, y lo que vino después mantuvo al grupo en la radio dominicana y de la diáspora durante dos décadas: «Agua de coco», «Pirulo», «El can», «Un hombre busca una mujer», «Enamoraíto», «El añoñaíto», «Noche de copas», «Cantinero», «El meneíto» y «Pegando el pecho», entre otras. Grabaron para Amapola, Gema, Artomax, Top Ten Hits, Ringo Records y Plátano Records, y se llevaron el Congo de Oro en Colombia, Orquesta del Año en Nueva York y varios discos de platino."}]},{"type":"paragraph","content":[{"type":"text","text":"«El tiguerón» llegó a la radio latina en 1992, un merengue de forma clásica que se destacó frente a lo que hacía la nueva generación del género en esa década."}]},{"type":"paragraph","content":[{"type":"text","text":"Jossie Esteban por su cuenta","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Nuestro 20 Aniversario cerró la etapa más activa de la orquesta a finales de los noventa. Jossie Esteban se había integrado en 1992 al trío merenguero Zona Roja, y desde entonces grabó también con su propio nombre, de Internacional (1993) y La Universidad del Merengue (1998) a Despierta (2015) y Ahora se goza más (2017)."}]},{"type":"paragraph","content":[{"type":"text","text":"El regreso","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En julio de 2025 el grupo lanzó «Como YO», su primer tema inédito en más de diez años, anunciado como Jossie Esteban, Ringo y La Patrulla 15. La letra es del cantautor venezolano Carlos Baute y el arreglo de Martínez, que sigue como director musical; Martínez declaró que nunca habían dejado de ensayar. El sencillo se presentó como el comienzo de un proyecto mayor, con un álbum de colaboraciones y presentaciones en vivo por delante, y la agrupación tenía fechas contratadas hasta 2026."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La orquesta perteneció a la generación que llevó el merengue por sus años de mayor expansión comercial, y trabajó el circuito de Nueva York con la misma constancia que el de casa. Su lista de integrantes pasa de treinta músicos en dos décadas, dominicanos y puertorriqueños, y de ella salieron músicos que dirigieron sus propias agrupaciones, Henry Hierro entre ellos."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jossie-esteban-y-la-patrulla-15'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jossie-esteban-y-la-patrulla-15' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f0acd6de-af0d-434e-b235-3922d4daf7cb', 'artist', '12263c19-ea47-4a2b-b33f-1c42e397f344'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jossie-esteban-y-la-patrulla-15' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5872db46-0029-4ff5-b098-bc173e9ca6b2', 'artist', 'db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jossie-esteban-y-la-patrulla-15' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Jossie Esteban y La Patrulla 15 es una orquesta de merengue dominicana formada en La Vega en 1979 por dos amigos de la infancia: el cantante Jossie Esteban —nacido Esteban Grullón— y el pianista y arreglista Alberto "Ringo" Martínez. Fue una de las orquestas más contratadas del merengue en los años ochenta y noventa, grabó más de veinte discos y volvió a grabar en 2025 tras una década de silencio.

**La Vega y Puerto Rico**

Grullón y Martínez eran amigos desde niños y los dos empezaron en la música de adolescentes. Cada uno se fue por su lado a estudiar a Puerto Rico y durante un tiempo ninguno tocó. Al reencontrarse decidieron volver, esta vez en serio, y la orquesta que armaron —anunciada al principio como Orquesta Jossie Esteban y la Patrulla 15— juntó músicos dominicanos y puertorriqueños, una mezcla que mantuvo el resto de su vida útil. Henry Hierro tocó el bajo e hizo arreglos en sus primeras nóminas.

**Veinte años de discos**

Cuchú Cuchá abrió el camino, y lo que vino después mantuvo al grupo en la radio dominicana y de la diáspora durante dos décadas: «Agua de coco», «Pirulo», «El can», «Un hombre busca una mujer», «Enamoraíto», «El añoñaíto», «Noche de copas», «Cantinero», «El meneíto» y «Pegando el pecho», entre otras. Grabaron para Amapola, Gema, Artomax, Top Ten Hits, Ringo Records y Plátano Records, y se llevaron el Congo de Oro en Colombia, Orquesta del Año en Nueva York y varios discos de platino.

«El tiguerón» llegó a la radio latina en 1992, un merengue de forma clásica que se destacó frente a lo que hacía la nueva generación del género en esa década.

**Jossie Esteban por su cuenta**

Nuestro 20 Aniversario cerró la etapa más activa de la orquesta a finales de los noventa. Jossie Esteban se había integrado en 1992 al trío merenguero Zona Roja, y desde entonces grabó también con su propio nombre, de Internacional (1993) y La Universidad del Merengue (1998) a Despierta (2015) y Ahora se goza más (2017).

**El regreso**

En julio de 2025 el grupo lanzó «Como YO», su primer tema inédito en más de diez años, anunciado como Jossie Esteban, Ringo y La Patrulla 15. La letra es del cantautor venezolano Carlos Baute y el arreglo de Martínez, que sigue como director musical; Martínez declaró que nunca habían dejado de ensayar. El sencillo se presentó como el comienzo de un proyecto mayor, con un álbum de colaboraciones y presentaciones en vivo por delante, y la agrupación tenía fechas contratadas hasta 2026.

**Legado**

La orquesta perteneció a la generación que llevó el merengue por sus años de mayor expansión comercial, y trabajó el circuito de Nueva York con la misma constancia que el de casa. Su lista de integrantes pasa de treinta músicos en dos décadas, dominicanos y puertorriqueños, y de ella salieron músicos que dirigieron sus propias agrupaciones, Henry Hierro entre ellos.' WHERE slug = 'jossie-esteban-y-la-patrulla-15';

COMMIT;
