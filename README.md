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

## Projects

Use `PROJECTS.md` as the index. Common rules live at the repository root;
project-specific settings, current checkpoints, and history live under
`projects/`.

## How To Use

On a new device, clone this repository into the normal repository folder and
run the local setup once:

```bash
mkdir -p ~/Repository
git clone https://github.com/jongsunP/codex-personal-context.git ~/Repository/codex-personal-context
cd ~/Repository/codex-personal-context
./setup-local-codex.sh
```

This keeps the Git-backed personal guidance in
`~/Repository/codex-personal-context` and syncs the active guidance files into
`~/.codex`. The `~/.codex` directory remains Codex's local runtime home for
auth, caches, logs, sessions, and other machine-local state.

Start with `BOOTSTRAP.md` when a new Codex session needs to understand the user.
Follow its canonical [Read Order](BOOTSTRAP.md#read-order): core guidance and
the active project's current checkpoint first, then task-relevant topics and
historical evidence. Do not read unrelated personal topics or the entire change
log at every start. For product work, refresh the assigned project repository,
verify the checkpoint against live Git, and read relevant stable team-owned
documentation under `SESSION_WORKFLOW.md`.

## Core Files

- `BOOTSTRAP.md`: first file to read in a new AI session
- `SESSION_WORKFLOW.md`: start, resume, wrap-up, session-role, and repository
  boundary rules
- `PROFILE.md`: stable user profile
- `AI_WORKFLOW.md`: Codex session ownership and context operating model
- `DEVELOPMENT_STYLE.md`: coding and product collaboration preferences
- `DECISION_FRAMEWORK.md`: preferred structure for decisions
- `FITNESS.md`: fitness and action sports context
- `VEHICLE.md`: vehicle context
- `PROJECTS.md`: project index
- `projects/README.md`: project-specific context structure and lifecycle
- `projects/<project>.md`: personal project progress, history, QA, blockers, and
  next starting point
- `HANDOFF.md`: cross-session resume index and repository-boundary summary
- `MEMORY_CHANGELOG.md`: durable context change log
