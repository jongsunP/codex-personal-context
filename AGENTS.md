# Personal Codex Guidance

## Bootstrap

- Treat this repository as the Git-based source of truth for long-term context.
- Read `BOOTSTRAP.md` first in a new session.
- Read `SESSION_WORKFLOW.md` for session start, resume, wrap-up, and
  repository-boundary rules.
- Prefer documented context over AI memory.
- When a durable user preference or project principle is discovered, suggest
  adding it to this repository.
- Use this repository for cross-project user preferences, Codex working style,
  session start/end workflows, and durable personal context regardless of the
  active project.
- Use each project repository for project-specific product decisions,
  technical status, implementation handoffs, and project documentation.
- If a note applies to both, record the general rule here and the concrete
  project-specific state in the relevant project docs.

## Communication

- Always answer this user in Korean.
- Use polite 존댓말 consistently.
- For direct answers to the user's questions, default to short, concise
  responses. The user will ask follow-up questions when more detail is needed.
- For development work, CTO handoffs, implementation notes, decision records,
  and cross-session summaries, include as much detail as the work requires.
- Explain important engineering decisions clearly when detail is necessary.
- Follow the truthfulness and uncertainty-calibration rules in
  `AI_WORKFLOW.md` for all Codex work.

## Permission Preference

- The user prefers Codex to proceed proactively and request required approvals directly when tools need elevated permissions.
- Still follow Codex/system permission prompts when they appear.

## Wrap-Up Workflow

- At the start of a new or resumed session, refresh this repository and the
  relevant project repository with `git pull` before relying on local context
  when the user asks to resume work or continue from a prior checkpoint.
- When the user says to wrap up, finish, close out, end, pause, hand off, or
  summarize a session checkpoint, proactively organize the current state
  instead of only saying goodbye.
- For project work, include completed work, decisions, verified facts, open
  questions, changed files when relevant, what was learned, what is needed,
  future tasks, and the next starting point.
- Decide whether durable memory or project documentation should be updated. If
  it should, update the appropriate Git-backed document/repository and commit
  and push when safe.
- For lightweight question/learning sessions, keep the wrap-up shorter but
  still capture durable preferences or project decisions when they appeared.
- When the user says to resume work or continue from a prior checkpoint, first
  refresh the relevant Git-backed context with `git pull` before relying on
  local memory.

## Active Project Context

The user's current main project is Action Sports Journal.

- Local path: `/Users/parkjongsun/repository/action-sports-journal-app`
- GitHub remote: `https://github.com/jongsunP/action-sports-journal-app`
- Product: iOS-first React Native action sports life log platform.
- Current stage: Stage 3 real video-to-analysis prototype in progress.
- Current Expo SDK: `~54.0.35`.
- Current mobile status: The app opens on the user's physical iPhone through Expo Go and as a standalone EAS preview/internal distribution app.
- First screen source: `src/features/sessions/HomeScreen.tsx`
- Root entry: `App.tsx`
- Latest documented project commit: `c7cdfe9 Switch dev analysis server to Gemini video input`

## Project Rules To Remember

- Session is the center of the domain model.
- ActivityGroup -> Session -> AnalysisResult -> ShareResult.
- AI analysis is only one feature, not the whole product.
- Do not add database, login, phone auth, production video upload/storage, production backend, coupons, expenses, calendar, or RAG until the project docs say the stage is ready.
- Keep implementations simple and avoid over-engineering.
- Durable preferences, project settings, and continuity notes should be kept in
  remote-backed Git repositories, not only in chat or local scratch state.
