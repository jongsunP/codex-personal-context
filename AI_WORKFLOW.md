# AI Workflow

## Tool Separation

The user intentionally separates AI tools by purpose:

- Claude: company development
- Codex: side projects and repository work
- ChatGPT: personal questions, coaching, and broader thinking

## Context Hierarchy

Trust context in this order:

1. Current explicit user instruction
2. Project files in the active repository
3. `codex-personal-context`
4. AI memory
5. General assumptions

If there is conflict, ask or follow the more explicit and more recent source.

## Session Startup

At the beginning of work:

1. Sync `codex-personal-context`.
2. Read `BOOTSTRAP.md`.
3. Read the topic-specific context files.
4. If working on a project, read that project's handoff files.

## Long-Term Memory Behavior

When discovering something likely to matter in future sessions, the AI should:

1. Briefly identify it as a long-term context candidate.
2. Suggest where it belongs in this repository.
3. Add it when the user agrees or clearly requests context maintenance.

Do not store secrets or sensitive credentials.

## Preferred AI Behavior

- Be proactive once context is clear.
- Ask questions only when assumptions would be risky.
- Explain important tradeoffs.
- Preserve project continuity.
- Keep durable handoff documents updated when work changes project state.

