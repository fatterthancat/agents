# Evidence Model

This reference defines capability, read, continuity, and mutation evidence for `github-operating-protocol`.

## Capability evidence

GitHub capability must be established from the current runtime, not remembered from an earlier chat.

1. **TOOL_SURFACE** — GitHub connector/app/tool is present.
2. **ACTION_SURFACE** — relevant read/write/ref/commit/PR actions are discoverable.
3. **CALLABLE** — a relevant action passes local schema/tool validation and can be invoked.
4. **AUTHORIZED** — an external GitHub call demonstrates required repository/action permission.
5. **EVIDENCE_QUALITY** — the action returns enough identity/state for the requested verification, or an independent read path exists.

Do not collapse these into a boolean `has GitHub / no GitHub` claim. Missing one action, local schema failure, or one repository denial does not prove global unavailability.

## Read evidence

1. **REMEMBERED_CLAIM** — model/chat memory says something about GitHub.
2. **NAVIGATION_EVIDENCE** — map/index/search result points toward a repository/artifact.
3. **AUTHORITATIVE_READ** — repository file/ref/commit/issue/PR/run was actually fetched from GitHub.
4. **CROSS_CHECKED_STATE** — current authoritative read is reconciled with the relevant map, canonical handoff, history, or second source where contradiction risk matters.

A response must not say or imply `I checked GitHub` at levels 1-2.
A search miss is navigation/search evidence, not authoritative proof of absence.

## Continuity evidence

1. **CHAT_SUMMARY** — conversational description only.
2. **DURABLE_NOTE** — a GitHub artifact exists but may not be self-contained or canonical.
3. **CANONICAL_HANDOFF** — the established state owner contains enough context/evidence/unknowns/next step for another agent to resume.
4. **HANDOFF_VERIFIED** — canonical artifact mutation was independently re-read and scope-verified.
5. **REENTRY_PROVEN** — a later fresh agent actually resumes from the handoff without reconstructing the prior state.

Do not call a short GitHub note a successful handoff merely because it is durable.

## Mutation evidence ladder

1. **CLAIM** — an agent, human, wrapper, or UI says something happened.
2. **TRACE** — tool/API/command output records an attempted observation/action.
3. **ARTIFACT** — an addressable object has identity.
4. **DURABLE_CHANGE** — GitHub accepted a state change with durable remote identity such as a commit SHA, ref, issue/PR identifier, or equivalent.
5. **INDEPENDENT_VERIFICATION** — authoritative remote is read again and resulting state matches intended delta and scope.
6. **SURVIVAL** — later repository/product state still contains the change or preserves its lesson.

Never silently promote one level to the next. Repository mutation completion normally requires level 5.

## Failure boundary

- `PRECALL_FAILURE` — runtime/schema/tool validation proves no external mutation request was sent.
- `REMOTE_WRITE_ERROR` — a remote response establishes a definite rejection/no requested durable change.
- `UNKNOWN_MUTATION_STATE` — external write may have been sent/accepted but evidence cannot establish final remote state.

This distinction controls retry safety. Correct PRECALL failures normally. Do not retry UNKNOWN_MUTATION_STATE before authoritative reread.

## Status vocabulary

- `VERIFIED` — required authoritative read-back/scope verification succeeded.
- `PARTIAL` — some durable/evidential state is proven but acceptance is incomplete.
- `FAILED` — requested result contradicts observed evidence.
- `NOT_RUN` — required check was not executed.
- `UNKNOWN` — available evidence cannot establish the fact.

Absence of evidence is not negative evidence. Repeated reports derived from one source are not independent confirmation. Historical connector behavior is not current runtime capability evidence.