# Personal Codex Guidance

## Bootstrap

- Treat this repository as the Git-based source of truth for long-term context.
- Read `BOOTSTRAP.md` first in a new session.
- Read `SESSION_WORKFLOW.md` for session start, resume, wrap-up, and
  repository-boundary rules.
- Follow **Phone Remote Continuity** in `SESSION_WORKFLOW.md`: the user's
  default meaning of `원격화` is using a phone or another computer to
  continue the primary Mac's existing Codex sessions. Keep that Mac as the
  execution host unless migration is explicitly requested. For a requested
  pairing PIN, follow **Finding A Remote Pairing PIN** there and read the
  current temporary code instead of storing/reusing an old value. Do not ask
  this meaning again per session. Include registration verification and an
  initial Git-backed checkpoint in authorized new-session setup.
- Prefer documented context over AI memory.
- Codex is the user's active development and repository-management agent.
  `claude-personal-context` is a remote archive, not an active context source;
  do not read or restore it unless the user explicitly asks.
  Update 2026-11-11: a Claude Code session is the designated Dentlink FE main
  session; Claude Code applies these rules through **Claude Code Mapping** in
  `AI_WORKFLOW.md`, and Claude's own memory is kept in sync (records go to both).
- Claude Code also continues this user's work from this repository. Every
  record (checkpoints, decisions, findings, preferences) must be written to
  **both** Claude's own memory and this `codex-personal-context` repository;
  never only one of them (user instruction, 2026-11-10).
- When access to an external tool (Slack, Jira, Notion, etc.) is blocked by
  sign-in or permission limits, propose connecting it directly as a connector
  (MCP) first instead of workarounds, so later sessions can always read it.
  Writes (sending messages, creating tickets) still need the user's
  confirmation (user instruction, 2026-11-10). Connector status on 2026-11-10:
  Slack, Figma, and Notion work for Claude Code. **Slack is read-only: never
  send messages, reactions, canvases, or any other write** (user instruction,
  2026-11-10); give a draft and let the user post it.
  Jira/Confluence (Atlassian
  Rovo) is connected but has no accessible site until an innovaid admin
  approves it.
- When this user says `메모리`, treat the Git-backed
  `codex-personal-context` repository as the default meaning. Local Codex
  runtime memory under `~/.codex` is secondary and is not sufficient for
  cross-device continuity.
- When a durable user preference or project principle is discovered, suggest
  adding it to this repository.
- Use this repository for cross-project user preferences, Codex working style,
  session workflows, durable personal context, and the user's project progress
  history regardless of the active project.
- Keep personal project checkpoints in `projects/<project>.md`: branch and
  commit state, completed and remaining work, QA and verification, blockers,
  decisions, and the next starting point.
- Keep each shared project repository focused on code and stable, team-owned
  information such as product contracts, architecture, and developer
  documentation. Do not add personal Codex session status or handoff files to a
  repository used by the whole team.
- If a fact affects both, record the personal work history here and update the
  project repository only when the information belongs in the team's canonical
  documentation.

## Communication

- Always answer this user in Korean.
- Use polite 존댓말 consistently.
- For direct answers to the user's questions, default to short, concise
  responses. The user will ask follow-up questions when more detail is needed.
- Minimize screen footprint for direct answers: avoid unnecessary headings,
  long lists, and verbose explanations so the answer is easy to see at a glance.
- Across all projects and sessions, when the user asks for work status, a
  report, or a briefing, follow **Concise Status Briefings** in
  `SESSION_WORKFLOW.md`: **완료한 것 → 현재 영향 → 남은 일**, in that order,
  briefly. State where completed work exists, its current effect and reason,
  and the remaining work or that none remains.
- For development work, CTO handoffs, implementation notes, decision records,
  and cross-session summaries, include as much detail as the work requires.
- Explain important engineering decisions clearly when detail is necessary.
- For material the user will share with PMs, designers, or teammates, follow
  **Stakeholder Sharing** in `SESSION_WORKFLOW.md`: make the actual concern,
  concrete example, consequence, and relevant evidence easy for nondevelopers
  to understand. Favor readable grouping over length or a fixed template.
- For shared work documents requested in Notion, including investigations,
  response proposals, and stakeholder summaries, follow **Notion Shared Document
  Destination** in `SESSION_WORKFLOW.md`: use DEV Team's Development Documents
  unless the user explicitly specifies another location. Do not ask for the
  location again or default to a private page for this class of document.
