# AI Workflow

## Codex Usage Model

Codex is the user's active AI for company development, personal repository
work, and project coordination. Claude is no longer used in the active
workflow, and its former context repository is an archive rather than a source
to load at session start.

**Update 2026-11-11 (user instruction):** Claude Code is active again alongside
Codex. On 2026-11-10 the user required every record to go to both Claude memory
and this repository. On 2026-11-11 the user designated a Claude Code session as
the Dentlink FE main session covering Web, Office and Lab (see
`projects/dentlink-fe.md` Session Ownership). The rules in this repository apply
to Claude Code as written; apply Codex-specific mechanics through **Claude Code
Mapping** below. The older sentence above is retained as history.

### Claude Code Mapping

Canonical translation of Codex-specific mechanics, recorded 2026-11-11. The
working rules themselves (permissions, branch/PR policy, scope, verification,
Jira, reporting, both-sides recording) are unchanged.

| Codex mechanic | Claude Code equivalent |
| --- | --- |
| `~/.codex` local guidance via `setup-local-codex.sh` | `~/.claude/CLAUDE.md` (global, Git-synced via `claude-personal-context`) points to this repository's read order; it does not copy rules |
| Codex runtime memory | Claude memory under `~/.claude/projects/<folder-key>/memory`, kept in sync with this repository |
| Main session folder `Documents/ChatGPT/메인 프로젝트` | The folder that holds the product repositories, itself not a Git repository: `/Users/parkjongsun/repository` on the home Mac, `/Users/parkjongsun/Repository` on the office Mac (same memory key, case-insensitive). One main session per agent; see `projects/dentlink-fe.md` Session Ownership |
| New session `model` + `thinking` passed explicitly | `start_session` inherits the main session's model and effort when `model`/`effort` are omitted (the tool only allows equal or lower). Omit them, then verify with `get_session`. Do not rely on the app's default model setting, which can differ |
| Session ID / registration check | `start_session` result + `get_session` / `list_sessions {"linked": true}` |
| Delegate then stop polling | Same. The app notifies the main session when a started session ends its turn; do not poll |
| Feature worktree + `feat/<Jira>` branch | Create the branch and worktree with Git yourself, then `start_session` with `cwd` = that worktree and `use_worktree: false`. Do not let the tool create a branch (its prefix setting adds a suffix). The app `branch_prefix` was set to `feat` as a safety net |
| Phone Remote Continuity / pairing PIN | Claude Remote Control (claude.ai/code, Claude mobile app). New sessions connect by default since 2026-11-11; an existing session uses `set_remote_control` on request. No PIN procedure |
| Archive/keep main session | Same rule; archive tools exist (`archive_session`) and the main session stays unarchived |
| Atlassian current plugin `mcp__codex_apps__atlassian_*` | Claude's Atlassian connector. Same site rule: `innovaid.atlassian.net`. Authorization is the user's (`/mcp`) |
| Figma `figma_http` direct MCP | Claude's Figma connector. Authorization is the user's |
| Codex in-app/non-visible browser; isolated test browser when needed | Same visibility rule: available in-app or headless first for agent-only work; external visible browser for requested preview or a genuine technical need. Testing Chrome is isolation, not a headed-launch requirement. Reuse sessions and avoid flashing/focus changes |

Use multiple Codex sessions when separation improves ownership and context:

- A top-level management session coordinates a product area across separate
  repositories. For Dentlink, actual implementation belongs in feature
  sessions by default, including small tasks. Follow the size/continuation
  routing rule in `SESSION_WORKFLOW.md`; direct main-session implementation
  is an exception when the user chooses it.
- Default to one session per logical feature or bug, including coordinated web
  and app work across repositories. Separate sessions only when product-specific
  purposes, requirements, timing, or ownership justify independent work under
  **New Work Intake And Session Routing** in `SESSION_WORKFLOW.md`. Different
  devices, repositories, or product Jira cards alone do not justify separation.
