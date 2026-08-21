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

## 준비 당시 체크포인트 — 2026-08-20

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

## 현재 구현 체크포인트 — 2026-08-21

- product branch/HEAD:
  `feature/DL-15828` / `0e35c3f714c07f3c731a722d997a0b05d53214ce`
  (`[DL-15828] feat: 주문 피드백 웹 화면 구현`)
- upstream: `origin/feature/DL-15828`; 로컬 HEAD와 원격 ref가 동일하다.
- worktree: commit과 push 후 clean이다.
- PR은 생성하지 않았다.
- 최신 `origin/master`는 준비 당시와 동일한 `9b57bec96`였으며, 기능 commit은 그
  기준으로 생성했다.

### 구현 완료 범위

- Clinic 마이페이지를 최신 Figma 구조로 맞추고 `Quick Links`에
  `Pending Reviews (count)`와 `My Office` 진입점을 추가했다. 기존 My Office
  목록은 삭제하지 않고 모달로 전환했다.
- 신규 경로는 `/my/feedback`이다. PC 500px 목록과 페이지네이션, 모바일
  무한스크롤 구조, To Review/Reviewed count, loading/empty/error, Good/Bad 빠른
  평가와 상세 진입 상태를 구현했다.
- 상세 화면은 PC 550px side drawer와 모바일 full-screen 구조를 공용 컴포넌트로
  구현했다. rating은 필수이고 keyword/comment는 현재 fixture 계약상 선택이며,
  500자 제한과 동적 `isRequired` 제출 조건을 반영했다.
- 주문 상세에는 eligibility 계약 전 개발용 preview 경계 안에서 피드백 배너를
  추가했다. 모바일은 주문 정보와 탭 사이, PC는 오른쪽 패널 최상단이며 기존
  LinkTalk/summary와 20px 간격을 유지한다.
- API 계약 전 내부 `FeedbackItem` view-model, fixture, mock repository,
  React Query query/mutation/cache invalidation을 분리했다. 배포 contract가 생기면
  generated DTO를 adapter 입력으로 교체하고 화면 컴포넌트는 유지하는 구조다.
- 사용자가 전달한 BE 질문 기본 구조를 fixture에 반영했다: `RATING`, `KEYWORD`,
  `COMMENT`, PRODUCT category별 keyword mapping, SERVICE의 `isShippable` 조건과
  comment placeholder다.
- Figma asset을 `clinic/public/images/feedback`에 저장해 배너와 상품 artwork에
  사용했다. 서버가 상품 이미지 식별자를 제공하지 않아 목록 카드별 서로 다른
  artwork는 아직 공통 artwork로 표시한다.
- 테스트 파일은 요청에 따라 추가하지 않았다.

### 2026-08-21 live 자료 확인

- Jira `DL-15828`, `DL-16056`, `DL-16057`, `DL-16058`, `DL-16060`,
  `DL-16063`, `DL-16064`, `DL-16061`, `DL-16065`, `DL-16066`의 최신 본문과
  상태를 다시 읽었다.
- Notion `[치과] 주문 피드백 수집`은 여전히 `작성 중`이며 마지막 수정 시각은
  `2026-08-20T07:57:13.912Z`였다. 2026-08-20 회의 문서에는 피드백 사진 첨부와
  관리자 입력 관련 추가 논의가 있으나 최종 기획·디자인·계약은 없다.
- Figma의 마이페이지 `160:38939`, 모바일 목록·상태 `160:41324`,
  `160:42078`, `160:42101`, 상세 `160:41979`, PC drawer `160:40708`, 주문 상세
  annotation `160:63485`와 관련 sibling 상태를 다시 조회했다.
- `https://dev-api.dentlink.io/v3/api-docs`를 직접 확인했지만 주문 feedback/review/
  rating/question endpoint와 schema는 없었다. 현재 generated model에도 주문
  피드백 API/DTO가 없다. endpoint와 DTO는 추측하지 않았다.

### 구현·QA 결과

