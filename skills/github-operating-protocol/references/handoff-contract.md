# Durable Handoff Contract

A handoff is successful when a fresh chat/agent can continue the project from durable evidence without requiring the user to reconstruct prior work.

## When to infer handoff intent

In active project context, short commands such as `запиши`, `запомни`, `сохрани`, `зафиксируй`, or `занеси в GitHub` normally mean: preserve the state needed for continuation.

Do not infer this when the user explicitly names a destination/path and literal content; the explicit mutation wins.

Before creating a new artifact, find whether the project already has a canonical state/memory/handoff owner. Update it instead of multiplying recovery notes.

## Minimum self-contained record

Use only sections that carry real information, but a substantive project handoff normally contains:

### CONTEXT

- goal and why the work exists;
- relevant project/repository boundaries;
- what state preceded the current work;
- why the current investigation/change was needed.

### TIMELINE

- important discoveries and experiments in causal order;
- meaningful changes;
- failures and recoveries;
- architecture decisions or reversals that affect continuation.

Do not reproduce the whole chat transcript. Preserve decisions and evidence identities.

### CURRENT STATE

- what exists now;
- current branch/ref/commit when material;
- current component/service chain;
- relevant configs, paths, commands and dependencies;
- what is working, partially working, failed, or not run.

For infrastructure, preserve the verified chain, for example:

`application -> config -> local bridge/service -> localhost port -> proxy/tunnel -> external service`

### FACTS / EVIDENCE

For material claims preserve enough identity to recover the source:

- repository/path/ref;
- commit/blob/tree SHA;
- issue/PR/run/artifact ID;
- exact discriminator command/tool action;
- relevant observed output/result;
- timestamp where timing matters.

A conclusion without its discriminator is weak handoff material.

### DECISIONS

Record accepted and rejected paths and why. Separate owner decisions from agent execution outcomes.

### FAILED ATTEMPTS

Preserve the failed observation and falsified assumption. This prevents the next chat from repeating known-dead paths merely because they are absent from a happy-path summary.

### UNKNOWN

State unresolved claims explicitly. Do not fill gaps from memory or likelihood.

### NEXT

Give the smallest concrete continuation step, what it should observe, and what result would change the plan.

### SOURCE OF TRUTH

Name the canonical handoff artifact and authoritative code/evidence locations. If other repositories need continuity, use pointers rather than duplicate operational state.

## Canonical ownership rules

1. Prefer one mutable canonical state artifact per active recovery/workstream.
2. Update the canonical artifact when new confirmed facts appear.
3. Keep incidents/history immutable when they are historical evidence; point from them to the current canonical state rather than turning every incident into another live source.
4. A pointer must identify the canonical repository/path and may contain provenance, but must not silently become a second independently maintained state copy.
5. Before creating a new recovery document, search/fetch the current project state and its history enough to prove that no suitable canonical artifact already owns the state.

## Verification of a handoff write

A handoff update is a normal GitHub mutation and must pass the same gate:

1. read canonical artifact and current ref/blob identity;
2. prepare the intended self-contained delta;
3. write;
4. obtain durable commit/ref evidence;
5. re-read the canonical artifact from the intended ref/commit;
6. verify exact content and mutation scope;
7. only then report that state was recorded.

`I wrote a handoff` is not evidence that another chat can recover from it. The artifact itself must contain the required continuation state.