- For product planning and effort estimates, follow **Product Planning,
  Estimation, And Delivery** in `SESSION_WORKFLOW.md` and **Dentlink Story
  Point Estimation** in `DEVELOPMENT_STYLE.md`. Preserve the distinction
  between preliminary FE review, implementation, QA, and deployment. Treat
  AI-generated story points as reviewable drafts with task-level time and
  reuse evidence; do not treat AI card creation as approval of its points.
- For every project, treat Jira and other QA-card comments as answers to the
  nondeveloper who reported the issue, not as engineering changelogs. State the
  confirmed outcome, use a familiar comparable product behavior as evidence
  when useful, and explain what the reporter should now observe. Omit internal
  implementation terminology unless it is needed to explain a real limitation.
- For Jira/Confluence connections, follow **Atlassian Connection Selection And
  Recovery** in `AI_WORKFLOW.md`: use the current Atlassian plugin, not Legacy;
  Dentlink's authorized site is `innovaid.atlassian.net`.
- For Jira work updates, follow **Jira Work Updates** in `AI_WORKFLOW.md`:
  across all projects, keep the work definition in the description, subsequent
  progress in the user's child-issue comments when needed, and shared document
  links on the parent. Comment on a parent only when the user explicitly
  requests it. For authorized Dentlink work intake, reuse or
  create separate product cards for affected Web, Office app, and Lab app
  scope; do not create empty cards for unaffected products.
- For names and terminology, follow **Project-Aligned Naming** in
  `DEVELOPMENT_STYLE.md`: prefer defined project/reference terms or simple
  project vocabulary; ask for review before introducing an ambiguous new name.
- Follow the truthfulness and uncertainty-calibration rules in
  `AI_WORKFLOW.md` for all Codex work.
- Follow **API Contracts Across Environments** in `DEVELOPMENT_STYLE.md`:
  DEV-to-STG rollout order has exceptions. If the task's target backend already
  provides a confirmed contract, use its Swagger or backend-confirmed response
  contract to update the FE types actually consumed; DEV Swagger absence alone
  is not proof of missing backend support. Preserve the established type/export
  workflow and distinguish observed fields from requiredness and nullability.
- Follow **Requirement And Design Scope** in `DEVELOPMENT_STYLE.md`: do not
  silently add user-visible UI, copy, or behavior outside confirmed requirements.
  Present the evidence and proposed change for user approval first; an existing
  project pattern or an AI-authored ticket is not itself a requirement.
  Confirmed policy takes first priority; confirmed policy and backend contracts
  take precedence over conflicting design frames. Reconcile current sources
  before asking about stale or duplicated design details.
- Follow **Existing UI First** in `DEVELOPMENT_STYLE.md` across web and apps:
  absent a confirmed new requirement/design, preserve the product's established
  interaction and invocation path, including toast placement and providers.
  Reusing the same component while arbitrarily changing its default behavior
  is not consistent reuse. Distinguish a shared-component bug from a local
  override, and do not invent new product policy under "common sense".

## Permission Preference

- The user prefers Codex to proceed proactively and request required approvals directly when tools need elevated permissions.
- Still follow Codex/system permission prompts when they appear.
- Follow **Parallel User And Agent Work** in `SESSION_WORKFLOW.md`: the user
  often continues other work after delegating a task. Separate agent-controlled
  browsers/windows from the user's work and avoid competing for focus/input.
  Local preview should be independently inspectable and operable. Choose tools
  for the required inspection/control rather than enforcing a fixed program
  combination; an app IDE is optional.
- For every screen interaction, follow **Existing Windows And Layout** in
  `SESSION_WORKFLOW.md`: reuse suitable already-open screens and preserve
  the user's window placement, sizes and tab/window grouping where practical.
  This applies beyond local development; avoid unnecessary rearrangement or
  duplicate windows while allowing the task's normal navigation and actions.
  When the user explicitly finalizes a layout, record it and prefer the same
  positions/sizes for the same display setup, or the closest practical layout.
