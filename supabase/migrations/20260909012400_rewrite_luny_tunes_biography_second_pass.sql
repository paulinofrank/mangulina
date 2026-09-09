BEGIN;

-- Ficha de Luny Tunes, SEGUNDA VERSIÓN.
--
-- La primera (20260909011700) reprodujo casi uno a uno el orden de las
-- secciones del artículo de Wikipedia en inglés. Esta se organiza por lo
-- que hizo cada disco, no por etapas de carrera, y trae material del
-- artículo del álbum Mas Flow —otra vantage— y de las fichas de DJ Urba y
-- Sharlene del propio catálogo:
--
--  * Mas Flow salió el 26 de agosto de 2003, acreditado a Luny Tunes y
--    Noriega, con DJ Nelson y Eliel también produciendo, y toda su música
--    es de ellos.
--  * Fue número uno en Reggae Albums y en Tropical Albums de Billboard.
--  * Junto a El Abayarde de Tego Calderón se lo señala como el primer disco
--    de reggaetón que llegó al público masivo.
--  * La Trayectoria y The Kings of the Beats, los dos de 2004, no estaban.
--  * DJ Urba pasó de 2004 a 2010 entre Mas Flow y El Cartel Records.
--  * Sharlene grabó con ellos en "La Fila", con Don Omar y Maluma.
--
-- La relación member_of ya quedó corregida en 20260909011700.

