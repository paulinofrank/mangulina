BEGIN;

-- Ficha de Grupo Extra.
--
-- La biografía de relleno eran dos frases genéricas sin nombrar canción, integrante ni
-- colaboración. Se registra su nominación a Premios Soberano 2026 (categoría Artista y/o
-- Agrupación Residente en el Extranjero); las afirmaciones sin fecha ni fuente verificable
-- de musica.com (colaboraciones con Aventura/Romeo Santos, premios Lo Nuestro/Billboard/
-- Grammy) no se adoptaron.

INSERT INTO award_categories (award_id, name)
SELECT id, 'Artista y/o Agrupación Residente en el Extranjero' FROM awards WHERE name = 'Premios Soberano'
  AND NOT EXISTS (SELECT 1 FROM award_categories WHERE award_id = awards.id AND name = 'Artista y/o Agrupación Residente en el Extranjero');
INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT a.id, aw.id, ac.id, 2026, NULL, false,
  'El Día, Hoy Digital, El Nuevo Diario, Listín Diario y lanaciondigital.com.do, todos confirmando la lista de nominados a Premios Soberano 2026'
FROM artists a, awards aw, award_categories ac
WHERE a.slug = 'grupo-extra' AND aw.name = 'Premios Soberano' AND ac.award_id = aw.id AND ac.name = 'Artista y/o Agrupación Residente en el Extranjero';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Grupo Extra is a Dominican bachata band founded by Robert Encarnación and Tony Santana (stage name of Edward Regalado), built a run of dancefloor hits in the 2010s, and has since become one of the genre’s most consistent touring acts in Europe."}]},{"type":"paragraph","content":[{"type":"text","text":"Origins","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Encarnación, who grew up in Santo Domingo’s Capotillo neighborhood by his own account, co-founded the group with Santana with the goal of pushing romantic bachata toward a more contemporary, pop-inflected sound without abandoning the genre’s guitar core."}]},{"type":"paragraph","content":[{"type":"text","text":"Breakthrough hits","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The band built its following through a run of radio and video hits — «Te Vas», «Quisiera Llorar» (2011), «No Sé Cómo Me Enamoré», «Te Amo Tanto», «Sin Ti», «Si Fueras Mía» and «Corazón Culpable» (2014) among them — establishing a sound built on close vocal harmony and a more urban-leaning bachata arrangement."}]},{"type":"paragraph","content":[{"type":"text","text":"International reach","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2015 the group recorded an official bachata remix of Pitbull’s «When I’m with You», produced by Moisés Sánchez, and has since built a particularly strong following in Europe. Now led by Fidel Pérez, the band released the single «Dime lo que te pasó» in February 2026, written by Santana and Oswaldy «Oxu» Díaz — the same month it earned its third career nomination for Premios Soberano, in the category for Dominican artists based abroad."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"More than two decades after its founding, Grupo Extra remains a working example of bachata’s reach beyond the island, still recording new material and still drawing crowds from Santo Domingo to the European circuit that has become its second home."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'grupo-extra'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'grupo-extra' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Grupo Extra is a Dominican bachata band founded by Robert Encarnación and Tony Santana (stage name of Edward Regalado), built a run of dancefloor hits in the 2010s, and has since become one of the genre’s most consistent touring acts in Europe.

**Origins**

Encarnación, who grew up in Santo Domingo’s Capotillo neighborhood by his own account, co-founded the group with Santana with the goal of pushing romantic bachata toward a more contemporary, pop-inflected sound without abandoning the genre’s guitar core.

**Breakthrough hits**

The band built its following through a run of radio and video hits — «Te Vas», «Quisiera Llorar» (2011), «No Sé Cómo Me Enamoré», «Te Amo Tanto», «Sin Ti», «Si Fueras Mía» and «Corazón Culpable» (2014) among them — establishing a sound built on close vocal harmony and a more urban-leaning bachata arrangement.

**International reach**

In 2015 the group recorded an official bachata remix of Pitbull’s «When I’m with You», produced by Moisés Sánchez, and has since built a particularly strong following in Europe. Now led by Fidel Pérez, the band released the single «Dime lo que te pasó» in February 2026, written by Santana and Oswaldy «Oxu» Díaz — the same month it earned its third career nomination for Premios Soberano, in the category for Dominican artists based abroad.

