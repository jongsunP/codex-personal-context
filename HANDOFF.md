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
3. Read `AGENTS.md`, `BOOTSTRAP.md`, `SESSION_WORKFLOW.md`, and
   `DEVELOPMENT_STYLE.md`.
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

## Project Checkpoints

- Action Sports Journal: `projects/action-sports-journal-app.md`
- Dentlink frontend coordination: `projects/dentlink-fe.md`
  — 2026-10-26 권한관리 작업 공간3개 제거·설정 보존, 디자인시스템/env 유지. 원격 release→master PR4776 통합은 완료됐으며 Jira 버전 표시는 재조회하지 않았다.
- Dentlink DLDS·AI 프롬프트 / DL-16437·DL-16466·DL-16830·DL-16471:
  [projects/dentlink-fe-opportunities.md](projects/dentlink-fe-opportunities.md)
  — 웹 운영 포함·완료 refs 정리 후 2026-10-26 사용자 지시로 세션을 유지한다. 통합 worktree/env와 하네스도 보존한다. 정식 npm/Studio/하네스는 별도 후속이며 자동 재개하지 않는다.
- Dentlink 요구사항 외 UI 변경 조사:
  [projects/dentlink-client-ui-requirements-audit.md](projects/dentlink-client-ui-requirements-audit.md)
  — 승인된 UI 정리 PR #4642가 반영된 완료 이력. 미착수 조사로 되돌리지 않는다.
- Dentlink web order feedback: `projects/dentlink-client-order-feedback.md`
- Dentlink Office app: `projects/dentlink-app.md`
- Dentlink Lab app: `projects/dentlink-lab-app.md`
- Dentlink Admin LBX: `projects/dentlink-client-lbx.md`
  — 2026-10-16 PR #4705의 develop 병합 완료. 운영 릴리스는 별도이며 원본과 날짜별 전달 브랜치를 보존한다.
- Dentlink 권한관리 / DL-16317: [projects/dentlink-permission-management.md](projects/dentlink-permission-management.md)
  — 웹 운영 포함·앱 Production 활성 확인 후 업무 완료/세션 보관. 10/26 웹/Office/리뷰 worktree3개는 제거하고 설정을 별도 로컬 보관했다. 원본 refs와 OTA exactSHA/전 기기 QA 한계를 유지하며 과거 QA 대기를 새 미완료 업무로 만들지 않는다.
- Dentlink 웹 환경변수 관리: [projects/dentlink-client-env-management.md](projects/dentlink-client-env-management.md)
  — 운영 반영·DL16821 완료·미사용 refs 정리 후 2026-10-26 사용자 지시로 세션·작업 공간을 유지한다. 실제 env는 사람이 관리하며 별도 DEV/보안 후속은 새 지시 전 보류한다.

- Dentlink Billing Statement 명칭 변경 / DL-16796:
  `projects/dentlink-client-billing-statement.md` — 2026-10-25 PR4699 운영 포함 확인·로컬/원격 완료 브랜치 정리·세션 보관. 추가 예정 작업 없음.
- Dentlink 통합알림센터: [projects/dentlink-unified-notification-center.md](projects/dentlink-unified-notification-center.md)
  — REST 방향·사전 조사 완료. 권한관리 선행, 미정 정책 확인과 재개 지시 대기.

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
