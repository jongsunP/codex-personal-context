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
Stage 2 local ActivityGroup / Session prototype complete
App Store / TestFlight preparation started
```

Latest local project checkpoint commit:

```text
b5d4eb1 Add continuity checkpoint for App Store prep
```

## Confirmed Project Facts

- Expo SDK is `~54.0.35`.
- React Native is `0.81.5`.
- React is `19.1.0`.
- The app opens on the user physical iPhone through Expo Go.
- Tunnel mode worked when LAN mode was unreliable.
- The first screen source is `src/features/sessions/HomeScreen.tsx`.
- The app entry is `App.tsx`.
- Stage 2 local ActivityGroup / Session prototype works with mock data and React state only.
- Project handoff exists in `docs/HANDOFF.md`.
- Latest checkpoint exists in `docs/CONTINUITY_CHECKPOINT.md`.
- App Store build identifiers were added to `app.json`.
- Initial EAS config exists in `eas.json`.

## Resume Commands

Open the project in a terminal:

```bash
cd /Users/parkjongsun/Repository/action-sports-journal-app
codex
```

Suggested first prompt:

```text
AGENTS.md, docs/HANDOFF.md, docs/CURRENT_STAGE.md, docs/CONTINUITY_CHECKPOINT.md, and REVIEW.md를 먼저 읽고 Stage 2 완료 및 App Store 준비 상태에서 이어서 진행해줘.
```

## Run Commands

```bash
cd /Users/parkjongsun/Repository/action-sports-journal-app
npm install
npx expo start --tunnel --port 8082
```

Use Node 20 or newer for Expo.

## Current Product Rules

- This is an Action Sports Life Log platform.
- It is not an AI-only analysis app.
- Session is the center of the system.
- ActivityGroup -> Session -> AnalysisResult -> ShareResult.
- Sharing is important long-term, but should not be implemented yet.

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

Do not add product features yet.

The next work should focus on release-path validation:

1. Ensure local project commits are pushed to GitHub.
2. Confirm Expo account login with EAS CLI.
3. Confirm Apple Developer Program / App Store Connect access.
4. Create or verify the App Store Connect app record for `com.jongsunp.actionsportsjournal`.
5. Run an iOS production EAS build.
6. Submit the build to App Store Connect / TestFlight.

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
