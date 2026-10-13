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
  — **2026-10-13 공개 후속 마감:** 최신 master8772와 세 패키지0.1.2 조정을 client feature/DL-16471-dlds-dlos-integration의94b6324be에 저장·푸시했습니다. 정상 hook·PR CI·수동 공개38372263872 성공. 시험0.1.3-pr.94b6324의 DLOS·신규 DLDS는 실제 registry 확인, icons는 약20분 뒤에도 미조회라 외부 설치 검증은 대기입니다. 다음은 **icons 반영 재조회·정확한 버전 설치 검증 → 신규 DLDS Trusted Publisher/직접 공개 설정 → 사용자 PR머지결정 → 정식 공개·Studio 갤러리 결과 확인**입니다. 기존 icons/DLOS OIDC 권한과 DLDS 최초 생성은 성공했으므로 같은 요청을 반복하지 않습니다. PR#4692는 실제 반영 목적 OPEN/non-Draft·미병합, Studio 공통 권한은 FE 필수 조건이 아닙니다. npm의 상세 처리 상태·DLDS 설정은 관리자 확인 영역입니다. 새 하네스/에디터는 통합 이후이며 자동 감시 없이 재개 지시를 기다립니다. 실행 방법·원격 복구 근거는 프로젝트 정본에 있습니다.
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
