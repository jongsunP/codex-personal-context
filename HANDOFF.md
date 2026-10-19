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
  — 2026-10-19 Member 앱 QA의필터50:50과홈기존결제안내403 보완완료. 서버코드상OWNER/PM만허용함을확인해웹/앱전체역할조건정렬.
  앱featurebe332c5·PR329반영및Office iOS/Android Development **v139**(2.2.4·mandatory100%활성)배포/read-back완료. 실제기기OTA적용/전체QA별도.
  웹은release162422ab9기반 `feature/DL-16317-payment-banner@20be3ee65`, **PR4716 OPEN→release/v1.89.0** 생성·미병합. 접두사오류의PR4715는동일SHA/diff로대체후닫았다.
  앱시뮬레이터/Reactotron과필터3+배너임시10검증,웹14tests·3서비스타입·정상push검사PASS. 사용자가배포후앱오류해소·필터적용을확인했다. 웹PR검토·병합·배포후QA가남았다.
  추가BE질문없고새UI/문구/파일없음. 공유의존성/네이티브/lock미변경,배포용임시source정리. 브랜치/worktree와Member시뮬레이터/Metro보존.
  — 최신 예외 감사에서 웹 추가 수정 없음. 앱 채팅·피드백·승인의 일시 오류 복구3건과 입력/첨부/완료 응답 경계를 보완했다.
  949e0f6/dafcad7/6437dbb 정상 커밋·푸시·PR329 본문 갱신, 기존6파일만 변경. 관련69 tests·lint PASS, 타입18진단 기존동일.
  새 UI/문구/정책/파일 없이 기존 refresh/Retry/앱·화면 복귀를 사용한다. Vercel은 사용자 지시로 제외했다.
  — 2026-10-16 DEV QA 후 담당 변경 경고를 보완해 커밋·푸시했고, PR4710은 사용자 병합으로 release/v1.89.0 MERGED.
  merge8daac3561/18:28:16 KST를 GitHub 확인. 사용자가 해당 release 기반 DEV 배포 진행 중이며 완료/새 배포본 QA는 아직이다.
  현재 permission worktree는 release24d3ff18a에서 분기한 feature/DL-16317-dentist-warning@e28b9c7e8·clean이다.
  SSR 문자열/숫자 ID와 다른 본인 Draft 제외 조건 수정, 기존파일2개·관련37 tests/3서비스 타입/정상push검사 PASS.
  **BE 최신 답변으로 정상 종결:** Draft 주문의 환자는 아직 내 환자가 아니므로 통합 Patients 환자217 미포함은 정상이다.
  BE 추가 수정/API 질문으로 남기지 않는다. 기존 Draft 포함 PRD보다 이 사용자 전달 최종 정책을 우선한다.
  DEV Admin/Member 메뉴·필터·NEW/FOLLOW_UP 저장·상세3종·링크·직접 URL·합성 담당 변경/복구 QA 기록을 보존한다.
  Draft9738·9739·9740 보존(제출/결제 없음). 새 수정의 배포본 QA는 아직이다.
  원본 웹 featuref4bfaf1bf와 worktree 보존, PR4700/4706 release 병합·DEV 사전 테스트 배포 기록 유지.
  앱 PR329 OPEN→develop·featurebe332c5·clean, 미병합 유지. Development v139에최종앱보완포함,실제기기적용후QA한다.
  다음은 사용자 DEV 배포 완료→경고 재확인→스테이징 QA, 앱은 PR329 포함 버전으로 실기기 QA.
  다른 역할·승인 대기 쓰기·다주문 지연 등 미실시 범위와 배포/Member 활성화 순서는 상세 체크포인트를 따른다.
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
