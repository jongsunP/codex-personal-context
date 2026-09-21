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

- The selected FE project is DLDS cleanup → AI prompt/harness refinement →
  an editor only if useful later. Use the [latest meeting](https://app.notion.com/p/3dfce072e82f812c843afed105630c98)
  and [implementation checkpoint](dentlink-fe-opportunities.md). Step 1 is in
  `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16466`.
  Latest implementation `0fa829542` adds 41 original-backed icons (452 total),
  viewport/scroll and keyboard fixes; documentation-only HEAD `f0d23995d` clarifies
  opt-in Modal/Popup vs default DropdownDrawer focus management. UI 162, icon
  generation 1, catalog checks and three-app types passed. Official local FE+DEV
  E2E 7 passed at the implementation commit after reproducing and fixing a real
  tablet Escape/focus race. Generic UI tsc still has the same 578 baseline errors,
  with no new diagnostics. Remaining icon originals (67) and logo variants (18) need
  Figma comparison. On 2026-09-21 official metadata and one previously blocked
  node screenshot succeeded; the old quota block is historical, not confirmed
  current. See the 2026-09-21 resume checkpoint before continuing. Whole Step1,
  real-device/screen-reader, staging and deployment are not complete. The user
  explicitly requests autonomous feasible work through product commit/push and
  Git memory closeout. PR/merge/deploy and AI harness remain separate. See the
  detailed checkpoint for source hashes, failed-run diagnosis and remaining scope.
  Resume DLDS/DL-16466 with the saved order: remaining Figma comparison → actual
  consumer-screen audit → evidence-based fixes/regression → Step1 handoff to AI.
  These follow-ups are not started. The user prioritizes resumability across
  usage interruptions/days/devices over finishing in one run. Save concrete next
  items and verified product/context commits at meaningful intermediate points,
  not only the end. Refresh account usage; historical 56% is not current quota.
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

## Office Welcome Analytics — Merged and Cleaned Up, 2026-09-18

- The user merged [PR #4613](https://github.com/Innvoaid/dentlink-client/pull/4613)
  into `release/v1.87.0` at 2026-09-18 16:30:38 KST. Squash commit:
  `f2e956f341a3f4b37a65813a272dddfea3e11080`; original PR head:
  `92c57f299e94568720ea1630d457104fb76ed378`. Both changed files have identical
  Git blobs in the original head and merge result; current release
  `7aaa5b8e306d136458b650db2527e298f505043c` also preserves them.
- Post-merge cleanup is complete. `/Users/parkjongsun/Repository/dentlink-client`
  is back on clean `master` at `de2ffdd9e3025cb758632788cd6086c170e4974e`,
  synchronized with `origin/master`. Local and remote `feature/DL-16474` and
  its remote-tracking ref are deleted; the old amplitude branch is also absent.
  The separate active DLDS worktree and `feature/DL-16466` remain intact.
- Jira is [DL-16474](https://innovaid.atlassian.net/browse/DL-16474),
  `[FE] 웰컴 앰플리튜드 이벤트 수정`. At the user's subsequent request, the
  remote and local branch were renamed from `feature/amplitude-pageview-tracking`
  to `feature/DL-16474`. GitHub closes an open PR when its head branch is renamed,
  so #4611 is closed and #4613 replaces it with identical three commits, title,
  target, assignee and requested reviewer. Both PR bodies link to each other;
  earlier review history stays on #4611 and does not transfer as new approval.
- The delivered commits include `7ef67797b` for Office-wide `[Amplitude] Page Viewed`
  collection after Next route completion, covering missed `replace` navigation.
  The added `26f08b9df` records `welcome_view` once per welcome-page mount via
  the existing `AMP_Track` queue; rerenders and StrictMode do not duplicate it,
  while leaving and revisiting records a new visit. Only the existing
  `useAmplitudeInit.ts` and welcome page were changed.
- Final follow-up `92c57f299` adds 23 lines to common initialization. SDK 2.43
  remote configuration can override local `pageViews.trackOn`, reproducing
  duplicate automatic/manual pageviews. A plugin registered before init sets
  `defaultTracking.pageViews.trackOn` after the remote merge and before builtin
  plugin installation. Other remote settings remain active. This prevents
  automatic pageview creation itself, preserving the click/pageview ID link;
  filtering already-created automatic events would allow an ID overwrite race.
- Source: [product thread](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1789705299279979)
  and [welcome_view definition](https://app.notion.com/p/3dfce072e82f80bf9b5ed5076608579c).
  PM requested both the common collection improvement and the separate event
  for 1.87.0. Welcome exposure and approval/Get Started behavior remain unchanged;
  not every new member necessarily visits welcome.
- Final checks passed: all three app type/lint hooks (228/189/410 existing
  warnings, zero errors), coverage hook with 27 shared tests, changed-file
  lint/format and diff checks. Real-SDK local scenarios passed 26/26: remote
  config 8, original hook 10, welcome normal/StrictMode 2, cache/follow-up remote
  response 6. Remote checks did not override `fetchRemoteConfig`; they asserted
  actual config subscription, one pageview per navigation, counters, click IDs,
  welcome event coexistence and preservation of other remote capture options.
  External requests and business mutations were zero. Next completion events,
  surrounding UI and Replay were test doubles; this is not full browser/Replay
  or live ingestion proof. SDK upgrades need the same remote/config checks.
- Historical temporary evidence: `/tmp/dentlink-amplitude-remote-regression.cjs`,
  `/tmp/dentlink-amplitude-defaultTracking-product-audit.cjs`, original
  `/tmp/dentlink-amplitude-hook-check.cjs` and welcome-event harness. Hook source
  SHA-256: `b3f79eb6b86fea5402350f2767a778054bb24d03ed28d5eab5551a6dfc8af551`.
  These scripts and their logs were removed after merge at the user's cleanup
  request; they are not available locally or as cross-device artifacts.
- The user confirmed both common collection and `welcome_view` belong in this
  delivery, and explicitly limited the final work to PR completion; the team
  handles deployment. The three commits are now included by the user's squash
  merge into `release/v1.87.0`. Deployment and live Amplitude receipt remain
  separate steps; the agent did not merge, deploy or run a CodeRabbit cycle.
  The production August count was not established as caused solely by this gap.
- Cleanup first removed nine obsolete experiments/drafts/logs, then removed
  the remaining four harnesses, two validation logs and the cleanup log after
  merge. At that checkpoint, no `/tmp/dentlink-amplitude*`, `/tmp/dentlink-welcome*`
  or `/tmp/dl-16474*` artifacts remained. Remote branch deletion used an exact SHA
  lease and normal push hooks; local deletion followed verified squash-result
  equivalence, release ancestry and preservation of the PR head in GitHub.
- Before merge, Vercel reported that Git author `jongsunP` needed project
  access to create deployments. That historical check is not a current open-PR
  blocker after the user's merge; no access-policy change was made here.
  Next step is team release delivery and actual Amplitude receipt verification.

## Amplitude Environment Consistency — Merged and Cleaned Up, 2026-09-18

- Following the merge above, [DL-16472 comment 44076](https://innovaid.atlassian.net/browse/DL-16472?focusedCommentId=44076)
  reported that staging received `welcome_view` but not `[Amplitude] Page Viewed`.
  Staging deployment `d1ee5acec501ee2fbd27b4e0cd80a0e32b8ebde5` succeeded in
  [workflow 35322222932](https://github.com/Innvoaid/dentlink-client/actions/runs/35322222932).
  Code review confirmed that automatic capture and Office pageviews still had
  a production-only condition, while explicit events ran in staging. This
  restriction predated DL-16474 (2025-08-11 commit `6757ac2f9`, PR #3061); its
  original rationale was not established. The prior pageview fix preserved it.
- The user authorized a new branch from `release/v1.87.0`, implementation,
  commit, push and another PR. [PR #4615](https://github.com/Innvoaid/dentlink-client/pull/4615)
  was created from `feature/DL-16474-amplitude-env` to `release/v1.87.0`.
  Base: `7aaa5b8e306d136458b650db2527e298f505043c`.
  Head: `f6a81010dca9fca028cafe82c83a37e455af129d`,
  `fix: Amplitude 환경별 이벤트 수집 기준 통일`. One commit, ten changed files.
  Jira remains [DL-16474](https://innovaid.atlassian.net/browse/DL-16474).
- `NEXT_PUBLIC_AMPLITUDE_ENABLED=true` plus a nonblank environment key now
  controls shared SDK loading, Track/Identify/Group, queueing and both app hooks.
  Disabled environments do not import the SDK or retain direct-event calls.
  Office and Lab production/staging/development retain their distinct existing
  keys, with both automatic and explicit collection enabled. The optional DEV
  preference question had no reply; the stated default preserves existing
  direct-event use and enables automatic collection consistently. These are
  build-time Next.js settings, not runtime consent/toggle controls.
- `NEXT_PUBLIC_AMPLITUDE_SESSION_REPLAY_ENABLED` remains independent: Office
  production only, Lab all three environments, matching prior behavior. Global
  collection off also disables Replay. Office production cookie domain and
  pageview snapshot/remote-config duplicate defenses are preserved. Actual SDK
  keys are trimmed. Lab now awaits the actual init promise before queue flush;
  its existing Replay initialization order is retained. Admin has no configured
  Amplitude init/key and gains no new collection. Welcome exposure is unchanged;
  Lab's existing `replaceState` pageview limitation was not rewritten here.
- Verification passed: all three app type and lint hooks; lint had zero errors
  and 222/189/410 existing warnings. Shared coverage hook passed 45 tests,
  including 18 new shared-helper regression tests. Changed-file lint, formatting
  and diff checks passed. Fresh worktree dependencies were installed with the
  frozen lockfile, and `next typegen` generated ignored app type entrypoints;
  no lockfile or generated tracked files changed. Coverage used the existing
  ignored baseline copied from the main checkout.
- Real SDK 2.43.0 local harness passed seven scenarios: Office staging/prod/dev,
  disabled collection, Replay enabled, and Lab staging enabled/disabled. Office
  initial/push/replace pageviews occur once per navigation, counters and click
  IDs remain linked, and `welcome_view` coexists. Actual RemoteConfig subscription
  received `pageViews:true` without duplicate Office pageviews; other remote
  settings remained active. Disabled cases imported/initialized/sent nothing.
  External requests and business API calls were zero. Next route events, Replay
  and transport were test doubles; this does not prove live ingestion, real
  Replay recording or deployment environment injection. Historical temporary
  harness `/tmp/dl-16474-env-runtime.cjs` was removed during post-merge cleanup;
  it is not a local or cross-device artifact now.
- The user merged PR #4615 on 2026-09-18 at 19:09:31 KST. Squash commit
  `08b74ee9084605ccde8cc19ef0bda836db132a59` is the verified release head.
  Its complete Git tree equals the original PR head, and all ten changed files
  have identical blobs. CodeRabbit completed successfully on the final head;
  review threads total zero, unresolved zero. Its review body contains one
  nonblocking suggestion to log Replay failures. The user requested verification
  and cleanup only, so no additional code change or review response was made.
- Cleanup completed at the user's request: removed the remote branch using an
  exact-head lease and normal push hooks, then removed the clean dedicated
  `/Users/parkjongsun/Repository/dentlink-client-amplitude-env` worktree, local
  feature branch and nine task-specific temporary harness/draft/log files.
  The main `/Users/parkjongsun/Repository/dentlink-client` checkout remains clean
  `master` at `de2ffdd9e3025cb758632788cd6086c170e4974e`, synchronized with
  `origin/master`. The independent DLDS worktree and `feature/DL-16466` were
  untouched. No amplitude follow-up branch/worktree or `/tmp/dl-16474-env*`
  artifact remains. Task is complete; wait for the user's next instruction.
- At PR creation, GitHub reported `MERGEABLE` with overall `BLOCKED` status:
  Vercel's `dentlink-dlos` preview says `Deployment was blocked`; no more specific
  current cause was established. Auto Assign succeeded and CodeRabbit was in
  progress. CodeRabbit later completed as recorded above; the Vercel status
  remained blocked on the merged PR. The agent did not merge, deploy or post
  Jira/Slack comments. Deployment with the new build-time flags and confirmation
  of staging pageviews plus `welcome_view` remain team-side follow-up; they were
  not verified by this cleanup.
