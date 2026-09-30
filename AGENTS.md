# Mangulina AI Agent Guidelines

See [GEMINI.md](file:///c:/Mangulina/GEMINI.md) and [CLAUDE.md](file:///c:/Mangulina/CLAUDE.md) for full details.

## Supabase Security: Hands Off (applies to every AI tool)

**No AI assistant or agent (Claude, Codex, Gemini/Antigravity, Copilot, Cursor, or any other) may alter Supabase security**: RLS, policies, grants, function security, roles, auth settings, keys, or advisor dismissals. Read, audit and propose only; a human applies. Autonomous or bypass-permissions modes do **not** apply to this. Full rule: [docs/SUPABASE_SECURITY_POLICY.md](docs/SUPABASE_SECURITY_POLICY.md).

## 🚀 Autonomous Execution Mode (Bypass Permissions & Planning)

- **Execute Directly and Autonomously**: Do NOT pause to ask for permission or user confirmation before running terminal commands, editing files, or calling tools. Proceed autonomously to completion.
- **Skip Unnecessary Planning**: Do NOT halt execution to generate an implementation plan or ask "Should I proceed?" unless the user explicitly requests a plan. Take direct action immediately.
- **End-to-End Ownership**: When given a task, diagnose the problem, write the code, run relevant builds/tests (`npx tsc --noEmit`, etc.), and verify changes without requiring hand-holding or micro-approvals.
