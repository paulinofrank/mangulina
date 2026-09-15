BEGIN;

-- Ficha de Jacinto Gimbernard.
--
-- La biografía de relleno lo llamaba genéricamente "compositor" de música académica; en
-- realidad fue ante todo violinista y concertino de la OSN, además de diplomático, director
-- del Teatro Nacional y escritor (su libro de texto "Historia de Santo Domingo" se usó en el
-- bachillerato dominicano por más de una década). middle_name añadido (Carlos); instruments
-- añadido (violin); occupations ampliado con "conductor".

UPDATE artists SET middle_name = 'Carlos', instruments = ARRAY['violin']::text[],
       occupations = '["conductor"]'::jsonb WHERE slug = 'jacinto-gimbernard';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jacinto Carlos Gimbernard Pellerano, born in Santo Domingo on 17 September 1931 and died there on 24 May 2017, was a Dominican violinist, conductor, diplomat and writer who became the youngest concertmaster in the history of the National Symphony Orchestra (OSN)."}]},{"type":"paragraph","content":[{"type":"text","text":"A child prodigy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He began violin at seven under Willy Kleinberg, Danilo Belardinelli and Ernesto Leroux, joined the OSN at thirteen as its youngest-ever member, and became its concertmaster at nineteen, a post he held for more than thirty years. As a soloist he performed concertos by Bach, Mozart, Tchaikovsky and others, including Beethoven’s at the 1956 inauguration of the Palacio de Bellas Artes and Chausson’s «Poème» at the Teatro Nacional’s opening concert in 1973."}]},{"type":"paragraph","content":[{"type":"text","text":"Diplomat and institution-builder","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He served as cultural attaché in London and ambassador to France, directed the Teatro Nacional, and later became the OSN’s music director, the first to travel abroad specifically to audition and hire foreign musicians for the orchestra. He taught violin at the Conservatorio Nacional de Música for 24 years, and in 2015 the Teatro Nacional named one of its rehearsal halls after him."}]},{"type":"paragraph","content":[{"type":"text","text":"A parallel career in letters","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A largely self-taught polyglot, Gimbernard was also a prolific writer: his «Historia de Santo Domingo» (1966) served as an official Ministry of Education textbook for more than a decade, and his novel «Medalaganario» (1980) went through four editions. He also produced the television program «Música de los Grandes Maestros» with the pianist Vicente Grisolía before hosting a daily radio program on music education."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Gimbernard died of a heart attack in his sleep in 2017, remembered as much for building the institutions of Dominican classical music — as concertmaster, orchestra director and educator — as for his own violin."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jacinto-gimbernard'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jacinto-gimbernard' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Jacinto Carlos Gimbernard Pellerano, born in Santo Domingo on 17 September 1931 and died there on 24 May 2017, was a Dominican violinist, conductor, diplomat and writer who became the youngest concertmaster in the history of the National Symphony Orchestra (OSN).

**A child prodigy**

He began violin at seven under Willy Kleinberg, Danilo Belardinelli and Ernesto Leroux, joined the OSN at thirteen as its youngest-ever member, and became its concertmaster at nineteen, a post he held for more than thirty years. As a soloist he performed concertos by Bach, Mozart, Tchaikovsky and others, including Beethoven’s at the 1956 inauguration of the Palacio de Bellas Artes and Chausson’s «Poème» at the Teatro Nacional’s opening concert in 1973.

**Diplomat and institution-builder**

He served as cultural attaché in London and ambassador to France, directed the Teatro Nacional, and later became the OSN’s music director, the first to travel abroad specifically to audition and hire foreign musicians for the orchestra. He taught violin at the Conservatorio Nacional de Música for 24 years, and in 2015 the Teatro Nacional named one of its rehearsal halls after him.

**A parallel career in letters**

A largely self-taught polyglot, Gimbernard was also a prolific writer: his «Historia de Santo Domingo» (1966) served as an official Ministry of Education textbook for more than a decade, and his novel «Medalaganario» (1980) went through four editions. He also produced the television program «Música de los Grandes Maestros» with the pianist Vicente Grisolía before hosting a daily radio program on music education.

**Legacy**

