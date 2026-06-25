# Action Sports Journal

## Current State

- Repository: `https://github.com/jongsunP/action-sports-journal-app`
- Local path: `/Users/parkjongsun/Repository/action-sports-journal-app`
- Platform: iOS-first React Native app
- Runtime: standalone EAS preview/internal distribution app on physical iPhone
- Current SDK: Expo SDK `~54.0.35`
- Current stage: Stage 3 post-foundation UX QA
- Latest project commit: `df1016f docs: close out build 82 qa handoff`

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
- Kakao Linking UI follow-up is closed beyond Build 75: false success is
  blocked, linked-state copy is clearer, and cleanup confirmed the same Kakao
  account can be linked to a fresh anonymous user after the old test account is
  removed.
- Kakao Recovery Sign-in P1 passed Build 81 real-device QA.
- Foundation Safety Check is complete and found no major blocking foundation
  issue. A broad refactor is not required at the current scale.
- External No-Token Finalization is complete. User-owned external no-token
  API paths now return 401 unless explicit internal development fallback is
  enabled.
- Push Token Account-switch Policy is complete. A same-device Expo push token
  moves to the current authenticated owner after account switch/recovery.
- Product UX Baseline P1 is complete: user-facing moment status labels are
  unified as 진행중 / 완료 / 실패.
- Kakao Recovery UI is now a single user-facing Kakao CTA while internal
  link-vs-recover branching remains hidden from the user.
- Detail Retry / Action UI, Home Journal first slice, Upload Entry UX polish,
  and Analysis Trust UX are complete for the current post-foundation slice.
- Build 82 was created for post-foundation UX QA and is waiting for the
  Founder's real-device QA result.
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

1. Founder shares Build 82 real-device QA results.
2. CTO reviews QA result before sending any new development-session prompt.
3. If QA is clean, choose the next product slice from recovery-attempt
   observability, Email Recovery deep-link strategy, Journal/Analysis/Media UX,
   or another user-observed issue.

Build 82 details:

- buildNumber: `82`
- build commit: `16b44a9 chore: prepare post-foundation ux qa build`
- EAS build page:
  `https://expo.dev/accounts/jspark88/projects/action-sports-journal/builds/c0effa32-29cb-49e6-9baf-e0642c480b68`
- install/build URL:
  `https://expo.dev/artifacts/eas/ttWHXF2SLddnDWq0NG0TV3r3e3LKRGDgg0Lgi-jsbQA.ipa`

## Deferred Follow-Up Issues

- Initial loading / Video tab spinner observability: after fresh standalone
  install, early app loading can be very slow and the video tab can show a
  spinner for too long or indefinitely; after several reinstalls/reopens it may
  become normal. Investigate later by finding where the app is waiting instead
  of guessing from symptoms. Main hypotheses: install/cache behavior,
  anonymous auth/user bootstrap timing, push registration, realtime
  subscription, local storage hydration, moments/video fetch, upload recovery
  scan, backend/Supabase cold start, and missing timeout/error/empty-state
  handling. Slow infra can be acceptable if understood; an indefinite spinner
  or unknown waiting state is not acceptable.

## New Session Prompt

Use this prompt when opening the project in a new Codex terminal session:

```text
AGENTS.md, docs/PROJECT_MEMORY.md, docs/CURRENT_STAGE.md, docs/HANDOFF.md를 먼저 읽고 현재 ASJ 상태를 복구해줘. 최신 기준선은 Build 81 Kakao Recovery Sign-in QA 통과, Foundation Safety Check 완료, External No-Token Finalization 완료, Push Token Account-switch Policy 완료, Product UX Baseline P1/Single Kakao CTA/Detail Retry/Home Journal/Upload Entry/Analysis Trust UX 반영 완료야. Build 82가 post-foundation UX QA용으로 생성되어 있고, 다음 시작점은 사용자의 Build 82 실기기 QA 결과 공유야. QA 결과를 받기 전에는 새 개발 세션 프롬프트를 주지 말고, 현재 완료/현재/바로 앞/가까운 후속/나중/장기 목록을 안정된 workstream 기준으로 짧게 정리해줘.
```
