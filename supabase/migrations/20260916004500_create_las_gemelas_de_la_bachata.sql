BEGIN;

-- Ficha NUEVA MÍNIMA: Las Gemelas de la Bachata, dúo emergente de gemelas. Sin nombres reales ni datos de nacimiento (menores).

INSERT INTO artists (name, sort_name, type, gender, ended, slug, youtube, facebook, primary_role, occupations, instruments, genres,
                                 aliases, artist_tags, status, primary_genre, has_image, id)
  VALUES ('Las Gemelas de la Bachata', 'Gemelas de la Bachata, Las', 'duo', 'female', false, 'las-gemelas-de-la-bachata', '@Lasgemelas30', 'profile.php?id=61586681583438',
          'singer', '[]'::jsonb, '{}'::text[], '{}'::text[], '{}'::text[], ARRAY['secular','emerging']::text[], 'published', 'bachata', false, '91eff9cf-da9d-44a3-8a25-0ba984668a54');

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Las Gemelas de la Bachata is an emerging Dominican bachata duo of twin sisters who have released their songs through their own YouTube channel since 2022. They are best known for «Quiero Ser Como Tú», a collaboration with "},{"type":"artistReference","attrs":{"occurrenceId":"9cfc005f-8f8d-4b08-951f-b3dd29ac3d37","artistId":"4f331050-2568-42a4-a73b-7f9a731f1df4","displayText":"Dalvin la Melodía"}},{"type":"text","text":" released in January 2026 that has passed 85,000 views."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Their catalogue so far also includes «Masoquista» (October 2025), «Me Voy Emborrachar» (March 2026), «Te Recordaré», a tribute to "},{"type":"artistReference","attrs":{"occurrenceId":"cfe740f0-37a3-4855-81c9-dbc77133f5f2","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":" (September 2026), and «Cuiden Los Niños» (September 2026)."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'las-gemelas-de-la-bachata';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '9cfc005f-8f8d-4b08-951f-b3dd29ac3d37', 'artist', '4f331050-2568-42a4-a73b-7f9a731f1df4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'las-gemelas-de-la-bachata' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'cfe740f0-37a3-4855-81c9-dbc77133f5f2', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'las-gemelas-de-la-bachata' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Las Gemelas de la Bachata is an emerging Dominican bachata duo of twin sisters who have released their songs through their own YouTube channel since 2022. They are best known for «Quiero Ser Como Tú», a collaboration with Dalvin la Melodía released in January 2026 that has passed 85,000 views.

**Legacy**

Their catalogue so far also includes «Masoquista» (October 2025), «Me Voy Emborrachar» (March 2026), «Te Recordaré», a tribute to Rubby Pérez (September 2026), and «Cuiden Los Niños» (September 2026).' WHERE slug = 'las-gemelas-de-la-bachata';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Las Gemelas de la Bachata es un dúo emergente dominicano de bachata formado por dos hermanas gemelas que publican sus canciones desde 2022 en su propio canal de YouTube. Son conocidas sobre todo por «Quiero Ser Como Tú», colaboración con "},{"type":"artistReference","attrs":{"occurrenceId":"adfbea86-d88e-4fc1-b392-45d2de83b03e","artistId":"4f331050-2568-42a4-a73b-7f9a731f1df4","displayText":"Dalvin la Melodía"}},{"type":"text","text":" lanzada en enero de 2026 que supera las 85 000 vistas."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su catálogo hasta ahora incluye además «Masoquista» (octubre de 2025), «Me Voy Emborrachar» (marzo de 2026), «Te Recordaré», homenaje a "},{"type":"artistReference","attrs":{"occurrenceId":"60e38a9b-92cd-44ad-807a-70a775ef5aa4","artistId":"cff70c92-8632-4c66-b5a0-81622c8128b0","displayText":"Rubby Pérez"}},{"type":"text","text":" (septiembre de 2026), y «Cuiden Los Niños» (septiembre de 2026)."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'las-gemelas-de-la-bachata';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'adfbea86-d88e-4fc1-b392-45d2de83b03e', 'artist', '4f331050-2568-42a4-a73b-7f9a731f1df4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'las-gemelas-de-la-bachata' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '60e38a9b-92cd-44ad-807a-70a775ef5aa4', 'artist', 'cff70c92-8632-4c66-b5a0-81622c8128b0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'las-gemelas-de-la-bachata' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Las Gemelas de la Bachata es un dúo emergente dominicano de bachata formado por dos hermanas gemelas que publican sus canciones desde 2022 en su propio canal de YouTube. Son conocidas sobre todo por «Quiero Ser Como Tú», colaboración con Dalvin la Melodía lanzada en enero de 2026 que supera las 85 000 vistas.

**Legado**

Su catálogo hasta ahora incluye además «Masoquista» (octubre de 2025), «Me Voy Emborrachar» (marzo de 2026), «Te Recordaré», homenaje a Rubby Pérez (septiembre de 2026), y «Cuiden Los Niños» (septiembre de 2026).' WHERE slug = 'las-gemelas-de-la-bachata';

COMMIT;
