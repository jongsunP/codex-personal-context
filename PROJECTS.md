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

### Dentlink Lab i18n

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree:
  `/Users/parkjongsun/repository/dentlink-client-i18n`
- Branch: `feature/i18n`
- Current state: design QA is in progress. The pushed head remains
  `dc44bc492`, with eight directly actionable QA items implemented locally but
  not yet committed or pushed. Lab Korean i18n now contains 1,497 keys; the
  two operational Sheet tabs are 1:1 role-based views with 1,497 identical
  message IDs, single-source request columns, and representative page values.
  Nine PM/design-to-developer requests and one developer-to-PM/design request
  are intentionally deferred. Capture expansion is paused while existing
  capture links remain preserved.
  Lab, Clinic, and Admin now share the Pretendard and letter-spacing policy;
  Clinic web and PDF were fully migrated from Lato. All three package versions
  are 1.84.0. Draft comparison PR #4461 currently targets `master`; the desired
  production target is `v1.84.0` on 2026-08-24, after which the finalized
  release must propagate forward to `master` and `release/v1.85.0`. The 1.85
  release is also still receiving features, so current conflict checks are
  preliminary and must be repeated after both release contents are finalized.
  Three QA items remain decision/reproduction dependent: status-chip sizing,
  the Step 4 Scan overlap report, and the order-category popup line break.
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
- Current state: Jira/Notion/Figma 기반 1차 FE 플래닝과 하위 카드 재구성을
  완료했다. 공통 API·상태 관리와 첫 앱 작업의 기술 검증을 별도 카드로 분리했으며,
  앱을 제외한 산정은 플래닝 포함 5 points다. 앱 기술 검증과 구현은 미산정이다.
  `origin/master` 기준 전용 worktree와 의존성/Husky 준비는 완료했지만 제품 코드는
  아직 수정하지 않았고 feature branch도 원격에 push하지 않았다.
- Personal current checkpoint:
  `projects/dentlink-client-order-feedback.md`
