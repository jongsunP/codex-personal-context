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
- Scope: Clinic/Lab 웹과 Office/Lab 앱의 REST 기반 알림 조회·읽음·삭제 및 공통
  딥링크의 병원 전환·화면/동작 실행·알림 읽음 연결
- Current state: 2026-09-03 후속 지침으로 **기기 간 실시간 동기화를 제외**했다.
  현재 기준은 기존 REST 흐름 유지다. 알림 전용 SSE와 읽음·삭제 동기화용 데이터
  FCM은 추가하지 않으며 기존 배송 SSE·사용자 노출 푸시는 별개로 유지한다. 웹·앱
  통합 관리 세션이 개설됐고 별도 프로젝트 폴더/worktree 없이 두 저장소를 함께
  참조한다. 푸시 클릭 시 읽음 요구를 반영했으며 공통 읽음 구현은 미착수다.
  읽음 대상은 알림 ID 직접 전달뿐 아니라 여러 정보를 조합해 처리할 가능성도
  있으며 방식은 미정이다. 목록 읽음 정책은 PM 답변 대기, 구체적인 처리 계약과
  전용 Jira/구현 branch/release는 미정이다. 상세 상태는 아래 체크포인트를 따른다.
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
  `/my/feedback?orderId={orderId}`다. 2026-09-03 최신 master `ddeeb1e86`을 작업 브랜치에
  충돌 없이 병합한 `b5627921b`를 push했고 원격과 동일한 clean 상태다.
  주문상세 배너의 Edit 판단을 클릭 이벤트에도
  전달해 Good 단독 평가의 이벤트 오분류를 수정했으며 기존 WebView/native 분기와 저장은
  유지했다. 현재 확정 요구사항에서 추가로 확인된 웹 FE 코드 수정은 모두 처리했다.
  관리자 세 진입점은 `orderId + reviewerUserId` 상세 GET과 ORDER READ 권한을 사용한다.
  PR #4555는 `release/v1.86.0` 대상 OPEN이며 최신 commit이 반영됐다. 사용자 지시로
  원격 develop을 삭제 후 최신 원격 master에서 재생성했고, 작업 브랜치 → develop
  PR #4571을 생성했다. 기존 개발 배포본에 WebView bridge가 빠진 것을 실제 JS로
  확인했으며, 새 PR merge·배포 후 실기기 확인은 별도다. PR은 임의로 merge하지 않았다.
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
  운영 배포는 별도 상태다. 해당 배포 작업에서 develop은 변경하지 않았다.
  이후 PM 댓글 43892의 최신 Notion 정책을 확인하고 사용자 지시로 원본
  `feature/DL-16258` / `8d3c8ad1e`에서 본문을 수정했다. 공용
  `LimitedWarrantyContent.tsx` 한 파일에서 상품 분류·명칭·보증기간과
  일반 조항을 반영했다. Notion 10개 조항·11개 상품 분류·61개 항목 및 렌더링 문장
  115개를 대조해 누락·불일치 0개, 세 앱 typecheck와 대상 분리 lint·Prettier·diff
  검사를 통과했다. 기본 lint의 기존 설정 충돌은 별도다. 사용자 후속 지시로 본문을
  `89bf047c5`에 commit하고 최신 master `ddeeb1e86`를 충돌 없이 병합했다. 현재 HEAD는
  `f7f81e69a`, push 완료·원격 동일·clean이다. Sheet에서 빠진 워런티 진입점 key 3개를
  표준 export로 복원하고 1,588개 key 정합성을 검증했다. 기본 commit/push hook도 통과했다.
  원격 stage를 삭제하고 최신 master `ddeeb1e86`에서 재생성한 뒤 작업 branch를 직접
  전달하는 [PR #4572](https://github.com/Innvoaid/dentlink-client/pull/4572)를 생성했다.
  `feature/DL-16258 -> stage`, OPEN·MERGEABLE, 16개 파일(+449/-6)이다.
  PR merge·실제 스테이징 배포·브라우저/PM QA는 아직 하지 않았다. 1.86.0 정식 release
  전달도 별도이며, 사용자 후속 지시 전까지 대기한다.
- Personal current checkpoint:
  `projects/dentlink-client-limited-warranty.md`
