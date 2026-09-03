# User Profile

## Identity

- Name: Park Jong Sun
- Primary role: Web frontend developer
- Collaboration language: Korean, polite 존댓말

## AI Usage Pattern

The user actively uses multiple AI tools with clear separation of roles:

- Company development: Claude
- Side projects: Codex
- Personal questions and coaching: ChatGPT
- Long-term context: `codex-personal-context`
- Project context: project `HANDOFF` and related docs

## Working Preference

The user values continuity and context more than the specific AI model.

The preferred collaboration style is practical, context-aware, and iterative.
The AI should avoid treating each session as isolated. It should check Git-based
context and continue from documented state.

## Decision Style

The user can start from intuition, attraction, or preference, but final
decisions are usually validated through real-world constraints.

Recurring decision criteria:

- Practical constraints
- Risk
- Regret minimization
- Long-term usefulness
- Maintenance burden
- Whether the approach was logically sound

The user often cares less about whether a result looks good in isolation and
more about whether the decision process was correct. When new information
appears, the user may re-evaluate past decisions rather than simply defend the
original choice.

This pattern appears across development, fitness, vehicle decisions, AI usage,
and product work.

The user's self-understanding can be summarized with a Zhang He style analogy:
adaptation, realistic optimization, using the cards available, and choosing the
best practical path over an idealized one.

## Developer Profile

The user is a product-oriented developer who prefers to build quickly, use the
result in real conditions, identify why it failed, then improve the structure.

Typical pattern:

1. Make it work.
2. Use it for real.
3. Find the failure cause.
4. Improve the structure.
5. Validate again.

The user does not prefer perfect upfront design. At the same time, the user is
not a pure hacker-style builder. A working prototype is valuable, but it should
eventually explain why it succeeds or fails.

The user is strong at:

- Seeing systems before implementation details
- Decomposing problems by cause rather than by feature
- Connecting technical work to product experience
- Moving from idea to implementation quickly
- Using real usage as the main validation source

Watchouts:

- Fast progress can sometimes outrun logging, evidence capture, or
  reproducibility.
- When a problem appears, the user may want to fix it before enough data has
  been collected.
- The user tends to go deep in personally interesting domains and automate or
  delegate less interesting areas quickly.

## 실시간 웹 개발 경험과 안내 수준

2026-09-03 사용자 설명 기준이며, 근무 서비스명은 기록하지 않는다.

- 채팅이 주력인 협업 메신저의 웹 팀에서 AngularJS 기반 개발과 WebSocket을 통한
  읽음 처리·실시간 상태 갱신을 경험했다.
- 주된 흐름은 REST로 초기 데이터를 조회한 뒤 WebSocket 이벤트로 해당 상태를
  갱신하는 방식이었다. 당시에는 React Query 같은 서버 상태 관리 도구 없이
  갱신을 처리했다.
- Android·iOS는 별도 네이티브 팀이 담당했다. 웹 경험을 근거로 모바일 플랫폼
  세부 동작까지 익숙하다고 가정하지 않는다.
- 실시간 동기화의 기본 개념과 구현의 큰 그림은 이해하고 있다. 경험을 설명한
  목적은 과거와 현재의 비교 설명을 요구한 것이 아니라, 현재 프로젝트에 적용할
  때 알아야 할 사항과 놓치기 쉬운 부분을 AI가 선제적으로 짚어주길 바라는 것이다.
- 기본 원리를 반복 강의하지 않되, 현재 라이브러리·프로젝트 구조·플랫폼 제약까지
  모두 알고 있다고 가정하지 않는다. 필요한 지식을 현재 적용 맥락에서 짧고
  구체적으로 안내한다.

## Technology Selection

The user has low loyalty to any specific language, framework, or tool.

The most important question is whether the technology solves the current
problem. Other important factors are development speed, maintainability, and
real operational feasibility.

Lower-priority factors:

- Whether the technology is new
- Community hype
- Developer taste detached from the actual problem

## AI Collaboration Style

The user does not treat AI as a search engine. The preferred role is closer to a
specialized assistant.

Useful AI roles:

- CTO
- Project secretary
- Project historian
- Analyst
- Code reviewer

The user strongly dislikes plausible but unsupported answers, baseless
confidence, and unverified claims presented as facts.

Preferred AI behavior:

- Say when something is unknown.
- Separate fact, hypothesis, inference, and recommendation.
- Give evidence for important claims.
- Preserve context across sessions.
- Turn repeated learnings into durable documentation when appropriate.

## Personal Operating Pattern

Long-term pattern:

1. Notice an interesting problem.
2. Build a fast prototype.
3. Use AI actively.
4. Test it in real life.
5. Structure the failure or insight.
6. Automate what can be automated.
7. Turn the useful parts into a system.

One-line summary:

The user is a product-centered developer who builds quickly, validates in real
life, and turns failure causes into better systems.

## Interests

- Action sports
- Wakeboarding
- Snowboarding
- Solo extreme sports with visible growth and skill progression
- Fitness and diet
- Vehicle maintenance and upgrades

## Current Vehicle

- BMW G30 520d

Vehicle questions should use this as the default reference unless the user says
otherwise.
