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
- Dentlink DLDS·AI 프롬프트 / DL-16437·DL-16466·DL-16471: [projects/dentlink-fe-opportunities.md](projects/dentlink-fe-opportunities.md)
  — **2026-10-15 DLDS 자동 배포 설정 회신 대기:** client `feature/DL-16471-dlds-dlos-integration`/`c5679107d`, clean·저장/푸시 완료, PR#4692 미병합 유지. env/ignore 관련 이번변경 재검토는 종료했고 추가수정없음. 최신시험0.1.5-pr.c567910은 이제icons·DLOS등록완료, DLDS만미등록(run38382879133 기본OIDC PUT E404). **지금 사용자→npm관리자: 신규DLDS Trusted Publisher·직접공개권한 확인 요청**(`Innvoaid / dentlink-client / packages_publish.yml`, environment비움). 회신→Codex 실패공개재개·최신3종설치검증→사용자PR병합결정→정식0.1.4/latest·Studio갤러리확인→하네스순서. 최초등록token/기존iconsDLOS권한/Studio공통권한/Vercel팀가입 재요청불필요. 자동감시·공개재시도·병합없이대기. 자세한순서/근거는정본의10월15일체크포인트참조.
- Dentlink 요구사항 외 UI 변경 조사:
  [projects/dentlink-client-ui-requirements-audit.md](projects/dentlink-client-ui-requirements-audit.md)
  — master 기준 조사·보고 전용. 사용자 승인 전 제품 수정 금지.
- Dentlink web order feedback: `projects/dentlink-client-order-feedback.md`
- Dentlink mobile app: `projects/dentlink-app.md`
- Dentlink Admin LBX: `projects/dentlink-client-lbx.md` — 백엔드 문제로 이번 배포 제외, PR #4623 미병합 종료. 재개 지시까지 작업 브랜치 보존·대기.
- Dentlink 권한관리 / DL-16317: [projects/dentlink-permission-management.md](projects/dentlink-permission-management.md)
  — Office API 4개 사용처 조사 완료. 권한관리 본 작업 미착수·지시 대기.
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
