BEGIN;

-- Ficha de Gabriel del Orbe.
--
-- La biografía de relleno lo describía en términos genéricos y confundía su lugar de
-- nacimiento con el de su muerte: nació en Moca (provincia Espaillat), no en Concepción de
-- la Vega, donde murió. second_last_name: Castellanos. instruments: violin, piano.

UPDATE artists SET second_last_name = 'Castellanos', birth_place = 'Moca',
       province = 'Espaillat', instruments = ARRAY['violin', 'piano']::text[] WHERE slug = 'gabriel-del-orbe';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Gabriel del Orbe — Gabriel del Orbe Castellanos, born 18 March 1888 in Moca, died 5 May 1966 in Concepción de la Vega — was a Dominican violinist, pianist and composer, one of the country’s first musicians to build an international concert career inside the European classical tradition."}]},{"type":"paragraph","content":[{"type":"text","text":"A house of music","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The fifth child of the musician Manuel María del Orbe — who had built himself a piano through sheer force of will and drew fervent praise for it — and Carolina Castellanos Fondeur, he began violin lessons with his father at three. On 9 March 1896, days short of turning eight, he made his debut at the Centro de Recreo in Santiago de los Caballeros playing Paganini’s «Carnaval de Venecia» note for note, to an audience that would not let him leave the stage."}]},{"type":"paragraph","content":[{"type":"text","text":"Brindis de Salas’s violin","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Weeks earlier, on 11 January 1896, the touring Cuban virtuoso Claudio Brindis de Salas — known as the Black Paganini — had given a concert in Moca on a violin belonging to Gabriel’s father; his older sister Dionisia played the piano for him that night, and Brindis left the family some of his own hand-written arrangements. The instrument itself later entered Gabriel’s own collection."}]},{"type":"paragraph","content":[{"type":"text","text":"The prodigious child, then Leipzig and Berlin","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"A year later the boy made his international debut — Caracas, the Teatro Nacional in Havana, the government palace in San Juan, Port-au-Prince — billed as «El Prodigioso Niño» and already collecting his first foreign honors. In 1907 he entered the Leipzig Conservatory in Germany, studying under Arno Hilf, who graduated him with the highest distinctions in 1909; the Royal Academy of Music in Berlin admitted him next, where the French violinist Henri Marteau finished shaping his bow technique."}]},{"type":"paragraph","content":[{"type":"text","text":"A touring virtuoso","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Critics singled out his account of Lalo’s «Symphonie espagnole», his “brilliant spiccato” in the Wieniawski and Paganini concertos, and his playing of Kreisler’s «Tambourin chinois» and Sarasate’s «Fantasía Fausto». Berlin’s 1912–13 concert-season catalogue listed him alongside Leopold Auer, Mischa Elman, Jan Kubelík and Joan Manén; he debuted in Havana in 1913, and went on to play Carnegie Hall in New York and the Blüthner-Saal in Berlin — with the Blüthner Orchestra under Edmund von Strauss — as well as stages in Mexico, Venezuela, Cuba, Haiti, Paris and Hamburg."}]},{"type":"paragraph","content":[{"type":"text","text":"As a composer","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He also wrote steadily: pieces for solo violin, for violin and piano, for solo piano, and a book of songs set to texts by the poets Fabio Fiallo and Ramón Emilio Jiménez. New York’s Musical Courier praised his «Rapsodia»; Mexico’s Excelsior singled out «Tropical» for its tenderness."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He died in Concepción de la Vega on 5 May 1966, at seventy-eight, close to seventy years after the child in Moca first drew an audience to its feet."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'gabriel-del-orbe'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'gabriel-del-orbe' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Gabriel del Orbe — Gabriel del Orbe Castellanos, born 18 March 1888 in Moca, died 5 May 1966 in Concepción de la Vega — was a Dominican violinist, pianist and composer, one of the country’s first musicians to build an international concert career inside the European classical tradition.

**A house of music**

The fifth child of the musician Manuel María del Orbe — who had built himself a piano through sheer force of will and drew fervent praise for it — and Carolina Castellanos Fondeur, he began violin lessons with his father at three. On 9 March 1896, days short of turning eight, he made his debut at the Centro de Recreo in Santiago de los Caballeros playing Paganini’s «Carnaval de Venecia» note for note, to an audience that would not let him leave the stage.

**Brindis de Salas’s violin**

Weeks earlier, on 11 January 1896, the touring Cuban virtuoso Claudio Brindis de Salas — known as the Black Paganini — had given a concert in Moca on a violin belonging to Gabriel’s father; his older sister Dionisia played the piano for him that night, and Brindis left the family some of his own hand-written arrangements. The instrument itself later entered Gabriel’s own collection.

**The prodigious child, then Leipzig and Berlin**

A year later the boy made his international debut — Caracas, the Teatro Nacional in Havana, the government palace in San Juan, Port-au-Prince — billed as «El Prodigioso Niño» and already collecting his first foreign honors. In 1907 he entered the Leipzig Conservatory in Germany, studying under Arno Hilf, who graduated him with the highest distinctions in 1909; the Royal Academy of Music in Berlin admitted him next, where the French violinist Henri Marteau finished shaping his bow technique.

**A touring virtuoso**

Critics singled out his account of Lalo’s «Symphonie espagnole», his “brilliant spiccato” in the Wieniawski and Paganini concertos, and his playing of Kreisler’s «Tambourin chinois» and Sarasate’s «Fantasía Fausto». Berlin’s 1912–13 concert-season catalogue listed him alongside Leopold Auer, Mischa Elman, Jan Kubelík and Joan Manén; he debuted in Havana in 1913, and went on to play Carnegie Hall in New York and the Blüthner-Saal in Berlin — with the Blüthner Orchestra under Edmund von Strauss — as well as stages in Mexico, Venezuela, Cuba, Haiti, Paris and Hamburg.

**As a composer**

He also wrote steadily: pieces for solo violin, for violin and piano, for solo piano, and a book of songs set to texts by the poets Fabio Fiallo and Ramón Emilio Jiménez. New York’s Musical Courier praised his «Rapsodia»; Mexico’s Excelsior singled out «Tropical» for its tenderness.

**Legacy**

He died in Concepción de la Vega on 5 May 1966, at seventy-eight, close to seventy years after the child in Moca first drew an audience to its feet.' WHERE slug = 'gabriel-del-orbe';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Gabriel del Orbe —Gabriel del Orbe Castellanos, nacido el 18 de marzo de 1888 en Moca, fallecido el 5 de mayo de 1966 en Concepción de la Vega— fue un violinista, pianista y compositor dominicano, uno de los primeros músicos del país en construir una carrera de concierto internacional dentro de la tradición clásica europea."}]},{"type":"paragraph","content":[{"type":"text","text":"Una casa de música","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Quinto hijo del músico Manuel María del Orbe —quien se había construido un piano a puro tesón, mereciendo por ello fervientes elogios— y de Carolina Castellanos Fondeur, empezó a estudiar violín con su padre a los tres años. El 9 de marzo de 1896, a pocos días de cumplir ocho, debutó en el Centro de Recreo de Santiago de los Caballeros interpretando «El Carnaval de Venecia», de Paganini, compás por compás, ante un público que no lo dejó bajar del escenario."}]},{"type":"paragraph","content":[{"type":"text","text":"El violín de Brindis de Salas","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Semanas antes, el 11 de enero de 1896, el virtuoso cubano en gira Claudio Brindis de Salas —conocido como el Paganini Negro— había dado un concierto en Moca con un violín propiedad del padre de Gabriel; su hermana mayor, Dionisia, lo acompañó al piano esa noche, y Brindis dejó a la familia algunos arreglos escritos de su puño y letra. El instrumento pasó después a la colección del propio Gabriel."}]},{"type":"paragraph","content":[{"type":"text","text":"El niño prodigioso, después Leipzig y Berlín","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Un año después el niño hizo su debut internacional —Caracas, el Teatro Nacional de La Habana, el Palacio de Gobierno de San Juan, Puerto Príncipe— presentado como «El Prodigioso Niño» y ya cosechando sus primeras condecoraciones ultramarinas. En 1907 ingresó al Conservatorio de Leipzig, en Alemania, donde estudió con Arno Hilf, quien lo graduó con las más altas distinciones en 1909; después lo admitió la Real Academia de Música de Berlín, donde el violinista francés Henri Marteau terminó de pulir su técnica de arco."}]},{"type":"paragraph","content":[{"type":"text","text":"Un virtuoso de gira","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La crítica destacó su interpretación de la Sinfonía Española de Lalo, su «brillante spiccato» en los conciertos de Wieniawski y Paganini, y su manera de tocar el «Tambourin chinois» de Kreisler y la «Fantasía Fausto» de Sarasate. El catálogo de la temporada de conciertos 1912-1913 de Berlín lo listó junto a Leopold Auer, Mischa Elman, Jan Kubelík y Joan Manén; debutó en La Habana en 1913, y llegó a tocar en el Carnegie Hall de Nueva York y en la Blüthner-Saal de Berlín —con la Orquesta Blüthner bajo la batuta de Edmund von Strauss—, además de escenarios de México, Venezuela, Cuba, Haití, París y Hamburgo."}]},{"type":"paragraph","content":[{"type":"text","text":"Como compositor","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Escribió también de forma constante: piezas para violín solo, para violín y piano, para piano solo, y un libro de canciones con textos de los poetas Fabio Fiallo y Ramón Emilio Jiménez. El Musical Courier de Nueva York elogió su «Rapsodia»; el Excelsior de México destacó la ternura de «Tropical»."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Murió en Concepción de la Vega el 5 de mayo de 1966, a los setenta y ocho años, casi setenta después de que aquel niño de Moca pusiera de pie a un público por primera vez."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'gabriel-del-orbe'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'gabriel-del-orbe' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Gabriel del Orbe —Gabriel del Orbe Castellanos, nacido el 18 de marzo de 1888 en Moca, fallecido el 5 de mayo de 1966 en Concepción de la Vega— fue un violinista, pianista y compositor dominicano, uno de los primeros músicos del país en construir una carrera de concierto internacional dentro de la tradición clásica europea.

**Una casa de música**

Quinto hijo del músico Manuel María del Orbe —quien se había construido un piano a puro tesón, mereciendo por ello fervientes elogios— y de Carolina Castellanos Fondeur, empezó a estudiar violín con su padre a los tres años. El 9 de marzo de 1896, a pocos días de cumplir ocho, debutó en el Centro de Recreo de Santiago de los Caballeros interpretando «El Carnaval de Venecia», de Paganini, compás por compás, ante un público que no lo dejó bajar del escenario.

**El violín de Brindis de Salas**

Semanas antes, el 11 de enero de 1896, el virtuoso cubano en gira Claudio Brindis de Salas —conocido como el Paganini Negro— había dado un concierto en Moca con un violín propiedad del padre de Gabriel; su hermana mayor, Dionisia, lo acompañó al piano esa noche, y Brindis dejó a la familia algunos arreglos escritos de su puño y letra. El instrumento pasó después a la colección del propio Gabriel.

**El niño prodigioso, después Leipzig y Berlín**

Un año después el niño hizo su debut internacional —Caracas, el Teatro Nacional de La Habana, el Palacio de Gobierno de San Juan, Puerto Príncipe— presentado como «El Prodigioso Niño» y ya cosechando sus primeras condecoraciones ultramarinas. En 1907 ingresó al Conservatorio de Leipzig, en Alemania, donde estudió con Arno Hilf, quien lo graduó con las más altas distinciones en 1909; después lo admitió la Real Academia de Música de Berlín, donde el violinista francés Henri Marteau terminó de pulir su técnica de arco.

**Un virtuoso de gira**

La crítica destacó su interpretación de la Sinfonía Española de Lalo, su «brillante spiccato» en los conciertos de Wieniawski y Paganini, y su manera de tocar el «Tambourin chinois» de Kreisler y la «Fantasía Fausto» de Sarasate. El catálogo de la temporada de conciertos 1912-1913 de Berlín lo listó junto a Leopold Auer, Mischa Elman, Jan Kubelík y Joan Manén; debutó en La Habana en 1913, y llegó a tocar en el Carnegie Hall de Nueva York y en la Blüthner-Saal de Berlín —con la Orquesta Blüthner bajo la batuta de Edmund von Strauss—, además de escenarios de México, Venezuela, Cuba, Haití, París y Hamburgo.

**Como compositor**

Escribió también de forma constante: piezas para violín solo, para violín y piano, para piano solo, y un libro de canciones con textos de los poetas Fabio Fiallo y Ramón Emilio Jiménez. El Musical Courier de Nueva York elogió su «Rapsodia»; el Excelsior de México destacó la ternura de «Tropical».

**Legado**

Murió en Concepción de la Vega el 5 de mayo de 1966, a los setenta y ocho años, casi setenta después de que aquel niño de Moca pusiera de pie a un público por primera vez.' WHERE slug = 'gabriel-del-orbe';

COMMIT;
