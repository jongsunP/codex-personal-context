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

This list is a product/workstream timeline for PM-style planning, not a code
change list or temporary engineering checklist. Do not include transient
validation steps such as typecheck, diff-check, Simulator QA, build readiness,
or "wait for development-session result" as list items. Build numbers may be
mentioned as evidence in notes, but they are not standalone product workstreams.
Keep workstream names stable and evolve the same list over time.

Completed product foundations and slices:

- Direct Upload Foundation(직접 업로드 기반): the app can create riding records
  from user-selected videos.
- Upload Reliability(업로드 신뢰성): upload, analysis handoff, result reflection,
  recovery cases, and thumbnail persistence are stable enough for the current
  phase.
- Device-first Identity(기기 우선 인증): users can start with anonymous/device-first
  usage instead of a login wall.
- Ownership and Privacy Boundary(소유권/프라이버시 경계): records are scoped to the
  user owner, realtime is private, and external no-token user paths are closed.
- Push Notification Foundation(푸시 알림 기반): push registration, delivery,
  observability, and account-switch token ownership are established.
- State Sync Foundation(상태 동기화 기반): Home, Video, Detail, upload completion,
  analysis completion, Push, and Realtime can converge without polling as the
  primary model.
- Recovery Baseline(복구 기준선): Email Recovery exists as a fallback baseline.
- Kakao Recovery(카카오 복구): Kakao account linking, reinstall/new-device recovery
  sign-in, and one user-facing Kakao CTA are verified for the current phase.
- Product UX Baseline(제품 UX 기준선): user-facing record status language is
  unified as 진행중 / 완료 / 실패.
- Detail Action UX(상세 액션 UX): detail retry/delete/action states are visible and
  explainable.
- Journal First Slice(저널 첫 슬라이스): Home now behaves more like a riding
  journal entry point, not only a video gallery.
- Upload Entry UX(업로드 진입 UX): the upload entry surface is polished for the
  current phase.
- Analysis Trust UX(분석 신뢰 UX): analysis/trick review/result explanation has a
  clearer trust path.
- Loading Observability(로딩 관측성): slow startup and Video/List spinner behavior
  now have app-side timeout/error/retry handling and QA diagnostics for
  real-device investigation.
- Kakao Display Name Policy(카카오 표시 이름 정책): investigated; current
  metadata/display_name sync is sufficient, with only low-priority
  fallback/policy follow-ups left.

Current active work:

- Email Recovery Connection(복구 이메일 연결): connect a recovery email to the current
  device-first account and return to ASJ through the app deep link.

Near follow-ups:

- Email Recovery Sign-in(이메일 기존 기록 복구): recover existing records by email
  after reinstall or on a new device.
- Email Recovery Redirect / Site URL Policy(이메일 리다이렉트/Site URL 정책):
  decide production-safe fallback and redirect rules for email flows.
- Real-use Loading Diagnosis(실사용 로딩 진단): if slow startup or Video spinner behavior
  reappears, use QA diagnostics to separate app-state issues from
  Render/Supabase/free-plan latency.
- Infrastructure Plan Validation(인프라 플랜 검증): if app behavior is correct but
  latency remains the bottleneck, test a basic Render/Supabase plan upgrade.
- Kakao OAuth Step Reduction(카카오 OAuth 단계 축소): investigate whether Kakao/iOS
  external "continue" friction can be reduced without breaking Supabase OAuth.

Later backlog:

- Display Name Fallbacks and Profile Policy(표시 이름 fallback/프로필 정책): add
  preferred_username/user_name fallback only if needed, and revisit overwrite
  rules when user-editable profile names exist.
- Recovery Attempt Observability(복구 시도 관측성): add durable row/log design for
  recovery attempts if debugging requires more than screen diagnostics.
- Media / Share UX(미디어/공유 UX).
- Upload Entry Bottom Sheet(업로드 진입 바텀시트): keep deferred unless a real
  pre-submit choice proves it necessary.
- Compression / Upload Optimization(압축/업로드 최적화).
- AI Calibration(AI 보정).

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
