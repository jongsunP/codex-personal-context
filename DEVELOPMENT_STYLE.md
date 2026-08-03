# Development Style

## General Style

The user prefers practical, incremental development.

Key preferences:

- Respect existing structure.
- Avoid over-engineering.
- Prefer MVP progress.
- Keep architecture understandable.
- Explain important technical decisions.
- Build from the current stage rather than jumping to a large future design.

## Engineering Bias

When making changes:

- Read existing files first.
- Follow current project patterns.
- Keep edits scoped.
- Avoid unnecessary new abstractions.
- Add documentation when it helps future continuity.
- Prefer working software and validated flows over speculative architecture.

## Project-Aligned Implementation

When extending an existing product codebase, the goal is not to implement the
request as an isolated new solution. First discover how the project already
solves the same class of problem, then preserve its components, props, hooks,
types, state ownership, and layout conventions while meeting the requirement.

"Follow the existing project" applies to the whole implementation method, not
only CSS, naming, or visual similarity. Before coding, inspect the closest
production implementation in the same app and current base version, then match
its component boundaries, hook placement and signatures, API/query/mutation
flow, cache behavior, state ownership, generated types, loading and error
handling, routing, responsive layout, imports, and naming. Do not substitute a
personally preferred pattern merely because it also works.

Use this decision order:

1. Same concept: use the existing component and existing props.
2. Small presentation difference: prefer usage-level composition or a minimal
   additive prop whose default preserves existing behavior.
3. Repeated genuinely new concept: add a shared component, but build it on the
   existing interaction primitives and tokens.
4. Shared change: search all consumers and verify side effects before treating
   the current screen as correct.

Avoid wrappers that only rename existing JSX, unexplained percentage widths,
arbitrary fixed heights, duplicated state abstractions, and new patterns that
appear nowhere else in the app.

## Existing UI First

- Use existing Button `size`, `variant`, `color`, `width`, and state props
  before creating styled action-button variants.
- Use Typography variants and theme colors instead of restating font metrics
  and raw colors. Add a palette/theme token when Figma requires a genuinely
  missing color.
- Use the existing icon library instead of drawing local SVGs.
- Use Modal header, footer, body, size, and close props before adding a shell,
  transient-prop adapter, or page-specific dim behavior.
- Preserve Breadcrumb, Header, DataGrid, and other layout primitives when the
  usage composition can be corrected without changing the shared default.
- A dedicated component should encapsulate real domain behavior, remove
  meaningful duplication, or provide reuse; otherwise keep the direct project
  primitive.

## Interaction Components

- Treat dropdown trigger, portaled menu, outside click, Escape, focus restore,
  disabled state, width, and position as one interaction contract.
- Keep Figma hover, focus, open, selected, and disabled states distinct. Do not
  add selected checks, selected-row backgrounds, or table hover unless the
  design calls for them.
- A menu that must escape a table, drawer, or modal must use the project's
  portal/fixed-position pattern and must not gain an accidental inner scroll.
- When a new specialized component replaces a temporary shared modification,
  re-evaluate and remove the shared modification if it is no longer needed.
- Generic interaction behavior belongs in the UI component; domain API state
  and workflow-specific orchestration belong in the usage layer.

## Layout, Table, And Scroll

- Reuse the existing table/list component that owns fixed headers and body
  scrolling instead of recreating table CSS cell by cell.
- Decide whether the page, table body, modal, or drawer owns scrolling. Avoid
  double vertical scroll and keep a fixed header outside the scrolling body.
- Distinguish minimum height from maximum/viewport height. Do not turn a design
  minimum into an arbitrary fixed full-screen height.
- Check the sum of container, first/last-cell, and component padding before
  adding padding to every row.
- Let long text and data rows grow naturally. Use stable dimensions only for
  fixed-format controls and containers.

## API, Types, And Loading State

- Follow the current app's data-fetching and mutation style instead of mixing
  in a personally preferred async/await or try/catch structure.
- Match the existing hook boundary as well as its syntax: where data is fetched,
  where redirects and side effects live, how callbacks are exposed, who owns
  loading/error state, and how query keys and invalidation are organized.
- Use the syntax of the library major version on the current base branch.
- Treat generated DTOs and EnumTypes as the contract. Prefer project-style
  domain aliases over repeating string unions.
- Keep child props semantic and generic, such as `isLoading`; do not leak the
  parent's internal `isValidating` or `isSubmitting` implementation into the
  child API.
- Scope loading and duplicate-request guards to the affected row, field, or
  action. Do not disable every dropdown for an unrelated mutation.
- Use optimistic cache updates only with a clear rollback path, then invalidate
  the narrow query scope needed after success.
- Preserve default refetch behavior unless a demonstrated problem justifies a
  change.
