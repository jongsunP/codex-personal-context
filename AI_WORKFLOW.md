# AI Workflow

## Tool Separation

The user intentionally separates AI tools by purpose:

- Claude: company development
- Codex: side projects and repository work
- ChatGPT: personal questions, coaching, and broader thinking

## Context Hierarchy

Trust context in this order:

1. Current explicit user instruction
2. Remote Git source of truth
3. Project files in the active repository
4. `codex-personal-context`
5. AI memory
6. General assumptions

If there is conflict, ask or follow the more explicit and more recent source.

Remote state has priority over local-only state. Before relying on local
project or context files, pull the relevant repository when possible. If local
state differs from remote state, do not assume local is correct unless the user
explicitly says the local unpushed work should be treated as authoritative.

When the user asks to check app or project progress, interpret that as a request
to verify the remote-backed source of truth first. Fetch or pull the relevant
project repository and read the committed handoff/status documents instead of
answering from chat history or local assumptions.

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

## Remote Continuity Rule

When the user asks to check project progress, verify current state, or confirm
something about the user, do not leave durable findings only in local state or
chat history.

If the finding is likely to matter in future sessions, update the appropriate
remote-backed Git source of truth:

- Project progress belongs in the relevant project repository handoff docs.
- User-level preferences and cross-project context belong in
  `codex-personal-context`.
- Commit and push durable context updates when safe, so another AI session or
  another computer can continue from the same facts.

Avoid committing secrets, credentials, private customer data, or transient
scratch details.

## Preferred AI Behavior

- Be proactive once context is clear.
- Ask questions only when assumptions would be risky.
- Explain important tradeoffs.
- Preserve project continuity.
- Keep durable handoff documents updated when work changes project state.
- Prefer remote-pushed Git context over local-only notes for durable progress
  and user-context updates.
- Treat remote Git as the default source of truth for continuity.
- For app progress questions, check the remote repository state first unless
  the user explicitly asks for local-only worktree state.
