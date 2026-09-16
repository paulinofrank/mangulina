BEGIN;

-- Ficha de Raphael Cruz.
--
-- La biografía de relleno era completamente genérica, sin nombrar banda, colaborador ni
-- hecho real de su carrera como percusionista de jazz latino en Nueva York, Puerto Rico y
-- Nueva Orleans.
-- birth_place/province corregidos de Santo Domingo/Distrito Nacional a Villa
-- Vásquez/Monte Cristi (coincide con MusicBrainz y con el propio relato de Cruz).
-- occupations ampliado con percussionist y bandleader.

UPDATE artists SET birth_place = 'Villa Vásquez', province = 'Monte Cristi',
       occupations = '["percussionist","bandleader"]'::jsonb
       WHERE slug = 'raphael-cruz';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Raphael Cruz —born in Villa Vásquez, Monte Cristi, on 27 May 1947, died in September 2020— was a Dominican percussionist and bandleader who spent most of his career in the Latin jazz scenes of New York, Puerto Rico and New Orleans, sharing stages and studios with musicians like Ray Barretto, Herbie Mann and The Crusaders."}]},{"type":"paragraph","content":[{"type":"text","text":"From Villa Vásquez to Santo Domingo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The son of Spanish parents who had migrated from Cuba, he moved to Santo Domingo as a young child, where he joined the marching band at the Escuela Chile on snare drum, bass drum and xylophone, and later continued his percussion studies — including marimba, snare drum and timpani — at the Colegio Don Bosco."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los X 6» and a mentor named Carmelo García","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Drawn into the 1960s rock explosion, he formed the group «Los X 6», which became the house band of the Dominican television show «Teenager’s Matinee». It was there that he met the drummer and timbalero Carmelo García, who had played in the bands of "},{"type":"artistReference","attrs":{"occurrenceId":"8109438e-7617-4f96-a5b2-93c44b2d6a96","artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano"}},{"type":"text","text":" and mentored Cruz in Caribbean folkloric rhythms and the emerging Latin jazz coming out of New York."}]},{"type":"paragraph","content":[{"type":"text","text":"Puerto Rico and «Raíces»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He spent the following decade in Puerto Rico, first touring Mexico City with the rock trio «Kaleidoscope» — recording an album for the Orfeon label later reissued in Germany — and then, in 1976, forming his first band, «Raíces». The group was signed to Nemperor Records, an Atlantic subsidiary run by the Beatles’ former lawyer Nat Weiss, and recorded in Miami before relocating to New York, where it opened for Miles Davis at the 1977 Dr. Pepper Jazz Festival in Central Park."}]},{"type":"paragraph","content":[{"type":"text","text":"New York and New Orleans","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cruz became an in-demand studio percussionist, recording for major labels and touring with Herbie Mann, Dr. John, Carly Simon, Bette Midler and The Crusaders. A move to New Orleans in the mid-1980s brought him into the circle of Dr. John and pianist Ellis Marsalis Jr.; the pianist in his own Latin jazz group there was a young Harry Connick Jr."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Back in New York, Cruz released his debut album as a leader, «A Mano», in 1999, followed by «Bebop Timba», nominated for the 2005 Grammy Award for Best Latin Jazz Album, and later «Time Travel» (2010). Known to friends simply as «Rafi», he continued performing and recording from his home in North Bergen, New Jersey, until his death in September 2020."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'raphael-cruz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'raphael-cruz' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '8109438e-7617-4f96-a5b2-93c44b2d6a96', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'raphael-cruz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Raphael Cruz —born in Villa Vásquez, Monte Cristi, on 27 May 1947, died in September 2020— was a Dominican percussionist and bandleader who spent most of his career in the Latin jazz scenes of New York, Puerto Rico and New Orleans, sharing stages and studios with musicians like Ray Barretto, Herbie Mann and The Crusaders.

**From Villa Vásquez to Santo Domingo**

The son of Spanish parents who had migrated from Cuba, he moved to Santo Domingo as a young child, where he joined the marching band at the Escuela Chile on snare drum, bass drum and xylophone, and later continued his percussion studies — including marimba, snare drum and timpani — at the Colegio Don Bosco.

**«Los X 6» and a mentor named Carmelo García**

Drawn into the 1960s rock explosion, he formed the group «Los X 6», which became the house band of the Dominican television show «Teenager’s Matinee». It was there that he met the drummer and timbalero Carmelo García, who had played in the bands of Rafael Solano and mentored Cruz in Caribbean folkloric rhythms and the emerging Latin jazz coming out of New York.

**Puerto Rico and «Raíces»**

He spent the following decade in Puerto Rico, first touring Mexico City with the rock trio «Kaleidoscope» — recording an album for the Orfeon label later reissued in Germany — and then, in 1976, forming his first band, «Raíces». The group was signed to Nemperor Records, an Atlantic subsidiary run by the Beatles’ former lawyer Nat Weiss, and recorded in Miami before relocating to New York, where it opened for Miles Davis at the 1977 Dr. Pepper Jazz Festival in Central Park.

**New York and New Orleans**

Cruz became an in-demand studio percussionist, recording for major labels and touring with Herbie Mann, Dr. John, Carly Simon, Bette Midler and The Crusaders. A move to New Orleans in the mid-1980s brought him into the circle of Dr. John and pianist Ellis Marsalis Jr.; the pianist in his own Latin jazz group there was a young Harry Connick Jr.

**Legacy**

Back in New York, Cruz released his debut album as a leader, «A Mano», in 1999, followed by «Bebop Timba», nominated for the 2005 Grammy Award for Best Latin Jazz Album, and later «Time Travel» (2010). Known to friends simply as «Rafi», he continued performing and recording from his home in North Bergen, New Jersey, until his death in September 2020.' WHERE slug = 'raphael-cruz';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Raphael Cruz —nacido en Villa Vásquez, Monte Cristi, el 27 de mayo de 1947, fallecido en septiembre de 2020— fue percusionista y director de orquesta dominicano que pasó la mayor parte de su carrera en las escenas de jazz latino de Nueva York, Puerto Rico y Nueva Orleans, compartiendo escenario y estudio con músicos como Ray Barretto, Herbie Mann y The Crusaders."}]},{"type":"paragraph","content":[{"type":"text","text":"De Villa Vásquez a Santo Domingo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Hijo de españoles que habían emigrado desde Cuba, se trasladó a Santo Domingo de muy niño, donde integró la banda de música de la Escuela Chile tocando redoblante, bombo y xilófono, y más tarde continuó sus estudios de percusión —incluyendo marimba, redoblante y tímpani— en el Colegio Don Bosco."}]},{"type":"paragraph","content":[{"type":"text","text":"«Los X 6» y un mentor llamado Carmelo García","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Atraído por la explosión del rock de los años sesenta, formó el grupo «Los X 6», que se convirtió en banda de casa del programa de televisión dominicano «Teenager’s Matinee». Allí conoció al baterista y timbalero Carmelo García, quien había tocado en las bandas de "},{"type":"artistReference","attrs":{"occurrenceId":"a2a3bcda-6600-42b0-ab0c-abf08fa96e05","artistId":"ba42e200-51b0-437b-99ac-1daf39ade337","displayText":"Rafael Solano"}},{"type":"text","text":" y lo introdujo en los ritmos folclóricos caribeños y en el naciente jazz latino que salía de Nueva York."}]},{"type":"paragraph","content":[{"type":"text","text":"Puerto Rico y «Raíces»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Pasó la década siguiente en Puerto Rico, primero de gira por Ciudad de México con el trío de rock «Kaleidoscope» —con quien grabó un disco para el sello Orfeon reeditado décadas después en Alemania— y luego, en 1976, formando su primera banda, «Raíces». El grupo firmó con Nemperor Records, subsidiaria de Atlantic dirigida por Nat Weiss, exabogado de los Beatles, y grabó en Miami antes de trasladarse a Nueva York, donde abrió para Miles Davis en el Dr. Pepper Jazz Festival de Central Park en 1977."}]},{"type":"paragraph","content":[{"type":"text","text":"Nueva York y Nueva Orleans","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cruz se convirtió en un solicitado percusionista de estudio, grabando para grandes sellos y de gira con Herbie Mann, Dr. John, Carly Simon, Bette Midler y The Crusaders. Una mudanza a Nueva Orleans a mediados de los ochenta lo acercó al círculo de Dr. John y el pianista Ellis Marsalis Jr.; el pianista de su propio grupo de jazz latino allí era un joven Harry Connick Jr."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De vuelta en Nueva York, Cruz publicó su álbum debut como líder, «A Mano», en 1999, seguido de «Bebop Timba», nominado al Grammy 2005 al Mejor Álbum de Jazz Latino, y más adelante «Time Travel» (2010). Conocido por sus amigos simplemente como «Rafi», siguió tocando y grabando desde su casa en North Bergen, Nueva Jersey, hasta su muerte en septiembre de 2020."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'raphael-cruz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'raphael-cruz' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'a2a3bcda-6600-42b0-ab0c-abf08fa96e05', 'artist', 'ba42e200-51b0-437b-99ac-1daf39ade337' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'raphael-cruz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Raphael Cruz —nacido en Villa Vásquez, Monte Cristi, el 27 de mayo de 1947, fallecido en septiembre de 2020— fue percusionista y director de orquesta dominicano que pasó la mayor parte de su carrera en las escenas de jazz latino de Nueva York, Puerto Rico y Nueva Orleans, compartiendo escenario y estudio con músicos como Ray Barretto, Herbie Mann y The Crusaders.

**De Villa Vásquez a Santo Domingo**

Hijo de españoles que habían emigrado desde Cuba, se trasladó a Santo Domingo de muy niño, donde integró la banda de música de la Escuela Chile tocando redoblante, bombo y xilófono, y más tarde continuó sus estudios de percusión —incluyendo marimba, redoblante y tímpani— en el Colegio Don Bosco.

**«Los X 6» y un mentor llamado Carmelo García**

Atraído por la explosión del rock de los años sesenta, formó el grupo «Los X 6», que se convirtió en banda de casa del programa de televisión dominicano «Teenager’s Matinee». Allí conoció al baterista y timbalero Carmelo García, quien había tocado en las bandas de Rafael Solano y lo introdujo en los ritmos folclóricos caribeños y en el naciente jazz latino que salía de Nueva York.

**Puerto Rico y «Raíces»**

Pasó la década siguiente en Puerto Rico, primero de gira por Ciudad de México con el trío de rock «Kaleidoscope» —con quien grabó un disco para el sello Orfeon reeditado décadas después en Alemania— y luego, en 1976, formando su primera banda, «Raíces». El grupo firmó con Nemperor Records, subsidiaria de Atlantic dirigida por Nat Weiss, exabogado de los Beatles, y grabó en Miami antes de trasladarse a Nueva York, donde abrió para Miles Davis en el Dr. Pepper Jazz Festival de Central Park en 1977.

**Nueva York y Nueva Orleans**

Cruz se convirtió en un solicitado percusionista de estudio, grabando para grandes sellos y de gira con Herbie Mann, Dr. John, Carly Simon, Bette Midler y The Crusaders. Una mudanza a Nueva Orleans a mediados de los ochenta lo acercó al círculo de Dr. John y el pianista Ellis Marsalis Jr.; el pianista de su propio grupo de jazz latino allí era un joven Harry Connick Jr.

**Legado**

De vuelta en Nueva York, Cruz publicó su álbum debut como líder, «A Mano», en 1999, seguido de «Bebop Timba», nominado al Grammy 2005 al Mejor Álbum de Jazz Latino, y más adelante «Time Travel» (2010). Conocido por sus amigos simplemente como «Rafi», siguió tocando y grabando desde su casa en North Bergen, Nueva Jersey, hasta su muerte en septiembre de 2020.' WHERE slug = 'raphael-cruz';

COMMIT;
