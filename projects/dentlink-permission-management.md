# Dentlink 권한관리 — DL-16317

## 현재 상태 — 2026-09-28 초기 설정 완료·대기

- 사용자가 통합알림센터에 앞서 권한관리 작업을 준비한다고 알렸다.
- 관련 Jira: [DL-16317](https://innovaid.atlassian.net/browse/DL-16317).
  이번에는 본문·댓글·외부 자료를 조회하지 않았으며 상세 요구사항은 미확인이다.
- 프로젝트 이름: **권한관리 프로젝트 폴더**.
- 등록된 로컬 폴더: `/Users/parkjongsun/Documents/ChatGPT/권한관리 프로젝트 폴더 2`.
  앱의 표시 이름은 **권한관리 프로젝트 폴더**이며 프로젝트 ID는
  `52bd24fb-ff53-41fb-a9df-f074b3e608ec`다.
- 사용자가 등록한 경로에 `START_PROMPT.md`를 옮겨 실제 폴더 경로를 맞췄다.
  세션 컨텍스트용 Git과 안내문만 있으며 제품 코드는 clone/연결하지 않았다.
- `권한관리 초기 설정` task `01a0e6fa-384c-7671-abb8-53d33c42c738`를 생성하고
  시작 프롬프트를 자동 전달했다. 공통 지침 읽기 완료 및 분석·구현·파일 변경 없이
  대기를 보고했으며, task의 idle 상태와 실제 cwd를 확인했다.
- 사용자 요청으로 중복 폴더를 정리했다. 최초의 숫자 없는 폴더는 안내문 이동 후
  빈 상태에서 제거했고, `권한관리 프로젝트 폴더 3`은 미등록·미사용이며 사용자 파일,
  커밋·refs·원격이 없는 빈 Git임을 확인하고 삭제했다. 권한관리 폴더는 등록된 `2`
  하나뿐이다. 앱의 프로젝트/task 경로 연결을 보존하기 위해 `2`의 이름은 유지했다.

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

1. 위 프로젝트의 기존 task에서 사용자의 업무 착수 지시를 기다린다.
2. 사용자가 착수를 요청하면 개인 컨텍스트를 갱신하고 Jira 및 관련 요구사항부터 확인한다.
3. 분석·구현 범위와 제품 작업 위치는 그때 live 상태로 결정한다. 초기 설정만을 위해
   제품 clone, branch/worktree, 추가 task를 만들지 않는다.
