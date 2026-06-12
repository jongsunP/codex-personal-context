# Action Sports Journal

## Current State

- Repository: `https://github.com/jongsunP/action-sports-journal-app`
- Local path: `/Users/parkjongsun/Repository/action-sports-journal-app`
- Platform: iOS-first React Native app
- Runtime: Expo Go on physical iPhone
- Current SDK: Expo SDK `~54.0.35`
- Current stage: Stage 1 complete
- Latest Stage 1 commit: `8d44d7b Add Stage 1 repository review`

## Confirmed Working

- GitHub repository exists and is pushed.
- Expo SDK was downgraded to SDK 54 for the user's current App Store Expo Go.
- The app is visible on the user's physical iPhone.
- The first screen shows static text from `src/features/sessions/HomeScreen.tsx`.
- `REVIEW.md` was added and pushed as the Stage 1 repository review.

## Important Files

- `AGENTS.md`: project rules and current setup context
- `docs/HANDOFF.md`: cross-session project handoff
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

When the user is ready, review the Stage 1 app structure together and decide whether to start Stage 2 as a local-only Session prototype.

## New Session Prompt

Use this prompt when opening the project in a new Codex terminal session:

```text
AGENTS.md, docs/HANDOFF.md, docs/CURRENT_STAGE.md, and REVIEW.md를 먼저 읽고 Stage 1 완료 상태에서 이어서 진행해줘.
```
