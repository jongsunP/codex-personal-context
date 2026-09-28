# Dentlink 권한관리 — DL-16317

## 현재 상태 — 2026-09-28 초기 설정 준비

- 사용자가 통합알림센터에 앞서 권한관리 작업을 준비한다고 알렸다.
- 관련 Jira: [DL-16317](https://innovaid.atlassian.net/browse/DL-16317).
  이번에는 본문·댓글·외부 자료를 조회하지 않았으며 상세 요구사항은 미확인이다.
- 프로젝트 이름: **권한관리 프로젝트 폴더**.
- 로컬 폴더: `/Users/parkjongsun/Documents/ChatGPT/권한관리 프로젝트 폴더`.
  세션 시작용 폴더를 생성했으며 제품 clone이나 Git 초기화는 하지 않았다.
- `START_PROMPT.md`에 초기 설정 후 대기하도록 하는 시작 프롬프트를 준비했다.
- Codex 프로젝트 등록·task 생성·프롬프트 전달은 아직 미완료다. 사용 가능한 도구에는
  새 로컬 프로젝트 등록 기능이 없어, 사용자가 폴더를 앱에 등록한 뒤
  `list_projects`에서 반환된 ID로 task를 생성해야 한다.

## 승인된 범위와 역할

- 현재 승인은 폴더·프로젝트·새 세션 준비와 공통 지침·개인 컨텍스트 읽기까지다.
- 요구사항 분석, 제품 코드 조사, 설계·구현, 테스트·서버 실행, 제품 Git 변경과
  배포는 착수하지 않고 사용자의 다음 지시를 기다린다.
- 웹·관리자는 `/Users/parkjongsun/Repository/dentlink-client`, 앱은
  `/Users/parkjongsun/Repository/dentlink-app`이라는 별도 제품 저장소 경계를 유지한다.
- 실제 웹·앱 영향 범위, 작업 branch/worktree, base와 release는 아직 정하지 않았다.
- FE 최상위 조율은 [dentlink-fe.md](dentlink-fe.md), 기존 통합알림센터 기록은
  [dentlink-unified-notification-center.md](dentlink-unified-notification-center.md)에 있다.
  기존 알림센터의 정책을 권한관리 요구사항으로 추정하지 않는다.

## 다음 시작점

1. 사용자가 위 폴더를 Codex에 등록하면 프로젝트 이름·경로를 확인한다.
2. 그 프로젝트에서 `권한관리 초기 설정` task를 생성하고 준비된 프롬프트를 전달한다.
3. 새 task가 개인 컨텍스트를 읽고 초기 설정 완료·대기를 보고했는지 확인한다.
4. 등록/task ID와 초기화 결과를 이 문서에 갱신한다. 실제 업무 착수는 별도 지시를 기다린다.
