# Project-Specific Context

## Purpose

Root guidance files define rules shared across all work. Each file in this
directory defines the user's personal configuration, checkpoint, and history
for one project without adding personal AI state to the shared project
repository.

## Layering

Apply context in this order:

1. Current explicit user instruction
2. Common personal guidance at the repository root
3. The active `projects/<project>.md`
4. Verified live Git, code, and stable team-owned project documentation

A project file may specialize a common rule for its own domain. It must not
silently weaken permission, security, truthfulness, or destructive-action
boundaries.

## What Each Project File Contains

- Repository identity, local paths, and usual branch or worktree
- Project-specific product and implementation principles
- Project-specific session roles, approval gates, QA, and output conventions
- Current branch, HEAD, worktree, verification, and integration state
- Completed and remaining work, blockers, decisions, and next starting point
- Dated history that helps explain how the current state was reached
- References to stable team-owned documentation without copying it wholesale

## What Stays In The Shared Project Repository

- Source code and generated product artifacts
- Stable product contracts and architecture used by the team
- Team-owned developer instructions and canonical documentation
- Information useful independently of this user's Codex workflow

Do not add personal progress logs, Codex handoffs, or transient QA checkpoints
to a repository shared by the whole team.

## Lifecycle

At start or resume:

1. Pull `codex-personal-context` first.
2. Read the common guidance and active project file.
3. Pull the shared project repository.
4. Reconcile the checkpoint with live branch, HEAD, remote divergence,
   worktree, recent commits, and relevant stable docs.

At meaningful closeout:

1. Update one current checkpoint; record history only for meaningful decisions,
   evidence, or changes of state, not every repeated status report.
2. Remove or label stale duplicate status so only one section is current.
3. Commit and push `codex-personal-context`.
4. Commit, push, or mutate the shared project only with explicit user
   authorization.

Do not store secrets, credentials, private customer data, or raw chat logs.

## Current Checkpoint And History Maintenance

- Put the current scope, completed work, present effect, remaining work or
  waiting condition, verification limits, and next starting point near the top.
  Branch/SHA and device details are dated observations, not permanent setup.
- Keep the detailed changing state in one project file. `PROJECTS.md` and
  `HANDOFF.md` route readers there; the FE main checkpoint keeps cross-project
  decisions and a short coordination index. Avoid copying changing SHA, PR,
  deployment, or local-folder inventories into all three.
- When historical checkpoints obscure the current state, move them to a dated
  file under `projects/archive/` and link it from the existing project path.
  Preserve decision rationale, exact revisions, evidence limits, recovery
  pointers, and meaningful unresolved facts. A full snapshot is acceptable
  when selective deletion would risk losing context.
- Keep stable rules and relevant unresolved work in the current file. Label
  archived instructions and old `current`/`next` headings as historical; they
  do not reopen finished work, lift a hold, or authorize an old action again.
  Correct stale summaries only from newer documented evidence, and distinguish
  this reconciliation from fresh Git, deployment, or device verification.
- Before publishing a refactor, verify preserved history, relative links and
  anchors, important policy boundaries, and other sessions' concurrent edits.
  Commit/push curated personal context and synchronize local guidance as needed.
- The main coordination session owns this maintenance when requested or when
  a concrete inconsistency needs correction. Do not reorganize merely to hit a
  size target, invent a recurring cleanup job, or rewrite active project facts
  without evidence. Large reference inventories can remain intact and be read
  only for relevant work.
