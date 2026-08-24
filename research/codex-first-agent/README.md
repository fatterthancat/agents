# Codex First-Agent Forensics

Status: **EVIDENCE PASS COMPLETE — PROTOCOL v0 DERIVED**

This investigation reconstructs retained Codex work across `lora`, `loom` and `council-memory-first` and uses later Git history to separate execution success from long-term product survival.

## Outputs

- [`REPORT.md`](REPORT.md) — synthesis, evidence locks and principal findings.
- [`THREADS.md`](THREADS.md) — analyzable thread inventory and thread-to-commit map.
- [`CASES.md`](CASES.md) — end-to-end cases, failures, recovery and attribution limits.
- [`PROTOCOL.md`](PROTOCOL.md) — minimal evidence-backed external-worker protocol v0.

## Research question

Which minimal agent primitives earned their place through observed work across multiple projects?

The required evidence chain is:

```text
operator task
-> Codex turn and tool activity
-> filesystem change / command result
-> test or other verification
-> Git commit, tree, CI run, or durable artifact
-> later repository state
```

An agent statement is not proof. A later owner-level architecture change is not retroactive proof that the agent failed to implement the earlier task.

## Source locks

- Supplied archive: `codex-forensics-final.tar.gz`.
- SHA-256: `1c4ae0d30969ddd1511f2d8abcde6029c5cafc3abf32c589c1b0c8de5149f685`.
- `history.jsonl`: 101 records and 16 session IDs.
- runtime DB: 22 thread IDs, 96 turns and 5,690 typed items.
- item inventory: 1,481 command executions, 359 file changes, 805 agent messages, 101 user messages, 53 web searches, 28 MCP calls and 21 context compactions.
- log projection: 30,933 rows and 75 distinct non-null thread IDs.

The count differences are a corpus-completeness boundary, not an error to hide. Six late canary threads exist only in projections.

## Repository time boundaries

| Repository | Supplied snapshot | Current GitHub state checked | Finding |
|---|---|---|---|
| `lora` | `main@5d86d35` | same | Codex sync commits survive on main |
| `loom` | branch `issue-8-bounded-gigachat@11f90f9`; archived main older | `main@349286b` | Git evolution confirmed; no matching retained Codex thread |
| `council-memory-first` | `main@08e7068` | `main@e6ffbe82` | runtime slices entered main, then owner revised architecture; Slice 08 diverged |

## Evidence labels

- **CONFIRMED** — direct command/file/Git/current-repository support.
- **INFERRED** — interpretation joining confirmed observations.
- **UNKNOWN** — absent or insufficient, including Loom thread attribution.
- **CONFLICT** — incompatible states that require explicit ref/time boundaries.
- **NOT_RUN** — verification could not execute; never rewritten as a project test failure.

## Principal conclusion

The evidence does not justify another monolithic agent framework. It supports a replaceable external worker with a precise handoff, bounded authority, reversible execution, observable acceptance, an evidence record and an independently readable checkpoint.

Loom owns continuity around work. Council Lab owns experiments about how work is executed. Git, tests and physical artifacts own their respective facts. `agents` should own only the portable boundary and accumulated evidence.

## Data boundary

The raw forensic archive is not published. It contains runtime configuration, local paths, logs and potentially sensitive material. Public reports use hashes, Git objects, aggregated counts and minimal redacted observations.
