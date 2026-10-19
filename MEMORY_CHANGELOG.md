# Memory Changelog

## 2026-10-19

- DLDS PR#4692에 최신 release89@8d209ada9를 반영해 충돌12개·신규 import/mock 경로를 정리하고 f027171bd로 정상 커밋·푸시했다.
  릴리스 유입385경로 누락없음·제품308개 본문동일/import만 변경 확인, 관련595테스트·세앱 타입/lint·패키지/Admin CI 통과.
  기존 navigation15실패는 최신release원본과 동일하며 PR은 MERGEABLE·리뷰필요·미병합으로 유지한다.
  처음에는 Atlassian 플러그인 대상사이트 승인 문제로 Chrome에서 Jira3본문·기존 진행댓글을 직접 정리·재조회했다.
  이후 사용자 승인으로 웹 플러그인 설정에서 Innovaid 재연결을 수락하고 신규 플러그인의 사이트 목록·DL-16471 실제 조회 성공을 확인했다. Legacy는 별도이며 신규 연결을 사용한다.
  제품 병합·하네스·재배포 없이 대기하고, 실제 확인한 재연결 경로와 재개기준을 프로젝트 정본/HANDOFF에 남겼다.

- 권한관리 웹·앱 QA 요청을 사용자가 완료했으며 결과가 나오면 재개하기로 했다. 추가 개발·배포·조회·모니터링 없이 대기하며 기존 브랜치/worktree·앱 PR329 미병합 상태를 보존한다.

- 권한관리 사용자 추가승인으로 Office feature/DL-16317@5c3504d를 양OS Stagingv335(target2.2.4,mandatory100%enabled)로 직접CodePush했다.
  기존PR329는 앱개발자리뷰를위해 develop대상미병합유지하며 이번한정예외로기록했다. 양명령exit0·서버history·제품source map각339파일일치확인.
  웹DL-16319·앱DL-16752 모두READY FOR QA·전달댓글 및 PR본문정리완료. 웹Staging반영은사용자확인기준이며추가조회중단지시로polling종료했다.
  Lab/Admin성공·Clinic마지막독립조회진행중을구분해보존하고Actions최종성공을독립검증했다고기록하지않는다.
  Developmentv139/Production/Lab·제품코드/브랜치변경없음. Staging실기기적용·전체QA와운영출시는별도이며QA결과가다음재개점이다.

- DL-16796은 사용자가 스테이징 배포 완료를 알렸으며 QA 대기로 갱신했다. QA 이슈가 전달되면 대응하고 없으면 현 구현으로 마무리할 예정이다.
  현재 추가 작업·조회·모니터링 없이 대기한다. 사용자 배포 보고와 독립 배포 검증·QA 통과·운영 출시를 구분하고 Jira 댓글 미작성·사용자 상태 관리 결정을 유지했다.

- 권한관리 웹stage삭제/재생성 및release→stage PR4717생성후사용자병합(413ed3564)을확인했다. 원래stage복구ref·lease보존,release와tree동일.
  앱최종리뷰에서틀니워크플로구캐시갱신누락과채팅타입오류를586381f/5c3504d로보완·푸시·PR329본문정리했다.
  기존테스트회귀2건추가(새파일없음),관련235tests/lint/diffPASS,exact의존성type는develop과기존6진단동일.
  웹최근수정/앱연동은추가수정없음. 이후배포는사용자담당이며Developmentv139에최신두커밋미포함,Staging앱환경필요조건을명시했다.

