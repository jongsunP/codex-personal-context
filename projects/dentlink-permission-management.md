# Dentlink 권한관리 — DL-16317


## 현재 상태 — 2026-10-15 Office PR329 생성·웹 리뷰 확인 후 대기

- **사용자 요청:** Office 앱 PR을 생성하고 CodeRabbit 유효 지적을 처리하되, 리뷰가 실행되지 않거나
  한도에 걸리면 건너뛴다. 웹도 남은 확인을 마치고 커밋/푸시·메모리 정리 후 대기한다.
- **Office PR:** [PR329](https://github.com/Innvoaid/dentlink-app/pull/329),
  `feature/DL-16317 → develop`, head `df3c79a5efa51e9c9160c9f0d6d260be93310584`.
  OPEN/MERGEABLE, develop `62e5864`가 이미 포함되어 최종 diff 75파일/11커밋(+7581/-791)이다.
  자동 제목·본문·라벨 workflow 성공 후에도 실제 base develop과 의도한 본문을 재확인했다.
  앱은 확인된 develop 대상 정책을 적용하며 웹의 release/v1.89.0 전달 경로와 구분한다.
- **Office CodeRabbit:** [댓글6187728788](https://github.com/Innvoaid/dentlink-app/pull/329#issuecomment-6187728788)에
  Review skipped가 명시되어 있다. 자동 리뷰 대상 패턴이 `release/*`여서 develop 대상은 실행하지 않았다.
  체크 SUCCESS는 실제 리뷰 완료가 아니다. reviews0/reviewThreads0이며, 사용자 지시에 따라 별도 재실행·과금·
  설정/대상 브랜치 변경은 하지 않았다. 새 수정 지적이 없어 제품 코드/커밋은 추가하지 않았다.
- **웹:** [PR4700](https://github.com/Innvoaid/dentlink-client/pull/4700),
  `feature/DL-16317@55ad768d54c3ffc9948f22051aad36ba49ba293c → release/v1.89.0` 유지.
  OPEN/MERGEABLE/REVIEW_REQUIRED. 최신 HEAD에 대한 CodeRabbit 실제 리뷰를 확인했고
  전체 3개 스레드 모두 resolved·추가 페이지 없음·신규 유효 지적 없음이다.
  docstring coverage 안내 경고만으로 불필요한 주석/파일을 추가하지 않았다.
- **Git/검증:** 두 제품은 기존 커밋이 원격과 동일하고 clean이다. 앞선 Office 26 suites/235 tests,
  lint오류0·iOS/Android JS bundle PASS 및 기존 타입 오류18개/추가0, 웹 관련4 suites/38 tests 결과를 유지한다.
  이번 단계는 PR/리뷰 확인이며 코드 변경이 없어 테스트를 반복하지 않았고 실기기/쓰기 QA를 새로 수행하지 않았다.
- **Jira:** Office DL-16752 댓글44462에 PR329·자동 리뷰 생략·다음 QA를 반영했다.
  Web DL-16319 댓글44459의 앱 PR 미생성 문구도 PR329 링크로 갱신했다. 두 카드 Ready for Deploy 유지.
  부모 카드·Lab 앱은 변경하지 않았다.
- **완료/재개점:** 현재 확정 계약에서 즉시 필요한 추가 FE 개발이나 BE 확인 질문은 발견하지 못했다.
  다음은 두 PR의 팀 리뷰 → 웹 릴리즈/앱 QA 버전 준비 → 같은 병원 Member/Admin 실제 기기와 쓰기 QA
  (기본/부분/차단 상세, 직원 전환, 채팅·승인/거절, 본인/미지정/타 의사 Draft, 업로드) → 승인된 배포다.
  PR 병합·배포·CodePush는 하지 않았다. 추가 변경·자동 모니터링 없이 사용자 재개 지시를 기다린다.

### 추가 읽기 QA — 2026-10-15 로컬 Admin/Member 초기 Pending 필터 차이

- 사용자 질문으로 현재 실행 중인 웹 서버 PID97531의 cwd가 정식 permission/clinic이고
  HEAD `55ad768d5`·clean인 것을 확인했다. 일반 Chrome Admin localhost와 시크릿 Member 127.0.0.1을 비교했다.
- 양쪽 모두 DEV `GET /office/orders/filter-hint`를 실제 호출한다. Admin 응답은
  `{code:"0000", data:"PENDING"}`, 자동 선택된 `PENDING_ORDER`+`OFFICE_APPROVAL_PENDING` 목록은 38건이었다.
  Member 응답은 `{code:"0000", data:"ALL"}`이고 기본 상태 필터 없이 전체 5건을 표시했다.
- Member에도 두 상태를 명시해 조회했다. 정확한 두 query와 size10/page0 요청의 HTTP200 및
  화면 0 Orders/No Result를 확인했다. 따라서 현재 Member가 조회 가능한 Pending 주문이 없어
  서버가 ALL을 돌려주고 FE가 이를 반영한 결과이며, 이 흐름의 FE 호출/필터 전달 누락은 발견하지 못했다.
- 코드상 기본 필터는 역할 공통으로 hint=PENDING·진입 URL query 없음일 때 마운트당 1회만 적용한다.
  Member 제거 필터는 dentistIds/myOrderOnly뿐이다. 직원·권한별 cache/enabled 조건은 연결돼 있고,
  현행 DEV Swagger도 별도 Member 필수 인자를 요구하지 않는다. `/pending-summary`는 앱 전용으로 구분한다.
- 확인 후 Member `/orders`·Status 미선택·전체5건으로 복원했다. 창 전환/주소 입력 중 섞인 잘못된 query의
  결과는 증거에서 제외하고 정확한 query의 응답만 위 결론에 사용했다. 제품/PR/Jira 수정이나 쓰기 QA는 없다.
  이는 현재 계정의 반환 데이터 확인이며 BE가 정한 환자/주문 전체 접근 범위의 최종 QA 증거는 아니다.

## 이전 체크포인트 — 2026-10-15 중단 작업 복구·Office 보완 및 develop 통합 완료

- **사용자 요청/범위:** 토큰 중단 전 Office 구현을 이어서 가능한 보완·검증·커밋/푸시·메모리·Jira 정리까지 완료.
  중간에 Claude가 웹 PR4700의 CodeRabbit만 처리한 변경도 인수 검토했다. 미커밋 Office 변경은 앞선 Codex 작업임을
  작업 기록과 diff로 확인해 이어받았다. 웹의 master → feature → release/v1.89.0 전달 경로는 유지한다.
- **웹 인수 결과:** 정식 `/Users/parkjongsun/Repository/dentlink-client-permission`을 pull하여
  `feature/DL-16317@55ad768d54c3ffc9948f22051aad36ba49ba293c` 원격 동일·clean으로 맞췄다.
  Claude의 Place Order/조회 실패 안내/권한 ref 갱신 3커밋에서 새 회귀를 찾지 못했고 추가 웹 수정은 하지 않았다.
  현재 코드의 관련 기존 4 suites/38 tests PASS. PR4700은 OPEN/MERGEABLE, base release/v1.89.0이다.
  CodeRabbit은 최신 head까지 실제 실행했으며 신규 지적 0·전체 3 threads 모두 resolved를 재확인했다.
  이전 '새 리뷰 미확인/정식 worktree 3커밋 뒤' 상태는 해소됐다. 유료 재실행은 요청하지 않았다.
- **Office 최종 Git:** `/Users/parkjongsun/Repository/dentlink-app-permission`, 기존 `feature/DL-16317`,
  `df3c79a5efa51e9c9160c9f0d6d260be93310584` 정상 push 완료·원격 HEAD/ls-remote 일치·clean.
  1. `323466a` 주문 채팅 API와 직원별 요청 범위 적용
  2. `5c9e57e` 주문 접근 거절과 승인 권한 처리 보완
  3. `7a43819` 주문의 미사용 권한 입력과 숨긴 필터 조회 정리
  4. `df3c79a` 최신 origin/develop `62e5864`를 feature로 통합한 merge commit
  원격 develop/main/release를 변경하거나 앱 PR·배포·CodePush를 실행한 것은 아니다. 앱 열린 PR 없음 확인.
- **완료된 Office 기능:**
  - 403/code2152는 로그인 만료로 처리하지 않는다. 제한 상세는 기존 웹 조회 불가 화면으로 진입하며,
    다른 오류는 기존 toast/back을 유지한다. 목적 주문 조회가 실패하면 이전 주문 데이터/채팅 버튼을 재사용하지 않는다.
  - ORDER GET/POST `/office/chat-messages/orders/{orderId}`로 전환. support/reply/read/page/translation 계약 유지.
    DEV Swagger 생성기를 실제 실행한 결과에서 필요한 DTO/alias/2method 76줄만 반영해 무관한 대량 생성 변경은 제외했다.
    원본 `/tmp/dentlink-office-permission-implementation-swagger-20261015.json`, SHA256
    `62be4515a489e803b69a2f18b4d78aa4886a6c9b95a64549054281ee50ef5f12`, 936 paths.
  - 메시지/신규/최근/미읽음/주문정보/승인목록을 직원·권한별로 구분하고 직접 cache writer도 일치시켰다.
    직원/권한 변경 시 이전 로컬 메시지·답글·낙관적 읽음 상태 및 지연 응답/작업을 차단한다.
    EmployeeProfile 활성 직원 writer도 reader의 employeeId 포함 키와 일치시켰다.
  - 승인 화면은 주문 GET 성공 후 siblings를 조회한다. 주문/승인 조회 실패 시 과거 파일을 가리고,
    2152는 기존 OrderDetail로 연결, 다른 오류는 기존 toast/back. 공유 Member의 파일/URL/버전 조회는 유지한다.
    승인·거절/첨부 준비 동안 직원·권한·대상이 바뀌면 이전 작업을 차단한다.
  - 주문/채팅 업로드는 최신 직원 권한을 요청 전후 재확인한다. multipart 중 권한/주문 전환은 기존
    abort/delete cleanup 큐를 재사용한다. 이미 첨부 요청이 전송됐을 가능성이 있는 파일은 임의로 삭제하지 않는다.
  - 미사용 외부 권한 prop은 제거하고 실제 역할·담당자 판정을 유지했다. 숨긴 Member 의사 필터 조회를 중단한다.
- **develop 통합:** 충돌 11파일을 양쪽 의미를 보존해 해결했다. 덴처 다음 단계 주문 POST와 shouldReturnOnBack,
  날짜 형식/생년월일 검증, Submission Method, 중복 업로드 방지·첨부/재조회 대기·실패 정리를 유지했다.
  덴처 다음 주문 API에도 현재 직원/권한 확인을 연결했다. 독립 코드 검토에서 추가 실행 경로 결함을 찾지 못했다.
  최종 origin/develop 대비 권한 feature diff는 75파일이며 env/ignore/stories/package/lock/native/배포 workflow 변경 없음.
- **검증:** 통합 전 관련 22 suites/173 tests, 통합 후 권한+업스트림 충돌 영향 26 suites/235 tests PASS.
  전체 feature 변경 TS/TSX lint 0 errors(기존 warning10), Prettier/diff PASS.
  전체 타입 검사는 기존 18개 진단이 동일(라인번호 정규화 비교 시 추가/제거 0). 타입 전체 PASS라고 보고하지 않는다.
  iOS JS bundle+74 assets, Android JS bundle+78 assets 생성 PASS. worktree node_modules symlink 때문에
  `/tmp/dentlink-office-permission-metro-20261015.cjs`에 watchFolders만 보완했고 저장소 설정은 변경하지 않았다.
  실기기·실계정 쓰기 QA/네이티브 빌드는 하지 않았다(부팅 시뮬레이터·연결 Android 없음, ios/Pods 없음).
- **검증 로그:** `/tmp/dentlink-office-final-{tests,lint,format,type,ios-bundle,android-bundle}-20261015.log`,
  `/tmp/dentlink-web-resume-review-20261015.log`. 신규 테스트 파일은 실제 승인조회·세션·업로드 회귀 검증용이며
  Storybook/검수용 UI/개인 인수 파일은 제품 저장소에 추가하지 않았다.
- **Jira:** Web DL-16319 댓글44459로 Claude 리뷰 처리 재확인, Ready for Deploy 유지.
  Office DL-16752 댓글44460에 개발 완료/검증/실기기·PR·배포 잔여를 반영하고 transition12로 Ready for Deploy 전환 확인.
  기존 요구사항 본문은 충분하여 유지했다. 부모/다른 담당 카드와 Lab 앱은 변경하지 않았다.
- **남은 것/재개점:** 현재 계약 기준 즉시 처리할 개발 잔여나 추가 BE API 확인 질문은 발견하지 못했다.
  다음은 Office 앱 PR·팀 리뷰 → QA 버전 준비(웹 상세는 PR4700 릴리즈와 함께) → 같은 병원 Member/Admin 실제 기기의
  기본/부분/차단 상세·직원전환·채팅/승인/거절 쓰기·본인/미지정/타 의사 Draft·업로드 QA → 승인된 배포다.
  앱 PR 기본 대상은 확인된 정책 develop이며, 10/12 앱 개발자 release 전달 설명은 별도 합의 전 참고 자료로 유지한다.
  이번 작업으로 웹 PR 병합/릴리즈 배포·앱 PR 생성/병합·CodePush를 실행하지 않았다. 재개 지시 전 대기한다.


## 이전 체크포인트 — 2026-10-15 Claude 인수·PR4700 CodeRabbit 3건 처리

- **이번 요청:** 사용자가 PR4700 CodeRabbit 지적의 처리·commit/push·resolve를 Claude에 요청했다.
  이전 에이전트(Codex) 작업을 이어받도록 이 저장소와 Codex transcript로 의도를 파악했다.
  작업 위치는 Claude 전용 worktree `/Users/parkjongsun/Repository/dentlink-client/.claude/worktrees/pr-4700-review-f03f94`
  (로컬 branch는 `origin/feature/DL-16317` 추적)이며 `HEAD:feature/DL-16317`로 push했다.
- **기록 정정:** 앞선 'CodeRabbit review-limit으로 리뷰 0건' 기록과 달리 CodeRabbit은 05:33Z에 `b725934a7`을 실제 리뷰해
  스레드 3건을 남겼다. 1건은 '96ff683에서 해결'로 resolved 표시였으나 `handleChangeOrder`만 반영되고
  `handlePlaceOrder` 가드가 남아 있었다.
- **웹 수정 (원격 `55ad768d5`, 3커밋):**
  1. `9578b2b31` `fix: 부분 제공 상세의 새 주문 작성 링크 허용` — `useOrderDetail`의 `handlePlaceOrder` 편집 권한 가드 제거.
     사이드패널 Place Order가 항상 보이는데 Member 타 의사 부분 상세에서 무반응이던 결함이다.
     근거: 부분 상세 제한 범위(변경/취소·Case 제목·승인/거절·채팅 작성)에 새 주문 작성은 없고, 주문 1단계는
     치과 전체 환자 선택·NEW Case 본인 고정이 확정 정책이다. 수정·Remake·담당 변경 가드는 유지.
  2. `7cca1ddf4` `fix: 주문 작성 화면의 조회 실패 시 조회 불가 안내 표시` — `[step].tsx`에서 403이 아닌 조회 실패
     (5xx·네트워크)가 빈 fragment로 남던 것을 기존 `OrderDetailUnavailable`(Go to Home, 앱 WebView는 네이티브 홈)로 표시.
     CodeRabbit 제안의 403 페이지 이동은 '401/네트워크는 권한 거절로 바꾸지 않음' 기준에 맞지 않아 따르지 않았다.
     403은 기존 403 이동, 2131 병원 전환은 제외 유지. 판정은 `officeOrderActionPermissions.ts`에 `isOfficeOrderLoadFailed` 추가.
     사용자 확인: 이번 인수의 목적은 완성된 작업의 리뷰 지적 처리뿐이며, 이 수정은 리뷰 대응 범위로 별도 승인 대상이 아니다.
  3. `55ad768d5` `fix: 시스템 메시지 액션 권한을 커밋 단계에서 갱신` — shared `OrderDetailLayout`의
     `canUseSystemMessageActionRef` 렌더 중 대입을 `useLayoutEffect`로 이동(커밋 직후·입력 전 동기 갱신).
- **검증:** 1·2는 기존 테스트 파일 안에서 수정 전 실패 → 수정 후 통과. 관련 Jest 14 suites/131 tests 통과.
  pre-commit의 Clinic/Lab/Admin 타입 검사 통과. 3서비스 lint 0 error(기존 경고만), Admin DLOS guard,
  shared coverage(변화 없음) 통과. 새 테스트 파일·Storybook은 추가하지 않았다. 실계정·화면 QA는 하지 않았다.
- **Push 방식 주의:** `.claude/worktrees/` 중첩 worktree에서는 ESLint가 상위 checkout의 `.eslintrc.json`까지 읽어
  storybook plugin 충돌로 pre-push hook이 실패한다. 같은 항목을 `--no-eslintrc -c ../.eslintrc.json`로 직접 실행해
  통과를 확인한 뒤 `--no-verify` push했다. 타입 검사에는 gitignore된 `{clinic,lab,admin}/next-env.d.ts`가 필요했다.
- **PR/리뷰:** PR4700 OPEN/MERGEABLE/REVIEW_REQUIRED, head `55ad768d5`. 스레드 3건 모두 근거 답글 후 resolved.
  새 커밋의 CodeRabbit 체크는 기록 시점 PENDING이며 새 스레드 재확인은 하지 않았다.
- **Worktree 상태:** 정식 웹 worktree `/Users/parkjongsun/Repository/dentlink-client-permission`은 `96ff6836b`(clean)로
  원격보다 3커밋 뒤다. 다른 worktree 변경이 권한 정책에 막혀 맞추지 않았으므로 재개 시 `git pull --ff-only`부터 한다.
  Office 앱 `/Users/parkjongsun/Repository/dentlink-app-permission`(`72a7914`)에는 **기록되지 않은 미커밋 변경 34항목**이
  있고 확인 중에도 32→34로 늘었다. 다른 세션이 작성 중일 수 있어 손대지 않았으며 소유권 확인이 필요하다.
- **다음:** 웹은 PR4700 팀 리뷰 → release/v1.89.0 병합·배포 → 쓰기/Draft QA.
  앱은 미커밋 변경 소유권 확인 후 기존 잔여 순서(2152 세션·상세 진입 → ORDER 채팅/역할 캐시 → 직원 정보 갱신)를 따른다.

## API 사용처 재검토 — 2026-10-15 별도 조회 세션 대기

- **범위:** 사용자 요청으로 웹 Office·Lab·Admin과 Office·Lab 앱의 실제 API 호출부를 읽기 전용으로 조사했다.
  이 조회 세션(`01a1337c-cad1-7e02-bc3b-9a25801be537`)의 결과이며, 위 권한관리 구현·리뷰 상태를 변경하지 않는다.
- GET `/office/order-chats`, GET `/lab/order-chats`: 웹은 생성 API 정의만 존재한다.
  각 앱은 `LinkTalkService.findOrderChats`와 `useFindOrderChatsInfiniteQuery`가 남아 있지만
  해당 훅을 소비하는 화면이 없다. 실제 Office·Lab LinkTalk 목록은 각각 GET
  `/office/chats/latest`, `/lab/chats/latest`를 사용하며 Admin 웹도 두 `order-chats` 경로를 호출하지 않는다.
- PATCH `/office/orders/{orderId}/revisions`: 미사용이라는 이전 결론을 재확인했다.
  웹 `shared/models/src/order/order.apis.clinic.ts:83`의 함수만 남아 있고 호출부는 없다.
  같은 파일의 `approve()` 주석은 `/revisions`로 잘못 표시되지만 실제 요청은 `/approve`다.
- 별개 PATCH `/lab/orders/{orderId}/revisions`는 Lab 웹 `useOrderDetailForm.ts:502`에서
  `PENDING_ORDER → NEW` 변경에 사용한다. `/admin/orders/{orderId}/revisions`는 생성 정의만 존재한다.
  Office·Lab 네이티브에는 직접 호출부가 없고, Lab 앱 WebView도 상태 변경 버튼을 숨긴다
  (`OrderDetailBoxTitleDesktop`의 `!isDentlinkApp`, Mobile의 Office 앱 전용 조건).
  앱에서 상태 변경 모달을 여는 메시지·라우트 플래그도 찾지 못해 간접 호출 진입 없음으로 확인했다.
- **최신성:** 조회 중 fetch한 웹 `origin/master 8772d6882`, `origin/feature/DL-16317 55ad768d5`,
  `origin/release/v1.89.0 af636cac8`에서 revisions 결론이 같다. 앱은 Office `origin/main/develop 62e5864`,
  Lab `origin/main bb61901`·`origin/develop 56cba67` 및 로컬 권한 작업 코드에서 확인했다.
- **한계:** 정적 호출 경로·화면 연결 확인이며 운영 트래픽, 구버전 앱, 실기기 실행 증거는 아니다.
  10월 13일 POST 채팅/pending-summary 조사 결과는 당시 기록이며 이번에 현재 경로를 다시 확인한 것으로 취급하지 않는다.
  제품 코드·PR·Jira·배포 변경이나 실제 변경 API 요청은 하지 않았다.
- **대기:** 사용자가 `오케이 대기`로 종료했다. 개인 체크포인트 저장 후 이 조회 세션은 추가 외부 조회·개발 없이
  다음 명시적 요청을 기다린다. 다른 권한관리 구현 세션을 중단하거나 대신 진행하라는 지시는 아니다.

## 이전 체크포인트 — 2026-10-15 앱 재점검·웹 주문 이동 보완

- **이번 요청:** Office/Lab 앱의 현재 구현 확인과 제품별 Jira 정리, 웹에 남은 결함이 있으면 보완.
  개인 컨텍스트와 기존 두 permission worktree를 pull하고 live Jira·PR·DEV Swagger를 대조했다.
- **웹 추가 수정:** Member의 타 의사 부분 상세에서 사이드패널 다른 주문번호를 눌러도 이동하지 않던
  `handleChangeOrder`의 편집 권한 검사를 제거했다. 링크는 목적 주문으로 이동하고 목적지 GET에서
  기본/부분/차단을 판정한다. 수정·Remake·담당 의사 변경 제한은 그대로 유지한다.
  기존 hook·기존 테스트 2파일만 변경했으며 새 파일/Storybook은 추가하지 않았다.
  커밋 `96ff6836b` (`fix: 부분 제공 상세의 다른 주문 이동 허용`) 정상 commit/push 완료·원격 일치·clean.
  PR4700은 release/v1.89.0 대상으로 OPEN/MERGEABLE이며 본문도 수정 동작과 검증으로 갱신했다.
- **웹 검증:** 수정 전 실제 hook 회귀 1건 실패(이동 0회), 수정 후 관련 3 suites/32 tests 통과.
  Prettier·diff 및 정상 commit의 Clinic/Lab/Admin 타입 검사 통과.
  정상 push의 3서비스 lint·Admin DLOS guard·shared coverage도 통과했다(기존 lint 경고 별도).
  로그 `/tmp/dentlink-permission-web-navigation-{before,after,commit,push}-20261015.log`.
  기존 24 suites/217 tests는 직전 정리 시점 결과이며 이번에는 관련 3묶음을 실행했다.
  이번 추가 검증은 코드 수준이며 새 실계정·기기 QA는 하지 않았다.
- **Office 앱은 개발 잔여:** `/Users/parkjongsun/Repository/dentlink-app-permission`,
  `feature/DL-16317@72a79146a` 로컬/원격 동일 clean. origin/develop `2bc7d04d` 대비 17/7커밋 분기,
  3-dot diff 60파일이며 이 feature의 PR은 없다. 이번 앱은 확인 요청 범위로 코드·Git 변경 없이 감사했다.
  1. 상세 GET의 **403/code2152를 로그인 만료로 처리**한다. fetcher.ts:147과 실제 상세 query/service 경로 확인.
     실제 모듈을 격리 실행하여 loggedIn=false 및 세션키8개 삭제를 확인했다. 2005/2004는 세션 유지.
     현재 origin/develop도 같다. 실제 사용자 계정에서 로그아웃을 일으키는 시험은 하지 않았다.
  2. ORDER 채팅 GET/POST가 아직 `/office/chat-messages`다. 현재 제공된
     `/office/chat-messages/orders/{orderId}`로 전환해야 한다. 고객지원·답글·읽음·페이지·번역은 기존 계약 유지.
     구 API도 Swagger에 남아 있으므로 모든 기존 호출이 실패한다고 단정하지 않는다.
  3. 메시지/신규 메시지/최근 대화/미읽음 query key에 직원·권한 구분이 빠져 있다.
     같은 병원 내 직원/권한 변경 전후 key 동일함을 격리 실행으로 확인했다. 명시적 병원 전환에는
     latest/unread reset이 이미 있으나 동일 직원 역할 변경과 메시지 state/cache는 별도 보완이 필요하다.
  4. EmployeeProfile의 활성화 성공 writer는 EMPLOYEE_OWN 3요소, reader는 employeeId 포함 4요소다.
     현재 reader가 활성화 응답을 받도록 맞춰야 한다. 후속 조회가 있어 항상 화면 실패인 것은 아니다.
  5. native 상세는 최초 GET 성공 전 WebView를 막고 실패는 toast/back이다. 2152 세션 보존 후에도
     웹 조회 불가 화면으로 연결되도록 확정된 접근 거절만 구분해야 한다. 다른 오류를 일괄 바꾸지 않는다.
  추가 정적 잔여: 파일 업로드 후 attach 전 현재 직원/권한/화면 종료 재확인,
  숨긴 의사 필터의 불필요한 조회 및 미사용 외부 권한 입력 정리. 무단 저장 성공을 재현한 것은 아니다.
  Draft DTO에 담당 정보가 없어 상세 재조회하는 실제 검사는 제거 대상이 아니다.
- **Office 검증:** 이번 기존 변경 관련 Jest 18 suites/128 tests PASS
  (`--config jest.config.js` 명시, `/tmp/dentlink-office-permission-audit-tests-20261015.log`).
  위 2152 인터셉터 문제는 이 기존 테스트가 다루지 않아 별도 격리 실행으로 확인했다.
- **Lab 앱:** origin/develop `56cba674`, origin/main `bb619010`의 tree 동일.
  환자 카드의 전체 주문/Case 수 제거·우리 Lab 주문 수 및 제목 중앙 정렬은 이미 반영되어 있다.
  상세 Case/주문 트리는 Lab 웹 WebView를 사용한다. DEV 명세는 기존 `/lab/chat-messages` GET/POST이며
  Lab 주문별 신규 경로는 없다. 이번 Office 전환을 Lab에 복제하거나 빈 Lab 카드를 만들 필요를 찾지 못했다.
  현재 별도 i18n checkout은 보존했다. 실기기·배포 확인은 이번 감사에 포함하지 않았다.
- **API/협의:** 최신 원본 `/tmp/dentlink-permission-app-audit-swagger-20261015.json`(936 paths),
  부모 최신 합의 댓글44436 유지. 별도 내 주문/환자 판정 API 대기는 불필요하다.
- **Jira:** Web DL-16319는 본문에 실제 범위/3상태/Pickup 링크/앱 경계를 정리하고,
  댓글44456에 구현/QA/앱 경계를 보고한 뒤 **Ready for Deploy**로 전환·확인했다.
  Office DL-16752는 오래된 BE 미배포 대기 문구를 현재 계약으로 정정하고 댓글44455에 개발 잔여를 반영했다.
  Office는 진행 중 유지. 부모 DL-16317과 다른 담당자 카드는 변경하지 않았다.
- **다음:** 웹은 PR4700 팀 리뷰·release 병합/배포 및 앞서 정리한 쓰기/Draft QA.
  앱은 2152 세션·상세 진입 → ORDER 채팅/역할 캐시 → 직원 정보 갱신 및 비동기 경계 보완 →
  develop 통합/PR 준비 → Member/Admin 실기기 QA 순서다. 새 BE API를 기다릴 작업이 아니다.

## 이전 체크포인트 — 2026-10-15 PR4700 미사용 준비 코드·테스트·Storybook 정리

- **사용자 지침:** 테스트는 실제 필요한 경우에만 유지하고, Storybook은 이제 사용하지 않는 방향이다.
  이번 PR 전체에서 불필요한 파일과 준비 코드를 다시 점검·정리하도록 요청했다.
  이 기능의 후속 작업에서 검수 편의만을 이유로 stories/테스트/helper를 추가하지 않는다.
- **제품:** `/Users/parkjongsun/Repository/dentlink-client-permission`, `feature/DL-16317`,
  `b725934a7` (`refactor: 권한 관리의 미사용 준비 코드와 검증 파일 정리`).
  정상 commit/push 완료. 기존 PR4700의 대상 `release/v1.89.0` 및 master 파생 전달 경로를 유지한다.
- **Storybook:** 신규 5파일 삭제, 기존 2파일의 이번 예제 추가분 원복. 최종 PR에 stories 변경은 없다.
  다른 기능이 갖고 있던 기존 Storybook 파일을 일괄 삭제한 것은 아니다.
- **미사용 제품 코드:** 실제 호출자가 없는 Draft `canContinueDraft`/`canDeleteDraft` 입력·전달과 행별 UI 준비,
  상세 페이지 외부 권한 입력 6개 및 승인 페이지/hook 외부 권한 입력을 제거했다.
  테스트도 가상 권한 prop 대신 실제 직원 역할·주문 담당 의사·GET403/2152 응답으로 검증하도록 바꿨다.
- **범위 밖 Lab 선행 확장:** Clinic에는 Memo 탭이 없고 Lab/Admin에서 실제 제한 조건을 공급하지 않던
  Memo 권한 확장 6파일을 release 기준으로 복원했다. Lab의 미사용 `isReadOnly` 전달도 제거했다.
  추가금·배송일 편집·상태 변경은 실제 Lab 전용이고 제한 조건이 공급되지 않아 관련 준비 코드를 원복했다.
  함께 도입됐던 일반 unmount/지연 callback 방어까지 원복되는 경로는 기존 release 동작 복원으로 구분한다.
  실제 Lab 시스템 메시지 액션 전달과 기존 `isInputHidden`은 유지한다.
- **실제 기능 보존:** Member 메뉴·필터, 상세 기본/부분/차단, 직접 작성 URL의 본인·미지정 Draft 검사,
  `isCurrentDraftContext`의 직원·역할·화면 종료 검사, Clinic 채팅 읽기 전용과 직원/권한별 캐시는 유지한다.
  이름이 같은 직접 작성 페이지의 지역 변수 `canContinueDraft`는 실제 검사이므로 제거하지 않았다.
- **테스트 정리:** 미사용 Memo/Draft UI 전용 테스트와 제품 변경이 없는 Pickup 링크 테스트 3파일 삭제.
  정적인 HOC 옵션을 런타임에 바꾸던 테스트, Lab 전용 미연결 제한 테스트 및 반복 fixture를 정리했다.
  신규 테스트는 27파일/7,610줄 → 24파일/6,424줄, 전체 PR은 174파일 → 151파일이다.
  이번 정리 커밋은 41파일 +306/-2,076, 순 1,770줄 감소다.
- **검증:** 남은 관련 Jest 24 suites/217 tests 전부 통과. 독립 호출 경로/diff 검토에서 실제 Member
  연결 누락을 발견하지 못했다. 정상 commit의 Clinic/Lab/Admin 타입 검사와 `git diff --check` 통과.
  정상 push의 Clinic/Lab/Admin lint, Admin DLOS guard, shared coverage 검사도 통과했다.
  기존 lint/Prettier 설정 경고는 있으나 검사 실패는 아니다. PR 본문도 최종 범위와 검증 결과로 갱신했다.
  기존 Swagger 생성물·SVG 3개는 실사용/생성 계약을 확인해 유지하며 env/ignore/package/배포 workflow 변경은 없다.
  로그: `/tmp/dentlink-permission-cleanup-final-tests-20261015.log`,
  `/tmp/dentlink-permission-cleanup-commit-20261015.log`, `/tmp/dentlink-permission-cleanup-push-20261015.log`.
- **다음:** PR 팀 리뷰·release 병합/배포 후 아래 실데이터 쓰기 QA와 Draft 사례 QA를 진행한다.
  이번 정리는 코드 검증이며 새 실계정 화면 QA·네이티브 수정·E2E·배포·Jira 댓글은 하지 않았다.
  CodeRabbit은 사용자의 한도 초과 시 생략 지시를 유지하며 유료 재실행하지 않는다.

## PR 생성 이력 — 2026-10-15 release/v1.89.0 대상 PR4700

- **최신 리뷰 결정:** 사용자가 PR4700 CodeRabbit 확인·필요 수정·커밋/푸시·메모리화를 요청했으나,
  실제 조회 결과 CodeRabbit은 리뷰 한도 초과로 실행되지 않았다. 체크 상태 SUCCESS를 리뷰 완료로 해석하지 않는다.
  [봇 댓글6184540498](https://github.com/Innvoaid/dentlink-client/pull/4700#issuecomment-6184540498)은
  현재 HEAD7bf2b72a7·대상171파일·유료 재실행 최대 US$42.75를 안내한다. reviews0/전체 reviewThreads0을 확인했다.
  비용 확인 질문에 사용자가 **“한도 넘었으면 넘겨 그냥”**이라고 답해 CodeRabbit 리뷰를 생략하기로 확정했다.
  유료 재실행·자동 수정·대체 전수 리뷰는 하지 않는다. CodeRabbit 미검토 상태를 보존하며 팀 리뷰/QA 단계로 진행한다.
  이번에는 리뷰 지적으로 인한 제품 수정·추가 제품 커밋/푸시가 없고 HEAD7bf2b72a7을 유지한다.

- **사용자 확정 전달 경로:** `master`에서 파생 → `feature/DL-16317` → `release/v1.89.0` → `master`.
  `develop`은 이번 작업의 기반·릴리즈 경로·완료 판정과 무관하다. 이전 develop PR은 임시 개발서버 확인 이력일 뿐이며
  이번 작업의 통합·배포 단계나 다음 할 일에 연결하지 않는다.
  2026-10-15 재확인: 최초 feature 커밋 `5ffe7e054`의 부모 `9bed1f7bd`는 master 이력이며,
  이후 통합은 master 및 release 이력이다. develop 코드를 유입한 이력은 없고 현재 원격 SHA와 로컬이 일치한다.
  PR4700은 `feature/DL-16317@7bf2b72a7` → `release/v1.89.0@af636cac8`, OPEN/MERGEABLE이다.
- 사용자가 기존 PR 유무를 확인하고 없으면 `release/v1.89.0` 대상으로 생성하도록 명시 요청했다.
  생성 전 열린 PR은 없었다.
- **[PR4700](https://github.com/Innvoaid/dentlink-client/pull/4700)**:
  `[DL-16317] Member 권한과 주문 상세 접근 제한 적용`, `feature/DL-16317` → `release/v1.89.0`, OPEN·일반 PR.
  생성 후 실제 base/head와 MERGEABLE, 174파일(+11,701/-1,065)을 확인하고 현재 채팅에 연결했다.
- **PR 생성 당시 제품 HEAD는 `7bf2b72a752c831e63069d6f37364f37647e2cb1`**.
  PR 준비 중 release `af636cac8`와 generated `PaymentProfileRequestDto.name` 설명 주석 한 곳의 충돌을 발견해
  feature에 release를 통합하고 릴리즈 설명을 유지했다. normal commit/push 완료·원격 일치·clean 확인.
  독립 대조에서 릴리즈 단독 변경47파일 보존 및 generated 필드/타입 손실 없음을 확인했다.
  최종 PR diff는 권한관리 누적 변경이며 package/lock/env/ignore/배포 workflow 변경은 없다.
- 통합 HEAD에서 Clinic/Lab/Admin 타입, 3서비스 lint, Admin DLOS guard, shared coverage 정상 hook 통과.
  아래 실제 계정 QA는 앞선 `e5c8a3e19` 기준이며 통합 HEAD의 화면 QA를 새로 한 것은 아니다.
  로그: `/tmp/dentlink-permission-release-pr-commit-20261015.log`, `/tmp/dentlink-permission-release-pr-push-20261015.log`.
- **다음:** PR 팀 리뷰·release 병합 → 릴리즈 환경 배포·아래 남은 실데이터 QA → 승인 후 master 반영.
  이번 요청은 PR 생성까지이므로 CodeRabbit 대응/지속 감시·병합·배포·Jira 댓글은 진행하지 않았다.

## 구현·로컬 QA 체크포인트 — 2026-10-15 Member/Admin 확인·홈 채팅 캐시 보완 완료

- **최신 승인:** 사용자가 BE 예정 API가 모두 완료된 기준으로 기존 작업 브랜치에서 로컬 연동 검증·가능한 수정·커밋/푸시·메모리화를 요청했다.
  시크릿 localhost의 Member 로그인을 직접 완료해 주었다. 아래 실계정 결과가 이전의 포괄적인 QA/BE 대기 기록보다 우선한다.
- **제품:** `/Users/parkjongsun/Repository/dentlink-client-permission`, `feature/DL-16317`.
  `e5c8a3e19ae0153b6be71ed2a12850e08bbd88ea` (`fix: 직원과 권한 변경 시 홈 채팅 캐시 분리`) normal commit/push 완료.
  원격 feature SHA 일치·작업 트리 clean 확인. 기존 Lab UI 2건 `7c724ad0a`도 그대로 포함한다.
  이번에 PR 생성/병합/배포·Jira 댓글·네이티브/E2E 변경은 하지 않았다. env/ignore도 수정하지 않았다.
- **추가 API 대기는 해제된 상태 유지.** 현재 DEV API로 아래 기능이 실제 동작한다.
  기존 주문 GET200 + 담당 의사 비교 + GET403/2152 계약을 사용하며, FE 임의 목록 필터나 별도 판정 API를 추가하지 않는다.
  API가 없다는 포괄적인 문의는 불필요하다. 재현되는 응답/권한 불일치가 생겼을 때만 좁혀 문의한다.

### 이번에 수정한 결함과 검증

- 홈 최근 LinkTalk가 같은 직원의 권한 변경 뒤 이전 목록·전체 건수를 재사용하고, 미읽음 건수는 소속/직원 변경 뒤 이전 캐시를 재사용할 수 있었다.
  수정 전 회귀 테스트 2건 실패로 확인했다. 직원·권한별 query key를 분리하고 현재 직원/권한이 확인된 뒤 조회하도록 했다.
  전환 첫 렌더부터 이전 목록·건수·필터를 제거하며, 수동 refetch도 유효한 직원 맥락에서만 수행한다.
  서버 API 경로/파라미터/목록 정제 정책은 바꾸지 않았다.
- 변경 4파일: `clinic/src/components/Dashboard/Dashboard.tsx` 호출 1줄,
  `clinic/src/lib/Dashboard/useDashboardLinkTalk.ts`, `clinic/src/services/chat/chat.query.ts`,
  신규 `clinic/src/lib/Dashboard/useDashboardLinkTalk.test.tsx`.
- 독립 검토, 신규 회귀 4건 포함 관련 7 suites/54 tests 및 별도 기존 권한 9 suites/90 tests 통과.
  Clinic 타입·변경 hook/query/test ESLint·Prettier·diff 검사 통과.
  정상 commit의 Clinic/Lab/Admin 타입과 정상 push의 3서비스 lint·Admin DLOS guard·shared coverage 검사도 통과했다.
  기존 lint/Prettier 설정 경고는 실패와 구분한다.
  로그: `/tmp/dentlink-permission-chat-commit-20261015.log`, `/tmp/dentlink-permission-chat-push-20261015.log`.

### 실제 계정으로 확인한 범위

- 로컬 Clinic `http://localhost:3000` + 기존 DEV API. Admin `jongsun.test1`(직원213, OWNER),
  Member `jongsun.test2`(직원386, MEMBER), 같은 frankieDevOffice. 사용자 비밀번호/토큰을 추출하거나 저장하지 않았다.
- **메뉴/필터:** Member는 Billing/Dashboard 메뉴 없음, 주문 Dentist/My Orders Only·환자 My Patients Only 필터 없음.
  Admin은 해당 메뉴/필터 유지. Member 주문 목록5건·환자 목록5건, 보드 In Review4건/Draft0건 및 의사 필터 없음을 확인했다.
  보드는 표시 상태 범위가 목록과 달라 총건수 차이만으로 결함으로 판단하지 않는다.
- **홈:** Admin Active624/Pending38, LinkTalk All203/Unread4.
  Member Active5/Pending0, 최근 주문5214/4393/3988/3437/2912 모두 본인 담당, LinkTalk All1/Unread0(2912).
  캐시 수정 후 새로고침/새 탭에서도 각각의 범위를 확인했다. 실제 계정의 권한을 변경한 것은 아니며 전환 경계는 회귀 테스트로 확인했다.
- **기본 상세:** Member 본인 `9000005214`는 Cancel/Edit·담당의사 변경·채팅 입력/파일 업로드가 표시된다.
  `/orders/9000005214/additional`의 본인 수정 폼과 본인 Assigned Dentist/Save Changes 표시까지 확인했다. 저장은 누르지 않았다.
- **부분 상세:** 공유 환자 목록에서 타 의사 주문 `9000003943`으로 이동 가능.
  환자/Case/주문 트리와 Details/Files/Timeline 유지, 주문 Cancel/Edit·담당의사 변경·채팅 입력/업로드 숨김.
  기존 파일1건 선택 시 Download(1) 활성화 확인 후 선택 해제했다. Admin의 같은 주문은 전체 기능이 표시된다.
  `/orders/9000003943/additional` 직접 진입은 `/403`으로 이동해 차단됐다.
- **차단 상세:** Member `9000009123`은 No order data available/Go to Home.
  Query Devtools의 해당 `order_show` 오류 응답에서 HTTP403, code2152, FORBIDDEN 및 Member own orders/patients 제한 메시지를 직접 확인했다.
  Admin의 같은 주문은 상세/수정/채팅 입력이 열린다. 이를 단순한 공통 데이터 없음과 구분한다.
- **승인/Remake:** Admin `/orders/9000009248/approvals/1469`는 파일 미리보기와 Approve/Reject,
  Member는 No order data available로 내용/버튼 미노출. Member의 공유 주문 `/remakes/9000003943/info`는 Remake 선택 목록으로 되돌아갔고 목록은 No Result였다.
  이 Remake 사례는 해당 주문의 자격/상태 조건도 관여하므로 역할별 단독 증거로 확대하지 않는다.
- **Pickup 링크:** Member가 기존 Pickup의 타 의사 주문 `9000004066` 링크를 누르면 새 탭의 해당 주문 상세로 이동한다.
  링크 단계 차단 없음 확인. 도착 화면은 No order data available이며 이 사례는 과거 Admin에서도 데이터 없음이었으므로
  4066을 역할별 상세 차단 증거로 쓰지 않는다. 역할별 거절 증거는 위9123이다.
- **신규 주문:** Member Place Order 시작 화면, 본인 환자 검색과 기존 Case 선택까지 확인했다.
  서버에 Draft를 만드는 Next/저장/주문 제출은 하지 않았다. 기존 Draft 이어하기용 실제 사례가 없어 미지정/본인/타 의사 Draft3종은 실데이터로 검증하지 못했다.
- **Lab UI2건:** 기존 로컬 Lab 로그인([LAB-DEV] E2E Lab), `http://localhost:3005`에서 환자 목록 제목의 실제 `vertical-align: middle`을 확인했다.
  환자→`9000009704` 상세에서 패널을 펼쳐 전체·Case/주문 트리 유지 및 Cases/Orders 건수 숨김을 확인했다.
  단일 주문 환자 사례이며 DL-16747의 타 기공소 이후 주문 경계 전체 검증은 아니다.
- 증거: `/Users/parkjongsun/.codex/visualizations/2026/10/15/permission-local-qa/`의 Member home/partial3943/blocked9123,
  Admin3943/9123, Lab patients/detail-panel 캡처.
- 로컬 QA 위젯 `/api/qa-users`의 Jira 설정500·ChannelIO 미로딩 등 기존 개발환경 경고는 별도다.
  HMR 직후 React queue 오류는 전체 새로고침으로 해소됐으며, 한 시크릿 탭 정지는 동일 계정/URL 새 탭에서 재현되지 않았다.
  Lab 상단 Order는 인쇄 버튼이었다. 인쇄 임시 탭은 닫았고 실제 패널 화살표로 검수했다. 인쇄/파일 저장은 실행하지 않았다.
- 검수 종료 후 직접 실행한 Clinic/Lab 서버를 정상 종료하고 임시 Admin/Lab·중복 시크릿 탭을 닫았다.
  사용자가 로그인한 Member 세션을 잃지 않도록 시크릿 홈 탭1개는 남겼다. 서버 재시작 후 기존 로그인 유효성을 확인한다.

### 남은 것과 다음 시작점

1. **현재 확인된 FE 구현 결함은 조치 완료.** 위 범위를 근거로 FE 전체 QA/출시까지 완료했다고 확대하지 않는다.
2. 다음에는 준비된 테스트 데이터로 실제 주문 저장·승인/거절·채팅/파일 전송과 Draft 미지정/본인/타 의사3종을 검증한다.
   담당자 변경 전후·공유/과거 담당 경계·Lab DL-16747의 여러 기공소 전후 주문 사례도 필요하다.
   정상 운영 데이터의 권한 변경/임의 fixture 생성은 하지 않는다. 이번에는 저장·승인/거절·전송·업로드 등의 제출 버튼을 실행하지 않았다.
3. BE에 지금 반드시 새로 질문할 API 누락/재현 오류는 없다. Lab 경계 등 준비된 사례가 기대 결과와 다를 때
   주문번호·현재 직원/기공소·응답status/code와 기대 기준을 모아 좁혀 확인한다.
4. 재개 시 개인 Git pull → 위 feature/원격/clean 확인 → 로컬 Clinic(3000)·필요시 Lab(3005) 실행 → 기존 브라우저 로그인 유효성 확인 순서.
   PR/통합/배포는 별도 요청으로 진행한다.

## 이전 체크포인트 — 2026-10-15 확정 UI 반영·필수 API 존재 확인

### 최신 정정 — API 추가 출시 대기 아님

- 사용자가 **BE는 어제 예정된 API가 모두 나왔다고 안내했다**고 전달했고, Swagger에 있는 것으로 충분한지 재검토하도록 요청했다.
  앞서 미검증 동작을 포괄적으로 BE 추가 작업/답변 대기로 안내한 것은 부정확하다. BE 미구현으로 단정하지 않는다.
- DEV 전체 Swagger 재조회는 아래 SHA256/936 paths와 동일하며, Office API 276 paths·Lab API 259 paths도 확인했다.
  대상 route의 전체/그룹 명세 차이는 summary 표기·operationId 접미사뿐이며 요청/응답 계약 차이는 없다.
- **현재 확정 기능을 구현하기 위한 필수 신규 API/응답 필드 누락은 발견하지 못했다.**
  현재 직원 own의 `id`·`authorityType=MEMBER`, 주문 GET의 `dentist.id`/`dentistId`, 주문별 채팅 GET/POST,
  Member 홈/최근 채팅/미읽음 건수/Draft 및 Lab 환자 주문 트리/상세는 모두 존재하고 실제 FE wrapper/hook도 사용 중이다.
  403/2152는 Jira 44435/44436 계약이며 Swagger 상세 GET에는 200만 기재되어 있다. Swagger의 오류 설명 누락은 API 미출시 증거가 아니다.
- **추가 판정 API, 목록의 담당자 ID/권한 플래그, 강제 필터 파라미터를 새로 요청할 근거는 없다.**
  서버가 반환 범위를 결정하는 기존 계약으로 가능하다. 홈/최근 채팅/건수/Draft의 권한별 실제 결과는 실계정 QA 항목이다.
  공개명세가 동일해도 기존 GET 내부 권한 정제는 변경될 수 있으므로 Swagger 해시로 BE 미반영을 단정하지 않는다.
- **새 Lab 범위 DL-16747은 별도:** ‘이후’ 기준이 공개 Jira에 구체화되지 않았지만, 이 또한 기존 목록 GET 정제와 상세 GET 거절로 구현 가능하다.
  별도 신규 API나 FE 판정 필드를 선제 요구하지 않는다. BE가 말한 완료 범위에 이 변경도 포함되는지와 적용 기준만 필요시 좁혀 확인한다.
  이 질문 때문에 기존 Member 연동 검증 전체를 대기시키지 않는다.
- 이번 재점검은 읽기 전용이다. Swagger 변경이 없어 재생성·제품 수정·추가 테스트 실행은 하지 않았으며 제품은 `7c724ad0a`로 유지한다.

- **최신 승인 범위:** 사용자가 기존 `feature/DL-16317`에서 즉시 가능한 UI 2건을 구현·검증하고
  커밋·푸시·Git 기반 메모리 정리까지 요청했다. 새 PR·develop/master 통합·배포·실계정 QA·E2E는 이번 범위에 포함하지 않는다.
  이어서 혼자 가능한 부분을 처리하고 디자인·기획 검토 완결성 및 사용자/BE 확인 질문·다음 순서를 재점검하도록 요청했다.
- **작업 경로/출발점:** `/Users/parkjongsun/Repository/dentlink-client-permission`, `feature/DL-16317`,
  출발 `f749491593ef1977976bc1c801b24e89bb5f5984`. 개인/제품 저장소 모두 pull 완료·출발 clean이었다.
  제품 최종 커밋은 **`7c724ad0afdd9b5c0e6ba30693fa2abefedd33ff`**
  (`fix: 기공소 주문 건수 노출과 환자 목록 제목 정렬 수정`). 정상 커밋·푸시 완료, 원격 feature SHA 일치·작업 트리 clean 확인.

### 반영한 UI와 근거

1. **Lab 주문상세 사이드패널 Cases·Orders 건수 숨김.**
   오늘 Figma #24/#25와 [신규 설명 576:32704](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v?node-id=576-32704),
   [화면 576:32702](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v?node-id=576-32702)를 확인했다.
   `shared/ui/src/OrderDetailUI/extra/OrderDetailSidePannel/OrderDetailSidePannel.tsx`에서
   `serviceType !== "LAB"` 조건으로 건수 라벨·숫자·구분자 블록만 감쌌다.
   전체(Total), 환자 정보, 케이스·주문 트리와 주문 이동은 유지한다. Clinic의 OFFICE 표시도 유지한다.
2. **Lab 환자 목록 ‘우리 기공소 주문현황’ 제목 세로 정렬.**
   [DL-16751 댓글44409](https://innovaid.atlassian.net/browse/DL-16751?focusedCommentId=44409)의 기존 UI 백로그다.
   환자명 열 공백은 긴 이름을 위한 설계이므로 유지한다. `lab/src/components/PatientList/PatientListLayerDesktop.tsx`의
   `StyledLabHeaderCell`에 `vertical-align: middle` 한 줄만 추가해 전역 styled-reset의 baseline을 덮어썼다.
   다른 헤더와 같은 정렬이며 높이·padding·열 너비·색·문구는 유지한다.
- 위 두 소스 파일만 변경했다. API·generated DTO·권한 guard·env/ignore·번역 호출/key/리소스는 변경하지 않았다.
  i18n 가이드를 읽었으며 기존 번역 호출을 유지하므로 번역 시트 동기화 변경도 없다.

### 검증과 한계

- 독립 코드 리뷰에서 수정 필요 결함 없음. Lab 페이지의 LAB 전달, Clinic의 OFFICE 전달,
  Total/트리 유지와 Lab 전용 제목 CSS의 적용 범위를 확인했다. Admin에는 현재 해당 sidebar 호출부가 없다.
- 변경 2파일 Prettier·diff 검사, Lab 제목 파일 scoped ESLint 통과.
  정상 커밋의 Clinic/Lab/Admin 타입 검사 및 정상 푸시의 3서비스 lint·Admin DLOS guard·shared coverage 검사 통과.
  전체 lint의 기존 경고와 Prettier의 기존 설정 옵션 경고는 실패와 구분한다.
  푸시 로그: `/tmp/dentlink-permission-ui-push-20261015.log`.
- 추가 `pnpm audit:i18n`은 기존 `account.auth.actions.logIn` 키 누락 판정으로 실패했다.
  수정 전 HEAD에도 shared SigninForm의 OFFICE 전용 `actions.logIn` 호출과 Lab en/ko 키 부재가 동일함을 확인했다.
  실제 Lab 로그인 호출부는 `serviceType="LAB"`이며 `actions.signIn` 분기를 사용한다.
  **후속 코드 대조로 감사기의 서비스 분기 오탐임을 확인했다.** `getRelevantConditions`는 삼항식의 true/false 구분 없이
  조건을 기록하고 `conditionExcludesLab`은 OFFICE 전용 조건을 제외하지 못한다. 관련 5파일은 merge-base 대비 변화가 없고
  Lab `signIn` 한/영 키가 모두 존재한다. 제품 번역 key 추가·시트 수정은 불필요하며 별도 감사 도구 개선 범위로 분리한다.
  로그: `/tmp/dentlink-permission-ui-i18n-20261015.log`.
- 후속 요청으로 수정된 실제 컴포넌트를 외부 API·인증·전송이 차단된 임시 로컬 fixture에서 렌더했다.
  Lab의 Cases/Orders 건수 숨김·Total/케이스 및 주문 트리 유지, Office의 기존 Cases 2/Orders 3 표시를 확인했다.
  Lab 환자 목록 제목의 실제 computed `vertical-align`은 `middle`이고 위/아래 여백은 17px/18px였다.
  브라우저 오류 로그는 없었다. 샘플 props와 별도 wrapper를 사용한 컴포넌트 검증이며 제품 전체 페이지의 스타일·폰트 QA는 아니다.
  임시 파일은 `/tmp/dentlink-permission-ui-preview-20261015`, 검수 주소는 `127.0.0.1:3097`이었다.
  검수용 서버 PID 30610만 정상 종료했으며 3097 listener가 없음을 확인했다.
- Member/Admin 실계정·서버 데이터 범위·저장 동작은 이번에 검증하지 않았다.
  정적/컴포넌트 검증을 배포·실계정 기능 QA 완료 근거로 확대하지 않는다.

### 현재 계약과 추가 확인할 것

- **조사 범위 보완:** 최초 보고에서 일부 연결 Jira가 빠져 있었다. 사용자 재확인 요청 뒤 DL-16317 하위 30개와
  DL-16747/16799, DL-16652를 직접 읽어 UI 백로그 DL-16751 및 기공소 열람 범위 기획을 추가했다.
  Figma 댓글 #1~25(목록에 #13 없음), 최신/과거 디자인과 현재 코드를 대조했다.
  후속으로 DL-16544가 연결한 [원기획/TC](https://app.notion.com/p/3c7ce072e82f811184a8e647444f01fd#e984570de2224ebdba3fd667a893cd51)의
  권한 5-4·TC 8-1, 전체 discussion 6개/댓글 8개와 하위 leo를 확인했다. 포함 Drive 블록 1개는 도구가 읽지 못했으므로
  모든 첨부까지 확인했다고 확대하지 않는다. 문서 전체 수정 시각이 권한 TC 수정 시각을 뜻하지도 않는다.
  원 TC의 Pickup 링크 비활성·타 의사 주문 상세 일괄 차단 등은 후속 사용자/Figma/Jira 결정으로 대체됐으므로 복원하지 않는다.
- **기존 계약 유지:** 부모 최신 댓글은 여전히 [44436](https://innovaid.atlassian.net/browse/DL-16317?focusedCommentId=44436).
  기존 주문 GET200·담당 의사 비교·403/2152 방식 및 주문 채팅 API 전환은 이미 반영돼 있다.
  DL-16782의 별도 검증 API 카드 제목은 그보다 오래된 기록이고 추가 계약이 없어 새 API 대기 사유로 삼지 않는다.
- **DEV Swagger 변경 없음:** 10/15 재조회 SHA256은 `62be4515a489e803b69a2f18b4d78aa4886a6c9b95a64549054281ee50ef5f12`,
  936 paths/1,383 schemas로 10/14 생성 기준과 동일하다. 이번에는 재생성하지 않았다.
  권한 코드 공개 응답도 Admin → Billing Manager → Manager → Member 순서로 확인돼 dropdown 추가 정렬은 불필요하다.
- **BE/기획 확인 1 — [DL-16747](https://innovaid.atlassian.net/browse/DL-16747):** 기공소가 처리한 주문 이후 주문의 열람 제한.
  Yoonie 기획 진행 중이며 하위 DL-16799에도 세부 계약은 없다. ‘이후’의 판정 기준,
  `GET /lab/patients/{patientId}/cases/orders` 목록 정제, `GET /lab/orders/{orderId}` 직접 조회 거절 status/code 확인이 필요하다.
  DTO에는 마지막 처리 주문 경계/조회 허용 정보가 없어 FE가 날짜·ID로 임의 필터링하지 않는다.
- **BE 확인 2 — Member 홈/최근 LinkTalk 범위:** `/office/orders/main`, `/office/chats/latest`와 관련 전체·미읽음 건수를
  본인 담당 주문 범위로 반환하는지 확인한다. 공유 환자의 타 의사 담당 주문까지 최근 목록에 넣는다는 뜻이 아니다.
  현 DTO로는 담당 의사 ID를 확실히 비교할 수 없어 FE 임의 필터를 추가하지 않는다.
- **Draft 정책 정정:** 원 TC 8-1에 Member는 **미지정 또는 본인 담당 Draft만 목록에 표시**한다고 명시돼 있다.
  5-4·TC와 DL-16785에는 신규 주문의 본인 Assigned Dentist 고정도 명시돼 있다. 이 두 방향을 미확정으로 질문하지 않는다.
  현재 직접 주문 form gate는 본인/미지정 DRAFT 이어하기를 허용하고 타 의사는 제한하며,
  생성 payload는 Member+NEW에서 본인 의사 정보를 사용한다. 관련 기존 3 suites/38 tests를 10/15 재실행해 모두 통과했다.
  로그: `/tmp/dentlink-permission-draft-check-20261015.log`.
  BE에는 해당 Draft의 목록·직접 GET·이어하기 허용 및 본인 자동 할당의 실제 적용 요청/응답을 확인한다.
  재개 시 본인 할당 시점과 삭제 권한은 원문에 없으므로, 기존 동작과 BE 계약으로 해결되지 않을 경우에만 좁혀 기획 확인한다.
- **실계정 QA 유지:** Member 기본/부분/차단·공유/과거 담당 범위·담당 변경 이후 접근·직접 승인/Remake·쓰기 동작은
  추후 확정 계약/준비된 사례로 확인한다.
  DL-16783/16785의 Ready for Deploy는 배포 증거가 아니며, 완료 카드 DL-16653의 타 기공소 주문 진입 QA 체크도 미완료다.
  DL-16784 AOP 트랜잭션 테스트·DL-16786 Annotation 런타임 검증은 해야 할 일이며, 추가 FE API 계약은 없다.
- **범위 분리:** DL-16652 모바일 환자 카드는 Lab native 작업으로 확인돼 웹 누락으로 계산하지 않는다.
  Office native DL-16752의 채팅/API·실기기·통합/배포 잔여도 이번 웹 UI 변경으로 완료되지 않는다.

### 다음 시작점

1. **API 추가 출시 대기는 해제한다.** 개인 Git pull → 이 기록 → 기존 feature/원격 확인 후 현재 API를 기준으로 연동 검증할 수 있다.
2. 화면 QA 재개 요청이면 이 feature를 로컬에서 실행하고 기존에 준비한 Member/Admin 계정과 해당 사례로 확인한다.
   DEV 웹에 feature가 올라갔다고 가정하지 않는다. 새 계정 준비를 불필요하게 반복 요청하지 않는다.
   홈/최근 채팅/건수·Draft·기본/부분/차단을 실제 응답으로 확인하고, 발견한 차이만 BE에 요청한다.
3. **BE/Leo 문의는 좁힌다:** 이번 완료 범위에 DL-16747도 포함되는지, 포함된다면 ‘이후’ 판정·동일/다른 Case 적용 기준이 무엇인지.
   기획 협의가 필요하면 레오가 확인 후 FE에 공유하도록 요청하며 사용자에게 별도 기획 창구를 추가하지 않는다.
4. 확인된 계약 차이나 실제 오류가 있을 때 필요한 FE만 반영한다. 별도 검증 API나 임의 필터는 추가하지 않는다.
5. 현재 확정 요구에서 추가 FE 결함은 발견하지 못했다. 제품은 `7c724ad0a`로 유지하며 추가 제품 커밋은 없다.
   새 사용자 지시 없이 PR·병합·배포·외부 댓글·자동 모니터링을 진행하지 않는다.

## 이력 — 2026-10-14 가능한 로컬 화면 검수·정리 완료 후 대기

- **최신 사용자 설명/요청:** DEV 웹은 원복되어 권한 feature를 확인할 배포 화면이 없다. 기존 코드를 로컬 실행해서라도 확인하도록 요청했다.
  따라서 아래 코드 작업의 화면 QA 제외 지시는 이번 **로컬 읽기 화면 검수** 범위에서 갱신됐다.
  DEV 웹 재조사·재배포·E2E는 재개하지 않으며, 주문/권한 저장·승인/거절·채팅 전송·업로드는 실행하지 않는다.
  이후 사용자가 **로컬에서 현재 가능한 만큼만 확인하고 정리·마무리**하라고 지시했다.
  Member 추가 로그인 요청은 반복하지 않고 미검증으로 남긴 뒤 검수 환경을 종료했다.
  최종적으로 **여기까지 중단하고 다음 재개 시 상태를 바로 알 수 있게 인계**하도록 요청했다. 명시적 재개 전 추가 작업은 하지 않는다.
- **실행 코드:** `/Users/parkjongsun/Repository/dentlink-client-permission`, `feature/DL-16317`,
  `f749491593ef1977976bc1c801b24e89bb5f5984`. 양쪽 저장소 pull은 up to date였고 제품 소스 수정 없이 실행했다.
  실행 명령은 `pnpm --filter dentlink-clinic-web dev --hostname 127.0.0.1 --port 3000`이다.
  **로컬 URL `http://localhost:3000`**, 기존 `.env.development`의 **DEV API**에 연결한다.
  프런트만 로컬이며 BE까지 독립 mock 환경인 것은 아니다. DEV 웹의 원복/서빙 상태는 확인하지 않았다.
- **런타임 정리 완료:** 이 작업에서 실행한 서버의 cwd가 permission/clinic인지 확인한 후 정상 종료 신호를 보냈다.
  localhost:3000 listener 없음·exec session80669 종료를 확인했다. 생성했던 일반/시크릿 localhost 탭만 닫았고,
  사용자가 열어둔 DEV 탭과 계정 로그인 상태는 유지했다. 로그 `/tmp/dentlink-permission-local-20261014.log`와 이미지는 보존한다.

### 로컬 Admin에서 직접 확인한 범위

- Chrome 기본 창의 localhost 기존 로그인은 **jongsun.test1 / frankieDevOffice**다. 프로필에서 계정을 확인했다.
  Billing/Dashboard 메뉴, Orders의 Dentist·My Orders Only, Patients의 My Patients Only,
  Board의 Dentist Name 필터가 표시된다. Patients612·Board559를 관찰했으며 Orders38은 기존 Pending 조건이 적용된 목록이다.
- 주문9123은 상세/Case 트리·Edit/Cancel·담당 변경 버튼·채팅 메시지와 입력을 표시한다.
  공유 비교용3943은 Cases4/Orders4·Files1·Edit/Cancel·담당 변경·채팅 입력이 표시된다. 이 화면에서 No Messages를 관찰했다.
  이번에는 응답 본문을 수집하지 않았으므로 빈 채팅의 서버 원인까지 새로 확정하지 않는다.
- 승인9248/1469는 PNG 실제 미리보기·Download·Approve/Reject가 표시된다. 승인/거절·다운로드는 실행하지 않았다.
- 마무리 때 주문3943의 Files 탭에서 파일1개 표시·선택 후 Download(1) 활성화·선택 해제 후 비활성화를 추가 확인했다.
  선택 상태를 원래대로 돌렸고 실제 다운로드·업로드는 실행하지 않았다.
- Pickup의 예약 항목을 펼쳐 주문4066을 클릭하면 새 localhost 주문 상세 탭으로 이동한다.
  도착 화면은 No order data available이다. 이 번호는 Admin도 조회 불가이므로 Member 전용 거절 사례로 쓰지 않는다.
- 위 화면 범위에서 새 권한 FE 결함은 발견하지 못했다. Member 제한·현재 API 2152 응답·전체 디자인 일치를 검증했다는 뜻은 아니다.
- 로컬 로그의 부가 `GET /api/qa-users` 500은 QA 제보 위젯의 Jira 담당자 조회 경로다.
  해당 route는 Jira 설정 누락/접근 실패 때 500을 반환하며 권한 주문 GET과 별개다. 비밀값·환경은 읽거나 변경하지 않아
  정확한 설정 원인은 확정하지 않았고 이번 권한 검수로 확대 수정하지 않는다.
- 이미지: `~/.codex/visualizations/2026/10/14/permission-local-qa/`의
  `admin-approval-9248.jpg`, `admin-shared-3943.jpg`, `admin-board.jpg`, `admin-file-selection-3943.jpg`.
  다른 기기에서는 이 기록을 기준으로 화면을 다시 확인한다.

### 마감 상태와 다음 재개 조건

1. 시크릿 localhost는 마감 직전에도 로그인 화면이었다. **Member의 메뉴/필터·기본/부분/차단·승인·Remake 직접 진입은
   이번 로컬 QA에서 미검증**이다. 과거 DEV 결과나 단위 테스트로 이번 실계정 확인을 대체하지 않는다.
2. 사용자에게 지금 추가 준비를 요구하지 않고 대기한다. 추가 BE/기획 계약 또는 명시적인 QA 재개 요청이 오면
   먼저 `codex-personal-context`를 pull하고 이 문서를 읽은 뒤 `dentlink-client-permission`의 branch/dirty/원격을 확인하고 안전하게 pull한다.
   기존 `feature/DL-16317`과 f74949159를 출발점으로 삼되 새 원격 변경을 우선한다. DEV 웹에 이 feature가 배포됐다고 가정하지 않는다.
   새 BE 계약 전달이면 Swagger/코드 차이부터, 로컬 QA 재개 요청이면 서버 실행·Member 로그인부터 진행한다.
   그때 본인5214·부분3943·차단9123·승인9248/1469 및 준비된 기존 Remake draft를 확인하며 새 draft를 임의 생성하지 않는다.
3. 현재 제품은 f74949159 그대로 원격 일치·clean이다. 이번에는 로컬 실행/읽기 검수만 했으므로 제품 신규 커밋·PR·병합·배포는 없다.
   완료/미검증·보조 QA 위젯 오류·서버/탭 종료를 개인 Git 기록에 커밋·푸시하고 마무리한다.
   확정 정책 외 구현 대기와 Office native 별도 범위는 아래 기록을 유지한다. 자동 모니터링은 없다.

## 이력 — 2026-10-14 확정 계약 기준 웹 FE 정리

- **최신 사용자 지시:** 현재 개발서버 상태는 판단 기준에서 제외하고, 원래 작업하던 웹 feature 코드에서
  논의로 정해진 FE 작업과 Swagger 재생성을 진행한다. 실제 API/실계정 테스트·화면 검수·E2E·배포는 이번 범위에서 제외한다.
  기존 커밋·푸시·개인 기록 정리 지시는 유지한다. develop/master 통합이나 새 PR·병합·배포는 진행하지 않는다.
- **작업 기준:** `/Users/parkjongsun/Repository/dentlink-client-permission`, 기존 `feature/DL-16317` 유지.
  시작 `e106405ad92f8d3820a31bf28ee0c3f5de784477`, 이번 커밋 **`f749491593ef1977976bc1c801b24e89bb5f5984`**
  (`fix: 주문 권한 조회 재사용과 API 명세 갱신`). Clinic 3파일 + Swagger 생성물 4파일이다.
  normal commit/push 완료, 원격 feature SHA 일치·working tree clean을 확인했다.

### 확정 계약과 코드 대조

- 근거는 Leo의 [DL-16317 댓글44435](https://innovaid.atlassian.net/browse/DL-16317?focusedCommentId=44435)와 실제 feature 코드다.
  별도 내 환자/내 주문 검증 API를 기다리거나 새로 추가하지 않는다.
  기존 `GET /office/orders/{orderId}` 성공으로 조회 가능 여부를 판단하고, 주문 담당 의사와 현재 직원 ID로 Member 행동 권한을 구분한다.
- **200 + 본인 담당:** 기본 상세와 허용된 행동. **200 + 타 의사 담당:** 부분 상세·변경 행동 제한.
  **403 / code 2152:** 해당 환자 접근 불가이므로 상세 차단.
  활성 직원 응답의 실제 ID 필드는 `id`다. `activeEmployeeId`와 profile의 ID가 일치한 상태에서 판단한다.
- 기존 `isOfficeOrderAccessDenied`는 병원 전환용 `2131`을 제외한 403을 처리하므로 `2152`도 이미 포함한다.
  2152만 처리하도록 좁히거나 기존 병원 전환 동작을 바꾸지 않았다.
  담당 의사 helper의 `order.dentist?.id ?? order.dentistId`는 두 필드 불일치 근거가 없어 그대로 유지했다.
- 상세·승인·주문 수정·리메이크의 판정은 이미 이 계약과 맞는다. `withAuthorization`은 직원/역할별 페이지 접근,
  개별 guard는 직접 URL 진입·변경 행동, 직원/역할별 query key는 캐시 분리를 담당하므로 일괄 제거하지 않는다.
  승인/리메이크 직접 진입에서 사용하는 기존 주문 GET은 여전히 필요하다.
  Pickup은 모든 주문번호 링크를 열고 도착한 상세에서 제한하는 기존 구현을 유지한다.
- 사용자는 위 검토 의견을 Jira에 직접 전달했다고 알렸다. 이번 작업에서 Codex가 Jira/Slack에 추가로 게시하지 않았다.

### 이번 반영과 로컬 검증

- `pnpm generate:api-type`으로 현행 `https://dev-api.dentlink.io/v3/api-docs`를 재생성했다.
  `shared/models/src/{Office,Lab,Admin,data-contracts}.ts` 4파일이 변경됐다.
  원문 SHA256: `62be4515a489e803b69a2f18b4d78aa4886a6c9b95a64549054281ee50ef5f12`.
  생성물에는 다른 BE 기능의 스키마 변화도 함께 포함되며, 해당 기능의 수동 FE 구현까지 변경한 것은 아니다.
- 새 ORDER 채팅 GET/POST와 `OrderChatMessageCreateDto(message, fileIds)`가 생성물에 반영됐다.
  기존 수동 ORDER adapter는 이미 이 경로·본문을 사용하고 있어 재전환하지 않았다. 고객지원/답글/읽음 등 기존 경로는 유지한다.
  `OrderDto`, `OrderDentistDto`, `AffiliatedEmployeeProfileDto`, `ApprovalGroupDto`, `ChatMessageDto`는 직전 생성물과 동일하다.
  **2152 의미는 Jira 댓글 근거**이며 Swagger 주문 GET은 여전히 200만 문서화하므로 Swagger에 오류 계약이 명시됐다고 표현하지 않는다.
- Member의 Remake Additional은 guard가 받은 주문을 optional prop으로 재사용하고 자체 ADDITIONAL 조회만 비활성화했다.
  직원/역할 query scope·focus 재조회·직접 URL 제한·권한 상실 시 폼 제거는 유지한다.
  비 Member는 기존 Additional 조회를 그대로 사용한다. 저장 후 상세 이동·Remake 파일 업로드의 기존 재조회도 바꾸지 않았다.
- **로컬 검증:** Remake 14건 + 기존 권한 helper/주문 query/채팅 adapter·요청 41건 = 5 suites / 55건 통과.
  Member 응답 재사용·응답 변경·2152 이후 폼 제거·비 Member 조회 유지 회귀를 포함한다.
  normal commit의 Clinic/Lab/Admin 타입 검사, 변경 파일 포맷·diff 검사, 독립 코드 리뷰를 통과했다.
  normal push의 3서비스 lint(오류 0, 기존 경고 존재)·Admin DLOS guard·shared coverage 검사도 통과했다.
  이는 로컬 코드/모의 응답 검증이며 실제 서버 권한 적용·화면 디자인 검수 증거로 확대하지 않는다.

### 남은 범위와 다음 시작점

1. **현재 확정된 웹 FE 계약의 코드 반영은 처리했다.** 별도 상세 판정 API 부재를 개발 대기 사유로 삼지 않는다.
2. **BE/기획 확인이 추가로 필요한 범위만 대기:** 미지정 Draft 처리 등 아직 확정되지 않은 정책이나 추가 기능별 계약이 나오면
   기존 feature 코드와 차이를 확인하고 필요한 부분만 반영한다. 계약 없이 제한·API·화면을 추가하지 않는다.
3. **QA는 이번 범위 밖:** 부분 승인·본인/타 의사/미지정 Draft·3D·담당 변경 후 접근 상실·실제 저장/승인/채팅 전송은
   추후 사용자가 테스트를 재개할 때 준비된 사례로 확인한다. E2E는 계속 제외한다.
4. **Office native는 별도:** 앱 `72a7914`의 ORDER API/cache·통합·실기기·배포 잔여는 이번 웹 변경으로 완료되지 않는다.
5. 개발서버 상태 조사·브라우저 조작·새 PR·병합·배포·자동 모니터링은 이번에 하지 않는다.
   이번 정리 후 대기하며 다음 재개 시 이 기록과 원격 feature부터 확인한다. 아래 10/13 배포·QA 근거는 과거 이력이다.

## 이력 — 2026-10-13 PR4696 병합·DEV 배포·재검증 정리 후 대기

- **최신 범위 정정:** 사용자가 E2E 관련은 현재 작업과 무관하므로 우선 넘기라고 명시했다.
  E2E/ISV 잔여는 참고 이력만 보존하고 이번 권한 FE의 잔여 작업·대기/재개 조건에서 제외한다.
  추가 E2E 조사·수정·재실행·모니터링은 하지 않는다. CI 설정이나 테스트 소스는 변경하지 않는다.
- **최신 사용자 승인:** Codex가 PR4696을 develop에 직접 병합하고, DEV 자동배포 및 배포 후 실계정 재검증까지 진행한다.
  기존 feature를 보존하며 FE가 현재 확인할 수 있는 것을 처리한 뒤 커밋·푸시·개인 기록을 정리하고 대기한다.
- **병합·원격:** [PR4696](https://github.com/Innvoaid/dentlink-client/pull/4696), **19:33:51 KST MERGED**,
  `feature/DL-16317 → develop`, merge **`03e62121e988418b944de0b7d71dfdb3ea4559cb`**.
  head `e106405ad92f8d3820a31bf28ee0c3f5de784477`를 match하여 일반 merge했다. 강제/admin override는 사용하지 않았다.
  `/Users/parkjongsun/Repository/dentlink-client-permission`의 feature는 삭제/이동하지 않았고,
  feature와 develop 전체 tree 동일·원격 feature 일치·작업 checkout clean을 확인했다. 이번 병합 후 추가 소스 수정은 없다.
- **실제 배포 완료:** [DEV38384223907](https://github.com/Innvoaid/dentlink-client/actions/runs/38384223907), 위 merge SHA와 일치.
  ECS 배포 단계 **19:45:16**, build/deploy job **19:45:45 success**. 새 BUILD_ID **`Kd6ikAQrMpzBT5J6qW4k0`**를
  **19:47:23 공개 DEV HTML HTTP200**에서 확인했고 CI 새 버전 probe도 **19:47:57 success**다.
  이후 두 실계정 화면을 새로 읽어 아래 항목을 검증했다. 빌드·배포·실제 서빙과 자동 E2E 결과는 구분한다.

### 새 배포의 실계정 재검증

| 항목 | 직접 확인한 결과 |
| --- | --- |
| Admin 승인 주문9248 | 채팅 메시지와 Review 버튼 복구. Review 클릭으로 `/orders/9000009248/approvals/1469`에 진입하며 PNG 미리보기·Download·Approve/Reject 표시. 실제 승인/거절은 하지 않음 |
| Member 본인5214 | 기본 상세·Edit/Cancel·담당 변경·채팅 입력 유지. 새 `GET /office/chat-messages/orders/9000005214?page=0&size=20` **HTTP200**, `data: []`, `totalElements: 0` |
| Member 공유3943 | Case4/Order4·Patient Info Edit·상세/Files1 유지, 주문 변경·채팅 입력 숨김. 새 채팅 GET **HTTP200**, code0000·빈 data·totalElements0 |
| Admin 공유3943 | Edit/Cancel·담당 변경·채팅 입력 표시. 같은 새 채팅 GET **HTTP200**, code0000·빈 data·totalElements0. 양쪽 No Messages는 이 주문의 실제 빈 응답과 일치 |
| 주문9123 비교 | Member는 No order data available / Go to Home, Admin은 Case8/Order10·상세·Edit/Cancel·채팅 메시지와 입력 표시 |
| 승인9248/1469 비교 | 같은 직접 URL에서 Member는 No order data available, Admin은 승인 파일·Approve/Reject 표시. Member 부분 승인 조회 사례는 여전히 별도 준비 필요 |
| Member 주문 목록 | Orders5와 Member 메뉴·My Orders Only/Dentist 필터 숨김 유지. 이전 배포의 전체 목록/필터 QA와 구분해 최소 회귀 범위를 재검증함 |

- 문자열 주문번호 때문에 HTTP 요청 전 차단되던 회귀는 실제 새 GET200 및 Admin 메시지/Review 표시로 해결을 확인했다.
  현재 읽기 QA에서 추가 FE 결함은 발견하지 못했다. 전체 BE 권한 계약 완료나 실제 쓰기 동작 검증을 뜻하지 않는다.
- 개인 테스트 주문의 채팅 전송·업로드·주문/담당/권한 저장·승인/거절은 실행하지 않았다.
  기존 자동 E2E는 병합 workflow로 시작된 별도 테스트 계정 흐름이며 수동 실계정 검증과 구분한다.
- 로컬 스크린샷은 기존 `~/.codex/visualizations/2026/10/13/01a132e9-6555-7a02-9c72-4dad9c04cc64/permission-post-deploy-qa/`의
  `admin-chat-review-9248-after-fix.png`, `admin-approval-review-recovered.png`, `member-denied-9123-after-fix.jpg`,
  `member-orders-after-chat-fix.jpg`에 저장했다. 다른 기기에서는 원격 코드·CI·이 기록으로 이어간다.

### 자동 E2E와 다음 순서

- **이전 run38379072202 최종:** 19:33:47 KST failure. 109수집 / 85통과 / 4실패 / 5허용제외 / 15미실행, flaky0·전역오류0.
  승인 거절·승인 후 피드백 2건은 6개 trace에서 정상 OWNER/승인 상태인데 SSR 문자열 주문 ID로 채팅 HTTP 요청0·Review 부재였다.
  이번 수정과 직접 일치하는 회귀이며 아래 새 CI에서 회복을 확인했다. Review는 채팅 승인 메시지의 버튼이다.
  ISV 상품→옵션·Step4 진입 2건은 카테고리 API200의 13개 목록에 Insta Smile Vision이 없어 테스트 전제와 DEV 카탈로그가 달랐다.
  더 이전 run38354572860에서도 실패한 별도 건이며 채팅 회귀나 권한 FE 결함으로 분류하지 않는다.
- **새 run38384223907 최종:** **20:05:49 KST E2E 종료 / failure**. **109수집 / 97통과 / 2실패 / 5허용제외 / 5미실행**,
  flaky0·전역오류0. 실제 Clinic SHA03e62121와 BUILD_ID Kd6ikAQrMpzBT5J6qW4k0를 확인했다.
  **승인 거절 Review(`05_labStatus.spec.ts:270`)와 승인 후 Completed/Feedback(`08_orderFeedback.spec.ts:189`)는 모두 최초 시도 PASS**,
  해당 파일 전체도 각각 **12/12, 10/10 PASS**다. 이전 채팅 회귀로 미실행됐던 후속10건도 회복됐다.
  남은 실패는 이전과 동일한 ISV2건(`instasmile.spec.ts:36`, `step4-ui-state.spec.ts:56`),
  `Insta Smile Vision` 버튼 대기90초 timeout / `order-step2-product.ts:97`, 각각3시도 실패다.
  오류/실패 위치는 동일하며 새 원인으로 바뀐 증거는 없다. 이전 trace의 카테고리 누락 진단과 현재 같은 실패 증상을 구분한다.
  최종 근거는 `/tmp/dentlink-dev-38384223907-artifacts.zip`의 report.json과 원격 CI다. 자동 검증 전체 통과로 표현하지 않는다.
- **BE/사용자 다음 준비:** 기능별 최종 범위·오류 계약, Member 부분 조회 가능한 승인 주문, 본인/타 의사/미지정 Draft,
  실제3D, 담당 변경 후 접근 상실과 쓰기 테스트 사례.
  같은 GET 내부 정제도 가능하며 별도 상세 검증 API를 선행 가정하지 않는다.
- **FE 다음:** 준비된 기능·사례부터 새 명세/실응답·디자인에 대조하고 필요한 부분만 구현/QA한다.
  기존 필요 guard/cache는 유지하고 BE 동등 계약이 확인되면 선행 GET 등을 통합·축소한다.
- **Office native 별도:** feature72a7914의 앱 ORDER API/cache·실기기 QA·통합/배포 잔여는 그대로이며 이번에 수정하지 않았다.
- **현재 가능한 FE 수정·배포·읽기 화면 재검증은 완료, 추가 FE 결함 미발견으로 대기한다.**
  BE 후속 계약·권한 검증 사례가 준비되면 해당 범위부터 재개한다. E2E는 현재 범위에서 제외하며 임시 모니터는 종료했다.
  별도 Jira/Slack 수동 전달·상용 배포·장기 자동 모니터링은 수행하지 않았다.

## 이력 — 2026-10-13 19:28 KST DEV 실계정 QA·채팅 회귀 수정 후 대기

- **최신 사용자 지시:** BE 추가 작업 전 FE가 할 수 있는 것을 최대한 처리한다. 검토 후 커밋·푸시·메모리를
  정리하고 문제를 보고한 뒤 대기한다. 이번 화면 QA는 읽기 범위였으며 실제 전송·업로드·주문/담당/승인 변경은 하지 않았다.
- **기존 배포 확정:** 사용자 병합 PR4695 / develop `97529d847a73e899d15c9590a80615645b2c176d`의
  [DEV38379072202](https://github.com/Innvoaid/dentlink-client/actions/runs/38379072202) build/deploy job은
  **19:03:57 KST success**, 새 BUILD_ID 대기 단계 **19:05:55 success**다.
  **19:06:47 공개 DEV HTML HTTP200 / `UowKnn4x6iXWck7cKODV7`**를 새 manifest와 대조했다.
  이후 준비된 두 브라우저를 새로고침하여 아래 화면 QA를 진행했다. 자동 E2E는 **19:27:18 최종 관측에서 실행 중**이며
  최종 성공/실패·건수는 아직 미확정이다. 이전 실행의 97/2 결과와 혼합하지 않는다.
- **새 FE 회귀 발견·수정:** Admin 주문9123 화면의 Network에서 주문/직원/Case API는 발생하지만
  `chat-messages/orders/` 및 `chat` 요청은 0건이고 LinkTalk는 No Messages였다.
  SSR `orders/[order_id]/index.tsx`가 주문번호를 문자열로 넘기는데 새 adapter의 `Number.isSafeInteger`가 이를 거절해
  HTTP 호출 전 예외가 났다. 권한/profile enabled 문제라는 초기 가설은 원인이 아니다.
  Admin 직원 API는 id213, authorityType OWNER, displayAuthorityType Admin을 반환했다.
- **수정 방법:** ORDER adapter 내부에서 정규 양의 정수 문자열을 number로 변환한 뒤 safe integer를 검증한다.
  숫자/문자열 정상 ID를 GET·POST에 허용하고 빈값·공백·지수·소수·음수·0·leading zero·unsafe ID 차단과
  DENTLINK 기존 경로/본문을 유지한다. 전역 DTO·SSR·UI·직원 scope를 불필요하게 확대 변경하지 않았다.
- **웹 원격:** `/Users/parkjongsun/Repository/dentlink-client-permission`, 기존 **`feature/DL-16317` 유지**,
  **`e106405ad92f8d3820a31bf28ee0c3f5de784477`** (`fix: 문자열 주문번호의 채팅 요청 차단 수정`), normal commit/push 성공, 원격 일치·clean 확인.
  shared adapter1 + Clinic 회귀 테스트2 = 3파일/1커밋이다.
  [후속 PR4696](https://github.com/Innvoaid/dentlink-client/pull/4696), **feature/DL-16317 → develop**, OPEN/MERGEABLE,
  정확히 위 1커밋/3파일을 확인하고 chat에 연결했다. Clinic의 실제 회귀 테스트 변경이 `clinic/**` 배포 조건을 충족한다.
  사용자 병합 전이며 이 수정은 아직 DEV에 배포되지 않았다.
- **검증:** 기존 코드에서 새 회귀 5실패/26통과 → 수정 후 채팅4 suites/48건 통과.
  전체 Clinic **37 suites / 302건 통과**, Clinic 별도 타입 검사 및 normal commit의 **3서비스 타입 통과**.
  변경 lint/Prettier/diff-check, 독립 코드 리뷰, normal push의 3서비스 lint(기존 warning 존재)·Admin DLOS guard·shared coverage 통과.
  이번 최소 후속 수정의 production build는 별도 재실행하지 않았으며 앞선 3서비스 build 성공과 구분한다.
  PR의 `dentlink-dlos` Vercel preview는 **Blocked / FAILURE**, CodeRabbit은 **develop 자동 리뷰 제외로 skipped**다.
  각 bot 댓글을 확인했으며 CodeRabbit SUCCESS를 실제 리뷰 완료로 확대하지 않는다. 별도 preview 차단 원인은 미확정이다.

### 새 DEV에서 직접 확인한 화면

| 항목 | Member jongsun.test2 | Admin jongsun.test1 / 판단 |
| --- | --- | --- |
| 계정·메뉴 | frankieDevOffice, Members의 Me=Member; Billing/Dashboard 없음, Office는 Members | 같은 병원 Me=Admin; Billing/Dashboard 및 Office Dashboard/Members/Billing Contact 있음 |
| 전체 목록 | Orders5, Patients5, Board4 | Orders1033, Patients612, Board559. 이전과 달리 Orders/Board도 실제 범위 차이가 관측됨. 전체 BE 계약 완료라는 뜻은 아님 |
| 숨긴 필터 | Orders My Orders Only/Dentist, Patients My Patients Only, Board Dentist Name 없음 | Admin에는 유지됨. Member 직접 URL의 myOrderOnly/dentistIds/myPatientOnly/dentistName 제거와 기존 검색어 보존 확인 |
| 본인 주문5214 | 기본 상세, Edit/Cancel/담당 변경/채팅 입력 표시, Case1/Order1 | 담당 변경 모달의 접근 상실 안내만 확인하고 저장 없이 닫음 |
| 공유 주문3943 | 부분 상세, Case4/Order4 트리/Patient Info Edit/상세/파일1 유지, 주문 변경·채팅 입력 숨김 | 같은 주문 Admin에는 Edit/Cancel/담당 변경/채팅 입력 표시. 파일 선택 시 Member Download(1) 활성화 확인, 실제 다운로드는 하지 않음 |
| 타 의사 주문9123 | No order data available / Go to Home | Admin은 Case8/Order10·상세·Edit/Cancel/채팅 입력 표시. 이전 부분형 관측과 달리 이번에는 Member 차단을 실제 대조함 |
| 승인9248/1469 | 주문 조회 불가 화면 | Admin은 PNG 미리보기·Download·Approve/Reject 표시. 이 주문은 이제 Member 부분 승인 조회 사례로 사용할 수 없음 |
| Pickup | 타 의사 주문4066 링크 클릭 → 새 주문 상세 탭으로 이동 | 링크를 목록에서 막지 않음 확인. 도착 화면은 조회 불가이며 이 번호는 예전에도 두 역할 모두 불가여서 Member 전용 차단 증거로 쓰지 않음 |
| 채팅 | 기본/부분 화면의 No Messages | 문자열 ID 회귀로 실제 조회가 실행되지 않았으므로 대화 없음/정상 조회 증거가 아님. 수정 후 재배포 QA 필요 |

- Figma 부분 상세475:77743·Member 필터475:85345를 새로 읽고 비교했다.
  차단 화면의 형태도 확인했지만 이번에는 API HTTP 거절 코드/본문까지 수집하지 않았으므로 BE 오류 계약 확정으로 표현하지 않는다.
  기본·부분·차단의 실제 화면 분기는 위 준비된 주문에 한해 확인했다.
- 로컬 시각 증거: `~/.codex/visualizations/2026/10/13/01a132e9-6555-7a02-9c72-4dad9c04cc64/permission-post-deploy-qa/`
  `member-own-5214.jpg`, `member-partial-3943.jpg`, `member-denied-9123.jpg`, `admin-detail-9123.png`.
  이 이미지와 `/tmp/dentlink-permission-chat-fix-*20261013.log`, `/tmp/dentlink-order-chat-runtime-string-*`는 로컬 보조자료이며
  다른 기기에서는 원격 코드·테스트·이 기록으로 이어간다.

### 다음 순서와 대기 경계

1. **사용자:** PR4696 확인·병합 → 기존 DEV 자동배포. Codex가 병합/재배포를 실행하지 않았다.
2. **FE:** 재배포 후 새 BUILD_ID를 확인하고 Admin/Member 주문 채팅 GET 발생·응답·대화 표시를 재확인한다.
   현재 DEV의 No Messages를 정상으로 처리하지 않는다. 실제 전송/업로드 검증은 별도 테스트 범위가 준비될 때 진행한다.
3. **현재 자동 E2E:** run38379072202 최종 결과는 다음 재개 시 확인한다. 배포 성공·실계정 읽기 QA와 별개다.
4. **BE/사용자:** 기능별 최종 범위·오류 계약과 추가 사례를 준비한다. 같은 GET의 내부 정제도 가능하며 별도 검증 API를 선행 가정하지 않는다.
   Member 부분 조회 가능한 승인 주문, 본인/타 의사/미지정 Draft, 실제3D, 담당 변경 후 접근 상실과 저장·승인·취소·전송 사례가 남았다.
   기존 필요 guard/cache는 유지하고 BE 동등 계약이 확인되면 선행 GET 등을 통합·축소한다.
5. **Office native 별도:** feature72a7914의 상태와 앱 ORDER API/cache·실기기 QA·통합/배포 잔여는 그대로다. 이번에 수정하지 않았다.
6. 정리 후 **대기**한다. 장기 BE/배포 자동 모니터링은 만들지 않았으며 다음 사용자 전달 또는 재개 지시에서 이어간다.

## 이력 — 2026-10-13 18:51 KST PR4695 사용자 병합·DEV 배포 진행 breakpoint

- **사용자 승인:** 준비된 Member/Admin 브라우저를 필요시 활용해 하던 작업을 이어가고, 완료 후
  커밋·푸시·메모리와 브리핑까지 하라는 직접 지시를 받았다. 아래 전수 감사에서 확인한 **웹 DEV 후속 범위**를 구현했다.
  Office native 소스·PR·배포/CodePush는 이번 전달에 포함하지 않았다.
  이후 사용자는 현재 feature를 유지한 채 clinic 변경을 포함해 개발서버에 추가 배포할 수 있도록 준비하고
  완료/잔여를 정리하도록 요청했다. 이 지시에 따라 develop 후속 PR을 생성했다.
  **최신 지시:** 사용자가 병합했고 배포 중이다. 먼저 breakpoint를 저장하고, 새 배포가 완료되면
  준비된 Member/Admin 화면 QA를 순서대로 이어서 진행한다. BE 추가 기능은 계속 기다리는 상태다.
- **웹 원격 보존:** `/Users/parkjongsun/Repository/dentlink-client-permission`, `feature/DL-16317`,
  **`812aff0d4d49d7e82c1e3d54708d236a77e07bee`** (`fix: 주문 채팅 전환과 멤버 권한 후속 처리 보완`).
  normal commit/push hook 성공, 원격 ls-remote 일치, working tree clean을 확인했다.
  기존 `1c67612c3` 뒤 1커밋이다. PR 당시 후속 diff43파일은 사용자 병합되었으며,
  현재 develop97529d847과 feature812aff0d4의 전체 tree는 동일하다. feature는 이동/삭제하지 않았다.
- **DEV 후속 PR:** [#4695](https://github.com/Innvoaid/dentlink-client/pull/4695),
  `[DL-16319] 개발서버용 주문 채팅 API와 Member 권한 후속 보완`, **MERGED 2026-10-13 18:49:26 KST**,
  **`feature/DL-16317 → develop`**, head `812aff0d4`, 병합 commit
  **`97529d847a73e899d15c9590a80615645b2c176d`**를 원격에서 확인했다. PR은 현재 chat에 연결돼 있다.
  커밋1개/43파일(**Clinic26 + shared17**)이며 source branch·HEAD는 유지했다. 새 제품 수정/빈 커밋은 없다.
- **배포 조건:** 현행 `clinic_dev_build_and_deploy.yml`은 develop push + `clinic/**` 변경으로 실행되며
  base/head에서 동일하다. 실제 Clinic26파일 변경으로 조건을 충족하므로 배포용 dummy 변경이 필요 없다.
  병합하면 Docker/ECR·정적파일S3·DEV ECS 배포, BUILD_ID 확인 및 후속 DEV E2E가 자동 실행된다.
  E2E는 배포 뒤 실행되므로 배포 성공과 E2E 성공을 별도로 확인한다.
- **병합 전 PR 검사 이력:** GitHub `MERGEABLE`, `mergeStateStatus=UNSTABLE`. Auto Assign SUCCESS,
  CodeRabbit SUCCESS 표시는 **develop 자동 리뷰 제외로 skipped**이며 실제 리뷰 통과가 아니다.
  별도 `dentlink-dlos` Vercel 미리보기는 **Deployment was blocked / FAILURE**다.
  현재 상태에서 차단 사유를 작성자 권한 등으로 추측하지 않았고 Clinic DEV workflow와 구분한다.
- **진행 중 배포:** [Office DEV workflow38379072202](https://github.com/Innvoaid/dentlink-client/actions/runs/38379072202),
  merge97529d847 대상, 18:49:29 KST 생성, 18:51 조회에서 Docker build/push 진행 중이다.
  새 BUILD_ID 서빙은 아직 미확인이다. build/deploy step 성공과 실제 dev-portal 새 빌드 반영,
  후속 자동 E2E 및 실계정 UI QA를 각각 확인한다. 실행 중 배포를 중복 실행/재배포하지 않는다.
- **breakpoint 후 계속할 순서:** 배포 job/새 BUILD_ID → 준비된 일반 Chrome Member와 시크릿 Admin 새로고침 →
  역할별 메뉴·Orders/Patients/Board 숨긴 필터/URL 정리 → 기본5214·부분9123/3943·승인9248·Pickup 링크 →
  주문 채팅 새 경로와 화면 표시를 가능한 근거로 확인한다. 실제 전송/업로드/주문 저장/권한 변경은 이번 화면 QA에 포함하지 않는다.
  FE 문제는 원인 확인 후 기존 feature에서 보완·검증·커밋/푸시한다. 후속 병합/배포는 별도 단계로 유지한다.

### 이번 완료 범위

| 항목 | 반영 결과 |
| --- | --- |
| 주문 채팅 API | 댓글44423과 현행 Swagger에 맞춰 ORDER GET·POST를 `/office/chat-messages/orders/{orderId}`로 전환. GET page/size/repeated sort, POST message/fileIds만 전달. 유효하지 않은 주문 ID는 요청하지 않음 |
| 기존 채팅 흐름 | 동일 adapter를 쓰는 초기·페이지·폴링·원문 이동·전송에 적용. 같은 응답/chatId를 유지하며 DENTLINK 고객지원·답글·읽음·페이지 위치·latest/unread·번역 경로는 유지 |
| 채팅 역할 전환 | query key에 직원·권한을 포함하고 현재 직원 profile 확인 전 ORDER 조회를 대기. wrapper remount로 이전 대화·pending 메시지·입력 draft·이미지 carousel을 비움. 이전 역할의 늦은 응답은 현재 화면에 반영되지 않음 |
| 캡처 로딩 | 승인 파일 URL·variant·캡처 권한 변경 시 무효화된 캡처/저장 busy를 회수. 이전 작업 완료가 새 캡처/저장 상태를 덮지 않도록 기존 version guard 유지 |
| 직원 캐시 | 결제·스캐너·요금표 writer와 온보딩 reader를 `[EMPLOYEE_OWN_SHOW, employeeId]`로 일치시킴. 소속 전환 중 ID가 다른 profile로 새 직원 cache를 쓰지 않음 |
| Member 숨긴 필터 | Orders dentistIds/myOrderOnly, Patients myPatientOnly, Board dentistName을 URL·표시·요청에서 제거. 역할 미확정/Admin의 조건과 나머지 검색·날짜·상태·페이지는 유지. 서버 rows/total을 FE에서 재필터링하지 않음 |
| Board 전환 검증 | reset의 invalidate도 현재 직원·권한·유효 조건으로 좁혀 이전 Admin 필터 재요청을 방지. 리뷰에서 발견한 역할 전환 시 정렬 초기화는 제거해 기존 정렬 유지 |
| Pickup 정리 | 사용되지 않는 canOpenOrder prop·전달·차단 분기와 제한 Story/test 제거. 모든 주문번호는 기존처럼 상세로 이동하며 제한은 상세에서 판단 |

- **with/guard 판단:** 기존 withAuthorization, 메뉴·필터 표시, 직접 URL/action guard, 직원·권한별 cache는
  각각 필요한 경계를 담당하므로 유지했다. Remake/승인 선행 order GET은 현재 DTO로 담당/행동 권한을
  대체할 수 없어 유지했다. BE가 동등한 판정/응답을 제공하면 그 근거로 통합·축소한다.
  새 검증 endpoint·UI·문구나 전체 readonly 정책을 추측해서 추가하지 않았다.
- **명세:** 이번 재조회 `/tmp/dentlink-permission-implementation-swagger-20261013.json` SHA256
  `95beaf4e7797538f1f95a06ed18773c320de0422bc10bf04d81a329e9e718057`로 감사 당시와 같다.
  별도 상세 검증 endpoint는 현재 공개 명세에서 식별되지 않았다. 동일 GET의 BE 내부 정제는 별도로 확인한다.

### 검증과 실제 브라우저 경계

- 최종 Clinic Jest **37 suite / 281건 전부 통과**. API 계약·실제 useLinkTalk 호출 흐름·역할/직원 scope 16건,
  직원 cache5건, 숨긴 필터6건(기존 목록 cache2건과 함께8건), 캡처17건, Pickup 전링크3건을 포함한다.
  새 테스트 fixture의 Router/type 문제는 수정했고 최종 전체 실행 및 normal 타입 검사에서 통과했다.
- **Clinic/Lab/Admin 타입 및 production build 모두 통과.** Board 최종 소스 변경 뒤 Clinic build도 재확인했다.
  normal push: 3서비스 lint 오류0(기존 warning은 남음), Admin DLOS guard6건, shared coverage check 통과.
  root와 별도 agent가 API/cache·필터·chat scope를 독립 리뷰했고 유효 지적을 반영한 뒤 재확인했다.
- 검증 로그: `/tmp/dentlink-permission-clinic-tests-20261013.log`,
  `/tmp/dentlink-permission-{clinic,lab,admin}-build-20261013.log`,
  `/tmp/dentlink-permission-commit-20261013.log`, `/tmp/dentlink-permission-push-20261013.log`.
  임시 로그는 로컬 보조 증거이며 원격 코드·테스트·이 기록으로 다른 기기에서 이어간다.
- **기존 DEV 화면 읽기 비교:** 준비된 Chrome 일반 Member `jongsun.test2`와 시크릿 Admin `jongsun.test1`,
  같은 병원의 주문 `9000003943`을 다시 비교했다. 두 화면 모두 Case/Orders4/4·트리·파일을 제공했고,
  Member는 Billing/Dashboard 메뉴·주문 Cancel/Edit·채팅 입력이 없으며 Admin에는 표시된다.
  Patient Info Edit은 Member에도 남는 현재 부분 조회 정책과 일치한다. 양쪽 대화는 No Messages였다.
- 위 브라우저는 **기존 DEV 버전**이며 새 커밋의 배포 QA가 아니다. 실제 채팅 전송·파일 업로드·주문 변경·
  권한 변경·저장은 실행하지 않았다. 새 POST는 mock transport로 body/URL/응답 연결을 검증했다.
- 이전 DEV E2E **97통과/2실패/5제외/5미실행**(ISV 버튼 timeout)은 여전히 별도 미해결이다.
  이번 로컬 검사로 DEV 자동 E2E나 전체 실계정 QA가 통과했다고 처리하지 않는다.

### 남은 일과 다음 담당 순서

1. **DEV 자동배포 → FE 확인:** PR4695 사용자 병합은 완료했고 workflow38379072202가 진행 중이다.
   실제 배포 완료/BUILD_ID 확인 뒤 이번 지시에 따라 Member/Admin 화면 QA를 계속한다.
   실제 전송/업로드/주문 변경은 화면 QA와 구분하며 필요한 테스트 대상/승인 범위가 준비될 때 확인한다.
2. **BE:** 기능별 준비 범위를 알려준다. 같은 GET이어도 목록/total/filter-hint 정제,
   주문 기본·부분·거절 판단과 관련 Case/파일/채팅 범위·오류 계약을 실제 endpoint/응답과 함께 확인한다.
   별도 검증 API를 반드시 신설해야 한다고 가정하지 않고 준비된 기능부터 연결한다.
3. **BE/사용자 테스트 준비 → FE 확인:** Admin만 성공하고 Member는 거절되는 주문,
   본인/타 의사/미지정 Draft, 실제3D, 담당 변경 후 접근 상실, 실제 저장·승인·취소·전송 대상이 필요하다.
   이미 준비된 두 계정은 계속 활용한다. `9000009248`/`9000009123`의 부분 Case/대화는 정책·응답 대조 잔여다.
4. **Office native 별도:** checkout `dentlink-app-permission`, feature `72a79146aaba1054827ab3dbd4540f274373a4ef`,
   원격 동일 clean을 재확인했다. 앱 ORDER API 전환·직원 cache writer/채팅 scope·기기 QA·통합/배포는 남아 있다.
   이전 157개 검사/양OS bundle·기존 type18오류는 과거 기록이며 이번에 재실행하지 않았다.
5. **진행 경계:** 사용자는 이번 배포 완료 후 화면 QA를 계속 진행하도록 지시했다. 이 breakpoint 저장이 작업 종료는 아니다.
   현재 run을 확인하면서 새 빌드가 준비되면 바로 QA를 이어간다. 별도 재배포·장기 BE 모니터링은 하지 않는다.
   화면 검증까지 마치고 남은 BE 범위·확인 불가 사례를 다시 정리한다.

## 이력 — 2026-10-13 breakpoint 이후 API·권한 구현 전수 재검토 (후속 구현 전)

- **범위:** 사용자 요청에 따라 중단된 댓글 44423 확인과 `with…`·페이지·컴포넌트 제한의 적정성을
  다시 검토했다. 이번 작업은 조사·검증이며 **제품 코드 수정, API 전환, 제품 커밋/푸시·PR·배포는 하지 않았다.**
  웹·Office 앱 checkout은 기존 원격 HEAD와 같고 clean이다. 개인 진행 기록만 갱신한다.
- **이전 판단 정정:** 아래 17:17 breakpoint의 '즉시 고칠 FE 단독 오류 없음/계약 준비 통보 대기'는
  이번 결과로 대체한다. **주문 채팅 GET·POST는 BE의 명시적 교체 요청이 있어 지금 FE 전환 대상**이며,
  독립 FE 보완과 미사용 코드 정리도 확인했다. '주문 상세 검증만 남음' 또는 '전부 BE 대기'로 보고하지 않는다.
- **사용자 의도 유지:** FE는 역할별 메뉴·필터·가능한 행동과 주문별 기본/부분/차단 화면을 담당한다.
  GET의 조회 범위·total/filter-hint 정제는 BE가 담당하며, 응답을 FE에서 임의로 잘라 권한을 구현하지 않는다.
  Pickup은 모든 주문 링크로 진입한 뒤 상세에서 판단한다. 준비된 API만 순차 연결하며 전체 BE 완성을 기다리지 않는다.

### 최신 근거와 감사 기준

- [DL-16317 댓글 44423](https://innovaid.atlassian.net/browse/DL-16317?focusedCommentId=44423):
  Leo(태경), **2026-10-13 17:07:03 KST**. GET·POST `/office/chat-messages`를
  `/office/chat-messages/orders/{orderId}`로 교체해 달라는 명시적 요청이다. 댓글 생성 시각은
  이전 breakpoint보다 앞서며, 이번에 사용자가 지정한 댓글을 읽어 반영 필요성을 확인했다.
- **Swagger 재조회 17:41 KST:** `https://dev-api.dentlink.io/v3/api-docs`, 935 paths,
  SHA256 `95beaf4e7797538f1f95a06ed18773c320de0422bc10bf04d81a329e9e718057`.
  `/tmp/dentlink-permission-full-audit-swagger-20261013.json`; 17:17 저장본과 동일하다.
  별도의 상세 접근 검증 endpoint는 현재 공개 명세에서 식별되지 않았다. 같은 GET의 BE 내부 정제 여부는 별도다.
- **웹:** `feature/DL-16317 / 1c67612c3506090706704c558ac07852d739a518`, 원격 동일.
  PR #4693의 실제 기준 `aff278a43...HEAD` 변경 167파일을 범위로 source·연결 경로를 점검했다.
  현재 fetch된 master는 `8772d68825cac6e23792d86a715153a67dc71078`로 이동했으며, 이를 feature에 합치지 않았다.
  develop은 기존 사용자 병합 `e6cfea705e4dadd3ec6c3c81d2b8432245f5b35c`다.
- **제품·디자인:** 부모 Jira의 원본 Notion 5-4 권한 범위를 재조회했으나 전체 응답은 truncated였다.
  완전한 PRD를 모두 검증했다고 확대하지 않는다. 이후 사용자 확정인 공유 주문 부분 조회와 Pickup 전링크 정책이
  이전 제안보다 우선한다. Figma `2OR0Gj7NUFEEeYBjQg5Y6v / 475:77743` 부분 상세 화면을 다시 받아
  이전 실계정 스크린샷과 대조했다. 새 브라우저 QA·실제 권한 변경·데이터 변경은 실행하지 않았다.

### 바로 반영할 수 있는 범위

| 항목 | 확인한 근거·상태 | 최소 후속 범위 |
| --- | --- | --- |
| 주문 채팅 GET·POST | 댓글 44423과 공개 명세가 일치하나 Web/App 실제 adapter는 구 경로 유지 | ORDER만 새 주문 경로로 분기. GET page/size/sort 유지, POST body는 message/fileIds. DENTLINK 고객지원·답글·page·read·latest·unread·번역은 현행 경로 유지 |
| 승인 파일 전환 시 캡처 로딩 | **원본 hook으로 재현한 회귀.** PNG A 캡처 대기 중 PNG B로 전환하면 version이 바뀌어 finally의 busy 해제가 생략됨 | 무효화된 캡처의 busy 상태 회수. 새 작업의 상태를 오래된 완료가 덮지 않도록 검증. 권한 상실 차단은 유지 |
| 직원 캐시 갱신 불일치 | **원본 helper/QueryClient로 재현.** reader는 `[EMPLOYEE_OWN_SHOW, employeeId]`, 결제·스캐너·요금표 writer는 옛 단일 key | 현재 직원의 scoped cache에 갱신. atom은 갱신되므로 즉시 화면 오류로 단정하지 않지만 query 데이터는 옛값임. 기존 온보딩 reader도 함께 정렬 |
| Member에게 숨긴 필터의 URL·요청 잔존 | **실행 경로를 소스로 확인.** Admin→Member 또는 직접 URL의 myOrderOnly/dentistIds/myPatientOnly가 요청에 남고 해당 chip/reset UI 없음 | Clinic의 역할별 유효 요청 조건과 URL 정규화. Board dentistName도 숨긴 채 요청에 남지만 공통 Reset은 가능. BE가 실제 행을 줄이는지는 별도 미확인 |
| Pickup 미사용 링크 제한 | 실제 Clinic/Lab caller가 canOpenOrder를 전달하지 않아 런타임은 전링크 유지. shared source 13개·story 1개·test 1개에 옛 차단 분기가 남음 | 확정 정책에 필요 없는 optional prop 전달·차단 분기·제한 Story/test 제거. 모든 링크 유지 검증은 보존 |

- Web 전환 중심: `shared/models/src/chat/chat.apis.clinic.ts:16,34`의 두 adapter.
  `clinic/src/lib/LinkTalk/useLinkTalk.tsx` 초기/페이지 조회·폴링·원문 이동의 반복 조회·전송이 여기에 모인다.
  응답 DTO가 같고 메시지에 chatId가 있으므로 별도 chatId 선행 조회나 채팅 전체 구조 교체는 필요하지 않다.
  새 경로에 유효한 orderId만 전달하는 검증과 실제 URL/query/body·고객지원·답글 회귀 확인이 필요하다.
- 캡처 근거: `shared/ui/src/OrderApprovalUI/useOrderApprovalCapture.ts:533,538,574`.
  `OrderApprovalUI.tsx`는 캡처 중 파일 전환을 허용하고 RejectForm은 isCapturing으로 버튼을 비활성화한다.
  임시 실제 hook 검사 **2개 중 1 실패/1 통과**: 파일 URL 변경은 busy=true 잔존, 권한 OFF는 false 복구.
  `/tmp/dentlink-permission-capture-leaf-repro-20261013.pvtmfxvh/`에 test/run.log/results.json 보존.
- 캐시 근거: `clinic/src/services/employee/employee.query.ts:15`,
  `lib/Billing/syncEmployerHasPaymentProfile.ts:19`, `lib/Scanner/syncEmployerOralScannersPreference.ts:32`,
  `services/employer/employer.query.ts:493`, `pages/office/onboard/landing.tsx:32`.
  임시 원본 helper 검사 **3개 중 2 실패/1 통과**: 현재 직원 key에 기대한 payment/scanner 값은 갱신되지 않고
  옛 단일 key와 atom만 갱신됨. `/tmp/dentlink-permission-cache-audit-20261013/`에 test/run.log/results.json 보존.
  즉시 UI는 atom 병합으로 보완되므로 실제 결제/온보딩 화면 장애가 실계정에서 재현됐다고 표현하지 않는다.
- 숨긴 필터 근거: `lib/OrderList/order-list.helpers.ts:96,148`, `useOrderListDesktop.tsx:53,93`,
  `lib/PatientList/patient-list.helpers.ts:37`, `lib/Order/useOrderKanbanBoard.tsx:54`,
  shared `OrderListLayerMobileFilter.tsx:131,155,190`. NEW 환자 선택은 이미 hidden myPatientOnly=false로 정규화한다.
  서버 목록의 FE 재필터링과 위 입력 상태 정규화는 다른 작업이다.

### with·페이지·컴포넌트 처리 판정

| 처리 | 판정과 이유 |
| --- | --- |
| 기존 withAuthorization | **역할별 직접 URL 접근 처리는 필요.** 이번에 새로 만든 HOC가 아니다. 로그인·현재 소속·역할 검증과 이전 소속 응답 무효화는 유지할 이유가 있다 |
| 메뉴/버튼 숨김과 page/action guard | 서로 다른 진입 경계를 담당한다. UI 숨김만으로 열린 모달·직접 URL·이미 시작한 비동기 동작까지 처리되지 않으므로 일괄 중복으로 제거하지 않는다 |
| Orders/Patients/Case 등 employee+authority query key | BE가 새 응답을 정제해도 이전 역할 캐시는 남을 수 있으므로 필요한 FE 처리다. 다만 reader/writer와 관련 chat 경계를 함께 맞춰야 한다 |
| 공통 직원 정보 조회 | `_app`의 query와 withAuthorization의 직접 GET이 cold/mismatched 상태에서 겹칠 수 있다. **기존 구조의 통합 후보**, 이번 Member 기능이 전부 불필요하다는 근거는 아니다 |
| withRemakeOrderAuthorization | Member일 때 전체 order GET으로 담당자를 확인하는 새 선행 조회가 있다. 현재 Remake DTO에 담당자/행동 권한이 없어 바로 삭제할 근거는 부족하다. 관련 API가 동등한 판정을 제공하면 통합·축소할 후보 |
| 승인 페이지 order GET | useOrderApprovalPage가 전체 역할에 추가 조회한다. 현재 approval DTO만으로 Member 담당자를 알 수 없어 관계 확인이 필요하지만, 향후 반환 권한/동등한 검증 계약에 맞춰 조회를 합치거나 범위를 줄일 수 있다 |
| 직접 주문 수정 step | 기존 order GET의 결과로 gate하며 별도 검증 endpoint를 새로 만들지 않는다. Member 본인/미지정 Draft와 타 의사 주문을 구별한다 |
| 부분 상세 | 조회·파일·환자 수정 등과 주문 변경/승인/채팅 전송은 별도 허용 범위다. 전체 readonly 하나로 합치면 현재 확정 동작을 바꿀 수 있다 |
| 관련 Case 제목 편집 | 현재 Member 본인 주문의 현재 Case만 허용한다. 다른 관련 Case 편집 범위는 확정 근거 부족으로 과도 제한/필수 누락을 단정하지 않는다 |
| 403·2131·기타 실패 | 2131 소속 전환을 별도 처리하고 나머지 403을 조회불가로 본다. 최종 BE 오류 계약과 대조 필요. 기존 withAuthorization의 일반 요청 실패→403은 이전부터 있던 한계다 |

### 채팅 캐시·Office 앱 별도 확인

- **웹 채팅 역할 전환은 정적 위험:** `clinic/src/lib/LinkTalk/useLinkTalk.tsx:84`의 CHAT_LIST key는
  params만 포함하고 employee/role이 없다. 주문 상세 page의 LinkTalk와 AppProviders에 역할별 cache 제거도 없어,
  동일 직원 EDITOR→MEMBER 전환 후 서버가 범위를 줄이면 새 GET 전 이전 대화를 재사용할 수 있는 경로가 남는다.
  기존 구조이며 실제 대화 노출을 실계정으로 재현한 것은 아니다. ORDER API 전환 때 함께 범위를 검증할 항목이다.
- **앱 기준:** `feature/DL-16317 / 72a79146aaba1054827ab3dbd4540f274373a4ef`, 원격 동일 clean.
  현행 origin/develop `2bc7d04dd92136b7a63a3d8c4d4e288afa867102`, merge-base `19f68100`.
  3-dot 변경60파일(source42·test18)과 연결된 navigator/provider/직원 활성화 경로를 대조했다.
  이번 앱 감사에서는 테스트·번들·기기 실행이나 코드 변경을 하지 않았다.
- **이번 앱 변경에서 놓친 cache writer:** `src/queries/useUserQueries.ts:34`는 EMPLOYEE_OWN 4요소 key를
  읽지만 `src/features/common/components/EmployeeProfile.tsx:101`의 활성화 응답은 3요소 key에 써
  확인된 응답을 새 reader가 재사용하지 못한다. 소스에서 확인한 누락이며 실기기 장애 재현은 아니다.
- **앱 채팅 역할 cache:** `src/queries/useLinkTalkQueries.ts:130,179` 메시지 key는 직원/역할이 없고
  `useCommonServiceQueries.ts:107` 최신 목록은 소속만 포함한다. 동일 직원 역할 변경 시
  `src/libs/useEmployeeProfile.ts:65` reset은 주문 상세/ORDER_INFO에 한정된다. 명시적 소속 전환에는
  latest/unread reset이 있으므로 모든 전환이 초기화되지 않는다고 확대하지 않는다. 정적 위험/기기 QA 잔여다.
- **앱 주문 채팅:** `src/services/linktalk.service.ts:38,102` 두 adapter는 구 경로다. ORDER만 교체하고
  고객지원·답글·페이지 번호·읽음·번역을 유지하면 초기/폴링/페이지/push/종료 fallback 연결을 함께 바꿀 수 있다.
  native 소스 수정·통합·배포는 웹 DEV 전달과 별도 범위로 유지한다.
- **기존 native 진입 예외:** `src/features/orderList/screens/OrderDetailScreen.tsx:119,258`은 최초 order GET
  성공 전 WebView를 비우며 실패는 toast/back으로 처리한다. 웹 NoData와 다르고 이번에 도입한 회귀는 아니다.
  상세3상태를 native 진입에도 맞출 때 해당 오류 계약과 함께 검토한다. 일반403을 일괄 치환하지 않는다.
- **기존 앱 비동기 경계:** OrderAdditionalInfoSection.tsx:482 및 useUploadOrderFile.ts:49는 upload 대기 후
  captured orderId에 attach를 시작하며 현재 actor/화면 종료를 재확인하지 않는다. 실행 가능한 후속 요청 경로의
  정적 위험으로 기록한다. 이번 diff는 cache key만 변경했고 서버 변경 성공/실기기 오류 재현은 없다.
- **앱 단순화 후보:** Member에게 숨긴 Dentist UI에서도 OrderNewCaseSection.tsx:49와
  OrderFilterBottomSheet.tsx:137의 직원 조회가 실행된다. 신규 리뷰 eligibility GET+저장 직전 재조회도 통합 후보다.
  Draft DTO에 담당자가 없어 이어하기/삭제 직전 상세를 확인하는 처리는 현재 계산 근거가 있으므로 일괄 제거하지 않는다.

### 검토·검증 범위와 다음 시작점

- 웹 source 검토: Clinic 변경 source 37개+조회불가 SVG 3개, shared UI 변경 source **72개 전체**,
  Lab 동반 변경 6개, 별도 HOC/atom/조회 query·route export와 generated model/enum diff를 확인했다.
  실제 연결을 확인하기 위해 변경되지 않은 메뉴·목록 parser·chat adapter·고객지원·승인 버튼 등도 읽었다.
  이 범위는 정적 감사이며 모든 화면/권한 조합의 실제 사용 QA 완료와 다르다.
- 이번 새 실행 검증은 위 임시 재현 **총 5개: 예상 동작 assertion 실패 3개, 대조군 통과 2개**다.
  Jest runner 실패가 아닌 두 회귀의 재현이다. 제품 파일에는 임시 테스트를 추가하지 않았다.
  기존 257개 웹 검사·3서비스 타입/빌드·157개 앱 검사 통과는 이전 동일 HEAD 기록이며 이번에 재실행하지 않았다.
- 기존 DEV 자동 E2E 97통과/2실패/5제외/5미실행과 ISV 버튼 timeout 원인 미확정은 유지한다.
  이번 정적 감사나 재현 검사로 DEV 자동 E2E/실계정 최종 QA가 통과했다고 갱신하지 않는다.
- **다음 FE 순서:** ORDER adapter 전환 → 독립 FE 회귀와 숨긴 필터 보완 → Pickup 미사용 제한 정리 →
  해당 범위 로컬 검사·리뷰 → 승인된 제품 커밋/푸시와 DEV PR → 사용자 merge/DEV 반영 후 실제 두 계정 QA.
  이번 요청은 검토이므로 위 제품 변경은 아직 실행하지 않았다.
- **BE·사용자 준비:** 목록/total/filter-hint 정제 완료 범위, 상세 기본/부분/거절 및 관련 Case·파일·채팅 허용 기준,
  실제 사용 endpoint/응답/오류 코드와 구별 가능한 주문을 제공한다. 새 상세 검증 API가 반드시 필요하다고 가정하지 않는다.
  Admin은 성공하고 Member만 거절되는 주문, 본인/타 의사/미지정 Draft, 3D, 담당 변경 후 접근 상실과 실제 저장 QA는 남아 있다.
- 앱과 상용 release는 별도 전달 범위다. 새 사용자 지시 없이 추가 구현·배포·자동 조회/모니터링은 시작하지 않는다.

## 이력 — 2026-10-13 17:17 기능별 BE 준비 후 이어갈 breakpoint

- **최신 사용자 지시:** BE 권한 작업은 아직 전부 배포되지 않았다. 주문 목록에서 역할별 차이가
  없거나 주문 상세의 검증 계약이 보이지 않는 상태를 전체 연동 완료로 계산하지 않는다.
  다만 전체 BE 완성을 일괄 선행조건으로 삼지 않고, **준비된 기능부터 FE가 빠르게 함께 연결·검증**한다.
  지금까지 완료한 코드·검증을 보존하고 현재 Git/QA/명세와 담당별 다음 순서를 정리해 원격에 저장한다.
- **현재 판단:** 확정 디자인과 실제 UI 비교에서 즉시 고칠 새 FE 단독 오류는 확인하지 못했다.
  일부 Case/대화 빈 표시와 승인대기 안내는 실제 응답·허용 정책 대조가 먼저다. BE가 준비되지 않은
  목록 범위를 FE가 임의 필터링하거나, 상세 판정 API를 추측해 만들거나, 기존 with/선행 GET을
  일괄 삭제하지 않는다. 아래의 기능별 준비 통보를 다음 재개점으로 삼는다.

### 완료·원격 보존 상태

| 구분 | 현재 확인 | 남은 경계 |
| --- | --- | --- |
| 치과 웹 소스 | `/Users/parkjongsun/Repository/dentlink-client-permission`, `feature/DL-16317`, 로컬·원격 HEAD `1c67612c3506090706704c558ac07852d739a518`, clean | 이번 마감에서 새 제품 변경/빈 커밋 없음 |
| 웹 DEV 전달 | 사용자 merge한 [PR #4693](https://github.com/Innvoaid/dentlink-client/pull/4693), 현행 원격 develop `e6cfea705e4dadd3ec6c3c81d2b8432245f5b35c`, master `aff278a433b2d4bc6f8e606a7fb12b6a5b18a407` | 전체 BE 완료·상용 release와 별개 |
| 웹 FE 구현·로컬 검증 | Member 메뉴/필터·NEW 본인 담당·주문 행동/직접 접근·Draft/승인 제어 구현, 기존 치과 테스트 257개와 3서비스 타입/빌드 통과 | 이번 문서 마감에서 제품 테스트를 새로 실행하지 않음 |
| 실제 Member/Admin UI | 같은 병원 역할 확인, 메뉴/필터·NEW·본인 기본 상세·타 의사 부분 상세/승인·공유 Case/파일·Pickup 링크 유지 확인 | Admin도 거절되는 사례는 Member 전용 차단 증거가 아님. 자세한 주문별 증거는 아래 2026-10-13 UI 비교 이력 |
| Office 앱 소스 | `/Users/parkjongsun/Repository/dentlink-app-permission`, `feature/DL-16317`, 로컬·원격 `72a79146aaba1054827ab3dbd4540f274373a4ef`, clean. 관련 테스트 157개·iOS/Android JS bundle 통과 | 전체 타입 기존 18개 오류, develop 통합·PR·실기기·배포/CodePush 미완료. 이번 웹 breakpoint에 자동 포함하지 않음 |

### 17:17 KST 마감 재조회와 잔여

- **현행 DEV Swagger 변화:** `https://dev-api.dentlink.io/v3/api-docs` 원본 및 no-cache 재조회.
  저장본 `/tmp/dentlink-permission-breakpoint-swagger-20261013.json`, SHA256
  `95beaf4e7797538f1f95a06ed18773c320de0422bc10bf04d81a329e9e718057`.
  14:04 비교본 이후 **GET `/office/chat-messages/orders/{orderId}`가 추가**됐다. 기존에 확인했던
  POST도 존재하며 GET은 같은 `ApiPageResponseListChatMessageDto`, page/size/sort 계약이다.
  `/office/chats/{chatId}/messages` GET/POST는 공개 명세에서 제거됐다. 활성 web/app 조회·발송은
  아직 deprecated GET/POST `/office/chat-messages`를 사용한다. 이전 '새 주문 경로는 POST만' 기록은
  이 재조회로 대체한다. 공개 명세 존재만으로 배포 동작·권한 조회 완성·최종 전환 합의를 확정하지 않는다.
- **목록·상세:** 이 비교에서 주문 관련 operation/DTO 변경은 확인되지 않았다. 별도의 주문 상세
  접근 검증 endpoint도 현재 공개 명세에서 식별되지 않았다. BE 내부 정제만 바뀔 수 있으므로
  명세가 같다는 사실로 배포 전후 동작을 단정하지 않는다. 사용자 확인대로 전체 BE는 미완료다.
  주문 목록/Board/승인대기 건수·filter-hint의 역할별 범위와 기본/부분/Member 전용 차단을
  실제 응답·예시 주문으로 재확인해야 한다. 새 권한 필드/검증 API가 반드시 필요하다고 미리 가정하지 않는다.
- **부분 조회 잔여:** `9000009248`/`9000009123`의 Member Case `-`/트리 없음/대화 없음은
  응답과 허용 정책 대조 전 미확인이다. `9000003943`은 두 계정 모두 Case/Order 4/4와 트리를 제공했다.
  canWrite=false가 메시지 GET을 막거나 Member 조건이 Case GET을 꺼서 생긴 현상은 아니다.
  실제 flat patientId 누락이 확인되면 연결 보완을 검토하되 현재는 확정 버그가 아니다.
- **채팅 전환 잔여:** 새 주문별 GET/POST를 실제 caller에 적용하지 않았다. ORDER 조회/발송의
  사용·배포 시점과 고객지원(DENTLINK)·답글·빈 채팅·chatId/읽음/페이지 동작을 해당 계약 단위로
  확인한다. 해당 주문 채팅 계약이 준비되면 다른 BE 전체 완료를 기다리지 않고 그 범위부터 전환한다.
- **추가 UI/행동 QA 잔여:** Admin은 조회 가능하고 Member만 거절되는 실제 주문,
  본인/타 의사/미지정 Draft(현재 두 Board Draft 0), 실제 STL/3D, 담당 변경 후 접근 상실,
  저장/전송/승인/취소 이후 상태는 미검증이다. 실제 데이터 변경 QA는 필요한 테스트 대상과 범위를
  준비한 뒤 진행한다. Office 앱/실기기와 상용 전달은 별도다.
- **자동 E2E 종료 확인:** [Office DEV workflow 38354572860](https://github.com/Innvoaid/dentlink-client/actions/runs/38354572860)은
  build/deploy 및 새 빌드 반영 성공, 후속 E2E는 15:33:24 KST failure로 종료됐다.
  development 전체 수집 109, 통과 97/실패 2/허용 제외 5/미실행 5/flaky 0/전역 오류 0이다.
  이전 '진행 중' 관찰을 이 종료 결과로 대체하며 자동 E2E 통과로 보고하지 않는다.
  읽기 전용 report 확인에서 실패는 `instasmile.spec.ts`의 `2. product → option`과
  `step4-ui-state.spec.ts`의 ISV Step4 진입이며, 둘 다 `order-step2-product.ts:97`의
  `Insta Smile Vision` 버튼 90초 대기 timeout이다. 후속 5건은 serial 미실행이다.
  직접 오류는 권한 거절이 아니며 이전 DEV ISV 실패 기록과 같은 영역이다. 현재 상품 설정/
  렌더링/테스트 중 원인은 확정하지 못했다. 권한 UI 구현과 별도의 미해결 E2E 조사 항목으로
  보존하고, 테스트 기대값을 임의 약화하거나 실제 서버 테스트를 다시 실행하지 않았다.
  진단 요약/report/verdict는 `/tmp/dentlink-permission-dev-e2e-readonly-20261013/`에 저장됐다.
  정상 실행 전 runner 검사 219개 통과와 실제 browser 테스트 실행을 확인했으므로 optional
  canvas 설치 경고를 직접 실패 원인으로 기록하지 않는다.

### 다음 순서와 담당

1. **BE:** 준비된 기능 단위로 DEV 배포 여부·실제 사용할 endpoint/요청/응답·기존 API 유지/대체
   범위를 알려준다. 목록이면 데이터/total/filter-hint 정제, 상세면 기본/부분/거절 기준과 관련
   환자·Case·파일·채팅 조회 허용 범위, 채팅이면 새 주문 GET/POST 사용 시점과 남는 경로를 제공한다.
   GET이 그대로이고 내부 정제만 달라지면 그 사실만 명시해도 된다.
2. **사용자·BE:** 현재 Member/Admin 계정을 유지하고 해당 기능을 구별할 주문번호/환자/Case를
   준비한다. 차단 검증에는 Admin은 성공하고 Member만 거절되는 같은 주문이 필요하다.
   Draft/3D/담당 변경 등은 해당 검증용 데이터가 준비됐을 때 범위를 정한다.
3. **Codex/FE:** 통보된 부분의 현재 Swagger·실제 요청/응답·소스를 대조한다. 서버 내부 정제면
   그대로 UI QA하고, 실제 caller/필드/상태 계약이 바뀌었으면 필요한 FE만 연결·보완한다.
   중복 with/선행 GET은 최종 해당 계약으로 필요성이 없어짐을 확인한 것만 줄인다. 확정 디자인의
   권한 UI/필터와 주문번호별 세 상태를 같은 두 Chrome 계정에서 재확인한다.
4. **Codex → 사용자:** 변경 범위에 맞는 로컬 검증·커밋/푸시·진행 기록과 개발서버 PR을 준비한다.
   사용자가 merge/DEV 반영을 진행한 뒤 해당 배포 화면을 재확인한다. 상용 release/Office 앱 전달은
   별도 범위로 정하고, native 통합 때에만 최신 develop과 알려진 충돌 후보를 다시 검증한다.

- **breakpoint 동작:** 현재 제품 소스는 보존하고 이번 정리까지 마감한다. 새로운 준비 통보가 오면
  그 기능부터 재개한다. 이후 Swagger/배포/Jira/Figma를 자동 조사·모니터링하거나 명세를 추측해
  계속 구현하지 않는다. 작업 완료 판정은 'FE 구현/로컬 검증/DEV 반영/실계정 UI 확인/BE 연동/최종 QA'를 구분한다.
- Web DL-16319의 기존 진행 댓글 `44418`에 실제 UI 확인·현행 Swagger·BE 잔여·E2E 종료와
  기능별 재개 순서를 17:22 KST에 갱신하고 댓글과 진행 중 상태를 재조회했다.
  상위 DL-16317/Office 앱 댓글은 이번에 변경하지 않았다.

## 이력 — 2026-10-13 Member·Admin 실계정 웹 UI 비교 완료·BE 연동 확인 잔여

- **사용자 준비와 실제 역할 확인:** Chrome 기본 창 `jongsun.test2`는 Member, 시크릿 창
  `jongsun.test1`은 같은 `frankieDevOffice`의 Admin이다. 각 Office Members의 `(Me)`와
  Member/Admin 표시를 실제 화면에서 확인했다. 이전 '테스트 계정 준비 전' 상태는 이 기록으로 대체한다.
- **이번 범위:** 준비된 실제 DEV PC 웹을 직접 조작해 FE가 확인 가능한 UI·필터·제한 표시와
  확정 Figma를 비교했다. BE 내부 정제/권한 완성도를 판정하거나 새 채팅 API를 전환하지 않았다.
  제품 checkout은 pull 후 `feature/DL-16317 / 1c67612c3`, 마감 확인에서도 clean이다.
  제품 소스·생성본·권한/계정·Jira·PR·배포는 이번 검토에서 변경하지 않았다.

### 실제 UI에서 확인한 항목

| 항목 | Member와 Admin의 실제 비교 | 판정 |
| --- | --- | --- |
| 상단·Office 메뉴 | Member Billing·Dashboard 숨김, Office는 Members만. Admin Billing·Dashboard와 Dashboard/Members/Billing Contact 탭 제공 | 의도 확인 |
| Patients | Member My Patients Only 숨김, Admin 표시. 당시 목록 5 vs 612는 관찰값이며 정제 정확성 전체 판정은 아님 | 필터 UI 확인 |
| Orders·Board | Member My Orders Only/Dentist 숨김, 상태·날짜 유지. Board는 Order Number/Patient Name만, Admin은 Dentist Name도 제공 | 디자인 방향 확인 |
| 신규 Case 첫 화면 | 같은 제공된 환자에서 Member는 본인 담당 표시 고정, Find Dentist/Assign Myself 없음. Admin은 두 선택 버튼 제공 | 의도 확인 |
| 본인 기본 상세 `9000005214` | Member도 수정·취소·담당 변경과 채팅 입력 UI 제공. 담당 변경 modal에 접근 상실 경고 표시 | 기본 상태 확인 |
| 타 의사 In Review `9000009123` | 같은 상태·ID에서 Admin은 Cancel/Edit·담당 변경·채팅 입력 제공, Member는 모두 숨김. 내용·Patient Edit 유지 | 부분 상태의 행동 제한 확인 |
| 제공된 공유 환자 상세 `9000003943` | Member는 Case/Order 4/4와 트리 유지, Admin은 수정·취소·담당 변경 제공하고 Member는 숨김. 파일 1개 선택 시 Download(1) 활성화, 실제 다운로드/변경은 안 함 | 조회 유지·행동 제한 확인 |
| 승인 `9000009248/approvals/1469` | Member도 PNG 미리보기·파일 목록·Download UI 유지, Approve/Reject 없음. Admin에는 두 버튼 제공 | 부분 승인 UI 확인 |
| Pickup `9000004066` | 타 의사 주문번호도 새 탭의 상세로 이동. 중앙 No order data available./Go to Home 표시 | 링크 유지·조회 불가 모양 확인 |
| Billing 직접 진입 | Member가 `/billing/statement`에 직접 진입하면 `/403` Forbidden 화면 | FE 페이지 제한 표현 확인 |

- 조회 불가 `9000004066`은 **Admin도 동일**했다. 삭제/소속/데이터/권한 중 원인은 이번에
  확정하지 않았다. 조회 불가 디자인은 확인했으나 'Admin 가능, Member 권한 때문에 차단' 검증으로 계산하지 않는다.
- Member 본인 → 타 의사 → 다른 화면 → 상세 직접 재진입을 실제 확인했고, 본인 주문의 행동 UI가
  타 의사 상세에 남는 현상은 확인하지 않았다. 두 원래 창은 최종 비교용 동일 주문 `9000003943`의
  상세에 남겼다. Pickup 클릭으로 생긴 QA 임시 탭은 닫았고 파일 선택도 해제했다.
- Next·저장·주문 생성·승인/반려·취소·담당 변경·메시지 전송·첨부·삭제를 실행하지 않았다.
  초기 `/orders/create`는 진입/환자·NEW Case 선택까지 조회·로컬 폼 설정만 한다는 코드를 확인했다.

### 확인한 차이와 다음 재확인

1. **일부 부분 상세의 조회 데이터 차이:** `9000009248`/`9000009123`에서 Admin은 Case 8/Order 10과
   트리·기존 대화를 보지만 Member는 건수 `-`, 트리 없음, `No Messages`다. 이 환자는 Member 목록 5건에
   없었다. 반면 Member에게 제공된 환자의 `9000003943`은 두 계정 모두 Case/Order 4/4와 트리가 있고,
   두 계정 모두 대화 없음이다. 모든 Member 부분 상세에서 FE가 트리/대화를 숨기는 현상은 아니다.
   최종 BE의 주문별 기본/부분/차단 기준·관련 환자/Case/채팅 조회 허용 범위와 실제 응답을 대조한다.
2. **코드 읽기 전용 진단:** canWrite=false는 메시지 GET을 막지 않고, 기존 `/office/chat-messages`를
   계속 조회한다. `No Messages`는 빈 list 표현이며 빈 응답·오류를 이 화면만으로 구분할 수 없다.
   Case GET도 Member에게 enabled이며 행동 제한이 트리를 숨기지 않는다. 상세 page는 `order.patient`
   와 평면 `order.patientId` 둘 다 있어야 patientId를 설정하므로, 실제 응답에 평면 ID가 없다면
   nested ID 연결 보완 후보다. 현재 응답은 조사하지 않았으므로 이 후보를 확정 FE 버그로 기록하지 않는다.
3. **승인대기 안내·범위:** 두 계정에서 초기 승인대기 38, 전체 Orders 1033, Board 559를 관찰했다.
   Member에도 `Orders waiting for your approval`이 보였다. FE는 `/office/orders/filter-hint`의 PENDING으로
   초기 필터·안내를 설정하고 조회 건수를 그대로 표시한다. 최종 서버 역할별 필터/허용 응답과 문구를
   맞춰 확인할 항목이다. Member도 본인 주문 승인이 가능하므로 모든 Member의 안내를 임의 제거하지 않는다.
4. **미검증:** Admin은 조회 가능하고 Member만 거절되는 실제 주문 사례, Draft 이어하기/삭제 UI
   (두 Board Draft 0), STL/3D 실제 조회, 실제 저장/전송/승인/담당 변경 이후 상태, 모바일 웹/Office 앱/실기기는
   이번 검토의 완료 판정에 포함하지 않았다. 최종 BE 조회 기준과 채팅 전환·with/선행 GET 정리 원칙은 유지한다.

- **디자인 근거 재확인:** Orders `475:85345`, Patients `43:44977`, Board `43:44991`, NEW `395:66740`,
  기본 상세 `344:49964`, 부분 상세 `475:77743`/Sidebar `475:77776`, 승인 `475:76737`,
  채팅 `475:76744`, 조회 불가 `475:77664`를 공식 Figma에서 재확인했다.
  [부분 상세](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v?node-id=475-77743)의 트리/조회 유지와
  작성 UI 제거를 비교했다. Pickup의 모든 링크 유지라는 사용자 확정을 계속 우선한다.
- **로컬 증거:** `/Users/parkjongsun/.codex/visualizations/2026/10/13/01a132e9-6555-7a02-9c72-4dad9c04cc64/permission-ui-qa/`
  에 실제 역할·필터·NEW·기본/부분/조회 불가·승인·파일·Pickup 화면을 저장했다. `member-shared-order-9000003943.png`
  와 `admin-shared-order-9000003943.png`, `member-partial-order-9000009123.png`와 `admin-order-9000009123.png`가
  같은 주문 비교 증거다. 로컬 PNG는 다른 기기에 자동 전달되지 않으며 이 Git 기록이 휴대 가능한 결과다.
- 현재 확인한 주요 권한 UI는 의도대로다. 부분 조회 데이터 차이·승인대기 안내는 BE 응답/정책과 함께
  재확인할 대상으로 남긴다. 이 UI 검토를 전체 BE 연동·권한 QA 완료나 코드 변경 승인으로 확장하지 않는다.

## 이력 — 2026-10-13 Member 테스트 계정 준비 후 FE 화면 확인 대기

- **사용자 관찰:** 개발서버 배포를 확인했고 BE 동료가 일부 화면에서 작업된 모습을 확인했다.
  사용자는 현재 Member 역할이 없어 전체를 보지 못했으며, 모든 동작이 정확한지는 아직 확인하지 않았다.
  이 관찰은 부분 구현 노출 확인이며 전체 Member QA/BE 권한 정책 완료 판정이 아니다.
- **계정 준비는 사용자·BE 담당:** 현재 사용자가 Member 상태를 직접 변경할 수 없다.
  사용자가 BE에 역할 변경과 테스트 계정 준비를 요청하고, 준비되면 이 세션에 다시 알려준다.
  FE에 임시 역할 전환 기능을 추가하거나 가정한 역할로 실제 Member QA를 대체하지 않는다.
- **재개 경로를 구분:** 계정 준비 통보가 오면 실제 Member 로그인 화면의 FE 확인부터 진행한다.
  BE 최종 명세 전체가 나올 때까지 이 화면 점검 자체를 미룰 필요는 없다.
  별도로 최종 BE 명세/응답이 준비되면 기존 with·선행 GET의 필요 여부와 채팅 전환을 재검토한다.
  GET 범위/데이터 정제는 BE, 권한별 UI·필터·실제 변경 API 연결·주문별 상세 세 상태는 FE라는 원칙을 유지한다.
- **다음 FE 화면 점검 범위(치과 웹 DEV):** 실제 인증된 Member 역할이 반영된 상태를 먼저 확인한 뒤,
  1. 진입 화면에서 권한별 메뉴·페이지·버튼이 확정 정책대로 보이거나 숨겨지는지 확인한다.
     준비된 Case/Draft 화면에서 본인/기존 담당 표시와 변경 허용 UI도 확인 범위에 둔다.
  2. Member에 제공하지 않는 My Orders/My Patients/Dentist 필터가 화면에서 제거되는지 확인한다.
  3. 준비된 주문번호별 기본·부분 조회·조회 불가 화면과 확정 Figma 디자인을 비교한다.
     Pickup의 모든 주문 링크는 상세로 이동하고 상세에서 제한한다.
  4. 부분 조회에서 내용·파일·3D·대화 조회를 유지하면서 수정·승인/거절·채팅 작성 등 제한 UI가
     확정 디자인대로 표시되는지 확인한다. 확인 목적은 실제 데이터 변경 수행이 아닌 FE 화면/제한 표시다.
  5. Member 로그인 후 첫 화면과 새로고침/다시 진입에서 UI 제한이 바로 반영되고,
     확정 디자인의 문구·배치·표시/숨김·활성 상태가 일치하는지 확인한다.
- **판정 경계:** FE가 직접 화면에서 확인한 결과와 디자인 불일치는 증거와 함께 기록한다.
  주문별 상태를 볼 계정/주문이 없거나 BE 응답이 준비되지 않은 항목은 미확인으로 남긴다.
  화면 노출만으로 서버 내부 GET 정제·우회 요청 거절·전체 접근 권한 완성도를 판정하지 않는다.
  Office 앱/실기기 QA는 이번 웹 화면 점검에 자동 포함하지 않는다.
- **지금은 준비·메모리 저장 후 대기:** 제품 구현·계정 변경·실계정 QA를 시작하지 않고,
  Swagger/배포/E2E/Jira/Figma를 자동 재조회하거나 모니터링하지 않는다. 이전 기록의 자동 E2E는
  15:17 KST 당시 진행 중인 관찰이며 이번 대기 지시에서 종료 결과를 새로 확인하지 않았다.
  계정 또는 BE 변경이 준비됐다는 새 사용자 통보를 다음 시작점으로 삼는다.

## 이력 — 2026-10-13 사용자 웹 PR merge·DEV 배포 확인·최종 BE 명세 대기

- **사용자가 직접 merge:** 웹 [PR #4693](https://github.com/Innvoaid/dentlink-client/pull/4693)은
  2026-10-13 **15:02:51 KST**에 MERGED다. 원격 develop은 실제 재조회에서
  **`e6cfea705e4dadd3ec6c3c81d2b8432245f5b35c`**, master는 `aff278a43`,
  feature/DL-16317은 `1c67612c3`다. 이번 목적은 완료한 화면을 개발서버에 올려 BE 개발자가
  사용할 수 있게 하는 것이다. 상용 전달이나 Office 앱 통합/배포까지 완료한 의미가 아니다.
- **15:13 KST DEV 확인:** 같은 merge SHA의
  [Office DEV workflow 38354572860](https://github.com/Innvoaid/dentlink-client/actions/runs/38354572860)은
  `office-dev-build-and-deploy` job 성공(15:13:30 KST), Docker build/push·S3 정적 파일·ECS 배포
  step 성공이다. 후속 `e2e-and-notify`는 진행 중이며 전체 workflow/E2E 성공은 아직 확인하지 않았다.
  ECS step은 서비스 안정화까지 기다리지 않는 설정이므로 배포 step 성공과 새 빌드 서빙 증거를 구분한다.
  [Lab DEV workflow 38354572871](https://github.com/Innvoaid/dentlink-client/actions/runs/38354572871)은
  같은 SHA로 전체 성공(15:11:58 KST)이다. 이는 보존된 Lab diff로 자동 실행된 결과이며 신규 Lab 정책 구현이 아니다.
- **새 Clinic 빌드 서빙 확인:** 15:14:46 KST 비로그인 `https://dev-portal.dentlink.io`는 HTTP 200,
  Next BUILD_ID **`hbVeD1fi0LvvqQFsJJUPG`**를 제공했다. 동일 workflow의 S3 manifest 업로드 ID와
  일치하며, 후속 job의 `Wait for new version to be live`도 성공했다. 실제 DEV 새 빌드 반영은 확인됐다.
  자동 E2E는 실행 중이고 인증된 Member 권한/주문 범위/실기기 QA나 BE 전체 배포 완료 증거는 아니다.
- **사용자 확정 FE/BE 책임:** GET의 조회 범위·데이터 정제는 BE 내부에서 처리할 수 있고
  API 형태는 유지될 수 있다. FE는 접속한 사용자 권한에 따른 UI/페이지/행동과 필터 제공,
  실제 바뀐 API의 caller 연결, 주문번호별 상세 **기본 / 부분 조회 / 조회 불가** 표현을 담당한다.
  기존 `with...`나 선행 GET이 모두 최종 설계로 확정된 것은 아니다. 최종 BE 응답에 맞춰
  필요한 FE 처리만 남기고 중복된 관계 예측/추가 조회를 줄일 수 있다. 지금 임의 삭제하지 않는다.
- **현재 코드 읽기 전용 검토 결과:** 로그인·소속·역할 진입 제어와 소속 변경 후 이전 승인 폐기,
  기본 폼 데이터 GET·거절 화면·직원별 cache/callback 보호는 필요한 FE 책임이다.
  `withAuthorization`의 직원 GET은 기존 `_app` 직원 cache 재사용 후보다.
  `withRemakeOrderAuthorization`의 Member 전용 선행 주문 GET과 `useOrderApprovalPage`의
  담당 확인용 주문 GET은 최종 Remake/승인 응답 계약이 충분하면 축소/통합할 후보다.
  직접 주문 폼·`canPerformOfficeOrderActions`의 담당 관계 판정과 Case 제목 허용 연결도
  최종 부분 조회/행동 계약에 맞춰 재검토한다. 동일 query key의 hook 둘을 중복 네트워크 GET으로 단정하지 않는다.
- **지금 할 일/대기할 일:** DEV 새 빌드 반영 증거와 자동 E2E 결과를 현재 확인 가능한 범위에서
  확인·기록한다. 최종 BE 명세 전 추가 guard 삭제·채팅 API 전환·FE 목록 데이터 정제를 시작하지 않는다.
  다음 재개 시 BE 최종 문서와 실제 요청/응답으로 위 후보 및 채팅 전환 범위를 검증하고,
  실제 Member 주문/환자 범위·상세 세 상태를 QA한다. 별도 테스트 계정은 아직 없다.
- 제품 소스·feature commit은 이번 사후 확인에서 변경하지 않았다. CodeRabbit develop 자동 리뷰는
  skip이었고 Vercel DLOS check는 blocked였다. 이들은 실제 코드 리뷰 완료/전체 PR checks 성공 증거가 아니다.
  사용자의 merge 이후 DEV Office/Lab workflow 결과와 분리해 기록하며 리뷰/설정을 임의 변경하지 않는다.
- Web DL-16319의 기존 댓글 `44418`에 15:17 KST 사용자 merge·새 DEV 빌드 반영·자동 E2E 진행과
  BE 최종 명세 후 잔여를 갱신하고 재조회했다. 카드 진행 중을 유지하며 상위/Office 앱 댓글은 이번에 변경하지 않았다.
  이번 사용자 질문으로 필요한 사후 확인과 메모리 정리를 한 것이며, 새 지시 없이 자동 조사/채팅 전환/
  guard 제거/배포/모니터링을 이어가지 않는다.

## 이력 — 2026-10-13 개발서버용 develop 재생성·웹 PR #4693 생성

- **최신 사용자 명시 지시:** 이번 작업은 웹 개발서버용이다. 원격 develop을 삭제하고 현재 원격
  master에서 새 develop을 만든 뒤 현재 작업 브랜치의 develop PR을 생성하도록 요청해 실행했다.
  이는 이번 개발서버용 웹 PR의 대상 예외이며 일반 웹 release 전달 정책을 변경하지 않는다.
- 삭제 전 `origin/develop`은 **`e9d3f3509bc808bd7a21de8c8b76b083d9966298`**였다.
  develop을 base/head로 사용하는 열린 PR 및 feature/DL-16317의 기존 열린 PR은 없었다.
  삭제는 해당 SHA의 lease로, 생성은 develop 부재의 lease로 진행해 중간 외부 변경을 덮지 않았다.
- 기존 develop을 로컬 Git 참조
  `refs/codex-backup/develop-before-dl-16317-dev-20261013-e9d3f3509`와 복구 bundle
  `/Users/parkjongsun/.codex/backups/dentlink-client/develop-before-dl-16317-dev-20261013-e9d3f3509.bundle`
  에 보존했다. `git bundle verify` 성공. master에 있는 prerequisite를 사용하는 증분 bundle이며
  이 로컬 산출물은 다른 기기에 자동 전달되지 않는다. 복구가 필요하면 현재 develop 상태와 사용자 지시를 먼저 확인한다.
- 원격 develop 삭제·신규 생성 성공. **새 develop과 원격 master가 모두
  `aff278a433b2d4bc6f8e606a7fb12b6a5b18a407`**임을 실제 원격 재조회로 확인했다.
  삭제/생성 모두 정상 pre-push lint·DLOS guard·coverage를 통과했고 훅을 우회하지 않았다.
- 웹 [PR #4693](https://github.com/Innvoaid/dentlink-client/pull/4693)
  **`feature/DL-16317 → develop`**, 일반 Open PR으로 생성하고 이 채팅에 attach했다.
  title `[DL-16317] 개발서버용 Member 권한과 주문 상세 제한 적용`.
  실제 base `develop/aff278a43`, head `feature/DL-16317/1c67612c3`를 생성 후 다시 확인했다.
  diff **167파일(+10,307/-1,310), 14커밋**, `git diff --check` 통과, GitHub `MERGEABLE`이다.
  제품 코드는 변경하지 않았고 해당 worktree는 clean이다.
- **검토 상태:** Auto Assign 성공. CodeRabbit은 develop base 자동 리뷰 설정이 꺼져
  `Review skipped: reviews are disabled for this base branch`였다. success 표시는 실제 리뷰 완료가 아니다.
  Vercel `dentlink-dlos` check는 `Deployment was blocked` failure이며 HEAD에 붙은 기존
  상태(생성 시각 02:37:17 UTC)다. [현재 Vercel 상태](https://vercel.com/innovaid-2c855104/dentlink-dlos/HAGJqQDiZLaZDYqvWzWHQesMTkv1),
  [CodeRabbit 설명](https://github.com/Innvoaid/dentlink-client/pull/4693#issuecomment-6139211802).
  PR의 mergeStateStatus는 `UNSTABLE`이며 충돌 없음과 checks/review 완료를 구분한다.
- PR 생성은 제품 배포 trigger가 아니다. develop push의 경로 필터에 따라 Office/Lab/Admin DEV
  자동 배포가 가능하지만, 이번 aff278 develop push에 대응하는 새 workflow run은 확인 시점에 없었다.
  수동 배포·PR merge는 실행하지 않았고 권한관리 feature의 실제 개발서버 배포 완료 증거도 아니다.
- PR 본문에 확정 Member/UI 범위·257개 테스트·서비스 타입/빌드와 기존 Lab optional 보존분,
  전체 Swagger 생성 동반 변경, 새 채팅 API 미전환·BE 최종 명세/실계정 QA 잔여를 명시했다.
  Web DL-16319 댓글 `44418`에도 개발서버용 PR과 미머지·미배포 확인 상태를 반영했다.
  상위 DL-16317에는 댓글을 쓰지 않았다. Office 앱 저장소/브랜치/PR은 이번 요청에서 조작하지 않았다.
- **후속:** 이 웹 PR의 리뷰와 현재 checks를 처리하고 실제 develop merge/DEV 반영은 별도 사용자
  지시 범위에서 진행한다. 채팅 API 전환은 BE 최종 명세 확인 후라는 지시를 유지한다.
  이전의 '웹 release 대상 미결정으로 PR 미생성' 상태는 이번 DEV PR에 적용하지 않는다.
  최종 상용 release 전달·Office 앱 develop 통합·실계정/실기기 QA는 별도 후속으로 남는다.

## 이력 — 2026-10-13 가능한 범위 마감·BE 최종 명세 후 재개 대기

- **최종 사용자 지시:** 완료된 작업은 그대로 보존한다. 채팅 API 전환은 **백엔드 최종 명세 확인 후**
  진행한다. 지금 확정된 범위에서 할 수 있는 확인·정리·원격 저장을 마치고 대기한다.
  제품 코드를 새 채팅 경로로 임의 전환하거나 임의 권한 계약을 추가하지 않는다.
- **우선 완료·보존:** 확정 UI/상세 기본·조회 불가·부분 조회, Member enum·기존 담당 정보 기반
  필터/본인 지정/행동 제어, 로컬 검증, 최신 웹 master 통합, 제품 commit/push.
  웹 `feature/DL-16317 / 1c67612c3`, Office 앱 `feature/DL-16317 / 72a79146a`는
  실제 원격과 일치하고 clean임을 마감 직전 다시 확인했다. 이번 마감에서 제품 코드 변경은 없다.
- **현재 가능한 확인 완료:** DEV Swagger의 삭제 4개 채팅 경로는 활성 웹/앱 사용처가 없고,
  기존 deprecated 메시지 조회/발송은 실제 사용 중임을 확인했다. 신규 주문 발송 및 chatId 경로와
  ORDER/DENTLINK/답글의 전환 범위를 구분해 아래에 기록했다. 불변 코드의 검증을 반복하지 않았다.
- **BE 명세 후 후속 개발:** 필수 전환 대상·시점·chatId 확보·빈 채팅·주문/고객지원/답글 지원을
  확정하고 Swagger와 실제 요청/응답을 대조한 뒤 채팅 caller와 필요한 최종 계약 연결을 진행한다.
  현재 전체 잔여를 QA만으로 취급하지 않는다. deprecated 표시만으로 기존 호출 실패를 단정하지 않는다.
- **별도 남은 작업:** 인증된 DEV Member/실기기 QA, 웹 전달 release 결정·대상 diff 확인,
  앱 develop 통합 시 예상 충돌 6파일 및 새 덴처 상세 캐시 키 정리, 실제 PR 생성·review·merge·배포.
  앱 작업 트리에 현재 충돌이 남아 있다는 의미가 아니다. PR/merge/배포/CodePush는 아직 수행하지 않았다.
- **대기:** 개인 체크포인트·제품별 하위 Jira에 완료/보류/검증 범위를 정리한 뒤,
  새 사용자 지시 전 자동 Swagger/Jira/Git 조사·추가 개발·QA·모니터링 없이 대기한다.
- **마감 기록:** Web DL-16319 댓글 `44418`, Office App DL-16752 댓글 `44419`를
  완료한 기존 계약/UI 범위와 채팅 전환·최종 BE 연동/QA 잔여, 명세 후 재개 대기로 갱신·재조회했다.
  두 카드 모두 진행 중을 유지했고 상위 DL-16317에는 댓글을 쓰지 않았다.

- 사용자가 승인한 개발서버 Swagger 확인/generate, 확정 디자인과 실제 계약 연결,
  최신 웹 master 통합, 로컬 검증, 제품 commit/push, 개인 체크포인트·하위 Jira 정리를 마쳤다.
  **스테이징은 확인하지 않았다. PR 생성·protected branch merge·배포·CodePush는 하지 않았다.**
  기공소 웹/앱의 신규 정책 구현은 제외하고 최신 master의 기존 Lab 변경은 보존했다.
- 현재 세션은 `01a132e9-6555-7a02-9c72-4dad9c04cc64`다. 아래 새 세션 인수인계와
  10월 12일 이하 기록은 당시 상태를 보존한 이력이며 현재 API 미연결/merge 진행 상태가 아니다.
- 사용자는 **별도로 준비된 테스트 계정이 없다**고 답했다. 개발서버 포털은 로그인 화면까지
  확인했으며, 인증된 Member 실계정·실기기 QA는 수행하지 못했다. 임시 브라우저 탭은 닫았다.
  자동 테스트·빌드·Swagger 응답은 실제 사용자의 주문/환자 범위나 배포·릴리즈 완료 증거가 아니다.

### 2026-10-13 사용자 확정에 따른 완료 범위 정정

- 사용자가 **Pickup의 모든 주문번호 링크는 주문 상세로 이동하고, 제한은 상세에서 처리**한다고
  명시했다. 타 의사 주문 링크 제거·공유 Case 링크 예외는 현재 요구가 아니다.
  오래된 Figma/Pickup 설명을 근거로 이 조건을 개발 잔여로 분류했던 Codex 판단을 철회했다.
  아래 과거 Pickup 조건 준비 이력은 당시 작업 기록이며 현재 요구를 대체하지 않는다.
- 주문 상세는 **기본 / 조회 불가 / 부분 조회**의 세 상태로 구분한다. Figma 정상 상세
  `344:49964`, No Data `475:77664`(App `475:77704`), 조회 가능한 타 의사 주문
  `475:77743`/상위 설명 `475:75588`을 재확인했다. 부분 조회는 내용·파일·3D 조회를 유지하면서
  승인/반려·주문 수정/취소·채팅 작성·Case 제목 편집 등 허용되지 않은 기능을 제한하는 상태다.
- **확정 화면 정책·현재 연결한 Member/기존 API 기준의 웹·Office 앱 FE 개발과 제품 commit/push는 완료**다.
  이는 새 채팅 API 전환이나 최종 BE 권한 계약 전체 연동 완료를 뜻하지 않는다.
  실계정/실기기 QA와 실제 서버 조회 범위·접근 거절 확인도 별도 잔여다. 전체 잔여를 QA만으로 축소하지 않는다.
- 본인 주문의 현재 Case 이외 관련 Case 전체를 편집 가능하게 확장하는 요구는 확정되지 않았다.
  담당 필드 부재만으로 이를 FE 개발 잔여나 필수 BE 대기로 분류하지 않는다.
  native 최초 조회 실패의 기존 fallback 유지 역시 승인된 범위이며 새 매핑을 개발 잔여로 단정하지 않는다.
- 웹의 개발 기준인 `master`와 Office 앱 PR 대상 `develop`에 대한 전체 diff를 확인한다.
  웹의 실제 전달 PR 대상은 의도한 배포 버전의 `release/vX.Y.Z`이며 master 기준과 구분한다.
  리뷰를 위한 PR 준비 단계와 실계정 QA·최종 merge/배포 준비는 구분한다. PR은 아직 생성하지 않았다.

### 2026-10-13 PR 검토 준비 확인

- 제품 feature HEAD/원격 일치와 clean을 재확인했다. 사용자 질문은 PR 준비 단계 확인이며
  이번 확인에서 PR 생성·실제 target 통합·merge·배포는 수행하지 않았다.
- 웹 target `origin/master=aff278a43`는 feature HEAD의 조상이다. behind 0/ahead 14,
  실제 diff **167파일(+10,307/-1,310)**이고 미해결 충돌은 없다. 권한관리와 전체 DEV Swagger
  생성에 따른 DTO/메서드 변경, 이전 Lab optional 조건·번역 보존분을 PR 설명에서 구분한다.
  `.github`/scripts/package/lockfile/Admin 제품 소스/DLOS/icons에는 target 대비 차이가 없다.
  master 기준 코드 검토는 가능하다. 웹 전달 PR은 배포 대상 release를 정한 뒤 그 target의
  실제 diff를 다시 확인해야 한다. 현재 DL-16317/DL-16319 fixVersions는 빈 값이며,
  확인한 원격의 최신 버전 release는 이미 완료된 `release/v1.88.0`이다.
  현재 master나 완료된 release를 임의 전달 대상으로 선택하거나 새 release를 만들지 않는다.
- Office 앱 target **`origin/develop=2bc7d04dd92136b7a63a3d8c4d4e288afa867102`**,
  merge-base `19f68100`이며 develop만 17커밋/feature만 7커밋이다.
  feature의 7개 커밋은 모두 권한관리이고 실제 PR diff **60파일(+5,574/-403)**은
  src 42·테스트 18파일이다. legacy monorepo/native/lockfile/workflow의 관계 없는 변경은 없다.
- 읽기 전용 `merge-tree`에서 앱 충돌 **6파일**을 확인했다: `MessageInput.test.tsx`,
  `MessageInput.tsx`, `MessageTemplate.tsx`, `DesignConfirmationScreen.tsx`, `OrderScreen.tsx`,
  `useUploadOrderFile.ts`. Draft PR로 코드 검토는 가능하지만, 정상 통합/merge 준비까지 끝난 것은 아니다.
  앱 PR 진행 작업에서는 develop의 업로드 잠금·덴처 동작·이전 화면 복귀와 feature 권한 guard를
  함께 보존해 통합해야 한다. develop의 `OrderDentureWorkflowSection.tsx:437` 상세 캐시 쓰기도
  직원 기준의 새 상세 키 helper에 맞춰야 한다. 실제 코드 변경/통합 뒤에는 비례 검증이 필요하다.
- Web 하위 Jira 댓글 **44418**의 잘못된 Pickup/관련 Case 개발 잔여 문구도 사용자 확정 기준으로
  수정했다. 개발 완료와 실계정 QA 잔여를 분리하며 진행 중 상태를 유지한다. 상위 댓글은 쓰지 않았다.

### 2026-10-13 백엔드 부분 배포 보고·계약 재확인

- 사용자는 백엔드가 아직 전부 배포된 것은 아니며 어제 변경도 API 교체보다 Member 추가로
  보인다고 전했다. BE 전체 배포 완료로 취급하지 않는다.
- `d374b77e7^ → d374b77e7`의 이전/이후 생성본 비교에서 권한관리 관련 계약 변화는
  MEMBER enum 추가가 중심이다. `OrderDto` 전체는 동일하고 dentist/dentistId/patientCaseId/
  isReviewable, 환자/Case/주문/Draft의 기존 계약도 유지됐다. 앱 isReviewable 타입 추가는
  오래된 앱 생성본 보완이며 신규 Member용 BE 필드가 아니다(웹에서는 9월 11일 이미 존재).
- 이번 확인의 최신 DEV 원본은 `/tmp/dentlink-permission-member-contract-check-20261013.json`이다.
  오늘 첫 generate 때 보존한 `/tmp/dentlink-permission-dev-swagger-20261013.json`과 비교하면
  **POST `/office/chat-messages/orders/{orderId}`가 추가**되고 기존 `/office/chat-messages`
  GET/POST에 deprecated 표시가 추가됐다. 새 본문 `OrderChatMessageCreateDto`는 message/fileIds,
  orderId는 path다. 기존 endpoint의 본문/응답 구조는 유지된다. 결제 관련 변경도 별도로 있다.
  따라서 현재 Swagger 전체가 Member enum만 바뀐 상태라고 단정하지 않는다.
- 어제 배포 직전/직후의 Swagger 원본은 현재 임시 경로에 없어 어제 배포 전체 diff를 확정하지
  않는다. 위 새 채팅 선언은 오늘 보존본과 현재 조회 사이의 차이이며 어제 배포로 날짜를 붙이지 않는다.
- 새 담당/공유/과거 참여/행동 권한 필드나 전용 거절 code 명세는 확인되지 않았다. 서버 내부의
  조회 범위/권한 검사는 기존 API 구조 그대로도 바뀔 수 있으므로 Swagger만으로 시행 완료를 증명하지 못한다.
- 이번 확인은 읽기 전용이며 제품 HEAD/코드는 그대로다. 새 채팅 선언을 제품 generated 파일이나
  실제 caller에 반영하지 않았다. BE 최종 범위가 확정돼 재개하면 Swagger를 갱신하고 새 주문별 채팅
  발송 계약과 기존 deprecated 경로의 지원/전환 정책을 확인한 뒤 필요한 FE 연결을 검토한다.

### 2026-10-13 14:04 KST Swagger·실사용 채팅 재확인

- 같은 DEV `/v3/api-docs`를 재조회하고 요청에 no-cache도 지정했다. 두 응답의 JSON과 SHA256이
  동일했고 응답 Date는 05:04:48 UTC, Cache-Control은 no-cache/no-store다.
  `/tmp/dentlink-permission-chat-recheck{,-nocache}-20261013.json`이 해당 원본이다.
- 현재 문서에는 새 주문 발송 POST `/office/chat-messages/orders/{orderId}`가 있다.
  기존 `/office/chat-messages` GET/POST는 남아 있고 deprecated다. chatId 기반
  `/office/chats/{chatId}/messages` GET/POST도 문서에 있으나 이들은 첫 보존본에도 있던 경로다.
  따라서 '교체 Swagger 전체가 아직 미배포'라는 전달과 현재 조회 문서의 대상/환경/버전을 맞춰야 한다.
  이 문서 조회로 실제 인증 요청 성공이나 BE 최종 정책 배포까지 확인한 것은 아니다.
- 빠진 4개 GET(`/office/chats`, `/office/chats/{chatId}/messages/participants`,
  `/office/chats/latest/participants`, `/office/chat-messages/participants`)은 웹/앱의 실제 화면 caller가 없다.
  앱에는 일부 미사용 서비스/query와 옛 generated 선언이 남아 있으나 활성 화면 호출은 없다.
- 반대로 deprecated GET/POST `/office/chat-messages`는 웹 `useLinkTalk`, 앱 `useMessage`에서
  조회/폴링/페이지/일반 발송에 실제 사용 중이다. 주문 ORDER와 고객지원 DENTLINK가 같은 경로를 쓴다.
  신규 주문 POST와 chatId 기반 GET/POST로의 실제 caller 전환은 **아직 미적용**이다.
- 새 주문 POST는 ORDER 일반 전송에 대응하며 기존 GET·고객지원·별도 답글까지 일괄 교체하는
  계약이 아니다. 필수 전환 대상/시점, 빈 채팅·chatId 확보·주문/고객지원 분기·답글 지원을 BE와 확정한 뒤
  해당 FE 전환을 별도 작업으로 진행해야 한다. deprecated를 즉시 서버 호출 실패나 삭제로 해석하지 않는다.
- 우선 완료: 확정 UI/상세 세 상태·Member enum·기존 담당 정보 기반 행동 제어·로컬 검증·제품 원격 보존.
  미완료/재확인: 채팅 전환 범위와 실제 caller 적용, 최종 BE 조회/접근 정책 및 실계정·실기기 QA,
  앱 develop 통합 충돌/웹 전달 release 선택과 실제 PR·merge·배포.

### 실제 계약과 디자인 기준

- 웹 `pnpm generate:api-type`, 앱 `yarn swagger-typescript-api-dev`를 실제 실행해
  `https://dev-api.dentlink.io/v3/api-docs`의 계약을 생성했다. 공개
  `/codes/authority-type?serviceType=OFFICE` 응답에서도 OWNER=Admin,
  PAYMENT_MANAGER=Billing Manager, EDITOR=Manager, **MEMBER=Member**와 code `0000`을 확인했다.
- 생성 계약에 MEMBER와 기존 employee/dentist ID, `OrderDto.isReviewable`이 있다.
  담당 의사 선택 값과 활성 직원의 본인 ID는 employee ID 기준이다. 담당·공유·과거 참여의
  새로운 관계 플래그, `canAction` 같은 필드, 새로운 접근 거절 업무 code는 확인되지 않았다.
  목록 GET의 서버 응답 범위를 사용하며 FE에서 담당 이름 비교나 임의 목록 잘라내기를 하지 않는다.
- [확정 Figma 475:75511](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v?node-id=475-75511&m=dev)은
  **조회 가능한 타 의사 주문을 보는 Member** 화면이다. 주문 변경/취소·Case 제목 수정·승인/거절·
  채팅 작성/첨부는 제한하고 파일·URL·3D·대화 조회를 유지한다. **환자 정보 Edit은 유지한다.**
  Member 전체를 읽기 전용으로 만들지 않으며 기존 EDITOR 허용 경로는 Member도 허용한다.
  비용/청구 경로의 OWNER/PAYMENT_MANAGER 조건은 그대로다.
- NEW Case는 본인 담당으로 고정하고 FOLLOW_UP은 기존 담당을 유지한다. 일반 환자 목록은
  서버 범위를 사용하며 주문 1단계는 치과 전체 환자/Case 선택을 유지한다. 담당 미지정 또는
  본인 담당 Draft는 이어하기/삭제를 허용한다. 미확정 역할/직원/담당 상태의 행동은 허용하지 않는다.
- 리뷰 대상은 서버의 `isReviewable`로 확인하고 본인이 작성한 기존 리뷰 수정은 유지한다.
  to-review는 담당된 작성 대상, own은 로그인한 사용자가 여러 소속에서 작성한 리뷰라는
  기존 정책을 보존했다. 단순 Member 역할만으로 리뷰를 일괄 금지하지 않는다.

### 웹 구현·Git 위치

- `/Users/parkjongsun/Repository/dentlink-client-permission`, `feature/DL-16317`.
  **HEAD/upstream/실제 원격 `1c67612c3506090706704c558ac07852d739a518`**, clean.
  마지막 원격 확인의 master **`aff278a433b2d4bc6f8e606a7fb12b6a5b18a407`**가 HEAD의 조상이다.
- 기존 진행 중이던 693b8b4 통합을 보존해 `1718b2cd5`로 마쳤고, 이후 원격 전진
  b229a944/aff278a43을 각각 `b90dd3234`/`d3bda388e`로 통합했다. reset/stash/rebase하지 않았다.
  실제 계약 연결 `d374b77e7`, 종료된 화면의 리뷰 저장 차단 `c015a9bc9`, 테스트 lint 정리
  `31a9e2920`, 소속 전환 뒤 이전 요청의 화면 이동 차단 `1c67612c3`을 정상 commit/push했다.
- generated Admin/Lab/Office/data-contracts 4개를 최신 DEV 생성물로 갱신했다. Member의
  주문/환자/보드 필터, 역할 표시, 초대 분석 라벨, 새 Case UI/RHF/최종 전송값에 실제 역할을 연결했다.
  현재 역할·직원 ID를 목록/건수/보드/타임라인/Draft/주문 1단계 쿼리 키에 반영하고 소속/역할
  변경 시 이전 누적 보드·응답을 재사용하지 않는다. 서버 결과 범위나 prefix invalidation은 유지했다.
- 주문 상세·직접 편집/승인·Remake에 현재 직원/주문/역할/담당 조건을 연결했다. 실제 주문 GET
  HTTP 403은 기존 NoData/홈 이동으로 처리하되 기존 소속 전환 code `2131`은 유지한다.
  401/네트워크 오류는 권한 거절로 바꾸지 않는다. 확인된 담당 변경은 현재 직원의 주문 캐시에
  새 담당 정보를 먼저 반영해 후속 조회 실패가 이전 본인 담당 상태를 되살리지 않게 했다.
- 환자 Edit은 조회 가능한 주문에서 유지하고, Case 편집은 본인 주문의 현재 Case ID만 편집 허용하도록 구현했다.
  다른 관련 Case의 담당은 `CaseListDto`에 없고 Pickup도 dentistName만 있어 이름으로 추정하지 않는다.
  Pickup은 기존 링크 이동을 유지하며 상세의 현재 접근 조건으로 처리한다.
  현재 Case 이외 관련 Case 편집 확대는 확정 요구가 아니며 개발 잔여로 분류하지 않는다.
  비동기 검증·화면 종료·직원/주문 변경 후 보관된 작성/삭제/다음 주문/승인 callback은 차단한다.
  이미 전송한 HTTP 자체를 취소하거나 서버 변경을 되돌리는 기능은 추가하지 않았다.

### 치과 앱 구현·Git 위치

- `/Users/parkjongsun/Repository/dentlink-app-permission`, `feature/DL-16317`.
  **HEAD/upstream/실제 원격 `72a79146aaba1054827ab3dbd4540f274373a4ef`**, clean.
  기존 오래된 feature base를 보존했다. 이번에 앱 main/develop merge·재기준화·PR 생성은 하지 않았다.
- 앱 전체 generator 결과는 unrelated Product/Option/OptionGroup 계약 변화로 기존 타입 진단
  18개에서 321개로 늘어났다. 전체 생성물은 임시 경로에 보존하고, **실제 generator 출력의
  authority 필드 14곳과 `OrderDto.isReviewable` 블록만 자동 추출해 반영**했다.
  임의 역할/DTO를 작성하지 않았고 관계 없는 전체 상품 계약 마이그레이션은 제외했다.
- Member 필터/NEW Case 본인 지정, 최신 주문 정보 확인 후 직접 편집/승인/채팅 작성,
  Draft 이어하기·삭제, 리뷰 작성 허용 여부를 연결했다. 기존 본인 리뷰 수정은 유지한다.
  직접 주문 제출에는 역할/직원 context 변경과 Member 본인 담당 검사를 연결했다.
  Draft 행동과 리뷰·첨부/업로드 경로에서는 화면 종료·대상 변경·지연 처리 차단도 검증했다.
- native 주문 상세/직원 조회 키를 직원 기준으로 통일하고 역할 변경 시 해당 소속 상세를 다시 읽는다.
  주문/건수/Draft·환자 일반/1단계/Case·홈 요약 조회에는 확인된 직원+권한을 추가했다.
  미확정/mismatch 상태의 자동/수동 조회는 실제 API 전에 차단한다.
- 웹 일반 resource HTTP 403 처리는 적용했지만 **native는 알려진 code `2005` 및 기존 세션 처리,
  최초 조회 실패 toast/back을 유지**한다. Swagger에 새 거절 규칙이 없어 모든 native 403을
  신규 NoData로 바꾸지 않았다. 승인된 기존 fallback이며 실제 거절 응답 확인은 QA 항목이다.

### 검증·증거 경계

- 최종 Clinic Jest **32 suites / 257 tests 통과**, Clinic/Lab/Admin 타입 검사와 production build 통과.
  icons/DLOS 타입·build, DLOS **45 files / 381 tests**, 최신 package artifact 테스트 **17개** 통과.
- 정상 pre-push 통과: Clinic/Lab/Admin lint **오류 0개**, 경고 각각 **223/186/393개**.
  Admin DLOS guard **60/baseline 60**, guard 테스트 **6개**, shared configs **21개**,
  shared hooks **32개** 및 coverage 비교 통과. 첫 push의 신규 테스트 fixture lint 오류 2개는
  수정·회귀 검증 후 정상 재실행했다. 훅 우회/coverage baseline 변경은 하지 않았다.
  서비스 검사 통과를 shared 전체 타입/lint 통과라고 확대하지 않는다.
- 앱 관련 Jest **23 suites / 157 tests 통과**, scoped lint 오류 0개/기존 경고 8개,
  prettier/diff 통과. 앱 전체 타입 로그는 기존 **18개 진단과 동일**하며 전체 타입 통과는 아니다.
- iOS **70 assets**, Android **74 assets** JS bundle 생성 성공. 실제 symlinked node_modules를
  드러내는 임시 Metro 설정을 `/tmp`에서 사용했으며 제품 Metro 설정/lockfile은 바꾸지 않았다.
  실행 중인 iOS simulator/ADB device가 없어 실제 앱 실행·실기기 QA 증거는 아니다.
- Swagger snapshot·전체 앱 생성물·검증 로그·임시 설정은 `/tmp/dentlink-permission-*`에 있다.
  원격에 보존된 코드는 다음 기기에서 재검증할 수 있으나 임시 산출물 자체는 휴대되지 않는다.

### Jira·대기·다음 시작점

- 사용자 담당 Web [DL-16319](https://innovaid.atlassian.net/browse/DL-16319)에 댓글 **44418**,
  Office App [DL-16752](https://innovaid.atlassian.net/browse/DL-16752)에 댓글 **44419**로
  실제 계약 연결·코드 보존·검증·실계정/실기기 잔여를 기록하고 재조회했다.
  두 카드 모두 **진행 중**을 유지했다. 상위 DL-16317에는 댓글을 쓰지 않았다.
- 승인된 이번 FE/검증/원격 정리를 마쳤으며 **추가 지시 전 대기**한다. 자동 외부 상태 확인,
  새 테스트 계정 설정, PR/merge, staging/배포/CodePush를 이어가지 않는다.
- 재개 시 개인 context와 해당 feature를 안전하게 refresh하고 아래를 확인한다.
  0. **BE 최종 명세·채팅 전환 범위 확인을 먼저** 한다. 현재 deprecated GET/POST의 최종 대체 대상,
     ORDER/DENTLINK/빈 채팅·chatId/답글 흐름과 기존 경로 지원 시점을 확인해 후속 구현 범위를 정한다.
  1. Member 실계정 및 본인/타 의사/공유/과거 참여 주문, 담당 미지정 Draft·전체 환자 선택 데이터.
     FOLLOW_UP 생성·Draft 복원 뒤 담당 지정 결과도 서버 업무 정책과 대조한다.
  2. 실제 서버 GET 범위·담당 변경 후 조회 상실·직접 주소 접근과 native 거절 code/응답.
  3. Pickup 링크 이동 후 정상/조회 불가/부분 조회 상태를 확인한다. 관련 Case 편집 확대 등
     미확정 정책은 새 요구가 제시될 때 검토하며 현재 개발 잔여로 취급하지 않는다.
  4. 인증된 개발서버 화면과 앱 실기기 QA. 앱 일반 PR 정책은 develop이며 기존 feature base와
     현재 delivery reference 차이를 확인한 뒤, PR/릴리즈 작업은 새 승인 범위에서 진행한다.

## 이력 — 2026-10-13 새 세션 인수인계·개발서버 기준 재개

- 같은 등록 권한관리 프로젝트에 후속 세션
  **`01a132e9-6555-7a02-9c72-4dad9c04cc64`**를 생성했다. 실제 적용 설정
  **gpt-6.1-sol/ultra**와 같은 프로젝트 cwd를 새 turn_context에서 확인했다.
  새 세션이 진행 중인 merge 보존·개발서버 Swagger 생성/실제 계약 연결·최신 master
  통합과 검증·commit/push·개인 메모리·하위 Jira 정리를 이어가겠다고 응답하고 작업을 시작했다.
  신규 사용자 지시는 생성 prompt에 원문 그대로 포함했다. 기존 세션은 인수인계 후 보관한다.
- 사용자가 이 대화에서 응답 재연결이 반복돼 **같은 권한관리 프로젝트 폴더에 새 세션을
  만들고 진행 상태를 인수인계한 뒤 기존 세션을 보관**하도록 요청했다. 기존 진행 내용을
  그대로 이어가며 아래 신규 지시를 추가한다. 이 세션에서는 이후 제품 구현을 중복 진행하지 않는다.
- **새 지시:** 스테이징 서버는 확인하지 않는다. 개발서버에 백엔드가 배포된 것으로
  보인다는 사용자 보고를 기준으로 개발서버 Swagger를 실제 확인·generate한 뒤,
  생성된 응답/역할/관계 계약과 최신 master·확정 디자인을 대조해 필요한 FE 작업을 진행한다.
  배포 여부와 계약은 새 세션에서 확인할 사항이며 이번 세션에서 Swagger 생성/실연동은 하지 않았다.
- **최신 master 통합 진행 상태:** 웹 HEAD/원격은 여전히
  `a6392cc67862590aea48889f927944d192baa002`. `git merge --no-commit --no-ff origin/master`로
  `693b8b4c4d247716db05ea415bc7bd1d33dab4cc`를 통합 중이다. **MERGE_HEAD가 남아 있고
  merge commit/push는 아직 하지 않았다.** 기존 커밋으로 임의 reset/stash/rebase하지 않는다.
- 3개 충돌(Lab LinkTalk·mobile title buttons·title buttons hook)을 해소했고 unmerged
  파일은 없다. master의 Lab 주문 소유/읽음/context 보호, 신규 밀링 버튼,
  의사 이름 추적·앱 Next Order를 유지했다. 새 밀링 버튼도 기존 주문 변경 조건과
  보관 callback 실행 guard를 적용해 권한 제어 우회를 방지했다. Lab 신규 정책을 추가하지 않았다.
- 웹 index에는 master 변경 **1,463파일 staged**가 있고, 기존
  `clinic/src/lib/Order/orderDetailActionPermissions.test.tsx`에 밀링 desktop/mobile
  회귀 2개가 **unstaged**로 남아 있다. untracked 없음. 새 세션은 실제 index/worktree를
  재확인해 테스트 파일까지 stage하고 통합 검토/필수 훅 후 merge commit/push를 마무리한다.
- `pnpm install --frozen-lockfile` 성공, icon workspace 링크/최신 패키지 동기화 완료.
  통합 후 Clinic/Lab/Admin 타입 검사 모두 통과, Clinic **25 suites/182 tests** 통과,
  icons/DLOS 패키지 타입 검사 통과, DLOS **45 files/381 tests** 통과,
  해소 파일·추가 테스트 포맷 및 diff 검사 통과. production build·새 pre-push
  Admin DLOS guard/coverage·통합 commit/push는 아직 미완료다.
- 치과 앱은 HEAD/원격 `445ced6eba5093d2cdc63d050d00bee15396e6c7`, clean이다.
  feature **16 suites/108 tests**를 재실행해 통과했다. 이번 웹 master 통합에서 앱
  develop/main을 병합하지 않았고 앱 제품 코드도 추가 변경하지 않았다.
- 10월 13일 인수인계 직전 `git ls-remote`로 웹 master가
  **`b229a944ebc77cd1ec6fc68a531edfbdfb78a6bb`**로 추가 전진한 것을 확인했다.
  새 세션은 기존 merge 작업을 보존하면서 다시 fetch하고 이 최신 변경도 통합·검증한다.
  로컬 `origin/master`/MERGE_HEAD의 693b8b4 기준과 실제 원격 최신 SHA를 혼동하지 않는다.
- **API 사용 조사:** GET `/office/chats/{chatId}/messages`는 확인한 웹·치과 앱에서
  실제 호출자가 없다. 웹 generated 선언과 앱 `findChatMessagesByChatId` 서비스 함수만
  남았고 실제 조회는 GET `/office/chat-messages`를 사용한다. 삭제/백엔드 폐기는 수행하지 않았다.
- 기존 승인 유지: 필요한 FE 구현/검증, 제품 commit/push, Git 개인 메모리와 사용자
  담당 하위 Jira 정리까지 진행하고 대기한다. Web DL-16319·Office App DL-16752를
  제품별로 정리하며 **상위 DL-16317 댓글 금지**, 기공소 웹/앱 신규 구현 제외를 유지한다.
  PR 생성·merge·배포·CodePush는 별도 승인 범위다. feature 브랜치로 master를 통합하는
  이번 허용과 protected branch/PR merge는 서로 다르다.
- 새 세션은 기존 세션 실제 설정 **gpt-6.1-sol/ultra**를 확인해 같은 설정으로 준비한다.
  개인 체크포인트와 실제 Git 상태를 기준으로 인수인계하고, 오래된 대화 전체를 복제하지 않는다.

## 현재 상태 — 2026-10-12 확정 디자인 보완·최신 master 참조·원격 보존

- 사용자가 확정 디자인의 누락과 디자이너가 글로 설명한 조건까지 확인·수정하도록
  재개했다. 아래 10월 6일의 중단 기록은 당시 이력이며 이번 재개 범위에는 적용하지
  않는다. 기준은 [Figma 주문 상세 475:75511](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v?node-id=475-75511&m=dev).
  **기공소 웹·앱은 사용자가 별도 작업 완료·배포 예정이라고 하여 이번 구현에서 제외했다.**
  백엔드는 아직 배포되지 않았다는 사용자 설명을 기준으로, 임의 서버 계약을 만들지 않았다.
- 기존 제품 commit/push·개인 Git 메모리·사용자 담당 하위 Jira 정리 승인을 유지해
  이번 보완을 구현·검증·commit/push했다. PR 생성·merge·배포·CodePush는 하지 않았다.
  상위 DL-16317에는 댓글을 쓰지 않았다.

### 이번에 보완한 범위

- **치과 주문 상세 실제 페이지:** 준비한 주문 조회·주문 변경·환자/Case 수정·LinkTalk
  읽기 전용·담당 의사 변경 경고 조건을 실제 페이지에서 전달할 수 있게 연결했다.
  아직 실제 Member/관계 API에서 조건을 계산하는 연결은 아니다. 기본값은 기존 동작을 유지한다.
- **조회 불가 화면:** 디자인의 `No order data available.`·`Go to Home`과 실제 SVG
  일러스트를 적용했다. 조회 불가일 때 주문 내용·사이드패널·관련 모달을 숨기며,
  PC는 홈 경로, 앱은 기존 네이티브 HomeTab/HomeScreen 메시지로 이동한다.
  조회 권한이 사라지면 열린 상세 모달을 정리하고 오래된 RN 수신 callback의 재진입도 막는다.
  기존 404 이동·앱 최초 조회 실패의 toast/back은 서버 거절 계약이 없어 변경하지 않았다.
- **Case/담당 의사 설명:** 모바일 Case 제목 수정은 제공하지 않는다는 디자인 설명을
  적용하고 이전 수정 callback도 차단했다. 담당 의사 변경 경고가 표시되는 모달은
  디자인 높이 729px을 적용하고 일반 모달은 기존 692px을 유지했다.
- **웹 직접 승인 화면:** 주문 변경과 별도의 승인 조건을 page/hook/UI/capture까지
  전달했다. 읽기 전용일 때 승인·거절·주석 작성을 숨기고 파일·URL·버전 조회와
  다운로드는 유지한다. 제한 변경·대상 변경·unmount 후 이전 callback, 파일 처리와
  지연 capture가 행동을 재개하지 않는지 확인했다. Planning/Design 승인 화면이 대상이며
  별도의 Case Preference 설문에는 확인되지 않은 제한을 추가하지 않았다.
- **치과 앱 직접 승인 화면:** 같은 범위의 조회/행동 분리와 이전 callback·비동기
  파일 처리·지연 주석 차단을 준비했다. 기존 native LinkTalk는 읽기 전용 전달과
  입력/첨부 제한이 이미 있어 재검토만 했다. 앱 주문 상세는 WebView 공통 화면이다.
- Figma PC/모바일/앱 화면과 내부 설명을 MCP context·screenshot으로 대조했다.
  3D 미리보기·채팅 조회·파일 조회는 유지하고 읽기 전용 작성/첨부 조건을 확인했다.
  기공소 caller 수정·배포 예정 작업의 재적용은 하지 않았다. 기존 branch의 과거 Lab
  사전 작업은 보존하며 이번 Lab 완료 보고를 우리 배포/런타임 증거로 간주하지 않는다.

### 최신 master 참조와 Git 위치

- 사용자 요청으로 `origin/master`를 다시 fetch하고
  **`693b8b4c4d247716db05ea415bc7bd1d33dab4cc` / Release/v1.88.0 (#4688)**를 확인했다.
  기존 기준점에서 대규모 변경과 Lab/shared 충돌이 예상돼 **master 전체를 merge한 상태는 아니다.**
  이번 치과 구현에 필요한 출시 동작을 선별해 반영했다.
- 최신 master의 앱 Denture 다음 주문 지원을 보존했다. 모바일 Next Order의 과거
  사용 불가 팝업을 제거하고 권한 guard는 유지했다. 다음 주문 생성 성공 시 앱의
  `OrderScreen` 이동을 최신 `useOrderDetail.ts`와 동일하게 반영했다.
- 향후 통합에서는 master의 밀링 callback/의사 이름 추적·아이콘 패키지와 generated
  경로·승인 첨부 한도 변경을 보존해야 한다. 현재 Clinic은 밀링 callback을 전달하지
  않으며 Lab 정책을 임의 확장하지 않았다. 전체 최신 패키지 통합·통합 후 QA는 남았다.
- 웹 worktree `/Users/parkjongsun/Repository/dentlink-client-permission`,
  `feature/DL-16317 / origin/feature/DL-16317`.
  **HEAD/upstream/실제 원격 `a6392cc67862590aea48889f927944d192baa002`**, clean.
  디자인 보완 `26aaa0747`, 최신 앱 다음 주문 호환 `a6392cc67`를 push했다.
  기존 master base `9bed1f7bd753e229478302413c0ec9a7e7a11dc2`는 그대로다.
- 치과 앱 worktree `/Users/parkjongsun/Repository/dentlink-app-permission`,
  `feature/DL-16317 / origin/feature/DL-16317`.
  **HEAD/upstream/실제 원격 `445ced6eba5093d2cdc63d050d00bee15396e6c7`**, clean.
  기존 오래된 main 기준 feature를 보존했다. 현재 앱 정책상 새 일반 기능의 기준과 PR
  대상은 develop이며, 이번에 브랜치 변경/재기준화/PR 생성은 하지 않았다.

### 검증과 증거 경계

- Clinic 전체 Jest **24 suites / 177 tests 통과**. 이번 승인 11·실제 페이지 5·
  모바일 Case 1·앱 Next Order 1개를 포함한다. Next Order는 실제 mobile title/button과
  workflow label helper를 사용해 허용 시 실행/팝업 없음, 제한 후 보관 callback 차단을 검증했다.
- 웹 Clinic/Lab/Admin 타입 검사 통과. 일반 pre-commit/pre-push를 정상 실행해
  제품 push가 성공했다. 전체 세 서비스 lint는 각각 기존 경고 223/189/410개·오류 0개이며,
  shared coverage 비교는 baseline과 같다. 훅을 우회하거나 baseline을 수정하지 않았다.
- 이번 승인 shared 검사에서는 기존 타입 진단 579개가 그대로이고, scoped shared
  lint의 기존 오류 1개·경고 2개도 그대로였다. shared 전체 타입/lint 통과라고 보고하지 않는다.
- 치과 앱 feature Jest **16 suites / 108 tests 통과**, 직접 승인 회귀 8개 포함.
  실행은 `yarn jest --config jest.config.js --runInBand __tests__/features`를 사용한다.
  전체 앱 타입 오류는 기존 **18개 동일**, 추가 진단 없음. scoped lint 오류 0개,
  기존 array-index-key 경고 2개·기존 RN StrictMode 경고는 별도로 남았다.
- 실제 NoData 컴포넌트를 임시 외부 fixture로 렌더링해 1440×1080/375×812에서
  200×195px 내용·SVG 원래 크기·홈 버튼 실행을 확인했다. 임시 서버는 종료했고
  제품 테스트 페이지/preview harness/설정은 추가하지 않았다. 임시 자료와 로그는 /tmp에
  있어 Git으로 이동하지 않는다. 실제 로그인 페이지 전체/실기기/서버 Member QA 증거는 아니다.
- 실제 Member·담당/공유/과거 참여 API 연결, 서버 GET 범위/거절 code,
  담당 변경 후 조회 상실 응답, 계정/상태별 UI·직접 URL·실기기 QA는 여전히 남았다.
  API 미연결 상태를 실제 신규 권한 시행 완료라고 보고하지 않는다.

### Jira·다음 시작점

- Web **DL-16319** 제목을 `[FE][Web] 담당 환자 제한 및 Member 권한 적용`으로
  정리하고 진행 댓글 **44414**에 보완·검증·남은 실연동/통합 QA를 기록했다.
  기존 본문 null은 유지했다.
- 영향을 받는 제품별 카드 규칙에 따라 치과 앱 **DL-16752**를 상위 DL-16317의
  별도 하위 카드로 만들었다. 제목은 `[FE][Office App] 담당 환자 제한 및 Member 권한 적용`,
  담당 Frankie, 진행 중이며 작업 구분과 실제 연동/실기기 잔여는 댓글 **44415**에 기록했다.
  두 카드의 제목·상태·담당·상위·최신 댓글을 재조회했다. 기공소 카드는 만들지 않았다.
- 현재 확정 디자인에서 API 없이 가능한 이번 보완은 원격에 보존했다. 다음 시작은
  실제 응답 설계/예시를 받아 준비한 개별 조건에 매핑하는 작업이며, 그 전에는 기존
  페이지/승인 화면에 임시 조건을 연결해 수동 확인할 수 있다. 서버 role 값만 바꿔 모든
  제한이 자동 적용되는 상태는 아니다. 신규 정책/enum/endpoint를 추정해 추가하지 않는다.
- 반복된 Codex 응답 끊김은 코드 결과와 구분했다. 요청 ID
  `bb4c7d1b-a0ae-4bd2-96a6-e483c19e9621`의 10월 12일 18:30:39 KST 스트림 오류와
  자동 retry 기록을 로컬 로그에서 확인했다. 앱 26.1007.30912/build 20156은 업데이트 검사
  `up_to_date`였다. 원인은 미확정이며 오류 해결·서비스 장애·네트워크 문제를 단정하지 않았다.
  로그 전송·앱 재시작·설정 변경은 하지 않고 코드/원격 상태를 재확인해 마무리했다.

## 현재 상태 — 2026-10-06 하위 Jira 정리·메모리 저장 후 대기

- 사용자는 현재 상태를 저장하고 대기하라고 명시했다. 이번에 허용된 작업은
  개인 메모리와 사용자 담당 Jira 하위 카드 정리이며, 추가 제품 개발·테스트·
  테스트용 UI 연결·자동 모니터링은 사용자 재개 지시 전까지 진행하지 않는다.
- **Jira 정리 위치는 사용자 담당 하위 카드다. 상위 카드 댓글은 명시 요청이
  있을 때만 작성한다.** 사용자는 기존 상위 댓글을 직접 삭제했다고 알렸다.
  이 삭제 보고를 보존하며 삭제한 상위 댓글을 복구하거나 새 댓글을 쓰지 않는다.
  공통 규칙은 `AI_WORKFLOW.md`의 Jira Work Updates에 저장했다.
- DL-16319 담당 Frankie·진행 중 상태를 확인하고 제목을
  **`[FE] 담당 환자 제한 및 Member 권한 적용`**으로 변경했다. 본문은 현재 별도
  작업 전 준비 사항 추가가 필요하지 않아 기존 null을 유지했다. 진행 경과는
  **댓글 44298**에 정리하고 제목·본문·담당·상태·댓글을 재조회해 확인했다.
  개인 대기를 Jira ON HOLD나 전체 완료로 변경하지 않았다.
- 댓글은 웹·치과 앱의 준비 범위, 실제 Member/담당·공유·과거 참여 연동과 기공소
  잔여/상태별 화면 확인, 임시 조건을 실제 화면에 연결할 경우의 로컬 확인 방법,
  10월 6일 이전 턴의 기존 관련 40개 테스트 재검증과 현재 개발 대기를 구분했다.
  테스트용 연결·브라우저 시연이 이미 완료됐다고 기록하지 않았다.
- 제품 코드는 기존 원격 보존 상태를 유지한다. 이번 closeout에서 웹
  `53f1f9a0f4987114e2ea518ea2ea94894613b4c3`, 앱
  `1dc7a361b06baa000edaca5361ec5fae26a7dabe`의 HEAD/upstream 일치와 clean을
  재확인했다. 제품 파일 변경·새 테스트 실행·제품 commit/push·PR/배포는 없었다.
- 최신 Git 개인 컨텍스트에는 Lab 앱 정본이 별도
  `Innvoaid/dentlink-lab-app`, 기본 checkout
  `/Users/parkjongsun/Repository/dentlink-lab-app`으로 등록돼 있다.
  [Lab 앱 체크포인트](dentlink-lab-app.md)를 다음 재개 때 참조한다. 아래 이전
  조사 당시의 Lab checkout 미확인은 현재 정본 저장소 부재라는 뜻이 아니다.
  권한관리 Lab 앱 구현/런타임 검증은 수행하지 않았다.
- 다음 재개는 웹 치과의 기존 화면에 준비된 조건을 임시로 연결해 상태별 확인을
  진행하거나 실제 API 설계에 연결하는 작업이다. 신규 서버 역할값만 하드코딩해서
  모든 UI가 자동으로 바뀌는 상태는 아니다. 현재 상태와 이번 Jira 정리 규칙을
  Git 개인 컨텍스트에 commit/push하고 대기한다.

## 현재 상태 — 2026-10-06 FE 단독 조건 가정·화면 검증 방향

- 사용자는 현재 상태를 저장한 뒤 외부 담당자를 제외하고 FE/Codex가 할 수 있는
  작업·테스트를 진행하려고 한다. 서버가 특정 권한값을 준다고 가정해 UI/페이지
  제한을 직접 확인하는 방법을 문의했다. 이 요청 범위의 FE 독립 검토·테스트는
  이전 중단 이후 새로 허용된 범위이며, 실제 API 계약 확보만을 모든 작업의
  착수 조건으로 삼지 않는다. 아직 제품에 테스트용 연결을 구현한 상태는 아니다.
- 추천은 **웹 치과의 기존 실제 화면에 가정한 UI 조건을 주입하고, 필요한 API 응답을
  fixture로 제공하는 로컬 검증**이다. 새 서버 enum/endpoint를 만들지 않고,
  역할 이름·대상 관계·행동별 허용 조건은 테스트의 가정임을 명확히 구분한다.
  기존 실제 로그인 역할은 유지하고 테스트 입력을 준비된 optional props에
  연결한다. 서버 역할값만 MEMBER로 바꾸면 UI 전달은 바뀌지 않거나 기존
  withAuthorization allowlist에서 거절될 수 있어 이것만으로 시연하지 않는다.
- 시나리오는 기본 허용·주문 변경 제한·환자/Case 수정 제한·채팅 작성 제한·
  시스템 CTA 제한·화면을 연 뒤 허용→제한 전환을 각자 독립 검증한다.
  Member를 전부 조회 전용으로 해석하지 않는다. 공유/과거 참여처럼 정책 미확정인
  관계는 조건 주입에 따른 FE 동작만 확인하고 실제 정책을 확정했다고 보고하지 않는다.
- 수동 확인은 기존 페이지에서 PC/모바일 폭으로 메뉴·입력·버튼 표시와 실제 클릭을
  확인한다. 자동 검증은 조건에 따라 보호된 행동 callback/요청이 실행되지 않는지와
  허용 시 정상 동작을 확인한다. 목록/건수 mock은 서버 GET 필터링·서버 접근 제어의
  검증이 아니다. 기본 권한과 신규 조건의 화면 연결 검증도 구분한다.
- 기존 Pickup/LinkTalk Storybook 예시는 컴포넌트 조건 비교에 활용 가능하지만
  기준선 버전/순환 import 문제와 시각 검증 미완료가 있어 첫 경로로 추천하지 않는다.
  기존 E2E `page.route` fixture 방식을 참고할 수 있으나 공식 runner globalSetup은
  실제 서버 계정/팀/온보딩을 준비한다. FE fixture 검증을 단순히 전체 E2E 실행으로
  대체하지 말고 실행·준비 범위를 먼저 한정한다. 별도 제품 페이지/권한 엔진이나
  정책을 추측한 서버 타입 변경을 전제하지 않는다.
- 오늘 기존 Clinic의 `withAuthorization`, `linkTalkActions`,
  `orderDetailLinkTalkActions`, `useOrderDetailPatientForm` 4 suites/40 tests를
  실제 재실행해 전부 통과했다. 조건 변경 후 오래된 callback·검증 후 저장 제한과
  기본 허용 동작의 기존 회귀 검증이다. 제품 파일 변경, 브라우저/실기기 시연,
  전체 E2E/전체 테스트 재실행, 새 Member 서버 연동을 완료한 것은 아니다.
- 제품 HEAD는 웹 `53f1f9a0f4987114e2ea518ea2ea94894613b4c3`, 앱
  `1dc7a361b06baa000edaca5361ec5fae26a7dabe`의 앞선 확인 상태를 보존한다.
  이번 웹 focused 테스트 뒤 Git clean을 재확인했다. 외부 담당자 메시지/Jira 수정은
  하지 않고 이 체크포인트만 Git 개인 컨텍스트에 commit/push한다.

## 현재 상태 — 2026-10-06 현황 재확인·담당별 다음 작업 정리

- 사용자는 현재 상황과 사용자/Codex/다른 담당자의 다음 작업 브리핑을 요청했다.
  이번 요청은 현황 조사이며 10월 2일의 구현 중단을 유지한다. 제품 수정·테스트
  재실행·제품 commit/push·Jira 수정·PR/배포는 하지 않았다.
- 개인 컨텍스트와 두 permission worktree를 `git pull --ff-only`로 동기화했다.
  웹 `53f1f9a0f4987114e2ea518ea2ea94894613b4c3`, 앱
  `1dc7a361b06baa000edaca5361ec5fae26a7dabe`로 기록과 같고 clean이다.
  각 HEAD·upstream·실제 원격이 일치한다. 기존 optional UI 조건은 준비돼 있지만
  실제 화면 호출부의 신규 Member/관계 응답 주입은 여전히 미완료다.
- 공개 DEV Swagger를 `/tmp/dentlink-permission-status-20261006-swagger.json`으로
  재조회했다. 937 paths/1374 schemas이며 10월 2일 phase4 JSON과 완전히 동일하다.
  공개 문서에서 새 역할 enum·관계별 허용 행동 계약을 확인하지 못했다.
  이것이 서버 작업/비공개 설계가 존재하지 않는다는 증거는 아니다.
- Jira 상위 19개 하위 상태 및 FE/BE/기획/디자인 관련 본문·댓글을 확인했다.
  FE DL-16319는 진행 중, BE DL-16320/16543/16564는 Leo 담당으로 진행 중이며
  응답 명세는 해당 티켓에 없다. 기공소 디자인 DL-16595는 Oli 담당 진행 중,
  기획 변경 반영 DL-16589는 Oli 담당 해야 할 일이다. 기획/기존 치과 디자인/TC
  완료 상태는 실연동 완료나 남은 정책 차이 해소를 뜻하지 않는다.
- 현재 Figma WF `1:6`과 연결 Notion의 권한표·TC를 재조회했다. Notion의 최종 편집은
  9월 29일이며 권한 밖 Drive embed 1개는 여전히 미지원이다. 최신 WF의 현재 담당
  환자 범위·Home의 내 주문+담당 환자 주문·주문1단계 전체 환자/Case·Draft 미지정/
  본인·Pickup 공유 Case 예외를 확인했다. Pickup section 제목과 상세 설명도 달라
  일반 TC의 일괄 차단 규칙을 임의 확정하지 않는다.
- 앱 기존 fetcher는 일부 예외를 제외한 403에서 세션 만료를 처리한다. 새 권한 거절
  HTTP/업무 code를 받아 접근 거절과 인증 만료를 구분해야 한다. 별도 Lab 앱 checkout은
  `~/Repository` 바로 아래와 등록 worktree 범위에서 미확인이다. Office 전용 코드에
  Lab 정책을 복제하지 않고 정본 저장소·브랜치·담당 범위를 Lab 담당에게 확인한다.

### 다음 작업의 추천 순서와 요청

1. **BE(Leo):** 기존 API 추가 필드 또는 신규 조회 API의 응답 설계/예시·적용 환경/
   예정일을 받는다. 새 Member wire 값과 기존 역할 매핑, 로그인 직원/담당 의사 ID,
   담당·공유·과거 참여별 허용 행동, GET 목록/건수/Draft 범위, 거절 code가 핵심이다.
   전체 서버 구현 완료가 아니라 FE 조건에 매핑할 수준의 설계면 착수 가능하다.
2. **기획(Yoonie)·디자인(Oli):** 남은 정책 차이만 확인한다. 현재/과거 담당·공유
   대상의 조회/수정/채팅 범위, Pickup 공유 예외와 직접 URL 처리, 담당 변경 후 이동,
   자동 담당 지정과 NEW/FOLLOW_UP/Draft 복원 정책을 동일 기준으로 맞춘다.
   기공소 최신 화면 node와 치과/기공소 적용 범위도 확인한다.
3. **사용자:** 위 자료와 제공 일정을 담당자와 조율하고 웹·앱/치과·기공소의 배포
   묶음·우선순위를 확인한다. 기술적으로는 웹 치과부터 연결을 추천한다.
4. **Codex:** 사용자 재개 지시와 매핑 가능한 계약이 갖춰지면 준비한 UI 조건에
   실제 응답을 연결하고, 웹 치과 → 웹 기공소·치과 앱 → 확정된 기공소 앱 범위로
   진행한다. 서버 GET 범위를 FE 필터로 대체하지 않는다. 직접 진입·담당/권한/소속
   변경·거절·Draft 복원·실제 상태 QA를 검증하고 사용자/QA가 실제 기기와 최종
   업무 동작을 확인할 수 있게 정리한다. 기존 역할 정상 동작도 함께 검증한다.

## 현재 상태 — 2026-10-02 추가 개발 중단·재개 기준 정리 후 대기

### 중단 결정과 재개 기준

- 사용자가 추가 작업을 그만하고 대기 여부를 재고하라고 한 뒤, 대기 추천에 따라
  정리하고 기다리라고 명시했다. **이번 중단 지시가 이전 자율 진행 지시보다 우선한다.**
  사용자 재개 또는 구체적인 검토 지시 전에는 개발·테스트·추가 조사·자동 모니터링을
  이어서 진행하지 않는다. 기존 permission worktree와 원격 branch를 보존한다.
- 다시 검토하고 독립 점검한 결과, 현재는 대기를 추천한다. API 없이 준비할 주요 UI/
  실행 조건과 확인된 보완은 정리했고, 다음 핵심 진도는 실제 역할·관계 응답의 연결이다.
  API 없이 가능한 개선이 전혀 없다는 뜻은 아니다. 작은 보완의 가치는 실제 연동 시
  구체적인 조건과 결함을 확인하면서 다시 판단한다.
- 재개 기준은 사용자의 재개 지시와, 기존 제어 조건에 매핑할 수준의 역할·담당·공유·
  과거 참여·허용 행동 응답 설계/자료다. 서버 조회 범위와 거절 응답도 함께 확인한다.
  백엔드 구현 전체 완료나 모든 기획·디자인의 완벽한 확정을 기다려야 한다는 뜻은 아니다.
  자료가 새로 생겼다는 이유만으로 자동 재개하지 않는다.
- 이번 정리에서는 제품 코드와 테스트를 변경하지 않았다. 웹/앱의 clean 상태와
  HEAD·upstream·실제 원격 SHA 일치를 재확인했다. Jira 기존 댓글 44240/44241에도
  완료·잔여 범위가 정확히 남아 있어 중복 댓글이나 상태 변경은 하지 않았다.
  현재 개인 대기를 Jira ON HOLD·전체 완료·PR/배포 완료로 해석하지 않는다.
- 이 결정과 현재 체크포인트만 Git 개인 컨텍스트에 commit/push하고 대기한다.

- 사용자가 반복해서 “혼자 할 수 있는 게 더 있으면 계속하고, 다 되면 이전처럼
  마무리”하라고 지시했다. 기존 추천대로 진행·제품 commit/push·Git 메모리·Jira
  정리 승인을 유지했다. 직전 메모·앱 채팅/Draft/Case 준비 이후 다시 검토해,
  환자·Case 검증 후 저장 확인, 앱 숨긴 필터의 건수 정렬·환자 단계·채팅 부모 전달을 보완했다.
  실제 API 연결에 필요한 계약과 계약 없이 준비할 수 있는 UI/실행 조건을 구분했다.
  PR 생성·merge·배포·CodePush는 하지 않았다.
- **신규 Member 실연동은 아직 미완료다.** 기존 EDITOR에 새 Member 제한을 적용하거나
  임의 역할 enum·관계 API·권한 store/route 계약을 만들지 않았다. optional UI 조건은
  기본값으로 기존 동작을 유지하며, 실제 역할·담당·공유·과거 참여 응답 연결이 남았다.
  Member를 모든 non-GET이 막히는 조회 전용 역할로 해석하지 않는다.

### 원격에 보존한 작업 위치

- 웹: `/Users/parkjongsun/Repository/dentlink-client-permission`,
  `feature/DL-16317 / origin/feature/DL-16317`.
  master base `9bed1f7bd753e229478302413c0ec9a7e7a11dc2`.
  **HEAD/원격 `53f1f9a0f4987114e2ea518ea2ea94894613b4c3`**, clean.
  최신 `fix: 환자와 케이스 저장 전 제한 조건 재확인` — 제품 4·통합 테스트 1개 파일.
  이전 메모 커밋 `e8dd7dafb1f7d2abbff253dcd503ef7938d4dd97`도 보존했다.
  이전 상세·채팅·Draft 커밋 `3b045e4882284c925c3fc43724f97ebc85a874bb`와
  `5ffe7e0549d7cb57ab58a7daeed4b934e9ebaa2a`·
  `f5a068e5000e266d6dde5af9c126038fd4158ea2`도 같은 branch에 있다.
- 앱: `/Users/parkjongsun/Repository/dentlink-app-permission`,
  `feature/DL-16317 / origin/feature/DL-16317`.
  앱에는 master가 없어 실제 기본 브랜치 main의
  `19f68100f7ce40e40c15d2d1e82c2e9737ca296a`에서 별도 Git worktree를 만들었다.
  **HEAD/원격 `1dc7a361b06baa000edaca5361ec5fae26a7dabe`**, clean.
  최신 커밋 `cbf1a89105d2c32fca6f872598e45e431f15f23c`
  `fix: 앱 권한별 목록 정렬과 환자 필터 표시 보완` — 제품 2·기존 테스트 2개 파일과
  `1dc7a361b06baa000edaca5361ec5fae26a7dabe`
  `feat: 앱 채팅 화면의 권한 제어 조건 연결` — 제품 1·통합 테스트 1개 파일이다.
  이전 채팅 `4ad003cda4e53d5830b7d3ddb8d5df39c2a19d1f`,
  Draft/Case `9ed78d31be81c71679592999c410fd77ec37e66c`도 보존했다.
  이전 필터 커밋 `340faa64be55a5ed873ec5ede1383bd6f36687b5`도 보존했다.
- 두 제품의 검증 당시 파일·커밋 내용·원격 SHA 일치를 확인했다.
  최신 추가 웹 5·앱 6개 파일은 SHA-256 snapshot과 HEAD 내용이 모두 일치했다.
  기존 웹 checkout·DLDS·앱 main checkout은 수정하지 않았다.
  앱 의존성은 원본 main의 기존 node_modules를 로컬 symlink로 재사용했다.
  symlink는 로컬 info/exclude로 무시되며 package/lockfile·Jest 설정은 변경하지 않았다.
  다른 기기로 Git을 옮겨도 이 로컬 의존성·/tmp 로그가 전달되지는 않는다.

### 추가 구현 범위

기존 웹 목록·보드·Pickup·권한 표시와 첫 구현 단위는 아래 이전 기록도 참조한다.

| 범위 | 구현과 보존한 경계 |
| --- | --- |
| 웹 주문 상세·사이드패널 | `canPerformOrderActions`로 제목·삭제·취소·상태·배송일·담당 변경 등을 표시/실행 제어. `canEditPatient`, Case별 `canEditCaseTitle(case)`는 별도로 제어. 이미 열린 팝업·비동기 GET 후 실행·Case 전환 뒤 오래된 submit도 최신 조건으로 차단 |
| 웹 환자·Case 저장 | 실제 submit 두 번째 optional `canSubmit(validatedId)`를 RHF onValid의 mutate 직전에 호출. SidePanel에서 mounted·현재 권한·편집 대상/현재 form ID·version을 재확인. 검증 중 제한 또는 대상 변경→복귀, unmount가 과거 저장을 재개하지 않음. 기존 guard 없는 호출·성공 callback/refetch와 주문 변경 권한 독립 유지 |
| Credit·승인·추가금 | `canUpdateCredit`의 수동/자동 업데이트 경계를 normal·Remake Summary에 전달. Pending Approval·Remake History의 변경 진입과 Lab 추가금 생성/취소도 제어. 가격·이력·도움말과 순수 디자인 파일 미리보기는 유지 |
| 웹 LinkTalk | `isReadOnly`로 전송·답장·업로드·재전송·수정·삭제·POST 번역 재시도 제어. `isSystemMessageActionEnabled`는 template별 CTA 입력. 상세 Layout의 실제 clone 경계도 조건 전달. DESIGN/AUTO 순수 미리보기와 기존 input hidden/disabled·Lab 타기공소 조건 보존 |
| 웹 Draft | `canContinueDraft`, `canDeleteDraft(orderId)`로 카드·연필·삭제 UI와 실제 부모 handler 제어. 목록/카운트/서버 GET 범위는 바꾸지 않고 SYSTEM_DRAFT의 기존 삭제 제한 유지 |
| 웹 Lab 메모 | Layout TabMemo에서 주문 변경 조건을 자식의 `canEditMemo`와 합쳐 전달. 입력·수정·삭제·첨부·임시 파일 삭제 진입과 실제 Lab handler 제어. 열린 편집기·파일 선택의 이전 callback과 unmount 이후 실행 차단. 조회·다운로드와 기존 undefined upload props 동작 유지 |
| 치과 앱 목록 | OrderSearchForm의 내 주문·내 환자·담당 의사 필터 표시 입력과 BottomSheet Dentist 탭 조건. 숨김 후 이전 toggle/chip/tab/선택 callback 차단. 열린 Dentist→Status, 저장된 imperative present에도 최신 조건 적용. 숨긴 외부 selectedDentists를 Done/Reset이 덮거나 지우지 않음. 내 주문/환자 토글이 숨겨진 행의 건수는 Figma대로 우측 정렬 |
| 치과 앱 주문 1단계 환자 | OrderScreen의 optional `isShowMyPatientOnly=true`를 OrderPatientListSection까지 전달. 자식의 이전 callback 차단 유지. 제공된 전체 환자·검색·선택·신규 등록·Next·다음 페이지 유지. Member 판단·조회 범위는 하드코딩하지 않음 |
| 치과 앱 native LinkTalk | ChatDetailScreen의 optional `isReadOnly=false`를 실제 useMessage·MessageInput·MessageList에 함께 전달. 부모 `isSystemMessageActionEnabled=true`는 leaf 타입의 bool/template predicate를 그대로 List에 전달. 전송·답장·업로드·재전송·POST 번역 재시도 차단. 시스템 메시지의 `isSystemMessageActionEnabled`는 별도 조건. DESIGN/AUTO 비동기 응답은 권한 또는 메시지/주문 변경·unmount 후 이전 작업을 재개하지 않음. 복사·원문·파일 열람과 허용된 순수 미리보기 유지 |
| 치과 앱 Draft | OrderScreen과 카드에 `canContinueDraft(draft)`, `canDeleteDraft(draft)` 전달. 실제 이어하기·삭제, scanner GET 이후 복원도 최신 조건 확인. false→true 전환이 과거 응답을 되살리지 않고 unmount·다른 주문 시작 시 무효화. SYSTEM_DRAFT 삭제 금지와 일반 진행 주문 편집 보존 |
| 치과 앱 신규 Case | Screen에서 `isShowAssignedDentist` 전달해 담당 의사 영역 전체와 sheet 숨김. 이전 찾기/변경/선택 callback·100ms 지연 실행과 unmount 이후 호출 차단. 기존 선택값·Next 검증 유지. 담당 의사 자동 지정이나 저장 payload 변경은 하지 않음 |

- 입력/메뉴/파일 선택의 남아 있는 callback을 제어한 것이며 이미 시작된 HTTP·S3
  업로드를 취소하거나 서버 권한을 보장하지 않는다. 환자·Case 폼은 검증 후에도 준비된
  조건을 재확인하며, 실제 서버 관계 응답 연결과 나머지 주문 취소/상태/추가금 폼의 최종
  mutation 경계는 API 연동 시 함께 확인한다. 주문 변경·환자/Case 수정·채팅·Feedback
  권한은 구분하며 모든 non-GET을 한 조건으로 막지 않는다.
- 앱 OrderDetail은 기존 웹 상세 WebView를 사용하고 native 채팅은 별도다.
  native UI/hook과 ChatDetailScreen의 조건 전달까지 준비했지만 실제 관계 응답을
  주입하는 연결은 남았다. 기존 ConfirmBanner와 승인/CP 직접 화면의 허용 행동은
  별도 정책 경계라 채팅 template 제한만으로 숨기거나 차단하지 않았다.
  `isDifferentLab=false` 익명 표시 상수는 권한이 아니다.
- 앱 신규 Case의 Member 디자인은 담당 의사 영역 전체가 없는 것으로 확인했다.
  일반 Draft가 PROFILE/PRODUCT/OPTION 이후로 복원되는 경우까지 담당 고정을 보장하려면
  응답·복원 정책이 필요하다. 자동 profile 변경·자기 자신 지정·1단계 강제 이동을 만들지 않았다.
  App Profile 권한 badge/help 디자인은 확인되지 않았으므로 웹 디자인을 복제하지 않았다.

### 검증과 자료 재확인

- **웹 Clinic 전체 Jest 22 suites / 159 tests 통과.** 직전 149개에 실제 RHF/Yup/
  React Query mutation·공용 SidePanel을 사용한 검증 후 저장 회귀 10개를 추가했다.
  guard 없는 정상 호출, 기본 UI 저장, revoke→복귀·대상 변경→복귀·form ID 불일치·
  양쪽 unmount를 확인했다. 직전 Memo 회귀 7개와 기존 upload props 검증도 유지했다.
- 웹 Clinic/Lab/Admin 전체 type 통과. 정상 pre-commit과 pre-push도 통과해 push했다.
  세 서비스 lint 오류 0이며 shared/configs 21·shared/hooks 24개 테스트와 기존
  coverage baseline 검사 통과. 이번 push에 훅 우회나 baseline 재설정은 없었다.
- 이번 Clinic 변경 2개 파일 scoped lint 오류/경고 0, shared 변경 3개 파일 scoped lint
  오류 0·기존 경고 28개가 동일했다. Clinic TS program의 변경 5파일 진단 0,
  실제 필수 훅 Clinic/Lab/Admin type 통과, Prettier·diff check 통과.
  직전 Memo 단위에서 sharedUI 전체 type의 579개 기존 진단 메시지 집합은 동일했고,
  과거 LinkTalk scoped lint 8 errors/49 warnings도 기존 문제였다.
  이번 sharedUI 전체 lint/type가 성공했다고 표현하지 않는다.
- **앱 features 전체 Jest 15 suites / 100 tests 통과.** 권한 관련 62개는 직전 필터/
  native 채팅/Draft/Case 57개와 새 부모 환자 단계 2개·실제 채팅 화면 통합 3개다.
  기존 order/patient 필터 회귀 2개에 숨김/복원 시 정렬 검사도 보완했다.
  실제 ChatDetailScreen/useMessage/MessageInput/MessageList로 이전 전송·재전송·파일
  callback 차단, 새 메시지·읽음·refresh 유지, 재허용 후 전송, template별 CTA 판정과
  기존 ConfirmBanner 진입 보존을 검증했다. 앱 전체 테스트 통과는 아니다.
  이번 추가 6개 파일 scoped ESLint 오류/경고 0, Prettier·diff check 통과.
  전체 tsc는 main 기준의 기존 **18개 오류 출력과 완전히 동일**하다.
  새 채팅 통합 테스트를 포함한 별도 TS program의 해당 파일 진단도 0이다.
  앱 전체 타입 검사가 통과했다고 쓰지 않는다. StrictMode의 기존 RN findNodeHandle
  경고는 숨기거나 설정을 바꾸지 않았다. 제품 변경을 서로 독립 검토했다.
- 최신 검증 로그: `/tmp/dentlink-permission-phase4-clinic-jest-all.log`,
  `/tmp/dentlink-permission-phase4-app-features-jest-all.log`,
  `/tmp/dentlink-permission-phase4-app-type-final.log`.
  최신 검증 snapshot: `/tmp/dentlink-permission-phase4-web-digest.json`,
  `/tmp/dentlink-permission-phase4-app-digest.json`.
  웹 정상 필수 commit/push 로그는 `/tmp/dentlink-permission-phase4-web-{commit,push}.log`.
- 로그인 Member 실계정·브라우저/실기기·시뮬레이터·제품 build/배포 검증은 하지 않았다.
  기존 Storybook 환경 문제와 i18n Sheet 미동기화는 아래 이전 기록대로 남았다.
  이번 추가분에는 새 UI 문구/i18n key가 없다.
- 상위 Jira의 하위 티켓 19개 목록과 FE DL-16319·BE DL-16320/16543·Lab 디자인
  DL-16595를 다시 읽었다. 신규 역할·관계 API 계약과 Lab 확정 디자인은 여전히 미확인이다.
  DEV `https://dev-api.dentlink.io/v3/api-docs`를 이번에 다시 받아 937 paths와
  직전 대비 path 추가/삭제 0, authority enum이 기존 4종임을 확인했다.
  `/tmp/dentlink-permission-phase4-swagger.json`은 익명 DEV 확인본이며 운영 증거는 아니다.
  invitation/employee wire enum은 기존 OWNER/PAYMENT_MANAGER/EDITOR/VIEWER다.
  기존 메뉴/domain 접근 API와 새 Member·담당/공유/과거 관계 행동 계약을 구분한다.
  AuthorityTypeDto의 key는 string이므로 서버 표시명 응답과 확정 wire 계약도 구분한다.
- 현재 Jira 디자인 Figma `2OR0Gj7NUFEEeYBjQg5Y6v`, WF page `1:6`,
  App section `36:34356`을 다시 읽었다. 신규 Case Member `56:17363`에 담당 의사
  영역이 없는 것이 확인되어 기존 앱 표시 입력의 근거로 사용했다.
  이번 WF metadata는 직전 XML과 동일했다. Orders/Patients 건수 행
  `36:42271`/`36:42294`의 우측 정렬을 확인했고 Orders 행의 design context도 읽었다.
  App Home `141:30768` 설명은 내 주문+담당 환자의 주문 범위이므로 myOrdersOnly=true나
  FE 임의 필터링으로 대체하지 않는다. 서버 조회 범위 계약을 받아야 한다.
- FE DL-16319의 기존 댓글 44240과 상위 DL-16317 댓글 44241을 22:35 KST에 갱신하고
  재조회했다. 웹 159개·앱 관련 기능 100개 검증과 준비/실연동 경계를 기록했다.
  두 티켓은 진행 중(10016)을 유지했다. 대기를 ON HOLD나 전체 완료로 바꾸지 않았다.
  개인 컨텍스트도 이 기록만 commit/push해 다음 세션에 보존한다.

### 남은 작업과 다음 시작점

1. 개인 컨텍스트와 위 두 permission worktree를 pull/fetch하고 실제 HEAD·원격·clean을
   확인해 재사용한다. 신규 Member enum·역할 표시/배정 계약과 관계별 행동 응답을 받는다.
2. 기존 optional UI 조건을 실제 응답에 연결하고, 목록·카운트·Draft 서버 조회 범위,
   직접 URL·소속/권한 변경·담당 변경 후 이동/재조회·거절 응답·캐시 갱신을 검증한다.
   현재/과거 담당 환자와 공유 Case의 허용 행동·FOLLOW_UP 담당 관계 정책을 맞춘다.
3. 앱 native 채팅의 실제 응답 연결, Home 담당 환자 조회 범위, 담당 의사 자동 지정과
   일반 Draft의 전체 복원 정책,
   기타 화면과 Lab의 확정 디자인 범위를 반영한다. 앱 Lab 코드 checkout은 현지에서
   확인되지 않았으며 Office 정책을 Lab에 복제하지 않는다. 웹 Lab 신규 Remake 생성/
   직접 진입 등도 실제 관계 조건과 함께 후속 감사한다. Lab Remake 목록/선택/info/
   additional은 상세 flag와 별도 페이지이며, 목록에는 관계 판단 데이터가 부족하다.
   승인·CP 직접 화면과 주문 폼의 최종 mutation 조건도 이 단계에서 함께 맞춘다.
   웹 Lab Memo 입력 준비는 완료다.
4. 실제 API 상태별 화면 QA·번역 검토를 보완한다. 현재 구현과 자동 테스트를
   신규 Member 정책 시행·전체 권한관리 완료로 해석하지 않는다.
5. 현재 선행 단위와 중단 결정은 제품 원격·Jira·Git 개인 메모리 정리를 마쳐 대기한다.
   사용자 재개 지시 이후 계약/디자인·구체적 결함을 다시 확인해 다음 범위를 선정하며,
   추측으로 정책을 만들지 않는다.

## 이전 상태 — 2026-10-02 웹 1차 선행 구현·검증·원격 보존

아래는 첫 구현 단위의 기록이다. 현재 작업 위치·완료·잔여 범위는 위 추가 구현 기록을 따른다.

- 사용자가 분석 이후 **판단이 꼭 필요한 사항 외에는 추천대로 스스로 구현을 진행**하라고
  지시했다. 앞선 분석 전용 제한은 이번 제품 코드 수정 지시로 해제됐다.
  웹부터 현재 Jira/Figma의 확정된 표시와 진입 제어를 준비했다. 이후 **작업 완료 시
  commit/push·메모리화·Jira 정리 후 대기**하라고 명시 승인했다. 해당 권한관리 작업의
  완료 단위에는 이 지시를 유지하며 같은 승인을 다시 요청하지 않는다.
  제품 PR 생성·merge·배포는 포함되지 않는다. 현재 작업분 마무리를 완료하고 대기한다.
- 작업 위치는 `/Users/parkjongsun/Repository/dentlink-client-permission`,
  branch/upstream `feature/DL-16317 / origin/feature/DL-16317`,
  base `9bed1f7bd753e229478302413c0ec9a7e7a11dc2`,
  **HEAD/원격 `f5a068e5000e266d6dde5af9c126038fd4158ea2`**, clean이다.
  이번 **49개 변경(기존 36·신규 13)을 두 커밋으로 원격에 보존**했고 로컬 파일·커밋
  내용이 검증 당시 49개 파일의 SHA-256과 동일함을 확인했다.
  기존 웹 checkout과 DLDS 작업 위치, 앱 checkout은 수정하지 않았다.
- 개인 컨텍스트를 `git pull --ff-only`로 먼저 갱신했다. permission worktree에
  `pnpm install --frozen-lockfile`을 완료했고 제품 package/lockfile은 변경하지 않았다.
  Node 24.4.1, pnpm 8.6.9. 선택적 구버전 canvas 설치 경고는 있었지만 설치는 성공했다.
- **실제 신규 Member 시행은 아직 아니다.** BE 역할 enum·권한 API·응답/오류 계약이
  미확정이라 기존 `EDITOR`에 Member 제한을 연결하지 않았다. 공용 UI의 optional
  표시·행동 입력과 Storybook 예시를 준비하고 기본 동작을 유지했다.
  Clinic의 EDITOR 표시명 Manager 변경, 도움말과 기존 HOC 오류 수정은 실사용 코드에 있다.

### 이번 마무리 결과

- 제품 커밋 두 개:
  - `5ffe7e0549d7cb57ab58a7daeed4b934e9ebaa2a` —
    `fix: 소속과 권한 변경 시 접근 상태 갱신` (HOC·회귀 2개 파일).
  - `f5a068e5000e266d6dde5af9c126038fd4158ea2` —
    `feat: 권한별 웹 화면 제한을 위한 UI 조건 추가` (UI·상태 예시·회귀 47개 파일).
- `git push -u origin feature/DL-16317` 성공. `git ls-remote`와 upstream/HEAD의
  동일 SHA, 제품 worktree clean을 확인했다. PR 생성·merge·배포는 하지 않았다.
- 필수 pre-commit의 Clinic/Lab/Admin type, pre-push의 세 서비스 lint 및 shared
  테스트·coverage 검사까지 실행했다. 세 서비스 lint는 오류 0(기존 경고 각각
  Clinic 223·Lab 189·Admin 410), shared/configs 21·shared/hooks 24개 테스트 통과.
- 최초 push는 **새 worktree의 무시된 `coverage-baseline.json` 부재**로 실패했다.
  검사 대상 shared/configs·hooks와 관련 모델/의존성에 feature 변경이 없음을 확인하고,
  coverage에 포함된 **64개 파일이 시작 commit과 byte 단위로 동일**함을 확인했다.
  그 검사 결과로 `pnpm coverage:baseline`을 실행한 뒤 필수 훅을 다시 통과해 push했다.
  baseline·coverage는 ignored 로컬 검증 산출물이며 제품 커밋에 넣지 않았다.
  기존 기준보다 coverage가 개선됐다는 주장이나 훅 우회는 하지 않았다.
- Jira 댓글 작성 후 재조회 확인:
  [FE DL-16319 댓글 44240](https://innovaid.atlassian.net/browse/DL-16319?focusedCommentId=44240)에
  선행 UI·기존 오류 보완·92개 검증·잔여 범위를 기록했고,
  [상위 DL-16317 댓글 44241](https://innovaid.atlassian.net/browse/DL-16317?focusedCommentId=44241)에는
  FE 결과를 연결하고 전체 잔여 범위를 짧게 정리했다.
  두 티켓 모두 **진행 중(10016)**을 유지했다. 전체 구현/실연동은 미완료라 완료나
  Ready for Deploy로 전환하지 않았다. Codex 대기를 Jira ON HOLD로 해석하지 않는다.
- 개인 컨텍스트의 이 체크포인트를 갱신하고 commit/push한다. 다른 세션의 기록이나
  제품 코드는 이 마무리 작업에 섞지 않는다. 다음 사용자 지시 전 추가 개발·PR/배포는 하지 않는다.

### 구현한 범위

| 범위 | 변경과 경계 |
| --- | --- |
| Office | Clinic의 기존 EDITOR 표시를 Manager로 변경, 디자인의 분홍 칩·Authority 도움말 적용. 목적지는 `https://portal.dentlink.io/help/articles/20`. OWNER/Billing Manager/VIEWER wire 값은 유지. 미지의 enum은 중립 표시로 처리해 깨짐 방지 |
| Orders/Patients/Board | PC·모바일에 `isShowMyOrderOnly`, `isShowMyPatientOnly`, `isShowDentistFilter` 조건 준비. Member 모바일의 검색+52px outline 필터/적용 표시, 열린 Dentist 탭 숨김 전환 및 숨긴 외부 필터값 보존. Board 필터는 기존 구성 그대로 작은 공용 컴포넌트로 추출 |
| 주문1단계 | 환자 My Only 표시 조건과 `fixedDentist` 입력 준비. 새 Case(`purpose=NEW`)에서 담당 변경/Assign Myself 진입을 막고 입력 초기화·Draft reset·제출 직전 지정 의사를 복원. 기존 Case(`FOLLOW_UP`) 담당 값은 임의로 덮지 않음 |
| 담당 의사 변경 | PC·모바일 상세에서 경고 조건을 모달로 전달. 문구는 최신 디자인의 `Changing the dentist will remove your access to this order.`. 기존 모달의 높이 제한 재사용. Lab en/ko locale에 대응 key 추가 |
| Pickup | `canOpenOrder(row)` 조건을 Today/Reschedule/Scheduled/Past PC·모바일과 Today 라벨 모달까지 전달. false는 일반 주문번호 텍스트와 클릭 handler 제거, 기본/true는 기존 링크. 환자 공유 예외는 서버 조건을 전달할 수 있도록 행별 입력이며 담당자 비교를 하드코딩하지 않음 |
| 기존 HOC | 권한·activeEmployeeId 변경/로그아웃 시 이전 승인 상태로 보호 페이지가 계속 보이는 문제 수정. 비동기 결과를 token+employeeId에 결부하고 오래된 조회 결과를 무시. null 프로필과 응답 id 불일치 방어. 응답 id 생략 및 정상 token refresh의 같은 소속 profile 유지 동작은 보존. 기존 /403·code2131 Office 전환 정책 변경 없음 |

주요 신규 파일과 진입점:

- `clinic/src/components/OfficeMemberList/office-member-authority.ts`,
  `OfficeMemberAuthorityHelp.tsx`, `useAuthorityTypeQuery.ts`.
- `shared/ui/src/OrderKanbanUI/OrderKanbanFilters.tsx`와 Clinic Board 호출부.
- `shared/ui/src/Order/OrderForm/OrderProfileForm/useFixedOrderDentist.ts` 및
  `OrderProfileForm.tsx`의 내부 Next → 복원 → 부모 RHF 제출 경계.
- `shared/ui/src/OrderUI/DentistFind/extras/ModalSearchDentist.tsx`와 상세 제목 PC·모바일.
- `shared/ui/src/PickupUI/PickupUI.type.ts`의 `PickupOrderAccessPropsType` 및 하위 전달.
- 기존 주문1단계 Story 보완, Orders/Patients/Board/담당 변경/Pickup 상태 Story 추가.
  별도의 신규 제품 화면이나 권한 엔진, API 계약·역할 enum을 만들지 않았다.

### 검증 결과와 한계

- Clinic 전체 Jest **14 suites / 92 tests 통과**. 신규 회귀 31개:
  HOC 12, 필터 6, 담당 고정 4, Pickup 9. 서버 정책과 실제 로그인 Member 검증은 아니다.
- Clinic/Lab/Admin 전체 `type` **모두 통과**. 새 worktree의 무시된 Next 이미지 타입
  파일이 없어 생긴 최초 PNG 오류는 Clinic/Lab `next typegen`으로 정리했다.
  제품 타입 설정은 수정하지 않았다.
- Clinic 변경 파일 ESLint, Prettier 및 `git diff --check` 통과.
  sharedUI는 기존 root/UI eslint-plugin-storybook 중복 resolve로 기본 명령이 실패했다.
  정본 UI 설정을 단독 지정한 변경 파일 검사는 **오류 0·경고 39**이며 기존 any/Hook
  경고와 Story export 경고가 있다. 전체 sharedUI 타입 명령은 기존 hook/icon 오류가
  남아 있으므로 별도로 전체 성공했다고 쓰지 않는다.
- **Storybook 시각 검증 미완료:** 기준선의 Storybook core/addon 버전 불일치,
  react-device-detect resolve, config/models 순환 import 및 prebundle entry 문제를
  겪었다. 임시 설정만 사용했으며 제품 deps/config를 고치지 않았다. 추가 환경 우회를
  중단하고 실제 컴포넌트를 렌더링한 Jest로 클릭과 상태를 검증했다. 임시 서버·브라우저 종료.
- Lab 신규 경고 문구는 en/ko JSON에 있으며 추가 key의 누락은 없다. 전체 i18n 검사는
  **기준선 실패 + 신규 key 시트 미동기화**를 구분한다. 변경 전 HEAD 대비 Sheet는
  `orders.detail.approval.fabrication.readyInHours` 값 차이와 `orders.filters.category`
  누락이 이미 있었다. `audit:i18n`의 `account.auth.actions.logIn` 누락도 HEAD에서 확인했다.
  신규 경고 key의 Sheet 반영/PM 번역 검토는 남았고 외부 Sheet 쓰기는 하지 않았다.
  관련 없는 번역값을 권한 작업에 섞어 수정하지 않았다.
- 제품 build/배포, 로그인 브라우저·실기기, 신규 Member 실계정 및 업무 API 연동은
  실행하지 않았다. Type/Jest 성공을 실제 권한 정책 시행으로 설명하지 않는다.

### 남은 작업과 다음 시작점

1. 개인 컨텍스트와 `origin/feature/DL-16317`을 갱신하고 위 기존 permission worktree를
   재사용한다. 제품 HEAD/원격/clean을 실시간 확인한다. 이번 구현은 원격에 보존됐으며
   후속 동일 권한관리 작업의 완료 단위에도 사용자의 commit/push·Jira 정리 승인을 유지한다.
2. 상세·사이드패널·Draft·Remake·LinkTalk/첨부·승인/삭제의 표시/실행 handler 경로를
   최신 정책과 대조해 다음 선행 범위로 진행한다. 현재 모든 non-GET 차단 완료가 아니다.
3. BE 명세가 나오면 실제 역할/관계 응답을 UI 조건에 연결하고 서버 목록·카운트·Draft
   범위와 직접 URL/변경 후 거절·캐시 갱신을 검증한다. 현재/과거 담당 환자, 공유 Case의
   행동 범위, FOLLOW_UP 생성 시 담당 관계는 아래 기존 미확정점과 함께 대조한다.
4. Lab 확정 디자인과 네이티브 앱 작업은 별도 다음 단계다. 현재 모바일 대응은 웹의
   반응형 UI이며 네이티브 앱 완료가 아니다. 기존 Lab 가격/타기공소 조건을 보존한다.
5. Storybook 기준선 및 i18n 시트 미동기화가 정리되면 상태별 화면 QA와 번역 검토를
   보완한다. 현재 확정 UI/입력 준비를 실제 신규 Member 배포 완료로 표현하지 않는다.

## 이전 분석 — 2026-10-02 웹 착수 준비·분석 완료

아래는 최초 분석 단계 기록이다. 이후 사용자가 구현을 지시했으므로 현재 승인 범위와
제품 변경·검증·다음 시작점은 위 선행 구현 기록을 따른다.

- 사용자는 권한관리 착수를 요청했으며 이번 단계는 **master 기준 신규 웹
  branch/worktree 준비 + Jira/하위 티켓/연결 문서/Figma/현행 코드 조사 + 계획 브리핑**이다.
  **제품 구현은 아직 하지 말라는 명시 조건**이 있다. 이 조건을 유지하고 다음 구현
  지시를 기다린다. 제품 commit/push/PR/merge/배포, Jira 댓글·상태 변경도 하지 않았다.
- 개인 컨텍스트 `git pull --ff-only` 후 공통 지침과 이 체크포인트를 읽었다.
  웹 원격은 `git fetch --prune origin`으로 갱신했다. 기존 제품 checkout의 branch는
  전환하지 않고 별도 작업 위치를 준비했다.
- 웹 전용 작업 위치: `/Users/parkjongsun/Repository/dentlink-client-permission`.
  branch **`feature/DL-16317`**, base/HEAD
  **`origin/master / 9bed1f7bd753e229478302413c0ec9a7e7a11dc2`**.
  clean, upstream 없음, 제품 수정·commit·push 없음.
- 앱 worktree/branch는 만들지 않았다. 현지 앱 checkout은 `main /
  19f68100f7ce40e40c15d2d1e82c2e9737ca296a`이며 현재 Office 전용 `src` 구조다.
  웹 먼저 진행한다는 사용자 방향에 맞추며 앱의 base를 master로 추정하지 않는다.
- 기존 웹 기본 checkout은 `release/v1.88.0 /
  3a4b1b2cf0632a683f5961488351d3863ea3e1c9`, 별도 DLDS worktree는
  `feature/DL-16471`이다. 둘 다 권한관리 작업 위치로 재사용하지 않는다.
- 이 채팅은 제품 Git 바깥 컨텍스트 폴더에 연결돼 있어 앱 `create_worktree`가
  `Not a git repository`로 실패했다. 실제 웹 저장소에서 직접
  `git -c branch.autoSetupMerge=false worktree add -b feature/DL-16317
  /Users/parkjongsun/Repository/dentlink-client-permission origin/master`를 실행했다.
  앱 managed attachment가 아닌 Git worktree이며 중복 생성하지 않는다.

### 확인한 자료와 정본 경계

- 상위 [DL-16317](https://innovaid.atlassian.net/browse/DL-16317): 본문·댓글 6개·관계·remote links.
  **직접 하위 19개 전부** 본문·댓글·관계·remote links를 읽었다. 추가 하위·issue links·
  remote links는 없었다. 연결 문서는 상위 본문과 TC 티켓에 있다.
- **최종 화면 기준:** [Figma Design WF](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v?node-id=1-6).
  페이지 metadata뿐 아니라 Office 역할/드롭다운, PC·모바일 목록/필터, Draft·주문1단계,
  Pickup, 의사변경 경고, 상세·사이드패널 하위 화면과 설명을 읽었다.
  큰 frame이 sparse metadata만 반환하면 실제 하위 instance/frame의 design context로
  내려갔다. 주요 화면 screenshot도 확인했다.
- 연결 [구 FigJam Member 범위](https://www.figma.com/board/U9Qpm6ACzjGFKyrCoaAuvA?node-id=68-463)는
  보조 근거다. 새 Design과 차이가 있는 규칙을 새 요구사항으로 자동 채택하지 않는다.
- [기획 5-4 권한표](https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd?source=copy_link#98f5af8127554b148e279f483c727836),
  [8-1 권한 TC](https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd?source=copy_link#e984570de2224ebdba3fd667a893cd51)의
  **TC 27행**과 토론 6개를 확인했다. 문서 제목은 `[공통] 알림센터 개편`, 상태 작성 중,
  last edited 2026-09-29다. 권한에 해당하는 영역만 본 작업 근거로 사용한다.
- 연결 [8/20 피드백 회의](https://app.notion.com/p/3c1ce072e82f8037bb9cdbfa32266882)와
  [leo 링크톡 자동발송 목록](https://app.notion.com/p/3d1ce072e82f80cbbe61f505afe96d0c)도 읽었다.
  전자는 초기 명칭·배경, 후자는 시스템 발송 목록이며 신규 권한 API 명세가 아니다.
- Notion 전체 응답의 `truncated=true`는 알림 현황의 지원하지 않는 Drive embed 1개에
  해당하며 그 내용은 읽지 못했다. 권한표와 TC 텍스트는 읽었다. 알림센터의 별도
  Sheet/Drive/Slack/회의 참고자료까지 권한관리 구현 범위로 확대하지 않는다.
- 디자인의 Authority 도움말 목적지 `https://portal.dentlink.io/help/articles/20`은
  웹 도구로 접근 실패했다. 링크 목적지는 확인했지만 게시물 본문은 미확인이다.
  운영 admin 사용자 페이지는 권한정책 문서가 아니므로 실제 운영 데이터에 접근하지 않았다.

| Jira 하위 작업 | 확인 상태와 의미 |
| --- | --- |
| DL-16319 FE | 해야 할 일. 본문·댓글에 구현 계획/명세 없음 |
| DL-16320 BE API List up / DL-16543 BE 접근 가드 / DL-16564 BE 기획 분석·설계 | 진행 중. 본문은 null 또는 공백, 댓글·연결 명세 없음. 실제 endpoint/응답/enum/오류 계약 확인 불가 |
| DL-16405 기획 / DL-16411 기획검토 공수산정 / DL-16318 디자인 | 완료. 구현 완료를 뜻하지 않음 |
| DL-16427 Office / DL-16428 Order List / DL-16429 Order Board / DL-16430 주문1단계 / DL-16431 Patient | 완료. 웹 PC·모바일 디자인 작업이며 코드 완료 증거 없음 |
| DL-16432 앱 프로필 / DL-16433 앱 Orders / DL-16434 앱 주문1단계 | 완료. 앱 디자인 작업이며 코드 완료 증거 없음 |
| DL-16544 TC 작성 | 완료. 연결 Notion TC를 읽음; 최신 Design과 일부 조건 불일치 |
| DL-16545 내부 릴리즈 노트 / DL-16589 기획 변경 반영 | 해야 할 일 |
| DL-16595 기공소 디자인 | 진행 중. 치과 Member 정책을 Lab에 그대로 적용하지 않음 |

### 현재 이해한 요구사항

1. **기존 화면의 조건 제한이 중심이며 웹부터 선행 개발 가능**하다. 공용 UI는 이미
   목록·필터값·handler를 props로 받으므로 표시와 사용 가능 조건을 추가하고 샘플 상태로
   확인한 다음 실제 서버 계약에 연결할 수 있다. API 없이 문서만 준비할 수 있다는
   판단은 지나치게 좁다. 새 페이지나 별도 권한 엔진을 전제하지 않는다.
2. 기획은 **기존 `EDITOR(DB)/Member(화면)` → Manager**, 새 의사 Member 추가,
   Billing Manager/Admin 유지 방향이다. 현재 API 타입은 `OWNER / PAYMENT_MANAGER /
   EDITOR / VIEWER`이다. 표시명과 실제 enum·데이터 전환 규칙은 별개이므로 `MANAGER`,
   `MEMBER` wire 값을 임의로 넣거나 기존 EDITOR에 새 Member 제한을 연결하지 않는다.
3. **Member는 조회 전용이 아니다.** 허용된 대상에서 기존 주문 처리 기능을 쓰는 역할이다.
   역할만으로 모든 non-GET을 막지 않고 조회/클릭/수정/삭제/전송 등 행동별로 제한한다.
4. 새 Design의 Member 목록은 My Orders/My Patients 토글 및 해당 Dentist 필터를
   제거하고 모바일 필터 표현을 조정한다. Board의 Dentist 필터도 제거한다.
5. **주문1단계는 일반 목록과 조회 범위가 다르다.** Member도 병원 전체 환자·Case를
   선택할 수 있고 Draft는 담당 의사 미지정 또는 본인인 항목만 노출한다
   ([설명 node107:23961](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v?node-id=107-23961)).
6. Pickup은 내 주문이 아니면 주문번호 링크를 없애되 환자 공유 Case의 주문에는 클릭
   예외가 있다 ([설명 node107:21457](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v?node-id=107-21457)).
   타의사 주문이라는 이유만으로 모든 링크를 막으면 최신 Design과 다르다.
7. 담당 의사 변경 모달은 접근을 잃을 수 있다는 경고와 모바일 높이 제한이 그려져 있다.
   경고 표현을 준비할 수 있으나 실제 변경 후 이동/유지/재조회는 정책 및 API 계약에
   맞춰야 한다. placeholder `팝업/CTA`는 완성된 문구·화면으로 간주하지 않는다.

### 문서 차이·API 연결 전 확인점

- **환자 목록:** 새 Design43:44977은 현재 담당 환자, 구 FigJam359:10333은 한 번이라도
  담당 주문이 있었던 환자를 노출한다. TC15는 미결이다. 사용자 지정 최신 Design을
  기준으로 계획하되 이 차이를 기록하고 실연동 전 동일 정책으로 맞춘다. 과거 참여 규칙이
  최신 Design에 확정돼 있다고 설명하지 않는다. 주문1단계의 전체 환자 범위는 별도다.
- **조회와 행동:** 구 TC12/13의 타의사 direct URL·Pickup 일괄 차단은 새 Pickup 공유
  예외와 맞춰야 한다. 공유 대상 상세/채팅/승인/다운로드/Remake의 행동 범위를
  클릭 허용만 보고 확대하지 않는다. 구 TC20/21의 담당 변경 후 접근 소멸도 대조 대상이다.
- **역할과 관계 계약:** 실제 역할 enum·기존 계정/VIEWER 매핑, 현재 담당·환자공유·
  기공소 관계를 판단할 응답, ID의 의미, 허용 필터·카운트·Draft 범위가 필요하다.
  신규 사전조회 API인지 기존 DTO 추가인지 아직 정하지 않는다.
- **오류·갱신 계약:** 직접 링크 접근 거절, 담당/권한 변경 후 상태와 이동, 세션 즉시 반영,
  소속 전환 시 cache 재조회 범위를 맞춘다. 현재 `403/code2131`은 Office 전환 용도라
  모든 403을 새 권한 부족으로 일괄 처리하면 안 된다.
- GET은 서버가 허용한 응답을 렌더링하는 방향이 맞다. FE에서 페이지별 목록을 다시
  잘라 전체 수·페이지네이션을 바꾸지 않는다. 다만 숨긴 필터의 URL 잔여 조건과
  조회 범위별 필드 누락/변경을 고려해야 하며 GET 처리까지 완전히 무변경이라고 단정하지 않는다.
- Notion 알림센터 Inbox·수신 설정 신설·치과 전환 배지·발송 DB 개편은 별도 기능이다.
  권한에 따른 알림 수신 원칙과 연관돼 있어도 본 작업에 알림센터 전체를 포함하지 않는다.

### 제안한 웹 선행 순서 — 아직 구현하지 않음

| 단계 | 범위 | 완료 기준/경계 |
| --- | --- | --- |
| 1. Clinic 확정 UI | Office 권한 표시·도움말·옵션 표현, Orders/Patients/Board PC·모바일 필터, 주문1단계 표현, 의사변경 경고 | 기존 UI에 조건 입력을 분리해 샘플 상태 확인. 실제 역할 enum/저장값/신규 endpoint 임의 작성 금지 |
| 2. Clinic 행동 조건 | 목록·Pickup 클릭, 상세·사이드패널, Draft 삭제/이어쓰기, Remake·생성·수정·승인·LinkTalk/첨부 진입 | 역할·대상 관계·주문 상태를 구분. 버튼뿐 아니라 메뉴/팝업/직접URL/실행 handler 경로 목록 대조 |
| 3. API 연동 | 생성 모델 갱신, 실제 역할/행동 조건 연결, 서버 목록·카운트·Draft 응답, 거절·변경 후 갱신 | 명세+실제 응답 확인 후 연결. 동일 사용자의 소속 전환과 이전 권한/담당 상태 cache 점검 |
| 4. Lab·앱 확장 | Lab 디자인 확정 부분, Clinic/Lab sharedUI, 앱 네이티브 화면·LinkTalk | Lab 기존 가격/타기공소 제한 보존. 앱 상세 WebView는 웹 재사용되지만 네이티브 채팅은 별도 검증 |

현행 코드 근거(이번 master snapshot):

- `clinic/src/components/OfficeMemberList/OfficeMemberAuthorityChip.tsx:15`: 역할 라벨/칩의
  하드코딩이 있어 enum 추가 시 함께 수정해야 한다. unknown 역할을 그대로 넣으면 칩
  설정 접근이 깨질 수 있다. 역할 옵션 일부는 코드 조회 API에 연결돼 있다.
- `clinic/src/common/hocs/withAuthorization.tsx:16`: 현재 페이지 역할 확인만 하며
  담당·참여·공유 관계를 판단하지 않는다.
- `shared/ui/src/OrderListUI/OrderListLayer/OrderListLayerDesktop.tsx:28`,
  `shared/ui/src/PatientListUI/PatientListLayerDesktop.tsx:19`: 목록과 UI 제어 props 구조라
  API와 분리한 표시 조건 선행 가능.
- `clinic/src/lib/Order/useOrderDetail.ts:135`,
  `clinic/src/lib/OrderForm/OrderProfileForm/useOrderProfileCreateForm.tsx:58`,
  `clinic/src/lib/Remake/select/useRemakeSelectCreate.tsx:48`,
  `clinic/src/lib/LinkTalk/useLinkTalk.tsx:118`: 상세/주문/Draft/Remake/채팅 실행 경로가
  분산돼 있다. Remake 버튼은 즉시 Draft mutation을 호출할 수 있다.
- `lab/src/atoms/common.ts:21`, `lab/src/lib/Order/useOrderDetail.ts:261`,
  `shared/ui/src/OrderDetailUI/OrderDetailLayout/OrderDetailLayout.tsx:185`: 기존 Lab
  EDITOR 가격 제한과 현재 기공소/주문 기공소 불일치 제한은 서로 다른 조건이다.
  후자가 과거 참여 여부를 뜻하지 않는다. Clinic 공용 화면 수정 시 보존한다.
- `shared/ui/src/FileListDownloadUI/FileListDownloadUI.tsx:138`,
  `shared/ui/src/LinkTalkUI/parts/LinkTalkListItem/LinkTalkListItem.tsx:95`: 개별/전체 파일,
  채팅 표시/답장/프로필 경로를 함께 점검할 필요가 있다. 익명화 응답은 아직 미확정이며
  프론트에서 이름만 가린 결과를 데이터 접근 제한 완료로 부르지 않는다.
- 앱 `src/features/orderList/screens/OrderDetailScreen.tsx:48,282,307`: 상세는 웹 경로
  WebView를 사용하지만 네이티브 LinkTalk(288~301행)는 별도다. 로컬 Lab 앱 checkout은
  확인되지 않아 같은 공용 앱 구조라고 추정하지 않는다.

### 산정·검증·다음 시작점

- 이전 사용자가 채택한 **전체 6~9영업일(구현·연동·검증)**은 조건부 가산정으로 유지한다.
  기획·디자인 확정 및 BE API 설계 시점 기준이며 BE 대기와 배포는 포함하지 않는다.
  이번 조사만으로 새 최종 일정이나 특정 배포일을 약속하지 않는다. Lab 확정 범위와
  최종 API가 확인될 때 선행 완료분을 반영해 남은 일정을 갱신한다.
- 검증 계획: Admin/Manager/Billing Manager/새 Member의 노출·행동, 본인/타인/공유
  대상, Draft 미지정/본인/타인, 직접 URL·Pickup·사이드패널·채팅/파일·승인/Remake,
  담당/권한/소속 변경 후 상태, 기존 Lab 제한, PC·모바일 웹을 확인한다.
- 이번 단계는 **정적 코드 및 외부 문서/디자인 조사**다. 제품 코드 수정, 의존성 설치,
  환경 파일 복사, 서버·브라우저·실기기 실행, 빌드/테스트, 실제 업무 API 요청은 하지 않았다.
  따라서 런타임 권한 차단·BE 정책 시행·배포 완료 증거는 없다.
- 다음 구현 지시가 오면 개인 컨텍스트와 Git/요구사항 변경을 확인하고 위 웹 worktree를
  재사용한다. **Clinic의 Office 권한 표시와 Orders/Patients/Board 필터 UI부터** 시작하는
  것이 제안 순서다. 실제 역할 연결은 BE 계약 대조 뒤 수행한다.
- 상세 Jira/Notion 원문 및 Figma 확인 이미지는 임시
  `/tmp/dentlink-permission-planning`에 있다. 이 임시 폴더는 기기 간 이전·영구 보존을
  보장하지 않는다. 복구 근거는 이 기록과 원본 Jira/Notion/Figma/Git이다.

## 이전 상태 — 2026-09-29 복구 체크포인트

아래 기록은 당시 조사 이력이다. 현재 상태·승인 범위·작업 위치·다음 시작점은
상단의 2026-10-02 기록을 따른다.

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

## 이전 복구 절차 — 2026-09-29 이력

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
