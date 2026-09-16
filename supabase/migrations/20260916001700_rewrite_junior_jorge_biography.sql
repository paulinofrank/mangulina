BEGIN;

-- Ficha de Junior & Jorge.
--
-- La biografía de relleno era completamente genérica, sin nombrar canción, sello ni el hecho
-- central de su historia: ambos integrantes abandonaron la música secular juntos, en una
-- misma noche, por una conversión religiosa compartida.
-- birth_place/province corregidos de Santo Domingo/Distrito Nacional a Nueva York/Nacido en
-- el Exterior. formation_year/dissolution_year añadidos (1995/2001).

UPDATE artists SET birth_place = 'Nueva York', province = 'Nacido en el Exterior',
       formation_year = 1995, dissolution_year = 2001
       WHERE slug = 'junior-jorge';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Junior & Jorge —a bachata duo formed in New York in 1995 by Junior Arias and "},{"type":"artistReference","attrs":{"occurrenceId":"62a0d5ab-cd17-49fe-ac96-114994030b0a","artistId":"d08df81f-db6b-4919-a741-7b45c3789dc2","displayText":"Jorge Morel"}},{"type":"text","text":"— became one of the most successful Dominican bachata acts of the late 1990s before both members left secular music together, in a single shared decision."}]},{"type":"paragraph","content":[{"type":"text","text":"Sony Discos, and the biggest stages","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Signed to Sony Discos International, the duo scored hits including «Piensa en Mí», «Amigo Mío» and «Olvídala» (with Alexandra), and were, by their own account, the first act to bring bachata to the television channel HTV. They won Premios Estrellas in New York and played some of the largest stages available to Latin artists at the time, including Bayfront Park in Miami and, at the invitation of radio station La Mega, Madison Square Garden."}]},{"type":"paragraph","content":[{"type":"text","text":"A shared conversion","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Around 2000, at a Thursday-night prayer meeting at the Iglesia San Antonio de Padua in the Bronx, Arias and Morel both decided, the same night, to leave secular music behind. On the advice of their bishop in the Dominican Republic, they first completed their existing promotional contract for the album «Camino sin Regreso» rather than leave it unfulfilled, and the group formally ended in 2001."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Jorge Morel went on to a long career as a Catholic worship musician, founding the youth movement Comunidad Jóvenes de Luz; Junior Arias shared in the same calling that night in the Bronx, closing the book on one of Dominican bachata’s most commercially successful duos of its era."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'junior-jorge'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'junior-jorge' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '62a0d5ab-cd17-49fe-ac96-114994030b0a', 'artist', 'd08df81f-db6b-4919-a741-7b45c3789dc2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'junior-jorge' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Junior & Jorge —a bachata duo formed in New York in 1995 by Junior Arias and Jorge Morel— became one of the most successful Dominican bachata acts of the late 1990s before both members left secular music together, in a single shared decision.

**Sony Discos, and the biggest stages**

Signed to Sony Discos International, the duo scored hits including «Piensa en Mí», «Amigo Mío» and «Olvídala» (with Alexandra), and were, by their own account, the first act to bring bachata to the television channel HTV. They won Premios Estrellas in New York and played some of the largest stages available to Latin artists at the time, including Bayfront Park in Miami and, at the invitation of radio station La Mega, Madison Square Garden.

**A shared conversion**

Around 2000, at a Thursday-night prayer meeting at the Iglesia San Antonio de Padua in the Bronx, Arias and Morel both decided, the same night, to leave secular music behind. On the advice of their bishop in the Dominican Republic, they first completed their existing promotional contract for the album «Camino sin Regreso» rather than leave it unfulfilled, and the group formally ended in 2001.

**Legacy**

