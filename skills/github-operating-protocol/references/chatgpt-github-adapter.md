# ChatGPT GitHub Adapter

This is a runtime adapter for the GitHub app/tool surface observed in ChatGPT. It is not a permanent API guarantee. **Rediscover the current action surface every session/task when capability matters.**

Snapshot observed on 2026-08-25: the connected GitHub surface exposed 89 actions spanning reads, writes, Git database objects, refs/branches, PR/issues, Actions, installations, and repository discovery. The linked account could enumerate an installed GitHub App and repositories with repository-level `push`/`admin` permissions. Product documentation for the ordinary ChatGPT GitHub App may describe a narrower/read-only experience; current runtime evidence wins over generic product assumptions.

## Connection and repository discovery

Useful current actions include:

- `get_user_login`, `get_profile` — authenticated identity;
- `list_installations`, `list_installed_accounts` — GitHub App installation presence;
- `list_repositories`, `list_repositories_by_installation`, `search_installed_repositories_v2` — accessible repositories;
- `get_repo`, `get_repo_collaborator_permission` — repository metadata and permission evidence.

Do not ask the user to reconnect GitHub merely because one later action fails. First classify whether the failure is action-specific, repository-specific, permission-specific, approval/risk-gated, or local schema validation.

ChatGPT app permission mode is separate from GitHub source permissions. Current OpenAI documentation describes app permissions as controlling when ChatGPT requests approval to use already-granted app access; those controls do not themselves grant new GitHub access and are separate from Memory/personalization/retention settings. Therefore an approval gate, missing Memory, or Temporary Chat does not by itself prove that the authenticated GitHub connection is unavailable.

## Authenticated account binding

When a request is personal or owner-ambiguous — for example `my GitHub`, `my repos`, `my project`, or only a project/repository name — repository discovery must bind to the authenticated account before global search.

Required order:

1. Read the authenticated GitHub login.
2. Read the relevant installation/account and installed/accessible repository universe when available.
3. Resolve ambiguous personal project names inside that account scope first.
4. If the authenticated account has an ecosystem map/index, use it for routing.
5. Only after the personal scope is exhausted, contradicted, or explicitly points outward may global/public repository discovery become the target resolver.
6. A repository owned by another account requires provenance: explicit user naming, a link/reference from an authenticated repository/map/handoff, or another authoritative relation.

A matching public repository name is never enough to claim ownership or project identity.

Observed regression on 2026-08-25: a Temporary Chat had a working authenticated GitHub connector and could return login `fatterthancat`, yet an owner-ambiguous request about `github-operating-protocol` fell into global/public discovery and selected `dzinh1901-lang/meta-agent`. This is `authenticated-scope-escape`: the connector worked, but account binding was skipped. The correct behavior is to bind to `fatterthancat`, inspect that account's repository universe/map, and reject the foreign repository unless authenticated provenance points to it.

## Read paths

- `fetch_file(repository_full_name, path, ref?)` is the preferred direct read when repo/path is known. Omitting `ref` uses the repository default branch.
- `fetch_commit`, `compare_commits`, branch/PR/action readers provide authoritative identity/history.
- `search` is code/file search and can miss unindexed/new content. A zero-result search proves only that the query returned zero indexed matches.
- `fetch(url)` is explicitly constrained to approved **public** GitHub resources. Failure through `fetch` does not prove a private repository is inaccessible through the authenticated connector.

When a canonical path/ref is known, direct fetch beats repeated broad search.

## Contents API wrappers

### `create_file`

- creates one UTF-8 file on an existing branch;
- omitting `branch` uses the default branch;
- does **not** create a branch;
- current wrapper returns the resulting commit SHA, not GitHub's full raw payload.

Required verification: fetch the created file at the intended branch/commit and compare exact bytes; fetch/compare commit scope when needed.

### `update_file`

- replaces the complete UTF-8 contents of an existing file;
- requires the current blob SHA, normally from `fetch_file`;
- omitting `branch` uses default branch;
- current wrapper returns `commit_sha` and new `content_sha`;
- sequential update/delete operations on the same path must not be parallelized.

Required verification: re-fetch from intended ref/commit, verify exact bytes and scope. Use returned `content_sha` only as evidence for that resulting content; do not confuse blob identity with branch/ref state.

### `delete_file`

- requires current blob SHA;
- returns commit SHA;
- omitting `branch` uses default branch.

Verify absence on the intended ref and commit scope after deletion.

## Low-level Git database path

Available current primitives:

`create_blob -> create_tree -> create_commit -> update_ref`

Important semantics:

- `create_blob` creates an object only; it does not change a branch.
- `create_tree` should use `base_tree_sha` when modifying an existing repository unless the full desired tree is intentionally supplied. A tree built without a base can omit existing files; committing such a tree can make them disappear from that commit.
- `create_commit` creates a durable commit object with an explicit parent but still does not move a branch.
- `update_ref` makes the commit visible through the branch; `force` defaults to false.

Therefore `create_commit` success is not equivalent to a completed branch mutation. Verify the branch ref and resulting files/diff after `update_ref`.

Use this path for atomic multi-file commits or when high-level wrappers omit necessary evidence, not as a default for simple single-file writes.

## Branch and PR traps

- `create_branch` requires exactly one existing SHA or base ref.
- File wrappers never implicitly create a missing branch.
- Several actions use `repository_full_name`; others use `repo_full_name`. Read the live schema instead of guessing. A wrong argument name can fail locally before any GitHub request.
- Example observed: `create_pull_request` requires `repository_full_name`, while `fetch_commit` uses `repo_full_name`.
- A local schema/argument failure is `PRECALL_FAILURE`: no remote write was sent. Correcting the invocation is not retrying a GitHub mutation.

## Error/evidence boundary

Classify before retrying:

- **PRECALL_FAILURE** — local schema/tool validation proves no external request was sent.
- **REMOTE_WRITE_ERROR** — GitHub/connector provides a definite remote rejection and no requested durable change is evidenced.
- **UNKNOWN_MUTATION_STATE** — the valid remote request may have reached GitHub but transport/response evidence is insufficient to know whether it landed. Read authoritative state before another write.

High-level wrappers normalize responses and may omit raw headers such as `X-GitHub-Request-Id`. If a task explicitly requires raw HTTP headers/status/payload shapes, this connector may be insufficient; use an authorized lower-level/custom canary rather than fabricating fields.

## Search/indexing rule

GitHub/ChatGPT search visibility may lag repository reality. Never convert `search returned nothing` into `the file/repository does not exist` when direct repository enumeration, known-path reads, trees, branches, or commit history can test the claim more directly.

Never use global/public repository search as the first resolver for an owner-ambiguous personal project when authenticated account-scoped discovery is available.