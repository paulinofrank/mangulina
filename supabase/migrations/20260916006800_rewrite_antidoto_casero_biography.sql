BEGIN;

-- Antídoto Casero (Alexander Duarte Durán): rapero y compositor dominicano, no un grupo de fusión como decía el relleno. Fuentes: su canal de YouTube @AntidotoCasero (títulos de sus videos), la fila (Alucinando, 22 mar. 2021), una nota promocional de 2021 sobre 'NaviRap' (Vibras Entertainment; sus afirmaciones sobre un tercero NO se incluyen). Campos: primary_role rapper, primary_genre urban-rap-hip-hop, genres vacío (reggae y fusion sin respaldo). Fecha de nacimiento: la fila dice 8 mar. 1992 y MusicBrainz 3 ago. 1992 (probable inversión día/mes); el texto no la da.

UPDATE artists SET primary_role = 'rapper', primary_genre = 'urban-rap-hip-hop', genres = ARRAY[]::text[] WHERE slug = 'antidoto-casero';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Antídoto Casero —Alexander Duarte Durán— is a Dominican rapper and songwriter whose catalogue on YouTube runs from 2018 to the early 2020s."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His channel carries the songs «Anestesia» (2018), «Agua» (2019), «Alucinando», «Ayúdame», «Noche Fría», «Los Nike», «A La Clara», «Resimiente», «Feliz Vanidad» and «Formato 42», and later «Redes Fecales», «Por Mi», «Cárcel Pa’ La Policía», «Por la Cultura» and «Gracias Rap». «Una Noche Real» was made with the rappers Centinela Rap, Mafuul Flay and Sinceroh, and «La Vida Es Magia» (2022) was produced by Emy Cambiando La Nota."}]},{"type":"paragraph","content":[{"type":"text","text":"«NaviRap»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 2021 he released the video «NaviRap», a response track aimed at the rapper Lírico en la Casa, which his distributor Vibras Entertainment announced together with the reissue of his catalogue on a new YouTube channel and digital stores. The single «Alucinando» was released on 22 March 2021."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His work is documented mainly on his own channel and on the platforms where his songs are distributed."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'antidoto-casero'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'antidoto-casero' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Antídoto Casero —Alexander Duarte Durán— is a Dominican rapper and songwriter whose catalogue on YouTube runs from 2018 to the early 2020s.

**Songs**

His channel carries the songs «Anestesia» (2018), «Agua» (2019), «Alucinando», «Ayúdame», «Noche Fría», «Los Nike», «A La Clara», «Resimiente», «Feliz Vanidad» and «Formato 42», and later «Redes Fecales», «Por Mi», «Cárcel Pa’ La Policía», «Por la Cultura» and «Gracias Rap». «Una Noche Real» was made with the rappers Centinela Rap, Mafuul Flay and Sinceroh, and «La Vida Es Magia» (2022) was produced by Emy Cambiando La Nota.

**«NaviRap»**

In 2021 he released the video «NaviRap», a response track aimed at the rapper Lírico en la Casa, which his distributor Vibras Entertainment announced together with the reissue of his catalogue on a new YouTube channel and digital stores. The single «Alucinando» was released on 22 March 2021.

**Legacy**

His work is documented mainly on his own channel and on the platforms where his songs are distributed.' WHERE slug = 'antidoto-casero';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Antídoto Casero —Alexander Duarte Durán— es un rapero y compositor dominicano cuyo catálogo en YouTube va de 2018 a los primeros años de la década de 2020."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su canal reúne las canciones «Anestesia» (2018), «Agua» (2019), «Alucinando», «Ayúdame», «Noche Fría», «Los Nike», «A La Clara», «Resimiente», «Feliz Vanidad» y «Formato 42», y más tarde «Redes Fecales», «Por Mi», «Cárcel Pa’ La Policía», «Por la Cultura» y «Gracias Rap». «Una Noche Real» la hizo con los raperos Centinela Rap, Mafuul Flay y Sinceroh, y «La Vida Es Magia» (2022) fue producida por Emy Cambiando La Nota."}]},{"type":"paragraph","content":[{"type":"text","text":"«NaviRap»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 2021 publicó el video «NaviRap», una canción de respuesta dirigida al rapero Lírico en la Casa, que su distribuidora Vibras Entertainment anunció junto con la reedición de su catálogo en un nuevo canal de YouTube y en tiendas digitales. El sencillo «Alucinando» salió el 22 de marzo de 2021."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su obra está documentada sobre todo en su propio canal y en las plataformas donde se distribuyen sus canciones."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'antidoto-casero'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'antidoto-casero' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Antídoto Casero —Alexander Duarte Durán— es un rapero y compositor dominicano cuyo catálogo en YouTube va de 2018 a los primeros años de la década de 2020.

**Canciones**

Su canal reúne las canciones «Anestesia» (2018), «Agua» (2019), «Alucinando», «Ayúdame», «Noche Fría», «Los Nike», «A La Clara», «Resimiente», «Feliz Vanidad» y «Formato 42», y más tarde «Redes Fecales», «Por Mi», «Cárcel Pa’ La Policía», «Por la Cultura» y «Gracias Rap». «Una Noche Real» la hizo con los raperos Centinela Rap, Mafuul Flay y Sinceroh, y «La Vida Es Magia» (2022) fue producida por Emy Cambiando La Nota.

**«NaviRap»**

En 2021 publicó el video «NaviRap», una canción de respuesta dirigida al rapero Lírico en la Casa, que su distribuidora Vibras Entertainment anunció junto con la reedición de su catálogo en un nuevo canal de YouTube y en tiendas digitales. El sencillo «Alucinando» salió el 22 de marzo de 2021.

**Legado**

Su obra está documentada sobre todo en su propio canal y en las plataformas donde se distribuyen sus canciones.' WHERE slug = 'antidoto-casero';

COMMIT;