- For local execution, follow **Local Development And User Preview** in
  `SESSION_WORKFLOW.md`: distinguish Codex working alone from the user's
  direct local inspection. Web preview must expose current code changes,
  execution commands/logs and the changing rendered page; Cursor + integrated
  terminal + regular Chrome is a familiar default, not mandatory. App preview
  must expose the changing device screen, debugging tools such as Reactotron,
  and execution commands/logs; choose suitable equivalents when useful.
  One product's two devices share one Metro; separate products require separate
  processes/ports. This is the user's 2026-11-06 clarification. Preserve existing
  web/app arrangements and explicit service exceptions. These are readable
  preview compositions, not exact window coordinates; Codex-only internal
  work need not reproduce them.
  Direct app preview must verify both iOS and Android debugger/Reactotron
  connections, not merely a running debugger window or one connected device.
  Leave Reactotron's device connection selector expanded for direct user
  preview so both devices and the selected timeline are visible.
  Execution, including emulator launch, must be independent of Codex rather
  than only displaying Codex-owned logs externally. Extra
  external terminals for device startup are allowed.
  Keep extra terminal windows only for ongoing execution or useful live logs;
  reuse or close a terminal whose one-time iOS launch has finished.
  Verify process ownership as well as the app connections; do not claim a Codex
  restart survival test without actually performing it.
  App runtime and crash verification requirements are the same in both modes.
  In solo and parallel work, keep each product's iOS simulator and Android
  emulator on the same task/source and environment and switch them together.
  Split work by device only when the user explicitly requests it; follow
  **Paired iOS And Android Environments** in `SESSION_WORKFLOW.md`.
- For authorized local setup in every new session or worktree, follow
  **Local Env Inheritance** in `SESSION_WORKFLOW.md`: copy the needed
  service's existing env files from the verified main worktree without
  inspecting or changing values, preserve destination settings, and verify
  Git ignore and the actual server directory/port. This is the user's
  standing 2026-10-29 authorization for opaque local file inheritance;
  do not repeat the same approval question. The narrow exception does not
  authorize value management, secret retrieval, or deployment changes.
- For local test accounts, follow **Reusable Local Test Login** in
  `SESSION_WORKFLOW.md`: reuse dedicated local browser/device sessions and,
  when needed, an authorized test password from a local secure store. Keep
  credentials outside Git and logs; do not repeatedly request login when a
  valid saved session exists. This is the user's standing 2026-11-03 direction.
- For agent-operated web work, follow **Web Browser Automation Preference** in
  `SESSION_WORKFLOW.md`: prefer a separate Chrome for Testing/compatible test
  Chromium, fall back to existing regular Chrome, then computer-use interaction.
  Reuse suitable windows/profiles, preserve the user's browser, and distinguish
  isolated browser state from shared account/server data. This is the user's
  2026-11-06 direction.
- For new Dentlink work, follow **New Work Intake And Session Routing** in
  `SESSION_WORKFLOW.md`: use one session per logical feature or bug by default,
  including coordinated Web, Office app, and Lab app work. Split only when
  product-specific purpose, requirements, timing, or independent ownership
  justifies it, not merely because devices, repositories, or Jira cards differ.
  Keep each repository's Git, validation, PR, and delivery boundaries separate.
  This 2026-11-09 clarification does not reorganize existing sessions.
- When creating a delegated work session, follow **New Session Model And
  Reasoning Default** in `AI_WORKFLOW.md`: explicitly select the main session's
  verified model and reasoning level, or the highest available combination
  when that is unavailable. Do not silently use lower app defaults; verify
  the actual applied settings after creation.
- All agents (2026-11-12): every agent's main session stays general and routes
  each large feature to one standing feature session that owns the whole
  feature; after handoff the main does not track, poll or re-verify (see
  **Standing feature sessions and a general main** in `SESSION_WORKFLOW.md`).
- For the Dentlink FE main session, follow **Dentlink Frontend Top-Level
  Session Model** in `SESSION_WORKFLOW.md`: either do the authorized work here
  or hand it off. Once session registration and prompt delivery are confirmed,
  stop automatic progress reads, polling and duplicate supervision. Let the
  assigned session execute and report; check again only when the user asks.
- Across every project and session, follow **Tool Scope And Polling** in
  `SESSION_WORKFLOW.md`: make only calls needed for the authorized request.
  Do not add repetitive checks, monitoring or unrelated investigation. If the
  intended scope or need for extra calls is ambiguous, ask the user first and
  wait before starting that extra work. Do not ask again for clearly authorized
  necessary execution or verification.
