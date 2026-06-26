# Action Sports Journal

## Purpose

This file is an index for ASJ-specific context in `codex-personal-context`.
It is not the canonical project memory.

The canonical ASJ product status, stable workstream list, technical decisions,
QA state, and backlog live in the project repository:

```text
/Users/parkjongsun/repository/action-sports-journal-app
```

Read the project documents instead of duplicating their contents here.

When updating ASJ-specific state, write to the ASJ project repository according
to its `README.md` "Where To Write" map. This personal-context file should stay
an index, not a duplicated project memory.

## Repository

- Repository: `https://github.com/jongsunP/action-sports-journal-app`
- Local path: `/Users/parkjongsun/repository/action-sports-journal-app`
- Platform: iOS-first React Native / Expo app
- Current Expo SDK: `~54.0.35`

## Start/Resume Read Order

When resuming ASJ work, first pull both repositories, then read this exact
order. Do not skip, reorder, or replace it with a chat summary unless a file is
genuinely missing:

1. `codex-personal-context/AGENTS.md`
2. `codex-personal-context/SESSION_WORKFLOW.md`
3. This file
4. `action-sports-journal-app/README.md`
5. `action-sports-journal-app/AGENTS.md`
6. `action-sports-journal-app/docs/PROJECT_MEMORY.md`
7. `action-sports-journal-app/docs/CURRENT_STAGE.md`
8. `action-sports-journal-app/docs/HANDOFF.md`
9. `action-sports-journal-app/docs/TECH_DEBT_AND_REFACTOR_TODO.md`

## Canonical List Rule

The ASJ stable workstream list must be read from:

```text
action-sports-journal-app/docs/PROJECT_MEMORY.md
```

Use the `Current stable workstream list` block from that file. Do not maintain
or answer from a duplicated list in this personal-context file.

When the Founder asks for the list, keep the project format:

```text
완료:
남은 것:
```

The list is a PM/product workstream timeline, not a transient engineering
checklist. Do not add typecheck, diff-check, Simulator QA, build readiness, or
"waiting for development-session result" as standalone workstreams. Build
numbers can be supporting evidence, not the workstream itself.

## Current Shortcut

As of the latest sync, the immediate ASJ flow is still governed by the project
repo docs. In the current conversation, Build 86 Email Recovery Connection QA
and Real-use Loading Diagnosis were the active threads. Always re-check the
project repo before relying on this shortcut.

## Durable Product Principles

- ASJ is not an MVP. It is a real service built one reliable foundation at a
  time.
- Upload reliability is survival-critical. AI quality can improve over time,
  but preventable upload failure or unknown loading states must be investigated.
- Device-first Anonymous Auth, Ownership Boundary, Private Realtime,
  Push Observability, and Kakao Recovery are durable foundations.
- The target audience is a small Korean action-sports niche. Instagram and
  KakaoTalk matter because they match actual user behavior.
- The Founder is a web frontend developer. Explain mobile/backend/infra gaps
  clearly when they are the source of confusion, without lowering the technical
  level.
