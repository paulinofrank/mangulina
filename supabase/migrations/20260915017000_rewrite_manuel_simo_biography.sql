BEGIN;

-- Ficha de Manuel Simó.
--
-- La biografía de relleno hablaba en términos genéricos de "energía cibaeña" sin nombrar una
-- sola institución, maestro, obra o año. Se registra su premio de 1944 en el Concurso
-- Centenario. instruments corregido de piano (sin respaldo en ninguna fuente) a percussion
-- (varias fuentes coinciden); occupations ampliado con "music educator".

INSERT INTO artist_awards (artist_id, award_id, category_id, year, work, won, source)
SELECT a.id, aw.id, ac.id, 1944, 'Cantata para cuarteto de solistas, gran coro y orquesta', true,
  'El Caribe (reseña de Antonio Gómez Sotolongo) y la Wikipedia alemana, ambas citando el Gran Concurso Centenario de 1944'
FROM artists a, awards aw, award_categories ac
WHERE a.slug = 'manuel-simo' AND aw.name = 'Premio Nacional de Música' AND ac.award_id = aw.id AND ac.name = 'Composición';
UPDATE artists SET instruments = ARRAY['percussion']::text[], occupations = '["music educator"]'::jsonb WHERE slug = 'manuel-simo';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manuel Simó Rojas, born in San Francisco de Macorís on 30 June 1916 and died in Santo Domingo on 14 September 1988, was a Dominican composer, conductor and music educator remembered as the first Dominican-born director of the Orquesta Sinfónica Nacional (OSN) and one of the country’s most persistent advocates for twentieth-century music."}]},{"type":"paragraph","content":[{"type":"text","text":"From a town band to the podium","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His mother steered him toward the local Academia de Música in San Francisco de Macorís, where he studied under Rafael Pimentel and Oguis Negrette and played in the town’s Banda Municipal. In Santo Domingo he joined the army band under José Dolores Cerón, who first spotted his talent and introduced him to conducting; by the OSN’s founding in 1941 he was already a conducting student of its first director, Enrique Casal Chapí, while playing percussion and English horn in its ranks. A late-1940s government scholarship sent him to the Conservatorio Kolisher in Montevideo, where he continued studying under Casal Chapí, who had relocated there himself."}]},{"type":"paragraph","content":[{"type":"text","text":"Director of the OSN","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Back home, he succeeded "},{"type":"artistReference","attrs":{"occurrenceId":"de1b2f93-849e-441a-8484-8792d6b623a5","artistId":"a4f98603-5d27-4971-bea9-d8c1c9e996da","displayText":"Juan Francisco García"}},{"type":"text","text":" as director of the Conservatorio Nacional de Música, where he also taught composition for years. He took over the OSN on an interim basis in 1952 after an accident sidelined its director, became sub-director shortly after, and was named titular director in 1959, a post he held until 1981, when he was made the orchestra’s Compositor Emérito."}]},{"type":"paragraph","content":[{"type":"text","text":"An advocate for the new","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"As director he gave Dominican audiences their first hearings of Prokofiev, Stravinsky, Shostakovich, Britten and Satie, while championing fellow Dominican composers on the same programs. In 1969 he organized «Fluxus Música de Vanguardia», two concerts of Cage, Varèse, Berio and Schoenberg at the Palacio de Bellas Artes — an unusually bold gesture for the time, and one the historian Arístides Incháustegui later noted found little lasting traction with a public and press not yet ready for it."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His own catalogue — symphonies, string quartets, violin sonatas, and a cantata for soloists, chorus and orchestra that won the Premio Nacional de Música at the 1944 centennial composition competition — remains, by most accounts, less known than the institution he spent three decades shaping."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manuel-simo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manuel-simo' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'de1b2f93-849e-441a-8484-8792d6b623a5', 'artist', 'a4f98603-5d27-4971-bea9-d8c1c9e996da' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manuel-simo' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Manuel Simó Rojas, born in San Francisco de Macorís on 30 June 1916 and died in Santo Domingo on 14 September 1988, was a Dominican composer, conductor and music educator remembered as the first Dominican-born director of the Orquesta Sinfónica Nacional (OSN) and one of the country’s most persistent advocates for twentieth-century music.

**From a town band to the podium**

His mother steered him toward the local Academia de Música in San Francisco de Macorís, where he studied under Rafael Pimentel and Oguis Negrette and played in the town’s Banda Municipal. In Santo Domingo he joined the army band under José Dolores Cerón, who first spotted his talent and introduced him to conducting; by the OSN’s founding in 1941 he was already a conducting student of its first director, Enrique Casal Chapí, while playing percussion and English horn in its ranks. A late-1940s government scholarship sent him to the Conservatorio Kolisher in Montevideo, where he continued studying under Casal Chapí, who had relocated there himself.

**Director of the OSN**

Back home, he succeeded Juan Francisco García as director of the Conservatorio Nacional de Música, where he also taught composition for years. He took over the OSN on an interim basis in 1952 after an accident sidelined its director, became sub-director shortly after, and was named titular director in 1959, a post he held until 1981, when he was made the orchestra’s Compositor Emérito.

**An advocate for the new**

As director he gave Dominican audiences their first hearings of Prokofiev, Stravinsky, Shostakovich, Britten and Satie, while championing fellow Dominican composers on the same programs. In 1969 he organized «Fluxus Música de Vanguardia», two concerts of Cage, Varèse, Berio and Schoenberg at the Palacio de Bellas Artes — an unusually bold gesture for the time, and one the historian Arístides Incháustegui later noted found little lasting traction with a public and press not yet ready for it.

**Legacy**

