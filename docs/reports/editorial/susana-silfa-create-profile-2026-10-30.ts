import { validateEditorialDocument } from "../../../src/lib/editorial/validate";
import { buildEditorialIntegrityReport } from "../../../src/lib/editorial/integrity";
import type { EditorialDocumentV1, EditorialInlineNode } from "../../../src/types/editorialDocument";

// Scoped, reproducible creation of one draft artist and her two published bios.
// Run without arguments to validate; --sql emits a single guarded transaction.
const ids = {
  artist: "e21a6907-9899-4a83-8dfa-a74cfca6d329",
  es: "5c90cb6e-80d0-40ee-a41d-e5152fc2ae0b",
  en: "bf3a62e4-f3a6-49b1-be0d-346dc8ca6cb1",
  esYaqui: "8fc99864-cb05-4770-be8d-4a11b1c44d9f",
  esRene: "2482f900-d2a4-49c5-a498-61030fc7459f",
  enYaqui: "ed3b2ca7-e0d4-4ce1-970c-5a5bd73df09e",
  enRene: "dc92dc07-f72a-414c-8c8c-1213b93e533f",
};
const yaqui = "faff18bd-3dbc-477a-bc38-859d611887f0";
const rene = "c1575281-d275-4f34-a721-9f02736132d2";

const t = (text: string): EditorialInlineNode => ({ type: "text", text });
const ar = (artistId: string, displayText: string, occurrenceId: string): EditorialInlineNode => ({
  type: "artistReference",
  attrs: { artistId, displayText, occurrenceId },
});
const p = (...content: EditorialInlineNode[]) => ({ type: "paragraph" as const, content });
const h = (text: string) => p({ type: "text", text, marks: [{ type: "bold" }] });

export const es: EditorialDocumentV1 = {
  type: "doc",
  content: [
    p(t("Susana Silfa, nombre profesional de Susana Mercedes Silfa Finke, es una cantante, compositora y actriz dominicana oriunda de Santo Domingo. Nacida un 26 de agosto, ha desarrollado una carrera entre el bolero, el jazz y la bachata que también grabó bajo el nombre de Mariita, «La Reina del Amargue».")),
    h("Formación e inicios"),
    p(t("Ingresó al «Conservatorio Nacional de Música» a los trece años y formó parte de su coro. Tras continuar sus estudios de canto, comenzó a trabajar profesionalmente en 1984 con agrupaciones musicales de hoteles y cruceros. La guitarra ha acompañado tanto sus actuaciones como su actividad docente.")),
    h("La etapa de Mariita"),
    p(t("En 1992 emprendió el proyecto bachatero Mariita, «La Reina del Amargue». Su álbum «Bachata Amargue», editado por «Jose Luis Records», figura en Apple Music como una producción de doce canciones de 1994; «Centro León» documenta que contiene composiciones suyas. Su grabación «Te quiero más que a nadie» apareció después en una recopilación del sello. En 2017 fue invitada de honor al congreso Música, Identidad y Cultura en el Caribe, dedicado a la bachata, y participó en la velada «Pioneros de la Bachata» de «Centro León».")),
    h("Poesía hecha canción"),
    p(t("A comienzos de los años 2000 desarrolló con la poeta Marivell Contreras el proyecto «Solfa y Tinta», dedicado a llevar textos literarios a la música. La propuesta incluyó una adaptación escénica de «Cien años de soledad», de Gabriel García Márquez, presentada en 2014, y una intervención musical sobre «El viento frío», de "), ar(rene, "René del Risco Bermúdez", ids.esRene), t(", en la Feria Internacional del Libro de 2017. En 2012 interpretó «Hoy existiré», canción basada en un poema de Lourdes Batista para una campaña contra la violencia hacia las mujeres. En 2017 apareció además «Solo Para Locos», producción de poemas musicalizados de autores de la diáspora.")),
    h("Radio, escenario y enseñanza"),
    p(t("En los primeros años del siglo XXI trabajó en el programa «Aquí Yaqui» junto a "), ar(yaqui, "Yaqui Núñez del Risco", ids.esYaqui), t(". En 2010 conducía «Salud, Dinero y Amor» en «Studio 88 FM». También integró el jurado del concurso televisivo «Buscando el Éxito» y fundó «Voice Gym», donde enseña técnica vocal e iniciación a la guitarra. Su incursión teatral documentada incluye la obra «Aroma de Casablanca» (2014).")),
    h("Bolero y jazz"),
    p(t("Desde 2001 ha cultivado el bolero y el jazz en bares, teatros y conciertos. Su espectáculo «Cuando el bolero es jazz» se presentó en «Casa de Teatro» en 2008 y 2015, y llegó a «Centro León» en 2018 con un repertorio que unía bolero, jazz y bossa nova. Con su propio nombre publicó el sencillo «Se fue» en 2011 y «Agradecida» en 2021.")),
    h("Legado"),
    p(t("Susana Silfa enlaza dos vertientes de la canción dominicana: la bachata de su etapa como Mariita y la interpretación de boleros con lenguaje jazzístico. Su trabajo con la poesía, la radio y la formación vocal amplía una trayectoria que sigue presente en los escenarios.")),
  ],
};

