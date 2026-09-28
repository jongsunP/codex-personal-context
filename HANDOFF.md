# Codex Cross-Session Handoff

## Purpose

This file is the cross-project resume index for the user's private Codex
context. It should not duplicate changing project status. Detailed personal
progress and dated history belong in `projects/<project>.md`.

Do not store secrets or private customer data here.

## Resume Order

1. Pull `/Users/parkjongsun/Repository/codex-personal-context`.
2. Run `./setup-local-codex.sh` when local Codex guidance may be stale.
3. Read `AGENTS.md`, `BOOTSTRAP.md`, `SESSION_WORKFLOW.md`, and
   `DEVELOPMENT_STYLE.md`.
4. Read the relevant personal checkpoint under `projects/`.
5. Pull the shared project repository and verify branch, HEAD, remote
   divergence, worktree, and recent commits.
6. Read stable team-owned project documentation relevant to the task.
7. Reconcile any stale checkpoint with verified live Git and current explicit
   user instructions before continuing.

## Project Checkpoints

- Action Sports Journal: `projects/action-sports-journal-app.md`
- Dentlink frontend coordination: `projects/dentlink-fe.md`
- Dentlink DLDS / DL-16466: `projects/dentlink-fe-opportunities.md`의 2026-09-28 최신 체크포인트. 제품 ca567f7df, UI196·복사 코드41·focused E2E4 통과. 최신 사용자 결정으로 아이콘 추가 전수 대조는 제외하고 누락만 대상으로 한다. 카탈로그 명칭 설명·메모리 반영 후 대기하며 추가 개발은 재개 요청 전에 시작하지 않는다. 보조 UI 경계·권한/실기기 조건은 별도이며 전체 DLDS 완료·AI 하네스 착수와 구분한다.
- Dentlink web order feedback: `projects/dentlink-client-order-feedback.md`
- Dentlink mobile app: `projects/dentlink-app.md`
- Dentlink Admin LBX: `projects/dentlink-client-lbx.md` — 백엔드 문제로 이번 배포 제외, PR #4623 미병합 종료. 재개 지시까지 작업 브랜치 보존·대기.

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
