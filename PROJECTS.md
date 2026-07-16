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

### Dentlink Invite

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Canonical local worktree: `/Users/parkjongsun/repository/dentlink-client`
- Active branch: `feature/DL-14232`
- Develop follow-up worktree:
  `/Users/parkjongsun/repository/dentlink-client-invitation-api-develop`
- Develop follow-up branch: `codex/DL-14232-followup-develop`
- Personal current checkpoint and history:
  `projects/dentlink-client-invite.md`

### Dentlink PDF Label Conversion (Completed)

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Former worktree: `/Users/parkjongsun/Repository/dentlink-client-pdf`
- Delivery branch: `feature/DL-15438`
- Personal completed checkpoint:
  `projects/dentlink-client-pdf.md`
