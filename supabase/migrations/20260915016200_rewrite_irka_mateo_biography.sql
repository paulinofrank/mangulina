BEGIN;

-- Ficha de Irka Mateo.
--
-- La biografía de relleno la describía en términos genéricos como enfocada en folclore
-- "afrodominicano" (salves, palos, gagá); todas las fuentes coinciden en que su enfoque más
-- distintivo es la reconstrucción de la herencia indígena taína específicamente, no solo
-- afrodominicana. Sin cambios de campo: no se identificó ningún dato estructural erróneo.

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Irka Mateo is a Dominican singer, songwriter and percussionist from Santo Domingo whose four-decade career has centered on reviving the island’s Taíno indigenous heritage alongside its Afro-Dominican folk traditions."}]},{"type":"paragraph","content":[{"type":"text","text":"After Convite","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She came up in the wave of fusion musicians who followed Luis Días and his band Convite in studying the folk music of rural bateyes, the sugarcane-plantation communities, alongside "},{"type":"artistReference","attrs":{"occurrenceId":"bac30228-b050-44e2-99c8-cd3cfb860689","artistId":"8e29188a-215b-4c6c-b34a-45b381765e46","displayText":"Xiomara Fortuna"}},{"type":"text","text":" and Tone Vicioso, later melding those rhythms with rock, blues and jazz."}]},{"type":"paragraph","content":[{"type":"text","text":"A discography built on Taíno memory","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her albums — «Tres Américas» (1996), «Anacaona» (2009, named for the Taíno cacica executed by Spanish colonizers) and «Vamo a Gozá» (2017), developed with the Brazilian composer and arranger Tadeu Demarco — trace her research into pre-Columbian and syncretic Dominican spirituality. «Vamo a Gozá» premiered at Lincoln Center’s David Rubenstein Atrium in New York before a 2018 Dominican tour."}]},{"type":"paragraph","content":[{"type":"text","text":"Recognition","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She was a guest vocalist on «El Orisha de la Rosa», the Colombian folk elder Magín Díaz’s album nominated for Best Folk Album at the 2017 Latin Grammy Awards, and the Indigenous Caribbean Network’s Taíno Awards named her their first-ever Musician of the Year before honoring her again as Woman of the Year in 2025."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Now based in Los Angeles, where she continues her ceremonial and cultural work under the name Sacred Taíno Healing and researches the reconstruction of pre-Hispanic Taíno ceramic instruments, Irka Mateo remains one of the clearest living links between Dominican popular music and the island’s indigenous past."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'irka-mateo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'irka-mateo' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'bac30228-b050-44e2-99c8-cd3cfb860689', 'artist', '8e29188a-215b-4c6c-b34a-45b381765e46' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'irka-mateo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Irka Mateo is a Dominican singer, songwriter and percussionist from Santo Domingo whose four-decade career has centered on reviving the island’s Taíno indigenous heritage alongside its Afro-Dominican folk traditions.

**After Convite**

She came up in the wave of fusion musicians who followed Luis Días and his band Convite in studying the folk music of rural bateyes, the sugarcane-plantation communities, alongside Xiomara Fortuna and Tone Vicioso, later melding those rhythms with rock, blues and jazz.

**A discography built on Taíno memory**

Her albums — «Tres Américas» (1996), «Anacaona» (2009, named for the Taíno cacica executed by Spanish colonizers) and «Vamo a Gozá» (2017), developed with the Brazilian composer and arranger Tadeu Demarco — trace her research into pre-Columbian and syncretic Dominican spirituality. «Vamo a Gozá» premiered at Lincoln Center’s David Rubenstein Atrium in New York before a 2018 Dominican tour.

**Recognition**

She was a guest vocalist on «El Orisha de la Rosa», the Colombian folk elder Magín Díaz’s album nominated for Best Folk Album at the 2017 Latin Grammy Awards, and the Indigenous Caribbean Network’s Taíno Awards named her their first-ever Musician of the Year before honoring her again as Woman of the Year in 2025.

**Legacy**

