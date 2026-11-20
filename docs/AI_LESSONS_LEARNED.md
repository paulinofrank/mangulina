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

## 5. Social Media Handles Format
*   **Never store full URLs** in `artists.instagram`, `artists.facebook`, `artists.twitter`, `artists.tiktok`, etc.
*   **Store only the username or handle** (e.g., `'marcoscaminero'` instead of `'https://www.instagram.com/marcoscaminero/'`, or numeric ID `'100063553412078'` for Facebook).
*   The application/frontend builds the destination links dynamically.

## 6. Contributor Discography & Song Ingestion Rules (Editor Instruction, 2026-10-24)
*   **Prohibition of Karaoke / Re-recordings:** Under no circumstances will Karaoke, backing tracks, or imitation cover albums (e.g. «Pistas Para Cantar Como...») be cataloged. They introduce redundancy and have zero documentary value.
*   **Existing Songs in Performer Discography:** If the song already exists in the performer's discography, do NOT create duplicate releases or recordings; ONLY attach/update authorship credits (`work_credits`).
*   **Missing Performers:** If the lead performer does not exist in Mangulina, do NOT create them automatically during a contributor workflow; exclude them and report them at the end.
*   **Performers Without Existing Discography:** If a performer exists in Mangulina but does NOT yet have their discography cataloged, do NOT create partial floating tracks; report the artist at the end to be scheduled for a dedicated discography workflow.

## 7. Duration and Track Length Units: Always Milliseconds (`ms`)
*   **Database Standard:** Columns `recordings.duration` and `tracks.length` must **ALWAYS** be stored in **milliseconds**, never in raw seconds (e.g. a 4:15 track is `255000` ms, not `255`).
*   **The "0:00" Bug:** Frontend formatters divide by 1000 (`Math.round(ms / 1000)`). If a duration is stored in seconds (e.g. `255`), `255 / 1000 = 0.255`, which rounds to `0`, rendering as **`0:00`**.
*   **Defensive Formatting:** All UI duration formatters must guard against second values (`const totalSeconds = ms < 1000 ? Math.round(ms) : Math.round(ms / 1000);`), but catalog ingestion scripts must strictly insert true millisecond values (`duration_seconds * 1000`).

## 8. YouTube Channel Discovery & Live Link Verification (Editor Instruction, 2026-11-07)
*   **Always search for YouTube channel:** During artist profile research, always search for and populate their official YouTube channel/handle (`artists.youtube`), rather than leaving it empty while only populating Instagram/Facebook/Spotify.
*   **Verify external links before persisting (No broken URLs):** Never save an artist's `website` or external links blindly without verifying that the URL actually loads and is active. Expired, parked, or dead domains (e.g. an artist's abandoned portfolio site) must be omitted (`website: null`) to prevent dead links on public profiles.



