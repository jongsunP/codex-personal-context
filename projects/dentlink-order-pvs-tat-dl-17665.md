# 주문 PVS·픽업 변경 시 납기 재선택 — DL-17665 / DL-17671

## 현재 체크포인트 — 2026-11-27 커밋·푸시 후 종료

- 사용자 명시 요청: 웹·앱을 각각 커밋·푸시까지만 진행하고 PR은 만들지 않음. 검증용 실행 종료 및 필요한 문서/Jira 정리 완료. **배포 일정·대상 버전 미정,1.95.0 반영 결정 없음.** 새 지시 전 대기하며 자동 추적하지 않는다.
- 웹 `feat/DL-17665` → origin 동일 브랜치에 `b536b24fa3e2b02baa23c7db7ef64d61efd560c1` 푸시 완료. 앱 `feat/DL-17665` → origin 동일 브랜치에 `e563e7ee5d4f41793646194af293b38e7e1510ff` 푸시 완료. 두 커밋 제목 `fix: 픽업 조건 변경 시 납기 재선택 처리`. 각각4파일/1파일, 원격 SHA 일치·작업트리 clean 확인. 웹 master 기반023057ab6, 앱 main 기반dd9fc9a2 유지, 원본/타 작업 무변경. PR/merge/배포 없음.
- 기존 작업 폴더와 브랜치는 후속 PR을 위해 보존. 웹 `/Users/parkjongsun/Repository/dentlink-client-dl-17665/dentlink-client`, 앱 `/Users/parkjongsun/Repository/dentlink-app-dl-17665/dentlink-app`. 채팅 cwd도 기존 앱 worktree 유지. 앱 Jira를 분리했어도 이미 검증한 같은 작업 브랜치를 임의 개명/분리하지 않는다.
- 웹 commit hook의 Clinic/Lab/Admin 타입 검사 모두 통과. 처음 Lab 이미지 선언 오류는 ignored `next-env.d.ts` 부재였고 Lab/Admin `next typegen`으로 로컬 생성 파일만 준비해 해결, 제품/설정 diff 없음. push hook의 Clinic/Lab/Admin lint 오류0(경고226/186/396), Admin DLOS guard·테스트 통과, shared/configs77개·shared/hooks92개 테스트 통과. 커버리지 baseline 부재는 커버된49/36파일 및 해당 소스·테스트·설정·lock이 부모커밋과 무변경임을 확인한 뒤 프로젝트 명령으로 ignored baseline 생성, 재검사 delta0. 훅 우회 없음. GitHub 전송 정체는 원격 브랜치 부재 확인 후 정체 프로세스만 종료, HTTP/1.1·전송 timeout의 일회성 옵션으로 같은 커밋 재시도 성공(영구 Git 설정 변경 없음).
- Jira: 기존 [웹 DL-17665](https://innovaid.atlassian.net/browse/DL-17665)는 제목에 웹을 명시하고 원문 보존. 같은 부모DL-17654의 중복 하위/연결 카드가 없음을 확인해 [치과앱 DL-17671](https://innovaid.atlassian.net/browse/DL-17671)을 Frankie 담당으로 생성. 각각 댓글45388/45387에 동작·실검증·한계·commit 링크·PR 미생성·배포 미정 기록. 두 카드 **Ready for Deploy(개발 완료)** 전이 확인. 부모 댓글/설명, story points·fixVersion·due date는 변경하지 않음.
- 실행 종료: 이 작업 소유 웹3000·Metro8081·Reactotron9090 종료 및 listener 없음 확인. iPhone17Pro 시뮬레이터 shutdown·Android emulator5554 종료, booted/adb devices 없음 확인. 작업에서 연 DeviceHub와 adb server도 종료. 타 앱/작업 프로세스는 보존. 테스트 픽업 취소 상태, DRAFT9000010141만 재검증용으로 남음. 제품 최종 주문 접수/저장 미실행.
- 검증 근거와 남은 한계: 아래 DEV 웹 신규·수정/iOS·Android 신규 화면 검증 및 컴포넌트45개 assertion 결과를 유지. 앱 보류 주문 `Review Order`의 모바일 미지원 진입 때문에 해당 수정 화면은 실검증하지 못했으며 별도 확인 대상으로 Jira에도 기록. 전체 앱 QA/최종 주문 저장/네이티브 신규 빌드/배포 검증은 완료로 간주하지 않는다.
- 다음 시작: 사용자 PR 지시가 있을 때 현재 두 브랜치를 그대로 사용하고 목표 release를 그때 확인한다. 웹 PR 생성 전 E2E 가드 수행 필요(이번은 열린PR 없는 신규 branch push이므로 PR 단계 가드 미실행). 별도 픽업 화면 자동 납기·팝업과 Lab 앱은 범위 밖. 정본/Claude 보조 메모리 동기화, 메인 공통 파일 수정·자동 보고/폴링 없음.
- 후속 읽기 전용 확인(11/27): 사용자 요청으로 웹 release/v1.95.0 `55086c9a1` ← feat/DL-17665 `b536b24fa` 병합 가능성만 확인. fetch/GitHub compare/checkout 없는 merge-tree 결과 충돌0. 실제 merge tree `58d544f4`의 릴리즈 대비 diff는 이번 커밋의4파일·53추가/2삭제와 동일하다. PR3점 비교에는 master 쪽 과거 이력 때문에5커밋/12파일이 표시되지만, 이8개 추가 파일의 변경은 이미 릴리즈 내용에 반영되어 최종 병합 차이에 남지 않는다. 수정4파일의 릴리즈 원본도 작업부모와 동일하며, 별도 임시 index에서 이번 커밋만 적용하는 검사도 통과. 제품 checkout/브랜치/원격/PR/Jira/실행 상태 무변경. 실제 PR 가드/CI·병합 후 실행 검증은 하지 않았고, 이 확인은 배포·릴리즈 포함 승인으로 해석하지 않는다. 앱은 웹 release와 별도다.

## DEV 화면 검증 이력 — 2026-11-27

- 사용자 화면 사용 승인 후 웹 Chrome/CUA, iOS Device Hub/CUA, Android Maestro·ADB(별도 명시 승인)로 실제 DEV 계정 `frankieDevOffice`를 사용해 확인했다. 제품 코드 추가 수정 없음. **배포 일정 미정, v1.95.0 포함 결정 없음**(사용자 확인). 웹 origin/master 기반·앱 origin/main 기반의 각각 `feat/DL-17665`와 기존 작업 폴더를 유지한다. 제품 commit/push/PR/릴리즈 반영/배포 없음.
- 웹 신규 DRAFT `9000010141`(케이스명 `DL-17665 TAT QA`)에서 Scan 납기12/10 선택 → PVS 추가로 미선택·비활성 → 픽업11/30 예약 후 미선택 유지/최소12/11 → 납기12/18 선택 후 픽업12/1 변경으로 미선택 → 재선택 후 PVS 해제로 미선택을 확인했다.
- 웹 기존 보류 테스트 주문 `9000010099`: 진입 시 저장된12/17 보존 → PVS 추가로 미선택 → 픽업12/15 예약 후 서버 기준 선택 시작일2027/1/6, 예전12/17 복원 없음 → 1/8 재선택 후 PVS 해제로 다시 미선택. 예약 취소 후 저장하지 않고 상세로 돌아가 원래12/17·PVS 없음·Pending Order/보류 유지 확인. 최종 Save Changes/Place Order는 실행하지 않았다.
- iOS26.5 iPhone17Pro와 Android16 API36에서 위 DRAFT를 순차 사용했다. 양쪽 모두12/10 선택 후 PVS 추가·픽업11/30 예약 → 미선택 유지/최소12/11,12/18 재선택 후 픽업12/1 변경 → 미선택/최소12/14,12/18 재선택 후 PVS 해제 → 미선택을 실제 화면으로 확인했다. 테스트 픽업 모두 취소, 홈으로 복귀. DRAFT는 재검증용으로 남았으며 주문 최종 접수는 하지 않았다.
- 제한: Android 기존 보류 주문의 `Review Order`는 네이티브 수정 화면 대신 DEV 웹 `/orders/9000010099/option`으로 이동해 `Mobile Not Supported`에 막혔다. 현재 웹 `useOrderDetail.ts`의 `handlerReviewOrder`도 option으로 직접 이동하며 이번 변경 파일이 아니다. 보류 주문의 이 진입 경로는 별도 확인 대상이다. 이번 검증으로 앱의 모든 기존 주문 수정 경로가 정상이라고 확대하지 않는다. 앱 수정 상태 로직은 앞선 컴포넌트 검증 근거와 구분한다.
- 실행: 웹3000의 실제 cwd=해당 웹 worktree/clinic, Metro8081=앱 worktree 확인. iOS와 Android 모두 같은 Metro/DEV 코드에 연결됐고 Reactotron9090에서2개 연결 확인. 기존 설치된 DEV debug binary(iOS2.2.5/151, Android2.2.4/134)에 현재 JS를 번들링했으며 네이티브 재빌드는 하지 않았다. 확인 동작 중 앱 종료/오류 화면 없음, Android crash buffer 비어 있음, 당일 로컬 Dentlink crash report0. 전체 앱 무충돌 보장은 아니다.
- 검증용 웹/Metro·두 기기는 실행 상태로 남겼다(웹 PID18901, Metro PID19568; 로그 `/tmp/dl17665-web.log`, `/tmp/dl17665-metro.log`). Codex와 분리된 background process로 실행했으나 Codex 재시작 생존 시험은 하지 않았다. iOS keyboard capture는 원래 off로 복구. Terminal CUA 접근 제한/Android 창 미지원은 우회하지 않고 CLI 서버 실행/사용자 승인 Android 도구로 처리했다.
- 남음: 사용자 지시 시 제품 commit/PR 준비, 전달 시 앱 제품 카드·릴리즈 대상 확인. 배포 일정이나 릴리즈를 임의 확정하지 않는다. 이번 납기 변경 요구로 PM에게 다시 질문할 항목은 없다. 보류 주문의 앱 수정 진입 제한과 최종 주문 저장 미검증을 결과에 명시한다.

## 구현 이력 — 2026-11-27

- 사용자 “답변 오면 알려줄 테니 가능한 작업 진행”으로 웹 구현 승인, 이어 “답변 왔음. 확인하고 반영”으로 확정 범위 반영 요청.
- [PM 답변45383](https://innovaid.atlassian.net/browse/DL-17654?focusedCommentId=45383), Yoonie 11/27 15:55: **웹+치과앱 모두 적용**, 별도 픽업 화면의 자동 납기 변경·안내 팝업은 다른 분 배정 예정. 이번 작업은 웹/Office 앱 주문 작성·수정4단계의 PVS 추가·해제/픽업일 변경 → 납기 초기화·서버 최소일 이후 재선택이다. 두 범위 질문 해소. Lab 앱·별도 픽업 화면은 미포함.
- 웹: `/Users/parkjongsun/Repository/dentlink-client-dl-17665/dentlink-client`, `feat/DL-17665` @ `023057ab6`(최신 origin/master),4파일 미커밋 수정. 앱: `/Users/parkjongsun/Repository/dentlink-app-dl-17665/dentlink-app`, `feat/DL-17665` @ `dd9fc9a2`(fetch한 origin/main),1파일 미커밋 수정. 두 저장소 main/타 worktree 무변경.
- 앱 scope 확정 후 create_worktree로 추가 준비. 실제 Repository 아래 경로/Git 등록/첨부/채팅 persisted cwd=앱 worktree 확인. 앱 main eligible ignored env1개 opaque 상속·동일성/ignore 확인, 값 미열람. 웹 pnpm frozen offline·앱 Yarn4 immutable 의존성 설치 완료, lockfile 무변경.
- 웹 변경: `OrderAdditionalInfoForm.tsx`에서 픽업 조건을 실제 변경한 현재 주문을 추적하여 비운 납기를 저장된 날짜로 복원하지 않음. 같은 픽업일 재확정은 보존. 재선택 값이 새 최소일보다 이르면 다시 비움. 일반 접수 주문 수정 보존, ADMIN/LAB/초기 OFFICE_SCANNER 특례 유지. `calendars.query.ts` → `OrderAdditional.tsx` → `DeliveryInfo.tsx`로 조회중/오류 상태 전달하여 오래된 날짜 선택 방지.
- 앱 변경: `OrderAdditionalInfoSection.tsx`에서 PVS 토글/픽업 저장 성공·삭제 성공 시 납기 초기화. 픽업 변경 후에는 서버 최소일을 자동 확정하지 않음. 예약 mutation/최소일 조회중·실패 시 납기 선택과 변경된 주문의 요약 진행 방지. 동일 픽업일·저장/삭제 실패의 기존 값 유지. 기본 일반 주문 흐름 보존, 네이티브/화면 구성·문구 변경 없음.
- 검증: 실제 웹 폼+React Hook Form+실제 날짜 유틸/DeliveryInfo를 jsdom에서 실행,23개 assertion 통과. 실제 앱 컴포넌트+React Query의 기존 조회/변경 훅을 React Test Renderer에서 실행,22개 assertion 통과. PVS 추가/해제/픽업일 변경, 최소일 동일/앞당김/지연, 재선택/재조회, 조회 대기/실패, 예약 실패, 일반 주문/관리자/Lab/스캐너/DRAFT 경로를 필요한 범위로 확인. UI 주변 컴포넌트와 API transport는 stub, 실제 서버/기기 검증 아님. stdin 임시 실행으로 새 테스트 파일 미추가.
- 타입: 웹 일반 `type`는 새 checkout의 Next image 선언 부재로 기존 PNG import 오류. Next 제공 image 타입을 메모리의 compiler root에만 추가해 동일 tsconfig로 HEAD/현재 대조한 결과 모두 진단0. 앱 `yarn typecheck`는 기존7개 오류(Icon2/Tooltip/MessageText/useOrderAddProduct2/RootNavigator); HEAD 소스 대체 비교로 동일7개·새 오류0 확인. 생성 파일/공용 설정 수정 없음.
- lint: 앱 변경파일 통과. clinic 변경2파일 오류0/기존 effect 의존성 경고2. shared/ui lint는 root/UI의 Storybook plugin 중복 로딩 충돌로 실행 불가(설정 변경 없이 제한 기록). 양쪽 diff --check 통과.
- 남음: 실제 DEV 서버 연결 웹·iOS/Android 화면 검증. 화면 사용 직전 승인을 질문해 대기 중(SESSION_WORKFLOW의 11/25 규칙). 서버/브라우저/기기 실행·실주문 API 쓰기 없음. 코드/branch 준비와 로컬 검증까지이며 제품 commit/push/PR/Jira 쓰기/배포 미수행·미승인. 전달 단계에서 앱 제품 카드 분리와 release 대상/선행 변경을 확인한다.
- 다음 시작: 사용자 화면 승인 여부 반영 → 최종 코드로 주문4단계 집중 검증 → 별도 지시 시 제품 commit/PR 준비. 요구 범위 때문에 PM에게 다시 질문할 항목은 현재 없다.

## 최초 조사 체크포인트 — 2026-11-27 이력

- 사용자 요청: 새 업무의 뜻부터 조사해 설명한다. 구현 전 요구 해석 단계다.
- Jira: [DL-17665](https://innovaid.atlassian.net/browse/DL-17665), 상위 [DL-17654](https://innovaid.atlassian.net/browse/DL-17654).
- 담당 채팅: `주문 PVS·픽업 변경 시 TAT 요구 조사 · DL-17665`, `01a21b8e-7123-75b0-9688-08e7c882c406` (local). 실제 turn `gpt-6-astra / xhigh` 확인.
- 조사 worktree: `/Users/parkjongsun/Repository/dentlink-client-dl-17665/dentlink-client`, detached `023057ab6109e54d263079a6c64c139407f02a6b` (fetch한 origin/master). 실제 경로·Git 등록·채팅 persisted cwd 일치. 제품 clean.
- 주 checkout의 master `96bdacda6`와 타 작업은 그대로 유지. 동일 저장소 main의 eligible ignored/untracked env6개를 opaque 복사, 동일성·ignore 확인. 설치·서버·브라우저·테스트 실행 없음.
- 권한: 조사와 위 worktree 준비만. 제품 코드/branch·commit/push/PR·Jira 쓰기·배포는 미승인. 개인 기록만 유지한다.
- 조사 완료: Jira 원문·현재 웹 코드·관련 Git 이력·DEV Swagger·앱 진입 경로를 읽었다. 제품 변경/테스트/서버/브라우저/실계정 주문·API 쓰기 없음. 다음 구현 지시 전 대기한다.
- 최초 준비 기록은 개인 정본 `c64a5b5`로 commit/push 완료. 아래는 이후 확인된 조사 결과다.

### 후속 재조사 결론 — 2026-11-27

- 사용자 후속: PM 질문/히스토리 문안을 다듬은 뒤 “8/31 작업이 진짜 영향이 맞는지만 한 번 더 조사해서 최종 정리” 요청. 구현 승인 아님. 제품/브랜치/테스트·브라우저/서버 실행 없이 Git·문서 읽기로 재검토했다.
- 최신 fetch 후에도 HEAD=origin/master=`023057ab6`. `1113de8b84`의 직전 `2cb1af80ca02f0bb89b6be6c7a9455d3126fdf8d`, 변경 직후, 현재를 대조했다. 해당 공통 폼에서8/31 변경은7줄 추가뿐이다.
- **접수된 주문에 PVS를 추가해 새 최소일이 기존 납기보다 늦어졌는데 기존 납기가 유지되는 현상에는8/31 변경이 직접 영향을 준다(코드 경로 기준).** 같은 입력에서 결과가 달라지는 지점을 확인했다. 실제 운영 주문 재현/서버 응답·발생 시작일 확인은 하지 않았다.

  | 비교 조건: 일반 OFFICE 접수 주문, 기존 납기12/10, PVS 저장 후 새 최소일12/17 | 직전 코드 |8/31 직후와 현재 |
  | --- | --- | --- |
  | PVS 체크로 비운 값, 새 최소일 응답 도착 | 기존12/10과 최소12/17 비교 → 납기 undefined | non-DRAFT 보존 분기 → 기존12/10 재입력·비교 전 종료 |
  | 이미 체크된 PVS의 픽업일 변경으로 같은 최소일 상승 | 날짜 비교 → 납기 undefined | 동일하게 기존12/10 유지 |
  | DRAFT 일반 주문에서 같은 입력 | 날짜 비교 → 초기화 | non-DRAFT 분기 제외 → 기존 비교 흐름 유지 |

- 재조회 호출·query→공통 폼 최소일 전달·effect 의존성도 직전부터 이미 연결돼 있었다. `usePickupOrders`의 POST/DELETE 이후 최소일 재조회와 `useCalculateTurnaroundDateByOrderIdQuery`는 이 기간 동안 관련 동작이 바뀌지 않았다.9~11월 후속 공통 폼 변경(관리자 RX 보정/필수값 표시 등)도 이 non-DRAFT 분기를 없애거나 조건을 좁히지 않았다. 새 서버 최소일이 실제로 변경돼 effect가 실행되는 경우라는 조건을 유지한다.
- **정정/한계:** “이번 요구의 모든 동작이 예전에는 정상”이라고 표현하지 않는다. 직전 코드도 현재 form 날짜가 undefined이면 저장된 날짜로 fallback하고, 그 날짜가 최소일보다 같거나 늦으면 다시 넣었다. 따라서 PVS 해제/최소일 단축·동일/기존 납기가 충분히 늦은 경우까지 항상 재선택하도록 하는 정책은 예전 코드에서도 보장되지 않았다.8/31 분기를 단순 삭제하는 것만으로 전체 요구가 끝나지 않는다.
- 담당 근거 보강: [PR4551](https://github.com/Innvoaid/dentlink-client/pull/4551)은 `chajju` 작성, `QA/DL-15466-2`→`release/v1.85.0`,8/31 15:29 KST 병합, merge SHA=`1113de8b84`. PR 본문에 DL-16239 수정 포함 명시. 실제 하위 [DL-16240](https://innovaid.atlassian.net/browse/DL-16240)도 담당 Joy(차주희)/완료다. 사용자 작성 변경으로 보지 않는다. 공유 문안에는 개인 책임보다 당시 요구와 영향 설명을 우선한다.
- PM 확인 범위는 아래처럼 최종 정리했다: 픽업일 변경은 카드 제목에 명시돼 포함하는 이해를 전달하되 별도 필수 질문으로 되돌리지 않는다. **웹 외 치과앱 포함 여부**, **상위의 별도 픽업 화면 자동 납기 조정/안내 팝업까지 이번 카드 범위인지** 두 가지를 함께 확인한다. “PM에게 물을 것이 없다”는 앞선 답변은 동작 요구만 보고 제품/작업 경계를 누락한 과도한 단정이었다.
- 조사 체크포인트는 개인 정본/Claude 보조 메모리만 갱신한다. 타 세션의 `PROJECTS.md`, 출력 정본 미커밋 변경은 보존한다. 다음 구현 지시 전 대기.

## 원문에서 구분할 사항

- 하위 제목은 픽업 날짜 수정, 본문은 PVS 추가·해제 시 기존 TAT 초기화와 서버가 준 가장 빠른 날짜를 선택하는 UI다. Frankie 담당/해야 할 일/댓글0.
- 상위는 새 주문4단계 정상(Scan 12/10, PVS 11/27 추가 시12/17), 접수 후 주문 수정은 기존12/10 유지가 문제라 재선택을 요구한다.
- 상위의 별도 픽업 추가는 기존 납기가 새 계산보다 빠른 경우만 자동 지연·+3/+5 영업일·안내 팝업이라는 별도 흐름이다. 하위 범위에 자동 포함하지 않는다.
- “예전에 테스트했다”는 작성자 기억이다. 실제 회귀와 현재 서버 응답·운영 재현은 아직 확인하지 않았다.

## 요청의 뜻

여기서 TAT는 화면의 `Turnaround Date`, 즉 사용자가 선택하는 납기 날짜다. Scan은 스캔 데이터를 보내는 방식, PVS(Pickup)는 실물 인상물을 픽업해 보내는 방식이다. 실물을 추가하면 운송을 포함한 일정이 달라지므로, 기존 날짜를 지우고 서버가 안내하는 가장 빠른 날짜부터 다시 고르게 해 달라는 요청으로 해석한다.

카드의 예시: Scan 주문에서12/10을 선택 → 11/27 PVS 픽업 추가 → 새 최소일12/17 → 기존12/10을 미선택으로 바꾸고 사용자가12/17 또는 이후 가능한 날을 선택한다. 이 예시 날짜는 카드에 적힌 값이며 이번 세션의 실제 서버 계산 결과가 아니다. 하위 카드는 자동으로12/17을 저장하라는 요구가 아니다. PVS 해제도 본문상 재선택 대상이다.

## 확인된 코드 흐름과 원인

아래 웹 경로는 조사 worktree의 상대경로, 기준 SHA는 위와 같다.

1. **새 주문과 주문 수정은 같은4단계 화면을 쓴다.**
   - `clinic/src/pages/orders/[order_id]/[step].tsx:32`는 DRAFT이면 Place Order, 이후 상태면 Edit Order로 제목만 구분한다.
   - `clinic/src/components/Order/OrderForm.tsx:198`는 ADDITIONAL 단계에 `OrderAdditional`을 렌더한다.
   - `clinic/src/lib/Order/useOrderDetail.ts:177`은 접수된 일반 주문 수정 시 같은 `/orders/{id}/additional`로, DRAFT는 저장된 단계로 들어간다. 리메이크 수정은 별도 경로다.
2. **PVS 체크/해제 시 날짜 초기화 자체는 이미 있다.**
   - `shared/ui/src/Order/OrderForm/OrderAdditionalInfoForm.tsx:236`에서 `deliveryRequestAt`을 undefined로 비우고 픽업일도 비운다. 기존 픽업일이 있으면 삭제 요청을 보낸다.
   - 같은 파일`:200`의 픽업일만 변경하는 handler는 픽업일 설정·API 호출만 하고 납기를 직접 비우지 않는다. 따라서 체크 변경과 날짜 변경을 같은 이벤트라고 볼 수 없다.
3. **접수된 주문에서는 기존 날짜를 되살리는 분기가 있다.**
   - 같은 파일`:400`의 effect는 `order` 또는 서버 최소일이 바뀌면 실행된다. `:411–417`에서 DRAFT 이후이며 기존 납기가 있으면 기존 `order.officeDeliveryRequestAt`을 무조건 다시 넣고 종료한다.
   - DRAFT는 이후 분기에서 현재 날짜와 서버 최소일을 비교해 너무 이른 날짜를 비운다(OFFICE_SCANNER DRAFT는 별도 자동 대체 예외). 그래서 상위의 신규 정상/수정 문제 구분과 코드가 부합한다.
   - PVS 변경 직후 잠시 비워져도, 서버 최소일 재조회 결과가 달라져 effect가 실행되면 접수 주문의 예전 납기를 다시 넣는 구조다. 실제 환경 재현은 하지 않았으므로 모든 조건에서 같은 증상이 난다고 단정하지 않는다.
4. **서버 계산 재조회와 날짜 선택 UI도 이미 있다.**
   - `clinic/src/lib/Pickup/usePickupOrders.tsx:27`의 POST/DELETE 후 `onSettled`에서 주문 요약·예약 목록·납기 계산을 재조회한다.
   - 픽업 예약 API는 `/office/shipments/pickups/reservations/orders/{orderId}`(POST 날짜 payload/DELETE)다. 체크만 하고 픽업일을 아직 선택하지 않으면 예약 생성은 안 된다.
   - `clinic/src/components/Order/OrderAdditional.tsx:140,194,234,254` → `clinic/src/services/calendars/calendars.query.ts:19` → `shared/models/src/holidays/holidays.apis.clinic.ts:40`: GET `/office/calendars/orders/{orderId}/turnaround-date`. 현재4단계 호출은 orderId만 설정하며 로컬 타입의 optional pickupDate는 전달하지 않는다.
   - 응답의 turnaroundDate를 `calendarsEnabledStartDate`로 넘긴다. `DeliveryInfo.tsx:73,148`는 그 날짜부터 달력을 열고 주말·휴일 제한을 적용한다. 비어 있으면 `Not selected` 표시, 날짜 선택은 사용자가 확정한다. API 최소일이 없을 때10영업일 fallback이 있으나 이 작업에서 새 계산을 넣을 근거는 아니다.
   - `useOrderAdditionalInfoForm.tsx:109` 및 `shared/configs/utils/orderAdditionalValidation.ts:26`은 납기 값의 존재·날짜 파싱 여부를 확인하며 최신 서버 최소일과 비교하지 않는다. 따라서 오래된 유효한 날짜가 되살아나면 FE 저장 검증은 통과할 수 있다. 서버 수락 여부는 실제 요청으로 확인하지 않았다.

## 과거 요구와 회귀 판단

- [DL-16239](https://innovaid.atlassian.net/browse/DL-16239), 2026-08-31 완료: “Draft 상태는 초기화 로직 유지, Draft 이후는 기존 Turnaround Date를 수정 시에도 유지”라는 명시 요구가 있었다.
- Git `1113de8b84fd6da7140acf9211bf88a4743e1e2e`, 2026-08-31, PR4551에서 위 접수 주문 보존 분기7줄이 추가됐다. 현재까지 남아 있다. PVS 체크 시 비우는 로직은 `7b0c501b90`(2025-12-29)부터 남아 있다.
- 따라서 “초기화 코드가 통째로 사라졌다”는 설명은 맞지 않는다. 기존 납기 유지 요구와 이번 PVS 변경 시 재선택 요구를 구분하지 못하는 분기가 확인됐다. 과거 사용자가 테스트한 버전/정확한 운영 회귀 시점은 미확인이다.
- 일반 주문 수정에서 납기가 지워지지 않게 하는 기존 정책을 없애면 안 된다. 픽업 조건을 바꾼 상황만 재선택 예외로 처리하는 최소안이 적절하다.

## API 계약 확인 범위

- 2026-11-27 [DEV Swagger](https://dev-api.dentlink.io/v3/api-docs) HTTP200 직접 조회. GET `/office/calendars/orders/{orderId}/turnaround-date`와 `CalendarTurnaroundResponseDto`의 `turnaroundDate`(string/date), `affectedScopes`(string array)를 확인했다. required/nullability는 명시되지 않았다.
- 현 DEV 해당 operation의 query에는 pickupDate가 없으며, FE 로컬 wrapper에는 optional pickupDate 잔여 선언이 있다. 실제4단계는 orderId만 사용한다. 이 차이만으로 이번 수정에 모델 변경/API 신규 작업이 필요하다고 단정하지 않는다.
- 주문 ID를 넣은 업무 데이터 응답·STG/운영 API·브라우저는 조회/실행하지 않았다. PVS 저장 후 서버가 실제로 어떤 최소일을 주는지는 구현/재현 시 확인할 사항이다. 현재 근거상 FE에서 +3/+5 영업일 계산을 새로 만드는 작업은 아니다.

## 제품·화면 범위

| 화면 | 확인한 경로와 영향 |
| --- | --- |
| 치과 PC 웹 주문 작성/수정4단계 | 이번 현상과 기대 UI의 직접 대상. 동일 컴포넌트, 주문 상태별 분기 |
| 치과 모바일 웹 주문 폼 | `OrderForm.tsx:131`에서 react-device-detect의 isMobile이면 Mobile Not Supported 팝업 반환. PC 웹4단계를 모바일 지원으로 확장할 근거 없음 |
| 치과앱 주문 작성/수정 | 웹 상세의 `OrderDetailBoxTitleMobile.tsx:126`에서 수정 버튼은 RN NAVIGATION으로 네이티브 OrderScreen 진입. 웹 폼 재사용 아님 |
| 기공소 웹 | 공통 폼을 소비하지만 PVS 체크 disabled, 픽업일 UI 없음(`SelectImpressionType.tsx:172,204`). 공통 effect 변경 시 일반 날짜 보존 회귀는 점검하되 신규 픽업 기능으로 확대하지 않음 |
| 관리자 웹 | 같은 공통 폼 소비, ADMIN 날짜 초기화·최소일 예외가 별도. 이번 치과 요구 때문에 관리자 특례까지 바꾸지 않음 |
| 접수 후 별도 픽업 추가 | `/pickup/create`, `usePickupCreate` → createReservation(payload의 date/orderIds) 후 목록 이동. 주문4단계 날짜 선택 UI를 거치지 않는 별도 흐름. 상위 시나리오3의 자동 납기 조정/팝업은 하위 범위로 편입하지 않음 |

### 앱 관련성만 확인한 결과

- 추가 worktree/변경 없이 기존 Office repo를 읽었다. 2026-11-27 fetch 확인: 현재 checkout `release/v2.2.7@0317f39c`, origin/main `dd9fc9a2`. checkout 전환/pull/실행 없음. 조사한 `OrderScreen.tsx`와 `OrderAdditionalInfoSection.tsx`는 origin/main과 동일하다. 앱 배포/실기기 상태는 확인하지 않았다.
- `src/features/order/screens/OrderScreen.tsx:1352` → 네이티브 `OrderAdditionalInfoSection`이다. 같은 서버 납기 API를 사용하지만 웹과 별도 상태 처리다.
- 해당 파일`:374` 픽업 저장 성공 후 최소일 재조회, `:398` 픽업 삭제 성공 시 납기 초기화, `:475` 체크만 추가할 때는 납기를 비우지 않는다. `:792`는 기존 선택일이 새 최소일보다 빠르면 **새 최소일로 자동 대체**한다. 주문 초기값은 order ID당1회 설정(`:701`)된다.
- 따라서 웹의 “접수 주문의 이전 날짜 재주입”과 같은 구현이라고 단정할 수 없다. 앱은 사용자 재선택 대신 일부 자동 대체 동작이 있으므로 이번 요구를 앱에도 적용할지는 범위 확인이 필요하다. 네이티브 수정은 아직 승인/착수하지 않았다. Lab 앱 확대 근거가 없어 추가 조사하지 않았다.

## 남은 확인·최소 작업안

후속 대화에서 정리한 범위 확인은 다음 두 가지다. PVS 추가·해제/픽업일 변경 후 재선택이라는 웹 동작 자체는 구현에 필요한 수준으로 읽을 수 있다.

1. **웹과 치과앱 모두 적용하는가?** 앱은 별도 네이티브 구현으로 웹 수정에 자동 포함되지 않으며 적용 제품은 카드에 명시되지 않았다.
2. **주문 수정 외에, 별도 픽업 화면에서 기존 주문에 픽업만 추가할 때 납기를 자동 변경하고 안내를 띄우는 것도 이번 카드에 포함하는가?** 상위 시나리오3의 실행 화면·자동조정 정책은 다르므로 하위 범위/담당을 임의 확대하지 않는다.

구현 승인 후 최소안: 기존 달력/UI/API 재사용, PVS 추가·해제·픽업일 변경으로 비운 납기를 서버 재조회 뒤 이전값으로 복구하지 않도록 상태 초기화 경계를 구분한다. 일반 수정은 기존 날짜 유지. 새 최소일 조회 완료 전/실패 시 기존 에러·로딩 흐름을 보존하고 잘못된 날짜를 확정하지 않게 실제 흐름을 확인한다. 단순히 non-DRAFT 보존 분기를 삭제하거나 부모의 +3/+5·팝업을 추가하지 않는다.

향후 검증 범위: 새 주문/접수 주문 각각 PVS 추가·해제·픽업일 변경, 일반 코멘트 수정 시 납기 유지, 새 최소일보다 기존 선택일이 빠른/늦은 경우, 픽업 실패·재조회 중 화면, 기공소/관리자 기존 공통 폼 특례. 이번 조사에서는 어떤 테스트나 제품 실행도 하지 않았다.

메인 공통 파일은 편집하거나 자동 보고/폴링하지 않는다. 조사 결과는 사용자에게 직접 설명하고 후속 지시를 기다린다.
