BEGIN;

-- Chris Alflow (Cristopher Valdez Almonte): dembowero de Santo Domingo Este; el relleno era genérico. Fuentes: su canal oficial de YouTube (LA OREO con Épico Sorprendente, prod. B One, dembow 2020), Audiomack (fecha de lanzamiento 20-21 mar. 2020), SoundCloud, Chartmetric (nombre completo y ocupaciones: cantante, compositor, rapero, guitarrista, actor y productor), MusicBrainz (nacimiento 16 sep. 1995), su página de Facebook (mánager y colaboración). No hay prensa independiente ni entrevista: ficha mínima, con las ocupaciones atribuidas a un perfil de datos. Campos: sin cambios salvo occupations (songwriter, rapper, producer). Sin ficha: Épico Sorprendente, B One.

UPDATE artists SET occupations = '["songwriter","rapper","producer"]'::jsonb WHERE slug = 'chris-alflow';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Chris Alflow —Cristopher Valdez Almonte, born on 16 September 1995— is a Dominican dembow singer from Santo Domingo Este."}]},{"type":"paragraph","content":[{"type":"text","text":"Dembow","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A music-data profile describes him as a singer, songwriter, rapper, guitarist, actor and record producer. His best-known release is «La Oreo», recorded with Épico Sorprendente and produced by B One, which appeared on his official YouTube channel and on streaming platforms in March 2020 under the tag «Dembow 2020»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His work is documented through «La Oreo» and his own channels."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'chris-alflow'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'chris-alflow' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Chris Alflow —Cristopher Valdez Almonte, born on 16 September 1995— is a Dominican dembow singer from Santo Domingo Este.

**Dembow**

A music-data profile describes him as a singer, songwriter, rapper, guitarist, actor and record producer. His best-known release is «La Oreo», recorded with Épico Sorprendente and produced by B One, which appeared on his official YouTube channel and on streaming platforms in March 2020 under the tag «Dembow 2020».

**Legacy**

His work is documented through «La Oreo» and his own channels.' WHERE slug = 'chris-alflow';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Chris Alflow —Cristopher Valdez Almonte, nacido el 16 de septiembre de 1995— es un cantante dominicano de dembow de Santo Domingo Este."}]},{"type":"paragraph","content":[{"type":"text","text":"Dembow","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Un perfil de datos musicales lo describe como cantante, compositor, rapero, guitarrista, actor y productor discográfico. Su lanzamiento más conocido es «La Oreo», grabado con Épico Sorprendente y producido por B One, que apareció en su canal oficial de YouTube y en las plataformas en marzo de 2020 bajo la etiqueta «Dembow 2020»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su obra está documentada a través de «La Oreo» y de sus propios canales."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'chris-alflow'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'chris-alflow' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Chris Alflow —Cristopher Valdez Almonte, nacido el 16 de septiembre de 1995— es un cantante dominicano de dembow de Santo Domingo Este.

**Dembow**

Un perfil de datos musicales lo describe como cantante, compositor, rapero, guitarrista, actor y productor discográfico. Su lanzamiento más conocido es «La Oreo», grabado con Épico Sorprendente y producido por B One, que apareció en su canal oficial de YouTube y en las plataformas en marzo de 2020 bajo la etiqueta «Dembow 2020».

**Legado**

Su obra está documentada a través de «La Oreo» y de sus propios canales.' WHERE slug = 'chris-alflow';

COMMIT;
