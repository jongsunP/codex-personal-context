# Memory Changelog

## 2026-10-08

- 클리닉318의 사용자병합 bf9e897e/15:02:42를 live확인했다. 웹배포완료는 사용자보고로구분했다.
  밀링7반영으로 Labrelease가96cc94a0/src로바뀌어5/6충돌을 사용자승인으로 동기화·일반push했다.
  기능6=55bc143·18파일(+579/-150), 문서5=9e04b395·3파일(+72/-3), 현재둘다CLEAN/MERGEABLE이다.
  최신API/밀링/native/deps를보존하고환자전용SVG를추가했다. 기존13검증·양플랫폼배포용JSbundle통과,
  최신baseline/feature tsc5오류/3228bytes동일·신규0, 독립검토결함0·둘PR모의통합충돌0/21파일이다.
  Jira44342·정본/제품/FE색인을갱신하고READY FOR QA는유지했다. 실제LabPRmerge/CodePush/메인보고는없다.
- 사용자가 앱의 최종release에서 본인작업만 전달한 PR구성을 본인 의도라고 확정했다.
  이어 웹 원격stage248e4028을 exact lease로 삭제·복구ref보존하고 master6b79c975에서
  nonexistence lease로 다시만들어 release1.88.0 eca577a6→stage PR4677을 생성/첨부했다.
  전체21커밋985파일·모의병합충돌0/tree=release, 웹4665/지침4666 포함·참조readback 확인.
  normal push 훅성공(기존feature검사), DLOSguard/자동할당SUCCESS·CodeRabbit SKIP·Vercel권한FAILURE다.
  기존EOF빈줄3건은 기록만 했으며 root의PRmerge/수동배포/통합QA는 미실행이다.
  후속live조회에서 사용자가14:50:42 #4677을stage d3795661로병합한사실과tree=release를확인했다.
  같은SHA의 치과웹/Lab웹/Admin 배포Actions3개는IN_PROGRESS이며 완료·실제화면QA로 확대하지 않는다.
  Jira44342·FE색인·기능정본·stage절차를 정리했고 앱/타작업checkout/source/QA자료는 보존했다.
- 사용자 앱PR 전체정리 지시로 요청한 작업만 최종release에 전달하도록 정정했다.
  Lab은 release1.0.4에서 기능1커밋20파일 e3bf335의PR6과 독립문서1커밋3파일2fb6e8b의PR5로 대체했고,
  기존2/3/4를 CLOSED·미병합/대체링크·원격branch보존으로 정리했다. 광범위 foundation은 불필요했다.
  Office318은 release 대비 실제배지3파일만 있어 유지했고 최신승인완료/CLEAN·CodeRabbit SUCCESS를 확인했다.
  새Lab포트 renderer10+연결4·lint/format/버전·양플랫폼releaseJSbundle PASS, 전체type는각baseline6개동일/신규0,
  독립검토결함0·모의통합충돌0이다. 새포트기기/OTA QA는 별도이며 실제PRmerge/배포/메인보고는없다.
  담당Jira댓글44342·제품체크포인트·앱release정책을 새구성으로 갱신하고 이전기반안을 이력으로 표시했다.
- DL-16652 두앱의리뷰전모든준비를최종확인했다. Office318behind0/3파일승인대기,
  Lab4기반/2기능분리·19파일추가코드리뷰결함0·순차merge-tree충돌0/최종tree동일이다.
  실행가능한준비잔여0, 검사pending/미해결0·자동merge설정없음. LabPR검증본문·형식검사범위를명확히했고
  담당Jira기존댓글44342를최종준비결과로갱신했다. 코드HEAD변경/실제merge/배포/메인보고는없다.
- 사용자 요청으로 Office PR #318의 승인 외 준비를 완료했다. 최신release2.2.4를 기존feature에
  Merge commit81584b82로동기화/push해behind0, 기존Remake3파일patchbyte동일을확인했다.
  버전/diff/scope lint·badgeformat/renderer3 PASS, release·sync fulltype8개로그동일/신규0,
  CodeRabbit승계SUCCESS·actionable0/미해결0 및본문readback. 사람승인1개만남기고 실제PRmerge/배포는미실행이다.
  웹/Lab변경과메인세션보고는없으며 Git준비라Jira기능결과댓글은추가변경하지않았다.
- DL-16652 Lab 앱을 사용자 요청대로 머지 전 리뷰 준비까지 마쳤다. 기존1.0.4 CodePush 전제를 확정하고
  기존 분리6커밋 기반 PR #4→release/v1.0.4와 feature PR #2→임시기반base(4커밋·19파일)를 분리했다.
  기반 이력을 보존한 Merge commit 후 기능base를release로돌려 재확인하는 순서를 기록했다.
  버전/diff/기존9테스트 PASS·두PR clean/미해결0, Jira44342 readback. 제품소스/HEAD·release는 그대로이며
  모든PR merge·태그·CodePush·스토어는 미실행, 웹/Office추가처리와 메인세션 보고도 제외했다.
  웹은 직전 사용자merge 확인을 정본에 반영하고 이전Draft기록을 현재상태로 재사용하지 않는다.
