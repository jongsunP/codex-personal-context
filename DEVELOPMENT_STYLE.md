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

## Requirement And Design Scope

- Across all projects, confirmed product policy is the first source of truth.
  Follow the design for presentation, but give confirmed policy and backend
  requirements/contracts higher priority when they conflict with a design
  frame. A duplicated or stale frame does not create a new setting, data field,
  or behavior. This is the user's explicit 2026-11-05 instruction.
- Reconcile the latest substantive policy decisions and applicable backend
  contract before treating a design difference as a question. If those sources
  settle it, implement the supported result and record the reason. Use an
  equivalent confirmed platform design where applicable; ask only if a material
  conflict remains. Backend drafts and current implementation are evidence, not
  permission to invent a contract or silently override confirmed product policy.
- Implement the user's confirmed requirements and design. Before adding or
  changing user-visible controls, copy, layout, or interaction outside that
  scope, explain the missing requirement, evidence, reason, and concrete proposal
  and obtain user approval. This also applies to error/retry, empty/loading,
  confirmation, automatic navigation/closing, and mock-driven states.
- Reusing a project component or a familiar UX pattern is implementation
  evidence, not evidence that this screen was requested to have that behavior.
  Do not silently fill a design gap with a preferred UX and present it as specified.
- Separate original PM/design/user sources from Codex-authored Jira descriptions,
  plans, and checklists. An AI-authored document cannot retroactively authorize
  the AI's own addition. State when the original source or approval is unavailable.
- Requirements and design documents may lag behind the actual decisions. Across
  all work, compare the latest substantive edits, Slack discussions and follow-up
  decisions, direct user instructions, and current code, then select the supported
  current interpretation and proceed. A document's overall edit time alone is not
  proof that every section supersedes a later discussion. Record the sources and
  reasoning; do not repeatedly ask the user to reconfirm settled decisions merely
  because an older document or duplicate platform frame was not updated.
  This is the user's explicit cross-project direction from 2026-10-29.
- For an already-confirmed cross-product flow, use its latest applicable design
  and established project components for equivalent platform UI when the evidence
  supports that adaptation. Record an adaptation as such, not as a separately
  verified design. Ask only when source reconciliation cannot resolve a genuinely
  new product/design decision. This does not authorize inventing requirements,
  backend contracts, or expanding Git/publication permissions.
- Audit suspected additions before changing them. Missing evidence is not proof
  that an existing behavior is wrong; distinguish confirmed deviations, additions
  needing a decision, and unavailable evidence. Report impact and a proposed
  correction, then wait for the user's approval when investigation-only was asked.
- Apply this rule within the user's existing authorization. Internal implementation
  choices that preserve confirmed UI and behavior do not need repeated approval.
  Do not remove error handling or accessibility behavior wholesale as an audit fix.
- Within authorized implementation, finish routine design decisions autonomously
  and report remaining ambiguities together after the work is ready. Prefer the
  confirmed design and source evidence rather than asking about every small value.
- When the same element has a repeated value across several final design examples
  and only one example differs, use the repeated value unless there is evidence
  that the exception is intentional. A lone mismatch may be a designer mistake;
  record the judgment and recheck if the designer supplies a new explanation.
  On 2026-10-06, the user explicitly chose 12px for the Lab patient card's internal
  gap because several examples used 12px and only the basic example used 8px.

## Project-Aligned Naming

- For UI labels, page names, categories, and documentation, first use the
  names already defined in the project, design system, requirements, or the
  relevant reference. Preserve the meaning; do not present a reference name
  as an official project term without evidence.
- If no defined name exists, prefer a short, familiar description using the
  project's existing vocabulary. Do not invent terminology that needs a
  separate explanation when a plain project-aligned name is available.
- When a genuinely new name is needed or the choice changes the meaning or
  classification, show the proposed name and its reason to the user for review
  before adopting it. Routine use of clear existing terms needs no extra check.
- A display-name correction does not by itself require renaming internal
  folders, public APIs, routes, or symbols. Preserve compatibility and change
  those only when the task requires it.

## Existing UI First

