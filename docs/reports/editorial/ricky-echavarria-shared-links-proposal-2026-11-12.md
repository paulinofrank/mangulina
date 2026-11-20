# Ricky Echavarría — shared relationship and incoming links proposal (2026-11-12)

No changes in this proposal have been written. Ricky's draft artist UUID is `a4296731-d9b5-4d87-adf8-78e706b06314`. The two public owner artists below require explicit expanded authorization under AGENTS.md.

| Owner / record | Before | Proposed change | Evidence |
| --- | --- | --- | --- |
| Proyecto Uno `f838ab51-002f-4737-ab38-17f65beec9ab` and Ricky | No structured founder relationship for Ricky | Add one Ricky → Proyecto Uno `founder_of` relationship, no exact start/end years | [CUNY DSI profile](https://dominicanmusicusa.com/educational_resources/proyecto-uno/221), [CUNY historical narrative](https://dominicanmusicusa.com/narratives/1990s-new-musical-trends/4). |
| Nelson Zapata EN biography `d5cb5096-8d90-4e34-bb8b-85aa78b73e6e`, revision 1 | `with Rick Echavarría around 1989` is plain text | Change only `Rick Echavarría` to `artistReference` displaying canonical `Ricky Echavarría`; preserve all other prose and references | Existing paragraph identifies the same cofounder; CUNY and first album corroborate. |
| Nelson Zapata ES biography `c34d2d39-6bcc-4d8b-9e31-1891cef023c1`, revision 1 | `Junto a Rick Echavarría fundó` is plain text | Change only `Rick Echavarría` to `artistReference` displaying canonical `Ricky Echavarría`; preserve all other prose and references | Same identity. |

The exact text change from Rick to Ricky is required because `artistReference.displayText` must match `artists.name` character for character. Revisions would become 2 if no one edits the documents first. After authorization, use the editorial lifecycle, verify both reference rows and Markdown mirrors, and refresh only Nelson's EN/ES public routes and both artists' relationship routes. No discography or other profile is part of this proposal.
