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
  — **최종 대기 지시:** PR#4692는 현재 실제 반영 목적의 상태 그대로 유지합니다. 추가 제목/본문/상태/리뷰/머지 변경이나 공개 재시도 없이 npm 설정 회신을 기다립니다. 회신·재개 요청이 오면 실제 상태를 확인하고 다음 행동을 안내합니다.
  — 2026-10-13 **브레이크포인트 / 실제 반영 PR·npm 설정 회신 대기**. client `77ff34f76` 저장·푸시·CI 통과, 사용자가 직접 바꾼 제목 `[DL-16471] DLDS·DLOS 패키지 통합`의 PR#4692는 **실제 master 반영 목적**입니다. OPEN/non-Draft·미병합(별도 사용자 결정), 추가 PR 불필요. npm run38350722659 attempt2도 icons OIDC E403으로 실패했고 목표0.1.2-pr.a118246 세 패키지 미공개/DLDS404입니다. FE 공통 Studio 권한 요구는 제외합니다. 목표 운영은 **npm 정식 공개→Studio 갤러리 자동 최신화**이며 현재 sync는 latest만 읽어 pr시험버전은 선택하지 않습니다. 자동화 완료는 미확인입니다. 동료 답변을 사용자가 공유하면 Codex가 권한·원격·PR·registry부터 확인해 기존 승인 범위의 시험 공개/설치검증→DLDS 자동배포 준비→사용자 PR머지결정→정식공개·자동갤러리 결과 확인을 이어갑니다. 사용자 직접 설정/승인이 필요하면 구체적으로 안내합니다. 현재는 추가 실행 없이 회신을 기다립니다. 자료/이력은 보존하고 새 하네스 개발은 통합 이후입니다.
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
