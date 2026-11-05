# 치과 웹 완료·취소 주문 지연 라벨 — DL-17141

## 현재 체크포인트 — 기공소 누락값 라벨 숨김·PR 갱신·대기, 2026-11-05

- **추가 사용자 요구:** 기공소의 isDelayed 키/값이 없으면 라벨을 아예 표시하지 않는다. 실제 배포 때 코드 주석의 서버 확인 사항을 처리하고, 확정된 계약에 맞춰 로직을 더 일반적으로 정리한다. 이 요구가 아래의 이전 'LAB 웹 추가 변경/배포 불필요' 판단을 대체한다.
- **완료:** 상세의 배지 표시 조건에 `(serviceType !== "LAB" || typeof isDelayed === "boolean")`을 추가했다. LAB 키 누락/undefined/null은 Delayed·On Time 모두 숨기고 true/false는 기존 서버 판정 표시를 유지한다. OFFICE의 완료·취소 지연 숨김, false/undefined On Time 및 날짜/목록 동작은 그대로다. commit `0b01b1427ca92f64515e86fc3d09b81063eead71`, local/upstream 일치·clean.
- **PR:** [#4837](https://github.com/Innvoaid/dentlink-client/pull/4837)을 `[DL-17141] 치과 지연 라벨 숨김 통일 및 기공소 누락값 처리`로 갱신했다. release/v1.92.0 대상 일반 OPEN, 최종 HEAD 확인. merge·배포는 하지 않았다.
- **배포 TODO:** shared 상세133–137행에 GET `/lab/orders/{orderId}`의 deliverySchedule.isDelayed와 POST `/lab/orders/search`의 isDelayed 제공·판정 일치를 실제 배포 시 확인하고, 확정된 boolean 계약에 맞춰 선택 타입/서비스별 임시 분기를 공통 표시 조건으로 단순화하도록 남겼다. 날짜 재계산·누락값을 정상으로 간주하는 fallback은 없다. 아직 실제 서버 계약/배포 확인이나 후속 일반화는 수행하지 않았다.
- **배포 범위 정정:** 이제는 누락값 숨김 때문에 **Clinic·Lab 웹 모두** PR 전달 범위다. Lab 앱 상세 WebView는 Lab 웹 배포를 소비한다. shared-only diff이므로 실제 배포 준비에서 두 웹 workflow trigger를 최종 release→reset-stage diff로 확인해야 한다. LAB 앱 네이티브 처리는 별도 앱 세션 담당이다.
- **검증:** 최종 실제 ReactDOM 컴포넌트 렌더100/100 통과. LAB 누락키/undefined/null 15조합만 On Time→미표시로 바뀌고 나머지 boolean·OFFICE·날짜·PC/모바일 목록은 보존된다. Clinic/Lab/Admin 타입, 변경 파일 lint/Prettier, 정상 push hooks, 최종 E2E NO_IMPACT mark/check 통과. 브라우저·실계정 API·기기·실제 E2E 검증은 아니며 증거는 `/tmp/dl-17141-followup/render-results.json`, `missing-delay-push.log`다.
- **공유·마감:** 기존 사용자 공유 승인에 따라 앱 채팅 01a1aa21-103b-7e82-b530-9b203c18cfe9에 최신 누락값 기준, 배포 TODO, LAB 웹 추가 배포 범위와 PR 상태만 전달했다. 전송 성공 확인 후 별도 진행 조회/회신/기기 검증/새 배포 요청은 하지 않았다. 개인 체크포인트를 commit/push하고 대기한다. 다음 실제 배포 요청에서 TODO·계약·트리거를 검토한다.

## 이전 웹 구현 마감·앱 인계 기록 — 2026-11-05

- **마감 확인:** 사용자의 최종 정리(치과 모든 노출부 숨김, 기공소 수동 판정을 서버값으로 통일)를 기준으로 웹에 필요한 구현은 모두 끝났다. 기공소 웹은 이미 서버 판정을 사용하므로 추가 변경이 없다. PR4837의 머지·배포는 별도 남은 전달 단계이며 구현 미완료와 구분한다. 마감 시 단건 조회로 PR OPEN/일반/release v1.92.0 대상·HEAD3d3344fef·제품 clean을 재확인했다.
- **공유 완료:** 사용자의 명시 승인으로 앱 채팅 `치과앱 완료·취소 주문 지연 라벨`(01a1aa21-103b-7e82-b530-9b203c18cfe9)에 웹 PR 상태, 웹뷰 배포 경계, LAB 목록/상세 서버 판정 정합성 및 필드 선행조건, 치과 목록 실노출 근거의 한계만 전달했다. 전송 성공 확인 후 앱 진행을 추가 조회하지 않는다. 새 구현·검증·배포·회신 요청은 하지 않았다. 앱 담당의 최신 DL-17262 체크포인트는 로컬 구현/관련 검증 완료, commit/push/PR/배포 미수행으로 구분돼 있다.
- **대기:** 이 개인 체크포인트만 commit/push하고 대기한다. 제품 코드·PR·Jira·서버·기기·창·브랜치를 추가 변경하거나 자동 머지/배포/리뷰 대응/감시/다른 세션 조회를 하지 않는다. 이후 사용자가 후속 작업을 요청하면 아래 PR와 배포 경계를 시작점으로 사용한다.

- **최종 요구:** 치과만 `isDelayed === true && (COMPLETED || CANCELED)`일 때 Delayed 라벨을 숨긴다. 기공소는 라벨 숨김이 아니라 앱의 수동 날짜 판정을 서버 `isDelayed`로 전환한다. 기공소 BE는 미배포이나 치과처럼 필드를 제공한다는 사용자 계약 가정으로 진행한다. 잘못 해석한 중간 LAB 숨김 코드는 커밋·배포하지 않고 폐기했다.
- **웹 완료:** [PR #4837](https://github.com/Innvoaid/dentlink-client/pull/4837), `feat/DL-17141-delay-label → release/v1.92.0`, 일반 OPEN/mergeable/4파일 확인. 최신 release `6a953cb1a`에서 후속 branch 생성, 최종 HEAD/upstream `3d3344fef2fce7070820bfc3e7082a28efc6e9aa`, clean. 원본 feat/DL-17141 보존. merge·배포는 하지 않았다.
- **변경:** shared/configs/utils/order.ts의 `shouldHideOfficeDelayedBadge`를 상세·PC 목록·모바일 목록 3곳에서 공통 사용. 상세133–134행에 치과만 숨김/LAB 서버값 사용/BE 반영 확인 주석을 남겼다. 목록은 기존에도 완료=날짜, 취소=`-`여서 기존 release 대비 가시 결과는 동일하다. 날짜·기존 On Time·진행 중 Delayed를 보존했다.
- **기존 웹 현황:** 치과 목록은 row.isDelayed와 officeEstimatedArrivalAt 존재 조건, 양 서비스 상세·앱 상세 WebView는 deliverySchedule.isDelayed를 사용한다. 실제 목록 응답에 필드가 있어 항상 라벨이 뜬다는 뜻은 아니다. 앞선 합성 검증에서 날짜 필드를 보충했던 점과 실노출 단정 오류를 사용자에게 정정했다. LAB 목록(table/kanban)에는 개별 배지 없음. dashboard delayCount는 별도 집계다.
- **기공소 웹:** GET `/lab/orders/{orderId}` → useOrderShowQuery → 공통 DeliverySchedule로 서버값을 그대로 전달하며 기존부터 날짜 수동 판정이 없다. 완료·취소여도 서버 true면 Delayed 유지. 따라서 이 요구만으로 LAB 웹 신규 동작 변경/배포가 필요한 근거는 없다.
- **앱 읽기 전용 감사:** Office 홈 Track Your Order·주문목록은 GET `/office/orders`의 서버 isDelayed를 사용하며 선행 DL-17248에서 숨김 적용 완료(기존 기록 기준 PR340 병합/Staging v343, 이번 배포 재조회 없음). LAB 일반목록에는 배지 없음. LAB 홈은 기존에 일반/리메이크 요청일과 예상도착일을 비교했다. 별도 `/Users/parkjongsun/.codex/worktrees/lab-delayed-api/dentlink-lab-app`, feat/DL-17262에서 item.isDelayed 사용으로 수정 중이며, POST `/lab/orders/search` 각 주문 필드 제공·Swagger 타입 갱신·날짜 fallback 없음 주석을 확인했다. 사용자도 앱 세션에 동일 요구를 직접 전달했다고 확인했으므로 앱 수정·기기·추가 메시지는 하지 않았다.
- **검증:** 실제 컴포넌트 ReactDOM 렌더80/80(최종 소스, 기존 release와 동일), 관련 Jest32, Clinic/Lab/Admin 타입, 변경 UI lint/Prettier, push hook의 lint·DLOS guard·공유53 tests/coverage 통과(기존 경고 유지). 렌더 검증은 무관 자식/번역 문맥을 격리했으며 브라우저·실계정·기기 증거가 아니다. E2E NO_IMPACT mark/check 통과, 실제 E2E 미실행. 증거 `/tmp/dl-17141-followup/`.
- **배포 대상:** 웹 공통화는 PR4837 병합 후 Clinic 웹 반영 대상이며 앱 상세는 웹 배포를 소비한다. LAB BE의 POST `/lab/orders/search` isDelayed 제공/판정 반영 후 Lab iOS·Android 변경을 활성화해야 한다. 미제공이면 undefined가 기존 On Time 분기로 흐른다. 상세 GET의 deliverySchedule.isDelayed도 BE 정책 확인 대상. 서버 판정 전환만으로 LAB 웹 재배포는 불필요하다. shared-only diff는 STG clinic/**·lab/** trigger를 직접 충족하지 않으므로 이후 배포 준비 때 정해진 release→reset-stage 최종 diff로 다시 확인한다.
- **남은 일:** 사용자 PR 검토/병합 및 별도 요청에 따른 웹 배포. LAB 앱 구현·검증·배포는 앱 세션 담당이며 BE 반영 확인은 실제 전달 시 필요하다. 자동 머지·배포·리뷰 대응·감시를 하지 않는다. 아래는 선행 이력이다.

## 선행 스테이징 배포 완료 보고 당시 기록 — 2026-11-05

- **완료:** 치과 완료·취소 주문의 Delayed 라벨 수정·검증·구현 PR4835와 v1.92.0 stage reset/recreate·배포 PR4836 준비를 완료했다. 사용자가 이후 “머지하고 배포까지 완료했어. 메모리 정리하고 대기해줘.”라고 보고했다.
- **현재 영향:** [PR4836](https://github.com/Innvoaid/dentlink-client/pull/4836)의 병합 및 v1.92.0 스테이징 배포 완료는 **사용자 보고**로 기록한다. 이번 마감에서는 GitHub 병합 SHA·Actions 최종 결과·서빙 리비전·실제 Staging 화면·독립 E2E 결과를 추가 조회하지 않았다. 사용자 배포 완료를 에이전트 런타임 QA나 E2E 통과로 확대하지 않는다.
- **요구·결정:** OFFICE에서 지연 true인 완료/취소 주문의 Delayed만 숨긴다. false/undefined의 기존 On Time, 날짜·진행 중 표시, LAB 동작은 유지한다. 구현·조건567개·관련32 tests·PC/모바일 로컬 화면 검증 증거는 아래 구현 기록에 보존했다. 앱 네이티브 작업·CodePush는 별도 DL-17248 세션의 기록을 따른다.
- **마감:** 이번 요청의 메모리 정리는 이 개인 체크포인트만 정리하여 commit/push한다. 제품 코드·브랜치·PR·Jira·기존 로컬 서버/창·다른 세션을 변경하지 않는다. 아래 PR OPEN/배포 대기 문구는 준비 당시 이력이며 현재 미완료 작업으로 되돌리지 않는다.
- **남은 일·다음 시작점:** 현재 추가 작업 없이 대기한다. 새 후속 요청이 있을 때만 해당 범위의 최신 Git/PR/배포 상태를 확인한다. 자동 상태조회·E2E 실행·리뷰 대응·배포·브랜치 정리·세션 보관·메인세션 전송은 하지 않는다. 이후 배포 검증이 요청되면 사용자 완료 보고와 독립 확인 결과를 구분한다.

## v1.92.0 스테이징 PR 준비 당시 기록 — 2026-11-05

- **당시 사용자 지시:** “머지배포는 내가할께 PR 까지했으면 대기”. PR4836 준비로 이번 요청을 마치며, 머지·배포는 사용자가 직접 진행한다. 추가 승인 질문·PR/Actions/서빙 상태 조회·자동 감시·후속 구현 없이 대기한다. 아래 PR 상태는 준비 당시 확인값이다.
- **요청 이력:** #4835를 직접 머지했다고 알린 뒤 정해진 스테이징 프로세스로 v1.92.0 전달을 요청하여 stage reset/recreate → 배포 PR까지 완료했다. 아래 구현 PR 미병합 기록은 당시 이력이다.
- **병합 확인:** #4835는 14:37:03 KST `fb9d64ed0c04ab41be4e9da3de62788783bc60df`로 release/v1.92.0에 병합됐다. 그 뒤 #4834 청구서 다운로드/API 후속 수정도 14:37:30 KST 병합되어 최신 release는 `6a953cb1a6cf524e248865e4868b839ed24cdf55`다. 두 수정 모두 이번 전달 범위에 포함된다.
- **완료:** [일반 스테이징 PR #4836](https://github.com/Innvoaid/dentlink-client/pull/4836)을 `release/v1.92.0 → stage`로 생성·첨부했다. GitHub 실제 OPEN/merged:false/draft:false/mergeable:true, base `c5a4b5e372fb7734c72a5faec6807e7b554c1dd6`, head `6a953cb1a6cf524e248865e4868b839ed24cdf55`, 13커밋/108파일(+6844/-1174)을 확인했다. 전체 GitHub 파일 목록이 로컬 diff와 동일하다.
- **stage 재생성:** 기존 stage `aa01dd4d6bb354b8d8bab28daf62cb2f80a67b3d`, 관련 열린 PR 없음, protection:false·effective rules:[] 확인. 복구 참조 `refs/recovery/stage-before-v1.92.0-dl17141-20261105` 보존 → 예상SHA lease로 remote stage 삭제 → 부재·최신master 재확인 → 비존재 lease로 위 master에서 stage 재생성. 원격 stage=master 확인. 과거 stage→main rename 안내가 push에 출력됐지만 실제 stage는 의도SHA이고 main ref는 없다.
- **배포 트리거:** 최종 PR과 실제 병합 diff 모두 Clinic30/Lab17/Admin12 경로가 각 STG workflow의 `push: stage` + `clinic/**`/`lab/**`/`admin/**` 조건을 충족한다. shared만으로는 트리거되지 않는다. Clinic은 build→Seoul/Ohio→양쪽 성공 시 verify, Lab/Admin은 별도 job-level if 없음. 독립 읽기전용 검토 완료. 기존 stage에서 바로 비교하면 신규21파일(Clinic12/shared9)뿐이어서 Lab/Admin 경로가 없었으므로 정해진 reset절차가 필요했다.
- **통합 결과:** `merge-tree(master,release)`가 `4ca1a139b65e222f1ee84148c6e782c57c7d2f60`이며 release tree와 동일, 충돌 없음. 실제 master→merge 결과는101파일. PR108파일 중 선행 CI7파일은 서로 다른 squash 이력으로 나타나며 master와 내용이 같다. master가 release의 ancestor라고 표현하지 않는다.
- **검증:** 삭제/생성 push 모두 정상 hooks 통과(기존 lint warning·error0, Admin guard·shared53/coverage). 현재 feat/DL-17141 checkout의 검사이며 최신 전체 release 런타임 QA와 구분한다. 최종 가드 `NEEDS_RUN` mark/check 완료. 미대응 locator 파손은 없으며 Change→Upload는 E2E에도 반영돼 있지만, 릴리즈의 배송 상태전환·CAD 승인/완료/피드백 STG 실증은 남는다. 이번 Delayed 단독은 NO_IMPACT이며 전체 릴리즈 가드와 구분한다. 실제 데이터 변경 E2E는 실행하지 않았다.
- **배포 상태 한계:** 재생성 직후 시작 메타데이터를 한 번 조회했을 때 새 stage push run은 없고 이전 13:53:23 KST/aa01dd4d6의 세 run만 보였다. 이후 감시·결과 조회는 하지 않았다. PR4836을 병합하거나 수동 dispatch하지 않았다. 실제 최신 릴리즈 배포·서빙리비전·Staging 웹뷰/사용자 QA는 아직 확인하지 않았다.
- **보존:** product checkout `feat/DL-17141@488575e8f`, upstream 동일·clean. 원본 feature/release 및 다른 worktree/IDE/서버는 변경하지 않았다. 상세 임시 증거는 `/tmp/dl-17141-qa/stage-delete.log`, `stage-create.log`, `stage-pr-files-{local,github}.txt`다.
- **다음:** 사용자의 새 요청을 기다린다. 이후 배포 결과 확인을 요청받으면 시작 후15분 및 후속 최소3분 간격 규칙을 적용하고, 배포 성공·독립 STG 전체 E2E 결과·실제 화면 QA를 각각 구분한다. 사용자의 직접 수행 예정 발언은 실제 병합·배포 완료 증거가 아니다.

## 구현 PR 전달 당시 체크포인트 — 2026-11-05

- **완료:** [일반 PR #4835](https://github.com/Innvoaid/dentlink-client/pull/4835)을 `feat/DL-17141 → release/v1.92.0`으로 생성·첨부했다. 실제 base/head/isDraft:false/변경 한 파일을 재조회했다. 사용자 최종 지시도 v1.92.0 PR까지이며 이후 직접 확인 예정이다.
- **현재 영향:** 구현은 feature branch와 PR에만 존재한다. merge·웹 배포·Staging/운영 서빙 검증·자동 CodeRabbit 대응은 하지 않았다. 앱 네이티브 PR/CodePush와 웹 상세 전달을 혼동하지 않는다.
- 세션: `치과 웹 완료·취소 주문 지연 라벨`, `01a1aa21-0ebc-75c0-9791-e5b21e524224`. local Mac / 메인 프로젝트 등록과 초기 실행 확인. 메인 세션이 gpt-6-astra/ultra 적용 확인을 기록했다.
- 승인: 웹 구현·검증·commit/push·`release/v1.92.0` 대상 일반 PR까지. merge·배포·자동 CodeRabbit 대응은 제외한다. 앱은 별도 DL-17248 세션 담당이다.
- 요구: OFFICE 서비스의 `isDelayed === true`이면서 `COMPLETED` 또는 `CANCELED`이면 Delayed 라벨만 숨긴다. 기존 false/undefined의 On Time, 날짜·진행 중 표시, LAB 동작 유지.
- 정본: [DL-17141](https://innovaid.atlassian.net/browse/DL-17141), [DL-17138](https://innovaid.atlassian.net/browse/DL-17138). 현재 원문 기준 Frankie 확정 댓글은 부모의 `44831`이다(접수 인계의 44828 참조와 다름). 원문·본문·댓글 실조회 완료.
- checkout: `/Users/parkjongsun/Repository/dentlink-client`. 기존 `feat/e2e-deploy-status@65dd71ddf` clean/upstream 동일 확인 후 보존. 최신 `origin/master@c5a4b5e372fb7734c72a5faec6807e7b554c1dd6`에서 `feat/DL-17141` 생성 확인. 시작 시 동명 local/remote 없음. PR 대상 최신 조회 `origin/release/v1.92.0@05243d50c4125166d723a4c3ed683bdd17cf75f3`.
- 최종 HEAD/upstream: `488575e8fb53fd85d31efa58dc2828d1948e8244`, clean·origin/feat/DL-17141 동일. 구현 커밋 `d80e110eb` + release 이력 통합 커밋 `488575e8f`. 기존 master 배포/E2E 작업과 release의 별도 squash 이력 때문에 보이던 선행 7파일을 제거하기 위해 대상 release를 feature에 merge했다. master 기반 출발과 기존 브랜치는 보존했다.
- 실제 변경: `shared/ui/src/OrderDetailUI/parts/BoxComponent/OrderDetailBoxDeliverySchedule.tsx` 한 파일 6줄 추가·1줄 삭제. PC/모바일 주문목록은 변경 없이 회귀 확인했다.
- 비파괴 통합 확인: 최신 release `05243d50c4125166d723a4c3ed683bdd17cf75f3` 기준 `git merge-tree --write-tree` 결과 `496080f224add315fa115383600c68e5a86905d5`가 HEAD tree와 동일하다.
- 남은 일: 사용자 PR 확인 및 별도 승인 시 merge/웹 배포. 앱 상세 WebView는 웹 배포 후 변경을 소비하므로 현재 Staging/운영 상세가 수정됐다고 보고하지 않는다. 자동 리뷰/배포 감시나 브랜치 정리를 시작하지 않는다.

## 검증·전달 — 최종 코드 기준

- 실제 소스의 조건식을 추출해 OFFICE/LAB/서비스 누락 × 완료/취소/진행/배송/승인대기/신규/상태 누락 × true/false/undefined × 날짜 유무 × 제작 전 예외를 조합한 567건을 확인했다. 기존 대비 변경되는 케이스는 OFFICE·지연 true·완료/취소뿐이었다.
- 실제 Next 로컬 페이지에서 저장된 DEV OWNER 로그인 재사용을 확인했다. 원본 완료·On Time 상세를 읽은 뒤, 브라우저 내부 GET 응답만 대체해 PC1440/모바일390 상세 14개 고유 조건과 목록8행(각 4행)을 검증했다. 완료·취소 true는 두 라벨 모두 없음, false/undefined는 기존 On Time, 진행중 true는 Delayed, 날짜없음/제작전은 기존 미표시. 날짜·상태 그래프 유지. uncaught page error 0.
- 업무 쓰기 요청은 테스트 context에서 차단했다(상세 자동 채팅 읽음 POST 포함). 인증 refresh만 정상 허용했다. 실제 서버 데이터를 바꾸거나 실제 계정 E2E를 실행하지 않았다. 브라우저 응답 대체는 해당 테스트 context에만 적용되므로 앱/다른 브라우저에는 적용되지 않는다. 실제 LAB 화면·앱 기기 WebView·다른 실제 권한 계정 검증은 이번 웹 화면 결과에 포함하지 않는다.
- 최종 Clinic/Lab/Admin 타입 검사 통과. `pnpm install --frozen-lockfile`로 release의 jszip 의존성을 설치한 뒤 재검증했다(설치 전 Clinic의 누락 모듈 오류 해소, 추적 파일 변화 없음).
- 관련 Jest: OrderDetailPage, useOrderDetailPermissions, useOrderShowQuery 3 suite·32 tests 통과. 독립 코드리뷰에서 조치 필요 결함 없음.
- 변경 파일 lint는 shared/ui의 기존 parent 설정 중복 플러그인 충돌을 확인한 뒤 해당 패키지 명시 설정으로 실행(`eslint <file> --no-eslintrc -c .eslintrc.cjs`)하여 통과. format/diff-check 통과. 전역 lint 설정은 수정하지 않았다.
- 정상 pre-commit 3서비스 타입 검사 통과. 정상 pre-push Clinic/Lab/Admin lint 통과(기존 warning 225/185/393, error0), Admin DLOS guard·shared coverage 검사 통과(config21+hook32 tests). hook 생략 없음.
- E2E 독립 영향 판정 최종 `NO_IMPACT`: 주문 상태 변경·피드백·링크톡의 기존 버튼/문구/API 접점 유지. E2E 파일 변경·실행 없음. `mark.sh NO_IMPACT release/v1.92.0 feat/DL-17141` 및 PR 생성 직전 check 통과.
- Jira 하위 DL-17141 댓글 `44832`에 비개발자용 결과·PR·미배포 사실을 남겼다. 부모 댓글·원문 수정은 하지 않았다. Jira 상태는 CHECK REQUEST를 유지했다.
- 로컬 증거(임시): `/tmp/dl-17141-qa/detail-results.json`, `list-results.json`, 영역 캡처 PNG, `push.log`. 화면 캡처는 배송 일정/합성 목록 영역만이며 인증자료를 포함하지 않는다.

## 로컬 연결·다음 시작점

- 개발 서버 cwd `/Users/parkjongsun/Repository/dentlink-client/clinic`, `pnpm --filter dentlink-clinic-web dev --port 3000`. 최종 확인 프로세스 PID39356, 로그 `/tmp/dl-17141-qa/clinic-server.log`. 필요한 앱 WebView 확인을 위해 유지했다. PID는 재사용 전에 소유/cwd/port를 다시 확인한다.
- Mac/iOS simulator: `http://localhost:3000/orders/{id}`. Android emulator: `http://10.0.2.2:3000/orders/{id}`. 로컬 웹은 기존 DEV env를 사용하며 Staging 토큰/계정과 별개다. 브라우저 fixture를 앱 실검증으로 확대하지 않는다.
- 에이전트 테스트 browser는 종료했다. 사용자의 기존 IDE·서버·창배치를 바꾸지 않았다. 초기 개인 기록 `d3e1e8b` 이후 이번 완료 기록도 이 파일만 commit/push한다.
