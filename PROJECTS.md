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
  `/Users/parkjongsun/Repository/dentlink-client-i18n`
- Branch: `feature/i18n`
- Current state: the Lab Korean-default i18n implementation and reusable
  usage/capture audit workflow are pushed to `origin/feature/i18n` at
  `98caa6e20`. The canonical Sheet separates nondeveloper wording review from
  developer use-site details with cross-tab formulas. Developer columns now
  keep page, screen state, marker, capture URL, and route as one location group.
  The shared fields in both operational tabs now use the same names, including
  `위치 번호` and `캡처`; the source code changes for this normalization remain
  local and uncommitted pending explicit project commit/push authorization. All
  1,959 use sites and 251 captured occurrences remain.
  Exhaustive conditional-state capture, PM/PD
  review, final Lab/Clinic/Admin QA, and PR creation remain.
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
