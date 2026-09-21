BEGIN;

-- Ficha de Gangrena Cerebral.
--
-- El relleno los llamaba punk y grindcore; Encyclopaedia Metallum, MusicBrainz y la banda
-- coinciden en death/thrash metal, formada en 2006. formation_year=2006.

UPDATE artists SET formation_year = 2006 WHERE slug = 'gangrena-cerebral';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Gangrena Cerebral —“Brain Gangrene”— is a Dominican death/thrash metal band formed in Santo Domingo in 2006, part of the capital’s extreme-metal underground."}]},{"type":"paragraph","content":[{"type":"text","text":"«Goecia Records» and the local scene","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Goecia Records» describes itself as the first independent label in Santo Domingo devoted solely to extreme metal, founded in 2004 by musicians from the local black and death metal scene. In June 2011 the label announced that it was adding Gangrena Cerebral, listed as death/thrash metal, to its roster alongside Vordavoss, and Encyclopaedia Metallum still lists Goecia as the band’s label."}]},{"type":"paragraph","content":[{"type":"text","text":"The lineup","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The band is built around Camilo Rijo Fulcar, on rhythm guitar and vocals, with Arturo Abreu on lead guitar, Guillermo Armenteros on bass and Mario Luis Ventura on drums; Habib Sucar (bass) and Irwin Abreu (drums) are listed as past members. Rijo Fulcar later studied classical guitar and started a nonprofit music school for people living on the streets of Santo Domingo, a project the newspaper Acento covered in 2016."}]},{"type":"paragraph","content":[{"type":"text","text":"«Sadismo Violencia y Perversion»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The band’s only listed release is the EP «Sadismo Violencia y Perversion», released on 4 May 2019 with five tracks: «Psicopata Homicida», «Violado Con Un Taladro», «Demonio Pederasta Con Sotana», «Ruta Del Tormento» and «Hepatocarcinoma». It was recorded in 2018 and 2019 at «Naowa Sonique» and «Ariel Sánchez Studios», engineered by Ariel Sánchez, produced by Guillermo Armenteros and Sánchez, and mastered by Brett Caldas Lima at «Towerstudio». The band describes it as extreme metal from the center of the Caribbean, telling grotesque, sadistic, violent and perverse stories that took place in the Dominican Republic."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Encyclopaedia Metallum lists Gangrena Cerebral as active, with the 2019 EP as its only release, and its members have also played in other Santo Domingo bands, among them Metalurgia, Kaostrophobia and Inner Vöid. Its work belongs to the small, locally organized circuit of Dominican extreme metal, far from the merengue and bachata industries."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'gangrena-cerebral'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'gangrena-cerebral' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Gangrena Cerebral —“Brain Gangrene”— is a Dominican death/thrash metal band formed in Santo Domingo in 2006, part of the capital’s extreme-metal underground.

**«Goecia Records» and the local scene**

«Goecia Records» describes itself as the first independent label in Santo Domingo devoted solely to extreme metal, founded in 2004 by musicians from the local black and death metal scene. In June 2011 the label announced that it was adding Gangrena Cerebral, listed as death/thrash metal, to its roster alongside Vordavoss, and Encyclopaedia Metallum still lists Goecia as the band’s label.

**The lineup**

The band is built around Camilo Rijo Fulcar, on rhythm guitar and vocals, with Arturo Abreu on lead guitar, Guillermo Armenteros on bass and Mario Luis Ventura on drums; Habib Sucar (bass) and Irwin Abreu (drums) are listed as past members. Rijo Fulcar later studied classical guitar and started a nonprofit music school for people living on the streets of Santo Domingo, a project the newspaper Acento covered in 2016.

**«Sadismo Violencia y Perversion»**

The band’s only listed release is the EP «Sadismo Violencia y Perversion», released on 4 May 2019 with five tracks: «Psicopata Homicida», «Violado Con Un Taladro», «Demonio Pederasta Con Sotana», «Ruta Del Tormento» and «Hepatocarcinoma». It was recorded in 2018 and 2019 at «Naowa Sonique» and «Ariel Sánchez Studios», engineered by Ariel Sánchez, produced by Guillermo Armenteros and Sánchez, and mastered by Brett Caldas Lima at «Towerstudio». The band describes it as extreme metal from the center of the Caribbean, telling grotesque, sadistic, violent and perverse stories that took place in the Dominican Republic.

**Legacy**

