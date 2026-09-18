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

- FE improvement planning uses one [Notion meeting document](https://app.notion.com/p/3dcce072e82f81628aa6fe5e28c833ca)
  and one [demo app](https://dentlink-experience-studio.parkjongsunfrankie.chatgpt.site).
  See [the current checkpoint](dentlink-fe-opportunities.md) for scope and recovery.
  The user selected Notion as the final source on 2026-09-15 for cross-device
  access and team editing. Fetch that page before edits; local
  `dentlink-fe-meeting.md` contains only a link. Older Notion history pages and
  PDFs remain retired and must not be restored as current meeting documents.
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

## Local Repository Housekeeping Completed — 2026-09-14

- A read-only web/app Git audit confirmed no extra registered worktrees in
  either repository. Web E2E's local feature branch and retired directory are
  absent. At audit time web retained local `master` and `release/v1.86.0`,
  both behind their remotes with no local-only commits.
- After that audit the user authorized cleanup. App now has only local `main`,
  clean and synchronized with `origin/main`; completed local `feature/DL-16061`
  was deleted after verifying its remote and squash-merge preservation.
  Exact evidence is in `projects/dentlink-app.md`. Each product has only its
  main checkout. The remote app feature was retained.
- The user then explicitly requested that web retain only local `master`.
  After confirming the local and remote release commits were included in
  `origin/master`, web `master` was fast-forwarded and local `release/v1.86.0`
  was deleted. Web now has only clean, synchronized `master`; the remote release
  remains preserved. Detailed web evidence is in
  `projects/dentlink-client-order-feedback.md`. No extra worktree remains in
  either product repository.

## E2E Coordination Checkpoint — 2026-09-14

- Local retirement completed around 19:03 KST on explicit user request. Removed
  the clean E2E worktree and local `feature/e2e-reliability`, about 12 GB of
  disposable worktree data, and 12 owned `/tmp` directories plus 41 files.
  All 49 changed files matched master/release before deletion. Curated QA
  evidence remains in the detailed checkpoint; raw local paths are historical.
  No owned server, 3100/3105/3102 listener or account/auth/onboarding lock remained.
  Shared caches/skills, unrelated stashes and remote refs were preserved.
- At E2E retirement, the remaining main checkout was clean local
  `release/v1.86.0` at `0e0878ef1`, with master at `ddeeb1e86`; the later
  housekeeping checkpoint above supersedes that local branch state.
  The completion prompt was delivered to this `메인세션`
  (`01a08f0c-2057-7852-ae8d-0cf950a91fd3`), which explicitly acknowledged
  reading canonical commit `5d9cd1b` and receiving the handoff at 19:04:42 KST.
  It is idle with no additional task or document mutation. The user will remove the old E2E app
  task/project themselves; do not create replacements or reopen completed work.
- Latest completion update around 18:59 KST supersedes the pending states below:
  the user confirmed master and production delivery. Live verification found
  [PR #4608](https://github.com/Innvoaid/dentlink-client/pull/4608) merged into
  master at `de2ffdd9e3025cb758632788cd6086c170e4974e`, containing E2E squash
  `c506661e6`; key runner/config files match the final feature source. Clinic,
  Lab and Admin production Actions `34826131930`, `34826221699`, `34826256088`
  all succeeded from their v1.86.0 tags at `c506661e6`. The earlier three stage
  Actions also succeeded. The E2E improvement is delivered and closed; no new
  scenario run or production functional test is claimed by this record update.
  Separate master UI S3 run `34826324855` failed at dependency installation;
  it is not an app deployment/E2E result and was not diagnosed in this update.
  Details and retained validation boundaries are in `dentlink-client-e2e.md`.
- Session closed at the user's request around 16:59 KST. Agreed E2E
  implementation/review/documentation and PR delivery are complete, with no known
  pending fix. The user confirmed owning the merges and deployment initiation.
  All three deployment workflows were still in progress at the final check;
  next follow-up starts with their deployment and E2E outcomes, not a new
  implementation plan. Worktrees/branches and the user's local UI were preserved.
- Current delivery supersedes the pre-merge review state below: the user merged
  E2E PR [#4606](https://github.com/Innvoaid/dentlink-client/pull/4606) into
  `release/v1.86.0` at 16:51:06 KST, squash commit
  `c506661e612b7105a7c8b73f32b96f39ee10b41c`.
- The user then authorized remote `stage` deletion/recreation from remote
  `master` and a release-to-stage PR. The E2E session used exact leases to delete
  old stage `28e5e0b1e` and recreate it at master `ddeeb1e86`, verified both refs,
  and created [PR #4607](https://github.com/Innvoaid/dentlink-client/pull/4607),
  `[Release] v1.86.0 스테이징 재배포`, `release/v1.86.0 -> stage`. The full release
  comparison is 16 commits/188 files, with no merge conflicts and a resulting
  tree identical to release. No local checkout/worktree/protection was changed.
- The user (`jongsunP`) merged #4607 at 16:55:48 KST while final verification was
  underway. Remote stage is now `2ce6c29d412f47976f74326b2202bca4b2c123af`.
  Exact-SHA deployment workflows started at 16:55:51 KST: Office/Clinic
  `34820155085`, Lab `34820155047`, Admin `34820155051`; all were **in progress**
  when checked. The agent did not merge or dispatch workflows. Actual deployment
  completion and new post-deployment E2E results still require verification.
- The following implementation/review evidence predates those merges and is
  retained with its original source and deployment boundaries.
- Detailed current state is in `projects/dentlink-client-e2e.md`. Worktree
  `/Users/parkjongsun/Repository/dentlink-client-e2e`, branch
  `feature/e2e-reliability`, HEAD `f267c4924`, clean and synchronized with
  `origin/feature/e2e-reliability`. The user authorized committing/pushing all
  49 approved files and creating open, non-draft
  [PR #4606](https://github.com/Innvoaid/dentlink-client/pull/4606) into
  `release/v1.86.0`. Remote PR head matches; merge-tree simulation against
  release `1e0754789` succeeded without conflict. No merge or deployment.
- The subsequently requested CodeRabbit cycle fixed two valid minor findings
  in `99f4780c8`: empty BUILD_ID now fails before DEV/STG deployment waits;
  onboarding's shared page uses the existing API monitor/reset/failure hooks.
  Both threads were answered/resolved, that review completed successfully, and
  focused staging onboarding **22/22** plus **211/211** regressions passed.
- The user also confirmed local UI tests worked and requested quieter logs.
  `f267c4924` preserves local server stdout/stderr in private per-run
  `webservers/{clinic,lab,admin}.log`, announces paths, and appends through UI
  Reload. CLI/headed/UI share this behavior; remote and direct Playwright paths
  retain their intended behavior. No service/ChannelTalk code or dependency
  changed. **219/219**, types and isolated native UI logging/Stop/Reload/startup
  failure checks passed. Existing user-run local UI was left running and needs
  a fresh launcher invocation for the new log environment. Source-qualified
  details and evidence are in the E2E checkpoint.
- The user approved completing all discussed follow-ups, asking for the design
  best suited to the existing workflow rather than unconditional UI parity.
  Manual operation remains local frontend with DEV API, or deployed staging
  with STG API. The unrequested `e2e:clinic:dev` alias and manual guidance were
  removed; existing DEV deployment CI retains its internal environment support.
- CLI, headed and UI commands now share environment/target/auth initialization
  and owned-process interruption protection. UI preserves native selection,
  reruns and Reload, archives each observed selection's JSON and applies the
  common result classifier. A private lifecycle journal catches setup/cleanup
  failures that native UI can hide. Later success does not erase earlier results.
- UI source snapshots record session boundaries. A normal `session_closed`
  is not a full test verdict: config/module errors before reporters may appear
  only in UI, and selection results do not prove independent full inventory,
  deployment versions or every intermediate state. Full release evidence remains
  the local/staging batch runner contract. Do not treat this as a new manual DEV
  workflow or a claim that every UI action is observed.
- The ten new E2E scripts remain `.js` CommonJS. No further script files or
  dependencies were added in this follow-up. Verified pre-commit source digest:
  `671bb59c6f5c2a52b34c089e03c0dbcec42aada4b4fa4a273dea8d78647ee9d8`.
  All 49 committed file contents match that snapshot; the commit changes HEAD
  and therefore the runner's digest, so the digest is historical run evidence.
  Regressions **211/211**, syntax **10/10**, E2E types, formatting, references,
  skills and independent code/side-effect review passed. Service app paths and
  existing DEV/STG build/deploy jobs are unchanged; CI changes concern E2E jobs.
- Real staging UI passed login/onboarding **25/25**, selected rerun **3/3**,
  and post-Reload **3/3**, then normal native window closure with two complete
  setup/teardown attempts, unchanged source and no recorded issue. Isolated real
  UI also verified expected failure, unapproved skip, in-body Stop and Reload
  cleanup failure remain observable. Real local UI passed **25/25** and **3/3
  after Reload**, with normal session closure, unchanged source and local server
  ports released. Final staging batch passed **104 + 5 allowed exclusions**,
  all 109 collected/reported, no failure/flaky/nonexecution, unchanged current
  source and all three portal BUILD_IDs, with `staging_full_verified=true`.
  The three real runs were sequential; final owned locks/recovery meta and local
  server listeners were absent. Approved follow-up implementation, verification
  and maintained documentation/skills are complete within these boundaries.
- Previous source-qualified full local/staging **104 + 5 allowed exclusions**,
  DEV focused **6/6**, invalid-target/account-lock evidence and exact run paths
  remain in the detailed checkpoint. They are historical evidence for their
  recorded sources, not substitutes for current or future deployment checks.
- Native app E2E is excluded. The role-neutral objective is trustworthy full
  staging decisions within registered web coverage, without a fixed pass count.
  Actual test-server data is mutated; cleanup is scoped and account locks are
  host-local, not distributed. Registration/assertion meaning still requires
  requirement/code review. Maintained guides and shared/personal skills use one
  authoring and execution contract; the personal installed skill matches its source.
- Commit/push hooks passed all three app type/lint checks (existing lint
  warnings), shared tests **27/27** and unchanged coverage. Missing ignored
  local coverage baseline was prepared with the existing command. The HTTPS
  workflow-scope rejection was resolved using already-authorized SSH identity
  with a command-only push URL override; no hook was bypassed or persistent
  remote/auth configuration changed.
- Final CodeRabbit verification on exact head `f267c4924`: **success / Review
  completed**, **zero unresolved threads**. The requested review cycle is complete.
  Initial Vercel failure required author project access; the final head reports
  `Deployment was blocked`. PR remains `MERGEABLE` but `BLOCKED`. Team review,
  release merge, deployment and actual remote E2E CI remain separate gates.
  No remote E2E run was started here.

## FE Opportunity Planning — Final Meeting and Demo, 2026-09-15

- Current scope, evidence, deployment and recovery are owned by
  [the FE opportunity checkpoint](dentlink-fe-opportunities.md).
- Team materials are one Notion meeting document and one public demo app.
  Preserve the two ranking axes: practical FE value and visible business value.
  The four demos illustrate the latter; no production task has been selected.
- Final refinement is deployed to the existing Site: real map detail, lab-space
  interiors, distinct synthetic dental models and order-context file browsing.
  The current gallery has 14 fresh screenshots and a 59-second silent slideshow.
- Historical breakpoint pages, local meeting bodies and PDF bundles are retired.
  Prior history is recoverable from Git; do not restore old links or duplicate
  detailed progress here. Fetch the current Notion before subsequent edits.

## Office Welcome Analytics — PR Created, 2026-09-18

- [PR #4611](https://github.com/Innvoaid/dentlink-client/pull/4611) targets
  `release/v1.87.0` from `feature/amplitude-pageview-tracking`; remote head is
  `26f08b9df39c40dbafba1f7232798e9644513d59`. The current checkout is
  `/Users/parkjongsun/Repository/dentlink-client`, clean and synchronized.
- The branch retains `7ef67797b` for Office-wide `[Amplitude] Page Viewed`
  collection after Next route completion, covering missed `replace` navigation.
  The added `26f08b9df` records `welcome_view` once per welcome-page mount via
  the existing `AMP_Track` queue; rerenders and StrictMode do not duplicate it,
  while leaving and revisiting records a new visit. Only the existing
  `useAmplitudeInit.ts` and welcome page were changed.
- Source: [product thread](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1789705299279979)
  and [welcome_view definition](https://app.notion.com/p/3dfce072e82f80bf9b5ed5076608579c).
  PM requested both the common collection improvement and the separate event
  for 1.87.0. Welcome exposure and approval/Get Started behavior remain unchanged;
  not every new member necessarily visits welcome.
- Checks passed: all three app type/lint hooks (existing lint warnings),
  coverage hook, formatting and diff checks. Earlier common-pageview checks
  passed 10 real-SDK local scenarios and 47 existing tests. The new actual-page,
  wrapper and SDK harness passed normal/StrictMode, delayed readiness, rerender,
  revisit and coexistence of both events, with no external network requests.
  Next navigation events and surrounding UI dependencies were simulated.
- PR creation is complete. Review, merge, deployment and live Amplitude receipt
  remain pending; no CodeRabbit follow-up or release mutation was requested.
  The production August count was not established as caused solely by this gap.
