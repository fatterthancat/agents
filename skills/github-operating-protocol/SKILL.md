---
name: github-operating-protocol
description: Use when the user asks to inspect, recover, continue, record, save, hand off, create, update, delete, commit, push, merge, or otherwise work with GitHub or project state, especially when GitHub access or canonical state may already exist.
---

# GitHub Operating Protocol

## Iron laws

1. **GitHub capability is a current-runtime fact.** Never claim GitHub is unavailable, disconnected, or read-only before discovering and attempting the relevant current capability.
2. **A GitHub inspection requires a GitHub read.** Memory, prior chat, web search, and navigation indexes are not substitutes.
3. **Navigation is not authority.** Use ecosystem maps to route; use repositories, commits, CI/artifacts, and canonical state records for truth.
4. **A project-context `record/save/remember` is durable state intent.** If no literal destination is given, preserve a self-contained recovery/handoff in the existing canonical owner rather than producing prose or a tiny duplicate note.
5. **A write is not complete until independently re-read and scope-verified.** `WRITE_ATTEMPTED != WRITE_EVIDENCED != VERIFIED`.

## Decode the operation first

Classify the request from the active context:

- **INSPECT** — `@GitHub`, `посмотри/чекни/изучи GitHub`, current repo state.
- **RECOVER** — `продолжай`, `восстанови`, `что там с X`, resume in a new chat.
- **RECORD_HANDOFF** — `запиши`, `запомни`, `сохрани`, `зафиксируй`, `занеси в GitHub` after project work.
- **MUTATE** — explicit create/update/delete/commit/ref/PR/merge request.

Explicit path/content overrides inference: if the user says exactly what file and bytes to write, perform that literal mutation.
A short command inherits the active verified project context; do not make the user restate it unless a material ambiguity survives repository/context recovery.

## Capability gate

Before doing GitHub work, inspect the actual connector/app actions available now. Treat read, write, Git-database, PR/issue, Actions, authorization, and evidence quality as separate capabilities. An explicit `@GitHub` routes to the connector when present.

Do not reuse a limitation from another chat/session as the current capability model. A local schema error is not a GitHub rejection. A missing search result is not proof of absence.

For ChatGPT-specific action behavior and traps, read `references/chatgpt-github-adapter.md`.

## Route before repeating archaeology

When an ecosystem index such as `github_map` exists, consult it first for routing. Then read the real repository/canonical artifact. If a canonical handoff path is already known, fetch it directly before broad search.

For this user's repository ownership rules, read `references/user-ecosystem-routing.md`.

## Mode workflows

### INSPECT / RECOVER

1. Establish current GitHub capability.
2. Route through the map/index if relevant.
3. Read the canonical handoff/state artifact if one exists.
4. Read current repository refs/files/commits and only the evidence needed to resolve deltas or contradictions.
5. Resume at the unresolved frontier; do not repeat failed or already-proven work without new evidence.

### RECORD_HANDOFF

1. Find the existing canonical state owner before creating anything.
2. Read current artifact/ref/blob identity.
3. Build a self-contained continuation record using `references/handoff-contract.md`.
4. Update the canonical artifact first; keep other locations as pointers/provenance.
5. Obtain durable commit/ref evidence, re-read the artifact, and verify scope before saying it was recorded.

### MUTATE

1. Baseline repo/ref/HEAD/path/object and relevant repository instructions.
2. State **FACTS / CURRENT / CHANGE / RISK** before the first remote write when material.
3. Execute the smallest authorized mutation.
4. Preserve exact error boundary: `PRECALL_FAILURE`, `REMOTE_WRITE_ERROR`, or `UNKNOWN_MUTATION_STATE`.
5. Obtain durable identity, re-read authoritative remote state, compare exact intended bytes/state and full scope, then mark `VERIFIED`.

Never blindly retry `UNKNOWN_MUTATION_STATE`. Resolve remote state first.

## Return contract

Use:

- **FACTS** — what GitHub/current evidence actually proved.
- **CHANGES** — only independently verified durable changes.
- **UNKNOWN** — unresolved claims/gates; do not convert search misses or memory into facts.
- **NEXT** — the smallest unresolved discriminator, or `none`.

Read `references/evidence-model.md` for evidence levels, `references/failure-catalog.md` for failure classification, and both test files before weakening this protocol.