# Memory Changelog

## 2026-08-03

- Corrected two DSO TODO classifications after checking live code and the
  confirmed backend policy: `organizations[0]` is the completed current
  single-Organization rule rather than a current selection blocker, and
  `Visit Office` already reuses the established active-employee transition,
  invalidation, rollback, and default-home navigation flow.
- Confirmed Figma comment `#26` against the committed code: both Organization
  and single-Office dashboards already update the `Data from ... ago` label on
  a 60-second interval without refetching APIs. Corrected the checkpoint rather
  than adding duplicate timer code.
- Corrected the scope of the reusable Dentlink guidance: it comes from the
  entire `feature/DL-15223` lifecycle, not only its DL-15801 Amplitude task.
  The common method now explicitly covers requirement reconciliation across
  Jira/FigJam/Figma/Swagger/live code, app-local pattern reuse, replaceable
  UI-to-API migration, generated-code ownership, narrow auth boundaries,
  browser-backed design review, reversible deferrals, and separate delivery
  states. DL-15801 remains recorded as one completed implementation checkpoint.
- Recorded the analytics event-boundary rule learned from DL-15801: place CTA
  click events at the actual click before validation or mutation, reserve
  success events for confirmed outcomes, and verify existing page-view/session
  capture before inventing manual dwell-time events.
- Updated the Dentlink DSO checkpoint to pushed head `345699e4d`, including the
  real dashboard/billing/PDF integrations, access and mobile guards,
  outstanding balance, My Profile changes, generated-file formatting guard,
  and DL-15801 Amplitude events. Advanced Export API, deployment/live event
  verification, multi-Organization policy, and develop integration remain.
- Added reusable `dentlink-client` implementation defaults learned while
  reviewing the DSO work: keep Clinic and Admin patterns app-local, separate
  generated Swagger transport artifacts from handwritten feature/domain types,
  preserve hook/service mutation ownership, and match selection cardinality to
  API payloads.
- Recorded that complete relationship selectors must not silently stop at the
  first 100 paginated results, and that user-visible dates and currency should
  use Dentlink shared formatters with the actual country context.
- Recorded the shared-input extension pattern: add a minimal optional
  controlled value path while preserving existing uncontrolled defaults and
  audit current consumers before changing shared behavior.
- Reinforced the design-before-API boundary: fixtures remain replaceable UI
  inputs, and only deployed, regenerated contracts authorize real integration.

## 2026-07-22

- Added the durable branch-naming rule: never introduce an agent-specific
  `codex/` prefix; follow each repository's existing `feature/`, `release/`,
  and related taxonomy.
- Recorded that release QA aggregation branches should be named for the release
  QA purpose rather than only the first Jira card, such as
  `feature/v1.79.0-qa` targeting `release/v1.79.0`.
- Corrected the durable PR workflow: always use the repository PR skill, but a
  normal commit/push/PR request stops at PR creation. CodeRabbit monitoring,
  response, resolution, and recheck run only when the user explicitly asks to
  handle the review; PR merge remains explicitly separate.
- Removed the completed Dentlink PDF project from the active project index and
  deleted its completed checkpoint document.
- Recorded PR #4411 merged as `6ee361e87`. E2E work waits for staging to contain
  that commit before the final local and staging full UI verification matrix.

## 2026-07-15

- Recorded the durable scope rule: use requirement/design/user/history causality,
  not shared-file location or diff size. Inspect introducing commits and source
  context before reverting, and ask when intent remains ambiguous.
- Recorded the user's PR boundary: when delivery is requested only through PR
  creation, downstream merge, deployment, and automatic workflow status must
  not be monitored or reported unless explicitly requested.
- Added the user's scope rule: do not create unsolicited test files, analytics
  mapper/helper files, analysis artifacts, or documentation. Keep event work in
  the feature's existing files and request approval before expanding structure.

## 2026-07-14

- Corrected the repository boundary for this user's workflow. Personal project
  progress, QA, blockers, branch/commit checkpoints, decisions, history, and
  next starting points belong in
  `codex-personal-context/projects/<project>.md`; shared project repositories
  keep code and stable, team-owned canonical information only.
- Defined resume and closeout behavior around that boundary: pull personal
  context first, reconcile its time-sensitive checkpoint with live project Git,
  and always commit and push the personal history at meaningful closeout.
- Clarified that explicit commit/push authorization applies to shared project
  code and repositories, not to routine closeout synchronization of
  `codex-personal-context`.
- Split personal configuration into common and project-specific layers. Root
  guidance now contains only cross-project rules; each
  `projects/<project>.md` owns that project's workflow, implementation rules,
  current checkpoint, QA, and history.
- Added `projects/README.md` as the project-context schema, reduced `HANDOFF.md`
  to a resume index, moved ASJ-specific workflow out of common
  `SESSION_WORKFLOW.md`, and defined the project-specific checkpoint lifecycle.
- Strengthened the canonical project-alignment rule: matching an existing
  product means following its complete implementation method, including hooks,
  API/query/mutation flow, cache behavior, state ownership, generated types,
  loading/error handling, routing, responsive layout, imports, and naming, not
  only CSS or visual conventions.
- Made this the default for `dentlink-client` and all derived Dentlink
  worktrees, branches, and repositories, using the closest implementation in
  the current app, base, and installed library version as the primary reference.
- Recorded that a concrete review comment is a signal to audit the full changed
  feature for the same root pattern, and that deviations require a specific
  need, minimal additive scope, preserved defaults, and consumer review.

