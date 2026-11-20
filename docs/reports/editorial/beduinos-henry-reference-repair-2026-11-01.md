# Los Beduinos and Henry Jiménez — biography reference repair

**Authorized scope:** The editor identified missing links in the existing public fichas for Los Beduinos (`c2e192d4-f144-4f9a-8db4-b71f0cff391e`) and Henry Jiménez (`1519cbca-ae0a-4ede-924b-244a49c9024e`). Only their published English and Spanish structured biographies were edited. Artist facts, music catalog records, publication state and other artists' biographies were untouched.

## Before → after

| Owner | Locale | Document UUID | Revision | Artist references |
| --- | --- | --- | --- | --- |
| Henry Jiménez | EN | `10558c0e-8f6b-4477-9072-c958272c0aee` | 2 → 3, published | 18 → 24 |
| Henry Jiménez | ES | `a29bc818-17be-4c63-b919-f03b790ae184` | 1 → 2, published | 18 → 24 |
| Los Beduinos | EN | `81931ec7-7cb0-4804-a290-c9895ae81954` | 7 → 8, published | 27 → 34 |
| Los Beduinos | ES | `80fd333b-37ff-48a2-a768-faa0fbe253e7` | 7 → 8, published | 27 → 34 |

In each Henry biography, six published catalog identities were linked at their existing mentions: Héctor Acosta “El Torito” (`dee014d6-cb3c-4abb-9262-165538277a0d`), Kinito Méndez (`c73737c2-0106-4a87-8dbe-5f1650d34342`), Sergio Vargas (`059a9e99-5d11-433e-97b9-9c35e57908f1`), Oro Sólido (`5602ba48-f2d7-4f38-b2a9-fea2aef24aca`), Mala Fe (`74b60ddd-3a3d-4983-8ff7-6fdf5f0513ed`), and Eddy Herrera (`ae3c0afb-0e0a-4506-bbe6-a59c3c68bb1e`). The Héctor Acosta mention uses the catalog's exact display name; the English sentence was minimally rephrased to keep the possessive natural.

In each Beduinos biography, five shorthand mentions of Wilfrido Vargas (`2bc36959-dcce-4e10-9ecf-2cd418eaa489`), one of Sony Ovalles (`82496438-cb38-4ba4-868f-2e01fdf023a7`), and one of Vicente Pacheco (`1e22f937-9de9-42ab-a8fd-33ae9ad15e90`) were expanded to the canonical names and linked. The existing Los Hijos del Rey reference was retained, with surrounding guillemets removed as required for artist references. Historical record titles containing «Wilfrido Vargas y sus Beduinos» remained titles, not individual artist mentions.

## Identity decisions and exclusions

- Los Beduinos names such as Chery Jiménez and Manuel de Jesús were not connected to unrelated or group identities. The catalog has a published **group** called Chery Jiménez y su Tercera Brigada, but no confirmed Chery personal ficha. [Revista Global](https://revistaglobal.org/politica-en-el-merengue-social-de-wilfrido-vargas/) describes Manuel de Jesús as an early Beduinos singer; no matching personal artist row was found. The separate Manuel Jiménez row was not assumed to be him.
- Henry's prose names the **people** Jossie Esteban and Pochy Familia. The catalog currently has the groups Jossie Esteban y La Patrulla 15 and Pochy y su Cocoband, so the personal mentions were not silently redirected to group fichas.
- Los Homeboys and Divas by Jiménez have artist rows marked `needs_review`. Public biographies were not linked to those currently nonpublic targets. Other unmatched names were left as text rather than assigned to homonyms.

## Verification and limit

The admin editor saved each locale separately through `Publish`; all four documents remained published. Read-only database checks found 24/24 unique link nodes and relation rows in each Henry biography and 34/34 in each Beduinos biography, with zero relation mismatches, noncanonical display names, or unpublished targets. The public Spanish [Henry Jiménez](https://mangulina.do/es/artists/henry-jimenez) and [Los Beduinos](https://mangulina.do/es/artists/los-beduinos) pages, plus [Henry's English page](https://mangulina.do/en/artists/henry-jimenez), displayed the new links in three targeted spot-checks. No deployment or manual cache refresh was performed.

The structured documents are the public biography source of truth. Existing `artists.bio_en`/`bio_es` legacy snapshots did **not** update when the admin document save ran: the current `upsert_editorial_document` function writes the documents and reference relations, but not those columns. [EDITORIAL_BIOGRAPHY_FORMAT.md](../../EDITORIAL_BIOGRAPHY_FORMAT.md) describes a synchronized legacy mirror, while the admin UI calls these columns frozen compatibility snapshots. No direct mirror write or code change was made under this link-repair scope.

Visual checks: [Henry Jiménez](henry-jimenez-links-verified-2026-11-01.png), [Los Beduinos](beduinos-henry-links-verified-2026-11-01.png).