- Add refs/effects only when they solve a concrete stale-closure, race, or
  synchronous duplicate-request problem that state alone cannot solve.

## Dentlink Client Implementation Defaults

These defaults were consolidated from the full `feature/DL-15223` lifecycle:
Admin and Clinic implementation, changing Figma and comments, Swagger/API
rollout, authentication and authorization, PDF reuse, generated files, browser
QA, and analytics. They are not rules learned only from DL-15801 or Amplitude.

Treat them as reusable project-aligned defaults for new `dentlink-client`
features, not as permission to ignore newer code or a verified exception.
Recheck the closest implementation in the target app and current branch before
applying them.

- Before editing, reconcile the Jira parent and related FE cards/comments,
  FigJam flow, target Figma nodes/variants/comments, deployed Swagger contract,
  live branch state, and the closest production implementation in the same app.
  Keep inaccessible, undecided, and backend-pending items explicit rather than
  completing them by assumption.
- Work in replaceable stages when requirements arrive asynchronously: preserve
  a clean UI/data boundary while an API is pending, regenerate and inspect the
  deployed contract when it arrives, then connect it through the app's existing
  service, domain type, and query layer. Do not leave fixtures mixed into the
  server-backed result after migration.
- Treat Figma as the source for product intent, information hierarchy, states,
  interactions, and intentional visual details rather than an instruction to
  duplicate every pixel with new CSS. Read sibling variants and comments, then
  verify the relevant real browser state before claiming design alignment.
- Place cross-cutting behavior at its narrowest owning boundary. For example,
  resolve a default landing view in the login destination flow instead of
  redirecting every authenticated navigation, and treat menu visibility and
  direct-route authorization as separate protections.
- Keep implementation, local checks, user visual QA, integration, deployed
  revision, real-data verification, and live analytics delivery as distinct
  completion states. A commit or successful push proves only the states that
  were actually checked.
- When the user asks only whether a feature is complete or what functionality
  remains, report actionable product-development work only. Do not mix in PR
  integration, deployment revision, real-data regression QA, live analytics
  receipt, or external comment-posting status unless the user also asks for
  delivery, QA, operations, or full checkpoint status.

- Keep Clinic and Admin patterns separate. A Clinic feature should follow the
  nearest Clinic screen, hook, service, routing, and state-ownership pattern;
  an Admin feature should follow the nearest Admin CRUD, form, query, and table
  pattern. Do not transfer a sibling app's style merely because it is in the
  same monorepo.
- Treat Swagger generation output as the transport contract. Handwritten model
  and feature code should consume the repository's app-facing exports, domain
  types, and API wrappers; do not import generated `data-contracts` directly
  from a handwritten feature type merely to save a small type definition.
- Keep query and mutation ownership at the same hook or service boundary used
  by neighboring code. Components should receive semantic data, loading state,
  and callbacks rather than mutation objects or duplicated invalidation and
  navigation logic.
- Match selection cardinality end to end. If the UI allows multiple values and
  the API accepts an array, preserve every selected value in state and the
  request. Define sentinel options such as `all` explicitly so selecting it
  clears specific values and clearing the final specific value restores the
  intended default.
- When a selector must offer the complete set from a paginated endpoint, do not
  silently treat the first `100` records as complete. Use the existing
  server-search interaction when available, or page until the response total
  is satisfied.
- Use Dentlink's shared date and currency utilities for user-visible values and
  derive the locale/date format from the real Organization, Office, or user
  country context. Keep API date parameters in the contract format through the
  same utility; avoid direct `date-fns` formatting, string replacement, and a
  hardcoded locale when a shared formatter already owns the rule.
- Extend an existing shared input with a minimal optional prop when the
  difference is real and reusable. For programmatic form updates, add a
  controlled `value` path while preserving the existing uncontrolled
  `defaultValue` or `defaultValues` behavior and defaults for all current
  consumers.
- When design arrives before an API, keep fixture data behind a boundary that
  can be replaced by the normal query layer. Once a real API is deployed,
  regenerate and inspect the contract before replacing fixtures; do not invent
  endpoints, fields, or response behavior that are still undecided.

## Figma And QA

- Inspect the provided node and sibling variants for desktop, mobile, long
  text, empty/loading, and status-specific states. A single screenshot is not
  the entire requirement.
- Review the full flow: entry point, list, detail, modal/drawer, dropdown,
  status actions, closing, back navigation, portal stacking, and scrolling.
- Compare Figma with the real browser when visual QA is in scope. For states
  unavailable in live data, compare Figma with the exact conditional code.
- Respect explicit unsupported surfaces; do not mark them missing or invent a
  responsive feature without a requirement.
