# Codex First-Agent Forensics

Status: **IN PROGRESS**

This investigation treats the user's real OpenAI Codex work history as the first
agent donor for `fatterthancat/agents`.

The objective is not to design a framework from first principles. The objective
is to reconstruct what actually happened, distinguish operator discipline from
agent behavior and runtime capability, and retain only patterns supported by
repeatable evidence.

## Research question

Which minimal agent primitives earned their place through observed work across
multiple projects?

The required evidence chain is:

```text
operator task
  -> Codex turn and tool activity
  -> filesystem change / command result
  -> test or other verification
  -> Git commit, tree, PR, issue, CI run, or durable artifact
  -> later repository state
```

An agent statement is not proof that an action succeeded.

## Source locks

### Uploaded forensic corpus

- Archive: `codex-forensics-final.tar.gz`
- SHA-256: `1c4ae0d30969ddd1511f2d8abcde6029c5cafc3abf32c589c1b0c8de5149f685`
- `history.jsonl`: 101 records, 16 session ids
- `thread_history_1.sqlite`: 22 thread ids, 96 turns, 5,690 items
- Item inventory:
  - 101 user messages
  - 805 agent messages
  - 2,835 reasoning items
  - 1,481 command executions
  - 359 file changes
  - 53 web searches
  - 28 MCP tool calls
  - 21 context compactions
  - 6 image views
- `logs_2.sqlite`: 30,933 log rows and 75 non-null thread ids

The difference between history sessions, projected threads, and log thread ids
must be reconciled. None of these counts is currently treated as a completeness
claim.

### Repository snapshots inside the corpus

| Repository | Snapshot ref | Current GitHub ref at investigation start | Boundary |
|---|---|---|---|
| `fatterthancat/lora` | `main@5d86d35d8014f6c42461f9d67569127b2b0c4347` | same | Direct snapshot/current comparison is available |
| `fatterthancat/loom` | `issue-8-bounded-gigachat@11f90f9174ea12a046eddf72d13f21ef41386500` | `main@349286b3c98a9aa1aa260f1afde472ad9019ec70` | Different branch and later repository state; do not collapse them |
| `fatterthancat/council-memory-first` | `main@08e7068f01153211d4c602291aec753b5232dbd9` | `main@e6ffbe82ea5016b3b9c69a11497e7bf92ee4ec52` | Historical snapshot must be compared through Git history |

### Navigation and destination state

- `fatterthancat/agents@ba7b433b16be74769380588f2518561075d1f44b`
  at investigation start.
- `fatterthancat/github_map@ed999b3552f8cf595a1d6eb6bfc7d05202d2e243`
  at investigation start.
- `fatterthancat/memory@e0b92da71212afa7a2d0f2e63dc16375611d76d9`
  at investigation start.

The current `github_map/repos/agents.md` still classifies `agents` as empty,
while the repository now contains an initial README and commit history. This is
a confirmed map/repository conflict, not evidence about agent behavior.

## Evidence classes

- **CONFIRMED**: directly supported by commands, file changes, tests, Git
  objects, CI, issues/PRs, or a durable artifact.
- **INFERRED**: a candidate explanation or cross-case pattern.
- **UNKNOWN**: not checked, absent, irreconcilable, or not provable from the
  retained evidence.
- **CONFLICT**: sources describe incompatible states and neither may be silently
  preferred without resolving time/ref boundaries.

Negative results and operator corrections are retained as evidence.

## Workstream

1. Reconcile session/thread/log identities and establish a stable case index.
2. Reconstruct each selected case from operator task through durable outcome.
3. Validate Codex claims against command results, file changes, tests, Git
   history, and later repository state.
4. Classify every useful mechanism as:
   - operator task-contract discipline;
   - agent behavior;
   - OpenAI/Codex runtime capability;
   - project/tool capability.
5. Extract repeated successes, repeated failures, recovery behavior, and stop
   conditions.
6. Compare patterns across at least `lora`, `loom`, and
   `council-memory-first`; a single-project observation cannot become a
   general agent primitive.
7. Produce a minimal candidate protocol only after the cross-case comparison.

Candidate envelope fields to test, not assume:

```yaml
task:
context:
authority:
constraints:
actions:
verification:
artifacts:
unknowns:
```

## Planned outputs

- A case index with source locks and outcome classifications.
- End-to-end case reconstructions with claim-to-evidence links.
- A failure and recovery catalogue.
- A comparison of operator, agent, runtime, and project responsibilities.
- A minimal evidence-backed agent protocol v0.
- Explicit rejected ideas and unresolved unknowns.

No `agent.py`, orchestration framework, RAG layer, router, or swarm is
authorized by this investigation alone.

## Data handling boundary

The raw Codex archive is evidence, not a public project artifact. Runtime
configuration, local paths, logs, and possible credentials must not be copied
into this public repository without a separate redaction and publication
decision.

Derived reports should cite hashes, repository objects, and minimal excerpts
needed to reproduce a finding.
