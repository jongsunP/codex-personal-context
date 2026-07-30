# Session Workflow

## Purpose

This file defines the user's preferred Codex session operating model across
all projects and devices.

The goal is continuous work without losing context: Codex should be able to
pause, resume, summarize, and hand off work through Git-backed memory instead
of relying only on chat history.

## Codex Working Environment As Code

Treat the Codex working environment like environment-as-code.

`codex-personal-context` plus the active project repository are the portable,
Git-backed source of truth for how Codex should behave. If Device A and Device
B both pull the same personal-context repo and the same project repo, Codex
should behave as consistently as possible across both devices, like starting
from the same declared environment.

This includes communication preferences such as Korean honorific replies,
handoff format, read order, closeout behavior, build policy, and project
source-of-truth rules. Device-local chat history can add context, but it must
not override the Git-backed rules unless the user explicitly changes and
records the rule.

The desired loop is:

```text
pull personal context
pull project repo
read in the documented order
apply recorded rules
write only to canonical locations
commit and push durable changes
```

The preferred local layout keeps `~/Repository/codex-personal-context` as a
normal Git repository folder and keeps `~/.codex` as Codex's machine-local
runtime home. Do not make `~/Repository/codex-personal-context` a symlink to
`~/.codex` by default. Use `setup-local-codex.sh` to sync the active guidance
files from the repository into `~/.codex`.

If a setting, preference, project state, or handoff rule matters beyond the
current chat, it should be represented in Git-backed documents rather than
left only in local session memory.

## Meaning Of Memory

When this user says `메모리`, `메모리 저장`, or `메모리 싱크`, the default
meaning is the Git-backed `codex-personal-context` repository, not Codex's
machine-local runtime memory under `~/.codex/memories`.

- `codex-personal-context` is the portable, pullable source of truth across
  sessions, devices, and Codex installations.
- `~/.codex` is a local runtime target for active guidance, auth, caches,
  sessions, and secondary AI memory. Writing only there does not count as
  remote durable memory.
- Intermediate implementation details do not need to be pushed continuously.
  At meaningful work closeout, curate the current status, learned rules,
  blockers, verification, and next start point into
  `projects/<project>.md`, then commit and push `codex-personal-context`.
- At work start or resume, pull `codex-personal-context` first and read the
  relevant project document before relying on chat history or runtime memory.
- General working rules belong in the canonical personal guidance files.
  Personal project checkpoints belong in `projects/<project>.md`. A shared
  project repository should contain only code and stable, team-owned canonical
  documentation, not a duplicate personal Codex handoff.

## Rule Application Model

Treat recorded rules like a single source-of-truth state flow.

- If a durable rule is recorded in the approved read path, apply it by default.
- Do not silently reinterpret, duplicate, or partially copy rules into another
  file.
- The user may restate the same intent in different words. Treat that as a
  signal to normalize the intent, compare it with existing canonical rules, and
  merge or tighten the existing rule instead of appending a duplicate.
- Record durable preferences as curated operating rules, not as a raw chat log.
- If a rule needs to change, update the canonical location instead of layering
  a conflicting rule elsewhere.
- If two recorded rules conflict, stop and resolve the source-of-truth location
  instead of choosing one ad hoc.
- If a rule was never recorded, handle it by best judgment and consider whether
  it should be written to the appropriate canonical file.

## Repository Boundaries

Use `codex-personal-context` for:

- Cross-project user preferences.
- Codex working style.
- Session start and end workflows.
- Durable personal context.
- AI tool usage preferences.
- Personal project progress and history.
- Branch and commit checkpoints, QA and verification, blockers, decisions, and
  the next starting point for each project under `projects/<project>.md`.

Use each project repository for:

- Source code and generated artifacts that belong to the product.
- Stable product contracts and architecture used by the team.
- Team-owned developer instructions and canonical project documentation.
- Information that remains useful independently of this user's Codex workflow.

Do not add personal session progress, AI handoffs, or transient QA checkpoints
to a repository shared by the whole team. When a finding changes team-owned
canonical information, update both the personal history here and the relevant
project documentation without duplicating the entire status log.

## Session Roles

Separate sessions by role when useful:

- Main development session: code changes, tests, commits, builds, technical
  execution.
- CTO or strategy session: product direction, architecture decisions, roadmap,
  prioritization, risk review, and copyable prompts for the development
  session.
- Question, DB, and concept session: terminology, database inspection,
  structure explanation, learning, and low-risk investigation.

This separation exists to reduce context contamination. It does not need to be
rigid, but important implementation work and strategic decisions should be
summarized into durable docs before being reused elsewhere.

## Main Worktree And Feature Session Model

For repositories where the user keeps a long-lived main worktree, treat its
Codex session as the repository administrator and `master` management session.
That session may keep `master` synchronized, inspect repository-wide state,
create and remove worktrees and branches, prepare new feature environments,
and handle work that explicitly belongs to the main worktree. Do not mix an
independent feature implementation into the main worktree merely because the
main session created or manages its branch.

For each substantial new feature, use this flow when the user requests it:

1. Verify that the main worktree is clean and synchronize `master` with its
   remote using a fast-forward-only path.
2. Confirm that the requested feature branch and folder do not already exist.
3. Create one dedicated `feature/*` branch and one sibling worktree from the
   requested base, then push the new branch and set its correct upstream when
   the user requests remote setup.
4. Create or open a separate Codex project and session rooted at that feature
   worktree. Treat that session as the sole implementation scope for the
   feature.
5. From the main session, give the feature session a copyable startup prompt
   containing the user's common working style, personal-context read order,
   repository and permission boundaries, validation/reporting rules, exact
   worktree/branch/upstream/HEAD state, and any relevant local-environment
   warnings.
