BEGIN;

-- Ficha de Aridia Ventura.
--
-- La biografía de relleno la describía en términos genéricos y decía que nació en San
-- Francisco de Macorís; nació en Jacagua, suburbio de Santiago de los Caballeros (iASO
-- Records y múltiples fuentes coinciden; ninguna dice San Francisco de Macorís).
-- birth_place/province corregidos. El año de nacimiento (1951 en la fila; iASO implica 1949
-- por "26 años en 1975") no se cambia, ver CONFLICTOS_DE_DATO.md.

UPDATE artists SET birth_place = 'Jacagua, Santiago de los Caballeros', province = 'Santiago' WHERE slug = 'aridia-ventura';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Aridia Ventura — born around 1949 in Jacagua, a suburb of Santiago de los Caballeros, died in 2001 — was a Dominican bachata singer and songwriter, one of the genre’s first successful female voices and the first to reach that scale since Melida Rodríguez a decade before her."}]},{"type":"paragraph","content":[{"type":"text","text":"A family of musicians","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"One of nine siblings, all of them musicians or singers, she was sent as a child to live with relatives in Santo Domingo, a common practice for large Dominican families. She began recording in 1975, at twenty-six, her first single produced by her brother "},{"type":"artistReference","attrs":{"occurrenceId":"3cee54cf-e9da-49c6-bd35-37bbd38cc1f3","artistId":"7bc2d1c9-baa4-4928-86f1-bbd0168fdf7c","displayText":"Adriano Ventura"}},{"type":"text","text":", already a name in bachata for his 1968 Mexican-style ranchera «La novia ajena»; that debut single carried «No eres varón», a song she later re-recorded into a genuine hit."}]},{"type":"paragraph","content":[{"type":"text","text":"«En la misma tumba»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Her second record, cut for the label Meregildo, made her a star: «En la misma tumba», a ranchera about wanting to be buried alongside a lover, became her biggest hit and remains her signature song."}]},{"type":"paragraph","content":[{"type":"text","text":"Radio Guarachita","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The song’s success caught the attention of "},{"type":"artistReference","attrs":{"occurrenceId":"4ca89521-4415-4492-a063-3e21cb8a86b6","artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena"}},{"type":"text","text":", who signed her to a five-year exclusive at a moment when bachata had had no comparable female star since Rodríguez. She cut at least eight LPs for him and got steady airplay, though Aracena mostly assigned her older boleros and rancheras rather than her own songs. She kept writing regardless — her merengue «Pa’ qué» became a hit for "},{"type":"artistReference","attrs":{"occurrenceId":"40a81ece-d900-4f6b-bdff-136a9f031061","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":" — and her despecho songs, sung from the point of view of betrayed women, earned her the nickname «La Verduga»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Amargue», and after","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"After her contract with Aracena ended she kept recording into the 1980s and became a fixture of Santo Domingo’s Monday-night «Amargue» shows, helping bachata gain acceptance in the capital. A 1991 brain-tumor surgery left her partially blind and slowed her career just as a younger style of bachata was crowding out her generation; her last real hit, «Dinero» (1997), was cut with the guitarist Nelson Paredes, brother of Edilio Paredes."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She died in 2001, one of the handful of women — with Rodríguez and Blanca Iris Villafañe before her — who built bachata’s audience before the genre had any real use for women at all."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'aridia-ventura'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'aridia-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '3cee54cf-e9da-49c6-bd35-37bbd38cc1f3', 'artist', '7bc2d1c9-baa4-4928-86f1-bbd0168fdf7c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'aridia-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4ca89521-4415-4492-a063-3e21cb8a86b6', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'aridia-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '40a81ece-d900-4f6b-bdff-136a9f031061', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'aridia-ventura' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Aridia Ventura — born around 1949 in Jacagua, a suburb of Santiago de los Caballeros, died in 2001 — was a Dominican bachata singer and songwriter, one of the genre’s first successful female voices and the first to reach that scale since Melida Rodríguez a decade before her.

**A family of musicians**

One of nine siblings, all of them musicians or singers, she was sent as a child to live with relatives in Santo Domingo, a common practice for large Dominican families. She began recording in 1975, at twenty-six, her first single produced by her brother Adriano Ventura, already a name in bachata for his 1968 Mexican-style ranchera «La novia ajena»; that debut single carried «No eres varón», a song she later re-recorded into a genuine hit.

**«En la misma tumba»**

Her second record, cut for the label Meregildo, made her a star: «En la misma tumba», a ranchera about wanting to be buried alongside a lover, became her biggest hit and remains her signature song.

**Radio Guarachita**

The song’s success caught the attention of Radhamés Aracena, who signed her to a five-year exclusive at a moment when bachata had had no comparable female star since Rodríguez. She cut at least eight LPs for him and got steady airplay, though Aracena mostly assigned her older boleros and rancheras rather than her own songs. She kept writing regardless — her merengue «Pa’ qué» became a hit for Fernando Villalona — and her despecho songs, sung from the point of view of betrayed women, earned her the nickname «La Verduga».

**«Amargue», and after**

After her contract with Aracena ended she kept recording into the 1980s and became a fixture of Santo Domingo’s Monday-night «Amargue» shows, helping bachata gain acceptance in the capital. A 1991 brain-tumor surgery left her partially blind and slowed her career just as a younger style of bachata was crowding out her generation; her last real hit, «Dinero» (1997), was cut with the guitarist Nelson Paredes, brother of Edilio Paredes.

**Legacy**

She died in 2001, one of the handful of women — with Rodríguez and Blanca Iris Villafañe before her — who built bachata’s audience before the genre had any real use for women at all.' WHERE slug = 'aridia-ventura';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Aridia Ventura —nacida hacia 1949 en Jacagua, un suburbio de Santiago de los Caballeros, fallecida en 2001— fue cantante y compositora dominicana de bachata, una de las primeras voces femeninas de éxito del género y la primera en alcanzar esa escala desde Melida Rodríguez, una década antes que ella."}]},{"type":"paragraph","content":[{"type":"text","text":"Una familia de músicos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Una de nueve hermanos, todos músicos o cantantes, de niña la mandaron a vivir con parientes en Santo Domingo, práctica común en las familias dominicanas numerosas. Empezó a grabar en 1975, a los veintiséis años, con su primer sencillo producido por su hermano "},{"type":"artistReference","attrs":{"occurrenceId":"5c73ccd3-ff55-450f-b82b-f6660cab312e","artistId":"7bc2d1c9-baa4-4928-86f1-bbd0168fdf7c","displayText":"Adriano Ventura"}},{"type":"text","text":", ya un nombre en la bachata por su ranchera de estilo mexicano de 1968, «La novia ajena»; ese sencillo debut llevaba «No eres varón», canción que después regrabaría convertida en un éxito real."}]},{"type":"paragraph","content":[{"type":"text","text":"«En la misma tumba»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su segundo disco, grabado para el sello Meregildo, la volvió una estrella: «En la misma tumba», una ranchera sobre el deseo de ser enterrada junto a un amante, se convirtió en su mayor éxito y sigue siendo su canción emblema."}]},{"type":"paragraph","content":[{"type":"text","text":"Radio Guarachita","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"El éxito del tema llamó la atención de "},{"type":"artistReference","attrs":{"occurrenceId":"443a03ff-76de-426a-81a6-7e233fdac683","artistId":"a08ab62e-ec7b-4770-ae52-60c1fcea6a08","displayText":"Radhamés Aracena"}},{"type":"text","text":", quien la contrató en exclusiva por cinco años en un momento en que la bachata no tenía una estrella femenina comparable desde Rodríguez. Grabó al menos ocho LP para él y tuvo pauta constante en la radio, aunque Aracena le asignaba sobre todo boleros y rancheras antiguos en vez de sus propias canciones. Ella siguió escribiendo de todos modos —su merengue «Pa’ qué» se volvió un éxito para "},{"type":"artistReference","attrs":{"occurrenceId":"4ebd49d9-a4c8-4feb-a0ab-a49d8ce13814","artistId":"bc310977-31a9-41bb-9af2-7d3a0d7fabdd","displayText":"Fernando Villalona"}},{"type":"text","text":"— y sus canciones de despecho, cantadas desde el punto de vista de la mujer traicionada, le ganaron el apodo de «La Verduga»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Amargue», y después","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Terminado el contrato con Aracena siguió grabando hasta bien entrados los ochenta y se volvió fija en las presentaciones de «Amargue» de los lunes en Santo Domingo, que ayudaron a que la bachata se aceptara en la capital. Una cirugía por un tumor cerebral en 1991 la dejó parcialmente ciega y frenó su carrera justo cuando un estilo más nuevo de bachata empezaba a desplazar a su generación; su último éxito real, «Dinero» (1997), lo grabó con el guitarrista Nelson Paredes, hermano de Edilio Paredes."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Murió en 2001, una de las pocas mujeres —junto a Rodríguez y Blanca Iris Villafañe antes que ella— que construyeron el público de la bachata antes de que el género tuviera algún uso real para las mujeres."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'aridia-ventura'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'aridia-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5c73ccd3-ff55-450f-b82b-f6660cab312e', 'artist', '7bc2d1c9-baa4-4928-86f1-bbd0168fdf7c' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'aridia-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '443a03ff-76de-426a-81a6-7e233fdac683', 'artist', 'a08ab62e-ec7b-4770-ae52-60c1fcea6a08' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'aridia-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '4ebd49d9-a4c8-4feb-a0ab-a49d8ce13814', 'artist', 'bc310977-31a9-41bb-9af2-7d3a0d7fabdd' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'aridia-ventura' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Aridia Ventura —nacida hacia 1949 en Jacagua, un suburbio de Santiago de los Caballeros, fallecida en 2001— fue cantante y compositora dominicana de bachata, una de las primeras voces femeninas de éxito del género y la primera en alcanzar esa escala desde Melida Rodríguez, una década antes que ella.

**Una familia de músicos**

Una de nueve hermanos, todos músicos o cantantes, de niña la mandaron a vivir con parientes en Santo Domingo, práctica común en las familias dominicanas numerosas. Empezó a grabar en 1975, a los veintiséis años, con su primer sencillo producido por su hermano Adriano Ventura, ya un nombre en la bachata por su ranchera de estilo mexicano de 1968, «La novia ajena»; ese sencillo debut llevaba «No eres varón», canción que después regrabaría convertida en un éxito real.

**«En la misma tumba»**

Su segundo disco, grabado para el sello Meregildo, la volvió una estrella: «En la misma tumba», una ranchera sobre el deseo de ser enterrada junto a un amante, se convirtió en su mayor éxito y sigue siendo su canción emblema.

**Radio Guarachita**

El éxito del tema llamó la atención de Radhamés Aracena, quien la contrató en exclusiva por cinco años en un momento en que la bachata no tenía una estrella femenina comparable desde Rodríguez. Grabó al menos ocho LP para él y tuvo pauta constante en la radio, aunque Aracena le asignaba sobre todo boleros y rancheras antiguos en vez de sus propias canciones. Ella siguió escribiendo de todos modos —su merengue «Pa’ qué» se volvió un éxito para Fernando Villalona— y sus canciones de despecho, cantadas desde el punto de vista de la mujer traicionada, le ganaron el apodo de «La Verduga».

**«Amargue», y después**

Terminado el contrato con Aracena siguió grabando hasta bien entrados los ochenta y se volvió fija en las presentaciones de «Amargue» de los lunes en Santo Domingo, que ayudaron a que la bachata se aceptara en la capital. Una cirugía por un tumor cerebral en 1991 la dejó parcialmente ciega y frenó su carrera justo cuando un estilo más nuevo de bachata empezaba a desplazar a su generación; su último éxito real, «Dinero» (1997), lo grabó con el guitarrista Nelson Paredes, hermano de Edilio Paredes.

**Legado**

Murió en 2001, una de las pocas mujeres —junto a Rodríguez y Blanca Iris Villafañe antes que ella— que construyeron el público de la bachata antes de que el género tuviera algún uso real para las mujeres.' WHERE slug = 'aridia-ventura';

COMMIT;
