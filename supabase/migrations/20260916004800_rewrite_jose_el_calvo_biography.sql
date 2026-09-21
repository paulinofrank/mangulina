BEGIN;

-- Ficha de José El Calvo. Nombre corregido (José Alberto Cabrera Bonilla; el relleno decía "José Gabriel Guaba"),
-- primary_role singer -> musician (saxofonista), occupations con saxophonist, genres merengue-perico-ripiao.

UPDATE artists SET first_name = 'José', middle_name = 'Alberto', last_name = 'Cabrera', second_last_name = 'Bonilla',
       aliases = ARRAY['Jose El Calvo y Su Conjunto Tipico','José El Calvo y su Artillería Pesada']::text[], primary_role = 'musician',
       occupations = '["saxophonist","bandleader","composer","arranger"]'::jsonb, genres = ARRAY['merengue-perico-ripiao']::text[]
       WHERE slug = 'jose-el-calvo';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"José El Calvo —born José Alberto Cabrera Bonilla in Imbert, Puerto Plata, on 11 February 1956— is a Dominican saxophonist, composer and arranger who leads the merengue típico group «José El Calvo y su Artillería Pesada»."}]},{"type":"paragraph","content":[{"type":"text","text":"From the tambora to the saxophone","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began as a percussionist in his hometown, playing tambora in the orchestra «Los Príncipes de Imbert», and then studied music and moved to the saxophone. His first professional work as a saxophonist was in the típico groups of Facundo Peña and «Los Hermanos Cruz». In 1978 he joined the group of Bartolo Alvarado, “El Ciego de Nagua”, and stayed about fifteen years, which he remembers as his school."}]},{"type":"paragraph","content":[{"type":"text","text":"The sideman","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Alongside his own group he became one of the most recorded saxophonists in the genre; by his own count he has played on more than 400 típico merengues by other artists. Over a hundred of them were with Alvarado. Others include a live album by "},{"type":"artistReference","attrs":{"occurrenceId":"8dc21a3e-f915-481d-adbd-a3fcfde47721","artistId":"9333da06-ad03-44eb-9b81-c21d0ccdd0ea","displayText":"Fefita la Grande"}},{"type":"text","text":", the whole of «La Grama Chapiá» by "},{"type":"artistReference","attrs":{"occurrenceId":"bbd92547-5278-46e2-ab4c-d95b551f5383","artistId":"424d789c-fe7a-4912-a1c1-c8baa74b4359","displayText":"Raquel Arias"}},{"type":"text","text":", «Apriétame así» by "},{"type":"artistReference","attrs":{"occurrenceId":"9c28b138-422a-4df0-93b5-d222732af131","artistId":"c462498c-0f4d-464f-b624-a576f8080e9d","displayText":"La India Canela"}},{"type":"text","text":", four productions by "},{"type":"artistReference","attrs":{"occurrenceId":"4adc0766-f152-4071-a19d-c5447f7d6b7e","artistId":"e9004428-e647-4a06-8316-b398452d46df","displayText":"María Díaz"}},{"type":"text","text":" and four by Toribio de la Cruz, and recordings with "},{"type":"artistReference","attrs":{"occurrenceId":"5e9f7365-2c63-438f-992f-903448efac9a","artistId":"3680fc10-c3fd-42c4-ad54-90d79b226a7d","displayText":"Francisco Ulloa"}},{"type":"text","text":", Ciano Arias, King de la Rosa and El Negrito Figueroa. He also played for "},{"type":"artistReference","attrs":{"occurrenceId":"454a74f8-79b1-4c39-ad3a-08c6d131facf","artistId":"7a92e4df-157c-49d9-9905-17ac0f740c4e","displayText":"Rafaelito Román"}},{"type":"text","text":", and outside típico he recorded with "},{"type":"artistReference","attrs":{"occurrenceId":"d45b2d16-4092-4deb-8225-12eba60e585d","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"87576bb6-e0d6-493b-8722-90926411db84","artistId":"6c3e0d74-23b7-4d80-969f-9d5319ee5127","displayText":"Alex Bueno"}},{"type":"text","text":" and, with the singer Marcel, «Vamo hablar Inglés»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Artillería Pesada»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"When Alvarado paused his career in 1992, José El Calvo formed his own group. He went to Puerto Plata to recruit Pedrito Reynoso and other musicians from his hometown, and put a saxophonist at the head of a genre whose bandleaders are usually accordionists. By 2021 he had recorded twelve albums, beginning with «La Parcela», which contains «Pa’ to perdió», the song he calls his flagship. His distributor’s biography places nine of them with «Allegro Producción», where «El Picoteao» and «La Samaritana» were among his hits, and three with «Juan y Nelson Records», linked to Sony."}]},{"type":"paragraph","content":[{"type":"text","text":"What he says he changed","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He credits himself with two innovations in típico. In his years with Alvarado the musicians played seated, and he persuaded his leader to have them play standing, a practice the other groups then adopted. He also says he arranged the saxophone and the accordion to play a melody in unison, a duet that, in his words, every group now uses."}]},{"type":"paragraph","content":[{"type":"text","text":"Recognition","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His own biography and a cultural society’s profile both credit him with Casandra awards for típico groups in 1996, 1997, 1998 and 1999; they differ on other years, and no official list for those editions is available online."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In a 2021 interview he said he was choosing ten songs for his next production, and his YouTube channel has since published a series of «Retro» compilations, a tribute to Alvarado and recent recordings with Narciso “El Pavarotti” and Pedrito Reynoso. The same cultural society describes him as a reference for saxophonists in típico music."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jose-el-calvo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jose-el-calvo' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '8dc21a3e-f915-481d-adbd-a3fcfde47721', 'artist', '9333da06-ad03-44eb-9b81-c21d0ccdd0ea' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'bbd92547-5278-46e2-ab4c-d95b551f5383', 'artist', '424d789c-fe7a-4912-a1c1-c8baa74b4359' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '9c28b138-422a-4df0-93b5-d222732af131', 'artist', 'c462498c-0f4d-464f-b624-a576f8080e9d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '4adc0766-f152-4071-a19d-c5447f7d6b7e', 'artist', 'e9004428-e647-4a06-8316-b398452d46df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '5e9f7365-2c63-438f-992f-903448efac9a', 'artist', '3680fc10-c3fd-42c4-ad54-90d79b226a7d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '454a74f8-79b1-4c39-ad3a-08c6d131facf', 'artist', '7a92e4df-157c-49d9-9905-17ac0f740c4e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'd45b2d16-4092-4deb-8225-12eba60e585d', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '87576bb6-e0d6-493b-8722-90926411db84', 'artist', '6c3e0d74-23b7-4d80-969f-9d5319ee5127' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'José El Calvo —born José Alberto Cabrera Bonilla in Imbert, Puerto Plata, on 11 February 1956— is a Dominican saxophonist, composer and arranger who leads the merengue típico group «José El Calvo y su Artillería Pesada».

**From the tambora to the saxophone**

He began as a percussionist in his hometown, playing tambora in the orchestra «Los Príncipes de Imbert», and then studied music and moved to the saxophone. His first professional work as a saxophonist was in the típico groups of Facundo Peña and «Los Hermanos Cruz». In 1978 he joined the group of Bartolo Alvarado, “El Ciego de Nagua”, and stayed about fifteen years, which he remembers as his school.

**The sideman**

Alongside his own group he became one of the most recorded saxophonists in the genre; by his own count he has played on more than 400 típico merengues by other artists. Over a hundred of them were with Alvarado. Others include a live album by Fefita la Grande, the whole of «La Grama Chapiá» by Raquel Arias, «Apriétame así» by La India Canela, four productions by María Díaz and four by Toribio de la Cruz, and recordings with Francisco Ulloa, Ciano Arias, King de la Rosa and El Negrito Figueroa. He also played for Rafaelito Román, and outside típico he recorded with Héctor Acosta “El Torito” and Alex Bueno and, with the singer Marcel, «Vamo hablar Inglés».

**«Artillería Pesada»**

When Alvarado paused his career in 1992, José El Calvo formed his own group. He went to Puerto Plata to recruit Pedrito Reynoso and other musicians from his hometown, and put a saxophonist at the head of a genre whose bandleaders are usually accordionists. By 2021 he had recorded twelve albums, beginning with «La Parcela», which contains «Pa’ to perdió», the song he calls his flagship. His distributor’s biography places nine of them with «Allegro Producción», where «El Picoteao» and «La Samaritana» were among his hits, and three with «Juan y Nelson Records», linked to Sony.

**What he says he changed**

He credits himself with two innovations in típico. In his years with Alvarado the musicians played seated, and he persuaded his leader to have them play standing, a practice the other groups then adopted. He also says he arranged the saxophone and the accordion to play a melody in unison, a duet that, in his words, every group now uses.

**Recognition**

His own biography and a cultural society’s profile both credit him with Casandra awards for típico groups in 1996, 1997, 1998 and 1999; they differ on other years, and no official list for those editions is available online.

**Legacy**

In a 2021 interview he said he was choosing ten songs for his next production, and his YouTube channel has since published a series of «Retro» compilations, a tribute to Alvarado and recent recordings with Narciso “El Pavarotti” and Pedrito Reynoso. The same cultural society describes him as a reference for saxophonists in típico music.' WHERE slug = 'jose-el-calvo';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"José El Calvo —nacido José Alberto Cabrera Bonilla en Imbert, Puerto Plata, el 11 de febrero de 1956— es un saxofonista, compositor y arreglista dominicano que dirige el grupo de merengue típico «José El Calvo y su Artillería Pesada»."}]},{"type":"paragraph","content":[{"type":"text","text":"De la tambora al saxofón","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó de percusionista en su pueblo, tocando la tambora con «Los Príncipes de Imbert», y luego estudió música y pasó al saxofón. Su primer trabajo profesional como saxofonista fue en los conjuntos típicos de Facundo Peña y «Los Hermanos Cruz». En 1978 entró al grupo de Bartolo Alvarado, “El Ciego de Nagua”, con el que estuvo unos quince años y que recuerda como su escuela."}]},{"type":"paragraph","content":[{"type":"text","text":"El músico de otros","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Junto a su propia agrupación se volvió uno de los saxofonistas más grabados del género; según su propia cuenta ha tocado en más de 400 merengues típicos de otros artistas. Más de cien fueron con Alvarado. Otros son un disco en vivo de "},{"type":"artistReference","attrs":{"occurrenceId":"399cd223-8ccd-459d-b8b6-a1c4048aaf7b","artistId":"9333da06-ad03-44eb-9b81-c21d0ccdd0ea","displayText":"Fefita la Grande"}},{"type":"text","text":", toda la producción «La Grama Chapiá» de "},{"type":"artistReference","attrs":{"occurrenceId":"8888af1c-6b5c-42ed-a2a3-f519b27c35c6","artistId":"424d789c-fe7a-4912-a1c1-c8baa74b4359","displayText":"Raquel Arias"}},{"type":"text","text":", «Apriétame así» de "},{"type":"artistReference","attrs":{"occurrenceId":"239325bc-bd04-4efc-a845-af8f6679450a","artistId":"c462498c-0f4d-464f-b624-a576f8080e9d","displayText":"La India Canela"}},{"type":"text","text":", cuatro producciones de "},{"type":"artistReference","attrs":{"occurrenceId":"36b27f49-4b46-44bd-8190-18317e5fb3b8","artistId":"e9004428-e647-4a06-8316-b398452d46df","displayText":"María Díaz"}},{"type":"text","text":" y cuatro de Toribio de la Cruz, y grabaciones con "},{"type":"artistReference","attrs":{"occurrenceId":"74d6de4c-1f59-4265-9287-141d31a3a74a","artistId":"3680fc10-c3fd-42c4-ad54-90d79b226a7d","displayText":"Francisco Ulloa"}},{"type":"text","text":", Ciano Arias, King de la Rosa y El Negrito Figueroa. También tocó para "},{"type":"artistReference","attrs":{"occurrenceId":"06daea17-d158-4552-81f8-1a885fea6c6f","artistId":"7a92e4df-157c-49d9-9905-17ac0f740c4e","displayText":"Rafaelito Román"}},{"type":"text","text":", y fuera del típico grabó con "},{"type":"artistReference","attrs":{"occurrenceId":"20038945-0b07-4cd9-9eb1-7d327e3fcb06","artistId":"dee014d6-cb3c-4abb-9262-165538277a0d","displayText":"Héctor Acosta “El Torito”"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"401a2bf7-7df8-4685-aafa-38ebddedcae5","artistId":"6c3e0d74-23b7-4d80-969f-9d5319ee5127","displayText":"Alex Bueno"}},{"type":"text","text":" y, con la cantante Marcel, «Vamo hablar Inglés»."}]},{"type":"paragraph","content":[{"type":"text","text":"«Artillería Pesada»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Cuando Alvarado detuvo su carrera en 1992, José El Calvo formó su propio grupo. Viajó a Puerto Plata a reclutar a Pedrito Reynoso y a otros músicos de su pueblo, y puso a un saxofonista al frente de un género cuyos líderes suelen ser acordeonistas. Hasta 2021 había grabado doce discos, comenzando con «La Parcela», que incluye «Pa’ to perdió», la canción que llama su buque insignia. La biografía de su distribuidora ubica nueve de ellos en «Allegro Producción», donde «El Picoteao» y «La Samaritana» figuraron entre sus éxitos, y tres en «Juan y Nelson Records», vinculado a Sony."}]},{"type":"paragraph","content":[{"type":"text","text":"Lo que dice haber cambiado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Se atribuye dos innovaciones en el típico. Con Alvarado la banda actuaba sentada; él logró que su jefe la pusiera de pie, y los demás grupos siguieron esa costumbre. Dice también que arregló el saxofón y el acordeón para tocar la melodía al unísono, un dúo que, según él, hoy usan todos los grupos."}]},{"type":"paragraph","content":[{"type":"text","text":"Reconocimientos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su propia biografía y el perfil de una sociedad cultural le atribuyen premios Casandra como grupo típico en 1996, 1997, 1998 y 1999; difieren en otros años, y no hay una lista oficial en línea de esas ediciones."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En una entrevista de 2021 contó que seleccionaba una decena de canciones para su siguiente disco, y desde entonces su canal de YouTube ha publicado una serie de compilados «Retro», un homenaje a Alvarado y grabaciones recientes con Narciso “El Pavarotti” y Pedrito Reynoso. La misma sociedad cultural lo describe como un referente para los saxofonistas de la música típica."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jose-el-calvo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jose-el-calvo' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '399cd223-8ccd-459d-b8b6-a1c4048aaf7b', 'artist', '9333da06-ad03-44eb-9b81-c21d0ccdd0ea' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '8888af1c-6b5c-42ed-a2a3-f519b27c35c6', 'artist', '424d789c-fe7a-4912-a1c1-c8baa74b4359' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '239325bc-bd04-4efc-a845-af8f6679450a', 'artist', 'c462498c-0f4d-464f-b624-a576f8080e9d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '36b27f49-4b46-44bd-8190-18317e5fb3b8', 'artist', 'e9004428-e647-4a06-8316-b398452d46df' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '74d6de4c-1f59-4265-9287-141d31a3a74a', 'artist', '3680fc10-c3fd-42c4-ad54-90d79b226a7d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '06daea17-d158-4552-81f8-1a885fea6c6f', 'artist', '7a92e4df-157c-49d9-9905-17ac0f740c4e' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '20038945-0b07-4cd9-9eb1-7d327e3fcb06', 'artist', 'dee014d6-cb3c-4abb-9262-165538277a0d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '401a2bf7-7df8-4685-aafa-38ebddedcae5', 'artist', '6c3e0d74-23b7-4d80-969f-9d5319ee5127' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'jose-el-calvo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'José El Calvo —nacido José Alberto Cabrera Bonilla en Imbert, Puerto Plata, el 11 de febrero de 1956— es un saxofonista, compositor y arreglista dominicano que dirige el grupo de merengue típico «José El Calvo y su Artillería Pesada».

**De la tambora al saxofón**

Empezó de percusionista en su pueblo, tocando la tambora con «Los Príncipes de Imbert», y luego estudió música y pasó al saxofón. Su primer trabajo profesional como saxofonista fue en los conjuntos típicos de Facundo Peña y «Los Hermanos Cruz». En 1978 entró al grupo de Bartolo Alvarado, “El Ciego de Nagua”, con el que estuvo unos quince años y que recuerda como su escuela.

**El músico de otros**

Junto a su propia agrupación se volvió uno de los saxofonistas más grabados del género; según su propia cuenta ha tocado en más de 400 merengues típicos de otros artistas. Más de cien fueron con Alvarado. Otros son un disco en vivo de Fefita la Grande, toda la producción «La Grama Chapiá» de Raquel Arias, «Apriétame así» de La India Canela, cuatro producciones de María Díaz y cuatro de Toribio de la Cruz, y grabaciones con Francisco Ulloa, Ciano Arias, King de la Rosa y El Negrito Figueroa. También tocó para Rafaelito Román, y fuera del típico grabó con Héctor Acosta “El Torito” y Alex Bueno y, con la cantante Marcel, «Vamo hablar Inglés».

**«Artillería Pesada»**

Cuando Alvarado detuvo su carrera en 1992, José El Calvo formó su propio grupo. Viajó a Puerto Plata a reclutar a Pedrito Reynoso y a otros músicos de su pueblo, y puso a un saxofonista al frente de un género cuyos líderes suelen ser acordeonistas. Hasta 2021 había grabado doce discos, comenzando con «La Parcela», que incluye «Pa’ to perdió», la canción que llama su buque insignia. La biografía de su distribuidora ubica nueve de ellos en «Allegro Producción», donde «El Picoteao» y «La Samaritana» figuraron entre sus éxitos, y tres en «Juan y Nelson Records», vinculado a Sony.

**Lo que dice haber cambiado**

Se atribuye dos innovaciones en el típico. Con Alvarado la banda actuaba sentada; él logró que su jefe la pusiera de pie, y los demás grupos siguieron esa costumbre. Dice también que arregló el saxofón y el acordeón para tocar la melodía al unísono, un dúo que, según él, hoy usan todos los grupos.

**Reconocimientos**

Su propia biografía y el perfil de una sociedad cultural le atribuyen premios Casandra como grupo típico en 1996, 1997, 1998 y 1999; difieren en otros años, y no hay una lista oficial en línea de esas ediciones.

**Legado**

En una entrevista de 2021 contó que seleccionaba una decena de canciones para su siguiente disco, y desde entonces su canal de YouTube ha publicado una serie de compilados «Retro», un homenaje a Alvarado y grabaciones recientes con Narciso “El Pavarotti” y Pedrito Reynoso. La misma sociedad cultural lo describe como un referente para los saxofonistas de la música típica.' WHERE slug = 'jose-el-calvo';

COMMIT;
