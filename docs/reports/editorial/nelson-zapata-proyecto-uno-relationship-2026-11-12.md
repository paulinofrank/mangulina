# Nelson Zapata / Proyecto Uno — relationship manifest (2026-11-12)

Editor request: add the missing relationship between published Nelson Zapata (`8320823b-6719-45c3-a414-cf43619c7b21`) and published Proyecto Uno (`f838ab51-002f-4737-ab38-17f65beec9ab`). This explicitly authorizes the shared relationship, which appears on both fichas. No biography, release, media, other artist, publication state, code, schema or security change is in scope.

| Field | Before | Proposed after | Evidence |
| --- | --- | --- | --- |
| Source → target | no relationship in either direction | Nelson Zapata → Proyecto Uno | Exact artist IDs and current published records checked. |
| Relationship | none | founder (`founder_of`) | [Nelson's first-person account in VICE](https://www.vice.com/es/article/la-historia-de-proyecto-uno-contada-por-uno-de-sus-fundadores-nelson-zapata/) identifies himself and Rick Echavarría as the original founders. |
| Start / end year | none | both null | Nelson says the beginning was *approximately* 1989; do not present it as an exact year. No supported end year. |
| Notes | none | `Fundador; la primera etapa comenzó hacia 1989, según su relato en VICE (2015).` | Same first-person account. |

The existing Proyecto Uno relation to Magic Juan is a separate `member_of` row and remains untouched. Use the admin relationship editor so the application refreshes the English and Spanish paths of **both** affected artists. Verify the saved row and both public views. The previously stale second Nelson bio mention in Proyecto Uno should also be checked after this targeted refresh, but that biography is not being edited here.

## Execution and verification

Created one `public.artist_relationships` row through the admin editor: `c62fbb23-d7ce-49eb-a01d-789fca0f0d74`, Nelson → Proyecto Uno, `founder_of`, null start/end years, notes exactly as proposed. Database readback confirmed one matching row. The admin displayed Proyecto Uno as a founded project of Nelson. Fresh public checks showed **Fundador de → Proyecto Uno** on Nelson's Spanish ficha and **Fundador → Nelson Zapata** on Proyecto Uno's Spanish ficha; both directions also appeared on the English fichas. The two Nelson biography links on Proyecto Uno's Spanish page were present after the targeted refresh, resolving the stale public rendering noted in the earlier profile report. No biographies or other records were written.
