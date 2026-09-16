BEGIN;

-- Ficha de El Cata.
--
-- La biografía de relleno era genérica y omitía el episodio central de su carrera: que su
-- propia canción «Loca con su Tíguere», reversionada por Shakira, se volvió un éxito mundial,
-- y el litigio de autoría que eso desató (resuelto a su favor en 2015).
-- middle_name añadido (Edwin). occupations y genres ampliados. No se tocó el año de
-- nacimiento (conflicto sin resolver, ver CONFLICTOS_DE_DATO.md).

UPDATE artists SET middle_name = 'Edwin',
       occupations = '["composer","producer","rapper"]'::jsonb, genres = ARRAY['merengue']::text[]
       WHERE slug = 'el-cata';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"El Cata —born Edward Edwin Bello Pou in Barahona— is a Dominican singer, rapper, songwriter and producer whose merenrap crossed into global pop through hit collaborations with Shakira and Pitbull."}]},{"type":"paragraph","content":[{"type":"text","text":"From Barahona to the Bronx","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He left the Dominican Republic for Puerto Rico at five and, a year later, for Miami, where he lived until graduating from Miami Beach Senior High School. He then moved with his family to New York, studying music at Bronx Community College while working in a furniture store, a bank and a state Medicare office. After more than twenty years in the United States, he returned to the Dominican Republic to pursue music formally."}]},{"type":"paragraph","content":[{"type":"text","text":"«El Malo» and an international crossover","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He debuted independently in 1997 with the songs «El Nacu Nacu» and «Con la Lengua Afuera», and in 2009 released his official debut album, «El Malo», on Allegro/Planet Records, featuring the singles «Loca con su Tíguere», «Pa’ la Esquinita» and «El Que Brilla Brilla». That year he also earned a co-writing credit on Pitbull’s «I Know You Want Me (Calle Ocho)», and in 2010 he joined Lil Jon, Sensato del Patio and Black Point on the remix of Pitbull’s «Watagatapitusberry»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Loca», Shakira, and a lawsuit over it","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2010 Shakira adapted El Cata’s own «Loca con su Tíguere» into «Loca», the lead single of her album «Sale el Sol», with El Cata rapping on the track; he also appeared on the Spanish-language version of the album’s «Rabiosa». Both songs became international hits, but in 2014 the Dominican songwriter Ramón Arias Vásquez sued, claiming he had written the underlying song in the late 1990s, and a federal court initially sided with him. In August 2015, however, judge Alvin Hellerstein dismissed the claim after finding that Arias Vásquez had lied to the court and submitted falsified recordings as evidence, vindicating El Cata’s authorship."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El Cata went on to collaborate widely, from Elvis Crespo on «Zombie» to Gente de Zona and Juan Magán, and remained a fixture of Dominican urban and merengue music into the following decade. In September 2022 he was sworn into the Partido Revolucionario Dominicano, seeking a seat in Congress representing Santo Domingo Oeste, without stepping away from music."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'el-cata'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'el-cata' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'El Cata —born Edward Edwin Bello Pou in Barahona— is a Dominican singer, rapper, songwriter and producer whose merenrap crossed into global pop through hit collaborations with Shakira and Pitbull.

**From Barahona to the Bronx**

He left the Dominican Republic for Puerto Rico at five and, a year later, for Miami, where he lived until graduating from Miami Beach Senior High School. He then moved with his family to New York, studying music at Bronx Community College while working in a furniture store, a bank and a state Medicare office. After more than twenty years in the United States, he returned to the Dominican Republic to pursue music formally.

**«El Malo» and an international crossover**

He debuted independently in 1997 with the songs «El Nacu Nacu» and «Con la Lengua Afuera», and in 2009 released his official debut album, «El Malo», on Allegro/Planet Records, featuring the singles «Loca con su Tíguere», «Pa’ la Esquinita» and «El Que Brilla Brilla». That year he also earned a co-writing credit on Pitbull’s «I Know You Want Me (Calle Ocho)», and in 2010 he joined Lil Jon, Sensato del Patio and Black Point on the remix of Pitbull’s «Watagatapitusberry».

**«Loca», Shakira, and a lawsuit over it**

In 2010 Shakira adapted El Cata’s own «Loca con su Tíguere» into «Loca», the lead single of her album «Sale el Sol», with El Cata rapping on the track; he also appeared on the Spanish-language version of the album’s «Rabiosa». Both songs became international hits, but in 2014 the Dominican songwriter Ramón Arias Vásquez sued, claiming he had written the underlying song in the late 1990s, and a federal court initially sided with him. In August 2015, however, judge Alvin Hellerstein dismissed the claim after finding that Arias Vásquez had lied to the court and submitted falsified recordings as evidence, vindicating El Cata’s authorship.

**Legacy**

El Cata went on to collaborate widely, from Elvis Crespo on «Zombie» to Gente de Zona and Juan Magán, and remained a fixture of Dominican urban and merengue music into the following decade. In September 2022 he was sworn into the Partido Revolucionario Dominicano, seeking a seat in Congress representing Santo Domingo Oeste, without stepping away from music.' WHERE slug = 'el-cata';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"El Cata —nacido Edward Edwin Bello Pou en Barahona— es cantante, rapero, compositor y productor dominicano, cuyo merenrap cruzó al pop global a través de exitosas colaboraciones con Shakira y Pitbull."}]},{"type":"paragraph","content":[{"type":"text","text":"De Barahona al Bronx","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Salió de República Dominicana hacia Puerto Rico a los cinco años y, un año después, hacia Miami, donde vivió hasta graduarse de la Miami Beach Senior High School. Luego se mudó con su familia a Nueva York, donde estudió música en el Bronx Community College mientras trabajaba en una mueblería, un banco y una oficina estatal de Medicare. Tras más de veinte años en Estados Unidos, regresó a República Dominicana para dedicarse formalmente a la música."}]},{"type":"paragraph","content":[{"type":"text","text":"«El Malo» y un cruce internacional","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Debutó de forma independiente en 1997 con las canciones «El Nacu Nacu» y «Con la Lengua Afuera», y en 2009 lanzó su álbum debut oficial, «El Malo», con el sello Allegro/Planet Records, que incluyó los sencillos «Loca con su Tíguere», «Pa’ la Esquinita» y «El Que Brilla Brilla». Ese año también obtuvo crédito como coautor en «I Know You Want Me (Calle Ocho)» de Pitbull, y en 2010 se sumó a Lil Jon, Sensato del Patio y Black Point en el remix de «Watagatapitusberry», también de Pitbull."}]},{"type":"paragraph","content":[{"type":"text","text":"«Loca», Shakira, y una demanda por ella","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2010 Shakira adaptó la propia canción de El Cata, «Loca con su Tíguere», convirtiéndola en «Loca», sencillo principal de su álbum «Sale el Sol», en el que El Cata rapea; también participó en la versión en español de «Rabiosa», del mismo disco. Ambas canciones fueron éxitos internacionales, pero en 2014 el compositor dominicano Ramón Arias Vásquez demandó, alegando haber escrito la canción original a finales de los años noventa, y una corte federal falló inicialmente a su favor. Sin embargo, en agosto de 2015 el juez Alvin Hellerstein desestimó la demanda tras determinar que Arias Vásquez había mentido a la corte y presentado grabaciones falsificadas como prueba, reivindicando la autoría de El Cata."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El Cata siguió colaborando ampliamente, desde Elvis Crespo en «Zombie» hasta Gente de Zona y Juan Magán, y se mantuvo como referente de la música urbana y el merengue dominicanos en la década siguiente. En septiembre de 2022 se juramentó en el Partido Revolucionario Dominicano, buscando una curul en el Congreso por Santo Domingo Oeste, sin apartarse de la música."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'el-cata'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'el-cata' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'El Cata —nacido Edward Edwin Bello Pou en Barahona— es cantante, rapero, compositor y productor dominicano, cuyo merenrap cruzó al pop global a través de exitosas colaboraciones con Shakira y Pitbull.

**De Barahona al Bronx**

Salió de República Dominicana hacia Puerto Rico a los cinco años y, un año después, hacia Miami, donde vivió hasta graduarse de la Miami Beach Senior High School. Luego se mudó con su familia a Nueva York, donde estudió música en el Bronx Community College mientras trabajaba en una mueblería, un banco y una oficina estatal de Medicare. Tras más de veinte años en Estados Unidos, regresó a República Dominicana para dedicarse formalmente a la música.

**«El Malo» y un cruce internacional**

Debutó de forma independiente en 1997 con las canciones «El Nacu Nacu» y «Con la Lengua Afuera», y en 2009 lanzó su álbum debut oficial, «El Malo», con el sello Allegro/Planet Records, que incluyó los sencillos «Loca con su Tíguere», «Pa’ la Esquinita» y «El Que Brilla Brilla». Ese año también obtuvo crédito como coautor en «I Know You Want Me (Calle Ocho)» de Pitbull, y en 2010 se sumó a Lil Jon, Sensato del Patio y Black Point en el remix de «Watagatapitusberry», también de Pitbull.

**«Loca», Shakira, y una demanda por ella**

En 2010 Shakira adaptó la propia canción de El Cata, «Loca con su Tíguere», convirtiéndola en «Loca», sencillo principal de su álbum «Sale el Sol», en el que El Cata rapea; también participó en la versión en español de «Rabiosa», del mismo disco. Ambas canciones fueron éxitos internacionales, pero en 2014 el compositor dominicano Ramón Arias Vásquez demandó, alegando haber escrito la canción original a finales de los años noventa, y una corte federal falló inicialmente a su favor. Sin embargo, en agosto de 2015 el juez Alvin Hellerstein desestimó la demanda tras determinar que Arias Vásquez había mentido a la corte y presentado grabaciones falsificadas como prueba, reivindicando la autoría de El Cata.

**Legado**

El Cata siguió colaborando ampliamente, desde Elvis Crespo en «Zombie» hasta Gente de Zona y Juan Magán, y se mantuvo como referente de la música urbana y el merengue dominicanos en la década siguiente. En septiembre de 2022 se juramentó en el Partido Revolucionario Dominicano, buscando una curul en el Congreso por Santo Domingo Oeste, sin apartarse de la música.' WHERE slug = 'el-cata';

COMMIT;
