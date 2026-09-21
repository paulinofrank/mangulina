BEGIN;

-- Revierte 20260916005900_rewrite_soul_of_death_biography.sql con los documentos y campos previos.

DELETE FROM editorial_entity_references WHERE editorial_document_id IN (
  SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'soul-of-death' AND d.document_type = 'artist_biography');
DELETE FROM editorial_documents WHERE owner_artist_id = (SELECT id FROM artists WHERE slug = 'soul-of-death') AND document_type = 'artist_biography';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Soul of Death are a Dominican melodic death metal band from Santo Domingo. The guitarist Melvin Holguín, who works as Focalor, started them at the beginning of August 2004.","type":"text"}]},{"type":"paragraph","content":[{"text":"Two lives","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"They worked until 2015 and then stopped, and came back in 2020. On returning they posted that they were not vanquished and not beaten, that they had been through some turmoil and were rising again with the same strength and the same brotherhood.","type":"text"}]},{"type":"paragraph","content":[{"text":"That is a fair description of what running a metal band in the Dominican Republic costs. There is no circuit to sustain one — no label money, no radio, no festival that pays — so a five-year silence is the ordinary shape of a career rather than a failure of one.","type":"text"}]},{"type":"paragraph","content":[{"text":"Apocalipsis and Spiritual Disease","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"The EP Apocalipsis came in 2006. Spiritual Disease arrived first as a single in 2020, marking the return, and then as a full album in February 2023 on Nefast Films Records. Metal Forces Magazine reviewed it.","type":"text"}]},{"type":"paragraph","content":[{"text":"The subject matter moved as the band did. The early records were occult; the later ones deal in ancestral war, apocalyptic prophecy and mythology, which is a turn from shock toward something closer to history.","type":"text"}]},{"type":"paragraph","content":[{"text":"The scene around them","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Dominican metal is small enough that its musicians hold several bands at once. Rubén Mahfoud plays in Múcaro alongside a former Abaddon RD drummer, and Focalor built the one-man project Sífilis de Nazareth in 2015.","type":"text"}]},{"type":"paragraph","content":[{"text":"The foreign metal press has begun to notice. MetalSucks put them among fifteen bands worth hearing from the country in 2022, which for a scene that has never had a domestic industry is how recognition arrives at all.","type":"text"}]}]}'::jsonb, 'published', id, 2 FROM artists WHERE slug = 'soul-of-death';
INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Soul of Death es una banda dominicana de death metal melódico de Santo Domingo. La armó el guitarrista Melvin Holguín, que trabaja como Focalor, a principios de agosto de 2004.","type":"text"}]},{"type":"paragraph","content":[{"text":"Dos vidas","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Trabajaron hasta 2015 y pararon, y volvieron en 2020. Al regresar publicaron que no estaban vencidos ni derrotados, que habían pasado por una turbulencia y estaban levantándose otra vez con la misma fuerza y la misma hermandad.","type":"text"}]},{"type":"paragraph","content":[{"text":"Ésa es una descripción justa de lo que cuesta sostener una banda de metal en la República Dominicana. No hay circuito que la mantenga —ni dinero de sello, ni radio, ni festival que pague—, así que cinco años de silencio son la forma corriente de una carrera y no el fracaso de una.","type":"text"}]},{"type":"paragraph","content":[{"text":"Apocalipsis y Spiritual Disease","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El EP Apocalipsis salió en 2006. Spiritual Disease llegó primero como sencillo en 2020, marcando el regreso, y después como álbum completo en febrero de 2023 por Nefast Films Records. Metal Forces Magazine lo reseñó.","type":"text"}]},{"type":"paragraph","content":[{"text":"Los temas se movieron con la banda. Los discos tempranos eran ocultistas; los últimos tratan de guerra ancestral, profecía apocalíptica y mitología, que es un giro del susto hacia algo más cercano a la historia.","type":"text"}]},{"type":"paragraph","content":[{"text":"La escena alrededor","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"El metal dominicano es lo bastante pequeño como para que sus músicos sostengan varias bandas a la vez. Rubén Mahfoud toca en Múcaro junto a un exbaterista de Abaddon RD, y Focalor levantó en 2015 el proyecto de un solo hombre Sífilis de Nazareth.","type":"text"}]},{"type":"paragraph","content":[{"text":"La prensa extranjera de metal ha empezado a notarlos. MetalSucks los puso entre quince bandas del país que vale la pena oír en 2022, que para una escena que nunca ha tenido industria propia es la manera en que llega cualquier reconocimiento.","type":"text"}]}]}'::jsonb, 'draft', id, 1 FROM artists WHERE slug = 'soul-of-death';
UPDATE artists SET bio_en = 'Soul of Death are a Dominican melodic death metal band from Santo Domingo. The guitarist Melvin Holguín, who works as Focalor, started them at the beginning of August 2004.

