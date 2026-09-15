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

- FE improvement planning uses one [meeting document](dentlink-fe-meeting.md)
  and one [demo app](https://dentlink-experience-studio.parkjongsunfrankie.chatgpt.site).
  See [the current checkpoint](dentlink-fe-opportunities.md) for scope and recovery.
  The user retired the Notion pages and duplicate PDFs on 2026-09-15; older
  Notion and PDF links below are historical, not current sharing destinations.
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

## FE Opportunity Planning — Breakpoint 1, 2026-09-15

- The user designated the Notion page linked above as the ongoing planning
  location and asked to preserve the current classified list before further
  discussion. Breakpoint 1 was written and read back: 41 candidates across five
  categories, seven collaboration-dependent ideas, four external references,
  seven preliminary recommendation groups, and the feasibility boundaries.
- The user removed the original two-week limit and welcomes ideas beyond the
  examples of refactoring, E2E, design systems, shipping, maps, and 3D spaces.
  The list is an exploratory checkpoint, not a selected implementation scope.
- The user clarified that the map example was inspired by ideas involving
  [Mapbox](https://www.mapbox.com/). Preserve that as context for the next
  discussion; Mapbox evaluation or re-ranking was not requested at this break.
- Resume by reading the Notion breakpoint and discussing the user's next
  direction. No product code, test execution, new implementation task, or
  product Git/PR mutation was performed for this capture.
- Candidate evidence is pinned to web master `de2ffdd9e` and app main `e0f4d5d`.
  Runtime usage, actual response completeness, and current Jira prioritization
  remain unverified; refresh only the sources needed for the next decision.

## FE Opportunity Planning — History 4 and Discussion Pause, 2026-09-15

- The team-sharing source remains [FE 9월 프로젝트](https://app.notion.com/p/3dcce072e82f80f8984ddd01b9554b26).
  After explicit approval, reorganized it into a concise current summary,
  six collapsible image samples with current interpretations, and collapsible
  histories 4 → 3 → 2 → breakpoint 1. Old recommendations and mistaken
  interpretations remain historical, with corrections in history 4.
- Notion readback verified every previous history's text, all original table
  rows (including 41 candidates and seven collaboration-dependent ideas), all
  six image storage paths, and the original prompt attachment. Ten native
  toggles retain nested content. Browser visual inspection required sign-in;
  preservation and structure were verified through the connected Notion tool.
- Current direction prioritizes visible product/business value led by FE;
  internal quality and automation remain eligible, with no duration limit.
  Samples 1+2 are one team-originated zoomable shipping experience: globe/global
  situation → region → individual shipment details. Actual shipment-to-order,
  coordinates and complete global-query coverage remain unverified.
- Sample 3 is an existing 3D viewer enhancement, now framed as carousel/model
  selection and enlargement. Separate order-scoped fetched-file browsing from
  complete chat attachment search and cross-order file management, whose APIs
  and persistence may require BE work. Sample 4 is retained without further
  development at the user's request.
- Sample 5 overlaps the [existing team spatial demo](https://innova-lab-spatial-studio.tata951193.chatgpt.site/),
  which already includes floor exploration and a 13-step workflow simulation.
  Further discussion should examine real order/process/handoff information
  and the other teammate's ongoing shared-lab work; its API and scope have not
  been inspected. Sample 6 meant guided sales/training scenarios, but its
  static image did not convey that well; a first-order demo already exists.
- Six generated static PNGs and prompts are also local under
  `/Users/parkjongsun/Documents/ChatGPT/FE/samples/2026-09-15-fe-concepts/`.
  They contain fictional data and do not prove product implementation.
- User requested organization, preparation and then waiting. No feature or
  implementation scope is selected. Resume with the Notion current summary,
  select the next discussion candidate/user/scenario, and verify only the
  needed data and existing functionality before refining it. No product code,
  product Git/PR change, or new implementation thread was created.
- Follow-up: the user found the history text itself too long. Condensed the
  four main-page histories to 6/3/3/3 bullets (about 92% less text, excluding
  links/markup), retaining current summary and six images. All four complete
  historical records, the 41-item list, source tables and prompt attachment
  were preserved and read back in the child page
  [FE 아이디어 · 상세 원문 보관](https://app.notion.com/p/3dcce072e82f8115b208d586b76c6d66).
  Resume from the short main-page history; open the archive only for details.

## FE Opportunity Planning — Breakpoint 2, 2026-09-15

Current dedicated planning and demo checkpoint:
[FE opportunity planning](dentlink-fe-opportunities.md). The user approved
record reorganization and presentation-ready prototypes for candidates 1–4.
That document now owns the detailed history, evidence and demo progress.

- Added a new top-level Notion breakpoint with 12 recommended candidates in
  name/function/category/FE-scope order. Readback confirmed all 12 rows and
  unchanged previous content, six images and the archive child-page link.
- First four to refine: global shipment overview-to-detail exploration, 3D
  carousel/enlargement UX, lab space/process visualization using the team's
  existing spatial demo and shared-lab work, and order-scoped file browsing.
  Shipping and real spatial/process integration remain conditional on data;
  the user explicitly requested retaining the lab-space candidate.
- Other shortlisted work: saved views/continuous order navigation, failed
  downloads, upload preflight, key-screen/3D performance, web E2E scenario
  coverage, design-system cleanup, QA capture, and PR validation automation.
  Rank is a planning recommendation, not a selected implementation scope.
- Product code remains unchanged. Resume from breakpoint 2; no more detail
  needs adding to prior histories unless the user asks.

## FE Opportunity Planning — Four Demos and Presentation Materials, 2026-09-15

- Detailed canonical checkpoint remains [FE opportunity planning](dentlink-fe-opportunities.md).
  Only BP2 candidates 1–4 were refined: global map → US region → individual
  shipment, 3D carousel/enlargement, lab space/process, and order-scoped file
  exploration. The original 41 candidates and 12-row shortlist are preserved.
  No actual product implementation candidate has been selected.
- Completed four interactive sample demos, a nine-page team PDF, 14 real UI
  screenshots, and a 58.93-second 1920×1080/30fps silent MP4 with the final
  shipping-playback correction. Artifacts are under
  `/Users/parkjongsun/Documents/ChatGPT/FE/deliverables/`: PDF
  `FE-4개-후보-시연-검토.pdf` and MP4 `Dentlink-FE-시연-둘러보기.mp4`.
  The MP4 combines static scene overviews with real shipping/model capture
  sequences; it is not a continuous recording of all 24 actions. Final decode
  and frame/caption review passed; separate full playback in a player was not
  recorded as verified.
- Browser/WebMCP verification covers all 24 steps, three invalid-input
  rejections with state preservation, four 390px-wide screens without
  horizontal overflow, corrected 3D enlargement clipping, and order 101→102
  selection/preview cleanup. PDF and selected ZIP generated actual browser
  download events and local saved files; PDF bytes match, and the ZIP contains
  exactly the two requested GLBs with matching bytes and CRC. All 66 fixed
  sample ZIP subsets also passed CRC verification. Selection download then
  prepared-ZIP save is a two-step flow, not a general live compression service.
- Final 3D asset is a directly generated, nonclinical synthetic arch with 14
  teeth and gingiva. Four materials are variants of the same synthetic shape.
  The initially researched CC0 stand model was not adopted; it is not the
  source of the final arch. No comparison or approval-round UI was included.
- Team sharing uses PDF/MP4. The new web demo is for the personal account:
  https://dentlink-experience-studio.parkjongsunfrankie.chatgpt.site .
  Private deployment and online key states were confirmed. Final materials:
  https://app.notion.com/p/3dcce072e82f81abbeabe933ba4ff128 . Existing team
  space content is an input/reference, not a newly created team feature.
  An online selected ZIP matched both final GLBs byte for byte and passed CRC.
  VP9 WebM was added for in-app playback after an MP4 playback crash; the WebM
  reached its final 0:58 screen locally. The original MP4 remains for sharing.
- For FE completion with existing data, review order-file exploration first,
  shipment exploration next. For company demonstration, emphasize shipping
  and space. These are different evaluation axes, not an approved roadmap.
  Real operating APIs, permissions, cross-order completeness, shared-lab
  process/handoff integration and physical-device performance remain separate
  verification gates. Use team feedback to select a product problem and
  bounded scope within the four candidates.