- Inside any session, every mutation still belongs to an explicitly confirmed
  repository, branch, or worktree. Do not blur Git histories merely because
  the same feature session owns both surfaces.
- Each worktree has one active writing session unless the user explicitly
  coordinates otherwise. A feature session may own several product worktrees.
- Durable continuity remains Git-backed in `codex-personal-context`; chat and
  device-local session history are supplementary.
- Keep the primary Mac as the execution host when a phone or another computer
  controls it; distinguish this from explicitly moving execution to another PC.
  Follow **Phone Remote Continuity** in `SESSION_WORKFLOW.md` for the user's
  established meaning of `원격화` and routine new-session registration and
  initial checkpoint requirements. Git-backed recovery and mobile chat-list
  visibility are different mechanisms.

### New Session Model And Reasoning Default

This is the user's standing preference for newly delegated work sessions,
confirmed on 2026-10-06. It applies across projects unless the user explicitly
selects a different model or reasoning level for the task.

- Prefer the main/coordinating session's verified current model **and**
  reasoning level. Read the actual session settings; do not assume that a
  new session inherits them or permanently hardcode today's model name.
- When the same combination is unavailable or cannot be established, select
  the highest-capability model available at the destination and its highest
  supported reasoning level. Check current supported combinations rather
  than inferring capability from a model name or list order.
- Explicitly pass both `model` and `thinking` when creating a work session.
  Omitting them applies the user's app defaults, which may differ from the
  main session. The user's standing instruction authorizes this selection;
  do not ask again for each already-authorized new session.
- Do not lower model capability or reasoning to save time or cost, or because
  a task appears small, unless the user asks. For internal delegated agents,
  preserve the main session's settings when inheritance is supported.
- After creation, verify the actual applied model and reasoning using
  available session metadata. Distinguish the requested settings from the
  verified settings if verification is temporarily unavailable. If the tool
  cannot apply the required combination, report the limitation instead of
  silently using a lower/default setting.
- This creation default does not change existing sessions or global app
  settings without a separate user request.

## Context Hierarchy

Trust context in this order:

1. Current explicit user instruction
2. Remote Git source of truth
3. `codex-personal-context`, including the personal project checkpoint
4. Stable team-owned project documentation
5. AI memory
6. General assumptions

If there is conflict, ask or follow the more explicit and more recent source.

Use history, checkpoints, and skills to understand the intent behind a
procedure. A past run count or successful workaround is not automatically a
permanent requirement or completion criterion. When the user clarifies the
goal, update the relevant maintained guidance and skills within the authorized
scope; preserve historical evidence with a clear superseded label. Judge the
current work by evidence that supports its purpose, not by mechanical replay
of an old checklist.

Remote state has priority over local-only state. Before relying on local
project or context files, pull the relevant repository when possible. If local
state differs from remote state, do not assume local is correct unless the user
explicitly says the local unpushed work should be treated as authoritative.

When the user asks to check app or project progress, pull
`codex-personal-context` first and read the personal project checkpoint. Then
fetch or pull the relevant project repository and verify the checkpoint against
the live branch, HEAD, worktree, code, and team-owned documentation instead of
answering from chat history or local assumptions.

## Session Startup

At the beginning of work:

