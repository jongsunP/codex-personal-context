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
  — 2026-10-08 **에이전트 공통 경로 정리·생성/후속수정 검증 저장 후 사용자 확인 대기**. 기본은 프로젝트를 읽는 에이전트의 자연어 요청이며 지침·스킬·`ai:screen` 도구는 AI 호출/인증을 하지 않는다. 기존 Codex 웹 입력은 `dev:ai-generation:codex` 선택 경로, `dev:ai-preview`는 AI 없는 고정 예시다. 제품 `feature/DL-16471 / 47edfb37f` 커밋·푸시·clean, 생성/수정 PC·휴대폰 동작까지 확인했다. 이번 실제 생성은 Codex 계열이며 다른 에이전트의 호환성·비개발자 사용성·공유 운용/에디터는 미확인이다. 다음은 최신 Git/서버 확인→FE 화면·코드 확인/자연어 요청→Codex 동작·재사용 검증. PM·디자이너/다른 팀원은 실제 서비스 단계 전에는 요청 대상에서 제외한다.5179는 생성된 결과만 보는 로컬 화면이며 임시 두 TSX는 Git 제외여서 다른 기기로 자동 이전되지 않는다. 정확한 경계·기기 복구·실행법은 기능 체크포인트를 따른다.
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
