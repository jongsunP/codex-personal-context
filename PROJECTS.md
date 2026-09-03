# Projects

Common Codex guidance lives in the repository root. Each project has a personal
configuration, current checkpoint, and history under `projects/`; see
`projects/README.md` for the required structure and lifecycle.

## Repository Folder

The user's personal repositories are generally located under:

```text
/Users/parkjongsun/Repository
```

Check this folder first when finding or continuing local projects.

## Projects

### Action Sports Journal

- Repository: `https://github.com/jongsunP/action-sports-journal-app`
- Local path: `/Users/parkjongsun/Repository/action-sports-journal-app`
- Product: action sports life log platform
- Current design center: Session

Domain flow:

```text
ActivityGroup -> Session -> AnalysisResult -> ShareResult
```

Important principle:

AI is one product feature, not the whole product.

Current preference:

- MVP-centered development
- Validate real user flow before large infrastructure
- Do not prematurely add database, login, production backend, RAG, coupons,
  expenses, calendar, or unrelated product features

For detailed current state, read:

- Personal current checkpoint and history:
  `projects/action-sports-journal-app.md`
- Cross-project personal continuation context: `HANDOFF.md`
- Stable team-owned project documentation when relevant:
  project-local `README.md`, `AGENTS.md`, and architecture/product docs

### Dentlink E2E Stabilization

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Local workspace: `/Users/parkjongsun/repository/dentlink-client`
- Use this main workspace unless the user explicitly requests another
  worktree.
- Release target: `release/v1.79.0`
- Current state: PR #4411 merged; wait for staging deployment, then run the
  final local and staging E2E matrix.
- Personal current checkpoint and history:
  `projects/dentlink-client-e2e.md`

### Dentlink Mobile App

- Shared repository: `https://github.com/Innvoaid/dentlink-app`
- Main local checkout: `/Users/parkjongsun/Repository/dentlink-app`
- Repository default branch: `main`; active feature base/PR target: `develop`
- Role: ongoing product-development scope connected to Dentlink web. Web is the
  primary workload, but mobile app work is active and must be developed
  alongside web when a feature or user flow spans both; its task volume may be
  smaller or intermittent.
- Current state: initial setup and Office native feedback/API/deep-link/WebView
  integration are implemented. Latest `feature/DL-16061` commit `919a884`
  includes account-scoped cleanup, file-size checks and upload cancellation
  from the follow-up reviews.
  PR #286 remains open with three develop conflicts; do not infer merge-ready
  from local checks or a resolved review thread. Notification design rows exist
  but their real setting API mapping awaits BE pushType release. The canonical
  current review result, Git state and separate runtime proof boundaries are
  maintained in the personal checkpoint below rather than duplicated here.
- Personal current checkpoint:
  `projects/dentlink-app.md`

### Dentlink 통합알림센터 — 사전 검토

- Shared repositories: `Innvoaid/dentlink-client`, `Innvoaid/dentlink-app`
- Scope: Clinic/Lab 웹과 Office/Lab 앱의 REST 기반 알림 조회·읽음·삭제
- Current state: 2026-09-03 후속 지침으로 **기기 간 실시간 동기화를 제외**했다.
  현재 기준은 기존 REST 흐름 유지다. 알림 전용 SSE와 읽음·삭제 동기화용 데이터
  FCM은 추가하지 않으며 기존 배송 SSE·사용자 노출 푸시는 별개로 유지한다. 읽음
  정책은 PM에게 요청한 상태이며 구현은 아직 시작하지 않았다. 전용 Jira/branch/
  worktree/세션/release는 미정이다. 별도 작업 환경 생성 전에는 메인 관리 세션에서
  문의를 이어갈 수 있으며 다른 세션에서도 같은 체크포인트를 읽는다.
- Personal current checkpoint:
  `projects/dentlink-unified-notification-center.md`

### Dentlink Lab i18n

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Current state: the complete i18n implementation and operating documentation
  are in `master` through `Release/v1.84.0 -> master` (`8e05cbb84`), and the
  user confirmed production deployment. Live verification on 2026-08-25 found
  `master` clean and synchronized with `origin/master`, with the required Lab
  locale, provider, manifest, Sheet client, and i18n skill files present.