- `pnpm type`: 통과
- `pnpm build:clinic`: 통과; `/my/feedback` route 포함을 확인했다.
- 변경 Clinic 파일 대상 ESLint: 0 errors. 주문 상세 파일의 기존 hook dependency와
  unused `style` warning 2건만 남았다.
- Prettier check와 `git diff --check`: 통과. Prettier의 기존 unknown option warning은
  결과에 영향이 없었다.
- Admin type: 통과. pre-push 전체 Clinic/Lab/Admin lint는 0 errors이고 기존 warning만
  보고했다.
- pre-push shared coverage test: config 3건, hooks 24건 모두 통과했다. 다만 이
  worktree에는 coverage baseline이 없어 마지막 coverage diff gate는 실행 완료로
  판정되지 않았다.
- Husky pre-commit의 Clinic type은 통과했으나 Lab type은 `origin/master`와 동일한
  `BrowserPDFHeaderUI.tsx`의 PNG module resolution 오류로 중단됐다. 관련 파일과
  PNG는 이번 commit에 포함되지 않으며 Admin type은 별도로 통과했다. 이 기존
  기준선과 coverage baseline 부재만 제외하고 commit/push했다.
- 로그인된 로컬 Chrome에서 PC·모바일 목록, 빠른 Good 저장 후 To Review 유지와
  `Tell Us Why`, 상세 저장 후 Reviewed 이동·count 변경, 두 success toast, empty와
  error/retry를 확인했다.
- PC drawer width 550px, 모바일 drawer 전체 폭, 고정 footer 102px와 submit button
  52px를 확인했다. 브라우저의 최소 모바일 viewport는 500x1083이어서 375px 실기기
  폭 자체는 확인하지 못했지만 동일 maxTablet 레이아웃과 정확한 footer 수치는
  확인했다.
- 마이페이지 Quick Links와 My Office 모달, 주문 상세 배너의 PC 오른쪽 패널 및
  모바일 주문 정보 아래 배치를 실제 화면에서 확인했다. 사용자가 앞선 QA에서
  교정 후 마이페이지와 주문 상세 반영 상태도 확인했다.

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
- 제품 worktree는 `feature/DL-15828`이며 `HEAD 0e35c3f71`에서 clean이다.
  `origin/feature/DL-15828`을 upstream으로 추적하며 로컬·원격 HEAD가 동일하다.
  `node_modules`와 Husky가 준비되어 있다.

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

### 현재 안전하게 이어갈 수 있는 범위

- 최신 Figma를 기준으로 한 웹 표현 UI 1차 구현은 완료했다. 디자인이 변경되면
  현재 컴포넌트 경계를 유지하며 확정된 차이만 반영할 수 있다.
- API가 필요한 UI는 기존 프로젝트 경계를 따르는 fixture/mock 또는 교체 가능한
  view-model 경계 안에서만 진행하고, endpoint·DTO·eligibility를 추측하지 않는다.
- 디자인 변경 가능성을 전제로 UI와 서버 상태 로직을 결합하지 않고, 변경 시
  교체하기 쉬운 단위로 제한한다.
- 공통 API/query/mutation/cache 실제 연동, 서버 조건 기반 동작, 관리자, 앱
  native·알림, 파일 업로드는 계약 또는 스펙 확인 전 시작하지 않는다.

### 퍼블리싱 구현 원칙 — 2026-08-21 확인

- 퍼블리싱의 기준은 Codex의 취향이나 더 좋아 보이는 UX가 아니라 최신 Figma의
  대상 노드, sibling variant, annotation/comment와 기존 Clinic 운영 패턴이다.
- Figma에 없는 영역, 문구, 상태, hover/animation, 반응형 재배치, 여백·장식은
  임의로 추가하거나 보완하지 않는다. 필요한데 디자인에 없으면 미확정으로
  분리하고 사용자에게 확인한다.
- Figma와 기존 공용 컴포넌트가 모두 적용 가능한 경우 공용 컴포넌트를 사용하되,
  공용 컴포넌트의 기본 형태 때문에 디자인 의미나 상태가 달라지게 만들지 않는다.
  차이가 있으면 사용 조합 또는 기본 동작을 보존하는 최소 선택적 prop으로 해결한다.
