# Codex Cross-Session Handoff

## Purpose

This private repository stores non-secret context so Codex can continue work across different sessions, terminals, or apps.

Do not store secrets here.

## Current Dentlink Work - DL-14232

Repository:

```text
/Users/parkjongsun/repository/dentlink-client
```

Branch:

```text
feature/DL-14232
```

Checkpoint date:

```text
2026-07-08
```

Status:

```text
Clinic invite/member-management UI committed and pushed; master PR is open.
```

Latest facts:

- Jira: `DL-14232` - `[치과] employee 초대 기능`.
- Scope now completed in Clinic: invite page, invite modal, member list review, member detail refresh behavior.
- Invite page uses All/Pending/Expired tabs, Pending Members table, status/action UI, empty/min-height behavior, and no pagination.
- Invite modal uses existing `Modal` and `MultiChipInput`; invite API is not available yet, so invite creation remains mock/local state.
- Role/Authority dropdowns use existing `PopupMenu` through a clinic-local adapter with `useFixedPortal`; shared UI component internals were not modified.
- Role/Authority options use available code APIs with mock fallback.
- Member detail/list sync was fixed: authority change, remove, approval, and rejection invalidate relevant list/detail/count queries.
- Latest pushed commit: `3cafb25f0 [DL-14232] docs: 프로젝트 Claude 가이드 복구`.
- Master PR: https://github.com/Innvoaid/dentlink-client/pull/4353
- Develop PR `#4352` was merged; user later said only master comparison matters.
- Verified: clinic type, build, prettier check, lint, commit hook, and push hook. Lint has existing project warnings but no failure.
- Remaining future work: replace mock invite state with real Clinic invite API/query/mutation hooks when backend APIs are ready.
- Mobile note: judge mobile completion only against mobile designs actually provided in Figma. Do not call missing mobile designs incomplete just because responsive code is not obvious.
- Figma note: Desktop MCP reconnect was later confirmed. Invite modal section node `224:31671` is accessible but returns sparse section metadata, so future design checks should inspect actual child frames/screenshots before making new completion claims. Codex in-app browser Figma web SSO was attempted, but it stopped on a blank `finish_google_sso` callback page; use Desktop MCP as the reliable path unless web auth is completed separately.
- Jira correction: `DL-15495` is not part of the user-approved DL-14232 invite scope. It was mistakenly updated; the bad comment was edited as invalid and the parent `DL-14232` comment was corrected. DL-15495 was later rechecked and confirmed back in Todo / `해야 할 일`.

## User Preferences

- Always answer in Korean.
- Use polite 존댓말 consistently.
- Be concise, but explain important engineering decisions clearly.
- When approvals are needed, proceed proactively by requesting the required approval.
- When the user asks to confirm app or project progress, treat it as a request
  to check remote Git first and answer from the remote-backed handoff/status
  documents rather than from memory alone.

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
Stage 3 product foundation in progress
Build 75 Kakao Recovery / Account Linking E2E validated
Push Observability P2 complete for current internal/dev scope
```

Latest project checkpoint commit:

```text
65c58ca docs: require remote push at session closeout
```

## Confirmed Project Facts

- Expo SDK is `~54.0.35`.
- React Native is `0.81.5`.
- React is `19.1.0`.
- The app opens on the user physical iPhone through Expo Go.
- The app has also been installed and opened on the user's iPhone as a
  standalone EAS preview/internal distribution app, without Expo Go.
- Build 74 closed Auth Phase 2 Push QA. Push registration/delivery works and
  Push Observability P2 now records delivery attempts, token counts, ticket
  mapping, and manual/internal receipt checks.
- Build 75 validated Kakao Recovery / Account Linking on standalone iOS.
- Device-first Anonymous Auth is a product principle, not a temporary shortcut.
- Recovery is treated as account linking for record protection, not signup as
  the first user experience.
- Ownership Boundary, Private Realtime, and No-Token Policy should not be
  reverted.
- Email Recovery is baseline/fallback. It can send the change-email magic link,
  but productization still needs redirect/deep-link strategy and link-validity
  QA.
- Kakao Recovery is currently the verified recovery path.
- Next immediate product work is Kakao Linking UI success/failure/cancel-state
  clarity.
- Tunnel mode worked when LAN mode was unreliable.
- The first screen source is `src/features/sessions/HomeScreen.tsx`.
- The app entry is `App.tsx`.
- Stage 2 local ActivityGroup / Session prototype works.
- Added Sessions are now persisted on-device with AsyncStorage.
- Project handoff exists in `docs/HANDOFF.md`.
- Latest checkpoint exists in `docs/CONTINUITY_CHECKPOINT.md`.
- Stage 3 API contract exists in `docs/STAGE_3_VIDEO_ANALYSIS_PLAN.md`.
- App Store build identifiers were added to `app.json`.
- Initial EAS config exists in `eas.json`.
- `expo-image-picker` is installed for selecting session videos.
- `@react-native-async-storage/async-storage` is installed for local Session persistence.
- The app can attach a selected video URI to a new Session.
- The mobile mock AI analysis fallback was removed.
- The mobile app calls `EXPO_PUBLIC_AI_ANALYSIS_ENDPOINT` for analysis.
- Remote analysis responses are normalized before rendering.
- Home screen layout was polished with scroll support, header metrics, clearer session cards, and status pills.
- Visible prototype UI copy and mock data were localized for Korean users.
- Guarded local Gemini analysis dev server exists in `dev-server/index.ts`.
- `/api/analyze-session-video` remains the Gemini-backed app-facing endpoint.
- `/api/benchmarks/openai-wakeboard-video` is a parallel GPT-5.5 benchmark
  endpoint for same-video comparison; it does not replace Gemini.
- Latest OpenAI benchmark implementation uses a motion-aware two-stage frame
  strategy: broad scan first, then dense sampling around action windows.
- OpenAI official model docs say GPT-5.5 supports text and image input, not
  direct video input. Therefore the benchmark uses server-side frame sampling
  rather than assuming model inferiority.
- TypeScript validation passed after the OpenAI benchmark implementation.
- `SETUP.md` now documents the new-Mac setup audit, required tools, EAS/Apple
  state, `.env.local` structure, key handling, gitignore audit, backup targets,
  and a 30-minute setup checklist.
- Gemini evidence extraction is implemented and is now the primary video/motion
  evidence path for wakeboard trick attempts.
- User-confirmed trick flow is implemented. Coaching should prefer the
  user-confirmed trick when available.
- Current recommended architecture:
  `Video -> Gemini Evidence Extraction -> User Confirmation -> Coaching Engine -> Stored Session Intelligence`.
- GPT is currently better suited to coaching/report generation after evidence
  and rider intent are confirmed.
- Gemini is currently better suited to video/motion evidence extraction.
- Exact Back Roll vs Tantrum classification is still not reliable enough to
  bypass user confirmation.
- Wakeboard trick identity should be evaluated from stance, edge, approach,
  takeoff, pop, and rotation initiation. Landing/crash are outcomes, not primary
  trick-classification evidence.
- The user's iPhone could open `http://10.10.7.17:8787/health` from Safari on the same Wi-Fi.
- EAS preview environment variable was set:
  `EXPO_PUBLIC_AI_ANALYSIS_ENDPOINT=http://10.10.7.17:8787/api/analyze-session-video`.
