BEGIN;

-- Bryan Dotel: productor, compositor e intérprete de música tropical urbana, hijo de Vladimir Dotel (líder de Ilegales); no un artista de pop y balada acústica como decía el relleno. Fuentes: Listín Diario (Emelyn Baldera, 7 may. 2018, entrevista a padre e hijo), El Día (11 may. 2018, lanzamiento de «Aventura»), MusicBrainz (Cosquilleo 27 abr. 2018; Aventura 11 may. 2018), canal de Ilegales en YouTube («Así», 28 oct. 2016; «Cuando lo hacemos», 28 sep. 2018), Bryan Dotel - Topic (Cuando lo hacemos, 27 mar. 2026), créditos de «El Truquito» (remix típico de El Grupasos). Campos: primary_genre urbano (era merengue sin respaldo), genres vacío (ballads), occupations producer y songwriter. Nacimiento: la fila trae 2 dic. 1999 sin fuente; Listín Diario lo da con 18 años en mayo de 2018, coherente: el texto solo dice 1999.

UPDATE artists SET primary_genre = 'urbano', genres = ARRAY[]::text[], occupations = '["producer","songwriter"]'::jsonb WHERE slug = 'bryan-dotel';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Bryan Dotel is a Dominican singer, songwriter and producer born in 1999, the son of Vladimir Dotel, leader of the group "},{"type":"artistReference","attrs":{"occurrenceId":"70c7efe5-69f7-4545-883d-e1920d7f6152","artistId":"1cd11a22-573a-43b4-8f54-fbd08329a4e2","displayText":"Ilegales"}},{"type":"text","text":". He describes his sound as tropical urban."}]},{"type":"paragraph","content":[{"type":"text","text":"Beginnings","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Listín Diario reported in 2018 that Vladimir Dotel woke one day to piano chords in his house and found his second son playing them, having learned without a teacher, only with tutorials. Of Dotel’s four children, Bryan was the only one to show a direct interest in music, and he wanted to learn on his own, without his father’s involvement. At fifteen he made his first appearance at Casa de Teatro."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Before his own debut he experimented with «Cosquilleo», a song his father promoted in several Central American countries, and El Día reported that the two turned it into a hit across Central America in the two years before 2018. On 11 May 2018 he released «Aventura (El que se enamora pierde)», his first official single, with Vladimir Dotel and Ilegales. It was written by both, produced by Bryan and shot as a video directed by Freddy Vargas. Bryan said he was looking for a tropical urban sound and considered himself more a producer than a singer. He later put out «Cuando lo hacemos», with an official video in September 2018 and a new release in March 2026. He is also credited as co-writer and producer of the típico remix of «El truquito» by El Grupasos."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His career is documented through the 2018 interviews with him and his father and through the releases and videos that carry his credits."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bryan-dotel'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'bryan-dotel' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '70c7efe5-69f7-4545-883d-e1920d7f6152', 'artist', '1cd11a22-573a-43b4-8f54-fbd08329a4e2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'bryan-dotel' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Bryan Dotel is a Dominican singer, songwriter and producer born in 1999, the son of Vladimir Dotel, leader of the group Ilegales. He describes his sound as tropical urban.

**Beginnings**

Listín Diario reported in 2018 that Vladimir Dotel woke one day to piano chords in his house and found his second son playing them, having learned without a teacher, only with tutorials. Of Dotel’s four children, Bryan was the only one to show a direct interest in music, and he wanted to learn on his own, without his father’s involvement. At fifteen he made his first appearance at Casa de Teatro.

**Songs**

Before his own debut he experimented with «Cosquilleo», a song his father promoted in several Central American countries, and El Día reported that the two turned it into a hit across Central America in the two years before 2018. On 11 May 2018 he released «Aventura (El que se enamora pierde)», his first official single, with Vladimir Dotel and Ilegales. It was written by both, produced by Bryan and shot as a video directed by Freddy Vargas. Bryan said he was looking for a tropical urban sound and considered himself more a producer than a singer. He later put out «Cuando lo hacemos», with an official video in September 2018 and a new release in March 2026. He is also credited as co-writer and producer of the típico remix of «El truquito» by El Grupasos.

