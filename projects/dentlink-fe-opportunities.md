# Dentlink FE 아이데이션 · Notion 회의 자료

## 재개 체크포인트 — 2026-09-21

### 목적과 현재 위치

- **사용자 목적:** 오늘 하루 또는 한 번의 사용량 안에 모두 끝내는 것이 목표가 아닙니다. 토큰·사용량 부족, 세션 중단, 나중 재개, 다른 기기에서도 **완료된 지점 다음부터 이어갈 수 있게** 기록합니다. 이후 사용자가 “1번만 지금 진행”을 요청하여 남은 Figma 대조만 수행했습니다. 다음2번 화면 점검·3번 수정은 아직 시작하지 않았습니다.
- **재개 신호:** 사용자가 “DLDS 작업 재개”, “디자인시스템 1단계 이어서”, “DL-16466 계속”이라고 하면 이 절을 먼저 읽고 아래 1→2→3 순서의 미완료 항목부터 진행합니다. 완료된 카탈로그를 다시 만들거나 초기 아이데이션으로 돌아가지 않습니다. 제품 커밋·푸시와 Git 메모리 정리까지 기존 명시 승인이 이어집니다. 필요한 정보·실제 판단이 생긴 항목만 질문하며 새 승인 대기를 임의로 만들지 않습니다.
- **정정:** 앞선 “독립적으로 가능한 범위를 마쳤다”는 표현을 모든 독립 작업 완료로 해석하지 않습니다. 남은 원본 대조뿐 아니라 앱별 폰트·실제 사용 화면·접근성/회귀 점검도 이어갈 수 있습니다. 아래1번의 지정 원본 대조는 완료했고, 2·3번은 미착수입니다. 전체 디자인시스템1단계 완료는 아닙니다.
- **제품 저장 상태:** `https://github.com/Innvoaid/dentlink-client`, branch `feature/DL-16466`, HEAD `01d49c3cbaf3590076a078a9531e2ddceb5be2a7`(남은 Figma 대조 기록·원본 보관), 구현 `0fa8295423e9c21ec01c8a6dc928d02c9a0cd16f`. 9월21일 원격 일치·clean 확인. 현 기기 전용 worktree는 `/Users/parkjongsun/Repository/dentlink-client-dlds`; 다른 기기에 이 절대 경로가 존재한다고 가정하지 않습니다.
- **지금까지 구현·검증:** 28개 카탈로그 항목, 공통 UI·작은 화면·키보드 정비, 원본 기반 신규 아이콘41/전체452. 9월18일 UI162·아이콘 생성1·서비스 focused E2E7·catalog 검사·세 앱 타입 통과. UI 일반 타입의 기존578건/신규0은 별도입니다. 세부 증거는 아래 9월18일 기록과 제품 `shared/ui/DESIGN_COVERAGE.md`를 봅니다. 이 수치를 오늘 새로 검증한 결과로 표현하지 않습니다.
- **Figma 대조 완료:** 공식 도구로 이전 제한 아이콘69개 node(67종+이름 충돌1+이름 미상1)·로고18변형·컴포넌트18상태를 확인했습니다. 제품 `shared/ui/design-audit/FIGMA_REMAINING_AUDIT.md`와 TSV를 정본으로 보며 `figma-source-snapshot-2026-09-21.json`에105개 node·SVG119개·SHA·배치 참조를 보관합니다. 접근 제한69행은 모두 해소됐고 단기 asset URL이나 `/tmp`에 재개를 의존하지 않습니다.
- **팀 기록:** [DL-16466](https://innovaid.atlassian.net/browse/DL-16466)은 진행 중이며 9월21일 남은 원본 대조 결과와 후속2·3번을 기록했습니다. 최신 [회의 원본](https://app.notion.com/p/3dfce072e82f812c843afed105630c98)은 유지합니다. 2단계 [DL-16471](https://innovaid.atlassian.net/browse/DL-16471) AI 프롬프트·하네스는 아직 시작하지 않았습니다.

### 다음 작업 — 이 순서로 이어가기

| 순서 | 상태 | 실행 내용 | 다음으로 넘어갈 기준 |
| --- | --- | --- | --- |
| 1. 남은 Figma 대조 | 지정 원본 대조 완료 · 수정 전 | 아이콘67종 중 기존 지도 핀2 재사용, 나머지65는 추가/조합 후보(도형 차이62+기본도형3). 별도2node의 이름 충돌/배경 차이 기록. 로고18=재사용2/조정10/조합6, 컴포넌트18상태 대조 | 원본·판정·후속 처리를 Git에 보관. 모든 자산 신규 구현이나 기존 이름 대응226종 전체 검증 완료라는 뜻은 아님 |
| 2. 실제 사용 화면 점검 | 후속 점검 미착수 | Clinic/Lab/Admin 실제 폰트 로딩·최종 스타일, Modal/Popup·Calendar·Tooltip 소비 화면과 키보드·작은 화면·기존 값/콜백 보존을 점검. 기존 검사와 중복되지 않는 대표 화면을 선정 | 검사한 앱·화면·환경·시나리오·결과, 재현된 결함, 미확인 범위를 기록 |
| 3. 발견한 차이 수정·검증 | 후속 수정 미착수 | 1·2에서 확인한 문제를 기존 props·기본값 호환성을 고려해 수정. 의미 있는 회귀 검사와 공식 E2E로 검증하고 커밋·푸시·문서/메모리 정리 | 새 결함의 재현→수정→검증 근거와 저장 상태가 연결됨. 실제 사용자 결정이 필요한 항목만 별도로 추림 |
| 4. 1단계 결과 정리·하네스 연결 | 1~3 뒤 | 확정 컴포넌트·규칙·사용 예시·남은 예외를 2단계 입력으로 정리 | 1단계 미검증/보류를 숨기지 않고 완료 범위를 설명. 1단계 진행 중에 AI 하네스/에디터 구현으로 임의 이동하지 않음 |

### 중단에 대비한 저장 방법

- 위 상태표를 실제 진행에 맞게 갱신합니다. 원본 대조는 아이콘·로고의 작은 묶음, 화면 검사는 앱/시나리오, 수정은 검증 가능한 변경 단위를 체크포인트로 삼습니다. 모든 도구 호출마다 저장할 필요는 없습니다.
- 각 체크포인트에는 **완료 항목/node/화면, 바로 다음 항목, 수정 파일, branch·HEAD·원격 저장 여부, 실행한 검사와 결과, 실패 원인/보류, 사용자 답이 필요한 내용**을 남깁니다. 중단 시 “진행 중”만 적지 말고 다음 행동 한 개를 특정합니다.
- 검증된 변경은 사용자가 승인한 범위에서 정상 hooks로 커밋·푸시하고 Git 메모리도 의미 있는 단위마다 커밋·푸시합니다. 최종 완료 때까지 원격 저장을 미루지 않습니다. 아직 검증하지 못한 변경을 저장할 필요가 있으면 검증 전 상태를 명시하고 완료로 보고하지 않습니다.
- 갑작스러운 종료로 원격에 없는 변경이 남았으면 다음 기기에서 자동 복구됐다고 가정하지 않습니다. 마지막 원격 체크포인트부터 시작하고 원래 기기의 dirty 파일·실행 중 프로세스 존재를 확인합니다. 다른 기기의 동시 작업을 덮어쓰거나 새 worktree로 무작정 중복 실행하지 않습니다.
- `/tmp/dlds-*`, 로컬 `e2e-runs/`, CUA 탭·서버·node_modules·환경변수·로그인 상태는 Git으로 이동하지 않습니다. 재현에 필요한 기준·명령·검증 요약은 Git에 남기고 필요한 원본/검사는 재확보합니다. 비밀 값·고객 데이터는 메모리에 기록하지 않습니다.
- 이번 후속 1~3 예상은 **4~8시간의 잠정 추정**(1:1~2h, 2:1~3h, 3:2~3h)이며 마감 약속/작업 예산이 아닙니다. 사용량 비교용으로 1번 전후와 주요 체크포인트에서 계정 사용량·실제 소요를 확인하여 남은 산정을 보정합니다. 2026-09-21 11:09 KST 조회 당시 주간 사용56%/잔여44%는 **계정 전체의 당시 값**이며 이 작업 토큰 수나 현재 잔여치로 재사용하지 않습니다. 다른 작업 사용량 때문에 전후 차이도 순수 작업 비용이라고 단정하지 않습니다.

### 같은 기기·다른 기기의 재개 순서

1. Git 기반 컨텍스트 `codex-personal-context`를 `git pull --ff-only`하고 `BOOTSTRAP.md` → `SESSION_WORKFLOW.md` → `projects/dentlink-fe.md` → 이 파일의 재개 절을 읽습니다. 새 기기에는 `https://github.com/jongsunP/codex-personal-context`를 준비하고 필요한 경우 `./setup-local-codex.sh`로 지침을 연결합니다.
2. 제품 저장소의 branch/dirty/원격 차이/`git worktree list --porcelain`를 먼저 확인합니다. 이 작업은 기존 `feature/DL-16466`을 이어갑니다. 다른 기기에 해당 checkout이 없으면 원격 브랜치에서 전용 checkout/worktree를 복구하며 master에서 새 구현을 시작하지 않습니다. 기존 로컬 브랜치/점유 worktree가 있으면 보존해 사용합니다. 강제 reset·checkout 삭제·force push를 하지 않습니다.
3. 안전한 대상 checkout에서 `git pull --ff-only`. 저장 기록01d49c3cb보다 원격이 앞서 있으면 최신 커밋과 체크포인트를 비교하여 후속 진행을 보존합니다. 오래된 SHA로 되돌리지 않습니다.
4. 저장소의 현재 Node/pnpm 기준과 루트·`shared/ui/README.md`, `shared/ui/tests/README.md`, `shared/ui/DESIGN_COVERAGE.md`, `shared/ui/design-audit/{figma-icons,figma-logos}.tsv`, `shared/icons/figma-provenance.json`을 확인합니다. 확인 당시 pnpm은 `8.6.9`, CI Node는 `24`이며 engines는 별도로 지정하지 않았습니다. 초기 의존성은 `pnpm install --frozen-lockfile`. 카탈로그는 루트 `pnpm dev:ui`(5177 strict port), UI 검사는 `pnpm test:ui`, 아이콘 검사는 `pnpm --filter @dentlink/icons test`입니다. 카탈로그 검사는 `pnpm --filter @dentlink/ui exec tsc -p tsconfig.catalog.json --noEmit`와 `pnpm --filter @dentlink/ui exec vite build`이며 기존 타입 오류가 있는 일반 UI build와 구분합니다. 실서비스 E2E는 dentlink-web-e2e skill과 저장소 지침을 읽고 환경/인증을 준비한 후 공식 runner를 사용합니다.
5. **다음 재개는2번 실제 사용 화면 점검**부터입니다. Clinic/Lab/Admin의 폰트 등록·최종 로딩과 Modal/Popup·Calendar·Tooltip 사용처를 읽고 대표 화면/시나리오를 선정합니다. 이미 확보한105개 node를 다시 모두 조회하지 않습니다. 추가 Figma 확인이 필요한 경우에만 해당 node를 조회하며, 접속 제한을 화면/코드 조사 전체 중단 이유로 확대하지 않습니다.
6. 현재 꼭 필요한 사용자 입력은 없습니다. 실제 인증이 필요한 경우, Figma 상충 기준을 정할 수 없는 경우, 실기기 검증이 필요한 경우에만 구체적인 도움을 요청합니다. 사용자에게 화면 전체 수동 검사를 넘기지 않습니다. PR·병합·배포·공통 기본값 전역 전환은 별도 범위로 유지합니다.

## 남은 Figma 대조 결과 — 2026-09-21

- **이번 범위:** 후속 순서1번만 조사. 제품 실행 코드·기본값·아이콘 export는 변경하지 않았으며2번 실제 화면 점검,3번 수정·회귀는 미착수입니다. “1번 완료”를 디자인시스템1단계 전체 완료로 혼동하지 않습니다.
- **자산 판정:** 기존 미대응132종=추가41+기존 대응26(이번지도핀2 포함)+추가/조합 후보65. 별도 이름 충돌 `1304:122`(테두리 콘)/`1304:123`(채운 콘), 이름 없는 `1320:15254`는 경광등 표식 투명/흰색 차이. quote의 부모24px frame·잘린 원본 배치도 확보. 65종을 필수 신규 구현 건수로 단정하지 않습니다.
- **로고:** Symbol TwoColor-light→SvgLogoTwoColorLight, Gradient-dark→SvgObjectDentlink는 도형·팔레트 재사용 가능. 나머지10은 색/여백/비율 조정, 세로형6은 원본에 맞는 조합 필요. MonoBlack 실제fill은회색이고 light/dark 팔레트가 다르므로 이름으로 대체하지 않습니다.
- **확인된 상태 차이:** 일반Checkbox hover·체크표시만의6상태; Stepper text/S 높이32 vs현재40; Slider 양끝손잡이 중심7/177 vs현재0/184·0% 활성선4 vs0·그림자 누락; 모바일Tooltip280px·padding·opacity/화살표 차이. 좌우화살표 묶음은 수량Stepper와 용도가 같다고 단정하지 않고 후속 사용처 확인. Tooltip 예시의 가운데 위치만으로 viewport 중앙 고정을 확정하지 않습니다.
- **증거/검증:** 제품5파일(대조MD2, TSV2, 원본JSON1),105node·SVG119개 SHA/유효XML·TSV395/18행·제한상태0·diff검사. 기존 TSX452+추가SVG104 후보검색. 지도핀은 동일480px 색 정규화IoU .999856/.999798, 로고재사용2개는464px RGB평균절대차 .0125/.0119. 단일유사도점수로 의미나 동일성을 판정하지 않으며 기본도형·ZIP·plus/minus반례를 기록했습니다.
- **원본 보관 원칙:** JSON의referenceLayout은 공식도구의참조텍스트이며 제품코드가 아닙니다. 원본SVG문자열·SHA와부분자산배치를 함께 보관했습니다. 새기기에서JSON을읽으면재조사에단기다운로드URL이필요하지않습니다. SVG를전체frame으로단순확대하지않습니다.
- **저장:** 제품 `01d49c3cbaf3590076a078a9531e2ddceb5be2a7` — `docs: DLDS 잔여 Figma 원본 대조와 정비 후보 정리`. 정상hooks(세앱타입/기존lint·coverage절차)완료, 원격SHA일치·clean확인. Jira DL-16466만진행현황동기화,Notion/Sites/AI하네스/PR/배포변경없음. 이번에검증서버나새브라우저를실행하지않았습니다.
- **사용량 참고:** 1번시작전계정주간57%사용/43%남음→11:44KST조회60%/40%. 계정전체3%p변화로다른작업사용도포함할수있으며이작업만의토큰수나잔여작업완료보장으로환산하지않습니다. 다음작업시다시조회합니다.

## 프로젝트 기준과 구현 체크포인트 — 2026-09-18

- **선택 과제는 하나:** 실제 덴트링크 컴포넌트를 기반으로 AI가 우리 UI에 맞는 화면을 만들고, PM·디자이너와 FE가 그 결과를 함께 활용하는 환경을 만듭니다. **DLDS 정비 → AI 프롬프트·하네스 정비(핵심) → 필요하고 가능하면 덴트링크 에디터 개발** 순서입니다. 핵심 AI 단계는 **Figma 시안이 나오기 전 기획·디자인 단계에서 비개발자가 프롬프트로 작업하는 환경**을 목표로 합니다.
- **최신 회의 원본:** [FE 2차 회의 결과 · 디자인시스템과 AI 화면 제작](https://app.notion.com/p/3dfce072e82f812c843afed105630c98). 페이지 ID `3dfce072-e82f-812c-843a-fed105630c98`. 오늘 회의 결론과 후속 구체화는 이 문서를 기준으로 합니다.
- **이전 기록:** [1차 전체 아이디어](https://app.notion.com/p/3dcce072e82f81628aa6fe5e28c833ca) → [2차 회의 전 검토안](https://app.notion.com/p/3dece072e82f818299d9c781d5696953) → 위 최종 회의 결과. 이전 본문을 보존하고 2차 검토안 상단에 새 결론 링크만 추가했습니다. 기존 후보·작은 병행 업무를 모두 실행하는 결정은 아닙니다.
- 세 문서 위치는 `DEV Team / Development Documents`, data source `26366594-1ec5-423c-b7c3-35abe1e047f2`입니다. 새 페이지 Tags는 FE·FE Planning·AI, 날짜는 2026-09-18입니다.
- **Jira 단계:** 상위 [DL-16437 · 디자인시스템 정비 · AI 하네스 기반 화면 제작](https://innovaid.atlassian.net/browse/DL-16437), [1단계 DL-16466 · DLDS 디자인시스템 정비](https://innovaid.atlassian.net/browse/DL-16466), [2단계 DL-16471 · AI 프롬프트·하네스 정비](https://innovaid.atlassian.net/browse/DL-16471)로 정리했습니다. 사용자 허용에 따라 상위·1단계 제목을 변경하고 2단계를 새 하위 작업으로 등록했습니다. 상위와 1단계는 기존 진행 중 상태, 2단계는 해야 할 일, DL-16464·DL-16465는 완료를 유지합니다. 에디터는 2단계 결과를 보고 진행 여부를 정하므로 별도 구현 카드로 확정하지 않았습니다. 각 단계 Jira 상단에 최신 Notion을 연결했습니다.
- **FE 자체 아이데이션:** 1·2차 회의 참석자는 FE 팀원들입니다. PM·디자이너·운영팀은 도구의 사용자 또는 필요시 확인할 상대입니다. 개인 진행 이력은 이 Git 체크포인트, 팀 공유 본문은 Notion에 둡니다.
- [dentlink-fe-meeting.md](dentlink-fe-meeting.md)는 최신·이전 Notion과 Jira의 바로가기입니다. `/Users/parkjongsun/Documents/ChatGPT/FE/FE-업무-검토-회의자료.md`는 이 파일의 심볼릭 링크이며 별도 본문을 관리하지 않습니다.
- 기존 [Dentlink Experience Studio](https://dentlink-experience-studio.parkjongsunfrankie.chatgpt.site)는 앞선 시각화 후보의 데모입니다. 이번 선택 과제의 구현 결과가 아니며 이번 기록 작업에서는 수정하지 않았습니다.
- 사용자가 실제 착수와 자율 진행·제품 커밋·푸시·Git 메모리 정리를 승인했습니다. **1단계 실제 컴포넌트 정비와 DLOS 구조를 참고한 28개 항목 카탈로그를 진행 중입니다.** 최신 제품 HEAD는 `f0d23995d616109739d35348ca31e45404da38a5`(설명 보완), 구현 커밋은 `0fa8295423e9c21ec01c8a6dc928d02c9a0cd16f`입니다. 신규 아이콘 41개, 작은 화면의 선택 목록·팝업·안내 및 키보드 복귀를 보완했습니다. 공통 UI 162개·아이콘 생성 1개·최종 구현 커밋의 서비스 E2E 7개 통과입니다. **전체 1단계 완료는 아닙니다.** 추가 Figma 원본 접근, 일부 상태 대조와 실기기·스크린리더 검증이 남습니다. AI 하네스·에디터·PR·병합·배포는 진행하지 않았습니다.
- **로컬 실행:** 전용 worktree 루트에서 `pnpm dev:ui` → `http://127.0.0.1:5177`. 설치·접속·종료·포트 중복 안내는 루트 README와 `shared/ui/README.md`에 있습니다. 회귀 검사는 `pnpm test:ui`입니다. Codex의 검증용 5187/5188과 E2E 3100/3105/3102는 종료했습니다. 사용자 5177 서버는 재실행·조작하지 않았고 마지막 점검에서는 리스너가 없었습니다. 다음 재개 시 프로세스 소유자와 경로를 다시 확인합니다.

## 스텝 1 자율 추가 정비·최종 검증 — 2026-09-18

### 저장 상태와 범위

- **최신 지시:** 사용자가 없어도 독립적으로 가능한 작업을 최대한 진행하고, 질문이 꼭 필요한 경우에만 확인하며 마지막에 제품 커밋·푸시·Git 메모리까지 마무리합니다. 단순 중간 체크포인트에서 작업을 종료하지 않습니다. 이 기록은 현재 1단계의 후속이며 AI 하네스·에디터 착수로 범위를 넓히지 않았습니다.
- **제품:** `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16466`. 구현 `0fa8295423e9c21ec01c8a6dc928d02c9a0cd16f` — `feat: DLDS 자산과 작은 화면 및 키보드 동작 정비`(133파일, +4606/-714; SVG41개와 생성 TSX41개 포함). 후속 `f0d23995d616109739d35348ca31e45404da38a5`는 README의 포커스 적용 범위 한 문장만 바로잡습니다. 정상 hooks를 거쳐 두 커밋을 푸시했고 원격 HEAD 일치·clean을 확인했습니다.
- 원본 `/Users/parkjongsun/Repository/dentlink-client`의 master `de2ffdd9e3025cb758632788cd6086c170e4974e`는 clean을 유지했습니다. PR 생성·병합·배포·기존 Storybook 삭제는 하지 않았습니다. 개인 컨텍스트의 동시 작업인 Amplitude PR4615 정리 기록(이전 HEAD `1914b09`)을 보존했습니다.

### 구현과 근거

- **아이콘:** 기존 미확인 132종을 추가 조사하여 41종의 Figma 원본 기반 자산을 추가하고 24종은 기존 도형과 대응함을 확인했습니다(9종은 회전 조건 필요). 67종은 원본 확인이 남습니다. 기존 411개 TSX는 바꾸지 않아 전체 452개, SVG 원본은 427개입니다. 이름만 대응한 기존 226종을 전수 도형 검증 완료로 세지 않습니다. TSV의 제한 상태 69행은 고유 67종 외 이름 없는 Component1·같은 이름 다른 node를 포함하므로 숫자를 혼용하지 않습니다.
- **자산 재현성:** `shared/icons/figma-provenance.json`에 원본 node·해시·프레임 근거를 기록했습니다. spinner/loading/hand 3종은 확인된 24px 부모 프레임에 원본을 배치했고 SVGR가 내부 SVG에 host props를 덮어쓰던 문제를 해당 자산만 보정했습니다. 신규 41개 생성 코드의 불필요한 React import를 제거했습니다. 재생성 41개 동일·기존 원본 기반 386개 재생성 diff0·기존 411개 byte 변경0. 생성 검사를 CI에 연결했습니다. SVG/React SSR의 24·48px 래스터 82비교 최대 평균 RGBA 오차는 1.8294/255(SVGO 반올림)이었으며 브라우저 전수 픽셀 일치의 증거로 보지 않습니다.
- **로고:** `figma-logos.tsv`에 18개 변형을 구분했습니다. 직접 후보 5개(가로2·심볼3), 후보 없는 13개이며 원본 대조가 막혀 정확한 도형 일치 완료는 0개입니다. MonoBlack 이름과 실제 gray fill 차이도 기록했습니다.
- **상태·버튼:** Radio 테두리·hover·checked 색상, Switch disabled cursor, Stepper의 활성 상태 hover를 정비했습니다. Slider의 `sideButtonVariant="icon"`은 24px 아이콘+8px 여백의 40px 버튼을 제공하며 기존 plain 기본 간격은 유지합니다. 기존 제품 Slider 2곳을 임의 전환하지 않았습니다.
- **선택 목록:** 기존 DOM 배치를 유지하면서 화면 안 너비·높이 제한과 위/아래 배치, 중첩 스크롤 복원을 처리했습니다. 키보드로 초점이 이동한 경우에만 해당 항목을 보이게 하고 사용자 수동 스크롤은 빼앗지 않습니다. modern/legacy/Chart, 긴 이름·30개 목록, disabled/값/콜백을 검증했습니다. DropdownDrawer는 기본 focus trap·스크롤 잠금, Modal·Popup은 선택형 `trapFocus`입니다. Admin의 v2 DropdownBase도 disabled/form 제출/Escape/객체 콜백을 보존합니다.
- **팝업·안내:** Tooltip의 화면 경계·긴 내용·키보드 설명 연결·내부 터치 스크롤, Toast의 실제 상단 여백/하단 위치를 보완했습니다. Popup `scrollContent=false` 기본을 유지하고 켠 경우 본문만 스크롤하며 하단 버튼을 유지합니다. Modal·Popup Tab/Shift+Tab 이동은 대상이 보이도록 스크롤하고 초기·복귀 초점은 기존 preventScroll을 유지합니다.
- **실서비스에서 발견한 초점 결함:** Clinic 태블릿에서 Paid 선택 후 재열기→Escape 시 초점이 사라지는 문제를 공식 E2E로 재현했습니다. 첫 수정의 단위 테스트만으로 해결된 것으로 판단하지 않았으며 재실행에서 실패를 확인했습니다. React 18 commit/focus 보정 순서와 실제 이벤트를 조사하여 legacy close를 `setIsShow(false)` 후 `focusTrigger()` 순서로 맞췄습니다. 닫기 먼저 예약 후 초점을 옮기는 기존 성공 선택 경로와 일치시켰고 공통 hook 전체 변경은 피했습니다. 임시 진단 코드는 제거하고 기존 강한 단언을 유지했습니다.

### 검증과 제약

- **자동 검사:** 공통 UI 22파일 162개, 아이콘 생성 1개, catalog strict 타입·lint·Vite production build 통과. Clinic/Lab/Admin 전체 타입 검사도 정상 커밋 hook으로 통과했습니다. UI 패키지 일반 타입 검사는 기존 578건과 정확히 동일하며 신규 진단 0건입니다. 전체 UI 단독 build/type가 성공했다고 표현하지 않습니다. catalog main chunk 약 517kB 경고는 남습니다.
- **저장 hooks:** 세 앱 lint 오류0(기존 경고229/189/410), shared configs3+hooks24=27개 테스트 및 coverage 검사 통과. hooks coverage는 기준과 같지만 configs에는 기존 기준 대비 dateInput/rnPostMessage 추가·일부 증가가 표시돼 전체 coverage 무변경으로 기록하지 않습니다. hooks를 우회하지 않았습니다. Tooltip Set 순회의 Clinic ES5 타입 오류는 Array.from으로 고치고 세 앱 전체 타입 검사를 다시 통과했습니다.
- **최종 서비스 E2E:** `pnpm e2e:clinic e2e/clinic/specs/03_orders/crown.spec.ts e2e/clinic/specs/09_sharedUi.spec.ts`. 최종 구현 커밋 `0fa8295423e9c21ec01c8a6dc928d02c9a0cd16f`에서 7/7 PASS, 실패/flaky/skip/미실행/중단/전역오류0. `e2e-runs/2026-09-18T11-12-46-153Z-fd8acde6/{summary.md,verdict.json,run.json}`. source SHA `3d458e947a73f92cc30375be63419467d810f070e964dd175de7cde13f591a87`, source_unchanged=true. 후속 f0d23995d는 README 한 줄만 바뀌어 실행 코드가 동일합니다. 로컬 FE+DEV API 검증이며 staging_full_verified=false. Admin은 실제 문자 발송·쓰기 시도0 가드를 유지했습니다.
- **실패·수정 이력:** `10-53-17-090Z-df305627` 및 `11-01-55-439Z-8a5d3be0`의 full 7은 각각 6pass/1fail. 진단 `11-04-49-266Z-3b80148c`의 태블릿 1fail 후 원인 수정, `11-07-05-273Z-1ae42649` focused1/1 및 `11-09-23-793Z-2e34cdb7` full7/7, 위 최종 커밋 full7/7로 검증했습니다. 통과할 때까지 원인 없이 반복한 것으로 요약하지 않습니다.
- **브라우저:** 320×480/568, 720×360, 960×360 등의 작은 화면에서 Popup 긴 본문·버튼 고정, Toast 상단80/하단12, Dropdown End/Home·수동 PageDown, Tooltip 내부 스크롤·Escape·aria 설명, Modal Shift+Tab 대상 버튼 스크롤을 확인했습니다. 실제 24/48px 아이콘 크기와 상태 색상도 확인했습니다. 최종 서버 재시작 후 새 런타임 오류는 없었으나 기존 styled DOM prop 경고는 남습니다. QA widget `/api/qa-users` 500은 별도 기존 로컬 설정 문제로, 전체 네트워크 오류0이라고 하지 않습니다. 태블릿 E2E는 touch/UA 에뮬레이션이며 실기기·스크린리더 증명이 아닙니다.
- **접근 한계:** 추가 Figma MCP는 Professional Dev seat 호출 한도에 도달했습니다. 제공된 DLDS URL을 브라우저에서도 확인했지만 로그인 화면이었고 인증 우회·계정 추측을 하지 않았습니다. 이미 확보한 원본과 공식 API 결과로만 적용했습니다. 미확인 67종 중 66종은 호출 한도, quote 1종은 부모 프레임 배치 근거 부족입니다. 로고 18개 변형과 Checkbox 일부 hover/표식·Stepper 일부 크기/화살표·Slider track/thumb 세부 시각 정합도 남습니다.
- **호환 범위:** Clinic/Lab의 Medium 파일=CSS400, Admin Regular400/Medium500 차이, 기존 full 반경과 Calendar 기본40px은 전역 변경하지 않았습니다. 신규 선택형 props를 전체 제품에 자동 적용하지 않았습니다. Figma mixed 원본의 일부 hover/disabled check와 enabled minus 불일치는 선택 의미를 보존해 minus를 유지했습니다.
- **정리/다음 시작:** DL-16466 진행 현황을 이 결과로 갱신하고 반환 본문 일치·진행 중 상태를 확인했습니다. Notion 회의 본문과 Sites는 그대로입니다. 자체 서버5187/5188, E2E3100/3105/3102는 종료했고 임시 브라우저 탭 닫기·viewport 복구를 마쳤습니다. 다음에는 Git을 갱신하고 인증된 Figma 또는 원본 접근이 가능해지면 남은 도형·상태 비교를 이어갑니다. 실기기/스크린리더 및 선택형 API 소비 화면 적용은 별도 증거가 필요합니다. 전체1단계·제품 전체 회귀·AI 하네스 완료로 넘겨짚지 않습니다.

## 스텝 1 중단 복구·예제·모달 포커스·달력 크기 — 2026-09-18

- **재개 의도/권한:** 사용자가 토큰 부족으로 중단됐다고 알리고, 기존 작업에 이어 Codex가 독립적으로 할 수 있는 구현·검증을 최대한 진행한 뒤 제품 커밋·푸시·Git 메모리를 정리하도록 재확인했다. 이전 a01200443와 개인20dfec4는 이미 원격에 저장됐으며 그 다음 미커밋 변경을 보존해 이어갔다. AI 하네스/에디터로 범위를 넘기지 않았다.
- **제품:** `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16466`, `7ddd6ac0969c73be5a853d06fa8f6001c24795b6` — `feat: DLDS 모달 포커스와 달력 크기 옵션 및 예제 보강`. 28파일(+2241/-764; TSV 새 추적열로396행 변경 포함). 정상 hooks를 거쳐 SSH push 성공, origin SHA 일치·clean. 기존 master checkout은 변경하지 않았다. PR/merge/deploy 없음.
- **카탈로그:** 실제 Button 기존/권장 구현에 로딩+문구/로딩만/좌우 아이콘/아이콘만 조합, Segment 선택 항목 장식, Slider 좌우 문구, Popup 이미지·아이콘과1버튼/가로2버튼/세로2버튼 추가. 사용 코드·props 설명 동기화. 새 가짜 제품 UI가 아니라 기존컴포넌트의 실제 props/children 조합이다.
- **Modal/Popup:** `trapFocus=false` 기본을 유지하는 선택형 API를 추가했다. 초기 초점·Tab/Shift+Tab 순환·닫기 후 복귀·숨김/비활성 제외·명시적 Portal 소유범위·중첩창/StrictMode를 검증했다. `ariaLabel`, `initialFocusRef`, `returnFocusRef`, `focusScopeRefs` 제공. 부모의 trap이 opt-out 자식의 autoFocus를 뺏는 commit 경합도 재현·수정했다. 기존 Popup stopEscapePropagation 기본false 유지. 카탈로그와 Admin SmsSend의 발송 확인 Popup 한곳만 opt-in; 검색 Portal이 있는 부모 작성Modal은 일괄 활성화하지 않았다. 임의 Drawer/iframe/배경 스크린리더 격리까지 완성했다고 보지 않는다.
- **Calendar:** 단독 CalendarPicker/CalendarRangePicker에 `daySize?:40|46`, 기본40 유지. 46px은 안쪽너비338px 이상(7×46+16) 계약이며 자동축소/가로스크롤 없음. 기존 DateField/DateRangeFieldV2 팝업에는 신규 옵션을 노출하지 않았다. 카탈로그는 실제 가용너비에 따라46 선택 가능 여부를 표시하고 좁아지면 선택값·사용코드를40으로 갱신한다. 320px에서 기존 날짜 열이 잘리던 카탈로그 겹친여백도 보완했다. 46px의 전체 간격까지 Figma와 일치한다는 뜻은 아니다.
- **폰트 해석 정정:** theme.medium400과 FigmaMedium500의 숫자 차이가 제품 전체의 시각 차이는 아니다. Clinic/Lab은 동일 Pretendard-Medium.woff2를CSS400에 등록하고 카탈로그400/500도같은파일이다. Admin은400Regular/500Medium을 나누므로 다르게 평가해야 한다. 실제font파일동일SHA·Regular/Medium일부glyph윤곽차이는 확인했으나 모든 실행페이지의최종폰트로딩은 미측정. 정적참조1482곳은 실제시각변경1482건이 아니다. 기본값·새Typography API를 임의변경하지 않고 README/DESIGN_COVERAGE를 정정했다.
- **아이콘:** 기존 미확인132종 중19종의 Figma 원본/기존SVG를 추가대조. 색상제외도형대응11종·잘못된후보배제5종·의미만대응3종,113종직접대조남음. 기존이름대응226은 유지, 추가11을완전구현율에합산하지않음. TSV에19종의후속상태/후보/도형중첩/근거4열을추가. spinner/arrow접두어를이름만보고같은자산으로연결하면안되는반례확인. viewBox17종은배율3/잘린자산2/부모frame조합2/비정사각형2/국기8로구분. 기존자산·색·viewBox·export변경없음.
- **검증:** `pnpm test:ui`16파일128개 PASS(109+focus14+daySize5). catalog strict TS/lint/build/diff PASS. commit hook Clinic/Lab/Admin전체타입 PASS. push hook3앱lint오류0·기존경고229/189/410, shared27tests·coverage변화0 PASS. 독립리뷰추가회귀발견0. 신규검증을기존전체UI단독타입의기존오류해소나스테이징증명으로해석하지않음.
- **브라우저:** preview5187에서 Modal/Popup 초기초점·Tab순환·Escape/확인후trigger복귀,390px 이미지/세로버튼·아이콘/1버튼을확인. Calendar375/400px 실제46×46·5/6주·마커·기간연결띠·선택/키보드,320px 실제40·선택유지·7열잘림없음·가로넘침없음. 콘솔오류/경고0. 실휴대폰/스크린리더검증과구분.
- **실서비스 E2E:** `pnpm e2e:clinic e2e/clinic/specs/09_sharedUi.spec.ts`2/2 PASS, 로컬FE+DEV API. Clinic Export 날짜오류복구·legacy선택/Escape·초기화와 Admin 확인Popup accessible name/description·초기취소focus·Tab/ShiftTab·Escape복귀·초안보존. 실제확인버튼활성화/문자발송없음, Admin쓰기요청시도0. `e2e-runs/2026-09-18T10-03-10-631Z-7d2ff877/{summary.md,verdict.json}`; source `c3007f185d9bfcf1b5792a399bba930cd6d28c2cd601ec1b1ca17fa0f35790ca`, source_unchanged=true. 실패/flaky/skip/미실행/중단/전역오류0. 이전체크포인트2건/24건과별도실행. 기존styled DOMprop경고는서버로그에남음.
- **정리:** DL-16466 진행현황을최신커밋/결과/남은범위로갱신했고반환본문일치확인. Notion 회의 원본/Storybook 유지, 새문서중복추가없음. 검증용5187·E2E3100/3105/3102 종료, 임시CUA탭닫기/viewport복구. 사용자5177재실행/조작없음. 사용자실행은전용worktree루트 `pnpm dev:ui`, 검사 `pnpm test:ui`.
- **남은 범위/다음 시작점:** 아직직접대조하지않은아이콘113종·로고/상태별시각정합, 선택형focus/daySize의제품소비자별적용, 실제휴대폰Drawer/스크린리더가남음. 전역글자굵기/반경/기본달력크기를이번에일괄전환하지않았다. 다음재개는이커밋을pull하고실사용처/디자인차이를구분해이어간다. 핵심AI하네스는아직미착수이며이단계완료로넘겨짚지않는다.

## 스텝 1 Figma 전체 목록 대조와 추가 정비 — 2026-09-18

- **최신 사용자 요청:** Codex가 스스로 할 수 있는 작업을 계속 진행하고 DLDS Figma에 있는 것이 실제로 다 구현됐는지/누락은 있는지 확인한다. 이전 대기는 사용자 승인·기술적 장애가 아니라 앞선 커밋/푸시 체크포인트였다. 이 후속 지시에도 Step1 안에서 작업하며 AI 하네스·에디터 단계로 넘어가지 않는다. 기존 최종 커밋·푸시·메모리 정리 승인은 유효하다.
- **제품 상태:** 전용 worktree `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16466`, 최신 `a01200443dee0c017ece2ceb6418d2751f9db515` — `feat: DLDS 디자인 누락 상태와 키보드 사용성 보완`, 35파일(+2487/-223). 원격 SHA 일치·clean 확인. master 원본은 수정하지 않았으며 PR·병합·배포 없음.
- **Figma 대조:** 확정 파일 `syQbfe4vTWUz87SYqa5Kvx`의 Core `1:28` + 개별 16페이지 metadata를 실제 source/catalog에 연결했다. 16개 모두 대응 코드는 있지만 모든 상태·픽셀·반응형 정합 완료를 뜻하지 않는다. 실제 수치 구현에는 해당 node design context와 스크린샷을 확인했다. 카탈로그는 Foundation1+실제 컴포넌트27의 28개를 유지한다.
- **팀 소유 기준 문서:** `shared/ui/DESIGN_COVERAGE.md`에 17페이지 매핑, Core Tab/Modal/기반 규칙, 반영 범위·원본 간 차이·남은 예제/검증을 정리했고 README에 연결했다. `shared/ui/design-audit/figma-icons.tsv`는 Figma 395 symbol의 node/분류/대응 source를 기록한다. 임시 원본 `/tmp/dlds-figma-audit/*.xml`·`/tmp/dlds-icon-coverage-report.md`는 다음 세션에서 존재를 가정하지 않는다.
- **아이콘 판정:** glyph368/이름 중복 제외358종 중 정규화 이름 대응226종, 이름 변경·실제 누락 여부 확인 대상132종. 132종을 미구현 확정으로 표현하면 안 된다. 직접 대응 중17종의 viewBox 차이, 로고18변형 전체 대응도 남아 있다. Admin app icon4개는 이름·크기·manifest 연결 확인. Figma 도형·색상 전수 픽셀 검증은 하지 않았다.
- **추가 구현:** Checkbox `indeterminate`(native mixed/aria/선택 이벤트)와 `selectionNumber`(0 포함 장식 숫자); Tabs optional compact46px/regular54px(폰트·배지·아이콘·underline), 생략 시 기존52px; Toast `actions`와 호출부가 소유하는 닫기/표시 시간. 기존 API 기본값·customIcon 우선순위·폼 값 보존. Input 카드에 한 줄/여러 줄/비밀번호·아이콘·우측 문구·로딩을 추가했다.
- **기반 규칙:** Figma의 white/gray×100/200/300 shadow6개와 border0.5/1/2px 토큰을 추가하고 Modal/Dropdown/Input의 같은 값을 연결했다. Foundation/Inspector에서 확인 가능. Layout 열·간격·여백 안내를 추가했으나 기존 제품 breakpoint/화면을 일괄 이전하지 않았다.
- **사용성/결함 수정:** Calendar grid 방향키·Home/End·PageUp/Down·Shift 연도 이동·Enter/Space 선택·월 경계 포커스. 수동 기간 입력이 기존 weekend/holiday/min/max 제한을 우회하던 문제를 수정했고 끝 날짜 제외·양 끝 날짜에 제한을 적용하는 기존 정책은 유지했다. ButtonGroup 전체 disabled 무시 및 PasswordInput disabled 중 보기/지우기 작동을 수정하고 비밀번호 아이콘을 키보드 가능한 button으로 바꿨다. Modal은 이미 처리된 Escape를 존중하며 Admin SmsSend/대량 LinkTalk 확인 Popup은 부모 작성창과 Escape를 분리한다.
- **검증:** `pnpm test:ui` 14파일109개 PASS. catalog strict TS/lint/build PASS. 커밋 hook Clinic/Lab/Admin 전체 타입 PASS. push hook 세 앱 lint 오류0(기존229/189/410경고), shared config/hooks27tests·master 대비 coverage 변화0 PASS. 독립 diff 리뷰 actionable regression0. 전체 UI 독립 타입의 기존 오류 집합은 이번에 재실행하지 않았으며 이전579→578 기록과 구분한다.
- **실제 브라우저:** 검증용5187에서 Compact46/font16/icon18/underline2, Regular54/font18/icon20, 좁은 화면/1440desktop 배치, Checkbox mixed 키보드 해제/숫자, Toast action callback, PasswordInput 키보드 보기·disabled 차단, Calendar 방향키/Enter/월 이동을 확인했다. 콘솔 오류·경고0. 실제 모바일 기기/스크린리더 검증을 뜻하지 않는다.
- **실제 서비스:** 정식 runner `pnpm e2e:clinic e2e/clinic/specs/09_sharedUi.spec.ts` 2/2 PASS. Clinic Export: 날짜 오류 복구·legacy Dropdown Escape 후 모달/날짜/Paid/focus 유지·닫기/초기화. Admin `/messages/sms`: 가상 수신자0·초안→확인 팝업→Escape→입력 내용 유지→취소. service worker 차단 + Admin 브라우저 쓰기 abort 가드; 실제 발송 버튼 클릭0·쓰기 요청 시도0 검증. 실제 메시지는 보내지 않았다.
- **E2E 증거:** `e2e-runs/2026-09-18T09-22-45-022Z-4412ae3b/{summary.md,verdict.json,run.json,report.json}`. 18:22:45~18:23:32 KST 약48초, 실패/flaky/retry/skip/미실행/전역오류0. 실행 당시 HEAD ad3b55d6a+작업 사본 SHA `ddda2cc3ed6ad94f5508d611b0b850c0571b4271da3bc3576b0cf42ee17a3a24`, source_unchanged=true. 이후 코드 변경 없이 문서 설명·TSV 빈 칸만 정리하여 커밋. 이전20+4 E2E와 별도 실행이며 staging_full_verified=false. 기존 styled DOM prop/DataTable deprecated 경고는 남는다.
- **정리:** 검증용5187 및 E2E3100/3105/3102 서버 종료, 임시 CUA 탭 닫음/viewport복구. 사용자5177 서버는 조작하지 않았다. Jira DL-16466 설명에 커밋·대조 문서·검증·남은 범위를 갱신하고 진행 중 유지. Notion 회의 방향·기존 Sites 데모는 변경하지 않았다.
- **다음 시작:** Step1 전체 완료 아님. ① 아이콘132 후보/로고18변형의 시각적 대응 및 실제 누락 확정 ② 기존 API로 가능한 Button 로딩/아이콘, Segment 장식, Popup 이미지·버튼 방향 등의 예제 ③ Medium500 vs400·full1000px vs50%·Calendar46 vs40 적용 범위 ④ Modal/Popup 전체 focus trap/복귀·실제 모바일/스크린리더. Checkbox 원본 일부 mixed-hover/disabled glyph가 check인 불일치는 선택 의미를 위해 minus 유지. 전역 기준 변경은 영향 근거 없이 밀어붙이지 않되, 가능한 조사·호환 보완·검증은 Codex가 계속 수행할 수 있다.

## 스텝 1 회귀 검증과 커밋 — 2026-09-18

- **사용자 진행 방식:** 가능한 작업·검증·문제 수정은 Codex가 직접 진행하고 판단이 필요한 질문만 한다. 사용자에게 화면 전체의 수동 검사를 넘기지 않는다. 사이드 이펙트를 최대한 자동·실제 화면에서 확인하되 필요시 사람/실기기 검증을 후속으로 병행한다. 이번 작업의 최종 제품 커밋·푸시·Git 메모리 정리까지 명시 승인했으며 완료 후 대기한다. PR·merge·배포까지 승인한 것은 아니다.
- **제품 체크포인트:** `feature/DL-16466`, `ad3b55d6a4f6c3f54e1b36ae39aa041a86f309bf` — `feat: DLDS 카탈로그와 공통 컴포넌트 정비 및 회귀 검증 추가`. 105파일(+7750/-1046), 28개 카탈로그 항목과 실제 공통 UI 정비, 테스트/CI/개발 안내를 포함한다. `origin/feature/DL-16466` 원격 push·upstream 연결 완료, 원격 SHA와 일치, clean.
- **추가 수정:** 실제 Forms/FormComponentWithError는 errorFocused에 오류 문구를 전달한다. InputBase가 이 문자열을 aria-invalid에 노출하지 않도록 boolean으로 정규화하고, 실제 wrapper를 사용한 오류 발생/해제·명시적 aria 우선순위 2건을 추가했다. 추가 Button·입력·Tab·Chip·overlay 소비자 독립 리뷰에서는 다른 구체적 새 회귀를 발견하지 못했다.
- **반복 검증:** `pnpm test:ui`로 실제 컴포넌트·hook·portal을 검사하는 8파일 70건 통과. 제품 모듈 mock 없이 jsdom 미지원 스크롤 API만 대체한다. 임시 66건에서 중복/치수/helper 직접 검사를 정리하고 overlay 및 실제 폼 wrapper 검사를 보강했다. PR용 `.github/workflows/ui_regression.yml`에 테스트·카탈로그 strict tsc·lint·build를 연결했다. 로컬에서 같은 명령을 통과했으며 GitHub CI 실행은 별도다.
- **정적 검사:** catalog strict tsc/lint/build 통과, 새 테스트/설정/InputBase lint 오류·경고0, diff --check 통과. 커밋 hook의 Clinic/Lab/Admin 전체 타입 검사도 통과. 전체 UI 독립 타입 검사에는 기존 579→578 오류가 남지만 새 진단0이다. 앱 타입 검사 통과와 UI 단독 기존 진단은 서로 다른 검사다.
- **실제 서비스 검증 1:** 로컬 frontend + DEV API, `crown`/`04_labShipment`/`08_orderFeedback` 20건 통과(4.2분). 환자 정보→주문 완료, 배송·픽업 생성/취소/수정, 승인·완료 후 피드백 저장·파일·재조회·수정·직접 진입까지 확인했다. 실패/재시도/flaky/skip/미실행/전역오류0. 증거 `e2e-runs/2026-09-18T08-38-17-378Z-46d3c5be/summary.md`; source snapshot `fd0d69fb25f69f9f78540896b7b279fe5a0dd01b6af3093e7141bf303d6d66d9`, 실행 전후 동일.
- **실제 서비스 검증 2:** InputBase 추가 수정 뒤 `01_signin` + 신규 `09_sharedUi` 4건 통과(58.4초). 로그인 성공/실패와 결제 내역 Export의 불완전 날짜 차단·Today로 복구·키보드 Dropdown 진입·선택/포커스·부모 스크롤 잠금·닫기 후 재열기 초기화를 검증했다. 신규 테스트는 실제 결제/유효 Export/데이터 변경을 수행하지 않는다. 증거 `e2e-runs/2026-09-18T08-44-39-913Z-aa9fb3a3/summary.md`; snapshot `8cabc0b8db08ec2158ac6d8143db9ff317f4eee8c62c2456393fe64dfb2eb730`, 실행 전후 동일. 두 실행은 서로 다른 작업 사본 시점이므로 한 번의 전체 실행으로 표현하지 않는다.
- **브라우저/환경:** CUA로 실제 로컬 Clinic 로그인 화면 desktop/390px 레이아웃·콘솔 오류0 확인. E2E용3100/3105/3102와 기존5177 모두 종료 상태 확인. CUA viewport 임시 설정 해제. 로컬 QA widget `/api/qa-users`500 및 기존 styled prop 경고는 DLDS 통과 범위와 분리하며 widget 연동 완료로 보지 않는다.
- **Git hook 복구:** 새 worktree에 없던 `.husky/_/husky.sh`는 정상 `pnpm exec husky install`로 준비했다. 첫 push는 ignored coverage-baseline 파일 누락으로 차단됐다. clean master 원본(`de2ffdd9e`)에서 기존 shared coverage27건을 새로 실행하고 결과 경로만 전용 worktree에 맞춰 baseline을 생성했다. 원본의 오래된 baseline은 덮어쓰지 않았다. configs/hooks 총 coverage 변화0, 훅 우회 없음. 앱 lint는 오류0(Clinic229/Lab189/Admin410 기존 경고). 최종 push hook 전체 통과. HTTPS OAuth에 workflow 권한이 없어 첫 원격 전송이 거절됐으며, 기존 SSH 인증 `jongsunP`와 저장소 접근을 확인해 명령 단위 push URL만 사용했다. 권한·persistent remote URL·hook을 바꾸지 않았고 원격 SHA 일치까지 확인했다.
- **정리 완료:** Jira DL-16466의 진행 현황을 커밋 링크·검증 결과·남은 범위로 갱신했고 상태는 진행 중을 유지했다. Notion 회의 방향/AI 단계/기존 데모는 변경하지 않았다. 제품 원본 master와 전용 worktree 모두 clean, Git 메모리도 커밋·푸시한 뒤 사용자 요청대로 대기한다.
- **남은 범위:** Step1 전체 완료 아님. Figma Medium500 vs theme400, full1000px vs50%, Calendar46 vs40의 적용 범위; spacing/shadow/border 공통화; 날짜 grid 키보드 탐색; 모달 focus trap/복귀·중첩 Escape 정책; Admin 주요 소비 화면과 실제 휴대폰/스크린리더. 지금까지의 로컬 focused24건은 전체 서비스/스테이징 배포 검증이 아니다. 사용자가 일일이 수동 확인해야 한다는 의미가 아니며 Codex가 가능한 범위부터 계속 검증한다.

## 스텝별 실행 준비 — 2026-09-18

- **1단계 · DL-16466:** 실제 공개 컴포넌트·사용 화면·테마·기존 Storybook을 확인 → 기준 Figma 파일·페이지·상태 연결 → 유지/정비/추가 확인 목록 작성 → props·기본값 영향·카탈로그 범위·검증 방법과 구현 순서 결정 → 해당 범위부터 구현합니다. 결과물은 기준/변경 목록·정비 코드·사용 예시·전체 확인 페이지입니다. 정적 검사, 기본 상호작용·접근성, 기존 사용 화면 영향을 확인하고 남은 차이를 기록해 AI 단계에 넘깁니다.
- **2단계 · DL-16471:** 1단계에서 사용할 컴포넌트·규칙·예시와 기본 동작 검증이 준비된 범위로 시작합니다. 대표 기획·디자인 요청과 평가 기준을 정하고 하네스를 구성합니다. 비개발자의 요청·확인·수정, 실제 컴포넌트 사용, 디자인·코드 품질과 FE 코드 전달을 검증하고 작업 절감 효과를 평가합니다. 결과물은 반복 사용 환경·안내·대표 요청/결과/검증 기록입니다.
- **3단계 · 조건부:** 2단계에서 확인한 불편과 필요에 따라 요소 선택·직접 조작·부분 수정 등 범위를 정합니다. 2단계로 목적을 달성하면 별도 에디터 없이 종료할 수 있습니다. 사용 도구·전달 형식·신규 UI 검토 절차·정량 품질 기준·기간은 각 단계 시작 시 실제 범위를 기준으로 구체화합니다.
- **확정 디자인 기준:** [000 DLDS · Core+Component](https://www.figma.com/design/syQbfe4vTWUz87SYqa5Kvx/000-DLDS?node-id=1-28). 사용자가 2026-09-18 이 파일을 기준으로 승인했습니다. MCP로 페이지 목록 17개·Core 영역·Button/Input 개별 페이지와 대표 상태/수치를 읽었습니다. 별도 추가 자료 없이 대조를 시작했습니다. DLOS URL은 정리 방식 참고이며 `shared/ui/src/v2`와 연결하지 않습니다.
- **초기 작업 경계(당시 상태):** 제품 원본 `/Users/parkjongsun/Repository/dentlink-client`의 `feature/amplitude-pageview-tracking` / `7ef67797b`는 clean 그대로 유지했습니다. 사용자 branch 승인 후 origin fetch 및 최신 master `de2ffdd9e`에서 `feature/DL-16466`, 전용 worktree `/Users/parkjongsun/Repository/dentlink-client-dlds`를 만들었습니다. 새 branch는 upstream을 연결하지 않았고 원격 branch를 만들지 않았습니다. 의존성은 frozen lockfile·offline·ignore-scripts로 설치했으며 lockfile 변경이 없습니다.
- **다음 시작점:** 전용 worktree `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16466`의 아래 최신 커밋/원격 상태부터 확인합니다. 스텝 1의 기준 차이 적용 범위·접근성·Admin 및 모바일 실제 화면 검증이 남아 있으며, AI 하네스 단계는 시작하지 않았습니다.
- **기록 동기화:** 기존 Notion과 Jira DL-16437/DL-16466의 Figma 미확인 문구를 확정 원본 링크로 갱신했습니다. DL-16466에는 첫 정비분·검증·남은 범위·로컬 미커밋 상태를 반영하고 진행 중 상태를 유지했습니다. Notion 회의 방향과 과거 메모는 유지합니다. 실제 작업 세부 범위는 Jira, 개인 작업 경계·검증 이력은 이 Git 체크포인트를 따릅니다.

## 스텝 1 회귀 검증 진행 방식 확정 — 2026-09-18

### 사용자 추가 승인

- 가능한 구현·검증·수정은 Codex가 스스로 이어가고, 방향이나 판단이 필요한 사항만 질문한다. 사이드 이펙트는 최대한 자동·브라우저 검증하되 필요하면 후속 실기기·사람 검토를 병행한다.
- 사용자가 이번 DLDS 작업의 중간 체크포인트 또는 마무리 **제품 코드 커밋·푸시를 명시적으로 승인**했다. 최종에는 제품 커밋·푸시, 진행 상황과 검증 한계의 Git 메모리 정리까지 수행하고 대기한다. PR 생성·병합·배포 승인으로 확대하지 않는다. 아래 이전 커밋·푸시 미승인 기록보다 이 승인이 우선한다.

- 사용자에게 현황을 정리했습니다: 기존69개 수정+신규21개(카탈로그15 포함)=90개 파일, 실제 동작 수정도 포함되어 전체1단계 완료가 아닙니다. 카탈로그/컴포넌트 단위 검증과 Clinic·Lab·Admin 실제 화면 검증을 구분합니다.
- **사용자 승인:** 변경 범위를 추가로 넓히기 전에 **Codex가 사용처를 찾아 실제 화면 검증·발견 문제 수정·반복 회귀 테스트 정착을 수행**합니다. 사용자가 모든 화면을 일일이 확인하는 방식이 아닙니다. 디자인 기준 선택 또는 Codex가 접근할 수 없는 실기기/환경이 필요한 경우에만 구체적인 비교안·차단 사유와 함께 확인을 요청합니다.
- 우선순위: 날짜/기간 입력과 실제 저장값 → Dropdown 검색·선택·초기화와 폼 상태 → 모달 중첩·스크롤 복원·모바일 → ListItem/버튼의 단일 클릭·의도치 않은 제출. 제품 전체가 안전하다고 테스트66건만으로 판단하지 않습니다.
- **범위 유지:** DLDS는 제공한 Figma 기준, DLOS는 카탈로그 구조·스타일 참고입니다. Medium500/400, full1000px/50%, 달력셀46/40처럼 적용 판단이 필요한 차이는 실제 사용처와 시각 영향을 먼저 확인하고 이후 결정합니다. AI 하네스/에디터는 아직 착수하지 않습니다.
- 기존 임시66개 테스트는 의미를 검토해 제품 저장소에서 재현 가능한 핵심 회귀 스위트로 정착시킵니다. 기존 서비스 환경이 준비되지 않았으면 실제 연동 검증과 대체 fixture 검증을 구분해 기록합니다.
- 현재 승인에는 제품 코드 수정·검증이 포함됩니다. 제품commit/push/PR/배포 승인은 추가되지 않았습니다. 개인 Git 메모리는 사용자 요청과 기존 원칙에 따라 commit/push합니다.

## 스텝 1 DLOS 원본 구조 적용·기존 선택 UI 정비 — 2026-09-18

- **DLOS 소스 확인:** 사용자가 제시한 PR #4609는 OPEN, head `feature/DL-16415` / `cbee7bd5f661dc220f971b74121bbbb40d3fe74a`, base `release/milling-center-v1.0`입니다. `dlos-preview/src/App.tsx`, `ComponentInspector.tsx`, `inspections.ts`와 `shared/dlos`가 실제 존재합니다. master에 없던 이유를 확인했습니다. 참조 PR/브랜치는 수정하거나 병합하지 않았습니다.
- **카탈로그:** DLOS의 248px 목차, 그룹별 한 페이지 예제, 흰색 캔버스, 선택 테두리, 오른쪽380px Code/Props/Tokens 패널, 글자·간격·색상을 DLDS에 적용했습니다. 1280px 미만은 닫을 수 있는 하단 패널입니다. 검색·속성/상태 펼치기·동적 사용 코드·Figma/실제 소스 경로를 연결했습니다. Tokens는 실제 DLDS 공통 참고값이며 모든 컴포넌트가 해당 값을 전부 적용했다는 뜻은 아닙니다. Desktop/Tablet/Mobile은 캔버스 폭이며 제품 media query/실기기 증명이 아닙니다.
- **수록 추가:** DateRangeFieldV2, CalendarRangePicker, ChartDropdown, Legacy Dropdown 예제를 더해 총28개 항목입니다. 실제 제품 코드·테마를 사용하며 DLOS 컴포넌트로 전환하거나 `shared/ui/src/v2`로 이관하지 않았습니다. 원본 구조의 DLOS 패키지 import 부분을 그대로 복사하지 않고 DLDS 예제에 연결했습니다.
- **기간 날짜:** 빈 배열 초기화 시 남는 입력, 불완전/잘못된 직접 입력으로 이전 기간이 확정되는 문제, 열린 상태의 disabled 처리를 보완했습니다. 선택 콜백 함수 identity 때문에 발생하던 반복 호출을 없애고 달력 dialog·오류 설명·취소 후 포커스를 연결했습니다. enabledEndDate 제외, maxRangeDays 날짜 차이, 단일 날짜 확인→[date,date], 빈 값→[] 규칙은 유지합니다.
- **기존 Dropdown:** 실제 Admin·Clinic 사용처를 확인해 legacy를 제거하지 않았습니다. placeholder/0/undefined 표시, 선택 지우기(onSelect 빈 문자열), disabled 항목, 검색 목록 갱신/모바일 재열기, 키보드 열기/닫기를 정비했습니다. ChartDropdown은 Portal DOM 연결 뒤 초기 포커스, 선택 후 복귀, 외부 포커스/disabled 시 닫기를 보완했습니다. ListItem의 실제 disabled·type=button·isItemClick 중복 호출도 수정했습니다. EmptyDataInfo/PaginationButtonUI는 leaf import만 좁혔으며 pagination onMount는 유지했습니다.
- **검증:** 카탈로그 strict tsc·lint0·production build·diff-check 통과. 전체 UI HEAD 비교579→578, 새 진단0(기존 DropdownFinder unused e1건 감소). 임시 Vitest66/66 = 기간17+날짜14+modern Dropdown11+Tooltip2+Slider/Stepper9+legacy/Chart13. 임시 설정은 `/private/tmp/dlds-dropdown-check`, `/private/tmp/dlds-range-check`, `/private/tmp/dlds-legacy-check`; shared/hooks에서 pnpm exec vitest run --config ... 로 실행했습니다. 제품 저장소에 CI 테스트로 편입된 것은 아닙니다. legacy 기존 lint 경고14건 유지.
- **브라우저:** production preview5187에서 28개 수록·검색·상태 보존·현재 사용 코드 갱신·Props/Tokens 키보드 탭 이동·그룹 링크·기간 팝업/잘못된 연도 확정 차단/취소·Chart 키보드 선택 및 포커스 복귀·legacy 지우기·Modal 본문 변경/Escape·Toast 화면 위치·390px 패널 닫기를 확인했습니다. 가로 넘침/브라우저 오류 없음. CUA fill(빈문자열)은 검색·날짜에서 값 제거가 되지 않았지만 일반 Backspace는 정상이며, 실제 wrapper/예제의 테스트에서도 정상임을 확인했습니다.
- **작업 상태:** product `feature/DL-16466`/HEAD de2ffdd9e, 미커밋. 제품 commit/push/PR/deploy 없음. DL-16466 Jira 진행 현황만28개/검증/남은 범위로 갱신, 회의 Notion은 유지했습니다. 사용자 실행용5177 서버는 조작하지 않았고, Codex 검증용5187만 종료했습니다. 마지막 포트 점검에서는5177/5187 모두 리스너가 없었으므로 재확인 후 pnpm dev:ui로 실행합니다.
- **남은 범위:** Figma Medium500↔theme400, full1000px↔50%, 달력셀46↔40의 적용 범위와 spacing/shadow/border 기준 연결; 날짜 그리드 키보드, 수동 날짜의 휴일/주말/허용 기간 제한; Modal/Popup focus trap·중첩 Escape; 실제 휴대폰 Drawer/스크린리더; Clinic/Lab/Admin 사용 화면 회귀. 이번 완료는 추가 정비분이며 전체1단계나 AI 하네스 완료가 아닙니다.

## 스텝 1 날짜·수량·공통 기준 통합 — 2026-09-18

- **현재 작업 상태:** 전용 worktree `dentlink-client-dlds`/`feature/DL-16466`, base/HEAD `de2ffdd9e` 그대로이며 제품 변경은 미커밋입니다. 최종 확인 때 원본 `dentlink-client`는 별도 작업 종료 후 master/de2ffdd9e로 돌아와 있었습니다. 원본 체크아웃은 이 작업에서 수정하지 않았습니다. 실행은 localhost5177이며 호스팅·제품 커밋/push/PR은 하지 않았습니다.
- **추가 코드:** DateField의 형식별 파싱·disabled/inputProps.disabled·빈 문자열 초기화·onlyCalendar를 보완하고 달력 조작의 불필요한 form 제출을 막았습니다. 날짜 입력 순수 함수를 `configs/utils/dateInput.ts`로 원문 그대로 분리하고 기존 export를 유지했습니다. 좁은 폭에서 월·연도가 글자 중간에 끊기지 않도록 월 이동 버튼을 다음 줄로 보냅니다.
- **수량/선택:** Slider의 초기값·step/범위 보정·min=max 트랙, Stepper 직접 입력 콜백·0↔1 경계 버튼·외부0초기화를 수정했습니다. 새 `defaultCount`를 권장하되 오타 `defalutCount`도 유지합니다. Stepper small 버튼32/입력40/아이콘18, medium48/아이콘20, outlined gray300으로 Figma에 맞췄습니다. ChipSelectGroup은 선택 상태·키보드·PC40/모바일37px, Core 빨간 점4px을 유지하며 class 기반 스타일을 정리했습니다. Badge는 흰색 토큰만 연결했습니다.
- **카탈로그/공통 기준:** 기존17종에 날짜 입력·달력·Slider·Stepper·ChipSelectGroup·Icon을 더해 컴포넌트23종, Foundation1개를 합친24개 항목입니다. Theme 색상96개·원본 팔레트·radius·breakpoint를 직접 읽고 IconType과 같은 실제 아이콘411개를 검색/선택합니다. Figma 색상89개를 대조해 redViolet 빈 값7개를 채웠습니다. 날짜 예제는 지연 로드하여 최종 main chunk458.52kB, 날짜91.95kB로 분리했습니다. 제품 앱의 라우트나 배포 설정은 변경하지 않았습니다.
- **검증:** 대상 strict tsc/ESLint/diff check/production build 통과. 전체 UI HEAD 비교 baseline579/current579/added0/resolved0. 임시 회귀는 Dropdown11+Tooltip2+날짜14+Slider/Stepper9=36건 통과. ChipSelect는 독립 Chromium에서 클릭·Enter·Space·form0·치수·숫자0/개수0/빨간점4 확인. CUA 통합 화면에서 날짜19/09/2026→2026-09-19, 초기화/disabled, 달력선택, Slider step3/max10→9, Stepper0↔1/직접입력/32px, Icon검색/선택코드, 팔레트9색·390px가로넘침없음·달력제목 수정 확인했습니다. 이전6/17종 검증은 아래 기록을 이어받습니다.
- **기준 차이/미완료:** Figma Medium500 vs theme400, Figma full1000px vs 원형50%, Figma 달력 기본셀46 vs 코드40, 별도 Chip페이지 별표8 vs Core점4를 구분했습니다. 전역 값을 일괄 교체하지 않았습니다. 날짜 수동입력의 업무상 제한·기간 달력·날짜 셀 키보드·전체 focus trap·실제 휴대폰/제품 페이지는 후속 검증입니다. 간격/그림자/테두리의 공통 토큰 정비도 남았습니다.
- **기록:** DL-16466 진행 현황에24항목·실제 수정·검증36건·남은 범위를 반영했습니다. Notion 회의 방향은 그대로입니다. 팀 문서는 `shared/ui/README.md`, 개인 이력은 이 파일로 분리합니다. 제품 미커밋 변경은 다른 기기에서 이 메모리 저장소만 pull해도 복구되지 않습니다.

## 스텝 1 추가 정비 — 2026-09-18

- **사용자 재확인:** 기존 master 기반 전용 worktree에서 계속 진행합니다. 실제 서비스의 공통 컴포넌트 코드를 수정하고 확인 페이지가 해당 코드를 직접 import합니다. 현재 localhost5177만 실행하며 호스팅은 하지 않았습니다. 검증은 CUA의 Codex 내장 브라우저를 사용했고 사용자가 열어둔 Chrome은 필요하지 않아 조작하지 않았습니다.
- **Git 상태:** 구현 worktree/branch/base는 그대로입니다. origin/master를 fetch하여 HEAD와 동일한 `de2ffdd9e` 확인. 원본 worktree는 다른 작업으로 `26f08b9df`까지 진행된 것을 확인했으며 수정하지 않았습니다. UI의 누락된 `react-device-detect` 직접 의존성을 기존 workspace 버전으로 추가했고 lockfile은 해당 importer 3줄만 변경했습니다(첫 정비 때와 달리 이번에는 의존성 선언 변경 있음).
- **실제 코드 정비:** Dropdown 3종의 falsy 값, disabled clear/닫기, 최신 outside callback, id/오류 연결, 화살표·Home/End·Escape/선택 후 focus 복귀를 보완했습니다. Tabs/Segment의 form 제출 방지, CategoryTab 버튼, Chip 키보드 클릭·삭제를 정비했습니다. 기존 `.chip > svg` 소비자를 위해 구조를 보존했습니다. Segment 최신 Core 기준 외곽32/40/52px·기본 글자14/14/16px, 명시 textVariant는 유지합니다.
- **Overlay/공통 코드:** Modal Escape가 최신 onClose를 사용하고 자신의 backdrop만 처리합니다. 취소 전용 footer와 inline Portal을 수정했습니다. Modal/DropdownDrawer는 공유 bodyScrollLock으로 마지막 owner만 원래 overflow/height/scroll을 복구하고 재열림 전 예약 복원을 취소합니다. RN 메시지 생성 함수는 코드 그대로 `configs/utils/rnPostMessage.ts`로 분리하고 기존 export를 유지했습니다. Popup 모바일335/title20·desktop360/title22, Toast font700와 확인된 상태 색상, 숨김 시 pointer-events를 적용했습니다. Tooltip focus/Escape와 안정적인 callback을 보강하고 NONE은 Escape를 소비하지 않도록 했습니다.
- **카탈로그:** 6→17종. 실제 상태 예시·현재 설정 코드에 Dropdown3종, Tabs/CategoryTab/SegmentControl/Chip, Modal/Popup/Tooltip/Toast를 추가했습니다. 데모값은 QA용이며 제품 API를 호출하지 않습니다. 모바일 grid의 min-content 가로 넘침을 수정하고 inline 메뉴가 카드에서 잘리지 않도록 했습니다. Generic Chip과 ChipSelectGroup Figma의 차이는 명시합니다.
- **검증:** catalog strict TypeScript, 변경 파일 ESLint, Vite production build, diff check 통과. 최종 전체 UI를 HEAD 소스로 비교한 결과 baseline579/current579/added0/resolved0입니다(기존 오류는 남음). Dropdown11+Tooltip2 임시 jsdom 회귀13개 통과(후속 날짜 검증으로 총27개까지 확장). Modal 잠금은 desktop/iOS mock, 두 owner 양쪽 해제 순서·중복 해제·재열림/rAF취소 검증. 임시 테스트는 `/private/tmp/dlds-dropdown-check`; 실행은 `cd shared/hooks && pnpm exec vitest run --config /private/tmp/dlds-dropdown-check/vitest.config.mjs`입니다. `/tmp` 별칭으로 config 전달하면 Vite의 실경로 로딩 실패가 있었고 `/private/tmp`로 해결됐습니다.
- **브라우저 검증:** Select0→키보드진입/선택/포커스복귀, Combo검색/선택/disabled값유지, Filter다중선택/Escape/칩키보드삭제, Tabs/Category Enter·Space·폼제출0, Segment3크기/글자/다중선택, Chip삭제시부모클릭0, Modal취소전용·최신값Escape·배경autoClose·scroll복원, Popup desktop/mobile치수·확인, Tooltip포커스/Escape, Toast표시·자동닫힘·숨김pointernone을 확인했습니다. 390px 가로넘침 수정후 page375≤viewport390 확인. 실제 휴대폰 UA의 Drawer·화면리더 및 전체 제품 회귀 검증은 아닙니다.
- **리뷰/기록:** 독립 리뷰에서 발견한 중첩 scroll 복원, Tooltip NONE Escape, 카탈로그 다른 컴포넌트 예시/복사코드 차이를 수정했습니다. DL-16466 진행 현황을 17종·실제 변경·검증·남은 범위로 갱신하고 진행 중 유지. Notion의 회의 방향은 변경하지 않았습니다. 제품 코드는 여전히 미커밋이며 push/PR/배포 없음. 로컬 미커밋 코드는 다른 기기에서 Git 메모리만 pull해도 복구되지 않습니다.

## 스텝 1 첫 정비분 — 2026-09-18

- **구현:** Vite 진입점과 `src/catalog`에 Button(기존/권장 비교), TextInput, Checkbox, Radio, Switch, Typography 6종을 구성했습니다. 검색·props 조작·상태 비교·설정 기반 코드 복사·Figma 상세 링크를 제공합니다. 제품 컴포넌트를 직접 import하고 같은 테마·Pretendard를 씁니다. 기존 Storybook과 public export는 유지합니다.
- **코드 정비:** 버튼 색상 별칭/기본값 처리 4곳을 공통화했습니다. 권장 Button 좌우 여백을 Figma의 10px로, Radio small을16px/내부8px로 맞췄습니다. Checkbox의 `defaultChecked + disabled` 표현을 native `:checked` 기준으로 수정했고 사각형 size 18/24/32px를 지원합니다. 기존 사각형 호출 26개는 small 또는 생략이어서 기본18px을 보존했습니다. Typography text-transform 타입을 맞추고 기초 컴포넌트의 barrel 순환 참조를 줄였습니다.
- **동작·접근성:** InputBase의 라벨 fallback, 오류 상태 및 caption/error 설명 연결을 추가했습니다. 사용자 지정 aria 속성은 보존합니다. Button/Checkbox/Radio/Switch 키보드 focus-visible을 보강했습니다. Vite에서 체크 아이콘이 표시되지 않던 동적 import에 실제 `.tsx` 확장자를 지정하고 기존 캐시·언마운트 보호를 유지했습니다.
- **검증:** 카탈로그 대상 tsc·변경 범위 ESLint·Prettier·git diff --check·Vite production build 통과. 버튼 스타일480조합+size7종의 기존 기본값/alias/상태 우선순위 동일 확인. 전체 UI TypeScript는 HEAD baseline과 초기정비 비교에서579건으로 동일하고 새 진단0건이었습니다(기존 생성파일/다른컴포넌트 오류). 기본 lint의 Storybook plugin중복은 기존문제로, 해당 패키지 config를 명시한 변경파일 검사로 분리했습니다.
- **브라우저:** CUA localhost5177에서 버튼 클릭/disabled/구현전환/코드복사, 체크박스 controlled 및 defaultChecked disabled·사각18/24/32, Radio small16/dot8·상호배제·disabled, Switch변경·large56×36, TextInput입력·오류설명·disabled, 검색과 390px/desktop Typography24→44px 확인. 변경컴포넌트 리뷰에서도 신규 blocker를 찾지 못했습니다. 제품 실서비스 페이지 전체 회귀 QA는 아직 아닙니다.
- **발견한 기준 차이:** Figma S버튼 안내문16px vs 실제 인스턴스/원본14px이어서 코드14px 유지. 기존 public Button 기본높이52px, 권장 refactor40px로 다르며 전역교체하지 않았습니다. Typography의 variant DOM속성을 쓰는 E2E selector가 있어 스타일props 제거는 소비자와 함께 후속 검토합니다.
- **실행/산출물:** `pnpm --filter @dentlink/ui dev --host 127.0.0.1 --port 5177 --strictPort`, 현재 [로컬 카탈로그](http://127.0.0.1:5177). 새 기기에서는 이 로컬 프로세스/미커밋 제품 변경이 자동 복구되지 않습니다. 임시 빌드/검증로그는 `/tmp/dlds-*`에 있으며 제품 저장소에는 개인 QA보고서나 새 테스트 파일을 남기지 않았습니다.

## 아이데이션 2차 팀 회의 결론 · 사용자 확인 — 2026-09-18

### 1. DLDS 정비와 DLOS 참고

- 회의 원문: “디자인 시스템 정비: 코드 정비, 안 맞는 거 맞추기, 인자값 정리 및 안 넣어도 될 정도?”, “디자인시스템 1차인 DLDS부터”, “Storybook은 deprecate 방향도 괜찮으나 전체를 볼 페이지는 필요”. 이 대화에 이어 [DLOS 링크](https://dentlink-dlos.vercel.app/#component-text-field)를 전달받았다는 것이 사용자의 기억입니다.
- **최종 이해:** 사용자가 말한 **v2는 DLOS**입니다. `shared/ui/src/v2` 폴더를 뜻하지 않습니다. 코드 폴더를 근거로 사용자의 버전 명칭을 다시 의심하거나 재질문하지 않습니다. “DLDS를 정비하고 DLOS처럼 정리한다”는 해석이 회의 맥락에 가장 타당하다는 데 정렬했습니다.
- **정비 방향:** DLOS 외의 기존 컴포넌트를 각 컴포넌트의 Figma 요구사항에 맞추고, 코드 불일치와 props·기본값을 정리합니다. “인자를 안 넣어도 될 정도”는 불필요한 설정을 줄이고 합리적인 기본값으로 쓸 수 있게 한다는 해석이며 모든 props 제거를 뜻하지 않습니다.
- **DLOS의 역할:** 컴포넌트 모습·상태·사용법을 한곳에서 확인하는 정리 방식의 참고 모델입니다. 앞선 브라우저 확인에서는 Figma Core 토큰, 상태·상호작용·반응형 미리보기, Code/Props/Tokens와 `@dentlink/dlos` 사용 예시를 봤습니다. 정확히 같은 화면 복제나 패키지 통합·폴더 이동·전체 마이그레이션까지 결정된 것은 아닙니다.
- **해석 정정 이력:** 처음에는 DLDS=v1/DLOS=v2로 기록했다가 사용자의 가능성 질문과 코드 폴더 때문에 과도하게 불확실성을 강조했습니다. 이후 사용자가 폴더 개념과 무관함 및 링크를 받은 회의 순서를 설명해 위 이해로 정리했습니다. 이전 불확실성 기록은 이 최신 설명으로 대체합니다.

### 2. AI 프롬프트·하네스 정비가 핵심

- **회의 용어 보완:** 사용자는 회의에서 ‘하네스’라는 단어를 직접 들었다고 확인했습니다. FE가 한 번 환경을 갖춰 두고 비개발자도 편하게 반복 사용할 수 있게 하려는 개념입니다. 지속적인 규칙·도구 유지보수가 불필요하다는 뜻은 아닙니다.
- **사용 시점과 목표:** 보통 FE는 완성된 Figma 링크를 받아 개발하지만, 이번 환경은 **Figma 시안이 나오기 전 기획·디자인 단계**에서 사용합니다. PM·디자이너가 프롬프트만으로 화면과 의도를 구체화해 기존에 FE가 전달받던 Figma 디자인에 준하는 수준의 결과를 얻는 것이 목표입니다. 앞선 ‘Figma 링크 없이 구현’이라는 표현은 이 맥락으로 이해합니다.
- **하네스의 역할:** FE가 실제 컴포넌트·디자인 규칙·프롬프트·스킬·도구와 요구사항 확인·생성·검증 절차를 연결해 환경을 준비합니다. 비개발자는 매번 개발 환경이나 복잡한 지침을 설정하지 않고 자연어 요청·결과 확인·수정 요청을 반복할 수 있어야 합니다. 부족한 요구사항은 AI가 재질문하고 프로젝트 기준에 맞는 결과를 만들도록 제어합니다.
- **예상 흐름:** FE가 하네스 준비 → PM·디자이너의 기획·디자인 요청 → 필요한 정보 재질문 → 실제 컴포넌트 기반 화면 생성·확인·수정 → FE 검토·제품 기능 연결. 결과 화면과 코드의 실제 FE 재사용은 계속 핵심입니다.
- **검증:** 디자인 기준 준수·화면 완성도·코드 품질·비개발자 사용 편의성·반복 일관성·FE 수정 작업 감소를 실제 사용 과정에서 확인합니다. 아직 품질·작업 절감 효과·소요 기간을 측정하지 않았습니다. Figma 파일 생성, 미제공 시안의 정확한 복제, 제품 데이터·권한·업무 기능의 자동 완성까지 약속하지 않습니다.
- **에디터와의 관계:** 비개발자가 하네스를 사용하는 경험은 이 핵심 AI 단계의 목표입니다. 이후 에디터는 요소를 직접 선택·조작하는 등의 추가 편집 기능이며, 비개발자 사용성을 에디터 단계까지 미루지 않습니다.

### 3. 회의 메모 연결과 에디터 확장

- **PM·디자이너도 FE 코드 기반:** Figma 시안 이전 단계에서 실제 제품 컴포넌트로 기획·디자인을 구체화하고 FE가 화면과 코드를 이어받는 목적입니다. 비개발자가 복잡한 개발 설정 없이 쓸 수 있어야 합니다.
- **스킬·하네스:** 회의에서 직접 언급한 개념입니다. FE가 AI 자료·실제 컴포넌트·규칙·도구·재질문·생성·검증 절차를 갖춰 두고, 비개발자가 프롬프트로 반복 작업하는 환경입니다.
- **`/design/`, `/publish/`:** 제작·미리보기 페이지 아이디어입니다. 경로·제공 방식은 미정이며 실제 운영 배포 기능을 승인한 표현이 아닙니다.
- **Orca·요소 선택기:** 화면에서 부분 선택 → 컴포넌트·코드 위치 확인 → 해당 부분에 자연어 수정 요청하는 경험의 참고입니다. 특정 Orca 제품 도입이나 구현 방식은 정하지 않았습니다.
- **Storybook 폐기 가능:** 대체 가능성을 열어 두되 전체 컴포넌트 확인 공간은 유지합니다. 실제 폐기 여부·시점은 추후 판단합니다.
- **과거 퍼블리셔 비유:** 실행되는 화면과 코드로 의도를 전달하고 FE가 실제 개발로 이어가는 협업 방식입니다.
- **에디터:** 디자인시스템과 AI 작업 방식이 충분히 정리된 뒤 필요하고 가능하면 실제 컴포넌트를 조작·수정하는 편집기를 개발합니다. 에디터 완성을 필수 성과로 고정하지 않습니다.
- 이전의 “목록 화면 1종·열/필터 설정 JSON·12~19일”은 당시 제한된 제안의 구조와 추정입니다. 새 AI 중심 과제의 확정 구조나 일정으로 재사용하지 않습니다.

### 다음 구체화 항목

1. 정비할 실제 컴포넌트 목록·기준 Figma·기존 사용 화면 영향·정비 완료 기준, DLOS에서 참고할 확인 페이지 구성.
2. 대표 기획·디자인 요청·화면과 최소 입력, 하네스의 비개발자 사용 편의성·디자인 완성도·코드 검증 및 실제 FE 작업 절감 확인 방법.
3. 기존 컴포넌트로 해결하기 어려운 신규 UI의 제안·팀 검토·추가 절차. AI 추천을 그대로 공식 기준으로 삼을지는 합의되지 않았습니다.
4. PM·디자이너의 요청·미리보기 환경과 FE가 화면·코드를 이어받는 방식.
5. 검증 이후 에디터의 필요 기능·구조·작업일. 위 항목은 사용자와 계속 논의하며 발전시키고, 지금 모두 재질문해 기록 작업을 막지 않습니다.

### 이번 기록의 검증과 이전 코드 관찰

- **완료된 Jira 2개와 링크 위치 보완:** DL-16464·DL-16465는 원래 각각 Notion URL만 있었습니다. 사용자 후속 확인에 따라 각 작업의 정리한 내용과 읽기 쉬운 자료 링크를 작성했고, DL-16465에는 이후 최종 과제 선택을 별도로 연결했습니다. DL-16466의 기존 하단 Notion 링크는 상단 ‘회의 자료’로 이동해 중복을 없애고 다음 단계 표현에 ‘하네스’를 반영했습니다. 세 작업 모두 재조회에서 본문 일치·완료/진행 상태·담당자·상위 관계 보존을 확인했습니다. 완료는 후보 자료·논의 완료를 뜻하며 제품 구현 완료로 기록하지 않았습니다.
- **하네스·사용 시점 보완:** 사용자가 회의에서 ‘하네스’를 직접 언급했으며 Figma 시안 이전에 비개발자가 프롬프트로 기획·디자인하는 환경이 목적이라고 추가 설명했습니다. Notion의 AI 단계·하네스 표·검증 항목과 에디터 확장 문구, Jira DL-16437의 AI 설명·진행 순서·검증 항목에 반영했습니다. DL-16466의 DS 범위는 그대로입니다.
- **후속 Jira 정리:** 기존 DL-16437의 FE 자체 업무 발굴 목적을 유지하면서 2차 회의 결론과 DS → AI 핵심 → 조건부 에디터 순서를 반영했습니다. 비어 있던 DL-16466 설명에 Figma 기준·props/기본값·전체 확인 페이지·Storybook 대체 검토와 다음 구체화 항목을 작성했습니다. 재조회에서 두 설명이 의도한 본문과 일치하고 제목·담당자·상태·상하위 관계가 그대로임을 확인했습니다. 별도 댓글·새 작업·일정은 추가하지 않았습니다. 세부 회의 기록과 후속 논의의 원본은 새 Notion으로 유지합니다.
- 새 Notion은 회의 결론 → 단계별 방향 → 회의 메모 6개 표 → 앞으로 구체화할 부분 → 이전 논의의 5개 섹션으로 작성했습니다. 재조회와 별도 내용 검토에서 메모 누락·과잉 확정이 없음을 확인했습니다. 이전 Notion은 결론 링크만 추가했고 후보 본문은 변경 없이 보존된 것을 확인했습니다.
- 이번에는 개인 저장소를 `git pull --ff-only`로 동기화하고 Notion·Jira를 조회했습니다. 제품 코드·Sites는 수정하거나 실행하지 않았습니다. runtime memory에도 최신 해석을 담은 작은 보충 기록을 남깁니다.
- **이전 읽기 전용 코드 관찰(현재 Git 상태 아님):** 당시 web checkout은 `feature/amplitude-pageview-tracking`, HEAD `de2ffdd9e3025cb758632788cd6086c170e4974e`, `clinic/src/common/hooks/useAmplitudeInit.ts` 수정 상태였습니다. 기존 TextInput 사용, `shared/ui/src/index.ts`의 DLDS·일부 v2 export, 기존/v2 InputBase 기본값과 Storybook 예시를 확인했습니다. 이 경로·기본값 차이는 사용자의 DLOS/v2 의미와 별개이며 차이만으로 결함이나 마이그레이션 정책을 단정하지 않습니다. 후속 구현 때 최신 저장소를 다시 확인합니다.

## 병행 업무 분리 — 2026-09-18

- 사용자는 병행 후보가 1차 회의에서 선정한 안건에만 붙는 표시가 아니라 **전체 아이디어 중 메인 업무와 함께 할 수 있는 작고 빠른 독립 업무**라는 뜻이라고 정정했습니다. 기존 초록 제목 2개·범례·작업일 옆 병행 문구를 제거했습니다. 앞으로 메인 안건에 병행 마커를 다시 붙이지 않습니다.
- Notion은 **메인 안건 → 빠르게 병행할 업무** 두 큰 구역으로 나눴습니다. 위쪽의 기존 11안과 사진 자동 배분 V2, 구현 조건·기간·마지막 사진 흐름 추천은 보존했습니다. 첨부 개선 전체 4~7일은 작은 업무로 간주해 쪼개지 않고 메인에 유지합니다. 디자인시스템 4~7일은 에디터의 선행 작업이며 에디터 12~19일에 포함되는 관계를 유지합니다. 아래 목록과 중복 등록하지 않았습니다.
- 1차 Notion의 **42개 아이디어·협업 확장안 7개**를 읽고, 실제 코드에 근거가 있고 독립적으로 완료할 작은 범위 6개를 선정했습니다. 목록은 이름·예상 작업일·짧은 설명으로만 표시합니다. 넓은 원래 아이디어 전체를 아래 기간에 끝낼 수 있다는 뜻이 아니며 각 행의 한정된 범위에 대한 정적 검토 기반 추정입니다.
  - 주문 정보 복사(원래 ‘주문 정보 복사·내보내기’): 치과·랩 웹의 주문번호·상세 링크 복사, **1~2일**. `shared/ui/src/OrderDetailUI/parts/BoxComponent/OrderDetailBoxTitle/OrderDetailBoxTitleDesktop.tsx:244`에서 현재 번호 표시 확인. 기존 권한을 쓰며 개인정보·파일 내보내기 기능까지 포함하지 않습니다.
  - URL·주문번호 링크 표시(원래 ‘HTML·링크 표시 규칙 정리’): 같은 링크톡 메시지의 두 링크를 함께 처리, **2~3일**. `shared/ui/src/LinkTalkUI/parts/LinkTalkListItem/utils/listItemUtils.ts:65`, `shared/configs/utils/utils.ts:494`에서 URL 링크가 있으면 주문번호 처리를 건너뛰는 조건 확인. 기존 상세 이동·권한과 주문번호 인식 기준을 유지합니다.
  - 파일 미리보기 접근성(원래 ‘핵심 화면 접근성 개선’): 대화 버튼의 접근성 이름·열림 상태·포커스 보강, **1~2일**. `shared/ui/src/LinkTalkUI/parts/LinkTalkCarousel/LinkTalkCarouselHeaderControls.tsx:48`. 이미 네이티브 버튼이므로 키보드 사용이 전혀 안 되는 현상이라고 주장하지 않습니다. 문구·번역 확인이 필요합니다.
  - QA 제보 자동 수집 개선: 재현 환경의 누락 정보 보강, **2~4일**. `shared/qa-widget/src/QAWidget.tsx:88`의 기존 화면 캡처·로그·URL·브라우저·시각은 유지하고 화면 크기·언어·시간대·버전 등을 추가하는 범위입니다. 기존 Jira 제보 연동과 검증 권한을 활용하고, 새로운 제보 시스템을 만드는 과제가 아닙니다.
  - PR 자동 검증 강화: E2E 실행기 변경 PR에 기존 `e2e:check` 연결, **2~3일**. `package.json:45`, `.github/workflows/clinic_stg_e2e.yml:99`에 기존 검사·STG 실행 근거가 있습니다. PR에서 실행·결과 표시하는 범위이며 필수 검사 지정은 관리자 확인이 필요합니다.
  - 웹 E2E 업무 시나리오 보강: 링크톡 첨부 전송 결과·주문 재진입 후 유지 검증, **3~5일**. `e2e/clinic/specs/06_linkTalk.spec.ts:105` 이후 현재는 전송 호출 후 끝나는 점 확인. 기존 테스트 환경·계정·첨부 권한을 활용하며 발견한 제품 결함 수정까지 포함한 공수는 아닙니다.
- 개인 메시지 템플릿은 어드민에 이미 활성화돼 있어 새 작은 기능으로 제안하지 않았습니다(`admin/src/components/LinkTalk/OrderLinkTalk.tsx:176`). 필터는 URL 상태 저장과 이름 붙인 보기 저장을 구분해야 하며, 초안 복원은 주문·계정 전환과 보관 범위가 더 필요해 이번 목록에서 제외했습니다. 시각 회귀·상태 체험은 메인 DS 범위와 겹칠 수 있고, 날짜·API 타입·의존성 정리는 이번 검토에서 작은 완료 범위 근거가 충분하지 않아 억지로 넣지 않았습니다.
- 검증: 개인 저장소와 web을 pull했고 web은 `master de2ffdd9e3025cb758632788cd6086c170e4974e` 그대로 깨끗합니다. Notion 재조회에서 메인 12개 안건의 내용·조건·기간 보존, 병행 목록 6개, 기존 초록·병행 마커 0개를 확인했습니다. 요청한 수정과 readback은 Notion이 정리한 빈 줄만 달랐습니다. 1차 페이지·Sites·제품 코드는 수정하지 않았으며 실제 개발·테스트 실행·배포도 하지 않았습니다.

## 2차 회의 자료 작성 완료 — 2026-09-17

- 사용자는 오늘 대화를 자료로 정리하되 불필요한 내용은 빼고, 필요한 내용은 최대한 담아 한눈에 들어오게 요청했습니다. 기존과 별도 페이지 사용을 허용했고, 신규 데모 사이트 없이 필요한 도식/시각자료를 사용하기로 했습니다.
- 9월 17일 최종 구성은 **기존 후보 링크 → 4개 주제별 11개 안건 → 사진 자동 배분 V2 → 별도 최종 추천**이었습니다. 각 안건의 **(대상) 업무명 → 기간 → 내용 또는 흐름 → 구현** 순서는 유지합니다. 당시 초록 병행 표시 2개는 위 9월 18일 분리 요청으로 폐기했습니다. 사용자는 ‘하는 일’도 어색하다고 지적해 ‘내용’으로 통일했습니다. 사용자 흐름에는 실제 조작을 쓰고 내부 처리를 섞지 않습니다. 표·이미지·접기·긴 서문·관리용 식별자·기간 세부 분해·중복 해설은 복원하지 않습니다. 처음 읽는 FE 동료가 채팅의 추가 설명 없이 이해할 수 있는 실제 서비스 용어와 동작을 우선합니다.
- **에디터에서 줄이면 안 되는 핵심:** 최신 항목은 **내용 / 사용 예시 / 구현 / 가능 범위** 순서입니다. PM·디자이너의 화면 구성 결과를 제품 코드에 재사용하는 내부 편집기이며, FE가 준비한 목록 화면에서 열·필터·문구를 바꾸는 제한된 검증안입니다. **적용 화면은 미정이고 주문목록은 제가 산정을 위해 넣었던 예시이지 팀의 확정 요구사항이 아닙니다.** DS 정비를 포함한 12~19일은 대상 화면에 따라 조정할 추정입니다. 미리보기와 제품이 같은 화면 코드를 쓰되 실제 데이터·권한·업무 동작은 FE가 연결합니다. 새 배치·컴포넌트·기능은 추가 개발이고 실서비스 반영은 FE 검토·적용·배포를 거칩니다. **반복 수정에서 줄어드는 FE 작업이 편집기 제작·유지 부담보다 큰지는 아직 검증이 필요합니다.** AI·자유로운 화면 제작은 확장안입니다. DS의 ‘6~10개 컴포넌트’도 임의 산정 가정이므로 회의 문서에서 제거했으며 대상 화면에 필요한 공통 컴포넌트 정비로 한정합니다.
- 사진 아이디어는 **주문 선택 후 사진 보내기**(8~13일)와 **촬영한 사진을 여러 주문에 배분**(10~15일)으로 구분합니다. 첫 안의 사용자 흐름은 **기본 카메라로 오더지 QR 스캔 → 촬영 또는 갤러리 선택 → 해당 주문 링크톡 전송**이며 앱에서 직접 주문을 선택하는 대안도 남겼습니다. 로그인·권한·선택 주문 유지와 앱 내 신규 QR 스캐너 설명은 사용자의 요청으로 간단한 흐름에서 제거했습니다. 인증이 불필요하거나 신규 스캐너까지 기본 견적이라는 뜻이 아닙니다. 앱 중심 작업으로 설명하되 기존 오더지 QR의 실제 앱 주문 진입을 확인하고 필요하면 연결을 보완한다는 조건은 유지합니다. 두 번째는 별도 화면에서 사진 한 장 또는 여러 장의 주문을 검색·지정하고 주문별로 확인·전송합니다. ‘미배정’, ‘첫 첨부’ 대신 주문을 지정하지 않은 사진, 대화 이력이 없는 주문에도 전송할 수 있는지로 풀어 썼습니다. QR은 필수가 아니며 두 업무의 기간을 누적 견적으로 혼동하지 않습니다.
- **운영팀 주문 생성:** ‘상품군 1개·템플릿 2~3개’는 임의 가정이었으므로 삭제했습니다. 실제 화면의 **카테고리·상품·상품 옵션** 조합 저장/불러오기로 반복 입력을 줄이고 환자·치아 등 주문별 정보는 확인·입력하는 제안입니다. web `de2ffdd9e`에서 단계명(`OrderProgress.tsx`)과 필드, `admin/src/lib/OrderForm/useOrderOptionUpdateForm.ts:176`의 치과 설정·Case Preference 기본값을 확인했습니다. 기존 기본값·생성 API·권한·검증을 유지하고 개인 브라우저 저장부터 검토하며 공유·대량 등록은 별도입니다. **7~11일은 저장 항목 확정 후 조정**합니다. 아래 초기 공수 가정의 상품군·템플릿 개수를 확정 요구사항으로 복원하지 않습니다.
- **QA 데이터 생성:** 사용자는 PM·디자이너가 CI 화면에 직접 접속하는 가정을 지적했습니다. 최신안은 **내부 생성 화면에서 필요한 주문·상태 선택 → 생성 → 진행·결과 확인 → 주문 열기**입니다. 뒤에서 기존 E2E를 활용한 생성 전용 작업을 실행하며 테스트 환경·계정·권한·데이터 정리가 필요합니다. **생성 화면 포함 10~17일은 기존 실행·결과 조회 연동을 재사용할 수 있을 때의 조건부 추정**이며 해당 연동이 없으면 서버·인프라 협업과 재산정이 필요합니다. 아래 7~12일·CI 직접 실행·별도 화면 추가 범위는 이전안 이력입니다.
- 기간은 **8~13일** 형식의 총합만 표시합니다. 실패 조사+복구 6~11일, 속도 분석+FE 개선 5~10일, 디자인시스템 대상 정비+한 화면 에디터 12~19일입니다. 미산정으로 남았던 사진 배분은 10~15일, 파일 탭은 7~10일, 어드민 상세는 7~11일로 후속 정적 검토·범위 가정에 따라 보완했습니다. 확정 견적이 아닙니다. 비교에 필요한 범위·의존성은 각 행에, 코드 위치·세부 산정 근거는 개인 기록에 유지합니다.
- 앞서 만든 **photo-flows-v2.png**, **editor-flow-v2.png**는 사용자가 불필요하고 워크플로우 설명으로 부족하다고 평가해 현재 문서에서 제거했습니다. 필요한 내용을 각 안건의 흐름·구현 조건으로 옮겼습니다. 새 이미지·별도 자료를 만들지 않았습니다. 임시 SVG·생성 스크립트는 `/tmp/dentlink-fe-second-meeting/`에 남지만 팀 문서의 현재 자료는 아닙니다.
- **사용자 삭제 존중:** 사용자가 서문·기간 기준·함께 고를 때 주석을 직접 삭제했음을 최신 Notion에서 확인했고 복원하지 않았습니다. 아래 세부 산정 근거는 개인 기록에만 유지합니다. 현재 항목에 남아 있던 에디터의 DS 포함 관계는 유지했습니다. **병행의 의미를 정정:** 사용자가 원한 것은 작은 부분을 떼어내는 것이 아니라 안건 전체가 다른 주요 업무와 별도로 병행하기 좋은지입니다. 이전 부분 병행 해석과 3개 표시를 폐기하고, 업로드 전 파일 점검·링크톡 첨부 개선(4~7일)과 제한된 디자인시스템 정비(4~7일)의 제목 자체만 초록으로 표시했습니다. 어드민 상세는 전체 범위 기준으로 표시를 제거했습니다. 디자인시스템은 에디터도 선택하면 선행 작업이며 에디터 기간에 포함된다는 관계를 본문에 명시했습니다. 병행은 추천 후보이며 동시 수행 일정·인력 배정 확정이 아닙니다.
- 사진 배분 예시는 30장을 여러 번 선택해 모으고, 주문별 전송은 기존 개수/용량 제한을 지키는 가정으로 보완했습니다. 자동 사진 분류, 앱 종료 복원, 기기 간 동기화는 추가 범위입니다.
- **최종 문구 검토:** 사용자가 부분별 지적을 마쳤다고 해 최신 Notion 전체를 다시 검토했습니다. ‘하는 일’ 8곳을 ‘내용’으로, 에디터의 ‘FE가 개발할 것’을 ‘구현’으로 통일했습니다. 첨부 재전송·사진 배분·속도 측정·파일 출처 설명을 풀어 쓰고 QA 연동의 중복 설명을 줄였습니다. ‘응답 유실’은 전송 후 완료 여부를 확인할 수 없는 경우로, 어드민의 ‘펼쳐 보는 구성’은 한 페이지의 주문 정보와 스크롤 중 식별 정보 표시·파일/배송 바로가기·배송 재조회·파일 이동/복사 전 주문 확인으로 이미 정정했습니다. 속도 개선은 FE 점검이 우선이며 서버·인프라 원인의 추가 검토도 필요하다는 목표를 유지합니다.
- **최종 readback:** 의도한 부분 수정 후 전체 본문이 예상 문자열과 완전히 일치했습니다. 12안건·11개 작업일·초록 제목 2개·V2 3×5cm/인식 검증 후 산정·에디터 효과 검증·QA 연동 조건·독립 최종 추천이 보존됐습니다. 표/이미지/접기 0, ‘하는 일’과 지적된 모호한 기존 표현 0입니다. 이는 문서 일관성 검토이며 새 기능 구현·API 실행·속도/인식 실측 검증을 의미하지 않습니다. 다음에는 이 Notion을 최신으로 읽고 FE 회의에서 후보를 선택·구체화합니다.
- 초기 표/도식 작성 단계에는 Notion 재조회와 브라우저 표시를 확인했습니다. 이후 사용자가 제거한 자료는 현재본에 복원하지 않습니다. 1차 Notion·Sites·제품 코드·공개 권한은 변경하지 않았습니다.

## 추가 아이디어 — 사진 속 주문 마커 자동 인식 V2 (2026-09-17)

- **사용자 최종 편집 확인:** 최신 Notion(2026-09-17T10:02:00.183Z)에서 사용자가 V2의 마지막 추천을 문서 끝 `앱 · 파일·링크톡 관련 현재 추천`으로 분리하고 주문 한 번 선택→여러 장 촬영→확인·전송→다음 주문 선택만 남겼습니다. 기존 11개 안건은 동일하고 V2의 3×5cm·OCR/선택적 QR·실물 사진 검증·작업일 산정 전제·수동 예외 처리는 유지됩니다. 필수 정보 손실이나 의미 충돌은 발견하지 못했고 독립 검토도 유지 의견이었습니다. 이번에는 Notion을 수정하지 않았습니다. 삭제된 추천의 부연 설명을 다시 복원하지 않습니다.
- 사용자는 제품과 주문번호 스티커를 함께 찍은 사진 여러 장을 한 번에 올리면 번호를 읽어 주문별로 자동 배분하는 아이디어를 제안했습니다. 기존 수동 배분과 별개 V2로 둘 수 있다고 했으며 제품 구현 착수는 아닙니다. Notion의 기존 11개 안건은 그대로 보존하고 마지막 `추가 아이디어`에 **(기공소 앱) 주문번호 인식으로 사진 자동 배분·일괄 전송 · V2**를 추가했습니다. 재조회에서 기존 본문 완전 보존·V2 포함 총 12개 안건을 확인했습니다.
- 흐름: 식별 스티커 출력·부착 → 한 주문의 제품과 마커를 함께 촬영 → 사진 여러 장 선택 → OCR/사진 속 QR로 식별값 읽기 → 접근 가능한 주문과 대조 → 주문별 자동 분류를 사용자가 확인·수정 → 기존 첨부 제한에 맞춰 주문별 링크톡 전송. 인식 실패·복수 번호·조회 불일치는 수동 배정합니다. 제품 모양을 AI로 판별하거나 확인 없이 자동 발송하는 안이 아닙니다. 최초의 주문번호+QR 추천은 아래 실제 라벨 제약에 따라 조건부 선택안으로 정제했습니다.
- **실제 라벨 크기·현시점 추천:** 사용자는 현장 라벨이 보통 약 **3×5cm**라 크기가 제한되며 V2 내용을 통째로 바꾸지 말고 이 조건을 반영해 달라고 했습니다. 기존 치과·환자·의사 정보를 유지하면서 번호를 넣을 공간과 가독성을 확인합니다. QR은 필수가 아니고 실제 제품과 함께 찍은 사진에서도 판독될 때 채택할 선택안입니다. 라벨만 확대해 찍은 테스트로 충분하다고 보지 않으며 실제 출력 크기·촬영 거리·반사·초점을 검증합니다. 사용자는 최종 현실적 추천도 요청했습니다. 현재 추천은 **QR 또는 앱 주문목록에서 주문 한 번 선택 → 해당 주문 사진 여러 장 촬영 → 확인·전송 → 다음 주문 선택**입니다. 사진마다 QR을 다시 찍도록 만들 필요는 없고 주문이 바뀔 때 전환합니다. 이미 찍어 둔 여러 주문의 사진은 앞서 제안한 수동 배분안이 기본이며, V2 자동 분류는 실제 3×5cm 라벨 검증 후 확장하는 순서입니다. Notion에서 기존 11개 안건·V2 흐름/구현은 보존하고 인식/스티커 설명만 정제한 뒤 현재 추천을 추가했습니다. 재조회로 의도한 본문과 일치 및 기존 안건 보존을 확인했습니다.
- **스티커 코드 확인:** web `de2ffdd9e3025cb758632788cd6086c170e4974e`의 `lab/src/components/PrintShipment/sticker/PrintShipmentStickerList.tsx:43`은 `orderId`를 전달하지만 `PrintShipmentStickerListItem.tsx:28`은 이를 주석 처리하고 Office/Patient/Dentist만 출력합니다. 현재 템플릿에는 주문번호·QR이 없어 그대로 재사용된다고 주장하지 않습니다. 데이터가 있으므로 출력 보완을 FE에서 검토할 기반은 있습니다. 주문서에는 주문 상세 URL QR(`shared/ui/src/OrderDetailUI/extra/OrderDetailPrint.tsx:191`, `lab/src/pages/orders/[order_id]/index.tsx:321`), 배송 명세서에는 주문 ID와 `https://abr.ge/40vjsg?orderId=...` QR(`lab/src/components/PrintShipment/label/PrintShipmentDetails.tsx:187`)이 있으나 개별 제품 스티커와는 다릅니다. 운송장 이미지 안의 바코드를 주문 식별자로 가정하지 않습니다.
- **앱 코드 확인:** app `e0f4d5dd996a691b32a5ba288d826abb039105ce`의 `shared/models/Api.ts:8170`에서 주문번호 검색은 숫자 `orderId`, 응답은 `id`입니다. `shared/services/lab.service.ts:59`에 주문 검색/상세, `shared/services/linktalk.service.ts:46`에 첨부 전송 기반이 있습니다. 현장 마커가 이 ID인지 확인하고 권한 있는 주문과 정확히 대조해야 합니다. 현재 VisionCamera/MLKit는 얼굴 감지용이며 정적 사진 OCR/바코드 기능은 찾지 못했습니다. 인식 SDK 추가 시 RN 0.82.1/New Architecture 호환·네이티브 빌드·양 플랫폼 기기 검증이 필요합니다. `shared/libs/useDeviceSystem.ts:22`의 갤러리는 기본 10장·quality 0.5라 작은 글자 인식용으로 검증된 설정이 아닙니다. 기존 전송 제한은 10개·합계 200MB 미만(`shared/features/chat/components/message/MessageInput.tsx:229`)입니다.
- 공식 기술 근거: [ML Kit 사진 OCR](https://developers.google.com/ml-kit/vision/text-recognition/v2/ios), [사진 QR 인식](https://developers.google.com/ml-kit/vision/barcode-scanning/ios). 일반 SDK로 구현을 검토할 수 있고 QR 인식은 기기 내 처리 가능합니다. 새 학습 모델이 반드시 필요한 과제는 아니지만, 실제 출력 크기·반사·기울기·초점·압축에 따른 정확도와 처리 시간은 실제 사진으로 확인해야 합니다.
- 기존 V1 10~15일에 V2 인식 개발을 포함시키지 않았습니다. 새 작업일은 실제 출력물·사진 인식과 식별자 대조 검증 후 산정하는 확장 아이디어로 표시했습니다. 필요한 API·권한이 기존에 충족되면 FE 중심으로 가능하나 미지원 시 서버 협업이 필요합니다. 두 제품 저장소 pull 후 정적 조사만 했고 여전히 깨끗하며 실제 인식 실험·업로드·API 호출·코드 변경·배포는 하지 않았습니다.

## FE 동료 공유용 최종 검토 — 2026-09-17

- **최종 소폭 다듬기 완료:** 사용자 최종 편집을 유지한 채 추가 요청에 따라 `주문 목록`·`파일명` 등 용어와 `·` 구분 표기, 에디터 작업일 옆 괄호, 일부 어색한 문장을 통일했습니다. V2는 QR 조건 문장을 줄이고 `현재 웹 코드`를 정확한 대상인 `확인한 스티커 코드`로 고쳤으며, 3×5cm·정보 유지·제품과 함께 촬영·거리/반사/초점 검증은 보존했습니다. 최신 Notion 재조회에서 전체 예상 본문과 일치, 제목/순서·12개 안건·11개 작업일·병행 제목 2개·V2 검증 후 산정·사용자가 분리한 마지막 추천을 유지한 것을 확인했습니다. 범위·기간·추천 방향을 변경하거나 삭제된 부연을 복원하지 않았습니다.
- **최근 전체 재검토:** 사용자가 억지 수정 없이 현재 문서를 다시 검토해 달라고 요청했습니다. 최신 Notion의 4개 주제·11개 안건을 원문 메모 14개 의미 단위와 대조했고, 2차 FE 아이데이션 회의에 필요한 주요 내용 누락·중대한 설명 모순은 발견하지 못했습니다. 독립 검토도 현상 유지를 권했습니다. 병행 후보 2개의 설명은 작업일 옆 괄호에 있고, 디자인시스템의 에디터 선행/기간 포함 관계가 유지됩니다. 에디터는 4개 설명으로 실제 도구·사용 예시·FE 구현·범위를 설명하며 주문목록은 예시, 대상은 미정, 기간은 검증안 가정입니다. 이번 재검토에서는 Notion 본문을 수정하지 않았습니다. 새 제품 코드 조사·API 연동·실측 검증을 한 것은 아니며 구현 의존성과 효과 미검증 상태는 그대로입니다. 여러 후보를 함께 고를 때 겹치는 첨부 UI 등은 최종 범위·산정 단계에서 확인하며 이전 공수를 단순 합산하지 않습니다.
- 최신 병행 표시 정정 후 Notion 재조회: 제목 초록 표시 2개, 이전 부분작업 표시 0개, 안건 11개와 작업일 11개 유지, 의도한 본문과 완전 일치를 확인했습니다. 아래 초록 표시 3개 검증 기록은 이전 해석 당시 이력입니다.
- 최종 문장 다듬기에서는 현재 리스트 양식을 유지하고 에디터 6개 설명을 4개로 축약했습니다. 실패 조사 후 복구·사진 배분 확인·QA 생성 흐름 등 표현을 명확히 하고, 초록 병행 표시의 의미를 보완했습니다. Notion 재조회에서 예상 본문과 완전 일치, 주제 4개·안건 11개·기간 11개 유지·초록 표시 3개·표/이미지/접기 0을 확인했습니다. 브라우저에서 에디터와 표시 문구의 가독성도 확인했습니다.
- 후속 요청으로 첫 주제명을 **앱 · 파일·링크톡**으로 명확히 하고, 에디터는 위 작동 원리·구현 범위만 확장했습니다. 최신 Notion을 fetch한 뒤 두 위치만 수정했으며 다른 10안·기간·병행 표시·사용자가 삭제한 문구는 그대로 유지했습니다.
- **최신 가독성 수정:** 사용자가 넓힌 표와 삭제된 문구를 다시 fetch해 기준으로 삼았습니다. 표 대신 파일/링크톡, 화면 제작/개발 효율, 운영/QA 데이터, 기존 주문 상세의 4개 주제로 11안 리스트를 구성했습니다. 안건명·대상·11개 기간·범위·FE 조건은 보존했고, 이미지에서 옮기며 주문별 전송 전 확인·DS 빈 화면 상태·명확한 실패만 재시도한다는 의미까지 대조했습니다. readback에서 주제 4·안건 11·부분 병행 표시 3·표/이미지/접기 0·삭제한 서문/주석 복원 0을 확인하고 실제 브라우저 표시도 확인했습니다. 아래 표/도식 검증 기록은 이전 단계 이력입니다.
- 사용자 목적을 재확인했습니다. 1차 회의 의견을 기반으로 구체화된 후보를 2차 FE 회의에서 추리기 위한 자료이며, 과제 선택·착수·기간 확정은 아닙니다. 간결함 때문에 필수 구현 조건을 대화나 개인 기록에만 숨기지 않습니다.
- 앱 5안, DS/에디터/운영/QA 4안, 파일/어드민 및 전체 가독성을 분리해 재검토했습니다. 기술적으로 확인한 기반과 미검증 조건을 표의 각 행에 반영했습니다. 파일 검사·속도·복구, QR로 먼저 주문 지정·나중에 사진 배분, 운영의 실제 주문·QA 상태 생성, 기존 파일 탭·관리자 상세의 목적 차이를 유지했습니다.
- QR은 기존 외부 주문 QR/링크로 앱에 진입하는 제안이며 앱 내 신규 스캐너는 제외합니다. 앱 연결 설정에 웹/인프라 협업이 필요할 수 있음을 표시했습니다. 사진 배분은 앱 실행 중 수동 지정·순차 전송이며 기존 API의 권한/첫 첨부가 미지원이면 서버 협업, 응답 유실은 결과 미확인 표시입니다. 실패 복구는 조사 후 필요한 범위를 구현하며 모든 실패의 해소를 약속하지 않습니다.
- QA는 기존 E2E 전체 실행을 그대로 노출하는 것이 아니라 접수/승인 대기/완료 중 원하는 상태에서 멈추고 확인한 주문 링크를 반환하는 **생성 전용 CI 작업**입니다. 현재 테스트는 이후 피드백까지 진행하므로 분리 개발이 필요합니다. PM/디자이너의 실행권한·계정·데이터 정리, 별도 웹 실행 화면은 추가 범위임을 표에 반영했습니다.
- 에디터는 주문목록 1종의 열/필터/문구와 실제 React 템플릿·설정 재사용을 구체적으로 표시했습니다. 설정 연결 코드·API·권한·업무 로직은 FE가 개발하고 실제 재작성 감소를 검증합니다. AI 연계·범용 편집기는 확장안으로 남기고, 작은 개선 병행 의견은 공통 주석에 유지했습니다.
- 실제 Notion에서 표 상단/하단과 기존 도식 2장 표시를 확인했습니다. 4열 폭을 164/240/224/80으로 배분하고 기간 헤더·QA 업무명 줄바꿈을 정리했습니다. 표 11안·4열·미산정 0·접기 0, 기존 이미지 URL 경로 2개 보존을 readback으로 확인했습니다. 기존 1차 문서·Sites·제품 코드는 변경하지 않았습니다.
- web/app은 pull 후 각각 `de2ffdd9e`/`e0f4d5dd`로 깨끗한 상태였습니다. 이번 검토도 소스 정적 확인이며 실제 주문 생성·메시지 전송·계측·빌드·실기기 검증은 하지 않았습니다. 다음 회의에서 선택할 후보와 확장 범위를 정한 뒤 해당 조건을 구현 전에 검증합니다.

## 누락·산정·FE 단독 가능성 재점검 — 2026-09-17

- 원문 의미 14개를 현재 11개 업무와 대조했습니다. 핵심 기능은 반영돼 있었지만 간소화 중 **AI 목업 연계 검토·작은 개선 병행** 표현이 사라져 표 아래 한 줄로 복원했습니다. 에디터 표 설명은 화면 1종 재사용으로 범위를 명확히 하고, QA 행에는 PM·디자이너를 명시했습니다. 1차 전체 후보는 기존 페이지에 남아 있으며 2차 자료의 생략 후보를 폐기한 것이 아닙니다.
- 미산정 3개는 기술적으로 불가능해서가 아니라 독립 업무 구분 후 범위·추정을 마무리하지 않은 상태였습니다. 아래 제한된 범위를 전제로 사진 배분 10~15일, 파일 탭 7~10일, 어드민 상세 7~11일을 2차 Notion에 반영했습니다. 표 11개 행·4열·이미지 2개 유지, 미산정 0개, 의도한 치환 이외 본문 변경 없음(서명 이미지 URL 제외)을 재조회로 확인했습니다.
- **사진 배분:** 같은 기공소에서 접근 가능한 주문을 수동 지정하고 주문별로 순차 업로드·전송하는 기본안은 기존 API로 구성할 코드 근거가 있습니다. `POST /lab/orders/search` → 주문 확인 → `uploadFile(images)`의 fileIds → `POST /lab/chat-messages`에 `{orderId, chatType:"ORDER", message:"", fileIds}`. 기존 전송에는 chatId나 별도 채팅방 생성 호출이 필요하지 않습니다. `useMessage` 전체 훅은 화면·읽음 상태에 결합돼 있어 별도 화면에서는 서비스 호출과 전송 상태를 분리해야 합니다.
- 사진 배분 10~15일은 갤러리 선택·별도 배분 화면·주문 검색/수동 지정·미배정/동일 선택 사진 중복 배정 확인·기존 제한 내 주문별 전송/결과·iOS/Android 개발자 QA까지의 추정입니다. QR 신규 개발, 자동 분류, 앱 종료 복원, 오프라인·기기 간 동기화, 재선택 파일 내용 해시 판별은 제외합니다. 접근 가능한 주문의 실제 전송 권한·대화 이력 없는 주문의 첫 첨부·응답 유실 때 중복 없는 재전송은 서버 계약/실행 검증 전입니다. 결과 불명은 무조건 재시도하지 않으며, 중복 방지 보장에 기존 기능이 부족하면 서버 지원이 필요할 수 있습니다.
- 사진 코드 근거: app `shared/services/lab.service.ts:59`, `shared/services/linktalk.service.ts:56`, `shared/services/linktalk.types.ts:48`, `shared/libs/useFileUpload.ts:184`, `shared/libs/useMessage.ts:738`, `shared/features/chat/screens/ChatDetailScreen.tsx:342`. 실제 API 쓰기·권한 우회·기기 테스트는 하지 않았습니다.
- **에디터:** 실제 코드 재사용은 가능한 구조이나 현재 화면 설정을 그대로 JSON으로 직렬화하는 기능이 있는 것은 아닙니다. 표 열·필터에 함수/JSX/콜백이 있어 `columns:["id","patientName","status"]` 같은 허용 키를 실제 렌더러·동작에 연결하는 공통 템플릿/어댑터가 필요합니다. 에디터는 샘플 데이터, 제품은 기존 데이터/핸들러를 넣고 같은 템플릿·설정·테마를 사용합니다. 12~19일은 대상 DS 정비+한 템플릿+제품 재사용 검증이며 자유 배치 에디터·AI 코드 생성·Figma 자동 변환·공동 편집 저장소는 제외합니다. 실질적 FE 작업 절감은 아직 미검증입니다.
- 에디터 근거: web `shared/ui/src/DataGrid/DataGridFilters/DataGridFilters.tsx:20`, `shared/ui/src/DataListTable/DataListTable.tsx:14`, `lab/src/pages/orders/index.tsx:47`, `lab/src/lib/OrderList/useOrderList.tsx:109`.
- **파일 탭 7~10일:** 기존에 받은 원주문/리메이크 파일의 회차 표시·파일명 검색·형식 필터·날짜 정렬과 선택/미리보기/다운로드 유지. 승인/링크톡 전체 자료 통합은 제외합니다. **어드민 상세 7~11일:** 펼쳐진 구성·고정 링크톡 유지, 주문 식별 고정/구역 이동, 배송 조회 상태/재시도, 기존 파일 이동/복제 전 대상 주문 확인까지입니다. 기존 API 재사용 가정이며 새 서버 필드·권한 변경은 포함하지 않습니다.
- 다른 업무도 현재 기반을 정적으로 확인했습니다. 운영팀 주문 생성은 기존 어드민 생성/권한 API를 활용합니다. QA 데이터 도구는 기존 E2E/CI로 생성 전용 작업을 만드는 범위이며 실행권한·테스트 계정·데이터 정리는 확인이 필요합니다. 별도 웹 실행 버튼까지 만들려면 인증된 실행 경로가 필요합니다. QR은 앱 링크/로그인·촬영 진입의 실제 기기 검증 전이며, 실패율·속도 개선 효과는 아직 실측하지 않았습니다.
- 이번 검토는 아이데이션의 기술적 근거 보완입니다. web/app을 pull 후 같은 커밋·깨끗한 상태에서 읽었고 제품 코드 변경·테스트/빌드·실제 서버 연동 검증·Sites 변경은 하지 않았습니다. ‘구현 가능한 후보’와 ‘FE 단독 완결·효과 입증 완료’를 구분합니다.

## 추가 메모 재검토 — 파일 탭·어드민 주문 상세 (2026-09-17)

- 사용자가 1차 문서의 `치과나 랩의 파일탭`을 기존 파일 탭과 제안의 차이에 대한 질문으로, `어드민 주문상`을 빠른 확인을 위해 별도로 설계한 관리자 상세의 개선 의견으로 명확히 설명했습니다. Clinic/Lab과 동일하게 만들자는 뜻이 아닙니다. 최초 재검토는 읽기 전용이었고, 이후 문서 간소화 요청에 따라 두 안건을 2차 Notion에 반영했습니다. Sites·제품 코드는 변경하지 않았습니다.
- 1차 Notion을 다시 읽고 web `master de2ffdd9e3025cb758632788cd6086c170e4974e`를 pull 후 정적 확인했습니다. 깨끗한 상태였으며 실행·API 응답·운영 불편·성능은 실측하지 않았습니다.
- **파일 탭:** 치과·기공소 공통 UI에 미리보기/3D 뷰어 연결, 개별·선택 다운로드, 파일 정보·업로더가 이미 있습니다. 현재 탭은 `orderFileList`에서 `remakeCount === 0`만 표시합니다. 리메이크 이력·컨펌·링크톡 첨부는 다른 영역에서 읽습니다. 서버가 자료를 중복 포함하는지는 미확인입니다.
- 후보명은 **기존 파일 탭의 회차·출처별 탐색 개선**이 정확합니다. 첫 범위는 기존 조회 범위의 파일명 검색·형식 필터·날짜 정렬과 원주문/리메이크 회차 표시입니다. 승인·대화 자료까지 빠짐없이 통합하려면 출처/식별자·권한·삭제/중복·전체 페이지 조회 계약 확인이 필요합니다. 단순 미리보기·다운로드 수요라면 기존 기능으로 충족하므로 높은 순위를 자동 유지하지 않습니다.
- **어드민:** 주문·가격·파일·리메이크·승인·배송/결제·메모/기록을 펼쳐서 보는 장점과 넓은 화면의 고정 링크톡을 유지합니다. 파일은 회차별 표시·선택 다운로드·다른 주문으로 이동/복제가 이미 있습니다. 별도 후보명은 **어드민 주문 상세의 빠른 확인·처리 개선**입니다.
- 제안은 ① 주문 식별 정보 고정+구역 바로가기 ② 구역별 로딩/빈 결과/실패 구분 및 재조회 ③ 파일 이동/복제 전 대상 주문의 환자·치과 확인입니다. 배송 컴포넌트는 `!data`를 `isPending`보다 먼저 검사하므로 상태 구분 개선의 코드 근거가 있습니다. 실제 장애 빈도를 확인했다는 뜻은 아닙니다. 첫 범위는 ①+배송 한 구역의 ②, ③은 기존 주문 조회 API·권한·이동 조건 확인 후입니다.
- 근거: `shared/ui/src/OrderDetailUI/parts/BoxComponent/OrderDetailBoxFileList.tsx:30`, `shared/ui/src/FileListDownloadUI/FileListDownloadUI.tsx:79`, `admin/src/pages/orders/[order_id]/index.tsx:585`, `admin/src/components/OrderShipping/OrderShippingList.tsx:19`, `admin/src/components/OrderDetail/OrderFiles.tsx:264`.
- 파일 탐색은 기존 업로드/첨부 UX와, 관리자 상세 처리는 운영팀의 주문 생성 편의성과 구분합니다. 2차 문서의 마지막 두 업무로 반영했습니다. 후속 재점검에서 위 범위를 가정해 7~10일/7~11일을 제시했으며 우선순위는 미선정입니다.

## 아이데이션 1차 팀 회의 결과

2026-09-17 사용자 제공 회의 메모와 후속 설명을 기록합니다. 아래 현재 이해는 사용자의 추가 설명으로 갱신했으며, 이전의 에디터·업무 흐름·주문서·QA 데이터에 관한 의미 불확실성을 그대로 재질문하지 않습니다. 회의에서 최종 과제를 선정하거나 개발 착수한 상태는 아닙니다. 아래는 개인 재개용 메모이며 팀 공유 문서의 새 복사본이 아닙니다.

### 회의 흐름에 따른 3개 주제

- **해석 원칙:** 사용자는 인접한 메모가 회의 중 같은 주제를 이어 적은 내용일 가능성이 높다고 설명했습니다. 원문 순서와 후속 설명을 함께 사용해 큰 주제와 세부 의견을 묶습니다. 나중에 추가한 메모도 있을 수 있으므로 인접성만으로 같은 과제라고 단정하지 않습니다.
- **파일·링크톡 사용 편의성:** 첨부 실패 규모 조사, 업로드 전 점검, QR을 통한 주문별 사진 첨부, 링크톡 첨부 UI, 파일 업로드 속도는 사진·파일을 준비해 올바른 주문에 전달하는 과정의 관련 개선 의견으로 묶습니다. QR은 수단 후보이며 실패 조사가 필요하다는 의견과 실제 실패율을 구분합니다.
- **스쿼드 제작 흐름 효율화:** 워크플로우·앞단 AI/목업·덴트링크 에디터·FE 반복 작업 감소는 같은 큰 목적입니다. 디자인시스템은 앞부분에서 별도 언급되고 후반에 에디터의 사전 정비 필요성으로 다시 연결됐으므로 이 주제의 공통 기반으로 정리합니다. 에디터 전용 정비나 전체 선행 재정비를 확정하지 않습니다.
- **비개발자의 데이터 생성 편의성:** 연속해서 나온 운영팀 주문 생성과 QA 테스트 데이터 준비를 같은 큰 주제로 묶습니다. 운영팀의 실제 업무용 주문 입력과 PM/디자이너의 QA 데이터 준비는 사용자·목적·환경이 다른 하위 사용 장면으로 유지하며, 단일 도구나 공용 DB 기능으로 합치는 결정을 뜻하지 않습니다.
- **진행 방식:** 작업량이 작은 개선을 큰 과제와 병행하자는 의견은 기능 후보와 분리해 둡니다. 이전에 나눈 5개 업무 방향은 위 3개 주제의 하위 사용 장면으로 흡수하며 누락하거나 폐기하지 않습니다. 이 분류는 아직 우선순위가 아닙니다.

### 2차 FE 미팅에 가져갈 구체화안

- 사용자는 내일 FE 팀원들과 **30분~1시간** 미팅 예정이라고 확인했습니다. 목적은 1차 메모 기반 아이데이션 구체화이며 실제 구현 착수는 아닙니다.
- 사용자가 다시 명확히 한 산출물은 **회의 시간표나 진행안이 아니라, 1차 메모를 실제 업무 제안으로 발전시킨 사전 검토안**입니다. 각 메모가 어떤 작업인지, 어떤 화면/흐름이 되는지, 얼마나 걸릴지, FE가 바로 할 부분과 추가 지원이 필요한 부분까지 제안합니다.
- 처음에는 주제별 **문제/사용 장면 → 구체적 기능 흐름 → 기존 코드 기반 → 작은 1차 범위 → 예상 공수와 가정 → FE 자체 범위/추가 지원 → 확장안**으로 검토했습니다. 이후 사용자 요청으로 공유 자료는 표·도식으로 간소화했으며 자세한 근거는 이 개인 기록에 둡니다. 코드에 있는 사실과 신규 제안/추정은 구분합니다.
- QR처럼 애매한 항목은 사용자 사례를 바탕으로 최대한 실제 기능처럼 흐름을 먼저 제안합니다. 현장 인터뷰나 사용자의 추가 답변이 있어야만 초안을 만들 수 있다고 멈추거나 이미 확인된 용어를 반복 질문하지 않습니다. 가정을 표시하고 기능 선택을 바꾸는 핵심 미확인 사항만 남깁니다.
- 공수는 경험 있는 FE 1명의 분석·개발·개발자 QA를 포함한 대략 인일 범위로 제시합니다. 서버 작업·타 직군 대기·배포/실기기 검증 등 포함 범위를 명시하며 확정 납기로 주장하지 않습니다. FE가 착수 가능하다는 것과 다른 지원 없이 운영까지 완결된다는 것을 구분합니다.

### 원문 대조·현재 이해

시간·작성자 표시를 제외한 실질 내용을 14개로 나누어 대조했습니다. 생략한 안건은 없으며, 넓게 묶인 표현과 해석을 더한 부분은 아래처럼 구분합니다.

| 원문 요지 | 현재 이해·확인 상태 |
| --- | --- |
| 앱 링크톡 첨부 실패 복구: 실제 얼마나 실패하는지부터 조사 | 복구 구현에 앞서 실패 규모를 조사하자는 명확한 선행 과제. 실패가 많다는 사실이나 수치는 아직 확인하지 않음. |
| 업로드 전 파일 점검 | 사용자가 기존 후보와 같은 방향임을 확인. 파일 검사·UI·속도·사용 편의성을 포함한 업로드 경험 개선의 한 부분이며 업로드 속도도 이 맥락에서 논의됨. 형식·중복 등의 구체 검사 항목과 대상 화면은 아직 미선정. |
| 앱에서 QR 생성하고 바로 사진 찍어 보내면 링크톡으로 | 특정 주문을 지정한 상태에서 휴대폰으로 찍은 사진을 해당 주문 링크톡에 바로 첨부하려는 방향. 기공소가 사진을 미리 준비한 뒤 주문을 다시 찾아 하나씩 첨부하는 과정이 번잡했다는 전언이며 정확한 현장 흐름은 미확인. 사용자는 이전 주문 상세 링크 QR을 언급했고, 주문 상세 진입 또는 주문 지정→카메라→첨부의 수단일 수 있다고 설명. 원문의 생성 위치를 확정 설계로 고정하지 않으며 QR의 역할·생성/사용 위치는 여전히 미정. |
| 디자인시스템 정비 | 공통 UI 정비의 자체 가치가 있고, 후반의 에디터 사전 정비 의견과 연결됨. 현재는 스쿼드 효율화의 공통 기반으로 묶으며, 어떤 컴포넌트·규칙을 먼저 정리할지와 선행/병행 관계는 도구 범위에 맞춰 결정. |
| 링크톡 첨부 개선 | 주문별 사진 연결·첨부의 반복을 줄이는 사용 경험을 포함. 촬영 즉시 첨부와 미리 찍은 여러 사진의 주문별 분배는 다른 사용 장면이므로 어느 쪽이 주된 불편인지 확인 필요. 실패 복구·파일 검사·속도와 연관되지만 각각 문제와 효과를 구분. |
| 파일 업로드 속도 | 파일 업로드 편의성 묶음에 포함. 실제 대상 파일·화면·환경·소요 시간과 느린 구간은 미조사. |
| 스쿼드 워크플로우(개발 속도 개선) | 사용자가 에디터·AI 목업·FE 작업 감소와 거의 같은 방향이라고 명확히 설명. 현재 FigJam 와이어프레임→디자이너의 Figma→FE가 Notion/Jira/Figma/FigJam을 참고해 다시 디자인·개발하는 흐름의 실질 효율을 개선하려는 목적. |
| 앞단 AI 활용, 디자이너/PM 단계에서 목업 페이지 | PM/디자이너가 FE가 제공하는 환경에서 실제 개발될 화면을 확인하고, 산출물이 우리 프로젝트 코드에도 적용될 수 있게 하는 방향. AI는 가능한 수단이며 특정 도구·코드 생성 방식은 미선정. |
| 덴트링크 에디터 만들기 | 위 스쿼드 효율화 환경/도구의 가칭으로 이해. 실제 서비스 구현과 맞는 화면을 앞단에서 구성·검토하고 FE 재구현 부담을 줄이는 목적이 명확해짐. 화면 조립·AI 생성·템플릿·코드/설정 산출 중 어떤 구조로 구현할지는 미정. |
| 마지막 것을 한다면 사전 디자인시스템 정비도 필요하지 않나 | 에디터와 디자인시스템의 의존성을 검토하자는 의견. 전체 디자인시스템 재정비를 확정 선행조건으로 만들지 않음. |
| FE가 작업에 실제로 줄 정도는 되어야 실제 가치가 있다 | 추가 설명으로 가치 기준이 명확해짐: 앞단의 화면이 실제 구현 가능한 모습이고 결과가 프로젝트 코드에 적용돼 FE의 반복 설계·구현 작업을 줄여야 함. 자동 생성 코드의 즉시 무검토 배포를 뜻하지 않으며 필요한 산출물 형식과 절감 수준은 미정. |
| 작업량이 아주 낮은 것은 병행해도 좋겠다 | 작은 개선을 큰 과제와 병행하자는 진행 방식. 어떤 안건이 작은지·누가 병행할지·정확한 공수는 미정. |
| 운영팀에서 주문서를 쉽게 만드는 기능 | 문서 출력이 아니라 **비개발자인 운영팀이 실제 주문용 데이터를 쉽게 입력·생성**하는 도구. 어드민 또는 별도 화면 모두 가능. 실제로 필요한 주문 유형·입력값·업무 규칙·사용 환경·API 연결 범위는 다음 구체화 대상이며 DB 직접 편집 방식이 확정된 것은 아님. |
| 테스트용 데이터 딸각으로 만들기 | **PM·디자이너가 개발자에게 요청하지 않고 QA에 필요한 테스트 데이터를 준비**하는 도구. 사용자가 E2E를 반복 실행해 테스트 데이터를 만들었던 경험이 출발점. 운영용 입력과 목적은 유사하지만 QA용 데이터·상태·환경을 다룸. E2E 실행 버튼 자체가 최종 방식으로 결정된 것은 아니며 필요한 시나리오·데이터 생성 경로는 미정. |

### 발전시키는 순서·적용 가능 수준

- 위 **3개 큰 주제 → 세부 사용 장면/개선 의견 → 필요한 확인** 구조로 발전시킵니다. 원문 14개는 추적용 의미 단위이며 14개 독립 과제를 뜻하지 않습니다. 실패 현황 조사·디자인시스템 기반 정비·작은 작업 병행 의견도 보존합니다.
- 스쿼드 개선·AI 목업·에디터·FE 작업 감소는 이제 사용자가 같은 목적의 묶음이라고 확인했습니다. 세부 도구 구조나 단일 제품으로의 구현은 미정입니다. ‘조사부터’는 첨부 실패 복구에 붙은 의견이며 모든 후보의 확정 선행 조건으로 일반화하지 않습니다.
- 이제 각 항목의 사용자와 해결하려는 문제는 구체화할 수 있습니다. 기존의 ‘에디터는 어떤 뜻인가/주문서는 출력물인가/QA 데이터는 단순 화면 목업인가’를 그대로 반복 질문하지 않습니다.
- 다음 확인은 현장 사진 작업 순서(촬영 즉시 vs 촬영 후 일괄 분배), QR이 줄이는 단계, 앞단 제작 환경의 첫 대상 화면·산출물·FE 작업 절감 기준, 운영팀 입력의 대표 주문, QA가 요청하는 대표 데이터·상태·환경입니다. QR은 수단 후보로 두고 문제와 흐름부터 구체화합니다.
- **회의 메모·아이데이션 초안 정리는 지금 가능**합니다. 미정 내용을 표시하면서 사용자·문제·사용 장면·기대 효과·다음 확인을 붙여 발전시킵니다. 최종 순위·기능 명세·전체 구현 착수는 아직 확정할 수 없습니다.
- 실패/속도/공통 UI의 현황 조사 계획은 먼저 구체화할 수 있습니다. 아래 2차 미팅 준비에서 현재 코드를 읽어 재사용 기반과 조건을 조사했습니다. 실제 실패율·성능 측정과 제품 구현은 수행하지 않았습니다.
- 이 메모가 기존 배송·공간·3D·파일 후보를 폐기하거나 순위를 바꾼다는 합의는 없습니다. 업무 제안·가정 흐름·대략 공수 구체화 후, 사용자의 후속 요청으로 새 Notion 2차 회의 자료에 반영했습니다. Sites·제품 구현 착수 지시는 아닙니다.

### 2차 검토를 위한 코드 조사 — 2026-09-17

- Git 갱신 후 읽기 전용 확인: web `master de2ffdd9e3025cb758632788cd6086c170e4974e`, app `main e0f4d5dd996a691b32a5ba288d826abb039105ce`. 두 저장소 모두 깨끗한 상태이며 이번에 제품 수정·API 쓰기·테스트/빌드·실기기 검증은 하지 않았습니다.
- **주문 사진 첨부:** 기존 주문서 QR(`lab/src/pages/orders/[order_id]/index.tsx:321`, `shared/ui/src/OrderDetailUI/extra/OrderDetailPrint.tsx:191`)과 앱 카메라/갤러리·링크톡 업로드가 있습니다. 새 제안은 주문 QR/링크 → 인증·주문 확인 → 여러 장 촬영/갤러리 → 대상 주문과 사진 확인 → 전송 → 링크톡 등록 확인입니다. 앱의 기존 선택 즉시 전송과 구분합니다. 이미 찍은 사진을 여러 주문에 배분하는 화면은 별도 확장입니다.
- **QR 제약:** 앱 JS 라우터의 주문 URL 지원과 실제 네이티브 앱 열림은 별개입니다. 앱 도메인 선언은 Airbridge 기반이므로 기존 웹 QR의 실제 앱 연결과 설치/로그인 상태별 복귀를 확인해야 합니다. 권한 없는 주문을 QR만으로 열어 주는 설계가 아닙니다.
- **파일 경험:** 기본 개수/용량 검사와 업로드는 이미 있습니다. 앱 10개/합계 200MB 미만, 웹 링크톡 10개/128MB로 달라 정책·서버 계약 확인이 필요합니다. 전송 묶음 기준 시작/완료, 단계별 시간·실패·사용자 취소를 구분해 관측하고 기존 로그만으로 실패율을 단정하지 않습니다. 앱 업로드 실패 재전송/메시지 등록 실패는 TODO가 있으며, 한 파일 실패 시 기존 성공 파일을 정리하는 동작 때문에 단순 재시도 버튼 추가로 산정하지 않습니다.
- **스쿼드 도구:** `@dentlink/ui`, Storybook controls/viewport/ThemeProvider와 공유 테마가 존재합니다. 신/구 컴포넌트 경로·앱별 테마 차이를 먼저 좁힙니다. 제안은 주문목록 형태 한 템플릿에서 허용된 열·필터·문구를 설정하고, 구성 도구와 제품이 같은 React 템플릿/설정 JSON을 재사용하는 검증입니다. 실제 API·권한·업무 로직은 FE 코드에 남습니다. AI는 설정 초안 생성 수단으로 붙일 수 있으며 범용 화면 편집기나 자동 배포를 먼저 만들지 않습니다.
- **스쿼드 근거:** `shared/ui/.storybook/main.ts:4`, `.storybook/preview.ts:7`, `shared/configs/theme-preset.ts:357`, `lab/src/styles/theme.ts:1`, `shared/ui/src/index.ts:19`, `lab/src/pages/orders/index.tsx:25`. Storybook 실행 성공이나 실제 FE 공수 절감은 검증하지 않았습니다. 같은 화면 재구현과 수정 왕복이 줄어드는지가 검증 완료 기준입니다.
- **운영 입력:** 어드민 주문 생성은 이미 구현돼 있습니다(`admin/src/pages/orders/create.tsx`, ORDER/CREATE 권한). 신규 주문 기능보다 기존 프로필→상품→옵션→추가정보 흐름의 반복 입력을 템플릿/기본값/사전 확인으로 줄이는 제안이 정확합니다. 임의 DB 쓰기나 검증 우회를 뜻하지 않습니다.
- **QA 데이터:** 기존 E2E는 실제 테스트 환경에서 주문·상태를 만드는 기반입니다. `.github/workflows/clinic_stg_e2e.yml`에 수동 실행·직렬화·실행환경·결과 artifact가 있으므로 대표 시나리오를 골라 생성 전용 작업을 실행하고 주문 링크를 반환하는 안은 신규 제품 BE 없이도 검토할 수 있습니다. 현재 전체 E2E 실행을 그대로 QA 생성 도구라고 부르지 않습니다. 사용자의 Actions 권한·테스트 계정·데이터 유지/정리 정책 확인이 필요합니다. 별도 웹 도구로 실행을 감싸려면 인증된 실행 경로가 추가로 필요할 수 있습니다.
- **운영/QA 상세 근거:** 관리자 생성 `shared/models/src/order/order.apis.admin.ts:87`, 매핑 `admin/src/lib/OrderForm/OrderProfileForm/useOrderProfileCreateForm.tsx:82`; QA 생성 흐름 `e2e/clinic/steps/feedback/create-feedback-order.ts:20`, `e2e/clinic/specs/08_orderFeedback.spec.ts:137`. 외부 데이터의 최소검증 프로필 API는 완성 주문 생성/검증을 대체하지 않습니다. 주문의 `isSample`도 테스트 환경 격리를 보장하지 않습니다.

#### 1차 공수 가정과 제안 경계

- 공통: 숙련 FE 1명, 분석·개발·개발자 QA 포함. 타 직군 대기·서버 개발·배포 대기·운영 데이터 관측 기간은 별도입니다. 정적 코드 조사 기반 추정이며 납기 확정이 아닙니다. 아래 범위에는 포함/확장 관계가 있어 단순 합산하지 않습니다.
- 첨부 실패/시간 단계 계측 **2~4인일**. 속도 병목 별도 분석 **2~3인일**, 확인된 FE 병목 수정은 **추가 3~7인일**을 가정하되 측정 후 재산정. 실제 실패 규모를 먼저 보자는 회의 의견을 유지합니다.
- 기존 링크톡 안 사진 모으기·전송 전 확인·파일별 오류 안내 **4~7인일**. 이 UX에 주문 QR/링크 진입을 포함한 기공소 앱 iOS/Android 1차안 전체는 **8~13인일**이며 앞의 4~7일을 다시 더하지 않습니다. 기존 API·링크 체계 재사용 가정입니다. 명확한 실패의 세션 내 묶음 재시도는 **추가 4~7인일**, 여러 주문으로 사진 배분은 **추가 7~12인일**. 응답 유실 시 중복 없는 메시지 등록과 앱 종료 후 재개까지 FE 단독으로 보장하지 않습니다.
- 디자인시스템은 대상 화면 6~10개 컴포넌트·테마·상태 정리 **4~7인일**. 같은 컴포넌트를 쓰는 한 화면 구성/JSON/제품 재사용 검증은 **추가 8~12인일**, 합계 **12~19인일**. 템플릿 추가·되돌리기·버전/설정 검증을 갖춘 내부 도구 확장은 **추가 12~20인일**(누적 24~39)을 가정하되 첫 검증 후 재산정합니다. 실제 FE 재작성 감소가 없다면 범용 에디터로 확장하지 않습니다.
- 운영팀 빠른 등록 **7~11인일**: 상품군 1개, 템플릿 2~3개, 기존 어드민 CREATE/UPDATE 권한·API 유지. 치과/환자 선택 → 템플릿 → 달라지는 치아/날짜/첨부 입력 → 검증/확인 → 실제 등록. 공용 템플릿 서버 저장·대량 입력·문서 자동 추출은 제외합니다.
- QA 데이터 생성 **7~12인일**: 테스트 환경 1개·상품 1개·대표 상태 3개, 기존 CI·계정·실행권한 활용. 예: Only Design 접수/디자인 승인 대기/완료 후 피드백 대상. 선택 → 생성 전용 작업 → 최종 상태 검증 → 주문번호·환경·상태·직접 링크. 별도 웹 실행 화면은 안전한 실행 API가 이미 있으면 **추가 3~5인일**, 없으면 서버 경로부터 별도 검토합니다.
- 제안 우선순위는 확정하지 않았습니다. 작은 첨부 개선/계측은 병행 후보, FE 내부 효과를 직접 검증할 도구는 QA 생성과 좁은 화면 구성 검증, 고객 체감 후보는 주문 사진 첨부입니다. QR은 촬영 즉시 흐름을 먼저 가정하되 현장의 주된 불편이 촬영 후 다중 주문 배분인지에 따라 첫 범위를 바꿉니다.

#### 후속 논의 — 기능의 실현 가능성과 선행 작업

- 사용자는 ‘주문을 먼저 정하고 사진을 보내기’ 흐름을 긍정적으로 평가했습니다. 기능 선택이나 구현 착수 승인으로 확대 해석하지 않습니다. 이미 촬영한 사진의 다중 주문 배분도 시간/별도 개발을 들이면 해결 가능한지, QR이 꼭 필요한지를 질문했습니다.
- **사진 배분은 수동 연결을 돕는 기능으로 구현 가능한 제안입니다.** 사진 다중 선택 → 주문 검색 또는 QR로 대상 주문 지정 → 선택 사진 배정 → 미배정/동일 선택 사진의 중복 배정 확인 → 주문별 최종 확인/전송/결과 표시. QR은 주문 검색을 줄이는 선택적 수단이며 사진의 소속 주문을 자동 추론하지 않습니다. 앞선 추가 7~12인일은 기공소 앱·기존 주문/첨부 API 재사용·한 세션 내 수동 배정을 가정합니다. 앱 재시작 복원·여러 기기 이어하기·사진 자동 분류는 별도 범위입니다.
- **업로드 속도는 실제 측정/원인 파악 자체를 검토 업무에 포함합니다.** 파일 준비/선처리, URL 발급, 실제 전송, 업로드 완료/메시지 등록을 나눠 대표 파일·기기·네트워크 조건에서 살펴본 뒤 FE 개선 또는 서버/네트워크 조건으로 분류합니다. 코드 조사는 했지만 실제 속도 측정 결과나 개선율이 나온 상태는 아닙니다.
- **에디터의 선행 작업에 디자인시스템 정비를 포함합니다.** 대상 템플릿에 필요한 컴포넌트의 버전·테마·사용 계약·상태를 먼저 정리하고 같은 실제 컴포넌트/템플릿을 도구와 제품에서 재사용합니다. 전체 서비스의 모든 화면 이전까지 완료해야만 시작하는 것으로 고정하지 않습니다. 4~7인일은 제한된 대상 정비이며 회사 전체 디자인시스템 전면 개편 공수가 아닙니다. 구현 가능한 제한형 구성 도구와 실제 FE 작업 절감 효과의 검증을 구분합니다.

## 마지막 논의·문서 반영

- 2026-09-16 사용자는 안건명만으로 적용 위치가 불명확하다며 **어느 페이지에서 무엇을 바꾸는지 한 번에 보이게** 요청했습니다. Notion의 `각 안건에서 하는 일` 14개 설명에 실제 적용 화면·동작을 명시하고, 신규 화면과 개발·QA 내부 작업을 구분했습니다. 수정 직후 readback으로 14개 설명과 그 밖의 본문 보존을 확인했습니다.
- **내 업무 보기·연속 주문 탐색:** 기존 주문 목록에서 검색·필터 조합을 이름 붙여 저장하고, 상세에서 해당 검색 결과의 이전·다음 주문으로 이동하는 후보입니다. 목록 복귀 시 필터·페이지·스크롤을 유지하며 개인 브라우저 저장부터 검토합니다. 새 담당자 배정 기능을 뜻하지 않습니다.
- **디자인 수정 전후 비교:** `주문 상세 → 상세 정보 → 디자인 승인 카드 → 컨펌 화면`의 확장 후보입니다. 첫 요청과 수정 후 재요청 등 두 자료를 사용자가 선택해 좌우로 보고 비교합니다. 기존 회차 선택·단일 미리보기와 구분하며 자동 차이 분석·임상 판정은 포함하지 않습니다.
- 위 두 후보는 현재 Sites에 구현하지 않았습니다. 이미 만든 **3D 캐러셀은 파일 선택·확대 경험**이며 수정 전후 비교와 별도입니다.
- 이번 메모리 저장에서 Notion을 재조회해 적용 위치가 있는 14개 설명을 확인했습니다. 반환된 최종 편집 시각은 `2026-09-16T07:17:00.348Z`입니다. 문서 끝에는 치과/랩 파일 탭·어드민 주문 관련 짧은 메모, FE 단독 전제와 개인적인 3D 선호 메모가 추가돼 있습니다. 미완성 논의 메모로 보존하며 특정 과제의 선택·착수 승인으로 확대 해석하지 않습니다.
- Sites 조회 결과는 **active / public / 최신 버전 4 / 기존 URL**입니다. 로컬 demo-studio는 main `4d12ae2b7251bf3ddd76263d8802cc349ed5c85a`, 변경 사항 없음. 이번 저장에서 Notion 본문·데모·제품 코드 변경이나 재배포, 기능 재검증은 하지 않았습니다.

## 1차 전체 후보 문서 구성·확인

- 기준·14개 후보의 두 기준 순위표 → 순위쌍을 붙인 안건 설명 → 전체 리스트 → 우선 구체화한 4개 데모 순서입니다. 사용자가 직접 삭제한 배경·추천 해설·회의 결정 문장은 다시 추가하지 않습니다.
- 각 안건의 괄호는 `(실무 가치 순위/보여지는 성과 순위)`입니다. 순위의 현재값은 Notion에서 확인하며 이 체크포인트에 중복 목록을 두지 않습니다.
- 전체 리스트는 기존 41개에 이미 구체화한 3D 캐러셀을 포함한 42개와 협업 확장안 7개입니다. 각각 한 줄로 표시하고 모호한 업무에만 짧은 설명을 붙였습니다. 표와 같은 업무는 명칭을 통일했습니다.
- 최종 정리에서 깨진 Markdown 제목·표 구분선·데모 소개 문장을 고쳤고, 웹 다운로드 복구 범위를 명시했습니다. 사용자가 줄인 문서 흐름을 유지했습니다.
- Notion 본문은 두 기준 순위표 1개(제목+14개), 설명 14개, 전체 후보 42개·협업 7개를 유지합니다. 9월 16일에는 설명 14개에 적용 위치를 추가했으며 순위표·전체 후보·데모 설명은 보존했습니다. 접힌 내용·하위 페이지는 없습니다.
- 대표 이미지를 본문에 중복 삽입하지 않고 데모앱 내부의 최신 화면 14장과 59초 영상으로 연결합니다. 영상은 화면을 순서대로 보여주는 무음 화면 모음이며 실제 클릭 과정을 녹화한 영상은 아닙니다. 데모 4개는 보여지는 성과를 중심으로 구체화한 사례이며 최종 개발 순위를 뜻하지 않습니다.
- 마지막 데모 절은 신규/기존 확장 구분, 실제 서비스 진입 위치, FE가 먼저 할 범위, 연동 조건과 제한점을 담습니다. 이 설명은 Notion에 두고 Sites에서는 시연 조작과 최소 샘플 표시만 제공합니다.
- 운영 사용량·실패 빈도·업무 소요 시간·최신 Jira 우선순위는 새로 측정하지 않았습니다. 실제 제품 과제가 정해지면 다시 확인합니다.

## 문서 위치 변경·자료 정리

- 처음에는 Notion 히스토리·PDF·여러 문서가 병행됐으나 사용자가 단일 회의 자료를 원해 로컬 Markdown으로 통합했습니다.
- 이후 다른 디바이스·팀원 접근과 후속 편집을 위해 사용자가 **Notion 하나를 최종 원본으로 유지**하도록 변경했습니다. 현재 위 새 페이지가 그 원본입니다.
- 예전 `FE 9월 프로젝트`와 하위 히스토리·시연 페이지는 휴지통에 그대로 둡니다. 이전 페이지 `3dcce072-e82f-80f8-984d-dd01b9554b26`는 이번에도 fetch의 `deleted`를 확인했습니다. 오래된 링크를 현재 회의 자료로 복구하지 않습니다.
- 로컬 최종 본문과 사용자 수정 이력은 Git 커밋 `f4fb52a`에 보존했습니다. 현재 MD에는 노션 링크만 있으며, 향후 Git 이력의 본문을 Notion 위에 덮어쓰지 않습니다.
- 중복 `deliverables/`, `notion-backups/`, `samples/`, `tmp/`는 앞서 제거했습니다. 시연용 영상·화면·합성 모델·샘플 파일·라이선스는 `demo-studio/dist/`, 구현 재개 근거는 숨김 `.internal/research/`에 유지합니다.
- 최신 요청에서 문서뿐 아니라 4개 데모를 고도화하고 기존 Sites에 재배포했습니다. 공개 범위는 public을 유지했습니다.

## 실제 서비스 기준·제품 연동 경계

- 제품 저장소는 읽기 전용으로 확인했습니다. `dentlink-client` master/origin/master, `de2ffdd9e3025cb758632788cd6086c170e4974e`; 제품 코드 변경은 없습니다. 이 시점의 확인을 이후 최신 API·동료 작업 확인 대신 쓰지 않습니다.
- 배송: 기존 기관 지도·배송 목록·추적 정보를 지구본→미국 지역→개별 배송으로 연결하는 신규 경험. 관리자에게 조회되는 범위와 확인된 좌표부터 FE 적용을 검토합니다. 기관·주문 식별자 연결, 주소 좌표 변환, 전체 페이지 조회·권한, 운송사 제공 ETA·갱신 계약은 확인 필요. GPS·새 ETA 계산·실제 이동 궤적으로 주장하지 않습니다.
- 3D: 기존 디자인/시술 컨펌 뷰어, 주문 파일, 링크톡 캐러셀에 이미 있는 회전·확대·이전/다음·캡처/주석 경험의 확장입니다. 데모 진입은 `주문 상세 → 파일 → 3D 자료`이며 기존 컨펌 하나에서 모든 차수 파일을 이미 조회한다는 뜻이 아닙니다. FE 첫 범위는 한 컨펌 자료 묶음의 썸네일·선택·확대 복귀. 대용량·모바일·파일 포맷·썸네일 저장 조건 확인 필요. 정합·임상 측정·수정 전후 비교는 미구현입니다.
- 공간·공정: 팀 공간·흐름·QR 데모 위에 여러 주문의 상태·담당·인계 탐색을 제안합니다. FE 첫 범위는 기존 주문 상태를 활용한 구역별 건수·목록·설명 조회입니다. 실제 물리 공정·작업자·시작/종료·인계 기록은 공유기공소 동료 작업과 API 확인 필요. 주문 상태 시각화와 실시간 생산 추적을 구분합니다.
- 파일: 실제 분산 위치는 `파일 탭(원본)`, `상세정보 → 리메이크 이력`, `디자인/시술 컨펌 요청·응답 첨부`, `오른쪽 링크톡`입니다. 한 주문의 원본·리메이크·열람 가능한 승인 자료부터 통합하고 출처와 차수를 유지합니다. 링크톡 첨부는 페이지 조회·권한 확인 없이 전체를 보장하지 않습니다. 전사 검색·공용 관리·버전 관리는 별도 서버 범위 확인 필요.
- 웹 E2E 실행 안정화는 이미 완료된 기반입니다. 후속 후보는 빠진 업무 결과 검증입니다.
- 보고서 추가 구체화 중단은 유지합니다. 모든 주문·공정·3D는 합성 샘플입니다.

## 완료한 데모 개선

- 배송: Three 지구본을 유지하고 지역·상세를 MapLibre 6.9.1 + OpenFreeMap 실제 도로·지명·입체 건물 지도로 교체했습니다. 지역 필터, 기록 위치 이동, 여정 재생, 도착지 확대를 연결했습니다. 지도 배경은 실제이고 샘플 거점과 점선은 가상 연결입니다. 외부 지도 네트워크가 필요하며 공개 타일에는 SLA가 없습니다. 로딩·실패·재시도와 표시 출처를 제공합니다.
- 공간: 9F/B1 단면 공간에 벽·유리·작업대·의자·가공 장비·수납·포장·식재를 구성했습니다. 구역 선택 시 카메라가 이동하고 주문·다음 인계·누락 상태를 연결합니다. 평면·공정·인계 정보는 모두 가상입니다.
- 3D: 색만 다른 치아 대신 서로 다른 상악·하악·크라운·리메이크 합성 GLB 4종을 제작했습니다. 파일별 실제 모델 썸네일·출처·차수·선택·확대·회전·다운로드를 연결했고, 확대를 닫아도 선택이 유지됩니다. 모델은 원본 절차 생성물이며 임상 자료가 아닙니다.
- 주문 파일: 공통 주문 맥락과 원본/리메이크/승인/링크톡 출처, 차수·형식·검색을 연결했습니다. PDF·SVG·3D 미리보기, 해당 모델 탐색, 개별 다운로드가 됩니다. 선택 ZIP은 선택한 실제 파일 바이트로 브라우저에서 생성하며 이전 고정 ZIP 66개를 제거했습니다. 주문 변경은 선택·검색·미리보기·ZIP을 초기화합니다.
- 자료: 현재 UI로 화면 14장을 교체하고 1920×1080·24fps·59초 MP4/WebM 화면 모음을 다시 생성했습니다. 사용하지 않는 이전 모델·샘플 파일은 정리하고 라이선스·출처는 유지했습니다. 연구·생성 근거는 `.internal/research/final-assets/`에만 둡니다.

## Sites 상태·검증 — 최종 배포 완료

- 프로젝트: `appgprj_6aa8dc165d888191a960b876c1af33a8`
- 공개 범위: **public**, 사용자 요청으로 2026-09-15 09:00:54 UTC 변경, revision 2. 이전 ‘개인 계정용’ 문구는 과거 상태입니다.
- 소스: `4d12ae2b7251bf3ddd76263d8802cc349ed5c85a` / main. 별도 demo-studio Git에 커밋하고 Sites 소스 push 성공 후 정확한 HEAD를 조회해 패키징했습니다.
- 버전: 4 / `appgprj_6aa8dc165d888191a960b876c1af33a8~appgver_c4f581e4d06c8191a7dc7aa74d6a5138`
- 배포: `appgdep_6aa92437de948191ba985038bd77e6ef` / **succeeded**, 2026-09-15 10:56:04 UTC. 기존 URL·public 유지.
- 정적 검증: 자체 JS 구문, Git diff 공백, HTML/모듈 상대 참조, 9개 파일 항목·4개 모델 경로 확인. GLB 헤더·인덱스·유한 좌표·폐곡면·서로 다른 형상 검증, PDF 한글 폰트·페이지 렌더 확인. 패키지 진입점·manifest 검증.
- 브라우저: 데스크톱 CSS 1440×1080과 좁은 화면 390×844에서 4개 경험을 확인했습니다. 지역 필터-선택 주문 일치, 기록 재생 종료, 9F/B1·구역 확대·누락 인계, 4개 모델 전환·확대/ESC 복귀, 차수/출처/형식 필터·주문 변경 초기화를 확인했습니다. 좁은 화면 가로 넘침 없음. 실제 모바일 기기 검증은 아닙니다.
- 실제 다운로드한 2개 선택 ZIP의 CRC와 PDF/GLB 원본 바이트 일치를 확인했습니다. 59초 WebM 전체 디코딩 성공, MP4 생성 성공, 화면 14장 1440×1080 확인. 영상은 인터랙션 녹화가 아닌 최신 화면 모음입니다.
- 공개 배포 후 홈과 배송 상세의 실제 지도·타일·출처·기록 UI 로딩 및 브라우저 오류 로그 없음 확인. 첫 외부 지도 준비에는 지연이 있었으나 로딩 완료 후 정상 표시됐습니다. 나머지 기능의 상세 조작 검증은 동일 소스의 로컬 QA 결과입니다.
- 운영 API·실제 사용자 권한·개인정보·실제 운송 궤적·임상 데이터·물리 모바일 기기 검증은 하지 않았습니다.
- 일반 Python HTTP 요청은 Cloudflare 1010으로 제한되어 공개 브라우저 페이지와 Sites 상태로 확인했습니다. 공개 범위를 바꾼 것은 아닙니다.

## 다음 시작점

1. 이 저장소를 갱신합니다. 회의 본문을 편집할 때는 위 **Notion 원본을 fetch**하고, 사용자나 팀원이 직접 편집한 내용을 로컬 과거 본문으로 덮어쓰지 않습니다.
2. **새 Notion 2차 회의 검토안에서 업무/흐름/공수/조건을 발전시킵니다.** 회의 진행 시간표 작성으로 되돌아가지 않습니다. 주문 지정 후 촬영 / 기존 사진 다중 주문 배분, 디자인시스템 선행 정비와 실제 구성 재사용, 기존 관리자 주문 생성 개선, CI 기반 QA 데이터 생성에서 이어갑니다. 이후 회의 결과로 범위·우선순위를 조정하며 최종 선택은 기존 4개 데모로 제한하지 않습니다.
3. 제품 구현이 결정되면 실제 저장소·활성 브랜치·API·동료 작업 범위를 새로 확인합니다. 예전 조사만으로 현재 기능 부재를 단정하지 않습니다.
4. 회의 본문은 Notion만 수정하고, 이 개인 체크포인트에는 결정·검증·재개 정보만 기록합니다. 새 회의용 MD/PDF나 히스토리 하위 페이지를 만들지 않습니다.