1. Sync `codex-personal-context`.
2. Follow the canonical [Read Order](BOOTSTRAP.md#read-order), including the
   core guidance and the active project's current checkpoint.
3. Use the task-specific document and history references required by that
   read path. Unrelated personal topics and entire change logs are not startup
   requirements.
4. For product work, follow **Start Or Resume Workflow** in
   `SESSION_WORKFLOW.md` to reconcile the checkpoint with the exact live
   repository and relevant stable team documentation.

## Long-Term Memory Behavior

When discovering something likely to matter in future sessions, the AI should:

1. Briefly identify it as a long-term context candidate.
2. Suggest where it belongs in this repository.
3. Add it when the user agrees or clearly requests context maintenance.

Do not store secrets or sensitive credentials.

## Remote Continuity Rule

When the user asks to check project progress, verify current state, or confirm
something about the user, do not leave durable findings only in local state or
chat history.

If the finding is likely to matter in future sessions, update the appropriate
remote-backed Git source of truth:

- Personal project progress and handoff history belong in
  `codex-personal-context/projects/<project>.md`.
- User-level preferences and cross-project context also belong in
  `codex-personal-context`.
- Shared project repositories should receive only stable, team-owned canonical
  documentation, not personal Codex session status.
- At meaningful closeout, commit and push `codex-personal-context` so another AI
  session or computer can continue from the same facts. Shared project commits,
  pushes, and PR mutations still require explicit user authorization.

Avoid committing secrets, credentials, private customer data, or transient
scratch details.

## Preferred AI Behavior

- Be proactive once context is clear.
- Ask questions only when assumptions would be risky.
- Explain important tradeoffs.
- Follow [Local Development And User Preview](SESSION_WORKFLOW.md#local-development-and-user-preview):
  agent-only development, research and automation default to internal/in-app
  or non-visible tools when available and sufficient. External visible browser
  use is for requested preview or a genuine technical need, not routine lookup
  steps. For direct user inspection, expose the exact code, execution/logs and
  actual rendered browser/device with the appropriate independent setup.
  Follow the canonical browser visibility/isolation distinction and preserve
  suitable existing windows, layout and sessions.
- Treat an implementation request as a goal to solve, not as an instruction to
  follow blindly or a reason to retreat behind risk. First inspect the closest
  existing behavior, comparable cases, and project constraints. If the
  requested direction is sound, proceed fully. If evidence supports a better
  direction, explain it with concrete examples that a nondeveloper stakeholder
  can understand, recommend it decisively, and execute the agreed direction
  with the same commitment. Do not use architecture, ambiguity, or uncertainty
  as a substitute for ownership; distinguish real blockers from engineering
  judgment.
- When drafting Jira comments or other stakeholder messages on the user's
  behalf, act as an evidence-based advocate rather than only polishing prose.
  Preserve the user's intent, remove emotional or defensive framing, cite a
  concrete comparable example when available, and make the conclusion or
  question easy for a nondeveloper to evaluate.
- Treat QA-card comments as answers to the nondeveloper who reported the issue,
  not as developer changelogs. Lead with the confirmed outcome, relate it to a
  familiar existing product behavior when useful, and state what the reporter
  should now observe. Omit internal query, cache, hook, file, and implementation
  details unless they are necessary to explain a remaining limitation.
- Preserve project continuity.
- Keep the personal project checkpoint updated when work changes project state.
- Prefer remote-pushed Git context over local-only notes for durable progress
  and user-context updates.
- Treat remote Git as the default source of truth for continuity.
- For app progress questions, read the remote personal checkpoint first, then
  verify it against the remote and local project Git state unless the user
  explicitly asks for a narrower source.

## Local Docker Verification And Tool Reuse

For authorized local Docker checks, reuse installed tools and a suitable
existing profile after checking its saved configuration and other sessions'
usage. Do not reinstall tools or create a default profile for each task.

- The current Mac has user-approved Colima/Docker tooling. The recorded
  profile is `dentlink-env-check`, with Docker context
  `colima-dentlink-env-check`. Start only the explicitly selected profile,
  using `--activate=false` so the default Docker context is not changed.
- Preserve its isolated mount at `/private/tmp/dentlink-env-check`; do not
  add home, repository, SSH-agent, or authentication-file mounts. Read the
  [device setup and verification history](projects/dentlink-client-env-management.md#local-docker-tool-reuse)
  before reuse. Versions and resource allocations there are dated snapshots.
- Run Docker with its isolated config and explicit context:

  ```sh
  env -u DOCKER_HOST -u DOCKER_CONTEXT DOCKER_CONFIG=/Users/parkjongsun/.local/share/dentlink-docker-check/docker-config docker --context colima-dentlink-env-check <command>
  ```

- For synthetic checks, use an isolated `git archive` of tracked source and
  synthetic configuration. Exclude actual env/auth files from archive and
  build inputs even if tracked. Do not automatically read or copy these files;
  actual environment values remain human-managed.
- Installed tooling does not extend authorization to actual credentials,
  deployment, external image pushes, or authenticated E2E. Synthetic local
  results do not prove real-configuration, server-deployment, or user QA success.
- At completion, stop only the dedicated profile used for that task after
  confirming no other session is using it. Preserve images and caches; do not
  stop or delete another session's profiles or containers.
- This installation is device-local. On another device, check installation
  and any needed approval separately. A memory update does not start tools,
  run checks, or resume paused work.

## Atlassian Connection Selection And Recovery

This is the user's shared rule for existing and new sessions, confirmed on
2026-10-19 after a successful connection repair.

- Use the current **Atlassian** plugin (`mcp__codex_apps__atlassian_*`) for
  Jira/Confluence. Do not select **Atlassian Rovo (Legacy)** or silently fall
  back to its `atlassian_rovo__legacy` tools. Its connection is separate and
  remained unauthenticated when the current plugin was repaired.
- For Dentlink work, use **`https://innovaid.atlassian.net`**, not
  `dentlink.atlassian.net`. The verified cloud ID is
  `e167280a-9dbd-4306-a629-456c995be3c9`; confirm the authorized site with the
  current plugin's accessible-resources tool as required by its tool contract,
  then pass that site explicitly. Do not substitute a different site's
  similarly named issue when the intended site is not authorized.
- Diagnose separately: Legacy reauthentication errors, current-plugin site
  approval errors, and actual issue permissions/not-found errors. On
  2026-10-19, Legacy required reauthentication and the current plugin initially
  had only the wrong `dentlink` site grant. Reconnecting the current plugin to
  Innovaid restored actual `DL-16471` reads. This was not a product-code issue.
- A successful Jira browser login, installed/enabled plugin, or connection
  toast alone does not prove connector access. Verify the authorized site and
  read the requested issue through the current plugin before declaring repair
  complete. Authentication may expire or permissions may change later.
- If recovery is needed, the verified web path is ChatGPT Plugins → Atlassian
  → Manage → connected account menu → Reconnect → Atlassian connect → select
  Innovaid → accept the displayed consent. The direct settings page is
  `https://chatgpt.com/settings/plugins-settings/plugin_asdk_app_6a83901dde988191b3f3cefdcc19acfa`.
  Read the actual UI before acting; labels and paths may change. Obtain any
  required action-time consent for site access/terms. Never request tokens in
  chat, bypass an app-control restriction, or uninstall a plugin merely to
  repair OAuth. If the site is absent, check the signed-in account/site access
  and applicable administrator policy rather than repeating blind reconnects.
- An old session may still expose or choose Legacy. Discover the current
  plugin's tools first; if unavailable, explain that limitation and refresh the
  session/plugin availability through supported controls. Do not guarantee
  that every existing session or another account/device has been repaired.
- The Dentlink main session carries this rule into relevant existing-session
  handoffs and new-session prompts. Shared Git context is the durable source;
  local guidance sync alone is not cross-device delivery. Propagating the rule
  does not authorize product changes, deployments, or unsolicited Jira edits.

## Jira Work Updates

The description, comment, and document-link rules below apply to Jira and
similar work-tracking cards across all projects and future tasks. The
Dentlink-specific intake rules remain limited to Dentlink.

- Apply the user's 2026-11-09 Jira status meanings when organizing their work:
  **remaining or not-started work = To Do (해야 할 일)**;
  **work actually being performed = In Progress (진행 중)**;
  **work no longer needed = Done (완료)**, with the exclusion reason;
  **finished requested work = Development Complete** (Dentlink currently
  uses `Ready for Deploy` for this state). Confirm the available transitions.
  Do not put ordinary policy/API waiting work on ON HOLD instead of To Do.
  A partly completed card with remaining work is To Do when not actively being
  worked on; preserve its completed portion in the record. No In Progress cards
  does not mean all work is finished. Keep QA, review, merge and deployment
  separate, and preserve story points unless explicitly authorized to change.
- For authorized Dentlink work intake, classify Web/Admin, Office native app,
  and Lab native app separately. This is the user's standing preference,
  confirmed on 2026-10-08: reuse an existing suitable product issue, or create
  a separate card for each affected product when bundled work lacks one.
  Routine product-card preparation and updates are included in authorized
  intake; do not repeat the same permission question for each missing card.
  An explicit read-only, setup-only, or pause request still limits mutations.
- Do not always create three cards. Record unaffected products with the
  reason, keep uncertain impact pending, and ask only for missing scope or
  ownership decisions. Check existing children and linked issues before
  creating anything so another assignee's work is not duplicated.
- Keep a shared parent or requirement reference where the actual Jira issue
  types and hierarchy allow it. Do not invent nested subtasks, reassign
  someone else's card, or invent fixVersions and due dates. Product labels in
  titles should follow existing project vocabulary; identify the product
  clearly when the current title does not.
- Track each product's requirements, PR, checks, QA, release integration, and
  deployment separately. A common API/BE requirement can remain one linked
  source; another product's completion is not proof of this card's completion.
  Splitting cards does not automatically split sessions, folders, or worktrees.
- Size implementation cards around a feature flow with a clear development
  completion criterion. A large product-wide estimate may need several cards;
  do not default to one card per product when that hides progress. Keep UI,
  API integration, and ordinary failure handling together for that flow rather
  than creating a card per file or API. Reuse existing cards and distinguish
  task splitting from starting implementation. A pure split preserves the
  reviewed total; a re-estimate may change it when scope, reuse, actual effort,
  or duplicate allowances provide new evidence. Do not force new estimates
  to reproduce an old total. Apply **Dentlink Story Point Estimation** before
  proposing or writing points; AI-generated card content does not validate
  the estimate, and Jira field-write authorization remains separate.
- Apply this rule to new intake and resumed work when needed. A request to
  save the policy is not authorization to bulk rewrite existing Jira issues,
  rename existing branches/PRs, or mutate a product repository.
- When a task has parent and child issues, organize work updates on the child
  issue assigned to the user. Do not comment on a parent issue unless the user
  explicitly requests it.
- Give the user's child issue a concrete title that identifies the work;
  a title containing only `FE` or `[FE]` is not sufficient.
- Use the description for the stable definition of the work: purpose, scope,
  requirements, and initial preparation or agreed approach. Update it when
  that definition changes, not each time progress changes. Preserve sufficient
  user-written content and completed meeting decisions; when reviewing a
  sound card, polish wording rather than expanding or rebuilding it.
- Record subsequent confirmed progress, verification, remaining work, and any
  current pause in a concise comment on the user's child issue when useful.
  Use the same card if there is no parent/child structure. Do not add a comment
  just to report cosmetic editing or repeat unchanged status. Keep the issue's
  status distinct from Codex's personal waiting state.
- Keep shared document links and the document index on the parent card.
  Child cards do not need repeated document lists, a manual parent link, or
  a duplicate child list already available through the tracker hierarchy.
  Without a parent, keep the necessary links on the work card itself. Specific
  evidence such as a PR or verification result may accompany the progress
  comment it supports. Preserve historical comments; this rule does not
  authorize removing their existing links or rewriting other cards in bulk.
- Apply the nondeveloper-facing QA/comment style above. Change titles,
  descriptions, or comments only within the user's authorized scope.

- Finding backend handoffs (user, 2026-11-12): backend API/spec notes for FE usually sit in the parent card's comments, but a backend developer may post them on their own sub-card instead (e.g. the notification settings change on DL-17114, not parent DL-16140). If the parent has nothing, check sibling backend cards for the newest comment that mentions the user (what the user sees in Jira notifications). The user may also give a linked Notion page.

## Figma Comments And Personal Review Notes

The user confirmed on 2026-10-27 that self-addressed Figma comments are
development notes to review, not noise to exclude from mention searches.

- For comment-based requirement review, read the comment, its replies and
  corrections, and the exact pinned design region together. Distinguish a
  question or provisional personal interpretation from an agreed requirement.
- When the user asks about their review notes collectively, verify every
  identified note and its pinned region; a supplied link is an example, not
  permission to narrow the review to that one comment. Compare edited live
  comments with email snapshots before carrying forward an unresolved item.
- The Figma connector supplies design content but may not expose comments.
  Notification email can locate comments, including the user's self-mentions,
  but is not proof of the complete current thread or its exact pin location.
- A verified local fallback is the signed-in Chrome UI: open the exact supplied
  Figma comment URL, identify its Chrome window through CoreGraphics, capture
  only that window with `screencapture -x -o -l <current-window-id> <temp.png>`,
  and inspect it with `view_image`. Use this direct window check consistently
  when reviewing comments that the connector cannot read; do not stop at an
  email snippet when the live comment and its screen can be checked.
- Chrome's accessibility tree can expose current comment text and replies.
  Pair that text with a target-window screenshot to verify the pin and design.
  On this device, focusing the exact comment-row accessibility button and
  sending Space to the Chrome process opened the selected thread; AXPress
  alone did not. Prefer targeted UI operations over global mouse/keyboard
  events, and verify the resulting thread before continuing. Never target
  reply inputs, send, resolve, reaction, or notification-state controls.
- Resolve the window ID each time; Chrome AppleScript tab/window IDs are not
  CoreGraphics capture IDs. `CGWindowListCopyWindowInfo` can be queried with
  Swift to select the exact owner/title/bounds. A window-specific capture also
  avoids capturing unrelated monitors or depending on the foreground app.
- On the current device, Chrome AppleScript JavaScript execution is disabled.
  Do not silently enable that security setting or read browser credentials.
  Window capture worked without changing it. Do not use the voice-only screen
  context tool in a text chat.
- Observe the user's read-only limits: no comment submission, editing,
  resolution, reactions, deletion, or explicit notification read-state changes.
  Do not activate notification/email tracking links merely to resolve a URL.
  If a target or older replies cannot be read, record the exact remaining gap;
  one visible thread is not evidence that all comments were reviewed.

## Truthfulness And Uncertainty Calibration

This applies to all Codex work for the user, across projects and sessions.

Accuracy and honesty are more important than confidence, speed, or sounding
intelligent.

Rules:

- If you do not know, say you do not know.
- If something is an assumption, hypothesis, inference, or recommendation,
  label it explicitly.
- Distinguish clearly between:
  - confirmed fact
  - observation
  - hypothesis
  - recommendation
  - unknown
- Do not claim work was completed unless it was actually completed and verified.
- Do not imply implementation exists if only a design, idea, or document exists.
- Distinguish clearly between what was observed, inferred, implemented, and
  what still needs validation.
- If multiple explanations are possible, do not present one explanation as fact
  unless evidence supports it.
- Avoid plausible-sounding answers when evidence is missing.
- When diagnosing problems, prefer "unknown yet" over premature conclusions and
  recommend evidence collection before proposing fixes.

For AI analysis work:

- Separate raw evidence, interpretation, confidence, and uncertainty.
- Preserve raw model outputs when diagnosing quality issues.
- Treat model classifications as claims to validate, not facts.
- Prefer calibrated uncertainty over a wrong high-confidence answer.