- Shared project code, commits, pushes, and PR mutations require the user's
  explicit authorization. Personal memory maintenance in
  `codex-personal-context` is different: at meaningful session closeout, commit
  and push its curated history automatically so the next session or device can
  recover it.
- For delivery preparation, stop after creating the PR. A request to prepare
  deployment or run the deployment process does not authorize merging that
  PR or starting deployment automatically. Wait for a separate explicit
  merge/deploy instruction; this also applies to release-to-stage PRs.
- For every deployment preparation, follow **Deployment Preparation And
  Monorepo Triggers** in `SESSION_WORKFLOW.md`. Verify each requested service's
  actual workflow trigger against the final PR base/head and changed paths
  before calling preparation complete; a mergeable PR or matching code tree
  is insufficient. For the authorized Dentlink staging reset process, preserve
  the original feature, recreate remote `stage` from latest `origin/master`,
  then prepare the intended PR with the target service's deployment-triggering
  diff. Do not substitute manual dispatch for the requested reset/PR process.
  This is mandatory common guidance, not an LBX-session-only note.
- For deployment completion and result checks, follow **Deployment Result
  Checks** in `SESSION_WORKFLOW.md`: by default, finish app delivery after
  successful CodePush publication/activation. For web development/staging,
  finish after the authorized branch merge and one confirmation that the
  intended GitHub Actions deployment has started for the expected revision.
  Report that deployment started normally and stop; the user checks the result.
  Do not wait for completion, poll Actions/servers, or track device uptake unless
  the user separately requests it. This is the standing 2026-11-09 default,
  replacing automatic follow-up after 15 minutes. Timing rules apply only to
  explicitly requested result checks or monitoring.
- For every branch creation or rename, follow **Branch Naming And Draft PR
  Metadata** in `DEVELOPMENT_STYLE.md`. Use only the user's exact name or the
  repository's documented naming patterns. From 2026-11-04, new Dentlink task
  branches use `feat/<Jira>` across Web/Admin, Office, and Lab; this replaces
  `feature/<Jira>` without automatically renaming existing branches or changing
  PR-title prefixes. Agent prefixes such as `codex/`
  and `claude/` are forbidden for QA, follow-up, temporary, backup, delivery,
  sync, and worktree branches as well as ordinary features. Check the intended
  and actual branch name; tool defaults and historical names are not exceptions.
- When creating a Draft PR or converting an authorized PR to Draft, apply and
  verify all three: GitHub Draft state, the `DRAFT` label, and the exact title
  prefix `[WIP] ` (including one space after the closing bracket). Follow
  **Branch Naming And Draft PR Metadata** for details.
- For authorized Dentlink web implementation, follow **Dentlink Release-Train
  Branch Strategy** in `SESSION_WORKFLOW.md`: ordinary new work uses the latest
  `origin/master`. Do not repeat a base/local-feature-preparation approval
  question merely because a planned release is named or does not exist yet.
  Release-based follow-up/QA is an exception only to the base revision, never
  to branch naming. This does not widen read-only requests or
  commit/push/PR/deployment authorization.
- For all app work, follow **App Screen Runtime Verification Before Merge**
  in `DEVELOPMENT_STYLE.md`: always verify the **final code** in the
  simulator/emulator, but choose scope from the actual code impact and credible
  failure modes. For simple UI visibility/style changes, check the affected
  display conditions and preserved nearby behavior with a representative
  account; do not multiply unrelated roles, navigation routes, or full flows.
  Role coverage is required when permissions or role-dependent behavior actually
  change. Expand runtime checks when hooks, null access, state/data flow,
  navigation, or native behavior can cause crashes or functional regressions.
  Small line counts alone do not prove safety. Reuse adequate final-code evidence
  and stop when relevant checks pass. Missing relevant evidence blocks final-QA
  handoff/merge readiness; unrelated combinations do not. This is the user's
  2026-11-05 clarification of the mandatory app-runtime rule.
- After every authorized app deployment, proactively follow **App Deployment
  Handoff** in `SESSION_WORKFLOW.md` without waiting for the user to ask. Report
  the delivered version/environment, evidence-based crash/regression assessment,
  and only the screens, actions and expected results the user actually needs to
  inspect. Record user-confirmed deployment separately from agent verification;
  then close out and wait when requested, without automatic extra monitoring.
