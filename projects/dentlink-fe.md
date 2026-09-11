# Dentlink Frontend Coordination

This is the personal cross-repository coordination checkpoint for Dentlink
frontend work. It is not a product repository, combined workspace, or worktree.
Detailed implementation history remains in the relevant existing project file.

## Scope

- Web/Admin repository: `/Users/parkjongsun/Repository/dentlink-client`
- Mobile app repository: `/Users/parkjongsun/Repository/dentlink-app`
- Durable context: `/Users/parkjongsun/Repository/codex-personal-context`
- Active AI workflow: Codex only. The remote `claude-personal-context`
  repository is retained only as an archive and is not loaded by default.

## Session Ownership

- The Dentlink FE top-level session is projectless and owns intake, web/app
  scope classification, shared decisions, priorities, release/deployment
  coordination, handoff prompts, and closeout.
- Code changes are performed only in a session rooted at the exact product
  repository, branch, or worktree that owns them.
- A feature spanning web and app may use separate implementation sessions for
  each repository. The top-level session coordinates the shared outcome but
  does not combine Git histories or write from an ambiguous directory.
- Keep one active writing session per worktree. Repository main-checkout
  sessions are optional helpers for branch/worktree/release administration.
- Shared repository mutations still require the user's explicit authorization.

## Context Routing

- Read `projects/dentlink-client-order-feedback.md` and other matching
  `dentlink-client` checkpoints for web/Admin implementation history.
- Read `projects/dentlink-app.md` for app implementation, runtime, build, and
  deployment history.
- Read `projects/dentlink-unified-notification-center.md` when that cross-web/app
  feature resumes.
- Keep repository-specific branch, commit, QA, and blocker detail in those
  existing files. Record only cross-repository decisions and coordination
  state here.

## Transition Checkpoint — 2026-09-11

- The DL-15828 web-only session was closed, its dedicated worktree and local
  task branches were removed, and web follow-up moved to the main
  `dentlink-client` checkout. Its verified state is recorded in
  `projects/dentlink-client-order-feedback.md`.
- Live verification found the main `dentlink-client` checkout clean on
  `release/v1.86.0` at `0e0878ef1`, synchronized with its remote. Its only
  local branches are `master` at `ddeeb1e86` and `release/v1.86.0`, both at
  0/0 divergence, and its only registered worktree is the main checkout.
- The existing app session must refresh `projects/dentlink-app.md`, verify live
  app Git and delivery state, and provide a final handoff before being replaced
  by the top-level coordination session.
- The local `claude-personal-context` checkout was removed after confirming it
  had no local-only changes, commits, stash, or worktrees. Its GitHub repository
  remains available for optional future recovery.

## Top-Level Session Start

1. Pull `codex-personal-context` and read the common guidance plus this file.
2. Read the relevant web and app checkpoints before relying on prior chat.
3. Fetch/pull both product repositories only as required by the current task,
   then verify exact path, branch, HEAD, upstream, dirty state, and worktree.
4. Classify each new request as web, app, or shared before deciding the owning
   implementation session and release target.
5. Do not create a worktree for a very small change without first asking the
   user, and do not reuse a completed feature branch.
6. Reconcile Jira, Notion, Figma, Swagger, and live code when the new request
   depends on them; do not re-fetch every external source without a task-driven
   reason.

## Next Starting Point

Create the new projectless Dentlink FE top-level Codex session, give it the
prepared startup prompt, then give the existing app session the handoff prompt.
The top-level session should not treat app status as current until that app
handoff has been written and verified.