export const en: EditorialDocumentV1 = {
  type: "doc",
  content: [
    p(t("Susana Silfa (Susana Mercedes Silfa Finke) is a Dominican singer, songwriter and actress from Santo Domingo. Born on 26 August, she has worked across bolero, jazz and bachata; she also recorded bachata as Mariita, «La Reina del Amargue».")),
    h("Training and early work"),
    p(t("She entered the «Conservatorio Nacional de Música» at thirteen and sang in its choir. After further vocal studies, she began working professionally with hotel and cruise-ship bands in 1984. Guitar has remained part of both her performances and her teaching.")),
    h("The Mariita years"),
    p(t("In 1992 she launched the bachata project Mariita, «La Reina del Amargue». Apple Music dates her twelve-track album «Bachata Amargue», issued by «Jose Luis Records», to 1994; «Centro León» documents that it includes songs she wrote. Her recording «Te quiero más que a nadie» later appeared on a compilation from the label. In 2017 she was a guest of honor at the Música, Identidad y Cultura en el Caribe congress devoted to bachata and appeared at «Centro León»'s «Pioneros de la Bachata» concert.")),
    h("Poetry set to music"),
    p(t("In the early 2000s she developed «Solfa y Tinta» with poet Marivell Contreras, setting literary texts to music. The project included a stage adaptation of Gabriel García Márquez's «Cien años de soledad» in 2014 and a musical presentation of «El viento frío» by "), ar(rene, "René del Risco Bermúdez", ids.enRene), t(" at the 2017 International Book Fair. In 2012 she performed «Hoy existiré», based on a poem by Lourdes Batista for a campaign against violence toward women. «Solo Para Locos», a collection of poems by diaspora writers set to music, appeared in 2017.")),
    h("Broadcasting, theater and teaching"),
    p(t("In the early 2000s she worked on the program «Aquí Yaqui» with "), ar(yaqui, "Yaqui Núñez del Risco", ids.enYaqui), t(". By 2010 she was hosting «Salud, Dinero y Amor» on «Studio 88 FM». She also served on the jury of the television talent show «Buscando el Éxito» and founded «Voice Gym», where she teaches vocal technique and introductory guitar. Her documented stage acting includes «Aroma de Casablanca» (2014).")),
    h("Bolero and jazz"),
    p(t("Since 2001 she has performed bolero and jazz in bars, theaters and concert halls. Her show «Cuando el bolero es jazz» played at «Casa de Teatro» in 2008 and 2015 and reached «Centro León» in 2018, combining bolero, jazz and bossa nova. Under her own name she released the singles «Se fue» in 2011 and «Agradecida» in 2021.")),
    h("Legacy"),
    p(t("Silfa's career connects two strands of Dominican song: the bachata she recorded as Mariita and her jazz-inflected bolero performances. Her work with poetry, broadcasting and vocal training broadens a career that remains active on stage.")),
  ],
};

function markdown(document: EditorialDocumentV1): string {
  return document.content.map((block) => {
    if (block.type !== "paragraph") throw new Error("Unexpected block type in biography");
    const contents = block.content ?? [];
    if (contents.length === 1 && contents[0].type === "text" && contents[0].marks?.length === 1 && contents[0].marks[0].type === "bold") {
      return `**${contents[0].text}**`;
    }
    return contents.map((node) => node.type === "artistReference" ? node.attrs.displayText : node.type === "text" ? node.text : "").join("");
  }).join("\n\n");
}

