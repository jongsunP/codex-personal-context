# Dentlink FE 아이데이션 · Notion 회의 자료

## 현재 체크포인트 — 2026-10-06 · FE와 Codex 중심 검증으로 참여 범위 정리

- **사용자 결정:** 현재 상황을 먼저 저장하고, 다음 진행은 사용자(FE)와 Codex가 할 수 있는 범위로 진행한다. PM·디자이너와 다른 팀원의 참여를 지금 요청하지 않는다. 작업이 완료되어 실제 서비스로 사용할 단계가 되기 전에는 PM·디자이너에게 사용 시험이나 검토를 요청하지 않는다. PM·디자이너는 최종 사용자 후보이며, 지금 진행을 막는 선행 조건이 아니다.
- **현재 개발 상태:** 1단계 DLDS 정비는 개발 정비 완료, Jira DL-16466은 `Ready for Deploy`. 2단계는 빈 요청에서 실제 DLDS 코드 생성·검사·미리보기·후속 수정·TSX 다운로드까지 로컬 기술 시험을 마쳤다. 사용자 편의성과 화면 품질 일반화·실제 FE 작업 감소·제품 API 적용·공유 서비스·에디터까지 완료한 것은 아니다. Figma는 참고만 한다.
- **저장/실행 확인:** 제품 `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16471`, HEAD와 원격은 `fa46e34386daf7778703606f51a2d6de9057f350`로 일치하고 working tree는 clean이다. 개인 컨텍스트는 pull 후 확인했다. 현재5178 서버는 꺼져 있다. 기존 “서버 유지” 기록은 10월2일 당시 상태이며 지금도 실행 중이라는 뜻이 아니다.
- **다음 진행 범위:** 기존 연락처 수정 요청부터 사용자(FE)·Codex가 요청→생성 화면 확인→자연어 수정→`Screen.tsx`·`SampleApp.tsx` 코드 검토를 진행한다. 화면 품질, 수정 요청에서 기존 동작 보존, 실제 DLDS 사용, FE가 유지할 코드와 필요한 보정량을 확인한다. API·권한 연결의 통상 작업과 UI 재작성/배치·상태 보정을 구분한다. 예제 수만 늘리기보다 이 흐름의 부족한 부분을 근거로 보완한다.
- **역할:** Codex는 실행 준비·생성 과정/코드/동작의 기술 검토·문제 분석과 필요한 수정/검증을 맡는다. 사용자는 FE 관점의 화면·코드 활용 여부와 필요한 방향 판단을 함께 확인한다. 사용자에게 기술 QA 전부를 넘기거나 PM·디자이너 사용 결과가 올 때까지 작업을 막지 않는다. 실제 비개발자 사용성은 향후 별도로 확인하며 FE·Codex 검증을 그 증거로 대신하지 않는다.
- **이번 저장 경계/다음 시작점:** 이번에는 현황 확인과 개인 Git 기록만 정리한다. 제품 코드·AI 생성·검사·서버 실행·Jira/Notion은 변경하지 않았다. 다음 재개 시 이 참여 범위와 실제 브랜치 상태를 확인해 FE·Codex 검증부터 진행한다. 공유 배포·제품 적용·에디터 확대·Figma 재시험은 자동으로 진행하지 않는다. 실행은 저장소 루트 `pnpm dev:ai-preview` → `http://127.0.0.1:5178/ai-generation.html`이며 자세한 방법은 제품 `shared/ui/ai-preview/README.md`와 `local-generation/README.md`를 따른다.
- **외부 자료 상태:** 10월6일 조회한 Jira DL-16437·DL-16471은 진행 중이며 기존 설명과 Notion FE에는 이전 “팀원 실사용 결과 대기”가 남아 있다. 위 사용자 결정이 최신이다. 외부 문서의 참여 범위 갱신은 이번 개인 저장에서 수행하지 않았으므로 다음 팀 자료 정리 때 반영한다.

## 이전 체크포인트 — 2026-10-02 · 로컬 생성 환경 저장·추가 구현 중단

- **최신 결정/현재 상태:** 사용자가 “더 작업은 그만하고 멈출지 더할지 고민”을 요청한 뒤, “추천에 따라 정리하고 대기”를 승인했다. **추가 구현·검사·AI 생성 요청을 중단**하고 실제 팀원 사용/FE 인계 결과를 기다린다. 직전 자율 진행으로 브라우저 요청→코드 생성·검사·실행·다운로드의 기본 기술 흐름을 준비했으므로, 다음 작업을 정할 근거를 실제 사용에서 얻는 것을 추천했고 사용자가 수용했다. 전체2단계·공유 서비스·에디터·제품 적용 완료가 아니다. 이후 단순 상황 확인·메모리 복원은 재개 승인이 아니며 새로운 사용자 지시나 시험 결과를 받은 뒤 다음 범위를 정한다.
- **시작/경계:** 개인 컨텍스트와 제품을 먼저 pull했다. 제품 시작 `7d14639ba6baa7843fac629a130b515d87070898`, 개인 시작 `e6e1aef1b6ccaa72108918f66804338e7a1a9ccb`. 후반 저장 전 개인 repo를 다시 pull해 다른 권한관리 세션의 정상 저장 `6ab7ad76f218da9c0c30dcdab37726d2c83e693f`와 맞추고 그 내용을 건드리지 않았다. 제품은 전용 worktree `/Users/parkjongsun/Repository/dentlink-client-dlds`의 `feature/DL-16471` 그대로다. 1단계·기존 제품/API·테마·공통 UI·아이콘·CI·제품 E2E·Figma 시험은 이번에 변경하지 않았다.
- **실행:** 저장소 루트 `pnpm dev:ai-preview` → `http://127.0.0.1:5178/ai-generation.html`. 새 페이지는 요청/화면이 비어있는 상태에서 시작한다. 요청 입력 → 생성하기 → 생성 범위/타입/lint/빌드 → 실행 화면·`Screen.tsx`/`SampleApp.tsx` 다운로드. 이후 같은 입력창에서 수정하거나 추가 질문에 답한다. 새 화면 요청/취소도 제공하며 실패·질문·취소는 마지막 성공 결과를 대체하지 않는다. 공개 DLDS에 TextArea export가 없어 기존 TextInput multiple을 실제 textarea로 사용했다.
- **실제 생성 연결:** 설치된 Mac Codex CLI0.159.2의 기존 인증/사용량을 사용한다. 새 API key·다른 유료 provider·클라우드 backend는 만들지 않았다. 부모가 소스 목록의 DLDS9종 실제 구현/타입·테마·지침을 stdin으로 전달한다. 완성 서비스 화면/이전 생성 예제/.env/인증 파일/레포 전체는 전달하지 않는다. AI는 두 TSX 문자열의 JSON만 반환하고 부모가 고정 결과 파일에 저장한다. 후속 요청에는 마지막 성공 코드와 원 요청, pending 질문/답변을 함께 전달한다. source packet은 서버 생명주기 동안 cache하므로 DLDS 자료를 바꾼 뒤에는 서버를 재시작한다.
- **권한 실증:** 도구의 custom permission profile은 `:root deny`, `:minimal read`, `:tmpdir/:slash_tmp deny`, 제어 폴더 read, network false이며 legacy `--sandbox`와 섞지 않는다. 합성 파일로 허용 read0·tmp/HOME 표식 read/write EPERM·부모HTTP200/자식네트워크차단을 확인했다. 실제 auth/config/keychain 파일을 읽어 검사하지 않았다. 첫 완화된 profile에서 /tmp 표식 접근이 열린 반례를 발견해 temp deny를 명시했다. 작은 CLI probe는 exit0/JSON 완료여도 모델이 파일 읽기를 거절한 답을 반환했으므로 결과 형식만으로 성공 처리하지 않는다. 소스는 stdin으로 전달하며 모델의 명령/그 외 도구 item이 나오면 게시하지 않는다. `--ignore-user-config --ephemeral`, 프로젝트 문서 cap0, 메모리/훅/하위에이전트/웹검색 비활성 임시 옵션을 쓰고 사용자 설정을 바꾸지 않는다.
- **출력·검사:** `local-generation/{runner,process,check,jobs,server}.mjs`. 허용 import/고정 구조·실제 DLDS 사용을 AST로 확인하고 임의 API/브라우저 접근/직접 HTML 컨트롤/외부 콘텐츠를 제한한다. trusted main/ThemeProvider/폰트/portal/검사 설정을 부모가 제공한다. 실제 타입·ESLint·Vite build를 순서대로 await하고 실패 시 게시하지 않는다. 프로세스 그룹 중단/timeout, 단일 작업 mutex, 실행당30화면/100작업,8,000자 요청·제한된 응답 크기를 구현했다.
- **서빙/제한:** API는 localhost Host·Origin·실행 토큰을 확인하고 CORS를 제공하지 않는다. 완료 버전의 컴파일 파일만 sandbox allow-scripts iframe에 제공하며 iframe에 same-origin 권한을 주지 않는다. 결과 모듈/폰트용 CORS와 CSP connect/frame/form 차단은 별도다. AST/CSP/iframe은 완전한 JS 보안 제품이 아니며 신뢰하는 팀의 로컬 시험이다. 공유 배포/임의 사용자의 코드 실행에는 별도 격리가 필요하다. 정적 preview build에는 생성 API가 포함되지 않는다.
- **실제 브라우저 시험:** 브라우저의 빈 요청창에서 자연어 연락처 모달을 실제 CLI로 생성했다. 이어 “제목을 Update Personal Mobile, Save를 Apply로 바꾸고 나머지를 유지”를 실제 CLI로 요청해 동일 session의 새 버전을 생성했다. 두 결과 모두 DLDS import·전화번호 표시·숫자만 입력·빈 Save disabled·저장·Cancel 폐기·Escape 폐기·1280/320 문서 폭·코드 다운로드를 통과했고 pageerror0이었다. 첫 시험 중 호스트 개발 파일 변경으로 Vite가 재시작한 경우와, 부모 iframe이 viewport 밖인 검사 준비 문제를 구분해 수정했다. 이후 생성기 모의 결과가 아니라 실제 생성된 첫 버전의 job 응답만 재연결하여 화면 검사를 재개했고 후속 요청은 실제 생성했다. 마지막 기능 모형/API mock 시험과 실제 AI 시험을 혼동하지 않는다.
- **자동/회귀 검사:** 최종 `pnpm test:ai-generation` **32/32**(모의 adapter로 lifecycle/추가질문 보존/성공 보존/취소·지연값/작업 제한/도구 item 거부/프로세스 중단/로컬 API 경계), 기존 `pnpm test:ai-preview` **22/22**, preview 전체타입·전체`.ts/.tsx/.mjs` lint 경고0·5진입점 build·diff check 통과. 실제 AI 생성은 이 단위검사에서 호출하지 않는다. 정상 커밋 훅 Clinic/Lab/Admin 타입과 정상 push 훅 3앱 lint/기존 coverage도 통과했다. 기존 앱 경고/tsconfig paths warning은 비차단 baseline이다. 제품 전체 E2E·실기기·전체 생성 품질 검증은 아니다.
- **제품 저장:** **`fa46e34386daf7778703606f51a2d6de9057f350`** (`feat: 브라우저 요청으로 DLDS 화면과 코드를 생성하는 로컬 환경 추가`),17files1931add/4delete. `origin/feature/DL-16471` 동일·working tree clean을 확인했다. 정상 hooks를 우회하지 않았다. PR·merge·제품 배포·외부 호스팅은 하지 않았다.
- **팀 자료:** DL-16471은 새 요청 환경·실제 시험·실행/코드 전달·한계를 반영, DL-16437은 현재2단계만 갱신했다. GET 설명 일치 및 둘 다 진행 중을 확인했다. 완료 카드/1단계 상태는 유지한다. 기존 Notion FE `3ecce072-e82f-81f3-bb89-fbf5729da06c`에 브라우저 요청·수정·다운로드와 실행 경로를 짧게 추가하고 재조회했다. 사용자 제목/역사/Figma 하위 시연 문서는 보존하고 새 공유 문서는 만들지 않았다.
- **로컬 결과/기기 이전:** 결과는 `shared/ui/.ai-sessions/<sessionUUID>/<versionUUID>/`의 두 TSX·trusted main/config·dist·검사 로그다. `.gitignore`로 Git에서 제외했다. UI 새로고침/서버 재시작 시 job/session 상태는 복원하지 않지만 소스 파일은 남는다. `/tmp/dentlink-ai-generation-live-check/`의 result/jobs JSON·1280/320 screenshots·다운로드 코드, `/tmp/dentlink-codex-permission-probe-xjvrkuvq/control/`의 합성 검사 증거는 이 기기에만 있다. Git은 실행 프로그램/소스 지침/검사법을 복원하며 이 임시 코드·인증·서버·브라우저 상태를 옮기지 않는다. 기존3개 고정 생성 예제는 원격 저장되어 계속 실행할 수 있다.
- **새 기기/재개:** 개인 repo pull 후 이 체크포인트를 먼저 읽고 제품 branch/HEAD/dirty/remote를 live 확인한다. 기능 브랜치의 제품을 준비해 `pnpm install --frozen-lockfile`, Mac Codex 설치·로그인을 확인한다. 다른 설치 경로는 `DENTLINK_CODEX_BIN`을 사용할 수 있다. 실행/예시 요청/권한·한계 정본은 제품 `shared/ui/ai-preview/README.md`, `local-generation/README.md`다. 검사 명령: `pnpm test:ai-generation`, `pnpm test:ai-preview`, `pnpm --filter @dentlink/ui type:ai-preview`, `lint:ai-preview`, `pnpm build:ai-preview`.
- **다음 시작점/대기:** 팀원이 현재 로컬 환경으로 요청→화면 확인→후속 수정→두 TSX 전달을 시도한다. 확인할 것은 ①화면 품질(요청 구성/동작), ②수정 편의성(후속 요청으로 원하는 결과 도달), ③FE 코드 인계·보정량이다. FE 보정은 UI 재작성/배치·상태 보정/원래 필요한 API 연결을 구분한다. 이 시험의 결과·어려웠던 요청·화면/코드를 사용자가 알려주거나 별도 재개 지시를 하면 live Git 상태를 확인하고 필요한 수정 범위부터 정한다. 결과 없이 기술 예제·하네스 기능·공유 배포·에디터·Figma 시험을 자동 확대하지 않는다.
- **이번 정리:** 제품 코드는 변경하지 않았고 제품 HEAD `fa46e34386daf7778703606f51a2d6de9057f350`/브랜치/clean 상태를 확인했다. 추가 검사를 실행하지 않았다. 기존 Jira DL-16471·DL-16437의 설명과 Notion FE에 추가 구현 중단·실사용 확인 항목·결과 후 범위 결정만 반영했다. Jira는 전체 과제가 진행 중이므로 상태를 유지하고 완료로 전환하지 않는다.
- **로컬 실행 상태:** 확인용 Vite5178 서버(PID41552)는 유지했다. 정리 시 Codex 생성 프로세스는 없었고 새 요청을 실행하지 않았다. 확인 페이지는 `/ai-generation.html`이며 서버 유지가 Codex의 작업 재개를 뜻하지 않는다. 서버/인증/생성 출력은 다른 기기로 자동 이전되지 않으며 위 실행·재개 방법을 따른다.

## 이전 체크포인트 — 2026-10-02 · 검색/날짜 새 생성·비동기 FE 인계 시험 완료

- **최신 요청/상태:** 사용자가 다시 “혼자 가능한 것이 더 있으면 이어서 계속하고, 다 되면 지금처럼 마무리”하라고 재개했다. 추천으로 가능한 기술 시험을 더 진행하고 제품 커밋·푸시, 개인 Git 메모리·Jira·Notion 정리 후 대기한다. 새 요청 없이 기존 제품 화면/API 변경·배포·PR/병합·에디터 확대·Figma 시험을 자동 재개하지 않는다.
- **시작 확인:** 개인 컨텍스트와 제품을 먼저 `git pull --ff-only`했다. 제품은 `feature/DL-16471`, 시작 `ae9fa0d283436c5291faa73e4bd004d9ff0cdd51`, 개인 main은 `b96d4e905d9312dc67f20e731abe9e5ed43be1c3`였다. unrelated origin/master/develop의 새 commit은 이번 브랜치에 합치지 않았다.
- **이번 범위:** 실제 Clinic 주문목록의 검색·주문일 필터만 분리해 공개 DateRangeFieldV2의 새 화면 적용을 시험했다. DataListSearch는 공개 DLDS가 아니므로 공개 TextInput/Button/Icon/Typography로 검색을 조합했다. 업무용 필터를 `dlds.ts`에 export하지 않았다. 동시에 생성 프로필 UI의 실제 FE 비동기 호스트 연결 계약을 실행 가능한 코드/검사로 확인했다.
- **새 빈 페이지:** root는 filter HTML/main/실제 ThemeProvider·폰트·Portal·build input과 `filter-screen.md`를 준비했다. 생성 전 root children0·빈 text·pageerror0을 확인했다. 새 독립 에이전트에 지침·화면 기준·공개 DLDS 소스/타입·일반 예시만 읽도록 지정했고 대상 주문목록 완성 JSX/기존 생성 연락처·프로필 결과는 제공하지 않았다. 이는 지침과 읽은 파일 보고 기준이며 파일 접근 통제를 구현한 것은 아니다.
- **필터 결과:** `GeneratedFilterPreview.tsx`(UI, controlled 검색값/Date[], callback, 500ms debounce·최신 callback·외부값 동기화·unmount 취소)와 `FilterGenerationApp.tsx`(빈 샘플 상태)를 새로 생성했다. 검색 PC380×52·날짜 최대288·간격16·PC 메뉴400px,2022-01-01~오늘(끝 경계 제외 API에 내일 전달), 기존 DateFormat YMD_D를 사용한다. 선택/확인/취소/지우기·keyboard를 제공하지만 API·URL·주문 카드·Status/Dentist 필터는 만들지 않았다. 720px 미만의 세로 배치는 축소 샘플이며 실제 모바일 Filter Drawer 전체 재현이 아니다.
- **발견/수정:** 처음 빈 검색창은 role/name으로 찾았지만 값 입력 후 Clear search 버튼이 나타나면 enclosing label에 버튼 이름까지 합쳐졌다. 명시적 aria-label로 수정하고 실제 Chromium/RTL에서 재확인했다. 초기 타입 검사에 다른 병행 작업의 model barrel noUnused·Vitest2 미지원 matcher가 끼어 있었으며 호스트 DTO를 실제 Swagger 생성 data-contracts type-only import로 좁히고 검사 문법을 수정했다. 제품 model 설정/DTO를 임의 변경하지 않았다.
- **브라우저 필터:** Chromium1280×900·720×900·390×844·320×568의14종×4폭 = **56/56 검사 그룹 통과**. 빈 상태·라벨/52px/너비/16px·긴 검색 실제viewport·SVG·오늘 가능/내일 제외·선택확인·Cancel/Escape/외부 폐기·이전 확정값과 다른 keyboard 범위 선택·날짜 clear/검색 독립성·새로고침·pageerror0을 검사했다. 날짜 테스트 브라우저의 시계만2026-10-02로 고정하고 실제 UI는 현재 날짜를 사용한다. 낮은320×568 화면은 기존 달력 내부 스크롤로 footer 접근을 확인했으며 모든 버튼이 처음부터 보인다고 주장하지 않는다. 실기기/iOS Safari 검증은 아니다.
- **검사 보정:** 첫56개 시도는 검색 접근 이름 결함 때문에8통과/8실패/40미실행이었다. 이름 수정 뒤 기존 Chip의 삭제 이름을 Clear로 잘못 조회하고, 애니메이션 중 좌표·모바일 배경 뒤 검색창을 클릭해 실패했다. 실제 Remove와 배경 클릭·finite animation 완료로 수정했다.320px 기존 scroll 동작도 반영했다. 독립 검토는 keyboard로 동일 범위를 다시 고르면 Enter 무시에도 통과할 수 있음을 지적했고, 다른 범위로 변경하는 assertion으로 고친 뒤56/56을 확인했다. 실패를 skip/허용 실패로 처리하지 않았다.
- **비동기 인계 코드:** `ProfileHandoffController.tsx`가 실제 GeneratedProfilePreview를 그대로 연결하고 실제 생성 DTO 타입의 countryCode/telephoneNumber/numberingSystem을 보존한다. callback Promise 성공값으로 profile을 반영·닫고, 실패는 이전 값/draft 유지와 기존 Save 재사용, SMS는 실패 rollback을 한다. 각 요청은 동기 ref로 중복을 막고 종료된 화면의 늦은 완료/error callback을 무시한다. 초기 props는 mount 때 읽으며 새 사용자/reset은 key 재마운트 계약이다. 서버 요청 취소/서버 write rollback을 구현한 것은 아니다.
- **대기 UI:** 생성 Profile UI에 optional `isSavingPersonalMobile`/`isUpdatingPromotionalSms`(default false)를 추가했다. 연락처 pending은 입력·Save·Cancel disabled/상단X 숨김/배경·Escape 취소 방지, SMS pending은 Switch disabled이다. 기존 원래 즉시 저장 샘플과 기본 동작은 유지했고 새 Retry/Toast/오류 문구나 공통 DLDS/제품 UI는 추가하지 않았다.
- **상태/인계 검사:** actual UI·portal·event를 사용한 Vitest14개(지연 성공·반환값·실패 재저장·빈값·기존4종 폐기·동일 tick 중복/닫기·SMS rollback·채널 독립성·unmount/key reset 늦은 완료)와 필터 callback8개 = **22/22 통과**. UI를 stub하지 않았고 실제 서버/로그인은 없다. pending UI는 일시 진입점 fixture로 Chromium1280/320의 input/Save/Cancel/Switch disabled·Escape/배경 guard·Tab/ShiftTab·서버 반환값 반영·초점·pageerror0을 확인했고 finally로 main byte/SHA256 복구했다. fixture는 커밋하지 않았다.
- **기존 회귀/검사:** Profile의 optional props default false 회귀56/56 통과. 기존 연락처43개는 이전 체크포인트 결과이며 이번에는 코드 변경이 없어 브라우저를 재실행하지 않았다. 최종 preview 타입·`.ts/.tsx/.mjs`를 명시한 전체 lint·22tests·4진입점 build·diff check 통과. preview 전용 Vitest config/test script를 추가하고 기존 test:ui·CI·제품 E2E runner는 건드리지 않았다. source index9컴포넌트/29unique path 모두 실존. 전용 검사 unreachable URL은0pass/56미실행/4준비 실패와 종료코드1을 확인했다. 기존 tsconfig paths 위치 warning은 비차단 baseline이다.
- **독립 검토/한계:** 읽기 전용 검토에서 요구 밖 제품/API/CI 변경이나 높은 영향 구현 오류를 찾지 못했다. README·AI_GUIDE에 실제 사용법과 인계 한계를 보완했다. 기존 `useUpdateProfileForm.onSubmit`은 async지만 mutate만 호출하므로 await를 서버 완료로 판단하면 안 된다. 실제 userAtom의 연락처 전체 교체/SMS 부분 병합 응답 경합, 서버 오류·권한·제품 QA는 별도다. 이 샘플로 비개발자 사용성/FE 수정량 감소/모든 화면 품질/전체 하네스 완료를 주장하지 않는다.
- **제품 저장:** `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16471`, **`7d14639ba6baa7843fac629a130b515d87070898`** (`feat: DLDS 날짜 필터 생성과 비동기 코드 인계 검증 추가`).18files1314add/8delete. 정상 커밋 훅 Clinic/Lab/Admin 타입 검사, 정상 push 훅 lint/coverage 통과. origin 동일·working tree clean을 확인했다. PR/병합/배포/브랜치 전환은 하지 않았다.
- **팀 자료:** Jira DL-16471/DL-16437의 현재 진행만 갱신하고 GET 내용 일치·둘 다 진행 중을 확인했다. 완료된 이전 카드/1단계 상태를 바꾸지 않았다. 기존 Notion FE `3ecce072-e82f-81f3-bb89-fbf5729da06c`에 날짜 새 생성·인계 결과와 세 실행 경로만 짧게 반영해 재조회했고, 사용자 내용/제목/이전 Figma 기록/하위 시연 문서를 보존했다. 새 공유 문서는 만들지 않았다.
- **재개/실행:** 이 기능 브랜치를 pull한 저장소 루트에서 `pnpm dev:ai-preview` → `/filter-generation.html`(새 검색/날짜), `/profile-generation.html`, `/contact-generation.html`. 기존 로컬 Vite5178은 유지한다. 새 기기는 `pnpm install --frozen-lockfile`, 필요 시 Playwright Chromium 설치 후 실행한다. `pnpm test:ai-preview`(22), `pnpm --filter @dentlink/ui type:ai-preview`, `lint:ai-preview`, `pnpm build:ai-preview`, `node shared/ui/ai-preview/checks/filter.mjs`, `profile.mjs --followup`로 재현한다. 검사 report·screenshot은 `/tmp/dentlink-ai-filter-20261002/`의 로컬 자료여서 Git으로 기기 간 이전되지 않지만 소스·기준·검사 명령은 원격 보존한다.
- **다음 시작점:** 기술 샘플 수만 늘리기보다 실제 PM·디자이너의 요청/후속 수정 → FE가 코드 이어받기/필요 수정량을 작은 시험으로 확인한다. 현재는 저장소를 연 Codex에서 `$dlds-screen` 요청·로컬 미리보기를 사용하며 브라우저 프롬프트 서비스는 아니다. 사용 환경·대표 화면/API 통합이 필요한 범위는 그 실사용 결과로 구체화하고 에디터는 이후 판단한다. 추가 기술 확장은 가능하지만 이번 자율 시험과 저장/정리 완료 후 대기한다.

## 이전 체크포인트 — 2026-10-02 · 복합 화면 생성·후속 수정·재실행 검사 완료

