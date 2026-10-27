# Codex Cross-Session Handoff

## Purpose

This file is the cross-project resume index for the user's private Codex
context. It should not duplicate changing project status. Detailed personal
progress and dated history belong in `projects/<project>.md`.

Do not store secrets or private customer data here.

## Resume Order

1. Clone `https://github.com/jongsunP/codex-personal-context` if missing, or pull
   the existing checkout. The preferred location is `~/Repository/codex-personal-context`;
   use the actual path on the current device.
2. Run `./setup-local-codex.sh` when local Codex guidance may be stale.
3. Apply the applicable `AGENTS.md` instructions and follow the canonical
   [Read Order](BOOTSTRAP.md#read-order), starting with `BOOTSTRAP.md`.
4. Read `PROJECTS.md` and the relevant personal checkpoint under `projects/`.
   For Dentlink, start with the active-session links in `projects/dentlink-fe.md`.
5. Restoring context alone does not resume implementation, QA, or servers, or
   authorize product Git changes. Preserve each checkpoint's waiting/hold state.
   When product work is authorized, prepare the appropriate repository and verify
   branch, HEAD, remote divergence, dirty state, worktree ownership, and commits.
   Refresh product Git within the existing authorization and repository boundaries.
6. Read stable team-owned project documentation relevant to the authorized task.
7. Reconcile stale checkpoints with live evidence before continuing. Local project
   registrations, chat IDs/transcripts, absolute paths, credentials, untracked
   environment files, dependencies, servers, and temporary evidence are not restored
   by pulling this repository. Follow each checkpoint's device-specific preparation
   notes and use the actual local paths; never record secrets here.

Using a phone to control the same running Mac continues the existing session;
it is not the other-PC recovery described above. Follow
[Phone Remote Continuity](SESSION_WORKFLOW.md#phone-remote-continuity).

## Project Checkpoints

Read each linked file's current checkpoint first. Do not copy changing SHAs,
PR states, checkout inventories, or task progress into this resume index.
Older dated sections explain history; they do not reopen completed work.

- [Action Sports Journal](projects/action-sports-journal-app.md): use its
  project-specific resume order and canonical workstream list.
- [Dentlink frontend coordination](projects/dentlink-fe.md): main-session
  ownership, active assignments, and cross-product decisions.
- [DLDS / Studio gallery / harness](projects/dentlink-fe-opportunities.md):
  follow the latest gallery scope and explicit resume conditions; do not
  automatically start the older harness plan.
- [Admin LBX](projects/dentlink-client-lbx.md): preserve the original work;
  test-environment delivery does not lift the production hold.
- [통합알림센터](projects/dentlink-unified-notification-center.md): planning
  and estimation are separate from authorization to implement.
- [Office app](projects/dentlink-app.md) / [Lab app](projects/dentlink-lab-app.md):
  separate repositories, runtime evidence, and delivery boundaries.
- [Office LinkTalk SIGSEGV investigation](projects/dentlink-app-linktalk-sigsegv-investigation.md):
  bounded investigation and unresolved cause; no automatic further investigation.
- [권한관리 / DL-16317·DL-17011](projects/dentlink-permission-management.md):
  original delivery and later QA have separate evidence; follow the latest
  closeout rather than an older implementation-wait entry.
- [모바일웹·앱 비교 / DL-17012](projects/dentlink-mobile-web-app-parity.md):
  preserve the latest approved Notion scope and user edits. Documentation
  completion does not authorize product implementation.
- [웹 환경변수 관리](projects/dentlink-client-env-management.md): preserve
  active local settings; separate completed transition from optional security
  follow-ups and another developer's setup.
- [Billing Statement / DL-16796](projects/dentlink-client-billing-statement.md)
  and [피드백 요구사항 외 UI 정리](projects/dentlink-client-ui-requirements-audit.md):
  completed work history; do not recreate old pending tasks.
- [주문 피드백](projects/dentlink-client-order-feedback.md): product contracts,
  implementation, QA, and delivery history.

Use `PROJECTS.md` for repository paths and the broader project index.

## Repository Boundary

- `codex-personal-context`: global working rules, personal project history,
  branch/commit checkpoints, QA, blockers, decisions, and next starting points.
- Shared project repositories: code and stable, team-owned canonical
  information that remains useful independently of this user's Codex workflow.
- `~/.codex`: synchronized local runtime state, not the durable source of truth.

Do not add personal Codex progress logs or transient session handoffs to a
shared project repository.

## Closeout

At meaningful closeout:

1. Curate the relevant `projects/<project>.md` current checkpoint and history.
2. Update general guidance or `MEMORY_CHANGELOG.md` when a durable rule changed.
3. Commit and push `codex-personal-context` so another session or device can
   resume from remote-backed history.
4. Commit, push, or mutate a shared project or PR only when the user explicitly
   authorizes that action.
