# User Ecosystem Routing

This reference is specific to the `fatterthancat` GitHub ecosystem. Re-verify current repository state on each task; these ownership rules guide routing but do not replace repository evidence.

## Account binding

For owner-ambiguous personal GitHub requests, establish the current authenticated GitHub login before repository discovery.

When the authenticated login is `fatterthancat`:

1. Treat repositories available through the `fatterthancat` installation/account as the initial repository universe.
2. Use `fatterthancat/github_map` as the first navigation index for ecosystem/project routing when relevant.
3. Resolve project names against `fatterthancat/*` and the map before any global/public repository search.
4. A repository owned by another account is external. Use it only when the user explicitly named it or a verified artifact in the `fatterthancat` ecosystem points to it as upstream, donor, dependency, comparison target, or other relation.
5. Never infer that a foreign repository is the user's project merely because its name or contents match the query.

Observed regression on 2026-08-25: a Temporary Chat had authenticated GitHub login `fatterthancat` but resolved `github-operating-protocol` through global/public discovery to `dzinh1901-lang/meta-agent`. That is a routing failure. The correct personal route is authenticated account -> `fatterthancat/github_map` -> `fatterthancat/agents` -> `skills/github-operating-protocol/`.

## Navigation and truth

### `fatterthancat/github_map`

Role: lightweight navigation/index of what exists, where it lives, and which relationships are CONFIRMED / INFERRED / UNKNOWN.

Use it first when a task spans the user's GitHub ecosystem or the target repository/artifact is not already explicit.

It is **not** the authoritative current state of code or runtime. If the map conflicts with the real repository, the repository wins for current state and the map is stale evidence that may need separate maintenance.

### Real repositories, commits, CI and artifacts

Role: physical source of truth for code, history, branches, tests, runs and produced artifacts.

Do not claim `looked at GitHub` unless these sources were actually read through GitHub in the current task when the claim depends on them.

### `fatterthancat/memory`

Role: canonical long-term project state, recovery/handoff records, incidents, principles and other durable context that must survive chats.

In active project context, when the user says variants of `запиши`, `запомни`, `сохрани`, `зафиксируй`, or `занеси в GitHub` without an explicit literal destination, default intent is **durable recovery/handoff**, not ChatGPT memory and not a one-line note. Find/update the existing canonical project artifact in `memory` when one exists.

If another repository/project explicitly establishes a different canonical state owner, follow that explicit ownership and preserve a pointer from memory/map as appropriate rather than creating competing live copies.

### `fatterthancat/agents`

Role: agent/executor research, portable skills/protocols, execution evidence, historical incidents and pointers.

Do not use `agents` as a second canonical copy of project operational state when `memory` already owns that state. Keep pointers/provenance here when agent history matters.

### Loom and project-specific logs

Treat project/experiment logs as evidence and continuity sources according to their own repository instructions. They do not automatically replace the canonical project handoff owner.

## Project-context record semantics

For this ecosystem:

`record/save/remember` after substantive work -> recover canonical owner -> create/update self-contained handoff -> commit -> reread -> verify -> return commit evidence.

Explicit user destination wins. Examples:

- `создай test-canary.md с одной строкой ...` -> literal file mutation;
- `запиши всё это, чтобы следующий чат продолжил` -> canonical handoff update;
- `запиши идею X` -> route to the project's established idea/memory owner, preserving enough context that the idea is recoverable; do not silently turn it into a global handoff unless the active context requires that.

## Required handoff quality

The user's established intent is that another chat/agent should be able to understand the project state months later without the user retelling it. Use `handoff-contract.md`; short conclusion-only notes are insufficient.

## GigaChat regression example

Historical evidence shows why ownership matters:

1. `agents/incidents/gigachat-codex-recovery-state.md` was created after lost-runtime reconstruction.
2. It was immediately expanded into a `Single Handoff`.
3. A `RECOVERY GATE` was added because repeated repair without a stable snapshot caused the same reconstruction cycle to repeat.
4. A canonical-artifact audit searched related repositories.
5. `agents` was finally reduced to a pointer and the canonical recovery state was moved to `fatterthancat/memory` at `infrastructure/gigachat-codex-recovery-2026-08-24.md`.

Future GigaChat/Codex recovery should begin by reading that canonical handoff (or its current successor/pointer) and then verifying only the unresolved/current delta. Do not restart from broad archaeology unless the canonical path is missing, contradicted, or explicitly superseded.

## Return shape

For GitHub ecosystem work, finish with:

- **FACTS** — verified repository/state evidence;
- **CHANGES** — verified durable mutations only;
- **UNKNOWN** — unresolved or unrun evidence;
- **NEXT** — smallest next discriminator, or `none`.
