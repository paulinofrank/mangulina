BEGIN;

-- Lapiitoh Dangers (José Aníbal Cuello Dilone): artista urbano de Barahona, nacido el 17 de junio de 2004; el relleno era un párrafo genérico. Fuentes: descripción oficial del canal 'Lapiitoh Dangers - Topic' en YouTube y biografía de Spotify (nombre civil, fecha, Barahona), Apple Music y Amazon Music (sencillos 2023-2026), MusicBrainz (nacimiento 2004-06-17, etiqueta 'los 100 records'). Ficha mínima: solo fuentes del propio artista y su distribuidor, sin prensa. Campos: nombre civil repartido en first/middle/last/second (José Aníbal Cuello Dilone) y alias 'Lapiitoh Dangers' se mantiene como name; lugar de nacimiento Barahona / Barahona. Se descartó una canción 'Dangerous (feat. Lapitoh Danger)' de Neno 357 porque la grafía difiere y no se comprobó que sea el mismo artista.

UPDATE artists SET first_name = 'José', middle_name = 'Aníbal', last_name = 'Cuello', second_last_name = 'Dilone', birth_place = 'Barahona', province = 'Barahona', aliases = ARRAY['Dangers']::text[] WHERE slug = 'lapiitoh-dangers';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Lapiitoh Dangers —José Aníbal Cuello Dilone, born on 17 June 2004 in Barahona— is a Dominican urban artist."}]},{"type":"paragraph","content":[{"type":"text","text":"Beginnings","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"The description on his official artist channel says that he began his musical career in his hometown of Barahona, where he stood out for his lyrical skills, and that he writes lyrics that reflect his personal experiences and the realities of street life in his community."}]},{"type":"paragraph","content":[{"type":"text","text":"Songs","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His singles on streaming platforms include «I Stay in Mine», «Tengo una nota» and «Dios bendiga» (2023), «No voy ah bajarle» (2024) and «Buscando los 100». In August 2026 he released «D.O.A. 100», with Errency 27."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His work is documented through his own channels and the releases on the streaming platforms."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'lapiitoh-dangers'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'lapiitoh-dangers' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'Lapiitoh Dangers —José Aníbal Cuello Dilone, born on 17 June 2004 in Barahona— is a Dominican urban artist.

**Beginnings**

The description on his official artist channel says that he began his musical career in his hometown of Barahona, where he stood out for his lyrical skills, and that he writes lyrics that reflect his personal experiences and the realities of street life in his community.

**Songs**

His singles on streaming platforms include «I Stay in Mine», «Tengo una nota» and «Dios bendiga» (2023), «No voy ah bajarle» (2024) and «Buscando los 100». In August 2026 he released «D.O.A. 100», with Errency 27.

**Legacy**

His work is documented through his own channels and the releases on the streaming platforms.' WHERE slug = 'lapiitoh-dangers';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Lapiitoh Dangers —José Aníbal Cuello Dilone, nacido el 17 de junio de 2004 en Barahona— es un artista urbano dominicano."}]},{"type":"paragraph","content":[{"type":"text","text":"Inicios","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"La descripción de su canal oficial de artista dice que empezó su carrera musical en su ciudad natal, Barahona, donde se destacó por sus habilidades líricas, y que escribe letras que reflejan sus experiencias personales y las realidades de la vida de la calle en su comunidad."}]},{"type":"paragraph","content":[{"type":"text","text":"Canciones","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Sus sencillos en las plataformas de streaming incluyen «I Stay in Mine», «Tengo una nota» y «Dios bendiga» (2023), «No voy ah bajarle» (2024) y «Buscando los 100». En agosto de 2026 publicó «D.O.A. 100», con Errency 27."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su obra está documentada a través de sus propios canales y de los lanzamientos en las plataformas de streaming."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'lapiitoh-dangers'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'lapiitoh-dangers' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'Lapiitoh Dangers —José Aníbal Cuello Dilone, nacido el 17 de junio de 2004 en Barahona— es un artista urbano dominicano.

**Inicios**

La descripción de su canal oficial de artista dice que empezó su carrera musical en su ciudad natal, Barahona, donde se destacó por sus habilidades líricas, y que escribe letras que reflejan sus experiencias personales y las realidades de la vida de la calle en su comunidad.

**Canciones**

Sus sencillos en las plataformas de streaming incluyen «I Stay in Mine», «Tengo una nota» y «Dios bendiga» (2023), «No voy ah bajarle» (2024) y «Buscando los 100». En agosto de 2026 publicó «D.O.A. 100», con Errency 27.

**Legado**

Su obra está documentada a través de sus propios canales y de los lanzamientos en las plataformas de streaming.' WHERE slug = 'lapiitoh-dangers';

COMMIT;
