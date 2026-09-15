BEGIN;

-- Ficha de Aisha Syed Castro.
--
-- La biografía de relleno decía que nació en Santo Domingo; nació en Santiago de los
-- Caballeros, que es lo que ya decía correctamente el campo birth_place de la fila (no se
-- tocó ningún campo, solo el texto). Un premio registrado: Casandra 2009, Violinista
-- Internacional.

INSERT INTO award_categories (award_id, name)
SELECT a.id, 'Violinista Internacional' FROM awards a WHERE a.name = 'Premios Casandra'
   AND NOT EXISTS (SELECT 1 FROM award_categories c WHERE c.award_id = a.id AND c.name = 'Violinista Internacional');

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT ar.id, cat.award_id, cat.id, 2009, NULL, true, 'Wikipedia (es), con siete referencias; octomedia.com.do; YouTube (lavozdom)'
  FROM artists ar, award_categories cat JOIN awards a ON a.id = cat.award_id
 WHERE ar.slug = 'aisha-syed-castro' AND a.name = 'Premios Casandra' AND cat.name = 'Violinista Internacional'
   AND NOT EXISTS (SELECT 1 FROM artist_awards w WHERE w.artist_id = ar.id AND w.category_id = cat.id AND w.year = 2009);

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Aisha Syed Castro — born 15 September 1989 in Santiago de los Caballeros — is a Dominican violinist and the first Latin American ever admitted to London’s Yehudi Menuhin School."}]},{"type":"paragraph","content":[{"type":"text","text":"A child prodigy in Santiago","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The daughter of Saifuddin Syed, of Pakistani descent, and Carolina Castro, she began violin and flute at four at the Hogar de la Armonía in Santiago under Henry Disla, traveling twice weekly to Santo Domingo for lessons with Hipólito Javier Guerrero and later studying under Caonex Peguero. She joined the Orquesta Sinfónica Infantil at six and, at eleven, became the youngest soloist ever to perform with the Orquesta Sinfónica Nacional, the same year she attended a violin symposium at the Juilliard School in New York."}]},{"type":"paragraph","content":[{"type":"text","text":"Yehudi Menuhin School","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2002, after a two-year audition process, she was admitted to the Yehudi Menuhin School in London on a British government scholarship — the first Latin American student the school had ever accepted."}]},{"type":"paragraph","content":[{"type":"text","text":"Sharing a stage with the greats","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2007 she performed alongside "},{"type":"artistReference","attrs":{"occurrenceId":"46d88419-1e31-4b72-9257-f748d1283d71","artistId":"da791d26-8bab-45e4-b7d1-f09314869f09","displayText":"Michel Camilo"}},{"type":"text","text":" at the Premios Casandra and shared a scene with the pianist Jeremy Menuhin. In March 2009, at Israel’s Eilat Festival, she performed under the direction of Maxim Vengerov alongside the violinists Julian Rachlin, Pavel Vernikov and Boris Kushnir and the violinist-comedian Aleksey Igudesman; that July, the Israeli composer Noam Sheriff chose her to give the world premiere of his concerto «Vísperas del Canario» at the Menuhin Festival Gstaad in Switzerland."}]},{"type":"paragraph","content":[{"type":"text","text":"Recognition","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In January 2009 she won an international competition among three thousand young musicians from twenty countries, and that same year the Premios Casandra named her its International Violinist."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"She has gone on to record albums including «Martinaitis» and to perform across Europe, the Americas and Asia, carrying the sound of a violin she first picked up at four in Santiago into concert halls the Dominican Republic rarely reaches."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'aisha-syed-castro'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'aisha-syed-castro' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '46d88419-1e31-4b72-9257-f748d1283d71', 'artist', 'da791d26-8bab-45e4-b7d1-f09314869f09' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'aisha-syed-castro' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Aisha Syed Castro — born 15 September 1989 in Santiago de los Caballeros — is a Dominican violinist and the first Latin American ever admitted to London’s Yehudi Menuhin School.

**A child prodigy in Santiago**

The daughter of Saifuddin Syed, of Pakistani descent, and Carolina Castro, she began violin and flute at four at the Hogar de la Armonía in Santiago under Henry Disla, traveling twice weekly to Santo Domingo for lessons with Hipólito Javier Guerrero and later studying under Caonex Peguero. She joined the Orquesta Sinfónica Infantil at six and, at eleven, became the youngest soloist ever to perform with the Orquesta Sinfónica Nacional, the same year she attended a violin symposium at the Juilliard School in New York.

**Yehudi Menuhin School**

In 2002, after a two-year audition process, she was admitted to the Yehudi Menuhin School in London on a British government scholarship — the first Latin American student the school had ever accepted.

**Sharing a stage with the greats**

In 2007 she performed alongside Michel Camilo at the Premios Casandra and shared a scene with the pianist Jeremy Menuhin. In March 2009, at Israel’s Eilat Festival, she performed under the direction of Maxim Vengerov alongside the violinists Julian Rachlin, Pavel Vernikov and Boris Kushnir and the violinist-comedian Aleksey Igudesman; that July, the Israeli composer Noam Sheriff chose her to give the world premiere of his concerto «Vísperas del Canario» at the Menuhin Festival Gstaad in Switzerland.

**Recognition**

In January 2009 she won an international competition among three thousand young musicians from twenty countries, and that same year the Premios Casandra named her its International Violinist.