- 디자인상 확정된 것, 기존 프로젝트 관례로 적용한 것, 아직 임시로 둔 것을 구현과
  보고에서 구분한다. 임시 판단을 디자인 확정값처럼 표현하지 않는다.
- 대표 화면 하나만 맞추지 않고 PC·모바일, To Review·Reviewed, Good·Bad,
  empty/loading/error, Drawer 열림·닫힘과 scrolling/portal stacking까지 관련 상태를
  확인한다.
- 실제 브라우저를 Figma와 비교해 시각 QA를 진행한다. 사용자 QA에서 수정된
  퍼블리싱 결과는 이후 정리·반응형 수정·리팩터링에서 임의로 되돌리지 않는 보호된
  기준으로 취급한다.
- 구현 중 새로 확정된 디자인 결정과 사용자 QA 교정은 이 프로젝트 체크포인트에
  지속적으로 기록한다. 단순 CSS 시행착오가 아니라 다음 세션에서도 지켜야 할
  결정과 기준만 선별해 남긴다.

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

## 현재 남은 확인과 대기 항목

- 목록 정렬 기준
- Bad 선택 후 상세 화면 자동 진입 여부
- 상세 사유가 완전 선택 사항인지 여부
- Figma annotation은 빠른 평가 후 화면을 이탈하기 전까지 To Review에 유지하도록
  표현하지만 Jira `DL-16057`은 저장 직후 Reviewed 반영으로 적혀 있다. 현재 UI는
  Figma 동작을 따르며 최종 정책 확인이 필요하다.
- Figma의 상품별 사유와 Notion의 Shade / Fit / Material / Other 사이 최종 계약
- BE DTO, eligibility, pagination, count, category/reason 계약
- 서버가 목록/주문별 상품 artwork 또는 이를 식별할 category/product 정보를 어떤
  필드로 제공할지
- App 저장소와 실행·빌드·디바이스 검증 환경
- Clinic WebView와 native app의 화면, navigation, back, safe-area, deep-link 책임
- 관리자 화면·권한·API·검증 범위
- 앱 피드백 알림의 발송 조건, 대상, 문구, deep link, BE/FCM/native 책임
- 파일 업로드를 포함한 2026-08-20 오후 추가 논의의 최종 기획·디자인 범위
- analytics event 명칭과 payload. Jira에는 telemetry 요구가 있으나 계약이 없어
  이벤트를 추측해 추가하지 않았다.
- 2026-08-21 배포 Swagger와 generated model에는 주문 피드백 API contract가
  없으므로 실제 연동 시작 시 다시 확인해야 한다.

## 다음 시작점

1. 신규 Codex 프로젝트/세션을
   `/Users/parkjongsun/Repository/dentlink-client-order-feedback`에 연결한다.
2. 개인 컨텍스트를 pull하고 이 문서와 live Git/Jira/Notion/Figma를 reconcile한다.
3. `git fetch --all --prune`, `git status -sb`, HEAD와 `origin/master` 차이를 확인한다.
4. 배포된 Swagger와 BE 계약을 확인하고, contract가 생기면 generated model을
   재생성·diff review한 뒤 `feedback.mockRepository`를 실제 repository/adapter로
   교체한다.
5. 최신 기획·Figma 변경을 다시 대조해 빠른 평가 이동 시점, 사유 계약, 상품별
   artwork, 사진 업로드, analytics를 확정한다. 현재 UI를 기준으로 API pagination,
   count, eligibility와 error handling을 연결하고 PC·모바일 회귀 QA를 수행한다.
6. 앱 구현 전에 DL-16064로 앱 환경과 WebView/native 책임을 확인하고, 그 결과로
   DL-16061의 범위와 스토리포인트를 확정한다.
7. shared 저장소의 commit, push, PR은 사용자의 명시 지시가 있을 때만 수행한다.
