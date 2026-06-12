# Action Sports Journal

## Current State

- Repository: `https://github.com/jongsunP/action-sports-journal-app`
- Local path: `/Users/parkjongsun/repository/action-sports-journal-app`
- Platform: iOS-first React Native app
- Runtime: standalone EAS preview/internal distribution app on physical iPhone
- Current SDK: Expo SDK `~54.0.35`
- Current stage: Stage 3 real video-to-analysis prototype in progress
- Latest project commit: `699457b Add setup audit guide`

## Continuity Rule

When the user asks to check Action Sports Journal progress, check the remote
GitHub repository first and read the remote-backed project docs such as
`docs/HANDOFF.md`, `docs/CURRENT_STAGE.md`, `docs/CONTINUITY_CHECKPOINT.md`,
`docs/STAGE_3_VIDEO_ANALYSIS_PLAN.md`, and `SETUP.md`.

## Confirmed Working

- GitHub repository exists.
- Expo SDK was downgraded to SDK 54 for the user current App Store Expo Go.
- The app is visible on the user physical iPhone.
- The app was installed and opened as a standalone iPhone app through EAS
  preview/internal distribution, without Expo Go.
- Tunnel mode worked when LAN mode was unreliable.
- ActivityGroups can be selected.
- Sessions are filtered by selected ActivityGroup.
- Add Session opens an input flow.
- Saving a session adds it to the local list.
- Added Sessions persist on-device through AsyncStorage.
- `expo-image-picker` is installed for selecting session videos.
- `@react-native-async-storage/async-storage` is installed.
- A selected video can be attached to a new Session.
- The mobile mock AI analysis fallback was removed.
- `AI 체크하기` calls `EXPO_PUBLIC_AI_ANALYSIS_ENDPOINT`.
- Local dev-server exists in `dev-server/index.ts`.
- The dev-server currently contains an OpenAI GPT-5.5 benchmark implementation
  for wakeboard video analysis quality testing.
- The OpenAI benchmark uses server-side whole-video frame sampling because
  official OpenAI docs list GPT-5.5 as text/image input, not direct video input.
- The benchmark sends sampled frames to GPT-5.5 via Responses API with
  `reasoning.effort=xhigh`, high verbosity, a world-class wakeboard coaching
  prompt, and strict structured JSON.
- Structured benchmark fields include observations, patternRecognition,
  inferences, confidence, and selfCritique.
- TypeScript validation passed.
- `SETUP.md` was added as the new-Mac setup audit and 30-minute execution
  checklist.
- Dummy-key testing confirmed video upload and frame extraction reach OpenAI
  authentication. Actual benchmark still needs a real local `OPENAI_API_KEY`.
- The user's iPhone could open `http://10.10.7.17:8787/health` on the same Wi-Fi.
- EAS preview environment variable was set:
  `EXPO_PUBLIC_AI_ANALYSIS_ENDPOINT=http://10.10.7.17:8787/api/analyze-session-video`.
- Real Gemini analysis must go through a server/BFF endpoint; do not put API keys in the mobile app.

## Important Files

- `AGENTS.md`: project rules and current setup context
- `docs/HANDOFF.md`: cross-session project handoff
- `docs/CONTINUITY_CHECKPOINT.md`: latest continuity checkpoint
- `docs/CURRENT_STAGE.md`: current stage summary
- `docs/STAGE_2_PLAN.md`: Stage 2 scope
- `docs/STAGE_3_VIDEO_ANALYSIS_PLAN.md`: video analysis API contract
- `docs/DEV_AI_ANALYSIS_SETUP.md`: local API setup and spend guardrails
- `App.tsx`: root app entry
- `src/features/sessions/HomeScreen.tsx`: first visible screen
- `src/features/groups/mockActivityGroups.ts`: local mock ActivityGroups
- `src/features/sessions/mockSessions.ts`: local mock Sessions
- `src/types/index.ts`: domain types
- `app.json`: Expo app config, bundle identifier, build numbers
- `eas.json`: EAS build/submit config
- `dev-server/index.ts`: local OpenAI GPT-5.5 benchmark analysis server

## Current Boundary

Do not implement these yet:

- Database
- Login or phone authentication
- Production video upload/storage
- Production backend
- Coupons
- Expenses
- Calendar
- RAG

## Next Likely Step

Focus on validating the OpenAI GPT-5.5 benchmark before making provider
conclusions:

1. Add local `.env.local` with `OPENAI_API_KEY`.
2. Run `npm run server:dev`.
3. Confirm `/health` returns OpenAI GPT-5.5 configured.
4. Test the exact same wakeboard video used for Gemini output.
5. Compare GPT-5.5 output with Gemini output.
6. Decide whether earlier OpenAI quality issues came from prompt, API usage,
   video input implementation, model limitation, or ChatGPT orchestration.

## New Session Prompt

Use this prompt when opening the project in a new Codex terminal session:

```text
AGENTS.md, docs/HANDOFF.md, docs/CURRENT_STAGE.md, docs/CONTINUITY_CHECKPOINT.md, docs/STAGE_3_VIDEO_ANALYSIS_PLAN.md, docs/DEV_AI_ANALYSIS_SETUP.md를 먼저 읽고, 현재 dev-server의 OpenAI GPT-5.5 wakeboard benchmark 구현 상태에서 이어서 진행해줘. 실제 OPENAI_API_KEY로 같은 웨이크보드 영상을 테스트하고 Gemini 결과와 비교해줘.
```
