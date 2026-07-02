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

When the Founder asks for the list, list-up, "리스트업", "현재 리스트업",
"리스트", "전체 리스트", or "현재/남은 것", treat it as a request for the
full project workstream list unless the Founder explicitly narrows the scope.
Keep the project format:

```text
완료:
현재 남은 과제:
```

The list is a PM/product workstream timeline, not a transient engineering
checklist. Do not add typecheck, diff-check, Simulator QA, build readiness, or
"waiting for development-session result" as standalone workstreams. Build
numbers can be supporting evidence, not the workstream itself.

Unless the Founder explicitly asks for a summary, subset, or priority-only
answer, show the full canonical list from the project repo, including the
complete `완료` section.

If a response intentionally covers only a narrow area, name that scope first so
it cannot be mistaken for the full list. For example: "Startup Performance
기준으로는...".

## Session Bootstrap Prompts

The canonical CTO-session and development-session initial setup prompts live in
the ASJ project repository:

```text
action-sports-journal-app/README.md
```

Use the `CTO Session Bootstrap Prompt` section when the Founder asks for a new
CTO-session setup prompt.

Use the `Development Session Bootstrap Prompt` section when the Founder asks a
CTO session for the development-session setup prompt.

Do not keep second copies of these prompts here.

## Current Shortcut

Do not rely on this file for current ASJ status. Always re-check the project
repo documents in the read order above. This file is only an index and durable
operating-rule layer.

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
