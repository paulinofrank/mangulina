BEGIN;

-- Apofis Imn: enlaza a Soul of Death, ya publicada.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Apofis Imn is a Dominican black metal band founded in Santo Domingo under the name Amon, which has been based in Buenos Aires, Argentina, in its later years.","type":"text"}]},{"type":"paragraph","content":[{"text":"From Amon to Apofis Imn","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Catalogues of Dominican metal date the band to 2001, when it began as Amon; its own Bandcamp page puts the founding in 2003 and credits it to the guitarist and singer Abraxas Satanas, and the international metal database Encyclopaedia Metallum lists it as Apofis Imn from 2010. Its themes are darkness, ancient gods, occultism, spirituality, misanthropy and anti-Christianity.","type":"text"}]},{"type":"paragraph","content":[{"text":"Lineup","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Abraxas Satanas has sung and played guitar since 2010. Vasago Imn, who earlier played in ","type":"text"},{"type":"text","text":""},{"type":"artistReference","attrs":{"occurrenceId":"03fa89a0-2c14-4b56-81b3-3d0a8cdb62dc","artistId":"ea2d1a26-e4d8-4daf-b487-52fe68faad36","displayText":"Soul of Death"}},{"text":", played guitar until 2012 and has played bass since; Draconum Oth Neghor moved from bass to drums in the same year, and Gaia Marion has added samples since 2019.","type":"text"}]},{"type":"paragraph","content":[{"text":"Releases","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Encyclopaedia Metallum lists two EPs, «La palabra de Satan» (2015) and «Traicionado por Dios» (2019); the band’s Bandcamp page carries both, dated March 2021, and says its first album was made by the band itself in 2004 under the same title. The band has no label.","type":"text"}]},{"type":"paragraph","content":[{"text":"Legacy","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Apofis Imn appears both in the list of Dominican rock and metal bands compiled by the Enciclopedia Rock Dominicano and in the international black metal archives, where it is listed as active.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'apofis-imn'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists x ON x.id = d.owner_artist_id
    WHERE x.slug = 'apofis-imn' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '03fa89a0-2c14-4b56-81b3-3d0a8cdb62dc', 'artist', 'ea2d1a26-e4d8-4daf-b487-52fe68faad36' FROM editorial_documents d JOIN artists x ON x.id = d.owner_artist_id
   WHERE x.slug = 'apofis-imn' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Apofis Imn is a Dominican black metal band founded in Santo Domingo under the name Amon, which has been based in Buenos Aires, Argentina, in its later years.

**From Amon to Apofis Imn**

Catalogues of Dominican metal date the band to 2001, when it began as Amon; its own Bandcamp page puts the founding in 2003 and credits it to the guitarist and singer Abraxas Satanas, and the international metal database Encyclopaedia Metallum lists it as Apofis Imn from 2010. Its themes are darkness, ancient gods, occultism, spirituality, misanthropy and anti-Christianity.

**Lineup**

Abraxas Satanas has sung and played guitar since 2010. Vasago Imn, who earlier played in Soul of Death, played guitar until 2012 and has played bass since; Draconum Oth Neghor moved from bass to drums in the same year, and Gaia Marion has added samples since 2019.

**Releases**

Encyclopaedia Metallum lists two EPs, «La palabra de Satan» (2015) and «Traicionado por Dios» (2019); the band’s Bandcamp page carries both, dated March 2021, and says its first album was made by the band itself in 2004 under the same title. The band has no label.

**Legacy**

