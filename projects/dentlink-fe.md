# Dentlink Frontend Coordination

This is the personal cross-repository coordination checkpoint for Dentlink
frontend work. It is not a product repository, combined workspace, or worktree.
Detailed implementation history remains in the relevant existing project file.

## Scope

- Web/Admin repository: `/Users/parkjongsun/Repository/dentlink-client`
- Mobile app repository: `/Users/parkjongsun/Repository/dentlink-app`
- Durable context: `/Users/parkjongsun/Repository/codex-personal-context`
- Active AI workflow: Codex only. The remote `claude-personal-context`
  repository is retained only as an archive and is not loaded by default.

## Session Ownership

- The Dentlink FE top-level session is projectless and owns intake, web/app
  scope classification, shared decisions, priorities, release/deployment
  coordination, handoff prompts, and closeout.
- Sessions are created primarily for a feature or responsibility, not for a
  device or repository. One feature session may inspect and implement both its
  web and app portions across the two product repositories.
- Every code or Git mutation must still name and confirm the exact product
  repository, branch, and worktree. A shared feature scope does not combine Git
  histories or permit writing from an ambiguous directory.
- The top-level session may directly implement a small, clearly scoped change.
  Split out repository-specific or parallel sessions only when scope, runtime,
  ownership, or collision risk justifies it.
- Keep one active writing session per worktree. Repository main-checkout
  sessions are optional helpers for branch/worktree/release administration,
  not permanent web-versus-app session boundaries.
- Shared repository mutations still require the user's explicit authorization.

## Context Routing

- Read `projects/dentlink-client-order-feedback.md` and other matching
  `dentlink-client` checkpoints for web/Admin implementation history.
- Read `projects/dentlink-app.md` for app implementation, runtime, build, and
  deployment history.
- Read `projects/dentlink-unified-notification-center.md` when that cross-web/app
  feature resumes.
- Keep repository-specific branch, commit, QA, and blocker detail in those
  existing files. Record only cross-repository decisions and coordination
  state here.

## Transition Checkpoint — 2026-09-11

- The DL-15828 web-only session was closed, its dedicated worktree and local
  task branches were removed, and web follow-up moved to the main
  `dentlink-client` checkout. Its verified state is recorded in
  `projects/dentlink-client-order-feedback.md`.
- Live verification found the main `dentlink-client` checkout clean on
  `release/v1.86.0` at `0e0878ef1`, synchronized with its remote. Its only
  local branches are `master` at `ddeeb1e86` and `release/v1.86.0`, both at
  0/0 divergence, and its only registered worktree is the main checkout.
- The app-specific session completed its live Git, PR, Jira, validation and
  delivery audit on 2026-09-11. Its final handoff is recorded in
  `projects/dentlink-app.md`; the product repository remained unchanged during
  the handoff and personal context was the only authorized write target.
- The local `claude-personal-context` checkout was removed after confirming it
  had no local-only changes, commits, stash, or worktrees. Its GitHub repository
  remains available for optional future recovery.

## Top-Level Session Start

1. Pull `codex-personal-context` and read the common guidance plus this file.
2. Read the relevant web and app checkpoints before relying on prior chat.
3. Fetch/pull both product repositories only as required by the current task,
   then verify exact path, branch, HEAD, upstream, dirty state, and worktree.
4. Classify each new request as web, app, or shared before deciding the owning
   implementation session and release target.
5. Do not create a worktree for a very small change without first asking the
   user, and do not reuse a completed feature branch.
6. Reconcile Jira, Notion, Figma, Swagger, and live code when the new request
   depends on them; do not re-fetch every external source without a task-driven
   reason.

## Next Starting Point

- On 2026-09-11 the user delivered the prepared prompts to both the new
  projectless Dentlink FE top-level session and the existing app session.
- After prompt delivery, the user clarified that future sessions are organized
  by feature rather than by device or repository. The current rule in this
  checkpoint supersedes earlier prompt wording that implied web and app
  implementation sessions should be split by default.
- This former `dentlink-client` management session can now close. Its repository
  cleanup and cross-repository operating-rule migration are complete.
- The web and app session handoffs are complete. The new projectless Dentlink
  FE top-level session should pull `codex-personal-context` again and use the
  repository-specific project files as its starting evidence.
- For app work, first re-fetch `/Users/parkjongsun/Repository/dentlink-app` and
  verify PR #286, Jira, branch and runtime state. The preserved app starting
  point is `feature/DL-16061` at `a8f3a6c`; resume implementation only for a
  new QA card, reviewer finding, or confirmed product/API/design change.
