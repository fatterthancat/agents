# Failure Catalog

Use this catalog to classify GitHub capability and mutation failures without inventing tool limits or upgrading incomplete evidence to success.

| Failure class | Observable condition | Required response |
|---|---|---|
| `false-capability-denial` | Agent says GitHub is unavailable/disconnected before inspecting the current runtime tool surface | Discover current GitHub tools/apps and invoke the relevant capability before making an availability claim |
| `connector-present-not-invoked` | GitHub connector is available or explicitly routed by the user, but agent asks for pasted files, web browsing, or manual setup instead | Route to GitHub first; do not offload capability discovery to the user |
| `read-write-conflation` | One read/write/admin action is absent or fails and agent generalizes that GitHub itself is unavailable/read-only | Discover capabilities separately and report the narrow missing capability only |
| `stale-capability-memory` | Agent relies on a limitation observed in an earlier chat/session although the current connector surface may differ | Re-discover current runtime capability; old tool behavior is historical evidence, not current truth |
| `schema-failure-misclassified` | Local argument/schema validation fails before any external request | Classify `PRECALL_FAILURE`; correct the invocation without claiming a GitHub write failed or remote state changed |
| `unknown-mutation-state` | A remote mutation may have been sent, but response/transport evidence cannot prove whether GitHub changed | Do not retry blindly; authoritative reread must resolve state first |
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
| `tool-capability-mismatch` | High-level wrapper omits evidence needed for verification | Discover lower-level GitHub capability or independent reread; never fabricate missing fields |
| `ref-moved-concurrently` | Branch/ref advanced after baseline before final update | Do not force unless explicitly authorized; re-baseline and report concurrency |
| `navigation-index-stale` | Map/index disagrees with the real repository | Keep index as routing evidence; repository state wins and stale index becomes a separate maintenance fact |
| `literal-content-drift` | Agent rewrites/sanitizes exact requested file content without user request or safety requirement | Treat resulting bytes as verification failure; exact requested content is part of acceptance |
| `sequential-contract-broken` | User requires write → reread → next write, but agent batches or skips an intermediate verification | Stop sequence; independently verify each completed write before proceeding |

## Rationalizations to reject

- "I don't have GitHub access" before checking the actual runtime tools.
- "You need to connect GitHub in Settings" before an actual capability/auth failure proves that.
- "That write action is missing, therefore GitHub is read-only."
- "It didn't work yesterday, so this connector still cannot do it."
- "The tool schema rejected my arguments, so GitHub rejected the write."
- "The tool said success, so it is probably fine."
- "We have the commit SHA; reread is redundant."
- "The diff is obvious from what I sent."
- "Retrying automatically is harmless."
- "GitHub probably treats identical content as a no-op."
- "The branch was surely main because it is the default."
- "A local commit proves the remote mutation."
- "The map says the repository is empty, so there is no need to inspect the repository."
- "The error shape is unimportant because we know what it means."

When the real runtime or repository contradicts an assumption, keep the contradiction as evidence and change the assumption, not the observation.
