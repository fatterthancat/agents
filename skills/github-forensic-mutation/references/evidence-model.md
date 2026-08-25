# Evidence Model

This reference defines the evidence ladder and capability semantics used by `github-forensic-mutation`.

## Capability evidence

GitHub capability must be established from the current runtime, not remembered from an earlier chat.

Capability claims should be as narrow as the evidence:

1. **TOOL_SURFACE** — GitHub connector/app/tool is present in the current runtime.
2. **ACTION_SURFACE** — specific read/write/ref/commit/PR actions are discoverable.
3. **CALLABLE** — a relevant action passes local schema/tool validation and can be invoked.
4. **AUTHORIZED** — an external GitHub call demonstrates the required account/repository permission.
5. **EVIDENCE_QUALITY** — the action returns enough identity/state to support the requested verification, or an independent read path exists.

Do not collapse these into a boolean `has GitHub / no GitHub` claim.

A missing action in the currently loaded subset is not evidence that the connector lacks that capability if action discovery is available.
A local schema error is not evidence of GitHub authorization failure.
An authorization failure for one repository/action is not evidence that all GitHub access is absent.

## Mutation evidence ladder

1. **CLAIM** — an agent, human, wrapper, or UI says something happened.
2. **TRACE** — tool/API/command output records an attempted observation or action.
3. **ARTIFACT** — an addressable file, response, tree, test report, or other object has identity.
4. **DURABLE_CHANGE** — GitHub accepted a state change with durable remote identity such as a commit SHA, updated ref, issue/PR identifier, or equivalent.
5. **INDEPENDENT_VERIFICATION** — the authoritative remote is read again and the resulting state matches the intended delta and scope.
6. **SURVIVAL** — later repository/product state still contains the change or explicitly preserves its lesson.

Never silently promote one level to the next.

For GitHub repository mutations, completion normally requires level 5. Level 4 proves a durable write occurred, but not that the intended ref/path now exposes exactly the expected state.

## Failure boundary

Use three distinct mutation failure classes:

- `PRECALL_FAILURE` — runtime/tool validation proves no external mutation request was sent.
- `REMOTE_WRITE_ERROR` — a remote response establishes a definite rejection/no requested durable change.
- `UNKNOWN_MUTATION_STATE` — the external write may have been sent or accepted, but available response evidence cannot establish final remote state.

This distinction controls retry safety. A PRECALL_FAILURE can be corrected without risking duplicate remote mutation. UNKNOWN_MUTATION_STATE requires authoritative reread before another write attempt.

## Status vocabulary

- `VERIFIED` — independent read-back and scope verification succeeded.
- `PARTIAL` — some durable change is proven, but acceptance is incomplete.
- `FAILED` — the requested mutation or verification produced a contradictory observation.
- `NOT_RUN` — a required check was not executed.
- `UNKNOWN` — available evidence cannot establish the fact.

Absence of evidence is not negative evidence. Repeated reports derived from one source are not independent confirmation. Historical connector behavior is not current runtime capability evidence.
