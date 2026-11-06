# 웹 주문 지연 라벨 — DL-17141

## 현재 체크포인트 — 사용자 병합·배포 정상 진행 보고 후 마감·대기, 2026-11-06

- **사용자 확인:** 사용자가 스테이징 PR4844를 직접 병합했고 “배포도 잘 돌아가고”라고 보고하며 정리·메모리·대기를 요청했다. PR4844의 병합 완료와 배포 정상 진행은 사용자 확인으로 기록한다. 아래 OPEN/미병합/병합 대기 문구는 준비 당시 이력이며 현재 남은 작업으로 되돌리지 않는다.
- **완료한 작업:** 웹 isDelayed 정책 구현·공통화, PR4843 릴리즈 병합 확인, stage 복구점 보존·삭제·master 기반 재생성, release/v1.92.0 전체 전달 PR4844와 세 서비스 트리거 검증까지 완료했다. 환경별 Swagger/서버 계약 판단 원칙도 공통 지침에 저장·푸시·로컬 동기화했다.
- **검증 경계:** 이번 마감에서는 GitHub merge SHA·Actions 최종 결과·실제 서빙 리비전·전체 E2E·화면을 추가 조회하지 않았다. 사용자 보고를 독립 배포 검증이나 전체 QA 통과로 확대하지 않는다. 기존 코드 검사·렌더100건 및 릴리즈 전체 E2E의 정적 확인 한계는 아래 기록을 유지한다.
- **보존:** 이 개인 체크포인트만 commit/push한다. 제품 코드·브랜치·PR·배포·서버·창·앱 세션은 변경하거나 추가 조회하지 않으며, 이전에 확보한 feature와 stage 복구 참조를 보존한다.
- **다음 시작점:** 현재 추가 작업 없이 대기한다. 사용자 피드백이나 새로운 명시적 요청이 오면 그 범위에서 최신 상태를 확인한다. 자동 배포 감시·E2E·CodeRabbit 대응·브랜치 정리·다른 세션 전송은 하지 않는다.

## 이전 v1.92.0 stage 초기화·배포 PR 준비 기록 — 2026-11-06

