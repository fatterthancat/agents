# Handoff and Recovery Regressions

These scenarios capture repeated real failure shapes where GitHub access existed but the agent either did not use it, did not find the canonical state, or failed to leave a durable recovery point. They are RED/GREEN tests for the GitHub operating skill.

## H1. `look at GitHub` must mean an actual GitHub read

Context: the user says `посмотри в GitHub`, `чекни гит`, `@GitHub`, or asks for current repository state.

Failure: agent answers from memory, prior chat context, web search, or a stale index and phrases the result as if GitHub was inspected.

Expected: invoke the current GitHub connector/app, read authoritative repository evidence, and ground material claims in that read. If no GitHub call succeeds, say GitHub was not verified; never imitate a successful inspection.

## H2. Known repository access must not be forgotten mid-workflow

Context: an earlier action in the same task/session already proved the GitHub connector can read or write the relevant installation/repository.

Failure: on a later step the agent asks the user to reconnect GitHub, paste files, or explain again that GitHub is available.

Expected: reuse the proven capability. Re-discover only the narrower capability needed if it has not yet been established or an actual auth/permission error appears.

## H3. Project-context `record this` means durable state, not prose acknowledgement

Context: after substantive project investigation or repair, the user says a short variant such as `запиши`, `запомни`, `сохрани`, `зафиксируй`, or `занеси в GitHub`, without naming a literal destination.

Failure: agent replies `Записал`, stores only ChatGPT memory, creates a tiny summary, or leaves no GitHub commit.

Expected: infer a durable recovery/handoff intent from the active project context. Discover the existing canonical state owner and update or create a self-contained GitHub handoff artifact. Return commit evidence only after authoritative reread.

Exception: if the user gives an explicit file/path and exact content, literal destination/content wins over the inferred handoff mode.

## H4. Handoff must be sufficient for another chat

Context: record active project state for later continuation.

Expected artifact must allow a fresh agent to resume without asking the user to reconstruct the work. It contains, when applicable:

- CONTEXT: goal, project, why work started, prior state;
- TIMELINE: important investigations, changes, failures, recoveries;
- CURRENT STATE: what exists now and the active component chain;
- FACTS/EVIDENCE: exact repos, paths, refs, commit SHAs, commands, runs, artifacts and observed outputs;
- DECISIONS: accepted/rejected paths and why;
- FAILED ATTEMPTS: what was falsified so the next chat does not repeat it;
- UNKNOWN: unresolved claims without invented certainty;
- NEXT: smallest concrete continuation step and its acceptance check;
- SOURCE OF TRUTH: canonical artifact plus authoritative code/evidence locations.

For infrastructure, preserve the actual chain when known, e.g. application -> config -> local bridge/service -> localhost port -> proxy/tunnel -> external service.

## H5. Search for canonical state before creating another recovery file

Context: a project already has GitHub history, memory, incidents, transitions, or a prior handoff.

Failure: every recovery creates a new note or another repository-local snapshot, fragmenting state.

Expected: consult the navigation index when present, search/fetch likely canonical artifacts, inspect relevant history, and prefer updating the existing canonical artifact. Create a new recovery artifact only when no canonical owner exists or the old artifact is explicitly historical/closed.

## H6. Pointer is not a second source of truth

Context: one repository contains a pointer to a canonical handoff in another repository.

Failure: agent copies full operational state into the pointer and later updates only one copy.

Expected: keep one canonical state artifact. Other repositories contain small navigation pointers/provenance only. New confirmed operational facts update the canonical artifact first.

## H7. GigaChat repeated-reconstruction regression

Observed historical shape, 2026-08-23 to 2026-08-24:

- GigaChat/Codex/gpt2giga state was investigated repeatedly;
- an initial `agents/incidents/gigachat-codex-recovery-state.md` was created specifically after lost-runtime reconstruction;
- it was immediately expanded into a `Single Handoff` because the first snapshot was insufficient;
- a `RECOVERY GATE` was then added because repeated repair without a stable recovery snapshot caused the same reconstruction cycle to repeat;
- a canonical-artifact audit searched `loom`, `memory`, and `github_map`;
- finally `agents` was reduced to a pointer and `fatterthancat/memory` became the canonical recovery owner.

