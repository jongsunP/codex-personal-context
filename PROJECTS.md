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
- Default branch: `main`
- Role: ongoing product-development scope connected to Dentlink web. Web is the
  primary workload, but mobile app work is active and must be developed
  alongside web when a feature or user flow spans both; its task volume may be
  smaller or intermittent.
- Current state: initial macOS setup is complete at `51aeb1520`. Office
  development login and the first Home dashboard are verified on both the API
  36 ARM64 `Dentlink_API_36` Android AVD and an iOS 26.5 ARM64 simulator.
  Android is the normal local path. iOS required an isolated simulator-only
  proof build without MLKit face detection plus temporary Codegen header
  aliases; the committed project still needs a durable simulator compatibility
  fix. Metro and Reactotron runtime connections were verified, and the shared
  repository remains clean. See the checkpoint for baseline issues.
- Personal current checkpoint:
  `projects/dentlink-app.md`

### Dentlink Lab i18n

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree:
  `/Users/parkjongsun/Repository/dentlink-client-i18n`
- Branch: `feature/i18n-maintenance`, based on `release/v1.84.0`
- Current state: the complete i18n implementation, including DL-16083, was
  merged by PR #4518 into `release/v1.84.0` at `7a7c0138b`. PR #4520 merged
  that release into `stage` at `e822d9707`; both commits have the same tree and
  the user confirmed staging deployment. Documentation-only follow-up PR #4522
  is open and mergeable from `feature/i18n-maintenance` to
  `release/v1.84.0` at `c6b3ae200`.
  Lab Korean i18n now contains 1,528 keys; the
  two operational Sheet tabs are 1:1 role-based views with 1,528 identical
  message IDs, single-source request columns, and representative page values.
  Capture expansion is paused while existing capture links remain preserved;
  remaining product/API decisions are recorded in the detailed checkpoint.
  Lab, Clinic, and Admin now share the Pretendard and letter-spacing policy;
  Clinic web and PDF were fully migrated from Lato. All three package versions
  are 1.84.0. Production master integration is not complete; after assembled
  release QA, the finalized `v1.84.0`
  release must propagate forward to `master` and `release/v1.85.0`. The 1.85
  release is also still receiving features, so current conflict checks are
  preliminary and must be repeated after both release contents are finalized.
  The directly actionable web cards, including DL-16013, are `Ready for
  Deploy`. DL-16013 now uses content-based shared status-chip widths with the
  Figma spacing across Clinic, Lab, and Admin while preserving the existing
  flat/icon/text-mode contracts. DL-16072 is also `Ready for Deploy` after the
  common term was decided as `리메이크`; app cards are tracked separately.
  DL-16053 and new DL-16080 remain `진행 중` because their displayed prose and
  button labels come from API templates and need an explicit scope decision.
  Future fixes discovered after a feature has entered a release must branch
  from the latest remote release and return to that release by PR; do not keep
  appending commits to the historical feature branch. Dentlink's exact
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
- Dedicated worktree:
  `/Users/parkjongsun/Repository/dentlink-client-linktalk-unread`
- Branch: `feature/DL-16002`
- Jira: parent `DL-14984`, FE subtask `DL-16002`
- Current state: Clinic/기공소 홈 LinkTalk의 All/Unread 필터 구현과 사용자 로컬
  기능·모바일 스타일 확인을 완료했다. PR #4513은 `release/v1.85.0` 대상으로 open,
  mergeable이며 CodeRabbit 성공·미해결 thread 0개다. 동료 승인과 merge를 기다린다.
- Personal current checkpoint:
  `projects/dentlink-client-linktalk-unread.md`

### Dentlink Admin Invitation 필터

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree:
  `/Users/parkjongsun/Repository/dentlink-client-invitation-filter`
- Branch: `feature/DL-16004`
- Jira: `DL-16004`
- Current state: Admin 이메일 알림과 CRM 필터에 Invitation 옵션을 추가했고 사용자
  로컬 기능 확인을 완료했다. PR #4512는 `release/v1.85.0` 대상으로 open,
  mergeable이며 CodeRabbit 성공·미해결 review thread 0개다. 동료 승인을 기다린다.
- Personal current checkpoint:
  `projects/dentlink-client-admin-invitation-filter.md`

### Dentlink 주문 피드백 수집

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree:
  `/Users/parkjongsun/Repository/dentlink-client-order-feedback`
- Branch: `feature/DL-15828`
- Jira: parent `DL-15828`
- Current state: 최신 Figma의 Clinic PC·모바일 웹과 APP 영역을 분리해 전수 대조했고,
  `/my/feedback`, 마이페이지 Quick Links·My Office 모달, 목록·상세 입력, 주문 상세
  피드백 배너와 API 교체 가능한 mock/query 경계를 구현했다. PC 10개 페이지네이션과
  모바일 5개 단위 무한스크롤을 실제 Chrome에서 검증했고, 모바일 웹 목록 배경과
  하단 여백을 Figma에 맞춘 최신 제품 commit은 `e56275ec6`이다.
  `origin/feature/DL-15828`과 동일한 clean 상태이며 PR은 없다. APP 디자인은 확인했지만
  native 구현은 이 웹 저장소 범위가 아니다. 배포 Swagger에는 아직 주문 피드백
  계약이 없어 실제 API·eligibility·pagination/count·상품별 artwork 연동은 대기
  중이다. 앱을 제외한 산정은 관리자 임시 0.5점을 포함해 5.5 points이며 앱 기술
  검증·구현·알림은 미산정이다.
- Personal current checkpoint:
  `projects/dentlink-client-order-feedback.md`
