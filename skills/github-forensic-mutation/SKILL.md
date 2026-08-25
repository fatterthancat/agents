---
name: github-forensic-mutation
description: Use when an agent is asked to create, update, delete, commit, push, merge, or otherwise mutate GitHub repository state, especially when GitHub tool availability, write capability, target state, or completion evidence is uncertain.
---

# GitHub Forensic Mutation

## Core invariants

GitHub capability is a runtime fact, not a remembered limitation.
A mutation is not complete because a write tool returned success.

`CAPABILITY_ASSUMED != CAPABILITY_PROVEN`

`WRITE_ATTEMPTED != WRITE_EVIDENCED != VERIFIED`

Only `VERIFIED` permits claims such as "changed", "written", "updated", "created", "deleted", "merged", "done", or equivalent.

## Capability discovery gate

Before saying GitHub is unavailable, disconnected, read-only, or incapable of the requested mutation:

1. Inspect the GitHub tools/apps actually available in the current runtime.
2. Discover the specific actions needed for the task instead of inferring capability from one missing or failed action.
3. If a GitHub connector/tool is in scope, invoke it before asking the user to paste repository content, connect GitHub, or use another path.
4. Distinguish connector presence, read capability, write capability, ref/commit capability, PR/issue capability, and evidence quality. Failure or absence of one does not prove absence of the others.
5. Treat an explicit `@GitHub` request as a direct routing instruction when that connector is available.
6. Do not reuse yesterday's connector limitations as today's capability model. Re-discover when the runtime/tool surface may have changed.

Never tell the user to connect GitHub or repeat that access exists until actual runtime discovery or an attempted GitHub call establishes that the needed capability is unavailable or unauthenticated.

If a high-level wrapper lacks a needed write/evidence field, inspect available lower-level Contents/Git database/ref/commit capabilities before declaring the mutation impossible.

If the environment defines a repository navigation index such as `github_map`, consult it first for ecosystem routing when relevant, then verify all material state against the real repository. An index is navigation evidence, not repository source of truth.

## Failure boundary

Classify failures before deciding recovery:

- **PRECALL_FAILURE** — local schema/argument/tool-validation failure proves the external mutation was not sent. Correcting the invocation is not a retry of a GitHub write.
- **REMOTE_WRITE_ERROR** — the external system returned a definite rejection and evidence establishes no requested durable change.
- **UNKNOWN_MUTATION_STATE** — a mutation may have reached GitHub but the response is insufficient to prove whether durable state changed. Do not retry until authoritative state is read or the ambiguity is otherwise resolved.

A generic exception is not enough to choose among these classes. Use the strongest available evidence about whether an external call actually occurred.

## Required state machine

0. **CAPABILITY_DISCOVERED** — establish the current GitHub tool surface needed for this task. Do not infer it from model memory or a previous conversation.
1. **DISCOVERED** — identify authoritative repository and target ref. Navigation indexes may point to the repo, but repository state is authoritative.
2. **BASELINED** — read current target ref/HEAD, target path/object, repository instructions relevant to the target, and current blob/object identity when applicable.
3. **MUTATION_PREPARED** — state exact intended delta, allowed scope, expected resulting state, and material risk before writing.
4. **WRITE_ATTEMPTED** — execute one bounded remote mutation. Preserve returned evidence or error. A PRECALL_FAILURE does not enter this state.
5. **WRITE_EVIDENCED** — obtain durable remote identity: commit SHA, ref target, PR/issue identifier, or the authoritative equivalent for that mutation.
6. **READ_BACK** — read the authoritative remote again using the intended ref or resulting durable identity.
7. **DIFF_VERIFIED** — compare observed remote state against the prepared delta and confirm no unexpected scope.
8. **VERIFIED** — and only now report the mutation as completed.

If any transition cannot be established, stop at the highest proven state and say what is missing.

## Before mutation

Report these fields before the first remote write:

- **FACTS** — capability evidence, repo, ref, HEAD/object identities actually read.
- **CURRENT** — relevant current content/state and applicable repository instructions.
- **CHANGE** — exact bounded delta to make.
- **RISK** — ambiguity, concurrency, permissions, protected refs, destructive effects, or verification gaps.

Do not mutate when repository, target ref, authority, or material scope is ambiguous.

For contents-style replacement or deletion, use the current blob SHA when the available API requires optimistic concurrency. Never reuse a stale SHA silently.

## Mutation rules

- Preserve exact user-requested bytes/semantics. Do not sanitize, rewrite, broaden, or "improve" literal requested content unless required by safety or the user asks.
- Prefer an isolated branch when the user has not explicitly authorized direct default-branch mutation.
- Keep independent writes serial when they target the same path/ref or when the user explicitly requires sequential verification.
- Do not hide or overwrite a failed remote attempt with an automatic retry. Record the failed observation first; retry only when authorized or when recovery is mechanically necessary and transparent.
- A PRECALL_FAILURE may be corrected immediately because no remote write occurred; preserve the distinction.
- A textual success message is a claim until durable identity is returned or independently observed.
- Same-content writes, branch protection behavior, stale-SHA behavior, and visibility delays are empirical API behavior. Do not invent them; report what the real endpoint/tool returned.
- Never infer success from local state when the requested authority is GitHub remote state.
- Never answer from stale cross-chat knowledge when the current repository can be read directly.

## Verification contract

Verification must answer all applicable questions:

1. Does the resulting durable object exist?
2. Does its parent/base match the prepared baseline where that relation matters?
3. Does the intended ref point where expected?
4. Does reread show the exact intended bytes/state?
5. Does the diff contain only expected paths and changes?
6. Did any protected-branch, permission, CI, or merge gate remain unresolved?
7. If multiple writes were requested sequentially, was each write independently reread before the next one?

A commit SHA without reread is `WRITE_EVIDENCED`, not `VERIFIED`.
A reread without scope comparison is `READ_BACK`, not `VERIFIED`.
A successful mutation to the wrong ref/path is not completion.

## Final return

Use:

### FACTS
Observed capability, source/ref/object identities, and mutation evidence.

### CHANGES
Only changes that reached `VERIFIED`. If none did, say `none verified`.

### UNKNOWN
Anything not proven: unobserved propagation, missing gate, ambiguous attribution, unrun CI, or failed verification.

### NEXT
The cheapest discriminator needed to reach `VERIFIED`, or `none`.

## Failure handling

On failure, preserve:

- whether the failure was PRECALL_FAILURE, REMOTE_WRITE_ERROR, or UNKNOWN_MUTATION_STATE;
- exact operation and target;
- returned status/error/evidence available from the tool;
- whether durable state changed;
- highest proven state-machine stage;
- cleanup/revert status if relevant;
- next cheapest discriminator.

Do not convert a diagnosis, attempted repair, local commit, tool acknowledgement, or remembered connector limitation into a success/failure claim about current GitHub state.

## References

Read `references/evidence-model.md` when evidence levels or completion semantics are disputed.
Read `references/failure-catalog.md` when handling capability confusion, ambiguous or failed writes.
Use `tests/pressure-scenarios.md` to validate this skill against common rationalizations before changing its rules.
