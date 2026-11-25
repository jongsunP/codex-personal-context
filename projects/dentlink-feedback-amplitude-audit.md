# Dentlink 피드백 Amplitude 코드 조사

## 현재 상태 — 2026-11-25

- 사용자 요청: Jira 카드 없이 별도 세션·별도 worktree에서 피드백 Amplitude 이벤트 전체를 코드로만 조사한다. 메인은 준비·인계만 하고 결과는 담당 세션이 사용자에게 직접 보고한다.
- 새 세션 **피드백 Amplitude 이벤트 코드 조사** (`01a211d5-91e6-7a70-bfd6-a25bd4ed22dc`, local) 생성·프롬프트 전달·조사 시작을 확인했다. 생성시 메인과 실제 새 세션 `gpt-6-astra` / `xhigh` 일치. 아직 조사 결과가 아니며 결과는 담당 세션에서 보고한다. 메인은 이후 자동 폴링하지 않는다.
- 채팅 persisted cwd는 기존 메인 프로젝트 폴더 `/Users/parkjongsun/Documents/ChatGPT/메인 프로젝트`이며 실제 존재를 확인했다. 제품 checkout과 같다는 뜻은 아니고 아래 한정 예외를 적용한다.
- 사용자가 **이번 조사만** 기존 메인 프로젝트 폴더를 채팅 cwd로 유지하고 Repository 전용 worktree를 명시하는 예외를 승인했다. 채팅 cwd를 바꾸는 attach/create_worktree를 담당 세션에서 재호출하지 않는다. 과거 경로 경고를 재수리하지 않으며, 향후 기본 경로 설정 조사는 사용자가 이번 세션 시작을 먼저 요청하여 보류했다.
- 전용 web worktree를 생성 후 즉시 Git-aware move로 Repository 아래 이동했다. detached HEAD, 제품 tracked 변경 없음. eligible 로컬 env 6개를 불투명 복사·일치/ignore 확인했으며 의존성 설치·서버 실행은 하지 않았다.

## 조사 범위와 판정

- 주문 상세와 피드백 목록·상세에서 Good/Bad, Submit을 포함한 모든 피드백 관련 이벤트를 찾는다. 진입/조회/수정/첨부/설정 등 실제 코드의 관련 이벤트도 포함하되 없는 제품 기능을 있다고 가정하지 않는다.
- 치과·기공소 웹의 데스크톱/모바일 분기, 치과·기공소 앱의 네이티브 화면, 앱 주문 상세 WebView 및 웹↔네이티브 전환을 구분한다. Admin은 실제 피드백 이벤트 소비가 있으면 별도 표시한다.
- 이벤트 상수 선언뿐 아니라 화면 진입점→핸들러→mutation 성공/실패→tracking wrapper→SDK 호출까지 추적한다. 조건부 early return, 동일 선택 재클릭, 신규/수정, 중복 클릭·WebView/네이티브 이중 호출, platform/device/source 속성을 대조한다.
- 코드에서 호출 가능/호출 없음/조건부/중복 가능/해당 기능 없음/불명확을 구분하고 파일·줄 근거와 사용자 동작을 표로 제시한다. 실제 SDK 네트워크 전송·Amplitude 수집·운영 배포를 확인했다고 말하지 않는다.
- 현재 코드의 정책·이름·속성·호출 시점을 조사한다. 사양 근거 없이 클릭 이벤트를 성공 이벤트로 바꾸어 해석하거나 새로운 이벤트를 요구사항으로 만들지 않는다.

## 저장소와 조사 기준

- 웹: `/Users/parkjongsun/Repository/dentlink-client`; 조사 worktree `/Users/parkjongsun/Repository/dentlink-client-feedback-amplitude-audit`. Jira가 없고 조사 전용이므로 detached HEAD, 신규 제품 branch 불필요.
- 2026-11-25 main ref fetch 확인: web `origin/master=9084878eaa93ea4fe39df0f376afa4456c5fec55`, Office `origin/main=dd9fc9a2812b1eb98866b97a5f38451e1a546fd5`, Lab `origin/main=12cd290e4344065ac030f6a64696df4426a8b59c`. 이후 변화가 있으면 기준 시각·SHA를 분명히 기록한다.
- Office `/Users/parkjongsun/Repository/dentlink-app`, Lab `/Users/parkjongsun/Repository/dentlink-lab-app`은 다른 알림 후속 작업의 미커밋 변경이 있다. checkout/pull/reset/stash/install/수정 금지. 고정한 main SHA를 `git show`, `git grep <SHA>`로 읽어 다른 세션의 작업과 조사 기준을 섞지 않는다.
- 새 worktree의 eligible ignored/untracked `.env*`는 공통 지침에 따라 불투명 복사·동일성/ignore 확인한다. 이 조사에서 값 열람·변경·서버 실행은 필요 없다.

## 권한과 결과물

- 코드 읽기 전용. 브라우저·시뮬레이터·Metro·Reactotron·앱·API 호출·실제 이벤트 발송·의존성 설치·제품 코드/문서 변경·commit/push/PR/merge/배포·Jira 생성/수정·Notion 수정은 하지 않는다.
- 누락/중복을 발견해도 수정하지 말고 확인된 차이·영향·수정 필요 여부만 보고한다. 필요 시 사용자가 후속 구현을 승인한다.
- 상세 결과는 이 문서, 사용자 요약은 플랫폼/진입경로별 간단한 표. 기록은 Claude `project_feedback_amplitude_audit_20261125.md`에도 동기화한다.
- 참고: [피드백 기능 정본](dentlink-client-order-feedback.md), [기존 DL-17604 이벤트 조사](dentlink-amplitude-event-audit-dl17604.md). 기존 조사는 이벤트 존재 중심이며 이번 요청의 경로별 정확성 결론을 대신하지 않는다.
