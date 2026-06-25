# Action Sports Journal

## Current State

- Repository: `https://github.com/jongsunP/action-sports-journal-app`
- Local path: `/Users/parkjongsun/Repository/action-sports-journal-app`
- Platform: iOS-first React Native app
- Runtime: standalone EAS preview/internal distribution app on physical iPhone
- Current SDK: Expo SDK `~54.0.35`
- Current stage: Stage 3 product foundation and recovery/account-linking polish
- Latest project commit: `65c58ca docs: require remote push at session closeout`

## Product Philosophy

- ASJ is not an MVP. It is a real service being built one proper foundation at
  a time.
- Upload is the service's starting point and survival-critical core. Imperfect
  AI analysis can be tolerated temporarily, but preventable upload failure
  cannot be treated casually.
- AI analysis quality is an ongoing development area. Upload is a basic
  foundation and should not fail in unknown or unobservable ways.
- Upload failures should be predictable and observable unless the cause is an
  unavoidable external network condition.
- A user uploads one item at a time, but multiple already-uploaded items can be
  analyzing at the same time. Per-item state visibility matters for trust:
  upload progress, uploaded, analyzing, completed, failed, and recoverable or
  non-recoverable conditions should be distinguishable when relevant.
- The target users are a specific action-sports niche group, not the general
  public.
- Instagram and KakaoTalk matter because they match that group's actual sharing
  and communication habits. Product/channel decisions should be judged against
  that niche group rather than generic mass-market assumptions.
- The Founder is originally a web frontend developer, not an app developer, but
  understands development flow, websocket-based systems, and presigned upload
  patterns. This is context for diagnosing possible misunderstandings, not a
  requirement to always explain in web frontend terms. If something is unclear,
  consider whether the gap comes from app/mobile/backend/infra differences and
  explain the missing structural difference directly.
- Slow infrastructure caused by a low plan can be acceptable when understood.
  Preventable issues caused by bad configuration or bad design are the real
  concern.

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
- Build 74 closed Auth Phase 2 Push QA. Push delivery was confirmed after
  analysis completion.
- Push Observability P2 is complete for the current internal/dev scope.
- Build 75 validated Kakao Recovery / Account Linking E2E on standalone iOS.
- Kakao identity linking attached to the existing anonymous Auth user rather
  than creating a separate new Auth user in the QA window.
- Device-first Anonymous Auth, Ownership Boundary, Private Realtime, and
  No-Token Policy are durable foundations and should not be reverted.
- Email Recovery is baseline/fallback. The magic-link send path works, but
  productization needs redirect/deep-link strategy and link-validity QA.
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
- `docs/PROJECT_MEMORY.md`: primary project memory and operating system
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

- Unrelated login expansion
- Phone authentication
- Coupons
- Expenses
- Calendar
- RAG
- Compression / upload optimization
- AI calibration
- Additional social features

## Next Likely Step

Do not add unrelated product features yet.

Current immediate work:

1. Kakao Linking UI success/failure/cancel-state polish.
2. Kakao display name sync decision.
3. Ownership continuity check with a user that already has Moments.
4. Foundation Safety Check.
5. External No-Token Finalization.
6. Push token account-switch policy.

## New Session Prompt

Use this prompt when opening the project in a new Codex terminal session:

```text
AGENTS.md, docs/PROJECT_MEMORY.md, docs/CURRENT_STAGE.md, docs/HANDOFF.md를 먼저 읽고 현재 ASJ 상태를 복구해줘. 최신 기준선은 Build 75 Kakao Recovery / Account Linking E2E 통과, Push Observability P2 완료, 다음 작업은 Kakao Linking UI success/failure/cancel-state polish야. 구현 전에 현재 완료된 것, 지금 하는 것, 앞으로 해야 할 것을 짧게 정리하고 개발 계획을 제안해줘.
```
