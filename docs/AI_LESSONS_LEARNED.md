# AI Agent Lessons Learned (Mangulina)

This document serves as a persistent memory and checklist for AI agents working on the Mangulina database, ensuring mistakes are not repeated and the highest editorial standards are maintained.

## 1. Database Searching & Duplication Prevention
*   **Never assume an artist is missing based on a simple name search.** Artists are often registered under aliases, stage names, or variations (e.g., `Luis "Terror" Días` instead of `Luis Días`, `El Cieguito de Nagua` instead of `Bartolo Alvarado`).
*   **Action:** Always perform broad searches (`ilike`) including known aliases, real names, and fragments of the name in both the `name` and `slug` columns before deciding to create a new record.

## 2. Editorial Document Format (`editorial_documents`)
*   **Tiptap JSON Structure:** Biographies must strictly follow the Tiptap/Prosemirror JSON structure (`type: "doc"`, `content: [ { type: "paragraph", content: [...] } ]`).
*   **Locales:** Both `es` and `en` locales must be created.
*   **Status:** The `status` field for *both* the `artists` table and the `editorial_documents` table must **ALWAYS** be `'draft'` upon creation or major update. Do not publish automatically.

## 3. Typographical & Style Rules
*   **Guillemets (`«»`):** Titles of works (songs, albums) and bands/entities that do NOT have a row in the catalog must be wrapped in guillemets (`«»`). Do *not* use straight quotes (`""`).
*   **Punctuation Placement:** Punctuation (commas, periods) must always be placed **outside** the guillemets, in both Spanish and English (e.g., `...the iconic «Canto de remos».`).
*   **Artist References:** Artists that *do* exist in the catalog must use the `artistReference` node (using their exact UUID). They do *not* get wrapped in guillemets.

## 4. Curatorial Quality (The "Billo Frómeta" Standard)
*   **Beyond Encyclopedic Facts:** Do not just list birth and death dates. Biographies must capture the *soul* and *narrative* of the artist's legacy.
*   **Context:** Include cultural milestones, influential anecdotes (e.g., political exiles, specific record-breaking events), and identify their specific musical innovations (e.g., the "Mosaicos" of Billo Frómeta, the "Merenhouse" of Fulanito).
*   **Process:** Use the `/browser` or deep web searches to gather human-curated historical context before writing.
