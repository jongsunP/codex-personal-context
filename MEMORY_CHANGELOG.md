# Memory Changelog

## 2026-07-15

- Closed out the DL-14232 implementation review with canonical master PR #4353
  at `1be4ee8db`, develop API PR #4376 merged/deployed successfully, and open
  develop follow-up PR #4378 at `660fbcde2` for payload and analytics changes.
- Recorded the verified Jira comments/child-card snapshot, Notion DL-15570 and
  DL-15575 event/property contract, Figma/FigJam alignment, generated invitation
  API contract/error codes, development-server QA, and remaining integrated QA.
- Added the user's scope rule: do not create unsolicited test files, analytics
  mapper/helper files, analysis artifacts, or documentation. Keep event work in
  the feature's existing files and request approval before expanding structure.
- Removed the previously added feature-specific test/helper files from both the
  master feature branch and develop follow-up branch while preserving runtime
  tracking behavior; updated both PR descriptions to match.
- Corrected the active Dentlink repository/worktree paths and added the isolated
  develop follow-up worktree to the project index.

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
  `SESSION_WORKFLOW.md`, and refreshed the Dentlink current checkpoint while
  retaining its dated history.
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
- Added project-aligned implementation guardrails generalized from DL-14232:
  existing props/components first, minimal additive shared changes, generated
  types and current library conventions, scoped loading, shared-consumer side
  effect review, complete Figma state/flow QA, and separate implementation,
  visual QA, and merge-readiness judgments.
- Updated the Dentlink invite project checkpoint to remote HEAD `6bc9e7eb8`,
  recorded completed Admin/Lab/Clinic invite management, recipient invitation
  UI-only status, missing recipient APIs/auth flow, latest `master` dependency
  drift, seven merge conflicts, verification, and the next start sequence.
- Added `projects/dentlink-client-invite.md` to `setup-local-codex.sh` so a
  pulled personal-context repository syncs the Dentlink checkpoint into the
  local Codex runtime guidance tree.

## 2026-07-09

- Updated Dentlink `DL-14232` checkpoint after follow-up commit `f00341b5d`:
  member detail `Member Info` outer border/radius/overflow removed, leaving only
  row dividers so the section no longer looks like a table box. Jira comment
  `43085` records the pushed commit and verification.
- Updated Dentlink `DL-14232` checkpoint after design QA commit
  `277a3314b`: ChartDropdown added, invite page/table/modal and member detail
  styling aligned more closely to Figma, PopupMenu outside-click behavior fixed
  for member detail drawer, and branch pushed to `origin/feature/DL-14232`.
- Recorded verification boundaries for the latest pass: `git diff --check`,
  clinic TypeScript, commit-hook clinic/lab/admin type checks, and push-hook
  lint completed; build and Computer Use QA were intentionally left to the user.
- Reconfirmed remaining blocker: real clinic invite create/resend/cancel/delete
  and invitation update APIs are still not generated/available, so mock/local
  invite actions remain until DL-15494/BE readiness.

## 2026-07-08

- Added Dentlink `DL-14232` checkpoint: Clinic invite/member-management UI is ready for commit/push before real Clinic invite API integration.
- Recorded that invite API is still unavailable; invite page/modal behavior remains mock/local state, while Role/Authority code dropdown APIs are connected with fallback.
- Recorded query refresh fix: member detail actions now refresh member list/detail/count caches after authority change, member removal, approval, and rejection.

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
