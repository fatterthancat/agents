# Failure Catalog

Use this catalog to classify ambiguous GitHub writes without upgrading them to success.

| Failure class | Observable condition | Required response |
|---|---|---|
| `textual-success-without-evidence` | Wrapper says success but returns no durable remote identity | Stop at `WRITE_ATTEMPTED`; independently fetch resulting remote state |
| `commit-without-readback` | Commit SHA exists but target state was not re-read | Stop at `WRITE_EVIDENCED`; fetch by commit/ref and compare |
| `readback-mismatch` | Durable write exists but bytes/state differ from prepared delta | `FAILED`; preserve both expected and observed state |
| `stale-object-identity` | Update/delete used an outdated blob/object SHA and GitHub rejects it | Record exact rejection; do not silently retry with a fresh SHA |
| `same-content-write` | Requested replacement is byte-identical to current content | Treat actual endpoint/tool behavior as empirical; do not assume commit/no-op semantics |
| `wrong-ref` | Write or reread targets a different branch/ref than prepared | `FAILED` or `UNKNOWN`; do not claim target branch changed |
| `protected-or-rejected-write` | Permissions/rules reject mutation | Preserve actual error shape and leave `CHANGES: none verified` unless an independent durable side effect is proven |
| `eventual-readback` | Write evidence exists but immediate authoritative reread cannot yet observe it | Remain below `VERIFIED`; record attempts/timestamps if retry is authorized |
| `unexpected-diff` | Intended change is present but additional paths/state changed | Verification fails until extra delta is explained or reverted |
| `missing-baseline` | Mutation began before authoritative current ref/object/content was read | Stop; reconstruct baseline before any further mutation |
| `tool-capability-mismatch` | High-level wrapper omits evidence needed for verification | Drop to a lower-level GitHub capability or independent reread; never fabricate missing fields |
| `ref-moved-concurrently` | Branch/ref advanced after baseline before final update | Do not force unless explicitly authorized; re-baseline and report concurrency |

## Rationalizations to reject

- "The tool said success, so it is probably fine."
- "We have the commit SHA; reread is redundant."
- "The diff is obvious from what I sent."
- "Retrying automatically is harmless."
- "GitHub probably treats identical content as a no-op."
- "The branch was surely main because it is the default."
- "A local commit proves the remote mutation."
- "The error shape is unimportant because we know what it means."

When the real system contradicts an assumption, keep the contradiction as evidence and change the assumption, not the observation.