**Legacy**

She has gone on to record albums including «Martinaitis» and to perform across Europe, the Americas and Asia, carrying the sound of a violin she first picked up at four in Santiago into concert halls the Dominican Republic rarely reaches.' WHERE slug = 'aisha-syed-castro';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Aisha Syed Castro —nacida el 15 de septiembre de 1989 en Santiago de los Caballeros— es violinista dominicana y la primera latinoamericana admitida en la Yehudi Menuhin School de Londres."}]},{"type":"paragraph","content":[{"type":"text","text":"Una niña prodigio en Santiago","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Hija de Saifuddin Syed, de ascendencia pakistaní, y de Carolina Castro, empezó a estudiar violín y flauta a los cuatro años en el Hogar de la Armonía de Santiago con el maestro Henry Disla, viajando dos veces por semana a Santo Domingo para tomar clases con Hipólito Javier Guerrero y estudiando después con Caonex Peguero. A los seis años entró a la Orquesta Sinfónica Infantil y, a los once, se convirtió en la solista más joven en presentarse con la Orquesta Sinfónica Nacional, el mismo año en que asistió a un simposio de violín en la Juilliard School de Nueva York."}]},{"type":"paragraph","content":[{"type":"text","text":"Yehudi Menuhin School","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2002, tras un proceso de audición de dos años, fue admitida en la Yehudi Menuhin School de Londres con una beca del gobierno británico —la primera estudiante latinoamericana que aceptó la escuela."}]},{"type":"paragraph","content":[{"type":"text","text":"Compartiendo tarima con los grandes","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2007 tocó junto a "},{"type":"artistReference","attrs":{"occurrenceId":"aaef693a-ccb1-4bad-ac88-705121b38c4d","artistId":"da791d26-8bab-45e4-b7d1-f09314869f09","displayText":"Michel Camilo"}},{"type":"text","text":" en los Premios Casandra y compartió escena con el pianista Jeremy Menuhin. En marzo de 2009, en el Festival Eilat de Israel, tocó bajo la dirección de Maxim Vengerov junto a los violinistas Julian Rachlin, Pavel Vernikov y Boris Kushnir y el violinista y comediante Aleksey Igudesman; ese julio, el compositor israelí Noam Sheriff la eligió para estrenar mundialmente su concierto «Vísperas del Canario» en el Festival Menuhin de Gstaad, Suiza."}]},{"type":"paragraph","content":[{"type":"text","text":"Reconocimiento","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En enero de 2009 ganó un concurso internacional entre tres mil jóvenes músicos de veinte países, y ese mismo año los Premios Casandra la nombraron Violinista Internacional."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Ha seguido grabando álbumes como «Martinaitis» y presentándose por Europa, América y Asia, llevando el sonido de un violín que tomó por primera vez a los cuatro años en Santiago a salas de concierto a las que República Dominicana rara vez llega."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'aisha-syed-castro'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'aisha-syed-castro' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'aaef693a-ccb1-4bad-ac88-705121b38c4d', 'artist', 'da791d26-8bab-45e4-b7d1-f09314869f09' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'aisha-syed-castro' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Aisha Syed Castro —nacida el 15 de septiembre de 1989 en Santiago de los Caballeros— es violinista dominicana y la primera latinoamericana admitida en la Yehudi Menuhin School de Londres.

**Una niña prodigio en Santiago**

Hija de Saifuddin Syed, de ascendencia pakistaní, y de Carolina Castro, empezó a estudiar violín y flauta a los cuatro años en el Hogar de la Armonía de Santiago con el maestro Henry Disla, viajando dos veces por semana a Santo Domingo para tomar clases con Hipólito Javier Guerrero y estudiando después con Caonex Peguero. A los seis años entró a la Orquesta Sinfónica Infantil y, a los once, se convirtió en la solista más joven en presentarse con la Orquesta Sinfónica Nacional, el mismo año en que asistió a un simposio de violín en la Juilliard School de Nueva York.

**Yehudi Menuhin School**

En 2002, tras un proceso de audición de dos años, fue admitida en la Yehudi Menuhin School de Londres con una beca del gobierno británico —la primera estudiante latinoamericana que aceptó la escuela.

**Compartiendo tarima con los grandes**

En 2007 tocó junto a Michel Camilo en los Premios Casandra y compartió escena con el pianista Jeremy Menuhin. En marzo de 2009, en el Festival Eilat de Israel, tocó bajo la dirección de Maxim Vengerov junto a los violinistas Julian Rachlin, Pavel Vernikov y Boris Kushnir y el violinista y comediante Aleksey Igudesman; ese julio, el compositor israelí Noam Sheriff la eligió para estrenar mundialmente su concierto «Vísperas del Canario» en el Festival Menuhin de Gstaad, Suiza.

**Reconocimiento**

En enero de 2009 ganó un concurso internacional entre tres mil jóvenes músicos de veinte países, y ese mismo año los Premios Casandra la nombraron Violinista Internacional.

**Legado**

Ha seguido grabando álbumes como «Martinaitis» y presentándose por Europa, América y Asia, llevando el sonido de un violín que tomó por primera vez a los cuatro años en Santiago a salas de concierto a las que República Dominicana rara vez llega.' WHERE slug = 'aisha-syed-castro';

COMMIT;
