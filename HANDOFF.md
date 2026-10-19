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
  — 2026-10-19 승인 후 최신 release89@8d209ada9 충돌을 해결하고 f027171bd 커밋·푸시, PR·Jira 정리를 완료했다. 기능·화면 로직 보존, 관련595테스트·타입/lint·패키지/Admin CI 통과. PR#4692는 충돌 해소·미병합·리뷰 필요 상태다.
  이번 통합 범위에서 확인된 추가 필수 코드 작업은 없다. 사용자가 리뷰·병합 진행 소식을 주기로 했으며, 그전에는 병합·하네스·배포·자동 조회 없이 대기한다. 새 release 변경은 재개 시 확인한다. Jira는 Chrome에서 저장 완료했고, 후속 사용자 승인으로 신규 Atlassian 플러그인도 innovaid에 재연결해 DL-16471 실제 조회까지 성공했다. 확인한 웹 재연결 경로는 정본에 남겼다. Legacy 연결은 사용하지 않는다.
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
  PR329 OPEN→develop 유지·본문최신화, 원본worktree/시뮬레이터/Metro 보존·임시buildsource만정리. 후속 리뷰 확인에서 최신f037c80에 myungjael LGTM/APPROVED, 리뷰스레드/인라인댓글0건으로 추가수정 없음. CodeRabbit은 develop대상제외 skipped이며 강제실행하지 않았다. 다음은 웹배포완료 및 앱기기적용/QA·사용자/팀 PR병합 판단이다.

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
