# Dentlink Frontend Coordination

웹·관리자, 치과 앱, 기공소 앱을 조율하는 최상위 개인 체크포인트입니다.
상세 구현·SHA·PR·QA·배포 증거는 각 담당 문서를 정본으로 사용합니다.
업무 색인은 **2026-10-27 개인 문서 대조 결과**이며, 별도로 명시한 배포 기준 실조회 기록과 구분합니다.

## DL-17124 / DL-17125 출고 예정일 수정 인계 — 2026-10-30

- 사용자 승인: 상위 [DL-17124](https://innovaid.atlassian.net/browse/DL-17124)의 기존 Frankie 하위 [DL-17125](https://innovaid.atlassian.net/browse/DL-17125)를 재사용해 제목·본문을 정리하고 구현·검증한다. 접수 당시 하위 제목은 `[Bug] d`, 본문·댓글 없음이었다. 상위 댓글 4개를 확인했으며 과거 출고 예정일 선택은 의도된 동작이 아니고 FE 수정 대상이다. 제작 단계별 알림·치과 노출 정책 변경은 범위에 넣지 않는다.
- **DL-17125 기공소 출고 예정일 수정** 세션(`01a18af5-8028-71b1-a8ce-83ee0aadfee0`)을 메인 프로젝트 폴더·Mac local에 생성했다. 프로젝트 등록·초기 작업 시작·메인과 같은 `gpt-6-astra / ultra` 적용을 확인했다.
- 기공소 웹의 작은 수정으로 분류했다. 기본 `/Users/parkjongsun/Repository/dentlink-client`는 접수 시 master@57bb759ca·clean이며 다른 작업은 별도 worktree에 있다. 새 폴더/worktree 없이 이 checkout에서 최신 원격과 소유권을 재확인하고 `feature/DL-17125`로 준비하도록 인계했다. 아직 branch 준비·카드 수정·구현 완료의 증거는 아니다.
- 담당 세션은 첨부·입력 경로·날짜 제약을 확인해 하위 카드 정리 → 최소 수정 → 실제 화면 및 관련 검증을 진행한다. 로컬 env 상속은 공통 지침을 따른다. 결과는 해당 세션에서 사용자에게 보고하며 제품 commit/push/PR/merge/배포는 별도 지시를 기다린다.

## 공유기공소·밀링센터 세션 준비 — 2026-10-29

- **검토 종료(2026-10-30):** 모델 변경 후 최종 출력 구성을 읽기 전용 재검토했고 신규 회귀 finding 없음·120tests 재통과·원본/배포 패치동일을 확인했다. PR4805는12:44:42 KST develop 병합(80411ee78)을 실조회했으며 배포 성공은 미확인이다. 사용자는 기존 단건/일괄 수출코드 문구 차이도 그대로 두고 병합·배포를 직접 진행한다고 확정했다. 제품/Jira/PR 추가 변경 없이 기록 정리 후 대기한다. 두전용worktree clean·보존, 메인worktree의 다른3005서버는 종료하지 않았다.
- **최신 변경(2026-10-30):** 사용자가 최종 범위를 공통 라벨·스티커 + INTERNAL 부착용 추가로 바꾸고 구현·개발용PR을 승인했다. 신규 설정 패널/미리보기는 부착용에만 유지한다. 원본 `feature/DL-17101@a7aa540a2`와 별도 `feature/DL-17101-common-print-develop@46bb74fd6`를 푸시하고 [PR4805](https://github.com/Innvoaid/dentlink-client/pull/4805) 하나를 develop 대상 OPEN·미병합으로 준비했다. 양쪽120tests/타입/정상훅·원본Chrome 부착용2건2장/공통2건4장·상세스티커 확인, 하위설명/댓글44725 갱신·Ready for Deploy 유지·상위무변경. 검증서버/탭종료, 브랜치/worktree보존. 아래3종 분리/유지결정은 이전 이력이며 [전용 최신 체크포인트](dentlink-lab-shipping-print.md)가 우선한다.
- 후속 논의 종료(2026-10-30): 설정 패널·미리보기 공통 적용은 검토만 하고 보류했다. 일반적인 출력 UX 사례와 이번 요구를 대조한 뒤 사용자가 **추가 수정 없이 현재 구현 유지, 실제 프린터 확인 후 문제 전달**로 확정했다. 프리셋/고급 설정은 선택 후보이며 필수 후속 작업이 아니다. 실물 출력 검증은 미완료로 구분하고 추가 요청까지 대기한다. 제품/Jira/PR 변경 없이 [전용 체크포인트](dentlink-lab-shipping-print.md)에 근거·영향·재개점을 보존했다.
- 최종 정리(2026-10-30): DL-17101 사용자 로컬 확인 완료, PR #4802 develop 병합(61da80eae) 확인 후 작업 종료. 로컬3005 서버를 종료했고 원본/배포용 브랜치·worktree는 보존했다. 하위 Ready for Deploy 상태는 임의 변경 없이 사용자 확인/종료 댓글44710 추가. 배포 결과·실물 인쇄·번역 시트는 별도 후속이며 자동 재개/감시 없음.
- 사용자가 질문을 별도 세션에서 이어가기 위해 **공유기공소·밀링센터 세션**(`01a18682-0535-7aa3-9d30-9440b0b90a01`)을 요청했다. 기존 메인 프로젝트 폴더·Mac `local` 호스트에 정상 등록했으며 메인과 같은 `gpt-6-astra / ultra` 적용 및 초기 지침 읽기 시작을 확인했다.
- 기본 지침·제품 저장소 분리·검증 및 승인 경계·기공소 번역/i18n·개인 컨텍스트 관리 방법을 전달했다. 별도 프로젝트/worktree/branch는 만들지 않았다. 초기 등록 기록은 메인에서 저장하며 휴대폰 표시 자체를 확인한 것은 아니다.
- DL-17101 출력 분리 PR4801은 사용자 배포 전달을 받았다. 후속3종 독립 설정·용지·정렬·실시간 미리보기·새 창 확대는 원본 `feature/DL-17101@3132e836f`, 배포 `feature/DL-17101-print-settings-develop@9e64614a8`에 커밋·푸시했고 [PR #4802](https://github.com/Innvoaid/dentlink-client/pull/4802) 하나를 갱신한 뒤 사용자가 로컬 확인을 마쳤다. PR4802 develop 병합을 실조회하고 실행 작업을 종료했다. 형식별 저장/취소·회전·3종각1건1장/2건2장 native 미리보기, 타입/82tests/양쪽push훅 통과. 실물 인쇄·운영 번역 시트는 남았다. 하위 설명/댓글44709·44710만 갱신, 상위DL-17099 무변경. [전용 체크포인트](dentlink-lab-shipping-print.md)가 정본이다.
- 원본 워크트리 `/Users/parkjongsun/Repository/dentlink-client-dl-17101`과 원본 브랜치를 함께 유지한다. 메인은master clean, 기존배포브랜치도보존했다. 사용자 명시 승인으로 새세션/워크트리의 로컬준비는 메인의 해당서비스 env를 값조회 없이 그대로 상속하며, 이번Lab에 적용해3005서버를 원본경로에서 실행했으며 사용자 최종확인 후 종료했다.

## DL-14899 헬프센터 News 수정·PR 생성 완료 — 2026-10-30

- **사용자 승인/완료 범위:** 10/29 사전조사·저장 후 대기에서, 10/30 사용자가 브랜치 생성·구현·커밋·푸시·PR과 대상 `release/v1.91.0`을 명시 승인했다. 이어 이번 작은 변경의 별도 화면 검증은 생략하고 본인이 확인하겠다고 명시했다. 이는 이번 작업의 검증 범위 조정이며 다른 앱 작업의 검증 원칙을 완화하는 일반 규칙은 아니다.
- **구현/전달:** 최신 `origin/master@57bb759ca`에서 `feature/DL-14899`를 생성하고 `/Users/parkjongsun/Repository/dentlink-client-dl-14899`에 분리했다. 메인 checkout의 다른 활성 세션 `feature/DL-17125`는 보존했다. `shared/ui/src/HelpCenterUI/Main/ThumbnailListSwiper.tsx`에 `import "swiper/css";` 한 줄 추가. 커밋 `6996623ddfe7d558c479aae1cde61bfd1de11da2`, [PR #4806](https://github.com/Innvoaid/dentlink-client/pull/4806) OPEN/일반 PR, base `release/v1.91.0`, head `feature/DL-14899`, 변경 1파일/+1줄을 실조회했다. 로컬 clean·원격 0/0. 앱 네이티브·API·카드 동작은 변경하지 않았다.
- **검증/로컬 준비:** Clinic·Lab·Admin 타입 및 커밋/푸시 훅 통과. 기존 lint warning은 남음. 훅의 Admin DLOS 9개, 공용 config 21개·hook 32개 테스트 통과. 새 worktree의 Next 타입 선언을 정상 생성했으며, 최초 push는 로컬 coverage baseline 부재로 중단되어 메인 worktree의 기존 ignored 기준 파일을 그대로 상속하고 재실행했다(기준 재작성·훅 우회 없음, 커버리지 개선 주장 아님). E2E 영향 가드 `NO_IMPACT`, 기존 결제·배너·팝업은 동일 CSS를 이미 로드함을 대조. E2E 파일 변경·실제 E2E 실행 없음.
- **화면 확인 경계:** 로컬 Clinic 3210·Lab 3215의 `/help` 컴파일/로그인 진입까지만 관찰했다. 사용자가 화면 검증 생략을 명시해 이후 브라우저·앱 검증을 종료했다. 수정 후 News/Release Note 렌더링·실제 앱 WebView 검증 완료로 보고하지 않는다. 이번 서버와 임시 브라우저 탭은 종료, 작업 worktree는 보존. env는 승인된 방식으로 메인에서 값 조회 없이 상속하고 ignored 상태 유지.
- [DL-14899](https://innovaid.atlassian.net/browse/DL-14899)는 헬프센터 모바일 웹의 **New 영역 미노출**을 확인하는 Frankie 담당 하위 작업이다. 상위 DL-14898과 함께 `해야 할 일`이며 두 카드 모두 댓글은 없다(접수 시점 실조회).
- [2026-05-25 Slack 원문](https://innovaidhq.slack.com/archives/C09613TBE5A/p1779715031187929)과 첨부 `F0B5TUUBCP5`를 실제로 읽었다. 카드의 ‘New’는 화면상 **News 게시물 목록**을 뜻한다. Order/Shipping·View More 아래 News 제목만 있고 회색 콘텐츠 영역이 비어 있다. 당시 앱 담당자는 웹뷰 영역이라고 설명했고 제보자는 모바일 웹에서도 동일 현상을 확인했다. 두 Jira 카드의 댓글 0개와 Slack 답글 7개는 별개다.
- 사용자 요청에 따라 같은 **메인 프로젝트 폴더**, 기존 Mac `local` 호스트에 **DL-14899 헬프센터 New 영역 조사** 세션(`01a18601-2719-77a3-8d2a-1962bc49e5b8`)을 생성했다. 프로젝트 연결과 초기 조사 턴, 메인과 같은 `gpt-6-astra / ultra` 적용을 확인했다. 실제 휴대폰 목록 노출은 별도 확인 대상이다.
- **10/29 운영 재현:** 로그인된 Chrome에서 `https://portal.dentlink.io/help` 직접 진입. 데스크톱에는 News 4개가 표시됐지만 DevTools iPhone SE(375×667, 모바일 UA)로 새로고침하면 원문과 같은 빈 News 영역이 재현됐다. Release Note도 동일했다. 이는 Chrome 기기 에뮬레이션 관찰이며 실제 iOS/Android 앱·실기기 검증은 아니다. 단순 viewport 축소는 UA 기반 분기를 타지 않아 이 재현을 대신하지 못한다. 임시 viewport·기기 모드·DevTools 필터는 조사 후 복구했다.
- **원인 근거:** 모바일 전용 `shared/ui/src/HelpCenterUI/Main/ThumbnailListSwiper.tsx`는 `swiper/react`만 import하며 `swiper/css`가 없다. 운영 DOM에는 섹션별 카드 4개가 존재하고 관련 게시글 GET은 200이었다. `.swiper-wrapper`는 `display:block`, 높이 764px, translateX(-440px)이고 모든 카드의 x 범위가 -440~-205px로 화면 밖이었다. 부모 overflow:hidden으로 가려진다. 실제 로드된 v1.90.0 CSS(`435cb33a3ae9e4d0.css`)에도 swiper 규칙이 없고 inline에는 부분 스타일만 있다. **모바일 슬라이더 기본 CSS 누락으로 인한 레이아웃 문제**를 확인했다. 5월 당시 서버·브라우저 상태까지 같은 원인이었다고 소급 확정하지 않는다.
- **담당 범위:** 자체 Next `/help`와 `/office/contents/boards`·게시글 API이며 외부 헬프센터/iframe 설정이 아니다. Clinic·Lab의 `HelpCenterMainContents.tsx`가 `react-device-detect.isMobile`로 공용 Swiper를 선택한다. Office·Lab 앱은 각각 portal/lab의 `/auth/redirect?next=/help`를 WebView로 열고 모바일 UA에 `-DentlinkAppWebView-`를 붙인다. News 렌더링은 웹 소유다. 공용 웹 스타일 로드 보완이 작은 수정 후보이며 앱 네이티브 코드 변경 필요 근거는 없다.
- **10/29 조사 당시 코드 기준/보존:** web `origin/master@57bb759ca08e3752140ceffdae2a5421934ec242`; checkout `feature/DL-17011@9dcb644d566cee06fa0019c16b7f47cdf10e8d36` clean, 관련 파일은 master와 동일. Office `origin/main@7f586790e0bbd7b288458e29f00654d38ba68da2`, Lab `origin/main@51441039751b63a08c82a1be9695c805c8af1539`를 읽었다. 앱 checkout의 알림센터 작업 변경(`feature/DL-17059`, `feature/DL-17060`)은 보존했다. 필요한 fetch 외 제품 코드·checkout·branch·worktree·commit/push·PR·Jira 변경 없음.
- **남은 일/재개점:** 요청한 코드 작업·커밋·푸시·PR 생성은 완료. 사용자의 화면 확인과 별도 리뷰/병합·배포 지시를 기다린다. 병합·배포·Jira 변경·CodeRabbit 후속 처리는 하지 않았다. 재개 시 PR #4806과 exact worktree를 먼저 확인한다. 데이터 없는 상태 개선이나 UA 분기 재설계는 범위에 추가하지 않는다.

## 앱 공통 브랜치 전략 변경 — 2026-10-29

- 통합알림센터 세션에서 사용자가 **Office·Lab 앱 모두 `main → feature → release → main`** 전략으로 변경했다고 확정했다. 신규 `feature/<Jira>`는 최신 origin/main에서 시작하며 develop은 더 이상 운용하지 않는다. 남은 develop은 점진적 정리 대상이고 이번 지시만으로 삭제하지 않는다.
- 공통 AGENTS/SESSION_WORKFLOW와 [앱 온보딩 지침](dentlink-app-onboarding.md)에 반영했다. 과거 develop 기준·PR 대상·release→develop 동기화 기록은 현재 전략으로 사용하지 않는다. 구현 상세는 기능 정본에 유지한다.

## 웹 v1.90.0 배포 기준 확인 — 2026-10-27

- 사용자 요청으로 원격 refs와 실행 대상을 한 번 확인했다. `release/v1.90.0`과 `prd/clinic/v1.90.0`, `prd/clinic-ohio/v1.90.0`, `prd/lab/v1.90.0`, `prd/admin/v1.90.0`은 모두 **`4168fba5aad347e6958412057b4bf35d856f4473`**를 가리킨다. 릴리스 커밋에서 태그를 만들어 배포한다는 목적과 일치한다.
- 아래 Actions는 해당 태그 push로 시작했고 실행 `head_sha`도 모두 위 커밋이다. **18:06 KST 메타데이터 조회 당시 진행 중**이었으며 완료 결과는 재조회하지 않았다.

| 서비스 | 시작 시각 KST | 실행 |
| --- | --- | --- |
| Clinic | 18:02:09 | [40477752750](https://github.com/Innvoaid/dentlink-client/actions/runs/40477752750) |
| Lab | 18:03:13 | [40477879968](https://github.com/Innvoaid/dentlink-client/actions/runs/40477879968) |
| Admin | 18:03:48 | [40477951931](https://github.com/Innvoaid/dentlink-client/actions/runs/40477951931) |

- 같은 exact SHA의 PRD workflow·Dockerfile을 대조했다. 태그 커밋 checkout → 해당 소스 build context → `prd-${github.sha}` 이미지로 전달하며 다른 브랜치 재checkout은 없다. Clinic workflow 하나가 서울·Ohio 양쪽을 처리한다.
- 이번 확인은 **배포 기준/실행 대상 일치**다. 최종 성공·serving revision·서비스 안정화·사용자 QA의 증거는 아니다. 특히 Lab/Admin은 workflow에서 안정화를 기다리지 않으므로 성공 상태만으로 확대하지 않는다. 자동 후속 감시는 시작하지 않으며 결과 확인은 사용자 요청과 공통 배포 확인 주기를 따른다.
- 제품 코드·branch·tag·배포 설정은 변경하지 않았다. 기본 checkout은 `feature/DL-17011@9dcb644d5`·clean·upstream0/0 그대로이며 로컬 checkout과 원격 태그 배포 기준을 혼동하지 않는다.
- **마감:** 사용자가 기준 일치 설명을 확인했으며 이번 확인 요청은 완료했다. 기록을 정리하고 추가 변경·배포 결과 재조회 없이 대기한다. 최종 배포 성공은 확인 완료로 승격하지 않으며, 사용자가 별도로 결과 확인을 요청할 때 위 실행부터 대조한다.

## 현재 업무 색인 — 2026-10-27

| 업무 | 담당 정본에 기록된 단계·재개 경계 | 상세 정본 |
| --- | --- | --- |
| 메인세션 | 상시 중앙 조율·개인 컨텍스트 관리. 보관하지 않고 유지 | 이 문서의 Session Ownership |
| LBX / DL-16387 | 원본 수정·별도 develop 전달 및 사용자 개발 배포 완료 기록. 원본 보존·운영 홀드 유지 | [LBX](dentlink-client-lbx.md) |
| 디자인시스템정비 | 원천/통합 운영 반영 완료. DL-17046 Studio 갤러리는 관련 동료 코드와 사용자 재개 지시 대기. 하네스는 별도 판단 | [DLDS](dentlink-fe-opportunities.md) |
| 통합알림센터 | 10/29 사용자 승인 후 웹·Office·Lab 선행 UI 구현 착수. BE 계약·실제 연결과 최종 검증은 구분 | [통합알림센터](dentlink-unified-notification-center.md) |
| DL-17012 앱 미지원 기능 우선순위 | Notion 최종 표 정리·검토 완료, 추가 요청 대기. 제품 구현 아님 | [모바일웹·앱 비교](dentlink-mobile-web-app-parity.md) |
| 권한관리 / DL-16317 | 배포·정리 완료 기록. 이후 발견된 회귀·후속 QA는 개별 근거로 구분 | [권한관리](dentlink-permission-management.md) |
| 후속 QA / DL-17011 | 구현·PR 병합 후 10/27 사용자 배포 완료·추가 QA 없음 확인. 업무 종료·세션 보관 요청 기록 | [권한관리](dentlink-permission-management.md) |
| Office 컨펌 오류 / DL-17038 | 수정 전 Render Error 재현·수정본 한정 검증·임시 브랜치/런타임 정리 완료 | [Office 앱](dentlink-app.md) |
| Office LinkTalk SIGSEGV | 확보 가능한 범위 조사 마감. 일치 dSYM 부재로 정확 원인 미확정, 증거 확보와 별도 재개 요청 대기 | [전용 조사](dentlink-app-linktalk-sigsegv-investigation.md) |
| Billing Statement / DL-16796 | 운영 포함·정리 완료 기록, 추가 예정 작업 없음 | [Billing](dentlink-client-billing-statement.md) |
| 웹 env / DL-16821 | 운영 반영·기본 로컬 실행 준비·정리 완료 기록. 별도 보안/DEV 후속 자동 재개 금지 | [환경변수](dentlink-client-env-management.md) |

- 세션 보관 요청과 실제 앱 보관 상태, Git 병합과 서버 배포, 에이전트 검증과 사용자 QA를 구분합니다.
- 제품 저장소의 현재 branch/worktree/env·배포 상태는 필요할 때 live 확인합니다. 이 표에 변동 SHA나 개수를 중복 기록하지 않습니다.
- 담당 문서가 이후 갱신되면 그 최신 기록을 따르며, 이 색인의 오래된 단계로 되돌리지 않습니다.

## 담당 세션 식별자

기존 세션을 찾기 위한 기록입니다. 다른 PC에 프로젝트/대화를 자동 복원하거나 현재 실행·보관 상태를 보증하지 않습니다.

| 업무 | 기록된 세션 이름 | ID |
| --- | --- | --- |
| 메인 | 메인세션 | `01a08f0c-2057-7852-ae8d-0cf950a91fd3` |
| 디자인시스템 | 디자인시스템정비세션 | `01a0a2eb-da08-7131-aaaf-6c14f0cfc204` |
| DL-17012 | DL-17012 기공소 앱 미지원 기능 우선순위 | `01a17657-caad-70f1-9a40-dbde874a3d42` |
| DL-17011 | DL-17011 관리자 그룹 회원 권한 수정 이력 조사 | `01a17658-54e4-7b42-bd92-d0f790d7f2bd` |
| SIGSEGV | 앱 SIGSEGV 오류 원인 조사 | `01a17c4f-57cb-7592-8b7e-b8b937ee7d32` |
| API 조회 | API 사용처 확인 세션 | `01a17b41-6ead-7fc1-9387-42f68aaa86e2` |
| DL-14899 | DL-14899 헬프센터 New 영역 조사 | `01a18601-2719-77a3-8d2a-1962bc49e5b8` |
| 공유기공소·밀링센터 | 공유기공소·밀링센터 세션 | `01a18682-0535-7aa3-9d30-9440b0b90a01` |
| DL-17125 | DL-17125 기공소 출고 예정일 수정 | `01a18af5-8028-71b1-a8ce-83ee0aadfee0` |

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

## Session Ownership

- **원격화 구분(2026-10-27):** 기본 의미는 켜진 이 Mac의 기존 세션을 휴대폰에서 그대로 이어 쓰는 것이다. 다른 PC로 실행 환경을 옮겨 Git 기반 컨텍스트를 복구하는 경우와 구분하고, 각 세션에서 같은 의미를 다시 묻지 않는다. 신규 세션은 정상 등록·프로젝트·호스트·초기 턴 확인과 초기 개인 기록 저장/푸시를 기본으로 챙긴다. 연결 설정은 사용자가 관리한다. 사용자의 '메모리화 후 휴대폰에서 보였다'는 경험은 관찰로 기록하며 Git 저장이 모바일 표시를 유발한다는 인과나 현재 표시 완료를 단정하지 않는다. 정본은 [Phone Remote Continuity](../SESSION_WORKFLOW.md#phone-remote-continuity)이다.
- **메인세션 유지 규칙(2026-10-27):** 이 최상위 세션 `01a08f0c-2057-7852-ae8d-0cf950a91fd3`는 보관하지 않고 계속 유지·대기한다. 보관/영구 종료 요청이나 다른 작업 세션용으로 보이는 대상 불명확 마감 지시가 들어오면 사용자에게 대상을 먼저 되묻는다. 메인 자체가 대상임을 재확인하기 전에는 보관하지 않으며, 일반적인 기록 정리·대기는 그대로 수행한다. 이 추가 확인은 다른 기능 세션 전체에 적용하지 않는다. 정본은 [Dentlink FE Main Session Retention](../SESSION_WORKFLOW.md#dentlink-fe-main-session-retention)이다.
- 직전의 'QA 없이 배포 완료, 정리 후 세션 보관' 메시지는 사용자가 다른 세션에 쓸 내용을 잘못 보낸 것으로 철회했다. 그 메시지를 근거로 SIGSEGV 조사나 다른 업무의 배포/완료 상태를 변경하지 않는다.
- 2026-10-27 **API 사용처 확인 세션** (`01a17b41-6ead-7fc1-9387-42f68aaa86e2`,
  local·메인 프로젝트)은 단순 API 사용처 확인용으로 계속 유지한다.
  원격에서도 찾을 수 있도록 이름·ID·용도만 기록하며, 조회 과정과 개별 결과는
  매번 저장하지 않고 재사용할 결정이나 원칙만 필요할 때 짧게 남긴다.
  Git 원격의 이 기록은 Codex 모바일 목록 동기화 완료를 확인한 근거는 아니다.
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

## 상시 작업 지침의 정본

- 앱의 최종 코드·영향 화면·권한별 에이전트 실행 검증 → 결과/확인표 전달 → 사람의 최종 QA: [앱 검증 지침](../DEVELOPMENT_STYLE.md#app-screen-runtime-verification-before-merge).
- 앱 PR·release·CodePush·스토어 경계와 개발자 참고 흐름: [앱 온보딩](dentlink-app-onboarding.md), [공통 앱 전달 정책](../SESSION_WORKFLOW.md#dentlink-app-release-and-delivery-policy). 참고 흐름으로 확정 정책을 조용히 바꾸지 않습니다.
- 제품별 Jira 카드·상위 댓글 제한: [AI_WORKFLOW](../AI_WORKFLOW.md#jira-work-updates).
- 기공소 정적 문구 변경 시 i18n·시트·검증: [공통 기준](../SESSION_WORKFLOW.md#dentlink-lab-translation-work), [웹](dentlink-client-i18n.md), [Lab 앱](dentlink-lab-app-i18n.md).
- 완료 브랜치 정리 시 현재 진행 중 release 원본 보존: [브랜치 정리 이력과 기준](dentlink-branch-cleanup-20261016.md). 제품 Git 정리는 별도 승인과 live 근거가 필요합니다.

## 다른 기기에서 이어가기

- **휴대폰으로 같은 Mac에 접속:** 기존 세션·프로젝트·코드 환경을 그대로 사용합니다. [Phone Remote Continuity](../SESSION_WORKFLOW.md#phone-remote-continuity)를 따르며 다른 PC 복구와 혼동하지 않습니다.
- **다른 PC로 실행 환경 변경:** 개인 컨텍스트 clone/pull → [BOOTSTRAP](../BOOTSTRAP.md#read-order) → 이 색인에서 해당 정본을 읽고 목적·결정·남은 일·재개 조건을 복구합니다.
- 기존 대화 전체·앱의 프로젝트 등록·인증·env·의존성·서버·임시 증거는 개인 컨텍스트 pull만으로 복원되지 않습니다. 절대 경로는 당시 기기 기록이며 실제 대상 경로를 확인합니다.
- 문서 복구만으로 구현·QA·서버 실행·배포·보류 해제가 승인되지 않습니다. 실제 재개 시 제품 Git과 작업 소유권을 다시 확인합니다.
- 여러 세션이 개인 컨텍스트 checkout을 공유하면 수정 파일을 나누고 stage/commit/push는 조율합니다. 다른 세션 변경을 임의로 포함하지 않습니다.

## 과거 조율 이력

[2026-10-27 정리 전 전체 이력](archive/dentlink-fe-history-through-2026-10-27.md)에 이전 세션 배정, 브랜치·폴더·env 정리, 피드백/E2E·release 전환, 웹/앱 초기 인계와 상세 PR 기록을 보존했습니다.
보관본의 '현재·대기·다음 시작점'은 당시 상태이며 위 최신 색인이나 담당 정본을 대체하지 않습니다. 정확한 과거 경위가 필요할 때만 읽습니다.
