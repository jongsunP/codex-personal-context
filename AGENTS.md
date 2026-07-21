# Personal Codex Guidance

## Bootstrap

- Treat this repository as the Git-based source of truth for long-term context.
- Read `BOOTSTRAP.md` first in a new session.
- Read `SESSION_WORKFLOW.md` for session start, resume, wrap-up, and
  repository-boundary rules.
- Prefer documented context over AI memory.
- When this user says `메모리`, treat the Git-backed
  `codex-personal-context` repository as the default meaning. Local Codex
  runtime memory under `~/.codex` is secondary and is not sufficient for
  cross-device continuity.
- When a durable user preference or project principle is discovered, suggest
  adding it to this repository.
- Use this repository for cross-project user preferences, Codex working style,
  session workflows, durable personal context, and the user's project progress
  history regardless of the active project.
- Keep personal project checkpoints in `projects/<project>.md`: branch and
  commit state, completed and remaining work, QA and verification, blockers,
  decisions, and the next starting point.
- Keep each shared project repository focused on code and stable, team-owned
  information such as product contracts, architecture, and developer
  documentation. Do not add personal Codex session status or handoff files to a
  repository used by the whole team.
- If a fact affects both, record the personal work history here and update the
  project repository only when the information belongs in the team's canonical
  documentation.

## Communication

- Always answer this user in Korean.
- Use polite 존댓말 consistently.
- For direct answers to the user's questions, default to short, concise
  responses. The user will ask follow-up questions when more detail is needed.
- Minimize screen footprint for direct answers: avoid unnecessary headings,
  long lists, and verbose explanations so the answer is easy to see at a glance.
- For development work, CTO handoffs, implementation notes, decision records,
  and cross-session summaries, include as much detail as the work requires.
- Explain important engineering decisions clearly when detail is necessary.
- Follow the truthfulness and uncertainty-calibration rules in
  `AI_WORKFLOW.md` for all Codex work.

## Permission Preference

- The user prefers Codex to proceed proactively and request required approvals directly when tools need elevated permissions.
- Still follow Codex/system permission prompts when they appear.
- Shared project code, commits, pushes, and PR mutations require the user's
  explicit authorization. Personal memory maintenance in
  `codex-personal-context` is different: at meaningful session closeout, commit
  and push its curated history automatically so the next session or device can
  recover it.
- When the user asks to `CodeRabbit 리뷰 확인` or equivalent, treat that
  wording as explicit authorization for the complete review cycle on the
  current PR: inspect every unresolved CodeRabbit thread, verify each finding
  against the current code, apply valid findings or reply with a concise
  technical rationale when not applying one, resolve the handled threads, run
  proportionate checks, commit and push resulting code, and check once more for
  newly created unresolved threads. Continue until the CodeRabbit check has
  completed and no unresolved CodeRabbit thread remains, unless genuinely
  blocked. This authorization does not include merging the PR or mutating an
  unrelated branch or PR.

## Wrap-Up Workflow

- At the start of a new or resumed session, refresh this repository and the
  relevant project repository with `git pull` before relying on local context
  when the user asks to resume work or continue from a prior checkpoint.
- When the user says to wrap up, finish, close out, end, pause, hand off, or
  summarize a session checkpoint, proactively organize the current state
  instead of only saying goodbye.
- For project work, include completed work, decisions, verified facts, open
  questions, changed files when relevant, what was learned, what is needed,
  future tasks, and the next starting point.
- Update the relevant personal project checkpoint when durable progress has
  changed. Update project documentation only when team-owned canonical
  information changed. Commit and push the personal context at meaningful
  closeout; commit or push the shared project only when explicitly authorized.
- For lightweight question/learning sessions, keep the wrap-up shorter but
  still capture durable preferences or project decisions when they appeared.
- When the user says to resume work or continue from a prior checkpoint, first
  refresh the relevant Git-backed context with `git pull` before relying on
  local memory.
- At meaningful project closeout, curate the personal progress history into
  this repository and commit and push it. Update, commit, or push the shared
  project only when explicitly authorized. Do not require every intermediate
  step to be recorded remotely.

## Project-Specific Layer

- Use `PROJECTS.md` as the project index and read the active
  `projects/<project>.md` after the common guidance files.
- Project-specific product rules, implementation constraints, role boundaries,
  progress, QA history, and next steps belong in that project file rather than
  this common agent guide.
- Common rules apply to every project. A project file may add narrower rules for
  its own scope but must not silently weaken user permission or safety rules.
- Verify every time-sensitive project checkpoint against the live shared
  repository before relying on it.