Apofis Imn appears both in the list of Dominican rock and metal bands compiled by the Enciclopedia Rock Dominicano and in the international black metal archives, where it is listed as active.' WHERE slug = 'apofis-imn';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Apofis Imn es una banda dominicana de black metal fundada en Santo Domingo con el nombre de Amon, que en sus últimos años ha estado radicada en Buenos Aires, Argentina.","type":"text"}]},{"type":"paragraph","content":[{"text":"De Amon a Apofis Imn","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Los catálogos del metal dominicano fechan la banda en 2001, cuando empezó como Amon; su propia página de Bandcamp sitúa la fundación en 2003 y se la atribuye al guitarrista y cantante Abraxas Satanas, y la base de datos internacional Encyclopaedia Metallum la registra como Apofis Imn desde 2010. Sus temas son la oscuridad, los dioses antiguos, el ocultismo, la espiritualidad, la misantropía y el anticristianismo.","type":"text"}]},{"type":"paragraph","content":[{"text":"Alineación","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Abraxas Satanas canta y toca la guitarra desde 2010. Vasago Imn, que antes tocó en ","type":"text"},{"type":"text","text":""},{"type":"artistReference","attrs":{"occurrenceId":"9a37f02c-cf39-47e7-bf63-6c6eefbd2024","artistId":"ea2d1a26-e4d8-4daf-b487-52fe68faad36","displayText":"Soul of Death"}},{"text":", tocó la guitarra hasta 2012 y desde entonces el bajo; Draconum Oth Neghor pasó del bajo a la batería ese mismo año, y Gaia Marion aporta samples desde 2019.","type":"text"}]},{"type":"paragraph","content":[{"text":"Grabaciones","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Encyclopaedia Metallum lista dos EP, «La palabra de Satan» (2015) y «Traicionado por Dios» (2019); la página de Bandcamp de la banda incluye ambos, con fecha de marzo de 2021, y afirma que su primer álbum lo hizo la propia banda en 2004 con ese mismo título. La banda no tiene sello.","type":"text"}]},{"type":"paragraph","content":[{"text":"Legado","type":"text","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"text":"Apofis Imn figura tanto en el listado de bandas dominicanas de rock y metal que reúne la Enciclopedia Rock Dominicano como en los archivos internacionales de black metal, donde se la registra como activa.","type":"text"}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'apofis-imn'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists x ON x.id = d.owner_artist_id
    WHERE x.slug = 'apofis-imn' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '9a37f02c-cf39-47e7-bf63-6c6eefbd2024', 'artist', 'ea2d1a26-e4d8-4daf-b487-52fe68faad36' FROM editorial_documents d JOIN artists x ON x.id = d.owner_artist_id
   WHERE x.slug = 'apofis-imn' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Apofis Imn es una banda dominicana de black metal fundada en Santo Domingo con el nombre de Amon, que en sus últimos años ha estado radicada en Buenos Aires, Argentina.

**De Amon a Apofis Imn**

Los catálogos del metal dominicano fechan la banda en 2001, cuando empezó como Amon; su propia página de Bandcamp sitúa la fundación en 2003 y se la atribuye al guitarrista y cantante Abraxas Satanas, y la base de datos internacional Encyclopaedia Metallum la registra como Apofis Imn desde 2010. Sus temas son la oscuridad, los dioses antiguos, el ocultismo, la espiritualidad, la misantropía y el anticristianismo.

**Alineación**

Abraxas Satanas canta y toca la guitarra desde 2010. Vasago Imn, que antes tocó en Soul of Death, tocó la guitarra hasta 2012 y desde entonces el bajo; Draconum Oth Neghor pasó del bajo a la batería ese mismo año, y Gaia Marion aporta samples desde 2019.

**Grabaciones**

Encyclopaedia Metallum lista dos EP, «La palabra de Satan» (2015) y «Traicionado por Dios» (2019); la página de Bandcamp de la banda incluye ambos, con fecha de marzo de 2021, y afirma que su primer álbum lo hizo la propia banda en 2004 con ese mismo título. La banda no tiene sello.

**Legado**

Apofis Imn figura tanto en el listado de bandas dominicanas de rock y metal que reúne la Enciclopedia Rock Dominicano como en los archivos internacionales de black metal, donde se la registra como activa.' WHERE slug = 'apofis-imn';

COMMIT;
