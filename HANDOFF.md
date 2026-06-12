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
/Users/parkjongsun/repository/action-sports-journal-app
```

Current status:

```text
Stage 1 complete
Stage 2 local ActivityGroup / Session prototype complete
Standalone iPhone EAS preview/internal distribution validated
Stage 3 real video-to-analysis prototype in progress
```

Latest local project checkpoint commit:

```text
802bd94 Benchmark OpenAI wakeboard analysis
```

## Confirmed Project Facts

- Expo SDK is `~54.0.35`.
- React Native is `0.81.5`.
- React is `19.1.0`.
- The app opens on the user physical iPhone through Expo Go.
- The app has also been installed and opened on the user's iPhone as a
  standalone EAS preview/internal distribution app, without Expo Go.
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
- The dev server calls Gemini Video Understanding through server-side Gemini API credentials.
- The dev server was confirmed on port `8787` with `/health` returning
  `geminiConfigured: true` and model `gemini-3.5-flash`.
- On 2026-06-12, the dev analysis server was switched back to an OpenAI GPT-5.5
  benchmark path to test whether ChatGPT-quality wakeboard coaching can be
  reproduced through the OpenAI API before giving up on OpenAI.
- Latest OpenAI benchmark implementation samples the whole video into evenly
  spaced frames, sends image inputs to GPT-5.5 through the Responses API, uses
  `reasoning.effort=xhigh`, and returns structured JSON with observations,
  pattern recognition, inferences, confidence, and self-critique.
- OpenAI official model docs say GPT-5.5 supports text and image input, not
  direct video input. Therefore the benchmark uses server-side frame sampling
  rather than assuming model inferiority.
- TypeScript validation passed after the OpenAI benchmark implementation.
- A dummy-key upload test confirmed the server reaches OpenAI authentication
  after video upload and frame extraction; a real `OPENAI_API_KEY` is still
  needed for the actual GPT-5.5 benchmark result.
- The user's iPhone could open `http://10.10.7.17:8787/health` from Safari on the same Wi-Fi.
- EAS preview environment variable was set:
  `EXPO_PUBLIC_AI_ANALYSIS_ENDPOINT=http://10.10.7.17:8787/api/analyze-session-video`.
- Development API spend target is under KRW 10,000/month with max 20MB video, 3 analyses/day, 600 output tokens.
- User must configure Gemini API billing/budget and local `.env.local`; API keys must not be committed.
- Real AI analysis must go through a server/BFF endpoint; do not put Gemini or
  OpenAI API keys in the mobile app.

## Resume Commands

Open the project in a terminal:

```bash
cd /Users/parkjongsun/repository/action-sports-journal-app
codex
```

Suggested first prompt:

```text
AGENTS.md, docs/HANDOFF.md, docs/CURRENT_STAGE.md, docs/CONTINUITY_CHECKPOINT.md, docs/STAGE_3_VIDEO_ANALYSIS_PLAN.md, docs/DEV_AI_ANALYSIS_SETUP.md를 먼저 읽고, 현재 dev-server의 OpenAI GPT-5.5 wakeboard benchmark 구현 상태에서 이어서 진행해줘. OpenAI를 포기하지 말고, 실제 OPENAI_API_KEY로 같은 웨이크보드 영상을 테스트한 뒤 Gemini 결과와 비교해줘.
```

## Run Commands

```bash
cd /Users/parkjongsun/repository/action-sports-journal-app
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

## Do Not Implement Yet

- Database
- Login or phone authentication
- Production video upload/storage
- Production backend
- Coupons
- Expenses
- Calendar
- RAG

## Next Likely Work

Do not add unrelated product features yet.

The next work should focus on validating the OpenAI GPT-5.5 wakeboard benchmark
before making provider conclusions:

1. Add local `.env.local` with `OPENAI_API_KEY` and GPT-5.5 benchmark settings.
2. Run `npm run server:dev`.
3. Confirm `/health` returns `provider: "openai"`, `model: "gpt-5.5"`, and
   `openaiConfigured: true`.
4. Test the exact same wakeboard video used for Gemini comparison.
5. Save the GPT-5.5 JSON output.
6. Compare it with the current Gemini output.
7. Report whether poor quality was caused by weak prompt, incorrect API usage,
   video input implementation, model limitation, or ChatGPT internal
   orchestration differences.

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
