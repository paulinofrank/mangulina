BEGIN;

-- Ficha de Ninón Lapeiretta de Brouwer.
--
-- La biografía de relleno hablaba en términos genéricos de "institution-building" sin
-- nombrar una sola obra, maestro, institución o fecha concreta.
-- date_of_death corregido de 1989-09-29 a 1989-09-22: tanto el cuerpo del artículo de
-- Wikipedia (no su infobox, que coincide con la fila) como el sitio familiar coinciden en
-- el 22 de septiembre.

UPDATE artists SET date_of_death = '1989-09-22' WHERE slug = 'ninon-lapeiretta-de-brouwer';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Ninón Lapeiretta Pichardo de Brouwer, born in Santo Domingo on 4 January 1907 and died there on 22 September 1989, was a Dominican composer and pianist who spent her career both writing concert music and building the institutions that let it be heard."}]},{"type":"paragraph","content":[{"type":"text","text":"Training","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She began piano at five under José de Jesús Ravelo, continued with Blanca Mieses Polanco, and from 1940 studied composition with Enrique Casal Chapí, the exiled Spanish conductor who led the Orquesta Sinfónica Nacional and made a point of programming Dominican composers alongside the European repertoire."}]},{"type":"paragraph","content":[{"type":"text","text":"A national premiere and a BBC broadcast","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Casal Chapí’s orchestra premiered her wind-ensemble piece «Dos Caprichos» in 1942 and, the following year, her orchestral «Abominación de la Espera» with the soprano Dora Merten as soloist. In 1944 her string-quartet piece «Suite Arcaica» was performed at a BBC concert in London marking the centennial of Dominican independence — a rare instance of Dominican concert music reaching a European audience at the time. She also composed the ballet score «La Reina del Caribe»."}]},{"type":"paragraph","content":[{"type":"text","text":"Building the institutions","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Beyond composing, Lapeiretta de Brouwer founded the Círculo de Bellas Artes in 1941 and the Sociedad Pro Arte in 1953, an organization she led for 24 years and used to bring international performers to the Dominican Republic. She is also credited with petitioning for 22 November — Saint Cecilia’s feast day — to be observed nationally as El Día del Músico, still marked in the country today."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"On 3 May 1959 she conducted the Orquesta Sinfónica Nacional, by her family’s account among the first women anywhere to conduct a national symphony orchestra. In 2004, the Orquesta Ars Nova of Santiago dedicated its entire concert season to her memory, honoring what it called an important but often overlooked figure in Dominican classical music."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'ninon-lapeiretta-de-brouwer'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'ninon-lapeiretta-de-brouwer' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Ninón Lapeiretta Pichardo de Brouwer, born in Santo Domingo on 4 January 1907 and died there on 22 September 1989, was a Dominican composer and pianist who spent her career both writing concert music and building the institutions that let it be heard.

**Training**

She began piano at five under José de Jesús Ravelo, continued with Blanca Mieses Polanco, and from 1940 studied composition with Enrique Casal Chapí, the exiled Spanish conductor who led the Orquesta Sinfónica Nacional and made a point of programming Dominican composers alongside the European repertoire.

**A national premiere and a BBC broadcast**

Casal Chapí’s orchestra premiered her wind-ensemble piece «Dos Caprichos» in 1942 and, the following year, her orchestral «Abominación de la Espera» with the soprano Dora Merten as soloist. In 1944 her string-quartet piece «Suite Arcaica» was performed at a BBC concert in London marking the centennial of Dominican independence — a rare instance of Dominican concert music reaching a European audience at the time. She also composed the ballet score «La Reina del Caribe».

**Building the institutions**

Beyond composing, Lapeiretta de Brouwer founded the Círculo de Bellas Artes in 1941 and the Sociedad Pro Arte in 1953, an organization she led for 24 years and used to bring international performers to the Dominican Republic. She is also credited with petitioning for 22 November — Saint Cecilia’s feast day — to be observed nationally as El Día del Músico, still marked in the country today.

**Legacy**

