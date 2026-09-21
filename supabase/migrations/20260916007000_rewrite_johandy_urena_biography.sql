BEGIN;

-- Johandy Ureña (Johandy Ureña Guaba): baterista e ingeniero de audio de rock y metal, no un músico de jazz como decía el relleno. Fuentes: Discolai (Max Cueto, 14 oct. 2022, entrevista a Voces en el Plasma), Metal Archives (Archaios, Altus Mortem, Hester Prynne, Post Mortem, Voces en el Plasma), reseña de Heavy Metal Tribune de The Distant (2011), Metal Underground (Exsanguination Throne, 2011), MusicBrainz ('dominican drummer, member of El Trio'), su perfil de Twitter/Instagram. Campos: primary_genre rock, genres vacío, artist_tags secular, occupations drummer y engineer.

UPDATE artists SET primary_genre = 'rock', genres = ARRAY[]::text[], artist_tags = ARRAY['secular']::text[], occupations = '["drummer","engineer"]'::jsonb WHERE slug = 'johandy-urena';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Johandy Ureña —Johandy Ureña Guaba— is a Dominican drummer and audio engineer who has played in some of the country’s rock and metal bands, among them "},{"type":"artistReference","attrs":{"occurrenceId":"c2d74484-465b-4e7c-ba8d-1984546c7e2a","artistId":"3bcd6c98-08d9-4008-8b5f-72ce8a10afa5","displayText":"Archaios"}},{"type":"text","text":" and «Voces en el Plasma»."}]},{"type":"paragraph","content":[{"type":"text","text":"Drummer in Dominican metal and rock","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The international metal database Encyclopaedia Metallum lists him as a past drummer of "},{"type":"artistReference","attrs":{"occurrenceId":"2010f77b-84bb-4fdb-b895-55c8fbc0dde6","artistId":"3bcd6c98-08d9-4008-8b5f-72ce8a10afa5","displayText":"Archaios"}},{"type":"text","text":", and a review of the band’s 2011 album «The Distant» singled out the precision of his drumming and his ability to move from technical passages to blast beats. He also appears with «Altus Mortem», «Hester Prynne», «Post Mortem» and «Exsanguination Throne», which named a stand-in for him in 2011 while he was in the United States, and his own profile lists "},{"type":"artistReference","attrs":{"occurrenceId":"35d572e3-37f6-4d12-93cc-ca847841b35a","artistId":"8400a1c5-0f35-4121-ba11-a887a7312443","displayText":"Santuario"}},{"type":"text","text":", «Medullah» and «Mike Massacred» among his bands."}]},{"type":"paragraph","content":[{"type":"text","text":"«Voces en el Plasma»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He is the drummer of the rock band «Voces en el Plasma», formed in late 2002, which released «La Inmaculada Brevedad de la Carne» in 2004 and «Las Fábulas del Hambre» in 2010 and returned in 2022 with the single «La Voz» and the 2023 album «La Galaxia Caníbal». In the Discolai interview about that return the band said he was the only one of its four members who works full time in music, as a drummer in many bands and an engineer specialized in sound and multimedia; at that point he lived in Texas."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His career is documented through band credits and press coverage of the bands he has played in, and he is also listed as a member of the trio «El Trio»."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'johandy-urena'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'johandy-urena' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c2d74484-465b-4e7c-ba8d-1984546c7e2a', 'artist', '3bcd6c98-08d9-4008-8b5f-72ce8a10afa5' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johandy-urena' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '2010f77b-84bb-4fdb-b895-55c8fbc0dde6', 'artist', '3bcd6c98-08d9-4008-8b5f-72ce8a10afa5' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johandy-urena' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '35d572e3-37f6-4d12-93cc-ca847841b35a', 'artist', '8400a1c5-0f35-4121-ba11-a887a7312443' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johandy-urena' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Johandy Ureña —Johandy Ureña Guaba— is a Dominican drummer and audio engineer who has played in some of the country’s rock and metal bands, among them Archaios and «Voces en el Plasma».

**Drummer in Dominican metal and rock**

The international metal database Encyclopaedia Metallum lists him as a past drummer of Archaios, and a review of the band’s 2011 album «The Distant» singled out the precision of his drumming and his ability to move from technical passages to blast beats. He also appears with «Altus Mortem», «Hester Prynne», «Post Mortem» and «Exsanguination Throne», which named a stand-in for him in 2011 while he was in the United States, and his own profile lists Santuario, «Medullah» and «Mike Massacred» among his bands.

**«Voces en el Plasma»**

He is the drummer of the rock band «Voces en el Plasma», formed in late 2002, which released «La Inmaculada Brevedad de la Carne» in 2004 and «Las Fábulas del Hambre» in 2010 and returned in 2022 with the single «La Voz» and the 2023 album «La Galaxia Caníbal». In the Discolai interview about that return the band said he was the only one of its four members who works full time in music, as a drummer in many bands and an engineer specialized in sound and multimedia; at that point he lived in Texas.