- Across web and apps, ordinary behavior that has no separately confirmed new
  requirement or design follows the product's existing user experience. Reuse
  the established invocation path as well as the component: toast placement and
  header offsets, providers/portals, duration, focus, dismissal, navigation and
  loading/disabled behavior are part of that contract. This is the user's
  explicit 2026-11-05 direction after the notification-center toast review.
- Do not deliberately give a feature a different default merely because the
  component exposes a prop or a standalone preview is easier to implement.
  Inspect the nearest production usage first. Follow confirmed new designs where
  they intentionally differ; do not use "common sense" to invent new screens,
  controls or unresolved product policy. An apparent bug in the shared component
  must be distinguished from a feature-specific override and assessed by its
  actual affected consumers before changing the global behavior.
- When a user reports an issue in one product, also inspect the equivalent web
  or app flow if it shares the same behavior or credible failure mode. Keep the
  review limited to that related scope, even when the user named only the web.
  This is the user's 2026-11-05 clarification.
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

## Design-System Boundaries

- Keep design-system UI independent of business domains. Order forms, payment
  workflows, chat panels, and other business-specific composites belong to the
  feature or domain layer and must not be classified as design-system primitives.
- Business components may compose generic UI through props, callbacks, and
  children. Generic UI must not import business components or own domain API
  calls, permissions, business states, or workflow rules.
- A component living under a shared `ui` directory does not automatically make
  it part of the design system. Define the catalog and AI-generation component
  scope explicitly; preserve compatibility while planning any folder/export
  separation rather than assuming it is already complete.
- Use domain-neutral catalog categories and sample content. Prefer names from
  the design source; identify any added grouping as a catalog convention.

## Interaction Components

- Treat dropdown trigger, portaled menu, outside click, Escape, focus restore,
  disabled state, width, and position as one interaction contract.
- Keep Figma hover, focus, open, selected, and disabled states distinct. Do not
  add selected checks, selected-row backgrounds, or table hover unless the
  design calls for them.
- A menu that must escape a table, drawer, or modal must use the project's
  portal/fixed-position pattern and must not gain an accidental inner scroll.
- When a dropdown is designed to open over later fields inside a fixed-height
  modal, reuse the modal's existing overflow escape option and keep scrolling
  inside the menu list. Do not make the modal body grow or scroll with the menu,
  and do not invent a different opening direction without a confirmed design.
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
- Use generated DTOs and EnumTypes through the project's existing type
  boundaries, reconciling their source environment with **API Contracts Across
  Environments** below. Prefer project-style domain aliases over repeating
  string unions.
- Keep child props semantic and generic, such as `isLoading`; do not leak the
  parent's internal `isValidating` or `isSubmitting` implementation into the
  child API.
- Scope loading and duplicate-request guards to the affected row, field, or
  action. Do not disable every dropdown for an unrelated mutation.
- If a list or action cannot be used while loading, show the product's existing
  loading feedback in that area. Do not leave an apparently actionable list and
  silently discard clicks. Track loading state during rendering as well as in
  action guards so the UI recovers when the request finishes; a missing design
  frame is not a reason to omit the established loading behavior.
- Use optimistic cache updates only with a clear rollback path, then invalidate
  the narrow query scope needed after success.
- Preserve default refetch behavior unless a demonstrated problem justifies a
  change.
- Add refs/effects only when they solve a concrete stale-closure, race, or
  synchronous duplicate-request problem that state alone cannot solve.

### API Contracts Across Environments

The user clarified this workflow on 2026-11-06. Apply it across projects when
backend environments or their published schemas are at different revisions.

- Where DEV normally precedes STG, as in Dentlink, that rollout order is not
  guaranteed. A change can be delivered to STG first. A field missing from DEV
  Swagger proves only its absence from that schema, not its absence from STG
  or an undecided contract.
- Identify the backend environment relevant to the task. If its confirmed
  contract is ahead of DEV, use that environment's available Swagger. If its
  schema is unavailable or outdated, use the backend-confirmed request/response
  contract supported by actual responses. Do not block authorized FE integration
  solely because DEV Swagger lags behind.
  Record which environment and source support the field; distinguish direct
  inspection from the user's confirmation with backend. Reuse sufficient
  current evidence; this does not require querying every environment or real
  API again for every task.