On 3 May 1959 she conducted the Orquesta Sinfónica Nacional, by her family’s account among the first women anywhere to conduct a national symphony orchestra. In 2004, the Orquesta Ars Nova of Santiago dedicated its entire concert season to her memory, honoring what it called an important but often overlooked figure in Dominican classical music.' WHERE slug = 'ninon-lapeiretta-de-brouwer';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Ninón Lapeiretta Pichardo de Brouwer, nacida en Santo Domingo el 4 de enero de 1907 y fallecida en la misma ciudad el 22 de septiembre de 1989, fue compositora y pianista dominicana que dedicó su carrera tanto a escribir música de concierto como a construir las instituciones que permitieran escucharla."}]},{"type":"paragraph","content":[{"type":"text","text":"Formación","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Comenzó el piano a los cinco años con José de Jesús Ravelo, continuó con Blanca Mieses Polanco y, desde 1940, estudió composición con Enrique Casal Chapí, el director español exiliado que dirigía la Orquesta Sinfónica Nacional y hacía un punto de programar a compositores dominicanos junto al repertorio europeo."}]},{"type":"paragraph","content":[{"type":"text","text":"Un estreno nacional y una transmisión de la BBC","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La orquesta de Casal Chapí estrenó su pieza para conjunto de viento «Dos Caprichos» en 1942 y, al año siguiente, su obra orquestal «Abominación de la Espera» con la soprano Dora Merten como solista. En 1944 su pieza para cuarteto de cuerdas «Suite Arcaica» se interpretó en un concierto de la BBC en Londres por el centenario de la independencia dominicana, un caso poco frecuente de música de concierto dominicana llegando a un público europeo en esa época. También compuso la partitura del ballet «La Reina del Caribe»."}]},{"type":"paragraph","content":[{"type":"text","text":"Construir las instituciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Más allá de componer, Lapeiretta de Brouwer fundó el Círculo de Bellas Artes en 1941 y la Sociedad Pro Arte en 1953, organización que presidió durante 24 años y con la que trajo intérpretes internacionales a la República Dominicana. Se le atribuye además haber pedido que el 22 de noviembre —día de Santa Cecilia— se observara a nivel nacional como El Día del Músico, fecha que el país sigue marcando hoy."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El 3 de mayo de 1959 dirigió la Orquesta Sinfónica Nacional, según el registro de su propia familia una de las primeras mujeres en el mundo en dirigir una orquesta sinfónica nacional. En 2004, la Orquesta Ars Nova de Santiago dedicó toda su temporada de conciertos a su memoria, en homenaje a quien llamó una figura importante pero con frecuencia olvidada de la música clásica dominicana."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'ninon-lapeiretta-de-brouwer'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'ninon-lapeiretta-de-brouwer' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Ninón Lapeiretta Pichardo de Brouwer, nacida en Santo Domingo el 4 de enero de 1907 y fallecida en la misma ciudad el 22 de septiembre de 1989, fue compositora y pianista dominicana que dedicó su carrera tanto a escribir música de concierto como a construir las instituciones que permitieran escucharla.

**Formación**

Comenzó el piano a los cinco años con José de Jesús Ravelo, continuó con Blanca Mieses Polanco y, desde 1940, estudió composición con Enrique Casal Chapí, el director español exiliado que dirigía la Orquesta Sinfónica Nacional y hacía un punto de programar a compositores dominicanos junto al repertorio europeo.

**Un estreno nacional y una transmisión de la BBC**

La orquesta de Casal Chapí estrenó su pieza para conjunto de viento «Dos Caprichos» en 1942 y, al año siguiente, su obra orquestal «Abominación de la Espera» con la soprano Dora Merten como solista. En 1944 su pieza para cuarteto de cuerdas «Suite Arcaica» se interpretó en un concierto de la BBC en Londres por el centenario de la independencia dominicana, un caso poco frecuente de música de concierto dominicana llegando a un público europeo en esa época. También compuso la partitura del ballet «La Reina del Caribe».

**Construir las instituciones**

Más allá de componer, Lapeiretta de Brouwer fundó el Círculo de Bellas Artes en 1941 y la Sociedad Pro Arte en 1953, organización que presidió durante 24 años y con la que trajo intérpretes internacionales a la República Dominicana. Se le atribuye además haber pedido que el 22 de noviembre —día de Santa Cecilia— se observara a nivel nacional como El Día del Músico, fecha que el país sigue marcando hoy.

**Legado**

El 3 de mayo de 1959 dirigió la Orquesta Sinfónica Nacional, según el registro de su propia familia una de las primeras mujeres en el mundo en dirigir una orquesta sinfónica nacional. En 2004, la Orquesta Ars Nova de Santiago dedicó toda su temporada de conciertos a su memoria, en homenaje a quien llamó una figura importante pero con frecuencia olvidada de la música clásica dominicana.' WHERE slug = 'ninon-lapeiretta-de-brouwer';

COMMIT;
