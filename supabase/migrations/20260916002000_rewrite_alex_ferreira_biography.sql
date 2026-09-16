BEGIN;

-- Ficha de Alex Ferreira.
--
-- La biografía de relleno era completamente genérica, sin nombrar disco, sello ni hecho real
-- de su carrera como cantautor independiente con trayectoria internacional en España y
-- México, incluyendo una nominación al Latin Grammy 2018.
-- first_name/middle_name/second_last_name añadidos/corregidos (Alexandre Santiago Ferreira
-- Peguero). occupations ampliado con engineer.

UPDATE artists SET first_name = 'Alexandre', middle_name = 'Santiago', second_last_name = 'Peguero',
       occupations = '["songwriter","producer","guitarist","engineer"]'::jsonb
       WHERE slug = 'alex-ferreira';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Alex Ferreira —full name Alexandre Santiago Ferreira Peguero, born in Santo Domingo on 23 March 1983— is a Dominican-Spanish singer-songwriter, producer and sound engineer whose independent pop-rock career has taken him from Madrid to Mexico City, earning a nomination for Best New Artist at the 2018 Latin Grammy Awards."}]},{"type":"paragraph","content":[{"type":"text","text":"From Santo Domingo to Madrid, with no return ticket","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He moved to the United States with his mother as a young child, spending his childhood and adolescence there, before relocating to Spain and settling in Madrid to study sound engineering while building a music career, working his way from central bars to larger venues. His earliest Dominican releases — the EP «Resplandor» (2003) and the 250-copy album «Parto Mi Viaje» (2005) — were known only to fans back home before he left the country with no ticket back."}]},{"type":"paragraph","content":[{"type":"text","text":"A Spanish recording career","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2006 he signed a publishing deal with EMI Music Publishing Spain, releasing the acoustic EP «Un Domingo Cualquiera» (2007), and in 2008 a recording contract with Warner/DRO Music Spain, which released his EP «Serenata de Plástico»; that year Casa América and the magazine Fusión Latina named him among the 100 most influential Latinos of 2008. A further EP, «Páginas», followed in 2009, and in January 2010 his first full-length international album, also titled «Un Domingo Cualquiera», was praised by Spain’s Radio 3 as one of the year’s most anticipated releases and reached the top of the sales chart at Madrid’s Fnac Callao in its first week."}]},{"type":"paragraph","content":[{"type":"text","text":"Mexico City, and «Canapé»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"After touring Mexico and the United States, Ferreira relocated to Mexico City, where he reconnected with his Dominican roots and his New York childhood. His second album, «El Afán», appeared in 2012, followed by the more electronic «Cinema Tropical» (2015) and, in 2017, the crowdfunded «Canapé», which he described as a synthesis of his Afro-Antillean roots in bachata and merengue alongside his love of rock, pop and electronic music — proud, in his own words, to be a fan of both "},{"type":"artistReference","attrs":{"occurrenceId":"e5668e6a-c03b-47a1-ab33-8c468e552b18","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":" and Björk."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ferreira’s 2018 Latin Grammy nomination for Best New Artist followed, and he has continued releasing music with «Tanda» (2021) and «Versiones Para el Tiempo y la Distancia» (2024). He holds Dominican and Spanish citizenship and has a daughter, Uma Ferreira Moreno."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alex-ferreira'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'alex-ferreira' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'e5668e6a-c03b-47a1-ab33-8c468e552b18', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'alex-ferreira' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Alex Ferreira —full name Alexandre Santiago Ferreira Peguero, born in Santo Domingo on 23 March 1983— is a Dominican-Spanish singer-songwriter, producer and sound engineer whose independent pop-rock career has taken him from Madrid to Mexico City, earning a nomination for Best New Artist at the 2018 Latin Grammy Awards.

**From Santo Domingo to Madrid, with no return ticket**

He moved to the United States with his mother as a young child, spending his childhood and adolescence there, before relocating to Spain and settling in Madrid to study sound engineering while building a music career, working his way from central bars to larger venues. His earliest Dominican releases — the EP «Resplandor» (2003) and the 250-copy album «Parto Mi Viaje» (2005) — were known only to fans back home before he left the country with no ticket back.

**A Spanish recording career**

In 2006 he signed a publishing deal with EMI Music Publishing Spain, releasing the acoustic EP «Un Domingo Cualquiera» (2007), and in 2008 a recording contract with Warner/DRO Music Spain, which released his EP «Serenata de Plástico»; that year Casa América and the magazine Fusión Latina named him among the 100 most influential Latinos of 2008. A further EP, «Páginas», followed in 2009, and in January 2010 his first full-length international album, also titled «Un Domingo Cualquiera», was praised by Spain’s Radio 3 as one of the year’s most anticipated releases and reached the top of the sales chart at Madrid’s Fnac Callao in its first week.

**Mexico City, and «Canapé»**

After touring Mexico and the United States, Ferreira relocated to Mexico City, where he reconnected with his Dominican roots and his New York childhood. His second album, «El Afán», appeared in 2012, followed by the more electronic «Cinema Tropical» (2015) and, in 2017, the crowdfunded «Canapé», which he described as a synthesis of his Afro-Antillean roots in bachata and merengue alongside his love of rock, pop and electronic music — proud, in his own words, to be a fan of both Juan Luis Guerra 4.40 and Björk.

**Legacy**

Ferreira’s 2018 Latin Grammy nomination for Best New Artist followed, and he has continued releasing music with «Tanda» (2021) and «Versiones Para el Tiempo y la Distancia» (2024). He holds Dominican and Spanish citizenship and has a daughter, Uma Ferreira Moreno.' WHERE slug = 'alex-ferreira';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Alex Ferreira —nombre completo Alexandre Santiago Ferreira Peguero, nacido en Santo Domingo el 23 de marzo de 1983— es cantautor, productor e ingeniero de sonido dominico-español, cuya carrera independiente de pop-rock lo ha llevado de Madrid a Ciudad de México, ganándole una nominación a Mejor Nuevo Artista en los Latin Grammy de 2018."}]},{"type":"paragraph","content":[{"type":"text","text":"De Santo Domingo a Madrid, sin billete de regreso","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Se trasladó a Estados Unidos con su madre siendo niño, pasando allí su infancia y adolescencia, antes de mudarse a España e instalarse en Madrid para estudiar Ingeniería de Sonido mientras construía una carrera musical, tocando primero en bares del centro y después en salas más grandes. Sus primeros lanzamientos dominicanos —el EP «Resplandor» (2003) y el disco de 250 copias «Parto Mi Viaje» (2005)— solo eran conocidos por fanáticos en su país natal antes de que se fuera sin billete de vuelta."}]},{"type":"paragraph","content":[{"type":"text","text":"Una carrera discográfica española","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2006 firmó un contrato editorial con EMI Music Publishing Spain, publicando el EP acústico «Un Domingo Cualquiera» (2007), y en 2008 un contrato discográfico con Warner/DRO Music Spain, que publicó su EP «Serenata de Plástico»; ese año Casa América y la revista Fusión Latina lo incluyeron entre los 100 latinos más influyentes de 2008. Le siguió otro EP, «Páginas», en 2009, y en enero de 2010 su primer disco internacional de larga duración, también titulado «Un Domingo Cualquiera», que Radio 3 de España calificó como uno de los discos más esperados del año y que llegó al primer puesto en ventas de la Fnac Callao de Madrid en su primera semana."}]},{"type":"paragraph","content":[{"type":"text","text":"Ciudad de México, y «Canapé»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Tras girar por México y Estados Unidos, Ferreira se trasladó a Ciudad de México, donde se reconectó con sus raíces dominicanas y su infancia neoyorquina. Su segundo álbum, «El Afán», apareció en 2012, seguido del más electrónico «Cinema Tropical» (2015) y, en 2017, del financiado por sus seguidores «Canapé», que describió como una síntesis de sus raíces afroantillanas en bachata y merengue junto a su gusto por el rock, el pop y la música electrónica —orgulloso, en sus propias palabras, de ser fan tanto de "},{"type":"artistReference","attrs":{"occurrenceId":"6d5c2602-bbb2-4406-8a14-c879206e6d72","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra 4.40"}},{"type":"text","text":" como de Björk."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Le siguió su nominación a Mejor Nuevo Artista en los Latin Grammy de 2018, y ha continuado publicando música con «Tanda» (2021) y «Versiones Para el Tiempo y la Distancia» (2024). Tiene nacionalidad dominicana y española, y una hija, Uma Ferreira Moreno."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alex-ferreira'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'alex-ferreira' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '6d5c2602-bbb2-4406-8a14-c879206e6d72', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'alex-ferreira' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Alex Ferreira —nombre completo Alexandre Santiago Ferreira Peguero, nacido en Santo Domingo el 23 de marzo de 1983— es cantautor, productor e ingeniero de sonido dominico-español, cuya carrera independiente de pop-rock lo ha llevado de Madrid a Ciudad de México, ganándole una nominación a Mejor Nuevo Artista en los Latin Grammy de 2018.

**De Santo Domingo a Madrid, sin billete de regreso**

Se trasladó a Estados Unidos con su madre siendo niño, pasando allí su infancia y adolescencia, antes de mudarse a España e instalarse en Madrid para estudiar Ingeniería de Sonido mientras construía una carrera musical, tocando primero en bares del centro y después en salas más grandes. Sus primeros lanzamientos dominicanos —el EP «Resplandor» (2003) y el disco de 250 copias «Parto Mi Viaje» (2005)— solo eran conocidos por fanáticos en su país natal antes de que se fuera sin billete de vuelta.

**Una carrera discográfica española**

En 2006 firmó un contrato editorial con EMI Music Publishing Spain, publicando el EP acústico «Un Domingo Cualquiera» (2007), y en 2008 un contrato discográfico con Warner/DRO Music Spain, que publicó su EP «Serenata de Plástico»; ese año Casa América y la revista Fusión Latina lo incluyeron entre los 100 latinos más influyentes de 2008. Le siguió otro EP, «Páginas», en 2009, y en enero de 2010 su primer disco internacional de larga duración, también titulado «Un Domingo Cualquiera», que Radio 3 de España calificó como uno de los discos más esperados del año y que llegó al primer puesto en ventas de la Fnac Callao de Madrid en su primera semana.

**Ciudad de México, y «Canapé»**

Tras girar por México y Estados Unidos, Ferreira se trasladó a Ciudad de México, donde se reconectó con sus raíces dominicanas y su infancia neoyorquina. Su segundo álbum, «El Afán», apareció en 2012, seguido del más electrónico «Cinema Tropical» (2015) y, en 2017, del financiado por sus seguidores «Canapé», que describió como una síntesis de sus raíces afroantillanas en bachata y merengue junto a su gusto por el rock, el pop y la música electrónica —orgulloso, en sus propias palabras, de ser fan tanto de Juan Luis Guerra 4.40 como de Björk.

**Legado**

Le siguió su nominación a Mejor Nuevo Artista en los Latin Grammy de 2018, y ha continuado publicando música con «Tanda» (2021) y «Versiones Para el Tiempo y la Distancia» (2024). Tiene nacionalidad dominicana y española, y una hija, Uma Ferreira Moreno.' WHERE slug = 'alex-ferreira';

COMMIT;
