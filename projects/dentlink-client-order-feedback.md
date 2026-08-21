# Dentlink 주문 피드백 수집 — DL-15828

이 문서는 치과 주문 피드백 수집 기능의 개인 체크포인트다. 다음 세션에서는 이
기록보다 live Git, Jira, Notion, Figma와 배포된 Swagger 상태를 우선한다. 기획
검토, 구현, 로컬 QA, 앱 검증, release 전달, 스테이징 QA와 배포를 구분한다.

## 범위와 자료

- 상위 Jira: [DL-15828](https://innovaid.atlassian.net/browse/DL-15828)
- 기획 문서:
  [Notion](https://app.notion.com/p/innovaid/3b1ce072e82f8105aec7e513995abc18)
- Figma:
  - [전체](https://www.figma.com/design/Lu8GEh1TUU5hOfj2FCPRYn/0101.-%EC%B9%98%EA%B3%BC--%EC%A3%BC%EB%AC%B8-%ED%94%BC%EB%93%9C%EB%B0%B1-%EC%88%98%EC%A7%91?node-id=60-9606&p=f&m=dev)
  - [마이페이지](https://www.figma.com/design/Lu8GEh1TUU5hOfj2FCPRYn/0101.-%EC%B9%98%EA%B3%BC--%EC%A3%BC%EB%AC%B8-%ED%94%BC%EB%93%9C%EB%B0%B1-%EC%88%98%EC%A7%91?node-id=160-38938&m=dev)
  - [피드백 목록·상세](https://www.figma.com/design/Lu8GEh1TUU5hOfj2FCPRYn/0101.-%EC%B9%98%EA%B3%BC--%EC%A3%BC%EB%AC%B8-%ED%94%BC%EB%93%9C%EB%B0%B1-%EC%88%98%EC%A7%91?node-id=160-40593&m=dev)
  - [주문 상세](https://www.figma.com/design/Lu8GEh1TUU5hOfj2FCPRYn/0101.-%EC%B9%98%EA%B3%BC--%EC%A3%BC%EB%AC%B8-%ED%94%BC%EB%93%9C%EB%B0%B1-%EC%88%98%EC%A7%91?node-id=160-38179&m=dev)
- 제품 범위: Clinic PC·모바일 웹과 Dentlink App의 주문 피드백 진입, 목록,
  작성·수정 및 주문 상세 연동
- 알림센터 구축과 ChannelTalk 중앙 진입점 대체는 2차 범위로 제외한다. 주문
  피드백 자체의 앱 알림 작업은 `DL-16066`에서 별도로 추적하되, 스펙 확정
  전까지 미산정 상태로 둔다.

## 현재 체크포인트 — 2026-08-20

- 전용 worktree:
  `/Users/parkjongsun/Repository/dentlink-client-order-feedback`
- branch: `feature/DL-15828`
- base/current HEAD:
  `origin/master` / `9b57bec96be7b8f63c48ef4fb67ff46fbe2d2928`
  (`Release/v1.83.0 (#4507)`)
- worktree: clean
- upstream: 없음. 빈 feature branch는 아직 원격에 push하지 않았다.
- `pnpm install --frozen-lockfile`과 Husky 설치를 완료했다.
- 설치는 성공했으며 `shared/configs`와 `shared/models`의 순환 workspace 의존성과
  optional `canvas@2.11.2` 설치 생략 경고만 있었다.
- 제품 코드 수정, project commit/push, PR, 신규 구현 세션은 아직 없다.

## 준비 상태와 재개 기준 — 2026-08-21

이 기능은 아직 기획·디자인·BE 계약이 함께 변하는 중이다. 아래 상태는 확정
스펙이 아니라 작업을 안전하게 시작하고 중단·재개하기 위한 체크포인트다. 새
세션에서는 반드시 live 자료를 다시 확인하고 차이를 먼저 보고한다.

### 준비 완료

- 개인 컨텍스트와 이 프로젝트 체크포인트를 원격에서 복구할 수 있다.
- Jira 상위 카드와 FE 하위 카드의 최신 본문·완료 조건·의존성을 직접 읽을 수
  있다.
- Notion `[치과] 주문 피드백 수집` 기획 문서에 접근할 수 있다.
- Figma 파일과 다음 기준 노드에 접근할 수 있다.
  - `60:9606` 디자인 전체
  - `160:38938` 마이페이지
  - `160:40593` Pending Reviews 목록·상세
  - `160:38179` 주문상세 앱·웹
- 제품 worktree는 `feature/DL-15828`이며 `HEAD 9b57bec96`에서 clean이다.
  2026-08-21 확인 당시 `origin/master`와 ahead/behind `0/0`이고, `node_modules`와
  Husky pre-commit이 준비되어 있다.

### 변경 가능 또는 미완성

- Notion 기획 문서는 `작성 중`이다. 문서에 반영되지 않았거나 이후 변경될
  정책이 있을 수 있으므로 구현 계약으로 단독 확정하지 않는다.
- Figma는 접근 가능하지만 변경될 수 있다. 2026-08-20 오후 논의된 파일 업로드
  등 아직 디자인에 반영되지 않은 항목은 현재 FE 5.5점과 구현 범위에서 제외한다.
- BE는 작업 중이며 DTO, eligibility, pagination, count, category/reason 계약이
  확정되지 않았다.
- 관리자 `DL-16065`와 앱 알림 `DL-16066`은 추적 카드만 준비된 상태다. 관리자는
  0.5점 임시 산정, 앱 알림은 미산정이며 스펙 확정 후 다시 산정한다.
- App 저장소, 실행·빌드·기기 검증 환경과 WebView/native 책임은 `DL-16064`에서
  먼저 확인해야 한다.

### 현재 안전하게 시작 가능한 범위

- 최신 Figma를 기준으로 한 화면 구조 분석과 표현 UI 작업은 시작할 수 있다.
- API가 필요한 UI는 기존 프로젝트 경계를 따르는 fixture/mock 또는 교체 가능한
  view-model 경계 안에서만 진행하고, endpoint·DTO·eligibility를 추측하지 않는다.
- 디자인 변경 가능성을 전제로 UI와 서버 상태 로직을 결합하지 않고, 변경 시
  교체하기 쉬운 단위로 제한한다.
- 공통 API/query/mutation/cache 실제 연동, 서버 조건 기반 동작, 관리자, 앱
  native·알림, 파일 업로드는 계약 또는 스펙 확인 전 시작하지 않는다.

### 매 세션 시작 절차

1. `codex-personal-context`를 `git pull --ff-only`하고 이 문서를 읽는다.
2. 제품 worktree에서 `git fetch --all --prune`, `git status -sb`, `git log -1
   --oneline`, `git branch -vv`, `git diff --stat`, `git rev-parse origin/master`를
   확인한다.
3. Jira `DL-15828`과 관련 FE 카드, Notion, Figma 기준 노드, 배포 Swagger를 live로
   다시 읽는다.
4. 이전 체크포인트와의 차이를 `준비 완료 / 변경됨 / 대기 / 확인 불가`로 나눠
   먼저 보고하고, 그 시점에 안전한 최대 작업 범위를 제시한다.
5. Swagger에 주문 피드백 계약이 생겼다면 generated model을 재생성해 diff를
   검토한다. 계약이 없다면 endpoint나 DTO를 만들지 않는다.
6. 구현 순서는 원칙적으로 `DL-16063` 이후 웹 카드이며, API 대기 중에는 현재
   디자인 기반 UI만 별도 경계에서 진행한다. 앱은 `DL-16064`가 먼저다.

### 중단·재개 기록 규칙

- 중단 시 제품 branch/HEAD, dirty 여부와 변경 파일, 완료한 검사, 사용자 QA와 앱
  QA, 확인한 Jira·Notion·Figma·Swagger 시점, 남은 불확실성, 다음 안전한 시작점을
  이 문서에 기록한다.
- 기획·디자인·BE 변경은 이전 구현이 틀렸다는 의미가 아니라 새 계약으로
  reconcile해야 하는 입력으로 취급한다.
- 개인 체크포인트는 이 저장소에 commit/push해 복구 가능하게 유지한다. shared
  제품 저장소의 commit/push/PR은 사용자의 명시 지시가 있을 때만 수행한다.

## FE Jira 구조와 스토리포인트

Dentlink의 시간 기반 산정인 `1 point = 6 planned work hours`를 적용한다.

- [DL-15830](https://innovaid.atlassian.net/browse/DL-15830)
  `[FE] 개발 플래닝`: 0.5
- [DL-16063](https://innovaid.atlassian.net/browse/DL-16063)
  `[FE] 주문 피드백 공통 API 및 상태 관리 기반 작업`: 1
- [DL-16056](https://innovaid.atlassian.net/browse/DL-16056)
  `[FE] 마이페이지 Quick Links 및 리뷰 진입점 작업`: 0.5
- [DL-16057](https://innovaid.atlassian.net/browse/DL-16057)
  `[FE] 피드백 목록 페이지 작업`: 1
- [DL-16058](https://innovaid.atlassian.net/browse/DL-16058)
  `[FE] 피드백 상세 입력·수정 작업`: 1.5
- [DL-16060](https://innovaid.atlassian.net/browse/DL-16060)
  `[FE] 주문 상세 피드백 영역 작업`: 0.5
- [DL-16064](https://innovaid.atlassian.net/browse/DL-16064)
  `[FE] 앱 피드백 개발환경 및 WebView/native 연동 범위 검증`: 미산정
- [DL-16061](https://innovaid.atlassian.net/browse/DL-16061)
  `[FE] 앱 피드백 화면 및 native 연동 구현`: 미산정
- [DL-16065](https://innovaid.atlassian.net/browse/DL-16065)
  `[FE] 관리자 주문 피드백 기능 작업`: 0.5 임시 산정
- [DL-16066](https://innovaid.atlassian.net/browse/DL-16066)
  `[FE] 앱 주문 피드백 알림 작업`: 미산정

앱을 제외한 현재 합계는 플래닝과 관리자 임시 산정을 포함해 5.5 points다. 앱
기술 검증, 앱 화면/native 구현, 앱 알림 3개 카드는 작업 추적 범위에 포함하지만
스토리포인트 합계에서는 제외한다. 관리자의 0.5점도 스펙 확정 전 임시값이다.

## 확인된 제품 정책

- 피드백 단위는 주문이며 Good / Bad 선택만으로 응답 완료 처리한다.
- 상세 사유와 자유서술은 추가 입력이며 등록 후에도 수정할 수 있다.
- 삭제는 지원하지 않는다.
- 배포 이후 원주문이 최초 COMPLETED된 경우만 대상이다.
- 피드백 목록에서는 주문 상태가 이후 변경되어도 계속 조회·수정할 수 있다.
- 주문 상세 유도 영역은 현재 주문 상태가 COMPLETED인 동안만 노출한다.
- 담당 의사가 변경되면 담당 의사별 피드백을 구분한다.
- 사용자 노출 문구는 영어다.
- 웹과 앱은 동일한 서버 데이터와 공통 query/cache 규칙을 사용한다.

## 구현 전 남은 확인

- 목록 정렬 기준
- Bad 선택 후 상세 화면 자동 진입 여부
- 상세 사유가 완전 선택 사항인지 여부
- Figma의 상품별 사유와 Notion의 Shade / Fit / Material / Other 사이 최종 계약
- BE DTO, eligibility, pagination, count, category/reason 계약
- App 저장소와 실행·빌드·디바이스 검증 환경
- Clinic WebView와 native app의 화면, navigation, back, safe-area, deep-link 책임
- 관리자 화면·권한·API·검증 범위
- 앱 피드백 알림의 발송 조건, 대상, 문구, deep link, BE/FCM/native 책임
- 파일 업로드를 포함한 2026-08-20 오후 추가 논의의 최종 기획·디자인 범위
- 현재 `origin/master` generated model에는 주문 피드백 API contract가 없으므로
  구현 시작 시 배포된 Swagger를 재확인해야 한다.

## 다음 시작점

1. 신규 Codex 프로젝트/세션을
   `/Users/parkjongsun/Repository/dentlink-client-order-feedback`에 연결한다.
2. 개인 컨텍스트를 pull하고 이 문서와 live Git/Jira/Notion/Figma를 reconcile한다.
3. `git fetch --all --prune`, `git status -sb`, HEAD와 `origin/master` 차이를 확인한다.
4. 배포된 Swagger와 BE 계약을 확인한 뒤 DL-16063 공통 데이터 기반부터 시작한다.
5. DL-16056, DL-16057, DL-16058, DL-16060 순서와 의존성을 실제 코드 구조에
   맞게 조정하며 웹 범위를 구현한다.
6. 앱 구현 전에 DL-16064로 앱 환경과 WebView/native 책임을 확인하고, 그 결과로
   DL-16061의 범위와 스토리포인트를 확정한다.
7. shared 저장소의 commit, push, PR은 사용자의 명시 지시가 있을 때만 수행한다.
