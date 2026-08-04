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
- Current state: the production-shaped Lab English/Korean i18n sample is split
  into five commits and pushed to `origin/feature/i18n` at `57a410355`. The
  user is reviewing it before follow-up fixes or PR work.
- Personal current checkpoint and resume instructions:
  `projects/dentlink-client-i18n.md`

### Dentlink DSO Dashboard

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree:
  `/Users/parkjongsun/Repository/dentlink-client-dso`
- Branch: `feature/DL-15223`
- Jira: `DL-15223`
- Current state: Admin Organization CRUD, Clinic DSO/Office dashboards, My
  Profile settings, Organization access/mobile guards, real dashboard/office/
  billing APIs, existing-statement PDF reuse, outstanding balance, and
  DL-15801 Amplitude click events are implemented. Advanced Export's latest
  Figma selection UI is committed and pushed at `67f0f4017`; its backend API
  integration remains pending. PR #4443 merged only the earlier state through
  `40bfd9526`; newer feature commits are not in `develop` and there is no open
  follow-up PR. Develop integration, deployment revision, and live Amplitude
  delivery remain pending. The current backend policy
  intentionally uses the sole `organizations[0]`; `Visit Office` already
  reuses the existing active-Office transition flow.
- Personal current checkpoint, decisions, and prioritized TODO list:
  `projects/dentlink-client-dso.md`