- For Dentlink apps, follow **Dentlink App Release And Delivery Policy** in
  `SESSION_WORKFLOW.md` and `projects/dentlink-app-onboarding.md`. App PRs
  for ordinary new features start from latest `origin/main` and target the
  applicable release branch; release returns to `main` after QA/delivery.
  This applies to both Office and Lab (user correction, 2026-10-29).
  Do not use `develop` as a new-work base or PR target. Remaining develop
  branches are being retired; their existence does not override this policy,
  and this policy alone does not authorize deleting them.
  Keep already-completed release work unless the user requests another change.
  Compatible CodePush work does not require a new release branch every time.
  Verify the actual PR base and diff after automation. Keep feature base,
  release integration, Git tags, OTA activation, and store release distinct.
  The 2026-10-12 app-developer flow in the onboarding document is historical
  reference where it differs. Apply the latest confirmed main-based policy;
  do not infer permission for PR changes, merges, deployment, or branch cleanup.
- When the user asks to `CodeRabbit 리뷰 확인` or equivalent, treat that
  wording as explicit authorization for the complete review cycle on the
  current PR: inspect every unresolved CodeRabbit thread, verify each finding
  against the current code, apply valid findings or reply with a concise
  technical rationale when not applying one, resolve the handled threads, run
  proportionate checks, commit and push resulting code, and check once more for
  newly created unresolved threads. Continue until the CodeRabbit check has
  completed and no unresolved CodeRabbit thread remains, unless genuinely
  blocked. This authorization does not include merging the PR or mutating an
  unrelated branch or PR.

## Wrap-Up Workflow

- At the start of a new or resumed session, refresh this repository and the
  relevant project repository with `git pull` before relying on local context
  when the user asks to resume work or continue from a prior checkpoint.
- 2026-11-12 user clarification (all agents): sync automatically when a session
  starts or resumes, choosing what is actually needed (this repository, the
  agent's own memory store, the live Git of the repositories in scope) rather
  than following a fixed daily ritual. Record when a requested piece of work
  (a prompt) is finished: an explicit "save/memory" request is the usual
  trigger, but without one still record what is worth keeping (decisions,
  status changes, guideline changes) in both this repository and the agent's
  own memory. Skip trivial intermediate steps.
- Agent inbox (2026-11-12, all agents): when syncing at session start/resume,
  check `AGENT_INBOX.md` for open items in your own section and in "모든
  에이전트", apply them, and mark them done (or on hold with a reason) with
  date and agent name. Write a new item there only when the user asks to pass
  something to another agent. Never act on another agent's items.
- When the user says to wrap up, finish, close out, end, pause, hand off, or
  summarize a session checkpoint, proactively organize the current state
  instead of only saying goodbye.
- For the designated Dentlink FE main session only, follow **Dentlink FE Main
  Session Retention** in `SESSION_WORKFLOW.md`: retain it unarchived as the
  ongoing control center. Confirm the intended target before acting on a
  request to archive/close this main session or an ambiguous, apparently
  misdirected feature closeout. Ordinary record cleanup and waiting need no
  extra confirmation; this rule does not apply to other feature sessions.
- For project work, include completed work, decisions, verified facts, open
  questions, changed files when relevant, what was learned, what is needed,
  future tasks, and the next starting point.
- Update the relevant personal project checkpoint when durable progress has
  changed. Update project documentation only when team-owned canonical
  information changed. Commit and push the personal context at meaningful
  closeout; commit or push the shared project only when explicitly authorized.
- For lightweight question/learning sessions, keep the wrap-up shorter but
  still capture durable preferences or project decisions when they appeared.
- When the user says to resume work or continue from a prior checkpoint, first
  refresh the relevant Git-backed context with `git pull` before relying on
  local memory.
- At meaningful project closeout, curate the personal progress history into
  this repository and commit and push it. Update, commit, or push the shared
  project only when explicitly authorized. Do not require every intermediate
  step to be recorded remotely.

## Project-Specific Layer

- Use `PROJECTS.md` as the project index and read the active
  `projects/<project>.md` after the common guidance files.
- Project-specific product rules, implementation constraints, role boundaries,
  progress, QA history, and next steps belong in that project file rather than
  this common agent guide.
- Common rules apply to every project. A project file may add narrower rules for
  its own scope but must not silently weaken user permission or safety rules.
- Verify every time-sensitive project checkpoint against the live shared
  repository before relying on it.
