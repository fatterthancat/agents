# Evidence Model

This reference defines the evidence ladder used by `github-forensic-mutation`.

1. **CLAIM** — an agent, human, wrapper, or UI says something happened.
2. **TRACE** — tool/API/command output records an attempted observation or action.
3. **ARTIFACT** — an addressable file, response, tree, test report, or other object has identity.
4. **DURABLE_CHANGE** — GitHub accepted a state change with durable remote identity such as a commit SHA, updated ref, issue/PR identifier, or equivalent.
5. **INDEPENDENT_VERIFICATION** — the authoritative remote is read again and the resulting state matches the intended delta.
6. **SURVIVAL** — later repository/product state still contains the change or explicitly preserves its lesson.

Never silently promote one level to the next.

For GitHub repository mutations, completion normally requires level 5. Level 4 proves a durable write occurred, but not that the intended ref/path now exposes exactly the expected state.

## Status vocabulary

- `VERIFIED` — independent read-back and scope verification succeeded.
- `PARTIAL` — some durable change is proven, but acceptance is incomplete.
- `FAILED` — the requested mutation or verification produced a contradictory observation.
- `NOT_RUN` — a required check was not executed.
- `UNKNOWN` — available evidence cannot establish the fact.

Absence of evidence is not negative evidence. Repeated reports derived from one source are not independent confirmation.
