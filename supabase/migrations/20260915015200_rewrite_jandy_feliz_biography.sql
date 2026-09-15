BEGIN;

-- Ficha de Jandy Feliz.
--
-- La biografía de relleno no nombraba a Son Familia, Chichi Peralta, ni ninguna canción o
-- álbum. birth_place daba Barahona (capital provincial); corregido a Jaquimeyes, el pueblo
-- real de nacimiento. Nombre real separado en first_name/last_name/second_last_name.

UPDATE artists SET first_name = 'José del Carmen', last_name = 'Feliz', second_last_name = 'Matos',
       birth_place = 'Jaquimeyes' WHERE slug = 'jandy-feliz';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jandy Feliz, born José del Carmen Feliz Matos on 11 January 1977 in Jaquimeyes, Barahona province, is a Dominican singer, songwriter and producer who first reached national audiences as the lead voice of a hit-making band before building a long solo and international career of his own."}]},{"type":"paragraph","content":[{"type":"text","text":"«Son Familia»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"He got his start as lead vocalist of «Son Familia», the band led by "},{"type":"artistReference","attrs":{"occurrenceId":"f90feb07-39c5-419d-9540-f33772a0e3b7","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":", singing the group’s biggest hit «Procura» along with «Amor narcótico» and «La ciguapa» before parting ways in 2001 to go solo."}]},{"type":"paragraph","content":[{"type":"text","text":"A solo catalogue","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His solo debut, «Hasta que lo pierde» (2000), yielded «Tócame» and «Cariñosa»; «Amor de locos» (2002) followed with «Los amores», and after a compilation of hits he returned in 2009 with «Con su permiso», whose track «Tu boca» was later recorded by Chayanne. «Jandy» (2010) carried «Besa», «Solo el amor» and «Por si acaso», and «Cada loco con su tema» (2017) closed out the run with «Baila conmigo» and a salsa remake of «Amor narcótico»."}]},{"type":"paragraph","content":[{"type":"text","text":"Beyond the studio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"His songs also traveled through Latin America on other artists’ voices and screens: duets with the Peruvian singer Anna Carina («Amándote») and the Ecuadorian singer Michelle Cordero («Sin tu amor», «Tal vez será»), a stint as a judge and vocal coach on the Peruvian talent show «La banda», and songs placed in the Peruvian series «Al fondo hay sitio» and the Ecuadorian «3 familias». In 2015 he stepped back from music to co-found JDNA, a sports program for disadvantaged youth in Australia, before returning to recording the following year."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"From a hit-making band vocalist to a solo artist with an international following, Jandy Feliz built a catalogue of romantic pop and tropical hits that outlasted the band that launched him."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jandy-feliz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jandy-feliz' AND d.locale = 'en' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'f90feb07-39c5-419d-9540-f33772a0e3b7', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-feliz' AND d.locale = 'en' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_en = 'Jandy Feliz, born José del Carmen Feliz Matos on 11 January 1977 in Jaquimeyes, Barahona province, is a Dominican singer, songwriter and producer who first reached national audiences as the lead voice of a hit-making band before building a long solo and international career of his own.

**«Son Familia»**

He got his start as lead vocalist of «Son Familia», the band led by Chichi Peralta, singing the group’s biggest hit «Procura» along with «Amor narcótico» and «La ciguapa» before parting ways in 2001 to go solo.

**A solo catalogue**

His solo debut, «Hasta que lo pierde» (2000), yielded «Tócame» and «Cariñosa»; «Amor de locos» (2002) followed with «Los amores», and after a compilation of hits he returned in 2009 with «Con su permiso», whose track «Tu boca» was later recorded by Chayanne. «Jandy» (2010) carried «Besa», «Solo el amor» and «Por si acaso», and «Cada loco con su tema» (2017) closed out the run with «Baila conmigo» and a salsa remake of «Amor narcótico».

**Beyond the studio**

His songs also traveled through Latin America on other artists’ voices and screens: duets with the Peruvian singer Anna Carina («Amándote») and the Ecuadorian singer Michelle Cordero («Sin tu amor», «Tal vez será»), a stint as a judge and vocal coach on the Peruvian talent show «La banda», and songs placed in the Peruvian series «Al fondo hay sitio» and the Ecuadorian «3 familias». In 2015 he stepped back from music to co-found JDNA, a sports program for disadvantaged youth in Australia, before returning to recording the following year.

**Legacy**

From a hit-making band vocalist to a solo artist with an international following, Jandy Feliz built a catalogue of romantic pop and tropical hits that outlasted the band that launched him.' WHERE slug = 'jandy-feliz';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Jandy Feliz, nacido José del Carmen Feliz Matos el 11 de enero de 1977 en Jaquimeyes, provincia de Barahona, es cantante, compositor y productor dominicano que llegó primero al público nacional como voz líder de una banda de éxito antes de construir una larga carrera solista e internacional propia."}]},{"type":"paragraph","content":[{"type":"text","text":"«Son Familia»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Comenzó como vocalista principal de «Son Familia», la banda liderada por "},{"type":"artistReference","attrs":{"occurrenceId":"cd213cd8-d63e-4f27-bde0-cd25e020b0c3","artistId":"0337dec9-fe9d-485f-be56-a9120b92fbe8","displayText":"Chichi Peralta"}},{"type":"text","text":", cantando el mayor éxito del grupo, «Procura», además de «Amor narcótico» y «La ciguapa», antes de separarse en 2001 para iniciar su carrera solista."}]},{"type":"paragraph","content":[{"type":"text","text":"Un catálogo propio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Su debut solista, «Hasta que lo pierde» (2000), dio «Tócame» y «Cariñosa»; «Amor de locos» (2002) siguió con «Los amores», y tras un álbum de grandes éxitos volvió en 2009 con «Con su permiso», cuyo tema «Tu boca» fue grabado después por Chayanne. «Jandy» (2010) llevó «Besa», «Solo el amor» y «Por si acaso», y «Cada loco con su tema» (2017) cerró el recorrido con «Baila conmigo» y una versión en salsa de «Amor narcótico»."}]},{"type":"paragraph","content":[{"type":"text","text":"Más allá del estudio","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Sus canciones también viajaron por América Latina en voces y pantallas ajenas: duetos con la cantante peruana Anna Carina («Amándote») y la ecuatoriana Michelle Cordero («Sin tu amor», «Tal vez será»), un paso como jurado y entrenador vocal en el concurso peruano «La banda», y temas incluidos en la serie peruana «Al fondo hay sitio» y la ecuatoriana «3 familias». En 2015 se apartó de la música para cofundar JDNA, un programa deportivo para jóvenes desfavorecidos en Australia, antes de volver a grabar al año siguiente."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"De vocalista de una banda exitosa a artista solista con seguimiento internacional, Jandy Feliz construyó un catálogo de pop romántico y música tropical que sobrevivió a la banda que lo dio a conocer."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'jandy-feliz'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'jandy-feliz' AND d.locale = 'es' AND d.document_type = 'artist_biography');
INSERT INTO editorial_entity_references (editorial_document_id, occurrence_id, entity_type, target_artist_id)
SELECT d.id, 'cd213cd8-d63e-4f27-bde0-cd25e020b0c3', 'artist', '0337dec9-fe9d-485f-be56-a9120b92fbe8' FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
 WHERE a.slug = 'jandy-feliz' AND d.locale = 'es' AND d.document_type = 'artist_biography';
UPDATE artists SET bio_es = 'Jandy Feliz, nacido José del Carmen Feliz Matos el 11 de enero de 1977 en Jaquimeyes, provincia de Barahona, es cantante, compositor y productor dominicano que llegó primero al público nacional como voz líder de una banda de éxito antes de construir una larga carrera solista e internacional propia.

**«Son Familia»**

Comenzó como vocalista principal de «Son Familia», la banda liderada por Chichi Peralta, cantando el mayor éxito del grupo, «Procura», además de «Amor narcótico» y «La ciguapa», antes de separarse en 2001 para iniciar su carrera solista.

**Un catálogo propio**

Su debut solista, «Hasta que lo pierde» (2000), dio «Tócame» y «Cariñosa»; «Amor de locos» (2002) siguió con «Los amores», y tras un álbum de grandes éxitos volvió en 2009 con «Con su permiso», cuyo tema «Tu boca» fue grabado después por Chayanne. «Jandy» (2010) llevó «Besa», «Solo el amor» y «Por si acaso», y «Cada loco con su tema» (2017) cerró el recorrido con «Baila conmigo» y una versión en salsa de «Amor narcótico».

**Más allá del estudio**

Sus canciones también viajaron por América Latina en voces y pantallas ajenas: duetos con la cantante peruana Anna Carina («Amándote») y la ecuatoriana Michelle Cordero («Sin tu amor», «Tal vez será»), un paso como jurado y entrenador vocal en el concurso peruano «La banda», y temas incluidos en la serie peruana «Al fondo hay sitio» y la ecuatoriana «3 familias». En 2015 se apartó de la música para cofundar JDNA, un programa deportivo para jóvenes desfavorecidos en Australia, antes de volver a grabar al año siguiente.

**Legado**

De vocalista de una banda exitosa a artista solista con seguimiento internacional, Jandy Feliz construyó un catálogo de pop romántico y música tropical que sobrevivió a la banda que lo dio a conocer.' WHERE slug = 'jandy-feliz';

COMMIT;
