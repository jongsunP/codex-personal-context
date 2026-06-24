# Session Workflow

## Purpose

This file defines the user's preferred Codex session operating model across
all projects and devices.

The goal is continuous work without losing context: Codex should be able to
pause, resume, summarize, and hand off work through Git-backed memory instead
of relying only on chat history.

## Repository Boundaries

Use `codex-personal-context` for:

- Cross-project user preferences.
- Codex working style.
- Session start and end workflows.
- Durable personal context.
- AI tool usage preferences.

Use each project repository for:

- Project-specific product decisions.
- Technical status.
- Implementation handoffs.
- Architecture notes.
- Project documentation.

When a note applies to both, record the general rule here and the concrete
project state in the relevant project docs.

## Session Roles

Separate sessions by role when useful:

- Main development session: code changes, tests, commits, builds, technical
  execution.
- CTO or strategy session: product direction, architecture decisions, roadmap,
  prioritization.
- Question, DB, and concept session: terminology, database inspection,
  structure explanation, learning, and low-risk investigation.

This separation exists to reduce context contamination. It does not need to be
rigid, but important implementation work and strategic decisions should be
summarized into durable docs before being reused elsewhere.

## Start Or Resume Workflow

When the user asks to start, resume, continue, or pick up work:

1. Pull `codex-personal-context`.
2. Pull the relevant project repository.
3. Read the current bootstrap and handoff documents.
4. Check the project git status before touching files.
5. Identify the current branch, latest relevant commit, and next starting
   point.
6. Continue from the documented state instead of relying only on chat memory.

For Action Sports Journal, read:

- Project `AGENTS.md`
- `docs/PROJECT_MEMORY.md`
- `docs/CURRENT_STAGE.md`
- `docs/HANDOFF.md`
- Other documents only when relevant to the task.

## Wrap-Up Or End Workflow

When the user says to wrap up, finish, close out, end, pause, hand off, or
summarize:

1. Summarize completed work.
2. Record decisions made.
3. Record verified facts and observations.
4. Record what was learned.
5. Record open questions and risks.
6. Record changed files when relevant.
7. Record what is needed next.
8. Record the next starting point.
9. Decide whether durable memory or project docs should be updated.
10. If documentation is updated, commit and push when safe.

For lightweight question or learning sessions, keep the wrap-up shorter, but
still preserve durable preferences or project decisions that should survive
the session.

## Communication Style

For direct answers to the user's questions:

- Be short by default.
- Use Korean 존댓말.
- Let the user ask follow-up questions for more depth.

For development handoffs, CTO notes, implementation summaries, and decision
records:

- Include the detail needed for another session to continue safely.
- Separate confirmed facts, observations, hypotheses, recommendations, and
  unknowns when the distinction matters.

## Database And Sensitive Work

Default database work should be read-only.

- Do not update or delete database rows without explicit approval.
- Do not print full access tokens, passwords, API keys, or Expo push tokens.
- Prefer masked identifiers when full values are not necessary.
- Before ownership migration or destructive cleanup, preview counts and target
  IDs first.

## Continuity Principle

Codex sessions can stay alive, but they should not be treated as the only
source of truth. Important state should be written to Git-backed memory or
project docs so work can continue across sessions, devices, and future AI
context resets.
