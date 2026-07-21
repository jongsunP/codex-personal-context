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
- Command-based type, lint, formatting, diff, browser, and network verification
  does not justify leaving permanent test or support files in the branch.
- Never claim an analytics event is live merely because code is committed or a
  PR exists. Confirm that the exact commit is deployed and observe delivery, or
  clearly label live delivery as pending.
