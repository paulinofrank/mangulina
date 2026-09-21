BEGIN;

-- Johnny Chocolate (Juan de la Cruz): tamborero. Fuentes: créditos de grabación repetidos en notas de prensa (Chichi Peralta 'El cofrecito', Mark B, Chiquito Team Band) y un video que lo presenta como la tambora de Juan Luis Guerra 4.40; sin entrevista ni biografía publicada. Campos: occupations percussionist, instruments tambora.

UPDATE artists SET occupations = '["percussionist"]'::jsonb, instruments = ARRAY['tambora']::text[] WHERE slug = 'johnny-chocolate';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Johnny Chocolate —Juan de la Cruz— is a Dominican percussionist who plays the tambora, the two-headed drum at the heart of merengue."}]},{"type":"paragraph","content":[{"type":"text","text":"In the studio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He is credited as the tambora player on recordings by a merengue rhythm section that also lists Luis Mojica on congas, Rafael Carrasco on güira, Junior Mayol on saxophones and José Luis Mateo on trumpets. Press notes name him on new songs by "},{"type":"artistReference","attrs":{"occurrenceId":"c51fd725-9bdb-46fa-87ae-1bc916a5e79d","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"93dbc1b2-eeb4-417b-b0ec-97675b16c856","artistId":"fba607fa-ffee-48a2-aa07-ee175a8837f1","displayText":"Mark B"}},{"type":"text","text":", and on a release by the salsa group "},{"type":"artistReference","attrs":{"occurrenceId":"c58d2eab-16cb-4acf-8d25-7683a20f4ae6","artistId":"c48f976c-c4cc-4d8c-a777-844a2e865147","displayText":"Chiquito Team Band"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"With Juan Luis Guerra","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A video published by a Dominican media page presents him as the tambora player of "},{"type":"artistReference","attrs":{"occurrenceId":"4cd626eb-0a98-4ed0-974b-9420670858c3","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra"}},{"type":"text","text":"’s 4.40, playing the traditional second pattern of merengue."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fellow musicians describe him in public messages as an outstanding tambora player; one calls him the most complete tamborero of all time. His work is documented mainly through recording credits."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'johnny-chocolate'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'johnny-chocolate' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c51fd725-9bdb-46fa-87ae-1bc916a5e79d', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johnny-chocolate' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '93dbc1b2-eeb4-417b-b0ec-97675b16c856', 'artist', 'fba607fa-ffee-48a2-aa07-ee175a8837f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johnny-chocolate' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c58d2eab-16cb-4acf-8d25-7683a20f4ae6', 'artist', 'c48f976c-c4cc-4d8c-a777-844a2e865147' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johnny-chocolate' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '4cd626eb-0a98-4ed0-974b-9420670858c3', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johnny-chocolate' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Johnny Chocolate —Juan de la Cruz— is a Dominican percussionist who plays the tambora, the two-headed drum at the heart of merengue.

**In the studio**

He is credited as the tambora player on recordings by a merengue rhythm section that also lists Luis Mojica on congas, Rafael Carrasco on güira, Junior Mayol on saxophones and José Luis Mateo on trumpets. Press notes name him on new songs by Chichi Peralta and Mark B, and on a release by the salsa group Chiquito Team Band.

**With Juan Luis Guerra**

A video published by a Dominican media page presents him as the tambora player of Juan Luis Guerra’s 4.40, playing the traditional second pattern of merengue.

**Legacy**

Fellow musicians describe him in public messages as an outstanding tambora player; one calls him the most complete tamborero of all time. His work is documented mainly through recording credits.' WHERE slug = 'johnny-chocolate';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Johnny Chocolate —Juan de la Cruz— es un percusionista dominicano que toca la tambora, el tambor de dos parches que está en el corazón del merengue."}]},{"type":"paragraph","content":[{"type":"text","text":"En el estudio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Figura como tamborero en grabaciones de una sección rítmica de merengue que incluye también a Luis Mojica en las congas, Rafael Carrasco en la güira, Junior Mayol en los saxofones y José Luis Mateo en las trompetas. Notas de prensa lo nombran en canciones nuevas de "},{"type":"artistReference","attrs":{"occurrenceId":"aed88986-faad-4377-b140-8d8a30d73bb3","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"fcd56a43-53f8-4257-aec6-524493607224","artistId":"fba607fa-ffee-48a2-aa07-ee175a8837f1","displayText":"Mark B"}},{"type":"text","text":", y en un lanzamiento del grupo de salsa "},{"type":"artistReference","attrs":{"occurrenceId":"94be929f-73b3-438f-8953-9d97035f329d","artistId":"c48f976c-c4cc-4d8c-a777-844a2e865147","displayText":"Chiquito Team Band"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Con Juan Luis Guerra","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Un video publicado por una página de medios dominicana lo presenta como el tamborero de la 4.40 de "},{"type":"artistReference","attrs":{"occurrenceId":"628c7d1b-4318-43de-9db2-aecf3d87589e","artistId":"10034596-47cb-46ba-9e80-9ea319a2c0df","displayText":"Juan Luis Guerra"}},{"type":"text","text":", tocando el patrón de segunda del merengue tradicional."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Colegas lo describen en mensajes públicos como un tamborero sobresaliente; uno lo llama el tamborero más completo de todos los tiempos. Su trabajo está documentado sobre todo en los créditos de grabaciones."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'johnny-chocolate'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'johnny-chocolate' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'aed88986-faad-4377-b140-8d8a30d73bb3', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johnny-chocolate' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'fcd56a43-53f8-4257-aec6-524493607224', 'artist', 'fba607fa-ffee-48a2-aa07-ee175a8837f1' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johnny-chocolate' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '94be929f-73b3-438f-8953-9d97035f329d', 'artist', 'c48f976c-c4cc-4d8c-a777-844a2e865147' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johnny-chocolate' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '628c7d1b-4318-43de-9db2-aecf3d87589e', 'artist', '10034596-47cb-46ba-9e80-9ea319a2c0df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'johnny-chocolate' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Johnny Chocolate —Juan de la Cruz— es un percusionista dominicano que toca la tambora, el tambor de dos parches que está en el corazón del merengue.

**En el estudio**

Figura como tamborero en grabaciones de una sección rítmica de merengue que incluye también a Luis Mojica en las congas, Rafael Carrasco en la güira, Junior Mayol en los saxofones y José Luis Mateo en las trompetas. Notas de prensa lo nombran en canciones nuevas de Chichi Peralta y Mark B, y en un lanzamiento del grupo de salsa Chiquito Team Band.

**Con Juan Luis Guerra**

Un video publicado por una página de medios dominicana lo presenta como el tamborero de la 4.40 de Juan Luis Guerra, tocando el patrón de segunda del merengue tradicional.

**Legado**

Colegas lo describen en mensajes públicos como un tamborero sobresaliente; uno lo llama el tamborero más completo de todos los tiempos. Su trabajo está documentado sobre todo en los créditos de grabaciones.' WHERE slug = 'johnny-chocolate';

COMMIT;