- **최신 요청:** 사용자가 “스테이징 배포 프로세스도 지우고 배포하는 것”을 요청한 뒤, 방금 머지한 PR을 포함한 **릴리즈 브랜치 전체를 스테이징에 반영**하려는 것이라고 명확히 했다. 공통 배포 준비 지침에 따라 기존 stage 삭제·master 기반 재생성·release→stage PR까지 수행한다. 새 PR의 merge/배포 시작은 별도 지시 대상이다.
- **병합 확인:** PR4843은 2026-11-06 15:28:03 KST에 release/v1.92.0에 병합됐다. 최신 릴리즈 `cfe42ad6a5d15ae237088cac32bc3ff9a8d023c9`, 원본 feature `feat/DL-17141-delay-cleanup@a4f70d33c5d4fb61767512530c8783067132d7e7`는 보존했다. local release는 기존 cdcd371ef에서 원격 최신으로 fast-forward하여 가드가 오래된 local ref를 사용하지 않도록 했다.
- **완료 PR:** [#4844](https://github.com/Innvoaid/dentlink-client/pull/4844), `[DL-17141] v1.92.0 스테이징 배포 준비`, `release/v1.92.0 → stage`. 생성·첨부 후 OPEN/일반/mergeable:true/merged:false, 실제 base `c5a4b5e372fb7734c72a5faec6807e7b554c1dd6`, head `cfe42ad6a5d15ae237088cac32bc3ff9a8d023c9`, 17커밋·121파일을 확인했다. REST pagination으로 GitHub 전체 파일 목록이 로컬과 동일함을 확인했다(gh pr view files는 첫 100개만 반환하여 그대로 전체 확인으로 간주하지 않았다).
- **stage 초기화:** 기존 stage `3ada04a14704ffbc082323a0e1290526d05c353a`, 열린 stage 대상 PR 0개, protected:false·유효 rules:[] 확인. `refs/recovery/stage-before-v1.92.0-dl17141-cleanup-20261106` 및 검증된 `/tmp/dl-17141-stage-20261106/stage-before-reset.bundle`에 복구점을 보존했다. 예상 SHA lease로 원격 stage 삭제 → 원격 부재·master 최신 재확인 → 비존재 lease로 exact master `c5a4b5e372fb7734c72a5faec6807e7b554c1dd6`에서 재생성 → 원격 stage=master 확인. 과거 stage→main rename 안내가 push에 출력됐지만 실제 ref는 의도한 stage/master 값이다.
- **트리거 검증:** 기존 stage→release 차이는 shared 4파일이라 세 서비스 경로 필터를 만족하지 않았다. reset 후 최종 PR 3dot 121경로·실제 master→merge 결과114경로이며, 양쪽 모두 Clinic39/Lab17/Admin13 경로가 포함되어 각 `push: stage` + `clinic/**`/`lab/**`/`admin/**` 조건을 충족한다. Clinic은 build→Seoul/Ohio→셋 성공 시 verify이며 Lab/Admin은 별도 job-level if/needs가 없다. PR에만 보이는 workflow/E2E 7경로는 master에 이미 같은 내용이 있는 별도 통합 이력이다.
- **병합·검사:** merge-tree 충돌 없음(exit0), 결과 tree `fdb82d40bded7f68dfcea1c18a091075550f6f33`가 릴리즈 및 현재 feature 전체 tree와 동일하다. stage 삭제·재생성의 정상 push hook 모두 통과: Clinic/Lab/Admin lint 기존225/185/393 warnings·error0, Admin guard9·공유53 tests/coverage. hook을 실행한 feature와 전달할 릴리즈의 추적 파일 내용이 동일하므로 검사 대상을 구분해 기록했다. 제품 코드 추가 수정·hook 생략 없음.
- **전체 릴리즈 E2E:** 독립 최종 NEEDS_RUN 판정. 미처리 locator 파손은 없고 CAD Change→Upload는 기존 E2E에 반영됐다. 배송 예상일 조회 실패 시 선택한 제작 상태 전환·빈 예상도착일 서버 수용·후속 배송 가능 여부는 정적 확인 불가다. 04_labShipment serial 전체와 실패 분기 관측, 05_labStatus·08_orderFeedback이 권장 범위이며 실제 데이터 변경 E2E는 이번 준비에서 실행하지 않았다. mark/check를 최종 stage/release refs로 통과시켰고 한계를 PR에 기록했다. 이번 배지 정리 단독 NO_IMPACT와 전체 릴리즈 가드를 혼동하지 않는다.
- **배포 상태 경계:** 재생성 뒤 시작 메타데이터를 한 번 조회했을 때 최신 stage push run은 기존 14:56:36 KST/3ada04a의 Office·Lab·Admin 세 run이었다. 재생성 master 또는 새 release의 실행은 그 관측에 없었다. 결과 상태를 조회·감시하거나 PR을 병합·workflow dispatch하지 않았다. 실제 최신 릴리즈 배포 성공·서빙 리비전·전체 E2E·실사용 화면 확인을 완료로 보고하지 않는다.
- **보존·다음 시작점:** product checkout은 원래 feature a4f70d33c/upstream 일치·clean, 다른 worktree/서버/창·앱 세션은 변경하지 않았다. 개인 체크포인트만 commit/push 후 대기한다. 다음 사용자 요청은 PR4844 검토/merge 또는 명시적 배포 작업을 시작점으로 삼는다. 서버 결과 확인 요청 시 시작 후15분·후속 최소3분 간격 규칙을 적용한다. 자동 merge·배포·추가 E2E·리뷰 대응·모니터링·브랜치 정리는 하지 않는다.

## 이전 PR 설명 정정·기록 마감 — 2026-11-06

- **최신 요청·경계:** 사용자는 기존 웹·백엔드의 스테이징 반영을 전제로 추가 코드 정리를 요청했고, 이번에는 즉시 배포할 필요 없이 후속 PR까지만 지시했다. merge·배포·앱 세션 전송·자동 리뷰 감시는 하지 않는다.
- **최종 마감:** 사용자의 “PR 정정할 것이 있으면 하고 정리메모리·대기” 요청에 따라 PR4843 본문의 API 계약 설명만 정정했다. Lab 목록 isDelayed의 STG 선반영·DEV 미반영을 사용자가 백엔드에 확인한 사실로 명시하고, 기공소 웹 라벨은 기존 상세 `deliverySchedule.isDelayed`를 사용하여 이번 PR에 Lab 목록 DTO 추가가 필요하지 않음을 적었다. 원래의 검증 범위와 자동 생성된 PR 부록은 보존했다. 변경 본문 재조회 일치·OPEN/일반/release v1.92.0·동일 HEAD·제품 clean을 확인했고 코드 변경이나 검사 재실행은 하지 않았다.
- **완료:** [일반 PR #4843](https://github.com/Innvoaid/dentlink-client/pull/4843), `feat/DL-17141-delay-cleanup → release/v1.92.0`, OPEN/isDraft:false/4파일을 생성 후 재확인하고 채팅에 첨부했다. commit/local/upstream `a4f70d33c5d4fb61767512530c8783067132d7e7`. 기존 PR4837은 2026-11-06 10:51:41 KST `cdcd371ef2c6b5df4ac746a0c2b2f43502e1d5c8`로 release에 병합된 사실을 앞선 재개 조사에서 확인했다. 기존 PR을 다시 수정하지 않았다.
- **작업 기반·보존:** 최신 확인된 `origin/release/v1.92.0@74454e95ea14f86cb351cc6c25d0c7ef9d70f85f` 기반 후속 branch이며 원래 feat/DL-17141·feat/DL-17141-delay-label은 보존했다. 현재 제품 checkout은 `/Users/parkjongsun/Repository/dentlink-client`, feat/DL-17141-delay-cleanup. 사용자 실험으로 동시에 생긴 `shared/models/src/Admin.ts`, `Lab.ts`, `data-contracts.ts` 변경 3개는 사용자의 명시적인 폐기 지시에 따라 원복했으며 최종 checkout은 clean이다.
- **변경 4파일:** `shared/configs/utils/order.ts`에 `getOrderDelayBadgeStatus`를 두어 DELAYED/ON_TIME/undefined를 반환하고, 공통 주문상세·치과 PC 목록·모바일 목록에서 표시 여부/문구/색상을 같은 결과로 결정한다. 기존 Office 전용 helper와 배포 전 TODO를 제거하고 확정된 표시 정책을 공통 함수 주석으로 남겼다. 상태 타입의 중복 union만 단순화했고 API·DTO·generated 모델은 변경하지 않았다.
- **유지한 정책:** 서버 isDelayed를 사용하고 날짜로 재계산하지 않는다. OFFICE는 true이며 COMPLETED/CANCELED일 때 Delayed만 숨기고 기존 false/undefined On Time은 유지한다. LAB은 true/false를 서버 그대로 표시하며, 누락/undefined/null/비boolean은 두 배지 모두 숨긴다. LAB에 OFFICE의 완료·취소 숨김을 적용하지 않는다. ADMIN/SYSTEM/서비스 미지정, 상세 날짜/제작 전 예외, 목록의 진행·완료·취소/officeEstimatedArrivalAt 조건도 보존한다.
- **환경별 계약 최종 확인:** 사용자가 백엔드에 직접 재확인했다. 기공소 목록 isDelayed는 **실제 STG 응답에 있고 DEV에는 없으며, 이번 건만 STG에 먼저 반영한 예외**다. DEV Swagger에 필드가 없는 것은 이 환경 차이 때문이며 STG 백엔드 미제공·계약 미확정을 뜻하지 않는다. 직접 조회한 DEV 명세는 `OrderDeliveryScheduleDto.isDelayed`·`OrderOfficeListDto.isDelayed`를 optional boolean으로 정의하고 `OrderListLabDto.isDelayed`는 없다. STG `/v3/api-docs` 404는 해당 문서 경로의 접근 결과이며 STG 실제 응답의 필드 부재를 증명하지 않는다. 웹에서 사용하는 상세 타입은 이미 존재하여 이번 PR은 API·DTO 변경 없이 표시 정책만 공통화했다. 이후 목록 타입을 사용하는 작업에서 필요하면 대상 환경 Swagger/백엔드가 확인한 계약을 근거로 실제 소비 FE 타입을 맞추며 DEV 반영을 기다릴 필요는 없다. 필드 존재만으로 required/nullability를 확대하지 않는다.
- **공통 지침 갱신:** 사용자 요청으로 AGENTS 진입점과 DEVELOPMENT_STYLE의 API Contracts Across Environments에 환경별 계약 판단·FE 복사/생성 타입 소비 기준을 추가했다. 이번 사례는 이 체크포인트에, 재사용할 원칙은 공통 지침에 둔다.
- **지침 보존:** 공통 지침 commit `643d3bd`를 원격에 push하고 `setup-local-codex.sh`로 로컬 지침까지 동기화했다. AGENTS/DEVELOPMENT_STYLE/MEMORY_CHANGELOG의 정본·로컬 일치를 확인했다. 이번 최종 마감은 이 개인 체크포인트만 추가 commit/push하며 다른 프로젝트·앱 세션에 전송하지 않는다.
- **검증:** 변경 실제 컴포넌트 ReactDOM SSR 100/100 통과, release74454e95 대비 표시·텍스트·전경 CSS·배경색·날짜 동일. 최종 커밋과 검사 소스 4개 SHA256 일치 확인. 번역/무관한 자식 일부를 격리한 검사이며 브라우저·실계정 API·실제 서버/배포 QA와 구분한다. Clinic/Lab/Admin 타입, 변경 UI ESLint·Prettier·diff 검사, 정상 push hook 3서비스 lint(기존 경고225/185/393, error0), Admin guard9, 공유53 tests/coverage 통과. 독립 코드리뷰 수정사항 없음.
- **E2E 영향:** 독립 NO_IMPACT 판정. 승인·완료·피드백·LinkTalk의 버튼/문구/API 접점을 유지한다. mark/check를 최종 커밋 기준으로 기록하고 PR 생성 직전에 통과했다. E2E 파일 변경·실제 데이터 기반 실행은 하지 않았다. 임시 검증 증거 `/tmp/dl-17141-delay-cleanup/render-check.cjs`, `render-results.json`, `commit.log`, `push.log`; 실제 DEV 명세 조회 파일 `/tmp/dl-17141-cleanup/development-openapi.json`. 임시 경로는 이후 사라질 수 있다.
- **현재 영향·남은 일:** 새 정리는 PR/feature에만 있고 현재 배포에는 추가 영향을 주지 않는다. 사용자 PR 검토 및 추후 별도 merge/배포 지시를 기다린다. 이전 배포 성공은 사용자 확인으로 기록하며 이번 작업에서 Actions 완료·실제 서빙·인증 화면을 새로 검증했다고 표현하지 않는다. 기공소 STG 목록 필드 제공은 사용자·백엔드 확인으로 확정했고 DEV Swagger 갱신은 이번 웹 작업의 완료 조건이 아니다. 이번 PR에 목록 DTO 추가는 없고 앱 세션에는 사용자가 직접 전달한다.
- **다음 시작점:** 사용자 피드백 또는 명시적인 후속 요청이 있을 때 PR4843과 해당 feature부터 확인한다. 현재 요구에 남은 코드 수정은 없으며 자동 CodeRabbit 대응·merge·배포·모니터링·브랜치 정리는 시작하지 않고 대기한다.

## 이전 서버 판정 기준 최종 확정·마감 기록 — 2026-11-05

- **최종 합의:** 웹·앱을 떠나 치과와 기공소의 지연 여부는 서버 isDelayed를 따른다. 치과는 기존 서버 판정에 완료·취소 지연 라벨 숨김만 신규 추가한 것이다. 기공소의 문제는 자체 날짜 계산이었으며, 서버 키가 있으면 치과처럼 서버 판정을 사용하고 키가 없을 때만 라벨을 숨긴다. 기공소에 치과의 완료·취소 숨김 조건을 적용한다는 뜻이 아니다. 웹 구현은 이 기준을 만족한다.
- **세션 경계:** 사용자가 앱 세션에는 필요한 내용을 직접 전달했다고 명시했다. 이미 보낸 메시지는 그대로 두고 추가 조치하지 않는다. 앞으로 앱 세션 공유·작업 지시는 사용자가 해당 전달을 명시적으로 요청할 때만 한다. 과거 한 차례의 공유 승인을 이후 업데이트의 자동 재전송 허가로 해석하지 않는다.
- **마감 확인:** 최종 HEAD/upstream 0b01b1427, 제품 checkout clean, PR4837은 release/v1.92.0 대상 일반 OPEN으로 재확인했다. 제품 추가 변경·머지·배포·앱 전송 없이 개인 메모리만 commit/push하고 대기한다. 다음 시작점은 PR 검토/병합 또는 별도 승인된 배포이며, 아래 TODO와 Clinic/Lab 웹 트리거를 확인한다.

- **추가 사용자 요구:** 기공소의 isDelayed 키/값이 없으면 라벨을 아예 표시하지 않는다. 실제 배포 때 코드 주석의 서버 확인 사항을 처리하고, 확정된 계약에 맞춰 로직을 더 일반적으로 정리한다. 이 요구가 아래의 이전 'LAB 웹 추가 변경/배포 불필요' 판단을 대체한다.
- **완료:** 상세의 배지 표시 조건에 `(serviceType !== "LAB" || typeof isDelayed === "boolean")`을 추가했다. LAB 키 누락/undefined/null은 Delayed·On Time 모두 숨기고 true/false는 기존 서버 판정 표시를 유지한다. OFFICE의 완료·취소 지연 숨김, false/undefined On Time 및 날짜/목록 동작은 그대로다. commit `0b01b1427ca92f64515e86fc3d09b81063eead71`, local/upstream 일치·clean.
- **PR:** [#4837](https://github.com/Innvoaid/dentlink-client/pull/4837)을 `[DL-17141] 치과 지연 라벨 숨김 통일 및 기공소 누락값 처리`로 갱신했다. release/v1.92.0 대상 일반 OPEN, 최종 HEAD 확인. merge·배포는 하지 않았다.
- **배포 TODO:** shared 상세133–137행에 GET `/lab/orders/{orderId}`의 deliverySchedule.isDelayed와 POST `/lab/orders/search`의 isDelayed 제공·판정 일치를 실제 배포 시 확인하고, 확정된 boolean 계약에 맞춰 선택 타입/서비스별 임시 분기를 공통 표시 조건으로 단순화하도록 남겼다. 날짜 재계산·누락값을 정상으로 간주하는 fallback은 없다. 아직 실제 서버 계약/배포 확인이나 후속 일반화는 수행하지 않았다.
- **배포 범위 정정:** 이제는 누락값 숨김 때문에 **Clinic·Lab 웹 모두** PR 전달 범위다. Lab 앱 상세 WebView는 Lab 웹 배포를 소비한다. shared-only diff이므로 실제 배포 준비에서 두 웹 workflow trigger를 최종 release→reset-stage diff로 확인해야 한다. LAB 앱 네이티브 처리는 별도 앱 세션 담당이다.
- **검증:** 최종 실제 ReactDOM 컴포넌트 렌더100/100 통과. LAB 누락키/undefined/null 15조합만 On Time→미표시로 바뀌고 나머지 boolean·OFFICE·날짜·PC/모바일 목록은 보존된다. Clinic/Lab/Admin 타입, 변경 파일 lint/Prettier, 정상 push hooks, 최종 E2E NO_IMPACT mark/check 통과. 브라우저·실계정 API·기기·실제 E2E 검증은 아니며 증거는 `/tmp/dl-17141-followup/render-results.json`, `missing-delay-push.log`다.
- **이전 공유 이력:** 앱 채팅 01a1aa21-103b-7e82-b530-9b203c18cfe9에 누락값 기준, 배포 TODO, LAB 웹 추가 배포 범위와 PR 상태를 전송했다. 사용자가 이후 자동 전달을 정정했으므로 위의 최신 세션 경계를 우선한다. 기존 메시지를 취소하거나 후속 메시지를 보내지 않는다. 다음 실제 배포 요청에서 TODO·계약·트리거를 검토한다.

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
