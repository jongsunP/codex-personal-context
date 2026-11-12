# Agent Inbox

사용자가 한 에이전트에게 "다른 에이전트도 이렇게 하래"라고 남긴 전달 사항입니다.
에이전트(사무실 Codex, 사무실 Claude Code, 집 Codex, 집 Claude Code, 이후 추가분)는
각자 따로 운영하며, 이 파일은 사용자의 지시를 다른 에이전트에게 넘기는 통로입니다.
에이전트끼리 서로 지시하는 곳이 아닙니다.

## 규칙

- **방향은 자유:** 보내는 쪽과 받는 쪽은 어떤 조합이든 된다. Codex → Claude, Claude → Codex,
  같은 종류의 다른 기기(사무실 Claude → 집 Claude), 한 에이전트 → "모든 에이전트" 모두 이 파일 하나로 주고받는다.
  새 에이전트가 생기면 아래에 섹션을 하나 추가한다.
- **정본 위치:** 읽기·수정은 항상 이 저장소의 파일에서 한다. Codex의 `~/.codex` 복사본(`setup-local-codex.sh`)은
  참고용이라 완료 표시를 거기에 하지 않는다.
- **남기기:** 사용자가 다른 에이전트에게 전하라고 할 때만 적는다. 받는 에이전트, 날짜,
  남긴 에이전트, 사용자 지시 내용(필요하면 정본 문서 링크)을 쓰고 상태는 `열림`.
- **확인:** 각 에이전트는 세션 시작·재개 시 동기화(pull)하면서 자기 섹션과 "모든 에이전트"
  섹션의 `열림` 항목을 확인한다.
- **처리:** 적용했으면 상태를 `완료 (YYYY-MM-DD, 처리한 에이전트)`로 바꾸고 commit·push한다.
  적용할 수 없거나 사용자 확인이 필요하면 `보류: 이유`로 적고 사용자에게 알린다.
- 다른 에이전트 섹션의 항목은 처리하지 않는다. 지침 자체의 정본은 각 문서
  (`AGENTS.md`, `SESSION_WORKFLOW.md`, `projects/dentlink-fe.md` 등)이고, 이 파일은 전달 기록이다.
- 비밀 값·고객 데이터는 적지 않는다. 완료 항목이 쌓이면 오래된 것부터 정리해도 된다.

## 모든 에이전트

- **2026-11-12 · 사무실 Claude가 남김 · 열림(각 에이전트가 자기 이름으로 완료 표시):**
  에이전트별 메인세션 1개 구조와 동기화·기록 시점이 확정됐다. 정본은
  `projects/dentlink-fe.md` Session Ownership, `AGENTS.md` Wrap-Up(2026-11-12 항목).
  - 사무실 Claude: 완료 (2026-11-12, 사무실 Claude)
  - 집 Claude: 열림
  - 사무실 Codex: 열림
  - 집 Codex: 열림(사용 시작 때)

- **2026-11-12 · 사무실 Claude가 남김 · 열림(각 에이전트가 자기 이름으로 완료 표시):**
  사용자 지시로 모든 에이전트가 같은 방식으로 일한다. 메인세션은 특정 작업·브랜치·PR에 묶지 않는 일반
  메인으로 두고, 큰 기능은 그 기능 전체를 맡는 상시 하위 세션 하나에 보낸다(이름만이 아니라 실제 역할,
  기능 진행 중에는 보관하지 않음). 넘긴 뒤 메인은 추적·폴링·재검증하지 않고, 완료 보고가 오면 결정할 것과
  남은 것만 전한다(재검증은 사용자 요청 시). 정본: `SESSION_WORKFLOW.md` "Standing feature sessions and a
  general main", `AGENTS.md`.
  - 사무실 Claude: 완료 (2026-11-12, 사무실 Claude) — 알림센터 상시 하위 세션 `local_62b33d4f…`
  - 집 Claude: 열림
  - 사무실 Codex: 열림
  - 집 Codex: 열림(사용 시작 때)

## 집 Claude Code

- **2026-11-12 · 사무실 Claude가 남김 · 열림:** 메인세션은 메인 폴더 `~/repository` 아래의
  모든 프로젝트(dentlink-client와 웹 worktree, dentlink-app, dentlink-lab-app,
  dentlink-studio, codex-personal-context)를 직접 읽기·수정·Git·빌드·실행할 수 있는
  범위로 운영한다. 다만 구현은 기본적으로 하위 세션(해당 repo worktree)에 맡기고,
  수정 전에 대상 repo·브랜치·worktree를 확인하며, 각 repo의 CLAUDE.md/AGENTS.md를
  따른다. 사용자가 직접 하라고 하면 메인에서 바로 해도 된다. 사무실 Claude 메인
  (`~/Repository`)과 같은 방식이다.

## 사무실 Codex

- **2026-11-12 · 사무실 Claude가 남김 · 열림:** 다음 사용 때 이 저장소를 pull하고
  `./setup-local-codex.sh`로 2026-11-11~12 지침(Claude Code 대응표, 에이전트별 메인 구조,
  동기화·기록 시점, Lab 번역 시트 중단, env 팀 규칙)을 로컬 Codex에 반영한다.

## 집 Codex

- **2026-11-12 · 사무실 Claude가 남김 · 열림:** 집 Mac에서 Codex를 쓰기 시작하면
  메인세션을 하나 지정해 `projects/dentlink-fe.md` Session Ownership 표에 등록하고,
  메인 폴더 아래 프로젝트를 위 "집 Claude Code" 항목과 같은 방식으로 운영한다.
