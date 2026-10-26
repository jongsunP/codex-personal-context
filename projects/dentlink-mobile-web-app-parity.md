# Dentlink 모바일웹 대비 앱 기능 차이 조사

## 현재 상태 — 2026-10-26 1차 조사 분리·2차 최종표 정리 완료

- **최신 사용자 의도:** 1차는 각 담당자의 조사 원문으로 유지하고, 2차는 합친 최종 작업 목록으로 정리한다. 서비스보다 기능 도메인을 우선한다. 기존 행·내용을 최대한 유지하면서 중복 범위를 정리하고 누락을 관련 행에 합친다. 마지막 요청은 2차의 클리닉·기공소 모두 수정 승인이다. 앞선 클리닉 조사만/기공소만 제한으로 되돌리지 않는다.
- **문서 구조:** [대문](https://app.notion.com/p/3fece072e82f80d5a02fda9a76cd51b7)은 제목을 유지하고 1차 조사 2개와 2차 회의록으로 연결했다. [1차 클리닉](https://app.notion.com/p/405ce072e82f8156a03af685077e9a88), [1차 기공소](https://app.notion.com/p/405ce072e82f81258a94efb5735b8086)는 각 담당자 원문을 분리 보존했다. 빈 작성중 history1(`405ce072e82f80028e9ec9cd0a4bf65a`)은 사용자 요청으로 삭제했다. 대문을 사용자가 다시 정리한 뒤 이번 최종표 작업에서는 대문·1차 둘의 제목/본문을 변경하지 않았다.
- **최종 문서:** [2차 회의록 · 앱 미지원 기능 종합 및 작업 계획](https://app.notion.com/p/405ce072e82f80a9a1f7ccd329fa2d3d). inline DB `21150103c57d4d5382657ca031459874`, source `a1ee4eee-13e0-42cb-be82-940b62b6a27b`. DB 이름은 사용자가 바꾼 `앱 미지원 기능 `을 유지한다. 이전 대시보드/백로그 이름이나 사용자가 삭제한 상태 안내를 복원하지 않는다.
- **행 구성:** 기공소 주문 상세·도움말 웹뷰 범위를 먼저 보완한 이후 최종표는 **36행(치과27·기공소9)**. 마지막 정리에서는 행 추가·삭제 없이 18개 행의 필요한 이름·영역·설명·경로만 수정했다. 사용자가 전부 `백로그`로 맞춘 작업 상태, 두 우선순위 열, 서비스, 사용 빈도, 앱 지원 상태, 담당자, 목표 일정은 모두 보존했다.
- **공통 도메인 9개:** 주문6 / 리메이크2 / 배송·픽업2 / 환자1 / 스캐너 연동1 / 결제·청구8 / 조직·직원7 / 계정6 / 기타3. 주문·리메이크, 주문·배송처럼 서비스별로 달랐던 영역을 실제 기능 범위로 구분했고 미사용 선택 옵션도 정리했다. 두 서비스의 `주문 상세`와 `도움말 센터` 이름을 통일했다. 기능 범위나 우선순위가 다른 서비스 행은 억지로 합치지 않았다.
- **클리닉 의도적 제외 항목 보완:** 사용자는 결제수단 관리, 비밀번호 변경·재설정, 조직 오피스·빌링·미수금을 다른 행과 겹쳐 제외했다고 설명했다. 별도 행을 재생성하지 않고 기존 3행을 `결제수단 관리·카드 등록·3DS 인증`, `내 정보 수정·비밀번호 변경·재설정`, `조직 대시보드·오피스·빌링·미수금`으로 묶어 설명·웹 경로를 보완했다. 근거 없는 카드 삭제/기본카드 지정 같은 세부 기능은 추가하지 않았다.
- **나머지 범위 정리:** 주문 생성 행은 주문에 쓸 스캔 파일 가져오기 설정, 스캐너 행은 스캐너 계정 연결·설정으로 구분했다. 서로의 작업 범위를 설명에 명시했으며 다른 우선순위는 유지했다. 기존 오피스 등록·찾기·데모 행에 `/demo`와 데모 설명을 보완했다. 2차 본문은 공통 도메인별 최종 목록이라는 설명과 주문·리메이크·배송/픽업 영역 구분 문구 2곳만 맞췄다.
- **사용자 전체뷰 컬럼 순서 보존:** 작업 항목 → 기능 영역 → 서비스 → 우선순위 → 직접정한 우선순위 → 사용 빈도 → 앱 지원 상태 → 앱에서 막히는 점 → 웹 경로 → 현재 가능한 범위·조건 → 작업 상태 → 담당자 → 목표 일정. 정렬은 기능 영역 오름차순 → 직접정한 우선순위 오름차순. 전체/치과/기공소/진행현황/우선순위미정 모든 뷰 설정은 쓰기 전후 동일하다.
- **기공소 웹뷰 후속 확인:** 주문 상세(주문별 배송 포함), 도움말 센터는 웹뷰 제공이며 기능 자체 미지원과 구분해 네이티브 전환 검토로 기록했다. 디자인·플래닝은 전체 승인화면이 아니라 HTML·URL 미리보기만 웹뷰다. BillingPolicy는 Lab 정상 진입 근거가 없고 PaymentMethod는 Forbidden/return null, Eximbay는 일반 Lab 진입 미확인이므로 일반 기공소 누락 항목으로 추가하지 않았다. 이 결론은 기존 고정 SHA 정적 코드 조사이며 설치 앱/실기기 QA 증거가 아니다.
- **1차 기공소 회색 보존:** 현재 7 알림 이력함, 11 공유기공소 잔여 목록·조회, 순번 없는 직접 소속전환 및 디자인·플래닝 HTML·URL 미리보기는 이미 작업 예정이거나 제외하되 인지하기 위한 항목이다. 모두 신규 개발 후보로 복원하지 않는다. 1차 기공소는 12개 번호 행+순번 없는 제외2개로 보존되어 아래 옛 11행/회색3개 기록은 과거 이력이다.
- **검증:** 2026-10-26 최종 live read-back에서 36행 전체 속성이 수정 직전값+승인된 최소 변경과 일치하고, 전부 백로그/보호필드 유지/기능영역9개/다른 스키마 및 모든 뷰 불변을 확인했다. 2차 본문은 의도한 2문구 변경과 정확히 일치했다. 대문·1차 두 문서의 제목/본문 불변 확인. 별도 에이전트가 행수·서비스별수·전체백로그·공통명·영역·컬럼순서를 독립 재확인했다.
- **남은 일/경계:** 요청한 Notion 최종 정리에는 미완료 사항 없음. 다음 요청 시 사용자의 최신 Notion을 먼저 읽고 진행한다. 추가 구현, Jira 변경/메시지, 제품 Git/PR/배포, 자동 추적, 실기기 QA는 수행하지 않았으며 이번 정리로 승인되지 않는다.

## 이전 상태 — 2026-10-26 사용자 최종본 확인·마감 후 대기

- **최종 확인:** 사용자가 직접 마무리한 Notion을 읽기 전용으로 확인했다. 우선순위 뜻·순서 번호·항목별 업무 영향과 이유가 있고, 추가 필수 수정은 없다. 사용자가 정리·대기를 요청하여 개인 기록만 저장하고 대기한다. 최종 확인 이후 Notion·연결 백로그·Jira·제품은 수정하지 않았다.
- **회색 표시의 사용자 정의:** 6번 알림 이력함, 10번 공유기공소 도입 관련 목록·조회, `—` 소속 기공소 직접 전환의 3개 행은 **이미 작업 예정이거나 제외하되 현황을 인지하기 위해 남긴 항목**이다. 회색이 모두 미완료·추가 착수 대상이라는 의미가 아니며, 앞의 두 항목이 각각 예정/제외 중 무엇인지는 임의로 확정하지 않는다. 직접 전환은 본문상 신규 개발 대상 제외다.
- 회색을 제외한 **1~5번·7~9번의 8개 항목**이 이번 우선순위 검토 대상으로 읽힌다. 회색 항목을 별도 개발·문서 수정·QA 대상으로 자동 재개하지 않는다. 다음 명시 요청에서만 최신 Notion과 적용 범위를 먼저 확인한다.

- 사용자가 Notion을 직접 정리한 뒤 기공소의 나뉜 표만 하나로 합쳐 높은 우선순위를 위에 두고, 표 안에 그 순위의 이유를 적으라고 요청했다. 최신 사용자 편집본을 재조회했으며 사용자가 삭제한 기존 설명·기준·출처 문단을 복원하지 않았다.
- 기공소 5개 표를 단일 표로 통합한 뒤, 추가 요청에 따라 최종 **1개 표·11행·5열**로 정리했다. 첫 열 `순서`에 1~10을 넣고 직접 소속전환은 `—`로 표시했다. 가입과 비밀번호 찾기는 P2/P1이 달라 두 행으로 나눴으며 새 기능이나 우선순위 변경은 없다. `우선순위·이유`는 업무 영향과 먼저/나중에 진행하는 이유를 설명한다.
- 표 위에 기공소 기준의 짧은 뜻을 추가했다: **P0 즉시 대응(확인된 장애·업무 중단), P1 높음(로그인·주문·출고 핵심 업무), P2 다음 단계(가입·초대·알림·계정/직원 관리), P3 현재 계획상 조건부 기능 확장 후순위**. 현재 P0 없음, 번호가 작을수록 먼저 권장, 실제 빈도·사용자 수는 미확인임을 명시했다. 치과의 순위를 그대로 따라야 하는 의미가 아니다.
- 최종 순서: 1 비밀번호 찾기(P1), 2 주문 검색·날짜(P1), 3 긴급·지연(P1), 4 전체 배송·라벨(P1), 5 초대 수락(P2), 6 알림 이력(P2), 7 직원 관리(P2), 8 비밀번호 변경·탈퇴(P2), 9 회원가입(P2), 10 공유기공소 잔여 조회(P3), — 직접 소속전환(대상 제외).
- 저장 후 재조회로 단일 표·11행·각5열·1~10/—·모든 셀·순위 설명 일치를 확인했다. **기능별 우선순위 절 밖의 본문 전체는 동일**하며 사용자 요약·치과·개요를 유지했다. 이번에는 연결 백로그·Jira·제품 저장소를 변경하지 않았다. 백로그의 기존 가입/찾기 묶음에는 두 순위가 이미 설명되어 있어 별도 분리·변경하지 않았다.
- 요청한 표 정리와 사용자 최종본 확인을 완료했다. 다음 수정 요청 전 추가 변경·자동 확인 없이 대기하며 재개 시 사용자의 최신 Notion을 먼저 읽는다.

## 이전 상태 — 2026-10-26 우선순위 반영 완료·사용자 Notion 정리 동안 대기

- **최신 지시:** 사용자가 Notion을 직접 다시 정리하겠다고 하며 대기를 요청했다. 추가 요청 전 Notion·백로그·Jira·제품 작업이나 자동 확인을 하지 않는다. 재개 시 사용자가 정리한 최신 Notion을 먼저 읽고, 아래 저장 당시 내용으로 덮어쓰지 않는다.
- 사용자는 Jira 카드가 간단해 티켓 상태만 직접 변경했다고 알렸다. 변경 후 정확한 상태는 재조회하지 않았으며, 아래 `해야 할 일`은 최초 조회 당시 기록이다. Codex의 Jira 수정은 없다.

- **요청/완료:** 사용자는 기공소만 본인 역할이며, 치과 담당자가 작성한 P0~P3 표기를 참고해 Codex가 직접 우선순위를 판단하여 Notion에 채우라고 명시했다. 우선순위 결정 자체를 다시 사용자에게 묻지 않는다. 이번 범위는 조사·우선순위 문서 반영이며 제품 구현이 아니다.
- [DL-17012](https://innovaid.atlassian.net/browse/DL-17012)는 Frankie 담당, 조회 당시 `해야 할 일`이다. 원래 조사 카드 DL-16826은 완료다. 상위 DL-16825의 [Tom 댓글44617](https://innovaid.atlassian.net/browse/DL-16825?focusedCommentId=44617)은 2026-10-25 10:48 KST에 “우선순위 정리까지”, 두 담당자가 PM이라고 생각하고 진행, “차주 화요일에 공유”를 요청했다. 별도 확정 일정·기한을 생성하지 않았다.
- [원문 Notion](https://app.notion.com/p/3fece072e82f80d5a02fda9a76cd51b7)의 **기공소 절만** 수정했다. 기존 5개 표·10행을 유지하고 `우선순위·이유` 열을 추가해 4열로 정리했다. 기준·진행 순서와 최신 코드에 따른 필요한 현황 정정을 함께 기록했다. 개요·치과·상단 대시보드 링크는 수정 전후 문자열 동일성을 확인했다.
- 새로 연결되어 있던 [앱 미지원 기능 작업 대시보드](https://app.notion.com/p/405ce072e82f80a9a1f7ccd329fa2d3d)의 백로그도 **기공소 10개 레코드만** 맞췄다. data source `a1ee4eee-13e0-42cb-be82-940b62b6a27b`: P1 4개, P2 4개, P3 1개, 이미 구현된 직접 소속전환 1개는 우선순위를 비우고 `신규 개발 대상 제외`를 설명했다. 회원가입·비밀번호 찾기 묶음은 대표값 P1이며 설명에 **찾기 P1 / 가입 P2**를 분리했다. 공용 DB 스키마·뷰·치과 레코드·작업 상태·일정·사용 빈도는 변경하지 않았다.
- **검증:** Notion 재조회에서 기공소 5개 표·10행·각 4열과 모든 순위/제외 표시 확인. 백로그 10개 재조회에서 지정값, 사용 빈도 `미정`, 작업 상태 `정리 필요`, 목표 일정 없음 유지 확인. 실제 사용 빈도·사용자 수는 미확인이다. 아래 순위는 개발 추천 순서이며 출시 일정·화면·구현 방식을 확정하거나 구현 착수를 승인한 것이 아니다.
- Jira 본문·댓글·상태는 변경하지 않았다. 특히 상위 댓글을 작성하지 않았다. 제품 코드·checkout·pull/fetch·branch/worktree·commit/push/PR·배포·실기기 QA 변경/실행은 없다. env/auth 실제값을 읽거나 복사하지 않았다.

### 반영한 순서와 판단 근거

- **P0 없음:** 즉시 대응이 필요한 서비스 중단 등의 근거는 확인되지 않았고 모바일웹 대체 경로가 있다. 치과 담당자의 순위·사용 빈도를 기공소의 실측값처럼 복사하지 않았다.
- **P1:** 비밀번호 찾기는 로그인 복구를 위해 먼저 보완한다. 주문목록 검색·날짜 조건 → 긴급·지연 집계·모아보기 → 전체 배송 관리·라벨 생성 순서로 기존 주문·출고 업무를 보완한다. 앞의 두 기능은 주문 필터/목록 연결을 공유하므로 함께 범위를 정하기 좋다.
- **P2:** 초대 수락 → 알림 이력함 → 직원·계정 관리·회원가입 순서. 모바일웹으로 처리 가능한 온보딩·관리 흐름과 푸시/LinkTalk를 보완하는 기능이다. 직원 관리는 Owner 대상이며 모든 직원의 반복 업무라고 가정하지 않았다.
- **P3:** 공유기공소 도입 관련 잔여 목록·조회. 일반 업무 보완을 우선한다는 판단이며 대상 사용자가 적다는 실측 근거가 있다는 뜻이 아니다. 이미 구현된 자재·생산/QR 경로를 제외하고 기존 밀링 작업과 남은 범위를 맞춘다.
- **대상 제외:** 소속 기공소 직접 전환. 최신 앱 코드에 직접 선택 UI부터 소속 활성화 API까지 구현되어 신규 개발 후보에서 제외했다. 실제 설치 앱 제공/기능 QA는 별도 미확인이다.

| 항목 | 순위 | 상대 난이도 초안 | 구현 시 필요한 범위/의존성 확인 |
| --- | --- | --- | --- |
| 주문목록 상세 검색·날짜 조건 | P1 | 중 | 기존 검색 요청 재사용, 카테고리·치과명·날짜 의미와 조합·시간대 |
| 긴급·지연 집계·모아보기 | P1 | 중 | 웹 집계 기준과 날짜 경계, 집계 건수와 필터된 주문목록 일치 |
| 전체 배송 관리·라벨 생성 | P1 | 중~상 | 인증·소속, 배송 생성 완료 SSE, 새 창 라벨/PDF·외부 추적·앱 복귀 |
| 비밀번호 찾기 / 회원가입 | P1 / P2 | 찾기 하~중 / 가입 중~상 | 웹 연결/앱 내 완료 방식, 복구·가입 이후 로그인/소속 흐름 |
| 초대 수락·소속 가입 | P2 | 중~상 | 로그인 전후 복귀, 초대 만료·계정 일치·소속 활성화와 앱 상태 반영 |
| 알림 이력함 | P2 | 중~상 | 기존 통합알림센터 방향, 알림 분류·읽음·목적지·소속/권한 |
| 직원 초대·관리 | P2 | 중~상 | Owner 제한, 역할/권한·퇴사 처리 후 앱 세션/소속 갱신 |
| 비밀번호 변경·회원탈퇴 | P2 | 중~상 | 재인증·소유자/소속 조건·처리 후 세션 종료; 두 절차의 범위 분리 |
| 공유기공소 도입 관련 잔여 조회 | P3 | 자재 중 / 설비·제품·옵션 중~상 | 자재탭 비활성 사유, SHARED/INTERNAL 대상·서버 권한·기존 밀링 담당 범위 |
| 소속 기공소 직접 전환 | 신규 개발 제외 | 신규 산정 불필요 | 설치본에서 제공 여부를 확정해야 할 때만 별도 기기 확인 |

난이도는 화면 방식·API/권한 검증 전의 상대 판단이다. 일수·Story Point·출시일은 산정하지 않았다. 위 확인사항은 향후 구현 범위 결정에 필요하며, 이번 우선순위 반영 완료를 보류하는 질문이 아니다.

### 최신 근거와 과거 기록의 정정

- **실제 Git:** 웹 master/실원격 master `c597f1fb3e7f5c03a76237926c3effad5bb84983`, clean. 로컬 LBX `feature/DL-16387@f389c13cfbe497e0b864aa9399efafd9ecae305d`와 다른 세션의 detached `dentlink-client-dlds` worktree를 보존했다. Lab 기본 checkout은 `QA/DL-16917@06e8dfde967502a4830e9a93c018ce150702dc7c`, clean이며 바꾸지 않았다. Lab 실원격 main/develop/release/v1.0.5 모두 `51441039751b63a08c82a1be9695c805c8af1539`로 ls-remote 확인했다.
- Lab 최신 object가 로컬에 없어 기존 refs를 갱신하지 않았다. GitHub 플러그인의 해당 repo 읽기가404여서 `gh api`의 고정 SHA GET으로 소스를 확인했다. 웹은 고정 SHA `git show`/diff로 대조했다. Office 저장소는 이번 범위가 아니므로 조사·변경하지 않았다.
- **일반 8개 격차 유지:** 앱 주문목록 요청 `OrderListTabScreen.tsx:88-109`는 상태·환자명·주문번호 중심, Home 집계는 In Review/Ready for Fabrication이며 배송관리·직원관리·계정 lifecycle·초대수락·알림이력의 정상 진입은 확인되지 않았다. 기존 주문상세 배송 WebView, 프로필 편집, 푸시 설정/LinkTalk 안읽음은 유지되어 전체 미지원으로 과장하지 않는다.
- **직접 소속전환은 현재 구현:** 앱 `HomeScreen.tsx:323`의 HomeProfileHeader 활성 → `HomeProfileHeader.tsx:53-91`의 목록 표시/선택 → `useMillingAccountSwitch.ts:58-72` → `useEmployeeProfile.ts:57`의 소속 활성화가 연결된다. 웹의 비교 조건은 `lab/src/atoms/common.ts:38-43`에서 INTERNAL/SHARED + 유효 소속2개 이상이다. 앱 직접 UI 조건은 `employees.length >= 2`이며 유형 제한 helper를 쓰지 않으므로 앱·웹의 조건이 완전히 같다고 쓰지 않는다.
- **밀링/자재 현행화:** 앱 `RootNavigator.tsx:208-271`의 밀링·자재·생산 route는 현재 활성이다. SHARED/EXTERNAL은 밀링탭 기본 진입, INTERNAL은 일반 홈에서 밀링 주문 전환 구조다(`millingAccount.ts:48-54`). `MillingOrderListScreen.tsx:23,56-89`의 자재 일반탭은 비활성이나 `useNavigationConfig.ts:351`의 재고QR 상세 및 일부 생산·출고 경로는 구현되어 있다. 재고 상세 query는 SHARED 조건이다(`useMillingMaterialQueries.ts:30-36`). 설비·제품·옵션의 독립 목록 진입 부재와 구분한다.
- **웹 적용범위 확대:** 최신 `Header.tsx:257-258` → `SiteResourceMenus.tsx:22-53`은 INTERNAL에도 설비·자재 모바일 메뉴를 제공한다. 그래서 과거 `공유기공소 전용 목록·조회`를 `공유기공소 도입 관련 목록·조회`로 바로잡고 SHARED의 제품/옵션과 구분했다. 웹 준비 중인 정산·모바일에서 숨긴 등록 기능·데스크톱 전용 보드/Excel은 계속 제외한다.
- **경로 정정:** 로그인 비밀번호 찾기 버튼은 `lab/src/lib/AuthSigninForm/useSigninForm.tsx:64-66` → `AUTH_CHANGE_PASSWORD`(`/auth/change/password`)로 이동한다. 별도 `/auth/forgot/password` 파일 존재와 정상 진입 경로를 혼동하지 않도록 Notion을 정정했다.
- 배송은 생성 완료 이벤트·라벨 새 창이 있고 알림은 독립 URL이 아닌 Layout의 목록 UI이므로 둘 다 단순 링크 추가만으로 완료되는 저난도라고 가정하지 않는다. 최신 앱 일부 QR에는 과거 README의 WebView fallback이 그대로 유지되지 않으므로 옛 설명을 현행 지원 증거로 재사용하지 않는다.
- 아래 10/19~20 상세 코드 절은 당시 고정 SHA의 조사 이력이다. `홈 전환 비활성`, `밀링 route 주석`, `진행 릴리스에만 자재 구현`, `리소스 모두 SHARED 전용`은 이 최신 확인으로 대체한다. 10/25 다른 세션의 OTA 활성 관찰은 역사 기록이며 이번 조사에서 설치본↔정확한 SHA 대응·실기기 QA를 새로 확인한 것은 아니다.

## 이전 상태 — 2026-10-20 기공소 표 가독성·조건부 범위 정리 완료

- **후속 사실 정정:** 소속 전환은 일반 EXTERNAL 기공소의 웹 기능이 아니다. 현재 웹 `canSwitchLabAtom`은 활성 소속 유형이
  INTERNAL 또는 SHARED이고 유효 소속이 2개 이상일 때만 허용한다. 기존 표에서 이 조건을 누락했다.
  공유기공소 DL-16092 작업의 `d7c308f27`(9/6)에서 전환 상태·복구, `caf918b24`(9/7)에서 관련 UI가 추가됐다.
  이후 사용자 보완 요청으로 **Notion 요약·표에 반영하고 재조회 검증했다**. 일반 기공소 누락으로 집계하지 않는다.
- 사용자 요청으로 기공소 표만 다시 정리했다. 치과와 형식을 맞출 필요는 없으며, 핵심은 앱에서 안 되는 작업과 이미 가능한 범위를 한눈에 구분하는 것이다.
- 요약은 **일반 기공소 기능 8개 / 공유기공소 도입 시 추가된 기능 2개**로 구분했다.
  소속 전환은 INTERNAL·SHARED + 선택 가능한 소속 2개 이상, 전용 목록·조회는 SHARED 전용임을 명시했다.
  소속 전환 행을 직원 관리 표에서 마지막 조건부 표로 옮겨 일반 기능처럼 읽히지 않게 했다.
- 5개 표·총 10개 항목과 **기능 / 앱에서 안 되는 것 / 현재 가능한 범위·조건**의 3열은 유지했다.
  앞선 가독성 정리에서 현황·우선 순위·사용 빈도 열은 제거했다.
- `부분지원`이라는 포괄적 상태 대신 검색 조건·집계·직접 선택·관리 화면 등 빠진 작업을 구체적으로 적고, 가능한 기능은 옆 열에 배치했다.
  웹 위치·경로는 기능 셀에 보존했으며 배송 웹뷰, Owner·대표 프로필 담당자·SHARED 조건, 딥링크 및 진행 중 릴리스 예외도 유지했다.
- 소속 전환의 코드 조건·도입 이력을 직전 질문에서 재확인한 뒤, 이번 요청에서는 Notion 표현·분류만 보완했다.
  실기기 QA·제품 코드/브랜치/PR/배포 변경은 하지 않았다.
- 수정 직전 재조회 후 기공소 요약·직원 관리 표·마지막 조건부 표만 수정했다. 저장 후 전체 예상 본문 일치,
  치과/개요 불변·5개 표·총 10행/3열·일반 8개/조건부 2개 요약·조건 문구를 확인했다.
  이번 표 정리는 완료이며 추가 요청 전 대기한다.

## 이전 확인 — 2026-10-19 기공소 검토 완료·사용자 확인 후 대기

- 사용자 확인으로 기공소 표 정리·검토를 완료 처리했다. 이번 후속 작업에서는 클리닉 내용을 수정하지 않았다.
  추가 Notion 변경이나 제품 작업 없이 대기하며, 기공소에 관한 신규 지시가 있을 때만 재개한다.
- 사용자 최종 범위: **클리닉은 건드리지 않고 기공소만 검토·수정·보고한다.** 아래 클리닉 검토 메모는 과거 이력이며 활성 후속 작업이 아니다.
  후속 재조회에서 기공소 10개 항목과 기존 검토 내용의 일치, 웹 master·Lab 앱 main SHA 불변을 확인했다. 추가 Notion 수정은 필요 없었다.
- 사용자 본래 담당은 **기공소(Lab/Frankie)**이며 치과(Clinic/Office/Joy) 조사는 사전 확인이었다.
  클리닉 담당자의 작성 여부를 확인해 작성 내용이 있으면 보존하고, 기공소만 같은 양식으로 맞추라는 후속 요청을 처리했다.
- Notion에는 기존 Frankie 치과 12행 표가 접힌 영역에 남아 있고, 그 아래 담당자의 새 요약 및 5개 분야·32행·6열 표가 추가돼 있었다.
  담당자 작성 내용이 있으므로 치과 영역 전체와 개요를 그대로 보존했다. 치과 조사자가 편집했는지는 블록별 작성 이력까지 조회한 결과가 아니라
  사용자 설명과 기존 사전 표 이후 추가된 본문을 대조한 판단이다.
- 기공소 기존 10개 항목을 **주문·배송 / 기공소·직원 관리 / 계정·마이페이지 / 알림 / 공유기공소**의 5개 표로 정리했다.
  열은 동료와 같은 **기능 / 경로 (웹) / 현황 / 우선 순위 / 사용 빈도 / 비고**이며, 조사자 `Lab : Frankie`는 개요에 유지했다.
  우선 순위·사용 빈도는 근거·PM 결정이 없어 모두 `미정`으로 표기했다. 기존 지원 예외·Owner/SHARED 조건·main/릴리스 구분·실기기 미확인은 보존했고,
  소개 편집의 대표 프로필 담당자 조건을 보완했다.
- 수정 직전 재조회로 동시 편집 여부를 확인하고 기공소 절만 교체했다. 수정 후 개요·치과 영역의 문자열 동일성,
  기공소 5개 표·10행·모든 6열·동일 열 이름·미정 표기·지원 예외와 제안문 전체 일치를 재조회 검증했다.
- 세 저장소 `git ls-remote`로 아래 기존 master/main SHA가 그대로임을 확인하고, 두 독립 검토에서 관련 코드를 다시 대조했다.
  제품 코드·브랜치·PR·Jira·배포 변경 및 실기기 QA는 없다.

### 과거 클리닉 검토 메모 — 사용자 지시로 후속 범위에서 제외

- 리메이크 요청·목록은 모바일웹도 `RemakeMobileNotSupport`로 차단된다. 앱만의 누락으로 집계하지 않는다
  (`clinic/src/pages/remakes/index.tsx:100`, `[order_id]/info/index.tsx:286`, `[order_id]/additional/index.tsx:124`).
- 주문보드·조직 Dashboard는 모바일 기본 메뉴에서 숨긴다. URL 직접 접근 불가와는 다르지만 모바일웹 제공 기능으로 분류하려면 별도 진입 근거가 필요하다
  (`clinic/src/common/constants/menus.ts:43-46,130-134`, `HeaderHamburgerMenu.tsx:44-53,225-228`).
- 동료의 “앱 비밀번호 찾기 지원”과 “프로필 이미지 편집 지원” 문구는 Office main 기준 코드와 다르다.
  로그인은 이메일·암호·Sign In만 있고, Office 프로필 이미지에는 편집 콜백이 연결돼 있지 않다
  (`SigninScreen.tsx:48-132`, `AuthNavigator.tsx:4-17`, `AllScreens.ts:27-51`, `ProfileOfficeSection.tsx:28-33`, `ProfileScreen.tsx:78-94`).
- 픽업 요청 미지원은 독립 관리 화면 기준으로 한정해야 한다. 주문 작성 중 예약은 지원한다(`useUpdateOrderAdditional.ts:200-208,269-282`).
  새 클리닉 표에는 기존 사전 표의 알림 이력함·Promotional SMS가 없으므로 사전 표를 임의 삭제하지 않았다.
- 우선 순위·사용 빈도는 코드만으로 검증할 수 없다. 클리닉 표 후속 수정은 담당자의 기준 확인 또는 사용자 별도 지시 시 진행한다.

## 사전 조사 이력 — 2026-10-19 코드 조사 완료

사용자 요청은 모바일웹에 있지만 앱에 없는 기능을 **치과 앱·기공소 앱 각각 앱 관점에서 조사**하는 것이다.
제품 코드·브랜치·PR·Jira·배포·서버 데이터는 변경하지 않았다. 정적 소스/메뉴/화면/요청 연결 대조를 완료했으며
실계정·실기기 QA 또는 현재 설치된 OTA의 기능을 검증한 결과는 아니다.

- 최초 사용자 요청으로 [모바일 웹 대비 앱 미지원 기능 현황](https://app.notion.com/p/innovaid/3fece072e82f80d5a02fda9a76cd51b7)의 기존 표를 채웠으며, 당시 재검토 보완 후 치과 12개·기공소 10개 항목이었다.
  기능·웹 경로·앱 현황을 채우고 확인자 열은 모두 `Frankie`로 표시했다. 우선순위·사용 빈도는 미산정으로 비워두었다.
  코드 조사/실기기 미확인과 부분지원 예외를 표 안에 명시했으며, 표 밖의 기존 내용과 5열 구성을 보존했음을 재조회로 확인했다.
- 사용자의 가독성 개선 요청으로 Notion의 앱 현황 칸만 굵은 지원 상태와 줄별 진입 부재·지원 예외·조건으로 정리했다.
  치과12/기공소10 항목·판정·웹 경로·권한/배포/실기기 조건·Frankie 표기·빈 우선순위·표 밖 내용은 보존했다.
- 사용자의 추가 재검토 요청으로 기존 19항목을 담당을 교차해 다시 읽고 웹 master·양 앱 main의 원격 SHA가 조사 기준과 같음을 확인했다.
  기존 분류는 유지하되, 양쪽의 받은 초대 수락·소속 가입 2항목과 SHARED 전용 목록·조회 1항목을 보완했다.
  SHARED 정산은 실제 기능이 아닌 준비 중 화면이며 모바일에서 숨긴 등록/재고조정 버튼도 누락 비교에서 제외한다.
  이는 정적 코드 교차검토이며 설치 앱/OTA·계정별 실제 동작 검증으로 확대하지 않는다.

### 비교 기준

fetch 후 고정한 소스를 조사용 임시 사본에서 읽었다. 기존 제품 checkout 및 활성 작업은 유지했다.
웹의 데스크톱 기능 전체와 비교하지 않고 모바일 노출·반응형 조건·모바일 브라우저 차단 여부를 확인했다.

| 제품 | 기준 | 정확한 SHA |
| --- | --- | --- |
| Clinic/Lab 모바일웹 | origin/master | 8772d68825cac6e23792d86a715153a67dc71078 |
| Office 앱 | origin/main | 62e5864dca89e8218a45eaa9ce83f414082747a9 |
| Lab 앱 | origin/main | bb619010b25419b724a5f6acded6f5760bb9af15 |

- Office release/v2.2.4(cdfdb904)와 develop은 위 main과 `src` 차이가 없다.
- 진행 중 Office feature/DL-16317(13b28d680)은 권한·예외 복구 변경이며 아래 관리 화면을 추가한 것은 아니다.
- Lab develop(56cba674)은 main과 `src` 차이가 없다. release/v1.0.5(a32acb02)는 자재 관리 등 64개 소스 파일 변경이 있어 별도 구분했다.
- 웹 release/v1.89.0(162422ab9)은 별도 진행 버전이다. 권한·청구 명칭·밀링 메뉴 확대 등을 main에 이미 배포된 기능으로 취급하지 않았다.
- 위 SHA는 조사 시점의 고정 기준이다. 개발 브랜치·현재 설치 앱·환경별 웹 배포는 서로 같다고 가정하지 않는다.

### 핵심 결과

| 대상 | 모바일웹 대비 앱에서 빠지거나 제한된 사용자 흐름 |
| --- | --- |
| 양쪽 공통 | 알림 이력함의 조회·읽음·삭제, 신규 가입·비밀번호 찾기/변경·회원탈퇴, 받은 초대 수락·소속 가입의 앱 내 진입 |
| 치과 | 청구서·결제 내역·미납 결제 관리; Pickup 전용 목록/예약 관리; 치과·구성원·청구 담당자·가격표·Scanner Setup 페이지; 개인 프로필 편집·Promotional SMS 동의; 크레딧 이력/자동사용 설정·추천 관리; 신규 치과 소속 신청/연결 |
| 기공소 | 전체 배송목록·배송 라벨 생성; 직원 초대/관리; 주문목록 카테고리·치과명·날짜 조건; 긴급/지연 주문 집계·모아보기. 별도 조건부 범위: INTERNAL·SHARED + 유효 소속 2개 이상의 직접 선택 진입(앱 UI 비활성), SHARED 전용 설비·제품/옵션·자재 목록/조회. 두 조건부 항목은 공유기공소 도입 범위이며 일반 EXTERNAL의 공통 기능이 아님. |

이 목록은 모든 항목을 버그 또는 추가 개발 확정 요구사항으로 선언하는 것이 아니다. 주로 **앱의 정상 메뉴·화면 진입 부재**이며,
앱 내 임의 채팅/CMS 링크를 통한 우회까지 불가능하다는 뜻은 아니다. 권한에 따른 웹 기능은 같은 권한의 사용자를 기준으로 비교한다.

### 누락으로 세지 않은 것

- 주문·환자 목록/상세, LinkTalk·지원 채팅, Help Center, 파일 다운로드/미리보기, 디자인 승인은 네이티브 또는 WebView/브리지 경로가 있다.
- 치과 앱의 피드백, Case Preference, 결제수단 관리·카드 등록, 주문 작성 과정의 픽업 예약·크레딧 적용, 기존 치과 전환도 제공된다.
- 기공소의 주문별 배송 조회와 프로필 이미지/표시명/전화번호/소개 편집은 제공된다. 전체 배송 관리나 직원 관리와 구분한다.
- Remake 및 전체 웹 주문작성 폼은 모바일웹 자체에도 제한이 있다. 이를 앱만의 누락으로 분류하지 않는다.
- Clinic Order Board/Organization Dashboard, Lab 주문목록 Excel 및 일반 Lab의 데스크톱 메뉴만 있는 정산/보드 등은 핵심 비교에서 제외했다.
- Lab의 PaymentMethodScreen은 등록돼 있지만 실제 Forbidden 처리된다. 파일 존재를 지원 증거로 사용하지 않았고,
  일반 Lab 모바일웹 대응 기능도 확인되지 않아 누락 항목으로 추가하지 않았다.

### WebView 대조 근거

- [파일 다운로드 브리지](https://github.com/Innvoaid/dentlink-client/blob/8772d68825cac6e23792d86a715153a67dc71078/clinic/src/common/hooks/useFileMultipleDownload.tsx#L21),
  [Office 수신 처리](https://github.com/Innvoaid/dentlink-app/blob/62e5864dca89e8218a45eaa9ce83f414082747a9/src/features/common/components/DentlinkWebView.tsx#L691).
- [Office 결제수단 WebView](https://github.com/Innvoaid/dentlink-app/blob/62e5864dca89e8218a45eaa9ce83f414082747a9/src/features/common/screens/PaymentMethodScreen.tsx#L205),
  [피드백 네이티브 이동](https://github.com/Innvoaid/dentlink-client/blob/8772d68825cac6e23792d86a715153a67dc71078/clinic/src/pages/orders/%5Border_id%5D/index.tsx#L178).
- 정상 주문상세·결제수단 WebView는 웹 전역 헤더를 숨기고 Help는 nonLayout을 사용한다.
  따라서 이들 화면이 빠진 관리 메뉴를 자동으로 제공한다는 근거는 없다.
- 창 열기·외부 링크의 WebView 처리는 존재하므로 외부 링크 전체 차단으로 설명하지 않는다.

## 근거를 읽는 방법

아래 각 파일 경로·줄 번호는 위 고정 SHA의 소스 기준이다. 실제 구현 중인 로컬 checkout의 줄 번호와 다를 수 있다.
치과 절의 `web`은 dentlink-client, `office`는 dentlink-app이다. 기공소 절의 웹은 dentlink-client,
앱은 별도 dentlink-lab-app이다. 생성 API 선언·화면 등록만으로 기능이 있다고 판정하지 않고 실제 호출·진입을 확인했다.

## 치과 앱 상세


| 영역 | 모바일웹 근거 | Office 앱 상태 및 근거 |
|---|---|---|
| 알림 이력함 | web `clinic/src/components/Layout/Header.tsx:98-105` 종 버튼; `shared/ui/src/NotificationUI/NotificationUI.tsx:272-320` 모바일 포털; `clinic/src/components/Notifications/useNotificationsPagination.tsx:33-61,88-123` 목록/필터/삭제/모두읽음 | 전용 화면·진입 없음. office `src/navigations/AllScreens.ts:27-51` 전체 등록화면에 알림함 없음. `ProfileNotificationSection.tsx:77-120,246-320`은 푸시 설정만이며 이력함이 아님. OS 푸시 자체는 제공. |
| Billing Statements·Payment History·미납 결제 관리 | web `clinic/src/common/constants/menus.ts:74-97`, `HeaderHamburgerMenu.tsx:44-53` OWNER/PAYMENT_MANAGER 모바일 Billing. `clinic/src/pages/billing/statement/index.tsx:45-47` 모바일 다운로드, `billing/payment-history/index.tsx:184-201` 모바일 내역·선택·PayNow | 앱 기본 진입 없음. AllScreens:27-51에는 PaymentMethod/Eximbay/BillingPolicy만. `src/features/common/components/EmployeeSelectBottomSheet.tsx:60-87`에도 Payment Method만. **결제수단 자체는 앱 제공:** `PaymentMethodScreen.tsx:93-96` `/billing/payment-method` WebView. |
| Pickup 전용 관리(오늘·예정·과거 목록, 별도 예약/재예약·확정) | web `menus.ts:48-55`, `clinic/src/pages/pickup/index.tsx:30-177`, `shared/ui/src/PickupUI/PickupUI.tsx:87-111` | 전용 목록·관리 화면 진입 없음(AllScreens:27-51). **주문 작성 과정의 PVS/픽업 예약은 있음:** `src/libs/useUpdateOrderAdditional.ts:200-208,270-281`, `src/services/office.service.ts:220-242`. 픽업 전체 불가로 표현 금지. |
| Office 운영관리(구성원 목록·상세, 치과정보 수정, 청구 담당자, Office dashboard·scanner 계약정보) | web `menus.ts:100-128`; `clinic/src/pages/office/managed/index.tsx:123-219` 모바일 탭/목록; `clinic/src/components/OfficeMemberList/OfficeMemberMobileList.tsx:39-75` 상세; `OfficeManaged/OfficeManagedEmployerInfo.tsx:60-63,92-102` OWNER 수정 | 앱 기본 진입 없음. `EmployeeSelectBottomSheet.tsx:54-87` 기존 소속 전환·결제수단만. 앱 치과 전환은 제공. 구성원 초대/권한 수정의 세부 모바일 허용 여부까지 일괄 확정하지 않음. |
| Fee Schedule / Scanner Setup | web `menus.ts:110-118` 모바일 메뉴에 hide 플래그 없음; `clinic/src/pages/office/pricing/index.tsx:39-63`, `office/scanners/index.tsx:34-69` | 앱 기본 진입 없음(AllScreens/profile/치과선택). 스캐너 draft 주문 수신과 스캐너 연결 설정은 별개. |
| 개인 프로필 편집·계정 삭제·암호 변경 | web `clinic/src/pages/my/index.tsx:138-158` 사진 편집, `clinic/src/components/My/MyProfileSection.tsx:33-44` 전화번호 수정, `clinic/src/pages/my/SettingButton.tsx:10-17,36-59` Reset Password/Delete Account | 앱 편집 UI 없음. `src/features/profile/sections/ProfileOfficeSection.tsx:26-43` 읽기 표시, :45-66 설정·알림·링크·로그아웃. `src/features/profile/screens/ProfileScreen.tsx:78-94` 이동 콜백에도 없음. |
| Promotional SMS 동의 | web `clinic/src/components/My/UserSetting.tsx:167-192` 모바일 스위치 | 앱 없음. ProfileNotificationSection:77-120의 푸시 설정과 SMS 동의는 별개. |
| User/Office Credits 이력·User Credit 자동사용 설정 | web `HeaderProfilePopupMenu.tsx:44-87`; `clinic/src/pages/credit/index.tsx:107-118,140-151` 모바일 자동사용·내역; `OfficeManagedEmployerInfo.tsx:115-131` Office Credits 진입 | 관리 페이지 진입 없음/일부 제공. 앱 `src/features/order/steps/step4OrderDetailsAndSubmit/OrderSummarySection.tsx:79-106,210-248,272-302`에 주문별 크레딧 적용과 Office 자동적용 존재. credit 사용 전체 누락 아님. |
| Referrals 추천 초대·내역 | web `HeaderProfilePopupMenu.tsx:76-93`, `clinic/src/pages/my/referrals/index.tsx:54-81` mobile layout·초대 | 앱 기본 진입 없음. `ProfileQuickLinksSection.tsx:32-44` Pending Reviews/Help Center만. |
| My Office 신규 소속 찾기·가입 신청·신청 취소/연결 관리 | web `MyQuickLinks.tsx:58-64`, `clinic/src/components/My/MyOffice.tsx:47-65,80-98` office/find·신청취소·추가 | 앱 기본 진입 없음. `EmployeeProfile.tsx:119-129`, `EmployeeSelectBottomSheet.tsx:54-87`은 이미 소속된 치과 전환. 새 치과 가입/연결과 기존 소속 전환을 구분. |
| 신규 회원가입·로그인 전 비밀번호 찾기 | web `clinic/src/pages/auth/signin.tsx:15-33`, `clinic/src/lib/AuthSigninForm/useSigninForm.tsx:33-60` 가입·암호찾기 이동. signup에는 모바일 flow 있음(root 교차확인) | 앱 로그인에 없음. `src/features/auth/screens/SigninScreen.tsx:31-134` 이메일/암호/Sign In만, signup/forgot/reset 등록화면·외부 이동 버튼 없음. 초대수락·치과등록까지 앱내 온보딩이 있다고 볼 근거 없음. |

## 누락에서 제외 / 반증

- 홈 Action Required/주문 추적, 주문 생성·ISV, 주문/환자목록·상세, LinkTalk, 피드백, Case Preference, Design Approval, Help Center는 앱 제공.
- 앱 주문상세 `src/features/orderList/screens/OrderDetailScreen.tsx:46-49`는 `/orders/:id` WebView. 네이티브 코드 부재만으로 웹 공유 기능을 누락으로 세지 않음.
- 주문 검색(환자명/주문번호), 상태·담당의사·주문일 필터, My Orders Only는 앱 `OrderSearchForm.tsx:203-265`, `OrderFilterBottomSheet.tsx:132-146`, `OrderListTabScreen.tsx:107-127`에 존재. 웹 `clinic/src/pages/orders/index.tsx:56-82` 및 `shared/ui/src/OrderListUI/OrderListLayer/OrderListLayerMobile.tsx:88-139`와 대조: 명확한 필터 누락 발견되지 않음.
- 환자명 검색·My Patients Only·최근 주문 상세이동은 양쪽 존재(web `clinic/src/pages/patients/index.tsx:48-71`, app `OrderPatientTabScreen.tsx:60-64`, `OrderPatientListItem.tsx:63-69`). case status/recent case/dentist/total case/order 필드도 양쪽 제공.
- Order Board/Organization Dashboard는 web menus.ts:42-46,130-134에서 모바일 숨김: 누락 제외. Office Overview 내 owner dashboard는 별도 모바일 지원.
- 모바일 주문 목록에는 desktop export·일괄 행액션이 없어 앱 누락으로 추가하지 않음.
- Remake는 모바일웹도 RemakeMobileNotSupport로 차단(index100/additional124/info286), 일반 웹 주문작성도 `clinic/src/components/Order/OrderForm.tsx:129-132` isMobile 차단. 앱만 누락으로 세지 않음(guard agent 교차확인).
- 파일 다운로드·미리보기·디자인승인은 native bridge/viewer가 있어 전체 누락 아님. 실제 OS 동작 QA는 미실행.

## 앱 기본 진입 부재와 완전 차단은 구분

- 주문상세 web `clinic/src/pages/orders/[order_id]/index.tsx:485` headerShown !isDentlinkApp, PaymentMethod web `billing/payment-method/index.tsx:245` 동일.
- Help `clinic/src/components/Help/HelpCenter.tsx:59` Layout nonLayout, Layout.tsx:65-66 children만; HelpCenterLayout.tsx:19 앱 헤더 감춤. 기본 Help에서 전역메뉴 우회는 없음(guard agent 교차확인).
- CasePreference는 native screen(`src/features/casePreference/screens/CasePreferenceScreen.tsx:1-25,158+`)이므로 웹 공통헤더 진입이 아님.
- 단 임의 CMS Help article/배너/채팅 링크까지 수집하지 않았으므로 ‘어떤 방법으로도 앱에서 불가’는 과장. 기본 앱 메뉴/화면 진입 없음으로 표현.

## release/진행 branch 보조 점검

- origin/release/v2.2.4 `cdfdb90457985e19738400a5125519eb77f46783`.
- origin/feature/DL-16317 `13b28d680d4003f20a4dc1bfdcd9bf2ad67eaef3`.
- `git diff origin/main origin/release/v2.2.4 -- src`: 차이 없음.
- permission feature vs main의 navigation/profile/EmployeeSelectBottomSheet에 새 관리화면 차이 없음. 주문/환자 권한·필터 조건 차이는 있으나 위 관리메뉴를 추가한 것은 아님. feature를 main의 단순 상위 버전으로 취급하지 않음.
- 배포/QA 완료 판단은 별개.

## 기공소 앱 상세


### 1. 전체 배송 관리 및 배송 라벨 생성 — 앱 정상 진입 없음

- 모바일웹 하단 Shipping 메뉴: `lab/src/components/Layout/NavigationMobile.tsx:111-122`.
- 실제 배송목록·필터·등록: `lab/src/pages/shipping/index.tsx:103-168`.
- Create Label 버튼은 DataGrid의 데스크톱 전용 영역이 아니라 직접 렌더링됩니다(`shipping/index.tsx:107-110`, `shared/ui/src/ShippingPickupUI/ShippingRegisterUI/ShippingRegisterUI.tsx:198-230`).
- 배송 상세, 배송에 연결된 픽업 상세도 웹에서 이동 가능합니다: `lab/src/lib/Shipment/useShippingList.tsx:65-82,149-167`.
- 앱은 Home / Orders / LinkTalk / Profile만 주요 탭이며 배송목록/등록 route가 없습니다: `src/navigations/BottomTabNavigator.tsx`, `src/configs/types/navigation.ts:15-112`, `src/navigations/RootNavigator.tsx:180-282`, `src/configs/constants/deepLink.ts:19-139`.
- 단, **주문별 배송 조회는 앱 주문 상세 WebView로 제공**됩니다. 앱 `src/features/orderList/screens/OrderDetailScreen.tsx:39-43,165-199`; 웹 주문 상세 `lab/src/pages/orders/[order_id]/index.tsx:424`에서 앱이면 전역 헤더 숨김. 주문 상세에서 /shipping으로 직접 이동하는 코드도 미발견입니다.
- 표현: “배송 기능 전체가 없다”가 아니라 “전체 배송목록·라벨 생성 등 배송 관리 진입이 없다”.

### 2. 알림 이력함 — 앱 미제공

- 모바일웹 하단 Notifications: `lab/src/components/Layout/NavigationMobile.tsx:153-157`.
- 알림 리스트·종류 필터: `lab/src/components/Notifications/useNotificationsPagination.tsx:24-63,78-82`.
- 삭제·모두 읽음·부분 읽음·알림 대상 이동: 같은 파일 `85-143`.
- 앱은 관련 화면/route가 없으며 models를 제외한 실제 코드에 findNotifications / markAllNotificationsAsRead / notification history 호출도 없습니다.
- **푸시 수신·설정과 LinkTalk 안읽음 기능은 있습니다.** 앱 `src/features/profile/sections/ProfileNotificationSection.tsx:72-102`, `src/configs/utils/fcmHandler.ts`. 이를 알림 이력함과 혼동하지 않아야 합니다.

### 3. 직원 초대·직원 관리 — 앱 정상 진입 없음

- 모바일웹 Header는 AccountMenu를 모바일에서도 렌더링: `lab/src/components/Layout/Header.tsx:122-145`.
- Owner 계정 초대/관리 메뉴: `lab/src/components/Layout/AccountMenu.tsx:204-228`.
- 목록·역할/권한·퇴사 등 관리: `lab/src/pages/members/index.tsx:27-38,70-98`; 초대 목록/폼 `lab/src/pages/members/invites/index.tsx:60-73`.
- 앱 Profile은 개인 정보·알림 설정·로그아웃으로 구성: `src/features/profile/screens/ProfileScreen.tsx:94-118`, `src/features/profile/sections/ProfileLabSection.tsx:216-309`.
- 앱 route/types/deepLink 전체에 members/invites 화면 또는 웹 이동이 없습니다.
- 계정 권한에 따른 조건부 웹 기능이며 모든 직원에게 항상 노출되는 기능은 아닙니다.

### 4. 회원가입·비밀번호 찾기 — 앱 로그인 화면에 진입 없음

- 웹 Lab 로그인: `lab/src/pages/auth/signin.tsx:26-32`; 실제 Lab 전용 Create Account / Forgot Password 링크 `shared/ui/src/AuthUI/Signin/SigninForm.tsx:122-148`.
- 가입은 기공소 소장 확인 팝업 이후 가입 경로, 비밀번호 찾기 이동은 `lab/src/lib/AuthSigninForm/useSigninForm.tsx:34-66`.
- 앱 로그인은 이메일·비밀번호·Sign In뿐: `src/features/auth/screens/SigninScreen.tsx:48-133`.
- RootStack와 AuthNavigator에 signup/forgot/change password 화면 및 외부 웹 연결이 없습니다.
- 앱 내에서 해당 절차를 시작할 수 없다는 의미이며 사용자가 별도 브라우저에서 웹을 열어 수행하는 것은 가능합니다.

### 5. 로그인 후 비밀번호 변경·회원탈퇴 — 앱 Profile에 진입 없음

- 웹 My Profile Security 영역: `lab/src/pages/my/index.tsx:163-206`.
- 앱 개인 프로필 편집은 displayName, telephoneNumber, 소개, 이미지 변경으로 한정: `src/features/profile/screens/ProfileLabEditScreen.tsx:54-90,184-217`.
- 앱 Footer는 앱 버전·Sign Out 및 개발/스테이징 간편 로그인뿐: `src/features/profile/sections/ProfileFooterSection.tsx:63-99`.
- 비밀번호 변경 및 계정 삭제의 화면/route/web 링크는 미발견입니다. 프로필 편집 기능 전체가 없는 것은 아닙니다.

### 6. 주문목록의 상세 검색·날짜 조건 — 앱 일부 제한

- 모바일웹 주문목록은 `DataGrid.Filters`를 숨김 없이 렌더링: `lab/src/pages/orders/index.tsx:67-78`.
- 웹 추가 검색조건: categoryIds(카테고리), officeName(치과명), 주문일·출고예정일·취소일 범위: `lab/src/lib/OrderList/useOrderList.tsx:568-629`.
- 모바일 필터/날짜 토글 실제 렌더: `shared/ui/src/DataGrid/DataGridFilters/DataGridFilters.tsx:195-285`; 기본 display:flex `303`.
- 앱 실제 주문목록 요청은 orderStatuses, inProgressDetailStatuses, patientName, orderId만 전달: `src/features/orderList/tabs/OrderListTabScreen.tsx:88-109`.
- 앱 필터 UI 파일 안에 Date/Dentist 관련 잔여 코드가 있어도 실제 Lab 목록 요청에 해당 조건이 전달되지 않으므로 웹과 동등 지원으로 간주할 수 없습니다.
- 앱 `release/v1.0.5`의 필터 차이는 화면 높이/스크롤 보완이며 위 검색조건 추가는 없습니다.
- 환자명/주문번호/주문상태 필터는 있으므로 “검색·필터 미지원”이 아니라 누락 조건을 특정해야 합니다.

### 7. 긴급 주문·지연 주문의 집계 및 모아보기 — 앱 일부 제한

- 모바일웹 홈은 Order Issues 영역 렌더: `lab/src/components/Dashboard/Dashboard.tsx:92-109`.
- 긴급·지연 건수 및 각각 progressEndAt / delayBaseAt 필터 연결: `lab/src/lib/Dashboard/useDashboardIssueCount.tsx:17-49`.
- 앱 Home Action Required는 In Review 및 Ready for Fabrication만: `src/features/home/sections/HomeLabActionRequiredSection.tsx:64-76`.
- 앱 홈 조회는 전체 주문/NEW/READY_FOR_FABRICATION: `src/libs/useHomeOrdersData.ts:26-73`.
- 비생성 코드에 urgentCount/delayCount/progressEndAt/delayBaseAt를 이용한 조회/집계가 없습니다.
- 개별 주문 Delayed 상태 배지 코드는 있습니다(`src/features/orderList/components/OrderStatusBadge.tsx:17-48`). 따라서 지연 표시 자체가 없다는 뜻은 아닙니다.

### 8. INTERNAL·SHARED의 복수 소속 전환 — 조건부 웹 기능, 앱 직접 진입 비활성

- 웹 전환 허용 조건은 `lab/src/atoms/common.ts:34-40`의 **INTERNAL 또는 SHARED + 유효 소속 2개 이상**이다.
  일반 EXTERNAL은 제외된다. 패널을 열 수 있다는 사실만으로 전환이 제공된다고 판단하면 안 된다.
- 모바일웹 햄버거 메뉴 Profile: `lab/src/components/Layout/Header.tsx:247-255`; Profile 버튼이 패널을 엶: `lab/src/components/Layout/Profile.tsx:40-65`.
  `LabSwitchModal.tsx:54,142,235`도 위 조건으로 소속 조회·전환 실행·목록 렌더링을 제한한다.
- 앱 현재 Home은 EmployeeProfile만 실제 렌더: `src/features/home/screens/HomeScreen.tsx:333-342`.
- EmployeeProfile에는 전환 BottomSheet/handler가 있지만 실제 프로필 영역은 View이고 BottomSheet.present를 호출하는 버튼이 없습니다: `src/features/common/components/EmployeeProfile.tsx:121-168`.
- 새 HomeProfileHeader 및 밀링 경로는 `10/26 배포일에 해제` 주석으로 비활성: `HomeScreen.tsx:336-342`, `src/navigations/RootNavigator.tsx:183-203`.
- 딥링크는 employerId 전환 처리를 가지므로 “소속 전환 기능 완전 미구현”이 아닙니다. **직접 선택 UI 진입 비활성**으로 분류합니다.
- Lab release/v1.0.5도 HomeScreen/EmployeeProfile의 이 부분은 main과 같습니다. 새 Header의 재료QR 추가만 있으며 정상 홈의 전환 진입 활성화 증거는 없습니다.

## 누락으로 세면 안 되는 항목

- 주문 목록/상세: 앱 목록 네이티브 + 상세 WebView 제공. 상세에서 파일, 메모, 주문 상태 관련 기능은 shared web 화면을 사용하므로 개별 차단 근거 없이는 누락으로 적지 않습니다.
- 환자 목록 및 환자별 주문 이동: 앱 `src/features/orderList/screens/OrderListScreen.tsx:91-114`, `tabs/OrderPatientTabScreen.tsx:43-59,146-153`, `components/OrderPatientListItem.tsx`에 구현되어 있습니다.
- 채팅/LinkTalk, Dentlink Support, Help Center: 네이티브 또는 WebView 경로 제공. Support → HelpCenter 연결(`features/common/components/DentlinkSupportBanner.tsx`)도 있습니다.
- 프로필 이미지·표시명·전화번호·소개 수정, 알림 수신 설정: 네이티브 제공.
- 주문목록 Excel 내보내기: 웹 `InvoiceExcel`는 `DataGrid.FunctionTab` customButtons이고 right-section이 모바일에서 display:none. `shared/ui/src/DataGrid/DataGridFunctionTab/DataGridFunctionTab.tsx:172-175`. **모바일웹 전용 격차에서 제외**.
- 일반 Lab 주문보드·정산 전체메뉴·독립 픽업 스케줄 메뉴: 코드가 있지만 데스크톱 Aside에서만 노출됩니다(`Aside.tsx:80-99`, `Menus.tsx:124-163`). 일반 모바일웹 기본 메뉴에 없으므로 이번 핵심 확정 목록에서 제외합니다. 단 배송목록에 연결된 픽업 상세는 모바일에서도 접근 코드가 있습니다.
- 리메이크: Lab 모바일웹도 isMobile일 때 RemakeMobileNotSupport로 차단하므로 앱만의 누락이 아닙니다(guards 담당과 교차검증).
- 결제 수단: 앱 PaymentMethodScreen는 route만 있고 canManagePaymentMethod=false로 막지만, 일반 Lab 모바일웹에서 대응하는 정상 메뉴 진입을 확인하지 못했으므로 누락 목록에서 제외합니다.
- 인쇄/Excel/고정 폭 표처럼 데스크톱 전용 컨트롤을 모바일웹 기능으로 포함하지 않습니다.

## 받은 초대 수락·소속 가입 — 양쪽 앱의 추가 누락

- 신규 회원가입, 기존 소속 직접 전환, 직원 초대 발신/관리는 수신자의 초대 수락과 구분한다. 기존 계정도 해당 흐름을 사용할 수 있다.
- 치과 웹 `clinic/src/components/OfficeInvitation/OfficeInvitationPage.tsx:121-129,172-179`에 Join Office와 모바일 레이아웃이 있고,
  `clinic/src/lib/OfficeInvitation/useOfficeInvitation.tsx:122-132,402-432`에서 로그인 후 복귀·실제 수락을 처리한다.
- 기공소 웹 `lab/src/pages/invitations/index.tsx:88-100,135-140`과 `lab/src/lib/LabInvitation/useLabInvitation.ts:111-146`에
  모바일 수락 화면·로그인 후 복귀·수락 API·소속 활성화가 연결돼 있다.
- 양쪽 앱 비생성 소스에는 초대 수락 화면·API 호출·전용 딥링크가 없다. `src/configs/utils/dentlinkWebURL.ts:48-58,258-268`의
  지원 경로에 `/invitations`가 없어 원본 웹 URL을 유지하며 채팅 링크는 OS의 링크 열기로 전달한다.
  따라서 앱 내 수락은 미지원이고 모바일웹으로 처리한다. 초대 링크 자체가 열리지 않거나 가입이 절대 불가능하다는 뜻은 아니다.

## 밀링/공유기공소 계정 및 진행중 release 차이 — 조건부 범위

- 웹 SHARED 계정은 `/mc` 공유기공소 관리 메뉴를 모바일 햄버거에서도 렌더합니다: `lab/src/components/Layout/SharedLabAside.tsx:44-104,194-219`.
- 설비, 제품·옵션, 자재목록/입출고 내역/재고의 본문 목록·조회가 존재합니다. 외부기공소는 `/milling` 흐름이며 일반Lab과 다른 계정 범위입니다.
- **재검토 정정:** 정산은 메뉴만 있고 `lab/src/pages/mc/settlements/index.tsx:3-4`가 빈 Layout을 반환해
  `MillingCenterLayout.tsx:87-93`의 준비 중 화면을 표시합니다. 실제 정산 기능 차이에 넣지 않습니다.
  같은 Layout `118-134`의 상단 headerAction은 모바일에서 숨겨지므로 등록·재고조정·이동까지 모바일 지원으로 확대하지 않습니다.
- SHARED의 설비·제품/옵션·자재 목록/조회는 앱 main에 정상 진입이 없어 Notion에는 별도 조건부 항목으로 추가했습니다.
  실제 목록·query 연결은 EquipmentList/ProductList/OptionList/MaterialList/InboundList/OutboundList/StockManagement에서 확인했습니다.
- 앱 main에는 MillingOrderList/Detail 화면 자체가 있으나 RootNavigator의 등록과 Home 진입이 10/26 주석으로 꺼져 있습니다. 미구현이라고 단정하면 안 됩니다.
- 앱 `release/v1.0.5`에는 MillingMaterialForm/Entry/Stock/Detail/QrScan 5개 화면 및 query/service가 추가됐습니다. RootNavigator에 위 5개는 등록돼 있지만 기존 밀링 주문 진입 블록은 여전히 주석입니다. 구현 존재·정상 진입·배포를 분리해야 합니다.
- 웹 `release/v1.89.0`에는 INTERNAL 계정의 모바일 햄버거 `SiteResourceMenus`가 추가되어 설비·자재 메뉴 진입이 확대됩니다(`Header.tsx` diff 신규 3줄, 신규 SiteResourceMenus.tsx의 labType INTERNAL 조건).
- 같은 웹 release에는 SHARED 생산/공정/생산품/검사/공급사 메뉴도 추가됩니다. 앱의 일부 자재구현과 전체를 단순 1:1 비교하거나 이번 일반 Lab 미지원 목록에 합산하지 않습니다.
- 두 release 모두 저장소 구현상 비교일 뿐, 실사용자에게 활성화/배포됐다는 증거로 사용하지 않습니다.

## 확인 한계 / 다음 단계

- UI 코드의 정상 메뉴·route·query 연결 기준으로 비교했습니다. 로그인된 실기기에서 버튼 활성 상태, 서버 권한, 특정 알림/배너 링크, 모든 파일 유형 및 OS별 동작을 검증하지 않았습니다.
- 서버가 보내는 임의 배너/Help 문서의 링크를 따라 우회 접근이 가능할 수 있지만 이를 정상 제공 기능으로 계산하지 않았습니다.
- 구현 착수 또는 API 쓰기, 테스트 실행, 브랜치/PR 변경은 하지 않았습니다.

## 다음 시작점

- DL-17012 기공소 우선순위·이유·단일 표·순서 번호와 사용자 최종본 확인까지 완료하고 명시 대기 중이다. 추가 필수 수정은 없으며 다음 요청 전 자동 작업을 하지 않는다. 재개 시 최신 Notion의 사용자 변경과 회색 표시 의미부터 확인한다.
- 이후 구현을 요청받으면 회색 3개와 일반 검토 8개를 구분하여 요청된 범위의 정확한 제품 저장소·최신 코드·화면/API를 확인한다. P1/P2/P3나 표의 존재만으로 구현을 자동 승인한 것으로 보지 않는다. 클리닉은 담당·후속 구현 범위가 아니며 타 담당자의 작성 내용을 보존한다.
- 단순 우선순위 작성은 Jira 완료 처리·개발 착수·제품 코드/브랜치/PR/배포·QA의 승인이 아니다. 추가 요청 전 자동 실행하지 않는다.
- 특정 항목의 실제 앱 제공 여부를 확정해야 할 때는 동일 계정·권한·서버 환경으로 모바일웹과
  iOS/Android 설치 앱을 대조하고 바이너리·OTA 버전을 기록한다. 이는 이번 정적 조사와 별도 단계다.
- 밀링/공유기공소는 상단 2026-10-26 현행화 결과부터 읽는다. 과거 비활성 설명을 그대로 복원하지 않는다.
