# Action Sports Journal

## Current State

- Repository: `https://github.com/jongsunP/action-sports-journal-app`
- Local path: `/Users/parkjongsun/Repository/action-sports-journal-app`
- Platform: iOS-first React Native app
- Runtime: standalone EAS preview/internal distribution app on physical iPhone
- Current SDK: Expo SDK `~54.0.35`
- Current stage: Stage 3 post-foundation UX QA
- Latest project commit: `12741db fix: prevent indefinite video archive loading`

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
- Build 84 passed Kakao Single CTA one-click real-device QA: one ASJ app
  `카카오로 계속하기` press recovered the existing Kakao-linked account without
  showing the previous `확인 필요` state or a second ASJ CTA. Home, Video, and
  Detail restored under the recovered account, and relaunch preserved the
  recovered state.
- Startup / Video Tab Loading Observability P1 first pass is implemented:
  initial remote sync no longer leaves list loading pending forever after
  timeout/failed, Video Archive first page has loading/empty/timeout/error/ready
  state separation, retry UI exists for timeout/error, and boot/video request
  logs include duration/status/count/reason without sensitive values.
- QA Debug Overlay/Panel is the current in-progress follow-up for real-device
  diagnosis of slow startup or Video/List spinner behavior.
- Detail Retry / Action UI, Home Journal first slice, Upload Entry UX polish,
  and Analysis Trust UX are complete for the current post-foundation slice.
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

Stable project list:

This list is a project feature/workstream timeline, not a temporary engineering
checklist. Do not include transient validation steps such as typecheck,
diff-check, Simulator QA, build readiness, or "wait for development-session
result" as list items. Keep the list at the product/technical plan level, keep
existing workstream names stable, and move items forward as the project evolves.

Completed foundation and product slices:

- Upload Part 1.
- Upload Reliability P0/P1.
- Auth Phase 1 / Auth Phase 2.
- Device-first Anonymous Auth.
- Ownership Boundary.
- Private Realtime.
- No-Token Policy / External No-Token Finalization.
- Push Registration.
- Push Delivery.
- Push Observability P2.
- Push Token Account-switch Policy.
- State Sync stabilization.
- Polling removal.
- Thumbnail Persistence.
- Build 74 QA baseline.
- Email Recovery baseline/fallback.
- Kakao Recovery Method Linking.
- Kakao Recovery Sign-in P1.
- Kakao Single CTA Recovery UX.
- Product UX Baseline P1.
- Detail Retry / Action UI.
- Home Journal first slice.
- Upload Entry UX Polish.
- Analysis Trust UX.
- Build 84 Kakao one-click recovery real-device QA passed.
- Initial Loading / Video Tab Spinner Observability P1.
- QA Debug Overlay / Panel P1.
- Kakao display_name sync investigation.

Current active work:

- Email Recovery P1: current-account recovery email connection completion.

Near follow-ups:

- Email Recovery sign-in flow for reinstall/new-device recovery.
- Email Recovery redirect / Site URL policy.
- Use QA Debug Panel values to separate app loading-state bugs from
  Render/Supabase/free-plan latency if slow startup or Video spinner behavior
  reappears in real use.
- If latency remains the bottleneck after app-side handling is verified, consider
  a basic infrastructure plan upgrade as a validation step.
- OAuth Step Reduction Investigation: Kakao/iOS may still feel like two external
  `계속` steps even though ASJ's own CTA is one-click.

Later backlog:

- preferred_username / user_name fallback for display-name sync.
- Revisit display_name overwrite policy if user-editable profile names are added.
- Recovery attempt observability row/log design.
- Media / Share UX later.
- Upload Entry Bottom Sheet remains deferred unless a real pre-submit choice
  proves it necessary.
- Compression / Upload Optimization.
- AI Calibration.

## Deferred Follow-Up Issues

- Initial loading / Video tab spinner observability: active. First pass fixed
  the likely indefinite list loading path after remote sync timeout/failed and
  separated Video Archive loading/empty/timeout/error/ready states. Continue with
  QA Debug Overlay/Panel so real-device QA can show where the app is waiting,
  how long each step took, and whether the cause is app state handling or
  infrastructure/network latency. Main hypotheses remain install/cache behavior,
  anonymous auth/user bootstrap timing, push registration, realtime
  subscription, local storage hydration, moments/video fetch, upload recovery
  scan, backend/Supabase cold start, and missing timeout/error/empty-state
  handling. Slow infra can be acceptable if understood; an indefinite spinner
  or unknown waiting state is not acceptable.

## New Session Prompt

Use this prompt when opening the project in a new Codex terminal session:

```text
codex-personal-context의 AGENTS.md, SESSION_WORKFLOW.md, projects/action-sports-journal-app.md와 ASJ 프로젝트의 AGENTS.md, docs/PROJECT_MEMORY.md, docs/CURRENT_STAGE.md, docs/HANDOFF.md, docs/TECH_DEBT_AND_REFACTOR_TODO.md를 먼저 pull/read하고 현재 ASJ 상태를 복구해줘. 최신 기준선은 Build 84 Kakao Single CTA one-click recovery 실기기 QA 통과, Startup / Video Tab Loading Observability P1 1차 수정 완료, 현재 진행은 QA Debug Overlay/Panel이야. 리스트업은 프로젝트 전체 시간축 기준으로 유지하고, 완료된 기반 작업도 생략하지 말아줘. 다음에는 QA Debug Overlay/Panel 결과 확인 후 필요 시 실기기 build 여부를 판단한다.
```
