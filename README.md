# Codex Personal Context

Private repository for non-secret Codex working context.

This repository is intended to help future Codex sessions understand stable user preferences and active project context.

## What Belongs Here

- Stable communication preferences
- Non-secret project locations
- Public or private GitHub repository URLs
- Current project stage summaries
- Safe setup notes
- Reusable Codex guidance

## What Must Not Be Stored Here

- API keys
- Access tokens
- Passwords
- `~/.codex/auth.json`
- Codex SQLite state files
- App secrets
- `.env` files
- Private customer/user data

## Current Main Project

Action Sports Journal

- Local path: `/Users/parkjongsun/repository/action-sports-journal-app`
- GitHub remote: `https://github.com/jongsunP/action-sports-journal-app`
- Stage: Stage 3 real video-to-analysis prototype in progress
- Expo SDK: `~54.0.35`
- React Native: `0.81.5`
- React: `19.1.0`
- Status: visible on the user's physical iPhone through Expo Go and standalone EAS preview/internal distribution

Latest documented project commit:

```text
c7cdfe9 Switch dev analysis server to Gemini video input
```

## How To Use

On a new device, clone this repository as the Codex home and run the local
setup once:

```bash
git clone https://github.com/jongsunP/codex-personal-context.git ~/.codex
cd ~/.codex
./setup-local-codex.sh
```

This makes the Git-backed personal guidance the active global Codex guidance on
that device. The script also creates `~/Repository/codex-personal-context` as a
convenient alias to `~/.codex` when it does not already exist.

Start with `BOOTSTRAP.md` when a new Codex session needs to understand the user.
Then read `SESSION_WORKFLOW.md` and `HANDOFF.md` for current continuation
context. For project work, also read the target project's `AGENTS.md` and
handoff docs.

## Core Files

- `BOOTSTRAP.md`: first file to read in a new AI session
- `SESSION_WORKFLOW.md`: start, resume, wrap-up, session-role, and repository
  boundary rules
- `PROFILE.md`: stable user profile
- `AI_WORKFLOW.md`: how the user separates AI tools and context
- `DEVELOPMENT_STYLE.md`: coding and product collaboration preferences
- `DECISION_FRAMEWORK.md`: preferred structure for decisions
- `FITNESS.md`: fitness and action sports context
- `VEHICLE.md`: vehicle context
- `PROJECTS.md`: project index
- `HANDOFF.md`: current cross-session handoff
- `MEMORY_CHANGELOG.md`: durable context change log