- 사용자가 앱 release·제품별 Jira 운영 방향의 지속 적용을 재확인해 FE 정본에 기록했다.
  지침 정리는 완료하고 Lab PR #2/#3의 선행 통합 과제는 미완료로 유지했다. 이번 정리에 새 작업 공간은 없다.
- 사용자 앱 release 정책과 제품별 Jira 카드 지침을 공통 AGENTS/SESSION_WORKFLOW/AI_WORKFLOW에 저장했다.
  앱은 기존 최신 유효 release를 PR 대상으로 우선하고 호환 CodePush마다 새 release를 만들지 않는다.
  웹·Office·Lab의 실제 영향에 따라 카드를 재사용/생성하며 완료·QA·배포를 독립 관리한다.
- APP 온보딩·사용자 원본 참고 링크 21개 및 DeepLink 16개 버전 등 확인 가능한 하위 문서를 분석했다.
  분리 전 구조·폐기 정책·미해석 객체와 현재 코드/태그/실제 배포를 구분해 앱 온보딩 정본을 만들었다.
  Lab release 미분리로 #2/#3 전체 diff가 확대된 상태와 최신 앱 PR base를 개인 기록에 정정했다.
  제품 코드·PR·Jira·태그·배포는 이번 정책 정리에서 변경하지 않았다.
- DL-16652 현재 점검에서 세 feature HEAD/미해결 리뷰 0건과 최종 Figma·운영 번역 시트 일치를 확인했다.
  웹 PR #4665는 사람 승인 후 현재 Draft이며 임의 전환/병합하지 않는다. Vercel은 프리뷰 실패이며
  필수 머지 검사가 아니다. DEV 실제 API 770명은 새 계약, STG 694명은 이전 계약이라 선배포 조건이 남았다.
- DeviceHub 정상 입력 회복 뒤 Lab iOS 실제 로그인·목록·검색·최근 주문 상세 로딩 및 별도 합성 KO/EN
  카드의 12pt/343×248/9자리 수·Remake/6상태를 확인했다. Office iOS도 정상 로그인·지정 QA 그룹 일치·
  Home/Orders를 확인했다. 가시 2행에서 실제 Remake를 찾지 못했고 필터/paging도 확증하지 못해 미검증으로
  구분한다. 앱 PR 본문/Jira 44341·개인 정본을 갱신하고 own runtime을 정리했다. 제품 코드 변경은 없으며
  이전 iOS 입력 차단을 현재 blocker로 재사용하지 않는다. 외부 선배포/프리뷰·앱 검토·실기기 QA를 대기로 둔다.

## 2026-10-07

- 사용자가 PR #4666을 release/v1.88.0에 squash 머지한 사실과 최종 지침 7개 파일 일치를 확인했다.
  보존 자료·사용 중인 프로세스·미커밋 변경이 없는 전용 i18n-guide worktree와 로컬 feature를 삭제하고
  원격 feature는 보존했다. 다른 제품·진행 중 작업은 유지하고 i18n/FE 정본을 완료·대기로 갱신했다.

- 사용자 요청으로 PR #4666의 일반 머지 요건을 live 정책·승인·최신 release merge 후보로 확인했다.
  CodeRabbit 완료·미해결0, 승인 유지·충돌 없음이며 Vercel은 비필수 검사 경고로 머지 차단이 아니다.
  추가 제품 변경·우회·실제 merge·배포 없이 사용자 머지와 대기로 넘기고 i18n/FE 체크포인트를 갱신했다.

- PR #4666 CodeRabbit 미해결 1건을 실제 시트 쓰기·스냅샷 복구 코드와 대조해 운영 지침을 보완했다.
  최초 조회부터 검증·필요한 복구 완료까지 양쪽 탭의 편집·다른 동기화를 중지하고, 확보 불가 시
  쓰기를 보류하도록 명시했다. 67e95af9f를 정상 hook 검증 후 commit/push하고 스레드 답변·해결 및
  최신 HEAD 재리뷰 완료·미해결 0건을 확인했다. PR OPEN·non-Draft·미병합, 이전 HEAD의 사람 승인과
  최신 Vercel 배포 차단을 구분했다. 실제 시트·번역·제품 코드·앱 저장소는 수정하지 않았다.

- DL-16652 자율 재점검에서 Figma/댓글/리뷰의 추가 수정이 없음을 확인했다. 두 앱 canonical Pods와
  정식 iOS Debug 빌드·새 시뮬레이터 설치/실행·미인증 초기 안내 화면을 확인하고 임시 환경을 정리했다.
  DeviceHub 자동 입력 연결 실패로 로그인 이후 iOS UI는 미검증이며 Android 기존 검증 결과를 유지한다.
  STG 실제 응답00:36은 이전 형식, 웹 Vercel/사람 리뷰·Office 실제 Remake 사례는 남았다.
  Jira44303과 개인 정본/제품 색인을 갱신하고 외부 조건 해소까지 대기한다. 제품 추가 변경은 없다.

## 2026-10-06

- DL-16652 현재 상태 재점검에서 웹 리뷰 수정과 최신 Figma의 앱 primary600 보정을 커밋·푸시했다.
  웹 CodeRabbit 실제 검토 완료·미해결0개, DEV 새 계약/STG 이전 계약, 신규 번역 시트·리소스 일치를
  재확인했다. Lab 실제 검색/상세 이동·별도 합성 기기 QA와 카드 줄바꿈/잘림 보정14949c6,
  Office 격리 의존성/새APK 정상 빌드·실제 로그인/목록·새 iOS bundle까지 완료했다. Office 실제
  Remake 사례 미검증과 외부 조치를 구분해 Jira44302·환자목록 정본·제품 색인을 갱신했다.

