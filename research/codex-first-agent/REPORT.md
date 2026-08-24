# Archaeology of the first agent

Status: evidence pass complete for the supplied corpus; protocol derived below.

## Question

What did the retained Codex sessions actually do, which results became durable Git history, what survived later project decisions, and what is the smallest useful protocol for `agents`?

This report treats a model statement as a claim, a command result as run evidence, a commit as durable change evidence, and the later repository state as survival evidence. These layers are not interchangeable.

## Evidence lock

- Supplied archive SHA-256: `1c4ae0d30969ddd1511f2d8abcde6029c5cafc3abf32c589c1b0c8de5149f685`.
- Runtime database: 22 indexed threads, 96 turns, 5,690 typed items.
- Typed items include 1,481 command executions, 359 file changes, 805 agent messages, 101 user messages, 53 web searches and 28 MCP calls.
- A second log projection contains 75 distinct non-null thread IDs. Six late `RIDGE_RACER_READY` canaries exist only in projections. Therefore 22 is the analyzable thread set, not a claim that every historical session was preserved.
- Git snapshots were locked at `lora@5d86d35`, `loom` branch `issue-8-bounded-gigachat@11f90f9` with an older local `main@bd4a182`, and `council-memory-first@08e7068`. Current GitHub heads were then checked independently: `lora@5d86d35`, `loom@349286b`, and `council-memory-first@e6ffbe82`.
- Raw session databases, local paths, configuration and unredacted messages are intentionally not published.

## Main findings

### 1. Codex was effective when the work boundary was concrete

The retained sessions show long, tool-heavy execution: dataset repair, environment and training work, Git drift recovery, repository implementation slices, sandbox hardening and physical model-invocation attempts. The strongest completed work had an exact source state, a named goal, explicit forbidden actions, observable acceptance tests and permission to continue through repair loops.

This is not proof of a generally autonomous agent. Many Council tasks were tightly operator-shaped, and in Slice 08 the operator eventually supplied the decisive llama.cpp flag. It is proof that a coding harness can carry a bounded task across inspection, edits, tests, commits and remote verification.

### 2. `lora` is the strongest end-to-end survival case

Thread `01a005b5…` recovered a non-Git local working body, compared it with `fatterthancat/lora`, selected source rather than generated datasets/runs, checked secrets and large blobs, made two commits, pushed them, fetched again, and verified zero local/remote divergence.