**Legacy**

His career is documented through the 2018 interviews with him and his father and through the releases and videos that carry his credits.' WHERE slug = 'bryan-dotel';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Bryan Dotel es un cantante, compositor y productor dominicano nacido en 1999, hijo de Vladimir Dotel, líder del grupo "},{"type":"artistReference","attrs":{"occurrenceId":"7bf8ba76-5ecb-49b2-8fa5-b7e06c1669b2","artistId":"1cd11a22-573a-43b4-8f54-fbd08329a4e2","displayText":"Ilegales"}},{"type":"text","text":". Describe su sonido como tropical urbano."}]},{"type":"paragraph","content":[{"type":"text","text":"Inicios","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Listín Diario contó en 2018 que un día Vladimir Dotel se despertó con unos acordes de piano en su casa y encontró a su segundo hijo tocándolos, sin haber tenido maestro, solo con tutoriales. De los cuatro hijos de Dotel, Bryan fue el único que mostró un interés directo por la música, y quería aprender por su cuenta, sin la participación de su padre. A los quince años hizo su primera presentación en Casa de Teatro."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Antes de su debut propio experimentó con «Cosquilleo», un tema que su padre promocionó en varios países de Centroamérica, y El Día informó que ambos lo convirtieron en un éxito de toda Centroamérica en los dos años previos a 2018. El 11 de mayo de 2018 lanzó «Aventura (El que se enamora pierde)», su primer sencillo oficial, con Vladimir Dotel e Ilegales. Fue compuesto por ambos, producido por Bryan y acompañado de un video dirigido por Freddy Vargas. Bryan dijo que buscaba un sonido tropical urbano y que se consideraba más productor que cantante. Después publicó «Cuando lo hacemos», con video oficial en septiembre de 2018 y un nuevo lanzamiento en marzo de 2026. También figura como coautor y productor del remix típico de «El truquito» de El Grupasos."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su trayectoria está documentada en las entrevistas de 2018 con él y su padre y en los lanzamientos y videos que llevan sus créditos."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'bryan-dotel'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'bryan-dotel' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '7bf8ba76-5ecb-49b2-8fa5-b7e06c1669b2', 'artist', '1cd11a22-573a-43b4-8f54-fbd08329a4e2' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'bryan-dotel' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Bryan Dotel es un cantante, compositor y productor dominicano nacido en 1999, hijo de Vladimir Dotel, líder del grupo Ilegales. Describe su sonido como tropical urbano.

**Inicios**

Listín Diario contó en 2018 que un día Vladimir Dotel se despertó con unos acordes de piano en su casa y encontró a su segundo hijo tocándolos, sin haber tenido maestro, solo con tutoriales. De los cuatro hijos de Dotel, Bryan fue el único que mostró un interés directo por la música, y quería aprender por su cuenta, sin la participación de su padre. A los quince años hizo su primera presentación en Casa de Teatro.

**Canciones**

Antes de su debut propio experimentó con «Cosquilleo», un tema que su padre promocionó en varios países de Centroamérica, y El Día informó que ambos lo convirtieron en un éxito de toda Centroamérica en los dos años previos a 2018. El 11 de mayo de 2018 lanzó «Aventura (El que se enamora pierde)», su primer sencillo oficial, con Vladimir Dotel e Ilegales. Fue compuesto por ambos, producido por Bryan y acompañado de un video dirigido por Freddy Vargas. Bryan dijo que buscaba un sonido tropical urbano y que se consideraba más productor que cantante. Después publicó «Cuando lo hacemos», con video oficial en septiembre de 2018 y un nuevo lanzamiento en marzo de 2026. También figura como coautor y productor del remix típico de «El truquito» de El Grupasos.

**Legado**

Su trayectoria está documentada en las entrevistas de 2018 con él y su padre y en los lanzamientos y videos que llevan sus créditos.' WHERE slug = 'bryan-dotel';

COMMIT;