- In the established Swagger workflow, FE consumes checked-in generated or
  copied types and app/domain models; it does not read Swagger at runtime.
  Trace the type the actual API wrapper and feature consume, and update the
  necessary FE declarations from the confirmed target-environment contract
  through the repository's existing type/export boundaries.
- Keep field presence, boolean value, requiredness, and nullability distinct.
  One response containing a field does not establish that it is required in
  every response or already deployed in other environments. Preserve confirmed
  missing-value behavior and infer no new policy from the rollout difference.
- Keep generation and manual model updates scoped to the task. Do not import
  unrelated generated changes or change the default generator/runtime backend
  environment merely to consume one confirmed contract. Contract reconciliation
  does not itself authorize deployment or work in another product repository.

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
  a clean UI/data boundary while an API is pending. When the contract arrives,
  inspect its target environment and update the needed generated/domain types
  through the established workflow, excluding unrelated generation changes.
  Connect it through the app's existing service, domain type, and query layer.
  Do not leave fixtures mixed into the server-backed result after migration.
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
- Keep Jira implementation comments stable and scoped to the card: summarize
  the implemented change and, when useful, its concise verification evidence.
  Do not write transient deployment wording such as pending deployment,
  staging deployment complete, a CodePush label, or a PR deployment state in
  those comments. Use the card's current workflow status plus live deployment
  evidence to determine delivery state instead. Record deployment details in a
  comment only when the deployment itself is the card's defect or investigation
  subject.
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
- Treat Swagger generation output as a snapshot of its source environment's
  transport contract; reconcile environment differences using **API Contracts
  Across Environments**. Handwritten model and feature code should consume the
  repository's app-facing exports, domain types, and API wrappers; do not import
  generated `data-contracts` directly
  from a handwritten feature type merely to save a small type definition.
- Keep query and mutation ownership at the same hook or service boundary used
  by neighboring code. Components should receive semantic data, loading state,
  and callbacks rather than mutation objects or duplicated invalidation and
  navigation logic.
- Match selection cardinality end to end. If the UI allows multiple values and
  the API accepts an array, preserve every selected value in state and the
  request. Define sentinel options such as `all` explicitly so selecting it
  clears specific values and clearing the final specific value restores the
  intended default. Before extracting or consolidating selection logic into a
  shared helper, record the existing truth table for empty, sentinel, single,
  and multiple values, then verify every consumer against that table. A cleanup
  or helper rename is not behavior-preserving if it silently changes
  cardinality.
- When a selector must offer the complete set from a paginated endpoint, do not
  silently treat the first `100` records as complete. Use the existing
  server-search interaction when available, or page until the response total
  is satisfied.
- Use Dentlink's shared date and currency utilities for user-visible values and
  derive the locale/date format from the real Organization, Office, or user
  country context. Keep API date parameters in the contract format through the
  same utility; avoid direct `date-fns` formatting, string replacement, and a
  hardcoded locale when a shared formatter already owns the rule.
- For a date-only filter whose API already receives the browser IANA timezone
  through `zone-id`, use the browser-local calendar date unless the contract
  provides and requires a more specific entity timezone. Do not infer a current
  date from `countryCode` alone because one country may span multiple timezones.
  Check whether the shared calendar's end boundary is inclusive or exclusive;
  Dentlink's current `enabledEndDate` is exclusive, so passing the next calendar
  day is the existing way to make today the last selectable date, not to permit
  a future date.
- Extend an existing shared input with a minimal optional prop when the
  difference is real and reusable. For programmatic form updates, add a
  controlled `value` path while preserving the existing uncontrolled
  `defaultValue` or `defaultValues` behavior and defaults for all current
  consumers.
- When design arrives before an API, keep fixture data behind a boundary that
  can be replaced by the normal query layer. Once a real API is deployed,
  regenerate and inspect the contract before replacing fixtures; do not invent
  endpoints, fields, or response behavior that are still undecided.