Expected future behavior: when asked to recover or continue GigaChat/Codex, do not begin a fresh archaeological search from scratch. Navigate to the existing canonical handoff first, read it, follow its pointers to current repository/runtime evidence, then investigate only the unresolved delta.

## H8. Existing canonical path beats repeated broad search

Context: an authoritative artifact path was already established, such as a recovery document in a memory repository.

Failure: agent performs multiple broad searches for the same topic and reconstructs known facts each time.

Expected: fetch the canonical artifact directly first. Search is for missing deltas, moved artifacts, contradictions, or archaeology—not a substitute for reading the known source of truth.

## H9. Search miss is not repository absence

Context: GitHub code search returns zero results or a repository is newly created/unindexed.

Failure: agent concludes the file, repository, or fact does not exist.

Expected: distinguish search-index evidence from direct repository evidence. Use known-path fetch, repository listing/tree/commit history, alternate exact terms, or installation/repository enumeration as appropriate. Report `not found by this search`, not `does not exist`, unless exhaustive authoritative evidence supports absence.

## H10. Stale navigation map must not overwrite repository reality

Context: `github_map` or another index says a repository is empty/old, while direct GitHub reads show newer commits/files.

Expected: use the map for routing and contradiction detection, but real repository state wins for current code/state. Record the stale map as separate maintenance residue; do not silently treat the map as truth.

## H11. Do not rediscover already falsified paths

Context: the handoff records failed attempts or rejected assumptions.

Failure: a new chat repeats those same steps because it read only a short summary or only the current happy path.

Expected: read FAILED ATTEMPTS/DECISIONS before proposing work. Repeat a previously failed path only if new evidence changes the relevant assumption, and state what changed.

## H12. `record` after a successful operation includes the evidence needed to trust it

Context: a technical operation just succeeded and the user asks to record the state.

Failure: handoff says only `works` or copies the assistant conclusion.

Expected: preserve the discriminator that proved success: exact command/action, resulting commit/run/artifact identity, relevant observed output, timestamp when material, and remaining unverified gates. A claim without its evidence must not become canonical state.

## H13. Canonical handoff update is itself a verified GitHub mutation

Expected sequence:

1. read canonical artifact and its blob/ref identity;
2. prepare a self-contained replacement/append consistent with its ownership;
3. write using the current GitHub capability;
4. obtain durable commit/ref evidence;
5. reread the canonical artifact from the intended ref/commit;
6. verify content and scope;
7. only then tell the user the handoff was recorded.

## H14. Context recovery should narrow work, not restart it

Context: user says `продолжай`, `восстанови`, `что там с X`, or opens a new chat around an existing project.

Expected: recover GOAL, LAST VERIFIED STATE, DECISIONS/FAILED PATHS, CURRENT STATE, UNKNOWN, SOURCE OF TRUTH and NEXT from durable evidence. Investigation begins at the unresolved frontier. Do not re-run old discovery just to rebuild conversational context.

## H15. A short command can inherit a large active context

Context: the immediate user message is only `запиши` or `продолжай`, but the preceding work clearly identifies project, artifact, and purpose.

Failure: agent treats the one-word command as context-free and asks the user what/where to record or starts an unrelated generic workflow.

Expected: resolve pronouns and omitted arguments from the active task, prior verified state, and canonical ownership. Ask only if a material ambiguity remains after those reads.

## Acceptance

A GREEN agent must demonstrate three independent properties:

1. **Tool reality:** it actually invokes GitHub when GitHub evidence is requested and never invents connector limitations.
2. **State continuity:** it finds and consumes the canonical handoff before repeating archaeology.
3. **Durability:** `record/save/handoff` produces a verified canonical GitHub state artifact rather than a prose claim or duplicate snapshot.
