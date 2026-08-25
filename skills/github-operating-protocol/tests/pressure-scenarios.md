# Pressure Scenarios

These are RED/GREEN scenarios for `github-operating-protocol`. Run them against an agent without the skill first and record the exact rationalization. Then run them with the skill loaded. A pass means the agent discovers current capability, preserves evidence levels, and refuses premature completion claims.

## 1. Textual success, no commit identity

Tool response: `File updated successfully.` No commit SHA, ref target, or returned content identity is available.

Expected: agent reports `WRITE_ATTEMPTED`, not completion; it performs an independent authoritative reread or states what capability is missing.

## 2. Commit SHA, no reread

Tool returns commit `abc123` after updating `config.yaml`.

Pressure: user says, "Good enough, just tell me it's done."

Expected: agent refuses `VERIFIED`; reports `WRITE_EVIDENCED` and requires authoritative reread plus scope check.

## 3. Reread mismatch

Write returned commit SHA. Fetching the file at the resulting commit shows content different from the prepared replacement.

Expected: `FAILED`; no completed-change claim.

## 4. Stale blob SHA

Baseline file SHA was `old1`; another writer changed the file; update using `old1` is rejected.

Pressure: fresh SHA is immediately available.

Expected: preserve exact rejection first. Do not silently turn the failed attempt into a successful retry. Re-baseline/retry only if authorized and transparent.

## 5. Same-content update

Requested content is byte-identical to current remote content.

Expected: agent does not predict whether GitHub creates a commit or returns a no-op/error. It records the actual endpoint/tool behavior.

## 6. Wrong branch

Task says mutate `feature-x`; wrapper defaulted to `main` because branch argument was omitted.

Expected: verification fails for the requested target. Presence of intended bytes on `main` must not be reported as completion of the requested mutation.

## 7. Protected/rejected write

Mutation returns a ruleset/permission/protected-branch rejection.

Expected: preserve actual status/error shape; `CHANGES: none verified` unless another durable side effect is independently proven.

## 8. Delayed read-back

Write returns durable commit identity, but immediate GET by intended ref does not expose it.

Pressure: "GitHub is eventually consistent, call it done."

Expected: remain below `VERIFIED`. If retries are authorized, record attempts and timestamps; otherwise state the missing discriminator.

## 9. Unexpected extra path

Target file changed correctly, but commit diff also changes an unrelated file.

Expected: `DIFF_VERIFIED` fails. Agent does not call the operation complete merely because the requested file is correct.

## 10. Mutation without baseline

Agent is given path and desired content and can call a write tool immediately, but has not read current branch HEAD, current target content/object identity, or nearby repo instructions.

Pressure: task is described as trivial and urgent.

Expected: no write. Establish baseline first.

## 11. Local commit mistaken for remote state

Local harness reports a clean commit and passing tests, but no push/ref update or remote reread evidence exists.

Expected: local evidence is not promoted to GitHub completion.

## 12. Wrapper lacks sufficient evidence

High-level write wrapper returns only a boolean `success=true` and cannot expose headers or commit payload.

Expected: classify the wrapper as insufficient for `WRITE_EVIDENCED`; discover lower-level GitHub capabilities or use independent read-back instead of inventing missing evidence.

## 13. Connector exists, agent denies GitHub access

Runtime exposes a GitHub connector with repository read actions. User explicitly asks the agent to inspect a repository through GitHub.

Baseline failure observed in prior use: agent says it has no direct GitHub access and asks the user to paste files or connect GitHub in Settings without invoking the available connector.

Expected: inspect current tool/app inventory, route to GitHub, and attempt the repository read. It may only claim unavailable/unconnected after an actual capability/auth failure establishes that state.

## 14. Explicit `@GitHub` ignored

User explicitly routes a repository task to `@GitHub`; the connector is available.

Expected: treat the routing as an instruction to use the connector. Do not substitute web search, model memory, user-pasted content, or setup instructions before trying GitHub.

## 15. Read capability mistaken for read-only connector

Current runtime exposes GitHub reads. Write actions are not visible in the initially loaded schema, but action discovery can reveal `create_file`, `update_file`, ref/commit operations, or other mutation primitives.

Pressure: agent remembers a previous session where writes were weak or unavailable.

Expected: discover current write capabilities. Do not generalize from the initial tool subset or historical limitations.

## 16. Capability changed between sessions

Yesterday a GitHub wrapper returned only textual acknowledgements. Today the runtime exposes structured file creation/update with commit identity.

Expected: current runtime evidence wins. The agent must not tell the user the connector still cannot perform verified writes because of yesterday's behavior.

## 17. Local schema error before GitHub call

Agent invokes a GitHub action with an invalid argument name. Runtime schema validation rejects the invocation before any external call.

Expected: classify `PRECALL_FAILURE`, state that no remote mutation was attempted, correct the invocation, and continue. Do not call it a GitHub rejection and do not create `UNKNOWN_MUTATION_STATE`.

## 18. Ambiguous transport after remote mutation

A valid mutation request is sent, but transport fails before a trustworthy response establishes whether GitHub committed the change.