for (const [locale, document] of [["es", es], ["en", en]] as const) {
  const result = validateEditorialDocument(1, document);
  if (!result.ok) throw new Error(`${locale}: ${JSON.stringify(result.issues)}`);
}

const q = (value: string) => `'${value.replaceAll("'", "''")}'`;
const a = (values: string[]) => `ARRAY[${values.map(q).join(",")}]::text[]`;
const refs = [
  [ids.es, ids.esYaqui, yaqui], [ids.es, ids.esRene, rene],
  [ids.en, ids.enYaqui, yaqui], [ids.en, ids.enRene, rene],
];
const integrity = buildEditorialIntegrityReport({
  documents: [
    { id: ids.es, document_type: "artist_biography", owner_artist_id: ids.artist, locale: "es", schema_version: 1, document: es, status: "published" },
    { id: ids.en, document_type: "artist_biography", owner_artist_id: ids.artist, locale: "en", schema_version: 1, document: en, status: "published" },
  ],
  relations: refs.map(([editorial_document_id, occurrence_id, target_artist_id]) => ({ editorial_document_id, occurrence_id, entity_type: "artist", target_artist_id })),
  artists: [
    { id: ids.artist, name: "Susana Silfa", slug: "susana-silfa", status: "draft", bio_es: markdown(es), bio_en: markdown(en) },
    { id: yaqui, name: "Yaqui Núñez del Risco", slug: "yaqui-nunez-del-risco", status: "published" },
    { id: rene, name: "René del Risco Bermúdez", slug: "rene-del-risco-bermudez", status: "published" },
  ],
});
if (integrity.counts.blocking || integrity.counts.warning) throw new Error(JSON.stringify(integrity));
const sql = `BEGIN;
INSERT INTO public.artists
  (id,name,sort_name,slug,first_name,middle_name,last_name,second_last_name,stage_name,type,status,gender,primary_role,occupations,primary_genre,genres,artist_tags,aliases,instruments,facebook,website,bio_es,bio_en)
VALUES
  (${q(ids.artist)},'Susana Silfa','Silfa, Susana','susana-silfa','Susana','Mercedes','Silfa','Finke','Mariita','solo_artist','draft','female','singer',${q(JSON.stringify(["composer", "actress", "vocal coach", "music educator", "guitarist"]))}::jsonb,'bolero',${a(["bachata", "jazz"])},${a(["secular"])},${a(["Mariita", "Maríita", "La Reina del Amargue"])},${a(["voice", "guitar"])},'susana.silfa','https://susanasilfalavoz.blogspot.com/',${q(markdown(es))},${q(markdown(en))});
INSERT INTO public.editorial_documents (id,document_type,locale,schema_version,document,status,owner_artist_id,revision)
VALUES
  (${q(ids.es)},'artist_biography','es',1,${q(JSON.stringify(es))}::jsonb,'published',${q(ids.artist)},1),
  (${q(ids.en)},'artist_biography','en',1,${q(JSON.stringify(en))}::jsonb,'published',${q(ids.artist)},1);
INSERT INTO public.editorial_entity_references (editorial_document_id,occurrence_id,entity_type,target_artist_id)
VALUES
  ${refs.map(([doc, occ, target]) => `(${q(doc)},${q(occ)},'artist',${q(target)})`).join(",\n  ")};
COMMIT;
SELECT id,name,status,first_name,middle_name,last_name,second_last_name,stage_name,primary_role,occupations,primary_genre,genres,artist_tags,gender,instruments,facebook,spotify,date_of_birth,birth_place,province FROM public.artists WHERE id=${q(ids.artist)};
SELECT id,locale,status,revision FROM public.editorial_documents WHERE owner_artist_id=${q(ids.artist)} ORDER BY locale;`;

if (process.argv.includes("--sql")) console.log(JSON.stringify({ sql, ids }));
else console.log(JSON.stringify({ valid: true, ids, esParagraphs: es.content.length, enParagraphs: en.content.length, references: refs.length, integrity: integrity.counts, findings: integrity.findings }));