- DL-16652 최종 Figma·댓글·구두 확정(카드12px·웹/앱 전역 Remake)을 반영해 웹·Lab 앱·Office 앱을
  commit/push하고 웹#4665→release/v1.88.0, 앱#2/#318→develop PR로 전달했다. 새 번역은 각 시트와
  생성 파일까지 등록·검증했다. DEV/STG 차이, 앱 기기QA·기존 타입 오류, 기존 번역 차이·CLI 인증·
  Vercel 팀 접근 차단을 완료된 구현과 구분해 정본/제품 색인을 갱신했다. 4시간 재점검은 취소했다.
- 승인된 작업의 작은 디자인 차이는 자율 판단하고, 여러 최종 예시의 반복 값이 단일 예외보다
  우선이라는 사용자 지침을 DEVELOPMENT_STYLE에 저장했다. 의도된 예외 근거가 있으면 재검토한다.

- 사용자 승인으로 웹 저장소 AGENTS·Claude·Cursor 진입점과 i18n 스킬·팀 운영 가이드에
  번역·시트·검증 기본 수행 지침을 추가하고 커밋·푸시 및 release/v1.88.0 대상 PR #4666을 생성했다.
  master 기반 구현 뒤 이번 지침 커밋만 release 전달 기준에 재배치해 다른 관리자 변경을 제외했다.
  최종 스킬·링크·diff·세 앱 타입·필수 push 검사를 통과했다. 사람 승인/CodeRabbit 대기와
  Vercel 작성자 접근 권한 실패, 미병합·앱 지침 미변경 상태는 웹 i18n 체크포인트에 기록했다.

- 기공소 웹·앱의 번역 도구와 운영 절차를 확인하고, 승인된 기능의 정적 문구 변경에는
  i18n 리소스·해당 스프레드시트 반영·검증을 자동으로 포함하는 지침을 저장했다.
  웹·Lab 앱의 시트와 생성 명령을 구분하고, 앱 스캐너 누락·PM 확인 조건·쓰기 인증·
  다른 활성 기능의 시트 행 보존과 완료 판단 기준을 명시했다.
  SESSION_WORKFLOW를 공통 정본으로 두고 웹 i18n·Lab 앱·FE·프로젝트 색인을 연결했다.
  이번에는 제품 코드·실제 번역 시트를 변경하지 않았다.

- Jira 정리는 사용자 담당 하위 카드에 남기고 상위 카드 댓글은 명시 요청이 있을
  때만 작성한다는 지침을 저장했다. 하위 제목은 작업 내용을 식별하도록 구체화하며,
  작업 전 필요한 사항은 본문, 진행 중 경과는 댓글에 정리한다. AI_WORKFLOW의
  Jira Work Updates를 정본으로 두고 AGENTS·권한관리 체크포인트를 맞췄다.
  메인세션에서는 기존 본문의 요구사항·범위가 충분하면 유지한다는 기준을 보완했다.
- 권한관리 DL-16319 제목을 `[FE] 담당 환자 제한 및 Member 권한 적용`으로 수정하고
  댓글 44298에 준비·잔여·임시 조건 확인 방법·오늘 관련 테스트 40개 재검증과 대기를
  기록했다. 상위 카드는 변경하지 않았으며 신규 구현·테스트를 더 진행하지 않는다.

- 앱 분리 이후 신규 업무의 제품 구분을 사용자 확정 지침으로 반영했다.
  `dentlink-app`은 Office 전용, `dentlink-lab-app`은 Lab 전용이며 각 Git·API·runtime·
  release를 별도로 확인한다. 기공소 앱 정본·프로젝트 색인을 추가하고 공통 세션 절차와
  FE 조율·Office 앱 기록의 기존 통합 앱 가정을 정정했다.
- 기능 세션의 진행·완료 결과를 메인세션으로 자동 메시지 전달하지 않는다. 결과는
  작업 세션과 해당 Git 체크포인트에 기록하며 사용자 명시 요청이 있을 때만 전달한다.
  SESSION_WORKFLOW의 기존 자동 보고 문구를 이 원칙으로 교체했다.

- 신규 작업 세션의 모델·추론 수준은 메인세션과 동일하게 명시하고 생성 후 실제
  적용값을 확인하도록 정리했다. 동일 조합을 사용할 수 없으면 지원되는 최고 등급을
  선택하며 사용자 지시 없이 낮은 앱 기본값이나 비용·속도 기준으로 낮추지 않는다.
  AI_WORKFLOW를 정본으로 두고 AGENTS·SESSION_WORKFLOW·PROFILE·FE 조율 기록을 맞췄다.
  확인 당시 메인세션은 `gpt-6.1-sol / ultra`, DL-16596 세션은 초기 `low`에서 현재
  `ultra`로 바뀐 상태였다. 이 값은 시점별 관찰이며 앞으로의 모델명을 고정하지 않는다.
