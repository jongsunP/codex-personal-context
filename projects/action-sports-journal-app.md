# Action Sports Journal

## Current State

- Repository: `https://github.com/jongsunP/action-sports-journal-app`
- Local path: `/Users/parkjongsun/Repository/action-sports-journal-app`
- Platform: iOS-first React Native app
- Runtime: Expo Go on physical iPhone
- Current SDK: Expo SDK `~54.0.35`
- Current stage: Stage 2 complete; App Store / TestFlight preparation started
- Latest local project checkpoint commit: `b5d4eb1 Add continuity checkpoint for App Store prep`

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

- AI integration
- Database
- Login or phone authentication
- Real video upload
- Backend
- Coupons
- Expenses
- Calendar
- RAG

## Next Likely Step

Focus on release-path validation before more product work:

1. Push local project commits to GitHub.
2. Confirm Expo/EAS login.
3. Confirm Apple Developer and App Store Connect readiness.
4. Create or verify the App Store Connect app record for `com.jongsunp.actionsportsjournal`.
5. Run `eas build --platform ios --profile production`.
6. Run `eas submit --platform ios --profile production` or upload manually if needed.

## New Session Prompt

Use this prompt when opening the project in a new Codex terminal session:

```text
AGENTS.md, docs/HANDOFF.md, docs/CURRENT_STAGE.md, docs/CONTINUITY_CHECKPOINT.md, and REVIEW.md를 먼저 읽고 Stage 2 완료 및 App Store 준비 상태에서 이어서 진행해줘.
```
