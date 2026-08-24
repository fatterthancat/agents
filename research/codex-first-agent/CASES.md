# Confirmed cases, failures and recovery

## Case A — Recovering lora from a non-Git working body

**Envelope.** Recover actual local Disco state, compare it with GitHub, publish only justified source changes, and audit Council without writing it.

**Observed loop.** The agent inventoried the local tree, compared it with a temporary remote clone, excluded datasets/runs/checkpoints, scanned staged content for secrets and large blobs, created an ignore-policy commit and a separate source commit, pushed, fetched again and checked ancestry/divergence.

**Result.** 60 files and 14,079 insertions across two commits. The second commit contains 59 files and 14,046 insertions. Remote verification showed the exact expected head. Current lora main is still descended from it.

**Why it matters.** This is the complete chain `thread -> commands -> changes -> commits -> remote write -> remote re-read -> later survival`.

**Protocol lesson.** A write is not complete until the authoritative remote is re-read. Bulk local output must be classified before Git staging, not cleaned up after accidental publication.

## Case B — Dataset repair after wrong assumptions

**Envelope.** Make the multipath LoRA dataset generator safe against leakage and structural corruption.

**Failures.** Initial Git commands assumed the dataset directory was a repository. A generator invocation used an incorrect path containing `disco el`. Both failed before durable damage.

**Recovery.** The agent corrected location assumptions, ran the generator and its checker, and recorded quantitative gates: 38,844 examples, 14,846 skill nodes, no exact duplicates, no target/node leakage, no repeated context nodes, structure clean, PASS.

**Fate.** Raw output (~130 MB) stayed outside Git. Source generators/checkers and small reproducibility artifacts were later imported by Case A and remain on current main.

**Protocol lesson.** Failed preconditions should become explicit checks. Publish reproducibility machinery, hashes and small fixtures; do not confuse generated evidence with source.

## Case C — Council hardening through one-discriminator repairs

**Envelope.** Continue a repo-native handoff and repair the real R1B/pre-Qwen path rather than redesigning it.

**Observed loop.** Repeated failures were narrowed to filesystem/environment exposure, tokenizer boundary, unverified model descriptors, impossible output envelopes and invalid source traversal. Each discriminator became a small commit with focused tests.

**Fate.** The commits entered repository history. Most of their surrounding runtime was later removed when Council was re-scoped.

**Protocol lesson.** A failed run is useful when it produces one falsified assumption, one next discriminator and one durable regression check. Local correctness does not grant permanent product relevance.

## Case D — Seven Council runtime slices

**Envelope.** Build the shortest durable Codex-like path in bounded slices, with per-slice tests and commits.

**Observed loop.** The agent built task/step durability, workers, worktrees, planning/execution, supervisor recovery, remote execution and immutable releases. Typed history records 466 command executions, 222 file-change items, 138 test-like commands and 171 Git-like commands in the main thread.

**Immediate result.** Each slice reached a named commit and the chain entered main through `6321a24`.

**Later fate.** Current main descends from the chain but subsequently removed most runtime code, workflows, specs and tests. The project now says to treat the historical body as donor/evidence and avoid building a new execution framework before testing a mature working system.

**Attribution.** The evidence supports successful agent execution of the requested slices. The later architectural reversal was made by the project owner; it must not be back-projected as an agent failure or as proof that Codex selected the architecture.

**Protocol lesson.** Implementation quality and product-direction survival are separate axes. A later owner decision can supersede correct work; archaeology must record both facts without assigning the redesign retroactively to the worker.

## Case E — Slice 08 and the value of a revert

**Envelope.** Make a first real Council physical model invocation and acceptance pass.

**Observed failure.** `--no-conversation` was proposed to force grammar-bound JSON, committed, then found incorrect and reverted. The likely correct llama.cpp discriminator became `--skip-chat-parsing`, but no retained commit closes it.

**Fate.** The branch diverged from main and the acceptance goal remains unproven.

**Protocol lesson.** Revert quickly when the physical system contradicts the implementation. Mark the task partial rather than converting a diagnosis into a success claim.

## Case F — Loom moves Codex outside its boundary

**Evidence type.** Git evolution only; no matching Codex runtime thread was retained.

**Observed decision.** Loom moved from cataloguing Codex internals as donor candidates to treating Codex/OpenCode as external work harnesses. Loom accepts intent/context out and outcome/artifacts/evidence back. It explicitly does not own the harness loop, sandbox, worktrees, subagents or provider lifecycle.

**Protocol lesson.** `agents` should standardize the boundary and evidence, not recreate the executor. The worker must remain replaceable.

## Failure catalogue

| Failure class | Confirmed example | Required residue |
|---|---|---|
| Wrong location/state assumption | Dataset path and non-Git directory | corrected source identity |
| Interrupted host/session | SSH and tmux investigations | distinguish process death, UI loss and durable artifacts |
| Tool/runtime mismatch | llama.cpp chat parsing versus grammar completion | exact failing command, version/interface discriminator |
| Owner-level architecture revision | Council runtime later collapsed after successful implementation | preserve both execution evidence and the later owner's rationale |
| Attribution gap | no Loom-specific Codex thread | UNKNOWN, never inferred authorship |
| Verification-environment gap | no `pytest` in current forensic environment | NOT_RUN, never “tests failed” |
| Projection/corpus mismatch | 22 indexed threads versus 75 log thread IDs | explicit completeness boundary |

## What does not count as proof

- an agent saying it finished;
- a file-change event without the resulting bytes or Git state;
- a passing unit test standing in for a physical external-system test;
- a local commit standing in for a remote write;
- a historical commit standing in for current product direction;
- a repository mention standing in for thread attribution;
- a diagnosis standing in for an implemented and verified repair.