-- Documentos editoriales, referencias y espejo markdown legacy
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Luny Tunes is the Dominican production duo of "},{"type":"artistReference","attrs":{"occurrenceId":"08218ff4-d95a-4d42-ad3b-c1740212c8be","artistId":"e611e3fc-c00d-46e6-b397-27425787d6d1","displayText":"Luny"}},{"type":"text","text":" — Francisco Saldaña — and "},{"type":"artistReference","attrs":{"occurrenceId":"3b8983c0-ba66-437f-9f18-5dfc39bc0168","artistId":"f78661d2-7e96-48b7-baf3-fd99a94d10e6","displayText":"Tunes"}},{"type":"text","text":" — Víctor Cabrera. Reggaeton before them lived on mixtapes and singles; what they did was make it work as an album, and the shape they gave those albums became the shape of the genre. They have been working since 2000, with a pause between 2021 and 2023."}]},{"type":"paragraph","content":[{"type":"text","text":"The Harvard kitchen","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Saldaña and Cabrera grew up in Lawrence, Massachusetts, and worked in the Leverett House dining hall at Harvard University, one cooking and the other washing dishes. Neither came out of the industry or a conservatory; they learned production on their own equipment after their shifts. Ivy Queen was the first artist to record with them, and it was their work on Héctor & Tito’s A La Reconquista, in 2002, that reached DJ Nelson, who signed them to Flow Music."}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow, 2003","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow appeared on 26 August 2003, credited to Luny Tunes and Noriega and issued by Flow Music and VI Music, with DJ Nelson and Eliel also producing. Every piece of music on it is theirs. It is a compilation in form — twenty tracks, a different vocalist on almost each one — but built entirely from new material, and the roster reads as a census of the genre at that moment: Héctor & Tito, Wisin & Yandel, Don Omar, Tego Calderón, Daddy Yankee, Zion & Lennox, Trebol Clan, Baby Ranks, Nicky Jam, Plan B, Glory, Ángel & Khriz."}]},{"type":"paragraph","content":[{"type":"text","text":"It went to number one on Billboard’s Reggae Albums and Tropical Albums charts and sold past half a million. Together with Tego Calderón’s El Abayarde, released the same year, it is generally described as the first reggaeton album to reach a mass audience — and the song structure and production style on it became the default for most of what the genre recorded afterwards."}]},{"type":"paragraph","content":[{"type":"text","text":"Gasolina and the million","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The following year they produced \"Gasolina\" for Daddy Yankee’s Barrio Fino, and worked in the same two-year stretch on Don Omar’s The Last Don, Tego Calderón’s El Abayarde, Eddie Dee’s Los 12 Discípulos, Ivy Queen’s Diva, Zion & Lennox’s Motivando a la Yal, Nicky Jam’s Vida Escante and Trebol Clan’s Los Bacatranes. La Trayectoria and The Kings of the Beats both came out in 2004."}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow 2 followed in 2005 and passed a million copies, which almost nothing in the genre has done. \"Rakata\", \"Mayor Que Yo\", \"Mírame\" and \"Te He Querido Te He Llorado\" are from it. Mas Flow: Los Benjamins came in 2006 with \"Noche de Entierro\", and they remixed Janet Jackson’s \"Call on Me\" in the same period."}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow as a label","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The name became a record company. Assistant producers worked in its orbit, Tainy among them, and it shared artists and catalogue with El Cartel Records: "},{"type":"artistReference","attrs":{"occurrenceId":"b9dd07a7-4fba-4100-9211-e5c49f03dacc","artistId":"f6865535-50d6-46a2-991e-402a5f3b27d6","displayText":"DJ Urba"}},{"type":"text","text":" spent the years from 2004 to 2010 across both, as half of Monserrate & DJ Urba. The duo signed Erre XI in 2008 and Dyland & Lenny in 2009, and were still putting Dominican singers on their records well after the boom — "},{"type":"artistReference","attrs":{"occurrenceId":"49a3e6eb-9b51-497b-8953-6a80ab74a78c","artistId":"112ab16f-a56b-4a93-8562-120bfee1c70b","displayText":"Sharlene"}},{"type":"text","text":" appears on a Luny Tunes album with Don Omar and Maluma on \"La Fila\"."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Two Dominicans out of a Massachusetts kitchen produced the decade by which reggaeton is remembered, in a genre still catalogued as Puerto Rican. The specific thing they changed is narrower and easier to point at than that: they proved the music could carry a full-length record, and then wrote the template everyone else used."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luny-tunes'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'luny-tunes' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '08218ff4-d95a-4d42-ad3b-c1740212c8be', 'artist', 'e611e3fc-c00d-46e6-b397-27425787d6d1'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3b8983c0-ba66-437f-9f18-5dfc39bc0168', 'artist', 'f78661d2-7e96-48b7-baf3-fd99a94d10e6'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b9dd07a7-4fba-4100-9211-e5c49f03dacc', 'artist', 'f6865535-50d6-46a2-991e-402a5f3b27d6'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '49a3e6eb-9b51-497b-8953-6a80ab74a78c', 'artist', '112ab16f-a56b-4a93-8562-120bfee1c70b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Luny Tunes is the Dominican production duo of Luny — Francisco Saldaña — and Tunes — Víctor Cabrera. Reggaeton before them lived on mixtapes and singles; what they did was make it work as an album, and the shape they gave those albums became the shape of the genre. They have been working since 2000, with a pause between 2021 and 2023.

**The Harvard kitchen**

Saldaña and Cabrera grew up in Lawrence, Massachusetts, and worked in the Leverett House dining hall at Harvard University, one cooking and the other washing dishes. Neither came out of the industry or a conservatory; they learned production on their own equipment after their shifts. Ivy Queen was the first artist to record with them, and it was their work on Héctor & Tito’s A La Reconquista, in 2002, that reached DJ Nelson, who signed them to Flow Music.

**Mas Flow, 2003**

Mas Flow appeared on 26 August 2003, credited to Luny Tunes and Noriega and issued by Flow Music and VI Music, with DJ Nelson and Eliel also producing. Every piece of music on it is theirs. It is a compilation in form — twenty tracks, a different vocalist on almost each one — but built entirely from new material, and the roster reads as a census of the genre at that moment: Héctor & Tito, Wisin & Yandel, Don Omar, Tego Calderón, Daddy Yankee, Zion & Lennox, Trebol Clan, Baby Ranks, Nicky Jam, Plan B, Glory, Ángel & Khriz.

It went to number one on Billboard’s Reggae Albums and Tropical Albums charts and sold past half a million. Together with Tego Calderón’s El Abayarde, released the same year, it is generally described as the first reggaeton album to reach a mass audience — and the song structure and production style on it became the default for most of what the genre recorded afterwards.

**Gasolina and the million**

The following year they produced "Gasolina" for Daddy Yankee’s Barrio Fino, and worked in the same two-year stretch on Don Omar’s The Last Don, Tego Calderón’s El Abayarde, Eddie Dee’s Los 12 Discípulos, Ivy Queen’s Diva, Zion & Lennox’s Motivando a la Yal, Nicky Jam’s Vida Escante and Trebol Clan’s Los Bacatranes. La Trayectoria and The Kings of the Beats both came out in 2004.

Mas Flow 2 followed in 2005 and passed a million copies, which almost nothing in the genre has done. "Rakata", "Mayor Que Yo", "Mírame" and "Te He Querido Te He Llorado" are from it. Mas Flow: Los Benjamins came in 2006 with "Noche de Entierro", and they remixed Janet Jackson’s "Call on Me" in the same period.

**Mas Flow as a label**

The name became a record company. Assistant producers worked in its orbit, Tainy among them, and it shared artists and catalogue with El Cartel Records: DJ Urba spent the years from 2004 to 2010 across both, as half of Monserrate & DJ Urba. The duo signed Erre XI in 2008 and Dyland & Lenny in 2009, and were still putting Dominican singers on their records well after the boom — Sharlene appears on a Luny Tunes album with Don Omar and Maluma on "La Fila".

**Legacy**

Two Dominicans out of a Massachusetts kitchen produced the decade by which reggaeton is remembered, in a genre still catalogued as Puerto Rican. The specific thing they changed is narrower and easier to point at than that: they proved the music could carry a full-length record, and then wrote the template everyone else used.' WHERE slug = 'luny-tunes';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Luny Tunes es el dúo dominicano de productores que forman "},{"type":"artistReference","attrs":{"occurrenceId":"248589b2-aaa7-4612-add5-1ab458c884a5","artistId":"e611e3fc-c00d-46e6-b397-27425787d6d1","displayText":"Luny"}},{"type":"text","text":" —Francisco Saldaña— y "},{"type":"artistReference","attrs":{"occurrenceId":"c7c0f159-5183-41c8-84b5-1a9a78db595e","artistId":"f78661d2-7e96-48b7-baf3-fd99a94d10e6","displayText":"Tunes"}},{"type":"text","text":" —Víctor Cabrera—. Antes de ellos el reggaetón vivía en mixtapes y sencillos; lo que hicieron fue que funcionara como álbum, y la forma que le dieron a esos álbumes terminó siendo la forma del género. Trabajan desde 2000, con una pausa entre 2021 y 2023."}]},{"type":"paragraph","content":[{"type":"text","text":"La cocina de Harvard","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Saldaña y Cabrera se criaron en Lawrence, Massachusetts, y trabajaban en el comedor de Leverett House, en la Universidad de Harvard: uno cocinando y el otro lavando platos. Ninguno salió de la industria ni de un conservatorio; aprendieron a producir en sus propios equipos, después del turno. Ivy Queen fue la primera en grabar con ellos, y fue su trabajo en A La Reconquista, de Héctor & Tito, en 2002, el que llegó a DJ Nelson, que los firmó para Flow Music."}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow, 2003","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow salió el 26 de agosto de 2003, acreditado a Luny Tunes y Noriega y editado por Flow Music y VI Music, con DJ Nelson y Eliel también en la producción. Toda la música del disco es suya. La forma es de recopilatorio —veinte cortes, un vocalista distinto en casi cada uno—, pero armado por completo con material nuevo, y la nómina se lee como un censo del género en ese momento: Héctor & Tito, Wisin & Yandel, Don Omar, Tego Calderón, Daddy Yankee, Zion & Lennox, Trebol Clan, Baby Ranks, Nicky Jam, Plan B, Glory, Ángel & Khriz."}]},{"type":"paragraph","content":[{"type":"text","text":"Llegó al número uno de las listas de Reggae Albums y Tropical Albums de Billboard y pasó el medio millón de copias. Junto a El Abayarde, de Tego Calderón, del mismo año, se lo suele señalar como el primer disco de reggaetón que alcanzó al público masivo; y la estructura de canción y el modo de producir que trae se volvieron el estándar de casi todo lo que el género grabó después."}]},{"type":"paragraph","content":[{"type":"text","text":"Gasolina y el millón","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Al año siguiente produjeron «Gasolina» para Barrio Fino, de Daddy Yankee, y en esos mismos dos años trabajaron en The Last Don, de Don Omar; El Abayarde, de Tego Calderón; Los 12 Discípulos, de Eddie Dee; Diva, de Ivy Queen; Motivando a la Yal, de Zion & Lennox; Vida Escante, de Nicky Jam; y Los Bacatranes, de Trebol Clan. La Trayectoria y The Kings of the Beats son los dos de 2004."}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow 2 llegó en 2005 y pasó el millón de copias, cifra que casi nada en el género ha alcanzado. De él son «Rakata», «Mayor Que Yo», «Mírame» y «Te He Querido Te He Llorado». Mas Flow: Los Benjamins es de 2006, con «Noche de Entierro», y en esa misma etapa remezclaron «Call on Me», de Janet Jackson."}]},{"type":"paragraph","content":[{"type":"text","text":"Mas Flow como sello","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El nombre se volvió disquera. En su órbita trabajaron productores asistentes, Tainy entre ellos, y compartió artistas y catálogo con El Cartel Records: "},{"type":"artistReference","attrs":{"occurrenceId":"ef3c3c1a-8b2b-4d13-9f47-56f4da0bccad","artistId":"f6865535-50d6-46a2-991e-402a5f3b27d6","displayText":"DJ Urba"}},{"type":"text","text":" pasó los años de 2004 a 2010 entre los dos sellos, como mitad de Monserrate & DJ Urba. El dúo firmó a Erre XI en 2008 y a Dyland & Lenny en 2009, y siguió poniendo cantantes dominicanas en sus discos mucho después del auge: "},{"type":"artistReference","attrs":{"occurrenceId":"3b78eb14-a022-4a5a-b276-366c0660488d","artistId":"112ab16f-a56b-4a93-8562-120bfee1c70b","displayText":"Sharlene"}},{"type":"text","text":" aparece en un álbum suyo junto a Don Omar y Maluma en «La Fila»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Dos dominicanos salidos de una cocina de Massachusetts produjeron la década por la que se recuerda al reggaetón, en un género que se sigue catalogando como puertorriqueño. Lo que cambiaron en concreto es más estrecho y más fácil de señalar que eso: probaron que esa música aguantaba un disco entero, y después escribieron la plantilla que usaron los demás."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'luny-tunes'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published',
       revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'luny-tunes' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '248589b2-aaa7-4612-add5-1ab458c884a5', 'artist', 'e611e3fc-c00d-46e6-b397-27425787d6d1'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c7c0f159-5183-41c8-84b5-1a9a78db595e', 'artist', 'f78661d2-7e96-48b7-baf3-fd99a94d10e6'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ef3c3c1a-8b2b-4d13-9f47-56f4da0bccad', 'artist', 'f6865535-50d6-46a2-991e-402a5f3b27d6'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3b78eb14-a022-4a5a-b276-366c0660488d', 'artist', '112ab16f-a56b-4a93-8562-120bfee1c70b'
  FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'luny-tunes' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Luny Tunes es el dúo dominicano de productores que forman Luny —Francisco Saldaña— y Tunes —Víctor Cabrera—. Antes de ellos el reggaetón vivía en mixtapes y sencillos; lo que hicieron fue que funcionara como álbum, y la forma que le dieron a esos álbumes terminó siendo la forma del género. Trabajan desde 2000, con una pausa entre 2021 y 2023.

**La cocina de Harvard**

Saldaña y Cabrera se criaron en Lawrence, Massachusetts, y trabajaban en el comedor de Leverett House, en la Universidad de Harvard: uno cocinando y el otro lavando platos. Ninguno salió de la industria ni de un conservatorio; aprendieron a producir en sus propios equipos, después del turno. Ivy Queen fue la primera en grabar con ellos, y fue su trabajo en A La Reconquista, de Héctor & Tito, en 2002, el que llegó a DJ Nelson, que los firmó para Flow Music.

**Mas Flow, 2003**

Mas Flow salió el 26 de agosto de 2003, acreditado a Luny Tunes y Noriega y editado por Flow Music y VI Music, con DJ Nelson y Eliel también en la producción. Toda la música del disco es suya. La forma es de recopilatorio —veinte cortes, un vocalista distinto en casi cada uno—, pero armado por completo con material nuevo, y la nómina se lee como un censo del género en ese momento: Héctor & Tito, Wisin & Yandel, Don Omar, Tego Calderón, Daddy Yankee, Zion & Lennox, Trebol Clan, Baby Ranks, Nicky Jam, Plan B, Glory, Ángel & Khriz.

Llegó al número uno de las listas de Reggae Albums y Tropical Albums de Billboard y pasó el medio millón de copias. Junto a El Abayarde, de Tego Calderón, del mismo año, se lo suele señalar como el primer disco de reggaetón que alcanzó al público masivo; y la estructura de canción y el modo de producir que trae se volvieron el estándar de casi todo lo que el género grabó después.

**Gasolina y el millón**

Al año siguiente produjeron «Gasolina» para Barrio Fino, de Daddy Yankee, y en esos mismos dos años trabajaron en The Last Don, de Don Omar; El Abayarde, de Tego Calderón; Los 12 Discípulos, de Eddie Dee; Diva, de Ivy Queen; Motivando a la Yal, de Zion & Lennox; Vida Escante, de Nicky Jam; y Los Bacatranes, de Trebol Clan. La Trayectoria y The Kings of the Beats son los dos de 2004.

Mas Flow 2 llegó en 2005 y pasó el millón de copias, cifra que casi nada en el género ha alcanzado. De él son «Rakata», «Mayor Que Yo», «Mírame» y «Te He Querido Te He Llorado». Mas Flow: Los Benjamins es de 2006, con «Noche de Entierro», y en esa misma etapa remezclaron «Call on Me», de Janet Jackson.

**Mas Flow como sello**

El nombre se volvió disquera. En su órbita trabajaron productores asistentes, Tainy entre ellos, y compartió artistas y catálogo con El Cartel Records: DJ Urba pasó los años de 2004 a 2010 entre los dos sellos, como mitad de Monserrate & DJ Urba. El dúo firmó a Erre XI en 2008 y a Dyland & Lenny en 2009, y siguió poniendo cantantes dominicanas en sus discos mucho después del auge: Sharlene aparece en un álbum suyo junto a Don Omar y Maluma en «La Fila».

**Legado**

Dos dominicanos salidos de una cocina de Massachusetts produjeron la década por la que se recuerda al reggaetón, en un género que se sigue catalogando como puertorriqueño. Lo que cambiaron en concreto es más estrecho y más fácil de señalar que eso: probaron que esa música aguantaba un disco entero, y después escribieron la plantilla que usaron los demás.' WHERE slug = 'luny-tunes';

COMMIT;