6. Leave Jira requirements, Figma nodes, and the actual implementation request
   for the user to provide directly in the feature session. Do not invent them
   in the bootstrap prompt.
7. After delivery is merged and the user asks for cleanup, verify the feature
   worktree is clean and its commits are preserved remotely or merged before
   removing the local worktree and branch.

The main session remains responsible for repository-level coordination and
master-related work, while each feature session owns edits, checks, commits,
pushes, and PR work inside only its assigned worktree and only within the
user's authorization boundaries.

## Start Or Resume Workflow

When the user asks to start, resume, continue, or pick up work, follow the
documented read order exactly. Do not skip, reorder, or replace it with a chat
summary unless a file is genuinely missing.

1. Pull `codex-personal-context`.
2. Read the global guidance and `projects/<project>.md` personal checkpoint.
3. Pull the relevant project repository.
4. Check the live project branch, HEAD, remote divergence, worktree, and recent
   commits before touching files.
5. Read stable team-owned project documentation that is relevant to the task.
6. Reconcile the personal checkpoint with live Git and code; current explicit
   user instructions and verified live state override an older checkpoint.
7. Continue from the reconciled state instead of relying only on chat memory.

Before any project mutation, verify that the current working directory and
worktree are the exact project location the user intends. If the named project
or worktree differs from the current location, make no changes in either place
and ask the user which path to use. Do not infer the target from a nearby clone
or sibling worktree.

Treat the Codex project and each separate session as an intentional scope for
one feature and its assigned worktree. Access to another clone or worktree of
the same repository does not make it part of that session's scope. Do not move
implementation or Git operations across that boundary unless the user
explicitly redirects the session after the target path is confirmed.

Assume project-internal Codex sessions are local-device-bound. For remote work
continuity, treat Git-backed documents as the durable source of truth, not the
current device's local session state.

## External MCP Connection Policy

- Prefer one global direct MCP configuration in `~/.codex/config.toml` for a
  service used across multiple projects. Do not duplicate the same service in
  project `.codex/config.toml` files.
- For Figma on this user's machines, use the global streamable HTTP server named
  `figma_http` at `https://mcp.figma.com/mcp`. Keep this name distinct from the
  common Claude-imported project server name `figma`; otherwise Codex can merge
  an imported STDIO `command` with the global HTTP `url` and reject the config.
  Do not install the Figma plugin connector on top of that direct server unless
  intentionally replacing the connection model.
- When importing Claude Code setup into a project, exclude MCP server
  configuration because the canonical Figma connection is already global. The
  distinct `figma_http` name remains the device-level guard if project MCP
  configuration is imported accidentally.
- Distinguish a plugin app connector from a direct MCP server. Authenticating
  one does not prove that the other is connected.
- After adding, removing, authenticating, or changing an MCP server, verify it
  from a fresh Codex process and restart the ChatGPT/Codex client before
  continuing in a new task. Existing tasks retain their original tool bridge.
- For Figma, verify the direct server with `mcp__figma_http__whoami`. A
  `mcp__codex_apps__figma_*` tool belongs to the plugin connector and should not
  be treated as proof that the global direct MCP is unavailable.

When writing durable context, use the repository boundary strictly. General
Codex/session behavior and personal project progress belong in
`codex-personal-context`; use `projects/<project>.md` for the current checkpoint
and dated history. Shared project repositories keep code and stable team-owned
documentation. Always verify time-sensitive personal progress against the live
project Git state when resuming.

Project-specific read orders, role boundaries, validation gates, and output
contracts belong in the active `projects/<project>.md`. Load them after this
common workflow and before acting in that project.

## Wrap-Up Or End Workflow

When the user says to wrap up, finish, close out, end, pause, hand off,
summarize, "정리하자", or "마무리하자":

1. Summarize completed work.
2. Record decisions made.
3. Record verified facts and observations.
4. Record what was learned.
5. Record open questions and risks.
6. Record changed files when relevant.
7. Record what is needed next.
8. Record the next starting point.
9. Update the personal project checkpoint when durable progress changed, and
   update team documentation only when its canonical information changed.
10. Commit and push `codex-personal-context` so the history is remote-backed.
    Commit or push the shared project only when explicitly authorized.

For lightweight question or learning sessions, keep the wrap-up shorter, but
still preserve durable preferences or project decisions that should survive
the session.

## Communication Style

For direct answers to the user's questions:

- Be short by default.
- Use Korean 존댓말.
- Let the user ask follow-up questions for more depth.
- Minimize screen footprint: avoid unnecessary headings, long lists, and
  verbose explanations so the answer is easy to see at a glance.

For development handoffs, CTO notes, implementation summaries, and decision
records:

- Include the detail needed for another session to continue safely.
- Separate confirmed facts, observations, hypotheses, recommendations, and
  unknowns when the distinction matters.
- Do not put ordinary status summaries, explanations, or CTO judgments in
  text/code blocks. Use text/code blocks only for copyable material such as
  development-session prompts, terminal commands, exact values, or text the
  user needs to paste elsewhere.

## Database And Sensitive Work

Default database work should be read-only.

- Do not update or delete database rows without explicit approval.
- Do not print full access tokens, passwords, API keys, or Expo push tokens.
- Prefer masked identifiers when full values are not necessary.
- Before ownership migration or destructive cleanup, preview counts and target
  IDs first.

## Continuity Principle

Codex sessions can stay alive, but they should not be treated as the only
source of truth. Personal progress should be written to Git-backed
`codex-personal-context`, while stable team-owned information belongs in the
shared project repository, so work can continue across sessions, devices, and
future AI context resets.