Now based in Los Angeles, where she continues her ceremonial and cultural work under the name Sacred Taíno Healing and researches the reconstruction of pre-Hispanic Taíno ceramic instruments, Irka Mateo remains one of the clearest living links between Dominican popular music and the island’s indigenous past.' WHERE slug = 'irka-mateo';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Irka Mateo es cantante, compositora y percusionista dominicana de Santo Domingo cuya carrera de cuatro décadas se ha centrado en revivir la herencia indígena taína de la isla junto a sus tradiciones folclóricas afrodominicanas."}]},{"type":"paragraph","content":[{"type":"text","text":"Después de Convite","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Se formó en la ola de músicos de fusión que, tras Luis Días y su banda Convite, estudiaron la música folclórica de los bateyes rurales, las comunidades de los ingenios azucareros, junto a "},{"type":"artistReference","attrs":{"occurrenceId":"3bcffcff-a6bc-41b0-ba5a-20d25a8002ed","artistId":"8e29188a-215b-4c6c-b34a-45b381765e46","displayText":"Xiomara Fortuna"}},{"type":"text","text":" y Tone Vicioso, fusionando después esos ritmos con rock, blues y jazz."}]},{"type":"paragraph","content":[{"type":"text","text":"Una discografía construida sobre la memoria taína","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Sus álbumes —«Tres Américas» (1996), «Anacaona» (2009, en homenaje a la cacica taína ejecutada por los colonizadores españoles) y «Vamo a Gozá» (2017), desarrollado con el compositor y arreglista brasileño Tadeu Demarco— trazan su investigación sobre la espiritualidad precolombina y sincrética dominicana. «Vamo a Gozá» se estrenó en el David Rubenstein Atrium del Lincoln Center de Nueva York antes de una gira dominicana en 2018."}]},{"type":"paragraph","content":[{"type":"text","text":"Reconocimiento","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fue vocalista invitada en «El Orisha de la Rosa», el álbum del folclorista colombiano Magín Díaz nominado a Mejor Álbum Folclórico en los Latin Grammy de 2017, y los Taíno Awards de la Indigenous Caribbean Network la nombraron su primera «Musician of the Year» antes de distinguirla de nuevo como «Woman of the Year» en 2025."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Radicada hoy en Los Ángeles, donde continúa su trabajo ceremonial y cultural bajo el nombre Sacred Taíno Healing e investiga la reconstrucción de instrumentos de cerámica taína prehispánicos, Irka Mateo sigue siendo uno de los vínculos vivos más claros entre la música popular dominicana y el pasado indígena de la isla."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'irka-mateo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'irka-mateo' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3bcffcff-a6bc-41b0-ba5a-20d25a8002ed', 'artist', '8e29188a-215b-4c6c-b34a-45b381765e46' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'irka-mateo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Irka Mateo es cantante, compositora y percusionista dominicana de Santo Domingo cuya carrera de cuatro décadas se ha centrado en revivir la herencia indígena taína de la isla junto a sus tradiciones folclóricas afrodominicanas.

**Después de Convite**

Se formó en la ola de músicos de fusión que, tras Luis Días y su banda Convite, estudiaron la música folclórica de los bateyes rurales, las comunidades de los ingenios azucareros, junto a Xiomara Fortuna y Tone Vicioso, fusionando después esos ritmos con rock, blues y jazz.

**Una discografía construida sobre la memoria taína**

Sus álbumes —«Tres Américas» (1996), «Anacaona» (2009, en homenaje a la cacica taína ejecutada por los colonizadores españoles) y «Vamo a Gozá» (2017), desarrollado con el compositor y arreglista brasileño Tadeu Demarco— trazan su investigación sobre la espiritualidad precolombina y sincrética dominicana. «Vamo a Gozá» se estrenó en el David Rubenstein Atrium del Lincoln Center de Nueva York antes de una gira dominicana en 2018.

**Reconocimiento**

Fue vocalista invitada en «El Orisha de la Rosa», el álbum del folclorista colombiano Magín Díaz nominado a Mejor Álbum Folclórico en los Latin Grammy de 2017, y los Taíno Awards de la Indigenous Caribbean Network la nombraron su primera «Musician of the Year» antes de distinguirla de nuevo como «Woman of the Year» en 2025.

**Legado**

Radicada hoy en Los Ángeles, donde continúa su trabajo ceremonial y cultural bajo el nombre Sacred Taíno Healing e investiga la reconstrucción de instrumentos de cerámica taína prehispánicos, Irka Mateo sigue siendo uno de los vínculos vivos más claros entre la música popular dominicana y el pasado indígena de la isla.' WHERE slug = 'irka-mateo';

COMMIT;