- 웹 신규 작업은 최신 `origin/master`에서 시작하며 Jira 예정 릴리즈는 구현 기준이
  아니라는 사용자 지침을 명시했다. 이미 release에 반영한 작업의 후속 수정·QA만
  release 기반 예외다. DL-16615처럼 예정 release가 없거나 현재 checkout이 이전
  release여도 이미 승인된 신규 작업의 master 기준·통상 로컬 feature 준비를 재질문하지 않는다.
  SESSION_WORKFLOW의 정본과 AGENTS·FE 기록을 맞추고 제품 전달 권한은 별도로 유지했다.
- Dentlink 신규 업무 링크는 메인세션에서 접수·분류하고 구현은 별도 기능 세션에
  맡기는 것을 기본으로 정리했다. 짧은 작업은 기존 폴더 안의 새 세션만,
  규모가 있고 여러 차례 이어갈 작업은 전용 폴더·worktree·세션을 사용한다.
  불명확한 범위·충돌·필수 결정만 사용자에게 확인한다. SESSION_WORKFLOW.md를
  정본으로 두고 AI_WORKFLOW·FE 체크포인트·프로젝트 색인의 충돌 문구를 맞췄다.
  기존의 작은 작업 직접 구현 및 작은 작업마다 worktree 선호를 재질문하는 기본값을 대체한다.

## 2026-10-01

- DLDS 1단계 우선 완료 후 ClayDesign 참고 방향을 2단계 작업 기준으로 합의했다.
  사용자의 첫 준비 승인으로 AI용 DLDS 지침·실제 코드 계약·미리보기 구성안·
  시험 화면 후보·요청/검증 기준을 하나의 초안에 정리하고 재개 위치를 갱신했다.
  후보·도구는 미정이며 생성 화면·하네스 구현/실험이나 제품·외부 문서 변경은 하지 않았다.

## 2026-09-29

- 요구사항 밖의 사용자 노출 UI·문구·동작은 기존 패턴을 재사용하더라도 근거와
  구체안을 제시하고 승인 후 반영하도록 최상위 지침에 명시했다. AI가 작성한
  Jira/계획을 원래 요구사항의 근거로 순환 인용하지 않는다.
- 피드백 Retry 조사에서 시작한 요구사항 외 UI 검토를 별도 세션으로 분리한다.
  `dentlink-client`의 최신 master 기준 `feature/ui-requirements-audit`는 조사·보고
  전용이며 제품 수정은 사용자 승인 후다. DLDS의 사용자 QA 문제 1은 E2E
  Password 셀렉터 충돌이고 아직 수정하지 않았다. 자세한 상태는 기능별 정본을 따른다.

## 2026-09-28

- DLDS 현재 단계를 사용자 로컬 QA 결과 대기로 기록했다. 제품85002472f에서 실제
  Clinic/Lab/Admin을 사용자가 확인하며, 결과 전 추가 작업은 시작하지 않는다.
  확인 대상·실행 위치·결과 전달 내용과 결과 수신 후 재현/수정/검증·저장·
  1단계 마감/2단계 진입 확인 순서를 기록해 기기나 세션이 바뀌어도 이어간다.

- DLDS 자율 후속 정비를 제품85002472f에 커밋·푸시했다. RadioGroup의 범용 공개,
  ListItemGroup 미사용 코드 정리, 선택 예제·필수 속성 안내를 보완하고 UI200·
  Chromium/WebKit·실제 복사 코드2종을 검증했다. Jira 현재 진행·재개 체크포인트를
  갱신하고 남은 권한/데이터/실기기 QA와1단계 마감 후 하네스 연결을 다음 순서로 남겼다.

- 명칭은 정의된 프로젝트·디자인·참조 용어를 우선하고 없으면 쉬운 프로젝트 용어를
  쓰며, 새 의미나 모호한 이름은 사용자 검토 후 채택하는 공통 원칙을 저장했다.
  DLDS 아이콘은 저장 목록의 존재 누락0 확인·기존 이름 정리2건을 구분했고,
  제품4622b54e5에서 화면/문서 이름을 `DLDS 컴포넌트 모음`으로 통일했다.
  아이콘 시각 추가 대조·다른 후속 개발은 진행하지 않고 보고 후 대기한다.

- 사용자 결정으로 DLDS 아이콘 추가 전수 대조를 작업에서 제외하고 누락만 대상으로
  변경했다. 카탈로그는 구현 중 붙인 설명용 명칭임을 확인했으며, 보고 후 대기하고
  재개 요청 전에는 다른 후속 개발을 시작하지 않도록 체크포인트와 색인을 갱신했다.
- DLDS 범용 UI 공개 경로·중립적 모음 페이지·다중 선택/화살표 예제와 모바일
  초점 복귀 보완을 제품 ca567f7df에 저장했다. UI196·복사 코드41·서비스 E2E4
  및 남은 범위/재개 방법을 기록하고 오래된 일시중단 색인을 갱신했다.

- 별도 worktree는 꼭 필요한 경우에만 만들고 기존 checkout을 우선한다는 사용자
  지침을 SESSION_WORKFLOW.md에 명확히 했다. 작은 QA나 새 Jira 카드라는 이유만으로
  자동 생성하지 않으며 기존 점유 상태와 기록된 사용자 선호를 먼저 확인한다.