Jorge Morel went on to a long career as a Catholic worship musician, founding the youth movement Comunidad Jóvenes de Luz; Junior Arias shared in the same calling that night in the Bronx, closing the book on one of Dominican bachata’s most commercially successful duos of its era.' WHERE slug = 'junior-jorge';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Junior & Jorge —dúo de bachata formado en Nueva York en 1995 por Junior Arias y "},{"type":"artistReference","attrs":{"occurrenceId":"3326f220-7367-405a-84de-d7206eb05b88","artistId":"d08df81f-db6b-4919-a741-7b45c3789dc2","displayText":"Jorge Morel"}},{"type":"text","text":"— se convirtió en uno de los actos de bachata dominicana más exitosos de finales de los noventa, antes de que ambos integrantes dejaran juntos la música secular, en una misma decisión compartida."}]},{"type":"paragraph","content":[{"type":"text","text":"Sony Discos, y los escenarios más grandes","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Firmado con Sony Discos International, el dúo consiguió éxitos como «Piensa en Mí», «Amigo Mío» y «Olvídala» (con Alexandra), y fueron, según su propio relato, los primeros en llevar la bachata al canal de televisión HTV. Ganaron Premios Estrellas en Nueva York y se presentaron en algunos de los escenarios más grandes disponibles para artistas latinos de la época, incluyendo el Bayfront Park de Miami y, por invitación de la emisora La Mega, el Madison Square Garden."}]},{"type":"paragraph","content":[{"type":"text","text":"Una conversión compartida","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Hacia el año 2000, en una asamblea de oración de un jueves por la noche en la Iglesia San Antonio de Padua, en el Bronx, Arias y Morel decidieron, la misma noche, dejar atrás la música secular. Por consejo de su obispo en República Dominicana, primero cumplieron el contrato promocional vigente para el álbum «Camino sin Regreso» en lugar de dejarlo incumplido, y el grupo terminó formalmente en 2001."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Jorge Morel continuó con una larga carrera como músico católico de alabanza, fundando el movimiento juvenil Comunidad Jóvenes de Luz; Junior Arias compartió ese mismo llamado aquella noche en el Bronx, cerrando la historia de uno de los dúos de bachata dominicana comercialmente más exitosos de su época."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'junior-jorge'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'junior-jorge' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '3326f220-7367-405a-84de-d7206eb05b88', 'artist', 'd08df81f-db6b-4919-a741-7b45c3789dc2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'junior-jorge' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Junior & Jorge —dúo de bachata formado en Nueva York en 1995 por Junior Arias y Jorge Morel— se convirtió en uno de los actos de bachata dominicana más exitosos de finales de los noventa, antes de que ambos integrantes dejaran juntos la música secular, en una misma decisión compartida.

**Sony Discos, y los escenarios más grandes**

Firmado con Sony Discos International, el dúo consiguió éxitos como «Piensa en Mí», «Amigo Mío» y «Olvídala» (con Alexandra), y fueron, según su propio relato, los primeros en llevar la bachata al canal de televisión HTV. Ganaron Premios Estrellas en Nueva York y se presentaron en algunos de los escenarios más grandes disponibles para artistas latinos de la época, incluyendo el Bayfront Park de Miami y, por invitación de la emisora La Mega, el Madison Square Garden.

**Una conversión compartida**

Hacia el año 2000, en una asamblea de oración de un jueves por la noche en la Iglesia San Antonio de Padua, en el Bronx, Arias y Morel decidieron, la misma noche, dejar atrás la música secular. Por consejo de su obispo en República Dominicana, primero cumplieron el contrato promocional vigente para el álbum «Camino sin Regreso» en lugar de dejarlo incumplido, y el grupo terminó formalmente en 2001.

**Legado**

Jorge Morel continuó con una larga carrera como músico católico de alabanza, fundando el movimiento juvenil Comunidad Jóvenes de Luz; Junior Arias compartió ese mismo llamado aquella noche en el Bronx, cerrando la historia de uno de los dúos de bachata dominicana comercialmente más exitosos de su época.' WHERE slug = 'junior-jorge';

COMMIT;
