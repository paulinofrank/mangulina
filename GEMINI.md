# Mangulina AI Agent Guidelines (Antigravity & Gemini)

## 🚀 Autonomous Execution Mode (Bypass Permissions & Planning)

- **Execute Directly and Autonomously**: Do NOT pause to ask for permission or user confirmation before running terminal commands, editing files, or calling tools. Proceed autonomously to completion.
- **Skip Unnecessary Planning**: Do NOT halt execution to generate an implementation plan or ask "Should I proceed?" unless the user explicitly requests a plan. Take direct action immediately.
- **End-to-End Ownership**: When given a task, diagnose the problem, write the code, run relevant builds/tests (`npx tsc --noEmit`, etc.), and verify changes without requiring hand-holding or micro-approvals.

---

## 📚 Project Rules & Required Reading

Before making code or schema changes, adhere to the authoritative project governance documents:

1. **[docs/AI_INSTRUCTIONS.md](docs/AI_INSTRUCTIONS.md)**: Database rules (8 core rules), credits model, development checklists.
2. **[docs/DATA_GOVERNANCE.md](docs/DATA_GOVERNANCE.md)**: Entity definitions (Artist, Work, Recording, Release, Track), Performer vs. Creative Contributor.
3. **[docs/ROLE_DICTIONARY.md](docs/ROLE_DICTIONARY.md)**: Valid role names and relationship types. Do not invent new roles.
4. **[docs/EDITORIAL_BIOGRAPHY_FORMAT.md](docs/EDITORIAL_BIOGRAPHY_FORMAT.md)**: How biographies are structured and stored in `editorial_documents`.
5. **[docs/BUILD_NOTES.md](docs/BUILD_NOTES.md)**: Build and deployment conventions.

---

## 🛡️ Core Principles

- **Preserve Editorial Accuracy**: Historical credit text, original titles, and relationships must be preserved as released.
- **Preserve Backward Compatibility**: Existing pages, APIs, queries, and features must continue working.
- **Dominican Artist Creation & Draft Status Policy**:
  - Before creating any missing artist discovered during discography, works, or credits workflows, confirm that the artist is **Dominican**.
  - Newly created artists must ALWAYS be saved with `status = 'draft'` (NEVER published immediately).
  - Leaving new artists in `draft` status allows the editor to review details and upload their photo before publishing.
- **Recording-Driven Work & Credit Creation Rule**:
  - When creating or documenting the catalogue of an arranger, composer, or lyricist, do NOT create standalone/floating Work entities directly without release context.
  - Always create the song/track within the **Performer's Discography** (on their Release/Recording), and attach the composer, lyricist, or arranger through credits (`work_credits` / `recording_credits`).
  - This anchors the song to historical release evidence and automatically populates the creator's Works Portfolio tab.
- **Self-Performance Presentation Rule**: Songs performed by an artist belong strictly in their **Discography** tab. An artist's **Works / Compositions Portfolio** tab must NEVER duplicate songs performed by themselves, but is reserved exclusively for works written, composed, arranged, or produced for OTHER artists (DATA_GOVERNANCE.md Section 5.5).
- **Search Before Creating**: Check existing schema, tables, columns, and previous migrations before adding new structures.
- **Verification**: Ensure TypeScript compiles cleanly (`npx tsc --noEmit`) and existing functionality remains unbroken before completing a task.