Encyclopaedia Metallum lists Gangrena Cerebral as active, with the 2019 EP as its only release, and its members have also played in other Santo Domingo bands, among them Metalurgia, Kaostrophobia and Inner Vöid. Its work belongs to the small, locally organized circuit of Dominican extreme metal, far from the merengue and bachata industries.' WHERE slug = 'gangrena-cerebral';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Gangrena Cerebral es una banda dominicana de death/thrash metal formada en Santo Domingo en 2006, parte del underground de metal extremo de la capital."}]},{"type":"paragraph","content":[{"type":"text","text":"«Goecia Records» y la escena local","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Goecia Records» se describe como el primer sello independiente de Santo Domingo dedicado solo al metal extremo, fundado en 2004 por músicos de la escena local de black y death metal. En junio de 2011 el sello anunció que sumaba a su nómina a Gangrena Cerebral, catalogada como death/thrash metal, junto a Vordavoss, y Encyclopaedia Metallum sigue listando a Goecia como su sello."}]},{"type":"paragraph","content":[{"type":"text","text":"La alineación","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La banda gira en torno a Camilo Rijo Fulcar, en guitarra rítmica y voz, con Arturo Abreu en guitarra líder, Guillermo Armenteros en el bajo y Mario Luis Ventura en la batería; Habib Sucar (bajo) e Irwin Abreu (batería) figuran como exintegrantes. Rijo Fulcar estudió después guitarra clásica y creó una escuela de música sin fines de lucro para personas que viven en las calles de Santo Domingo, proyecto que el periódico Acento recogió en 2016."}]},{"type":"paragraph","content":[{"type":"text","text":"«Sadismo Violencia y Perversion»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El único lanzamiento que se le conoce es el EP «Sadismo Violencia y Perversion», publicado el 4 de mayo de 2019 con cinco temas: «Psicopata Homicida», «Violado Con Un Taladro», «Demonio Pederasta Con Sotana», «Ruta Del Tormento» y «Hepatocarcinoma». Se grabó en 2018 y 2019 en «Naowa Sonique» y «Ariel Sánchez Studios», con ingeniería de Ariel Sánchez, producción de Guillermo Armenteros y Sánchez, y masterización de Brett Caldas Lima en «Towerstudio». La banda lo describe como metal extremo desde el centro del Caribe, con historias grotescas, sádicas, violentas y perversas ocurridas en República Dominicana."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Encyclopaedia Metallum registra a Gangrena Cerebral como activa, con el EP de 2019 como único lanzamiento, y sus integrantes han tocado también en otras bandas de Santo Domingo, entre ellas Metalurgia, Kaostrophobia e Inner Vöid. Su obra pertenece al pequeño circuito, organizado localmente, del metal extremo dominicano, lejos de las industrias del merengue y la bachata."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'gangrena-cerebral'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'gangrena-cerebral' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Gangrena Cerebral es una banda dominicana de death/thrash metal formada en Santo Domingo en 2006, parte del underground de metal extremo de la capital.

**«Goecia Records» y la escena local**

«Goecia Records» se describe como el primer sello independiente de Santo Domingo dedicado solo al metal extremo, fundado en 2004 por músicos de la escena local de black y death metal. En junio de 2011 el sello anunció que sumaba a su nómina a Gangrena Cerebral, catalogada como death/thrash metal, junto a Vordavoss, y Encyclopaedia Metallum sigue listando a Goecia como su sello.

**La alineación**

La banda gira en torno a Camilo Rijo Fulcar, en guitarra rítmica y voz, con Arturo Abreu en guitarra líder, Guillermo Armenteros en el bajo y Mario Luis Ventura en la batería; Habib Sucar (bajo) e Irwin Abreu (batería) figuran como exintegrantes. Rijo Fulcar estudió después guitarra clásica y creó una escuela de música sin fines de lucro para personas que viven en las calles de Santo Domingo, proyecto que el periódico Acento recogió en 2016.

**«Sadismo Violencia y Perversion»**

El único lanzamiento que se le conoce es el EP «Sadismo Violencia y Perversion», publicado el 4 de mayo de 2019 con cinco temas: «Psicopata Homicida», «Violado Con Un Taladro», «Demonio Pederasta Con Sotana», «Ruta Del Tormento» y «Hepatocarcinoma». Se grabó en 2018 y 2019 en «Naowa Sonique» y «Ariel Sánchez Studios», con ingeniería de Ariel Sánchez, producción de Guillermo Armenteros y Sánchez, y masterización de Brett Caldas Lima en «Towerstudio». La banda lo describe como metal extremo desde el centro del Caribe, con historias grotescas, sádicas, violentas y perversas ocurridas en República Dominicana.

**Legado**

Encyclopaedia Metallum registra a Gangrena Cerebral como activa, con el EP de 2019 como único lanzamiento, y sus integrantes han tocado también en otras bandas de Santo Domingo, entre ellas Metalurgia, Kaostrophobia e Inner Vöid. Su obra pertenece al pequeño circuito, organizado localmente, del metal extremo dominicano, lejos de las industrias del merengue y la bachata.' WHERE slug = 'gangrena-cerebral';

COMMIT;
