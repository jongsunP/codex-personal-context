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
  — 2026-10-26 웹 기본 master worktree1개·로컬 master/LBX만 남겼다. 기본 env/의존성과 3서비스 로그인 페이지 응답 확인 완료. 메인·LBX·디자인시스템 세션 유지, env·통합알림센터 보관. 이후 최신 master에서 필요한 작업만 준비한다.
- Dentlink DLDS·AI 프롬프트 / DL-16437·DL-16466·DL-16830·DL-16471:
  [projects/dentlink-fe-opportunities.md](projects/dentlink-fe-opportunities.md)
  — 2026-10-26 세션 유지. 기존 worktree2개와 제품 브랜치3개를 복구 백업 후 정리했고 Studio 로컬 브랜치도 정리했다. Studio 원격1개는 쓰기 권한403으로 남았다. 미완료 하네스·env/auth·생성 결과는 보호된 로컬 백업에 보존했다. 재개 대상은 Jira DL-16471 ‘2단계 · AI 프롬프트·하네스 정비’(진행 중)이며, 다음 요청에서 최신 master 기준 새 브랜치/필요한 worktree 준비부터 시작한다. 지금은 구현 없이 대기한다.
- Dentlink 요구사항 외 UI 변경 조사:
  [projects/dentlink-client-ui-requirements-audit.md](projects/dentlink-client-ui-requirements-audit.md)
  — 승인된 UI 정리 PR #4642가 반영된 완료 이력. 미착수 조사로 되돌리지 않는다.
- Dentlink web order feedback: `projects/dentlink-client-order-feedback.md`
- Dentlink Office app: `projects/dentlink-app.md`
- Dentlink Lab app: `projects/dentlink-lab-app.md`
- Dentlink Admin LBX: `projects/dentlink-client-lbx.md`
  — 운영 홀드·개발서버 반영 상태. 10/26 원본 feature/DL-16387과 세션을 보존했고, 재개 시 최신 master에서 필요한 LBX 변경만 준비한다.
- Dentlink 권한관리 / DL-16317: [projects/dentlink-permission-management.md](projects/dentlink-permission-management.md)
  — 웹 운영 포함·앱 Production 활성 확인 후 업무 완료/세션 보관. 10/26 웹/Office/리뷰 worktree3개는 제거하고 설정을 별도 로컬 보관했다. 원본 refs와 OTA exactSHA/전 기기 QA 한계를 유지하며 과거 QA 대기를 새 미완료 업무로 만들지 않는다.
- Dentlink 웹 환경변수 관리: [projects/dentlink-client-env-management.md](projects/dentlink-client-env-management.md)
  — 2026-10-26 기본 master 로컬 준비·전용 worktree 제거·세션 보관 완료. 원본 설정은 로컬 제한 권한 백업에 보존. 새 기능 QA/E2E는 미실행이며 별도 DEV/보안 후속은 새 지시 전 보류한다.

- Dentlink Billing Statement 명칭 변경 / DL-16796:
  `projects/dentlink-client-billing-statement.md` — 2026-10-25 PR4699 운영 포함 확인·로컬/원격 완료 브랜치 정리·세션 보관. 추가 예정 작업 없음.
- Dentlink 통합알림센터: [projects/dentlink-unified-notification-center.md](projects/dentlink-unified-notification-center.md)
  — REST 방향·사전 조사 보존, 구현 미착수. 2026-10-26 세션 보관, 재개 지시 대기.

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