- Local closeout: the dedicated
  `/Users/parkjongsun/Repository/dentlink-client-i18n` worktree and local
  `feature/i18n` / `feature/i18n-maintenance` branches were deleted on
  2026-08-25. Matching remote branches were intentionally preserved. There is
  no active dedicated i18n worktree.
- Future i18n changes must start on a fresh feature branch from the current
  release-plan base, not from either historical i18n branch. Dentlink's exact
  staging-server branch is `stage`, not `staging`.
- Personal current checkpoint and resume instructions:
  `projects/dentlink-client-i18n.md`

### Dentlink DSO Dashboard

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree:
  `/Users/parkjongsun/Repository/dentlink-client-dso`
- Current local branch: `feature/DL-15906-DL-15937-develop`
- Jira: `DL-15223`
- Current state: 백엔드 대기였던 DL-15906과 DL-15937 API까지 Clinic/Admin에
  반영해 FE 개발 범위를 완료했다. release 전달 PR #4490, develop 전달 PR #4491,
  `release/v1.83.0 -> stage` PR #4492가 모두 merge됐다. 사용자 확인 기준 릴리즈
  준비와 스테이징·개발서버 배포가 진행 중이며, 배포 완료 후 최종 QA 1회를 통과하면
  DL-15223 DSO 작업을 종료하는 단계다. 현재 알려진 추가 FE 개발 항목은 없다.
- Personal current checkpoint, decisions, and prioritized TODO list:
  `projects/dentlink-client-dso.md`

### Dentlink 홈 LinkTalk 미확인 필터

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Jira: parent `DL-14984`, FE subtask `DL-16002`
- Current state: 기존 구현 PR #4513은 `release/v1.85.0`에 merge됐다. QA 후속
  DL-16226 미읽음 카운트 동기화와 DL-16227 Case Preference 빈 상태 안내는
  PR #4544로 `release/v1.85.0`에 merge됐다. 원격 `stage`는 최신 `master`로
  재생성했으며 배포 PR #4545가 `release/v1.85.0`에서 `stage` 대상으로 열려 있다.
  전용 worktree와 관련 로컬 feature 브랜치는 제거했고 원격 PR head는 보존했다.
- Personal current checkpoint:
  `projects/dentlink-client-linktalk-unread.md`

### Dentlink Admin Invitation 필터

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Jira: `DL-16004`
- Current state: Admin 이메일 알림과 CRM 필터에 Invitation 옵션을 추가했고 사용자
  로컬 기능 확인을 완료했다. PR #4512는 `release/v1.84.0`에 merge됐다. 전용
  worktree와 로컬 feature 브랜치는 제거했고 원격 브랜치는 보존했다.
- Personal current checkpoint:
  `projects/dentlink-client-admin-invitation-filter.md`

### Dentlink Admin 주문 Case Preference 배치

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Jira: `DL-16269`
- Current state: Admin 주문 생성·수정 2~4단계에서 Case Preference를 우측 액션
  버튼 아래에 노출하도록 수정했다. `feature/DL-16269`의 CodeRabbit 후속 commit
  `be31e3596`까지 원격과 동기화됐고, 최신 `origin/master`에서 생성한
  `release/v1.85.1` 대상 PR #4558은 open·review required 상태다. CodeRabbit
  재검토는 성공했고 unresolved thread는 0개다. 사용자가 기능과 기본 배치 및 마지막
  30px 간격을 포함한 최종 화면 노출을 로컬에서 확인했다.
- Personal current checkpoint:
  `projects/dentlink-client-admin-case-preference.md`

### Dentlink 주문 피드백 수집

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree:
  `/Users/parkjongsun/Repository/dentlink-client-order-feedback`
