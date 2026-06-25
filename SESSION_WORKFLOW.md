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
  prioritization, risk review, and copyable prompts for the development
  session.
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

If the user says "작업 재개하자" for Action Sports Journal, treat it as a
status-recovery request. Prepare:

- What is already complete.
- What is current.
- What should happen next.
- What needs the Founder to decide.
- The first copyable development-session prompt if implementation can proceed.
- Previously deferred concerns or backlog items that should be rechecked.

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

If the user says "작업 마무리하자" for Action Sports Journal, treat it as a
closeout request. Prepare documentation, handoff/checkpoint updates, commit and
push guidance or execution, and the next session starting point.

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

## Action Sports Journal CTO Output Contract

For the Action Sports Journal CTO session:

- The only active project target is
  `/Users/parkjongsun/Repository/action-sports-journal-app`.
- The CTO session should not act as the implementation developer by default.
- Actual code work should be given to a separate development session as one
  copyable prompt.
- If there is nothing the Founder needs to know, show only the development
  session prompt.
- When answering current status, judgment, or context for the Founder, use
  normal prose or a short normal list unless there is a copy/paste action.
- If the Founder asks a question before passing a development-session prompt to
  the development session, treat the question as intentionally pausing the
  handoff. Answer the question first and do not repeat the prompt unless the
  answer changes it or the Founder asks for it again.
- A development-session prompt is not considered handed off until the Founder
  actually passes it to the development session. During a paused handoff,
  answer intermediate questions without reprinting the prompt. When the Founder
  indicates the questions are done or asks for the final prompt, provide the
  revised final prompt once.
- If the Founder asks a question after a prompt was provided, assume the prompt
  has not yet been passed to the development session unless the Founder
  explicitly says it has. If it has already been passed, the Founder will say so
  directly, for example: "이미 프롬프트는 넘겼고 질문하자면".
- If the Founder raises a concern that will not be handled immediately, record
  it as a backlog or follow-up item so it can be rechecked later. Deferred
  concerns should not disappear just because the current task continues.

Validation-cost policy:

- Builds and AI API calls are allowed when they are the right validation step.
- If simulator or physical-device testing can verify the behavior without a
  new EAS build, use that path first.
- If the behavior specifically requires standalone physical-device validation,
  say so clearly and proceed toward the build.
- Builds are executed by the development session by default. When the CTO
  session reaches a build decision point, ask or state that a build is needed;
  if the Founder says to proceed, provide one copyable build-execution prompt
  for the development session.
- For repeated upload-reliability tests, keep the production-like app/backend
  path intact and bypass only the paid AI provider call when AI quality is not
  the target.
- Bypassing the AI provider is not app mock-data testing. The product path
  should remain as close to production as possible; only the cost-incurring
  provider call is substituted.

Product judgment policy:

- Do not frame ASJ as an MVP. It is a real service being built one proper
  foundation at a time.
- Treat upload reliability as survival-critical. AI quality is an ongoing
  development area; preventable, unknown, or unobservable upload failure cannot
  be accepted as a normal state.
- Remember that one user may upload one item at a time while multiple
  previously uploaded items are analyzing. Preserve and explain per-item state
  visibility when reviewing upload/analysis flows.
- Judge product/channel decisions against ASJ's specific action-sports niche
  users, whose actual sharing and communication habits favor Instagram and
  KakaoTalk, not generic mass-market assumptions.
- The Founder is a web frontend developer who understands websockets,
  presigned upload flows, and engineering causality. This is context for
  diagnosing possible misunderstanding, not a requirement to always explain in
  web frontend terms. Keep explanations technically direct; if the Founder is
  confused, check whether the missing piece is an app/mobile/backend/infra
  difference from web frontend work.

Use this exact owner format when needed:

````markdown
## **개발 세션에게**
```text
cd ~/Repository/action-sports-journal-app

...
```
````

Use the user section only when the Founder has a decision or direct action:

````markdown
## **사용자에게**
<short explanation>

```text
<copyable command or value only when needed>
```
````

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
