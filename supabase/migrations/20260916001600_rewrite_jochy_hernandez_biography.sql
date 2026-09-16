BEGIN;

-- Ficha de Jochy Hernández.
--
-- La biografía de relleno era genérica, sin nombrar canción, orquesta ni hecho real: su
-- historia está marcada por el asesinato sin resolver de su padre y el accidente de 1987 en
-- Bonao que mató a varios de sus músicos, antes del tumor cerebral que le costó la vida.
-- last_name/second_last_name intercambiados de Díaz/Hernández a Hernández/Díaz (Wikipedia
-- aclara que Hernández es el apellido paterno). Alias erróneo eliminado; se añade "La Figura".

UPDATE artists SET last_name = 'Hernández', second_last_name = 'Díaz',
       aliases = ARRAY['El Amiguito','La Figura']::text[]
       WHERE slug = 'jochy-hernandez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jochy Hernández —full name Carlos José Hernández Díaz, born in San Cristóbal on 12 September 1963, died in Santo Domingo on 30 April 1994— was a Dominican merengue singer known as «El Amiguito», whose brief career was framed by two tragedies: an accident that killed several of his musicians, and the brain tumor that eventually took his own life."}]},{"type":"paragraph","content":[{"type":"text","text":"An unsolved murder","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He was orphaned at eleven when his father, Bartolo Hernández, was shot and killed on 5 October 1974, a murder that was never solved. As a teenager he began singing with several bands before landing a spot in a merengue orchestra led at different times by "},{"type":"artistReference","attrs":{"occurrenceId":"82493daf-10fd-429e-92c0-2eab9d01ac82","artistId":"6c3e0d74-23b7-4d80-969f-9d5319ee5127","displayText":"Alex Bueno"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"d5e38dc0-261c-4e9d-b241-db058b57dd02","artistId":"f050869b-f4c0-4281-b883-bce0120ad9b2","displayText":"Aníbal Bravo"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Ahora Yo» and a night in Bonao","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1985 he went solo, signing with Discos CBS and releasing his debut single, «Ahora Yo». On 16 August 1987, after a concert in the Cibao, a minibus carrying part of his orchestra collided with a truck in Bonao; Hernández and his brother Ruddy, traveling in a separate vehicle, arrived to find three musicians already dead, while the singer Delvi, who had survived the initial crash, was struck and killed moments later by an oncoming vehicle."}]},{"type":"paragraph","content":[{"type":"text","text":"«El Amiguito»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His 1988 album gave him the nickname that stayed with him for the rest of his career, including the song «Hermanos Míos», dedicated to the musicians killed at Bonao."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1989 Hernández was diagnosed with a terminal brain tumor and given two months to live, but survived five more years, eventually receiving surgery in Boston after his brother, San Cristóbal senator Tito Hernández, brought his condition to the attention of President Joaquín Balaguer. He died at the Centro Médico UCE in Santo Domingo at thirty. He was married to television reporter and actress María del Carmen Hernández, with whom he had three children, including a son, José Carlos, himself a rock musician, who was murdered in Santo Domingo in 2012, and a daughter, Cindy Marie."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jochy-hernandez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jochy-hernandez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '82493daf-10fd-429e-92c0-2eab9d01ac82', 'artist', '6c3e0d74-23b7-4d80-969f-9d5319ee5127' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jochy-hernandez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd5e38dc0-261c-4e9d-b241-db058b57dd02', 'artist', 'f050869b-f4c0-4281-b883-bce0120ad9b2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jochy-hernandez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Jochy Hernández —full name Carlos José Hernández Díaz, born in San Cristóbal on 12 September 1963, died in Santo Domingo on 30 April 1994— was a Dominican merengue singer known as «El Amiguito», whose brief career was framed by two tragedies: an accident that killed several of his musicians, and the brain tumor that eventually took his own life.

**An unsolved murder**

He was orphaned at eleven when his father, Bartolo Hernández, was shot and killed on 5 October 1974, a murder that was never solved. As a teenager he began singing with several bands before landing a spot in a merengue orchestra led at different times by Alex Bueno and Aníbal Bravo.

**«Ahora Yo» and a night in Bonao**

In 1985 he went solo, signing with Discos CBS and releasing his debut single, «Ahora Yo». On 16 August 1987, after a concert in the Cibao, a minibus carrying part of his orchestra collided with a truck in Bonao; Hernández and his brother Ruddy, traveling in a separate vehicle, arrived to find three musicians already dead, while the singer Delvi, who had survived the initial crash, was struck and killed moments later by an oncoming vehicle.

**«El Amiguito»**

His 1988 album gave him the nickname that stayed with him for the rest of his career, including the song «Hermanos Míos», dedicated to the musicians killed at Bonao.

**Legacy**