- DL-16534 구현·병합·로컬 정리 종료와 stage PR #4637 병합을 프로젝트 체크포인트에
  정리했다. 재배포 실행 보고와 workflow 진행 중/실제 화면 미반영을 구분해 기록하고,
  PM이 합의한 현재 스펙 운영 및 백엔드 개선의 후속 범위를 유지했다.

## 2026-09-21

- LBX 로컬 구현 체크포인트를 갱신했다. 기존 Admin 화면/모달 3개와 API 연결,
  미완성 주문 조회 한 곳의 교체 구조를 기록했다. 사용자가 정정한 요청 제한은
  제품의 차단이 아니라 **테스트에서 생성·수정 실전송만 피하는 것**이며 제품
  모의 transport/데이터는 제거했다. 제품 Git 변경의 커밋·푸시는 수행하지 않았다.
- 사용자의 구현 전 별도 메모리 요청에 따라 `projects/dentlink-client-lbx.md`를
  추가하고 프로젝트 목록·FE 기록에서 연결했다. 최신 UI/폼 합의, 환경별 IDS 정책,
  Mother 상태 필터, Office 없는 기존 픽업 UI와 outbound 이동, `isConsolidated`
  반영 확인과 별도 Baby 대상 주문 API 대기를 기록했다. 구현 미착수와 실제 업무
  요청 없는 모의 성공 흐름 원칙을 유지하며 초기 미결 사항의 후속 결정을 구분했다.

## 2026-09-15

- Recorded the user's Notion `FE 9월 프로젝트` page as the ongoing location for
  Dentlink FE opportunity planning. Preserved the first breakpoint's completion,
  the removal of the two-week constraint, and Mapbox as a next-discussion
  reference in `projects/dentlink-fe.md`; the detailed candidate list stays in
  Notion without duplication in personal context.

## 2026-09-11

- Replaced the former Claude/company and Codex/side-project split with Codex as
  the active development, repository-management, and project-coordination
  agent. The remote `claude-personal-context` repository remains an archive,
  while its clean local checkout was removed.
- Added a Dentlink FE session hierarchy: one projectless top-level management
  session coordinates work spanning `dentlink-client` and `dentlink-app`, and
  actual implementation is organized by logical feature rather than device or
  repository. One feature session may own both web and app changes while each
  repository keeps its exact branch/worktree and one active writer.
- Kept repository main-checkout sessions as optional repository-administration
  helpers beneath the cross-repository top-level session, and added
  `projects/dentlink-fe.md` as the portable coordination checkpoint without
  creating a combined product folder or worktree.
- Clarified that the top-level session may directly handle a small scoped
  change, while extra repository-specific sessions are created only when size,
  parallelism, runtime isolation, or ownership risk justifies them.
- Clarified that the lasting unit of session ownership is a feature or
  responsibility, not a device or repository. One feature session may handle
  both web and app repositories while preserving their exact Git boundaries;
  the top-level session may also complete small, well-scoped changes directly.

## 2026-09-08

- Promoted the QA-comment audience rule into the global personal `AGENTS.md`,
  so it applies consistently across every project rather than only Dentlink app
  work.
- Clarified that QA-card comments are user-facing answers for the nondeveloper
  reporter, not internal engineering changelogs: state the outcome, use a
  familiar product comparison when useful, and describe the expected visible
  behavior without unnecessary implementation terminology.
- Replaced the exact-IDE-terminal preference with an on-demand visible Codex
  terminal rule: Codex owns command execution, the user owns the IDE, and the
  terminal is opened only while commands are active.
- Refined stakeholder communication as evidence-based advocacy: preserve the
  user's intent, remove emotional or defensive framing, cite concrete comparable
  examples, and make the conclusion or question easy for nondevelopers to
  evaluate.
- Recorded the DL-16349, DL-16352 and DL-16353 QA closeout at app commit
  `943a290`, including Jira outcomes and user-confirmed Staging CodePush.
- Added the user's evidence-led collaboration preference across all projects:
  Codex should neither implement requests blindly nor avoid responsibility by
  citing risk. It should inspect comparable existing behavior and constraints,
  explain a better direction with concrete stakeholder-friendly examples when
  the evidence supports one, recommend decisively, and then execute the agreed
  direction fully.

## 2026-09-07

- Confirmed that the user's organically developed mapping of one substantial
  feature to one branch, worktree, and dedicated Codex project/session is the
  default personal AI-development isolation model, with the long-lived main
  checkout/session acting as repository and release coordinator.
- Added a separate, non-immediate AI workflow improvement backlog covering a
  lightweight worktree registry, one active writer per worktree, single
  release-branch ownership, non-mutating startup preflight, standardized
  closeout, and non-Git runtime-resource collision management. These are
  candidates to evaluate over time, not changes that should be applied merely
  because they were recorded.

## 2026-09-03

- 가칭 `통합알림센터`를 별도 개인 프로젝트 체크포인트와 `PROJECTS.md`에 등록하고
  앱 체크포인트에서도 연결했다. 전용 세션/worktree 이전에도 어느 세션에서든 같은
  내용을 재개할 수 있도록 사용자 확정 FE 공유 요약을 보존했다.