- [`611ae839`](https://github.com/fatterthancat/lora/commit/611ae839928c3ea8eb669fcae33201299dcbb70e) isolates local/generated artifacts in `.gitignore`.
- [`28b7879c`](https://github.com/fatterthancat/lora/commit/28b7879ce90e8ca3e264e31c94f1ccc981372b78) adds the Disco training and cognitive runtime sources.
- Current `main@5d86d35` is two commits ahead and zero behind `28b7879c`; the merge base is exactly `28b7879c`.

The earlier dataset session also left quantitative gates: 38,844 examples, 14,846 skill nodes, zero exact duplicates, zero target/node leakage, zero repeated context nodes and a passing structural gate. Generated data stayed outside Git while the generator, checks, fixtures and runtime sources later entered Git. That boundary survived.

### 3. Council proves execution depth; its later removal was an owner-level architecture decision

Thread `019ffc92…` produced a sequence of narrow hardening commits: Bubblewrap allowlists, tokenizer execution in preflight, verified model descriptors, impossible-envelope rejection and completed/incomplete source-read constraints. Thread `01a006da…` then produced seven durable runtime slices from task/step control through local and remote workers, worktrees, typed model execution, supervisor continuation and immutable releases.

The last slice commit [`6321a242`](https://github.com/fatterthancat/council-memory-first/commit/6321a242c9a582808583ad873756ba3a3cc4d0a0) is an ancestor of current `main`. The owner later reconsidered the architecture and the ten subsequent commits removed most of the runtime, tests, specs and workflows while redefining the repository as Council Lab. The retained evidence does not attribute that earlier architectural choice to Codex: the agent implemented the task it was given, and the implementation reached main. Most of that implementation later ceased to be the owner's chosen product direction. Current README explicitly keeps the historical body as donor/evidence, not as an active architecture requirement.

This is a confirmed distinction:

- implementation success: yes;
- integration into main: yes for slices 01–07;
- long-term architectural survival after the owner's redesign: mostly no;
- informational value: yes, as evidence and donor material.

### 4. Slice 08 is a clean failed-experiment record

Thread `01a00804…` added pinned remote llama deployment and bounded gpt-oss reasoning. It then tried `--no-conversation` to force JSON completion and immediately reverted it in [`d5fd42a`](https://github.com/fatterthancat/council-memory-first/commit/d5fd42a5f021279eedd1b73d9a5e5ac329ee4acc). The thread diagnosed `--skip-chat-parsing` as the likely correct discriminator, but the supplied Git record contains no follow-up implementation.

The Slice 08 branch and current `main` diverge at `6321a242`: current main is 10 commits ahead while the branch is 4 commits on the other side. Therefore the physical acceptance goal was not completed in the retained evidence. The failure is still valuable because it eliminated a wrong interface assumption without contaminating main.

### 5. Loom records a later boundary correction, not a retained Codex execution thread

No Loom-specific Codex thread is present in the supplied runtime corpus: searches found no `gpt2giga`, `CODEX-DONOR` or `fatterthancat/loom` task body. Attribution of Loom code changes to these Codex threads is therefore UNKNOWN.

Git history independently confirms that Loom once recorded Codex as a high-priority donor in [`4f285f86`](https://github.com/fatterthancat/loom/commit/4f285f86e9d591484bc3ddcef99348211bf1003d), and current main descends from it by 28 commits. But `docs/CODEX-DONOR.md` now supersedes the donor-first runtime plan: Codex/OpenCode are external harnesses; Loom owns continuity around work, not their agent loop, shell, sandbox, worktrees, subagents or providers.

The durable idea was not “copy Codex”. It was “use a working harness, preserve artifacts/evidence, and own only the demonstrated seam”.

## What repeated across confirmed cases

| Primitive | Confirmed effect | Counterexample or limit |
|---|---|---|
| Lock source identity | Prevented work on an imagined state | Local/archive branch names were sometimes stale |
| State authority and forbidden actions | Kept Council read-only during the lora sync audit | The owner later changed Council's product boundary |
| Inspect before mutate | Recovered real local work and avoided rebuilding completed outputs | A wrong local path still caused an early dataset failure |
| Small discriminating test | Turned failures into specific repairs | Slice 08 stopped before the diagnosed flag was committed |
| Separate generated/private data from source | Allowed reproducible code to survive without publishing bulky or sensitive state | Absolute local paths entered some source manifests and remain technical debt |
| Commit in coherent units | Made ignore policy and source import independently auditable | A correct implementation can later be superseded by an owner decision |
| Re-read remote after write | Proved the lora push actually landed | A local success report alone cannot prove this |
| Preserve negative evidence | Wrong llama mode was reverted and remains inspectable | Failure logs without a decision or next discriminator are mostly noise |
| Mutate a working system before invention | Became a law in all three current repositories | It is a direction derived after expensive overbuilding, not an early invariant |

## Conclusion

The “first agent” is not a new monolithic runtime. The evidence supports a thinner object: a bounded external worker operating against authoritative project systems, leaving a compact evidence chain and a recoverable checkpoint. Loom owns continuity, Council Lab owns experiments about execution, Git/test systems own mechanics, and `agents` should encode the minimal handoff/evidence protocol between them.

## Confidence labels

- **CONFIRMED**: supported by retained command output plus Git/GitHub state, or by direct current repository content.
- **INFERRED**: interpretation joining multiple confirmed facts.
- **UNKNOWN**: absent or insufficient attribution, especially Loom-to-thread identity and unretained sessions.
- **CONFLICT**: competing source states are named with their time/ref rather than silently resolved.