**Legacy**

More than two decades after its founding, Grupo Extra remains a working example of bachata’s reach beyond the island, still recording new material and still drawing crowds from Santo Domingo to the European circuit that has become its second home.' WHERE slug = 'grupo-extra';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Grupo Extra es una agrupación dominicana de bachata fundada por Robert Encarnación y Tony Santana (nombre artístico de Edward Regalado), que construyó una racha de éxitos bailables en la década de 2010 y se ha convertido desde entonces en una de las bandas de gira más constantes del género en Europa."}]},{"type":"paragraph","content":[{"type":"text","text":"Orígenes","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Encarnación, criado según su propio testimonio en el barrio Capotillo de Santo Domingo, cofundó el grupo junto a Santana con el propósito de llevar la bachata romántica hacia un sonido más contemporáneo y con matices pop, sin abandonar la base de guitarras del género."}]},{"type":"paragraph","content":[{"type":"text","text":"Éxitos que los dieron a conocer","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La banda construyó su público con una serie de éxitos radiales y en video —entre ellos «Te Vas», «Quisiera Llorar» (2011), «No Sé Cómo Me Enamoré», «Te Amo Tanto», «Sin Ti», «Si Fueras Mía» y «Corazón Culpable» (2014)— con un sonido basado en la armonía vocal cercana y un arreglo de bachata con más inclinación urbana."}]},{"type":"paragraph","content":[{"type":"text","text":"Proyección internacional","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2015 el grupo grabó el remix oficial en bachata de «When I’m with You» de Pitbull, producido por Moisés Sánchez, y desde entonces ha construido un público particularmente fuerte en Europa. Ya bajo el liderazgo de Fidel Pérez, la banda lanzó el sencillo «Dime lo que te pasó» en febrero de 2026, escrito por Santana y Oswaldy «Oxu» Díaz —el mismo mes en que obtuvo su tercera nominación de carrera a los Premios Soberano, en la categoría de artistas dominicanos residentes en el extranjero."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Más de dos décadas después de su fundación, Grupo Extra sigue siendo un ejemplo en activo del alcance de la bachata fuera de la isla, todavía grabando material nuevo y todavía convocando público desde Santo Domingo hasta el circuito europeo que se ha convertido en su segunda casa."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'grupo-extra'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'grupo-extra' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Grupo Extra es una agrupación dominicana de bachata fundada por Robert Encarnación y Tony Santana (nombre artístico de Edward Regalado), que construyó una racha de éxitos bailables en la década de 2010 y se ha convertido desde entonces en una de las bandas de gira más constantes del género en Europa.

**Orígenes**

Encarnación, criado según su propio testimonio en el barrio Capotillo de Santo Domingo, cofundó el grupo junto a Santana con el propósito de llevar la bachata romántica hacia un sonido más contemporáneo y con matices pop, sin abandonar la base de guitarras del género.

**Éxitos que los dieron a conocer**

La banda construyó su público con una serie de éxitos radiales y en video —entre ellos «Te Vas», «Quisiera Llorar» (2011), «No Sé Cómo Me Enamoré», «Te Amo Tanto», «Sin Ti», «Si Fueras Mía» y «Corazón Culpable» (2014)— con un sonido basado en la armonía vocal cercana y un arreglo de bachata con más inclinación urbana.

**Proyección internacional**

En 2015 el grupo grabó el remix oficial en bachata de «When I’m with You» de Pitbull, producido por Moisés Sánchez, y desde entonces ha construido un público particularmente fuerte en Europa. Ya bajo el liderazgo de Fidel Pérez, la banda lanzó el sencillo «Dime lo que te pasó» en febrero de 2026, escrito por Santana y Oswaldy «Oxu» Díaz —el mismo mes en que obtuvo su tercera nominación de carrera a los Premios Soberano, en la categoría de artistas dominicanos residentes en el extranjero.

**Legado**

Más de dos décadas después de su fundación, Grupo Extra sigue siendo un ejemplo en activo del alcance de la bachata fuera de la isla, todavía grabando material nuevo y todavía convocando público desde Santo Domingo hasta el circuito europeo que se ha convertido en su segunda casa.' WHERE slug = 'grupo-extra';

COMMIT;