- 초기에는 웹 알림 전용 상시 SSE + REST, 앱의 OS 표시 없는 데이터 FCM + REST를
  검토했으나, 같은 날 후속 사용자 지침으로 **기기 간 실시간 동기화를 제외하고
  REST 기반으로 변경**했다. 현재 체크포인트·프로젝트 목록·앱 컨텍스트를 정정했다.
  기존 배송 SSE·사용자 푸시는 유지하고 신규 동기화 연결/이벤트 처리는 추가하지
  않는다. 구현은 미착수이며 PM 읽음 정책은 대기 상태다.
- 사용자의 실시간 메신저 웹 개발 경험을 서비스명 없이 `PROFILE.md`에 기록했다.
  기본 개념은 이해한 상태로 보고, 과거 경험 비교가 아니라 현재 Dentlink에 적용할
  때 알아야 할 연결·캐시·모바일 제약·PM/BE 협의 사항을 선제적으로 짚는 안내 기준을
  통합알림센터 체크포인트에 추가했다. 이력은 단순한 WebSocket 사용 경험이 아니라
  Slack처럼 채팅·읽음·알림이 중심인 팀 협업 메신저의 웹 개발 맥락으로 이해한다.

## 2026-08-27

- Closed the DL-16061 app FE implementation checkpoint at synchronized head
  `9f66fa3`; PR #286 is Ready for review, mergeable, CodeRabbit-successful and
  has zero unresolved review threads.
- Recorded final Android API 36 proof for Profile feedback counts and lists,
  completed-order Clinic WebView feedback banner, native Feedback Details and
  Image Upload landing without mutating POST/PUT/upload data.
- Recorded Jira final state and evidence: DL-16064 Complete, DL-16061 Ready for
  Deploy with comment `43750`, DL-16066 To Do, and parent DL-15828 In Progress.
- Preserved the next boundary: app-developer review is now appropriate, while
  approval, physical-device and real-mutation QA, merge, release QA and
  deployment remain separate gates.

## 2026-08-19

- Closed out Dentlink Lab i18n and cross-service typography work at pushed
  `feature/i18n` head `1d1b2fda1`; Lab, Clinic, and Admin package versions are
  1.84.0, and the user confirmed deployment.
- Replaced the earlier one-catalog/many-use-site Sheet description with the
  final 1:1 role-view model: both operational tabs have 1,464 identical message
  IDs and shared representative page values, while full technical use-site IDs
  remain hidden in the developer tab.
- Recorded explicit request ownership and the preserved split of 39 notes:
  16 PM/design-to-developer requests and 23 developer/automation-to-PM/design
  requests.
- Recorded full Pretendard policy completion: Clinic web and five PDF paths
  migrated from Lato, Admin retained its existing Pretendard setup, and all
  three services now use heading `0px` and body `-0.1px` letter spacing.
- Recorded final verification and known local limits: direct Sheet/local
  translation mismatch count 0, font/runtime/PDF checks passed, Admin typecheck
  passed, Clinic remains blocked by the unrelated PNG module declaration, and
  the push hook still lacks a local coverage baseline.

## 2026-08-18

- Reordered the generated developer-area Sheet columns around location review:
  page, screen state, marker, capture URL, and page path form one source group.
  Hidden marker/capture columns leave the three visible location fields
  consecutive, and the whole group remains frozen.
- Recorded pushed i18n head `98caa6e20` and verified that the Sheet reorder
  preserved 1,959 use-site rows, 251 capture links across 201 keys, 110
  representative capture groups, and 39 review memos without formula errors.
- Updated the Dentlink Lab i18n checkpoint to pushed head `5a431821a`.
- Recorded the two-tab Sheet ownership model: nondeveloper English/Korean and
  review notes are the wording source; developer use sites are the location
  source; each tab reads the other side's owned values through formulas.
- Recorded 27 masked Drive screenshots, 251 observed occurrences, 201 observed
  keys, 1,459 catalog keys, and the remaining exhaustive state-coverage flow.
- Preserved the next-step rule: exhaust development-server states first, use a
  local environment when possible, then request only the exact user-opened
  state that cannot otherwise be produced.

## 2026-08-10

- Tightened the durable branch-naming rule: new work branches default to the
  project's `feature/` taxonomy, never `codex/` or `claude/`; `release/`,
  `hotfix/`, and other exceptional prefixes require explicit user direction.
- Recorded PR #4484 merged into `release/v1.83.0` as `41de67a8f`, then removed
  the clean DSO worktree and local `DL-15223-qa` branch while preserving its
  remote branch.
- Recorded the current delivery phase: `origin/stage` contains the DSO merge,
  the user confirmed staging deployment and re-QA are in progress, and only
  DL-15906 and DL-15937 remain blocked on backend APIs.

## 2026-08-03

- Clarified completion reporting: a request for completed and remaining
  functionality should contain product-development work only. PR integration,
  deployment revision, real-data regression QA, live analytics receipt, and
  comment-posting status belong in delivery/QA/operations reporting only when
  requested.
- Corrected two DSO TODO classifications after checking live code and the
  confirmed backend policy: `organizations[0]` is the completed current
  single-Organization rule rather than a current selection blocker, and
  `Visit Office` already reuses the established active-employee transition,
  invalidation, rollback, and default-home navigation flow.