- If a backend-dependent export is not deployed, it is acceptable to complete
  the validated modal and isolated presentation/PDF renderer first, but keep an
  explicit adapter boundary and do not invent the endpoint, request DTO, result
  source, download behavior, or error contract. Reuse existing PDF primitives,
  isolate a genuinely new document from legacy routes, and preserve server-owned
  row ordering unless the contract assigns sorting to the client.
- Separate report business data from presentation context. Before requesting a
  new response field, check the exact PDF design and the authenticated profile
  state already owned by the app. Reuse the existing locale or currency code
  when it is stable product context, and do not add symbols to rows or summaries
  when the design intentionally shows a code only at the grand total.
- For edit forms whose detail response may include nullable or unassigned
  relations, separate display coverage from mutation payload. Let the response
  represent available unassigned items when required, but initialize selection
  and submit only relations with valid IDs; do not add a second fetch when the
  canonical detail response already owns the full relation set.
- When a required relationship label has a sensible value on the entity the
  user just selected, prefill that value for creation and keep it editable.
  Do not overwrite an existing server value when initializing edit mode, and
  preserve the normal required-field validation when the source value is absent.
- Before calling a long-lived feature branch merge-ready, compare it with the
  current base branch using a non-mutating merge check. Passing feature-local
  types, lint, hooks, and browser QA does not remove integration risk when the
  base has overlapping later work or generated-file conflicts. During the real
  merge, do not apply `ours` or `theirs` to every conflict: classify each file
  by responsibility and chronology, preserve the base's newer common behavior,
  and preserve later feature-specific work where it intentionally supersedes
  the base. For generated files, keep non-conflicting changes from both sides
  and resolve only the overlapping contract from the newest deployed source;
  regenerate union-style outputs such as icon indexes from the merged assets.
  Before committing, compare feature-owned conflict files with the pre-merge
  first parent and verify that the base commit is an ancestor of the result.

## Dentlink Story Point Estimation

Dentlink uses a time-based story-point convention rather than Fibonacci-style
relative complexity.
The 2026-11-04 [team feedback](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793765218878199)
asks for AI-generated points to be checked; it does not change this scale or
identify a particular issue, excessive duration, or required reduction.

- `1 point` means one developer working day: 6 productive work hours. The
  user clarified on 2026-10-27 that roughly 2 hours of an 8-hour day are
  excluded for meetings; do not add that same daily allowance again as a
  blanket estimation buffer.
- Use `0.5 point` for about 3 hours and `0.25 point` for about 1.5 hours.
- Use the same proportional scale for work longer than one day, such as `1.5`
  for about 9 hours and `2` for about 12 hours.
- Estimate Jira FE work in this unit by default. Do not translate a conventional
  Fibonacci estimate such as 3, 5, or 8 directly into Dentlink story points.
- Treat every AI-generated estimate as a reviewable draft, even when the
  requirements look settled. State material API/design/ownership uncertainty
  and let the user review the basis and make the final adjustment. Creating a
  Jira card with AI does not validate or authorize its story-point value.
- Before proposing points, show a compact task-level basis: confirmed scope,
  reusable or completed work, remaining implementation/integration/checks,
  estimated productive hours, assumptions, and resulting hours / 6 points.
  Compare with relevant actual work where available. Avoid adding completed
  preparation, shared work, or the same risk/meeting allowance more than once.
- Define whose effort is measured. Account for the user's actual one-person
  plus Codex workflow and observed reuse or AI assistance; do not store
  hypothetical unaided developer-days as actual effort while separately
  assuming AI makes the calendar shorter. Unmeasured AI speedups and agent
  counts are not evidence for a fixed multiplier or divisor. Preserve the
  necessary human review, integration, and final-code runtime checks.
- Check the units before sharing both points and an elapsed schedule. State
  whether card hours represent expected human effort with AI assistance or
  another explicitly labeled comparison; do not silently mix those measures.
  Explain any gap between summed effort and available human hours through
  task ownership, dependencies, justified overlap, and review/integration
  capacity. A numerically correct sum alone does not validate the estimate.
