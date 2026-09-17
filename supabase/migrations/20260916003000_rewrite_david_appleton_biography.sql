BEGIN;

-- Ficha de David Appleton.
--
-- El relleno inventaba una carrera de compositor CLASICO/cinematografico que ninguna fuente
-- respalda; en realidad es cantautor de R&B/soul y, ademas, ingeniero de ciberseguridad.
-- primary_genre corregido de "instrumental-classical" a "urbano". occupations recortado a
-- "composer" (se quitan producer/arranger, sin respaldo).

UPDATE artists SET primary_genre = 'urbano', occupations = '["composer"]'::jsonb
       WHERE slug = 'david-appleton';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'en', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"David Appleton is a Dominican-Mexican singer-songwriter and composer —born in the Dominican Republic, raised in Mexico, and now based in Madrid— known for R&B- and soul-rooted music that has expanded into drill, afrobeat, reparto cubano and reggaetón."}]},{"type":"paragraph","content":[{"type":"text","text":"From reality television to «El inicio del fin»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Appleton appeared on television talent competitions including «Got Talent España» and «La Voz» before building an independent recording career, releasing singles such as the ballad «No Me Dejes Ir». In January 2026 he released his most ambitious project to date, the concept album «El inicio del fin», presented from Madrid and led by the single «Bajo la Luna»."}]},{"type":"paragraph","content":[{"type":"text","text":"The «hacker-artista»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Appleton has combined his music career with work as a cybersecurity engineer at a major European bank, a duality Dominican press has framed as making him a «hacker-artista» — someone who brings the structure of information security to the creative freedom of the studio. He described the concept behind «El inicio del fin», quoting Machiavelli’s «el fin justifica los medios» (“the end justifies the means”), as being about the need to let go of paths that no longer serve one’s goals in order to grow."}]},{"type":"paragraph","content":[{"type":"text","text":"Legacy","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Splitting his career between a cybersecurity job and an evolving, genre-blending catalog, David Appleton represents an unusual profile among Dominican urban artists — one built as much on a day job in technology as on the recording studio, and one that, with «El inicio del fin», continues to widen rather than settle into a single style."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'david-appleton'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'david-appleton' AND d.locale = 'en' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_en = 'David Appleton is a Dominican-Mexican singer-songwriter and composer —born in the Dominican Republic, raised in Mexico, and now based in Madrid— known for R&B- and soul-rooted music that has expanded into drill, afrobeat, reparto cubano and reggaetón.

**From reality television to «El inicio del fin»**

Appleton appeared on television talent competitions including «Got Talent España» and «La Voz» before building an independent recording career, releasing singles such as the ballad «No Me Dejes Ir». In January 2026 he released his most ambitious project to date, the concept album «El inicio del fin», presented from Madrid and led by the single «Bajo la Luna».

**The «hacker-artista»**

Appleton has combined his music career with work as a cybersecurity engineer at a major European bank, a duality Dominican press has framed as making him a «hacker-artista» — someone who brings the structure of information security to the creative freedom of the studio. He described the concept behind «El inicio del fin», quoting Machiavelli’s «el fin justifica los medios» (“the end justifies the means”), as being about the need to let go of paths that no longer serve one’s goals in order to grow.

**Legacy**

Splitting his career between a cybersecurity job and an evolving, genre-blending catalog, David Appleton represents an unusual profile among Dominican urban artists — one built as much on a day job in technology as on the recording studio, and one that, with «El inicio del fin», continues to widen rather than settle into a single style.' WHERE slug = 'david-appleton';

INSERT INTO editorial_documents (document_type, locale, schema_version, document, status, owner_artist_id, revision)
SELECT 'artist_biography', 'es', 1, '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"David Appleton es cantautor y compositor dominico-mexicano —nacido en República Dominicana, criado en México y radicado actualmente en Madrid—, conocido por una música con raíces en el R&B y el soul que se ha expandido hacia el drill, el afrobeat, el reparto cubano y el reggaetón."}]},{"type":"paragraph","content":[{"type":"text","text":"De la televisión a «El inicio del fin»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Appleton participó en concursos de talento televisivos como «Got Talent España» y «La Voz» antes de construir una carrera discográfica independiente, publicando sencillos como la balada «No Me Dejes Ir». En enero de 2026 publicó su proyecto más ambicioso hasta la fecha, el álbum conceptual «El inicio del fin», presentado desde Madrid y encabezado por el sencillo «Bajo la Luna»."}]},{"type":"paragraph","content":[{"type":"text","text":"El «hacker-artista»","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Appleton ha combinado su carrera musical con su trabajo como ingeniero de ciberseguridad en un banco europeo, una dualidad que la prensa dominicana ha descrito como la de un \"hacker-artista\" —alguien que lleva la estructura de la seguridad informática a la libertad creativa del estudio—. Describió el concepto detrás de «El inicio del fin», citando a Maquiavelo con \"el fin justifica los medios\", como la necesidad de soltar caminos que ya no sirven a las metas propias para poder crecer."}]},{"type":"paragraph","content":[{"type":"text","text":"Legado","marks":[{"type":"bold"}]}]},{"type":"paragraph","content":[{"type":"text","text":"Repartiendo su carrera entre un empleo en ciberseguridad y un catálogo cambiante que mezcla géneros, David Appleton representa un perfil poco común entre los artistas urbanos dominicanos —construido tanto sobre un trabajo diario en tecnología como sobre el estudio de grabación—, y que, con «El inicio del fin», sigue ampliándose en vez de asentarse en un solo estilo."}]}]}'::jsonb, 'published', id, 1 FROM artists WHERE slug = 'david-appleton'
ON CONFLICT (document_type, owner_artist_id, locale) WHERE document_type = 'artist_biography' DO UPDATE
   SET document = excluded.document, status = 'published', revision = editorial_documents.revision + 1, updated_at = now();
DELETE FROM editorial_entity_references WHERE editorial_document_id IN
  (SELECT d.id FROM editorial_documents d JOIN artists a ON a.id = d.owner_artist_id
    WHERE a.slug = 'david-appleton' AND d.locale = 'es' AND d.document_type = 'artist_biography');
UPDATE artists SET bio_es = 'David Appleton es cantautor y compositor dominico-mexicano —nacido en República Dominicana, criado en México y radicado actualmente en Madrid—, conocido por una música con raíces en el R&B y el soul que se ha expandido hacia el drill, el afrobeat, el reparto cubano y el reggaetón.

**De la televisión a «El inicio del fin»**

Appleton participó en concursos de talento televisivos como «Got Talent España» y «La Voz» antes de construir una carrera discográfica independiente, publicando sencillos como la balada «No Me Dejes Ir». En enero de 2026 publicó su proyecto más ambicioso hasta la fecha, el álbum conceptual «El inicio del fin», presentado desde Madrid y encabezado por el sencillo «Bajo la Luna».

**El «hacker-artista»**

Appleton ha combinado su carrera musical con su trabajo como ingeniero de ciberseguridad en un banco europeo, una dualidad que la prensa dominicana ha descrito como la de un "hacker-artista" —alguien que lleva la estructura de la seguridad informática a la libertad creativa del estudio—. Describió el concepto detrás de «El inicio del fin», citando a Maquiavelo con "el fin justifica los medios", como la necesidad de soltar caminos que ya no sirven a las metas propias para poder crecer.

**Legado**

Repartiendo su carrera entre un empleo en ciberseguridad y un catálogo cambiante que mezcla géneros, David Appleton representa un perfil poco común entre los artistas urbanos dominicanos —construido tanto sobre un trabajo diario en tecnología como sobre el estudio de grabación—, y que, con «El inicio del fin», sigue ampliándose en vez de asentarse en un solo estilo.' WHERE slug = 'david-appleton';

COMMIT;