- Confirmed Figma comment `#26` against the committed code: both Organization
  and single-Office dashboards already update the `Data from ... ago` label on
  a 60-second interval without refetching APIs. Corrected the checkpoint rather
  than adding duplicate timer code.
- Corrected the scope of the reusable Dentlink guidance: it comes from the
  entire `feature/DL-15223` lifecycle, not only its DL-15801 Amplitude task.
  The common method now explicitly covers requirement reconciliation across
  Jira/FigJam/Figma/Swagger/live code, app-local pattern reuse, replaceable
  UI-to-API migration, generated-code ownership, narrow auth boundaries,
  browser-backed design review, reversible deferrals, and separate delivery
  states. DL-15801 remains recorded as one completed implementation checkpoint.
- Recorded the analytics event-boundary rule learned from DL-15801: place CTA
  click events at the actual click before validation or mutation, reserve
  success events for confirmed outcomes, and verify existing page-view/session
  capture before inventing manual dwell-time events.
- Updated the Dentlink DSO checkpoint to pushed head `345699e4d`, including the
  real dashboard/billing/PDF integrations, access and mobile guards,
  outstanding balance, My Profile changes, generated-file formatting guard,
  and DL-15801 Amplitude events. Advanced Export API, deployment/live event
  verification, multi-Organization policy, and develop integration remain.
- Added reusable `dentlink-client` implementation defaults learned while
  reviewing the DSO work: keep Clinic and Admin patterns app-local, separate
  generated Swagger transport artifacts from handwritten feature/domain types,
  preserve hook/service mutation ownership, and match selection cardinality to
  API payloads.
- Recorded that complete relationship selectors must not silently stop at the
  first 100 paginated results, and that user-visible dates and currency should
  use Dentlink shared formatters with the actual country context.
- Recorded the shared-input extension pattern: add a minimal optional
  controlled value path while preserving existing uncontrolled defaults and
  audit current consumers before changing shared behavior.
- Reinforced the design-before-API boundary: fixtures remain replaceable UI
  inputs, and only deployed, regenerated contracts authorize real integration.

## 2026-07-22

- Added the durable branch-naming rule: never introduce an agent-specific
  `codex/` prefix; follow each repository's existing `feature/`, `release/`,
  and related taxonomy.
- Recorded that release QA aggregation branches should be named for the release
  QA purpose rather than only the first Jira card, such as
  `feature/v1.79.0-qa` targeting `release/v1.79.0`.
- Corrected the durable PR workflow: always use the repository PR skill, but a
  normal commit/push/PR request stops at PR creation. CodeRabbit monitoring,
  response, resolution, and recheck run only when the user explicitly asks to
  handle the review; PR merge remains explicitly separate.
- Removed the completed Dentlink PDF project from the active project index and
  deleted its completed checkpoint document.
- Recorded PR #4411 merged as `6ee361e87`. E2E work waits for staging to contain
  that commit before the final local and staging full UI verification matrix.

## 2026-07-15

- Recorded the durable scope rule: use requirement/design/user/history causality,
  not shared-file location or diff size. Inspect introducing commits and source
  context before reverting, and ask when intent remains ambiguous.
- Recorded the user's PR boundary: when delivery is requested only through PR
  creation, downstream merge, deployment, and automatic workflow status must
  not be monitored or reported unless explicitly requested.
- Added the user's scope rule: do not create unsolicited test files, analytics
  mapper/helper files, analysis artifacts, or documentation. Keep event work in
  the feature's existing files and request approval before expanding structure.

## 2026-07-14

- Corrected the repository boundary for this user's workflow. Personal project
  progress, QA, blockers, branch/commit checkpoints, decisions, history, and
  next starting points belong in
  `codex-personal-context/projects/<project>.md`; shared project repositories
  keep code and stable, team-owned canonical information only.
- Defined resume and closeout behavior around that boundary: pull personal
  context first, reconcile its time-sensitive checkpoint with live project Git,
  and always commit and push the personal history at meaningful closeout.
- Clarified that explicit commit/push authorization applies to shared project
  code and repositories, not to routine closeout synchronization of
  `codex-personal-context`.
- Split personal configuration into common and project-specific layers. Root
  guidance now contains only cross-project rules; each
  `projects/<project>.md` owns that project's workflow, implementation rules,
  current checkpoint, QA, and history.
- Added `projects/README.md` as the project-context schema, reduced `HANDOFF.md`
  to a resume index, moved ASJ-specific workflow out of common
  `SESSION_WORKFLOW.md`, and defined the project-specific checkpoint lifecycle.
- Strengthened the canonical project-alignment rule: matching an existing
  product means following its complete implementation method, including hooks,
  API/query/mutation flow, cache behavior, state ownership, generated types,
  loading/error handling, routing, responsive layout, imports, and naming, not
  only CSS or visual conventions.
- Made this the default for `dentlink-client` and all derived Dentlink
  worktrees, branches, and repositories, using the closest implementation in
  the current app, base, and installed library version as the primary reference.
- Recorded that a concrete review comment is a signal to audit the full changed
  feature for the same root pattern, and that deviations require a specific
  need, minimal additive scope, preserved defaults, and consumer review.

## 2026-07-10

