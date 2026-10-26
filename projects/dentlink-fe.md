# Dentlink Frontend Coordination

This is the personal cross-repository coordination checkpoint for Dentlink
frontend work. It is not a product repository, combined workspace, or worktree.
Detailed implementation history remains in the relevant existing project file.

## 현재 업무 배정 — 2026-10-26 정리 후 신규 접수

- 사용자가 디자인시스템 작업 준비와 신규 업무 2개의 별도 세션 진행을 요청했다. 메인은 전달·시작 확인·공통 색인만 관리한다.
- 디자인시스템의 `/Users/parkjongsun/Repository/dentlink-client-dlds`는 최신 `origin/master`와 같은 `c597f1fb3e7f5c03a76237926c3effad5bb84983`의 **detached HEAD**로 준비됐다. 브랜치·구현·의존성 설치 없이 대기한다. 기본 checkout과 LBX는 유지하며, 웹 등록 worktree는 현재 2개다.
- 신규 2개 세션은 기존 **메인 프로젝트 폴더**에 생성했다. 별도 프로젝트 폴더·worktree는 없고, 실제 적용 모델/추론 수준 `gpt-6-astra / ultra`와 두 세션의 조사 시작을 확인했다. 제품 코드의 동시 작성 권한을 배정한 것은 아니다.

| 업무 | 담당 세션·ID | 현재 승인 범위 | 상세 정본 |
| --- | --- | --- | --- |
| 디자인시스템 준비 | 디자인시스템정비세션 · `01a0a2eb-da08-7131-aaaf-6c14f0cfc204` | detached worktree 준비 완료, branch/구현 없이 대기 | [DLDS](dentlink-fe-opportunities.md) |
| DL-17012 기공소 우선순위 산정 | DL-17012 기공소 앱 미지원 기능 우선순위 · `01a17657-caad-70f1-9a40-dbde874a3d42` | DL-16825 댓글44617과 기존 모바일웹/앱 비교에 따른 기공소 우선순위안 조사·초안. 치과 영역 보존 | [모바일웹·앱 비교](dentlink-mobile-web-app-parity.md) |
| DL-17011 관리자 그룹 회원 권한 수정 | DL-17011 관리자 그룹 회원 권한 수정 이력 조사 · `01a17658-54e4-7b42-bd92-d0f790d7f2bd` | 권한관리 이력·요구사항 조사 후 사용자에게 보고. 구현은 아직 시작하지 않음 | [권한관리](dentlink-permission-management.md) |

- DL-17012는 제품 코드 구현 요청이 아니라 기공소 앱 미지원 기능의 우선순위 산정이다. 사용빈도·사업 우선순위를 추정값으로 확정하지 않고 추천안과 미확인 사항을 분리한다.
- DL-17011의 상위 DL-17010은 **STG Admin OFFICE 그룹 회원 수정 화면**에서 신규 권한이 보이지 않는다는 제보다. 사용자의 최근 배포 QA 설명과 실제 제보 환경을 구분하고, 최초 미구현·병합/배포 누락·후속 회귀 등의 원인을 commit/PR/환경별 근거로 조사한다. 현재 원인을 확정한 것은 아니다.
- 두 신규 세션이 사용자에게 직접 보고한다. 이전 권한관리 세션의 완료·보관은 유지하며 이번 후속 조사는 새 세션에서 진행한다. 각 세션은 상세 정본, 메인은 공통 색인을 맡는다.

## 이전 작업 공간 정리 완료 — 2026-10-26 신규 접수 전

- **사용자 최종 방향:** `dentlink-client` 기본 저장소를 정리해 사용하고, 별도 작업 코드는 LBX만 보존한다. 기능 세션은 LBX·디자인시스템정비를 유지하며, 이번 정리와 무관한 통합알림센터도 그대로 유지한다. 이후 작업은 그때의 최신 master에서 필요한 브랜치/worktree를 준비하고 필요한 변경만 가져온다. LBX는 후속 명시 요청에 따라 아래처럼 로컬 준비까지 완료했다.
- 웹 worktree는 `/Users/parkjongsun/Repository/dentlink-client` **1개**, 로컬 브랜치는 **`master`와 `feature/DL-16387` 2개**다. 기본 checkout master는 `c597f1fb3e7f5c03a76237926c3effad5bb84983`로 origin/master와 동일·clean이다. 로컬 LBX는 이 master 위에 필요한19파일만 추가한 `f389c13cfbe497e0b864aa9399efafd9ecae305d`로 재구성했다. 원격 LBX는 기존 `b69dd84b6`을 보존했으며 새 로컬 브랜치의 과거 upstream 연결은 해제했다. [LBX 정본](dentlink-client-lbx.md)에 검증·복구·원격 경계를 기록했다.
- 남아 있던 env worktree와 완료된 로컬 `feature/DL-16821-stage-e2e`, `feature/v1.89.0-qa`를 제거했다. 두 원격 브랜치는 동일 SHA로 유지한다. DLDS 작업 공간 정리는 담당 세션에서 별도로 완료했으며 미완료 하네스의 복구 자료와 Studio 원격 삭제 권한 문제는 [담당 정본](dentlink-fe-opportunities.md)에 있다.
- 기본 저장소의 DEV env·E2E 설정과 의존성·공용 패키지를 준비했다. Clinic3000/Lab3005/Admin3002 로그인 페이지 HTTP200 및 env 로드를 확인한 뒤 임시 서버를 종료했다. 후속 사용자 요청으로 이번에 안내한 env 백업11개는 삭제했고 활성 로컬 env6개는 유지했다. 로그인 이후 기능 QA/E2E를 실행한 것은 아니다. 설정 정리와 검증 근거는 [env 정본](dentlink-client-env-management.md)을 따른다.
- **메인·LBX·디자인시스템정비·통합알림센터 세션 유지, env 세션 보관 완료.** 통합알림센터까지 보관한 것은 메인이 정리 범위를 넓게 해석한 것이며, 사용자 정정에 따라 즉시 보관 해제했다. 미착수 상태와 사전 검토는 그대로다. LBX의 승인된 로컬 재구성 외에 앱 저장소, 원격 refs, Jira, PR, 배포는 변경하지 않았다.
- 다음은 준비된 로컬 LBX 또는 새 사용자 요청에 필요한 작업만 이어간다. 폐기할 worktree의 env/의존성을 다시 맞추지 않는다. LBX 옛 원본은 원격·bundle로 보존하며 재구성된 로컬 결과를 원격에 올리는 작업은 별도다.
- **이번 정리 최종 마감:** 사용자 확인 후 기본 저장소5개(`codex-personal-context`, 웹, Office 앱, Lab 앱, Studio), 웹 worktree1개·master/LBX 브랜치2개·master clean, 유지할 Dentlink 세션4개를 다시 확인했다. 활성 로컬 env6개는 존재·Git 제외 상태이고 example4개는 Git 추적 대상이며, 이번에 삭제한 env 백업의 잔여는0개다. 추가 제품/IDE 설정 변경이나 테스트 재실행 없이 정리를 종료한다.
- **새 업무 시작 기준:** 신규 요청의 제품 범위를 먼저 나누고 담당 세션에서 진행한다. 일반 웹 신규 업무는 그 시점 최신 origin/master에서 새 작업 브랜치를 준비하며, 기존 LBX 브랜치를 다른 업무에 재사용하지 않는다. 이번 정리의 추가 필수 작업은 없다. LBX 원격 반영·운영 홀드, DLDS 2단계/Studio 권한, 통합알림센터 미착수는 각 담당 정본의 별도 후속으로 유지하며 새 요청 없이 실행하지 않는다.

## 이전 완료 업무 폴더 정리 — 2026-10-26

- 사용자 최신 범위는 **디자인시스템·env 유지, 권한관리·Billing 완료 업무의 Repository 폴더 정리**다. 현재 앱 목록에서도 디자인시스템정비세션·env 파일 Git 제외와 환경변수 관리 정리는 보관 밖 idle임을 확인했다. 이 두 세션과 관련 작업 공간은 변경하지 않았다. 10/25의 4세션 보관 표는 당시 이력이다.
- 권한관리 웹 `dentlink-client-permission`, Office `dentlink-app-permission`, 웹 내부 PR4700 리뷰의 **3개 등록 worktree를 제거**했다. 미커밋/미추적 코드·활성 작업 없음과 운영 코드 보존을 확인했다. Billing은 별도 폴더가 없어 기본 웹 저장소를 유지했다. Repository 바로 아래 폴더는10개→8개, 웹 checkout은6개→4개, Office는2개→1개다.
- env21개·debug keystore1·로컬 설정1·coverage baseline2의 **25개 파일**을 내용 조회/복사 없이 rename으로 `/Users/parkjongsun/.local/share/codex-closeout/20261026-permission-folders/`에 제한 권한 보관했다. 메타데이터 일치와 로컬 manifest를 확인했으며 Git 문서에 실제 파일을 업로드하지 않는다.
- **이번 브랜치 삭제는 없다.** 모든 로컬/원격 refs·기존 복구 bundle·기본 제품 저장소·Lab 앱은 유지했다. Office 기본 의존성과 다른 감시도 보존하고 두 permission 경로의 watch만 해제했다. 복구/재개는 [권한관리](dentlink-permission-management.md), [Office](dentlink-app.md), [Billing](dentlink-client-billing-statement.md)을 따른다.
- 원격 웹 master는 `c597f1fb3e7f5c03a76237926c3effad5bb84983`(PR4776)으로 release a5e465561을 포함한다. **어제 미실행이던 원격 release→master 통합은 이후 완료됐다.** 로컬 master8772d6882는 clean/40behind이며 fetch만 했다. Jira 버전 표시는 이번에 재조회/변경하지 않았다.
- 제품 코드·새 커밋/PR·배포·Jira 변경 없이 개인 정본/색인을 저장·푸시하고 대기한다. DLDS·env의 별도 과제와 기존 검증 한계는 자동 재개하지 않는다.

## 배포 후 종합 마감 — 2026-10-25

