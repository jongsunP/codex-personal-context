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
- Dentlink DLDS·AI 프롬프트 / DL-16437·DL-16466·DL-16830·DL-16471:
  [projects/dentlink-fe-opportunities.md](projects/dentlink-fe-opportunities.md)
  — 2026-10-19 사용자 PR#4692 release병합(f9a45fe02), PR#4722 stage병합(f38ad84936) 완료·실제 stage tree=release 확인. 하지만 세 웹 stage 배포 모두 Docker/Next.js 빌드 중 heap out of memory로 FAILURE다. 배포 완료나 이번 통합본 QA 가능 상태로 기록하지 않는다. 제품 checkout f027171bd는 clean이다.
  사용자는 QA를 직접 하고 결과를 주기로 했으며 정리 후 대기를 지시했다. 실패 사실을 알리고 코드수정·재배포·추가QA·모니터링·하네스 없이 대기한다. 후속 요청 시 실패run/현재배포확인→빌드원인해결→세웹배포성공확인→사용자QA 순서다. 이번 웹 변경으로 앱 CodePush/스토어 배포는 불필요하다.
  Jira DL-16830은 본문을 병합완료·배포실패·사용자QA대기로 갱신·재조회했고 Ready for Deploy를 유지했다. 하네스 DL-16471은 진행 중·후속 대기이며 변경하지 않았다. 신규 Atlassian의 innovaid 사이트를 사용한다. 정식 npm·Studio·하네스는 별도다.
- Dentlink 요구사항 외 UI 변경 조사:
  [projects/dentlink-client-ui-requirements-audit.md](projects/dentlink-client-ui-requirements-audit.md)
  — 승인된 UI 정리 PR #4642가 반영된 완료 이력. 미착수 조사로 되돌리지 않는다.
- Dentlink web order feedback: `projects/dentlink-client-order-feedback.md`
- Dentlink mobile app: `projects/dentlink-app.md`
- Dentlink Admin LBX: `projects/dentlink-client-lbx.md`
  — 2026-10-16 PR #4705의 develop 병합 완료. 운영 릴리스는 별도이며 원본과 날짜별 전달 브랜치를 보존한다.
- Dentlink 권한관리 / DL-16317: [projects/dentlink-permission-management.md](projects/dentlink-permission-management.md)
  **대기:** 2026-10-19 사용자 종료 지시. QA 결과/후속 지시 전까지 자동 조회·수정·배포 없이 기존 브랜치/worktree를 보존한다.
  — 2026-10-19 PR4719 사용자release병합(fef630005) 확인 후 stage를 master8772d6882에서 재생성, PR4720 release→stage 준비 후 사용자병합완료(stage4b28c28a6, release와tree동일).
  웹 최신3제품 배포run은 in_progress이며 최종성공/QA는별도다. 기존stage복구ref/전체변경/Actions경계를 정본에 보존했다. 앱은 사용자재승인으로 feature/DL-16317@f037c80 양OS Stagingv336/2.2.4 mandatory100%enabled 전달·서버/소스맵341파일확인완료.
  PR329는 사용자 develop 병합완료(43f7879), 기존Stagingv336·원본worktree/시뮬레이터/Metro를 보존한다. 후속 리뷰 확인에서 최신f037c80에 myungjael LGTM/APPROVED, 리뷰스레드/인라인댓글0건으로 추가수정 없음. CodeRabbit은 develop대상제외 skipped이며 강제실행하지 않았다. 이후 앱QA는 작업브랜치 수정→develop 병합→develop 전체 Staging CodePush로 전달한다. 지금 추가배포하지 않고 QA 결과를 기다린다.

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
