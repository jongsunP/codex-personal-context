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
- Dentlink DLDS·AI 프롬프트 / DL-16437·DL-16466·DL-16471:
  [projects/dentlink-fe-opportunities.md](projects/dentlink-fe-opportunities.md)
  — 2026-10-16 PR #4692의 release/v1.89.0 충돌 확인. 다른 브랜치 정리 후 사용자가 일괄 충돌 해결을 지시할 때까지 코드·PR 변경/병합·자동 확인 없이 대기한다.
  재개 시 다른 브랜치의 기능·의도와 DLDS의 DLOS 구조·패키지 통합 목적을 함께 보존한다. 과거 충돌 없음·검증 성공과 현재 상태를 구분하며 상세 근거·순서는 정본을 따른다.
- Dentlink 요구사항 외 UI 변경 조사:
  [projects/dentlink-client-ui-requirements-audit.md](projects/dentlink-client-ui-requirements-audit.md)
  — 승인된 UI 정리 PR #4642가 반영된 완료 이력. 미착수 조사로 되돌리지 않는다.
- Dentlink web order feedback: `projects/dentlink-client-order-feedback.md`
- Dentlink mobile app: `projects/dentlink-app.md`
- Dentlink Admin LBX: `projects/dentlink-client-lbx.md`
  — 2026-10-16 PR #4705의 develop 병합 완료. 운영 릴리스는 별도이며 원본과 날짜별 전달 브랜치를 보존한다.
- Dentlink 권한관리 / DL-16317: [projects/dentlink-permission-management.md](projects/dentlink-permission-management.md)
  — 2026-10-19 웹stage413ed3564(release8d209ada9와tree동일), 사용자Staging반영확인·추가배포조회중단지시로정리.
  앱feature/DL-16317@5c3504d를 사용자 이번예외승인으로 양OS Stagingv335/2.2.4 직접배포·서버/소스확인완료.
  PR329 OPEN→develop·미병합유지(앱개발자리뷰용),Developmentv139/Production변경없음. 웹DL-16319·앱DL-16752 모두READY FOR QA·전달댓글완료.
  추가확정FE개발/BE문의없음. 사용자 QA요청완료·결과전달까지 추가작업/조회/모니터링없이대기한다. 앱개발자PR리뷰·실기기적용·QA통과·운영출시는별도다.
  원본feature/worktree/Member시뮬레이터·Metro보존. 상세검증(235tests,baseline동일6타입진단)·정책·배포아티팩트는정본참조.
- Dentlink Billing Statement 명칭 변경 / DL-16796:
  `projects/dentlink-client-billing-statement.md` — PR #4699의 release/v1.89.0 병합 완료. QA·운영 출시 별도이며 브랜치는 보존한다.
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
