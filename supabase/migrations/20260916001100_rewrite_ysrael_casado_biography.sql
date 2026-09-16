BEGIN;

-- Ficha de Ysrael Casado (Israel Casado).
--
-- La biografía de relleno era completamente genérica, sin nombrar agrupación, colaborador ni
-- hecho real de su carrera como arreglista y director musical.
-- birth_place ampliado de Santo Domingo a Villa Francisca, Santo Domingo. occupations
-- corregido: se retira "musician" (genérico) y se añaden pianist y musical_director.

UPDATE artists SET birth_place = 'Villa Francisca, Santo Domingo',
       occupations = '["pianist","musical_director","producer","composer"]'::jsonb
       WHERE slug = 'ysrael-casado';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Ysrael Casado —born Israel Casado in the Villa Francisca neighborhood of Santo Domingo— is a Dominican pianist, arranger and music director active in merengue since 1982, credited by many as the architect of "},{"type":"artistReference","attrs":{"occurrenceId":"99ee9e8e-73d0-4b2a-88a1-c9d9e3ca0a6a","artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario"}},{"type":"text","text":"’s musical style and, for over thirteen years, the musical director and arranger of "},{"type":"artistReference","attrs":{"occurrenceId":"ef60ba2a-f912-4c6a-b991-27fe0306e725","artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"A difficult artist, an easy friendship","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Casado has said that his long partnership with Rosario worked precisely because friendship outweighed professional distance between them: newer arrangers, he has said, are often intimidated by the singer’s strong will, while Rosario always trusted his opinions. It was Casado who recommended «Quiero Volver a Empezar» to Rosario after his breakup with the Puerto Rican singer Ivette Cintrón, a song that became one of the defining hits of his solo career."}]},{"type":"paragraph","content":[{"type":"text","text":"A change of tempo for Miriam Cruz","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As musical director for "},{"type":"artistReference","attrs":{"occurrenceId":"915f069d-f8cb-4d62-9eb8-04fd02fbcb15","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":"’s orchestra, Casado was tasked by her manager with slowing the group’s tempo, a change that drew some initial criticism but ultimately proved effective, according to both the singer and her management."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Casado has also worked with "},{"type":"artistReference","attrs":{"occurrenceId":"20efed27-158e-4c9b-a414-00fed1becd56","artistId":"15775d55-9e10-46bc-8516-ee7468724ec0","displayText":"Benny Sadel"}},{"type":"text","text":" and with numerous other Latin artists over a decades-long career, during which, by his own account and Dominican press reports, he has won seven Latin Grammy Awards."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'ysrael-casado'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'ysrael-casado' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '99ee9e8e-73d0-4b2a-88a1-c9d9e3ca0a6a', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'ysrael-casado' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'ef60ba2a-f912-4c6a-b991-27fe0306e725', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'ysrael-casado' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '915f069d-f8cb-4d62-9eb8-04fd02fbcb15', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'ysrael-casado' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '20efed27-158e-4c9b-a414-00fed1becd56', 'artist', '15775d55-9e10-46bc-8516-ee7468724ec0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'ysrael-casado' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Ysrael Casado —born Israel Casado in the Villa Francisca neighborhood of Santo Domingo— is a Dominican pianist, arranger and music director active in merengue since 1982, credited by many as the architect of Los Hermanos Rosario’s musical style and, for over thirteen years, the musical director and arranger of Toño Rosario.

**A difficult artist, an easy friendship**

Casado has said that his long partnership with Rosario worked precisely because friendship outweighed professional distance between them: newer arrangers, he has said, are often intimidated by the singer’s strong will, while Rosario always trusted his opinions. It was Casado who recommended «Quiero Volver a Empezar» to Rosario after his breakup with the Puerto Rican singer Ivette Cintrón, a song that became one of the defining hits of his solo career.

**A change of tempo for Miriam Cruz**

As musical director for Miriam Cruz’s orchestra, Casado was tasked by her manager with slowing the group’s tempo, a change that drew some initial criticism but ultimately proved effective, according to both the singer and her management.

**Legacy**

Casado has also worked with Benny Sadel and with numerous other Latin artists over a decades-long career, during which, by his own account and Dominican press reports, he has won seven Latin Grammy Awards.' WHERE slug = 'ysrael-casado';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Ysrael Casado —nacido Israel Casado en el barrio Villa Francisca de Santo Domingo— es pianista, arreglista y director musical dominicano, activo en el merengue desde 1982, señalado por muchos como el arquitecto del estilo musical de "},{"type":"artistReference","attrs":{"occurrenceId":"55af545b-d729-4a2f-aca3-6b875ac40110","artistId":"3422883e-7048-48af-bb03-c68c8c557ee4","displayText":"Los Hermanos Rosario"}},{"type":"text","text":" y, durante más de trece años, director musical y arreglista de "},{"type":"artistReference","attrs":{"occurrenceId":"8e200ae9-8d17-468b-a79e-565857dc4ef6","artistId":"6fc762d4-96b8-4ecf-aca8-fdf52936658e","displayText":"Toño Rosario"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Un artista difícil, una amistad fácil","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Casado ha dicho que su larga sociedad con Rosario funcionó precisamente porque la amistad pesaba más que la distancia profesional entre ambos: los arreglistas más nuevos, según él, suelen intimidarse ante el fuerte carácter del cantante, mientras que Rosario siempre confió en sus opiniones. Fue Casado quien le recomendó «Quiero Volver a Empezar» tras su ruptura con la cantante puertorriqueña Ivette Cintrón, tema que se convirtió en uno de los éxitos definitorios de su carrera como solista."}]},{"type":"paragraph","content":[{"type":"text","text":"Un cambio de velocidad para Miriam Cruz","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Como director musical de la orquesta de "},{"type":"artistReference","attrs":{"occurrenceId":"84401134-9acd-401c-b7bd-d33fe368809c","artistId":"bc2289d0-ae94-48b5-8eb9-7f0ae18b845a","displayText":"Miriam Cruz"}},{"type":"text","text":", su manager le encomendó a Casado bajar la velocidad del grupo, un cambio que generó cierta crítica inicial pero que terminó resultando efectivo, según la propia cantante y su manejo."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Casado también ha trabajado con "},{"type":"artistReference","attrs":{"occurrenceId":"41c05ed4-8f71-4bcf-8e35-9513d838bb0a","artistId":"15775d55-9e10-46bc-8516-ee7468724ec0","displayText":"Benny Sadel"}},{"type":"text","text":" y con numerosos artistas latinos a lo largo de una carrera de décadas, en la que, según su propio testimonio y la prensa dominicana, ha ganado siete premios Latin Grammy."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'ysrael-casado'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'ysrael-casado' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '55af545b-d729-4a2f-aca3-6b875ac40110', 'artist', '3422883e-7048-48af-bb03-c68c8c557ee4' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'ysrael-casado' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '8e200ae9-8d17-468b-a79e-565857dc4ef6', 'artist', '6fc762d4-96b8-4ecf-aca8-fdf52936658e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'ysrael-casado' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '84401134-9acd-401c-b7bd-d33fe368809c', 'artist', 'bc2289d0-ae94-48b5-8eb9-7f0ae18b845a' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'ysrael-casado' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '41c05ed4-8f71-4bcf-8e35-9513d838bb0a', 'artist', '15775d55-9e10-46bc-8516-ee7468724ec0' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'ysrael-casado' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Ysrael Casado —nacido Israel Casado en el barrio Villa Francisca de Santo Domingo— es pianista, arreglista y director musical dominicano, activo en el merengue desde 1982, señalado por muchos como el arquitecto del estilo musical de Los Hermanos Rosario y, durante más de trece años, director musical y arreglista de Toño Rosario.

**Un artista difícil, una amistad fácil**

Casado ha dicho que su larga sociedad con Rosario funcionó precisamente porque la amistad pesaba más que la distancia profesional entre ambos: los arreglistas más nuevos, según él, suelen intimidarse ante el fuerte carácter del cantante, mientras que Rosario siempre confió en sus opiniones. Fue Casado quien le recomendó «Quiero Volver a Empezar» tras su ruptura con la cantante puertorriqueña Ivette Cintrón, tema que se convirtió en uno de los éxitos definitorios de su carrera como solista.

**Un cambio de velocidad para Miriam Cruz**

Como director musical de la orquesta de Miriam Cruz, su manager le encomendó a Casado bajar la velocidad del grupo, un cambio que generó cierta crítica inicial pero que terminó resultando efectivo, según la propia cantante y su manejo.

**Legado**

Casado también ha trabajado con Benny Sadel y con numerosos artistas latinos a lo largo de una carrera de décadas, en la que, según su propio testimonio y la prensa dominicana, ha ganado siete premios Latin Grammy.' WHERE slug = 'ysrael-casado';

COMMIT;