- Show material uncertainty as an explicit assumption or justified range,
  not unexplained padding on every card and again on the total. Revisit the
  basis when scope or actual progress changes; do not preserve an old total
  merely because it has already been shared, or reduce it merely to look fast.
- A vague request to check points does not identify a specific card or prove
  overestimation. Separate the source statement from hypotheses and inspect
  the estimate before proposing a change. Jira point writes still require
  authorization for the reviewed value or an explicitly labeled draft.
- Follow **Product Planning, Estimation, And Delivery** in
  `SESSION_WORKFLOW.md`. Explicitly state whether estimates include API
  integration, developer testing, review/QA corrections, user QA, and delivery.
  Separate product effort and dependency waiting; an estimate is not a
  promised calendar date or authority to write Jira story-point fields.
- For schedule sharing, account for work that can overlap across independent
  repositories. The user confirmed on 2026-10-27 that their current operating
  model is one human working with Codex in the same feature session, with
  independent product tasks running in parallel when practical. Do not assume
  one human per product or require the user to coordinate extra sessions.
- Show product-level effort separately from the elapsed working-day plan.
  Shared decisions, prerequisite patterns, review, integration, and final
  runtime verification constrain overlap; do not simply sum all product days
  or divide them by the number of agents. Taking only the longest product's
  duration is not a justified schedule unless independent execution capacity,
  prerequisite handoffs, and the human's shared work have been accounted for.
  Label assumed overlap and any unmeasured productivity gain, and recalibrate
  against actual progress. When scope changes, rebuild the affected schedule
  rather than retaining an unsupported earlier parallelism assumption.
- Include FE analysis, UX feasibility review, and design in planning/development
  estimates. Separate already-completed planning from remaining work so it is
  counted once, and label a planning allocation separately from measured worklogs.
- When the user asks for a development-only estimate, exclude the separate QA
  phase, QA-driven follow-up fixes, deployment, and external waiting. Keep
  required developer checks, integration checks, and final-code app runtime
  verification explicitly allocated within development. If a previous QA line
  bundled those checks with a separate QA phase, split it before subtracting;
  do not remove its entire effort while keeping the same verification duties.
  This scheduling boundary does not waive the app runtime evidence required
  before final QA or merge, or authorize starting verification outside scope.
- Record each Jira product card's own effort; put the parallel elapsed schedule
  and its assumptions in the shared planning explanation. Do not make a sum of
  product estimates appear to be the promised delivery duration.

## App Screen Runtime Verification Before Merge