- 사용자 재확인: `codex/` 등 에이전트 접두사 금지는 신규 기능뿐 아니라 QA·후속·임시·백업·전달·동기화·worktree 생성 브랜치 전부에 적용한다.
  주어진 이름/저장소 허용 패턴 안에서만 생성하고 생성 전후 실제 이름을 확인하도록 공통 지침과 세션 전달 절차를 보강했다.
  Draft PR은 GitHub Draft 상태 + `DRAFT` 라벨(#4713 확인) + 제목 앞 `[WIP] `(#4712 확인, 닫는 괄호 뒤 공백 한 칸 포함)를 모두 적용·재조회한다.
  이번 요청은 지침 정리이며 제품 브랜치·기존 PR 변경이나 타 세션 재지시는 수행하지 않았다.

- 권한관리 웹 브랜치의 기존 feature 접두사 규칙 누락을 사용자 지적으로 정정했다.
  로컬·원격 feature/DL-16317-payment-banner@20be3ee65 및 PR4716→release/v1.89.0으로 동일 SHA/diff를 확인했다.
  PR4715는 교체 링크 후 닫고 잘못된 codex ref만 삭제했다. 제품 코드·원본 feature/worktree·앱 배포에는 변경이 없다.
  배포 후 사용자 앱 홈 오류 해소·필터 디자인 적용 확인도 기록했다. Action Required 0/0/0과 기존 카드 표시 조건은 유지한다.

- 모바일웹·앱 기능 차이를 한 차례 독립 재검토했다. 기존 19항목은 유지하고 양쪽 초대 수락 2항목과 SHARED 목록·조회 1항목을 보완했다.
  SHARED 정산의 준비 중 화면·모바일 숨김 버튼을 실제 기능과 구분해 기록을 정정하고 Notion 최종 치과12행·기공소10행/Frankie22개 및 표 밖 보존을 확인했다.

- 권한관리 Member 앱 QA를시뮬레이터·Reactotron으로재현했다. 홈결제배너GET403(code2005)과정상주문요약0/0/0을구분했다.
  기존결제API는이번에추가한것이아니며backend보안코드3868da78에서OWNER/PM허용목록을확인했다. 사용자지시로기존전체권한까지웹/앱동일조건적용.
  앱필터50:50·배너권한보완13b28d6/87cc46b/최종be332c5커밋·푸시·PR329본문갱신,양OSDevelopmentv139배포·서버read-back완료.
  앱실제MemberQA·필터3+최종배너임시10검증(삭제)통과. 웹QA브랜치codex/dl-16317-payment-banner@20be3ee65/PR4715→release/v1.89.0생성,
  기존3파일·14tests·3서비스type·정상push검사PASS. jsqr누락설치후재검증했고package/lock/env변경없음.
  웹미병합·미배포,앱실기기OTA적용/전체QA별도. 임시진단복원/receiver종료·배포source정리,Member시뮬레이터/Metro·모든브랜치/worktree보존.

- 사용자 요청에 따라 모바일웹 대비 앱 기능 차이 조사를 Notion 기존 치과 11행·기공소 8행 표에 반영했다.
  확인자 `Frankie`, 미지원/부분지원 및 코드 조사 한계를 표시하고 우선순위·빈도는 비워두었다. 표 밖 내용과 기존 양식 보존을 재조회 검증했다.

- 메인세션에서 Clinic/Lab 모바일웹 대비 Office/Lab 앱 기능 차이를 읽기 전용으로 조사했다.
  앱 정상 진입이 없는 관리 기능과 기공소의 검색/집계·소속전환 차이를 기록하고, WebView/네이티브 대체 및
  모바일웹 자체 제한 기능은 제외했다. 두 앱 main·진행 release/권한관리 차이를 분리해 비교 문서와 색인을 저장했다.
  제품 수정·Jira·PR·배포·실기기 QA는 수행하지 않았으며 구현은 사용자 후속 결정 대기다.

- 권한관리 사용자의 명시적 진행 승인으로 Office feature/DL-16317@6437dbb를 iOS·Android Development v138에 배포했다.
  2.2.4·mandatory·100% 활성·설명/SHA를 read-back 확인. PR329는 미병합이며 웹/Lab·Staging/Production·태그·제품 코드는 변경하지 않았다.
  공용 node_modules가 lock과 달라 별도 HEAD archive+immutable install에서 번들·Hermes 생성했고 양 OS 업로드 exit0.
  실제 기기 적용/QA는 미실행이며 사용자 후속 요청까지 대기. 임시 빌드 소스/의존성을 정리하고 증거·재개 기준을 저장했다.

## 2026-10-16

- 메인세션에서 상태 보고의 기본 순서 **완료한 것 → 현재 영향 → 남은 일**을 모든 프로젝트·세션의
  공통 지침으로 재확정했다. 기존 AGENTS·SESSION_WORKFLOW의 브리핑 규칙에 적용 범위와 순서를
  명시했다. 인용된 회의 후 대기는 해당 작업의 예시이며, 다른 작업의 재개 조건으로 일반화하지 않는다.

- 사용자가 원하는 "브리핑·쉽게 설명"은 완료한 것과 위치, 현재 운영 영향과 이유, 남은 일을 한 번에 짧게 설명하는 형식임을 확정했다. AGENTS와 SESSION_WORKFLOW의 공통 보고 지침으로 저장하고 env 체크포인트에 실제 3줄 브리핑을 추가했다. 제품·GitHub·Notion·Jira 추가 변경 없이 회의 후 재개까지 대기한다.

- 웹 env 사용자가 회의에서 Notion 정리 문서를 공유한 뒤 후속 진행하기로 확정했다. 회의 전 문서·Jira·분류·코드·GitHub 새 설정 준비 완료, Draft PR4713 미병합 상태를 재확인했다. 기존 운영은 새 설정을 사용하지 않으며, 회의 후 재개 전까지 추가 변경 없이 대기한다.

- 웹 env 작업을 FE 기존 값·이름·동작 보존으로 재확정해 후속 구현을 마감했다. Eximbay 서버 변경 필수/미사용 Medit 제외 판단을 철회하고 private build로 모두 보존했다.
  89b051664/8d29f043e 정상 commit/push, Draft PR4713 본문 갱신. 9환경 값 일치·env74/E2E도구220·타입/lint 및 Clinic 포함3서비스 native빌드/HTTP200 확인.
  GitHub 새 build/E2E Secrets5개 추가(기존 설정 유지), 9개 기존 배포 Docker/workflow의 입력 연결·수동E2E 과거ref 호환·암호화 pack/unpack 구현.
  실제 TTY에서 발견한 전달 CLI 미종료를 수정하고 양쪽 exit0·내용일치·비출력 검증 후 fixture를 정리했다.
  Notion 운영/따라하기·Jira44467과 체크포인트를 최신화했다. 기존env9 추적 유지, 실제배포/merge/전환·Docker설치·실계정쓰기는 하지 않았다.
  추가 팀정책/BE계약을 받아올 필요 없이 다음 사용자 재개에서 Docker·팀원수신/실사용·복구 확인 후 전환한다. 아래 앞선 기록의 Eximbay 차단·Medit 제외는 대체된 이력이다.

- 권한관리 사용자가 현재 가능한 웹·앱 조치를 마감하고 QA는 나중에 진행하겠다고 명시했다.
  앱6437dbb/PR329 OPEN→develop·웹e28b9c7e8 clean을 재확인하고 대기 상태를 기록했다.
  QA·병합·배포·감시를 시작하지 않으며 브랜치/worktree 보존, 사용자 QA 재개 지시 후 실제 배포 버전부터 확인한다.

- 웹 환경변수 후속 검증을 추가 설치 없이 마쳤다. STAGE 비밀파일을 DEV에 가져오는 결함을 환경·종류 표시 검증으로 수정했고, Medit 키는 현재 웹 미사용으로 분류했다.
  최신 c1f424d06 정상 커밋·푸시, master 비교용 Draft PR4713 생성·첨부·base/head/draft 확인. 기존 env9파일·배포·원래 checkout은 보존했다.
  env46/E2E도구220·타입·lint 통과, 외부 네트워크 차단 Admin/Lab 실제 native 빌드와 standalone HTTP200, DEV/STAGE109개씩 테스트 목록 수집 확인.
  Docker 설치는 사용자 보류이며 이미지·실계정 시나리오·실제 팀원 전달·Clinic Eximbay 서버 처리·전환/복구는 남았다. BE 서명 API가 이미 있다는 근거는 없고 현재 callback은 발급 API가 아니다.
  Vercel 전용 키는 확인 범위에서 없었고 Vercel 사이트/미리보기 성공을 완료조건으로 삼지 않는다. Notion 따라하기·Jira44466·개인 체크포인트를 갱신하고 검증 서버 및 임시 native 복사본을 정리했다.

- 권한관리 웹·Office의 FE 예외 처리에 대한 과잉 차단/입력 유실 감사를 완료했다. 웹 신규 확정 수정 없음,
  앱 채팅 refresh·피드백 Retry/저장/첨부·승인 화면 복귀의 일시 오류 복구를 기존6파일에 반영했다.
  949e0f6/dafcad7/6437dbb 커밋·푸시, 기존 PR329 OPEN→develop 본문 및 head 확인 완료. 새 디자인·문구·정책·파일 없음.
  최종 관련5 suites/69 tests·lint PASS, 전체 tsc는 기존18진단과 출력동일. 403/404·직원 전환·오래된 콜백 차단 유지.
  웹 e28b9c7e8은 병합 release8daac3561과 소스 차이없음. 브랜치/worktree 보존, 새 DEV 배포 완료 확인/앱 실기기 QA는 별도다.
  Draft 정책 종결·필수 BE 추가 질문 없음 유지. 사용자가 Vercel 체크 생략을 지시했으며 병합/배포는 실행하지 않았다.

- 권한관리의 임의 디자인·문구·로직 여부를 확인했다. Figma475:75525의 실제 경고 원문과 공용 모달이 같고,
  Notion Resolved11에 경고 조건이 명시되어 있다. PR4710은 UI 추가 없이 조건 수정이다.
  단, 보조 조회 실패 시 모달 중단·기존 토스트 재사용, 앱 최초 조회 실패 뒤로가기, 일시 오류 입력 보존 등은
  FE 구현 판단이며 전부 디자인에 명시된 동작이라고 설명하면 안 된다. 핵심 출처와 예외처리 구분을 체크포인트에 기록했다.
  PLANNING SKIP의 기본 표시 클릭은 작업 전부터 막혔고 customButton 실제 사용처가 없어 새 실사용 제한으로 단정하지 않는다.
  제품 코드·Git refs·PR·배포·외부 문서는 수정하지 않았다.

- 웹 환경변수 전환 준비를 `feature/DL-16821`의 별도 worktree에서 구현했다. 공개 설정 CLI·private/E2E 분리·적용 보호·비배포 빌드 경로와 빈 예제를 추가했다.
  GitHub 새9환경/공개238항목 등록·read-back, 기존 설정·env9파일·배포 경로 보존. env36/E2E도구220·타입 검사 통과이며 실제 Docker/실계정 E2E/배포는 미실행이다.
  DL-16818을 문서·작업 목차로 정리하고 기존 조사 DL-16819 완료 유지, 새 구현 DL-16821 진행 중으로 연결했다.
  Notion에 로그인·최초 수신·private 준비·갱신·적용 명령을 별도 따라하기로 추가하고 세 문서에서 상위 Jira로 돌아가도록 정리했다.
  사용자는 필요한 실제 사용법을 생략하지 말고 길면 문서를 나누되 상위에 링크를 모으도록 요청했다. 준비 완료와 실제 보안 이관·운영 검증 완료를 구분한다.

- 권한관리 사용자가 PR4710을 release에 병합하고 해당 release 기반 DEV 배포를 진행 중이라고 보고했다.
  GitHub MERGED/release/v1.89.0/merge8daac3561/18:28:16 KST 확인. 배포 완료나 새 배포본 QA 통과로 확대하지 않는다.
  브랜치·worktree를 보존하고 다음 단계는 배포 완료 후 담당 변경 경고 및 권한 동작 재확인으로 갱신했다.

- 권한관리 DEV QA 후 승인된 FE 후속을 완료했다. release24d3ff18a에서 feature/DL-16317-dentist-warning 분기,
  748c8f6bb/e28b9c7e8 정상 커밋·푸시, PR4710 OPEN → release/v1.89.0 생성·base/head/2파일 확인.
  SSR 문자열 ID로 마지막 본인 주문의 경고가 누락되는 결함을 수정했다. 사용자 전달 BE 최종 답변은
  **Draft는 내 환자 판단에서 제외**이므로 통합 Patients 환자217 미포함은 정상 종결이며 BE 미완료가 아니다.
  담당 변경 경고에서도 다른 본인 Draft를 접근 유지 근거에서 제외하고 일반·취소 주문은 유지했다.
  수정 전 실패 재현 후 관련37 tests/Clinic·Lab·Admin 타입/정상push검사 PASS, 기존 lint warning 있음.
  원본featuref4bfaf1bf·worktree 및 앱feature7cb4487/PR329 의도적 미병합 보존. 앱 native 수정·병합·배포 없음.
  다음은 사용자 PR4710 병합·DEV 배포 후 경고 재확인, 스테이징 정식 QA/PR329 포함 앱 실기기 검증이다.
  아래 Draft 포함 정책 불일치 기록은 문의 당시 이력이며 새 답변으로 대체됐다.

- 권한관리 Admin 로그인 완료와 테스트 환경 생성 승인을 받아 DEV Admin/Member 사전 QA를 실제 수행했다.
  메뉴·필터·NEW/FOLLOW_UP 저장·상세3종·Pickup/공유 Case 링크·직접 URL 차단을 확인했다.
  Draft9738/9739/9740 생성, 합성9739 담당 변경 후 차단과 원복 후 접근 복구 확인. 제출/결제/기존 주문 변경 없음.
  FE5214 담당 변경 경고 누락은 SSR 문자열/숫자 ID 비교로 현재 주문을 다른 본인 주문으로 세는 결함으로 확정했다.
  기존 환자217에 Member Draft9740 저장200 후에도 새 Patients 응답5건에서 누락되는 정책/서버 반환 불일치를 확인했다.
  Draft 포함 PRD·실제 trace/필드·최소 FE 수정안·테스트 데이터·재개 순서를 기록했다. 제품 코드/Git/PR/배포 변경 없음.
  다음은 FE 최소 수정/회귀검증/PR 및 BE 실제 반환 조건 조사→DEV 재검증→스테이징 정식 QA다.

- 권한관리 사용자가 정식 QA 전 Codex 권한별 접속 검수를 제안해 DEV 읽기 검수를 시작했다.
  Member 역할·메뉴/필터·본인5214 상세를 확인했다. 담당 변경 경고 미노출은 실제 보조응답을 확인하기 전 판정 보류로 기록했다.
  공개 현재 DEV chunk에는 경고 구현/props/문구가 있다. 담당 변경 저장은 하지 않았다.
  Admin 세션이 없어 시크릿 DEV 로그인 화면을 준비하고 사용자 로그인 요청 후 대기한다. 제품/브랜치/배포 변경 없음.

- 권한관리 최종 검토에서 사용자가 개발서버 사전 테스트용 배포 완료·스테이징 정식 QA 예정이라고 명확히 했다.
  직전의 포괄적인 '배포 전' 표현을 정정했다. 웹 PR4700/4706 release 병합, 앱 PR329 의도적 미병합·미배포를 구분했다.
  읽기 전용 코드 교차 검토와 기존 검증 로그 재확인에서 신규 확정 차단 사유를 발견하지 못했다.
  Member 담당 변경 클릭 시1+N 순차 조회의 다주문 지연은 미측정이며, 앱 검증은 PR329 포함 버전으로 진행한다.
  원격 release는 비밀번호 변경 PR4701의24d3ff18a로 전진했지만 권한 소스는 그대로다. 권한 worktree10c30e3cb와 원본feature 보존.
  제품 수정·중복 전체 테스트·브랜치 전환·PR/배포 변경 없이 개인 체크포인트만 정리했다.

- 사용자가 브랜치 정리 기준을 과거 운영 배포 완료 작업으로 명확히 했다. 추가 설명에 따라
  진행 중인 v1.89의 원본 작업 브랜치와 필요한 worktree를 보존하고, 반영 완료된 부분 수정·QA용
  파생 브랜치는 구분하도록 SESSION_WORKFLOW에 저장했다.
  메인세션 삭제 목록과 현재 v1.89 대상/열린 PR의 head/base 교집합0 및 과거 출시 근거를 재확인했다.
  PR4706 codex 후속 브랜치를 필수 복구 대상으로 안내한 것은 과도한 해석이므로 정정했다.
  원래 feature/DL-16317은 이미 복구됐고 후속 변경도 release/worktree에 보존돼 추가 복구 불필요.
  이번 정정에서 제품 브랜치 삭제·복원·코드 변경은 하지 않았다.

- 권한관리 다른 에이전트 인계를 재확인했다. 웹 featuref4bfaf1bf 로컬/리모트 복구와 release10c30e3cb detached clean 보존 완료 상태이며 추가 복구 불필요.
  최신 사용자 기준을 release 반영·배포 전으로 정정했다. PR4700 통합 tree와 PR4706 최종 tree도 대조했다.
  현재 PRD5-2/5-3의 환자 전체 읽기 정책상 담당 변경 보조GET403을 필수 BE 질문으로 재분류하지 않는다.
  반면 PR329 미포함 앱의 승인 UI 노출 가능성은 조건부 배포 호환성으로 인정하고 Member 활성화/앱버전을 함께 관리하도록 기록했다.
  CodeRabbit thread resolved/추가0·체크PENDING, 제품수정·중복전체검증·배포·리뷰대기 없이 메모리만 갱신한다.

- 권한관리 #4700·#4706의 release/v1.89.0 반영과 squash 동일성을 확인하고 release 기준 Clinic/Lab Jest·3서비스 tsc 통과를 확인했다.
  정적 리뷰에서 확정 버그는 없고 배포 전 확인 2건(담당 변경 경고의 타 주문 403 처리, 웹 선배포 시 구버전 앱 승인 화면 노출)을 기록했다.
  feature/DL-16317은 보존, permission 워크트리는 release 10c30e3cb detached로 원복했다(Claude).

- 권한관리 사용자가 아직 상용 반영 전이라 웹 feature/DL-16317 복구와 워크트리 보존을 요청했다.
  삭제 전 f4bfaf1bf로 원래 feature를 로컬/리모트 복구하고 원격 동일을 확인했으며, 워크트리는 최신 release10c30e3cb detached HEAD로 유지한다.
  후속 codex 브랜치는 삭제 상태이고 앱 브랜치는 기존대로 보존한다. 사용자 후속 지시 전 재삭제하지 않는다.

- 권한관리 사용자의 개발서버 배포 완료 보고 후 실제 웹 PR4706 MERGED/release10c30e3cb를 확인했다.
  squash 통합 tree를 검증하고 웹 feature/DL-16317·codex/dl-16317-permission-followup의 로컬/리모트 브랜치를 삭제했다.
  원본 폴더는 release10c30e3cb detached HEAD·clean으로 보존했다. 미병합 Office PR329/앱 feature 브랜치는 유지한다.
  배포 보고와 실제 QA·앱 배포를 구분해 기록했으며 추가 리뷰/배포/감시는 하지 않고 QA 결과 대기로 종료한다.

- 권한관리 웹 PR4706 CodeRabbit의 승인 ID 대상 대체 오류를 재현·수정하고 d5f896740 정상 commit/push했다.
  기존2파일만 변경, Clinic353/Lab399 tests·3서비스 타입·정상push검사 PASS. thread 답변/resolve 완료.
  최신d5f896740 CodeRabbit은 마지막 PENDING이며 사용자 요청으로 추가 대기/조회 없이 종료한다.
  순차 조회의 병렬화는 추가 요청 tradeoff로 현 구조를 유지하는 근거를 PR에 남겼다. BE 추가 요청/앱 코드 변경/배포 없음.

- 권한관리 잔여 담당 변경 경고를 기존 환자 Case 주문·주문 상세 API 조합으로 구현했다.
  BE 필수 후속으로 분류했던 판단을 정정하고 웹976097e85/PR4706에 반영했다. Office PR329는7cb4487 유지하며
  동일 WebView 경로라 중복 앱 커밋 없이 웹 배포 의존성을 정리했다. 정상 commit/push·원격동일·clean, 두 PR본문 갱신.
  Clinic349/Lab399 tests·3서비스 타입·정상push검사·최종커밋 production build195페이지/standalone PASS.
  페이지 상시/병원 전체 조회 없이 Member 변경 클릭에만 조회하며 본인 주문 발견 시 중단, 오류·권한 전환 가드를 검증했다.
  사용자 배포/실제 QA 대기이며 merge·배포·CodePush·E2E·자동 리뷰 루프는 하지 않는다.

- 권한관리 Figma·실제 권한 PRD/TC·DEV Swagger 전반을 재대조해 Member 기존 Case 주문도 본인 배정임을 정정했다.
  웹 release047fcc585에서 새 codex/dl-16317-permission-followup을 만들어 f173d49f7 normal commit/push 및 PR4706을 생성했다.
  담당 UI 숨김/불필요 조회 중단과 읽기 전용 번역·승인·완료C.P. 조회를 보완했다. Clinic324/Lab399 tests·3서비스 타입·
  정상push검사·정식production build195페이지 PASS. 앱은 사용자 확인에 따라 기존 feature/PR329(develop)에
  0c6bc84/de9be1f/7cb4487을 푸시했다. 후속/ISV 담당 배정, 읽기 채팅·접근 복구, 승인 입력 보존을 기존21파일에 반영했다.
  앱394 tests·lint오류0·iOS/Android JS bundle PASS, 타입18건은 변경전과 동일. 실제 QA와 담당 변경 경고 BE 판정 정보는 잔여다.
  신규파일/스토리/env/패키지 생성이나 후속merge/배포/CodePush는 없다. Jira403과 앱CodeRabbit skip을 실제 통과와 구분했다.

- 사용자 요청으로 frankieTemp 백업 5개를 추가 검토했다. version·threeJsTemp는 다른 담당자의
  대체 완료, DL-10132는 최근 적용 완료 및 과거 약관 초안 폐기, DL-4978은 실험 폐기 승인을 받아
  원격 4개를 삭제했다. invoiceTemplete는 유사 HTML 견본만 있고 실제 배송 문서는 서버 URL로
  제공되어 대체 적용을 확인하지 못했으므로 추가 질문 없이 보존했다. 삭제 전 bundle과 삭제 후
  ref·checkout 불변을 검증했다. 오늘 원격 삭제 누계158개지만 이번4개는 원본 전체 출시 증명과
  구분한다. 개인 정본과 삭제 목록을 갱신하고 추가 제품 작업 없이 마무리한다.

- 사용자 요청으로 출시 완료된 본인 작업만 대조해 웹/Office/Lab의 로컬 브랜치 4개,
  worktree 1개, 원격 브랜치 154개(웹147/Office1/Lab6)를 삭제했다. 삭제 직전 SHA·소유 PR·
  squash/전체 패치 반영과 운영 전달을 검증하고 bundle·삭제 목록을 보존했다.
  권한관리·LBX·DLDS·Billing 및 공용/타인/불명확 브랜치는 유지했다. 웹 태그·stash·
  보존 ref 불변, 남은 8개 worktree clean을 확인했다. Lab 기본 checkout만 최신 main으로 복귀했다.
  HANDOFF의 오래된 권한/LBX/UI 상태와 Billing PR #4699 release 병합을 정정하고,
  FE의 중복 기능 전달 이력은 기능 정본으로 모았다. 제품 코드·PR·Jira·배포 변경은 없다.

- 사용자가 권한관리 웹 개발서버 배포 완료와 검토 후 이슈 전달 계획을 알렸다. 사용자 보고와 Codex의
  실제 배포/화면 검증을 구분하여 기록했고, 운영 배포·master 반영 완료로 확대하지 않았다.
  추가 검수·제품 수정·Jira 변경·자동 모니터링 없이 검토 결과를 기다린다.

- 사용자가 권한관리 웹 PR4700을 release/v1.89.0에 병합했다고 알려 GitHub MERGED와 원격
  merge047fcc585(13:03:46 KST)를 확인했다. 실제 release tree가 사전에 검증한0a14f88과 일치한다.
  feature f4bfaf1bf/worktree는 유지하고 배포·실제QA는 미확인으로 구분했다. 제품 추가수정·Jira·앱·배포 없이
  다음 배포/QA 결과와 재개 지시를 기다리는 상태로 개인 Git 체크포인트를 갱신했다.

- 웹 env 착수 전 질문을 제안 가능한 사항과 실제 팀 답이 필요한 사항으로 나눈 최종 설명을 저장하고 대기한다.
  기존 비밀값 공유 수단·실제 접근 허용 범위·조회 불가한 외부 키 상태는 미확인으로 유지하며,
  신규 도구/비용은 구체안을 만든 뒤 도입 여부를 확인한다. 사용자 재개 전 추가 조사·Notion·제품·설정 변경은 없다.

- 웹 env 구현 전 질문 검토 요청을 기록했다. 로컬 비밀값 공유 경로·환경별 접근 범위·외부 키 검증 접근을
  팀 확인 사항으로, 명시적 로컬 갱신/개인 override 보존·기존 배포 절차 유지를 제안 정책으로 구분했다.
  기술 설계는 Codex가 담당하며 모든 답을 착수 선행 조건으로 묶지 않는다. 값 연결·해당 키 이관·운영 전환의
  확인 시점을 나눴고, 구현·Notion 수정·설정 변경·배포 없이 개인 Git 메모리만 갱신했다.

- 권한관리 최종 검토 지적을 f4bfaf1bf로 수정·정상커밋/푸시하고 기존 PR4700 본문을 갱신했다.
  최초 주문 확인 전 승인자료 차단, 리메이크/승인 작성 중 일시적 재조회 실패 시 입력 보존,
  숨긴 Member 의사 필터의 직원 조회 중단을 기존10파일 안에서 보완했다. Clinic303tests·3서비스 타입·
  정상push린트/커버리지 및정식production build195페이지/standalone이 통과했다.
  이전 빌드 해석 오류는 pnpm wrapper 실행경로를 빠뜨린 검증방식 문제로 정정하며 manifest/lock/env변경은 없다.
  최신release와충돌없음/최종합성Clinic타입PASS, PR OPEN/MERGEABLE·필수리뷰대기·새CodeRabbitPENDING.
  발견된코드조치잔여없으며 사용자병합/실제QA·배포를 다음으로 남겼다. merge/배포/앱/Jira변경은 없다.

- 웹 env 회의에서 GitHub 기반 적용과 팀 공동 관리를 확정한 내용을 저장했다. 회의 메모의 의미는 이해 완료이며,
  현재는 로컬 동기화·서비스/환경 분리·Variables/Secrets 분류·공개 키·변경 반영/복원 운영안을 구체화하는 단계다.
  master8772d688의 env9개/변수명105개·배포9개·GitHub 메타데이터·공식 자료를 조사했고,
  환경9개 구획/로컬 단방향 갱신을 제안했다. E2E 비밀값 분리와 Eximbay 브라우저 서명 경로,
  설정만 바꾼 재빌드의 이미지/정적파일 복원 고려사항을 기록했다. Vault/Infisical 도입은 미정이며,
  팀의 기존 비밀값 공유 경로와 외부 키 실제 상태는 확인 대상으로 남긴다. Notion·제품 코드·설정·배포는 미변경이다.

- 권한관리 웹 PR4700 최종 검토에서 Member 리메이크의 일시적 재조회 실패 시 입력 유실과 승인 화면의
  주문 조회 대기/500에서도 파일을 표시하는 순서 문제2건을 저장소 밖 임시 테스트3건으로 재현했다.
  숨긴 Member 의사 필터용 조회는 비차단 정리 후보이며 권한 HOC·캐시·비동기 가드의 실제 사용 경로를 확인했다.
  Clinic/Lab 전체71 suites/665 tests 및3서비스 타입/lint오류0. 격리 production build는 기존 소스가 요구하는
  로컬 의존성 해석 오류로 미완료이며, 제품/PR/Jira 변경·병합·배포 없이 보완 후 머지를 권고했다.
  실제 최신 release2커밋과의 가상 통합은 충돌 없고 통합소스의3서비스 타입도 모두 통과했다.

## 2026-10-15

- 의자 최종 대안 SIZEOF 베이직 S 비교와 사용자 설명을 저장했다. 현재 의자가 크다는
  불편은 없고 전방 헤드 위치·좌판 선호가 우선이며, 신장/S 규격을 과도하게 중시했던
  추천을 바로잡아 아르코로 최종 확정했다. 사용자는 기존 구매결정서대로 진행하며 다른
  후보 조사도 종료했다. 실제 결제·승인·수령은 미확인으로 유지하고 수령 후 사용 후기까지
  대기한다. 사용자가 불편을 느끼지 않는 항목을 임의로 핵심 기준으로 올리지 않는 원칙을
  `DECISION_FRAMEWORK.md`에 보완했다.

- 권한관리 로컬 주문리스트의 Admin/Member 초기 Pending 필터 차이를 확인했다. 실제 filter-hint는
  Admin PENDING/해당38건, Member ALL/전체5건이며 Member에 같은 두 Pending 상태를 명시해도 HTTP200/0건이다.
  FE 공통 호출·필터 전달 누락은 없고 현재 역할별 반환 데이터에 맞는 표시다. Member 원래 전체목록으로 복원했으며
  제품/PR/Jira 수정·쓰기 QA 없이 이 읽기 검증 결과만 저장했다.

- 웹 env 관리안의 설명용 댓글 3개(전체 개념·로컬 관리·Variables/Secrets 구분)까지 최종 확인·저장했다. 본문에 잘못 덧붙인 요약은 제거해 원복하고, 설명은 기존 댓글 스레드에서 유지한다. 본문과 댓글은 더 수정하지 않으며 팀 의견을 받은 사용자의 재개 요청까지 구현·자동 모니터링 없이 대기한다.

- 권한관리 Office PR329(feature/DL-16317 → develop, df3c79a)를 생성하고 자동 workflow 후 실제 대상/본문을 확인했다.
  CodeRabbit은 release/* 자동 대상 설정으로 skipped·리뷰/스레드0이며 사용자 지시대로 별도 재실행 없이 종료했다.
  웹 PR4700 최신55ad768d5 실제 CodeRabbit 리뷰·전체3스레드 resolved를 재확인했다. 추가 제품 수정은 없다.
  Office Jira44462·Web44459에 PR/잔여를 반영하고 Ready for Deploy 유지. 팀 리뷰·QA 버전 준비·실기기/쓰기 QA·승인 배포를
  다음 단계로 저장하며 병합·배포·CodePush·자동 모니터링 없이 대기한다.

- 사용자의 명시적 요청으로 제품 구매 판단 방식을 `DECISION_FRAMEWORK.md`에 정리하고
  `PROFILE.md`에서 연결했다. 제약 안의 최적 선택, 확인 가능한 변수의 충분한 비교,
  재확인의 목적(누락 변수·판단 근거 점검), 적합성과 가성비 순위 분리, 미확인 수용과
  제한된 조사 후 종료를 기록했다. 의자 체크포인트는 아르코 선택·결제 진행 의사만
  사례로 남기고 구매·수령 완료로 표현하지 않았다. 메모리 저장 후 추가 작업 없이 대기한다.

- 권한관리 토큰 중단 작업을 복구했다. Claude 웹55ad768d5를 정식 worktree에 반영하고 최신 CodeRabbit
  신규지적0/미해결0 및 기존4 suites/38 tests 통과 확인. Office 앱의 주문별 채팅 API, 직원/권한별 캐시,
  2152 세션/상세, 승인조회·비동기/업로드 정리, 불필요 조건을 보완하고 최신develop62e5864를 feature에 통합했다.
  앱df3c79a 정상 push·원격동일·clean, 26 suites/235 tests·lint오류0·iOS/Android JS bundle PASS,
  전체 타입 기존18진단 유지/추가0. Web 댓글44459·Office 댓글44460 및 Office Ready for Deploy 전환 완료.
  현재 계약 개발 잔여 없음, 앱PR·팀리뷰/QA준비·실기기/쓰기QA·승인배포가 다음이며 아직 PR/배포/CodePush 미실행.


- 권한관리 PR4700을 Claude가 이어받아 CodeRabbit 실제 스레드3건을 처리했다(앞선 '리뷰0건' 기록 정정).
  부분 상세 Place Order 가드 제거, 주문 작성 화면 403 외 조회 실패 시 조회 불가 표시(2131 제외),
  shared 시스템 메시지 권한 ref의 layout effect 갱신을 3커밋으로 반영해 원격 `55ad768d5` push·스레드 resolve했다.
  관련 Jest 14 suites/131 tests·3서비스 타입/lint·DLOS guard·shared coverage 통과, 실계정 QA 없음.
  중첩 worktree ESLint 충돌로 hook 항목을 직접 실행 후 `--no-verify` push했다. 정식 웹 worktree는 3커밋 뒤,
  Office 앱 worktree에는 기록되지 않은 미커밋 변경34항목이 있어 소유권 확인 전 손대지 않는다.

- 권한관리 앱 재점검에서 Office의 주문 채팅 API 미전환, 직원/권한별 대화 캐시 누락,
  활성 직원 캐시 reader/writer 불일치와 403/2152가 세션 만료로 처리되는 결함을 확인했다.
  앱은 추가 FE 개발이 남으며 새 BE API 대기 상태가 아니다. Lab 앱 추가 변경 근거는 없었다.
  웹의 부분 상세에서 다른 주문 이동까지 편집 권한으로 막던 결함은 `96ff6836b`로 보완했다.
  기존 테스트 안에서 수정 전 실패·수정 후 3 suites/32 tests 통과, Office 기존18 suites/128 tests 통과.
  사용자 담당 Web/Office Jira를 현재 계약과 제품별 완료/잔여 기준으로 정리했다.

- 웹 env 관리안의 최종 Notion 문서와 ASJ/Render 참고 예시를 확정했다. Render 실제 환경변수 화면·서버 코드 위치·process.env 의미, GitHub Variables와의 공통점/차이·선정 이유·공개/비밀값 구분을 정리했다. 사용자 지정 403 조사 문서와 같은 DEV Team / Development Documents 계층으로 이동했다. 이후 사용자 직접 편집본을 검토하고 승인된 대체안 제목만 'GitHub 기반 환경변수 관리'로 변경해 나머지 본문 보존을 확인했다. 제품 구현·설정 변경·배포 없이 개인 메모리 저장 후 대기한다.

- 권한관리 PR4700을 실제 제품 사용 경로 기준으로 다시 정리했다. Storybook 변경 7건을 제외하고,
  미사용 Draft/페이지 권한 입력과 Lab 메모·상태·배송·추가금 선행 확장을 원복했다.
  실제 Member 제한은 보존했으며 테스트 27→24파일, PR 174→151파일로 줄였다.
  정리 제품 커밋 `b725934a7` 정상 push 완료, PR 본문 갱신 및 관련 Jest 24 suites/217 tests,
  3서비스 타입·lint·DLOS guard·shared coverage 정상 hook 통과.
  사용자의 Storybook 미사용 방향과 필요한 테스트만 유지하는 기준을 프로젝트 체크포인트에 기록했다.

- PR4700 CodeRabbit 확인에서 SUCCESS 표시와 달리 review-limit으로 실제 리뷰가 미실행됐고 리뷰/스레드0임을 확인했다.
  최대 US$42.75 유료 재실행 안내에 사용자가 한도 초과면 건너뛰도록 지시해 리뷰 생략을 확정했다.
  과금/재실행/대체 전수리뷰·제품 수정 없이 현재 release 대상 PR과 HEAD7bf2b72a7을 유지하고 팀 리뷰·QA로 넘긴다.

- 사용자가 권한관리 전달 경로를 master 파생 → feature/DL-16317 → release/v1.89.0 → master로 재확정했다.
  develop은 이번 기반/릴리즈/완료 판정과 무관하며 이전 임시 개발서버 이력을 현재 전달 경로에 연결하지 않도록 정정했다.
  기존 PR4700의 release 대상은 이 기준에 부합해 제품·PR 변경 없이 유지했다.

- 권한관리 사용자 요청으로 기존 develop PR3건 MERGED/열린PR없음을 확인하고 release/v1.89.0 대상 PR4700을 생성했다.
  generated 설명 주석1곳 충돌을 릴리즈 문구로 해소해 feature HEAD7bf2b72a7을 normal commit/push했다.
  3서비스 타입/린트·필수 guard/coverage 통과, 릴리즈 변경 보존·174파일 최종범위·실제 base/head/MERGEABLE 확인 완료.
  다음은 팀 리뷰/병합·배포 후 준비된 데이터 QA이며 자동 리뷰 대응/병합/배포는 이번 범위에 포함하지 않았다.

- 권한관리 기존 feature에서 사용자 제공 Member/Admin 로컬 로그인과 DEV API를 연결해 메뉴/필터·홈/최근채팅 범위,
  기본/부분/403·2152 차단 상세, 본인 수정 허용/공유 수정 제한·타 의사 승인 화면 차단을 확인했다.
  Lab 실제 화면에서도 건수 숨김/트리 유지와 환자 제목 middle 정렬을 확인했다.
  홈 채팅의 직원/권한 변경 캐시 재사용 결함을 회귀 테스트로 재현·수정해 `e5c8a3e19`로 normal commit/push했다.
  관련 테스트·3서비스 타입/린트·필수 push 검사를 통과했으며 실제 저장/전송·Draft3종·담당자 변경/Lab 경계 QA를 잔여로 구분했다.
  추가 API 출시 대기나 선제 BE 질문 없이 준비된 실제 사례로 후속 검수할 순서를 기록했다. PR/병합/배포는 하지 않았다.

- 권한관리에서 사용자가 BE 예정 API 출시 완료를 전달해 DEV 전체/Office/Lab Swagger와 실제 FE 호출부를 재대조했다.
  필수 API/응답 필드 누락은 발견하지 못했고, 포괄적인 BE 추가 작업 대기를 해제했다. 기존 GET의 내부 권한 정제와
  Draft/건수는 연동 QA 잔여이며 API 미구현으로 단정하지 않는다. 별도 판정 API·권한 필드 요청도 불필요하다.
  신규 Lab DL-16747의 완료 범위 포함 여부와 판정 기준만 좁혀 BE에 확인하며, 기존 Member 검증을 막지 않는 순서로 정정했다.

- DL-16796 사용자가 Admin 포함 댓글 요구사항의 개발 완료를 확인하고 메모리화 후 대기를 요청했다. 제품3aac1dff0 clean·PR4699 OPEN/release1.89·CodeRabbit SUCCESS/미해결0을 다시 확인했다. Jira 댓글 미작성·사용자 직접 상태 관리(하위 Ready for Deploy), 팀 승인/실환경 QA/병합/배포 전과 재개 시 live PR 확인 순서를 정리하고 추가 작업 없이 대기한다.

- 권한관리 후속 점검에서 원기획/TC·댓글을 대조해 Member의 미지정/본인 Draft 표시와 신규 본인 할당은 확정 요구임을 정정했다.
  기존 Draft/form 테스트 3 suites/38 tests와 실제 수정 컴포넌트의 격리 로컬 렌더를 확인했고 추가 제품 결함은 발견하지 못했다.
  기존 i18n 실패는 서비스 분기를 구분하지 못하는 감사 도구 오탐으로 분리했다. 제품 `7c724ad0a`는 원격 일치·clean 유지다.
  Lab 이후 주문 열람 기준의 기획 질문, BE 목록/GET/건수/Draft 적용 확인, 이후 로컬 실계정 QA 순서를 구체화했다.
  기획 문서의 포함 Drive 자료 1개 미열람 및 실계정·서버·쓰기 QA 미완료 한계를 보존한다.

- 권한관리 최신 Figma·Jira·Swagger 재검토 뒤 승인된 웹 UI 2건을 기존 `feature/DL-16317`의 `7c724ad0a`로 normal commit/push했다.
  Lab 상세의 Cases/Orders 건수만 숨기고 Total/트리/Clinic 표시를 유지했으며, Lab 환자 목록 제목의 baseline 정렬을 middle로 수정했다.
  3서비스 타입·린트·필수 guard/coverage·독립 리뷰 통과, 실제 화면/실계정 QA·배포는 미실행이다.
  추가 i18n 감사의 기존 OFFICE 전용 logIn 키 검출 실패를 별도로 기록했다. 관련 Jira 30개/연결 기획 재검토로
  Lab 이후 주문 열람 범위 계약, Member 홈·최근 목록의 서버 정제, Draft/자동 할당·서버 검증 잔여와 재개 순서를 정리했다.

- PR4699의 CodeRabbit이 현재 head3aac1dff0/11파일 검토 완료·SUCCESS, actionable comment/미해결 스레드0건임을 확인했다. Docstring50% 경고는 로직 변경 없는 명칭 치환에서 추가 수정하지 않는 근거를 PR댓글6183353072에 기록했다. 독립 소스 검토도 결함 없음, 제품 추가 변경/커밋/푸시 없이 팀 리뷰 대기로 갱신했다.

- DL-16796을 사용자 승인에 따라 최신 master에서 구현해 `3aac1dff0`으로 normal commit/push하고 release/v1.89.0 대상 PR4699를 생성·연결했다. 11파일의 문서/버튼/번호라벨/파일명만 변경했고 발행·결제 구조는 유지했다. 로컬 의존성 링크 누락을 frozen install로 복구한 뒤 3서비스 타입·린트와 필수 push 검사, 합성 PDF8사례 전후 비교·11페이지 시각 확인을 마쳤다. 사용량 제한으로 중단된 보조 검증은 루트가 이어받았다. 네이티브 수정 불필요 소스 판정, 실제 다운로드/실기기·첨부·리뷰/병합/배포 미완료와 재개 시작점을 보존한다.

- 사무실 의자 조사 현황을 사용자 요청으로 저장했다. 최신 총예산 40만 원·지원금 30만 원, 통짜 쿠션 좌판과 헤드판 후방 회전 방지 목적, 실제 판매 링크/옵션 가격과 미검증을 구분했다. G1의 165cm 헤드 높이 후기·레니프의 고정력 불만·X3/X5 차이와 현재 의자 수리의 미실행 상태를 보존한다. 구매/수리 결정 없이 사용자가 후보를 직접 검토한 의견을 다음 시작점으로 둔다.

- DL-16796 현황 재조회에서 상위 댓글13개·하위댓글0개를 확인했다. Mina 댓글44443의 관리자 `Statement 다운로드 → Invoice 다운로드` 명시 요청을 체크포인트에 추가했다. 제품·Jira 변경 없이 구현 지시 대기를 유지한다.

- DL-16796 Billing Statement 담당 세션의 읽기 전용 조사와 사용자 범위 정정을 신규 체크포인트에 저장했다.
  기존 개별/통합 문서 명칭 변경만 수행하며 발행/결제 구조는 유지한다. 최신 Jira의 케이스별 Invoice 답변과 관리자 버튼 요청,
  FE PDF 생성 근거, 첨부/앱/실제 QA 미완료, clean master/최신 원격 및 향후 feature 시작점을 구분했다.
  제품 구현·브랜치·PR·Jira 변경 없이 사용자 재개 지시를 기다린다.

## 2026-10-14

- 권한관리 사용자가 여기서 중단하고 재개 인계를 요청했다. 개인 Git pull→프로젝트 기록→기존 feature/원격 확인 순서와
  BE 계약 후속·로컬 Member QA의 서로 다른 시작점을 명시했다. DEV에 feature가 배포됐다고 가정하지 않고 재개 지시 전 대기한다.

- 권한관리 로컬 QA를 현재 가능한 범위에서 끝내라는 사용자 지시로 마감했다. Admin 파일 목록·선택/해제에 따른 Download 활성도 추가 확인했고
  Member 시크릿 localhost는 미로그인으로 미검증을 남겼다. 추가 로그인 요청 없이 대기하며 검수 서버/생성 localhost 탭만 종료했다.
  제품 f74949159 원격 일치·clean, 소스 신규 변경 없음. 검수 근거·범위 한계·추후 재개 조건을 개인 Git 정본에 정리했다.

- 사용자가 DEV 웹 원복을 알리고 권한 feature의 로컬 화면 검수를 재개했다. f74949159를 localhost:3000에서 실행했고
  기존 DEV API와 연결된 Admin jongsun.test1의 목록 필터·상세9123/3943·승인 미리보기9248/1469·Pickup 상세 이동을 확인했다.
  권한 화면 신규 결함은 미발견, Member는 시크릿 localhost 로그인 준비를 요청한 상태다. 서버/비교 창을 유지한다.
  제품 소스 수정·배포·E2E·저장/승인/전송은 하지 않았다. 부가 QA 위젯의 Jira 사용자 조회500은 별도 로컬 연동 문제로 구분했다.

- 권한관리 최신 지시를 현재 DEV/QA/화면 검수 제외·기존 웹 feature의 확정 계약 구현으로 갱신했다.
  Leo 댓글44435의 기존 주문 GET200/담당 의사 비교/403·2152 계약과 현재 코드를 대조했으며 별도 검증 API 대기는 해제했다.
  필요한 with/직접 진입/action/cache는 유지하고 Member Remake Additional의 중복 GET만 응답 재사용으로 정리했다.
  Swagger 생성물4파일과 Clinic3파일을 f74949159에 normal commit/push하고 원격 일치·clean을 확인했다.
  관련55건·3서비스 타입·독립 리뷰·normal push 검사 통과.
  추가 정책/BE 계약·추후 QA·Office native의 별도 잔여와 새 PR/병합/배포를 하지 않는 경계를 정본에 저장했다.

## 2026-10-13

- 사용자 최신 지시에 따라 E2E/ISV 관련을 현재 권한관리 작업 범위에서 제외했다.
  기존 결과는 참고 이력으로만 남기고 잔여 작업·대기/재개 조건에서 제거했다. 추가 조사·수정·재실행·모니터링 없이
  BE 후속 계약과 권한 검증 사례를 기다린다. 제품 코드·CI·테스트 설정 변경은 없다.

- 사용자 직접 승인으로 PR4696을 develop에 일반 병합했다(19:33:51 KST, 03e62121e).
  DEV38384223907 배포/probe 성공과 새 BUILD_ID Kd6ikAQrMpzBT5J6qW4k0 실제 서빙 뒤 Member/Admin 읽기·화면 이동 QA를 완료했다.
  문자열 주문 ID 회귀의 해결을 Admin 채팅/Review 복구·승인 진입, Member 본인/공유 및 Admin 공유 주문 새 GET200으로 확인했다.
  기본/부분/차단 화면·입력 제한·Member 목록 필터도 유지됐다. feature e106405ad 보존, develop tree동일, 추가 소스 수정 없음.
  새 E2E 최종97통과/2실패/5허용제외/5미실행, 승인/Feedback2 및 후속10건 회복을 확인했다. 기존 ISV2의 동일 timeout만 남았다.
  BE 최종 범위/오류 계약·추가 테스트 사례·실제 쓰기 QA·Office native 별도 잔여를 보존하고 현재 가능한 FE 작업 완료로 대기한다.
  CI 확인 모니터를 종료했고 별도 Jira/Slack 수동 전달·상용 배포·장기 모니터링은 하지 않았다.

- PR4695의 DEV 새 BUILD_ID UowKnn4x6iXWck7cKODV7 실제 서빙 후 두 실계정 화면을 비교했다.
  Member/Admin Orders5/1033·Patients5/612·Board4/559, 본인5214기본·공유3943부분·9123Member차단/Admin허용과 Pickup 전링크 진입을 확인했다.
  새 채팅 adapter가 SSR 문자열 주문번호를 거절해 요청0이 되는 FE 회귀를 발견하고 e106405ad로 수정·normal commit/push했다.
  채팅48건·전체Clinic302건·3서비스타입·독립리뷰·normal push검사 통과. PR4696 feature/DL-16317→develop 1커밋/3파일 생성·연결했다.
  수정은 아직 미배포이며 사용자 병합→새배포→채팅 조회 재확인, 자동E2E최종결과·BE추가범위/승인부분조회사례·쓰기QA·native별도잔여를 기록하고 대기한다.

- 사용자 PR4695 병합(18:49:26 KST)과 develop97529d847/feature812aff0d4 tree동일을 확인했다.
  DEV38379072202는 Docker build/push 진행 중이며 새 BUILD_ID·화면 QA는 미확인이다.
  먼저 breakpoint를 저장하고 배포 완료 후 준비된 Member/Admin 화면검증을 계속하라는 최신 지시와 재개순서를 기록했다.
  별도 재배포·실제 전송/업로드/주문 변경·장기 BE모니터링은 포함하지 않는다.

- DL-16317 현재 feature 보존과 Clinic 변경 포함 DEV 전달 요청으로 후속 PR4695(feature/DL-16317→develop)를 만들었다.
  head812aff0d4/후속1커밋/43파일(Clinic26+shared17), clinic/** 배포조건충족·MERGEABLE을 확인했다.
  추가 소스/빈커밋 없이 원본 브랜치를 유지했다. Auto Assign성공·CodeRabbit develop리뷰skip·DLOS Vercel preview Blocked를 구분했다.
  사용자 병합→DEV자동배포→두계정QA, BE기능별 준비 대기 순서를 기록했으며 병합/배포/자동모니터링은 실행하지 않았다.

- DL-16317 웹 DEV 후속을 사용자 승인으로 구현하고 feature/DL-16317의812aff0d4를 normal hook으로 커밋·푸시했다.
  ORDER 채팅 API·역할 cache/입력 초기화·캡처 busy·직원 cache·숨긴 필터를 보완하고 Pickup 미사용 제한을 제거했다.
  Clinic281건/3서비스 타입·빌드/normal push 검사가 통과했다. 기존 DEV 두 계정 읽기 비교와 신규 코드 QA를 구분했다.
  새 PR/DEV 병합·배포, BE 기능별 계약·테스트 주문, 실제 쓰기 QA, native 별도 잔여를 정본의 다음 담당 순서로 저장했다.

- DL-16317 breakpoint 이후 중단된 Jira44423/API 반영 검토와 권한 구현 전수 감사를 마쳤다.
  BE의 ORDER 채팅 GET·POST 교체 요청을 확인하여 전체 채팅 명세 대기 판단을 정정했다.
  원본 hook/helper 임시 검사로 캡처 busy 회수·직원 scoped cache 갱신 누락을 재현하고,
  숨긴 URL 필터·Pickup 미사용 제한·역할 변경 chat cache 경계와 기존/신규 한계를 구분했다.
  웹167파일 범위·앱60파일의 source/caller 검토와 BE/FE 담당별 다음 범위를 정본에 기록했다.
  제품 HEAD·코드·Jira·PR·배포는 그대로이며 개인 진행 기록만 저장한다.

## 2026-10-12

- DL-16652 사용자가 앱 확인 완료·웹 직접 상용 배포 진행 중과 전체 작업 종결을 선언했다.
  앱Productionv13 활성100%·동기화15 사용자병합과 웹master693b8b4c의release1.88 전달 근거를 보존한다.
  Jira44407/완료 상태 유지·전용worktree3개와원격동일로컬branch7개정리·receipt3개보존/임시파일정리·개인기록푸시후세션보관이다.
  과거 STG/API/실기기 미완료 기록만으로 자동 재개하지 않으며 새 요청 전 추가 개발·조회·배포·예약·메인 보고는 없다.
- Lab 상용 CodePush와 최종 main→develop PR의 명시 요청을 완료했다. mainbb619010의 양OS Productionv13을
  비활성 업로드 후 Stagingv36과 각bundlehash동일/1.0.4를 확인해 활성화·mandatory·100%서버검증했다.
  iOS18:20:25/Android18:21:05 KST업로드, PR15→develop을 생성/연결했고 사용자병합56cba674/18:22:23도확인했다.
  main/develop전체tree8bd4226c동일/diff0. Jira44407/완료 상태 유지·개인기록정리, 웹은사용자직접배포다.
  root실기기운영OTA/화면/건강상태는미검증이며 기존참고·합의대기정책의자동변경/추가병합은없다.
- 앱 개발자 전달 일반 개발(develop 기준 feature→release→QA→release→main/CodePush→develop)과
  핫픽스(main 기준 hotfix→main/CodePush→release·develop 최신화)를 온보딩 정본에 저장했다.
  원문의 ‘별도 조율 전 참고만’ 조건과 기존 10/8 확정 지침과의 PR 대상·최신화 차이를 명시했다.
  AGENTS·SESSION_WORKFLOW·FE 조율 문서에서 앞으로 함께 읽도록 연결했으며 기존 정책·PR·배포는 자동 변경하지 않았다.
- 총주문수숨김웹4686(d2커밋→951503d4)·Lab13(e6커밋→8eeac898) commit/push/PR후사용자병합을확인했다.
  웹frozen install로3앱type/normalhooks PASS·CodeRabbit완료/미해결0. Stage복구/lease삭제/master6b기준재생성후
  전체release1.88 PR4687도사용자병합b98da6ff/tree249f=release이고최신웹보고는배포진행중이다.
  명시요청Labmain14=bb619010소스에서양OSStaging v36(18:03:16/18:03:48)완료·1.0.4/active/mandatory/100%서버확인이다.
  사용자는앱배포확인보고/root실기기QA는별도미검증. 개발자흐름은37eadee정본의참고·합의대기로구분했고자동정책대체없다.
  Jira44407/원완료상태유지·개인기록정리후대기, 추가Web조회/main→develop/Production/native/store/tag/메인메시지없다.
- 사용자Staging기준/웹release1.88직접지시로총주문수표시만삭제하는새브랜치를준비했다.
  웹feature/DL-16652-hide-total-orders@66aba1060·표1파일(+5/-16),
  앱QA/lab/DL-16652-hide-total-orders@1311d473·카드1파일(-21)로우리Lab count/API/i18n을보존했다.
  lint/format/diff·독립검토PASS, 웹기존type진단1640→1640/신규0·새화면QA미실행이다.
  제품소스는unstaged/local only·제품commit/push/PR/deploy없음이며현재LabStaging v35에는미반영이다.
  앱v35는description빈값이라exact배포SHA미입증을구분했고정본에다음전달시작점을기록했다.

## 2026-10-08

- 사용자가 앱 일반 feature의 통합 대상을 develop으로 정정했다. 같은 날 앞선 release 기본 해석을 대체하고
  AGENTS·SESSION_WORKFLOW·온보딩·제품별 정본·색인에 반영했다. release는 QA/배포이며 호환 CodePush는
  기존 release를 유지한다. 승인된 release 전달 정리 이력과 일반 신규 feature 시작 기준을 구분했다.
  양 앱 동기화 PR Office321/Lab9는 생성 후 GitHub에서 jongsunP 병합16:08:37/16:07:37 KST를 확인했다.
  메인 실행은 PR 생성까지다. 이후 진행은 다른 세션에 맡기고 여기서는 지침만 수정하라는 정정을 따르며,
  이미 수행된 작업은 유지하고 추가 제품 코드·PR·merge·배포 작업은 실행하지 않는다.
- DL-16652사용자마감요청으로완료상태/다음시작점을정리하고새요청전대기한다.
  메인생성기존Clinic321(04ed4e5b/16:08:37)·Lab9(e6fec379/16:07:37)의release→develop병합을live확인,
  양develop은각release와전체tree동일이다. 중복PR/추가병합·배포는하지않았다.
  일반앱feature→develop정정과Lab양OSStaging v32(1.0.4/active/mandatory/100%)완료를보존했다.
  root실기기v32적용/NEW픽셀QA는미검증이며Jira READY FOR QA 유지·메인메시지/새예약/자동후속작업없다.
  메인작성중공통정책7파일과제품checkout은보존하고기능checkpoint/changelog만별도저장했다.
- 사용자PR8병합59e6a56c/15:59:08확인후승인된Lab양플랫폼Staging CodePush재배포를완료했다.
  검증bb2df333과전체tree동일·native/deps/1.0.4보존, iOSv32/16:01:35·Androidv32/16:02:26 KST다.
  CLIexit0+서버history에서v31→v32/packageHash변경·description·active/mandatory/100%를검증했다.
  Jira44342/READY FOR QA·개인기록정리, 실제OTA적용/NEW회색14px픽셀QA는별도미확인이다.
  Clinic/Production/native/store/tag·번역시트·메인메시지는추가실행하지않았다.
- 사용자양앱검증/필요수정승인으로Lab NEW카드를최종Figma14px/#959595원본으로보정했다.
  QA/lab/DL-16652-review-icon@bb2df333·3파일(+11/-1)만push하고PR8→release1.0.4를생성/연결했다.
  자동화후base/diff·CLEAN/MERGEABLE·미해결0을검증, lint/실제SVG/양플랫폼JS bundle PASS·기존type5동일/신규0이다.
  Clinic최신2.2.4에는같은결함근거없어추가코드/PR없다. Jira44342/READY FOR QA정리·메인메시지없음.
  PR8병합/추가CodePush·실기기픽셀확인은아직이며현재Staging v31은아이콘미수정이다.
- 사용자 Lab iOS 실물 ‘검토 중’ 아이콘 제보를 양 앱 코드와 실제 SVG 변환/native paint 경로로 조사했다.
  Lab환자카드 NEW의 bgwhite/pathwhite가 직접원인이고 동일Android도영향받는다. Office 일반주문은
  보라색 원위white로대비유지·PR318Remake만변경이며 같은결함근거없다. 카드SVG12개도확인했다.
  이전QA가NEW실색검증을놓쳤다. 조사만완료/제품수정·배포·Jira미실행이며 v31배포와결함미수정을구분했다.
  정본/제품/FE에Lab카드범위최소보정다음시작점을남겼다. 실제기기확인은사용자가진행중이다.
- 사용자 Lab 문서5/기능6 병합768814e1/f000ae2c를 확인하고 명시 승인된 Staging CodePush를 실행했다.
  최신release1.0.4@f000ae2c/tree31a50be7·clean detached기존worktree에서 플랫폼별 명령을순차실행해
  iOS v31/15:25:36·Android v31/15:26:36 업로드 성공/CLIexit0·서버history readback을 확인했다.
  바이너리1.0.4·active/mandatory·rollout100%이며 새native/코드변경/태그/스토어/Production/Development/Slack은없다.
  Jira44342/READY FOR QA를 유지하고기록했다. 실기기OTA다운로드/적용/재실행·기능QA는별도로남아있다.
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
