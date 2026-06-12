# Action Sports Journal

## Current State

- Repository: `https://github.com/jongsunP/action-sports-journal-app`
- Local path: `/Users/parkjongsun/repository/action-sports-journal-app`
- Platform: iOS-first React Native app
- Runtime: standalone EAS preview/internal distribution app on physical iPhone
- Current SDK: Expo SDK `~54.0.35`
- Current stage: Stage 3 real video-to-analysis prototype in progress
- Latest project commit: `4664bfb Prioritize trick initiation evidence`

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
- The dev-server keeps Gemini as the app-facing endpoint and contains a parallel
  OpenAI GPT-5.5 benchmark endpoint for wakeboard video analysis quality testing.
- Real Gemini video analysis and the OpenAI benchmark path both work locally.
- Gemini evidence extraction exists at `/api/extract-session-evidence`.
- The current recommended architecture is:
  `Video -> Gemini Evidence Extraction -> User Confirmation -> Coaching Engine -> Stored Session Intelligence`.
- GPT is currently stronger for coaching/report generation, while Gemini is
  currently stronger for video/motion evidence extraction.
- User-confirmed trick flow is implemented; user-confirmed trick intent is kept
  separate from the AI-estimated trick.
- Motion-aware dense sampling is implemented for the OpenAI benchmark.
- Gemini 503 retry/fallback handling exists. `gemini-2.5-flash-lite` is
  degraded fallback only, not a trick-recognition quality benchmark.
- Evidence JSON truncation was mitigated by setting
  `GEMINI_EVIDENCE_MAX_OUTPUT_TOKENS=6000`.
- Lightweight consistency validation flags internally inconsistent evidence
  before coaching.
- Wakeboard trick identity should be evaluated primarily from stance, edge,
  approach, takeoff, pop, and rotation initiation. Landing and crash are
  outcomes, not primary trick-classification evidence. A crashed HS Back Roll is
  still an HS Back Roll attempt.
- TypeScript validation passed.
- `SETUP.md` was added as the new-Mac setup audit and 30-minute execution
  checklist.
- Same-video tests showed exact Back Roll vs Tantrum recognition is still not
  reliable enough to bypass user confirmation, but failures now stay in a more
  plausible Back Roll/Tantrum-family range rather than clearly unrelated tricks.
- The user's iPhone could open the current local `/health` endpoint on the same
  Wi-Fi after using HTTP explicitly.
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
- `dev-server/index.ts`: local Gemini analysis server plus parallel OpenAI
  GPT-5.5 benchmark endpoint

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

Do not add unrelated product features yet.

Continue validating the evidence-first loop:

1. Run the same wakeboard video through Gemini evidence extraction.
2. Confirm or correct the intended trick in the app.
3. Compare GPT vs Gemini coaching quality after the confirmed trick is supplied.
4. Evaluate whether the classifier correctly prioritizes stance, edge, approach,
   takeoff, pop, and rotation initiation over landing/crash outcome.
5. Start shaping stored Session intelligence only after the evidence and
   confirmation loop is stable.

## New Session Prompt

Use this prompt when opening the project in a new Codex terminal session:

```text
AGENTS.md, docs/HANDOFF.md, docs/CURRENT_STAGE.md, docs/CONTINUITY_CHECKPOINT.md, docs/STAGE_3_VIDEO_ANALYSIS_PLAN.md, docs/DEV_AI_ANALYSIS_SETUP.md, docs/OPENAI_BENCHMARK_REPORT.md를 먼저 읽고, evidence-first wakeboard analysis 상태를 이어서 진행해줘. Gemini evidence extraction은 stance/edge/approach/takeoff/pop/rotation initiation을 landing/crash보다 우선해서 평가하고, 사용자가 확정한 trick intent를 coaching에 우선 적용해줘.
```
