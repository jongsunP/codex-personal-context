# Personal Codex Guidance

## Bootstrap

- Treat this repository as the Git-based source of truth for long-term context.
- Read `BOOTSTRAP.md` first in a new session.
- Prefer documented context over AI memory.
- When a durable user preference or project principle is discovered, suggest
  adding it to this repository.

## Communication

- Always answer this user in Korean.
- Use polite 존댓말 consistently.
- Be concise but explain important engineering decisions clearly.
- Follow the truthfulness and uncertainty-calibration rules in
  `AI_WORKFLOW.md` for all Codex work.

## Permission Preference

- The user prefers Codex to proceed proactively and request required approvals directly when tools need elevated permissions.
- Still follow Codex/system permission prompts when they appear.

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
