BEGIN;

-- Ficha de Alberto «Ringo» Martínez.
--
-- La biografía de relleno lo describía en términos genéricos, sin nombrar La Patrulla 15,
-- Caña Brava ni ningún otro hecho verificable. No se fija lugar ni fecha de nacimiento por
-- falta de fuente confiable propia (ver nota en el encabezado del script). Vivian Martínez y
-- Víctor García no tienen ficha: ver ARTISTAS_FALTANTES.md.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Alberto «Ringo» Martínez is a Dominican pianist, arranger, composer and producer, co-founder with Jossie Esteban of the merengue orchestra "},{"type":"artistReference","attrs":{"occurrenceId":"382d5416-4e9d-4230-9dfe-e195f6dc1409","artistId":"02b306b3-acc0-4800-b314-05683205d1c5","displayText":"Jossie Esteban y La Patrulla 15"}},{"type":"text","text":" and one of the architects of the genre’s sound through the 1980s and 1990s."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Patrulla 15»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1979, in La Vega, he and his childhood friend Jossie Esteban formed the orchestra that carried both their names, mixing Dominican and Puerto Rican musicians — among them the bassist and arranger "},{"type":"artistReference","attrs":{"occurrenceId":"ac2ca9c4-c169-4587-a31d-f1999544d0e8","artistId":"db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250","displayText":"Henry Hierro"}},{"type":"text","text":" — over a run of some twenty-five albums and decades of steady touring."}]},{"type":"paragraph","content":[{"type":"text","text":"Beyond the Patrulla","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Alongside that career he founded and produced his own groups: «Caña Brava», whose 1996 album «Quieren mi caña» gave the band its best-known song and whose 1992 record carried «No me faltes nunca», written by Vivian Martínez and Víctor García; «Las Nenas de R&J»; and «Fuego 440»."}]},{"type":"paragraph","content":[{"type":"text","text":"A recovery","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In January 2021 he was hospitalized in intensive care with COVID-19; a month later, on 8 February, he was discharged after a steady recovery, a story Dominican press covered as one of merengue’s own close calls with the pandemic."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Four decades after two young friends from La Vega put together an orchestra, Martínez remains one of the genre’s working architects, still credited on the arrangements and productions that keep merengue’s older sound alive."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alberto-ringo-martinez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'alberto-ringo-martinez' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '382d5416-4e9d-4230-9dfe-e195f6dc1409', 'artist', '02b306b3-acc0-4800-b314-05683205d1c5' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alberto-ringo-martinez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ac2ca9c4-c169-4587-a31d-f1999544d0e8', 'artist', 'db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alberto-ringo-martinez' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Alberto «Ringo» Martínez is a Dominican pianist, arranger, composer and producer, co-founder with Jossie Esteban of the merengue orchestra Jossie Esteban y La Patrulla 15 and one of the architects of the genre’s sound through the 1980s and 1990s.

**«La Patrulla 15»**

In 1979, in La Vega, he and his childhood friend Jossie Esteban formed the orchestra that carried both their names, mixing Dominican and Puerto Rican musicians — among them the bassist and arranger Henry Hierro — over a run of some twenty-five albums and decades of steady touring.

**Beyond the Patrulla**

Alongside that career he founded and produced his own groups: «Caña Brava», whose 1996 album «Quieren mi caña» gave the band its best-known song and whose 1992 record carried «No me faltes nunca», written by Vivian Martínez and Víctor García; «Las Nenas de R&J»; and «Fuego 440».

**A recovery**

In January 2021 he was hospitalized in intensive care with COVID-19; a month later, on 8 February, he was discharged after a steady recovery, a story Dominican press covered as one of merengue’s own close calls with the pandemic.

**Legacy**

Four decades after two young friends from La Vega put together an orchestra, Martínez remains one of the genre’s working architects, still credited on the arrangements and productions that keep merengue’s older sound alive.' WHERE slug = 'alberto-ringo-martinez';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Alberto «Ringo» Martínez es pianista, arreglista, compositor y productor dominicano, cofundador junto a Jossie Esteban de la orquesta de merengue "},{"type":"artistReference","attrs":{"occurrenceId":"dcf4c9d7-4579-494f-b3a3-40eda88e71d2","artistId":"02b306b3-acc0-4800-b314-05683205d1c5","displayText":"Jossie Esteban y La Patrulla 15"}},{"type":"text","text":" y uno de los artífices del sonido del género a lo largo de los ochenta y los noventa."}]},{"type":"paragraph","content":[{"type":"text","text":"«La Patrulla 15»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1979, en La Vega, él y su amigo de infancia Jossie Esteban formaron la orquesta que llevó los nombres de ambos, mezclando músicos dominicanos y puertorriqueños —entre ellos el bajista y arreglista "},{"type":"artistReference","attrs":{"occurrenceId":"7010331b-9368-416c-b37d-aa4b1c46f8cd","artistId":"db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250","displayText":"Henry Hierro"}},{"type":"text","text":"— a lo largo de unos veinticinco álbumes y décadas de giras constantes."}]},{"type":"paragraph","content":[{"type":"text","text":"Más allá de la Patrulla","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En paralelo a esa carrera fundó y produjo sus propias agrupaciones: «Caña Brava», cuyo álbum de 1996 «Quieren mi caña» le dio al grupo su tema más conocido y cuyo disco de 1992 llevaba «No me faltes nunca», escrita por Vivian Martínez y Víctor García; «Las Nenas de R&J»; y «Fuego 440»."}]},{"type":"paragraph","content":[{"type":"text","text":"Una recuperación","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En enero de 2021 fue hospitalizado en cuidados intensivos por covid-19; un mes después, el 8 de febrero, recibió el alta tras una mejoría progresiva, una historia que la prensa dominicana cubrió como uno de los sustos propios del merengue frente a la pandemia."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cuatro décadas después de que dos amigos jóvenes de La Vega armaran una orquesta, Martínez sigue siendo uno de los artífices en activo del género, todavía acreditado en los arreglos y producciones que mantienen vivo el sonido más viejo del merengue."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'alberto-ringo-martinez'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'alberto-ringo-martinez' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dcf4c9d7-4579-494f-b3a3-40eda88e71d2', 'artist', '02b306b3-acc0-4800-b314-05683205d1c5' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alberto-ringo-martinez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '7010331b-9368-416c-b37d-aa4b1c46f8cd', 'artist', 'db00c1d0-00ce-4bde-9e7e-f5f6a3bd9250' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'alberto-ringo-martinez' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Alberto «Ringo» Martínez es pianista, arreglista, compositor y productor dominicano, cofundador junto a Jossie Esteban de la orquesta de merengue Jossie Esteban y La Patrulla 15 y uno de los artífices del sonido del género a lo largo de los ochenta y los noventa.

**«La Patrulla 15»**

En 1979, en La Vega, él y su amigo de infancia Jossie Esteban formaron la orquesta que llevó los nombres de ambos, mezclando músicos dominicanos y puertorriqueños —entre ellos el bajista y arreglista Henry Hierro— a lo largo de unos veinticinco álbumes y décadas de giras constantes.

**Más allá de la Patrulla**

En paralelo a esa carrera fundó y produjo sus propias agrupaciones: «Caña Brava», cuyo álbum de 1996 «Quieren mi caña» le dio al grupo su tema más conocido y cuyo disco de 1992 llevaba «No me faltes nunca», escrita por Vivian Martínez y Víctor García; «Las Nenas de R&J»; y «Fuego 440».

**Una recuperación**

En enero de 2021 fue hospitalizado en cuidados intensivos por covid-19; un mes después, el 8 de febrero, recibió el alta tras una mejoría progresiva, una historia que la prensa dominicana cubrió como uno de los sustos propios del merengue frente a la pandemia.

**Legado**

Cuatro décadas después de que dos amigos jóvenes de La Vega armaran una orquesta, Martínez sigue siendo uno de los artífices en activo del género, todavía acreditado en los arreglos y producciones que mantienen vivo el sonido más viejo del merengue.' WHERE slug = 'alberto-ringo-martinez';

COMMIT;
