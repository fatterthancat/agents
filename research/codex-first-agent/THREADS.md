# Thread and case index

The IDs are shortened only for display. Counts come from typed runtime items, not estimates.

## Substantive threads in the requested three-repository scope

| Thread | Turns | Commands | Changes | Test-like commands | Git-like commands | Outcome |
|---|---:|---:|---:|---:|---:|---|
| `019ffc92…` | 16 | 247 | 87 | 53 | 105 | Council R1B/hardening repairs; commits resolve in Git |
| `01a0011f…` | 2 | 31 | 23 | 10 | 1 | lora dataset generator repaired; quantitative safety gate passed |
| `01a0014a…` | 15 | 211 | 60 | 94 | 22 | lora training/optimizer work after SSH interruption |
| `01a002a5…` | 8 | 167 | 52 | 37 | 5 | lora/cognitive/hardware investigation and repair work |
| `01a005b5…` | 1 | 43 | 5 | 3 | 34 | lora source sync pushed and re-fetched; Council audited read-only |
| `01a00637…` | 4 | 137 | 0 | 0 | 31 | tmux disappearance forensic; intentionally no mutation |
| `01a006da…` | 13 | 466 | 222 | 138 | 171 | Council foundation audit plus runtime slices 01–07 |
| `01a00804…` | 6 | 104 | 27 | 18 | 34 | Council Slice 08; partial physical invocation, wrong mode reverted |

## Retained threads outside or below scope

| Class | Threads | Treatment |
|---|---|---|
| Repository orientation / casual queries | `019ffc6e…`, `019ffc7f…` | Context only; no substantive changes |
| Explicit exit | `01a006a9…` | No work |
| Mario Gamma | `01a025b5…` | Substantive but outside the three requested repositories |
| Repository-path probe | `01a02dcf…` | Canary; no typed commands retained |
| Environment/status probes | `01a02f5f…`, `01a02fd2…` | Canary; no changes |
| RIDGE_RACER canaries | `01a02f74…` plus six projection-only threads | Completeness/projection evidence only |

## Commit map

### lora

The decisive sync thread maps to:

- `611ae839` — ignore generated/local training artifacts;
- `28b7879c` — add 59 source/document/fixture files;
- remote push output showed `edc6b93..28b7879 main -> main`;
- a subsequent fetch showed local and remote heads equal with relation `0/0`;
- current GitHub main remains a descendant.

### Council R1B and pre-Qwen repair loop

The main repair chain includes:

- `850f8436` — restrict Bubblewrap to allowlisted filesystem/environment;
- `207ae5b3` — execute the bound tokenizer during preflight;
- `b02a8463` — bind model execution to verified descriptors;
- `b860e171` — reject impossible finding envelopes;
- `551211bb` — reject reads of completed sources;
- `b4a7ce09` — constrain reads to incomplete sources.

These are confirmed historical commits. Their later functionality was largely removed by the current-main collapse; their experimental lessons remain evidence.

### Council runtime slices 01–07

| Slice | Commits | Capability added |
|---|---|---|
| 01 | `ac5db8f` | durable task control plane |
| 02 | `6f11fc6` | durable step lifecycle |
| 03 | `2bf4a93`, `6d00a80` | local worker and owned worktrees |
| 04 | `6e5705f`, `80727f6`, `606d333` | planning, typed execution, coding task E2E |
| 05 | `f5f7bd9`, `5effa36`, `01520ed` | supervisor contracts, continuation, operations |
| 06 | `e4ab06f`, `5dce220`, `9e07c01` | host placement and remote execution |
| 07 | `205cc89`, `a93cddc`, `6321a24` | pinned and immutable remote releases |

All are ancestors of current main through `6321a24`; most implementation was then deleted or collapsed.

### Council Slice 08

- `0787af0` — pinned remote llama deployment;
- `08c045c` — bounded gpt-oss reasoning output;
- `2f5ffc6` — attempted `--no-conversation` JSON mode;
- `d5fd42a` — reverted that attempt.

The branch diverges from current main at `6321a24`. No retained commit proves the later `--skip-chat-parsing` diagnosis was implemented.

### Loom

There is no direct thread-to-commit mapping in the supplied Codex corpus. Git-only chronology:

- `4f285f86` recorded Codex as a high-priority donor;
- current main is 28 commits ahead and zero behind that commit;
- the current donor note replaces internal-runtime copying with an external-harness boundary;
- current README/architecture retain provenance, evidence, recoverability and mutate-before-invent while rejecting a Loom-owned agent runtime.

## Verification limits

- Fresh local test runs were attempted against all three archived worktrees, but the analysis environment has no `pytest`; all three stopped before project tests executed. This is **NOT_RUN**, not a test failure.
- Historical test outcomes are retained command evidence, not independently reproduced in this environment.
- The supplied archive does not prove corpus completeness.
- Loom attribution is UNKNOWN even though its Git evolution is CONFIRMED.
