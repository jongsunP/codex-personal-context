# Action Sports Journal

## Current State

- Repository: `https://github.com/jongsunP/action-sports-journal-app`
- Local path: `/Users/parkjongsun/Repository/action-sports-journal-app`
- Platform: iOS-first React Native app
- Runtime: Expo Go on physical iPhone
- Current SDK: Expo SDK `~54.0.35`
- Current stage: Stage 3 video-to-analysis prototype started; App Store / TestFlight preparation also exists
- Latest local project checkpoint commit: `ef942d8 Add video analysis prototype flow`

## Confirmed Working

- GitHub repository exists.
- Expo SDK was downgraded to SDK 54 for the user current App Store Expo Go.
- The app is visible on the user physical iPhone.
- Tunnel mode worked when LAN mode was unreliable.
- ActivityGroups can be selected.
- Sessions are filtered by selected ActivityGroup.
- Add Session opens an input flow.
- Saving a session adds it to the in-memory list.
- Added sessions disappear after reload because persistence is intentionally not implemented yet.
- `expo-image-picker` is installed for selecting session videos.
- A selected video can be attached to a new Session.
- `Request AI Check` returns a local mock analysis result unless `EXPO_PUBLIC_AI_ANALYSIS_ENDPOINT` is configured.
- Real OpenAI analysis must go through a server/BFF endpoint; do not put API keys in the mobile app.

## Important Files

- `AGENTS.md`: project rules and current setup context
- `docs/HANDOFF.md`: cross-session project handoff
- `docs/CONTINUITY_CHECKPOINT.md`: latest continuity checkpoint
- `docs/CURRENT_STAGE.md`: current stage summary
- `docs/STAGE_2_PLAN.md`: Stage 2 scope
- `App.tsx`: root app entry
- `src/features/sessions/HomeScreen.tsx`: first visible screen
- `src/features/groups/mockActivityGroups.ts`: local mock ActivityGroups
- `src/features/sessions/mockSessions.ts`: local mock Sessions
- `src/types/index.ts`: domain types
- `app.json`: Expo app config, bundle identifier, build numbers
- `eas.json`: EAS build/submit config

## Current Boundary

Do not implement these yet:

- Real server-side OpenAI integration
- Database
- Login or phone authentication
- Real video upload
- Backend
- Coupons
- Expenses
- Calendar
- RAG

## Next Likely Step

Focus on validating the first feature flow before more infrastructure:

1. Run the app on the physical iPhone.
2. Add a Session.
3. Select a video.
4. Save the Session.
5. Tap `Request AI Check`.
6. Confirm the mock analysis result appears.
7. Then add a minimal server/BFF endpoint for real OpenAI analysis.

## New Session Prompt

Use this prompt when opening the project in a new Codex terminal session:

```text
AGENTS.md, docs/HANDOFF.md, docs/CURRENT_STAGE.md, docs/CONTINUITY_CHECKPOINT.md, and REVIEW.md를 먼저 읽고 Stage 2 완료 및 App Store 준비 상태에서 이어서 진행해줘.
```