## 2026-07-10

- Defined `메모리` as the Git-backed `codex-personal-context` repository for
  this user; `~/.codex/memories` is secondary runtime memory and does not count
  as remote cross-device continuity.
- Tightened the session lifecycle: pull personal context at work start, and at
  meaningful closeout curate and push durable status, learned rules, blockers,
  verification, and the next start point. The 2026-07-14 policy clarified that
  personal-context synchronization is automatic at meaningful closeout.
- Added project-aligned implementation guardrails:
  existing props/components first, minimal additive shared changes, generated
  types and current library conventions, scoped loading, shared-consumer side
  effect review, complete Figma state/flow QA, and separate implementation,
  visual QA, and merge-readiness judgments.

## 2026-06-24

- Added the user's UI/readability preference: direct answers should minimize
  screen footprint by avoiding unnecessary headings, long lists, and verbose
  explanations.
- Added `SESSION_WORKFLOW.md` as the durable cross-project session operating
  model for start, resume, wrap-up, session roles, repository boundaries,
  communication style, database safety, and continuity.
- Added the user's global communication preference: direct answers to the
  user's questions should be short by default, while development work, CTO
  handoffs, implementation notes, decision records, and cross-session summaries
  should include as much detail as needed.
- Added the user's wrap-up workflow preference: when the user asks to wrap up,
  pause, close out, hand off, or summarize a checkpoint, Codex should
  proactively organize the state and update durable Git-backed memory or
  project docs when appropriate.
- Clarified the wrap-up/resume workflow: end-of-work requests should include
  documentation, durable memory, work status, learned facts, needed items, next
  tasks, and the next starting point; resume requests should begin by pulling
  the relevant Git-backed context.
- Recorded an initial repository separation rule. This boundary was superseded
  on 2026-07-14: personal project status and handoffs now live in
  `codex-personal-context/projects/<project>.md`, while shared repositories keep
  stable team-owned information.

## 2026-06-14

- Added a global Codex working principle: prioritize truthfulness and
  uncertainty calibration over sounding confident.
- Recorded that Codex should explicitly label confirmed facts, observations,
  hypotheses, recommendations, and unknowns.
- Recorded that Codex must not imply implementation exists when only a design,
  idea, or document exists.
- Recorded that AI analysis work should separate raw evidence, interpretation,
  confidence, and uncertainty.
- Reinforced the user's remote-first rule: durable settings, preferences,
  project status, and continuity notes should be committed and pushed to
  remote-backed Git repositories whenever safe.

## 2026-06-13

- Updated Action Sports Journal project memory after the evidence-first video
  analysis validation day.
- Recorded latest project commits:
  - `e5e6d98 Validate evidence-first video analysis`
  - `4664bfb Prioritize trick initiation evidence`
- Recorded current recommended architecture:
  `Video -> Gemini Evidence Extraction -> User Confirmation -> Coaching Engine -> Stored Session Intelligence`.
- Recorded the current model split: Gemini is primary for video/motion evidence
  extraction; GPT is preferred for coaching/reporting after evidence and rider
  intent are confirmed.
- Recorded that exact Back Roll vs Tantrum classification is still not reliable
  enough to bypass user confirmation, but repeated Back Roll tests now fail in a
  more plausible Back Roll/Tantrum-family range instead of unrelated tricks.
- Recorded the wakeboard domain rule for future evaluation: trick identity
  should be determined primarily from stance, edge, approach, takeoff, pop, and
  rotation initiation. Landing and crash are outcomes, not primary
  trick-classification evidence.
- Recorded local evidence extraction stability setting:
  `GEMINI_EVIDENCE_MAX_OUTPUT_TOKENS=6000`.

## 2026-06-12

- Added initial personal context bootstrap structure.
- Established `codex-personal-context` as the source of truth for long-term AI
  collaboration context.
- Documented user profile, AI workflow, development style, decision framework,
  fitness context, vehicle context, and project index.
- Confirmed the current main project is Action Sports Journal.
- Confirmed the user's current vehicle is BMW G30 520d.
- Confirmed the user's preferred AI split: Claude for company development,
  Codex for side projects, ChatGPT for personal questions and coaching.
- Confirmed Action Sports Journal latest local project commit is
  `c7cdfe9 Switch dev analysis server to Gemini video input`.
- Updated Action Sports Journal latest project commit to
  `802bd94 Benchmark OpenAI wakeboard analysis`.
- Recorded that the current priority is an OpenAI GPT-5.5 wakeboard analysis
  benchmark before giving up on OpenAI. The implementation uses whole-video
  frame sampling, Responses API image inputs, xhigh reasoning, and structured
  coaching JSON. Actual GPT-5.5 benchmark still requires a local
  `OPENAI_API_KEY`.
- Added the remote continuity rule: when the user asks to check project
  progress or user context, durable findings should be committed and pushed to
  the appropriate Git source of truth rather than left only in local state or
  chat history.
- Corrected the local Codex startup sync instruction in `~/.codex/AGENTS.md`
  from `cd ~/.Codex && git pull` to
  `cd ~/Repository/codex-personal-context && git pull`, because `~/.codex` is
  an app state/config directory, not the Git source of truth.
- Added the user's remote-first rule: remote Git state is the default source of
  truth for continuity; local files are working copies unless the user
  explicitly says local unpushed work should be treated as authoritative.
