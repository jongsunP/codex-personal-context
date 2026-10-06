# Dentlink 권한관리 — DL-16317

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