**Two lives**

They worked until 2015 and then stopped, and came back in 2020. On returning they posted that they were not vanquished and not beaten, that they had been through some turmoil and were rising again with the same strength and the same brotherhood.

That is a fair description of what running a metal band in the Dominican Republic costs. There is no circuit to sustain one — no label money, no radio, no festival that pays — so a five-year silence is the ordinary shape of a career rather than a failure of one.

**Apocalipsis and Spiritual Disease**

The EP Apocalipsis came in 2006. Spiritual Disease arrived first as a single in 2020, marking the return, and then as a full album in February 2023 on Nefast Films Records. Metal Forces Magazine reviewed it.

The subject matter moved as the band did. The early records were occult; the later ones deal in ancestral war, apocalyptic prophecy and mythology, which is a turn from shock toward something closer to history.

**The scene around them**

Dominican metal is small enough that its musicians hold several bands at once. Rubén Mahfoud plays in Múcaro alongside a former Abaddon RD drummer, and Focalor built the one-man project Sífilis de Nazareth in 2015.

The foreign metal press has begun to notice. MetalSucks put them among fifteen bands worth hearing from the country in 2022, which for a scene that has never had a domestic industry is how recognition arrives at all.', bio_es = 'Soul of Death es una banda dominicana de death metal melódico de Santo Domingo. La armó el guitarrista Melvin Holguín, que trabaja como Focalor, a principios de agosto de 2004.

**Dos vidas**

Trabajaron hasta 2015 y pararon, y volvieron en 2020. Al regresar publicaron que no estaban vencidos ni derrotados, que habían pasado por una turbulencia y estaban levantándose otra vez con la misma fuerza y la misma hermandad.

Ésa es una descripción justa de lo que cuesta sostener una banda de metal en la República Dominicana. No hay circuito que la mantenga —ni dinero de sello, ni radio, ni festival que pague—, así que cinco años de silencio son la forma corriente de una carrera y no el fracaso de una.

**Apocalipsis y Spiritual Disease**

El EP Apocalipsis salió en 2006. Spiritual Disease llegó primero como sencillo en 2020, marcando el regreso, y después como álbum completo en febrero de 2023 por Nefast Films Records. Metal Forces Magazine lo reseñó.

Los temas se movieron con la banda. Los discos tempranos eran ocultistas; los últimos tratan de guerra ancestral, profecía apocalíptica y mitología, que es un giro del susto hacia algo más cercano a la historia.

**La escena alrededor**

El metal dominicano es lo bastante pequeño como para que sus músicos sostengan varias bandas a la vez. Rubén Mahfoud toca en Múcaro junto a un exbaterista de Abaddon RD, y Focalor levantó en 2015 el proyecto de un solo hombre Sífilis de Nazareth.

La prensa extranjera de metal ha empezado a notarlos. MetalSucks los puso entre quince bandas del país que vale la pena oír en 2022, que para una escena que nunca ha tenido industria propia es la manera en que llega cualquier reconocimiento.', status = 'needs_review' WHERE slug = 'soul-of-death';

COMMIT;