- The top-level session accepted the app handoff and rechecked live state.
  The earlier transition handoffs came from the former web session;
  `DENTLINK_APP_FINAL_HANDOFF` came from the former app session. Keep their
  repository ownership distinct. Ask the user when a substantive conflict or
  unanswered decision remains after comparing the evidence.
  After the 15:07 handoff, PR #286 was merged into app `develop` at 15:09:46
  KST. Its squash result exactly preserves the feature tree. Detailed Git and
  review evidence is in the latest section of `projects/dentlink-app.md`.
- Keep current delivery gates separate: app implementation and develop
  integration are complete; DL-16229 and DL-16353 remain `READY FOR QA`.
  No formal human approval is recorded, and release/Production inclusion is
  not confirmed. Preserve existing branch/worktree state until the user asks
  for cleanup; do not reuse the completed feature branch for new work.

- On 2026-09-11 the existing unified-notification-center session aligned its
  role beneath this top-level session, retaining one web/app feature scope.
  It remains in planning with no assigned implementation branch or release;
  detailed decisions and verified state stay in
  `projects/dentlink-unified-notification-center.md`.

## E2E Coordination Checkpoint — 2026-09-11

- The initial read-only audit found CI success indicators overstating actual
  E2E success. It is now followed by implementation and runtime verification;
  the audit's no-run/no-edit statements describe only that earlier phase.
  Detailed current evidence and historical CI results are in
  `projects/dentlink-client-e2e.md`.
- Keep accurate CI result reporting, actual suite stability and feedback
  coverage as separate evidence. Native Detox readiness remains outside this
  improvement's scope.
- The user subsequently limited this improvement to web, including feedback;
  app E2E is deferred. Its goal is trustworthy full-suite staging verification
  as a basis for production delivery decisions. Fixed pass counts are neither the
  objective nor a minimum completion gate. Current policy and the revised
  personal skill are tracked in `projects/dentlink-client-e2e.md`.
- The user approved a dedicated web E2E worktree/project/task. The worktree
  and project `dentlink-client-e2e` are registered. Implementation is assigned
  to task `웹 E2E 신뢰성 개선`; exact IDs and the worktree checkpoint are recorded
  in `projects/dentlink-client-e2e.md`. This top-level session keeps coordination
  ownership and hands the agreed implementation/validation scope to that task.
- Handoff is complete: the full prompt was delivered automatically, and the
  dedicated task has now completed its authorized implementation/runtime scope.
  Scope/release decisions, integration and eventual cleanup return to this
  coordination session under the corresponding authorization.
- The dedicated task has uncommitted implementation on
  `feature/e2e-reliability` at HEAD `0e0878ef1`: three CI workflow gates and
  version evidence, fail-closed preparation/cleanup, fresh onboarding attempts
  per file execution, and evidence-based sign-in/DEV ISV corrections. CI helper
  regressions passed 27 tests and independent review findings were addressed.
  Product commit/push/PR/deployment remain unauthorized and have not occurred.
- Local full-suite evidence is **104 passed / 5 allowed skips**, with
  all 109 collected results accounted for and no failure, flaky result,
  unexpected nonexecution or setup/report error. Onboarding's 22 scenarios
  also passed first execution, same-runner Run All and a final fixed-code Reload,
  with exact office cleanup verified. Full counts and evidence limits remain in
  the detailed E2E checkpoint rather than being duplicated here.
- The first staging full run correctly failed on signup preparation (93 passed,
  1 failure, 5 allowed skips, 10 follow-up tests not run). Trace evidence identified
  a test wait on an input removed after successful verification. A one-function
  correction passed its complete 16-test consumer scope locally and on staging.
- **Final staging whole-suite verification passed: 104 passed / 5 allowed skips**,
  no failure/flaky/extra nonexecution or setup/report errors, all 109 planned
  results accounted for. Clinic/Lab/Admin BUILD_IDs and source evidence matched
  at the run's boundaries. This completes the authorized implementation/runtime
  scope; the product remains uncommitted and the new workflows have not been run
  remotely. Integration and delivery still need separate authorization.
- Operating guidance and the personal skill source/installed copy are aligned
  with the role-neutral objective and no fixed pass-count gate. Feedback's
  existing ten scenarios and additional coverage candidates are explicitly
  separated in the E2E checkpoint; no expansion of native E2E is implied.
