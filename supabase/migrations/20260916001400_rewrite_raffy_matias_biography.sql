BEGIN;

-- Ficha de Raffy Matías.
--
-- La biografía de relleno era completamente genérica, sin nombrar canción, agrupación ni
-- hecho real de su carrera.
-- first_name/middle_name/last_name/second_last_name/stage_name y gender añadidos (todos
-- vacíos en la fila). occupations y genres ampliados.

UPDATE artists SET first_name = 'Rafael', middle_name = 'Enrique',
       last_name = 'Matías', second_last_name = 'Rodríguez', stage_name = 'Raffy Matías',
       gender = 'male', occupations = '["composer","producer"]'::jsonb, genres = ARRAY['bachata']::text[]
       WHERE slug = 'raffy-matias';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Raffy Matías —full name Rafael Enrique Matías Rodríguez, born in Jarabacoa on 26 September 1969, died there on 2 October 2024— was a Dominican merengue and bachata singer, composer and producer nicknamed «la voz más dulce del merengue», the sweetest voice in merengue."}]},{"type":"paragraph","content":[{"type":"text","text":"From «Hermanos en la Vía» to «ROL»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He studied piano from a young age and joined the group «Hermanos en la Vía» before forming «ROL» with fellow musicians Olvi and Ludwig, the group’s name taken from their initials. Touring under that name won him recognition in La Vega, Jarabacoa, Santiago and other towns across the Cibao."}]},{"type":"paragraph","content":[{"type":"text","text":"A producer, and a signature sound","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1995 he met the producer Julio Sosa, with whom he recorded his first productions, «Acúsame», «Con Altura», «Volando Alto» and «Bachata de Etiqueta». His best-known songs, «Quiero Saber de Ti», «Amor Ayúdame» and «Ahora Que Te Vas», carried his career across the region in the years that followed."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Illness kept Matías off stage in his final months, during which he publicly asked the Dominican government for a pension to help cover his medical costs. He died at his home in Jarabacoa on 2 October 2024 from pulmonary, gastric and colon complications, and the city’s municipal council declared three days of mourning."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'raffy-matias'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'raffy-matias' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Raffy Matías —full name Rafael Enrique Matías Rodríguez, born in Jarabacoa on 26 September 1969, died there on 2 October 2024— was a Dominican merengue and bachata singer, composer and producer nicknamed «la voz más dulce del merengue», the sweetest voice in merengue.

**From «Hermanos en la Vía» to «ROL»**

He studied piano from a young age and joined the group «Hermanos en la Vía» before forming «ROL» with fellow musicians Olvi and Ludwig, the group’s name taken from their initials. Touring under that name won him recognition in La Vega, Jarabacoa, Santiago and other towns across the Cibao.

**A producer, and a signature sound**

In 1995 he met the producer Julio Sosa, with whom he recorded his first productions, «Acúsame», «Con Altura», «Volando Alto» and «Bachata de Etiqueta». His best-known songs, «Quiero Saber de Ti», «Amor Ayúdame» and «Ahora Que Te Vas», carried his career across the region in the years that followed.

**Legacy**

Illness kept Matías off stage in his final months, during which he publicly asked the Dominican government for a pension to help cover his medical costs. He died at his home in Jarabacoa on 2 October 2024 from pulmonary, gastric and colon complications, and the city’s municipal council declared three days of mourning.' WHERE slug = 'raffy-matias';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Raffy Matías —nombre completo Rafael Enrique Matías Rodríguez, nacido en Jarabacoa el 26 de septiembre de 1969, fallecido en la misma ciudad el 2 de octubre de 2024— fue cantante, compositor y productor dominicano de merengue y bachata, apodado «la voz más dulce del merengue»."}]},{"type":"paragraph","content":[{"type":"text","text":"De «Hermanos en la Vía» a «ROL»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Estudió piano desde joven e integró el grupo «Hermanos en la Vía» antes de formar «ROL» junto a los músicos Olvi y Ludwig, nombre del grupo tomado de sus iniciales. Con esa agrupación ganó reconocimiento en La Vega, Jarabacoa, Santiago y otras ciudades del Cibao."}]},{"type":"paragraph","content":[{"type":"text","text":"Un productor, y un sonido propio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1995 conoció al productor Julio Sosa, con quien grabó sus primeras producciones, «Acúsame», «Con Altura», «Volando Alto» y «Bachata de Etiqueta». Sus canciones más conocidas, «Quiero Saber de Ti», «Amor Ayúdame» y «Ahora Que Te Vas», llevaron su carrera por toda la región en los años siguientes."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La enfermedad mantuvo a Matías alejado de los escenarios en sus últimos meses, durante los cuales pidió públicamente al gobierno dominicano una pensión que le ayudara a cubrir sus gastos médicos. Murió en su casa de Jarabacoa el 2 de octubre de 2024 por complicaciones pulmonares, estomacales y de colon, y el ayuntamiento de la ciudad declaró tres días de duelo."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'raffy-matias'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'raffy-matias' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Raffy Matías —nombre completo Rafael Enrique Matías Rodríguez, nacido en Jarabacoa el 26 de septiembre de 1969, fallecido en la misma ciudad el 2 de octubre de 2024— fue cantante, compositor y productor dominicano de merengue y bachata, apodado «la voz más dulce del merengue».

**De «Hermanos en la Vía» a «ROL»**

Estudió piano desde joven e integró el grupo «Hermanos en la Vía» antes de formar «ROL» junto a los músicos Olvi y Ludwig, nombre del grupo tomado de sus iniciales. Con esa agrupación ganó reconocimiento en La Vega, Jarabacoa, Santiago y otras ciudades del Cibao.

**Un productor, y un sonido propio**

En 1995 conoció al productor Julio Sosa, con quien grabó sus primeras producciones, «Acúsame», «Con Altura», «Volando Alto» y «Bachata de Etiqueta». Sus canciones más conocidas, «Quiero Saber de Ti», «Amor Ayúdame» y «Ahora Que Te Vas», llevaron su carrera por toda la región en los años siguientes.

**Legado**

La enfermedad mantuvo a Matías alejado de los escenarios en sus últimos meses, durante los cuales pidió públicamente al gobierno dominicano una pensión que le ayudara a cubrir sus gastos médicos. Murió en su casa de Jarabacoa el 2 de octubre de 2024 por complicaciones pulmonares, estomacales y de colon, y el ayuntamiento de la ciudad declaró tres días de duelo.' WHERE slug = 'raffy-matias';

COMMIT;
