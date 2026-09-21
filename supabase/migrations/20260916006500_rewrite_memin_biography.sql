BEGIN;

-- Memín (Giovanny Belliard, 1969-2022): bajista, guitarrista, arreglista y cantante de bachata nacido en Santiago. Fuentes: Diario Libre (José Zapata, 19 jun. 2022), La Información Digital (20 jun. 2022). Campos: primary_role musician, occupations guitarist/bassist/composer/arranger/producer, nacido en Santiago de los Caballeros.

UPDATE artists SET primary_role = 'musician', occupations = '["guitarist","bassist","composer","arranger","producer"]'::jsonb, birth_place = 'Santiago de los Caballeros', province = 'Santiago' WHERE slug = 'memin';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Memín —Giovanny Belliard, born on 5 February 1969 in Santiago de los Caballeros and died on 19 June 2022— was a Dominican bassist, guitarist, arranger, composer and bachata bandleader, known as “El Sucesor”."}]},{"type":"paragraph","content":[{"type":"text","text":"A family of musicians","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He was the youngest of a family of musicians, the «Hermanos Belliard», in which he played second guitar and later requinto at parties. In the 1990s he also worked as a bassist for típico groups, among them those of «Gerardo Rosario», "},{"type":"artistReference","attrs":{"occurrenceId":"f8588ec5-6cee-4e9f-883f-800716afdd64","artistId":"9127e809-a19c-44b8-a6e6-cee9335941bb","displayText":"Agapito Pascual"}},{"type":"text","text":", «David David» and "},{"type":"artistReference","attrs":{"occurrenceId":"5daa4ca5-b171-4f65-a467-74fa35219fe2","artistId":"c462498c-0f4d-464f-b624-a576f8080e9d","displayText":"La India Canela"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"With Luis Vargas and Anthony Santos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"In 1992 he joined the band of "},{"type":"artistReference","attrs":{"occurrenceId":"6cfdd96c-b938-4d1e-b2fd-2b6b06b4c46f","artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas"}},{"type":"text","text":" as second guitarist, at a moment when the group had lost many of its musicians on a tour of New York, and after leaving he kept arranging requinto parts and recording guitar and bass for Vargas. In 1995 he became the bassist of "},{"type":"artistReference","attrs":{"occurrenceId":"4b380865-2852-4da9-a666-8ce2989ba0d6","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":" for almost two years, and afterwards he went on recording vocals, second guitar and bass on close to ten of Santos’s productions."}]},{"type":"paragraph","content":[{"type":"text","text":"Solo work","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His first group, «Línea de Fuego», was short-lived. In 1997 he formed «El Dúo de Moda» with Sussy, and their first hit was «Con un nudo en la garganta»; when the duo split he continued as a soloist under the name El Sucesor and led his own bachata orchestra. Among the songs he wrote are «Que se alocó», «Pa’ to perdío algo cogío», «Bartolina» and «La Garganta»."}]},{"type":"paragraph","content":[{"type":"text","text":"In the studio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Besides his own records he played guitar and bass on recordings for many bachata and merengue groups, including productions by "},{"type":"artistReference","attrs":{"occurrenceId":"dca75cc1-4543-4c19-9f0c-4513017ef961","artistId":"8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3","displayText":"Romeo Santos"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"afaa8d08-44b0-46ec-a282-5bdedf2b36f8","artistId":"a77079ce-351a-4eb5-baef-de02dc1b62ce","displayText":"Zacarías Ferreira"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"37b3778b-d3cf-4afc-b79d-16c00f31ab00","artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes"}},{"type":"text","text":" and "},{"type":"artistReference","attrs":{"occurrenceId":"02615318-f87d-4fba-9c29-aa81680f133b","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":". He lived in the Bronx and in Santiago."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He died in Santiago on 19 June 2022, aged 53. One profile called him probably the best guitarist of modern string merengue after "},{"type":"artistReference","attrs":{"occurrenceId":"74f22558-c0ca-4c5d-a99e-2ca90de09953","artistId":"634a12eb-24c4-4053-835b-806986a8a735","displayText":"Eladio Romero Santos"}},{"type":"text","text":"."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'memin'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'memin' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'f8588ec5-6cee-4e9f-883f-800716afdd64', 'artist', '9127e809-a19c-44b8-a6e6-cee9335941bb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '5daa4ca5-b171-4f65-a467-74fa35219fe2', 'artist', 'c462498c-0f4d-464f-b624-a576f8080e9d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '6cfdd96c-b938-4d1e-b2fd-2b6b06b4c46f', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '4b380865-2852-4da9-a666-8ce2989ba0d6', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'dca75cc1-4543-4c19-9f0c-4513017ef961', 'artist', '8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'afaa8d08-44b0-46ec-a282-5bdedf2b36f8', 'artist', 'a77079ce-351a-4eb5-baef-de02dc1b62ce' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '37b3778b-d3cf-4afc-b79d-16c00f31ab00', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '02615318-f87d-4fba-9c29-aa81680f133b', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'en' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '74f22558-c0ca-4c5d-a99e-2ca90de09953', 'artist', '634a12eb-24c4-4053-835b-806986a8a735' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Memín —Giovanny Belliard, born on 5 February 1969 in Santiago de los Caballeros and died on 19 June 2022— was a Dominican bassist, guitarist, arranger, composer and bachata bandleader, known as “El Sucesor”.

**A family of musicians**

He was the youngest of a family of musicians, the «Hermanos Belliard», in which he played second guitar and later requinto at parties. In the 1990s he also worked as a bassist for típico groups, among them those of «Gerardo Rosario», Agapito Pascual, «David David» and La India Canela.

**With Luis Vargas and Anthony Santos**

In 1992 he joined the band of Luis Vargas as second guitarist, at a moment when the group had lost many of its musicians on a tour of New York, and after leaving he kept arranging requinto parts and recording guitar and bass for Vargas. In 1995 he became the bassist of Antony Santos for almost two years, and afterwards he went on recording vocals, second guitar and bass on close to ten of Santos’s productions.

**Solo work**

His first group, «Línea de Fuego», was short-lived. In 1997 he formed «El Dúo de Moda» with Sussy, and their first hit was «Con un nudo en la garganta»; when the duo split he continued as a soloist under the name El Sucesor and led his own bachata orchestra. Among the songs he wrote are «Que se alocó», «Pa’ to perdío algo cogío», «Bartolina» and «La Garganta».

**In the studio**

Besides his own records he played guitar and bass on recordings for many bachata and merengue groups, including productions by Romeo Santos, Zacarías Ferreira, Frank Reyes and Prince Royce. He lived in the Bronx and in Santiago.

**Legacy**

He died in Santiago on 19 June 2022, aged 53. One profile called him probably the best guitarist of modern string merengue after Eladio Romero Santos.' WHERE slug = 'memin';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Memín —Giovanny Belliard, nacido el 5 de febrero de 1969 en Santiago de los Caballeros y fallecido el 19 de junio de 2022— fue un bajista, guitarrista, arreglista, compositor y director de orquesta de bachata dominicano, conocido como “El Sucesor”."}]},{"type":"paragraph","content":[{"type":"text","text":"Una familia de músicos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Era el menor de una familia de músicos, los «Hermanos Belliard», donde tocaba la segunda guitarra y luego el requinto en fiestas. En los años noventa trabajó también como bajista de grupos típicos, entre ellos los de «Gerardo Rosario», "},{"type":"artistReference","attrs":{"occurrenceId":"42d54e9f-a479-43f4-922b-365204a85583","artistId":"9127e809-a19c-44b8-a6e6-cee9335941bb","displayText":"Agapito Pascual"}},{"type":"text","text":", «David David» y "},{"type":"artistReference","attrs":{"occurrenceId":"39873ad5-1042-4e20-877c-a62587bd29e7","artistId":"c462498c-0f4d-464f-b624-a576f8080e9d","displayText":"La India Canela"}},{"type":"text","text":"."}]},{"type":"paragraph","content":[{"type":"text","text":"Con Luis Vargas y Anthony Santos","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"En 1992 entró como segunda guitarra a la agrupación de "},{"type":"artistReference","attrs":{"occurrenceId":"aa2ac23e-8a79-42c6-8654-be3911b244c9","artistId":"0760875d-6b6f-4a48-8aed-6e57934d1baa","displayText":"Luis Vargas"}},{"type":"text","text":", en un momento en que el grupo había perdido a muchos de sus músicos en una gira por Nueva York, y tras irse siguió haciéndole arreglos de requinto y grabándole guitarra y bajo. En 1995 pasó a ser bajista de "},{"type":"artistReference","attrs":{"occurrenceId":"da7d0d95-07c3-4104-ac99-055ad025959b","artistId":"28a3745e-90d6-45cd-b8bd-798028f8deb8","displayText":"Antony Santos"}},{"type":"text","text":" durante casi dos años, y después continuó grabando coros, segunda guitarra y bajo en cerca de diez producciones de Santos."}]},{"type":"paragraph","content":[{"type":"text","text":"Obra propia","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su primer grupo, «Línea de Fuego», duró poco. En 1997 formó con Sussy «El Dúo de Moda», y su primer éxito fue «Con un nudo en la garganta»; al separarse el dúo siguió en solitario con el nombre de El Sucesor y dirigió su propia orquesta de bachata. Entre las canciones que escribió están «Que se alocó», «Pa’ to perdío algo cogío», «Bartolina» y «La Garganta»."}]},{"type":"paragraph","content":[{"type":"text","text":"En el estudio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Además de sus discos tocó guitarra y bajo en grabaciones de muchas agrupaciones de bachata y merengue, incluidas producciones de "},{"type":"artistReference","attrs":{"occurrenceId":"7afa5f0e-b7aa-45be-b5b3-fca5eab9710e","artistId":"8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3","displayText":"Romeo Santos"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"3709657f-703d-4669-b208-e3f21a2d85cb","artistId":"a77079ce-351a-4eb5-baef-de02dc1b62ce","displayText":"Zacarías Ferreira"}},{"type":"text","text":", "},{"type":"artistReference","attrs":{"occurrenceId":"ecf2633c-c2cb-4028-9d60-97a9c067c2e7","artistId":"3dd83e6b-2058-4d04-ac68-38e11d9348a9","displayText":"Frank Reyes"}},{"type":"text","text":" y "},{"type":"artistReference","attrs":{"occurrenceId":"6bb63550-129e-4061-b7ce-9dada066676a","artistId":"9c02d1a1-952e-4855-9b60-c0266236378d","displayText":"Prince Royce"}},{"type":"text","text":". Vivía en el Bronx y en Santiago."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Murió en Santiago el 19 de junio de 2022, a los 53 años. Un perfil lo describió como probablemente el mejor guitarrista del merengue de cuerda moderno después de "},{"type":"artistReference","attrs":{"occurrenceId":"031eb018-e12e-4192-bdc5-623f65311e2f","artistId":"634a12eb-24c4-4053-835b-806986a8a735","displayText":"Eladio Romero Santos"}},{"type":"text","text":"."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'memin'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'memin' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '42d54e9f-a479-43f4-922b-365204a85583', 'artist', '9127e809-a19c-44b8-a6e6-cee9335941bb' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '39873ad5-1042-4e20-877c-a62587bd29e7', 'artist', 'c462498c-0f4d-464f-b624-a576f8080e9d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'aa2ac23e-8a79-42c6-8654-be3911b244c9', 'artist', '0760875d-6b6f-4a48-8aed-6e57934d1baa' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'da7d0d95-07c3-4104-ac99-055ad025959b', 'artist', '28a3745e-90d6-45cd-b8bd-798028f8deb8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '7afa5f0e-b7aa-45be-b5b3-fca5eab9710e', 'artist', '8f1d2a44-3c6e-4b17-9a58-7d0e5c9b21f3' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '3709657f-703d-4669-b208-e3f21a2d85cb', 'artist', 'a77079ce-351a-4eb5-baef-de02dc1b62ce' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, 'ecf2633c-c2cb-4028-9d60-97a9c067c2e7', 'artist', '3dd83e6b-2058-4d04-ac68-38e11d9348a9' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '6bb63550-129e-4061-b7ce-9dada066676a', 'artist', '9c02d1a1-952e-4855-9b60-c0266236378d' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'es' AND d.document_type = 'artist_biography';
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
  SELECT d.id, '031eb018-e12e-4192-bdc5-623f65311e2f', 'artist', '634a12eb-24c4-4053-835b-806986a8a735' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
   WHERE a.slug = 'memin' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Memín —Giovanny Belliard, nacido el 5 de febrero de 1969 en Santiago de los Caballeros y fallecido el 19 de junio de 2022— fue un bajista, guitarrista, arreglista, compositor y director de orquesta de bachata dominicano, conocido como “El Sucesor”.

**Una familia de músicos**

Era el menor de una familia de músicos, los «Hermanos Belliard», donde tocaba la segunda guitarra y luego el requinto en fiestas. En los años noventa trabajó también como bajista de grupos típicos, entre ellos los de «Gerardo Rosario», Agapito Pascual, «David David» y La India Canela.

**Con Luis Vargas y Anthony Santos**

En 1992 entró como segunda guitarra a la agrupación de Luis Vargas, en un momento en que el grupo había perdido a muchos de sus músicos en una gira por Nueva York, y tras irse siguió haciéndole arreglos de requinto y grabándole guitarra y bajo. En 1995 pasó a ser bajista de Antony Santos durante casi dos años, y después continuó grabando coros, segunda guitarra y bajo en cerca de diez producciones de Santos.

**Obra propia**

Su primer grupo, «Línea de Fuego», duró poco. En 1997 formó con Sussy «El Dúo de Moda», y su primer éxito fue «Con un nudo en la garganta»; al separarse el dúo siguió en solitario con el nombre de El Sucesor y dirigió su propia orquesta de bachata. Entre las canciones que escribió están «Que se alocó», «Pa’ to perdío algo cogío», «Bartolina» y «La Garganta».

**En el estudio**

Además de sus discos tocó guitarra y bajo en grabaciones de muchas agrupaciones de bachata y merengue, incluidas producciones de Romeo Santos, Zacarías Ferreira, Frank Reyes y Prince Royce. Vivía en el Bronx y en Santiago.

**Legado**

Murió en Santiago el 19 de junio de 2022, a los 53 años. Un perfil lo describió como probablemente el mejor guitarrista del merengue de cuerda moderno después de Eladio Romero Santos.' WHERE slug = 'memin';

COMMIT;
