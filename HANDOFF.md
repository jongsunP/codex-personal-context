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
Stage 3 video-to-analysis prototype started
App Store / TestFlight preparation started
```

Latest local project checkpoint commit:

```text
ea832e4 Add guarded OpenAI analysis dev server
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
- Stage 3 API contract exists in `docs/STAGE_3_VIDEO_ANALYSIS_PLAN.md`.
- App Store build identifiers were added to `app.json`.
- Initial EAS config exists in `eas.json`.
- `expo-image-picker` is installed for selecting session videos.
- The app can attach a selected video URI to a new Session.
- A first AI analysis request flow exists with a mock fallback.
- Remote analysis responses are normalized before rendering.
- Home screen layout was polished with scroll support, header metrics, clearer session cards, and status pills.
- Visible prototype UI copy and mock data were localized for Korean users.
- Guarded local OpenAI analysis dev server exists in `dev-server/index.ts`.
- Development API spend target is under KRW 10,000/month with max 20MB video, 3 analyses/day, 600 output tokens.
- User must configure OpenAI Platform billing/budget and local `.env.local`; API keys must not be committed.
- Real OpenAI analysis must go through a server/BFF endpoint; do not put API keys in the mobile app.

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

- Real server-side OpenAI integration
- Database
- Login or phone authentication
- Real video upload
- Backend
- Coupons
- Expenses
- Calendar
- RAG

## Next Likely Work

Do not add unrelated product features yet.

The next work should focus on validating the first video-to-analysis flow:

1. Run the app on the physical iPhone.
2. Add a Session.
3. Select a video.
4. Save the Session.
5. Tap `Request AI Check`.
6. Confirm the mock analysis result appears.
7. Then add a minimal server/BFF endpoint for real OpenAI analysis.

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
