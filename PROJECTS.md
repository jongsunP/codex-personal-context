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
- Current state: the full Lab frontend-owned static-text pass is implemented
  with fixed Korean UI and English fallback, synchronized with the canonical
  Sheet, merged with `origin/master` through v1.82.0, and pushed to
  `origin/feature/i18n` at `2b5d0acfd`. The tree is clean and no PR exists;
  PM wording review, browser/shared-consumer QA, and PR creation remain.
- Personal current checkpoint and resume instructions:
  `projects/dentlink-client-i18n.md`

### Dentlink DSO Dashboard

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree: merge 후 로컬 삭제 완료
- Last branch: 로컬 `DL-15223-qa` 삭제, 원격 브랜치는 보존
- Jira: `DL-15223`
- Current state: release QA에서 바로 처리 가능한 Clinic/Admin DSO 기능과 디자인 QA를
  `DL-15223-qa`에 반영했고, PR #4484는 `release/v1.83.0`에 merge commit
  `41de67a8f`로 반영됐다. 대시보드와 Billing의 Office 및 status 필터 복수 선택
  회귀 수정도 포함됐다. 전용 worktree와 로컬 브랜치는 정리했으며 원격 head
  브랜치는 보존했다. Frankie 담당 카드 중 구현 가능한 13건은 Ready for Deploy이고,
  DL-15906 카테고리 활성화 API와 DL-15937 Advanced Export 전용 Dentist API만
  백엔드 배포 대기로 To Do에 유지한다. `origin/stage`에는 DSO merge commit이
  포함돼 있고, 사용자 확인 기준 스테이징 서버 배포 후 나머지 범위의 재 QA를
  진행 중이다.
- Personal current checkpoint, decisions, and prioritized TODO list:
  `projects/dentlink-client-dso.md`