Gimbernard died of a heart attack in his sleep in 2017, remembered as much for building the institutions of Dominican classical music — as concertmaster, orchestra director and educator — as for his own violin.' WHERE slug = 'jacinto-gimbernard';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jacinto Carlos Gimbernard Pellerano, nacido en Santo Domingo el 17 de septiembre de 1931 y fallecido en la misma ciudad el 24 de mayo de 2017, fue violinista, director de orquesta, diplomático y escritor dominicano que se convirtió en el concertino más joven en la historia de la Orquesta Sinfónica Nacional (OSN)."}]},{"type":"paragraph","content":[{"type":"text","text":"Un niño prodigio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Empezó violín a los siete años con Willy Kleinberg, Danilo Belardinelli y Ernesto Leroux, ingresó a la OSN a los trece como su miembro más joven, y llegó a concertino a los diecinueve, cargo que mantuvo por más de treinta años. Como solista interpretó conciertos de Bach, Mozart, Chaikovski y otros, entre ellos el de Beethoven en la inauguración del Palacio de Bellas Artes en 1956 y el «Poème» de Chausson en el concierto inaugural del Teatro Nacional en 1973."}]},{"type":"paragraph","content":[{"type":"text","text":"Diplomático y constructor de instituciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Fue agregado cultural en Londres y embajador en Francia, dirigió el Teatro Nacional y más tarde se convirtió en director titular de la OSN, el primero en viajar al exterior específicamente a audicionar y contratar músicos extranjeros para la orquesta. Enseñó violín en el Conservatorio Nacional de Música durante 24 años, y en 2015 el Teatro Nacional bautizó con su nombre una de sus salas de ensayo."}]},{"type":"paragraph","content":[{"type":"text","text":"Una carrera paralela en las letras","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Políglota en gran parte autodidacta, Gimbernard fue también un escritor prolífico: su «Historia de Santo Domingo» (1966) sirvió como libro de texto oficial del Ministerio de Educación durante más de una década, y su novela «Medalaganario» (1980) tuvo cuatro ediciones. También produjo el programa de televisión «Música de los Grandes Maestros» junto al pianista Vicente Grisolía, antes de conducir un programa radial diario de educación musical."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Gimbernard murió de un infarto mientras dormía en 2017, recordado tanto por construir las instituciones de la música clásica dominicana —como concertino, director de orquesta y educador— como por su propio violín."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jacinto-gimbernard'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jacinto-gimbernard' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Jacinto Carlos Gimbernard Pellerano, nacido en Santo Domingo el 17 de septiembre de 1931 y fallecido en la misma ciudad el 24 de mayo de 2017, fue violinista, director de orquesta, diplomático y escritor dominicano que se convirtió en el concertino más joven en la historia de la Orquesta Sinfónica Nacional (OSN).

**Un niño prodigio**

Empezó violín a los siete años con Willy Kleinberg, Danilo Belardinelli y Ernesto Leroux, ingresó a la OSN a los trece como su miembro más joven, y llegó a concertino a los diecinueve, cargo que mantuvo por más de treinta años. Como solista interpretó conciertos de Bach, Mozart, Chaikovski y otros, entre ellos el de Beethoven en la inauguración del Palacio de Bellas Artes en 1956 y el «Poème» de Chausson en el concierto inaugural del Teatro Nacional en 1973.

**Diplomático y constructor de instituciones**

Fue agregado cultural en Londres y embajador en Francia, dirigió el Teatro Nacional y más tarde se convirtió en director titular de la OSN, el primero en viajar al exterior específicamente a audicionar y contratar músicos extranjeros para la orquesta. Enseñó violín en el Conservatorio Nacional de Música durante 24 años, y en 2015 el Teatro Nacional bautizó con su nombre una de sus salas de ensayo.

**Una carrera paralela en las letras**

Políglota en gran parte autodidacta, Gimbernard fue también un escritor prolífico: su «Historia de Santo Domingo» (1966) sirvió como libro de texto oficial del Ministerio de Educación durante más de una década, y su novela «Medalaganario» (1980) tuvo cuatro ediciones. También produjo el programa de televisión «Música de los Grandes Maestros» junto al pianista Vicente Grisolía, antes de conducir un programa radial diario de educación musical.

**Legado**

Gimbernard murió de un infarto mientras dormía en 2017, recordado tanto por construir las instituciones de la música clásica dominicana —como concertino, director de orquesta y educador— como por su propio violín.' WHERE slug = 'jacinto-gimbernard';

COMMIT;