- Defined `메모리` as the Git-backed `codex-personal-context` repository for
  this user; `~/.codex/memories` is secondary runtime memory and does not count
  as remote cross-device continuity.
- Tightened the session lifecycle: pull personal context at work start, and at
  meaningful closeout curate and push durable status, learned rules, blockers,
  verification, and the next start point. The 2026-07-14 policy clarified that
  personal-context synchronization is automatic at meaningful closeout.
- Added project-aligned implementation guardrails:
  existing props/components first, minimal additive shared changes, generated
  types and current library conventions, scoped loading, shared-consumer side
  effect review, complete Figma state/flow QA, and separate implementation,
  visual QA, and merge-readiness judgments.

## 2026-06-24

- Added the user's UI/readability preference: direct answers should minimize
  screen footprint by avoiding unnecessary headings, long lists, and verbose
  explanations.
- Added `SESSION_WORKFLOW.md` as the durable cross-project session operating
  model for start, resume, wrap-up, session roles, repository boundaries,
  communication style, database safety, and continuity.
- Added the user's global communication preference: direct answers to the
  user's questions should be short by default, while development work, CTO
  handoffs, implementation notes, decision records, and cross-session summaries
  should include as much detail as needed.
- Added the user's wrap-up workflow preference: when the user asks to wrap up,
  pause, close out, hand off, or summarize a checkpoint, Codex should
  proactively organize the state and update durable Git-backed memory or
  project docs when appropriate.
- Clarified the wrap-up/resume workflow: end-of-work requests should include
  documentation, durable memory, work status, learned facts, needed items, next
  tasks, and the next starting point; resume requests should begin by pulling
  the relevant Git-backed context.
- Recorded an initial repository separation rule. This boundary was superseded
  on 2026-07-14: personal project status and handoffs now live in
  `codex-personal-context/projects/<project>.md`, while shared repositories keep
  stable team-owned information.

## 2026-06-14

- Added a global Codex working principle: prioritize truthfulness and
  uncertainty calibration over sounding confident.
- Recorded that Codex should explicitly label confirmed facts, observations,
  hypotheses, recommendations, and unknowns.
- Recorded that Codex must not imply implementation exists when only a design,
  idea, or document exists.
- Recorded that AI analysis work should separate raw evidence, interpretation,
  confidence, and uncertainty.
- Reinforced the user's remote-first rule: durable settings, preferences,
  project status, and continuity notes should be committed and pushed to
  remote-backed Git repositories whenever safe.

## 2026-06-13

- Updated Action Sports Journal project memory after the evidence-first video
  analysis validation day.
- Recorded latest project commits:
  - `e5e6d98 Validate evidence-first video analysis`
  - `4664bfb Prioritize trick initiation evidence`
- Recorded current recommended architecture:
  `Video -> Gemini Evidence Extraction -> User Confirmation -> Coaching Engine -> Stored Session Intelligence`.
- Recorded the current model split: Gemini is primary for video/motion evidence
  extraction; GPT is preferred for coaching/reporting after evidence and rider
  intent are confirmed.
- Recorded that exact Back Roll vs Tantrum classification is still not reliable
  enough to bypass user confirmation, but repeated Back Roll tests now fail in a
  more plausible Back Roll/Tantrum-family range instead of unrelated tricks.
- Recorded the wakeboard domain rule for future evaluation: trick identity
  should be determined primarily from stance, edge, approach, takeoff, pop, and
  rotation initiation. Landing and crash are outcomes, not primary
  trick-classification evidence.
- Recorded local evidence extraction stability setting:
  `GEMINI_EVIDENCE_MAX_OUTPUT_TOKENS=6000`.

## 2026-06-12

- Added initial personal context bootstrap structure.
- Established `codex-personal-context` as the source of truth for long-term AI
  collaboration context.
- Documented user profile, AI workflow, development style, decision framework,
  fitness context, vehicle context, and project index.
- Confirmed the current main project is Action Sports Journal.
- Confirmed the user's current vehicle is BMW G30 520d.
- Confirmed the user's preferred AI split: Claude for company development,
  Codex for side projects, ChatGPT for personal questions and coaching.
- Confirmed Action Sports Journal latest local project commit is
  `c7cdfe9 Switch dev analysis server to Gemini video input`.
- Updated Action Sports Journal latest project commit to
  `802bd94 Benchmark OpenAI wakeboard analysis`.
- Recorded that the current priority is an OpenAI GPT-5.5 wakeboard analysis
  benchmark before giving up on OpenAI. The implementation uses whole-video
  frame sampling, Responses API image inputs, xhigh reasoning, and structured
  coaching JSON. Actual GPT-5.5 benchmark still requires a local
  `OPENAI_API_KEY`.
- Added the remote continuity rule: when the user asks to check project
  progress or user context, durable findings should be committed and pushed to
  the appropriate Git source of truth rather than left only in local state or
  chat history.
- Corrected the local Codex startup sync instruction in `~/.codex/AGENTS.md`
  from `cd ~/.Codex && git pull` to
  `cd ~/Repository/codex-personal-context && git pull`, because `~/.codex` is
  an app state/config directory, not the Git source of truth.
- Added the user's remote-first rule: remote Git state is the default source of
  truth for continuity; local files are working copies unless the user
  explicitly says local unpushed work should be treated as authoritative.
