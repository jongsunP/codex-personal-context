# Personal Codex Guidance

## Communication

- Always answer this user in Korean.
- Use polite 존댓말 consistently.
- Be concise but explain important engineering decisions clearly.

## Permission Preference

- The user prefers Codex to proceed proactively and request required approvals directly when tools need elevated permissions.
- Still follow Codex/system permission prompts when they appear.

## Active Project Context

The user's current main project is Action Sports Journal.

- Local path: `/Users/parkjongsun/Repository/action-sports-journal-app`
- GitHub remote: `https://github.com/jongsunP/action-sports-journal-app`
- Product: iOS-first React Native action sports life log platform.
- Current stage: Stage 1 initial setup.
- Current Expo SDK: `~54.0.35` for compatibility with the user's App Store Expo Go on a physical iPhone.
- Current mobile status: The app opens on the user's physical iPhone through Expo Go.
- First screen source: `src/features/sessions/HomeScreen.tsx`
- Root entry: `App.tsx`

## Project Rules To Remember

- Session is the center of the domain model.
- ActivityGroup -> Session -> AnalysisResult -> ShareResult.
- AI analysis is only one feature, not the whole product.
- Do not add AI, database, login, phone auth, video upload, backend, coupons, expenses, calendar, or RAG during Stage 1.
- Keep implementations simple and avoid over-engineering.