- Branch: `feature/DL-15828`
- Jira: parent `DL-15828`
- Current state: Clinic PC·웹 모바일의 `/my/feedback`, 마이페이지 Quick Links·My
  Office 모달, 목록·상세 drawer·파일 첨부, 주문 상세 배너를 실제 Office 피드백
  GET/POST/PUT API와 React Query cache에 연결했다. 딥링크는
  `/my/feedback?orderId={orderId}`다. 2026-09-03 최신 제품 commit `263203463`을
  push했고 원격과 동일한 clean 상태다. 주문상세 배너의 Edit 판단을 클릭 이벤트에도
  전달해 Good 단독 평가의 이벤트 오분류를 수정했으며 기존 WebView/native 분기와 저장은
  유지했다. 현재 확정 요구사항에서 추가로 확인된 웹 FE 코드 수정은 모두 처리했다.
  관리자 세 진입점은 `orderId + reviewerUserId` 상세 GET과 ORDER READ 권한을 사용한다.
  PR #4555는 `release/v1.86.0` 대상 OPEN이며 최신 commit이 반영됐다. develop은
  PR #4559 반영 이후의 코드리뷰 수정·WebView bridge·이번 이벤트 수정이 미반영 상태다.
  완료 후 취소 주문의 배너 정책은 Notion과 기존 Figma/코드가 충돌하므로 확정 대기이며
  QA·배포·Jira 정리는 이번 코드 작업 범위에서 제외했다. 첨부는 5개·총 200MB를 유지한다.
  앱은 별도 저장소·세션에서 진행하며 신규 알림 설정 DL-16285는 pushType 계약 대기다.
- Personal current checkpoint:
  `projects/dentlink-client-order-feedback.md`

### Dentlink Limited Warranty

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Jira: `DL-16258`
- Current state: 과거 `frankieTemp/DL-10132`에서 보류됐던 Warranty 작업을 최신
  `master` 기준 `feature/DL-16258`로 이식하고 현재 프로젝트 관례에 맞게 정리했다.
  2026-09-03 사용자가 PR #4556의 대상을 `release/v1.86.0`에서 `release/v1.85.1`로
  변경하고 merge했다. release commit은 `8d0744936`이며 사전 검토한 병합 결과와
  동일하다. Clinic/Lab/Admin 타입 검사와 번역 보존 검사를 통과했다. Warranty 번역
  3개의 Sheet 반영은 완료됐으며 공통 i18n 운영 개선 PR #4557도 이미 1.85.1에 포함됐다.
  원격 `stage`를 삭제하고 최신 원격 `master`와 같은 `4fc3b4877`로 재생성했으며,
  `release/v1.85.1 -> stage` PR #4566은 `24b5af7b7`로 merge됐다. 사용자가 스테이징
  배포 완료를 알렸으며, 실제 서버 SHA와 화면 QA는 이번 후속 기록에서 별도로 확인하지
  않았다. 운영 배포는 별도 상태다. 로컬 branch/worktree는 정리하지 않았다.
  이후 사용자가 Warranty를 이번 1.85.1 배포에서 제외한다고 결정했다. 당시 원격 release의
  마지막 commit `8d0744936`만 되돌렸으며 독립 i18n 운영 개선은 유지했다.
  사용자 지시 후 새 `feature/DL-16258-release-hold`에서 역변경 commit `af496bb34`를
  push하고 같은 release 대상 제외 PR #4567을 생성했다. 결과 tree는 워런티 반영 직전과
  정확히 같으며 세 앱 타입·다국어 정합성·기본 push hook을 통과했다. 사용자가 #4567을
  merge해 최신 release는 `b9fba70b4`이며 워런티는 제외됐다. 이어서 사용자 요청대로
  원격 stage를 삭제하고 최신 master `4fc3b4877`에서 재생성한 뒤, release 전체를
  전달하는 스테이징 PR #4568을 생성했다. 사용자가 #4568을 `5cb3ddaf3`로 merge했고
  GitHub에서 확인했다. 스테이징 배포 완료는 사용자 확인 기준이며 서버 SHA·화면 QA·
  운영 배포는 별도 상태다. 로컬 checkout은 제외용 branch, clean 상태이고 develop은
  변경하지 않았다. Warranty 재출시 버전은 미정이며 현재 추가 작업 없이 대기한다.
- Personal current checkpoint:
  `projects/dentlink-client-limited-warranty.md`