- Separate implemented code, user visual QA, and merge readiness. Passing in
  the current branch does not imply readiness when the base branch has
  conflicts or major dependency drift.

## Feedback And Completion

- Treat one concrete user example as a request to search all equivalent
  occurrences. Fix the underlying pattern, not only the quoted line.
- Treat user-verified and QA-corrected behavior as a protected baseline. Before
  a later cleanup, responsive pass, refactor, or adjacent feature edit changes
  the same area, inspect the prior fix and preserve it unless the new
  requirement explicitly conflicts. If it conflicts, explain the tradeoff and
  get the user's direction instead of silently replacing the verified behavior.
- When told to make code match the project, compare neighboring imports,
  component props, hook syntax, types, state ownership, and naming rather than
  performing a cosmetic rename.
- If the previous UI was closer to the design, determine whether the right
  answer is a rollback or a smaller project-aligned correction.
- After feedback, review in three scopes: today's edits, the affected app or
  feature, then the full branch/shared blast radius.
- Run type/lint after a coherent edit set instead of after every small change.
  Run builds when requested or when the risk justifies them.
- Report existing warnings separately from failures and state test gaps rather
  than overstating completion.

## User-Directed Scope Discipline

- Do not invent or use an agent-specific branch prefix such as `codex/` in the
  user's repositories. Before proposing or creating a branch, inspect and
  follow that repository's established taxonomy, such as `feature/` or
  `release/`. If the repository convention is still ambiguous, ask the user.
- Name a branch for its intended delivery scope. When a branch is meant to
  collect multiple QA fixes for one release, use the release QA purpose rather
  than the first Jira card alone; for example, `feature/v1.79.0-qa` for fixes
  targeting `release/v1.79.0`.
- For every pull request, read and follow the repository's PR skill before
  committing or creating the PR. A normal request to commit, push, and open a
  PR stops after PR creation; do not wait for, monitor, or respond to
  CodeRabbit automatically. Run the full CodeRabbit closeout flow only when the
  user explicitly asks to handle the review, such as `리뷰까지 처리해줘`:
  validate each finding, implement or leave a reasoned reply, resolve every
  addressed thread, push any follow-up commit, and recheck until no unresolved
  CodeRabbit thread remains or a concrete blocker is reported. PR merge remains
  separate unless explicitly requested.
- In every Dentlink repository, a generic request to commit, upload, or push
  does not authorize using an admin or ruleset bypass to push directly to a
  protected `master`, `develop`, or `release/*` branch. If a direct protected
  branch push is technically appropriate because a separate delivery branch
  would add little value, first verify the protection and current bypass
  capability, explain the direct-push path and its alternatives, obtain the
  user's explicit approval, and only then proceed. Report a server-authorized
  bypass as a bypass even when no `--force` option was used.
- Judge scope by traceable causality to requirements, design, explicit user
  direction, and branch history. A shared file or broad visual diff is not
  automatically over-scoped.
- Before reverting a suspicious change, inspect its introducing commits, Jira
  comments and child cards, Notion/Figma context, user instructions, and the
  as-is behavior being corrected. If intent is still ambiguous, ask before
  undoing completed design work.
- When the user limits delivery to PR creation, downstream merge, deployment,
  and automatic workflow status are outside the task. Do not monitor or report
  them unless the user explicitly asks.
- Global lifecycle code has a higher bar than shared styling. Do not move a
  domain event into `_app`, add storage handoffs, or introduce app-wide effects
  when the owning mutation or workflow already provides the exact lifecycle
  point.
- Treat transient styled-component props such as `$isFull` as correctness work
  when they preserve the requested style while preventing style-only props from
  leaking to the DOM; do not classify them by filename alone.
- Do not add new test files, dedicated analytics mapper files, analysis
  artifacts, helper modules, or documentation merely because they would make
  verification or organization easier. Add them only when the user explicitly
  requests them or after explaining a repository-required need and receiving
  approval.
- For instrumentation work, first follow the feature's existing `AMP_Track`
  placement and property-construction style inside the existing domain files.
  Verify event names and properties against the requested Notion/Jira source,
  but do not introduce a new analytics abstraction by default.
- Preserve the source's event semantics: a CTA `click` event belongs at the
  actual click boundary before validation, navigation, or mutation, while a
  success event belongs only after the confirmed outcome. Do not relabel one as
  the other for implementation convenience.
- When an analytics brief lists dwell time as an analysis goal but specifies no
  manual duration event, verify the app's existing page-view and session
  capture before inventing another event.
- Command-based type, lint, formatting, diff, browser, and network verification
  does not justify leaving permanent test or support files in the branch.
- Never claim an analytics event is live merely because code is committed or a
  PR exists. Confirm that the exact commit is deployed and observe delivery, or
  clearly label live delivery as pending.
