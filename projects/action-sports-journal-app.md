# Action Sports Journal

## Purpose

This file is the user's personal ASJ configuration, checkpoint, and history in
`codex-personal-context`. It owns ASJ-specific Codex workflow rules and personal
continuity without adding personal AI state to the shared repository.

The shared project repository remains the source for live code and stable
team-owned product and technical documentation:

```text
/Users/parkjongsun/Repository/action-sports-journal-app
```

At resume, read this file first, then verify every time-sensitive checkpoint
against the live project Git state and relevant team-owned docs. At meaningful
closeout, update the personal progress and history here. Update the shared
project documentation only when stable information needed by the team changes.

## Repository

- Repository: `https://github.com/jongsunP/action-sports-journal-app`
- Local path: `/Users/parkjongsun/Repository/action-sports-journal-app`
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

If a future session answers from only the immediate chat topic, treat that as a
workflow miss and re-read the ASJ project `README.md`, `docs/PROJECT_MEMORY.md`,
`docs/CURRENT_STAGE.md`, and `docs/HANDOFF.md` before answering again.

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

## Current Checkpoint Rule

Use this file for personal ASJ progress and history, but never treat a dated
checkpoint as live proof. Pull the ASJ repository and reconcile branch, HEAD,
remote divergence, worktree, code, and stable team docs before answering current
status. This storage-boundary reorganization occurred during Dentlink work, so
refresh the ASJ progress section during the next ASJ session rather than
guessing its current state here.

## Temporary Pause Checkpoint

As of 2026-07-31, the Founder has temporarily paused ASJ work and intends to
resume it later. This is a pause, not a cancellation of the project.

Cost controls applied for the pause:

- Render automatic payment / saved-card billing has been disabled or removed.
- Expo automatic payment / saved-card billing has been disabled or removed.
- Apple Developer Program remains active because it is an annual membership
  and the next renewal is still far away.
- Supabase remains on the unchanged Free plan according to the current project
  record, so no separate cancellation was performed.
- Gemini and OpenAI API usage are usage-based rather than recorded ASJ monthly
  subscriptions. No separate cancellation was performed, and the paused
  project should make no paid AI/API calls.
- The Founder has already added small prepaid amounts for OpenAI and Gemini API
  use. Leave those existing balances in place and do not pursue a refund during
  the pause. Accept that unused credits may expire under each provider's credit
  policy; do not add more credit or enable automatic top-ups while paused.
- The billing review found no other recorded ASJ recurring project charge.
  GitHub, Postico, Kakao OAuth, APNs Push, and the not-yet-purchased custom
  domain do not add a recorded recurring ASJ charge in the current setup.

When work resumes:

1. Pull this personal-context repository and the ASJ project repository.
2. Follow the documented ASJ read order and verify live Git/project state.
3. Re-enable Render or Expo billing only when the next approved work genuinely
   needs those services.
4. Treat the billing notes above as a dated checkpoint and verify current
   provider settings before incurring new costs.

## CTO Session Boundary

For ASJ, the CTO session is the Founder-facing coordination lane. It should
interpret QA, classify product priorities, keep the stable list aligned, update
durable documentation when appropriate, and provide copyable prompts for the
development session.

Do not treat "계속해줘", "진행해", or similar continuation phrases in the CTO
session as permission to implement ASJ app/server code directly. Those phrases
mean to continue the CTO workflow unless the Founder explicitly asks this
session to execute code changes here.

Actual ASJ app/server implementation, migrations, validation commands, commits,
pushes, and EAS builds belong in the separate development session by default.
If this boundary is missed, recover by returning to this personal project
checkpoint, the relevant stable team-owned docs, and the `SESSION_WORKFLOW.md`
CTO contract.

Hard gate: the CTO session must separate "needed" from "approved". EAS builds,
Render deploys, DB writes/migrations, build-number changes, project code
commits/pushes, and cost-incurring AI/API calls require explicit Founder
approval for that exact action before the CTO session gives executable
instructions to a development session. Vague continuation phrases such as
"계속해줘", "진행해", "고", or "좋아" are not enough for these actions. Sync,
read-only investigation, or readiness-check prompts should explicitly say
"검증만 / 수정 금지 / 빌드 금지" unless execution has been approved.

## CTO Handoff Behavior

- Keep the CTO session in coordination, judgment, QA interpretation,
  documentation, and prompt-handoff mode by default.
- In the CTO session, vague continuation phrases continue the CTO workflow; they
  do not authorize app/server code, migrations, project commits or pushes,
  deploys, builds, database writes, or paid AI calls.
- Separate recommendation from execution. A needed build, deploy, or migration
  must be explained before an execution prompt is issued.
- Development-session prompts default to read-only investigation and no build
  unless the Founder approved that exact implementation or execution step.
- If the Founder asks a question after a proposed prompt, pause the handoff and
  answer the question without repeating the prompt. Provide one revised final
  prompt when the Founder asks to continue.
- When a development result arrives and the next safe step is clear, provide the
  next prompt without unnecessary confirmation. EAS Build remains a hard final
  confirmation exception.
- Keep operating rules out of ordinary development prompts unless they directly
  affect that task. Preserve deferred concerns in the personal checkpoint or
  backlog so they do not disappear.

## Validation Cost

- Prefer the cheapest proof that validates the behavior: static checks, local
  app, Simulator, or physical-device testing before a new EAS build.
- Use Development Build or Local Build when repeated native validation would
  otherwise consume multiple cloud builds.
- Before every EAS build, finish code and lower-cost QA, report build readiness,
  and obtain final Founder confirmation.
- For upload reliability tests, preserve the production-like app/backend path
  and bypass only the paid AI-provider call when AI quality is not the target.

## Output Format

- Ordinary status and CTO judgment use concise normal prose.
- Put only copyable prompts, commands, or exact values in code blocks.
- When only the development session needs an action, show the development prompt
  without an empty user section.
- Use the owner headings `개발 세션에게` and `사용자에게` only when both lanes
  genuinely have content.

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