- 사용자가 오늘 배포된 작업의 담당 세션만 찾아 배포 상태·로컬/브랜치·Jira·개인 기록을 정리하고 보관하도록 승인했다. 메인은 대상 선정·전달·결과 검증·공통 색인을 맡고, 실제 정리는 아래 담당 세션에서 진행했다. 개인 컨텍스트 commit/push는 순차 실행했다.
- **웹 운영:** Clinic·Lab·Admin `prd/*/v1.89.0` 태그와 release가 모두 `a5e465561b953270b2925b2082845ba753f0572f`다. [Clinic 40180395283](https://github.com/Innvoaid/dentlink-client/actions/runs/40180395283), [Lab 40180309291](https://github.com/Innvoaid/dentlink-client/actions/runs/40180309291), [Admin 40180269225](https://github.com/Innvoaid/dentlink-client/actions/runs/40180269225) 모두 성공이다. 담당자가 각 작업의 병합 커밋·최종 변경 잔존을 대조했다.
- Clinic은 서울/오하이오 안정화·rollback 검사까지 성공했다. Lab/Admin은 workflow에서 ECS 안정화를 기다리지 않으며, 공개 접속·정적 파일 HTTP200을 별도로 확인했다. **운영 E2E·로그인 이후 기능 QA를 새로 수행한 것은 아니다.** 확인한 범위에서 오늘 배포의 실패 징후는 발견하지 못했다.
- **앱 관찰:** 권한관리 담당자가 Office 양OS Production **v84/2.2.4**, Lab 양OS **v17/1.0.5** 활성·mandatory100%와 각 최신 Staging 패키지 일치를 확인했다. 해당 수정의 운영 Git 포함과 OTA 활성은 확인했지만, OTA 설명에 source SHA가 없어 패키지→정확한 Git SHA 직접 대응·전 기기 적용/QA는 확인하지 못했다. 앱 원본 refs·작업 공간은 보존했다.

| 담당 세션 | 운영 반영·정리 결과 | 개인 기록·보관 |
| --- | --- | --- |
| DL-16796 Billing Statement 명칭 변경 | PR4699 포함. 로컬1·원격1 삭제. Jira 담당/QA 카드 이미 완료 | `02e8520`, [정본](dentlink-client-billing-statement.md), 보관 확인 |
| env 파일 Git 제외와 환경변수 관리 정리 | PR4713/4740/4743 포함. 로컬2·원격2 삭제. DL16821 완료 처리 | `9b39b9e`, [정본](dentlink-client-env-management.md), 보관 확인 |
| 디자인시스템정비세션 | PR4692/4723/4730/4731/4732 포함. 로컬4·원격4 삭제. DL16830 과거 배포실패 본문 정정 | `843fe09`, [정본](dentlink-fe-opportunities.md), 보관 확인 |
| 권한관리세션 | 웹 권한·후속9PR 및 앱 관련 수정의 운영 Git 포함. 로컬8·원격7 삭제. 담당24카드 이미 Done | `936dde2`, [정본](dentlink-permission-management.md), 보관 확인 |

- **총 정리:** 웹 로컬 브랜치15개·원격14개. 제품 코드/신규 제품 커밋/PR/병합/배포는 변경하지 않았다. exact SHA·본인 PR·운영 포함·열린 PR의 head/base·worktree 사용 여부와 복구 자료를 확인한 뒤 삭제했다. 전체 삭제 목록·복구 bundle/manifest의 경로·해시는 담당 정본에 있다. 백업 파일은 이 Mac에 있고 개인 문서 push로 다른 기기에 복사되지는 않는다.
- **보존:** 실제 env가 있는 env/DLDS통합/권한관리 worktree와 현재 브랜치, 미완료 DLDS 하네스, Office4개 feature·Lab3개 QA refs, 기존 stash/복구 자료·타 세션/타인 자원·보호 브랜치/태그. 이번 worktree 삭제는 없다. LBX의 운영 보류·통합알림센터 미착수 등 오늘 배포와 무관한 세션은 재개하지 않았다.
- **공통 후속:** 최종 재확인에서 웹 `origin/master=8772d68825cac6e23792d86a715153a67dc71078`이며 `release/v1.89.0 → master` 열린 PR도 없다. 이 통합은 미실행이다. Billing 담당자의 Jira 조회에서 v1.89.0은 `released=false`였다. 보호 브랜치 병합과 공용 버전 전환을 이번 정리로 자동 실행하지 않았다.
- **별도 보존 과제:** DLDS 정식 npm0.1.7 공개·Studio·하네스, Lab웹 번역2키의 Sheet 반영, 과거 DEV ISV E2E 실패2건, env와 별개인 키 제한/Eximbay 서명·키 교체, Lab앱 기존 타입 진단의 현행성 확인은 별도다. 오늘 운영 실패 또는 새 필수 QA로 임의 재분류하지 않으며 새 요청 없이 재개하지 않는다.
- 메인은 위 4세션의 실제 보관을 목록에서 확인했다. 공통 인계/색인을 이 결과에 맞게 저장·푸시한 뒤 추가 변경 없이 대기한다. 상세 이력은 담당 정본, 공통 결정과 조율은 이 문서로 구분한다.

## 공통 지침 정리 — 2026-10-20 로컬 Docker 도구 재사용

- 사용자 요청을 받은 환경변수 세션의 인계를 바탕으로 설치된 Colima/Docker 재사용 지침을
  [AI_WORKFLOW](../AI_WORKFLOW.md#local-docker-verification-and-tool-reuse)에 정리했다.
- 기존 전용 프로필·명시 context/config·격리 마운트를 재사용하고, 실제 env는 사람이 관리하며 다른 세션 자원은 보존한다.
  버전·자원 사양·완료한 검증은 [환경변수 작업 기록](dentlink-client-env-management.md#local-docker-tool-reuse)에 둔다.
- 이번 메인 작업은 문서·메모리 정리뿐이다. 도구 시작·추가 검증·제품 변경·배포·대기 업무 재개는 하지 않는다.

## 공통 지침 전파 — 2026-10-19 Atlassian 연결

- 디자인시스템정비세션의 사용자 원문을 확인해 기존·신규 세션 전파 권한을 확인했다.
  정본은 [AI_WORKFLOW의 Atlassian Connection Selection And Recovery](../AI_WORKFLOW.md#atlassian-connection-selection-and-recovery)이며,
  신규 Atlassian 사용·Legacy 자동 fallback 금지·Innovaid 사이트 확인과 복구 기준을 따른다.
- 메인세션에서도 신규 도구의 authorized resources와 `DL-16471` 실제 조회 성공을 확인했다.
  이는 현재 메인세션의 접근 확인이며 다른 계정·기기의 영구 정상이나 Legacy 복구를 뜻하지 않는다.
- `SESSION_WORKFLOW.md`의 신규 세션 전달 및 시작·재개 절차에 정본 참조를 추가했다.
  `setup-local-codex.sh`로 로컬 지침을 동기화하고 AGENTS·AI_WORKFLOW·SESSION_WORKFLOW의 원본 일치를 확인했다.
- 현재 작업 중인 **권한관리세션**(`01a132e9-6555-7a02-9c72-4dad9c04cc64`)에 지침만 전달했다.
  사용자 승인 작업과 대기 지시를 유지하며 다음 Jira 접근부터 적용하도록 안내했고, 회신이나 추가 인증 조회를 요구하지 않았다.
  원본 디자인시스템정비세션은 이미 해당 지침을 알고 있으므로 중복 회신하지 않았다.
  나머지 대기 FE 세션은 깨우지 않고 다음 재개 시 공통 지침을 적용한다.
- 이번 정리에서 제품·PR·배포·Notion·Jira 내용은 변경하지 않았다. 연결 지침 후속 정리는 완료이며 추가 작업 없이 대기한다.

## 정리 완료 — 2026-10-20 모바일웹 대비 기공소 앱 기능 차이

- 사용자 확인으로 기공소 Notion 정리·검토를 완료 처리했다. 클리닉은 수정하지 않았으며 추가 요청 전 문서·제품 작업 없이 대기한다.
- 후속 요청으로 사용자 본래 담당이 기공소임을 명확히 했다. Notion의 클리닉 담당자 작성 내용은 보존하고,
  기공소 10개 항목만 정리했다. 10/20에는 표를 `기능 / 앱에서 안 되는 것 / 현재 가능한 범위·조건` 3열로 개선했다.
  소속 전환의 조건 누락을 정정해 요약·표에서 일반 기능 8개와 공유기공소 도입 기능 2개를 구분했다.
  소속 전환은 INTERNAL·SHARED + 소속 2개 이상, 전용 목록·조회는 SHARED만 해당하며 Notion 재조회 검증을 완료했다.
  클리닉은 이후 검토·수정·보고 범위에서 제외한다.
- Clinic/Lab 모바일웹과 별도 Office/Lab 앱의 최신 main 계열 소스를 고정해 메뉴·화면·WebView·브리지·실제 요청 연결을 대조했다.
- 관리 기능의 앱 정상 진입 부재와 일부 검색/집계 차이를 정리했고, 모바일웹도 제한된 기능 및 네이티브 대체 기능은 제외했다.
- 코드 조사 완료, 제품 변경·실기기 QA·배포 없음. 세부 차이·근거·release 예외·다음 시작점은
  [모바일웹·앱 기능 비교](dentlink-mobile-web-app-parity.md)에 보존한다. 구현은 사용자 후속 결정 전 미착수다.

## 현재 재확인 — 2026-10-16 진행 중 릴리스 보존 기준

- 사용자가 ‘릴리즈 완료 작업 정리’는 **과거 운영 배포가 끝난 작업**을 뜻한다고 명확히 했다.
  현재 작업·QA·배포 대기인 `v1.89.0`의 **원본 작업 브랜치**와 필요한 worktree는 보존한다.
  추가 설명에 따라 release 통합 이후 부분 수정·QA용 임시 파생 브랜치와 구분한다.
  파생 작업은 대상 브랜치 반영과 활성 작업·의존성 없음을 확인하면 승인된 정리 범위에서 정리할 수 있다.
  이 기준을 `SESSION_WORKFLOW.md`의 정리 절에 반영했다.
- 메인세션의 실제 삭제 목록과 현재 웹 v1.89 대상 PR 9개 및 열린 PR 5개의 head/base를
  대조한 교집합은 0개다. 웹147개는 과거 PRD v1.88.0 반영을 다시 확인했고 앱7개도
  이전 운영 전달 작업이다. 별도 폐기 승인 frankieTemp4개는 출시 증명과 구분한다.
  삭제한 로컬 release/v1.88.0과 Lab 문서 공간도 현재 미출시 작업에 해당하지 않는다.
- **후속 브랜치 판단 정정:** PR #4706의 `codex/dl-16317-permission-followup`은
  release 기반 부분 수정·QA용 파생 브랜치다. 단순 develop 배포 중계는 아니며 실제 수정이 담겼다.
  최종 소스와 release 병합 결과의 전체 tree가 같고, 원본 `feature/DL-16317`은 복구됐으며
  최신 release worktree도 유지된다. 사용자 보존 의도는 원본 작업 브랜치이므로,
  이 파생 브랜치까지 잘못 삭제·필수 복구 대상으로 분류한 앞선 판단을 철회한다.
  후속 브랜치는 삭제 상태를 유지하며 추가 제품 변경은 하지 않았다.
- 이 재검증 결과를 타 세션의 모든 삭제가 적절했다는 보증으로 확대하지 않는다.
  담당 세션의 최신 복구·보존 상태는 [권한관리 정본](dentlink-permission-management.md)을 따른다.

## 이전 후속 정리 완료 — 2026-10-16 frankieTemp 백업 검토

- 사용자 요청으로 남아 있던 `frankieTemp/` 5개를 코드·과거 PR·현재 운영 소스와 비교했다.
  이번 삭제는 아래 사용자 확인에 따른 **대체 완료·불필요 실험의 폐기**이며,
  1차 정리의 운영 반영 검증 154개와 근거를 구분한다.
- 원격 4개를 추가 삭제했다: `version`(라이브러리 업그레이드는 다른 담당자가 대체 완료),
  `threeJsTemp`(3D 작업은 다른 곳에서 대체 완료), `DL-10132`(최근 Warranty 작업으로
  대체 적용 완료 및 과거 약관 초안 폐기 확인), `DL-4978`(모바일 채팅 포커스 실험 폐기 승인).
  원본 전체 코드가 그대로 출시됐다는 의미는 아니며, 이 과거 초안을 다시 할 일로 복원하지 않는다.
- **`frankieTemp/invoiceTemplete / 062ba4aeea1e0d33014bd1b126e6aa0f11f871d0`는 보존했다.**
  유사한 `Invoice-commercial.html` 견본은 있으나 실제 배송 UI는 서버가 준 문서 URL을 연다.
  사용자의 ‘비슷한 양식이 적용됐다면 삭제’ 조건을 확인할 근거가 부족하다. 최신 요청대로 추가 질문 없이 유지한다.
- 삭제 전 정확한 SHA·열린 PR head/base·worktree 미사용과 증분 Git bundle을 검증했다.
  삭제 후 원격 부재·invoice 백업 유지·다른 원격 ref/로컬 branch·worktree·태그·stash·checkout
  불변을 확인했다. 웹 원격은 272→268개이며 이번 로컬 브랜치/worktree 삭제는 없다.
- 복구용 bundle과 manifest는 웹 공용 Git 디렉터리의
  `codex-closeout/frankie-backup-cleanup-20261016/`에 있다. 정확한 SHA와 사유는
  [삭제 목록](dentlink-branch-cleanup-20261016.md)의 후속 절에 보존한다.
- **오늘 누계:** 로컬 브랜치 4개, worktree 1개, 원격 브랜치 158개(1차 출시 완료154 + 승인된 폐기4).
  제품 코드·PR·Jira·배포 변경은 없으며 개인 컨텍스트 정리 후 새 요청 전 대기한다.

## 이전 1차 정리 완료 — 2026-10-16 출시된 개인 브랜치·worktree

- 사용자 명시 요청에 따라 **실제 릴리스까지 완료된 본인 작업**만 정리했다.
  PR 작성자 `jongsunP`, 현재 원격 HEAD, squash/최종 전달본의 변경 보존, 운영 반영,
  열린 PR의 head/base 및 worktree 사용 여부를 대조하고 삭제 직전 SHA를 재확인했다.
- **로컬 브랜치 4개·worktree 1개·원격 브랜치 154개 삭제**, 삭제 후 서버·로컬 ref 재조회 완료.
  정확한 브랜치명·SHA·PR·보존 공간은 [삭제 및 보존 목록](dentlink-branch-cleanup-20261016.md)에 있다.

| 저장소 | 로컬 브랜치 삭제 | worktree 삭제 | 원격 브랜치 삭제 | 남은 로컬 브랜치 / worktree |
| --- | ---: | ---: | ---: | ---: |
| 웹 `dentlink-client` | 1 | 0 | 147 | 9 / 5 |
| 치과 앱 `dentlink-app` | 0 | 0 | 1 | 2 / 2 |
| 기공소 앱 `dentlink-lab-app` | 3 | 1 | 6 | 1 / 1 |

- 웹 로컬은 오래된 `release/v1.88.0`만 삭제했다. 기본 checkout은 Billing의
  `feature/DL-16796 / 3aac1dff` 그대로다. 웹 PRD v1.88.0 `951503d4`의 Admin·Clinic·Lab
  Actions 38228924416·38228730049·38228870317 성공과 삭제 후보의 반영을 확인했다.
  웹 원격 147개에는 출시된 전체 패치와 동등한 develop 파생 3개가 포함된다.
- 기공소 앱은 두 `feature/lab-i18n-workflow*`와 local-only DL-16652 backup을 삭제했고,
  문서용 `dentlink-lab-app-i18n-release` worktree를 제거했다. 기본 checkout을
  최신 `main / bb619010`으로 fast-forward했으며 이제 main 하나만 남았다.
- 치과 앱은 출시된 `feature/DL-16652` 원격만 삭제했다. local main은 `a32aa691`,
  origin/main보다 18커밋 뒤인 기존 상태를 유지했고 권한관리 worktree는 보존했다.
- **보존:** 권한관리·LBX·DLDS·Billing의 미출시 작업과 관련 검토 공간, 타인 브랜치,
  공용 main/master/develop/stage/release, 최신 변경의 출시 여부가 불명확한 파생 브랜치.
  release/develop 병합을 운영 출시와 같게 보지 않는다. 태그와 기존 stash도 보존했다.
- 남은 8개 worktree는 모두 tracked/untracked clean이다. 웹은 삭제 예정 147개 외 원격 ref의
  삭제·SHA 변경이 없음을 전후 비교했다. 제품 코드·PR·Jira·배포는 변경하지 않았다.
- 삭제 전 검증한 bundle과 manifest는 각 저장소의 공용 Git 디렉터리
  `codex-closeout/released-branch-cleanup-20261016/`에 있다. 웹 bundle은 보존된 master 이력에
  의존하는 증분 백업이고 앱 bundle은 독립 백업이다. bundle은 현재 디바이스에만 있으며
  개인 컨텍스트의 삭제 목록·PR 이력과 구분한다.
- 중복된 기능별 전달 이력은 정본 링크로 줄이고 HANDOFF·PROJECTS·아래 기능 색인의
  오래된 대기 상태를 정정했다. Billing PR #4699는 release/v1.89.0 병합 완료로 갱신했다.
  재개 요청 전 추가 정리·작업·자동 모니터링은 하지 않는다.

## 이전 공통 전달 — 2026-10-08~12 웹·앱 릴리스

- 웹 release/v1.88.0의 stage 전달, Lab Production v13/1.0.4와 main→develop 동기화,
  사용자 앱 확인 및 기능 종료를 완료한 이력이다. PR #4677·#4687과 stage 복구 ref,
  플랫폼별 배포·검증 경계는 [DL-16652 정본](dentlink-patient-list-design.md)에 보존한다.
- Lab 번역 지침은 [문서 전달 정본](dentlink-lab-app-i18n.md)을 따른다. 기능별 상세 QA·SHA·
  중간 PR 대기 기록의 중복은 이 조율 문서에서 걷어냈으며 과거 Git 이력에도 남아 있다.
- 아래 날짜가 붙은 접수·보존·전달 기록은 당시 이력이다. 현재 branch/worktree와 진행 상태는
  가장 위의 최신 정리 기록 및 각 기능 정본을 우선한다. 완료된 기능을 자동 재개하지 않는다.

## Scope

- Web/Admin repository: `/Users/parkjongsun/Repository/dentlink-client`
- Office app repository: `/Users/parkjongsun/Repository/dentlink-app`
- Lab app repository: `/Users/parkjongsun/Repository/dentlink-lab-app`
  (https://github.com/Innvoaid/dentlink-lab-app)
- 2026-10-06 사용자 확정: 앱은 최근 Office/Lab 저장소로 분리됐다. 앞으로 앱 업무는
  제품을 먼저 구분하고 [Office 앱](dentlink-app.md) 또는 [Lab 앱](dentlink-lab-app.md)의
  정본과 실제 Git을 확인한다. 웹 반응형과 네이티브 앱 적용도 구분한다.
- Durable context: `/Users/parkjongsun/Repository/codex-personal-context`
- Active AI workflow: Codex only. The remote `claude-personal-context`
  repository is retained only as an archive and is not loaded by default.

## 앱 개발자 전달 프로세스 — 2026-10-12 참고·합의 대기

- 사용자 제공 앱 개발자의 일반 개발·핫픽스 흐름을 [앱 온보딩 정본](dentlink-app-onboarding.md)에 보존했다.
  일반 개발은 develop 기준 feature→release→QA→release→main(CodePush)→develop 최신화,
  핫픽스는 main 기준 hotfix→main(CodePush)→release·develop 최신화다.
- 원문의 ‘별도 조율 전 참고만’ 조건을 유지한다. 기존 2026-10-08 확정 지침과 다른 PR 대상·최신화 경로는
  자동 대체하지 않으며 앞으로 앱 업무 계획에서 함께 확인한다. 이번 작업은 개인 지침 저장이며 제품·PR·배포는 변경하지 않았다.

## 앱 release·제품별 Jira 정책 — 2026-10-08 기존 확정 지침

- 사용자가 같은 날 후속 정정했다. **일반 앱 feature PR은 `develop`에 모으며, release는 QA·배포 단계**다.
  이전 release 기본 대상 해석을 대체한다. 기존 release 전달은 유지하고 필요한 변경을 release→develop PR로 동기화한다.
  기존 앱 PR 정리에서 broad foundation 선행안도 이미 폐기했다.
- 같은 바이너리의 호환 CodePush마다 release를 새로 만들지 않는다. feature 시작 기준·PR 대상과
  Git 태그·OTA 업로드/활성화/설치·스토어 심사/출시는 별도 판단·상태로 관리한다.
- 승인된 업무 접수에서는 웹·치과 앱·기공소 앱의 영향을 구분하고, 해당 제품별 카드를 재사용하거나
  없으면 생성한다. 영향 없는 제품의 빈 카드는 만들지 않는다. 공통 요구를 연결하되 제품별 완료를 구분한다.
  카드 분리는 세션/폴더/worktree 분리를 강제하지 않으며 상위 댓글은 사용자 명시 요청이 필요하다.
- 사용자 제공 APP 온보딩·참고 링크 21개와 확인 가능한 하위 문서를 실제 Git·스크립트와 대조했다.
  분리 전 문서·폐기된 정책·미해석 객체와 실제 배포 증거를 구분한다.
  상세 전략과 출처·조회 한계는 [앱 온보딩 정본](dentlink-app-onboarding.md)에 둔다.
- 최초정책조사에서 Lab #2·#3은 분리 전release 대상으로 전체diff가 확대돼 있었다.
  이후 #6 기능20파일·#5 문서3파일로 대체해 요청한 작업만 전달하도록 정리했다. 최초조사에서는 제품 변경이 없었다.
- 사용자 승인으로 Office [#321](https://github.com/Innvoaid/dentlink-app/pull/321)과
  Lab [#9](https://github.com/Innvoaid/dentlink-lab-app/pull/9)의 release→develop 동기화 PR을 생성했다.
  이후 GitHub에서 두 PR의 `jongsunP` 병합을 확인했다. 메인은 생성까지만 실행했고 병합·배포는 실행하지 않았다.
  사용자는 이후 진행을 다른 세션에 맡기고 여기서는 지침만 수정하도록 정정했다. 이미 수행된 작업은 유지한다.
  상세 이력은 제품별 체크포인트에 두며 추가 제품 작업을 자동 재개하지 않는다.

## Session Ownership

- 메인세션은 항상 Dentlink FE 전체를 감독·조율하는 최상위 세션이다.
  신규 업무 접수, 웹·앱 영향 범위, 공통 결정·우선순위, 진행 상태,
  release·배포 단계, 구현 세션 인계와 마무리를 관리한다.
- Git-backed `codex-personal-context`를 관리하며 세션 간 결정·진행 기록을
  정제·동기화한다. 상세 이력은 기능별 문서에, 공통 결정과 조율 상태는 이 문서에 둔다.
  의미 있는 정리 시 개인 컨텍스트를 커밋·푸시한다.
- 필요한 경우 프로젝트 폴더와 세션의 설정·연결·이동·정리를 맡는다.
  실제 폴더, 앱의 표시 이름·연결 경로, 기존 세션 소속·실행 경로를 각각 확인하고
  기존 세션 이력과 진행 중인 제품 작업을 보존한다.
- 메인세션의 폴더는 `/Users/parkjongsun/Documents/ChatGPT/메인 프로젝트`다.
  개인 조율·자료용 폴더이며 전용 제품 저장소나 worktree를 연결하지 않는다.
  위 상시 역할은 2026-09-28 사용자가 재확인한 운영 원칙이다.
- Sessions are created primarily for a feature or responsibility, not for a
  device or repository. One feature session may inspect and implement both its
  web and app portions across the relevant separate product repositories.
- Every code or Git mutation must still name and confirm the exact product
  repository, branch, and worktree. A shared feature scope does not combine Git
  histories or permit writing from an ambiguous directory.
- 2026-10-06 사용자 지침: 구현은 작은 작업도 별도 기능 세션이 기본이며,
  메인세션은 접수·분류·조율·마감을 맡는다. 짧은 작업은 현재 폴더에서 세션만,
  규모가 있고 여러 차례 이어갈 작업은 전용 폴더·worktree·세션으로 분리한다.
  판단이 불명확하거나 작업 충돌·필수 결정이 있을 때만 사용자에게 확인한다.
  상세 운영 정본은 [SESSION_WORKFLOW.md](../SESSION_WORKFLOW.md#new-work-intake-and-session-routing)이며,
  메인세션 직접 구현은 사용자가 선택하는 예외다. 기존 작업 이력은 이 지침으로 재배치하지 않는다.
- 2026-10-06 사용자 추가 지침: 새 작업 세션은 별도 지정이 없으면 메인세션과 같은
  모델·추론 수준을 명시하고 실제 적용값도 확인한다. 같은 설정을 사용할 수 없으면
  사용 가능한 최고 등급을 선택하며, 상세 정본은
  [모델·추론 기본값](../AI_WORKFLOW.md#new-session-model-and-reasoning-default)이다.
- Keep one active writing session per worktree. Repository main-checkout
  sessions are optional helpers for branch/worktree/release administration,
  not permanent web-versus-app session boundaries.
- Shared repository mutations still require the user's explicit authorization.
- 웹 신규 작업의 기준은 최신 `origin/master`로 확정돼 있다. Jira 예정 릴리즈나
  현재 checkout이 release라는 이유로 master 기준을 다시 묻지 않는다. 해당 release에
  이미 반영한 작업의 후속 수정·QA만 release 기반 예외이며, 상세 정본은
  [브랜치 전략](../SESSION_WORKFLOW.md#dentlink-release-train-branch-strategy)을 따른다.

## 기공소 번역 작업의 기본 범위 — 2026-10-06

- 승인된 기공소 작업에서 정적 UI 문구가 바뀌면 i18n 리소스·운영 스프레드시트
  반영·검증까지 한 작업으로 처리하며 신규 기능 세션 프롬프트에도 포함한다.
- 웹 Lab과 Lab 앱의 시트·생성 절차는 다르다. 상세는 [웹 i18n](dentlink-client-i18n.md)과
  [Lab 앱](dentlink-lab-app.md)에 두고 공통 정본은
  [SESSION_WORKFLOW.md](../SESSION_WORKFLOW.md#dentlink-lab-translation-work)를 따른다.
- 시트 쓰기·PM 검토·재생성·검증 완료를 각각 구분하며, 필요한 인증·검토가 없으면
  미완료로 남긴다. 이번에는 기존 절차 확인과 개인 지침 저장만 했으며 실제 번역·시트는 변경하지 않았다.
- 사용자 후속 승인으로 웹 공통 에이전트 진입점·스킬·운영 가이드 7개 파일에 지침을 반영하고
  [PR #4666](https://github.com/Innvoaid/dentlink-client/pull/4666)을 `release/v1.88.0` 대상으로 생성했다.
  2026-10-07 CodeRabbit의 동시 시트 편집 지적 1건을 운영 지침에 반영하고 HEAD `67e95af9f`를 푸시했다.
  타입·필수 push 검사 통과와 최신 커밋의 CodeRabbit 재리뷰 완료·미해결 0건을 확인했다.
  사용자가 11:37 KST에 squash 머지했으며 `dd9f1f544`의 release 반영과 지침 7개 파일 일치를 확인했다.
  전용 worktree·로컬 feature를 정리하고 원격 feature는 보존했다. 실제 배포·master 반영과 구분한다. 상세는
  [웹 i18n 정본](dentlink-client-i18n.md)에 두고 앱 팀 지침 변경과 구분한다.
- 2026-10-08 최초 사용자 승인으로 Lab 앱의 팀 지침도 직접 반영하고
  [앱 PR #3](https://github.com/Innvoaid/dentlink-lab-app/pull/3)을 최초 `develop` 대상으로 전달했다.
  앱 README·AGENTS·CLAUDE 3개 문서, `5844ba5` push·자동 검사 SUCCESS·미병합이다.
  이후 release에서 문서만 옮긴 #5로 대체하고 #3을 닫았다. 최신 대상/범위는 앱 i18n 정본을 따른다.
  실제 번역·시트·실행 코드는 변경하지 않았다. 상세는
  [앱 i18n 전달 기록](dentlink-lab-app-i18n.md)에 두고 웹 release 상태와 분리한다.

## DL-16655 신규 세션 전달 — 2026-10-08

- 치과 웹 주문목록 Product·Patient 아이콘/글자 정렬 QA 요청이다. Jira 본문·첨부 존재를 확인하고
  기존 메인 프로젝트 폴더에 **DL-16655 치과 주문목록 아이콘·텍스트 정렬** 세션을 만들었다.
- 세션 `01a11939-5a8c-7973-a2b4-9e47ce3accc1`, 기본 웹 checkout을 사용하며 새 폴더·worktree는 없다.
  메인과 같은 `gpt-6.1-sol / ultra`를 명시했고 생성된 세션 메타데이터에서 실제 적용을 확인했다.
- 요구·첨부·live Git 대조 후 이해되지 않으면 해당 세션 사용자에게 먼저 질문하도록 전달했다.
  수정·검증과 제품 Git 전달 권한을 구분하며 메인세션으로 진행·완료 메시지를 보내지 않는다.
  구현의 최신 상태는 작업 세션과 그 개인 체크포인트를 따른다. 메인세션은 이번 전달만 기록했다.

## DL-16652 기공소 환자목록 디자인·API 대응 — 최초 전달·QA 이력

- 10월 8일 재점검: 세 feature HEAD와 Figma/댓글/신규 번역 시트 값은 기존 구현과 동일하다.
  웹 #4665는 사람 승인 APPROVED지만 현재 Draft이며 임의 전환/병합하지 않는다. Vercel 프리뷰 차단은
  required merge check가 아니다. Lab #2·Office #318은 OPEN/non-Draft/MERGEABLE/CLEAN이다.
- 실제 DEV API는 신규 계약 770명, STG 실제 API는 이전 계약 694명이다. STG Swagger는 조회하지 않았다.
  STG/운영 API 선배포 확인 후 UI 배포가 필요하며 현재 배포 완료로 보고하지 않는다.
- DeviceHub 연결 회복 뒤 Lab iOS 실제 목록·검색·최근 주문 이동과 별도 합성 카드 검증을 마쳤다.
  Office iOS 정상 로그인/지정 QA 그룹/홈/가시 주문 목록까지 확인했으나 실제 Remake는 미검증이다.
  앱 PR 본문과 Jira 44341에 새 결과/남은 조건을 반영했고 두 own sim/Metro/임시 env를 정리했다.
  제품 소스 수정은 없고 상세 결과/남은 조건은 아래 기능 정본에 둔다. 병합·배포·Draft 전환은 하지 않는다.

- 사용자 요청으로 기존 메인 프로젝트 폴더 안에 **DL-16652 기공소 환자목록 디자인 변경**
  세션 `01a11038-d621-7fb3-ad4e-58d01fbb9a6a`(local)을 생성하고 확정 요구와 작업 공간을 자동 전달했다.
  환자 목록 대상은 **웹 Lab과 기공소 네이티브 앱**이며, 이후 전역 Remake 확정으로
  Office 앱에는 Remake 배지만 추가 적용했다.
  생성 설정은 메인과 같은 `gpt-6.1-sol / ultra`이며 실제 실행 메타데이터에서도 확인했다.
- 웹 `origin/master`와 새 Lab 앱 `origin/develop`에서 각각 `feature/DL-16652`
  worktree를 준비했다. 기존 작성 세션의 checkout을 전환하거나 변경하지 않았다.
- 최종 Figma와 구두 확정(카드 내부12px·모든 Remake 배지 변경)을 적용하고 DEV 배포 계약을 대조했다.
  주문목록처럼 최근 주문 상태·상세 상태와 `isRemake`를 별도로 표시한다.
  이번 표는 해당 화면 전용이며 기존 공통 테이블 변경·공식 디자인시스템 편입은 하지 않는다.
- 상위 DL-16596은 참고 관계이며 기존 타기공소 가드 PR과 별도 작업이다.
  DEV 새12필드는 실제 응답으로 확인했고 STG 실제 endpoint는 이전 계약이다. STG Swagger는 제외한다.
- 진행 결과는 기능 세션과 [개인 정본](dentlink-patient-list-design.md)에 둔다.
  사용자 지시에 따라 메인세션으로 자동 진행·완료 메시지를 보내지 않는다.
  이후 사용자 승인으로3제품 commit/push·PR까지 완료했다. 웹
  [#4665](https://github.com/Innvoaid/dentlink-client/pull/4665)→release/v1.88.0, Lab 앱
  [#2](https://github.com/Innvoaid/dentlink-lab-app/pull/2)·Office 앱
  [#318](https://github.com/Innvoaid/dentlink-app/pull/318)→develop. merge/배포는 하지 않았다.
  4시간 예약 확인은 취소돼 heartbeat PAUSED다. 새 번역 양 시트 반영 완료, 실기QA·STG·Vercel 접근
  및 기존 번역 차이/CLI scope 한계는 기능 정본에 기록했다. 현재 HEAD/QA는 위 정본을 live 대조한다.
- 23시 재점검에서 웹 pagination 스타일 리뷰를 수정·푸시(`1c8298079`)했고 CodeRabbit 실제 검토
  SUCCESS·미해결0개를 확인했다. 최신 Figma 앱 Remake 문구도 primary600으로 변경돼 두 앱을
  최소 보정·푸시했다. STG 실제 응답은 이전 계약이어서 새 API 선배포 후 UI 배포 조건을 PR에
  명시했다. 웹 Vercel 차단은 계속되며 사람 리뷰·병합·배포 대기와 구현 완료를 구분한다.
- Lab Android 실데이터 검색/최근 주문 이동과 합성 긴문구·Remake·KO/EN/눌림 QA를 완료했고
  실제 기기에서 발견한 count 줄바꿈/잘림을 `14949c6`으로 추가 보정했다. Office는 own immutable
  의존성을 설치해 기존 로컬 불일치를 해소하고 정상 새APK 빌드·로그인/목록·iOS bundle을 확인했다.
  Office 실제 Remake 사례는 가시0건으로 미검증이다. 최신 head/한계는 기능 정본·Jira44302에 기록했다.
- 10월7일 자율 재점검에서 추가 디자인/리뷰 수정은 없었다. 두 앱의 잠금 버전 독립 Pods를 준비해
  정식 iOS Debug 빌드·새 시뮬레이터 설치/실행·미인증 초기 안내 렌더까지 확인했다.
  로그인 이후 iOS UI는 Xcode27 DeviceHub 자동 제어 연결 제한으로 미검증이며 임시 환경은 정리했다.
  STG 실제 API00:36은 이전 형식, 웹 Vercel·사람 리뷰는 대기다. Jira44303/기능 정본에 확인 결과와
  불가 사유를 기록하고 추가 수정·예약 재점검·미승인 병합/배포 없이 외부 조건 해소까지 대기한다.

## DL-16596 타기공소 주문 조회 가드 세션 — 2026-10-06

- **사용자 재검토에 따른 정정 구현·검증·PR 전달 및 임시 worktree 정리 완료.** 상세 정본은
  [타기공소 주문 조회 가드](dentlink-client-other-lab-guard.md)다.
  [PR #4663](https://github.com/Innvoaid/dentlink-client/pull/4663)는
  `feature/DL-16596` → `release/v1.88.0`, head
  `e112d12c098d6231a6200110b9fc3a7074a2ae8d`이며 Lab 5개 파일만 포함함을 live 조회로 확인했다.
  master 구현 후 무관한 변경을 제외한 release 전달 브랜치를 사용했다.
  사용자 요청으로 최신 브랜치 이름을 `feature/DL-16596`으로 통일하면서 이전
  [PR #4662](https://github.com/Innvoaid/dentlink-client/pull/4662)는 미병합 종료됐다.
  동일 HEAD·5파일·release 대상으로 대체 PR을 생성했으며 제품 코드 추가 변경은 없다.
- 최초 구현의 디자인 승인 소유 조건·모달 제한·추가 주문 조회는 요구 범위 밖 변경으로
  정정됐다. 최종 범위는 타기공소 extra-fee GET·채팅 읽음 POST 차단이며,
  채팅·디자인 데이터 조회와 기존 승인 흐름을 유지한다. 이전 승인 제한을 확정 요구로 재사용하지 않는다.
- 담당 세션은 Clinic/Lab/Admin 타입·필수 push 검사·공유 테스트 53개 및 실제 로컬 Lab/fixture
  정정 검증 통과를 보고했다. 로컬 샘플 파일 목록·이미지 미리보기·기존 승인 모달도 확인했지만,
  실제 STG 디자인 파일 접근·사용자 QA·release 통합 QA는 남았다.
  담당 하위 [DL-16640](https://innovaid.atlassian.net/browse/DL-16640)은 최종 설명과
  `Ready for Deploy` 상태를 live 확인했다. 이 상태는 병합·배포 완료를 뜻하지 않는다.
  PR은 `OPEN`, 미병합·최종 리뷰 필요다. 확인 시 CodeRabbit은 `PENDING`이며,
  Vercel은 작성자 `jongsunP`의 프로젝트 접근 권한 부족으로 preview 생성에 실패했다.
  PR 생성 완료를 리뷰·merge·배포 완료로 확대하지 않는다.
- 임시 worktree 경로와 등록이 제거됐고 원격 PR head가 보존돼 있음을 live 확인했다.
  담당 세션은 QA 탭·3116/3117 서버 정리도 보고했다. 초기 로컬 구현 브랜치를 제거하고
  최신 전달 브랜치를 로컬·원격 모두 `feature/DL-16596`으로 통일했으며 upstream도 확인했다.
  정정·정리된 담당 상세 기록은 개인 컨텍스트 `67578a4`에 보존됐고 메인세션이 이 색인을 연결한다.
- 사용자가 [DL-16596](https://innovaid.atlassian.net/browse/DL-16596)의 웹 구현·검증을
  별도 세션에 맡기도록 지시했다. 범위는 타기공소 주문의 extra-fee 조회·채팅 읽음
  요청 차단, 디자인 컨펌 이력 조회, HTTP 403 + code 1018의 서버 메시지 빨간색 표시 가드다.
  Jira 하위 DL-16597·DL-16598·DL-16634·DL-16640과 서버/FE 역할은 담당 세션에서 대조한다.
- 기존 `메인 프로젝트`에 **DL-16596 타기공소 주문 조회 가드** 세션
  `01a10f22-340a-7703-b5e6-2fc0d0f313cd`(local)를 생성하고 요청·근거·코드 조사 결과를
  자동 전달했다. 새 프로젝트 폴더는 만들지 않는다.
- 기본 checkout의 MEDIT 작성 세션과 충돌해 사용자에게 작업 공간을 확인했고,
  **임시 worktree로 병행한 뒤 작업 완료 시 정리**하도록 승인받았다. 원격 갱신 후
  최신 `origin/master / 6b79c9756cc56313fe833aad463bddb1f8c385fa`에서
  `feature/DL-16596`, `/Users/parkjongsun/Repository/dentlink-client-other-lab-guard`를 준비했다.
  인계 시 clean·기준 대비 0/0, upstream·원격 feature·PR 없음이다. 활성 작성자는 신규 세션 하나다.
- 확정 경로를 전달하고 구현·검증 진행을 지시했다. 이후 사용자가 완료 시 제품
  **commit·push·`release/v1.88.0` 대상 PR 생성**까지 명시 승인해 담당 세션에 전달했다.
  `origin/master` 구현 기준과 release 전달 대상을 구분하며 관련 없는 변경의 포함 여부를 검증한다.
  merge·환경 branch 변경·배포는 승인되지 않았다. 완료 후 유일한 변경·자료의 보존과 실행 프로세스를 확인해
  임시 worktree를 정리하며, 기존 MEDIT·DLDS·권한관리 checkout을 섞거나 삭제하지 않는다.

## DL-16615 MEDIT TAT 수정 세션 접수 — 2026-10-06

- 최신 전달 상태: [PR #4660](https://github.com/Innvoaid/dentlink-client/pull/4660)은
  **10/7 `release/v1.88.0` 병합 완료**이며 팀 승인·CodeRabbit 검토 완료·미해결 0개다.
  **10/12 사용자가 확인까지 모두 완료됐다고 보고했고, Jira 완료 상태도 재확인해 작업을 종료했다.**
  로컬 `feature/DL-16615`는 원격·squash merge의 동일 결과를 검증한 뒤 삭제했다.
  기본 checkout은 clean master이며 원격 feature·PR과 다른 진행 중 worktree는 보존한다.
  이 기능의 임시 worktree·임시 파일은 없다. 사용자 요청에 따라 현재 기능 세션을 보관한다.
  상세 이력·검증·다음 시작점은 [Medit TAT 체크포인트](dentlink-client-medit-tat.md)를 따른다.

- 사용자 요청에 따라 새 폴더 없이 기존 `메인 프로젝트`에
  **DL-16615 MEDIT TAT 수정** 세션을 생성했다.
  세션 ID: `01a10eae-2ff7-7b43-a9e2-11a3b93cc782`, host: `local`.
- [Jira DL-16615](https://innovaid.atlassian.net/browse/DL-16615)는 상위 DL-16613
  “스캐너 주문 수정 사항”의 하위 작업이며 접수 시 “해야 할 일”, fixVersions 미지정이다.
  본문은 [Notion Medit TAT](https://app.notion.com/p/innovaid/Medit-TAT-3ecce072e82f80bca54ffcb137f57c97)로
  연결된다. 10월 2일 Jira 댓글에서 Notion 댓글 확인을 요청했으므로 본문과 댓글 모두
  실제 코드와 대조하도록 전달했다. 과거 release 기준을 이번 작업에 자동 적용하지 않는다.
- 사용자는 DL-16613의 예정 v1.89.0과 release 브랜치 부재가 DL-16615의 구현 기준에
  영향을 주지 않는다고 확인했다. 신규 작업이므로 최신 `origin/master`에서
  `feature/DL-16615`를 준비하는 기준을 재질문하지 않는다. 예정 배포 대상과 구현 기준은 별개다.
  사용자가 신규 세션에 직접 응답해 전달했으므로 메인세션에서는 중복 메시지를 보내지 않는다.
- 시작 프롬프트는 자동 전달됐으며 개인 컨텍스트·Git·요구사항 확인을 시작한 상태를
  확인했다. 제품 구현·검증 완료를 뜻하지 않는다. 메인세션은 제품 코드·branch·PR을
  변경하지 않았으며 상세 조사·작업 진행은 신규 세션이 담당한다.

## 웹 E2E 계정·문서 정리 완료 — 2026-10-01

- 사용자는 DEV/STG별 E2E Clinic·E2E Lab 한 쌍씩, 총 고정 그룹 4개를 유지하고
  매핑을 이전하는 방향에 따라 정리 완료를 보고했다. 상세 그룹 ID·계정 역할·
  임시 치과 정책은 [E2E 정본](dentlink-client-e2e.md)의 최신 절을 따른다.
- 사용자 확인 결과 **STG 전체 성공**, **DEV는 다른 개발자의 진행 중인 ISV 변경에
  따른 ISV 실패만 존재**한다. 사용자 판단에 따라 오늘 계정·문서 정리는 완료로 처리한다.
  해당 ISV 변경이 master에 반영되면 E2E 정합성을 다시 확인하는 후속 사항으로 남긴다.
- 조사 중 발견한 픽업 대상 선택 문제는 미수정 별도 사항이며 이번 완료 범위를
  자동으로 확장하지 않는다. 상세 검증 한계·후속 시작점은 E2E 정본을 따른다.
- 제품 E2E 문서·스킬 정비는 별도로 승인됐다. 이번 제품 변경은 `release/v1.88.0`에서 신규 브랜치를
  만들어 커밋·푸시하고 같은 release로 PR을 제출한다. 상세 작업 위치·검증·PR은
  [E2E 정본](dentlink-client-e2e.md)의 최신 절을 따른다.
- 문서·스킬·구 준비 스크립트 주석 정정은
  [PR #4648](https://github.com/Innvoaid/dentlink-client/pull/4648)로 전달했다.
  `feature/e2e-group-guide` → `release/v1.88.0`, 현재 CodeRabbit 상태는 성공이며
  최종 승인·병합은 대기 중이다. 사용자 QA 완료와 PR 병합 상태를 구분한다.
- 문서 작업용 `dentlink-client-e2e-docs` worktree와 로컬 `feature/e2e-group-guide`는
  사용자 지시에 따라 정리했다. 동일 커밋을 가진 원격 브랜치와 PR #4648은 보존하며,
  기본 checkout과 진행 중인 DLDS worktree는 유지한다.

## 피드백 요구사항 외 UI 정리 완료 — 2026-10-01

- 사용자 승인 범위의 피드백 UI 4곳을 정리한 [PR #4642](https://github.com/Innvoaid/dentlink-client/pull/4642)가
  `release/v1.88.0`에 병합됐다. [완료 기록](dentlink-client-ui-requirements-audit.md)을 따른다.
- 작업용 로컬 `feature/ui-requirements-audit`는 삭제했고 기본 checkout은 `master`로
  복귀했다. LBX 로컬·원격 브랜치는 보존하며 보류 상태를 유지한다.
- 확인되지 않은 요구사항을 임의로 보완하지 않는 공통 지침은
  AGENTS/DEVELOPMENT_STYLE에 반영돼 있다.
- 디자인시스템정비세션은 사용자 수동 QA의 “전체적으로 괜찮아 보임” 결과를 접수하고,
  재개 승인 후 Password E2E 선택자 수정·16건 재검증과 조사 자료5개 정리를 마쳤다.
  다음은 AI 프롬프트·하네스 논의이며 구현은 미착수다. 상세와 남은 확인 범위는
  [DLDS 정본](dentlink-fe-opportunities.md)을 따른다.
- 아래 기기 복구 표의 QA 대기 상태는 이번 보고 전 저장 시점의 기록이다.

## 다른 기기에서 이어가기 — 2026-10-26 색인 갱신

- 신규/다른 기기의 첫 대화는 아래 개인 정본에서 현재 업무를 복구한다.
  기존 권한관리·Billing·env 세션은 완료/보관 상태다. 메인·LBX·디자인시스템정비·통합알림센터 세션을 유지하고 DL-17012·DL-17011을 별도 새 세션에서 조사한다.
  통합알림센터는 미착수·대기 상태다. 웹은 기본 master와 새 DLDS detached worktree가 있으며, 신규 조사 2건에는 별도 worktree를 만들지 않았다.
  상세 근거와 후속의 승인 경계는 각 정본을 따른다.

| 기능 | 현재 단계 | 개인 정본 |
| --- | --- | --- |
| 권한관리 | 업무 완료·세션 보관, 웹/Office/리뷰 worktree 제거. 앱 원본 refs/검증 한계 보존 | [권한관리](dentlink-permission-management.md) |
| LBX | 최신 master 기반 로컬 f389c13cf 준비·검증 완료, 세션 유지. 원격은 옛 원본·운영 홀드 | [LBX](dentlink-client-lbx.md) |
| 디자인시스템정비 | 최신 master 기반 새 detached worktree 준비 완료. branch/구현 없이 대기 | [DLDS](dentlink-fe-opportunities.md) |
| DL-17012 기공소 앱 우선순위 | 기존 메인 프로젝트의 신규 세션에서 조사·추천안 작성 시작. 제품 구현 아님 | [모바일웹·앱 비교](dentlink-mobile-web-app-parity.md) |
| DL-17011 관리자 회원 권한 QA | 신규 세션에서 과거 구현/병합/배포 이력과 현재 요구사항 조사. 구현 전 사용자 보고 | [권한관리](dentlink-permission-management.md) |
| Billing Statement | PR4699 운영 포함·원본 refs 정리·세션 보관, 추가 작업 없음 | [문서 명칭 변경](dentlink-client-billing-statement.md) |
| 통합알림센터 | 이번 정리 대상에서 제외·세션 유지. 사전 조사 후 미착수·재개 지시 대기 | [통합알림센터](dentlink-unified-notification-center.md) |
| 웹 환경변수 관리 | 운영 반영·기본 저장소 로컬 준비 완료. 전용 worktree 제거·세션 보관 | [환경변수](dentlink-client-env-management.md) |

- 2026-09-29 최초 개인 기록의 원격 보존 확인: 권한관리 `f778f98`, LBX `976d93b`, DLDS
  `b2d428c`, 통합알림센터 `a5f2883`. 제품 코드의 commit·push를 이번 기록 작업에서
  실행한 것이 아니다. Git/PR/검증·배포의 상세 근거와 한계는 위 기능별 정본에 둔다.
- 새 기기에서는 개인 컨텍스트 clone/pull → `BOOTSTRAP.md`의 초기 설정·공통 지침
  → `PROJECTS.md`/`HANDOFF.md` → 이 표의 해당 정본 순서로 읽는다. 기존 대화나
  Codex 프로젝트가 없어도 저장된 목적·결정·진행 상태·남은 일·다음 시작점을 복구한다.
- 문서를 읽는 것만으로 제품 pull·구현·QA·서버 실행이나 보류 해제를 승인하지 않는다.
  각 기능의 재개 조건과 실제 사용자 지시를 먼저 확인한다. 구현 재개 시에는 그 기기의
  정확한 제품 저장소·branch·HEAD·dirty·worktree 소유권과 최신 원격 상태를 대조한다.
- 실제 폴더/앱 등록/세션 ID/대화 전체는 자동 복원되지 않는다. 아래 절대 경로는 현재
  기기의 배치 참고값이다. 인증·로컬 전용 환경파일·의존성·서버·미추적 산출물은 별도
  준비 대상이며, Git 추적 제품 파일·회귀 테스트·검증 요약과 구분한다.
  LBX의 과거 `/tmp` 원본 부재 등 알려진 제약도 각 정본에 기록했다.
- 앞으로도 의미 있는 상태 변화는 담당 정본에 정리·원격 보존하고, 메인세션은 색인과
  공통 결정을 관리한다. 여러 세션이 동일 개인 컨텍스트 checkout을 사용할 때는
  읽기 확인은 병행할 수 있지만 파일 수정·stage·commit·push 차례는 조율한다.

## 프로젝트 폴더 정렬 — 2026-09-28

- 사용자가 디바이스 폴더와 앱 프로젝트의 연결 경로를 수동으로 정리했다.
  아래 다섯 실제 디렉터리와 기존 세션의 프로젝트 소속을 live 조회로 확인했다.
  공통 상위 경로는 `/Users/parkjongsun/Documents/ChatGPT`다.

| 폴더 | 기존 세션 | 프로젝트 ID |
| --- | --- | --- |
| `메인 프로젝트` | 메인세션 | `4a13e754-960d-4ca3-b716-8f7a19311b64` |
| `권한관리 프로젝트` | 권한관리세션 | `52bd24fb-ff53-41fb-a9df-f074b3e608ec` |
| `통합알림센터 프로젝트` | 통합알림센터세션 | `1e576f21-c172-461f-8580-ff4be7fa6810` |
| `LBX 프로젝트` | LBX세션 | `5daeeb0b-4d4a-4f10-83c1-8ad41fe934ab` |
| `디자인시스템정비 프로젝트` | 디자인시스템정비세션 | `a047bc64-579f-4993-ab3e-1526d8f47f39` |

- 앱 표시 이름은 조회 당시 위 폴더명 뒤에 각각 ` 폴더`가 붙어 있다. 표시 이름과
  디바이스 경로는 별도 값이며, 실제 연결 경로는 위 표와 일치한다.
- **기존 세션의 기록된 cwd는 자동 변경되지 않았다.** 메인·LBX·디자인시스템은
  옛 `FE`, 권한관리는 `권한관리 프로젝트 폴더 2`, 통합알림센터는 옛
  `통합알림센터`가 남아 있다. 옛 디렉터리는 없으며 이 메인세션에서도 workdir을
  생략한 명령은 경로 없음으로 실패했다. 새 `메인 프로젝트`를 명시하면 실행된다.
  재개 시 각 세션은 새 컨텍스트 폴더 또는 정확한 제품 checkout을 절대 경로로
  명시한다. 프로젝트 이동만으로 기존 cwd까지 갱신됐다고 보고하지 않는다.
- 폴더는 개인 세션·자료용이다. 웹·앱 제품 저장소와 DLDS worktree는 이동하거나
  합치지 않았고 제품 코드·Git 상태를 변경하지 않았다. 기존 세션 이력을 유지하며
  이 정리로 권한관리 분석이나 다른 기능 구현을 재개하지 않는다.
- 권한관리 `START_PROMPT.md`와 현재 경로를 가리키는 개인 문서를 갱신했다.
  아래 과거 체크포인트의 옛 폴더명은 당시 이력으로 보존한다.

## 로컬 환경·메모리 정리 — 2026-09-28

- **후속 DLDS:** 아래 환경 정리 이후 사용자의 재개 요청으로 사용 방식·영향 확인을 마쳤습니다. 이어서② 구현과③ 대표 소비 화면 재검증·발견 문제 수정을 마쳤습니다. 권한·데이터·실기기 제한은 별도로 남았습니다. 자세한 상태는 [DLDS 체크포인트](dentlink-fe-opportunities.md)를 봅니다. 아래의 일시중단/HEAD는 당시 기록입니다.

- 후속 DL-16534 QA의 Rating 클릭 개선과 작성자 이름 검색은 PR #4636으로
  release/v1.87.0 `ae1145676`에 병합됐다. 사용자 요청에 따라 로컬
  `feature/DL-16534`와 `/Users/parkjongsun/Repository/dentlink-client-feedback-qa`를
  정리했다. 원격 feature는 보존했고 기본 checkout/LBX 및 DLDS는 변경하지 않았다.
  PM 정정으로 의사명은 제외했으며 나머지 백엔드 작업은 이번 배포 필수가 아니다.
  새 worktree는 꼭 필요한 경우에만 생성하며 기존 checkout을 우선한다. 상세 상태는
  [피드백 QA 체크포인트](dentlink-client-order-feedback.md)를 참조한다.
  아래 목록은 이 후속 작업 이전 정리 시점의 기록이다.
- 사용자가 LBX 외 작업까지 로컬 브랜치·worktree·메모리를 확인하고 불필요한 항목을
  정리한 뒤 대기하도록 요청했다. 아래 목록은 이번 live Git/경로 점검 결과다.
- 웹 기본 checkout은 `feature/DL-16387 / 347909945`, DLDS 전용 worktree는
  `feature/DL-16466 / 01d49c3cb`다. 둘 다 원격과 0/0·clean이며 보류/중단 중인
  미병합 작업이라 보존한다. 로컬 `master / de2ffdd9e`도 원격과 일치한다.
  이 셋 외 웹 로컬 branch와 추가 worktree는 없고, prune할 worktree 메타데이터도 없다.
- 앱은 기본 checkout의 `main` 하나뿐이다. clean 확인 후 `git pull --ff-only`로
  `e0f4d5d` → `7403721151f3d2135799a995bccdd2214783822d`를 반영했다.
  원격과 0/0·clean이다. fetch --prune으로 원격에서 이미 삭제된
  `origin/feature/DL-16292`, `origin/wip/transfer`의 로컬 추적 참조만 정리했다.
- FE 프로젝트 폴더의 `.internal/research`, 회의자료 심볼릭 링크 및 로컬 전용
  `demo-studio`(`main / 4d12ae2`, clean, 원격 없음)는 자료/데모로 보존했다.
  FE·통합알림센터의 프로젝트용 Git 메타데이터도 유지했다. FE의 이 자료들은 바깥
  Git 저장소에서 untracked로 보이며 제품의 미커밋 변경과 구분한다.
- `~/.codex/worktrees`에 추가 Git checkout은 없다. 제품의 다른 등록 worktree도 없다.
  웹의 기존 stash **148개**는 미반영 여부를 판정하지 않았으므로 삭제하지 않았다.
  stage 복구 ref `refs/codex-backup/stage-20260928-0272910a6d3c`는 이전 stage를
  보존하는 복구 지점이므로 유지한다. 나이가 오래됐다는 이유로 자료를 제거하지 않았다.
- `PROJECTS.md`의 오래된 경로·진행 상황 복제를 줄여 프로젝트별 정본 링크 중심으로
  정리했고, LBX 보류/앱 현재 HEAD/Case Preference PR 병합 상태를 맞췄다.
  각 프로젝트의 과거 결정과 검증 이력은 삭제하지 않았다. `HANDOFF.md`에 LBX 경로를 추가했다.
- 제품 구현·테스트·PR/원격 브랜치 변경·배포는 하지 않았다. 정리 완료 후 대기하며,
  LBX와 DLDS는 사용자의 재개 지시가 있을 때만 이어간다.

## Release Stage Checkpoint — 2026-09-28

- **최신 종료 확인:** PR #4637은 stage `bf955dfe2`로 병합됐고 추가 Popup QA를
  포함한 release/v1.87.0 `bb5bff410`과 전체 tree가 같다. 사용자가 재배포를 실행했다.
  확인 시 Admin 36383203554/Office 36383203565/Lab 36383203608은 모두 진행 중이며
  STG 피드백 화면도 기존 버전이었다. FE 구현·병합·로컬 정리는 완료했고 배포 성공 및
  새 화면 반영만 미확정으로 남긴다. 정확한 run 링크와 다음 확인 항목은
  [피드백 종료 기록](dentlink-client-order-feedback.md)에 있다. PM은 현재 스펙 우선
  운영에 동의했고 백엔드 의존 개선은 이번 배포 필수가 아니다. 아래는 이전 전달 이력이다.

- **최신 전달:** 사용자 요청으로 원격 stage(`7c4255f7b`)를 삭제하고 원격 master
  `de2ffdd9e`에서 다시 생성했다. 최신 release/v1.87.0 `ae1145676`을 새 stage로
  전달하는 [PR #4637](https://github.com/Innvoaid/dentlink-client/pull/4637)을
  생성했다. 전체 릴리즈 19개 commit/86개 file이며 직전 stage 이후 QA #4635/#4636을
  포함한다. PR 병합·스테이징 배포는 미실행이다. 이전 stage는 local recovery ref
  `refs/codex-backup/stage-20260928-7c4255f7b9fd`로 보존했다. 아래는 이전 전달 이력이다.

- 후속 종료 확인: 사용자가 PR #4634를 병합했고 stage는
  `7c4255f7b9fd8efb2cc87978ed26ac8ef49a85e2`다. release `c07fc181a`와 tree가
  동일하다. 스테이징 배포를 실행했으며 종료 시점 Lab/Admin/Office 배포 run은 모두
  `in_progress`였다. 정확한 run 링크와 QA 경계는
  [피드백 종료 체크포인트](dentlink-client-order-feedback.md)를 참조한다.
- 사용자 요청으로 DL-16443 local branch 3개, 전용 수동 worktree와 임시 검증 파일을
  정리했다. 원격 브랜치, 기존 stage 복구 ref, 다른 진행 작업의 LBX/DLDS 환경은 보존했다.
  개인 체크포인트를 원격에 저장한 뒤 DL-16443 세션을 보관하며, 이 세션에서 새 작업이나
  자동 배포 감시를 시작하지 않는다. 아래는 stage PR 생성 당시의 이력이다.

- 사용자 요청 순서대로 웹 저장소의 원격 `stage`를 삭제하고, 원격 `master`
  `de2ffdd9e3025cb758632788cd6086c170e4974e`에서 새 원격 `stage`를 만들었다.
  생성 후 `git ls-remote`에서 두 브랜치의 SHA 일치를 확인했다.
- 삭제 전 `stage`는 `0272910a6d3c055d92941df294567a2922550be3`이었다.
  열린 stage 대상 PR·브랜치 보호 규칙은 없었고, 기존 커밋은 제품 로컬 ref
  `refs/codex-backup/stage-20260928-0272910a6d3c`에 보존했다.
- [PR #4634](https://github.com/Innvoaid/dentlink-client/pull/4634)를
  `release/v1.87.0 → stage`로 생성하고 이 task에 첨부했다. 생성 당시 release는
  `c07fc181a810d6528b948d792c956fb77cb1d5b6`, PR은 OPEN·MERGEABLE이다.
  원격 master 대비 17개 커밋/83개 파일이며, DL-16443 최종 수정도 포함돼 있다.
- 실행 경로는 `/Users/parkjongsun/Repository/dentlink-client-feedback-review`이고
  checkout은 `feature/DL-16443 / 1babe908f` clean 상태를 유지했다.
  다른 작업의 checkout·로컬 branch는 바꾸지 않았다. PR merge나 별도 배포 실행은
  하지 않았다. 다음 단계는 통합 PR 검토·병합 및 실제 stage 배포/QA 확인이다.

## Context Routing — 접수 당시 이력

- 2026-09-28 사용자 요청으로 통합알림센터의 선행 작업인
  [DL-16317 권한관리](https://innovaid.atlassian.net/browse/DL-16317)를 별도 준비한다.
  앱 프로젝트 `권한관리 프로젝트 폴더`에 기존 task `권한관리세션`
  (`01a0e6fa-384c-7671-abb8-53d33c42c738`, 생성 당시 이름 `권한관리 초기 설정`)이 있다.
  초기 설정 이후 Office API 4개 사용처 조사까지 진행했으며 2026-09-29 개인 정본에
  반영했다. 권한관리 본 요구사항 분석·설계·구현은 미착수이고 추가 지시를 기다린다.
  중복 폴더 정리 후 사용자가 등록 경로를
  `/Users/parkjongsun/Documents/ChatGPT/권한관리 프로젝트`로 변경했다.
  자세한 시작 상태는 [권한관리 체크포인트](dentlink-permission-management.md)에 둔다.
- On 2026-09-22 the user requested a separate task for
  [DL-16443 — 관리자 피드백 리스트 페이지](https://innovaid.atlassian.net/browse/DL-16443).
  Created `DL-16443 관리자 피드백 목록`, task
  `01a0c83d-bef3-7c43-962d-9f6b2158695b`, in the existing FE project.
  It owned the web Admin `/feedbacks` list/filter and CS 관리 menu, using the
  newly added API contract and existing Admin patterns. Detail was deferred at
  intake, then the existing drawer and navigation links were added. This task
  closed on 2026-09-28 after review fixes, release/stage merges and local cleanup;
  see `dentlink-client-order-feedback.md` for the final state and deployment evidence.
  The user authorized creating `feature/DL-16443` from current master in the
  existing web main checkout. At intake that checkout was clean on LBX
  `feature/DL-16387` with one local-only commit and an active LBX writing task.
  The new task was instructed to do read-only preparation until LBX releases
  checkout ownership, then reverify Git and create the requested branch.
  No product branch or file was changed by this top-level task.
- On 2026-09-21 the user requested a new task in the existing
  `메인 프로젝트 폴더` (`/Users/parkjongsun/Documents/ChatGPT/FE`) for
  [DL-16279 — LBX 작업](https://innovaid.atlassian.net/browse/DL-16279).
  Created `DL-16279 요구사항 검토`, task
  `01a0c2c0-3e4d-7a42-867d-9c80f3fee241`, using the saved local folder.
  Its first scope is understanding
  [DL-16387 — 어드민 UI 초안 작업](https://innovaid.atlassian.net/browse/DL-16387),
  related requirements and the existing implementation through read-only
  inspection. No implementation, product Git changes, new branch/worktree,
  Jira/PR changes, test run or deployment is authorized by this intake.
  The startup prompt was delivered automatically; the user need not paste it.
  The initial direct detail request returned HTTP 504; that was an intake-time
  limitation, not the current feature status. The later feature review and user
  clarifications are now recorded in the dedicated checkpoint below. The Jira
  UI-draft subtask's completed status does not establish FE implementation.
- LBX 최신 상태는 [dentlink-client-lbx.md](dentlink-client-lbx.md)가 정본이다.
  구현·배포 전 검토와 release 충돌 해결까지 `feature/DL-16387 / 347909945`에
  저장됐지만, 2026-09-28 사용자가 백엔드 문제로 이번 배포에서 제외했다.
  PR #4623은 미병합 종료됐고 작업 브랜치를 보존한 채 대기한다.
  제품 API는 정상 연결하며 실제 서버 생성·수정 요청은 테스트에서 실행하지 않는다.
- DLDS 최신 상태는 [구현 체크포인트](dentlink-fe-opportunities.md)의 최상단을 따른다.
  **2026-10-08 사용자 정정으로 프로젝트를 읽는 에이전트의 자연어 요청을 기본으로
  정리하고 빈 소스 연락처 생성·후속수정·PC/휴대폰 검증을 저장**했다.
  공통 지침/스킬/ai:screen 도구는 특정 AI를 호출·인증하지 않는다. 기존 Codex 웹
  입력창은 선택 경로이며 다른 에이전트 실제 호환성·비개발자 사용성·공유 서비스는 별도다.
  사용자(FE)와 Codex만 지금 검증하며 PM·디자이너는 실제 서비스 단계에서 참여한다.
  다음은 사용자 확인/후속 요청을 받고 근거 있는 보완을 진행한다.
  정확한 HEAD·검증·로컬 미리보기·기기 변경 복구 조건은 기능 정본에 둔다.
- FE improvement planning uses one [Notion meeting document](https://app.notion.com/p/3dcce072e82f81628aa6fe5e28c833ca)
  and one [demo app](https://dentlink-experience-studio.parkjongsunfrankie.chatgpt.site).
  See [the current checkpoint](dentlink-fe-opportunities.md) for scope and recovery.
  The user selected Notion as the final source on 2026-09-15 for cross-device
  access and team editing. Fetch that page before edits; local
  `dentlink-fe-meeting.md` contains only a link. Older Notion history pages and
  PDFs remain retired and must not be restored as current meeting documents.
- Read `projects/dentlink-client-order-feedback.md` and other matching
  `dentlink-client` checkpoints for web/Admin implementation history.
- Read `projects/dentlink-app.md` for Office app implementation, runtime,
  build, and deployment history, and `projects/dentlink-lab-app.md` for Lab app work.
- Read `projects/dentlink-unified-notification-center.md` when that cross-web/app
  feature resumes.
- Keep repository-specific branch, commit, QA, and blocker detail in those
  existing files. Record only cross-repository decisions and coordination
  state here.

## Transition Checkpoint — 2026-09-11

- The DL-15828 web-only session was closed, its dedicated worktree and local
  task branches were removed, and web follow-up moved to the main
  `dentlink-client` checkout. Its verified state is recorded in
  `projects/dentlink-client-order-feedback.md`.
- Live verification found the main `dentlink-client` checkout clean on
  `release/v1.86.0` at `0e0878ef1`, synchronized with its remote. Its only
  local branches are `master` at `ddeeb1e86` and `release/v1.86.0`, both at
  0/0 divergence, and its only registered worktree is the main checkout.
- The app-specific session completed its live Git, PR, Jira, validation and
  delivery audit on 2026-09-11. Its final handoff is recorded in
  `projects/dentlink-app.md`; the product repository remained unchanged during
  the handoff and personal context was the only authorized write target.
- The local `claude-personal-context` checkout was removed after confirming it
  had no local-only changes, commits, stash, or worktrees. Its GitHub repository
  remains available for optional future recovery.

## Top-Level Session Start

1. Pull `codex-personal-context` and read the common guidance plus this file.
2. Read the relevant web and app checkpoints before relying on prior chat.
3. Fetch/pull the relevant product repositories only as required by the current task,
   then verify exact path, branch, HEAD, upstream, dirty state, and worktree.
4. Classify each new request as web, app, or shared before deciding the owning
   implementation session and release target.
5. Apply the canonical size/continuation routing rule: separate feature session
   by default, with a dedicated folder/worktree for substantial continuing
   work. Resolve unclear scope or ownership only when necessary, and do not
   reuse a completed feature branch.
6. Reconcile Jira, Notion, Figma, Swagger, and live code when the new request
   depends on them; do not re-fetch every external source without a task-driven
   reason.

## 이전 Next Starting Point — 2026-09-11 전환 당시

- On 2026-09-11 the user delivered the prepared prompts to both the new
  projectless Dentlink FE top-level session and the existing app session.
- After prompt delivery, the user clarified that future sessions are organized
  by feature rather than by device or repository. The current rule in this
  checkpoint supersedes earlier prompt wording that implied web and app
  implementation sessions should be split by default.
- This former `dentlink-client` management session can now close. Its repository
  cleanup and cross-repository operating-rule migration are complete.
- The web and app session handoffs are complete. The new projectless Dentlink
  FE top-level session should pull `codex-personal-context` again and use the
  repository-specific project files as its starting evidence.
- For app work, first re-fetch `/Users/parkjongsun/Repository/dentlink-app` and
  verify PR #286, Jira, branch and runtime state. The preserved app starting
  point is `feature/DL-16061` at `a8f3a6c`; resume implementation only for a
  new QA card, reviewer finding, or confirmed product/API/design change.
- The top-level session accepted the app handoff and rechecked live state.
  The earlier transition handoffs came from the former web session;
  `DENTLINK_APP_FINAL_HANDOFF` came from the former app session. Keep their
  repository ownership distinct. Ask the user when a substantive conflict or
  unanswered decision remains after comparing the evidence.
  After the 15:07 handoff, PR #286 was merged into app `develop` at 15:09:46
  KST. Its squash result exactly preserves the feature tree. Detailed Git and
  review evidence is in the latest section of `projects/dentlink-app.md`.
- Keep current delivery gates separate: app implementation and develop
  integration are complete; DL-16229 and DL-16353 remain `READY FOR QA`.
  No formal human approval is recorded, and release/Production inclusion is
  not confirmed. Preserve existing branch/worktree state until the user asks
  for cleanup; do not reuse the completed feature branch for new work.

- On 2026-09-11 the existing unified-notification-center session aligned its
  role beneath this top-level session, retaining one web/app feature scope.
  It remains in planning with no assigned implementation branch or release;
  detailed decisions and verified state stay in
  `projects/dentlink-unified-notification-center.md`.

## Local Repository Housekeeping Completed — 2026-09-14

- A read-only web/app Git audit confirmed no extra registered worktrees in
  either repository. Web E2E's local feature branch and retired directory are
  absent. At audit time web retained local `master` and `release/v1.86.0`,
  both behind their remotes with no local-only commits.
- After that audit the user authorized cleanup. App now has only local `main`,
  clean and synchronized with `origin/main`; completed local `feature/DL-16061`
  was deleted after verifying its remote and squash-merge preservation.
  Exact evidence is in `projects/dentlink-app.md`. Each product has only its
  main checkout. The remote app feature was retained.
- The user then explicitly requested that web retain only local `master`.
  After confirming the local and remote release commits were included in
  `origin/master`, web `master` was fast-forwarded and local `release/v1.86.0`
  was deleted. Web now has only clean, synchronized `master`; the remote release
  remains preserved. Detailed web evidence is in
  `projects/dentlink-client-order-feedback.md`. No extra worktree remains in
  either product repository.

## E2E Coordination Checkpoint — 2026-09-14

- Local retirement completed around 19:03 KST on explicit user request. Removed
  the clean E2E worktree and local `feature/e2e-reliability`, about 12 GB of
  disposable worktree data, and 12 owned `/tmp` directories plus 41 files.
  All 49 changed files matched master/release before deletion. Curated QA
  evidence remains in the detailed checkpoint; raw local paths are historical.
  No owned server, 3100/3105/3102 listener or account/auth/onboarding lock remained.
  Shared caches/skills, unrelated stashes and remote refs were preserved.
- At E2E retirement, the remaining main checkout was clean local
  `release/v1.86.0` at `0e0878ef1`, with master at `ddeeb1e86`; the later
  housekeeping checkpoint above supersedes that local branch state.
  The completion prompt was delivered to this `메인세션`
  (`01a08f0c-2057-7852-ae8d-0cf950a91fd3`), which explicitly acknowledged
  reading canonical commit `5d9cd1b` and receiving the handoff at 19:04:42 KST.
  It is idle with no additional task or document mutation. The user will remove the old E2E app
  task/project themselves; do not create replacements or reopen completed work.
- Latest completion update around 18:59 KST supersedes the pending states below:
  the user confirmed master and production delivery. Live verification found
  [PR #4608](https://github.com/Innvoaid/dentlink-client/pull/4608) merged into
  master at `de2ffdd9e3025cb758632788cd6086c170e4974e`, containing E2E squash
  `c506661e6`; key runner/config files match the final feature source. Clinic,
  Lab and Admin production Actions `34826131930`, `34826221699`, `34826256088`
  all succeeded from their v1.86.0 tags at `c506661e6`. The earlier three stage
  Actions also succeeded. The E2E improvement is delivered and closed; no new
  scenario run or production functional test is claimed by this record update.
  Separate master UI S3 run `34826324855` failed at dependency installation;
  it is not an app deployment/E2E result and was not diagnosed in this update.
  Details and retained validation boundaries are in `dentlink-client-e2e.md`.
- Session closed at the user's request around 16:59 KST. Agreed E2E
  implementation/review/documentation and PR delivery are complete, with no known
  pending fix. The user confirmed owning the merges and deployment initiation.
  All three deployment workflows were still in progress at the final check;
  next follow-up starts with their deployment and E2E outcomes, not a new
  implementation plan. Worktrees/branches and the user's local UI were preserved.
- Current delivery supersedes the pre-merge review state below: the user merged
  E2E PR [#4606](https://github.com/Innvoaid/dentlink-client/pull/4606) into
  `release/v1.86.0` at 16:51:06 KST, squash commit
  `c506661e612b7105a7c8b73f32b96f39ee10b41c`.
- The user then authorized remote `stage` deletion/recreation from remote
  `master` and a release-to-stage PR. The E2E session used exact leases to delete
  old stage `28e5e0b1e` and recreate it at master `ddeeb1e86`, verified both refs,
  and created [PR #4607](https://github.com/Innvoaid/dentlink-client/pull/4607),
  `[Release] v1.86.0 스테이징 재배포`, `release/v1.86.0 -> stage`. The full release
  comparison is 16 commits/188 files, with no merge conflicts and a resulting
  tree identical to release. No local checkout/worktree/protection was changed.
- The user (`jongsunP`) merged #4607 at 16:55:48 KST while final verification was
  underway. Remote stage is now `2ce6c29d412f47976f74326b2202bca4b2c123af`.
  Exact-SHA deployment workflows started at 16:55:51 KST: Office/Clinic
  `34820155085`, Lab `34820155047`, Admin `34820155051`; all were **in progress**
  when checked. The agent did not merge or dispatch workflows. Actual deployment
  completion and new post-deployment E2E results still require verification.
- The following implementation/review evidence predates those merges and is
  retained with its original source and deployment boundaries.
- Detailed current state is in `projects/dentlink-client-e2e.md`. Worktree
  `/Users/parkjongsun/Repository/dentlink-client-e2e`, branch
  `feature/e2e-reliability`, HEAD `f267c4924`, clean and synchronized with
  `origin/feature/e2e-reliability`. The user authorized committing/pushing all
  49 approved files and creating open, non-draft
  [PR #4606](https://github.com/Innvoaid/dentlink-client/pull/4606) into
  `release/v1.86.0`. Remote PR head matches; merge-tree simulation against
  release `1e0754789` succeeded without conflict. No merge or deployment.
- The subsequently requested CodeRabbit cycle fixed two valid minor findings
  in `99f4780c8`: empty BUILD_ID now fails before DEV/STG deployment waits;
  onboarding's shared page uses the existing API monitor/reset/failure hooks.
  Both threads were answered/resolved, that review completed successfully, and
  focused staging onboarding **22/22** plus **211/211** regressions passed.
- The user also confirmed local UI tests worked and requested quieter logs.
  `f267c4924` preserves local server stdout/stderr in private per-run
  `webservers/{clinic,lab,admin}.log`, announces paths, and appends through UI
  Reload. CLI/headed/UI share this behavior; remote and direct Playwright paths
  retain their intended behavior. No service/ChannelTalk code or dependency
  changed. **219/219**, types and isolated native UI logging/Stop/Reload/startup
  failure checks passed. Existing user-run local UI was left running and needs
  a fresh launcher invocation for the new log environment. Source-qualified
  details and evidence are in the E2E checkpoint.
- The user approved completing all discussed follow-ups, asking for the design
  best suited to the existing workflow rather than unconditional UI parity.
  Manual operation remains local frontend with DEV API, or deployed staging
  with STG API. The unrequested `e2e:clinic:dev` alias and manual guidance were
  removed; existing DEV deployment CI retains its internal environment support.
- CLI, headed and UI commands now share environment/target/auth initialization
  and owned-process interruption protection. UI preserves native selection,
  reruns and Reload, archives each observed selection's JSON and applies the
  common result classifier. A private lifecycle journal catches setup/cleanup
  failures that native UI can hide. Later success does not erase earlier results.
- UI source snapshots record session boundaries. A normal `session_closed`
  is not a full test verdict: config/module errors before reporters may appear
  only in UI, and selection results do not prove independent full inventory,
  deployment versions or every intermediate state. Full release evidence remains
  the local/staging batch runner contract. Do not treat this as a new manual DEV
  workflow or a claim that every UI action is observed.
- The ten new E2E scripts remain `.js` CommonJS. No further script files or
  dependencies were added in this follow-up. Verified pre-commit source digest:
  `671bb59c6f5c2a52b34c089e03c0dbcec42aada4b4fa4a273dea8d78647ee9d8`.
  All 49 committed file contents match that snapshot; the commit changes HEAD
  and therefore the runner's digest, so the digest is historical run evidence.
  Regressions **211/211**, syntax **10/10**, E2E types, formatting, references,
  skills and independent code/side-effect review passed. Service app paths and
  existing DEV/STG build/deploy jobs are unchanged; CI changes concern E2E jobs.
- Real staging UI passed login/onboarding **25/25**, selected rerun **3/3**,
  and post-Reload **3/3**, then normal native window closure with two complete
  setup/teardown attempts, unchanged source and no recorded issue. Isolated real
  UI also verified expected failure, unapproved skip, in-body Stop and Reload
  cleanup failure remain observable. Real local UI passed **25/25** and **3/3
  after Reload**, with normal session closure, unchanged source and local server
  ports released. Final staging batch passed **104 + 5 allowed exclusions**,
  all 109 collected/reported, no failure/flaky/nonexecution, unchanged current
  source and all three portal BUILD_IDs, with `staging_full_verified=true`.
  The three real runs were sequential; final owned locks/recovery meta and local
  server listeners were absent. Approved follow-up implementation, verification
  and maintained documentation/skills are complete within these boundaries.
- Previous source-qualified full local/staging **104 + 5 allowed exclusions**,
  DEV focused **6/6**, invalid-target/account-lock evidence and exact run paths
  remain in the detailed checkpoint. They are historical evidence for their
  recorded sources, not substitutes for current or future deployment checks.
- Native app E2E is excluded. The role-neutral objective is trustworthy full
  staging decisions within registered web coverage, without a fixed pass count.
  Actual test-server data is mutated; cleanup is scoped and account locks are
  host-local, not distributed. Registration/assertion meaning still requires
  requirement/code review. Maintained guides and shared/personal skills use one
  authoring and execution contract; the personal installed skill matches its source.
- Commit/push hooks passed all three app type/lint checks (existing lint
  warnings), shared tests **27/27** and unchanged coverage. Missing ignored
  local coverage baseline was prepared with the existing command. The HTTPS
  workflow-scope rejection was resolved using already-authorized SSH identity
  with a command-only push URL override; no hook was bypassed or persistent
  remote/auth configuration changed.
- Final CodeRabbit verification on exact head `f267c4924`: **success / Review
  completed**, **zero unresolved threads**. The requested review cycle is complete.
  Initial Vercel failure required author project access; the final head reports
  `Deployment was blocked`. PR remains `MERGEABLE` but `BLOCKED`. Team review,
  release merge, deployment and actual remote E2E CI remain separate gates.
  No remote E2E run was started here.

## FE Opportunity Planning — Final Meeting and Demo, 2026-09-15

- Current scope, evidence, deployment and recovery are owned by
  [the FE opportunity checkpoint](dentlink-fe-opportunities.md).
- Team materials are one Notion meeting document and one public demo app.
  Preserve the two ranking axes: practical FE value and visible business value.
  The four demos illustrate the latter; no production task has been selected.
- Final refinement is deployed to the existing Site: real map detail, lab-space
  interiors, distinct synthetic dental models and order-context file browsing.
  The current gallery has 14 fresh screenshots and a 59-second silent slideshow.
- Historical breakpoint pages, local meeting bodies and PDF bundles are retired.
  Prior history is recoverable from Git; do not restore old links or duplicate
  detailed progress here. Fetch the current Notion before subsequent edits.

## DL-16474 Amplitude — Closed, 2026-09-28

- Completed: Office pageview collection, `welcome_view`, and Office/Lab
  environment-consistent collection. [PR #4613](https://github.com/Innvoaid/dentlink-client/pull/4613)
  and [PR #4615](https://github.com/Innvoaid/dentlink-client/pull/4615) were both
  merged into `release/v1.87.0` on 2026-09-18. Validation and cleanup are complete.
- On 2026-09-28, the user requested retirement of this finished session and its
  working memory. Detailed checkpoints were removed; recover implementation
  history from the merged PRs or this repository's Git history only if needed.
  Related local/remote branches, dedicated worktrees and task temporary files
  are absent. Do not resume this as pending work or restore the old worktree.
- Deployment and live event receipt were outside this session's verified scope;
  they are not an active agent task. Other project work/checkouts are independent.
