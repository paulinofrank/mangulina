BEGIN;

-- Ficha de Hugo Pérez y sus Quisqueyanos Modernos.
--
-- La biografía de relleno inventaba una lectura simbólica del nombre del grupo sin citar un
-- solo disco o hecho verificable.
-- birth_place/province corregidos de Santo Domingo/Distrito Nacional a Nueva York/Nacido en
-- el Exterior (todos los sellos documentados son neoyorquinos). genres ampliado con salsa.

UPDATE artists SET birth_place = 'Nueva York', province = 'Nacido en el Exterior',
       genres = ARRAY['salsa']::text[]
       WHERE slug = 'hugo-perez-y-sus-quisqueyanos-modernos';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Hugo Pérez y sus Quisqueyanos Modernos was a Dominican merengue orchestra based in New York, active from at least 1962, whose catalogue was built largely out of merengue arrangements of hits from outside the genre, recorded for small Latin labels serving the city’s Dominican and wider Latino audience."}]},{"type":"paragraph","content":[{"type":"text","text":"Small labels, a New York catalogue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Their earliest documented album, «El Rey del Merengue», appeared in 1962; later releases included «Acelerando», produced by Bobby Marin — a fixture of New York’s Latin soul and boogaloo scene — and «Algo Diferente», both issued on Mary Lou Records, alongside further singles pressed on 45 rpm for the same label and for Palma Records."}]},{"type":"paragraph","content":[{"type":"text","text":"Covers turned merengue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The group’s signature move was reworking songs from outside the tradition into merengue arrangements: «El Último Beso», on «Algo Diferente», is a Spanish-language merengue version of the American pop song «Oh Where Can My Baby Be». Their records mixed merengue with cumbia, guaracha and salsa arrangements, of a piece with the pan-Latin dance-orchestra circuit that served New York’s Latino nightlife through the 1960s and 1970s."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Little else is documented today about the group or about Hugo Pérez himself; their records survive mainly in the hands of collectors of vintage New York Latin music."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'hugo-perez-y-sus-quisqueyanos-modernos'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'hugo-perez-y-sus-quisqueyanos-modernos' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Hugo Pérez y sus Quisqueyanos Modernos was a Dominican merengue orchestra based in New York, active from at least 1962, whose catalogue was built largely out of merengue arrangements of hits from outside the genre, recorded for small Latin labels serving the city’s Dominican and wider Latino audience.

**Small labels, a New York catalogue**

Their earliest documented album, «El Rey del Merengue», appeared in 1962; later releases included «Acelerando», produced by Bobby Marin — a fixture of New York’s Latin soul and boogaloo scene — and «Algo Diferente», both issued on Mary Lou Records, alongside further singles pressed on 45 rpm for the same label and for Palma Records.

**Covers turned merengue**

The group’s signature move was reworking songs from outside the tradition into merengue arrangements: «El Último Beso», on «Algo Diferente», is a Spanish-language merengue version of the American pop song «Oh Where Can My Baby Be». Their records mixed merengue with cumbia, guaracha and salsa arrangements, of a piece with the pan-Latin dance-orchestra circuit that served New York’s Latino nightlife through the 1960s and 1970s.

**Legacy**

Little else is documented today about the group or about Hugo Pérez himself; their records survive mainly in the hands of collectors of vintage New York Latin music.' WHERE slug = 'hugo-perez-y-sus-quisqueyanos-modernos';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Hugo Pérez y sus Quisqueyanos Modernos fue una orquesta dominicana de merengue radicada en Nueva York, activa desde al menos 1962, cuyo catálogo se construyó en buena parte a partir de arreglos de merengue de éxitos ajenos al género, grabados para pequeños sellos latinos que atendían al público dominicano y latino en general de la ciudad."}]},{"type":"paragraph","content":[{"type":"text","text":"Sellos pequeños, un catálogo neoyorquino","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su álbum documentado más antiguo, «El Rey del Merengue», apareció en 1962; discos posteriores incluyen «Acelerando», producido por Bobby Marin —figura habitual de la escena de latin soul y boogaloo de Nueva York— y «Algo Diferente», ambos publicados por Mary Lou Records, además de otros sencillos en 45 rpm para ese mismo sello y para Palma Records."}]},{"type":"paragraph","content":[{"type":"text","text":"Versiones convertidas en merengue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El sello distintivo del grupo era convertir en merengue canciones ajenas a la tradición: «El Último Beso», en «Algo Diferente», es una versión en español y en merengue de la canción pop estadounidense «Oh Where Can My Baby Be». Sus discos mezclaban el merengue con arreglos de cumbia, guaracha y salsa, en sintonía con el circuito de orquestas panlatinas que animaba la vida nocturna latina de Nueva York durante los años sesenta y setenta."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Poco más se documenta hoy sobre el grupo o sobre el propio Hugo Pérez; sus discos sobreviven sobre todo en manos de coleccionistas de música latina neoyorquina de época."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'hugo-perez-y-sus-quisqueyanos-modernos'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'hugo-perez-y-sus-quisqueyanos-modernos' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Hugo Pérez y sus Quisqueyanos Modernos fue una orquesta dominicana de merengue radicada en Nueva York, activa desde al menos 1962, cuyo catálogo se construyó en buena parte a partir de arreglos de merengue de éxitos ajenos al género, grabados para pequeños sellos latinos que atendían al público dominicano y latino en general de la ciudad.

**Sellos pequeños, un catálogo neoyorquino**

Su álbum documentado más antiguo, «El Rey del Merengue», apareció en 1962; discos posteriores incluyen «Acelerando», producido por Bobby Marin —figura habitual de la escena de latin soul y boogaloo de Nueva York— y «Algo Diferente», ambos publicados por Mary Lou Records, además de otros sencillos en 45 rpm para ese mismo sello y para Palma Records.

**Versiones convertidas en merengue**

El sello distintivo del grupo era convertir en merengue canciones ajenas a la tradición: «El Último Beso», en «Algo Diferente», es una versión en español y en merengue de la canción pop estadounidense «Oh Where Can My Baby Be». Sus discos mezclaban el merengue con arreglos de cumbia, guaracha y salsa, en sintonía con el circuito de orquestas panlatinas que animaba la vida nocturna latina de Nueva York durante los años sesenta y setenta.

**Legado**

Poco más se documenta hoy sobre el grupo o sobre el propio Hugo Pérez; sus discos sobreviven sobre todo en manos de coleccionistas de música latina neoyorquina de época.' WHERE slug = 'hugo-perez-y-sus-quisqueyanos-modernos';

COMMIT;
