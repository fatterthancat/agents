# Minimal protocol v0

This is the smallest protocol supported repeatedly by the retained evidence. It describes a replaceable external worker boundary; it is not a new agent runtime or a mandatory giant task schema.

## 1. Handoff

A task needs five things. Natural language is sufficient if they are unambiguous.

1. **Intent** — the observable outcome, not a component wish list.
2. **Source lock** — authoritative repo/path/ref and the state actually read.
3. **Authority** — what may be read, changed, committed, pushed or externally acted on.
4. **Constraints** — forbidden actions, data boundaries and stop/escalation conditions.
5. **Acceptance** — the cheapest observation that discriminates success from a plausible fake.

Do not ask the user to fill a large envelope when the worker can derive these fields safely. The worker must echo material assumptions before mutation.

## 2. Work loop

```text
ORIENT -> TRY -> OBSERVE -> REPAIR OR STOP -> VERIFY -> RECORD
```

- **ORIENT:** read repo instructions, status, source identity, nearby working systems and existing artifacts.
- **TRY:** make the smallest reversible change or run the smallest physical discriminator.
- **OBSERVE:** preserve command, exit status and relevant output; separate observation from interpretation.
- **REPAIR OR STOP:** change one falsified assumption at a time. Stop on lost authority, destructive ambiguity, secret exposure or architectural expansion.
- **VERIFY:** run focused tests, then the appropriate broader/physical gate. After a remote write, read the remote again.
- **RECORD:** leave coherent commits/artifacts and a checkpoint another worker can continue from.

## 3. Evidence record

Every meaningful work unit returns:

| Field | Minimum content |
|---|---|
| Source | repo/path plus base ref or content hash |
| Actions | commands/tools that materially changed or tested state |
| Delta | files/artifacts/commits created or changed |
| Verification | exact test/run/remote observation and result |
| Outcome | `CONFIRMED`, `PARTIAL`, `FAILED`, `NOT_RUN` or `UNKNOWN` |
| Residue | failure artifact, rejected assumption and next discriminator |
| Fate | initially `UNKNOWN`; later archaeology may mark survived, modified, reverted, deleted or superseded |

Use links/hashes instead of copying an entire transcript. Keep raw traces private when they contain credentials, local paths or unrelated content.

## 4. Evidence levels

1. **Claim** — model/human assertion.
2. **Trace** — command or tool output.
3. **Artifact** — file, test report, manifest or physical run output with identity.
4. **Durable change** — commit or authoritative-system update.
5. **Independent verification** — re-read remote, CI, physical acceptance or another authoritative observer.
6. **Survival** — later repository/product state still uses the change or explicitly preserves its lesson.

Report the highest attained level. Never silently promote one level to the next.

## 5. Failure rule

A useful failure must leave:

- the exact failed observation;
- the assumption it falsified;
- whether any state changed;
- cleanup/revert status;
- the next cheapest discriminator.

If those are absent, the work mostly produced noise. A quick revert with a retained explanation is a successful recovery action, not a completed original task.

## 6. Ownership rule

Before adding infrastructure, ask in order:

1. Which existing system already owns this fact or capability?
2. What mature end-to-end system can be used as-is?
3. Can configuration or a small adapter close the demonstrated gap?
4. Only then: what minimal new mechanism is unavoidable?

Git owns bytes/history, test runners own mechanical results, physical artifacts own experiment outcomes, Loom owns project continuity, and the external harness owns its execution mechanics. `agents` owns only this portable boundary and its accumulated evidence.

## 7. Stop conditions

Stop and request direction when:

- target/ref/authority is ambiguous and mutation would matter;
- the next action expands project ownership rather than closing the task;
- secrets or private raw traces would need publication;
- verification would require inventing results or silently changing the environment;
- a physical acceptance gate cannot be run;
- the repository contradicts the task premise.

Stopping must still produce the evidence record and next discriminator.

## 8. Compact return format

```markdown
FACTS
- source/ref read
- observations and confidence

CHANGES
- files/artifacts/commits/external writes

VERIFICATION
- exact checks and authoritative re-read

UNKNOWN
- attribution, unrun gates, unresolved conflicts

NEXT
- one cheapest discriminator or `none`
```

## 9. Anti-patterns rejected by the evidence

- building an agent platform inside every project;
- treating a transcript as the canonical project state;
- requiring one fixed model/provider/topology;
- equating unit tests with physical acceptance;
- claiming success from a local commit without remote verification;
- publishing raw forensic archives;
- treating work superseded by an owner decision as an agent execution failure;
- preserving superseded complexity merely because it was expensive;
- designing from components before trying the nearest working system.

## 10. Protocol status

`v0` is a research conclusion, not a stable standard. Promote it only after using it on new bounded tasks with at least two different harnesses and recording where it is insufficient.
