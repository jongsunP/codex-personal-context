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
- Current state: initial macOS setup and Office development login/Home proof are
  complete. The active checkout is clean on `feature/DL-16061` at `9f66fa3`
  and synchronized with its upstream. PR #286 is open, mergeable and Ready for
  review; CodeRabbit is successful with no unresolved review thread. The
  deployed feedback API, cache and existing multipart-upload integration are
  implemented. Android API 36 directly verified Profile, To Review/Reviewed,
  the completed-order Clinic WebView feedback banner and its native detail and
  Image Upload landing. The FE code scope is ready for app-developer review.
  Real POST/PUT/upload mutation QA, physical-device QA, a fresh committed-source
  Apple Silicon iOS build, and DL-16066 notification/deep-link work remain
  separate gates.
- Personal current checkpoint:
  `projects/dentlink-app.md`

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

### Dentlink 주문 피드백 수집

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree:
  `/Users/parkjongsun/Repository/dentlink-client-order-feedback`
- Branch: `feature/DL-15828`
- Jira: parent `DL-15828`
- Current state: Clinic PC·웹 모바일의 `/my/feedback`, 마이페이지 Quick Links·My
  Office 모달, 목록·상세 drawer·파일 첨부, 주문 상세 배너를 실제 Office 피드백
  GET/POST/PUT API와 React Query cache에 연결했다. 딥링크는
  `/my/feedback?orderId={orderId}`이며 최신 제품 commit `ba8a9c186`이
  `origin/feature/DL-15828`과 동일한 clean 상태다. 개발서버 확인용 PR #4541은
  물론 후속 동기화 PR #4542·#4543도 `develop`에 merge됐다. 이후 원격 `develop`을
  최신 `master`로 재생성하고, 기존 피드백 상태와 `release/v1.85.0`을 합친 통합
  branch `feature/DL-15828-develop-v1.85.0-integration` / `bcf55a61c`에서 새
  `develop` 대상 PR #4546을 merge했으며 사용자가 개발서버 배포를 완료했다. 임시
  통합 worktree와 로컬 branch는 제거했고 원격 branch는 보존했다. 원본 피드백
  branch는 변경하지 않았다.
  2026-08-28 실제
  eligible 주문으로 목록/count, 주문 상세 배너, 딥링크 상세 GET, PC·웹 모바일
  drawer와 Photo/Camera/File 선택 UI를 Chrome에서 확인했다. 실제 Good/Bad POST,
  상세 PUT과 업로드·삭제는 서버 데이터를 바꾸므로 별도 QA가 남아 있다. 첨부 제한은
  현재 최대 5개·총 200MB이나 Notion과 Figma의 일부 문구가 상충해 확정이 필요하다.
  웹 구현 Jira 카드는 `Ready for Deploy`, 상위는 `진행 중`, 관리자 DL-16065는
  스펙 미확정으로 `해야 할 일`이다. 정식 release PR은 아직 없다. 앱은 별도
  `dentlink-app` 저장소·세션에서 진행한다.
- Personal current checkpoint:
  `projects/dentlink-client-order-feedback.md`
