BEGIN;

-- Darlyn y Los Herederos: grupo de merengue de Bonao dirigido por Darlyn Madé, no un grupo genérico 'de merengue y tropical'. Fuentes: AllMusic (biografía de Stacia Proefrock: empezó a cantar a los 7 años en festivales de Bonao; pasó por Coco Band y La Muralla; álbum Pruébame a los 19 con distribución de una discográfica grande; sencillo «Lamparita»), Apple Music y Audiomack (Pruébame 1999, Platano Records), MusicBrainz (Pruébame 11 ene. 2000; Sin ti 17 abr. 2001), El Caribe (25 oct. 2021, titular sobre su regreso a los escenarios; artículo no abierto por bloqueo de la página), YouTube Topic y Spotify (reediciones digitales, 'Mi tierra' 2025, remix de Pruébame con Bayron Fire, ago. 2026). Conflicto: Pruébame 1999 (Apple, Audiomack) frente a 2000 (MusicBrainz, AllMusic). Campos: occupations bandleader (era musician). Tipo de fila sigue solo_artist con nombre de grupo: separación pendiente (memoria separar-persona-de-agrupacion). Excluido: videos de chismes sobre 'ascenso y caída' y enemistad con Héctor Acosta.

UPDATE artists SET occupations = '["bandleader"]'::jsonb WHERE slug = 'darlyn-y-los-herederos';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Darlyn y Los Herederos is a Dominican merengue group from Bonao led by the singer Darlyn Madé, who created it."}]},{"type":"paragraph","content":[{"type":"text","text":"Darlyn Madé","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"AllMusic reports that Madé began singing at the age of seven in festivals in his hometown of Bonao. Before forming his own group he played in successful merengue bands, among them Coco Band and "},{"type":"artistReference","attrs":{"occurrenceId":"1f119fc1-c6ed-4ae3-b371-245a4ef56bab","artistId":"b181edca-515a-45ad-8fae-8b61195de1cc","displayText":"Orquesta La Muralla"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Records","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The group’s first album, «Pruébame», was issued when Madé was nineteen, with distribution by a major label; streaming platforms date it to 1999 under Platano Records, while MusicBrainz and AllMusic give 2000. It mixes romantic ballads and dance numbers, and its lead single was «Lamparita». A second album, «Sin ti», followed in 2001. Both appear on digital platforms in releases dated September 2025."}]},{"type":"paragraph","content":[{"type":"text","text":"Return","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In October 2021 the newspaper El Caribe reported that Madé, leader and creator of Los Herederos, was returning to the stages. Later releases include the single «Mi tierra» (2025) and, in August 2026, a remix of «Pruébame» with Bayron Fire."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The group is documented mainly through its two albums from the turn of the century and the digital reissues of them."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'darlyn-y-los-herederos'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'darlyn-y-los-herederos' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '1f119fc1-c6ed-4ae3-b371-245a4ef56bab', 'artist', 'b181edca-515a-45ad-8fae-8b61195de1cc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'darlyn-y-los-herederos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Darlyn y Los Herederos is a Dominican merengue group from Bonao led by the singer Darlyn Madé, who created it.

**Darlyn Madé**

AllMusic reports that Madé began singing at the age of seven in festivals in his hometown of Bonao. Before forming his own group he played in successful merengue bands, among them Coco Band and Orquesta La Muralla.

**Records**

The group’s first album, «Pruébame», was issued when Madé was nineteen, with distribution by a major label; streaming platforms date it to 1999 under Platano Records, while MusicBrainz and AllMusic give 2000. It mixes romantic ballads and dance numbers, and its lead single was «Lamparita». A second album, «Sin ti», followed in 2001. Both appear on digital platforms in releases dated September 2025.

**Return**

In October 2021 the newspaper El Caribe reported that Madé, leader and creator of Los Herederos, was returning to the stages. Later releases include the single «Mi tierra» (2025) and, in August 2026, a remix of «Pruébame» with Bayron Fire.

**Legacy**

The group is documented mainly through its two albums from the turn of the century and the digital reissues of them.' WHERE slug = 'darlyn-y-los-herederos';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Darlyn y Los Herederos es un grupo dominicano de merengue de Bonao dirigido por el cantante Darlyn Madé, que lo creó."}]},{"type":"paragraph","content":[{"type":"text","text":"Darlyn Madé","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"AllMusic informa que Madé empezó a cantar a los siete años en festivales de su ciudad natal, Bonao. Antes de formar su propio grupo tocó en exitosas orquestas de merengue, entre ellas Coco Band y "},{"type":"artistReference","attrs":{"occurrenceId":"295dcdf8-98bb-449a-a7ba-b4e193d75964","artistId":"b181edca-515a-45ad-8fae-8b61195de1cc","displayText":"Orquesta La Muralla"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Discos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El primer álbum del grupo, «Pruébame», salió cuando Madé tenía diecinueve años, con distribución de una discográfica grande; las plataformas de streaming lo fechan en 1999 bajo Platano Records, mientras que MusicBrainz y AllMusic dan 2000. Mezcla baladas románticas y temas bailables, y su sencillo principal fue «Lamparita». Un segundo álbum, «Sin ti», siguió en 2001. Ambos aparecen en las plataformas digitales en ediciones fechadas en septiembre de 2025."}]},{"type":"paragraph","content":[{"type":"text","text":"Regreso","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En octubre de 2021 el periódico El Caribe informó que Madé, líder y creador de Los Herederos, volvía a los escenarios. Entre los lanzamientos posteriores figuran el sencillo «Mi tierra» (2025) y, en agosto de 2026, un remix de «Pruébame» con Bayron Fire."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El grupo está documentado sobre todo a través de sus dos álbumes de comienzos de siglo y de las reediciones digitales de ellos."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'darlyn-y-los-herederos'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'darlyn-y-los-herederos' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '295dcdf8-98bb-449a-a7ba-b4e193d75964', 'artist', 'b181edca-515a-45ad-8fae-8b61195de1cc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'darlyn-y-los-herederos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Darlyn y Los Herederos es un grupo dominicano de merengue de Bonao dirigido por el cantante Darlyn Madé, que lo creó.

**Darlyn Madé**

AllMusic informa que Madé empezó a cantar a los siete años en festivales de su ciudad natal, Bonao. Antes de formar su propio grupo tocó en exitosas orquestas de merengue, entre ellas Coco Band y Orquesta La Muralla.

**Discos**

El primer álbum del grupo, «Pruébame», salió cuando Madé tenía diecinueve años, con distribución de una discográfica grande; las plataformas de streaming lo fechan en 1999 bajo Platano Records, mientras que MusicBrainz y AllMusic dan 2000. Mezcla baladas románticas y temas bailables, y su sencillo principal fue «Lamparita». Un segundo álbum, «Sin ti», siguió en 2001. Ambos aparecen en las plataformas digitales en ediciones fechadas en septiembre de 2025.

**Regreso**

En octubre de 2021 el periódico El Caribe informó que Madé, líder y creador de Los Herederos, volvía a los escenarios. Entre los lanzamientos posteriores figuran el sencillo «Mi tierra» (2025) y, en agosto de 2026, un remix de «Pruébame» con Bayron Fire.

**Legado**

El grupo está documentado sobre todo a través de sus dos álbumes de comienzos de siglo y de las reediciones digitales de ellos.' WHERE slug = 'darlyn-y-los-herederos';

COMMIT;