His own catalogue — symphonies, string quartets, violin sonatas, and a cantata for soloists, chorus and orchestra that won the Premio Nacional de Música at the 1944 centennial composition competition — remains, by most accounts, less known than the institution he spent three decades shaping.' WHERE slug = 'manuel-simo';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Manuel Simó Rojas, nacido en San Francisco de Macorís el 30 de junio de 1916 y fallecido en Santo Domingo el 14 de septiembre de 1988, fue compositor, director de orquesta y educador musical dominicano, recordado como el primer director dominicano de la Orquesta Sinfónica Nacional (OSN) y uno de los defensores más constantes de la música del siglo XX en el país."}]},{"type":"paragraph","content":[{"type":"text","text":"De una banda de pueblo al podio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su madre lo encaminó hacia la Academia de Música de San Francisco de Macorís, donde estudió con Rafael Pimentel y Oguis Negrette e integró la Banda Municipal del pueblo. En Santo Domingo se unió a la banda del ejército bajo José Dolores Cerón, quien descubrió su talento y lo inició en la dirección orquestal; para la fundación de la OSN en 1941 ya era alumno de dirección de su primer director titular, Enrique Casal Chapí, mientras tocaba percusión y corno inglés en sus filas. Una beca del gobierno de finales de los años cuarenta lo llevó al Conservatorio Kolisher de Montevideo, donde continuó sus estudios con Casal Chapí, radicado él mismo en esa ciudad."}]},{"type":"paragraph","content":[{"type":"text","text":"Director de la OSN","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De vuelta en el país, sucedió a "},{"type":"artistReference","attrs":{"occurrenceId":"663bfb8d-cd21-40e5-8a47-43a618ad0dec","artistId":"a4f98603-5d27-4971-bea9-d8c1c9e996da","displayText":"Juan Francisco García"}},{"type":"text","text":" como director del Conservatorio Nacional de Música, donde también fue profesor de composición durante años. Asumió la OSN de forma interina en 1952 tras un accidente que apartó a su director, pasó poco después a la subdirección, y fue nombrado director titular en 1959, cargo que ocupó hasta 1981, cuando fue designado Compositor Emérito de la orquesta."}]},{"type":"paragraph","content":[{"type":"text","text":"Un defensor de lo nuevo","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Como director le dio al público dominicano sus primeras audiciones de Prokófiev, Stravinski, Shostakóvich, Britten y Satie, a la vez que promovía a compositores dominicanos en los mismos programas. En 1969 organizó «Fluxus Música de Vanguardia», dos conciertos de Cage, Varèse, Berio y Schönberg en el Palacio de Bellas Artes —un gesto inusualmente audaz para la época, que el historiador Arístides Incháustegui señaló después que encontró poco eco duradero en un público y una prensa que aún no estaban listos para él."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su propio catálogo —sinfonías, cuartetos de cuerda, sonatas para violín y una cantata para solistas, coro y orquesta que ganó el Premio Nacional de Música en el concurso de composición del centenario de 1944— sigue siendo, según casi todos los relatos, menos conocido que la institución que él mismo formó durante tres décadas."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'manuel-simo'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'manuel-simo' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, '663bfb8d-cd21-40e5-8a47-43a618ad0dec', 'artist', 'a4f98603-5d27-4971-bea9-d8c1c9e996da' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'manuel-simo' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Manuel Simó Rojas, nacido en San Francisco de Macorís el 30 de junio de 1916 y fallecido en Santo Domingo el 14 de septiembre de 1988, fue compositor, director de orquesta y educador musical dominicano, recordado como el primer director dominicano de la Orquesta Sinfónica Nacional (OSN) y uno de los defensores más constantes de la música del siglo XX en el país.

**De una banda de pueblo al podio**

Su madre lo encaminó hacia la Academia de Música de San Francisco de Macorís, donde estudió con Rafael Pimentel y Oguis Negrette e integró la Banda Municipal del pueblo. En Santo Domingo se unió a la banda del ejército bajo José Dolores Cerón, quien descubrió su talento y lo inició en la dirección orquestal; para la fundación de la OSN en 1941 ya era alumno de dirección de su primer director titular, Enrique Casal Chapí, mientras tocaba percusión y corno inglés en sus filas. Una beca del gobierno de finales de los años cuarenta lo llevó al Conservatorio Kolisher de Montevideo, donde continuó sus estudios con Casal Chapí, radicado él mismo en esa ciudad.

**Director de la OSN**

De vuelta en el país, sucedió a Juan Francisco García como director del Conservatorio Nacional de Música, donde también fue profesor de composición durante años. Asumió la OSN de forma interina en 1952 tras un accidente que apartó a su director, pasó poco después a la subdirección, y fue nombrado director titular en 1959, cargo que ocupó hasta 1981, cuando fue designado Compositor Emérito de la orquesta.

**Un defensor de lo nuevo**

Como director le dio al público dominicano sus primeras audiciones de Prokófiev, Stravinski, Shostakóvich, Britten y Satie, a la vez que promovía a compositores dominicanos en los mismos programas. En 1969 organizó «Fluxus Música de Vanguardia», dos conciertos de Cage, Varèse, Berio y Schönberg en el Palacio de Bellas Artes —un gesto inusualmente audaz para la época, que el historiador Arístides Incháustegui señaló después que encontró poco eco duradero en un público y una prensa que aún no estaban listos para él.

**Legado**

Su propio catálogo —sinfonías, cuartetos de cuerda, sonatas para violín y una cantata para solistas, coro y orquesta que ganó el Premio Nacional de Música en el concurso de composición del centenario de 1944— sigue siendo, según casi todos los relatos, menos conocido que la institución que él mismo formó durante tres décadas.' WHERE slug = 'manuel-simo';

COMMIT;