- Development API spend target is under KRW 10,000/month. Local dev settings
  include `GEMINI_EVIDENCE_MAX_OUTPUT_TOKENS=6000` to avoid truncated Gemini
  evidence JSON.
- User must configure local `.env.local` with `GEMINI_API_KEY` and
  `OPENAI_API_KEY` for the comparison; API keys must not be committed.
- Real AI analysis must go through a server/BFF endpoint; do not put Gemini or
  OpenAI API keys in the mobile app.

## Resume Commands

Open the project in a terminal:

```bash
cd /Users/parkjongsun/Repository/action-sports-journal-app
codex
```

Suggested first prompt:

```text
AGENTS.md, docs/PROJECT_MEMORY.md, docs/CURRENT_STAGE.md, docs/HANDOFF.md를 먼저 읽고 현재 ASJ 상태를 복구해줘. 최신 기준선은 Build 75 Kakao Recovery / Account Linking E2E 통과, Push Observability P2 완료, 다음 작업은 Kakao Linking UI success/failure/cancel-state polish야. 구현 전에 현재 완료된 것, 지금 하는 것, 앞으로 해야 할 것을 짧게 정리하고 개발 계획을 제안해줘.
```

## Run Commands

```bash
cd /Users/parkjongsun/Repository/action-sports-journal-app
npm install
npm run server:dev
```

Use Node 20 or newer. For local AI testing, confirm the iPhone can open:

```text
http://YOUR_COMPUTER_LAN_IP:8787/health
```

For the 2026-06-12 session, the working LAN IP was `10.10.7.17`.

Build a standalone preview app:

```bash
npx eas-cli@latest build --platform ios --profile preview
```

Current EAS/iPhone facts:

```text
Expo account: jspark88
EAS project ID: f6e1a90a-62fb-4485-9434-ca92a756b8f4
Device: iphone12 mini
UDID: 00008101-000404943640001E
Apple Team ID: L339A3KKLC
```

## Current Product Rules

- This is an Action Sports Life Log platform.
- It is not an AI-only analysis app.
- Session is the center of the system.
- ActivityGroup -> Session -> AnalysisResult -> ShareResult.
- Sharing is important long-term, but should not be implemented yet.
- Login should not precede use. Users should be able to install, use, upload,
  analyze, and create records first.
- Account linking exists to protect records later.

## Do Not Implement Yet

- Unrelated login expansion
- Phone authentication
- Coupons
- Expenses
- Calendar
- RAG
- Compression / upload optimization
- AI calibration
- Social features

## Next Likely Work

Do not add unrelated product features yet. Current priority is product
foundation polish:

1. Kakao Linking UI success/failure/cancel-state polish.
2. Decide whether Kakao `name` / `full_name` should sync to
   `public.users.display_name`.
3. Recheck ownership continuity with a user that already has Moments.
4. Foundation Safety Check.
5. External No-Token Finalization.
6. Push token account-switch policy.

## Other Context Files

- `AGENTS.md`: personal Codex guidance
- `SESSION_WORKFLOW.md`: cross-device session start/resume/wrap-up workflow
- `projects/action-sports-journal-app.md`: project-specific context

## Safety

Never commit these:

- API keys
- access tokens
- `~/.codex/auth.json`
- SQLite state files
- `.env` files
- private user/customer data
