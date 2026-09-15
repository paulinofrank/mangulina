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
- **Search Before Creating**: Check existing schema, tables, columns, and previous migrations before adding new structures.
- **Verification**: Ensure TypeScript compiles cleanly (`npx tsc --noEmit`) and existing functionality remains unbroken before completing a task.
