BEGIN;

-- Ficha de Félix Cumbé.
--
-- La biografía de relleno era completamente genérica, sin nombrar canción, orquesta ni hecho
-- alguno de su carrera.
-- first_name/last_name/second_last_name corregidos del nombre artístico duplicado al nombre
-- real documentado (Fritz Sterlin Odine). birth_place ampliado de "Haití" a "Puerto Príncipe".
-- occupations ampliado con bandleader.

UPDATE artists SET first_name = 'Fritz', last_name = 'Sterlin', second_last_name = 'Odine',
       birth_place = 'Puerto Príncipe', occupations = '["composer","bandleader"]'::jsonb
       WHERE slug = 'felix-cumbe';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Félix Cumbé —born Fritz Sterlin Odine in Port-au-Prince, Haiti, on 4 August 1964, died in Santo Domingo on 11 February 2025— was a Haitian-born, naturalized Dominican singer and composer who spent more than forty years moving between Dominican merengue and bachata and Haitian kompa."}]},{"type":"paragraph","content":[{"type":"text","text":"From Aníbal Bravo’s orchestra","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He emigrated to the Dominican Republic at thirteen, and began recording in the 1980s with «El Gatico», written for "},{"type":"artistReference","attrs":{"occurrenceId":"c7cfcc70-b088-48b3-ba34-af26b49f618e","artistId":"f050869b-f4c0-4281-b883-bce0120ad9b2","displayText":"Aníbal Bravo"}},{"type":"text","text":"’s orchestra. His popularity grew with «Feliz Cumbé» and «Déjame Volver», the latter performed together with "},{"type":"artistReference","attrs":{"occurrenceId":"05b0167a-483b-4d74-a36d-54aa02b53c08","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Between two islands’ rhythms","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"After leaving Bravo’s orchestra he formed his own group, then relocated to Haiti, where he led the orchestra «Super Star» to three years of notable success, before returning to the Dominican Republic to form a bachata group. His debut bachata release, «Félix Cumbé Bachateando», was followed by «Rompecorazones», «El Inmigrante», «La Punta Temblorosa» and «El Tíguere que Pulla», among others."}]},{"type":"paragraph","content":[{"type":"text","text":"A voice for immigrants","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Beyond its dancefloor hits, his catalogue included socially conscious songs such as «El Inmigrante», a chronicle of the dignity and hardship of diaspora life, and «La Niña Violada», which denounced abuse against women and girls. He returned to the spotlight in 2012 with «Tú No ’Ta’ pa’ Mí», was naturalized as a Dominican citizen in 2022, and in 2024, after suffering a stroke, saw a new remix of his older hit «Fui Fuá» go viral on TikTok."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Félix Cumbé died on 11 February 2025 during a catheterization procedure at the Cedimat hospital in Santo Domingo, after months of declining health following his stroke. His daughter, Katty Sterlin Adames, now leads the orchestra he founded, and in 2026 the humanitarian organization Global Alivio posthumously named him «Ambassador of Melody», honoring both his popular hits and the social themes running through his work."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'felix-cumbe'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'felix-cumbe' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'c7cfcc70-b088-48b3-ba34-af26b49f618e', 'artist', 'f050869b-f4c0-4281-b883-bce0120ad9b2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'felix-cumbe' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '05b0167a-483b-4d74-a36d-54aa02b53c08', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'felix-cumbe' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Félix Cumbé —born Fritz Sterlin Odine in Port-au-Prince, Haiti, on 4 August 1964, died in Santo Domingo on 11 February 2025— was a Haitian-born, naturalized Dominican singer and composer who spent more than forty years moving between Dominican merengue and bachata and Haitian kompa.

**From Aníbal Bravo’s orchestra**

He emigrated to the Dominican Republic at thirteen, and began recording in the 1980s with «El Gatico», written for Aníbal Bravo’s orchestra. His popularity grew with «Feliz Cumbé» and «Déjame Volver», the latter performed together with Fernando Villalona.

**Between two islands’ rhythms**

After leaving Bravo’s orchestra he formed his own group, then relocated to Haiti, where he led the orchestra «Super Star» to three years of notable success, before returning to the Dominican Republic to form a bachata group. His debut bachata release, «Félix Cumbé Bachateando», was followed by «Rompecorazones», «El Inmigrante», «La Punta Temblorosa» and «El Tíguere que Pulla», among others.

**A voice for immigrants**

Beyond its dancefloor hits, his catalogue included socially conscious songs such as «El Inmigrante», a chronicle of the dignity and hardship of diaspora life, and «La Niña Violada», which denounced abuse against women and girls. He returned to the spotlight in 2012 with «Tú No ’Ta’ pa’ Mí», was naturalized as a Dominican citizen in 2022, and in 2024, after suffering a stroke, saw a new remix of his older hit «Fui Fuá» go viral on TikTok.

**Legacy**

Félix Cumbé died on 11 February 2025 during a catheterization procedure at the Cedimat hospital in Santo Domingo, after months of declining health following his stroke. His daughter, Katty Sterlin Adames, now leads the orchestra he founded, and in 2026 the humanitarian organization Global Alivio posthumously named him «Ambassador of Melody», honoring both his popular hits and the social themes running through his work.' WHERE slug = 'felix-cumbe';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Félix Cumbé —nacido Fritz Sterlin Odine en Puerto Príncipe, Haití, el 4 de agosto de 1964, fallecido en Santo Domingo el 11 de febrero de 2025— fue cantante y compositor dominicano nacionalizado, nacido en Haití, que pasó más de cuarenta años moviéndose entre el merengue y la bachata dominicanos y el kompa haitiano."}]},{"type":"paragraph","content":[{"type":"text","text":"En la orquesta de Aníbal Bravo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Emigró a República Dominicana a los trece años, y empezó a grabar en los años ochenta con «El Gatico», escrita para la orquesta de "},{"type":"artistReference","attrs":{"occurrenceId":"0c29a746-918b-4a3c-ad2d-dba415a38ebb","artistId":"f050869b-f4c0-4281-b883-bce0120ad9b2","displayText":"Aníbal Bravo"}},{"type":"text","text":". Su popularidad creció con «Feliz Cumbé» y «Déjame Volver», esta última interpretada junto a "},{"type":"artistReference","attrs":{"occurrenceId":"4c4be5ba-06a1-4e53-ac38-07ae116fbc69","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Entre los ritmos de dos islas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Tras dejar la orquesta de Bravo formó su propia agrupación, y luego se trasladó a Haití, donde dirigió la orquesta «Super Star» durante tres años de notable éxito, antes de regresar a República Dominicana para formar un grupo de bachata. Su primera producción de bachata, «Félix Cumbé Bachateando», fue seguida por «Rompecorazones», «El Inmigrante», «La Punta Temblorosa» y «El Tíguere que Pulla», entre otras."}]},{"type":"paragraph","content":[{"type":"text","text":"Una voz para los inmigrantes","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Más allá de sus éxitos bailables, su catálogo incluyó canciones de conciencia social como «El Inmigrante», una crónica de la dignidad y las dificultades de la vida en la diáspora, y «La Niña Violada», que denunciaba el abuso contra mujeres y niñas. Volvió a los escenarios en 2012 con «Tú No ’Ta’ pa’ Mí», se naturalizó dominicano en 2022, y en 2024, tras sufrir un accidente cerebrovascular, vio cómo un nuevo remix de su antiguo éxito «Fui Fuá» se volvía viral en TikTok."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Félix Cumbé murió el 11 de febrero de 2025 durante un procedimiento de cateterismo en el hospital Cedimat de Santo Domingo, tras meses de salud en declive luego de su accidente cerebrovascular. Su hija, Katty Sterlin Adames, dirige hoy la orquesta que él fundó, y en 2026 la organización humanitaria Global Alivio lo nombró póstumamente «Embajador de la Melodía», en reconocimiento tanto a sus éxitos populares como a los temas sociales presentes en su obra."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'felix-cumbe'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'felix-cumbe' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '0c29a746-918b-4a3c-ad2d-dba415a38ebb', 'artist', 'f050869b-f4c0-4281-b883-bce0120ad9b2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'felix-cumbe' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '4c4be5ba-06a1-4e53-ac38-07ae116fbc69', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'felix-cumbe' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Félix Cumbé —nacido Fritz Sterlin Odine en Puerto Príncipe, Haití, el 4 de agosto de 1964, fallecido en Santo Domingo el 11 de febrero de 2025— fue cantante y compositor dominicano nacionalizado, nacido en Haití, que pasó más de cuarenta años moviéndose entre el merengue y la bachata dominicanos y el kompa haitiano.

**En la orquesta de Aníbal Bravo**

Emigró a República Dominicana a los trece años, y empezó a grabar en los años ochenta con «El Gatico», escrita para la orquesta de Aníbal Bravo. Su popularidad creció con «Feliz Cumbé» y «Déjame Volver», esta última interpretada junto a Fernando Villalona.

**Entre los ritmos de dos islas**

Tras dejar la orquesta de Bravo formó su propia agrupación, y luego se trasladó a Haití, donde dirigió la orquesta «Super Star» durante tres años de notable éxito, antes de regresar a República Dominicana para formar un grupo de bachata. Su primera producción de bachata, «Félix Cumbé Bachateando», fue seguida por «Rompecorazones», «El Inmigrante», «La Punta Temblorosa» y «El Tíguere que Pulla», entre otras.

**Una voz para los inmigrantes**

Más allá de sus éxitos bailables, su catálogo incluyó canciones de conciencia social como «El Inmigrante», una crónica de la dignidad y las dificultades de la vida en la diáspora, y «La Niña Violada», que denunciaba el abuso contra mujeres y niñas. Volvió a los escenarios en 2012 con «Tú No ’Ta’ pa’ Mí», se naturalizó dominicano en 2022, y en 2024, tras sufrir un accidente cerebrovascular, vio cómo un nuevo remix de su antiguo éxito «Fui Fuá» se volvía viral en TikTok.

**Legado**

Félix Cumbé murió el 11 de febrero de 2025 durante un procedimiento de cateterismo en el hospital Cedimat de Santo Domingo, tras meses de salud en declive luego de su accidente cerebrovascular. Su hija, Katty Sterlin Adames, dirige hoy la orquesta que él fundó, y en 2026 la organización humanitaria Global Alivio lo nombró póstumamente «Embajador de la Melodía», en reconocimiento tanto a sus éxitos populares como a los temas sociales presentes en su obra.' WHERE slug = 'felix-cumbe';

COMMIT;