App runtime verification remains mandatory for all app work, as confirmed on
2026-10-27. The user's 2026-11-05 clarification makes its scope proportional to
the actual code impact and credible failure modes, rather than an exhaustive
role/route checklist for every change. It applies independently to Office and
Lab apps and equally in both modes of
[Local Development And User Preview](SESSION_WORKFLOW.md#local-development-and-user-preview);
the user's presence or terminal arrangement does not replace agent verification.

- Before handing an app change to the user for final QA, and before declaring
  it ready to merge, the agent must actually test **the final code on every
  affected screen in the simulator/emulator**. Include indirect consumers of
  changed shared components, hooks, stores, navigation, and permission rules;
  do not limit coverage to edited screen files or the reported example.
- First inspect the final diff and direct/shared consumers to decide what can
  actually break. A small diff is not automatically safe, and being app code
  does not automatically require broad regression testing. Scale the written
  plan to the change: a sentence or short checklist is enough for a simple fix.
- For a pure UI visibility/style change with no hook, state, API, permission,
  navigation or native changes, verify the affected display conditions and
  preserved nearby behavior using a representative account on affected screens.
  Do not repeat Owner/Member or other roles, unrelated entry/back-navigation
  paths or full order flows merely because those areas exist. An authorized
  deployment still needs its source, target and binary compatibility confirmed.
  For example, hiding a completed/canceled order's Delayed
  badge requires hidden/retained labels and dates to be checked; it does not
  require a permission matrix when no role-dependent code is involved.
- Expand checks when the code can cause crashes or functional failures, such
  as null/undefined access, hook call order, effect dependencies/render loops,
  state/cache/persistence changes, asynchronous data flow, navigation, platform
  differences or native integration. Exercise the relevant failure conditions
  and transitions, even when the change is only a few lines. Each extra role,
  route or scenario should have a concrete code-related reason.
- Complete the relevant simulator/emulator checks as the agent before final
  human QA handoff or declaring merge readiness. Testing an intermediate version
  or only opening an unrelated screen is insufficient. If required execution is
  blocked, state the precise blocker and relevant unfinished checks; missing
  unrelated role/route combinations do not block readiness.
- If a screen-control tool fails, apply the alternative-control guidance in
  [Existing Windows And Layout](SESSION_WORKFLOW.md#existing-windows-and-layout)
  before declaring device verification blocked. Keep the justified scope when
  changing methods; tool difficulties are not a reason to broaden the task.
- Confirm that the running app/Metro uses the intended final checkout/revision
  and a compatible native binary, including the final implementation and review
  fixes. Do not use a mock/demo, an older branch, or a stale bundle as proof of
  the final code. After any later code change, reassess the affected screens and
  recheck those cases on the resulting final code before QA handoff or merge.
- Only when permission or role-dependent behavior is affected, cover each
  affected role/permission state with valid
  accounts and server data: allowed access/actions, restricted access/actions,
  and relevant navigation. A mocked or hardcoded role is supplementary evidence,
  not a substitute for checking the actual permission-dependent screen.
- Open each affected screen and exercise the changed behavior. Check loading,
  data arrival, transitions, back navigation, actions and detailed runtime logs
  when the changed code can affect them. Observe runtime errors without turning
  a simple display fix into unrelated crash investigations or full-flow QA.
- Check each affected platform before final QA handoff and merge. Shared
  iOS/Android changes need evidence for both; platform-specific work can stay
  on the affected platform.
  Simulator/emulator screen testing is required. Add physical-device verification
  for hardware or behavior the simulator cannot reproduce, and identify those
  device-only checks explicitly rather than claiming simulator proof. This
  does not require a fresh native build or retesting after every small edit.
- Record the final revision, relevant environment/screens/conditions, actions
  and results concisely; include role details when they affect the behavior.
  User testing is additional final QA and does not replace the agent's required
  runtime verification. Reuse adequate unchanged evidence. Once the relevant
  checks pass, stop: do not repeat tests for a pass count or expand coverage
  without new changes, failures or concrete unresolved concerns.
- Type/lint/build checks, unit tests, screenshots, and a green review cannot
  replace this runtime verification. If accounts, data, devices, or execution
  access needed for relevant cases are missing, report those cases and keep
  the work
  **not ready for final human QA handoff or merge**. Preparing a Draft PR is
  still possible within the user's authorization, using the required Draft
  label/title metadata.
- For a regression caused by a hook/store/effect interaction, verify the real
  interaction and loading-to-data transition. Mocking both the producer and
  stateful consumer can hide a render loop; isolated green tests are not
  evidence that their integration is safe.
- Passing this gate does not authorize merge or deployment and does not prove
  OTA receipt, store release, or production QA. Preserve those separate stages.
- After an authorized deployment, proactively provide the risk assessment and
  proportional human screen-check guide under
  [App Deployment Handoff](SESSION_WORKFLOW.md#app-deployment-handoff), without
  waiting for the user to request either. Reuse the completed agent evidence.

## Figma And QA

- Inspect the provided node and sibling variants for desktop, mobile, long
  text, empty/loading, and status-specific states. A single screenshot is not
  the entire requirement.
- Review the full flow: entry point, list, detail, modal/drawer, dropdown,
  status actions, closing, back navigation, portal stacking, and scrolling.
- Compare Figma with the real browser when visual QA is in scope. For states
  unavailable in live data, compare Figma with the exact conditional code.
  This design comparison does not replace the mandatory app runtime gate above.
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
- Before deployment (and before merge for affected app screens under the rule
  above), review the completed feature as a whole, including UI/UX,
  instead of relying only on field-by-field fixes and type/lint checks. Compare
  related screens and modals for layout, prerequisite guidance, loading/error/
  empty states, selection resets, disabled controls, submit eligibility, and
  success/failure transitions. The same state should behave consistently across
  the feature. Record this review as the next step when work pauses before deployment.
- Run type/lint after a coherent edit set instead of after every small change.
  Run builds when requested or when the risk justifies them.
- Report existing warnings separately from failures and state test gaps rather
  than overstating completion.

## Branch Naming And Draft PR Metadata

- This naming rule applies to **every branch creation and rename**, local or
  remote, across all projects and sessions: ordinary features, QA, release
  follow-up, review fixes, temporary experiments, backups, delivery/sync
  branches, and branches created by worktree or delegated-session tools.
- Use the user's exact branch name when supplied. Otherwise stay within the
  repository's documented naming patterns; never invent another prefix or
  namespace. From 2026-11-04, Dentlink task branches use `feat/<Jira>` by default
  across Web/Admin, Office app, and Lab app. The [team notice](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793765529562549)
  shortens `feature` to `feat`; the [follow-up confirmation](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793765642512149)
  confirms that it concerns branch names across projects, not PR-title prefixes.
  Apply the new prefix to future branches; preserve existing branch names,
  PR heads, and historical records unless a rename is explicitly authorized.
  Historical `feature/` examples are not the current creation default. Other
  projects retain their own naming contracts unless this policy applies there.
  Agent-specific prefixes such as `codex/`, `claude/`, or `agent/` are forbidden.
  An agent/tool default, an old branch with that prefix, isolation needs, or a
  QA/release-based starting commit does not create an exception.
- Use `release/`, `hotfix/`, or another repository-approved exceptional pattern
  only for its explicitly authorized purpose. Being authorized to do QA or
  follow-up work does not authorize inventing `qa/`, `backup/`, or another
  prefix. If an existing task branch must be preserved, use a permitted
  descriptive suffix within `feat/<Jira>` rather than a new namespace.
- Name a branch for its intended delivery scope. When a branch is meant to
  collect multiple QA fixes for one release, use the release QA purpose rather
  than the first Jira card alone; for example, `feat/vX.Y.Z-qa` for fixes
  targeting `release/vX.Y.Z`.
- Before creation or rename, compare the full intended name with the exact
  user instruction and the allowed repository pattern. After any tool or
  automation creates the branch, verify its actual name before editing,
  pushing, or creating a PR. Resolve a mismatch within the existing authority
  instead of proceeding with an agent-prefixed branch. This rule does not
  authorize renaming or deleting unrelated existing branches.
- If a worktree/session tool would force an agent prefix, do not create that
  branch and plan to rename it afterward. Choose a permitted creation method
  or a detached checkout instead; the tool does not override the naming rule.
- A Draft PR requires **all three**: GitHub's actual Draft state, the `DRAFT`
  label, and the exact title prefix `[WIP] `, including exactly one ASCII space
  after `]` before the existing title. For Jira work, preserve the normal
  ticket/title format after it, for example `[WIP] [DL-16821] 작업 제목`.
  Avoid duplicate `[WIP]` markers and preserve other applicable labels.
- After creating or converting an authorized PR to Draft, re-read its actual
  state, labels, and title. Do not report Draft setup complete if one is missing
  or could not be applied. A title marker or label alone does not set Draft
  state, and setting Draft alone does not satisfy this requirement.
- When an authorized transition makes the PR ready for review, remove only
  the stale `DRAFT` label and leading `[WIP] ` prefix, preserving the remaining
  title and labels. This consistency rule does not itself authorize changing
  an existing PR's readiness or editing reference PRs.
- User references verified on 2026-10-19: web PR
  [#4713](https://github.com/Innvoaid/dentlink-client/pull/4713) demonstrates the
  `DRAFT` label, and [#4712](https://github.com/Innvoaid/dentlink-client/pull/4712)
  demonstrates the leading `[WIP]` title. Neither example alone establishes
  that all three fields were already present on both PRs.

## User-Directed Scope Discipline

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
