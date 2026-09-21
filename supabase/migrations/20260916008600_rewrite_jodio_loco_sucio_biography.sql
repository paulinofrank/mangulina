BEGIN;

-- Jodío Loco Sucio (JLS): trío de hard rock y metal fundado por Leo Susana; grabó tres álbumes en 1997, 2001 y 2003 y hoy está basado en Zaragoza. La ficha solo tenía una frase vacía. Fuentes: la página de la banda en el sitio de Leo Susana (formaciones, estudios, canciones, alineación actual), Bandcamp (trío desde Santo Domingo, fundado y dirigido por Leo Susana, nativo de Nueva York, basado en Zaragoza), Enciclopedia Rock Dominicano en Facebook (formada en 1991 con su primo Máximo Gómez, ambos de Toque Profundo), EcuRed (Leo Susana), Amazon (Crudo (Live), 20 nov. 2007), Spotify (Serpiente en el huerto 2000). Conflicto: fundación 1991 (Enciclopedia Rock Dominicano) frente a 1992 (espejo de Wikipedia); Serpiente en el huerto 2001 (web de la banda) frente a 2000 (Spotify). Campos: birth_year 1991. La biografía es en gran parte la propia de la banda: el texto la atribuye. Sin cifras vivas.

UPDATE artists SET birth_year = 1991 WHERE slug = 'jodio-loco-sucio';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jodío Loco Sucio, known as JLS, is a Dominican hard rock and metal power trio founded by the guitarist and singer Leo Susana, a New York native, in Santo Domingo. It is now based in Zaragoza, Spain."}]},{"type":"paragraph","content":[{"type":"text","text":"Formation","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"According to a page of a Dominican rock encyclopedia, Susana left the band "},{"type":"artistReference","attrs":{"occurrenceId":"085c9ed2-51e8-40b9-b7e4-309edd3a71b9","artistId":"0a43fb92-e8f1-4413-b054-2aa46319385b","displayText":"Toque Profundo"}},{"type":"text","text":" at the end of the 1980s and in 1991 teamed up with his cousin Máximo Gómez, who also came from that band. Other sources give the founding year as 1992."}]},{"type":"paragraph","content":[{"type":"text","text":"Albums","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The band’s own biography lists three albums of hard rock and metal, each with a different lineup. «Testigos de la historia» (1997) was recorded at Midilab Studios with Leo Susana on guitar and vocals, Miguel Gómez on bass and Luinis Quezada on drums, and it contains «Enemigo de la sociedad», «Patra», «Dame tu sexo» and «Me da la gana». «Serpiente en el huerto» (2001, dated 2000 on streaming platforms) was recorded at Big House Studios in New York with Guy Frometa and Peter Nova as rhythm section, and includes «Diputado Man», «Privilegio es vivir (en una democrac.i.a.)» and «El rey del mosh». «Un año de odio, un siglo de miedo» (2003), described as its heaviest album, brought Quezada back and added drums by Gigi Cano, with tracks such as «Ah, los dictadores» and «Frío metal». A live album, «Crudo (Live)», appeared in November 2007, and the band released «Pa’lante» in 2024."}]},{"type":"paragraph","content":[{"type":"text","text":"Present lineup","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The current lineup, based in Zaragoza, is Leo Susana on guitar and vocals, Gigi Cano on drums and Marce Marco on bass."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The band’s own biography describes «Enemigo de la sociedad», «Patra», «Dame tu sexo» and «Me da la gana» as classics of the Dominican rock scene."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jodio-loco-sucio'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jodio-loco-sucio' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '085c9ed2-51e8-40b9-b7e4-309edd3a71b9', 'artist', '0a43fb92-e8f1-4413-b054-2aa46319385b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jodio-loco-sucio' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Jodío Loco Sucio, known as JLS, is a Dominican hard rock and metal power trio founded by the guitarist and singer Leo Susana, a New York native, in Santo Domingo. It is now based in Zaragoza, Spain.

**Formation**

According to a page of a Dominican rock encyclopedia, Susana left the band Toque Profundo at the end of the 1980s and in 1991 teamed up with his cousin Máximo Gómez, who also came from that band. Other sources give the founding year as 1992.

**Albums**

The band’s own biography lists three albums of hard rock and metal, each with a different lineup. «Testigos de la historia» (1997) was recorded at Midilab Studios with Leo Susana on guitar and vocals, Miguel Gómez on bass and Luinis Quezada on drums, and it contains «Enemigo de la sociedad», «Patra», «Dame tu sexo» and «Me da la gana». «Serpiente en el huerto» (2001, dated 2000 on streaming platforms) was recorded at Big House Studios in New York with Guy Frometa and Peter Nova as rhythm section, and includes «Diputado Man», «Privilegio es vivir (en una democrac.i.a.)» and «El rey del mosh». «Un año de odio, un siglo de miedo» (2003), described as its heaviest album, brought Quezada back and added drums by Gigi Cano, with tracks such as «Ah, los dictadores» and «Frío metal». A live album, «Crudo (Live)», appeared in November 2007, and the band released «Pa’lante» in 2024.

**Present lineup**

The current lineup, based in Zaragoza, is Leo Susana on guitar and vocals, Gigi Cano on drums and Marce Marco on bass.

**Legacy**

The band’s own biography describes «Enemigo de la sociedad», «Patra», «Dame tu sexo» and «Me da la gana» as classics of the Dominican rock scene.' WHERE slug = 'jodio-loco-sucio';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jodío Loco Sucio, conocido como JLS, es un trío dominicano de hard rock y metal fundado en Santo Domingo por el guitarrista y cantante Leo Susana, nativo de Nueva York. Hoy está basado en Zaragoza, España."}]},{"type":"paragraph","content":[{"type":"text","text":"Formación","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Según una página de una enciclopedia del rock dominicano, Susana dejó la banda "},{"type":"artistReference","attrs":{"occurrenceId":"07c5aa14-ba65-4548-b4c1-f6ab0a3aeb46","artistId":"0a43fb92-e8f1-4413-b054-2aa46319385b","displayText":"Toque Profundo"}},{"type":"text","text":" a finales de los años ochenta y en 1991 se asoció con su primo Máximo Gómez, que también venía de esa banda. Otras fuentes dan 1992 como año de fundación."}]},{"type":"paragraph","content":[{"type":"text","text":"Discos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La propia biografía de la banda enumera tres álbumes de hard rock y metal, cada uno con una alineación distinta. «Testigos de la historia» (1997) se grabó en Midilab Studios con Leo Susana en la guitarra y la voz, Miguel Gómez en el bajo y Luinis Quezada en la batería, y contiene «Enemigo de la sociedad», «Patra», «Dame tu sexo» y «Me da la gana». «Serpiente en el huerto» (2001, fechado en 2000 en las plataformas) se grabó en Big House Studios de Nueva York con Guy Frometa y Peter Nova como sección rítmica, e incluye «Diputado Man», «Privilegio es vivir (en una democrac.i.a.)» y «El rey del mosh». «Un año de odio, un siglo de miedo» (2003), descrito como su álbum más pesado, hizo volver a Quezada y sumó baterías de Gigi Cano, con temas como «Ah, los dictadores» y «Frío metal». Un álbum en vivo, «Crudo (Live)», salió en noviembre de 2007, y en 2024 la banda publicó «Pa’lante»."}]},{"type":"paragraph","content":[{"type":"text","text":"Alineación actual","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La alineación actual, con sede en Zaragoza, es Leo Susana en la guitarra y la voz, Gigi Cano en la batería y Marce Marco en el bajo."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La propia biografía de la banda describe «Enemigo de la sociedad», «Patra», «Dame tu sexo» y «Me da la gana» como clásicos de la escena rock dominicana."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jodio-loco-sucio'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jodio-loco-sucio' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '07c5aa14-ba65-4548-b4c1-f6ab0a3aeb46', 'artist', '0a43fb92-e8f1-4413-b054-2aa46319385b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jodio-loco-sucio' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Jodío Loco Sucio, conocido como JLS, es un trío dominicano de hard rock y metal fundado en Santo Domingo por el guitarrista y cantante Leo Susana, nativo de Nueva York. Hoy está basado en Zaragoza, España.

**Formación**

Según una página de una enciclopedia del rock dominicano, Susana dejó la banda Toque Profundo a finales de los años ochenta y en 1991 se asoció con su primo Máximo Gómez, que también venía de esa banda. Otras fuentes dan 1992 como año de fundación.

**Discos**

La propia biografía de la banda enumera tres álbumes de hard rock y metal, cada uno con una alineación distinta. «Testigos de la historia» (1997) se grabó en Midilab Studios con Leo Susana en la guitarra y la voz, Miguel Gómez en el bajo y Luinis Quezada en la batería, y contiene «Enemigo de la sociedad», «Patra», «Dame tu sexo» y «Me da la gana». «Serpiente en el huerto» (2001, fechado en 2000 en las plataformas) se grabó en Big House Studios de Nueva York con Guy Frometa y Peter Nova como sección rítmica, e incluye «Diputado Man», «Privilegio es vivir (en una democrac.i.a.)» y «El rey del mosh». «Un año de odio, un siglo de miedo» (2003), descrito como su álbum más pesado, hizo volver a Quezada y sumó baterías de Gigi Cano, con temas como «Ah, los dictadores» y «Frío metal». Un álbum en vivo, «Crudo (Live)», salió en noviembre de 2007, y en 2024 la banda publicó «Pa’lante».

**Alineación actual**

La alineación actual, con sede en Zaragoza, es Leo Susana en la guitarra y la voz, Gigi Cano en la batería y Marce Marco en el bajo.

**Legado**

La propia biografía de la banda describe «Enemigo de la sociedad», «Patra», «Dame tu sexo» y «Me da la gana» como clásicos de la escena rock dominicana.' WHERE slug = 'jodio-loco-sucio';

COMMIT;