**Legacy**

His career is documented through band credits and press coverage of the bands he has played in, and he is also listed as a member of the trio «El Trio».' WHERE slug = 'johandy-urena';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Johandy Ureña —Johandy Ureña Guaba— es un baterista e ingeniero de audio dominicano que ha tocado en varias de las bandas de rock y metal del país, entre ellas "},{"type":"artistReference","attrs":{"occurrenceId":"6f126d27-d42d-48a7-bce5-f1942a12b846","artistId":"3bcd6c98-08d9-4008-8b5f-72ce8a10afa5","displayText":"Archaios"}},{"type":"text","text":" y «Voces en el Plasma»."}]},{"type":"paragraph","content":[{"type":"text","text":"Baterista del metal y el rock dominicanos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La base de datos internacional Encyclopaedia Metallum lo registra como baterista anterior de "},{"type":"artistReference","attrs":{"occurrenceId":"a7bb5048-4c9f-4339-a26f-8549685d593f","artistId":"3bcd6c98-08d9-4008-8b5f-72ce8a10afa5","displayText":"Archaios"}},{"type":"text","text":", y una reseña del álbum «The Distant» de 2011 destacó la precisión de su batería y su capacidad para pasar de partes técnicas a blast beats. También figura con «Altus Mortem», «Hester Prynne», «Post Mortem» y «Exsanguination Throne», que en 2011 nombró un sustituto suyo mientras estaba en Estados Unidos, y su propio perfil enumera a "},{"type":"artistReference","attrs":{"occurrenceId":"99c735c6-cb6a-42e1-a71e-a56fe3978376","artistId":"8400a1c5-0f35-4121-ba11-a887a7312443","displayText":"Santuario"}},{"type":"text","text":", «Medullah» y «Mike Massacred» entre sus bandas."}]},{"type":"paragraph","content":[{"type":"text","text":"«Voces en el Plasma»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Es el baterista de la banda de rock «Voces en el Plasma», formada a finales de 2002, que publicó «La Inmaculada Brevedad de la Carne» en 2004 y «Las Fábulas del Hambre» en 2010 y regresó en 2022 con el sencillo «La Voz» y el álbum «La Galaxia Caníbal» de 2023. En la entrevista de Discolai sobre ese regreso la banda dijo que era el único de sus cuatro integrantes que se dedica por completo a la música, como baterista de muchas bandas e ingeniero especializado en sonido y multimedia; entonces vivía en Texas."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su trayectoria está documentada en los créditos de las bandas y en la cobertura de prensa de los grupos en los que ha tocado, y figura también como integrante del trío «El Trio»."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'johandy-urena'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'johandy-urena' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '6f126d27-d42d-48a7-bce5-f1942a12b846', 'artist', '3bcd6c98-08d9-4008-8b5f-72ce8a10afa5' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johandy-urena' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'a7bb5048-4c9f-4339-a26f-8549685d593f', 'artist', '3bcd6c98-08d9-4008-8b5f-72ce8a10afa5' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johandy-urena' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '99c735c6-cb6a-42e1-a71e-a56fe3978376', 'artist', '8400a1c5-0f35-4121-ba11-a887a7312443' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johandy-urena' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Johandy Ureña —Johandy Ureña Guaba— es un baterista e ingeniero de audio dominicano que ha tocado en varias de las bandas de rock y metal del país, entre ellas Archaios y «Voces en el Plasma».

**Baterista del metal y el rock dominicanos**

La base de datos internacional Encyclopaedia Metallum lo registra como baterista anterior de Archaios, y una reseña del álbum «The Distant» de 2011 destacó la precisión de su batería y su capacidad para pasar de partes técnicas a blast beats. También figura con «Altus Mortem», «Hester Prynne», «Post Mortem» y «Exsanguination Throne», que en 2011 nombró un sustituto suyo mientras estaba en Estados Unidos, y su propio perfil enumera a Santuario, «Medullah» y «Mike Massacred» entre sus bandas.

**«Voces en el Plasma»**

Es el baterista de la banda de rock «Voces en el Plasma», formada a finales de 2002, que publicó «La Inmaculada Brevedad de la Carne» en 2004 y «Las Fábulas del Hambre» en 2010 y regresó en 2022 con el sencillo «La Voz» y el álbum «La Galaxia Caníbal» de 2023. En la entrevista de Discolai sobre ese regreso la banda dijo que era el único de sus cuatro integrantes que se dedica por completo a la música, como baterista de muchas bandas e ingeniero especializado en sonido y multimedia; entonces vivía en Texas.

**Legado**

Su trayectoria está documentada en los créditos de las bandas y en la cobertura de prensa de los grupos en los que ha tocado, y figura también como integrante del trío «El Trio».' WHERE slug = 'johandy-urena';

COMMIT;