In 1989 Hernández was diagnosed with a terminal brain tumor and given two months to live, but survived five more years, eventually receiving surgery in Boston after his brother, San Cristóbal senator Tito Hernández, brought his condition to the attention of President Joaquín Balaguer. He died at the Centro Médico UCE in Santo Domingo at thirty. He was married to television reporter and actress María del Carmen Hernández, with whom he had three children, including a son, José Carlos, himself a rock musician, who was murdered in Santo Domingo in 2012, and a daughter, Cindy Marie.' WHERE slug = 'jochy-hernandez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jochy Hernández —nombre completo Carlos José Hernández Díaz, nacido en San Cristóbal el 12 de septiembre de 1963, fallecido en Santo Domingo el 30 de abril de 1994— fue cantante dominicano de merengue conocido como «El Amiguito», cuya breve carrera estuvo enmarcada por dos tragedias: un accidente que mató a varios de sus músicos, y el tumor cerebral que finalmente le costó la vida."}]},{"type":"paragraph","content":[{"type":"text","text":"Un asesinato sin resolver","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Quedó huérfano a los once años cuando su padre, Bartolo Hernández, fue baleado y asesinado el 5 de octubre de 1974, un crimen que nunca se resolvió. De adolescente empezó a cantar con varias bandas antes de conseguir un puesto en una orquesta de merengue dirigida en distintos momentos por "},{"type":"artistReference","attrs":{"occurrenceId":"58226458-189a-4b9e-9b83-0da1c70ab7d9","artistId":"6c3e0d74-23b7-4d80-969f-9d5319ee5127","displayText":"Alex Bueno"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"bfda57ce-c03c-4218-9753-765443a682d9","artistId":"f050869b-f4c0-4281-b883-bce0120ad9b2","displayText":"Aníbal Bravo"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"«Ahora Yo» y una noche en Bonao","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1985 se independizó, firmando con Discos CBS y lanzando su sencillo debut, «Ahora Yo». El 16 de agosto de 1987, tras un concierto en el Cibao, un minibús que transportaba a parte de su orquesta chocó con un camión en Bonao; Hernández y su hermano Ruddy, que viajaban en otro vehículo, llegaron para encontrar a tres músicos ya muertos, mientras que el cantante Delvi, quien había sobrevivido al choque inicial, murió minutos después al ser atropellado por un vehículo que venía en sentido contrario."}]},{"type":"paragraph","content":[{"type":"text","text":"«El Amiguito»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su álbum de 1988 le dio el apodo que lo acompañaría el resto de su carrera, e incluyó el tema «Hermanos Míos», dedicado a los músicos fallecidos en Bonao."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1989 a Hernández se le diagnosticó un tumor cerebral terminal y se le dieron dos meses de vida, pero sobrevivió cinco años más, siendo operado finalmente en Boston después de que su hermano, el senador por San Cristóbal Tito Hernández, pusiera su condición en conocimiento del presidente Joaquín Balaguer. Murió en el Centro Médico UCE de Santo Domingo a los treinta años. Estuvo casado con la periodista de televisión y actriz María del Carmen Hernández, con quien tuvo tres hijos, entre ellos un hijo, José Carlos, músico de rock él mismo, asesinado en Santo Domingo en 2012, y una hija, Cindy Marie."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jochy-hernandez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jochy-hernandez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '58226458-189a-4b9e-9b83-0da1c70ab7d9', 'artist', '6c3e0d74-23b7-4d80-969f-9d5319ee5127' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jochy-hernandez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'bfda57ce-c03c-4218-9753-765443a682d9', 'artist', 'f050869b-f4c0-4281-b883-bce0120ad9b2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jochy-hernandez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Jochy Hernández —nombre completo Carlos José Hernández Díaz, nacido en San Cristóbal el 12 de septiembre de 1963, fallecido en Santo Domingo el 30 de abril de 1994— fue cantante dominicano de merengue conocido como «El Amiguito», cuya breve carrera estuvo enmarcada por dos tragedias: un accidente que mató a varios de sus músicos, y el tumor cerebral que finalmente le costó la vida.

**Un asesinato sin resolver**

Quedó huérfano a los once años cuando su padre, Bartolo Hernández, fue baleado y asesinado el 5 de octubre de 1974, un crimen que nunca se resolvió. De adolescente empezó a cantar con varias bandas antes de conseguir un puesto en una orquesta de merengue dirigida en distintos momentos por Alex Bueno y Aníbal Bravo.

**«Ahora Yo» y una noche en Bonao**

En 1985 se independizó, firmando con Discos CBS y lanzando su sencillo debut, «Ahora Yo». El 16 de agosto de 1987, tras un concierto en el Cibao, un minibús que transportaba a parte de su orquesta chocó con un camión en Bonao; Hernández y su hermano Ruddy, que viajaban en otro vehículo, llegaron para encontrar a tres músicos ya muertos, mientras que el cantante Delvi, quien había sobrevivido al choque inicial, murió minutos después al ser atropellado por un vehículo que venía en sentido contrario.

**«El Amiguito»**

Su álbum de 1988 le dio el apodo que lo acompañaría el resto de su carrera, e incluyó el tema «Hermanos Míos», dedicado a los músicos fallecidos en Bonao.

**Legado**

En 1989 a Hernández se le diagnosticó un tumor cerebral terminal y se le dieron dos meses de vida, pero sobrevivió cinco años más, siendo operado finalmente en Boston después de que su hermano, el senador por San Cristóbal Tito Hernández, pusiera su condición en conocimiento del presidente Joaquín Balaguer. Murió en el Centro Médico UCE de Santo Domingo a los treinta años. Estuvo casado con la periodista de televisión y actriz María del Carmen Hernández, con quien tuvo tres hijos, entre ellos un hijo, José Carlos, músico de rock él mismo, asesinado en Santo Domingo en 2012, y una hija, Cindy Marie.' WHERE slug = 'jochy-hernandez';

COMMIT;
