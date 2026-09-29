# Dentlink 권한관리 — DL-16317

## 현재 상태 — 2026-09-29 복구 체크포인트

- 목적: 통합알림센터에 앞서 진행할 [DL-16317 권한관리](https://innovaid.atlassian.net/browse/DL-16317)를 담당한다.
  FE 전체 조율은 [dentlink-fe.md](dentlink-fe.md), 통합알림센터의 별도 기록은
  [dentlink-unified-notification-center.md](dentlink-unified-notification-center.md)다.
- **완료:** 세션 초기 설정과 공통 지침 읽기. 이후 사용자의 별도 요청으로
  백엔드가 확인을 요청한 Office API 4개의 웹·앱 사용처를 정적으로 조사해 답변했다.
  초기 설정만 했다는 이전 기록은 이 API 조사 진행 상황을 포함하지 않는다.
- **대기:** 요청받은 API 조사 답변까지 완료했으며 진행 중인 구현이나 테스트는 없다.
  기존 세션을 유지하고 추가 API 조사 또는 권한관리 착수 지시를 기다린다.
- **미착수:** 권한관리 본 요구사항 분석·설계·구현. Jira 본문·댓글·관련 외부 자료는
  아직 조회하지 않았다. 웹·앱 영향, 권한 정책과 API 계약, 구현 branch/worktree,
  base와 배포 release는 미정이다. 이 세션의 제품 PR·merge·배포 작업도 없다.
- 승인 범위는 초기 설정, 사용자 지정 API의 읽기 전용 코드 조사와 이번 개인
  체크포인트 정리·commit·push다. API 조사 결과를 코드/API 삭제 승인이나
  권한관리 구현 지시로 해석하지 않는다. 통합알림센터 정책도 전용 요구사항으로
  추정하지 않는다. 제품 수정·commit·push·PR 변경·배포는 별도 명시 지시가 필요하다.

### API 사용처 조사 결과 — 2026-09-28

| GET API | 웹 Clinic/Lab/Admin 조사 결과 | 모바일 앱 조사 결과 |
| --- | --- | --- |
| `/office/orders/status-count` | 생성된 API·타입 정의만 있고 실제 호출부 없음 | 생성된 API·타입 정의만 있고 실제 호출부 없음 |
| `/office/orders/pending-summary` | 생성된 API·타입 정의만 있고 실제 호출부 없음 | Office 홈의 **Action Required**에서 사용 |
| `/office/orders/drafts` | 새 주문 작성(`/orders/create`)의 **Draft 목록·작성 이어하기**에서 사용 | Office **Place Order → Draft 선택 화면**에서 사용 |
| `/office/order-chats` | 생성된 API·타입 정의만 있고 실제 호출부 없음 | 서비스·쿼리 훅은 남아 있으나 그 훅을 사용하는 화면이 없어 실제 사용처 없음 |

조사 당시의 제품 코드와 비교 브랜치를 기준으로 한 결론이다. 운영 요청 로그,
실기기·브라우저 실행, 배포 버전별 사용량은 확인하지 않았다. API가 정의되어 있다는
사실과 실행되는 화면에서 호출된다는 사실을 구분했으며, 이 결과만으로 구버전 앱이나
다른 소비자까지 포함한 백엔드 API 삭제 가능 여부를 확정하지 않는다.

복구 시 확인할 코드 근거(줄 번호는 당시 snapshot 기준):

- `status-count`: 웹 `shared/models/src/Office.ts:4637`, 앱
  `shared/models/Api.ts:43758`에 정의만 존재했다. `/lab/orders/status-count`와
  `/admin/orders/status-count`는 별도 API이므로 이 결론에 포함하지 않는다.
- `pending-summary`: 앱 `shared/services/serviceTypeService.ts:186`의
  `getPendingSummary`가 `/${serviceType.toLowerCase()}/orders/pending-summary`를 호출한다.
  `shared/queries/useCommonServiceQueries.ts:57` →
  [useHomeOrdersData.ts:106](https://github.com/Innvoaid/dentlink-app/blob/7403721151f3d2135799a995bccdd2214783822d/shared/libs/useHomeOrdersData.ts#L106)의
  `enabled: serviceType === "OFFICE"` →
  `apps/office/src/features/home/sections/HomeOfficeActionRequiredSection.tsx:74,166`으로 이어진다.
  `pending/planning/design`을 각각 최대 10개 추려 Pending Order / Planning Approval /
  Design Confirmation 카드에 표시하며 홈 진입·당겨서 새로고침 경로가 있다.
- `drafts` 웹: `shared/models/src/order/order.apis.clinic.ts:289`의 `findDraftOrders`
  → `clinic/src/services/order/order.query.ts:38`의 `useOrderDraftQuery`
  → [OrderProfileCreate.tsx:34](https://github.com/Innvoaid/dentlink-client/blob/347909945b091324e7134673525203de14e122fd/clinic/src/components/Order/OrderProfileForm/OrderProfileCreate.tsx#L34).
  새 주문 폼이 렌더링되면 조회를 활성화하고 응답을 `draftProps.list`에 전달한다.
  Draft 삭제 성공 후 목록을 재조회한다.
- `drafts` 앱: `shared/services/office.service.ts:200`의 `findDraftOrders`
  → `shared/queries/useOfficeQueries.ts:186`의 `useOfficeDraftOrdersQuery`
  → [OrderScreen.tsx:146](https://github.com/Innvoaid/dentlink-app/blob/7403721151f3d2135799a995bccdd2214783822d/shared/features/order/screens/OrderScreen.tsx#L146).
  Office 조건으로 조회하며 Insta Smile Vision 항목을 제외한 Draft 목록으로
  선택·작성 이어하기·삭제 화면을 구성한다. 삭제·주문 제출 후 쿼리 갱신 경로가 있다.
- `order-chats` 앱: `shared/services/linktalk.service.ts:220`의 `findOrderChats`
  → [useLinkTalkQueries.ts:74](https://github.com/Innvoaid/dentlink-app/blob/7403721151f3d2135799a995bccdd2214783822d/shared/queries/useLinkTalkQueries.ts#L74)의
  `useFindOrderChatsInfiniteQuery`까지만 존재하며 이를 import/호출하는 화면은 없었다.
  실제 웹 홈 LinkTalk·앱 LinkTalk 목록은 `/office/chats/latest`를 사용했다.
  웹 근거는 `clinic/src/lib/Dashboard/useDashboardLinkTalk.ts:26`,
  앱 근거는 `shared/features/linkTalk/sections/LinkTalkListSection.tsx`의
  `useGetLatestChatInfiniteQuery` 연결과 `shared/services/serviceTypeService.ts:167`이다.

조사 snapshot:

- 웹 기본 checkout: `feature/DL-16387`,
  `347909945b091324e7134673525203de14e122fd`. 읽기 전용 조사에 사용했으며 LBX의
  작업 브랜치를 권한관리 소유로 가져온 것이 아니다.
- 웹 비교 ref: `origin/master / de2ffdd9e`, `origin/release/v1.87.0 / bb5bff410`,
  `origin/stage / bf955dfe2`, `origin/develop / 1d0140ca3`에서 같은 결론을 확인했다.
- 앱: `main / 7403721151f3d2135799a995bccdd2214783822d`,
  `origin/develop / 589286ad58ad22752d5bcd82f46dcd48a817d89d`에서 같은 결론을 확인했다.
- 조사 시작 시 두 제품에 `git pull --ff-only`를 실행했고 당시 checkout은 변경 없이
  최신이었다. 이후 코드·branch·worktree·PR·Jira 변경, 실제 API 요청, 테스트·서버
  실행은 하지 않았다. 위 답변은 사용자에게 전달했으며 백엔드에 직접 메시지를
  보내거나 Jira에 게시하지 않았다.

### 제품 경계와 Git 확인 — 2026-09-29

이번에는 `status`, HEAD/upstream, 등록 worktree, `ls-remote`만 읽었으며 제품
fetch/pull/checkout은 하지 않았다. 아래 값은 확인 시점의 상태이며, API 분석을
오늘 원격 HEAD에서 다시 수행했다는 뜻이 아니다.

| 저장소·로컬 조사 경로 | 로컬 branch / HEAD / upstream | 작업 상태·원격 확인 |
| --- | --- | --- |
| [dentlink-client](https://github.com/Innvoaid/dentlink-client), `/Users/parkjongsun/Repository/dentlink-client` | `feature/DL-16387` / `347909945b091324e7134673525203de14e122fd` / `origin/feature/DL-16387` | clean, 추적 ref 대비 0/0. `ls-remote`의 동일 branch SHA도 일치해 원격 보존 확인 |
| [dentlink-app](https://github.com/Innvoaid/dentlink-app), `/Users/parkjongsun/Repository/dentlink-app` | `main` / `7403721151f3d2135799a995bccdd2214783822d` / `origin/main` | clean, **로컬 추적 ref** 대비 0/0. 실제 원격 main/develop은 아래와 같이 변경됨 |

- 이 세션이 생성하거나 소유한 권한관리 제품 branch/worktree와 미커밋 코드는 없다.
  웹에는 기본 checkout 및 다른 기능의 `dentlink-client-dlds` worktree가 등록돼 있고,
  앱에는 기본 checkout 하나가 있다. 기존 체크아웃의 소유권은 별도로 확인해야 한다.
- 웹 실시간 원격: `master / 9bed1f7bd753e229478302413c0ec9a7e7a11dc2`,
  `release/v1.87.0 / 8a612494737db71c93e1e25a9cd8e3a9c337f2e8`로 조사 당시와 다르다.
  `stage / bf955dfe2ee0dfbe8a41e9a51da354c5149e0c85`,
  `develop / 1d0140ca3b0af345f742bb9fdd2ab8d54e38b1da`는 당시와 같다.
- 앱 실시간 원격 `main`과 `develop`은 모두
  `a681df51e3864f37720b1f2178c939cfe734fdf4`다. fetch하지 않았으므로 현재 원격 대비
  ahead/behind 수와 이전 조사 commit의 최신 원격 이력 포함 여부는 미검증이다.
  로컬 추적 ref의 0/0을 최신 원격과 동기화됐다는 의미로 쓰지 않는다.
- 앞으로 현재 버전의 API 사용 여부를 판단할 때는 허용된 범위에서 제품 Git을 갱신하고
  달라진 코드를 대조한다. 다른 기능 브랜치를 임의 전환하거나 재사용하지 않는다.

## 새 디바이스 복구와 다음 시작점

1. `https://github.com/jongsunP/codex-personal-context`를 clone하거나 기존 사본에서
   `git pull --ff-only` 후 공통 지침과 이 문서를 읽는다. 이 파일이 작업 상태의 정본이다.
   새 기기의 첫 대화에도 본 기능은 **API 사용처 조사 완료 / 권한관리 본 작업 미착수·대기**로 복구한다.
2. 추가 API 조사 지시라면 위 두 제품 저장소를 별도로 준비하고, 해당 기기의 정확한
   경로·branch·HEAD·upstream·dirty·worktree 소유권을 확인한다. 현재 분석은 위 snapshot으로
   재현할 수 있으나, 최신 원격에서는 코드가 달라졌을 수 있다. `feature/DL-16387`을
   권한관리 구현 브랜치로 자동 선택하지 않는다. 권한관리 전용 복구 branch는 아직 없다.
3. 권한관리 본 작업 착수 지시가 오면 개인 컨텍스트와 해당 제품 Git을 갱신하고
   DL-16317 및 관련 요구사항·댓글·API·코드를 확인한다. 웹·앱 영향과 미정 정책을
   정리한 뒤 실제 작업 checkout·단일 작성 세션 소유권·base·branch·release를 결정한다.
   범위 확인과 구현·제품 Git 변경 승인을 구분한다.
4. 정적 코드 조사에는 저장소 접근 권한과 Git/검색 도구가 필요하다. 실행 검증을
   새로 요청받으면 각 저장소의 README/지침에 따라 Node·웹 pnpm·앱 Yarn 및 필요한
   네이티브 도구·의존성·환경파일·테스트 계정/로그인·Jira/Figma 등 연결 인증을 해당
   기기에서 확인한다. 이 세션은 런타임 환경·서버·테스트 계정을 준비하거나 검증하지 않았다.
   Git checkpoint가 설치 파일·환경변수·인증 세션을 이전해 주지는 않는다.
5. 진행 중인 수정이나 재개를 막는 확인된 기술 장애는 없다. 남은 조건은 사용자의
   다음 업무 지시와, 실제 착수 시 요구사항·작업 위치 결정이다. 운영 트래픽과
   9/29 변경된 원격 코드에서의 사용 여부는 필요시 별도로 확인해야 한다.

### 이 기기의 세션 폴더와 로컬 자료

- 2026-09-29 실경로 확인: `/Users/parkjongsun/Documents/ChatGPT/권한관리 프로젝트`.
  제품 checkout이 아닌 세션 컨텍스트 폴더다. 옛 `권한관리 프로젝트 폴더 2`는 없다.
  기존 task에 옛 cwd가 남을 수 있으므로 모든 명령에 존재하는 절대 workdir을 명시한다.
- 폴더에는 `.git`과 `START_PROMPT.md`가 있다. 일반 작업 branch에는 commit이 없고
  remote도 없으며 안내문은 untracked다. **이 안내문은 이 기기에만 있다.**
  원본 파일 자체가 필요하면 별도 보존해야 한다. 초기 범위·제품 경계·대기 조건은
  이 원격 체크포인트에 정리했으므로 업무 상태 복구가 안내문 원본에 의존하지는 않는다.
  이번 작업에서 안내문이나 폴더를 수정·commit하지 않았다.
- 기존 task는 **권한관리세션** `01a0e6fa-384c-7671-abb8-53d33c42c738`, 프로젝트 ID는
  `52bd24fb-ff53-41fb-a9df-f074b3e608ec`다. 앱 표시 이름 **권한관리 프로젝트 폴더**와
  위 실제 디바이스 경로는 별개다. ID는 기존 기기에서의 연결 참고값이다.
- 이 문서는 요약 체크포인트이며 대화 전체 백업·앱 프로젝트 자동 생성·기존 세션의
  타 기기 자동 이전을 보장하지 않는다. 중요한 미푸시 제품 코드나 조사 산출물은
  이 세션에서 만들지 않았다. 기존 세션을 종료·보관하거나 중복 세션을 만들지 않는다.

## 이력 — 2026-09-28 초기 설정 및 폴더 이동

- 사용자는 통합알림센터의 선행 작업으로 권한관리를 준비하도록 요청했고,
  최초에는 프로젝트·세션 초기 설정과 공통 지침 읽기까지만 승인했다.
  `권한관리 초기 설정`이라는 task로 시작 프롬프트를 전달받아 초기화 후 대기했다.
  그 뒤 별도 API 사용처 조사 요청이 추가됐으며 결과는 최상단에 정리했다.
- 최초 숫자 없는 `권한관리 프로젝트 폴더`는 안내문 이동 후 빈 상태에서 제거됐고,
  미등록·미사용 `권한관리 프로젝트 폴더 3`도 사용자 파일·작업 commit·원격이 없는
  빈 Git임을 확인한 뒤 메인세션에서 삭제했다. 당시 등록된 `권한관리 프로젝트 폴더 2`를 유지했다.
- 이후 사용자가 디바이스 폴더와 앱 연결을 `권한관리 프로젝트`로 수동 변경했다.
  메인세션은 연결 경로 일치를 확인하고 `START_PROMPT.md`의 경로를 갱신했다.
  프로젝트 경로 변경이 기존 task의 기록된 cwd까지 갱신한 것은 아니다.
- 2026-09-29 메인세션을 통해 새 기기 복구용 개인 기록 정리와 해당 파일의
  commit·push를 승인받았다. 제품 조사·구현을 재개하지 않고 Git·폴더 상태만 대조해
  이 문서를 갱신한다. 공통 색인은 메인세션이 별도로 취합한다.
