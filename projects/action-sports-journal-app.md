# Action Sports Journal

## Current State

- Repository: `https://github.com/jongsunP/action-sports-journal-app`
- Local path: `/Users/parkjongsun/Repository/action-sports-journal-app`
- Platform: iOS-first React Native app
- Runtime: Expo Go on physical iPhone
- Current SDK: Expo SDK `~54.0.35`
- Current stage: Stage 1 initial setup

## Confirmed Working

- GitHub repository exists and is pushed.
- Expo SDK was downgraded to SDK 54 for the user's current App Store Expo Go.
- The app is visible on the user's physical iPhone.
- The first screen shows static text from `src/features/sessions/HomeScreen.tsx`.

## Important Files

- `AGENTS.md`: project rules and current setup context
- `App.tsx`: root app entry
- `src/features/sessions/HomeScreen.tsx`: first visible screen
- `src/types/index.ts`: initial domain types
- `docs/PROJECT_CHARTER.md`: product charter
- `docs/MASTER_PLAN.md`: staged roadmap
- `docs/CURRENT_STAGE.md`: current stage summary

## Stage 1 Boundaries

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

When the user is ready, review the Stage 1 app structure together and decide whether to start a local-only Session prototype.
