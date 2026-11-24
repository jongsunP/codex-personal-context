# Dentlink Amplitude 이벤트 확인 — DL-17604

## 현재 상태 — 2026-11-24 읽기 전용 조사 세션에 전달

- 사용자 목적: 담당 이벤트가 코드에 있는지만 웹·앱에서 확인. 아직 코드·Jira·Notion은 변경하지 않는다.
- 담당 채팅: **Amplitude 이벤트 확인 · DL-17604**, `01a20b41-ed6f-7b30-99cd-7bb151a66fdf`.
- 기존 메인 프로젝트 폴더 `/Users/parkjongsun/Documents/ChatGPT/메인 프로젝트`, 실행 host `local`. 별도 폴더·branch·worktree 생성 없음.
- `gpt-6.2-astra / ultra` 명시 생성 후 실제 turn metadata에서 적용 확인. 등록·초기 조사 시작을 1회 확인했다.
- 메인은 인계·초기 기록만 완료했다. 코드 조사 결과는 아직 확인하지 않았으며 이후 진행 조회/폴링 없이 담당 채팅이 사용자에게 직접 보고한다.

## 조사 대상과 경계

- [DL-17604](https://innovaid.atlassian.net/browse/DL-17604): 제목 `앰플리튜드 이벤트 상태 확인`, 담당 Frankie, 상위 DL-17469, 1차 조회 댓글 0개.
- [이벤트 Notion 표](https://app.notion.com/p/innovaid/1aece072e82f8082b52ce49e409d3f6d?v=1b6ce072e82f80749708000cadc7e1a2&source=copy_link)의 Frankie 담당 항목과 대상 제품이 실제 조사 범위다.
- Jira 본문에는 완료 항목의 Notion 상태변경도 있지만 이번 명시적 읽기 전용 지시가 우선한다. **Notion 진행률/상태도 변경하지 않는다.**
- 웹 `/Users/parkjongsun/Repository/dentlink-client`, Office `/Users/parkjongsun/Repository/dentlink-app`, Lab `/Users/parkjongsun/Repository/dentlink-lab-app`은 독립 저장소다. 최신 Git/기준과 코드 증거는 담당 채팅에서 확인한다.
- 선언만 있는지, 실제 track/wrapper 호출로 연결되는지, 화면·행동·분기·properties를 확인하고 앱 WebView의 웹 코드 사용도 구분한다. 실제 Amplitude 수집·배포 성공 검증으로 확대하지 않는다.
- 제품 수정·신규 branch/worktree/PR·배포·실제 이벤트 전송·기기 실행 없음. 접근 불가나 요구 모호함은 확인불가로 보고한다.

## 다음 시작점

담당 채팅에서 Notion 담당 이벤트를 읽고 제품별 코드 근거를 표로 보고한다. 결과와 후속 승인 필요 항목은 이 문서에 이어서 정리하며, 구현이나 Notion/Jira 변경은 별도 사용자 지시 후 진행한다.
