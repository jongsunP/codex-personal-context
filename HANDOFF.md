# Codex Cross-Session Handoff

## Purpose

This private repository stores non-secret context so Codex can continue work across different sessions, terminals, or apps.

Do not store secrets here.

## User Preferences

- Always answer in Korean.
- Use polite 존댓말 consistently.
- Be concise, but explain important engineering decisions clearly.
- When approvals are needed, proceed proactively by requesting the required approval.

## Current Main Project

Action Sports Journal

Repository:

```text
https://github.com/jongsunP/action-sports-journal-app
```

Local path:

```text
/Users/parkjongsun/Repository/action-sports-journal-app
```

Current status:

```text
Stage 1 complete
```

Latest Stage 1 commit:

```text
8d44d7b Add Stage 1 repository review
```

## Confirmed Project Facts

- Expo SDK is `~54.0.35`.
- React Native is `0.81.5`.
- React is `19.1.0`.
- The app opens on the user's physical iPhone through Expo Go.
- The first screen source is `src/features/sessions/HomeScreen.tsx`.
- The app entry is `App.tsx`.
- Stage 1 review exists in `REVIEW.md`.
- Project handoff exists in `docs/HANDOFF.md`.

## Resume Commands

Open the project in a terminal:

```bash
cd /Users/parkjongsun/Repository/action-sports-journal-app
codex
```

Suggested first prompt:

```text
AGENTS.md, docs/HANDOFF.md, docs/CURRENT_STAGE.md, and REVIEW.md를 먼저 읽고 Stage 1 완료 상태에서 이어서 진행해줘.
```

## Run Commands

```bash
cd /Users/parkjongsun/Repository/action-sports-journal-app
npm install
npx expo start --lan
```

Use Node 20 or newer for Expo.

## Current Product Rules

- This is an Action Sports Life Log platform.
- It is not an AI-only analysis app.
- Session is the center of the system.
- ActivityGroup -> Session -> AnalysisResult -> ShareResult.
- Sharing is important long-term, but should not be implemented in Stage 1.

## Do Not Implement Yet

- AI integration
- Database
- Login or phone authentication
- Real video upload
- Backend
- Coupons
- Expenses
- Calendar
- RAG

## Next Likely Work

Only when the user asks to continue product development:

- Start Stage 2 planning.
- Keep it local-only.
- Consider a tiny mock ActivityGroup and Session prototype.
- Avoid external services and premature architecture.

## Other Context Files

- `AGENTS.md`: personal Codex guidance
- `projects/action-sports-journal-app.md`: project-specific context

## Safety

Never commit these:

- API keys
- access tokens
- `~/.codex/auth.json`
- SQLite state files
- `.env` files
- private user/customer data
