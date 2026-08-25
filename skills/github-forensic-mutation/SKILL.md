---
name: github-forensic-mutation
description: Use when an agent is asked to create, update, delete, commit, push, merge, or otherwise mutate GitHub repository state where the user needs evidence that the intended remote change actually happened.
---

# GitHub Forensic Mutation

## Core invariant

A mutation is not complete because a write tool returned success.

`WRITE_ATTEMPTED != WRITE_EVIDENCED != VERIFIED`

Only `VERIFIED` permits claims such as "changed", "written", "updated", "created", "deleted", "merged", "done", or equivalent.

## Required state machine

1. **DISCOVERED** — identify authoritative repository and target ref. Navigation indexes may point to the repo, but repository state is authoritative.
2. **BASELINED** — read current target ref/HEAD, target path/object, and current blob/object identity when applicable.
3. **MUTATION_PREPARED** — state exact intended delta, allowed scope, expected resulting state, and material risk before writing.
4. **WRITE_ATTEMPTED** — execute one bounded mutation. Preserve returned evidence or error.
5. **WRITE_EVIDENCED** — obtain durable remote identity: commit SHA, ref target, PR/issue identifier, or the authoritative equivalent for that mutation.
6. **READ_BACK** — read the authoritative remote again using the intended ref or resulting durable identity.
7. **DIFF_VERIFIED** — compare observed remote state against the prepared delta and confirm no unexpected scope.
8. **VERIFIED** — and only now report the mutation as completed.

If any transition cannot be established, stop at the highest proven state and say what is missing.

## Before mutation

Report these fields before the first write:

- **FACTS** — repo, ref, HEAD/object identities actually read.
- **CURRENT** — relevant current content/state.
- **CHANGE** — exact bounded delta to make.
- **RISK** — ambiguity, concurrency, permissions, protected refs, destructive effects, or verification gaps.

Do not mutate when repository, target ref, authority, or material scope is ambiguous.

For contents-style replacement or deletion, use the current blob SHA when the available API requires optimistic concurrency. Never reuse a stale SHA silently.

## Mutation rules

- Prefer an isolated branch when the user has not explicitly authorized direct default-branch mutation.
- Keep independent writes serial when they target the same path/ref.
- Do not hide or overwrite a failed attempt with an automatic retry. Record the failed observation first; retry only when the task authorizes it or the recovery is mechanically necessary and transparent.
- A textual success message is a claim until durable identity is returned or independently observed.
- Same-content writes, branch protection behavior, stale-SHA behavior, and visibility delays are empirical API behavior. Do not invent them; report what the real endpoint/tool returned.
- Never infer success from local state when the requested authority is GitHub remote state.

## Verification contract

Verification must answer all applicable questions:

1. Does the resulting durable object exist?
2. Does its parent/base match the prepared baseline where that relation matters?
3. Does the intended ref point where expected?
4. Does reread show the intended bytes/state?
5. Does the diff contain only expected paths and changes?
6. Did any protected-branch, permission, CI, or merge gate remain unresolved?

A commit SHA without reread is `WRITE_EVIDENCED`, not `VERIFIED`.
A reread without scope comparison is `READ_BACK`, not `VERIFIED`.

## Final return

Use:

### FACTS
Observed source/ref/object identities and mutation evidence.

### CHANGES
Only changes that reached `VERIFIED`. If none did, say `none verified`.

### UNKNOWN
Anything not proven: unobserved propagation, missing gate, ambiguous attribution, unrun CI, or failed verification.

### NEXT
The cheapest discriminator needed to reach `VERIFIED`, or `none`.

## Failure handling

On failure, preserve:

- exact operation and target;
- returned status/error/evidence available from the tool;
- whether durable state changed;
- highest proven state-machine stage;
- cleanup/revert status if relevant;
- next cheapest discriminator.

Do not convert a diagnosis, attempted repair, local commit, or tool acknowledgement into a success claim.

## References

Read `references/evidence-model.md` when evidence levels or completion semantics are disputed.
Read `references/failure-catalog.md` when handling ambiguous or failed writes.
Use `tests/pressure-scenarios.md` to validate this skill against common rationalizations before changing its rules.
