BEGIN;

-- Ficha de José Rufino Reyes y Siancas.
--
-- La biografía de relleno lo describía vagamente como compositor "cristiano e instrumental"
-- temprano sin mencionar jamás que compuso la música del actual Himno Nacional dominicano.
-- instruments añadido (cello).

UPDATE artists SET instruments = ARRAY['cello']::text[] WHERE slug = 'jose-rufino-reyes-y-siancas';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"José Rufino Reyes y Siancas, known simply as José Reyes, was a Dominican composer born in Santo Domingo on 15 November 1835 and died there on 31 January 1905, remembered for one work above all others: he wrote the music of the Dominican national anthem."}]},{"type":"paragraph","content":[{"type":"text","text":"A soldier-musician","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The son of a poor shopkeeper, he grew up in a bohío on what is now Arzobispo Nouel street and enlisted as a soldier while still a boy amid the wars that followed independence. As a regular army musician he studied under the military bandmaster "},{"type":"artistReference","attrs":{"occurrenceId":"38ee38c2-12a7-4602-8bfd-c52354049c01","artistId":"8da2665e-3035-4a8d-810c-98d2d8c8a27b","displayText":"Juan Bautista Alfonseca"}},{"type":"text","text":", learning several instruments and excelling on the cello."}]},{"type":"paragraph","content":[{"type":"text","text":"An anthem","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1882 he set a patriotic melody to staff notation and asked a group of the country’s writers to supply verses for it; Emilio Prud’Homme’s version, later revised in 1897, became the lyrics that endure today. The anthem premiered on 17 August 1883 at a Masonic lodge in Santo Domingo and was an immediate favorite — the music chosen, above all others written for the occasion, when Juan Pablo Duarte’s remains were repatriated from Venezuela."}]},{"type":"paragraph","content":[{"type":"text","text":"A hymn without a country","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Reyes’s tune kept being performed at major national occasions over the following decades — a railway inauguration, patriotic galas — and was twice put before Congress for official adoption, once under the dictator Ulises Heureaux, who left it unsigned before his 1899 assassination. It was not formally adopted as the Himno Nacional until 1934, twenty-nine years after Reyes’s own death."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1932, on the anniversary of his birth, his forgotten pasodoble «Salve al Progreso» was rescued from an old archive and broadcast on national radio; his birth centennial in 1935 was marked with tributes across the country. He is buried in the Panteón Nacional de la República Dominicana, the composer of a song that outlived every dictator who refused to sign it into law."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jose-rufino-reyes-y-siancas'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jose-rufino-reyes-y-siancas' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '38ee38c2-12a7-4602-8bfd-c52354049c01', 'artist', '8da2665e-3035-4a8d-810c-98d2d8c8a27b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-rufino-reyes-y-siancas' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'José Rufino Reyes y Siancas, known simply as José Reyes, was a Dominican composer born in Santo Domingo on 15 November 1835 and died there on 31 January 1905, remembered for one work above all others: he wrote the music of the Dominican national anthem.

**A soldier-musician**

The son of a poor shopkeeper, he grew up in a bohío on what is now Arzobispo Nouel street and enlisted as a soldier while still a boy amid the wars that followed independence. As a regular army musician he studied under the military bandmaster Juan Bautista Alfonseca, learning several instruments and excelling on the cello.

**An anthem**

In 1882 he set a patriotic melody to staff notation and asked a group of the country’s writers to supply verses for it; Emilio Prud’Homme’s version, later revised in 1897, became the lyrics that endure today. The anthem premiered on 17 August 1883 at a Masonic lodge in Santo Domingo and was an immediate favorite — the music chosen, above all others written for the occasion, when Juan Pablo Duarte’s remains were repatriated from Venezuela.

**A hymn without a country**

Reyes’s tune kept being performed at major national occasions over the following decades — a railway inauguration, patriotic galas — and was twice put before Congress for official adoption, once under the dictator Ulises Heureaux, who left it unsigned before his 1899 assassination. It was not formally adopted as the Himno Nacional until 1934, twenty-nine years after Reyes’s own death.

**Legacy**

In 1932, on the anniversary of his birth, his forgotten pasodoble «Salve al Progreso» was rescued from an old archive and broadcast on national radio; his birth centennial in 1935 was marked with tributes across the country. He is buried in the Panteón Nacional de la República Dominicana, the composer of a song that outlived every dictator who refused to sign it into law.' WHERE slug = 'jose-rufino-reyes-y-siancas';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"José Rufino Reyes y Siancas, conocido simplemente como José Reyes, fue compositor dominicano nacido en Santo Domingo el 15 de noviembre de 1835 y fallecido en la misma ciudad el 31 de enero de 1905, recordado sobre todo por una sola obra: escribió la música del Himno Nacional dominicano."}]},{"type":"paragraph","content":[{"type":"text","text":"Un soldado-músico","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Hijo de un pobre comerciante detallista, creció en un bohío en lo que hoy es la calle Arzobispo Nouel y se enroló como soldado siendo apenas un niño, en medio de las guerras que siguieron a la independencia. Como músico regular del ejército estudió con el director de banda militar "},{"type":"artistReference","attrs":{"occurrenceId":"fcf90f55-c958-413c-b147-a6b26686d637","artistId":"8da2665e-3035-4a8d-810c-98d2d8c8a27b","displayText":"Juan Bautista Alfonseca"}},{"type":"text","text":", aprendiendo varios instrumentos y destacándose en el violonchelo."}]},{"type":"paragraph","content":[{"type":"text","text":"Un himno","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1882 llevó al pentagrama una melodía patriótica y pidió a un grupo de escritores del país que le pusieran versos; la versión de Emilio Prud’Homme, revisada después en 1897, es la letra que perdura hoy. El himno se estrenó el 17 de agosto de 1883 en una logia masónica de Santo Domingo y fue un favorito inmediato: la música elegida, por encima de todas las escritas para la ocasión, cuando los restos de Juan Pablo Duarte fueron repatriados desde Venezuela."}]},{"type":"paragraph","content":[{"type":"text","text":"Un himno sin patria oficial","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La melodía de Reyes siguió interpretándose en grandes ocasiones nacionales durante las décadas siguientes —la inauguración de un ferrocarril, galas patrias— y dos veces se llevó al Congreso para su adopción oficial, una de ellas bajo el dictador Ulises Heureaux, que la dejó sin firmar antes de su asesinato en 1899. No fue adoptada formalmente como Himno Nacional hasta 1934, veintinueve años después de la muerte del propio Reyes."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1932, en el aniversario de su nacimiento, su olvidado pasodoble «Salve al Progreso» fue rescatado de un viejo archivo y difundido por radio nacional; el centenario de su natalicio, en 1935, se celebró con homenajes en todo el país. Está sepultado en el Panteón Nacional de la República Dominicana, autor de una canción que sobrevivió a cada dictador que se negó a convertirla en ley."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jose-rufino-reyes-y-siancas'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jose-rufino-reyes-y-siancas' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'fcf90f55-c958-413c-b147-a6b26686d637', 'artist', '8da2665e-3035-4a8d-810c-98d2d8c8a27b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jose-rufino-reyes-y-siancas' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'José Rufino Reyes y Siancas, conocido simplemente como José Reyes, fue compositor dominicano nacido en Santo Domingo el 15 de noviembre de 1835 y fallecido en la misma ciudad el 31 de enero de 1905, recordado sobre todo por una sola obra: escribió la música del Himno Nacional dominicano.

**Un soldado-músico**

Hijo de un pobre comerciante detallista, creció en un bohío en lo que hoy es la calle Arzobispo Nouel y se enroló como soldado siendo apenas un niño, en medio de las guerras que siguieron a la independencia. Como músico regular del ejército estudió con el director de banda militar Juan Bautista Alfonseca, aprendiendo varios instrumentos y destacándose en el violonchelo.

**Un himno**

En 1882 llevó al pentagrama una melodía patriótica y pidió a un grupo de escritores del país que le pusieran versos; la versión de Emilio Prud’Homme, revisada después en 1897, es la letra que perdura hoy. El himno se estrenó el 17 de agosto de 1883 en una logia masónica de Santo Domingo y fue un favorito inmediato: la música elegida, por encima de todas las escritas para la ocasión, cuando los restos de Juan Pablo Duarte fueron repatriados desde Venezuela.

**Un himno sin patria oficial**

La melodía de Reyes siguió interpretándose en grandes ocasiones nacionales durante las décadas siguientes —la inauguración de un ferrocarril, galas patrias— y dos veces se llevó al Congreso para su adopción oficial, una de ellas bajo el dictador Ulises Heureaux, que la dejó sin firmar antes de su asesinato en 1899. No fue adoptada formalmente como Himno Nacional hasta 1934, veintinueve años después de la muerte del propio Reyes.

**Legado**

En 1932, en el aniversario de su nacimiento, su olvidado pasodoble «Salve al Progreso» fue rescatado de un viejo archivo y difundido por radio nacional; el centenario de su natalicio, en 1935, se celebró con homenajes en todo el país. Está sepultado en el Panteón Nacional de la República Dominicana, autor de una canción que sobrevivió a cada dictador que se negó a convertirla en ley.' WHERE slug = 'jose-rufino-reyes-y-siancas';

COMMIT;
