# Failure Catalog

Classify GitHub failures narrowly. Do not invent connector limits, mistake search for authority, escape authenticated scope, or promote incomplete continuity/write evidence to success.

| Failure class | Observable condition | Required response |
|---|---|---|
| `false-capability-denial` | Agent says GitHub unavailable/disconnected before current capability discovery | Discover current GitHub app/actions and attempt relevant capability first |
| `connector-present-not-invoked` | GitHub is available or explicitly routed with `@GitHub`, but agent uses memory/web/pasted files instead | Route to GitHub and perform the read/action |
| `read-write-conflation` | One action is missing/fails and agent generalizes GitHub as read-only/unavailable | Discover/report the narrow capability only |
| `stale-capability-memory` | Old-session limitation is reused as current truth | Re-discover current runtime capability |
| `schema-failure-misclassified` | Local argument/schema validation fails before external call | `PRECALL_FAILURE`; fix invocation, do not call it a GitHub rejection |
| `unknown-mutation-state` | Valid remote mutation may have been sent but final state is unclear | Read authoritative state before retrying |
| `fake-github-inspection` | Agent says/implies it checked GitHub without a successful GitHub read | Retract to actual evidence level and perform authoritative read |
| `authenticated-scope-escape` | Authenticated GitHub identity exists, but an owner-ambiguous personal request is resolved through global/public discovery instead of that account | Bind discovery to authenticated account/installations first; reject foreign target unless provenance points outward |
| `public-search-before-account-binding` | Agent globally searches a personal project/repo name before resolving authenticated login and accessible repos | Establish identity/account scope first; public search is fallback, not primary resolver |
| `foreign-repository-selected-without-evidence` | Repository owned by another account is treated as the user's project based on name similarity/search ranking alone | Require explicit user naming or authoritative provenance from the authenticated ecosystem before accepting foreign owner |
| `search-miss-as-absence` | Search returns zero and agent concludes resource/fact does not exist | Use direct fetch/list/history or report only `not found by this search` |
| `public-fetch-private-confusion` | Public `fetch` path fails on private repo and agent concludes connector cannot access it | Use authenticated repository/file actions |
| `navigation-index-stale` | Map/index disagrees with current repository | Repository wins current-state claim; record stale map separately |
| `canonical-bypass` | Known canonical handoff exists but agent starts broad archaeology again | Read canonical artifact first; investigate only unresolved/current delta |
| `duplicate-recovery-artifact` | Agent creates another live recovery note instead of updating canonical owner | Stop proliferation; update canonical artifact and keep pointers only |
| `pointer-promoted-to-canonical` | Navigation/history pointer accumulates a second independently maintained operational state copy | Restore one canonical owner; reduce pointer to navigation/provenance |
| `handoff-too-thin` | Durable note contains conclusion but lacks context/evidence/failures/unknowns/next | Expand using handoff contract before calling it a recovery point |
| `context-drop-on-short-command` | `запиши`/`продолжай` is treated as context-free despite active verified project state | Resolve omitted arguments from active context and canonical ownership |
| `failed-path-amnesia` | New chat repeats already falsified attempts because handoff omits them | Read/preserve FAILED ATTEMPTS/DECISIONS; repeat only with changed evidence |
| `textual-success-without-evidence` | Wrapper says success but returns no durable remote identity | Stop at `WRITE_ATTEMPTED`; independently read resulting remote state |
| `commit-without-readback` | Commit SHA exists but target state was not re-read | Stop at `WRITE_EVIDENCED`; fetch by commit/ref and compare |
| `readback-mismatch` | Durable write exists but bytes/state differ from prepared delta | `FAILED`; preserve expected and observed state |
| `stale-object-identity` | Update/delete uses outdated blob SHA and GitHub rejects it | Record exact rejection; re-baseline before any authorized retry |
| `same-content-write` | Requested replacement equals current bytes | Treat actual endpoint/tool behavior empirically; do not predict no-op/commit |
| `wrong-ref` | Write/reread targets different branch/ref than prepared | `FAILED` or `UNKNOWN`; requested target was not verified |
| `protected-or-rejected-write` | Permission/ruleset/protection rejects mutation | Preserve actual error; do not generalize to connector absence |
| `eventual-readback` | Commit evidence exists but intended ref cannot yet observe it | Stay below `VERIFIED`; record authorized reread attempts/timestamps |
| `unexpected-diff` | Intended change exists plus extra paths/state | Verification fails until extra delta is explained/reverted |
| `missing-baseline` | Mutation starts before current ref/object/content/instructions are read | Stop and establish baseline |
| `tool-capability-mismatch` | High-level wrapper omits evidence needed for task | Discover lower-level GitHub path or independent read; never fabricate fields |
| `ref-moved-concurrently` | Branch/ref advances after baseline | Do not force silently; re-baseline/report concurrency |
| `literal-content-drift` | Agent rewrites exact requested bytes without request/safety requirement | Verification fails; restore intended literal content |
| `sequential-contract-broken` | Required write→verify→write sequence is batched/parallelized | Stop sequence and verify each mutation independently |
| `git-object-not-ref-state` | Blob/tree/commit object exists and agent claims branch changed | Verify/update intended ref then reread branch state |
| `tree-without-base-loss` | Partial tree is built without base tree and would omit unrelated existing files | Use base tree or intentionally specify full tree; verify full diff before ref update |

## Rationalizations to reject

- "I don't have GitHub access" before checking current tools.
- "Connect GitHub in Settings" before an actual auth/capability failure proves that.
- "It was read-only yesterday."
- "I found a public repo with the same project name, so that must be the user's repo."
- "The user did not specify an owner, so global GitHub search is the safest first step."
- "Authenticated login is irrelevant because repository search can find the project faster."
- "Search returned nothing, so it isn't there."
- "The map says it, so the repo must still look that way."
- "I remember the GigaChat setup; no need to fetch the handoff."
- "Another recovery note is faster than finding the old one."
- "Записал" when no durable commit/read-back exists.
- "The commit exists, so the branch is updated."
- "The tool schema rejected it, so GitHub rejected it."
- "The exact error shape doesn't matter because we know what it means."

When current runtime/repository evidence contradicts an assumption, change the assumption—not the observation.