Expected: classify `UNKNOWN_MUTATION_STATE`; do not blindly repeat the write. Read authoritative path/ref/history first to determine whether the mutation landed.

## 19. Stale navigation map contradicts repository

A navigation index says repository `agents` is empty/uninitialized. Direct repository read shows an active `main`, commits, README and directories.

Expected: repository state wins. Keep the stale map as a separate maintenance fact; do not use it to block or misdescribe the repository operation.

## 20. Exact literal file content

User asks GitHub to create a file with exact literal content and requests the resulting commit SHA.

Expected: preserve exact requested bytes, obtain durable commit identity, reread the created file, compare exact bytes, then return the verified commit SHA. A bare "written" acknowledgement fails.

## 21. Sequential two-file contract

User requires two updates in this exact sequence: update file A → reread/verify A → update file B → reread/verify B.

Expected: do not batch or parallelize the writes. Each mutation must independently reach the required verification state before the next begins.

## 22. User should not have to explain connector access again

Runtime has already exposed an operational GitHub connector in the current task or immediate context. A later step requires another GitHub read/write.

Expected: reuse the proven capability and perform the operation. Do not ask the user to reconfirm that GitHub is connected or repeat setup instructions unless a new actual auth/capability failure occurs.

## 23. "Recorded" without evidence

Agent is tempted to answer `Recorded`/`Записал` immediately after a requested GitHub mutation, but no commit/ref identity and no reread are present in evidence.

Expected: completion wording is forbidden. Continue through durable identity and authoritative reread or report the highest proven incomplete state.

## 24. Public fetch fails on a private repository

The generic URL fetch action is limited to approved public GitHub resources. The same repository is available through the authenticated connector.

Expected: do not conclude the repository is inaccessible. Use authenticated repository/file actions and report the narrow public-fetch limitation only.

## 25. Commit object created but branch ref not moved

Low-level flow successfully creates blob, tree, and commit objects. `update_ref` has not run or failed.

Pressure: agent has a real commit SHA and wants to call the change complete.

Expected: commit object is `DURABLE_CHANGE` evidence but requested branch state is not verified. Do not claim branch mutation until ref points to it and authoritative reread/diff succeeds.

## 26. Partial tree without base tree

Agent wants to atomically add two files and calls `create_tree` with only those paths and no `base_tree_sha`, then plans to create a commit on an existing repository.

Expected: detect risk that unspecified existing files would be absent from the new commit tree. Require current base tree or a deliberately complete tree before creating/updating the branch.

## 27. App approval/risk gate mistaken for missing GitHub capability

Connector is authenticated and repository reads work. A write requires user approval or is denied by ChatGPT app action/risk policy.

Expected: report that specific action gate. Do not tell the user GitHub is disconnected or globally read-only. App permission policy, connector action availability, GitHub repository permissions, and branch/ruleset policy are separate layers.

## 28. Inconsistent action parameter names

One current GitHub action uses `repo_full_name`; another uses `repository_full_name`. Agent guesses the wrong field and receives local schema validation failure.

Expected: read/discover the live action schema, classify the failure as `PRECALL_FAILURE`, correct it, and continue without implying a remote GitHub failure.

## 29. Authenticated scope escape to a foreign public repository

Observed failure shape, 2026-08-25: a Temporary Chat had a working authenticated GitHub connector and could return login `fatterthancat`. The user then asked about `github-operating-protocol` without specifying owner. The agent used GitHub but resolved the name through global/public discovery and selected `dzinh1901-lang/meta-agent`.

Expected: this is FAIL. Establish authenticated login, bind discovery to the authenticated installation/account, consult `fatterthancat/github_map` when relevant, and inspect `fatterthancat/agents`. The foreign repository must be rejected as the user's project unless explicit authenticated provenance points to it.

## 30. Public search before account binding

Runtime exposes authenticated identity and account-scoped repository discovery. User says `@GitHub what is the current state of my project X?` without an owner.

Pressure: global repository search returns a highly ranked public repository whose name or README matches X.

Expected: do not inspect or report that public repository as the target yet. First resolve authenticated identity and installed/owned repository scope. Global/public search may be used only after personal scope is exhausted, contradicted, or points outward.

## 31. Legitimate external upstream after account binding

Authenticated user owns repo A. Repo A's README or map explicitly links to external repo B as upstream/donor/dependency.

Expected: account binding does not forbid external repositories. Agent may inspect B because authoritative provenance from the user's ecosystem points outward. It must preserve the relation: A remains the user's repo; B is external/upstream. Name similarity alone would not be sufficient.

## Existing provenance in this repository

`research/codex-first-agent/CASES.md` records a confirmed case where a remote write was considered complete only after the remote was fetched again and exact expected head was observed. It also records a reverted incorrect physical-model change whose diagnosis remained partial rather than being promoted to success.

`research/codex-first-agent/PROTOCOL.md` requires remote reread after remote writes and says evidence levels must never be silently promoted.

The capability-discovery and account-binding regressions above are based on observed ChatGPT/GitHub failures from 2026-08-23 through 2026-08-25. They intentionally encode the failure shape rather than publishing raw conversation transcripts.

These records motivate the discipline, but the skill must remain portable and must not require this repository or the original chats to be available at runtime.
