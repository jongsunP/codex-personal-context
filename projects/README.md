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

1. Curate the current checkpoint and append meaningful history.
2. Remove or label stale duplicate status so only one section is current.
3. Commit and push `codex-personal-context`.
4. Commit, push, or mutate the shared project only with explicit user
   authorization.

Do not store secrets, credentials, private customer data, or raw chat logs.