- **최신 요청:** 사용자가 “혼자 가능한 것이 더 있으면 이어서 계속하고, 다 되면 지금처럼 마무리”하라고 재개했다. 앞선 대기 경계는 이 요청으로 해제했고, 필요한 질문 없이 가능한 다음 시험을 추천으로 진행했다. 끝나면 커밋·푸시·메모리·Jira 정리 후 대기하라는 지시는 유지한다.
- **현재 위치:** DLDS 정비 1단계는 다시 열지 않았다. AI 프롬프트·하네스 2단계의 연락처 첫 생성/독립 반복에 이어 **화면 구성 기준을 제공한 복합 화면 생성·후속 수정·실행 검증**을 완료했다. 전체 하네스·비개발자용 서비스·에디터·제품 적용 완료는 아니다. Figma는 참고만 사용하며 추가 Figma 시험·로딩 복구·master 시험은 재개하지 않는다.
- **선정 근거:** 실제 Clinic 주문목록은 일반 DLDS Table이 아니라 주문 전용 카드·상태 그래프·배송 규칙을 사용하며 클릭도 상세 페이지 이동이다. 임의 상세 모달을 넣거나 업무 UI를 DLDS로 export하지 않았다. 현재 공개 DLDS로 검증 가능한 좁은 **My Profile 일부: 이름·이메일·연락처 카드 + 연락처 수정 모달 + Preferences의 Promotional SMS**를 선택했다.
- **빈 페이지 생성:** `profile-generation.html`과 기존 실제 ThemeProvider·폰트·Portal을 연결하고 root 자식0·텍스트 없음·pageerror0을 확인했다. FE가 실제 Clinic 배치·문구·크기·동작을 검토해 `profile-screen.md`로 전달했다. 새 독립 에이전트에는 스킬·생성 지침·실제 DLDS/테마/일반 예시·화면 기준을 제공했고 대상 Clinic 완성 JSX·기존 연락처 생성 결과는 읽거나 복사하지 않도록 했다. 에이전트 보고와 범위 지침 기준이며 도구 수준 파일 접근 통제는 아니다.
- **생성 코드:** `ProfileGenerationApp.tsx`는 샘플 사용자·번호 draft·저장/폐기·독립 SMS 상태, `GeneratedProfilePreview.tsx`는 제어 props/callback과 실제 DLDS Button·Icon·Modal·SelectDropdown·Switch·TextInput·Tooltip·Typography 8종을 조합한다. 첫 생성 타입/lint 보정0회. 서버/API·실제 로그인·권한·기존 제품 화면·공통 컴포넌트·테마·의존성은 수정하지 않았다.
- **후속 프롬프트:** “SMS 상태를 Promotional SMS 아래에 SMS enabled/SMS disabled로 표시하고 나머지 동작/배치는 유지”를 미리보기에서만 적용했다. 생성 에이전트가 UI의 라벨 영역·작은 상태 문구만 바꿨으며 샘플 컨테이너 파일은 첫 생성과 byte 동일하다. 후속 타입/lint 보정0회. 기존 서비스에 SMS 상태 문구를 임의 추가한 것이 아니다.
- **복합 화면 브라우저:** 첫 요청과 후속 최종 각각 Chromium 1280×900·720×900·390×844·320×568, 14종×4폭 = **56개 검사 그룹 통과**. 그룹 내부 assertion 총개수나 전체 제품 판정과 구분한다. 카드 최대750/간격·모바일 라벨/목록, 모달480·숫자/빈값, Save와 SMS 독립성, Cancel/Close/Escape/배경 폐기, 초점 복귀·Tab/ShiftTab, Tooltip pointer/focus/Enter/Escape·화면 내 배치, 40자리 입력/저장·문서 폭·새로고침, pageerror0을 확인했다. 최종 후속에는 SMS 상태 문구와 두 동적 Icon의 SVG 표시도 포함했다. 첫56개는 SVG 보강 전 결과다. 실제 viewport 옵션 폭과 문서 폭을 비교하며 innerWidth 단독 비교를 쓰지 않는다. 이 검사는 Chromium의 화면 크기 검증이며 실기기/iOS Safari 검증은 아니다.
- **긴 props 확인:** 별도로 진입점에 일시 fixture를 연결해 224자 이름·252자 이메일·40자리 번호를 1280/720/390/320 폭에서 표시했다. 넘침0, 연필 수평 배치·모달 초기 번호·Cancel·pageerror0을 확인했다. finally로 진입점의 byte/sha256 복구를 확인했고 fixture는 제품에 남기지 않았다.
- **재실행 가능한 검사:** `shared/ui/ai-preview/checks/contact.mjs`, `checks/profile.mjs`를 보존했다. 기존 `/tmp` 연락처39개 검사를 옮기고 승인된 정확한 제목/라벨·고정 Country·PC480px을 보강해 최종 **43/43 통과**했다. 새 UI 검증 CI·제품 E2E 실행기 변경은 없다. URL/임시 산출물 옵션·폴더 생성·브라우저 종료·JSON/스크린샷·준비 실패/미실행 분리를 갖췄다. 접속 거부는 통과0/미실행·준비실패로 기록했고 연락처 스크린샷 저장 실패도 별도 실패로 기록함을 확인했다. 소스 문자열이나 생성 class 이름을 테스트하지 않는다.
- **검사와 검토:** 미리보기 타입/lint·두 mjs 파일의 직접 lint·syntax·diff check 통과. 처음 mjs 직접 lint에서 Node env/빈 animation rejection handler 8건을 발견해 코드 동작을 바꾸지 않고 수정한 뒤 통과했다(생성 UI의 타입/lint 보정0회와 구분). 멀티페이지 빌드가 기존 index/contact와 새 profile HTML을 모두 산출함을 확인했고 PC/320px 최종 그림도 직접 검토했다. 별도 읽기 전용 FE 검토에서 요구 밖 제품 변경·높은 영향 문제를 찾지 못했다. 실제 API/권한 실행 검증은 하지 않았다.
- **FE 재사용 연결:** UI 파일은 Clinic 업무 화면에서 사용하고 DLDS 공개 export에는 넣지 않는다. 기존 userAtom 필드와 UI props 매핑, `useUpdateProfileForm`의 DTO countryCode/numberingSystem 보존·성공 후 닫기, `useUpdateProfileSms`와 실패 rollback, host main/제목 통합, pending/중복 저장·제품 QA 필요를 제품 README에 정리했다. 이는 실제 연결점 조사와 인계 방법이며 API 연결을 구현/검증했다고 하지 않는다. 화면 재작성 없이 바로 제품 적용 완료·FE 작업 감소 입증이라는 표현도 하지 않는다.
- **제품 저장:** worktree `/Users/parkjongsun/Repository/dentlink-client-dlds`, branch `feature/DL-16471`, HEAD **`ae9fa0d283436c5291faa73e4bd004d9ff0cdd51`**, `feat: DLDS 복합 화면 생성과 미리보기 검증 추가`. 10파일1540추가/1삭제. 정상 커밋 훅 Clinic/Lab/Admin 타입, 정상 푸시 훅 앱 lint·공통 coverage 통과(기존 경고 유지). origin 동일 SHA·working tree clean 확인. 앞선 연락처/스킬 저장은 b9af07839이다. 새 PR·merge·제품 배포는 하지 않았다.
- **팀 자료:** 실제 지침은 제품 스킬→AI_GUIDE→dlds-reference 및 원본 코드이다. JSON은 Switch/Tooltip을 더해8종·고유 경로21개 존재를 확인했으며 별도 props 스키마/렌더러/접근 통제가 아니다. 팀 요청·화면 기준은 profile-screen.md, 실행·검사·FE 연결 안내는 README에 둔다. 세션 이력·개인 handoff는 제품에 추가하지 않는다.
- **Notion/Jira:** 기존 [FE 문서](https://app.notion.com/p/3ecce072e82f81f3bb89fbf5729da06c)의 생성·수정 결과·현재 실행 위치·다음 추천만 갱신하고 Figma 기록/자식 시연 문서를 보존했다. [DL-16471](https://innovaid.atlassian.net/browse/DL-16471)의 현재 진행·코드/커밋/실행법·복합 결과·한계·다음 검증과 상위 [DL-16437](https://innovaid.atlassian.net/browse/DL-16437)를 갱신했다. 두 카드 제목·진행 중 상태는 유지했고 별도 재조회에서 본문 일치 확인. 다른 단계 카드·새 댓글/작업시간/카드는 변경하지 않았다.
- **현재 실행:** 이 기기에는 Codex의5178 Vite devserver가 실행 중이다. 로컬이며 호스팅/제품 서비스가 아니다. `pnpm dev:ai-preview` → **`http://127.0.0.1:5178/profile-generation.html`**(복합), `/contact-generation.html`(연락처), `/`(이전 연결). 종료는 해당 터미널 Ctrl+C. 브라우저 검사 명령은 README에 있으며 새 기기에는 `pnpm install --frozen-lockfile` 및 `pnpm exec playwright install chromium`이 필요하다.
- **산출물 경계:** 최종 그룹 결과·이미지/로그·첫 소스 snapshot·긴값 fixture 증거는 `/tmp/dentlink-ai-profile-20261002/`, 최초 연락처 반복 기록은 이전 `/tmp`에만 있다. Git에는 재실행 코드/요청/기준을 남겼으므로 다른 기기는 검증을 다시 실행할 수 있다. `/tmp`, 의존성·인증·running server·Chrome 세션은 Git으로 이동하지 않는다.
- **남은 것/다음 시작점:** 실제 PM·디자이너가 요청→미리보기→수정을 수행하고 FE가 코드로 이어받을 때 필요한 수정량을 확인하는 것이다. 로컬 Codex 기반의 작은 실제 사용자 시험을 먼저 권장하며, 비개발자 전용 제공 환경·AI 사용 권한/배포·에디터 채택은 그 결과로 판단한다. 이를 모델의 문답/정적 검토로 대신했다고 하지 않는다. 다양한 업무 화면·제품 API/권한 연결·실제 작업 감소는 아직 미검증이다.
- **정리 후 대기/재개:** 최신 결과를 커밋·푸시·Git 메모리·Notion·Jira에 정리했으며 후속 구현은 사용자 재개 요청까지 대기한다. 다시 시작할 때 개인 컨텍스트와 이 제품 branch를 pull하고 본 절/제품 README·화면 기준을 읽는다. 연락처 첫 생성·Figma 재설정·master 시험부터 다시 하지 않고 현재 결과에서 실제 사용자/FE 인계 시험으로 이어간다. 꼭 필요한 정보만 질문하고 일상적인 구현 선택은 추천으로 진행한다.

## 이전 체크포인트 — 2026-10-02 · 첫 빈 페이지 생성·독립 반복 검증 완료

- **최신 요청과 범위:** Figma 이전 DLDS·AI 작업으로 복귀한 뒤 사용자가 첫 화면은 연락처 수정, 자료 범위는 필요한 DLDS·테마·일반 사용 예시부터로 선택했다. 이어 **정말 사용자 의견 없이는 진행할 수 없는 경우만 질문하고, 그 외에는 추천안으로 자율 진행한 뒤 필요하면 수정**하라고 명시했다. 이 프로젝트의 일상적인 구현 선택·검증을 질문 대기로 멈추지 않는다. 이번에는 빈 페이지 실증·실제 소스 생성·후속 프롬프트 수정·독립 반복·스킬/자료 연결·검증을 진행했다. 전체 하네스·비개발자 서비스·범용 에디터·제품 배포까지 완료했다고 하지 않는다.
- **최신 종료 지시:** 사용자가 작업이 끝나면 커밋·푸시·메모리화·Jira 정리까지 마무리하고 대기하도록 했다. 현재 저장된 작은 화면 생성/수정/반복 검증은 완료한 범위로 기록하며 **정리 후 후속 구현·복합 화면 시험은 사용자 재개 요청까지 대기**한다. 앞선 자율 진행 지침이 이 대기 경계를 무효화하지 않는다. 이 재개 지시 없이 다음 추천 항목을 자동 시작하지 않는다.
- **원래 작업으로 복귀:** Figma 전 준비한 `projects/dentlink-ai-dlds-draft.md`와 제품 `shared/ui/ai-preview/`·실행/검사 설정을 이어 사용한다. 기존 미리보기는 실제 DLDS의 연락처 샘플이며 Figma용 잔재가 아니므로 보존한다. Figma는 사본에서 시험했고 원본에 이메일 생성 파일 등이 반영되지 않아 **브랜치/코드를 reset하거나 되돌릴 대상은 없다**. 기존 실제 UI·테마·폰트·Portal·Vite 연결 기반을 보존하고 새 빈 페이지 생성 시험과 구분한다.
- **로컬 정리 완료:** `/Users/parkjongsun/Documents/ChatGPT/디자인시스템정비 프로젝트/figma-code-layers` 약1.9GB를 `/Users/parkjongsun/.Trash/dentlink-figma-trial-20261002T094210Z`로 옮겼다. 내용은 업로드용 소스 사본2종, master 내보내기 사본/설치 의존성, 다운로드 ZIP4개, 스크린샷·로컬 검증 산출물·사본 메타데이터다. 이동 전 workspace의 Git 추적 파일0·중첩 Git0·symlink 아님을 확인했고5180 리스너도 없었다. 이동 후 원래 폴더가 없고 휴지통 복구 가능·workspace clean·제품 clean을 확인했다. 영구 삭제나 디스크 공간 확보를 주장하지 않는다. Notion의 시험 결과/출처와 개인 Git 이력은 보존하며 시연법의 기존 로컬 경로가 더 이상 존재하지 않음을 표시했다. 현재 재개에 사본 복구·재생성은 필요 없다.
- **선택된 첫 시험:** 기존 연락처 완성 코드를 복사하지 않고 **빈 페이지에서 연락처 표시·수정 모달·저장/취소**를 자연어로 생성한다. 국가 변경 불가·숫자 외 입력 제거·빈 번호 저장 제한·샘플 상태 저장은 기존 서비스와 이전 연결 시험을 바탕으로 이번 시험의 범위로 사용했다. 전체 My Profile·이메일·SMS·실제 API까지 임의 확장하지 않는다. 상세 요구와 사람이 입력할 요청문 초안·성공 기준은 [기존 준비 문서](dentlink-ai-dlds-draft.md)의 `현재 첫 시험`에 정리했다.
- **선택된 AI 자료 범위:** 사용자는 **필요한 DLDS·테마·일반 사용 예시부터(추천)**를 선택했다. 생성 입력은 안내·공개 진입점·실제 소스/타입·테마·일반 예시이며 대상 연락처 완성 코드와 이전 생성 결과는 제공하지 않는다. 실행·빌드에는 실제 workspace를 사용한다. 지침으로 읽기 범위를 정하는 것과 도구 수준의 파일 접근 통제는 구분한다.
- **확정된 회의 결론:** 사용자는 FE 회의를 완료했고, **Figma를 이번 작업에 사용하지 못하며 참고는 할 수 있다**고 정했다. 채택하지 못한 이유는 제공되지 않았다. 이전 Files 로딩·1GB 제한이 원인이라고 추론해 확정하지 않는다. Figma 운용 여부를 정할 회의를 기다리는 단계는 끝났으며, 추가 Figma 시험·로딩 복구·master 시험을 자동 진행하지 않는다.
- **이어갈 목표:** 실제 Dentlink 컴포넌트와 DLDS를 기반으로 AI가 우리 UI에 맞는 화면을 만들고, PM·디자이너 등 비개발자와 FE가 함께 활용한다. 개발자도 사용할 수 있다. 최종 목적은 FE가 실제 제품 작업에 활용할 **소스 코드**를 받는 것이다. 화면 이미지·JSON 설정만 반환하는 것으로 최종 목적을 충족했다고 보지 않는다. 앞서 합의한 디자인시스템 정비 → AI 프롬프트·하네스 → 필요하면 에디터 순서에서, 현재는 AI 생성 검증을 구체화하는 지점이다.
- **사용자가 정의한 첫 성공 기준:** **비어 있는 테스트 페이지 → 자연어로 화면 제작 요청 → 실제 프로젝트 코드에 맞고 바로 활용할 수준의 디자인·실행 가능한 코드가 생성된다.** 이 시험은 프로젝트의 성패를 가늠할 첫 검증이다. 이미 만들어 둔 연락처 예제를 실행하거나, 비슷한 이미지를 만드는 것만으로 성공이라고 하지 않는다. 실제 컴포넌트를 사용하는지, 디자인시스템 규칙을 벗어나지 않는지, FE가 실제로 활용할 수 있는지를 확인한다. 이번에 실제로 실행했으며 작은 연락처 화면의 컴포넌트 재사용·실행·동작까지 확인했다. 모든 제품 화면의 디자인 적합성이나 비개발자의 작업 감소는 별도다.
- **단계 구분:** 사용자가 여기서 말한 ‘1단계 성공’은 **새 AI 생성 검증의 첫 성공 기준**이다. 이미 완료로 정리한 전체 과제의 DLDS 정비 1단계를 다시 여는 뜻이 아니다. AI 프롬프트·하네스 전체나 에디터가 완성됐다는 뜻도 아니다.


### 실제 생성·검증 결과

- **빈 상태부터 확인:** 새 `contact-generation.html`과 실제 ThemeProvider·폰트·Portal 진입점을 연결했다. 브라우저에서 root 자식0·화면 텍스트 없음·pageerror0을 확인한 뒤 생성했다. 기존 `/`의 완성 DLDS 연결 예제는 보존하며 새 시험과 구분한다.
- **첫 생성 방식:** 이전 대화·개인 메모리·기존 연락처 완성 코드 없이 독립 에이전트에 자연어 요청, `AI_GUIDE.md`, `dlds-reference.json`을 제공했다. 안내에서 실제 타입·테마·일반 예시를 찾아 읽었다. 에이전트의 읽기 보고와 작업 범위 지침에 기반하며 OS 수준 접근 차단·읽기 감사가 구현됐다는 뜻은 아니다.
- **생성 결과:** `ContactGenerationApp.tsx`에 샘플 상태/저장·취소를, `GeneratedContactPreview.tsx`에 실제 DLDS 조합과 props/callback을 분리했다. 초기에는 Button·Modal·TextInput·Typography를 사용했으며 이후 고정 Country를 SelectDropdown으로 변경해 최종5종을 사용한다. API·로그인·권한·기존 제품 화면은 수정하지 않았다.
- **후속 프롬프트2회:** ① 기존 서비스의 제목 `Change information`, 입력 라벨 `Personal Mobile Number`, PC 창 최대480px, 고정 국가 SelectDropdown으로 보정 ② 긴 숫자가 좁은 화면에서 넘치는 실제 표시 오류를 Typography의 `$wordBreak="break-all"`로 수정. FE/부모가 UI를 다시 작성하지 않았으며 생성과 두 후속 수정 모두 첫 작성 후 타입/lint를 위한 수정0회였다. 후속 시각 보정과 실제 오류 수정은 별도이며 최초 출력이 그대로 제품 디자인과 같았다고 하지 않는다.
- **브라우저 최종39개 통과:** PC1280×900, iPhone13 390×844, iPhoneSE 320×568에서 초기 표시, 국가 고정/초점, 숫자만 입력/빈값 Save 제한, 저장/초점 복귀, Cancel·Close·Escape·배경 닫기와 draft 폐기, Tab 범위, 입력/Save 잘림, 40자리 표시 넘침, 새로고침 샘플 복귀, 브라우저 오류를 확인했다. 초기의26개 검사 중 긴 값 검사는 모바일 innerWidth가 넘친 문서와 같이 늘어나는 특성 때문에 충분하지 않았다. **실제 viewport 폭으로 보완한 검사에서 모바일2개 실패를 재현하고 수정 후39개 통과**했다. 최초26개를 완전한 품질 증거로 인용하지 않는다.
- **독립 반복:** 새 에이전트가 스킬·최소 자료·같은 자연어 요청만으로 `/tmp`에 두 소스를 다시 생성했다. 제품 진입점에 일시 연결해 타입/lint/빌드와 동일39개 브라우저 검사를 통과했다. `finally`로 최종 제품 소스를 복구하고 byte/hash 일치까지 확인했다. 반복 결과를 별도 제품 파일로 누적하지 않았다. 두 번만으로 다양한 화면의 반복 품질을 증명하지 않는다.
- **추가 확인:** 320px 최종 화면을 직접 시각 검토했고 기존 `/` 미리보기의 수정/Save와 오류0을 확인했다. 미리보기 멀티페이지 빌드는 기존 index와 새 contact HTML을 함께 산출한다. 새 스킬의 frontmatter 검증, 소스목록19개 고유 경로 존재, 상대 링크, diff check 통과. 커밋 훅의 Clinic/Lab/Admin 타입 검사도 통과했다.
- **스킬 판단 시험:** 독립 에이전트가 “연락처 수정이 더 편하면 좋겠다”에는 불편한 단계/원하는 변경을 물었고, 음성 입력 요청에는 DLDS 밖 음성 인식·마이크 권한·기기/언어·실패 처리 필요를 설명했다. 새 기능을 작동하는 것처럼 몰래 추가하지 않았다. 이는 문답 시험이며 실제 비개발자 사용성 평가가 아니다.
- **배운 점:** 실제 DLDS 재사용은 가능했고, FE는 UI 소스를 유지하며 샘플 props/callback을 제품 데이터로 연결할 수 있다. 다만 동일 요청에서도 카드 배치·창 너비·문구가 달랐다. **컴포넌트 기준과 화면 구성 기준은 별개**다. 지침에 승인된 화면 자료/배치·문구·크기 기준을 함께 읽도록 보완했다. Figma 시안 없이 존재하지 않는 정답과의 픽셀 일치를 약속하지 않는다.
- **유지할 팀 자료:** `.agents/skills/dlds-screen/SKILL.md` → `shared/ui/ai-preview/AI_GUIDE.md` → `dlds-reference.json`과 실제 소스/타입. JSON은 경로 찾기용 자료이며 props 복제 명세·JSON 렌더러·실행 스키마 검사·접근 통제가 아니다. 현재 공식 Codex 저장소 스킬 경로 `.agents/skills`를 사용했고 로컬 exclude의 `.agents` 전체 규칙은 바꾸지 않은 채 팀용 스킬1개만 명시적으로 추적했다. 기존 `.codex/skills`는 이전하지 않았다.
- **증거/정리 경계:** 스크린샷·브라우저 검사 스크립트·반복 출력·로그·검증용 Python venv는 `/tmp`에만 있다. 제품에 임시 회의/세션 이력·Figma 업로드 사본·새 CI를 추가하지 않았다. 브라우저 검사와 반복 방식/결과는 이 기록으로 회복하며 `/tmp` 자체가 Git으로 전달된다고 하지 않는다.

### 회의 메모 전체 해석 · 미정 사항

| 메모 | 현재 이해와 남은 선택 |
| --- | --- |
| 디자인시스템용 스키마·JSON·카탈로그 | AI가 읽을 컴포넌트·인자·사용 규칙·디자인 기준을 마련한다. 첫 시험에는 생성 지침·스킬·JSON 소스목록을 적용했고 별도 렌더러/강제 스키마는 만들지 않았다. 메모의 ‘카탈로그’는 자료 형태의 예시이며 프로젝트 폴더·화면 이름을 다시 catalog로 바꾸라는 지시가 아니다. |
| 원본 레포 또는 제한된 디자인용 소스 | 첫 시험은 사용자가 선택한 필요한 DLDS·테마·일반 예시부터로 진행했다. 최종 비개발자 배포용 소스 구성은 별도다. 현재 약60MB Figma 사본을 최종 하네스 소스로 확정하지 않는다. |
| 테스트 페이지·디자인시스템 통제 | 작은 연락처 화면의 실제 DLDS 생성·후속 수정·반복/동작을 확인했다. 다양한 화면 품질·기술적 접근 통제까지 입증했다고 하지 않는다. |
| 비개발자용 환경·개발자 사용 | PM·디자이너가 복잡한 개발 설정·반복 프롬프트 규칙을 매번 준비하지 않고 사용할 환경을 목표로 한다. 현재 Codex·로컬 미리보기는 구현했고 최종 비개발자용 환경은 추가 검증 대상이다. |
| FE가 코드로 받는 최종 목적 | FE가 이어서 개발할 실제 소스 코드가 결과물이다. 생성·수정 코드의 전달 방식, 제품 적용 범위와 검증 방법은 정해야 한다. |
| 디자이너 로컬 에이전트에서 FE 레포 기반 디자인 | 사용 방식의 후보/질문이다. 디자이너가 로컬 에이전트를 쓰는 것으로 확정한 것은 아니다. |
| Orca처럼 요소 선택·메모·프롬프트 수정 | 수정 대상 요소를 집어 요청으로 연결하는 편집 UX 참고다. 특정 Orca 제품 채택, 선택기 구현, 요소와 코드의 자동 연결을 이번 필수 범위로 확정하지 않는다. |
| 동그라미 마커로 부분 수정 | 화면에 표시한 영역을 수정 요청과 연결하는 별도 편집 방식의 후보다. 요소 선택 방식과 함께 검토할 수 있으나 채택 여부는 미정이며 에디터는 생성 검증 이후 확장이다. |

- **오늘 Figma 검토와의 연결:** 목적은 동일하다. 오늘은 외부 Figma 환경이 실제 FE 소스 기반 생성·수정·코드 인계를 해결하는지 살펴봤고, 이제 확인한 경험과 제한을 참고해 Dentlink에 맞는 방식을 정한다. 유용한 교훈은 이어 쓰되 Figma 도입·기존 시험 재개를 전제로 하지 않는다.
- **앞으로 구체화할 사항:** 연락처의 첫 생성/수정/반복은 진행했으므로 다시 화면 선택·자료 범위를 묻지 않는다. 다음 추천은 화면 구성 기준을 갖춘 복합 화면으로 시험 범위를 넓히고, PM·디자이너의 실제 요청·확인·FE 인계를 작은 로컬 시험으로 검증하는 것이다. 전체 비개발자 서비스·AI 제공/사용 권한·배포·에디터/선택기 채택은 완료/확정하지 않는다. 중요한 요구·권한이 부족할 때만 질문하고 가능한 구현/검증은 추천으로 진행한다.
- **노션 반영:** [FE](https://app.notion.com/p/3ecce072e82f81f3bb89fbf5729da06c) 같은 페이지 상단에 회의 결과·첫 검증 기준/생성 결과·현재 자료와 사용 환경·다음 추천을 반영했다. 생성 코드/실행법 링크와 실제 샘플/API 미연결·배치 변동·비개발자/효율 미검증을 짧게 명시했다. 사용자가 아래에 붙인 메모는 빠짐없이 상단 항목으로 옮겨 정리했으며, 기존 Figma 결과·제한·참고 링크와 [Figma 시연하는 법](https://app.notion.com/p/3edce072e82f8173afffd861d7725d14)은 과거 시험 기록으로 보존한다. 이전 Figma 활용 추천은 당시 검토 방향으로 구분하고, 시연법에도 현재 진행 지시가 아니라는 표시를 추가했다. 새 문서를 중복 생성하지 않는다.
- **제품 저장:** `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16471`, 커밋 `b9af07839` — `feat: DLDS 화면 생성 스킬과 독립 미리보기 추가`. 9파일401줄 추가/17줄 삭제이며 생성 화면·지침·스킬·JSON과 멀티페이지 빌드/README를 저장했다. 커밋 훅3앱 타입 검사 통과. 제품 전체 HEAD는 `b9af078390c849d243e7aaa5ad8743adea37f26f`이며 origin 같은 브랜치 푸시·ls-remote 동일 SHA·working tree clean을 확인했다. 기존 pre-push 훅의3앱 lint·configs/hooks 검사도 정상 종료했고 미리보기와 관계없는 기존 경고는 변경하지 않았다. 새 PR·merge·제품 배포는 하지 않았다. 최종 종료 요청에 따라 Jira 설명을 갱신했고 상태는 그대로 유지했다.
- **Jira 최종 정리:** [DL-16471](https://innovaid.atlassian.net/browse/DL-16471)의 현재 진행을2026.10.02로 갱신해 Figma 참고 결론, 빈 페이지 생성·프롬프트 수정·독립 반복, 각각39개 검사/타입·lint·빌드, 실제 DLDS·스킬/지침·소스목록 역할, 코드/실행법/커밋 링크, 실제 API·비개발자 환경·복합 품질/효율 미검증과 정리 후 대기를 반영했다. 상위 [DL-16437](https://innovaid.atlassian.net/browse/DL-16437)도 현재 단계와 최신 Notion 링크 문구를 동기화했다. 두 카드 제목·진행 중 상태는 유지한다. DL-16466은 Ready for Deploy, DL-16464/65는 완료임을 조회했고 새 범위가 없어 수정하지 않았다. 업데이트 반환과 별도 재조회에서 두 카드의 본문 일치·진행 중 상태를 확인했다. Jira에 별도 중복 댓글/작업시간/새 카드를 만들지 않았다.
- **실행/다른 기기 재개:** 제품 branch를 pull하고 저장소 루트에서 `pnpm install --frozen-lockfile`(새 기기), `pnpm dev:ai-preview`를 실행한다. 새 생성 결과는 `http://127.0.0.1:5178/contact-generation.html`, 이전 연결 예제는 `/`. 현재 기기에서 Codex가5178 devserver를 실행 중이며 외부 호스팅이 아니다. 다른 기기는 직접 실행해야 한다. 실제 코드/사용법은 제품 README가 정본이다.
- **다음 시작점:** 현재는 정리 후 대기다. 사용자가 재개하면 개인 컨텍스트와 제품을 pull한 뒤 이 절과 `dentlink-ai-dlds-draft.md`의 현재 결과를 읽는다. 첫 작은 화면이 실제 DLDS로 생성·수정·반복되는 것까지 확인했고 전체2단계는 계속 진행 중이다. 기본 추천은 생성 스킬/화면 구성 자료를 넓혀 복합 화면과 실제 비개발자→FE 인계를 검증하는 것이다. 연락처 첫 생성 준비·Figma 재설정/master 시험·완성 코드 복사부터 다시 시작하지 않는다. 사용자 최신 자율 진행 지침을 적용하되 실제 필요 정보/권한만 묻는다.


아래는 회의 전과 이전 단계의 이력이다. 최신 결론과 다음 재개 범위는 위 절을 따른다.

## 이전 체크포인트 — 2026-10-02 · 회의·시연 자료 확정, 회의 결과 대기

- **최종 마무리·대기:** 사용자는 현재 정리된 문서와 시연 상태로 회의를 진행하기로 했다. 이번 시연은 준비된 전화번호 예제와 프롬프트를 통한 이메일 생성·동작·문구 수정 확인까지이며, Files 로딩으로 실제 코드 조회·다운로드가 막힌 사실을 함께 설명한다. 코드 확인이 완료됐거나 제품에 바로 적용할 수 있다고 보고하지 않는다. 이번 종료 요청은 **문서·메모리만 정리하고 마무리**하라는 것이므로 추가 브라우저 조작·로딩 복구 조사·AI 생성·제품 구현을 진행하지 않는다. 시연법 상단에 이번 범위와8번 보류를 짧게 표시했다. 다음은 사용자의 FE 회의 결과를 받아 Figma 운용·DLDS/AI 프롬프트·하네스 방향을 정리하고, 필요하면 합의한 목적의 Figma 테스트나 코드 조회 복구를 진행한다. master 시험 재개·자체 에디터 구현은 자동 시작하지 않는다.
- **최신 제한 — Files 코드 조회 미완료:** 사용자는 처음 준비한 탭과 직접 새로 설정한 탭 모두 Files가 오래 로딩되어 실제 코드를 아직 보지 못했다고 보고했다. Codex도 기존222:24317 / Version6와 사용자 새277:1307 / Version2에서 **Files Loading, 파일 트리 미표시, 검색·File actions 비활성화**를 직접 확인했다. 277:1307에는 한국어 첫 실행 설정 프롬프트와 완료 응답·Personal Mobile 미리보기가 보이며, 아직 이메일 생성 결과를 검사한 것은 아니다. 현재 사용자 코드 조회·다운로드는 막혔고, 이전 시험의 소스 확인 기록을 현재 시연에서 재현된 검증으로 사용하지 않는다. 첫 탭 새로고침을 시도한 뒤 재확인해도 Loading이었다. 브라우저 콘솔 단축키 진단은 제어 도구가 사용자 조작 감지를 반환하거나 콘솔이 표시되지 않아 로그를 확보하지 못했다. 로딩 원인·정상 대기 시간·복구 방법은 미확인이다. 다운로드 메뉴도 비활성이라 우회 성공을 주장하지 않는다. 회의용 Notion과 시연법8단계에 이 제한을 반영했다. 제품 코드·클라우드 소스 변경·추가 AI 생성·새 master 시험은 하지 않았다. 현재는 코드 확인이 포함된 시연 전체를 완료로 보고하지 않는다.
- **최신 후속 범위:** 사용자는 master 기반 시험을 더 진행할 필요가 없다고 정했다. 다음은 FE 회의에서 **Figma 운용 방식과 DLDS의 진행 방향을 정리**하는 것이며, 이후 필요하면 합의한 목적에 맞춰 Figma를 추가 테스트한다. master 시험 재개·반복이나 자체 하네스/에디터 개발을 자동으로 시작하지 않는다. 기존 시험 자료는 과거 근거이며 이번 지시는 삭제 요청이 아니다. 회의용 Notion에서도 별도 master 폼 시험 소개는 제외하고 이 조건부 후속 방향을 반영했다.
- **최신 시연 목적:** 사용자가 회의에서 직접 프롬프트를 입력해 Figma가 실제 FE 컴포넌트로 익숙한 UI를 생성 → 입력·저장·취소 확인 → 후속 수정 → 실제 import와 JSX 사용을 보여준다. 완성 화면 클릭만 보여주는 것이 아니며, 생소한 팀원 초대 화면 대신 Clinic 연락처 수정 예제를 사용한다.
- **사용자 최종 구분:** 기존 전화번호 박스·수정 모달은 Codex가 준비한 시작 리소스다. Figma가 새로 만드는 것은 이메일 항목·수정 버튼·이메일 모달이며 모달만 생성하는 요청은 아니다. 시작 화면에는 AI 미리보기 제목·Clinic/샘플 설명을 두지 않고 기본 박스만 남긴다. 시간이 부족하므로 이 표시 정리·시연법·저장까지만 마무리하고 새 실험을 넓히지 않는다.
- **사용자 재시연 확인:** 사용자가 레이어 생성부터 직접 진행하고 첫 실행 설정 프롬프트 후 Personal Mobile 수정 버튼과 전화번호 모달까지 나왔다고 보고했다. 이는 이미 준비된 전화번호 예제를 실행한 정상 결과다. 새 이메일 항목·버튼·모달을 생성하는 두 번째 프롬프트와 구분하며, 시연 문서 4·5단계에도 명시했다. 이번 확인은 사용자 관찰 보고이며 Codex가 새 레이어 화면·코드를 직접 검사한 결과가 아니다. 해당 레이어 ID와 후속 이메일 생성 여부는 아직 확인하지 않았다.
- **접속 대상:** 정비 DLDS 사본인 [Code layer222:24317](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v/?node-id=222-24317&code-node-id=222-24317)이 기존 시연 결과다. 사용자가 Chrome 시크릿에 두 번째 탭을 열어 일반 Pages 진입과 새 Code layer 생성을 직접 확인했다. 새 레이어는 **Code 1 /276:871**이며 `What do you want to build?`와 Figma 기본 시작 화면까지 확인했다. 그 레이어에 Dentlink 소스를 가져오거나 실행 설정·새 프롬프트를 전송하지는 않았다. Running 표시만으로 Dentlink 설정 완료라고 판단하지 않는다.
- **서비스와의 관계:** Clinic `/my` → My Profile → Personal Mobile 수정 모달을 실제 DLDS·테마·폰트와 샘플 데이터로 재구성한 예제다. 기존 서비스 이메일은 조회 전용이므로 이번 이메일 편집은 시연용 확장이다. 실제 계정·API·메일 발송·서버 저장은 연결하지 않았다.
- **실제 생성 연습:** 완성 JSX를 제공하지 않고 기존 전화번호 화면 아래 이메일 항목·수정 버튼과 DLDS 이메일 모달을 자연어로 요청했다. Figma가 **Version2 · Add Email Row and Edit**를 생성했으며 연습 시간은 약3분이었다. 새 파일은 `shared/ui/ai-preview/EmailProfilePreview.tsx`, 연결 파일은 `shared/ui/ai-preview/App.tsx`다. 자동화의 한국어 입력/붙여넣기 문제로 동일 요구를 영어로 전송했고, 공유 가이드에는 대응하는 한국어 요청문을 제공한다. 한국어 요청 자체를 이번 연습에서 검증했다고 쓰지 않는다.
- **직접 확인한 동작:** 기존 전화번호 모달의4155550123→4155550188 저장, 생성된 이메일 모달 열기, 잘못된 형식의 Save disabled, 정상 `demo2@example.com` 저장 후 닫힘·화면 반영, 다른 초안 입력 후 Cancel에서 기존 저장값 유지까지 Codex가 확인했다. 새로고침 시 샘플 값은 초기화된다.
- **직접 확인한 코드 재사용:** Figma Files에서 `@dentlink/ui/dlds`의 Modal·TextInput·Button·Typography import와 실제 JSX 사용을 읽었다. Modal의 confirm/cancel/close와 local state, 이메일 형식 검사, 실제 TextInput ref/label/type 사용이 보인다. Button은 `Button.refactor.tsx`, Modal/TextInput/Typography는 기존 각각의 소스다. 모양이 비슷한 것 또는 AI 답변만으로 재사용을 확정한 것이 아니다.
- **검증 주체 구분:** 타입·lint·build와 headless Chromium의 빈값/오류/정상 저장·Cancel/Escape·기존 전화번호 동작 통과는 Figma 에이전트 최종 보고다. Codex가 그 명령을 제품 저장소에서 새로 실행한 것은 아니며 직접 화면·생성 코드 확인과 구분한다. 이번 생성 결과의 ZIP 다운로드/별도 로컬 검증은 하지 않았다. 아래 master 독립 시험의 다운로드/로컬 통과와 혼합하지 않는다.
- **시연 시작 버전 저장:** Version1 복원 실패와 초기 Email 잔존 뒤 **Version6 · Remove headings and descriptions**를 저장했다. 이후 기존222:24317의 Code editor에서 캔버스로 돌아가, **Personal Mobile / US4155550123 / 수정 버튼만 있고 제목·Clinic 설명·Email이 없는 시작 화면**을 Codex가 스크린샷으로 직접 확인했다. 앞선 '최종 표시 확인 대기'는 해결됐다. 왼쪽 Pages의 `작업중`과 선택된 Code 레이어, 화면 하단 중앙의 **Open code editor**도 직접 확인했다. 초기 화면 제어 오류의 원인은 확정하지 않는다. Figma 에이전트의 별도 cloud version5=`Phone card meeting baseline`, ID=`8a985799-11ac-4040-8eef-2e422659b2c5`, cloud commit=`0c58d3e`는 원본 제품 Git 커밋이 아니다.
- **팀 자료:** 기존 [FE](https://app.notion.com/p/3ecce072e82f81f3bb89fbf5729da06c)는 사용자 제목과 **최종요약 / 어디까지 됐나? / 사용하려면 알아둘 점? / 그러면 DLDS가 나아가야 할 방향은? / 참고** 5절을 유지했다. 시작 리소스와 Figma 생성 결과, 1GB 제한·약60MB 사본, 원격 코드 생성과 FE의 다운로드·검토·적용을 명확히 적었다. 완성 이메일 결과는 Version2이며 하위 [Figma 시연하는 법](https://app.notion.com/p/3edce072e82f8173afffd861d7725d14)을 본문 끝에 연결했다. 시연법은 **Pages 선택 → 소스 업로드 → Open code editor → 실행 환경 준비 → 새 기능 요청 → 동작 시연 → 말로 수정 → Files·다운로드** 8단계만 남겨 다시 작성하고 재조회했다. Version6 링크에서 바로 요청하는 방식만 안내했던 이전 가이드는 이 절차로 대체됐다.
- **소스 업로드·페이지 구분:** 업로드용 폴더는 `/Users/parkjongsun/Documents/ChatGPT/디자인시스템정비 프로젝트/figma-code-layers/dentlink-client`이며 기존 `shared/ui/ai-preview/App.tsx` 존재를 다시 확인했다. 파일 내 **Pages → 작업중**, **Agents → Build with code → Upload folder**로 시작한다. Code layer는 원하는 페이지 안에 만들 수 있고 전용 페이지가 필수는 아니다. **Code layers · master**는 이전 정비 전 master 독립 시험용 페이지이며 현재 DLDS 시연과 별개다. 삭제하면 이전 시험 레이어 결과만 함께 사라진다는 점을 사용자에게 설명했으며 Codex는 삭제하지 않았다.
- **생성 코드 위치·반영 방식:** Figma 상단 Files → shared/ui/ai-preview. 이메일 연습은 EmailProfilePreview.tsx에 실제 모달/입력/버튼 코드, App.tsx에 상태와 화면 연결을 생성했다. 코드는 Figma 원격 환경에서 생성·수정·실행되며 Upload folder는 사본이므로 원래 로컬 IDE/레포를 자동 변경하지 않는다. 로컬 활용은 **File actions → Download code → FE가 검토·적용 → 커밋·푸시**다. GitHub Clone/OAuth/자동 동기화는 시험하거나 설정하지 않았다. 새 요청의 실제 파일명은 AI 보고와 Files에서 확인한다. 영어 사용은 자동화의 한글 입력 누락 때문이며 영어 품질 우위를 비교한 결과는 없다. 공유 가이드는 한글 요청문이다.
- **원본 제품 상태:** `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16471`, `e7b7148a53a684e78ed25301e8d4eb541fc06c19`. 이번 변경은 Figma 클라우드 사본과 Notion·개인 컨텍스트뿐이며 제품 코드·커밋·푸시·PR·Jira·서비스 배포는 하지 않았다. 제품 working tree는 clean으로 확인했다.
- **다음 시작점:** 회의에서는 위 노션을 공유하고, 시연법을 따라 정상 Pages 진입부터 소스 업로드·실행 준비·프롬프트 생성·동작/코드 확인을 보여준다. 이미 준비한 결과를 쓸 경우222:24317의 Version6 시작 화면 또는 Version2 이메일 결과를 선택한다. 사용자가 새로 만든276:871은 아직 우리 소스가 준비되지 않았다. 이번 마무리는 문서·메모리뿐이며 추가 업로드/생성·제품 코드·Jira·PR 작업을 하지 않았다. 반복 품질·FE 수정량·자체 하네스/에디터의 계속/축소는 FE팀 논의 후 결정한다. 브라우저 로그인과 업로드용 로컬 폴더는 Git만으로 다른 기기에 이전되지 않으므로 새 기기에서는 소스 사본 준비·계정 접속이 필요하다.

## 이전 체크포인트 — 2026-10-02 · Figma 원본 master 독립 시험 완료·방향 논의 대기

- **이번 완료 범위:** 원본 master 사본의 빈 화면에서 Figma가 새 폼을 생성하고, 후속 프롬프트·요소 선택 수정·ZIP 다운로드·별도 로컬 실행까지 시험했다. 기존 팀 Notion 한 페이지에 결과/제약/후속 방향을 반영하고 재조회했다. 제품 하네스/에디터 구현·제품 PR/병합/배포·계정 초기화는 하지 않았다.
- **제품 저장 상태:** `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16471`, **`e7b7148a53a684e78ed25301e8d4eb541fc06c19`**. 시작 시 pull과 종료 시 clean을 확인했으며 제품 코드 변경/커밋/푸시는0이다. 주 저장소의 release 브랜치는 전환하지 않았다. 기존 Codex 연락처 예제(`pnpm dev:ai-preview`,5178)와 이번 Figma 생성 시험은 다른 결과다.
- **독립 시험 출처:** 고정한 `origin/master` **`9bed1f7bd753e229478302413c0ec9a7e7a11dc2`**(2026-09-28 release/v1.87.0). 기존 Codex `ai-preview`·`dlds-gallery`·신규 `dlds.ts`가 없는 정비 전 원본이다. 개인 폴더의3,460파일/58,314,729bytes 소스 사본을 사용했고 설치/빌드/민감 설정 등635경로를 제외했다. 루트 AGENTS.md/claude.md는 원본대로 남는다. [출처·제외 목록·복구 설정](dentlink-figma-master-source.md)에 전체 목록과 해시 계산법을 원격 보존한다.
- **실제 Figma 결과:** [시험 화면](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v/?node-id=234-4&code-node-id=234-4), file key `2OR0Gj7NUFEEeYBjQg5Y6v`, 페이지 **Code layers · master /234:2**, Code layer **234:4**, Cloud main / **Version6**. 최종 제목은 **Team notification preferences**다. 이전 연락처 연결 시험의 node `222:24317`과 분리한다. 최종 Browser 미리보기로 복귀하고 Annotate for agent를 껐다.
- **팀 공유 자료:** 사용자가 제목을 바꾼 [FE](https://app.notion.com/p/3ecce072e82f81f3bb89fbf5729da06c)의 최신 편집을 먼저 읽고 **최종요약 / 어디까지 됐나? / 사용하려면 알아둘 점? / 그러면 DLDS가 나아가야 할 방향은? / 참고** 5절만 남겨 자연스럽게 다듬었다. 시연 설명과 프롬프트는 사용자 요청대로 전부 제외했다. 2026-10-02T05:07:35.552Z 재조회에서 제목 FE 유지, 정확한 5개 heading, 요약 문구, 시연 본문 없음 등을 확인했다. 새 Notion/Jira/Sites는 만들거나 수정하지 않았다.
- **시연 가이드 검증:** 현재 일반 Chrome 계정은 Figma 캔버스/속성 화면으로 열린다. `Code layers · master`의 Code 예제 오른쪽 위 작은 ▷를 눌러 캔버스 내 실행 모드에 진입했고, iframe의 Email=`wrong-email`→입력창 밖 클릭→오류/Save disabled, Name=`FE Demo`·Email=`demo@example.com`·알림Off→Save→Saved settings 일치를 확인했다. 로컬 서버 없이 Figma에서 직접 동작했다. 프롬프트/Files 메뉴를 쓰는 선택 시연은 편집 가능한 계정에서 Open code editor를 연다. 메뉴가 없으면 앞서 사용한 디자이너 계정으로 준비한다는 안내를 넣었다. 실제 AI 요청이나 코드 수정은 이번 가이드 작성에서 하지 않았고 기존Version6를 유지했다. 확인 캡처는 private `master-trial/evidence/08-canvas-demo-saved.png`다.
- **이번 범위 설명:** 사용자가 완료 여부를 묻는 대상은 이번 Figma 시험/팀 자료 정리다. 전체 하네스/에디터 미완료를 매번 부연하지 않는다. 팀 자료에는 중간 과정이나 과거 예제 출처 비교를 남기지 않고 최종 결론을 우선한다. Figma 링크는 파일에 저장된 Code layer의 클라우드 실행 미리보기이며 기존 DLDS 로컬 서버와 구분한다. 로컬 실행은 다운로드한 결과의 별도 활용 검증이다.
- **판단:** 작은 폼에서는 기존 컴포넌트로 생성·수정·코드 전달이 가능했다. FE의 초기 실행 환경과 검사 설정 지원이 필요했고, 실제 제품 적용이나 대표 화면 전체 품질까지 증명한 결과는 아니다. 자체 에디터를 바로 계속 만들기보다 정비한 DLDS 대표 화면의 반복 품질과 FE 인계 후 수정량을 비교한 뒤 팀에서 계속/축소/보류를 정하는 제안이다.

### 당시 개인용 시연 안내 — 최신 시연 문서로 대체

- 당시에는 시연법을 팀 Notion에서 제외하고 개인용 팀원 초대 예시를 안내했다. 이후 사용자가 익숙한 실제 서비스 UI로 직접 프롬프트 시연하는 준비를 요청했으므로, 위 최신 체크포인트와 별도 Notion 시연법을 따른다.
- 원본 master의 node234:4 / Version6와 정비한 DLDS의 node222:24317을 구분한다. 최신 DLDS 재사용의 확인과 회의 시연은 후자가 대상이다.

### 실제 시험 이력과 확인 근거

| 단계 | 직접 확인한 결과 |
| --- | --- |
| V1/V2 초기 설정 | master3,460파일 업로드 후3개 Next.js 앱 중 실행 대상/배포 방식을 재질문했다. 독립 React/Vite 빈 미리보기와 원본 앱 보존으로 답변했고, 빈 Running 화면·코드 다운로드까지 확인했다. 기존 master 파일은 모두 바이트 동일했다. |
| V3 새 폼 생성 | 완성 JSX를 넘기지 않고 자연어로 이름·이메일·알림·저장 폼을 요청했다. TextInput·Checkbox·Button·Typography를 실제 소스에서 참조했고 App.tsx만 변경했다. 그러나 verifier 성공과 달리 실제 화면은 흰색이었고 `Unexpected token '<'` 오류를 확인했다. |
| V4 실행 오류 수정 | 실제 오류를 Figma에 전달해 미리보기의 JSX 변환과 일부 index 역참조 bridge를 수정했다. 기존 앱/shared 소스는 보존했다. 실제 화면 표시·이름 필수·저장 값을 확인했다. |
| V5 후속 프롬프트 | 이메일을 필수로 변경하고 빈값/형식 오류 시 저장 차단·blur 오류·375px Save 전폭 배치를 요청했다. 실제 동작을 확인했다. |
| V6 요소 선택 수정 | Annotate for agent에서 제목을 선택해 문구만 변경했다. V5→V6 ZIP diff는 App.tsx 제목 한 줄뿐이며 다른 필드/검증/레이아웃은 동일했다. |
| FE 로컬 활용 | 최종 ZIP을 별도 사본에 설치하고 Vite 빌드·설정 보완 후 타입 검사·실제 브라우저 입력/검증/저장 동작을 확인했다. 기존 master3,460파일 모두 보존했고 최종 ZIP3,477파일과 설치 후 소스 바이트가 일치했다. |

- **최종 브라우저 검증:** 제목, 이메일 빈값/invalid→Save disabled+blur 오류, 가상 입력값/알림Off→저장 결과 일치를 확인했다. 새로고침 후 샘플 초기값으로 돌아가며 저장 결과는 사라진다. 클라우드와 별도 로컬에서 확인했다. Chrome375×667 에뮬레이션으로 배치와 버튼 전폭을 봤지만 실기기 QA는 아니다. Console 오류 표시0을 확인했으나 기존 공통 prop 경고/Issues는 남아 무경고 판정은 아니다.
- **재사용의 정확한 범위:** 입력·체크박스·버튼·문자 컴포넌트는 원본 구현이다. 미리보기 adapter의 Icon은 기존 `SvgSignCheck`를 직접 연결하므로 원래 `Icon.tsx`의 동적 로딩까지 동일하게 시험한 것은 아니다. 모양만 비슷한 새 컨트롤로 바꾼 것은 아니다.
- **로컬 확인:** Node22.23.3 / pnpm8.6.9 / Vite4.3.2. Frozen install과56 modules 빌드 통과(494ms). ZIP에.git가 없어 root prepare의 husky가 실패했고 해당 사본에만 `HUSKY=0`을 적용했다. optional canvas2.11.2의mac arm64 바이너리/prebuild 실패는 있었지만 이 폼은 canvas를 사용하지 않는다.
- **타입 검사:** ZIP에는 독립 preview용 검사 설정이 없었다. FE가 별도 설정으로 React/DOM/alias/dependency types를 연결한 후 App·main·bridge와 도달하는 import를 strict 모드로 검사해 통과했다. 전체 제품 타입 검사나 다운로드 즉시 완성된 검사 workflow라는 뜻은 아니다. 재현 설정은 위 출처 문서에 보존했다.
- **초기 제어 문제:** 이전 Chrome 탭의 AX/스크린샷 불일치·`noWindowsAvailable`·`elementHasNoFrame`는 새 시크릿 탭으로 같은 파일을 열어 해결했다. Mac 잠금이나 Figma 기능 오류로 원인을 확정하지 않는다. 한글 native typeText 누락/paste timeout 때문에 영어로 동일 요구를 제출했으며, Figma 한국어 이해 능력의 평가가 아니다.

### 팀 문서에 반드시 구분한 제약과 방향

- **업로드 UI1GB 제한:** 원본 폴더약30GB를 그대로 올리지 못했다. 이번 master는 설치/빌드/민감 설정을 뺀약58.3MB **일회성 소스 사본**이다. 앞선 feature 연결 시험의약60.7MB와 구분한다. 최초 폴더 드롭 미반응의 단일 원인을 용량으로 확정하지 않는다.
- **미확인 범위:** Git 저장소 자동 동기화, 실제 API/권한/업무 데이터, 완성 화면의 Figma 디자인 일치, 대표 화면 전체/반복 품질, 팀의 베타 접근·AI 크레딧 조건은 확인하지 않았다. 환경변수 미지원은 실제 업로드 UI 안내다. 이 결과로 원본 서비스 전체 연결이나 제품 적용 완료를 주장하지 않는다.
- **계속할 기준 제안:** 실제 DLDS/허용값, 부족한 요구 재질문, 생성 결과 실행·검증 기준은 유지한다. 다음 후보는 정비한 DLDS의 대표 화면 생성·반복 수정과 FE 인계 후 수정량 비교다. 자체 하네스·에디터의 계속/축소/보류는 사용자/FE팀 논의 뒤 결정하며 자동으로 구현하지 않는다.
- **외부 참고:** [WooWacon ClayDesign 세션856](https://woowacon.com/sessions/856)은2026-10-28 예정이고 공개 영상값이 비어 있음을 확인했다. 전체 발표 자료는 아직 확인하지 못했다. 대신 발표자 김상국의 [컨텍스트 엔지니어링 글26459](https://techblog.woowahan.com/26459/)에서 디자인시스템 지식 제공과 실행·검증의 구분을 참고했다. ClayDesign 전체 구현 공개는 아니다. [json-render](https://github.com/vercel-labs/json-render)는 등록한 컴포넌트·속성 규칙→JSON→React 화면의 공개 참고이며 Dentlink 완성 도구가 아니다.
- **문서 목적:** 새롭게 확인한 사실/제약과 DLDS의 다음 방향을 FE팀에 짧게 공유한다. 공식 매뉴얼·장문 히스토리가 목적은 아니다. 회의 자료는 기존 Notion 한 페이지를 갱신하며 개인 진행/복구 기록은 이 저장소에만 남긴다.

### 결과 자료와 초기화·다른 기기 재개

- **로컬 자료 루트:** `/Users/parkjongsun/Documents/ChatGPT/디자인시스템정비 프로젝트/figma-code-layers/master-trial/`.
- **최종 ZIP:** `master-final-v6.zip`,32,724,721bytes, SHA256 **`d0df2a57d1e936907bb47d6392eb8a3e7453fd3bec4f449ed56ac81a352bed52`**. V2/V3/V5 ZIP도 이 폴더에 보존했다. **`export-v5/`라는 폴더명은 유지했지만 내용은 최종Version6**이다.
- **검증 자료:** `local-validation-v6.json`, `typecheck-v6.config.json`, 설치/빌드/타입 로그, `evidence/00-empty-preview.png`~`07-local-v6-saved.png`. 스크린샷·ZIP·설치 폴더는 로컬만 있고 Git에 올리지 않았다. 최종 ZIP은 Figma Version6의 Files→File actions→Download code로 다시 받을 수 있다.
- **원본 재구성:** 위 출처 문서의 기준 SHA/excluded_paths로 git archive 사본을 준비하고3,460파일/58,314,729bytes와 tree SHA256 **`53e4a5f28de4f51dca033571909d8bcbdf85f246a5f81e8c250f20eee79b4fef`**를 확인한다. 다른 SHA를 사용할 때는 민감 설정 검사를 다시 한다. 결과 추출/로컬 실행의 명령과 portable 타입 설정도 그 문서에 보존했다.
- **서버 정리:** 이번 private 로컬 검증용5180만 종료하고 포트 종료를 확인했다. 기존 사용자5177/5178·제품 앱 서버는 건드리지 않았다. Figma 최종 미리보기는 남겨뒀다. 로컬 서버/로그인/브라우저 세션은 기기 간 이동되지 않는다.
- **사용량/초기화:** 사용자가 약1시간 자리를 비우며 사용량 소진 후 초기화도 고려한다고 했다. 중간 milestone을 개인 Git으로 여러 차례 commit/push했으며 최종 결과/다음 시작점도 원격 저장한다. 계정 사용량 초기화는 자동 실행하지 않았고, 초기화 후 동일 브라우저 세션 유지나 무중단 진행을 보장하지 않는다.
- **현재 대기:** 독립 시험과 팀 문서 정리는 완료다. 다음은 사용자의 결과 확인과 FE팀 방향 논의다. 사용자가 이어가면 개인 컨텍스트 pull→제품 `feature/DL-16471` 상태/Figma Version6 접근 확인→대표 화면 비교 범위 및 하네스/에디터 방향 합의부터 시작한다. **같은 독립 시험을 처음부터 반복하거나 제품 하네스 구현을 임의로 재개하지 않는다.**

아래는 당시 이력이다. 최신 재개 범위는 위 절을 따른다. 특히 기존 연락처 예제의 Ask for changes를 다음 시험으로 삼았던 추천은 **원본 master 기반 독립 시험을 먼저 하자는 최신 방향으로 대체**한다.

## 이전 체크포인트 — 2026-10-02 · Figma Code layers 실제 DLDS 연결·실행 시험

- **이번 승인:** 사용자가 Chrome 시크릿 Figma 계정에 접속한 뒤, 기능 확인만 하던 범위를 실제 코드 연결·설정 시험으로 확대했다. 하단 `{ }` 메뉴와 오른쪽 **Code layer / Create a code layer / Clone repository / Upload folder**를 직접 확인했으므로 실제 기능은 **Figma Design Code layers**로 확정했다. Local Make로 혼동하지 않는다.
- **업로드 과정:** 사용자가 원본 `dentlink-client` 폴더를 드롭했을 때 폴더 표시 없이 Upload가 비활성이었다. 원본 디스크 사용량 약30GB, DLDS worktree 약8GB를 확인했고, UI의1GB 제한을 넘는다는 사실을 확인했다. 이것만으로 최초 드롭 미반응의 단일 원인을 확정하지는 않는다. `feature/DL-16471`의 tracked 소스 복사본에서 설치/빌드/실행 기록·환경변수9개·MCP 연결 설정·E2E 계정 관련 파일 등을 제외해 **4,258파일 / 60,773,615bytes(약60.7MB)**를 준비했다. browse로 폴더 선택→Chrome 업로드 확인→Figma의 자동 처리로 소스를 가져왔다.
- **실제 결과:** 현재 디자인 파일에 Code layer **222:24317**이 생겼고, Code editor의 **Cloud main / Version1**에서 기존 `shared/ui/ai-preview` 연락처 화면을 실행했다. 실제 DLDS와 테마·폰트를 사용하는 기존 샘플이며 이미지 재현이나 새로 만든 가짜 UI가 아니다. 수정 모달 열기→샘플 번호를4155550188로 변경→저장 후 표시 반영을 AX와 최종 화면에서 확인했다. 실제 계정·API·인증·데이터 저장은 연결하지 않았다.
- **Figma 자동 설정:** Figma 에이전트가 클라우드 복사본에 `.figma/make/{install,dev,deploy,deploy-preview,dev.json}`을 준비했다. 처음에는 실행 설정이 없었고 배포 검증에서 생성된 `icons/dist/icon-type`이 누락됐지만 자동 설정이 빌드 전 아이콘 생성으로 수정했다. UI 결과에 `verify-bootstrap`, `verify-deploy`, `verify-deploy-preview` 성공이 표시됐으며 미리보기 실제 실행·수정·저장은 Codex가 별도로 확인했다. 배포 설정 검증 성공을 제품 서비스 배포나 전체 앱 QA로 해석하지 않는다.
- **연결의 의미와 남은 검증:** Upload folder는 **일회성 소스 복사본**이다. GitHub Clone·OAuth 권한 설정·원본 저장소 push·자동 동기화는 하지 않았다. Figma 오른쪽/하단의 `main`은 클라우드 복사본의 상태이며 제품 `feature/DL-16471`이 바뀐 것이 아니다. 자연어로 새 화면 생성·후속 수정·요소 선택·DLDS 재사용/FE 수정량·코드 인계 품질은 아직 시험하지 않았으므로 자체 하네스/에디터를 완전히 대체한다고 결론내리지 않는다. 다음은 이 화면의 왼쪽 **Ask for changes**에서 작은 요청으로 실제 편집 품질을 확인하는 것이다.
- **환경 조건:** Code layers 업로드 UI는 웹 코드만 지원하고 환경변수는 지원하지 않는다고 안내했다. 실제 서비스 전체 실행과 이번 환경변수 없는 DLDS 샘플 실행은 다르다. 원본 `dentlink-client`는 release/v1.88.0이었고 정비한 DLDS/샘플은 별도 worktree `feature/DL-16471`에 있으므로 시험에는 후자를 사용했다.
- **저장/접속:** 제품 `/Users/parkjongsun/Repository/dentlink-client-dlds`는 pull 후 `e7b7148a53a684e78ed25301e8d4eb541fc06c19`, clean을 확인했으며 이번에 제품 코드를 수정·커밋·푸시하지 않았다. Figma file key `2OR0Gj7NUFEEeYBjQg5Y6v`, node-id/code-node-id `222-24317`; 현재 Chrome 시크릿 Code editor를 열어 두었다. 로컬 업로드 복사본과 출처 메타데이터는 개인 작업 폴더 `figma-code-layers/`에 있으며 최종 화면은 `evidence/figma-dlds-ready.png`에 저장했다. 브라우저 계정 세션·로컬 복사본·실행 서버는 Git으로 다른 기기에 전달되지 않는다.

### 팀 공유용 문서 지침 — 사용자 추가 요청

- 목적은 Figma 소개가 아니라 **DLDS 과제에 이미 외부 제품/참조 코드가 있는지와 우리가 계속할/줄일 작업의 방향을 FE팀에서 논의하는 것**이다.
- **짧은 실험 과정·결과 → 외부 도구/참고 자료 → DLDS 방향과 논의점**으로 정말 간단히 작성한다. 예: 원본30GB/업로드1GB 제한, 소스 복사본60.7MB로 실제 DLDS 실행 성공. 상세는 필요할 때 보완한다.
- Figma 외에도 팀에 도움이 되는 원문/코드1~2개를 덧붙인다. [우아콘 ClayDesign](https://woowacon.com/sessions/856)은 컴포넌트·토큰·규격과 검증을 AI에 연결하는 사례다. [우아한공방 챗봇 개발기](https://techblog.woowahan.com/26319/)는 관련 기술 설명·코드 스니펫을 제공하나 ClayDesign 완성 소스가 공개된 것으로 쓰지 않는다. [Vercel Labs json-render](https://github.com/vercel-labs/json-render)는 등록한 React 컴포넌트와 props 스키마를 제한한 자연어→JSON→UI 생성·렌더의 공개 구현 참고다. Dentlink에 맞는 TSX 출력/제품 연결까지 완성됐다는 뜻은 아니다.
- 이번 추가 메시지는 **문서 작성 지침**으로 받아 기록했다. 현재 Notion의 기능 미확정/미시험 표현은 이번 실험 전 작성된 내용이므로 다음 문서 정리 요청 시 이 결과로 맞춘다. 이번에는 Notion/Jira를 임의 수정하거나 팀이 도입 방향을 정한 것으로 기록하지 않는다.

## 이전 체크포인트 — 2026-10-02 · 기존 도구 대체 가능성과 프로젝트 방향으로 FE 논의안 수정

- **최신 보완 · Code layers와 실제 접속 확인:** 사용자가 한국어 [Code layers 글](https://www.figma.com/ko-kr/blog/code-on-the-figma-canvas/)과 **`{ }` 메뉴에서 Clone repository를 봤다**는 단서를 추가했다. 공식 설명은 기존 코드 가져오기→실행→디자인/프롬프트 변경→저장소 전달 흐름이므로 사용자의 개념 이해와 맞는다. 다만 로컬 Make도 복제를 제공하므로 아직 실제 기능은 확정하지 않았다. 같은 Notion을 Code layers와 프로젝트의 대체/병행/자체 개발 중심으로 다시 정리하고, 직접 접속 시 화면 확인(기능명·사용 가능 여부·연결/편집/전달 메뉴)과 회의 후 실제 샘플 연결 시험을 구분했다. 재조회로 선택지·확인 항목·미확정 표현·기존 링크를 확인했다. 디자이너 계정으로 접속해 보면 도움이 되는지에 답했으며, 실제 계정 접속/저장소 연결/Figma 실험은 아직 요청받거나 실행하지 않았다. 다음 입력은 실제 사용 화면 확인 요청이나 FE 회의 결정이며, 자료 작성으로 제품 구현을 재개하지 않는다.
- **사용자 의도 보완:** FE 회의 목적은 Figma 기능 소개가 아니다. 우리가 목표로 하는 경험이 이미 출시된 도구에 있는지, 활용하면 자체 개발을 대체할 수 있는지, Figma와 현재 작업을 함께 쓴다면 무엇을 이어갈지를 논의하는 것이다. 기능 사용 시험 여부만 묻는 자료로 좁히지 않는다.
- **최신 판단:** 핵심 경험은 이미 제품·베타 형태로 존재한다. 공식 문서상 Make kits는 유료 Full seat에서 디자인시스템 패키지·지침 기반 생성을 제공하고, 실제 저장소 수정/코드 캔버스 경험인 로컬 Make·Code layers는 여전히 제한 베타다. 기능 존재와 우리 DLDS·비개발자 사용·FE 코드 인계까지 충분히 대체한다는 판단은 별개이며 실제 팀 접근·연결·결과는 미확인이다.
- **새 논의 구조:** 기존 [FE 논의안](https://app.notion.com/p/3ecce072e82f81f3bb89fbf5729da06c)을 같은 페이지에서 수정했다. 기능별 소개 표를 프로젝트 방향 선택지(Figma 활용 중심 / 검증하며 현재 작업 병행 / 자체 환경 개발 계속)로 바꾸고, 각 선택에서 남을 작업과 조건을 정리했다. 회의 결과를 **활용할 도구 / 계속할 작업 / 보류할 개발**로 남기도록 했다. 이전 회의·Jira·샘플 링크는 보존했고 재조회로 구조와 링크를 확인했다. 새 페이지나 회의 결과 카드는 만들지 않았다.
- **추천과 결정의 구분:** 현재 DLDS 규칙·프롬프트·검증 기준은 Figma에도 활용할 수 있으므로 다듬되, 별도 제작 환경·에디터 개발 범위는 도구 활용성을 확인한 뒤 정하는 병행안을 추천했다. 결과가 충분하면 별도 하네스 구현 자체도 줄이거나 생략하고, 부족하면 확인한 부분만 개발할 수 있다. 자체 도구 개발을 목표 자체로 삼거나 계속 필수라고 단정하지 않는다. 팀이 채택한 방향은 아직 없다.
- **실행 경계와 다음 시작점:** 다음은 FE 팀에서 대체 가능성·비교 범위/담당·현재 작업의 계속/축소/보류를 합의하고 그 결과를 전달받는 것이다. 이번에는 Notion/개인 컨텍스트만 변경했고 제품 코드·테스트·Jira 상태·PR·호스팅·Figma 설정/실험은 진행하지 않았다. 제품 `feature/DL-16471`은 `e7b7148a53a684e78ed25301e8d4eb541fc06c19`에서 clean으로 확인했다. 아래10월1일은 당시 자료이며 이후 시작은 이 목적과 팀 결정부터 확인한다.

## 이전 체크포인트 — 2026-10-01 · Figma 코드 기능 조사·FE 후속 논의안 준비

- **요청과 현재 경계:** 사용자가 오늘 본 Figma 기능을 다른 AI에 빠르게 질문한 답변을 가져왔다. 붙여넣은 글은 정확한 기능 명세나 도입 요구사항이 아니라, 현재 AI 화면 제작 과제와 비슷해 보여 가져온 탐색 자료다. 공식 자료 조사 후 짧은 브리핑과 FE 팀 논의용 Notion을 요청했다. Figma 도입·설정·비교 실험이나 제품 구현은 이번에 진행하지 않았다.
- **회의 자료:** [FE 논의안 · Figma 코드 기능과 AI 하네스 방향](https://app.notion.com/p/3ecce072e82f81f3bb89fbf5729da06c)을 기존 Development Documents에 만들고 재조회로 내용·날짜·태그를 확인했다. 기능별 역할, 우리 작업에 미치는 영향, 사용 가능 여부·첫 사용 목적·비교 실험·후속 범위의 질문4개를 담았다. 새 회의가 이미 열렸거나 결론이 정해진 것으로 기록하지 않는다. 상세 공유 자료는 Notion 한 곳에서 관리하며 이 파일은 개인 진행 체크포인트다.
- **공식 자료에서 구분한 역할:** [로컬 Make](https://help.figma.com/hc/en-us/articles/40775535020695-Make-in-your-local-codebase)는 실제 저장소의 실행 화면을 프롬프트·요소 선택으로 수정하고 코드·브랜치·GitHub PR로 연결한다. [Code layers](https://www.figma.com/blog/code-on-the-figma-canvas/)는 Figma 캔버스에서 코드를 실행하고 디자인 레이어 수정과 연결한다. [Make kits](https://help.figma.com/hc/en-us/articles/43602872461079-Bring-your-design-system-package-to-a-Make-kit)는 실제 디자인시스템 패키지와 사용 지침으로 새 화면·프로토타입을 생성한다. [Code Connect](https://developers.figma.com/docs/code-connect/)는 Figma 컴포넌트와 실제 코드 사용 방법을 연결하는 기능이다. 서로 같은 기능으로 설명하지 않는다.
- **미확인 조건:** 오늘 사용자 화면의 Code 메뉴가 정확히 어떤 기능인지는 아직 확인하지 않았다.2026-10-01 공식 안내상 로컬 Make·Code layers는 제한 베타이고 팀 계정의 접근 권한은 미확인이다. 로컬 Make는 Mac Beta 앱·저장소 권한·개발자 최초 실행 설정이 필요하다. Make kits는 배포 가능한 디자인시스템 패키지 준비가 필요하며 현재 private/workspace 의존 코드를 폴더 그대로 넣을 수 있다고 가정하지 않는다. 레포 연결만으로 완벽한 자동 동기화·코드 품질이 보장되거나 비개발자 설정이 없어지는 것은 아니다. ClayDesign의 공개 발표만으로 내부 Figma API·AST·WebView 구현은 확인하지 못했다.
- **추천은 도입 결정 전 제안:** 실제 사용 가능한 Figma 기능부터 확인하고, 지금 만든 DLDS 연락처 수정 샘플을 같은 요청으로 비교하는 작은 실험을 제안했다. DLDS 재사용·화면/동작·FE 수정량을 보고 필요하면 대표 페이지1개까지 확인한다. Figma가 요청·미리보기·편집 환경을 제공하면 별도 도구 개발을 줄일 수 있지만 DLDS 사용 규칙·프롬프트·검증·FE 인계 기준은 계속 필요하다. 이 추천을 사용자나 팀이 채택한 결정으로 간주하지 않는다.
- **Notion·Jira 연결:** 이전 [FE 2차 회의 결과](https://app.notion.com/p/3dfce072e82f812c843afed105630c98) 상단에 도입 결정 전 후속 논의안 링크만 추가했다. DL-16437/16471 기준 문서에 새 논의안 링크를 넣고, 상위의 오래된 미착수 표현을 첫 DLDS 샘플 생성·실행 완료/비개발자용 하네스 미완성으로 맞췄다. 재조회로 설명 일치·제목/진행 중 상태 보존을 확인했다. 완료된 회의 카드 DL-16464/16465와1단계 카드는 변경하지 않았다.
- **제품 저장 상태:** `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16471`, `e7b7148a53a684e78ed25301e8d4eb541fc06c19`. 이번에는 제품 코드·테스트·브랜치·PR·호스팅을 변경하지 않았고 working tree가 clean인 것을 확인했다. 기존 실제 DLDS 연락처 샘플과 실행 안내는 아래 첫 실험 기록을 따른다.

### 다음 시작점 — FE 논의 후 사용 환경·비교 범위 결정

1. 개인 컨텍스트를 pull하고 위 새 Notion 논의안과 팀 논의 결과를 확인한다. 기존 DLDS 정비·첫 샘플·ClayDesign을 기준으로 합의한 목표는 유지한다.
2. 사용 가능한 Figma 기능/권한, 첫 대상(새 화면 기획 또는 기존 화면 수정), 비교 실험 진행 여부·담당·확인 범위, 자체 하네스 보완 범위를 팀에서 정한다. 논의 자료만으로 Figma 설정이나 실험을 자동 착수하지 않는다.
3. 이후 승인된 방향에 따라 Figma 활용을 비교하거나 현재 하네스의 대표 페이지·후속 수정·반복 품질·FE 인계 시험을 이어간다. 비개발자용 사용 환경과 완성된 하네스는 아직 없다.

## 이전 체크포인트 — 2026-10-01 · 2단계 첫 생성·로컬 미리보기 확인

- **최신 마무리 · 번외 질문 전 저장:** 사용자가 지금까지의 작업을 저장·정리한 후 다른 질문을 하겠다고 요청했다. 두 저장소를 pull하고 제품 `feature/DL-16471`의 `e7b7148a5`와 추적 HEAD 일치·clean, 개인 컨텍스트의 이전 결과 `5fa543e` 저장 상태를 다시 확인했다. 이번에는 제품 코드·테스트·Jira/Notion/Sites를 추가 변경하거나 검사를 재실행하지 않는다. 기존 미리보기 서버5178은 사용자가 볼 수 있도록 유지한다. 대표 전체 화면·하네스 후속 구현은 재개 요청을 받을 때 이어가며 번외 질문으로 자동 착수하지 않는다.
- **날짜 고정 테스트에 대한 확인:** 사용자가 `vi.setSystemTime(new Date(2026, 8, 18))`의 하드코딩 여부와 적절성을 물어 코드·추가 커밋 `3f12af1da`·당시 실패 기록을 확인했다. `shared/ui/tests/overlay-focus.test.tsx`의 빈 달력은 현재 월을 열지만 시험은2026-09-21을 클릭한다. 월이10월로 바뀌면 실패하므로 테스트에 기존부터 있던 `currentDate`와 같은2026-09-18로 Date만 고정하고 `afterEach`의 `vi.useRealTimers()`로 복원한다. JS월 인자8은9월이다. 값 자체는 고정값(하드코딩)이 맞지만, 일정한 테스트 조건을 만드는 용도로 적절하며 업무 정책 날짜나 제품 런타임 변경이 아니다. 이 내용으로 사용자에게 답변했으며 코드 수정 요청은 없었다. 질문 검토 후 추가 제품 변경은 하지 않았다.
- **이번 승인과 저장 순서:** 사용자가 준비 문서를 확인하고 “지금단계 저장한번하고 진행”을 요청했다. 초안 `b492577`에 이어 착수 승인·범위를 개인 컨텍스트 `cc6db07`로 먼저 커밋·푸시한 뒤 첫 실행 실험을 진행했다. 1단계는 합의한 범위에서 우선 완료이며, 이번 결과는 2단계의 작은 연결 시험이다.
- **제품 저장 상태:** 기존 `/Users/parkjongsun/Repository/dentlink-client-dlds` worktree를 재사용하고, 저장된1단계 `56bc1be5ce975c6726637be51347911d730410ba`에서 `feature/DL-16471`을 만들었다. 첫 미리보기 구현은 **`e7b7148a53a684e78ed25301e8d4eb541fc06c19`**이며 정상 hooks로 커밋·푸시했다. 로컬·추적·실원격 HEAD 일치와 clean을 확인했다. `feature/DL-16466`과 비교용 Draft PR#4643은 그대로다. 새 worktree·PR·병합·배포는 없다.
- **실제로 생긴 화면:** `shared/ui/ai-preview/`의 Clinic 연락처 수정 예제. 실제 DLDS Button·Icon·Modal·SelectDropdown·TextInput·Typography, 테마·Clinic Pretendard를 사용한다. 샘플 국가/연락처와 저장 상태는 `App.tsx`, 재사용 화면과 `contact/countries/onSave` 연결점은 `UpdateProfilePreview.tsx`로 분리했다. 수정→번호 입력→Save로 화면의 연락처가 바뀌고 새로고침하면 초기값으로 돌아간다. 제품 API·인증·권한·SMS·새 업무 기능은 연결하지 않았다.
- **실행과 검사 위치:** 저장소 루트 `pnpm dev:ai-preview` → **http://127.0.0.1:5178/**. 현재 로컬 서버를 실행해 사용자가 볼 수 있게 두었다(node PID68356, exec95512; 기기·세션 종료 시 유지되지 않음). 종료는 실행 터미널 Ctrl+C. `pnpm dev:ui`5177의 기존 컴포넌트 모음과 별도다. 새 기기는 설치 후 같은 브랜치에서 재실행하며 포트가 사용 중이면 strictPort로 중단한다. 실행·사용 기준은 제품 `shared/ui/ai-preview/README.md`, 전용 type/lint/build 스크립트·tsconfig/Vite 설정에 남겼다. 빌드 산출물 `dist-ai-preview`는 Git 제외다.

### 생성·수정·검증 근거

- **첫 생성 조건:** 새 컨텍스트의 생성 에이전트에게 “치과 연락처 수정창, 현재 국가·번호 표시, 국가 고정, 숫자 외 입력 제거·빈 번호 저장 금지, 영어 UI, PC/좁은 화면, 부모 샘플 상태와 callback 저장”을 요청했다. 실제 지침·공개 DLDS·선택 컴포넌트 소스/타입·테마를 읽게 했고 Clinic의 완성된 UpdateProfile 코드는 열거나 복사하지 않게 했다. 첫 생성본 hash는 `7211265283511a3f32fc9aa97e3cd4e5f5ab6127587c9492ae45941bc8213912`다. 이후 기존 서비스에서 확인한 modal480/unset/352, gap8, 모바일/태블릿 padding, 국가 required 표시를 한 번의 후속 요청으로 반영했다. 따라서 완전히 독립된 반복 생성 품질이나 수정 없이 완성되는 결과를 증명한 것은 아니다.
- **계약·환경 보완:** InputBase의 required는 라벨 표시에만 쓰이므로 생성 화면의 해당 input ref에만 native required를 설정했다. 초기 환경의 GlobalStyle 테마 타입과 entry Fast Refresh 경고는 preview 내부에서 수정했고, Vite 패키지 자기 import 문제는 공개 `@dentlink/ui/dlds`를 실제 `src/dlds.ts`로 연결하는 전용 alias로 해결했다. 가짜 UI·externalize로 우회하지 않았다. 공통 런타임 소스·기존 앱·gallery·에셋·의존성·lockfile은 바꾸지 않았다.
- **최종 정적 검사:** `type:ai-preview`, `lint:ai-preview`(경고0), `build:ai-preview`, diff check 통과. 현재 코드로 재실행했으며 실제 생성 파일이 검사·번들 대상임을 확인했다. 정상 commit hooks의3앱 type와 push hooks의3앱 lint·coverage를 통과했다. 앱의 기존 lint 경고는 남아 있다. 별도 읽기 전용 검토에서도 props/callback 분리, 저장·취소 흐름, 검사 범위·실제 서비스 영향에 중요한 문제를 발견하지 않았다.
- **실제 브라우저 확인:** IAB에서 수정 열기/초기 focus·국가 disabled·빈 번호 Save 차단·`650abc5550199`→`6505550199` 저장·닫힘·재열기·Escape/버튼 focus 복귀·Tab 순환·닫기 시 미저장 값 미반영·새로고침 초기화 확인.320×568/375×812/1280×900과 기본 IAB 폭에서 가로 overflow 없이 입력/Save 표시를 확인하고 viewport를 원복했다. 콘솔 error0이며 변경하지 않은 공통 styled-components의 DOM prop 경고는 남는다. 최종 스크린샷은 로컬 `/tmp/dentlink-ai-preview-final.jpg`; Git으로 다른 기기에 전달되지 않으며 코드를 실행하면 화면을 다시 볼 수 있다. 실휴대폰 키보드·스크린리더·모바일 UA Drawer는 검증하지 않았다. 이번 국가는 disabled라 Drawer 동작 시험 대상도 아니다.
- **Jira:** DL-16471의 현재 진행에 실제 첫 생성·검증·실행 안내 링크와 남은 범위를 반영하고, 제공되는 진행 전이(id2)로 **진행 중**으로 바꿨다. 재조회로 제목·본문 일치·상태를 확인했다. 상위와1단계·완료된 회의 카드, Notion·Sites는 이번에 수정하지 않았다.

### 다음 시작점 — 대표 화면·후속 수정과 반복 사용

1. 개인 컨텍스트를 pull하고 이 최상단 절을 읽는다. 제품은 기존 dlds worktree의 **`feature/DL-16471`**을 pull한 뒤 HEAD/dirty부터 확인한다. 다른 기기에서1단계 브랜치에 머물러 있으면 깨끗한 checkout에서 이 원격 브랜치를 사용한다. 로컬 서버·node_modules·인증·/tmp는 이전되지 않는다.
2. 첫 화면은 위 실행 명령으로 직접 볼 수 있다. 현재 브라우저에 프롬프트 입력칸이나 AI 자동 실행 기능은 없으며, Codex 생성→실행→검증을 개발 환경에서 시험한 상태다. 전체 하네스·에디터·FE 작업 감소가 완료됐다고 말하지 않는다.
3. 다음 요청에서는 초안 `dentlink-ai-dlds-draft.md`의 대표 화면 후보에서 전체 페이지 범위를 정하고 생성/후속 수정·모호한 요구의 질문·없는 UI의 제안·반복 품질을 검증한다. My Profile 전체에는 사진·메뉴·Quick Links 등 공개 DLDS 밖 UI가 있으므로 첫 연락처 예제 성공만으로 통째로 연결하지 않는다. 실제 FE 인계와 수정 작업 감소도 별도 확인한다.
4. 비개발자가 개발 설정 없이 사용할 모델/도구·프롬프트 입력/결과 전달·접근/호스팅 방식은 아직 미정이다. 필요한 범위부터 논의하며 범용 에디터나 제품 API·권한·공통 UI 변경을 자동 확장하지 않는다. DLDS1단계 전수 QA·아이콘 추가 대조·기존 비교 PR 변경을 다시 시작하지 않는다.

아래 준비 초안 및 이전 체크포인트는 당시 기록이며 현재 상태는 이 최상단 절을 따른다.

## 이전 체크포인트 — 2026-10-01 · 1단계 우선 완료·2단계 사용 기준·실험 초안 준비

- **최신 실행 승인 — 저장 후 첫 실험:** 사용자가 준비 문서만 생성된 상태와 다음 작업에서 실행 화면을 확인한다는 설명을 이해한 뒤 “지금단계 저장한번하고 진행”을 요청했다. 준비 초안은 b492577로 원격 저장돼 있으며 이번 승인을 먼저 저장하고 구현을 시작한다. 첫 연결 시험은 추천한 Clinic 내 정보 수정 팝업으로 진행한다. 기존 dlds worktree를 재사용하고 저장된1단계56bc1be5c를 기반으로2단계 `feature/DL-16471` 브랜치를 만든다. 실제 DLDS·가상 연락처·로컬 저장을 쓰는 독립 미리보기와 검사 대상을 준비한다. 제품 API/권한·전역 UI·기존 비교 PR·에디터·호스팅까지 착수하는 승인은 아니다. 중단되면 Git dirty·브랜치부터 확인해 첫 미리보기 구현/검증을 이어간다.

- **진행 승인과 현재 단계:** 승인된 E2E 수정·검증 → 조사 자료 정리 → 검사·커밋·푸시·메모리 저장을 마쳤다. 사용자는 1단계를 합의한 개발·정리 범위에서 우선 완료로 보고, ClayDesign 조사 후 제안한 방향을 **2단계 AI 프롬프트·하네스의 작업 기준으로 채택**했다. 이어 첫 준비 작업을 승인해 **AI용 DLDS 사용 기준·미리보기 구성안·시험 화면 후보·요청/검증 기준 초안**을 작성했다. 아래 준비 결과와 다음 시작점을 따른다. 생성 화면·하네스·에디터 구현과 실행 실험은 아직 하지 않았다. 날짜·모달 등의 대표 검증을 처음부터 전수 반복하거나 아이콘 추가 전수 대조를 재개하지 않았다.
- **수동 QA 결과:** 사용자가 전체적으로 눌러보았을 때 괜찮아 보였다고 보고했다. 모든 화면·상태의 무결함을 확정한 결과는 아니다. 이 결과와 이전 대표 화면·브라우저 검증을 1단계 마감 근거로 사용하며, 이후 구체적인 증상이 나오면 해당 사용처를 확인한다.
- **제품 저장 상태:** `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16466`. `3f12af1da`(회원가입 선택자·날짜 테스트 보완), `56bc1be5ce975c6726637be51347911d730410ba`(조사 자료 정리)를 정상 hooks로 커밋·원격 푸시했다. 최종 로컬·추적·원격 HEAD 일치, 미커밋 변경 없음과 E2E 전용 서버 종료를 확인했다. 기존 비교용 [PR #4643](https://github.com/Innvoaid/dentlink-client/pull/4643)은 의도적인 Draft이며, 제목·상태·대상·충돌·리뷰를 별도 변경하지 않았다. 병합·배포·Notion/Sites 변경은 하지 않았다. Jira 후속 정리는 아래 최신 결과를 따른다.
- **Jira 동기화 완료 · 2026-10-01:** 사용자 요청으로 상위 [DL-16437](https://innovaid.atlassian.net/browse/DL-16437)와 하위4개를 실조회했다. 상위는 **진행 중**을 유지하고 현재 단계·다음 시작점을 갱신했다. [DL-16466](https://innovaid.atlassian.net/browse/DL-16466)은 실제 제공되는 “요구사항에 대해 개발 완료” 전이(id12)로 **Ready for Deploy**에 변경했다. 최신 정비·사용자 수동 QA·E2E16/UI200/아이콘2 결과와 미확인 환경을 상단에 추가했고, 이전9월28일 기록을 당시 기록으로 구분했다. 삭제한 조사 자료의 과거 링크3개는 파일 존재를 확인한 당시 커밋 링크로 바꿨다. [DL-16471](https://innovaid.atlassian.net/browse/DL-16471)은 구현 미착수이므로 **해야 할 일**을 유지하고, 준비된 코드/문서·첫 산출물·요청→재질문→생성→미리보기→검증/수정·반복 평가·비개발자 사용 환경의 흐름을 반영했다. 과거 회의 DL-16464/16465는 본문·완료 상태 그대로다.5카드 재조회로 제안 본문 일치와 제목·담당자·상위 관계 보존을 확인했다. 개발 완료 상태는 배포 완료 증거가 아니며 이번 Jira 정리로 하네스 구현을 시작하지 않았다.

### 완료한 수정·정리

- **알려진 Password E2E 문제 해결:** `e2e/clinic/steps/auth/signup-step1.ts`의 `getByLabel("Password")`에 `exact: true`를 지정했다. 입력과 `Show password`/`Clear password` 버튼이 함께 매칭되던 문제를 해결하며 제품 표시나 접근성 이름은 바꾸지 않는다. 소비자인 회원가입 전체·Step2/3 검증2파일을 모두 실행했다.
- **최종 검사에서 발견한 날짜 테스트 보완:** `shared/ui/tests/overlay-focus.test.tsx`의 부모 창/달력 Escape2건은 빈 달력이 실행 월을 열지만 고정된9월21일을 찾고 있어10월1일 실행에서 실패했다. 해당 사례에서 Date만2026-09-18로 고정하고 종료 시 복원했다. 실제 타이머·제품 달력 동작은 변경하지 않았다. 처음198통과/2실패 → 보완 후200통과다.
- **일회성 자료5개 삭제 완료:** `shared/icons/figma-provenance.json`, `shared/ui/design-audit/{figma-icons.tsv,figma-logos.tsv,FIGMA_REMAINING_AUDIT.md,figma-source-snapshot-2026-09-21.json}`. 감사 문서에만 있던 Checkbox·Stepper·Slider·Tooltip 상태 근거는 `shared/ui/DESIGN_COVERAGE.md`에 필요한 만큼 보존했다. README·tests 안내·모음 화면의 삭제 파일 참조도 정리했다.
- **계속 필요한 생성 설정·테스트 유지:** `svgr.config.js`의 기존 automatic JSX 대상121개는 같은 정적 목록으로 옮겨 provenance 의존을 제거했다. `generation.test.mjs`는 Figma 해시/스냅샷 대신 실제 SVG 재생성·공개 export와 중첩 SVG viewport/host props를 검사한다. SVG507개 재생성은 저장 TSX와 바이트 동일이며 에셋·dist·export·사용처 변경0이다. 전체532개 중 나머지25개는 원본 SVG 없이 남은 기존 TSX/동적 Icon 이름이며 이번 생성 검사나 신규 공개 export 대상이 아니다.
- **유지하는 파일·범위:** `shared/ui/tests/`, `DESIGN_COVERAGE.md`, 실제 SVG/TSX·진입점·모음 페이지·로컬 스크립트·제품 E2E는 유지한다. ListItemGroup 추가 작업, 전역 UI 기본값 변경, 버튼 여백·Icon 전환·Escape의 새 디자인 수정은 하지 않았다. 기존 사용자가 실행한 Clinic/Lab 개발 서버를 종료하지 않았다.

### 최종 검증과 한계

- 공식 **local focused E2E16개 통과**, `e2e-runs/2026-10-01T05-06-18-025Z-31a9ebed`. `00_signup.spec.ts`와 `00_signup_step2_3_validation.spec.ts` 전체를 실행했다. 실패·flaky·skip·미실행·중단·전역 오류0, gate_passed=true. 실행 당시 부모 HEAD는812886171이며 작업 사본 source `153d8b63036358ae818aba3b2545359f7e8251636c3a2472f1dbed73dc07e788`, 실행 전후 동일이다. 이후 변경은 테스트 날짜 고정과 검증 설명뿐이며 제품 실행 코드는 그대로다. 로컬 FE+DEV API 근거로, staging 전체·배포 검증은 아니다.
- 공통 UI **24파일200개**, 아이콘 생성 **2개** 통과. E2E TypeScript, 모음 strict TypeScript·scoped ESLint·Vite build 통과. 정상 commit hooks의 Clinic/Lab/Admin 타입 및 push hooks의 앱 lint·공통 coverage를 통과했다. 앱의 기존 lint 경고와 모음 chunk 크기 경고는 남으며 전체 서비스 무경고 판정은 아니다.
- 9월29일 중단된 사용자 실행의 보존 오류는 Password2건과 Insta Smile Vision2건이다. ISV 두 trace의 `/catalogs/category`는200/13항목이지만 `Insta Smile Vision`·`INSTA_DESIGN`이 없었다. 카테고리 선택 전 데이터 전제 실패로, DLDS UI 회귀 근거가 아니다. 당시 전체 실행의 최종 결과는 미확정이며 이번에 ISV 서버 데이터나 테스트 기대값을 변경하지 않았다.
- 기존 미확인 조건인 DSO 권한/92일 날짜 범위, 수정 가능한 NUMBER 옵션 주문, 실휴대폰·스크린리더·전체 다국어·staging 전수는 유지한다. 지금 확정된 추가 UI 구현 누락이나 하네스 논의의 필수 선행 실패로 취급하지 않는다. Button12→10px 여백, Icon A→B 로딩 빈자리, Popup Escape 닫기는 디자이너 문의 시 찾을 참고 기록이며 새 오류 판정은 없다.

### 2단계 첫 준비 결과 — 2026-10-01

- **검토할 문서:** [AI용 DLDS 사용 기준과 첫 실험 초안](dentlink-ai-dlds-draft.md). 공통 지침·실제 코드 계약·미리보기 구성안·후보3개·요청 예시·검증과 FE 인계 기준을 한 문서에 모았다. 승인 전 실험 제안이며 공식 제품 요구나 새로운 DLDS 계약을 확정한 문서가 아니다.
- **근거 확인:** 개인 컨텍스트와 제품을 pull했다. 제품은 위56bc1be5c/clean이며 AGENTS·DLDS README·공개 진입점·테마·실제 props/types·gallery 구성과 Clinic 사용 화면을 읽었다. Jira DL-16471의 현재 본문과 `해야 할 일` 상태도 재조회했다. README의 핵심 계약과 코드 일치, `dev:ui`는 고정된 모음 페이지이고 별도 생성 파일이 자동 검사되지 않는 점을 확인했다.
- **추천과 미정:** 첫 연결 시험은 Clinic 내 정보 수정 팝업을 추천한다. My Profile 전체와 주문목록은 후속 후보이며 첫 화면을 확정하지 않았다. 전체 My Profile에는 사진·계정 메뉴·Quick Links·권한 표시가 있고 공개 DLDS 밖 UI도 있어 별도 범위 결정이 필요하다. 작은 연결 시험과 완성 화면을 답으로 주지 않는 자연어 생성 품질 시험을 구분한다.
- **검토·경계:** 읽기 전용 병렬 검토로 코드 계약·범위·미리보기/검사 대상과 초안을 교차 확인했다. 모바일 Drawer의 `react-device-detect` 분기는 viewport 변경만으로 검증하지 않는 점을 보완했다. 제품 파일·Git/PR·Jira/Notion/Sites를 변경하거나 서버·테스트를 실행하지 않았다. 문서와 재개 기록만 개인 컨텍스트에 저장한다. 생성 품질·자동 수정·FE 작업 감소는 아직 미검증이다.

### 다음 시작점 — 첫 생성·미리보기 실험

1. 다른 기기는 개인 컨텍스트와 제품 `feature/DL-16466`을 `git pull --ff-only`하고 위 HEAD/dirty를 확인한다. 로컬 인증·환경변수·node_modules·브라우저·e2e-runs·/tmp·실행 서버는 Git으로 이전되지 않는다. 제품 코드·팀 문서와 이 체크포인트로 이어간다.
2. 위 초안으로 **첫 시험 화면·샘플 동작·실행 도구·결과 파일/검사 위치**를 정한다. 추천은 Clinic 내 정보 수정 팝업으로 실제 DLDS 연결을 확인하는 것이다. 기존 코드·문서·모음 기반을 활용하되 생성 화면 진입점과 타입/lint/빌드 대상을 함께 연결한다. 특정 주문목록·JSON 에디터 구조로 고정하지 않는다.
3. 구현 착수 지시 후 공통 기준을 읽는 첫 생성·실행·수정 시험을 진행하고, 결과를 근거로 규칙을 보완한다. 연결 확인 후 대표 화면 전체·모호한/없는 UI/반복/후속 수정 요청·FE 인계를 확인한다. PM·디자이너의 접근 환경·모델·호스팅은 아직 선택하지 않았다. 기존 비교용 DLDS PR을 임의로 정식 검토/배포 상태로 바꾸지 않는다.
4. DLDS 정비 → **AI 프롬프트·하네스 정비가 핵심** → 가능하면 에디터 순서를 유지한다. 범용 에디터 개발을 먼저 시작하지 않는다. 이번 준비 승인만으로 제품 런타임·전역 UI·API/권한·신규 업무 기능까지 변경하지 않는다.

### 2단계 합의된 작업 기준 — 2026-10-01

사용자가 ClayDesign와 관련 공식 자료 조사 후 정리한 방향을 긍정하고, 이를 메모리에 남겨 작업 기준으로 삼도록 요청했다. 이전의 조사 후 추천을 아래 합의로 확정한다.

- **목표:** FE가 실제 DLDS 컴포넌트와 화면 구성 기준을 준비하고, PM·디자이너가 Figma 시안 전 자연어로 실행되는 화면을 만들고 수정하며, FE가 같은 코드와 컴포넌트를 이어받는 환경을 만든다.
- **준비할 다섯 가지:** ① 컴포넌트 위치·속성·기본값·테마·예제 ② 기존 서비스의 배치·간격·화면 밀도·조합 기준 ③ 부족한 요구의 재질문과 컴포넌트 선택·신규 UI 제안 기준 ④ 실제 코드 생성→실행→미리보기→타입·화면·동작 검증→수정/중단 ⑤ 비개발자의 요청·수정과 FE 코드 전달 경험. 긴 공통 프롬프트나 개발 설정을 사용자마다 반복하게 하지 않는다.
- **진행 순서:** AI용 DLDS 기준과 실행 기본 환경·시험 요청을 함께 준비 → 작은 구성으로 연결 확인 → 대표 화면 전체와 후속 수정 요청까지 시험 → 같은 요청을 반복하며 기준 보완 → 비개발자의 사용과 FE 인계 확인. 작은 팝업만 생성한 결과로 전체 목표 달성을 판단하지 않는다.
- **완료 판단:** 실제 DLDS 사용, 덴트링크다운 화면 구성과 요구한 동작, 반복·수정 시 품질 유지, FE가 다시 만드는 작업의 실제 감소를 함께 확인한다. Figma 시안이 없는 시점의 화면에 존재하지 않는 목표 이미지와의 픽셀 일치를 약속하지 않는다.
- **범위와 미정 사항:** 제품 API·권한·업무 데이터 연결은 FE의 후속 개발과 구분하고, 신규 UI를 공식 DLDS로 임의 등록하지 않는다. Figma 출력·요소 선택·시각 에디터는 선택 확장이다. 특정 모델·서비스·MCP/검색 서버·Storybook 재도입·첫 시험 화면·호스팅 방식은 아직 선택하지 않았다. ClayDesign은 목표와 구조의 참고이며 확인되지 않은 내부 기술을 그대로 구현하는 뜻은 아니다.

### 2단계 개념 조사 — ClayDesign 참고 · 2026-10-01

- **사용자 방향:** 1단계는 합의한 개발·정리 범위에서 우선 완료로 보고 2단계를 논의한다. 사용자가 [WOOWACON ClayDesign 세션](https://woowacon.com/sessions/856)을 거의 같은 목표의 참고 사례로 제공하고 공개·관련 자료 조사를 요청했다. 이번 작업은 개념 조사이며 제품 코드·하네스·에디터 구현이나 Jira/Notion/Sites 변경은 하지 않았다.
- **공개 범위:** 세션은 「세 번 그리던 화면을 한 번에: ClayDesign 개발기」, 발표자 김상국·류현승이다. 브라우저에서 소개를 확인했다. 실제 디자인시스템을 AI가 사용할 기준으로 제공하고 화면을 검사·수정하며, Figma 산출물·코드·베타 앱으로 이어지는 경험을 소개한다. [행사 공지](https://techblog.woowahan.com/27782/)의 개최일은 2026-10-28로 조사일보다 뒤다. 추가 ClayDesign 발표 슬라이드·영상·공개 코드는 검색에서 발견하지 못했으며, 존재하지 않는다고 단정하지 않는다. 특정 모델·DSL·Figma 변환 방식·내부 구조는 확인되지 않았다.
- **가장 직접적인 연결 근거:** 발표자 김상국의 [컨텍스트 엔지니어링 글](https://techblog.woowahan.com/26459/)(2026-07-07)은 DS MCP 생성에서 지식 제공과 하네스의 역할을 구분한다. 컴포넌트/토큰/기본값 정보, 사용 가능한 재료를 우선하는 선택 순서, 생성 후 규칙 검사, 반복 실행의 구조 비교를 참고한다. Android·Figma 입력 사례이며 ClayDesign 내부 구현 자체라고 명시된 것은 아니다. 글의 규칙 수·실험 횟수·개선 비율을 Dentlink 기준이나 성능 보장으로 옮기지 않는다.
- **추가 우아한 공식 근거:** [DS 맥락 챗봇](https://techblog.woowahan.com/26319/)(2026-05-22)은 IDE/CLI의 비개발자 진입 장벽과 관련 문서·코드·설계 의도의 검색을 설명한다. 아이디어만으로 UI를 만드는 GenUI는 글 당시 향후 목표다. [전자계약서 AI 개편](https://techblog.woowahan.com/27604/)(2026-09-18)은 실제 컴포넌트 문서·렌더 이미지, 코드 생성→실행→화면 비교→수정, 사람이 확인하는 동작과 업무 로직 경계를 보여준다. 이는 디자인 이미지를 받은 뒤 구현하는 사례이므로 우리 목표의 Figma 이전 경험과는 구분한다. [팀용 하네스](https://techblog.woowahan.com/26177/)(2026-04-17)는 공통 규칙·재사용 절차·필요한 맥락 관리의 참고다.
- **다른 공식 구현 참고:** [v0 Design Systems 2.0](https://v0.app/docs/design-systems-2)은 DS 소스와 실제 소비 앱을 읽고 실행 가능한 시작 앱을 검토해 팀 skill로 저장하는 구조다. [Figma Make kit](https://help.figma.com/hc/en-us/articles/43602872461079-Bring-your-design-system-package-to-a-Make-kit)는 실제 production npm 패키지와 guidelines를 사용하되 Vite 호환·workspace 의존 제거가 필요하다. [Storybook MCP](https://storybook.js.org/docs/ai/mcp/overview)는 문서 조회·실행/미리보기·검사를 구분하며, [원격 공유](https://storybook.js.org/docs/ai/mcp/sharing)는 문서 도구와 로컬 개발·검사 도구의 범위가 다르다. 해당 서비스 도입, 패키지 이전, Storybook 재도입을 결정한 것은 아니다.
- **조사 후 추천하는 개념:** 실제 DLDS와 화면 구성 기준을 공통으로 제공해 PM·디자이너가 자연어로 실행되는 화면을 만들고 수정하며, FE가 동일한 코드와 컴포넌트를 이어받는 환경이다. 하네스에는 관련 맥락 선택, 부족한 요구의 재질문, 생성 코드의 실행·검증·수정과 멈출 기준, 결과 전달이 포함된다. MCP는 자료·도구를 연결하는 수단이고 그 자체가 실행·검증 환경은 아니다. 처음부터 RAG 서버·벡터 DB·자체 MCP·범용 에디터가 모두 필수인 것은 아니다.
- **우리 기준에 맞춘 제안:** 기존 DLDS 컴포넌트 우선 → 기존 컴포넌트 조합 → 필요시 토큰을 사용하는 새 UI 초안과 팀 검토. 공식 DS 등록과 업무 API·권한·데이터 동작은 임의로 생성·확정하지 않는다. Figma가 없는 시점의 화면은 요구 충족·DS 사용·레이아웃/상태별 완성도·동작·FE 재사용을 평가한다. 존재하지 않는 목표 시안과의 픽셀 일치를 약속하지 않는다. 비개발자는 개발 환경이나 긴 공통 지침을 매번 설정하지 않아야 한다.
- **다음 시작점 제안:** ① 실제 컴포넌트·속성·테마와 기존 화면 조합을 AI가 찾을 기준 정리 → ② 실제 DLDS가 동작하는 공통 미리보기 기본 환경 → ③ 구체적/모호한/수정/없는 UI 요청의 생성·검증 실험 → ④ 비개발자 요청·미리보기·수정·FE 전달 흐름. 기존 문서·모음·코드를 재사용하며 새 자료를 무조건 늘리지 않는다. 앞서 제안한 Clinic 내 정보 수정 팝업은 첫 연결 확인 후보일 뿐 확정 화면이 아니다. 작은 구성 검증 후 대표 화면 전체의 품질까지 확인해야 한다. 사용 도구·첫 시험 화면·제공 방식은 아직 미정이다. Figma 출력·요소 선택·시각 편집기는 선택 확장으로 유지한다.

아래는 당시의 이전 체크포인트다. 최신 상태와 파일 보관 판단은 이 최상단 절을 우선한다.

## 이전 체크포인트 — 2026-10-01 · 수동 QA 결과 접수·다음 진행 논의

- **사용자 수동 QA 결과 접수:** 사용자가 전체적으로 눌러보았을 때 괜찮아 보였다고 보고했다. 모든 부분을 전수 확인해 무결함을 확정했다는 의미는 아니다. Calendar·DatePicker와 Modal·Popup을 중점 확인 대상으로 안내한 상태였으며, 실제 확인한 경로·환경별 상세 결과는 아직 없다. 이전의 QA 결과 미수신 상태를 이 결과로 갱신한다.
- **현재 실행 경계:** 이번 요청은 추가 QA 필요성과 다음 진행 순서에 관한 의견 요청이다. 제품 코드 수정·테스트·화면 QA를 시작하지 않았다. 다른 기기에서도 이 결과를 읽고 사용자의 실행 지시부터 이어간다. 2026-10-01 확인한 제품 `feature/DL-16466`의 로컬·원격 HEAD는 `812886171`로 일치하고 clean이다.
- **Codex 추천 — 실행 전:** 날짜·모달 등 이미 수행한 대표 화면/회귀 검증을 처음부터 전수 반복하지 않는다. 알려진 Password E2E 선택자 충돌을 수정·대상 재실행하고, Insta Smile Vision 데이터 전제 실패는 별도로 판단한 뒤 확인 범위와 남은 조건을 정리해 DLDS 1단계 마감 여부를 결정한다. 아래 조사 자료 5개 정리는 완료 후 별도 마무리 작업이다. DSO 권한·수정 가능한 NUMBER 주문·실휴대폰/스크린리더 등은 미확인 환경 범위이며 현재 확정된 추가 UI 구현 누락으로 간주하지 않는다. AI 프롬프트·하네스는 그 뒤의 다음 단계이며 아직 착수하지 않는다.
- **임시 PR #4643:** 사용자가 `master` 대비 코드 비교를 위해 만든 [PR #4643](https://github.com/Innvoaid/dentlink-client/pull/4643)은 의도적으로 `[WIP] 임시 DLDS 코드비교용` Draft다. 정식 검토 PR로 전환하거나 제목을 바꿀 과제가 아니다. 2026-09-29 조회 시 `master`와 충돌했고 `git merge-tree`에서 `clinic/src/components/PaymentMethod/PaymentMethodView/PaymentMethodDetailInfoSection.tsx`와 `shared/ui/src/Popup/Popup.tsx`를 확인했다. Vercel 실패의 연결 URL은 팀 초대 페이지여서 코드 빌드 실패로 단정하지 않는다. CodeRabbit 검사는 성공으로 표시된다. 이 상태 정보는 당시 조회 결과이며, 이번 진행 방향 논의에서 PR은 변경하지 않는다.
- **`shared/ui/tests/`와 `shared/ui/DESIGN_COVERAGE.md`: 유지.** 테스트는 실제 공통 UI의 입력·선택·포커스·중첩 창 동작을 검사하며 로컬 `pnpm test:ui`로 실행한다. 대조 문서는 Figma 대응, 기존 사용 계약, 확인/미확인 범위의 팀 근거다. 현재 문서 압축이나 테스트 재구성은 하지 않고, 구체적인 오류나 유지보수 문제가 확인될 때만 재검토한다.
- **Button 여백:** 12→10px 변경으로 버튼 크기·간격이 달라질 수 있다. 추후 디자이너 문의나 실제 화면 차이가 나오면 해당 사용처만 확인한다. 현재 확인된 오류로 보거나 수정하지 않는다.
- **Admin 팝업 닫기:** Escape 키로 닫히는 것은 시각적 차이가 아니라 동작 변화다. 현재 문제로 판단하지 않고, 관련 문의가 있을 때 확인한다.
- **Icon 이름 전환:** 새 아이콘을 읽는 동안 잠깐 빈자리가 보이는 변화는 아래 「Icon 이름 전환 시 표시 방식」에 이미 기록되어 있다. 중복 기록이나 수정은 하지 않는다.

### DLDS 작업 완료 후 파일 정리 판단 — 조사만, 삭제 전

- **최종 권고:** 아이콘·로고 SVG와 생성된 TSX는 제품 에셋으로 유지한다. `shared/icons/tests/generation.test.mjs`는 `postinstall` 생성 결과와 중첩 SVG 표시가 깨지지 않는지 보는 회귀 테스트로 유지하되, 일회성 Figma 원본 대조에 묶인 부분은 간소화한다. `origin/master...feature/DL-16466`의 신규 파일과 참조를 정적으로 확인한 결과이며, 지금 삭제하거나 작업 완료로 판정한 것은 아니다.
- **완료 후 정리 권고 5개:** `shared/ui/design-audit/{figma-icons.tsv,figma-logos.tsv,FIGMA_REMAINING_AUDIT.md,figma-source-snapshot-2026-09-21.json}`와 `shared/icons/figma-provenance.json`. TSV·감사 문서·스냅샷은 당시 Figma 대조 근거이고, provenance는 그 원본 추적과 현재 생성 설정의 에셋 목록을 겸한다. 아이콘·로고를 이후에도 Figma 원본과 지속 대조하지 않는다면 조사 자료를 제품 저장소에 영구 보관할 필요는 낮다.
- **삭제 전 필요한 정리:** 감사 문서에만 있는 컴포넌트 판단은 `shared/ui/DESIGN_COVERAGE.md`에 필요한 만큼 보존한다. `shared/icons/svgr.config.js`는 지금 provenance를 `postinstall`·`generate`에서 직접 읽으므로, 생성 결과를 유지할 간결한 설정으로 바꾼 뒤 재생성을 검증해야 한다. 유지할 생성 테스트는 스냅샷·provenance가 없어도 생성된 코드와 핵심 SVG 동작을 검사하도록 조정한다. `shared/ui/{README.md,DESIGN_COVERAGE.md,tests/README.md}`와 컴포넌트 모음의 링크·설명도 함께 정리한다. 파일만 삭제하면 생성·검사가 깨진다.
- **그 외 유지:** 신규 SVG·TSX 에셋, 제품 컴포넌트/hook·공개 진입점, `dlds-gallery/`, `shared/ui/tests/`, `DESIGN_COVERAGE.md`, 실제 화면 E2E는 제품 사용·모음·회귀 검증에 연결돼 있다. 이번 정적 조사에서는 위 5개 외에 완료 후 삭제가 명확한 신규 파일을 찾지 못했다. 전체 구현/QA 완료나 전 파일의 무결성을 검증했다는 뜻은 아니다.

- 사용자 재확인에 따라 아이콘 생성·Figma 감사 관련 6개 파일의 개별 역할과 보관 판단을 제품 `shared/ui/README.md`에 표로 명시했다. 현재 삭제 대상은 없고, 검사 의존 파일과 조사 이력을 구분했다. 제품 `feature/DL-16466`의 `812886171`로 커밋·푸시했으며 정상 hooks를 통과했다. 이 작업에서 E2E 파일은 수정하거나 실행하지 않았다.
- 사용자는 별도로 요청하지 않았던 `.github/workflows/ui_regression.yml`을 제품 저장소에서 제거하기로 결정했다. 제품 `feature/DL-16466`의 `be034cc10`으로 제거·README 수정·원격 푸시 완료. DLDS 모음·테스트·로컬 실행 스크립트는 유지했다. 기존 `develop` Chromatic과 `master`/`develop` UI S3 Storybook 빌드 워크플로는 변경하지 않았다. 세 앱 commit 타입 검사와 push hook이 통과했다.
- 다시 팀과 PR 자동 검사를 도입하기로 하면 [보관한 워크플로 원본](dentlink-ui-regression-workflow-reference.md)을 출발점으로 사용한다. 이 파일은 개인 컨텍스트의 참고 자료일 뿐 실행되지 않는다. 당시 범위는 `shared/**` 등의 PR마다 아이콘 테스트·UI 테스트·DLDS 모음 타입/lint/빌드였고, 재도입 전 실행 범위·CI 시간·팀 합의를 다시 검토한다.

## 이전 체크포인트 — 2026-09-29 · DLDS 모음 코드 위치 정리

- 제품 `dentlink-client-dlds`의 `feature/DL-16466`에서 `a4d264c34`를 커밋·원격 푸시했다. `shared/ui/src/catalog/`와 `src/main.tsx`를 `shared/ui/dlds-gallery/`로 옮기고, 내부 `Catalog` 명칭과 타입 설정을 모음 화면에 맞게 바꿨다. Vite 진입점·CI·README의 경로도 갱신했다. 주문 데이터 API 등 별개 의미의 `catalog`는 유지했다.
- 모음 타입·lint·Vite 빌드, UI 회귀 24파일 200개, 세 앱 commit 타입 hook과 push hook을 통과했다. 로컬 Vite 서버에서 새 진입 파일 HTTP 200을 확인하고 서버를 종료했다. 기존 앱 lint 경고와 빌드 크기 경고는 남는다.
- HTTPS OAuth 인증에는 `workflow` 권한이 없어 CI 파일 포함 푸시가 거부됐고, 등록된 SSH 인증으로 같은 커밋을 정상 푸시했다. PR·병합·배포는 하지 않았다.
- 사용자의 수동 화면 점검 결과와 E2E Password 선택자 충돌, 별도 피드백 Retry 조사 경계는 아래 기록대로 유지한다. 이 경로 정리만으로 DLDS 1단계나 전체 QA가 완료된 것은 아니다.


## 이전 체크포인트 — 2026-09-29 · 사용자 수동 확인에서 큰 이상 없음, E2E 문제 기록·대기

- **저장·재개 기준:** 제품 `/Users/parkjongsun/Repository/dentlink-client-dlds`의
  `feature/DL-16466`은 아이콘 자료 설명 커밋 `98291e609`까지 원격에 저장했다.
  이전 구현 커밋 `85002472f` 이후 제품 실행 코드·아이콘 그림·사용처는 수정하지 않았다.
- **아이콘 파일의 역할·보관 이유:** `shared/icons/figma-provenance.json`의 첫머리와
  `shared/ui/README.md`의 원본 아이콘·로고 절에 기록했다. provenance는 Figma
  node·해시·원본 frame의 근거이며 현재 SVGR 설정과 생성 검사에서 직접 읽는다.
  `figma-source-snapshot-2026-09-21.json`은 일부 생성 검사의 원본 근거이고,
  TSV/대조 문서는 판정 이력이다. SVG와 생성 TSX는 실제 사용 가능한 자산이다.
  완료 후 일괄 삭제할 임시 파일로 취급하지 않으며, 정리 시 참조·검사·원본
  추적의 필요성을 함께 검토한다. JSON 파싱·아이콘 검사2개·정상 commit/push hooks
  통과. 기존 baseline lint 경고는 이번 문서 수정과 구분한다.
- **Icon 이름 전환 시 표시 방식 — 디자이너 의도 확인 후보:**
  `shared/ui/src/Icon/Icon.tsx`의 `ad3b55d6a` 변경에서, 같은 화면의 `Icon`이
  A에서 아직 캐시되지 않은 B로 바뀔 때 예전에는 B를 읽는 동안 A가 잠시 남았고
  지금은 지정 크기의 빈 `div`가 보이다 B가 나타난다. 애니메이션 스켈레톤은 아니다.
  새 아이콘 추가로 기존 이름이 다른 그림을 가리키게 된 변경과는 별개이며,
  사용자에게 보이는 전환 동작이다. 현재 디자이너의 의도·선호는 확인되지 않았으므로
  이를 오류/완료로 단정하거나 지금 수정하지 않는다. 추후 관련 의견이 나오면 이
  파일의 로딩 분기와 실제 이름이 바뀌는 사용 화면을 확인해 전환 방식을 결정한다.

- **최신 사용자 확인:** 수동으로 살펴본 화면에서 큰 이상은 발견하지 못했다고 보고했다.
  확인한 화면·환경의 상세 범위나 전체 QA 완료 여부는 아직 전달되지 않았다.
  현재 알려진 문제는 아래 E2E 한 건이며, 사용자 요청대로 결과만 기록하고 대기한다.
  이 보고를 전체 화면 통과나 작업 재개 승인으로 해석하지 않는다.

- **현재 발견된 문제 1 — E2E 셀렉터 영향:** 사용자 로컬 UI 실행
  `2026-09-29T04-48-33-516Z-42e1ca5f`의 기존 trace/error-context를 읽었다.
  회원가입의 `getByLabel("Password")`가 입력창과 `Show password` 버튼을 함께 찾아
  strict mode 오류가 난다. 9월18일 DLDS `a01200443`에서 접근성 버튼/이름을 추가한
  영향이며, 대상은 `e2e/clinic/steps/auth/signup-step1.ts:67`이다. 아직 수정/재실행하지 않았다.
- 같은 실행의 Insta Smile Vision 실패는 카테고리 API200 응답에 해당 항목이 없다는
  별도 데이터 전제 문제다. 셀렉터 회귀와 합치지 않는다. 당시 UI 세션은 종료 전이어서
  전체 실패/성공 판정을 확정하지 않았다. caught timeout 로그도 최종 실패와 구분한다.
- **피드백 Retry 정리 완료:** [완료 기록](dentlink-client-ui-requirements-audit.md)의
  PR #4642가 `release/v1.88.0`에 병합됐다. 이 DLDS 세션의 후속 작업 범위에는
  포함하지 않는다.
- **다음 시작점:** 사용자 지시가 오면 Password 선택자 충돌을 해당 E2E에서
  수정·재검증하고, Insta Smile Vision은 데이터 전제 문제인지 별도로 판단한다.
  그 결과와 수동 확인 범위를 합쳐 DLDS 1단계 마감 여부를 정리한 뒤에만
  AI 프롬프트·하네스 2단계로 넘어간다. 아이콘 추가 전수 시각 대조는
  사용자 결정대로 제외한다.
- 별도 피드백 Retry/요구사항 외 UI 조사는 다른 세션에 인계했다. 이 세션은
  다음 지시까지 대기하며 나머지 화면 통과·전체 QA·1단계 마감·하네스 착수를
  완료로 표시하지 않는다.

## 저장된 구현·QA 인계 — 2026-09-28

### 요청·저장 상태

- **당시 인계 — 사용자 QA 결과 대기:** 사용자가 이번 브랜치의 실제 Clinic·Lab·Admin 화면을 로컬에서 직접 실행해 확인하기로 했습니다. Codex의 확정된 코드 정리·자동/대표 화면 검증은 저장 완료했습니다. 9월29일 접수된 결과와 현재 지시는 위 최상단 절을 우선하며, 아직 보고되지 않은 화면을 통과로 보지 않습니다. 아이콘 시각 추가 대조 제외·공통 명명 원칙은 유지합니다.
- **제품:** `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16466`, **`85002472fe6823da903138cbc577d0883bf72d0c`**. 정상 hooks로 커밋·푸시, HEAD/추적/원격 실조회 SHA 일치·clean 확인. 직전은4622b54e5, 범용 UI 경계/실제 화면 구현은ca567f7df·bd7f83ec3입니다.
- **Jira:** DL-16466의 「현재 진행 · 2026.09.28」만 새 결과·커밋·남은 조건으로 갱신하고 반환 본문 일치 확인. 상태 **진행 중** 유지. 원래 목표·Notion 링크·이전 검증 기록은 보존했습니다. Notion·Sites·AI 하네스·에디터·PR·병합·배포는 변경하지 않았습니다.

### 2026-09-29 저장 확인 · 다른 기기에서 이어가기

- **과제와 현재 단계:** 실제 덴트링크 컴포넌트로 제품 UI에 맞는 화면을 만들고 PM·디자이너와 FE가 함께 활용하는 것이 목표입니다. **DLDS 정비 → AI 프롬프트·하네스 정비 → 필요하면 에디터** 순서이며, 현재는 첫 단계의 사용자 실제 화면 QA 결과를 기다립니다. DLOS는 정비와 컴포넌트 모음 구성의 참고이며 `shared/ui/src/v2`를 뜻하지 않습니다.
- **오늘 확인:** 제품 `feature/DL-16466`의 HEAD와 원격 실조회가 위 `85002472f`로 일치하고 미커밋 변경이 없습니다. 오늘은 저장 상태와 실행 스크립트만 확인했으며 구현·QA·테스트·서버 실행을 재개하지 않았습니다. 아래 검증 결과는 2026-09-28의 기록입니다. 사용자 요청대로 저장·정리 후 대기합니다.
- **원격 정본:** 개인 컨텍스트는 [jongsunP/codex-personal-context](https://github.com/jongsunP/codex-personal-context), 제품 코드는 [Innvoaid/dentlink-client](https://github.com/Innvoaid/dentlink-client)의 `feature/DL-16466`입니다. 새 기기는 개인 컨텍스트를 pull하고 `BOOTSTRAP.md` → `SESSION_WORKFLOW.md` → 이 문서를 읽은 뒤 제품 브랜치와 최신 HEAD를 확인합니다. 위 로컬 worktree 경로는 현재 기기의 위치이며 새 기기의 필수 경로가 아닙니다. QA 결과가 아직 없으면 대기를 유지합니다.
- **기기별 준비:** 제품의 `packageManager`는 `pnpm@8.6.9`이고 lockfile이 저장돼 있습니다. 저장소 접근 권한·의존성 설치·환경변수·로그인 계정은 기기별로 준비합니다. 코드·회귀 테스트·`shared/ui/README.md`·`DESIGN_COVERAGE.md`·Figma 원본 스냅샷/아이콘 대응 자료는 Git으로 복구합니다. `/tmp/dlds-*`, `e2e-runs`, 로컬 인증·브라우저 설치·실행 중인 서버는 이전되지 않습니다. 로컬 증거 파일이 없다는 이유만으로 완료된 감사를 처음부터 반복하지 않습니다.

### 사용자가 지금 확인할 것

- **대상:** `feature/DL-16466`의 최신 코드를 실행한 실제 Clinic·Lab·Admin 화면. `127.0.0.1:5177`의 컴포넌트 모음만 보는 단계가 아니라, 공통 UI 정비가 기존 서비스 화면과 동작에 영향을 주지 않았는지 평소 서비스 사용 경험으로 살펴보는 QA입니다. 배포 전이므로 현재 운영 사이트만 보아서는 이번 변경을 검증할 수 없습니다.
- **실행 위치:** 이 기기는 `/Users/parkjongsun/Repository/dentlink-client-dlds`입니다. 다른 기기는 같은 원격의 `feature/DL-16466` checkout/최신 HEAD를 확인합니다. 각 터미널에서 저장소 루트의 `pnpm dev:clinic`, `pnpm dev:lab`, `pnpm dev:admin`을 사용하고 접속 주소는 실행 로그를 따릅니다. 기존 환경변수·로그인 준비는 기기별로 필요하며 Git 메모리가 인증·서버를 옮기지는 않습니다. 이번 인계에서 Codex가 서버를 켜거나 끄지 않았습니다.
- **확인 내용:** 주요 페이지를 둘러보며 배치·글자/줄바꿈·간격·잘림, 입력/체크/선택/날짜, 팝업 열기/닫기·스크롤·키보드 동작을 확인합니다. 변경 공통 UI를 쓰는 화면과 이전 미확인 조건을 우선하며, 이미 자동/대표 검증한 모든 경로를 처음부터 반복해야 하는 것은 아닙니다.
- **결과 전달:** 앱과 화면 경로, 수행한 동작, 기대한 모습/동작과 실제 증상. 가능하면 브라우저·화면 크기와 스크린샷을 함께 받습니다. 문제가 없었던 범위나 권한/데이터 때문에 못 본 화면도 알려주면 확인 완료와 미확인을 구분합니다. 고정된 보고서 양식을 요구하지 않습니다.

### QA 결과를 받은 뒤 Codex가 재개할 순서

1. 개인 컨텍스트와 제품 브랜치를 pull하고 HEAD/dirty를 확인한 뒤, 이 **사용자 QA 결과 대기** 상태와 사용자 결과를 함께 읽습니다. 제품 체크포인트85002472f 이후 변경이 있으면 먼저 차이를 확인합니다.
2. 전달받은 증상과 화면을 재현하고 기존 문제인지 이번 변경의 영향인지 구분합니다. 확인된 문제를 프로젝트 규칙대로 수정하고 관련 동작을 재검증합니다. 접근 제한이나 디자인 판단이 필요한 경우에만 구체적으로 문의합니다. 실제 업무 데이터 생성/전송 권한을 QA 인계로 추정하지 않습니다.
3. 수정이 생기면 기존 승인 범위의 코드 commit/push·개인 컨텍스트 갱신을 수행하고, 필요하면 수정된 화면만 사용자 재확인을 요청합니다. 단순히 결과를 읽어 달라는 요청 등 더 좁은 새 지시는 우선합니다.
4. 문제가 없다는 결과가 오면 실제 확인한 범위와 남은 환경 조건을 정리하고 **1단계 마감 및2단계 AI 프롬프트·하네스 진입**을 사용자와 확인합니다. 일부 화면의 통과를 전체 검증 완료로 확대하지 않으며 결과 전달만으로 PR·병합·배포나 하네스 구현을 자동 시작하지 않습니다.

### 이번에 마친 작업

- **RadioGroup:** 혼합 UI index와 EnumMaps 업무 모델 의존을 직접 import·동일 구조의 로컬 props 타입으로 교체하고 `@dentlink/ui/dlds`에 공개했습니다. 기존 name·value·list·문자열/숫자 callback·선택 비교를 유지합니다. icon 필드는 타입 호환만 유지하며 새로 표시하지 않습니다. Clinic/Admin 기존 사용처의 import나 폼을 변경하지 않았습니다.
- **ListItemGroup:** Checkbox/Radio 직접 import, 사용하지 않는 Typography/theme/주석·스타일 제거. DataListFilter는 props를 type import로 참조합니다. padding/checkedColor/notBorderBottom 공개 타입은 호환용으로 유지하며 현재 표시 효과가 없음을 문서화했습니다. 기존 단일 defaultChecked·다중 checked 계약은 보존했습니다.
- **공개 범위 판단:** ListItemGroup은 현재 제품 JSX 소비가 없고 고정 name·중첩 label·단일/다중 선택 모델 차이가 있어 새 DLDS 공개 경로에 넣지 않습니다. 새 코드는 RadioGroup 또는 Radio/Checkbox를 조합합니다. 미사용 컴포넌트의 새 기능·그룹 API를 임의 설계하지 않습니다. 이는 확정된 필수 잔여 구현이 아닙니다.
- **모음 페이지:** 기존 Radio 항목 안에 Radio/RadioGroup 전환, 문자열/숫자0 선택과 사용 코드·값 타입을 연결했습니다. RadioGroup 미지원 size/disabled는 해당 모드에서 숨기고 기존 Radio 설정을 유지합니다. Button Spinner 안내, SelectDropdown/ChartDropdown 콜백·SegmentControl name 필수 설명을 실제 API에 맞췄습니다. 새 상위 명칭/업무 컴포넌트는 추가하지 않았습니다.

### 검증·한계

- UI **200개/24파일 통과**(새 RadioGroup4개: 문자열/숫자0 callback·native form 값·외부 초기화·서로 다른 name의 독립성). 공개 dlds 경로에서 실제 컴포넌트를 가져와 검증합니다. 초기 테스트는 현재 Vitest2에 없는 matcher 때문에 실패했으며 기존 지원 matcher로 바로잡아 전체 통과했습니다.
- **Chromium1440px / WebKit390px:** Group 문자열/숫자0·1 선택, 좌우 방향키, 코드 갱신, 기존 Radio small/disabled 전환 보존, 가로 넘침0·pageerror0. Chromium의 실제 clipboard 문자열/숫자 코드2개가 표시와 일치하고 각각 strict TypeScript 진단0. 초기 수동 스크립트의 중복 code 선택·desktop에 없는 Close 선택은 도구 선택자를 수정한 것으로 제품 결함과 구분합니다.
- 컴포넌트 모음 strict 타입·Vite build, 변경 TS/TSX scoped lint0오류/0경고, 정상 commit hooks Clinic/Lab/Admin 타입, 정상 push hooks 앱 lint·공유 coverage 통과. 기존 앱 lint·Vite chunk/tsconfig 경고는 남습니다. 일반 UI tsc578 baseline이나 전체 서비스 정상 판정으로 확장하지 않습니다.
- 독립 코드 리뷰: dlds runtime 정적 그래프89→90모듈, 신규 RadioGroup만 추가. 업무 models/API 및 UI/config/hook 혼합 root 유입0·미해결0. Icon의 동적 자산 경로는 이번 변경과 별개이며 재감사하지 않았습니다.
- 이전 local focused E2E4와 복사41 검증은 직전 구현의 증거입니다. 이번 의존 정리/예제 변경에서는 제품 API·사용 화면 로직을 변경하지 않아 전체 서비스 E2E를 반복하지 않았습니다. 제품 데이터 생성·수정·전송도 하지 않았습니다.

### 남은 것과 다음 시작점

1. **현재 확인된 범위에서 추가 판단 없이 수행할 코드 정리는 완료했습니다.** 아래 환경/적용 결정과 전체 DLDS 마감을 구분합니다. 목록 수나 모든 Figma 변형의 완전 일치를 보장하는 선언은 하지 않습니다.
2. **실제 소비의 검증 조건:** DSO 접근403 해소, 수정 가능한 NUMBER 옵션 주문/승인된 데이터. 실휴대폰·스크린리더·전체 다국어 및 staging 회귀는 배포 전 검증 범위로 따로 확보합니다. 접근제어 우회·실데이터 생성으로 해결하지 않습니다.
3. **선택 적용:** 전역 폰트/반경/달력46px/focus trap 일괄 전환, 기존 Button 일괄 교체, 물리적 폴더 이전은 확정된 필수 구현이 아닙니다. 필요할 때 적용 화면·호환 계약을 먼저 결정합니다. 아이콘 시각 추가 대조는 사용자 결정으로 제외하고, 이전 누락 점검 결과를 유지합니다.
4. **추천 다음 순서:** 사용자 로컬 QA 결과 수신 → 필요한 수정·재검증 → DLDS1단계 마감 범위 확인 → DL-16471 AI 프롬프트·하네스 작업으로 연결. 실제 컴포넌트 진입점/토큰·사용 계약·샘플 코드·명명/업무 경계는 준비됐지만, 비개발자용 실행 환경·입력 최소정보·재질문 규칙·새 UI 처리·결과 평가 기준은 다음 단계에서 구체화합니다. 이번에는 하네스 구현을 시작하지 않았습니다.

재개 시 개인 컨텍스트→제품 branch를 pull하고 현재 HEAD/dirty 확인 후 이 절부터 시작합니다. 완료된 Figma 감사·아이콘 누락 검사·대표 소비 전체를 목적 없이 반복하지 않습니다. 로컬 모음은 제품 루트 `pnpm dev:ui` → `http://127.0.0.1:5177`이며 새 RadioGroup은 Radio 항목의 ‘속성 바꾸기 → 구현’에서 봅니다. 회귀는 `pnpm test:ui`입니다.

이번 소유 QA5187 서버·브라우저는 종료했고 사용자 서버는 건드리지 않았습니다. `/tmp/dlds-support-*`의 브라우저/복사 진단·로그는 기기 전용입니다. Git에는 실제 수정 코드·회귀4개·사용/검증 문서를 저장했으며 인증·node_modules·실행 프로세스는 다른 기기로 자동 이동하지 않습니다.

## 이전 체크포인트 — 2026-09-28 · 아이콘 누락 점검·DLDS 컴포넌트 모음 명칭 정리

### 저장 상태

- **최신 요청 완료 — 추가 작업 대기:** 아이콘 누락 여부만 확인하고 화면·안내 문서의 이름을 `DLDS 컴포넌트 모음`으로 통일했습니다. 기존 아이콘226종의 도형·색상·배치 추가 전수 대조는 사용자 결정으로 제외하며, 이 범위 결정은 개인 메모리에만 둡니다. 다른 후속 개발은 보고 후 사용자의 재개 요청을 기다립니다.
- **프로젝트 공통 명명 원칙:** `DEVELOPMENT_STYLE.md`의 **Project-Aligned Naming**과 AGENTS 진입 안내에 저장했습니다. 정의된 프로젝트·디자인·참조 명칭을 우선하고, 없으면 기존 프로젝트 용어로 쉽고 정확하게 설명합니다. 새 이름을 만들어야 하거나 의미가 갈리면 사용자 검토 후 채택합니다. 화면 이름 변경만으로 내부 경로/API를 불필요하게 바꾸지 않습니다.
- 사용자 요청: Feedback 이름을 판단해 정리하고 미작업된 부분을 이어서 구현. 기존 자율 QA·수정·제품 commit/push·Git 메모리 승인 범위로 진행했습니다. PR·병합·배포는 제외입니다.
- 제품 worktree `/Users/parkjongsun/Repository/dentlink-client-dlds`, 브랜치 `feature/DL-16466`, **`4622b54e52e82034703804a7bbefaefafe36d91d`**. 명칭 수정8파일을 정상 hooks로 커밋·푸시했습니다. 직전 범용 UI 구현은 `ca567f7df`, 그 이전 대표 소비 수정은 `bd7f83ec3`입니다.
- 직전 구현 때 Jira [DL-16466](https://innovaid.atlassian.net/browse/DL-16466)의 현재 진행 절을 갱신했습니다. 이번 누락 확인·명칭 정리에서는 Jira를 수정하지 않았습니다. 상태는 진행 중이며 전체 1단계 완료가 아닙니다. Notion·Sites·AI 하네스·에디터는 변경하지 않았습니다.
- 카탈로그란 DLOS처럼 컴포넌트를 모아 보고, 속성·동작을 바꾸고, 사용 코드를 복사하는 페이지입니다. 사용자가 용어를 질문했으므로 대화에서는 **컴포넌트 모음 페이지**로 쉽게 설명합니다. 별도 제품 화면이나 호스팅을 뜻하지 않습니다.
- **명칭 출처 확인:** 구현 커밋 ad3b55d6a에서 HTML 탭 제목을 `DLDS · 컴포넌트 카탈로그`, 페이지 제목을 `Component gallery`로 붙였습니다. DLOS Component Gallery는 구성 참고이며 카탈로그가 DLDS의 공식 지정 명칭이라는 근거는 없습니다. 이름을 유지해야 할 기술적 이유도 없습니다. 이후 사용자 승인에 따라 HTML 탭·화면 제목과 README·안내 문서의 용어를 `DLDS 컴포넌트 모음`으로 바꿨습니다. `src/catalog` 같은 내부 경로와 기존 링크/컴포넌트 API는 유지했습니다. DLOS Component Gallery의 실제 참조 이름도 보존했습니다.

### 이번 누락 점검·명칭 검증

- **기존에 확보한 Figma 목록 기준 아이콘 존재 누락0.** `shared/ui/design-audit/figma-icons.tsv`의395노드 중 터치 영역/간격 조합25·빈 슬롯1을 제외한369개 아이콘 노드를 확인했습니다.366노드는 실제 TSX345개에 연결되고, 기본 도형3개는 기존 CSS 예제로 제공합니다. 이름 있는368노드는 중복 제외358종이며 이름 없는1개도 연결돼 있습니다. 회전 재사용9개는 대응표의 기존 조합으로 존재만 확인했습니다.
- `shared/icons/dist`의 TSX532개와 IconType·모음 페이지 glob 목록이 일치합니다. 신규 provenance 자산121개는 SVG·TSX·export·IconType에 모두 있습니다. 저장된 Figma 목록 이후의 원본 변경이나 도형/색상 동일성을 새로 검증한 결과는 아닙니다. 아이콘 코드·대응표·원본은 수정하지 않았습니다.
- **기존 이름 정리 사항:** `SvgObjectTeethBrushLine`·`SvgObjectCreditLine`은 TSX와 IconType이 있어 동적 Icon/모음 페이지에서 사용할 수 있지만 같은 이름의 SVG 원본·직접 named export는 없습니다. 과거 #3940/#3349에서 원본 이름이 `SvgTeethBrushLine`/`CreditLine`으로 바뀐 뒤 예전 TSX가 남고 대응표가 옛 이름을 참조합니다. 실제 제품 호출은 옛2명을 쓰지 않습니다. TSX 중 직접 export가 없는25개 집합은 origin/master와 동일해 이번 DLDS에서 생긴 export 누락이 아닙니다. 새/옛 그림의 동일성을 대조하거나 이름표를 임의 교체하지 않았습니다.
- **명칭 검증:** strict 컴포넌트 모음 타입 검사 통과. Chromium1440/390px에서 탭·h1 `DLDS 컴포넌트 모음`, 가로 넘침0·pageerror0 확인. 새 테스트는 만들지 않았고 기존 상호작용 회귀 전체를 반복하지 않았습니다. 정상 commit hooks 세 앱 타입·push hooks 앱 lint/공유 coverage 통과(기존 경고 유지). 이전 UI196/복사41/focused E2E4는 아래 직전 구현 근거입니다.

### 구현과 판단

- **Feedback → Overlays:** Figma Core 및 최상위 metadata에는 Feedback 공식 그룹이 없었습니다. Modal·Popup·Tooltip·Toast를 묶는 중립적인 탐색 이름으로 정리했습니다. 기존 `component-*` 링크는 유지합니다. 주문·배송·결제·직원 권한 샘플과 주문 이탈 그림을 범용 항목·분류·도형 예제로 바꿨습니다.
- **범용 공개 경로:** `@dentlink/ui/dlds`에 검증된 범용 컴포넌트만 명시적으로 export합니다. `Button`은 Button.refactor, `LegacyButton`은 기존 Button입니다. 기존 root와 업무별 진입점·기본값은 보존했습니다. `EllipsisTypography`의 hook import도 직접 경로로 좁혔습니다. 제품 AGENTS·UI README에 업무 도메인 독립 원칙을 추가했습니다.
- **분리의 한계:** `shared/ui` 전체 폴더를 이전하거나 모든 범용 API를 옮긴 것은 아닙니다. 기존 `RadioGroup`은 UI/models 혼합 barrel, `ListItemGroup`은 미완성 구현·혼합 의존성이 있어 새 경로에 넣지 않았습니다. 기존 소비는 그대로이며 실제 이전 필요성과 영향은 별도 검토합니다. 주문폼·링크톡은 DLDS 목록에서 제외됩니다.
- **빠진 예제:** 검색형 Combobox의 단일/다중·최대 선택 수·선택 해제·지우기를 실제 API와 연결했습니다. 모드 전환 때 검색어만 초기화하고 선택값은 유지합니다. 좌우48px 버튼을1px 겹친 **95×48px 화살표 조합**은 Figma `4010:2156`의 enabled 원본과 대조했습니다. 각 콜백과 비활성은 사용하는 화면에서 정하며 Stepper나 Pagination 동작으로 단정하지 않습니다. 기존 아이콘을 예제 안에서만 위치 보정하고 전역 자산은 유지했습니다.
- **복사 코드:** 새 공개 경로로 통일하고 useState import·상태/핸들러 선언·Popup 이미지·날짜 Date[] 타입을 보완했습니다. JSX/Hook 조각형 예제이며 모두 독립 페이지 파일이라는 뜻은 아닙니다.
- **발견·수정:** 모바일 UA에서 `drawer-root` 누락으로 페이지가 중단돼 HTML root를 추가했습니다. WebKit Close 이후 `useOverlayFocus` cleanup의 복귀를 React `restoreSelection`이 다시 덮어 닫힌 Drawer에 초점이 남는 현상을 이벤트/호출 stack으로 재현했습니다. 동기 복귀는 유지하고 화면 갱신 뒤 닫힌 scope/body에만 남은 초점을 복구합니다. 다른 입력·새 창의 초점은 가져오지 않습니다. DropdownPrimitive에서 먼저 초점을 빼는 시도는 원인이 아니어서 최종 변경에 포함하지 않았습니다.

### 검증

- UI **196개/23파일 통과**. 새 회귀3개는 닫힌 Drawer 복귀·다른 입력 보존·새 Modal 보존입니다. 초기 새 테스트가 cleanup 중간의 동기 복귀를 fireEvent 반환 뒤 요구해 실패했으며, 실제 React commit 이후 계약을 검사하도록 바로잡았습니다. 브라우저의 수정 전 실패와 수정 후 복귀를 별도로 확인했습니다.
- **Chromium148:** Overlays 분류, 검색·다중 선택·limit·초기화·disabled·긴 목록, 화살표95×48·48px·Tab/ShiftTab·Enter/Space·비활성·폼 제출0, Inspector와 복사 내용 전환을 확인했습니다. 새 모듈 runtime export46개 및 업무 export 제외, 페이지 오류/외부 API 요청0입니다.
- **WebKit26.4/iPhone UA390px:** Drawer 최대2개·해제·검색·지우기·결과 없음, Close/Escape 복귀·재열기 내부 초점·다른 Select 복귀, 화살표 치수·클릭/Enter/Space·개별/양쪽 disabled·폼 제출0, pageerror0. iPhone UA native Tab이 버튼을 건너뛰는 환경 관찰은 성공으로 세지 않습니다. 실휴대폰·스크린리더 검증은 별도입니다.
- 화면과 실제 클립보드 전달값 **41개(기본28+변형13)**를 일치 확인하고 strict TypeScript 검사0오류. JSX/Hook은 함수 본문, Foundation CSS는 styled template, 완결형 화살표 코드는 그대로 검사했습니다.
- 공개 진입점의 타입 제거 후 runtime 의존89개에서 업무 UI/models API/혼합 UI·config·hook barrel 유입0. 동적 아이콘532개는 React import뿐입니다. 기존 package exports6개 보존·Clinic 경로 해석 확인.
- 공식 **local focused E2E4개 통과**: `e2e-runs/2026-09-28T09-08-54-637Z-e3cf7c3e`. 실패·flaky·skip·미실행·전역 오류0. source `911968d52bcfbd7d99333c873d500a5d00800ff983b535a8822f0bba7e048492`, 실행 전후 동일. 실행 당시 HEAD는 부모 bd7f83ec3이며 작업 사본으로 새 구현을 검증했습니다. 이후 제품 변경은 검증 설명뿐입니다. 실제 주문·배송·사진 저장·문자 발송은 하지 않았습니다.
- 카탈로그 strict 타입·Vite build, 정상 commit hooks의 Clinic/Lab/Admin 타입, 정상 push hooks의 앱 lint·공통 coverage 통과. Scoped UI lint는 오류0/기존 EllipsisTypography dependency 경고1. Vite chunk 크기·기존 tsconfig paths 위치·앱 기존 경고는 남아 있으며 전체 UI tsc578 baseline을 성공 근거로 쓰지 않습니다.

### 남은 범위와 재개

1. **아이콘 전수 대조는 사용자 결정으로 제외합니다.** 아이콘은 누락 여부만 대상으로 하며, 기존 이름 대응226종의 도형·색상·배치가 미대조라는 이유로 작업을 다시 시작하거나 1단계의 필수 미완료 항목으로 남기지 않습니다. 전수 일치 검증을 완료했다는 뜻은 아닙니다. 기존105node 감사·신규 아이콘/로고·화살표 예제와 기존 자산을 유지합니다. 위 누락 존재 점검을 완료했습니다. 추가 아이콘 구현이나 시각 대조는 하지 않았습니다.
2. 기존 보조 UI의 혼합 의존 관계·폴더 이전 여부는 사용처를 보고 판단합니다. 새 공개 경로가 안전해졌다는 것과 물리적 패키지 분리 완료를 구분합니다. 기존 Button 일괄 전환, 입력 달력46px 확대, 폰트·radius·trapFocus 전역 기본값 변경은 자동 진행하지 않습니다.
3. 실제 소비의 남은 조건: DSO 권한403, 수정 가능한 NUMBER 옵션 주문, 실휴대폰·스크린리더·전체 다국어·staging 전수. 아래 이전 기록의 구체적 접근·데이터 제약을 유지합니다.
4. 전체 DLDS 정비의 완료 범위를 정리한 뒤 AI 프롬프트·하네스 단계로 이어갑니다. 아직 AI 하네스·에디터를 구현하지 않았습니다.

**후속 작업 후보 — 재개 요청 후:** 보조 UI의 불필요한 의존 관계 정리 → 변경 검증이 가능합니다. 이전에 추천한 아이콘 원본 전수 대조는 최신 사용자 결정으로 취소합니다. 정적 조사상 RadioGroup은 Clinic/Admin 사용처가 있고 ListItemGroup은 직접 렌더 없이 타입 참조만 있어, 기존 props·문자열/숫자 콜백을 보존한 import·공통 타입·미사용 코드 정리는 가능합니다. 선택 상태 제어 방식 변경이나 미사용 스타일 props의 기능 복원은 별도 요구 확인이 필요합니다. 현재는 사용자 요청대로 보고 후 대기하며 새 구현은 시작하지 않았습니다.

재개 시 개인 컨텍스트와 위 제품 브랜치를 `git pull --ff-only`로 갱신하고 현재 HEAD/dirty를 확인합니다. 사용자 세션 폴더는 `/Users/parkjongsun/Documents/ChatGPT/디자인시스템정비 프로젝트`이며 제품은 별도 worktree입니다. 모음 페이지는 제품 루트의 `pnpm dev:ui` → `http://127.0.0.1:5177`입니다. 이 실행 방법은 package script·README에 저장돼 있습니다.

이번 QA 전용5187 서버와 에이전트 브라우저는 종료했습니다. 시작 시 사용자5177 서버는 있었으나 QA 시점에는 이미 종료돼 있었고 사용자의 프로세스를 종료하지 않았습니다. 공식 E2E 서버는 runner가 정리했습니다. `/tmp/dlds-*` 스크린샷/진단, e2e-runs, 인증·node_modules·실행 프로세스는 다른 기기로 자동 이전되지 않습니다. 원격 Git의 코드·문서·이 체크포인트로 재현합니다.

## 이전 체크포인트 — 2026-09-28 · ③ 대표 사용 화면 재검증·수정 완료

### 현재 상태와 저장 위치

- **2026-09-28 세션 폴더 정렬:** 기존 **디자인시스템정비세션**
  `01a0a2eb-da08-7131-aaaf-6c14f0cfc204`은
  `/Users/parkjongsun/Documents/ChatGPT/디자인시스템정비 프로젝트`에 연결됐다.
  프로젝트 ID는 `a047bc64-579f-4993-ab3e-1526d8f47f39`다. 기존 세션의 기록된 cwd는
  옛 `FE`로 남아 있으므로 명령은 새 컨텍스트 폴더 또는 아래 제품 worktree를
  workdir로 명시한다. 세션 이력과 제품 worktree를 보존했으며 폴더 정리로 구현을
  재개하지 않는다.

- **최신 요청은 현재 상태 저장·커밋·푸시·메모리화 후 브리핑입니다.** 두 저장소를 다시 pull하고 제품 `bd7f83ec3`의 로컬·원격 일치와 미커밋 변경 없음을 확인했습니다. 이번 마무리에서는 추가 구현이나 테스트를 시작하지 않았습니다. 다음 진행 요청 시 아래 남은 조건부터 이어갑니다.
- 직전 구현 요청 **“남은것들 진행해줘”**에 따라 후속 ① 사용 방식·영향 확인 → ② 구현 → **③ 수정 후 재검증**을 진행했습니다. 대표 소비 화면·키보드·모바일 에뮬레이션·Firefox/WebKit을 확인하고 발견한 문제를 수정했습니다. 전체 서비스 전수·실기기·staging 검증 완료는 아닙니다.
- 제품: `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16466`, **`bd7f83ec3fd8bba22f4e0c52ece4801f2d9e407b`**. 직전 구현은 `6a841dada60a7c5d93a4aaa6d83a9566fc3a9583`입니다. 정상 hooks로 커밋·푸시하고 원격 일치·clean을 확인했습니다. 기존 사용자 승인에 따른 제품 commit/push와 Git 메모리 정리입니다. PR·병합·배포는 하지 않았습니다.
- 팀 정본: `shared/ui/DESIGN_COVERAGE.md`의 「수정 후 대표 화면·브라우저 검증」. README·tests/README·Figma 감사 문서도 갱신했습니다. 로컬 카탈로그는 저장소 루트에서 `pnpm dev:ui` → `http://127.0.0.1:5177`입니다.
- Jira DL-16466 현재 진행 절에 이번 결과·커밋·남은 조건을 반영하고 진행 중 상태를 유지했습니다. Notion·Sites·AI 하네스·에디터는 변경하지 않았습니다.

### 이번 수정

- **모바일 Tooltip:** 숨긴 헤더의 0×0 wrapper가 Tab에 남는 문제를 실제 Clinic에서 재현했습니다. 표시 영역과 자식의 초점 가능 여부를 확인하고 resize·ResizeObserver로 갱신합니다. NONE/본문 없음에는 observer를 만들지 않습니다.
- **WebKit Tooltip 링크:** 트리거 초점 → 내부 링크 pointerdown → blur(relatedTarget=null) → unmount로 click이 빠졌습니다. 내부 pointer 조작 중에만 blur 닫기를 보류했습니다. 수정 전 실패와 수정 후 WebKit·Firefox 클릭 성공을 확인했습니다.
- **안내 이름:** Tooltip의 아이콘·상태·비활성 입력·차트 구역에 기존 문구/번역으로 `triggerAriaLabel`을 연결했습니다. 전체 서비스 접근성이나 스크린리더 검증 완료를 뜻하지 않습니다.
- **데스크톱 사진 편집:** 기존 master에도 Modal onClose가 없고 X가 클릭용 Icon이어서 Escape/키보드 닫기가 안 됐습니다. 기존 초기화 함수와 번역된 native Close 버튼을 연결했습니다. `autoClose=false`로 배경 클릭은 기존처럼 유지했습니다.
- 공통 폰트·반경·daySize·trapFocus 기본값, 기존 자산·제품 로고 사용처는 바꾸지 않았습니다.

### 실제 화면 확인

| 대상 | 확인한 결과와 경계 |
| --- | --- |
| Clinic 사진 편집 | 데스크톱1440×1000·모바일390×844에서 −180~180/5도, 방향키/Home/End·중앙 클릭·끝점 드래그·증감 버튼과 이미지 회전 일치. 끝점 버튼 비활성·모바일 넘침 없음. 새 Escape·X Enter 닫기와 재열기 시 파일/각도 초기화 확인. Save 미실행. |
| Clinic 안내·Portal 메뉴 | SMS204px·결제 불가200px의 이름/focus/Escape·초점 유지, native disabled 유지. 숨긴 헤더의 빈 Tab 제거와1440↔390 전환 확인. My Office 메뉴는 Escape로 메뉴만 닫고 열기 버튼 복귀, 다음 Escape로 부모 닫힘. Leave 미실행. |
| Lab 추가금 | Others 선택 후 수량40px/min1. 1→증가2→직접6→감소5→0입력 후 blur에서1로 보정. 요청 미실행. |
| Lab NUMBER 옵션 | 실제48px/readOnly/min0 렌더 확인. 해당 기존 주문은 수정 불가 안내층이 조작을 막습니다. 강제 클릭·안내층 제거는 하지 않았습니다. 제작 중 표본14건에는 NUMBER 상품이 없었습니다. 실제 소비 콜백은 남기고 공통 Stepper 콜백/readOnly/disabled는 unit·카탈로그 검사로 구분합니다. |
| Lab 배송 날짜 | 라벨 생성→픽업 일정 등록→날짜40px·과거/주말 제한·선택 반영. 달력을 다시 열어 Escape하면 부모 날짜/체크 유지. 최종 생성 미실행. |
| Clinic 모바일 주문 날짜 | Order Dates는 별도 자식 창이 아닌 **Filter Drawer 하나의 탭**입니다. Escape로 Filter 전체 닫기·미확정 날짜 미적용이 정상입니다. Done 후 재열기 선택 유지, 날짜40px·390px 넘침 없음. |
| Admin 방문 요청 | 날짜 선택 자체는 달력을 닫습니다. 선택 후 다시 열고 Escape하면 부모1개·날짜2026-09-29·Done 활성 유지. 다음 Escape 후 재열면 날짜 초기화. 제출 미실행. |
| Admin 폰트·이메일 | 공휴일 달력 CSS600 제목/한글 요일의 실제 폰트가 Pretendard-SemiBold임을 CDP로 확인. sandbox="" iframe 초점의 Escape는 부모로 전달되지 않고 부모 Close는 정상. sandbox 완화 없음. |
| Firefox150.0.2 / WebKit26.4 | 카탈로그 Checkbox hover·Stepper32/40/입력/readOnly/disabled/폼 미제출·Slider 키보드/클릭/드래그·Tooltip BASIC/HELP/INFO/닫기/링크·로고18 확인, pageerror0. WebKit320/390px 터치 에뮬레이션에서 range 끝점 탭·감소 버튼·넘침 없음. 실기기·터치 드래그 검증은 아님. |

기존 SVG427개·기존 dist 바이트와 export 보존도 재검산했습니다. 신규80개는 제품 로고에 자동 적용되지 않았습니다. 서로 다른 신규 로고 변형의 gradient ID는 파일명 prefix로 구분됩니다. Clinic/Lab CSS400=Medium·Admin400=Regular/500=Medium은 이전 실제 측정과 현재 선언 보존을 함께 근거로 하며, 이번에 모든 굵기·언어를 새로 측정한 것은 아닙니다.

### 최종 검증 근거

- UI **193개/23파일**, 카탈로그 strict 타입·Vite build, E2E 전체 타입 검사 통과. Tooltip2·사진 편집2 회귀는 수정 전 실패→수정 후 통과했습니다. 아이콘 실행 코드는 직전2개 통과 이후 그대로여서 재실행하지 않았습니다.
- 공식 **local focused E2E4개 통과**: `e2e-runs/2026-09-28T06-40-43-648Z-a4ef7e8a`. 실패/flaky/skip/미실행/전역 오류0. 실행 전후 source 동일: `396eada7857dc13405793eb0090e7be2ff5009206110ed2da38faa726925503f`. 실행 당시 HEAD는 부모6a841dada이며 이 작업 사본 hash가 실제 코드 근거입니다. 이후 문서 외 실행 코드 변경은 없습니다.
- `09_sharedUi.spec.ts` 기존3개(Clinic Export desktop/tablet·Admin SMS)에 모바일 프로필 Tooltip1개를 추가했습니다. 프로필 설정 write 차단·요청0건 assertion을 포함합니다. staging 전체나 배포 증거가 아닙니다.
- 정상 commit hooks의 세 앱 타입과 push hooks의 앱 lint·coverage 통과. scoped shared lint의 Members 조건부 Hook5·DataTable 빈 callback4 및 경고는 HEAD와 동일한 기존 진단입니다. 일반 UI tsc의 과거578 baseline은 이번에 재측정하지 않았고 성공 근거로 사용하지 않습니다.
- 수동 조사는 업무 write를 차단했습니다. 초기 조회 POST 차단(`/admin/chats/search`, `/lab/orders/search`)은 코드 확인 뒤 정확한 조회 경로만 허용했습니다. 채팅 읽음 POST2건은 차단했습니다. Network Error2건·로컬 QA 위젯500·기존 경고는 별도이며 네트워크 전체 정상으로 보고하지 않습니다. 실제 저장·전송·읽음 변경은 실행하지 않았습니다.

### 남은 조건과 다음 시작점

**DLDS 범위 원칙 — 사용자 확인(2026-09-28):** 디자인시스템 UI는 주문·결제·배송·링크톡 등의 비즈니스 도메인에 귀속되지 않아야 합니다. 주문폼 같은 업무 전용 컴포넌트는 DLDS 정비·카탈로그·향후 하네스의 기본 UI 목록에서 제외합니다. `shared/ui` 폴더 전체를 DLDS로 취급하지 않습니다. 실제 폴더와 index에는 업무 UI가 함께 남아 있지만 현재 카탈로그28항목에는 주문폼/링크톡 컴포넌트가 없습니다. 업무 화면은 공통 UI 변경의 영향 확인 대상으로만 구분합니다. 폴더 이동·export 분리까지 완료됐다고 설명하지 않습니다.

- 사용자의 상시 작업 지침 적용 요청에 따라 `DEVELOPMENT_STYLE.md`의 **Design-System Boundaries**에 범용 UI와 업무 UI의 의존 방향·카탈로그/AI 대상 경계·중립적인 예제 원칙을 추가했습니다. 다음 세션도 프로젝트 기록뿐 아니라 공통 작업 지침으로 읽습니다.
- `origin/master...HEAD`의 범용 UI 의존성 변경을 정적으로 확인한 결과, 새 주문·결제·링크톡 API나 업무 상태 의존성을 추가한 흔적은 없었습니다. 달력 models 참조는 기존 마커 모양 타입(CIRCLE/DOT/ASTERISK)의 type import이고, 주문/링크톡 사용처 변경은 Tooltip 이름 연결입니다. 기존 패키지 혼재·업무 예제 문구는 별도 정리 대상이며 이 확인을 전체 코드 무결점 판정으로 사용하지 않습니다.

- Figma 최신 metadata로 Core+Component와 최상위 페이지를 재확인했습니다. Modal·Popup·Tooltip·Toast는 개별 컴포넌트명이며 `Feedback`이라는 상위 분류는 없습니다. 현재 Feedback 그룹은 카탈로그의 자체 분류입니다. 명칭 대안으로 `Overlays`를 제안하며 Figma 공식 분류로 주장하지 않습니다. 일부 예제의 주문/배송/결제 문구와 주문 이탈 안내 이미지는 샘플이며 업무 컴포넌트 자체의 포함과 구분합니다. 이번 확인에서는 제품 코드·분류명·폴더를 수정하지 않았습니다.

**구현 현황 설명 기준(2026-09-28 추가 확인):** Figma의16개 컴포넌트 페이지와 Core의 Tab·Modal에는 모두 대응 코드가 있습니다. 이는 모든 variant·크기·상태의 원본 대조 완료나 API 통합 완료를 뜻하지 않습니다. 좌우48px 화살표 두 개를 붙인95px 조합은 별도 구현을 제공하지 않았습니다. 달력46px은 단독 Picker/RangePicker 옵션이며 DateField/DateRangeFieldV2에는 노출하지 않았고, Button의 기존/권장 API도 병행 유지합니다. ComboboxDropdown의 검색+다중 선택은 구현돼 있지만 카탈로그 검색 선택 예제는 단일 선택만 노출합니다. 실제 서비스 검증과 별개인 컴포넌트 제공 범위·카탈로그 예제 보완을 구분해 설명합니다.

1. **권한·데이터:** DSO `/organizations/billings`는 같은 계정에서 `/403`으로 이동합니다.92일 범위·카테고리 안내의 실화면이 남습니다. 수정 가능한 NUMBER 옵션 주문 또는 승인된 테스트 데이터가 있으면 실제48px 소비의 값 변경을 확인합니다.
2. **별도 환경:** 실휴대폰·스크린리더·전체 다국어 줄바꿈·staging 전체 회귀. 브라우저 에뮬레이션으로 완료 표시하지 않습니다.
3. **범위·디자인 판단:** Figma4010:2156 좌우 화살표 묶음의 용도는 미확정입니다. 기존 이름 대응 아이콘226종의 전체 도형/색 대조는 기존 감사 범위 밖입니다. 전역 medium500/radius1000/daySize46/trapFocus 전환은 필수 잔여 구현으로 간주하지 않고 기존 계약을 유지합니다.
4. **이후:** 남은 조건과 DLDS1단계 완료 범위를 확정한 뒤, 정리된 컴포넌트·규칙·예시를 DL-16471 AI 프롬프트·하네스 단계의 입력으로 연결합니다. 하네스 구현은 미착수입니다. 완료한105node 감사나③대표 QA를 처음부터 반복하지 않습니다.

### 다른 기기에서 재개

두 Git을 pull → 제품 branch/HEAD·원격 일치·dirty 확인 → 이 절과 DESIGN_COVERAGE의 미확인 조건부터 시작합니다. 아래 과거 절의③미착수/일시중단은 현재 상태가 아닙니다. 소유 서버5177/3100/3102/3105·브라우저·계정 잠금은 종료했고 사용자 프로세스는 건드리지 않았습니다.

`/tmp/dlds-phase3`, e2e-runs, 스크린샷·인증·.env·node_modules·이번에 설치한 Playwright Firefox/WebKit은 Git으로 이동하지 않습니다. 팀 문서와 영구 회귀 테스트로 재현하며, 비공개 화면·로그를 Git/공개 문서에 복사하지 않습니다.

## 이전 기록 — 2026-09-28 · ② 남은 구현·수정 완료, ③ 재검증 전

### 범위와 저장 상태

- **최신 요청:** “다음 2단계 진행”. 이번 번호는 **① 기존 사용 방식·영향 확인 → ② 남은 구현·수정 → ③ 수정 후 재검증**입니다. 전체 프로젝트의 DLDS 정비→AI 하네스→에디터 번호와 구분합니다.
- **① 완료 / ② 확인된 구현 범위 완료 / ③ 미착수:** 구현에 필요한 unit·카탈로그·문제 화면의 제한된 확인은 수행했습니다. 전체 소비 화면·기기별 재검증을 대신하지 않습니다. 전체 DLDS 정비 완료나 AI 하네스 착수로 해석하지 않습니다.
- **제품:** `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16466`, 이번 구현 HEAD `6a841dada60a7c5d93a4aaa6d83a9566fc3a9583`. 시작 HEAD `1a6518147cdaf9ff082da69221b03fc7264b0ce2`. 기존 자율 구현·제품 commit/push·Git 메모리 정리 승인을 적용했으며 PR·병합·배포는 하지 않았습니다.
- **저장 확인:** 정상 commit hooks의 세 앱 타입 검사와 push hooks의 앱 lint·공유 coverage 검사를 통과해 제품을 푸시했습니다. 로컬 HEAD·origin 추적·원격 실조회 SHA 일치, ahead/behind0/0·clean을 확인했습니다. Jira DL-16466에 현재 구현·검증·후속③과 커밋을 반영하고 반환 본문 일치·진행 중 상태를 확인했습니다. Notion 회의 본문·Sites는 변경하지 않았습니다.
- **정본:** 제품 `shared/ui/DESIGN_COVERAGE.md`, `README.md`, `design-audit/FIGMA_REMAINING_AUDIT.md`와 아이콘/로고 TSV·provenance. 개인 재개 상태는 이 파일이 정본입니다. Figma 원본105node·SVG119개 snapshot은 변경하지 않았습니다.

### 반영한 구현

- **Checkbox:** 일반 hover와 선택형 `checkmarkOnly`24px 추가. customIcon·부분 선택·숫자 우선, native disabled/readOnly/콜백, 기존 기본 크기와 소비 class 보존.
- **Stepper·Slider:** text/small만32px(문자24px·버튼32px), input/small40px·기본48px 유지. Slider native16px thumb·그림자·track 안쪽7px 끝점·최소 활성선4px 반영. 기존 사진 회전 범위(-180~180/step5)·콜백·plain 버튼 유지.
- **Tooltip:** 선택형 BASIC/HELP280px·radius6·opacity.9·padding12/12x16·무화살표, 아이콘/닫기/도움말 링크 카탈로그 조합 추가. INFO/TEXT/NONE·명시폭·기본300px 유지. disabled 자식을 키보드 진입점으로 오인하지 않게 수정하고 Clinic 결제 이력에 `triggerAriaLabel`을 지정했습니다.
- **Modal/Popup/PopupMenu:** 실제 React 부모·자식 관계의 Escape를 자식부터 처리하고, 같은 native event 중 자식이 즉시 unmount돼도 부모까지 닫히지 않게 했습니다. fixed Portal 메뉴의 Escape·열기 버튼 복귀 추가. 마지막 조사에서 발견한 **isOpen commit 뒤 Portal DOM 준비 전** 공백도 `openScopes`와 기존 focus scope 분리로 보완했습니다. 닫힘/숨김 자식 제외·StrictMode·legacy 비중첩 sibling 계약·trapFocus=false 기본값은 유지합니다.
- **자산:** 원본 아이콘64개+로고16개 신규 export, 총532개. 로고18변형 중2개는 기존 재사용. 기본 도형3개는 CSS 조합/provenance로 제공합니다. 기존 SVG427개·TSX452개와 snapshot 바이트 보존. 5개 node의 축약 배치 누락은 같은 snapshot의 referenceLayout로 복원하고 provenance에 근거·행렬·해시 기록. 기존 제품 로고 사용처는 교체하지 않았습니다.
- **카탈로그:** 기존28항목 안에 신규 상태·props·코드 예시·로고18변형/원본 비율과 기본 도형을 연결했습니다. 공통 폰트·radius.full·달력 daySize·focus trap의 전역 기본값은 바꾸지 않았습니다. 좌우 화살표 묶음의 용도는 여전히 미확정이므로 수량 Stepper로 임의 통합하지 않았습니다.

### 검증과 한계

- 최종 UI **189개/22파일**, 아이콘 원본 연결·재생성 **2개** 통과. 전체 원본 SVG507개를 재생성한 TSX와 저장본 byte 일치. 원본/생성물80개×1배/2배 래스터160회 및 비교판 확인. 색/좌표 반올림 차이는 기존 원본과 구분해 기록했습니다.
- 카탈로그 strict 타입·scoped lint·Vite build 통과. 새 코드에 대해 Clinic/Lab/Admin 타입과 push hooks를 실행했습니다. 일반 UI `tsc`의 과거 baseline578건은 이번에 재측정하지 않았고 passing proof로 쓰지 않습니다. 기존 build chunk warning·PopupMenu hook dependency warning 등은 새 통과 범위와 구분합니다.
- 카탈로그 Chromium에서 Checkbox 기본/hover·Stepper text32/input40(transition 종료 후), Tooltip BASIC/HELP 크기·닫기/링크·disabled 안내, Slider Arrow/Home/End·중앙 클릭·끝점 drag, 로고18개 렌더링 확인. 이는 모든 소비 화면·브라우저 엔진 검증이 아닙니다.
- 실제 Clinic 결제 이력: 이름 있는 disabled 안내10개가 보인 표본에서 Tab 진입/안내 표시/Escape 닫기·native disabled 유지 확인. My Office: Leave를 실행하지 않고 Escape로 메뉴만 닫기/trigger 복귀, 다음 Escape 부모 닫기 확인. Admin 방문 요청: 달력2→1/2026-09-29 선택값·Done활성 유지, 다음1→0, 다시 열면 날짜 비움/Done비활성 확인. 실제 저장·전송·탈퇴 요청은 하지 않았습니다.
- 위 수동 조사에서는 쓰기 요청을 차단했으며 Admin 조회 POST `/admin/chats/search`도3회 차단되어 Network Error2개가 기록됐습니다. 네트워크 전체 정상·무경고 결과가 아닙니다. 마지막 Portal 공백 수정은 실제 Modal/DateField/Portal 회귀test에서 수정 전 실패/수정 후 통과를 확인했습니다.
- 최종 공식 focused E2E3개: `2026-09-28T06-00-29-021Z-0242b297`; 실패/flaky/skip/미실행/전역오류0, 실행 전후 source 일치 `79ae1bafbbdecdf22244539658e62fc27b9274a93257cbd4235c2fc395749ac5`. Clinic Export desktop/tablet와 Admin SMS 확인창이며 local FE+DEV API입니다. 이전 run `2026-09-28T05-52-14-971Z-b86eff62`도3pass였으나 최종 Portal 수정 전 결과이므로 최종 근거와 구분합니다.

### 다음 시작점 — ③ 수정 후 실제 화면 재검증

1. 개인 컨텍스트와 위 제품 branch를 pull하고 status/HEAD를 확인합니다. 이 체크포인트와 제품 DESIGN_COVERAGE를 먼저 읽고, 완료된 Figma105node 조사를 반복하지 않습니다.
2. 변경된 공통 UI의 실제 Clinic/Lab/Admin 화면을 대표 조합과 상태별로 확인합니다. 사진 편집 Slider의 값·drag·끝점·모바일, Checkbox 옵션/비활성/hover, 주문 NUMBER·Lab 추가비용 Stepper, Tooltip 기존 명시폭/TEXT/NONE/강제 안내, Modal/Popup/Calendar/Portal의 빠른 열기·닫기/값 유지/포커스 회귀를 봅니다.
3. 앱별 폰트400/500/600·다국어 줄바꿈, 반경/Calendar40·선택형46·모바일 Drawer, sandbox iframe, 선택형 focus trap 적용 범위를 이어서 확인합니다. 폰트400→500·radius50%→1000px·daySize40→46·trapFocus 전역 전환을 전제하지 않습니다.
4. Clinic DSO `/organizations/billings`는 이전 계정403으로 실제92일 범위 UI 미검증입니다. 접근 가능 환경만 요청하며 나머지 검증을 진행할 수 있습니다. 실휴대폰·스크린리더·다른 브라우저 엔진은 증거를 별도로 기록합니다.
5. 발견한 회귀만 근거에 맞게 수정·검증하고 전체 DLDS1단계의 완료/의사결정 필요 항목을 정리합니다. AI 프롬프트·하네스와 에디터는 별도 요청/단계로 남깁니다.

### 재개 환경

- 카탈로그: 이 코드가 있는 체크아웃 루트에서 `pnpm dev:ui` → `http://127.0.0.1:5177`. 명령과 종료법은 shared/ui/README.md에 있습니다. 이번에 띄운 카탈로그·제품 서버/브라우저·계정 잠금은 종료·해제했습니다.
- 검사: `pnpm test:ui`, `pnpm --filter @dentlink/icons test`, `pnpm --filter @dentlink/ui exec tsc -p tsconfig.catalog.json`, 필요 시 공식 E2E runner. 계정은 동시 사용을 피하고 인증값을 출력하지 않습니다.
- Git은 코드·기록만 옮깁니다. `/tmp/dlds-step2`, `/tmp/dlds-icons-0928`, `/tmp/dlds-overlay-race-0928`, `e2e-runs`, `.env`, node_modules, 로그인, 실행 프로세스는 다른 기기로 자동 이동하지 않습니다. 개인 데이터/인증을 Git에 넣지 않습니다.


## 이전 기록 — 2026-09-28 · ① 사용 방식·영향 확인 완료

### 현재 범위와 저장 위치

- **최신 요청:** “우선 1단계 진행”, 나머지는 중단·다른 기기에서도 알 수 있게 기록. 이번 번호는 **① 기존 사용 방식·영향 확인 → ② 남은 구현·수정 → ③ 수정 후 재검증**입니다. 과거 ‘1번 Figma 대조’ 또는 전체 프로젝트의 ‘디자인시스템 1단계’와 혼동하지 않습니다.
- **① 완료 범위:** Clinic/Lab/Admin·공유 UI의 정적 사용처 조사와 아래 대표 화면의 수정 전 기준 확인을 마쳤습니다. 모든 제품 화면·상태의 전수 검증을 뜻하지 않습니다. Figma 원본105개 node 조사는 반복하지 않았습니다.
- **② 미착수 / ③ 미착수:** 다음 작업으로 남깁니다. 이번 요청은 실행 코드 수정까지 포함하지 않으므로 이 지점에서 대기합니다. 전체 DLDS 정비와 AI 하네스·에디터는 완료되지 않았습니다.
- **제품:** `/Users/parkjongsun/Repository/dentlink-client-dlds`, `feature/DL-16466`. 조사 기준 `01d49c3cbaf3590076a078a9531e2ddceb5be2a7`; 원본 구현은 `0fa829542`입니다. 이번 문서 저장 HEAD는 `1a6518147cdaf9ff082da69221b03fc7264b0ce2`이며 로컬·추적 브랜치·원격 실조회 SHA 일치와 clean을 확인했습니다. 제품 실행 코드·테스트·기본값은 변경하지 않았고 감사 MD2개만 갱신했습니다.
- **팀 기술 근거:** 제품 `shared/ui/DESIGN_COVERAGE.md`의 「현재 사용처와 변경 영향」에 사용 계약·화면 결과·문제·미검증 조건을 기록하고 `shared/ui/design-audit/FIGMA_REMAINING_AUDIT.md`에서 연결했습니다. 임시 보고서가 없어도 수정 범위를 복구할 수 있습니다.
- **동기화:** 시작 시 두 저장소 pull 완료. 종료 전 개인 컨텍스트를 다시 pull하여 다른 QA 작업의 `099df56`까지 보존했습니다. 조사 시 `origin/master=de2ffdd9e`가 현 브랜치의 조상이었고 새 master 통합 필요는 없었습니다. 이후 작업 시 원격을 새로 확인합니다.

### 확인 결과

- **폰트:** 세 앱 로그인 화면을1440×1000 Chromium148에서 시각 확인하고 CDP로 실제 선택된 폰트를 확인했습니다. Clinic/Lab의 Typography400·Button500은 모두 Pretendard-Medium, Admin은 Typography400=Regular·Button500=Medium입니다. 공통 medium400→500을 숫자만 보고 일괄 변경하지 않습니다. Admin600·전체 다국어 줄바꿈은 미검증입니다.
- **정적 사용 계약:** Stepper 직접2곳은 NUMBER 옵션 기본48px/min0와 Lab 추가비용 input/S40px/min1로, text/S32 정비는 이 조합에 한정할 수 있습니다. Slider 직접2곳은 사진 회전(-180~180/5도). Checkbox는 notHoverStyle·disabled·상위 클릭 담당 소비와 `.checkbox-ui` 의존성을 유지해야 합니다. Tooltip은 명시폭200/204/280·강제 안내·TEXT/NONE이 혼재합니다. 기존 로고 슬롯·radius.full 원형을 일괄 교체하지 않습니다.
- **실제 동작 확인:** Clinic 사진 편집의0/5/-180/180/175와 감소 버튼170이 이미지 회전각과 일치하고 끝점 버튼이 비활성화됐습니다. Lab 라벨 생성 내 날짜는40px·과거/주말 제한·선택값 반영·Escape 달력만 닫기/부모 유지가 확인됐습니다. Clinic 모바일390×844 주문 날짜 필터는 가로 넘침 없음·40px·하단 버튼 표시, Escape 미적용/Done 적용 후 재열기 유지가 확인됐습니다.
- **재현한 수정 후보1 — disabled Checkbox Tooltip:** Clinic `/billing/payment-history`에서 hover 안내는 보이지만 Tab 순회(60회)·focus로는 접근할 수 없습니다. wrapper tabindex 없음, disabled input을 기존 키보드 진입점으로 오인합니다. native disabled/선택 차단을 유지하며 이름 있는 진입점과 enabled 자식 중복 Tab 방지가 필요합니다.
- **재현한 수정 후보2 — 중첩 Escape:** Admin `/pickup/inbound/[기존 ID]`의 요청 가능 상태→픽업 방문 요청→Date에서 열린 창2개가 Escape 한 번에0개로 닫힙니다. 날짜 선택 후 동일하게 닫고 재열면 날짜가 비고 Done이 비활성화됩니다. 첫 Escape2→1/부모 값 유지, 다음1→0/reset 한 번이 목표입니다.
- **같이 다룰 Portal:** Clinic `/my`→My Office→더보기의 Leave는 `.modal` 밖/#modal-root 안에 있습니다. Leave 초점에서 Escape하면 부모도 닫히고 opener로 복귀하지 않았습니다. 실제 Leave는 실행하지 않았습니다. 메뉴를 부모가 소유한 자식 overlay로 연결하고 메뉴만 닫기/초점 복귀를 검토합니다. focusScopeRefs 추가만으로 해결되지 않습니다.
- **기존 결함과 회귀 구분:** 위 Tooltip·Modal·PopupMenu 원인은 기준 `de2ffdd9`에도 있습니다. 관련 소비/PopupMenu 파일이 바뀌지 않았고 base Modal은 모든 Escape에 onClose를 호출했습니다. **정적 비교상 기존 결함 유지**이며 base 브라우저 재실행은 하지 않았습니다. legacy 비중첩 sibling의 동시 닫기 검사 계약은 보존하고 중첩 관계만 좁혀 수정합니다.
- **iframe 제약:** Admin `/notifications/email` 기존 기록의 sandbox iframe 표시·초점 진입 확인. iframe에 초점이 있으면 Escape가 부모에 전달되지 않고 부모 Close 버튼은 정상입니다. 전역 focus trap만으로 iframe 내부까지 해결된다고 보지 않습니다. sandbox 완화는 하지 않습니다.

### 검사와 한계

- 공식 명령 `pnpm e2e:clinic e2e/clinic/specs/09_sharedUi.spec.ts`: **3 passed**, fail/flaky/skip/nonexecution/globalError0. Clinic Export desktop·tablet 모바일 UA와 Admin SMS 확인창입니다. **수정 전 local focused** 검사이며 staging 전체 또는 후속③ 결과가 아닙니다.
- 실행 `e2e-runs/2026-09-28T05-00-46-176Z-294ea760`, HEAD01d49c3cb, source hash `d60a3d97c7e705c67e3fe361c44cc51d34b9285c8c7d45749e792792d1507a91`, 실행 전후 동일. 요약은 제품 감사 문서에도 남겼습니다. 서버/업무 데이터 준비는 공식 runner 절차이며, 테스트에서 주문·결제·배송 생성이나 실제 SMS/유효 Export 제출은 하지 않았습니다.
- 추가 브라우저 조사는 공식 테스트 수에 합산하지 않습니다. 테스트 계정 잠금과 소유 서버3100/3105/3102를 사용했고 업무 변경 요청을 차단했습니다. 이 과정에서 Admin 읽기용 POST `/admin/chats/search`도2회 차단되어 Network Error1건이 발생했습니다. 제품 결함으로 판정하지 않았습니다. 로컬 QA 위젯500·styled-components/i18n 경고도 있어 ‘무오류/무경고 전체 검증’으로 보고하지 않습니다.
- **화면 미확인 조건:** Clinic DSO `/organizations/billings`는 현재 계정403. DateRangeFieldV2의 최대92일 등 코드는 확인했으나 실제 화면은 미확인입니다. Stepper 조건부 NUMBER/추가비용 입력 화면, 모바일 사진 회전·포인터 드래그, Admin600, 로고/아이콘 전체 소비, 실기기/스크린리더는 범위 밖으로 남깁니다. 확인된 좁은 수정의 착수를 막는 미결 질문은 현재 없습니다.
- `/tmp/dlds-0928-*` 정적 보고서, `/tmp/dlds-0928/` 진단 스크립트·스크린샷·CDP 측정과 로컬 e2e-runs는 보조 자료입니다. 계정·고객 데이터·로그·인증 상태를 Git에 올리지 않았습니다. 다른 기기는 문서의 경로/재현 절차로 재확보합니다.

### 다음 시작점 — ② 남은 구현·수정

사용자가 후속 진행을 요청하면 두 Git을 pull하고 최신 체크포인트·제품 diff를 확인한 뒤 다음 순서로 시작합니다. **완료한 원본 대조나 대표 화면 점검을 처음부터 반복하지 않습니다.**

1. **재현 문제의 좁은 수정:** Tooltip disabled 진입점, Calendar/Modal 중첩 Escape와 My Office Portal 메뉴의 소유 관계·복귀를 먼저 다룹니다. `trapFocus` 전역 true 또는 모든 legacy 창의 닫기 정책 변경으로 해결하지 않습니다. base의 `shared/ui/tests/overlay-focus.test.tsx` 비중첩 sibling 계약과 기존 Dropdown/Drawer/SMS Popup을 보존합니다.
2. **남은 Figma 차이 구현:** Checkbox 일반 hover·선택형 checkmark-only, Stepper text/small32px, Slider 그림자·끝점/활성선과 실제 range 일치, 모바일 Tooltip Basic/Help를 기존 소비와 호환되게 보완합니다. 기존 명시값·업무 콜백·옵션 기본값을 보존합니다.
3. **아이콘·로고·카탈로그:** 확보된 원본/TSV를 기준으로 추가/조합 후보65종과 로고 조정10·세로 조합6을 처리합니다.65종을 무조건 새 기능65개로 치환하지 않고 재사용/조합/API 제공을 구분합니다. 기존 export를 덮어쓰지 않습니다. 카탈로그·생성 검증·사용 예시도 실제 구현 범위에 맞게 갱신합니다.
4. **좁히지 못한 기본값은 별도 판단:** medium 굵기, radius.full, daySize46, scrollContent, 전역 trapFocus·로고 치환은 자동 적용하지 않습니다. DSO 전용 계정 등 접근이 꼭 필요한 시점에만 구체적 도움을 요청합니다.

**③ 수정 후 재검증은② 뒤에 별도로 남아 있습니다.** 새 문제 재현 검사→수정→소비 화면 재확인, UI/아이콘/카탈로그 및 변경 영향에 맞는 앱 타입·공식 E2E를 수행합니다. 일반 UI tsc의 기존578건은 성공으로 표시하지 않습니다. 필요한 실기기/스크린리더·staging 검증과 사람의 디자인 판단은 별도 상태로 보고합니다.

### 종료·재개 원칙

- 이번에 띄운 서버·브라우저·계정 잠금은 종료했고3100/3105/3102 리스너와 해당 진단 잠금이 없음을 확인했습니다. 다른 worktree/사용자 서버는 건드리지 않았습니다.
- 제품 문서 커밋·푸시를 마쳤습니다. 정상 hooks에서 세 앱 타입 통과, 앱 lint는 기존 경고와 함께 오류0, 기존 coverage 검사 완료입니다. 이를 새 전체 UI 회귀 통과로 표현하지 않습니다. 개인 체크포인트·FE 라우팅·HANDOFF도 이 상태로 커밋·푸시하고, 개인 메모리의 최신 SHA는 `git log -1`로 확인합니다.
- Jira·Notion·Sites·PR·병합·배포·AI 하네스 구현은 이번 요청에서 변경하지 않았습니다. 기존 제품 커밋·푸시 허용은 이어지지만, 이번① 한정 요청을② 자동 착수로 확대하지 않습니다.
- “DLDS 이어서”, “2단계 남은 구현 시작”으로 재개하면 이절을 우선 읽습니다. 아래9/21 일시중단은 과거 기록이며 이번①만 해제·완료됐습니다.②·③은 누락이 아니라 명시적 후속 작업입니다. 새 기기의 경로·환경/인증·node_modules·서버는 별도 준비하고 오래된 SHA로 reset하지 않습니다.


## 재개 체크포인트 — 2026-09-21

### 현재 상태: 사용자 요청으로 일시 중단

- **중단 지시:** 2026-09-21 사용자가 “여기서부터는 나중에”, “현재 상황 저장”, “일단 스탑”을 요청했습니다. 기록·원격 저장을 마친 후 대기하며, 재개 요청 전에는 후속 점검·수정을 실행하지 않습니다.
- **완료/미착수 구분:** 후속 목록의 **1번 Figma 대조 완료**, **2번 실제 사용 화면 점검 미착수**, **3번 차이 수정·검증 미착수**입니다. 이번 대조에서 실행 코드를 수정하지 않았습니다. 전체 디자인시스템 1단계는 아직 진행 중입니다.
- **마지막 저장 확인:** 제품 `feature/DL-16466`의 로컬·추적 브랜치·원격 실조회 SHA가 모두 `01d49c3cbaf3590076a078a9531e2ddceb5be2a7`이며 미커밋/미푸시 변경이 없습니다. 기존 구현·카탈로그·검사 코드와 이번 원본·대조 문서가 원격 Git에 있습니다. 개인 메모리는 이 변경을 포함해 별도 커밋·푸시합니다. 개인 메모리의 정확한 최신 SHA는 `git log -1`로 확인합니다.
- **재개할 첫 작업:** 두 저장소를 갱신하고 아래 복구 순서를 따른 뒤 **Clinic/Lab/Admin의 폰트 및 Modal·Popup·Calendar·Tooltip 사용처에서 대표 점검 화면을 선정**합니다. 화면 확인·문제 기록이2번이며, 실제 수정은3번으로 구분합니다. Figma105개 node 대조를 처음부터 반복하지 않습니다.
- **다른 기기:** 아래의 Git 주소·브랜치·설치/실행 명령·증거 경로로 복구합니다. 로컬 경로, node_modules, 환경변수, 로그인, 실행 서버와 임시 파일은 이동되지 않으므로 해당 기기에서 준비합니다. 이 대화나 `/tmp`가 없어도 정본 체크포인트와 제품 원본 기록으로 이어갈 수 있습니다.
- **대기 상태:** 이번 정리에서 새 서버·브라우저·배포를 시작하지 않았고 진행 중인 위임 작업도 없습니다. 다른 사용자 작업이나 서버는 중단하지 않았습니다. PR·병합·배포·AI 하네스 착수는 하지 않았습니다.

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
- [dentlink-fe-meeting.md](dentlink-fe-meeting.md)는 최신·이전 Notion과 Jira의 바로가기입니다. `/Users/parkjongsun/Documents/ChatGPT/메인 프로젝트/FE-업무-검토-회의자료.md`는 이 파일의 심볼릭 링크이며 별도 본문을 관리하지 않습니다.
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
