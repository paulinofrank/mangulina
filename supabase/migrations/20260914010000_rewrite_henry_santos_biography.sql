BEGIN;

-- Ficha de Henry Santos.
--
-- Alias "Aventura" retirado de henry-santos Y de romeo-santos: el grupo tiene
-- fila propia. Sexto y séptimo caso del patrón banda-como-alias.
--
-- founder_of Aventura: se mantiene start 1993 (Listín Diario 2026 y la ficha
-- de Aventura) pero end_year pasa de 2011 a NULL: hubo regresos en 2014,
-- 2016, 2019-2021 y la gira de 2024-2025, y él mismo niega la separación.
-- La relación de romeo-santos tiene el mismo 2011 y queda sin tocar.
--
-- Nombre: MusicBrainz registra como legal "Henry Vicente Santos Taveras";
-- Wikipedia dice que a los 17 se cambió el apellido a Jeter. La fila
-- (Santos / Jeter) coincide con el nombre posterior al cambio y no se toca.
--
-- Fuera: su matrimonio y la depresión que relata en Listín (vida personal y
-- salud). "Mira quién baila" (2012) va en prosa pero no como premio.

UPDATE artists SET aliases = array_remove(aliases, 'Aventura') WHERE slug IN ('henry-santos', 'romeo-santos');
UPDATE artist_relationships r
   SET end_year = NULL,
       notes = 'Second voice, songwriter and producer; group paused in 2011 and reunited 2014, 2016, 2019-2021 and 2024-2025'
  FROM artists s, artists g
 WHERE r.source_artist_id = s.id AND r.target_artist_id = g.id
   AND s.slug = 'henry-santos' AND g.slug = 'aventura' AND r.relationship_type = 'founder_of';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Henry Santos is a Dominican singer, songwriter and producer, born in Moca on 15 December 1979. He was the second voice of "},{"type":"artistReference","attrs":{"occurrenceId":"b7e1b4dd-201f-444c-bc59-2f5586bb54d9","artistId":"3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3","displayText":"Aventura"}},{"type":"text","text":", the Bronx group that took bachata into stadiums, and has recorded under his own name since 2011. He is the cousin of "},{"type":"artistReference","attrs":{"occurrenceId":"f94ba843-5157-4b53-952b-3d9dcbf24af4","artistId":"8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3","displayText":"Romeo Santos"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Moca and the Bronx","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Santos moved from Moca to the Bronx with his family at thirteen. In 1993 he and his cousin met the brothers Lenny and Max Santos — no relation, despite the surname — and the four started playing together as «Los Tinellers», the English word teenagers spelled the way the neighbourhood said it. When he took United States citizenship at seventeen he changed his surname to Jeter, after the Yankees shortstop who had just arrived in the major leagues, and has signed as Henry Santos Jeter since."}]},{"type":"paragraph","content":[{"type":"text","text":"The second voice","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Trampa de Amor», recorded in 1996, sold almost nothing. The manager Julio César García renamed them "},{"type":"artistReference","attrs":{"occurrenceId":"b3738417-d37f-4f5f-86de-a36eee3b1680","artistId":"3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3","displayText":"Aventura"}},{"type":"text","text":", they signed to «Premium Latin Music» in 1998, and within a decade they had taken bachata to number one in Italy and France and sold out Madison Square Garden. Inside the group Santos sang harmony and backing vocals on most of the catalogue, danced on stage, wrote and produced, and took the lead on «9:15», «Déjà Vu», «Voy Malacostumbrado» and «Princesita». When "},{"type":"artistReference","attrs":{"occurrenceId":"622b26b7-1779-49dd-8157-ccbc58ea6e8e","artistId":"3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3","displayText":"Aventura"}},{"type":"text","text":" paused in 2011, he was the member with the least exposure as a lead."}]},{"type":"paragraph","content":[{"type":"text","text":"On his own","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He signed with «Siente Music», under Venemusic and Universal, and released «Poquito a Poquito» on 2 May 2011; «Introducing Henry Santos» followed in October and entered Billboard’s Tropical Albums at number two. «My Way» (2013) gave him his first number one on Tropical Airplay with its title track, featured "},{"type":"artistReference","attrs":{"occurrenceId":"e1c706b0-67fd-4316-beb8-c23f4bef0326","artistId":"af726afa-c7a0-47da-99bb-a4c7669a8785","displayText":"Natti Natasha"}},{"type":"text","text":", and led to «La Vida», made with the producer "},{"type":"artistReference","attrs":{"occurrenceId":"99a28ae6-7358-4fd2-920b-3e80fbbeea1c","artistId":"4688614f-d936-4fb8-8bf1-04008de4256b","displayText":"Maffio"}},{"type":"text","text":", which went to number one as well. When «Siente Music» closed in 2015 it handed him his masters, and he has worked independently since through his own label, «HustleHard Entertainment»: «Henry The Third» (2016), with "},{"type":"artistReference","attrs":{"occurrenceId":"a1453999-8f42-48c9-8cea-f9fcd3707986","artistId":"b22dbf04-c87b-4842-baac-0616b7613208","displayText":"Jhoni The Voice"}},{"type":"text","text":" among the guests, a live compilation in 2017, «Shut Up & Listen» (2018) and two karaoke albums."}]},{"type":"paragraph","content":[{"type":"text","text":"In the autumn of 2012 he became the first Dominican to compete on «Mira quién baila», Univision’s version of Dancing with the Stars, and won the third season on 18 November with 41 per cent of the public vote, without once being nominated for elimination."}]},{"type":"paragraph","content":[{"type":"text","text":"Friends and legends","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Friends & Legends» (2021) was a record of bachata duets across generations: "},{"type":"artistReference","attrs":{"occurrenceId":"bdc7f7bb-bd2b-46a0-af94-46725b83a6b3","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":", with whom he had released «Don Juan & Cupido» in 2019; "},{"type":"artistReference","attrs":{"occurrenceId":"a08630eb-b0b9-413e-b06b-b2c0e586d454","artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas"}},{"type":"text","text":"; "},{"type":"artistReference","attrs":{"occurrenceId":"dd0f6f54-e8fd-4c13-bd7f-a0504298dda8","artistId":"aec32df5-cc5a-43c2-ac33-02bc8caa1cf5","displayText":"Joe Veras"}},{"type":"text","text":", on «No me Tocó Morir por Ti»; "},{"type":"artistReference","attrs":{"occurrenceId":"669175f6-5031-4925-8b01-8044489e9ce7","artistId":"14a4dba6-84d2-4e50-bfb7-d40e3009b42a","displayText":"Alexandra Queen"}},{"type":"text","text":", on «Como Abeja a la Flor»; "},{"type":"artistReference","attrs":{"occurrenceId":"b0c6d661-83ab-4e18-88bc-283f6b548b3e","artistId":"84aba9ce-ba69-4caa-b71b-2bedb2f848fc","displayText":"Daniel Santacruz"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"e0b9d729-c40c-489a-85a7-01775d9e16d5","artistId":"5ce0aa05-7d1a-4750-8cd2-dab62b06a244","displayText":"Grupo Extra"}},{"type":"text","text":", the salsero "},{"type":"artistReference","attrs":{"occurrenceId":"d093356f-1c12-40ee-8ddb-7db649014224","artistId":"69ca4e3b-2a3a-4e61-a5bd-2210606c5f13","displayText":"David Kada"}},{"type":"text","text":", and "},{"type":"artistReference","attrs":{"occurrenceId":"9074cfea-8d1e-41c5-8081-81534c6cc34f","artistId":"f07fcc6b-a888-4e97-ac50-6ce6ea37a714","displayText":"El Prodigio"}},{"type":"text","text":" on the merengue «I’m So In Love». «2.0» followed in 2024, preceded by a bachata version of "},{"type":"artistReference","attrs":{"occurrenceId":"48a66601-5a2b-47fd-af73-7647db83a4f3","artistId":"34b63c95-f79a-4f7b-aa1d-426926d12959","displayText":"Pavel Núñez"}},{"type":"text","text":"’s «Te Di» with Núñez himself, «La Excepción» with "},{"type":"artistReference","attrs":{"occurrenceId":"f2b2c1a3-8e14-4682-8e98-0489ae242654","artistId":"2a4813af-a826-410e-9475-b2bd1474b234","displayText":"Kiko Rodríguez"}},{"type":"text","text":" and «No Soy Nada Sin Ti» with "},{"type":"artistReference","attrs":{"occurrenceId":"36916837-02bd-468c-9593-99ab96c369ce","artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes"}},{"type":"text","text":". In 2023 he began releasing boleros with urban production under the name urban bolero."}]},{"type":"paragraph","content":[{"type":"text","text":"The reunions","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"artistReference","attrs":{"occurrenceId":"2b004d8a-f712-4cf5-a6fa-90643e19bb01","artistId":"3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3","displayText":"Aventura"}},{"type":"text","text":" came back several times: a surprise appearance at "},{"type":"artistReference","attrs":{"occurrenceId":"f4ab317c-5d28-423d-9c35-ef6668117143","artistId":"8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3","displayText":"Romeo Santos"}},{"type":"text","text":"’s Yankee Stadium show in 2014, a month of concerts at the United Palace in 2016, «Inmortal» in 2019 and the stadium tour of 2021. For the farewell tour, «Cerrando Ciclos», the group released «Brindo con Agua» on 2 April 2024 — the first Aventura single with Santos as lead voice, issued through his own label. In September 2026 he released «After the Noise», whose song «Leyendas» tells the story of the group from its beginnings as «Los Tinellers»; Lenny Santos co-produced it and Max Santos played bass. Santos rejects the word separation and describes the group as being on a break."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Santos was the member of "},{"type":"artistReference","attrs":{"occurrenceId":"87cdedd8-df63-45a5-b4f1-55a853c63def","artistId":"3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3","displayText":"Aventura"}},{"type":"text","text":" whose voice was most present on the records and least credited in front of them, and his solo work has been an argument about that gap. He has also appeared in the Dominican films «Sanky Panky» and «La Soga», for which he was music supervisor."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'henry-santos'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b7e1b4dd-201f-444c-bc59-2f5586bb54d9', 'artist', '3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f94ba843-5157-4b53-952b-3d9dcbf24af4', 'artist', '8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b3738417-d37f-4f5f-86de-a36eee3b1680', 'artist', '3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '622b26b7-1779-49dd-8157-ccbc58ea6e8e', 'artist', '3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e1c706b0-67fd-4316-beb8-c23f4bef0326', 'artist', 'af726afa-c7a0-47da-99bb-a4c7669a8785' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '99a28ae6-7358-4fd2-920b-3e80fbbeea1c', 'artist', '4688614f-d936-4fb8-8bf1-04008de4256b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a1453999-8f42-48c9-8cea-f9fcd3707986', 'artist', 'b22dbf04-c87b-4842-baac-0616b7613208' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'bdc7f7bb-bd2b-46a0-af94-46725b83a6b3', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a08630eb-b0b9-413e-b06b-b2c0e586d454', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'dd0f6f54-e8fd-4c13-bd7f-a0504298dda8', 'artist', 'aec32df5-cc5a-43c2-ac33-02bc8caa1cf5' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '669175f6-5031-4925-8b01-8044489e9ce7', 'artist', '14a4dba6-84d2-4e50-bfb7-d40e3009b42a' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b0c6d661-83ab-4e18-88bc-283f6b548b3e', 'artist', '84aba9ce-ba69-4caa-b71b-2bedb2f848fc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e0b9d729-c40c-489a-85a7-01775d9e16d5', 'artist', '5ce0aa05-7d1a-4750-8cd2-dab62b06a244' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'd093356f-1c12-40ee-8ddb-7db649014224', 'artist', '69ca4e3b-2a3a-4e61-a5bd-2210606c5f13' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '9074cfea-8d1e-41c5-8081-81534c6cc34f', 'artist', 'f07fcc6b-a888-4e97-ac50-6ce6ea37a714' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '48a66601-5a2b-47fd-af73-7647db83a4f3', 'artist', '34b63c95-f79a-4f7b-aa1d-426926d12959' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f2b2c1a3-8e14-4682-8e98-0489ae242654', 'artist', '2a4813af-a826-410e-9475-b2bd1474b234' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '36916837-02bd-468c-9593-99ab96c369ce', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '2b004d8a-f712-4cf5-a6fa-90643e19bb01', 'artist', '3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f4ab317c-5d28-423d-9c35-ef6668117143', 'artist', '8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '87cdedd8-df63-45a5-b4f1-55a853c63def', 'artist', '3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Henry Santos is a Dominican singer, songwriter and producer, born in Moca on 15 December 1979. He was the second voice of Aventura, the Bronx group that took bachata into stadiums, and has recorded under his own name since 2011. He is the cousin of Romeo Santos.

**Moca and the Bronx**

Santos moved from Moca to the Bronx with his family at thirteen. In 1993 he and his cousin met the brothers Lenny and Max Santos — no relation, despite the surname — and the four started playing together as «Los Tinellers», the English word teenagers spelled the way the neighbourhood said it. When he took United States citizenship at seventeen he changed his surname to Jeter, after the Yankees shortstop who had just arrived in the major leagues, and has signed as Henry Santos Jeter since.

**The second voice**

«Trampa de Amor», recorded in 1996, sold almost nothing. The manager Julio César García renamed them Aventura, they signed to «Premium Latin Music» in 1998, and within a decade they had taken bachata to number one in Italy and France and sold out Madison Square Garden. Inside the group Santos sang harmony and backing vocals on most of the catalogue, danced on stage, wrote and produced, and took the lead on «9:15», «Déjà Vu», «Voy Malacostumbrado» and «Princesita». When Aventura paused in 2011, he was the member with the least exposure as a lead.

**On his own**

He signed with «Siente Music», under Venemusic and Universal, and released «Poquito a Poquito» on 2 May 2011; «Introducing Henry Santos» followed in October and entered Billboard’s Tropical Albums at number two. «My Way» (2013) gave him his first number one on Tropical Airplay with its title track, featured Natti Natasha, and led to «La Vida», made with the producer Maffio, which went to number one as well. When «Siente Music» closed in 2015 it handed him his masters, and he has worked independently since through his own label, «HustleHard Entertainment»: «Henry The Third» (2016), with Jhoni The Voice among the guests, a live compilation in 2017, «Shut Up & Listen» (2018) and two karaoke albums.

In the autumn of 2012 he became the first Dominican to compete on «Mira quién baila», Univision’s version of Dancing with the Stars, and won the third season on 18 November with 41 per cent of the public vote, without once being nominated for elimination.

**Friends and legends**

«Friends & Legends» (2021) was a record of bachata duets across generations: Antony Santos, with whom he had released «Don Juan & Cupido» in 2019; Luis Vargas; Joe Veras, on «No me Tocó Morir por Ti»; Alexandra Queen, on «Como Abeja a la Flor»; Daniel Santacruz and Grupo Extra, the salsero David Kada, and El Prodigio on the merengue «I’m So In Love». «2.0» followed in 2024, preceded by a bachata version of Pavel Núñez’s «Te Di» with Núñez himself, «La Excepción» with Kiko Rodríguez and «No Soy Nada Sin Ti» with Frank Reyes. In 2023 he began releasing boleros with urban production under the name urban bolero.

**The reunions**

Aventura came back several times: a surprise appearance at Romeo Santos’s Yankee Stadium show in 2014, a month of concerts at the United Palace in 2016, «Inmortal» in 2019 and the stadium tour of 2021. For the farewell tour, «Cerrando Ciclos», the group released «Brindo con Agua» on 2 April 2024 — the first Aventura single with Santos as lead voice, issued through his own label. In September 2026 he released «After the Noise», whose song «Leyendas» tells the story of the group from its beginnings as «Los Tinellers»; Lenny Santos co-produced it and Max Santos played bass. Santos rejects the word separation and describes the group as being on a break.

**Legacy**

Santos was the member of Aventura whose voice was most present on the records and least credited in front of them, and his solo work has been an argument about that gap. He has also appeared in the Dominican films «Sanky Panky» and «La Soga», for which he was music supervisor.' WHERE slug = 'henry-santos';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Henry Santos es cantante, compositor y productor dominicano, nacido en Moca el 15 de diciembre de 1979. Fue la segunda voz de "},{"type":"artistReference","attrs":{"occurrenceId":"167e79a7-5695-44dc-877e-1eda77bc42ec","artistId":"3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3","displayText":"Aventura"}},{"type":"text","text":", el grupo del Bronx que llevó la bachata a los estadios, y graba con su nombre desde 2011. Es primo de "},{"type":"artistReference","attrs":{"occurrenceId":"503f96fa-a936-420a-9100-e49db2416019","artistId":"8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3","displayText":"Romeo Santos"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"De Moca al Bronx","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Santos se mudó con su familia de Moca al Bronx a los trece años. En 1993 él y su primo conocieron a los hermanos Lenny y Max Santos —que no son parientes suyos pese al apellido— y los cuatro empezaron a tocar juntos como «Los Tinellers», la palabra inglesa teenagers escrita como se decía en el barrio. Al hacerse ciudadano estadounidense, a los diecisiete, se cambió el apellido a Jeter, por el campocorto de los Yankees que acababa de debutar en las Grandes Ligas, y desde entonces firma Henry Santos Jeter."}]},{"type":"paragraph","content":[{"type":"text","text":"La segunda voz","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Trampa de Amor», grabado en 1996, casi no vendió. El mánager Julio César García los rebautizó "},{"type":"artistReference","attrs":{"occurrenceId":"082f5919-58bd-4dd7-9cd8-bc1d0420febc","artistId":"3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3","displayText":"Aventura"}},{"type":"text","text":", en 1998 firmaron con «Premium Latin Music», y en una década habían puesto la bachata en el número uno de Italia y Francia y agotado el Madison Square Garden. Dentro del grupo Santos hacía la armonía y los coros de casi todo el repertorio, bailaba en escena, escribía y producía, y llevó la voz principal en «9:15», «Déjà Vu», «Voy Malacostumbrado» y «Princesita». Cuando "},{"type":"artistReference","attrs":{"occurrenceId":"55785292-bba5-40ca-8e3e-94fdd89b6da9","artistId":"3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3","displayText":"Aventura"}},{"type":"text","text":" hizo la pausa de 2011, era el integrante menos expuesto como voz líder."}]},{"type":"paragraph","content":[{"type":"text","text":"Por su cuenta","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Firmó con «Siente Music», bajo Venemusic y Universal, y el 2 de mayo de 2011 sacó «Poquito a Poquito»; «Introducing Henry Santos» llegó en octubre y entró en el número dos de Tropical Albums de Billboard. «My Way» (2013) le dio su primer número uno en Tropical Airplay con el tema que le daba nombre, contó con "},{"type":"artistReference","attrs":{"occurrenceId":"5b543da5-827f-41d5-8793-bec755801d90","artistId":"af726afa-c7a0-47da-99bb-a4c7669a8785","displayText":"Natti Natasha"}},{"type":"text","text":", y trajo «La Vida», hecha con el productor "},{"type":"artistReference","attrs":{"occurrenceId":"968430dc-24d0-4ed5-a3b4-10301c879741","artistId":"4688614f-d936-4fb8-8bf1-04008de4256b","displayText":"Maffio"}},{"type":"text","text":", que también llegó al número uno. Cuando «Siente Music» cerró en 2015 le entregó sus másteres, y desde entonces trabaja por su cuenta con su propio sello, «HustleHard Entertainment»: «Henry The Third» (2016), con "},{"type":"artistReference","attrs":{"occurrenceId":"5e23d21b-e5f4-4227-91e8-aafbdf815547","artistId":"b22dbf04-c87b-4842-baac-0616b7613208","displayText":"Jhoni The Voice"}},{"type":"text","text":" entre los invitados, un recopilatorio en vivo en 2017, «Shut Up & Listen» (2018) y dos discos de karaoke."}]},{"type":"paragraph","content":[{"type":"text","text":"En el otoño de 2012 fue el primer dominicano en competir en «Mira quién baila», la versión de Univision de Dancing with the Stars, y ganó la tercera temporada el 18 de noviembre con el 41 % del voto del público, sin haber sido nominado nunca a eliminación."}]},{"type":"paragraph","content":[{"type":"text","text":"Amigos y leyendas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"«Friends & Legends» (2021) fue un disco de dúos de bachata entre generaciones: "},{"type":"artistReference","attrs":{"occurrenceId":"585fe37b-d101-466d-a961-ac33d95d589e","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":", con quien había sacado «Don Juan & Cupido» en 2019; "},{"type":"artistReference","attrs":{"occurrenceId":"f90068b7-4c16-49ac-ba7e-c4199271c04c","artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas"}},{"type":"text","text":"; "},{"type":"artistReference","attrs":{"occurrenceId":"a66537e3-a48a-4883-9057-7eebbf9ec974","artistId":"aec32df5-cc5a-43c2-ac33-02bc8caa1cf5","displayText":"Joe Veras"}},{"type":"text","text":", en «No me Tocó Morir por Ti»; "},{"type":"artistReference","attrs":{"occurrenceId":"18fb8070-86c6-48b1-b5dd-daac5a446812","artistId":"14a4dba6-84d2-4e50-bfb7-d40e3009b42a","displayText":"Alexandra Queen"}},{"type":"text","text":", en «Como Abeja a la Flor»; "},{"type":"artistReference","attrs":{"occurrenceId":"573c9fb2-bf18-4953-a076-60e35de701df","artistId":"84aba9ce-ba69-4caa-b71b-2bedb2f848fc","displayText":"Daniel Santacruz"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"b00747c8-d448-4520-a5b3-0a577c6e860e","artistId":"5ce0aa05-7d1a-4750-8cd2-dab62b06a244","displayText":"Grupo Extra"}},{"type":"text","text":", el salsero "},{"type":"artistReference","attrs":{"occurrenceId":"fe5ecce0-d399-4c75-bf5b-37a9ca3a417d","artistId":"69ca4e3b-2a3a-4e61-a5bd-2210606c5f13","displayText":"David Kada"}},{"type":"text","text":", y "},{"type":"artistReference","attrs":{"occurrenceId":"ba0c0f81-3c2d-407a-9618-390fa2e8f345","artistId":"f07fcc6b-a888-4e97-ac50-6ce6ea37a714","displayText":"El Prodigio"}},{"type":"text","text":" en el merengue «I’m So In Love». Detrás vino «2.0» en 2024, anticipado por una versión en bachata de «Te Di», de "},{"type":"artistReference","attrs":{"occurrenceId":"c376f57f-7616-45f5-9b26-f59dd090eb18","artistId":"34b63c95-f79a-4f7b-aa1d-426926d12959","displayText":"Pavel Núñez"}},{"type":"text","text":", cantada con el propio Núñez, «La Excepción» con "},{"type":"artistReference","attrs":{"occurrenceId":"377d756e-fce9-4aef-bde9-204cdf499052","artistId":"2a4813af-a826-410e-9475-b2bd1474b234","displayText":"Kiko Rodríguez"}},{"type":"text","text":" y «No Soy Nada Sin Ti» con "},{"type":"artistReference","attrs":{"occurrenceId":"38cfd086-e512-453b-9589-1c6adb26ce40","artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes"}},{"type":"text","text":". En 2023 empezó a publicar boleros con producción urbana bajo el nombre de bolero urbano."}]},{"type":"paragraph","content":[{"type":"text","text":"Los regresos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"artistReference","attrs":{"occurrenceId":"e9600d5a-cb5d-4130-9d09-70fee5fa817c","artistId":"3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3","displayText":"Aventura"}},{"type":"text","text":" volvió varias veces: una aparición sorpresa en el concierto de "},{"type":"artistReference","attrs":{"occurrenceId":"75a7739c-af42-46a6-9d21-aac5cd17866a","artistId":"8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3","displayText":"Romeo Santos"}},{"type":"text","text":" en el Yankee Stadium en 2014, un mes de conciertos en el United Palace en 2016, «Inmortal» en 2019 y la gira de estadios de 2021. Para la gira de despedida, «Cerrando Ciclos», el grupo sacó «Brindo con Agua» el 2 de abril de 2024: el primer sencillo de Aventura con Santos como voz principal, editado por su propio sello. En septiembre de 2026 publicó «After the Noise», cuyo tema «Leyendas» cuenta la historia del grupo desde sus comienzos como «Los Tinellers»; lo coprodujo Lenny Santos y Max Santos tocó el bajo. Santos rechaza la palabra separación y dice que el grupo está en un descanso."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Santos fue el integrante de "},{"type":"artistReference","attrs":{"occurrenceId":"b3835d47-7584-4894-a482-2382c718fd71","artistId":"3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3","displayText":"Aventura"}},{"type":"text","text":" cuya voz más estaba en los discos y menos se acreditaba al frente, y su obra solista ha sido un alegato sobre esa distancia. Ha aparecido además en las películas dominicanas «Sanky Panky» y «La Soga», de la que fue supervisor musical."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'henry-santos'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '167e79a7-5695-44dc-877e-1eda77bc42ec', 'artist', '3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '503f96fa-a936-420a-9100-e49db2416019', 'artist', '8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '082f5919-58bd-4dd7-9cd8-bc1d0420febc', 'artist', '3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '55785292-bba5-40ca-8e3e-94fdd89b6da9', 'artist', '3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5b543da5-827f-41d5-8793-bec755801d90', 'artist', 'af726afa-c7a0-47da-99bb-a4c7669a8785' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '968430dc-24d0-4ed5-a3b4-10301c879741', 'artist', '4688614f-d936-4fb8-8bf1-04008de4256b' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '5e23d21b-e5f4-4227-91e8-aafbdf815547', 'artist', 'b22dbf04-c87b-4842-baac-0616b7613208' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '585fe37b-d101-466d-a961-ac33d95d589e', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f90068b7-4c16-49ac-ba7e-c4199271c04c', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'a66537e3-a48a-4883-9057-7eebbf9ec974', 'artist', 'aec32df5-cc5a-43c2-ac33-02bc8caa1cf5' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '18fb8070-86c6-48b1-b5dd-daac5a446812', 'artist', '14a4dba6-84d2-4e50-bfb7-d40e3009b42a' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '573c9fb2-bf18-4953-a076-60e35de701df', 'artist', '84aba9ce-ba69-4caa-b71b-2bedb2f848fc' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b00747c8-d448-4520-a5b3-0a577c6e860e', 'artist', '5ce0aa05-7d1a-4750-8cd2-dab62b06a244' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'fe5ecce0-d399-4c75-bf5b-37a9ca3a417d', 'artist', '69ca4e3b-2a3a-4e61-a5bd-2210606c5f13' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'ba0c0f81-3c2d-407a-9618-390fa2e8f345', 'artist', 'f07fcc6b-a888-4e97-ac50-6ce6ea37a714' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'c376f57f-7616-45f5-9b26-f59dd090eb18', 'artist', '34b63c95-f79a-4f7b-aa1d-426926d12959' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '377d756e-fce9-4aef-bde9-204cdf499052', 'artist', '2a4813af-a826-410e-9475-b2bd1474b234' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '38cfd086-e512-453b-9589-1c6adb26ce40', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'e9600d5a-cb5d-4130-9d09-70fee5fa817c', 'artist', '3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '75a7739c-af42-46a6-9d21-aac5cd17866a', 'artist', '8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'b3835d47-7584-4894-a482-2382c718fd71', 'artist', '3a7c19e8-5d24-4f06-b8e1-9c4a70f2d5b3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'henry-santos' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Henry Santos es cantante, compositor y productor dominicano, nacido en Moca el 15 de diciembre de 1979. Fue la segunda voz de Aventura, el grupo del Bronx que llevó la bachata a los estadios, y graba con su nombre desde 2011. Es primo de Romeo Santos.

**De Moca al Bronx**

Santos se mudó con su familia de Moca al Bronx a los trece años. En 1993 él y su primo conocieron a los hermanos Lenny y Max Santos —que no son parientes suyos pese al apellido— y los cuatro empezaron a tocar juntos como «Los Tinellers», la palabra inglesa teenagers escrita como se decía en el barrio. Al hacerse ciudadano estadounidense, a los diecisiete, se cambió el apellido a Jeter, por el campocorto de los Yankees que acababa de debutar en las Grandes Ligas, y desde entonces firma Henry Santos Jeter.

**La segunda voz**

«Trampa de Amor», grabado en 1996, casi no vendió. El mánager Julio César García los rebautizó Aventura, en 1998 firmaron con «Premium Latin Music», y en una década habían puesto la bachata en el número uno de Italia y Francia y agotado el Madison Square Garden. Dentro del grupo Santos hacía la armonía y los coros de casi todo el repertorio, bailaba en escena, escribía y producía, y llevó la voz principal en «9:15», «Déjà Vu», «Voy Malacostumbrado» y «Princesita». Cuando Aventura hizo la pausa de 2011, era el integrante menos expuesto como voz líder.

**Por su cuenta**

Firmó con «Siente Music», bajo Venemusic y Universal, y el 2 de mayo de 2011 sacó «Poquito a Poquito»; «Introducing Henry Santos» llegó en octubre y entró en el número dos de Tropical Albums de Billboard. «My Way» (2013) le dio su primer número uno en Tropical Airplay con el tema que le daba nombre, contó con Natti Natasha, y trajo «La Vida», hecha con el productor Maffio, que también llegó al número uno. Cuando «Siente Music» cerró en 2015 le entregó sus másteres, y desde entonces trabaja por su cuenta con su propio sello, «HustleHard Entertainment»: «Henry The Third» (2016), con Jhoni The Voice entre los invitados, un recopilatorio en vivo en 2017, «Shut Up & Listen» (2018) y dos discos de karaoke.

En el otoño de 2012 fue el primer dominicano en competir en «Mira quién baila», la versión de Univision de Dancing with the Stars, y ganó la tercera temporada el 18 de noviembre con el 41 % del voto del público, sin haber sido nominado nunca a eliminación.

**Amigos y leyendas**

«Friends & Legends» (2021) fue un disco de dúos de bachata entre generaciones: Antony Santos, con quien había sacado «Don Juan & Cupido» en 2019; Luis Vargas; Joe Veras, en «No me Tocó Morir por Ti»; Alexandra Queen, en «Como Abeja a la Flor»; Daniel Santacruz y Grupo Extra, el salsero David Kada, y El Prodigio en el merengue «I’m So In Love». Detrás vino «2.0» en 2024, anticipado por una versión en bachata de «Te Di», de Pavel Núñez, cantada con el propio Núñez, «La Excepción» con Kiko Rodríguez y «No Soy Nada Sin Ti» con Frank Reyes. En 2023 empezó a publicar boleros con producción urbana bajo el nombre de bolero urbano.

**Los regresos**

Aventura volvió varias veces: una aparición sorpresa en el concierto de Romeo Santos en el Yankee Stadium en 2014, un mes de conciertos en el United Palace en 2016, «Inmortal» en 2019 y la gira de estadios de 2021. Para la gira de despedida, «Cerrando Ciclos», el grupo sacó «Brindo con Agua» el 2 de abril de 2024: el primer sencillo de Aventura con Santos como voz principal, editado por su propio sello. En septiembre de 2026 publicó «After the Noise», cuyo tema «Leyendas» cuenta la historia del grupo desde sus comienzos como «Los Tinellers»; lo coprodujo Lenny Santos y Max Santos tocó el bajo. Santos rechaza la palabra separación y dice que el grupo está en un descanso.

**Legado**

Santos fue el integrante de Aventura cuya voz más estaba en los discos y menos se acreditaba al frente, y su obra solista ha sido un alegato sobre esa distancia. Ha aparecido además en las películas dominicanas «Sanky Panky» y «La Soga», de la que fue supervisor musical.' WHERE slug = 'henry-santos';

COMMIT;
