# Dentlink 통합알림센터 — 사전 검토 체크포인트

최종 갱신: 2026-10-26 — 기획·디자인·알림 현황표·Jira·Slack·선행 권한 작업·웹/Office/Lab 코드·DEV Swagger 사전 대조 완료. 자료 간 충돌과 API 확인 사항 정리, 제품 구현 미착수.

## 최신 사전 준비 체크포인트 — 2026-10-26

### 요청·목적·완료 경계

- 사용자는 기획·디자인·BE가 아직 완성되지 않았으므로 **실제 구현 전에 얻을 수 있는 정보와 부족한 정보를 지금 최대한 확인**하도록 요청했다. 앞서 ‘실제 착수 전에 문의’라고 남긴 다음 단계는 이번 사전 조사로 당겨 수행했다. 구현 승인으로 확대하지 않는다.
- 목적은 **사용자가 자기 소속·권한에 맞는 알림을 웹·앱에서 다시 확인하고, 알림 종류와 전달 채널별 수신을 조절하며, 클릭 시 올바른 소속·업무 화면으로 이동하도록 만드는 것**이다. 알림 목록, 수신 설정, OS 권한 안내, 읽음·미읽음 표시, 공통 딥링크, 권한별 수신 범위를 함께 준비한다.
- 사용자 제공 5개 링크와 연결된 권한 PRD·Google Sheet·BE 첨부를 읽고, 메인세션 답변·보관된 권한 세션·기존 개인 정본·현재 FE 코드·DEV Swagger를 대조했다. 제품 코드/branch/worktree/PR/배포 변경, 서버 실행, 테스트·실기기 QA는 하지 않았다. 외부 Figma/FigJam/Notion/Jira/Slack/Sheet에는 작성·수정·삭제·댓글을 하지 않았다.
- 기록은 이 개인 체크포인트만 변경한다. 제품 저장소나 FE 공통 정본에 상세 이력을 중복 작성하지 않는다. 사용자 명시적 지시 없이 별도 제품 폴더·worktree를 만들지 않는다.
- **REST 기반, 기기 간 실시간 동기화 제외, notificationId 직접 전달을 필수로 확정하지 않음**은 기존 사용자 결정으로 유지한다. 알림 전용 SSE, 읽음 동기화 data FCM, 대체 주기적 polling을 추가하지 않는다. 서버가 요청 시 미읽음 수를 계산하는 것과 FE가 상시 동기화하는 것은 다른 요구다.
- 아래 9월 기록과 당일 초기 OS 조사는 당시 이력이다. 최신 자료가 보완한 클릭 읽음·삭제 UI 제외·Jira 연결·모바일 웹 지원 방향은 이 절을 우선한다. 출처끼리 충돌하거나 최종 승인이 없는 내용은 확정 정책으로 승격하지 않는다.

### 출처와 실제 열람 범위

| 출처 | 직접 확인한 범위·시점·주의점 |
| --- | --- |
| [Figma 디자인](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=2-6) | 페이지 구조·주석과 Office 앱 목록/설정/OS 차단/빈 목록/다른 치과, Office 웹 목록, Lab 앱·웹 설정의 실제 화면을 읽었다. 모바일 웹 미지원·OS 값 종속 등 이전 주석이 남아 있어 최신 Slack/PRD와 구분한다. 현재 댓글 전체를 직접 읽은 것은 아니다 |
| [FigJam](https://www.figma.com/board/U9Qpm6ACzjGFKyrCoaAuvA?node-id=68-463) | 제공 노드는 MEMBER 권한 영역이다. 전체 보드 구조, 알림센터 `33:3702`, 레퍼런스 `33:3614`, KakaoBank OS 안내 예시 `642:8892`도 확인했다. 설명 widget `33:3714/33:3512`는 스크린샷으로 읽었으며 9/1 Yoonie 표기다. 예시 화면·과거 메모를 새 구현 요구로 자동 승격하지 않는다 |
| [알림센터 PRD](https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd) | 제목 `[공통] 알림센터 개편`, 작성 중/초안(검토필요). 최종 편집 10/26 18:52:41 KST, 본문·표와 댓글 11스레드 확인. 외부 Drive 객체 1개는 본문에서 펼쳐지지 않아 전체 첨부까지 읽었다고 하지 않는다 |
| [DL-16140](https://innovaid.atlassian.net/browse/DL-16140) | 부모 및 직접 자식 12건, 관련 댓글·설계/조사 첨부를 읽었다. 부모 진행 중. 기획·현황 조사 Done과 디자인/BE 준비 중을 구분한다. 직접 자식 목록에는 제품별 FE 구현 카드가 없었으며 전체 Jira에 없다고 단정하지 않는다 |
| [10/26 Slack 원문](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793001606386079) | 원문+답글 6개, 마지막 19:11:08 KST까지 읽었다. 모바일 웹 지원, OS와 저장값 분리, OS OFF에서 PUSH 조작만 비활성, 카테고리 검토 중이 최신 보완 |
| [알림 현황 정리 26.09](https://docs.google.com/spreadsheets/d/1w1xwwEWRE0KgiJsOvldxIFbtNgWguohurf5kemIrW_g/edit) | 파일 수정 10/26 17:31:14 KST. 전체 알림 A1:O199, 시스템 링크톡 A1:I35, 개선안 Office A1:O160, 개선안 Lab A1:O160(이후 A161:AC886 공란 확인), 푸시 현황 A1:J70, 메일 A1:Y12/A13:N70, 이벤트별 그룹 A1:AA12/A13:G220을 읽었다. 알림 인벤토리는 초기12행, Copy of Jun은 메타만 확인. 전체 알림 채널 행169개. ‘최종 알림 정리’라는 실제 탭은 없고 표끼리 분류·수신자도 다름 |
| [DL-17029 BE 조사](https://innovaid.atlassian.net/browse/DL-17029) | 10/26 17:05 첨부 XLSX·댓글44646. BE develop의 TemplateType 92+ChatMessageTemplateType 12와 표 169행을 대조한 담당자 정적 보고. 이 세션이 BE 코드·운영 DB를 직접 검증한 것은 아님. 이후 Sheet에서 MFG 코드명/운영 상태와 덴처 채널 상태가 보정된 것을 확인 |
| Notion 연결 알림 인벤토리 | data source `d762274b-e0c0-40ce-8a93-900ada29449c`, 저장된 전체 view `3cece072-e82f-808f-b9fe-000cd2d936c0`로 138행 확인. NOTIFICATION55/MAIL50/PUSH27/SMS3/CHAT3, 운영상태 공란135·검토필요19. SQL 조회 한도 제한 후 공식 view 조회로 읽었다. 현재 확정 카탈로그나 실제 발송 건수로 사용하지 않는다 |
| [연결된 링크톡 조사](https://app.notion.com/p/3d1ce072e82f80cbbe61f505afe96d0c) | 9/17 문서의 시스템 링크톡 19트리거/12타입과 하드코딩 예외를 읽었다. 과거 조사이며 현재 DB 템플릿·수신자를 입증하지 않음 |
| [권한 PRD](https://app.notion.com/p/3eace072e82f81aa955dc21cba5cf127) | 10/26 17:58:07 KST 편집본의 본문과 댓글5스레드/10개. MEMBER 실제 지정·신규 가입 기본값은 알림센터 릴리즈 이후라는 5-1 조건이 남아 있다. 이를 해제한 별도 결정은 확인되지 않음 |
| 메인·보관 세션 | 메인 `01a08f0c-2057-7852-ae8d-0cf950a91fd3`에 사용자 허용 범위로 선행 정보만 질문하고 답변을 받았다. 보관 권한 세션 `01a132e9-6555-7a02-9c72-4dad9c04cc64`은 읽기만 했다. 메인 답변은 기존 기록 기반이며 외부 재검증이나 새로운 정책 승인 아님 |

### 현재 자료로 파악한 화면·기능 범위

| 영역 | 준비 기준과 남은 경계 |
| --- | --- |
| 제품 | Clinic/Lab PC 웹·모바일 웹, Office/Lab native. 웹·앱 전체 조율은 메인, 이 세션은 알림센터 기능 준비. 기존 완료 기능을 재시작하지 않음 |
| Inbox | 최신순, All/Unread 두 탭, 카테고리 필터 없음, LinkTalk는 Inbox에서 제외하는 PRD 방향. 미읽음이 있으면 Unread, 없으면 All 진입이라는 디자인 주석. 전체 병원 통합 목록은 요구하지 않음 |
| 읽음 UI | PRD와 디자인 `141:22284/22286`은 클릭·탭 또는 Read all을 읽음 계기로 명시. 기존 노출·스크롤 자동 읽음을 그대로 재사용하지 않음. 삭제 UI 제외·개별 읽음 버튼 보류·Read all 유지는 10/21 PM 동의 기록과 현재 화면이 부합하지만 최신 댓글 변경 여부까지 직접 확인한 것은 아님 |
| 수신 설정 진입 | Inbox 안 설정 진입으로 모으고 Profile 기존 진입 제거. 도메인·카테고리·지원 채널별 설정. Employee(소속) 기준으로 웹·앱에서 같은 수신 설정을 사용하려는 PRD 방향 |
| 플랫폼별 채널 | PUSH 조작은 native만 노출. 웹은 해당 제품이 지원하는 웹알림/메일 범위. Lab은 메일·SMS 미지원이므로 Office 구성을 복사하지 않음. Office/Lab 화면의 도메인 명칭·카테고리는 아직 정리 중 |
| OS 권한 | OS 권한과 서버 저장 선택을 분리. OS OFF에서도 저장값은 보존·표시하고 PUSH 조작만 비활성, OS 설정 이동 안내. 다른 지원 채널까지 함께 막지 않음. OS ON 복귀 시 사용자가 개별 OFF한 항목을 켜지 않음 |
| 초기값·이관 | 신규 가입/새 소속은 OS와 무관하게 PUSH ON, 기존 설정은 보존하는 최신 방향. 초대 생성/수락 시점, 구버전 값→신규 분류 매핑·멱등 초기화는 BE 계약 필요. 이전 메시지 신규 구조 마이그레이션 없음과 기존 PUSH 선택 보존은 서로 다른 요구 |
| 다중 소속 | 현재 또는 다른 소속에 미읽음이 있으면 bell dot, 다른 치과 안내에서 대상 소속으로 전환 후 해당 Inbox Unread 진입. 현재/다른 소속/OS badge의 같은 집계 기준을 원하지만 상세 포함 범위·조회 시점은 미정 |
| 역할·수신 범위 | Office MEMBER는 담당 주문 수신으로 제한하고 설정 선택을 막는 방향. 같은 환자의 타 의사 주문을 조회할 권한과 그 주문의 알림을 받을 권한은 다름. Editor/Manager 등의 My Orders 선택과 결제 역할별 설정은 최종 역할/API 매핑 필요 |
| 자동 LinkTalk | 자동 시스템 메시지 자체는 수신 설정으로 끄지 않는 PRD 방향. 같은 업무 이벤트의 별도 PUSH/MAIL/NOTIFICATION과 구분. LinkTalk 채팅·Support PUSH 설정과 Inbox 제외를 혼동하지 않음 |
| 제외·후속 | 미읽음 이메일 재알림은 다음 릴리즈, 관리자 템플릿/정책 관리 UI는 이번 제외, 기존 메시지 이관 없음. 지표 `notification_opened/sent/settings_viewed`는 제안이며 기존 이벤트와 합칠 계약·기준 측정은 미정 |

OS 관련 최신 근거는 [19:04 정책](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793009068187999), [19:11 PUSH만 비활성 확인](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793009468673069)이다. OS ON과 서버 PUSH ON이 수신 가능한 조건이라는 의미이며, 미수신 과거 알림 재발송·지연 없는 수신을 보장하는 것은 아니다. 1회 홈 권한 안내는 제안 상태이고 노출/닫기/재노출 기준과 문구는 디자인 확인 대상이다.

### 디자인에서 다시 사용할 정확한 위치

- Figma 파일 `QLIzKYWzFFlptCYzN36Iq4`: Office 앱 목록 `25:6486`, 설정 `36:8562`, OS 차단 `62:19720`, 빈 목록 `29:11711`, 치과 전환 `29:7570`; Office 웹 목록 `39:13907`; Lab 앱 설정 `167:25825`, Lab 웹 설정 `123:24602`.
- bell 위치·Profile 진입 제거 `36:11364/11366/11368`; 다른 소속 dot `173:28442`; 다른 소속 Unread 이동 `29:7884`; 기본 탭 `29:14828`, `89:13621/13634`; 행 필드 domain/category/time/title/subtitle `89:18502`; 상대시간·국가별 날짜 `89:18603`; Read all 비활성·하이라이트 해제 `89:15897/18497/15901`.
- **대체된 설명:** `39:18425`의 모바일 웹 미지원은 [최신 모바일 웹 지원 답변](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793002051169799)·현 PRD로 대체. `173:27687`의 OS 값으로 ON/OFF 결정, `173:28429`의 OS OFF에서 ON 터치 팝업은 최신 저장값 보존·PUSH 비활성 방향과 재정렬 필요.
- OS 차단 시 체크 표시/회색 처리, 빈 목록의 Read all 비활성 표현은 일부 화면·주석이 완전히 일치하지 않는다. 문구·색·닫기 동작을 추측하여 새 UI를 만들지 않는다.
- `158:22708`의 도메인 OFF→ON 시 하위 채널을 모두 ON으로 재설정한다는 메모는 **OS OFF→ON 보존 정책과 별개**다. 이 복구 규칙의 최종 효력과 도메인 OFF 의미를 확인해야 한다.
- 10/21 Figma #8의 삭제/개별 읽음 보류 기록은 [권한 정본](dentlink-permission-management.md)·보관 세션 turn `01a15c77-10cb-76c2-a7eb-c0999869d35b`·메인 답변과 대조했다. Change Office 토스트 문의는 정확한 플랫폼/계정/문구가 없어 결함 미확정이며, 권한 QA 범위에서 제외된 것을 수정 완료로 기록하지 않는다.
- FigJam 9/1 설명 `33:3714`도 클릭 읽음·Employee별 읽음·다른 병원 Inbox 이동·최신순 무한스크롤·다른 병원 포함 red dot을 설명한다. 웹 개인화 설정 `33:3512`는 Employee/Office별 저장과 도메인 OFF 시 웹알림 미발송을 명시한다. 최신 PRD의 읽음 계정+employer 범위와 실제 Employee/재가입 처리, Sheet의 항상 노출 문구는 BE/PM 계약으로 정렬해야 한다. 이 두 과거 카드에는 OS 분리·웹앱 저장 공유·삭제/Read all 정책은 없다.

### 원문 간 충돌·미정 사항 — 구현 전 결정할 질문

| 우선 확인 주체 | 질문과 이유·근거 |
| --- | --- |
| PM·BE | **수신 OFF 시 Inbox 기록/노출도 끄는가?** PRD·디자인은 도메인 OFF가 웹알림까지 막는 방향인데 [Sheet 전체 알림 B2:B7](https://docs.google.com/spreadsheets/d/1w1xwwEWRE0KgiJsOvldxIFbtNgWguohurf5kemIrW_g/edit#gid=614410508&range=B2:B7)은 인앱 로그 항상 기록·항상 노출·opt-out 불가라고 명시. 파일 수정 시각만으로 우선순위를 정하지 않는다. 저장된 기존 기록 숨김/신규 생성 중단 여부도 분리 필요 |
| PM·디자인·BE | **최종 도메인/카테고리/채널/수신자 표는 어느 탭·문서인가?** Sheet 전체/개선안/푸시 현황과 Figma 분류가 다름. Office All Employees와 생성자+담당의도 표끼리 다름. 10/26 Slack에서도 Leo 검토 후 디자인 반영 예정. API enum·화면 라벨을 지금 확정하지 않음 |
| PM·권한 담당 | **MEMBER 실제 적용·신규 가입 기본값 시행 시점과 구버전 앱 대응은?** 권한 코드 운영 전달은 기록으로 확인되지만 PRD5-1의 알림센터 이후 적용 조건을 해제한 근거 없음. 관리 화면에 선택 항목이 있다는 사실과 실제 시행 정책을 구분 |
| PM·FE·BE | **알림 My Orders Only와 홈/주문/LinkTalk 필터는 어떤 값만 공유하는가?** PRD는 알림 설정 웹·앱 공유, 홈 필터는 웹·앱 독립을 설명. 현재 Office는 서버 preference+로컬 store 연결, Lab은 로컬 store, Clinic은 URL 필터. 동일 이름만으로 합치지 않음. MEMBER 수신은 담당의 기준, 일반 My Orders는 생성자+담당자라는 차이도 있음 |
| PM·BE | **클릭 읽음의 정확한 성공 기준·대상·전체 범위는?** 클릭 즉시인지 상세 성공 뒤인지, 랜딩 없는 공지/삭제 대상/권한 상실/조회 실패/이미 읽음 재요청, 클릭 알림 하나와 같은 업무의 과거 알림 관계, Read all의 LinkTalk·serviceType·소속 범위 확인. notificationId 또는 정보 조합의 선택·전달 위치·FE/BE 책임은 미정 |
| BE·FE | **새 목록/필터/페이지·집계·설정 API 계약은?** 현재 DEV 공개 스펙에는 아래 차이가 남음. 읽음 필터를 FE에서 현재 페이지만 걸러 빈 목록·수량 오류를 만들지 않도록 서버 pagination과 합의 필요. count에 채팅 포함 여부, 현재/전체 소속·기기 기준, REST 재조회 계기·실패 시 처리도 필요 |
| PM·디자인·BE | **기존값 보존과 초기값 생성은 언제 어떻게 하는가?** 신규 가입·초대 수락·기존 사용자 새 소속·신규 카테고리 추가를 분리. OS 변화는 저장값을 바꾸지 않음. 도메인 OFF→ON 하위 선택 복원/전체 ON, 과거 알림 미이관 시 화면, 누락/삭제 템플릿 전환 시점은 확인 대상 |
| PM·디자인 | **남은 화면 상태는?** 모바일 웹 최종 배치, native 권한 가이드 1회 기준/닫기/다시 안내, 로딩·실패·빈 목록·탭 변경·전체 읽음 실패·소속 전환 실패, 국가별 날짜·문구. 기존 패턴만으로 사용자 동작을 새로 추가하지 않음 |

### 연결된 알림 현황표에서 확보한 FE 매핑 재료

- Sheet `전체 알림` gid `614410508`의 열은 Domain/Category/이벤트·템플릿/발송 조건/Template ID/Order Notification Scope/채널/운영 상태/수신 대상/영·국문 제목·부제/랜딩이다. 매핑 축은 확보했으나 확정 enum·운영 정본으로 간주하지 않는다. 169행 상태 표기는 운영중137/신규15/추가예정3/삭제필요5/미사용6/중단3이며 실제 발송 검증 결과가 아니다.
- 후보 분류: ORDERS(Design Confirmation/Order Updates/Shipping/Payments/Feedback), CREDITS, USERS(Case preference/Group members), LINKTALK, Manufacturing(Order Updates/Payments). 개선안 탭은 ORDER/PAYMENT/USER PREFERENCE 등 별도 이름을 사용한다. 지원하지 않는 채널이나 비어 있는 값을 추측해 추가하지 않는다.
- 10/26 BE 첨부 후 Sheet186~194행의 MFG5종은 `MFG_ORDER_SUBMITTED/CANCEL/CONFIRM/IN_PROGRESS/SHIPPING`, 운영중으로 고쳐져 있다. 106~109행 덴처 다음 단계는 CHAT 운영중, NOTIFICATION/PUSH 신규로 구분. 이미 보정된 항목을 현재 결함으로 되풀이하지 않는다.
- 남은 표 차이: Office13~19행 All Employees와 개선안6~11행 생성자+담당의, 삭제필요96/172/173/179/182행, MFG Template ID 공란, Support184행 Template ID `en`. 월 인보이스195~196행은 추가예정·랜딩 공란. BE 첨부의 미구현/수신자 의견은 FE가 서버 코드로 재검증한 사실과 구분한다.
- 기존 PushType은 화면 카테고리와 1:1이 아니다. `ORDER_APPROVAL/ORDER_NEW`는 제품·이벤트별 의미가 다르고 푸시 현황표에는 일부 카테고리/수신제품/스캐너/신규유형 매핑이 비어 있다. Template ID·PushType·업무 데이터 ID·알림 개별 레코드 ID는 다른 식별자다.
- 시스템 링크톡 tab gid `1129039729`는 번호19개+추가 문구1행, SYSTEM/LAB/OFFICE 발신·타입·본문/DB 템플릿·조건·수정 대상이 혼재. 자동승인 `# hours`와 `24 hours`, 국문 공란, 타입 없는 하드코딩도 확인. 시스템 메시지와 동일 이벤트의 사용자 노출 PUSH를 하나의 수신 설정으로 묶지 않는다.
- 메일 탭은 Auth & Onboarding 수신설정 제외(B10), 샘플 만족도 랜딩 변경/삭제 질문(B28), Case preference 발송 조건 ‘주문 생성 시’(D39)와 ‘매월1일09시’(I39)가 혼재한다. 중단의심 표기를 실제 폐기 확정으로 사용하지 않는다. 이벤트별 그룹의 USER/BENEFIT·Order Status/Account 명칭도 최종 분류 정렬 대상이다.

| 랜딩 종류·원문 예 | 사전 확인할 내용 |
| --- | --- |
| `dentlink://confirm/{officeId 또는 employerId}/{orderId}/{approvalId}` | 병원 식별자 명칭 혼용. 현재 앱은 employer→사용자 소속 employee를 찾으므로 계약을 명확히 해야 함 |
| `dentlink://order/{orderId}` / `dentlink://order/{employerId}/{orderId}` | 병원 없는 기존형과 일반형 공존. 잘못된 현재 소속으로 요청하지 않는 방법 필요 |
| 주문 URL의 `scanner-draft-received`, `isCasePreferenceModalOpen`, shipment tracking, chat·casePreference 경로 | 단순 screen 이동 외 action·상태 분기 보존. 이미 검증된 기존 기능의 상세 이력을 재작업하지 않음 |
| 크레딧 PUSH의 ‘알림센터 오픈’, MFG의 `milling/orders/{orderId}` | 실제 URL/payload 없음 또는 웹 상대 경로. native Inbox/상세 목적지와 실패 fallback 계약 필요 |
| 랜딩 없는 공지, 월 인보이스 랜딩 공란 | 이동할 화면을 임의로 만들지 않음. 클릭·읽음 동작과 표시 구분을 기획에 확인 |

모든 기존·신규 링크에 대해 로그인 준비 → 목표 소속 확인/활성화 → 화면 또는 action → 정책에 따른 읽음을 검토한다. 읽음 정보를 URL/FCM/Airbridge/deferred 경로에서 잃지 않아야 한다. 같은 화면의 서로 다른 알림과 같은 알림의 중복 콜백을 구분하고, 경로 중복 이동 제어를 읽음 중복 제거로 그대로 사용하지 않는다.

### 코드·DEV Swagger 대비 재사용 지점과 변경 예상

10/26 19:16 KST [DEV Swagger JSON](https://dev-api.dentlink.io/v3/api-docs) 읽기 확인. 인증된 계정 조회·mutation·DB 확인은 하지 않았다.

| 영역 | 현재 확인한 계약/실제 호출 | 준비할 차이 |
| --- | --- | --- |
| 목록 | 웹 service→query→Notifications→공통 NotificationUI 실제 호출. `GET /messages/notifications` query `id/serviceType/size`; 웹20건 cursor. Native는 생성 Api.ts 선언 외 실제 호출 미확인 | 공개 스펙에 읽음 필터·LinkTalk 제외 parameter 없음. `NotificationDto`는 id/notificationType/serviceType/title/content/landingUrl/isRead/sentAt/options 등 기존 구조. 새 domain/category/event/delivery 표현·native service/query/screen 필요 여부 확인 |
| 읽음 | 기존 웹 부분/전체 PATCH 호출. partial body `unreadNotificationIds`; all 선택 query `serviceType` 있으나 웹 wrapper는 미전달 | 현재 웹은 노출/스크롤로 부분 읽음, All 하단 도달 시 전체 읽음. 클릭 기준으로 트리거 변경 필요. 신규 읽음 API가 반드시 필요하다고 가정하지 않음 |
| 삭제 | 기존 DELETE 계약·웹 호출 있음 | 새 화면에서 삭제를 제외하는 방향과 API 자체 제거는 별개. 기존 API 삭제 승인 아님 |
| 미읽음 집계 | `/unread` boolean, `/employers` string 배열. Native는 로그인/foreground에 서버 디바이스 badge와 Notifee badge를0으로 초기화 | 숫자·소속별 dot·OS 배지를 같은 미읽음 기준으로 묶을 계약과 기존 초기화 정책 확인. 현재 응답만으로 소속ID/count map을 제공한다고 단정하지 않음 |
| 수신 설정 | 앱 실제 GET/POST `push-preferences`, PATCH preferenceId/settingsId. 응답 `pushEnable/enablePersonalOrders/settings[].id/type/enable`; preference PATCH는 pushEnable와 enablePersonalOrders 필요 | Employee×domain×category×channel 신규 공개 계약은 검색 범위에서 미확인. BE 개발이 전혀 없다는 뜻은 아님. 기존 PUSH 타입과 다채널 새 구조 매핑 필요 |
| OS 분리 | OS granted 변화 때 POST 초기화, 서버 pushEnable false/필수 타입 누락 때도 초기화, OS 미허용 시 화면 값 false 처리 | 저장값 그대로 표시·보존 + PUSH 비활성 유지. OS ON으로 기존 OFF를 켜는 초기화 연결과 신규 타입 생성 분리. 현재 서버 설정이 아예 없던 구조는 아님 |
| My Orders | Office 서버 preference+로컬 store, 변경 시 `pushEnable:true`도 PATCH. Lab 로컬 store, Clinic URL필터 | 전체 수신 OFF와 조회 필터를 의도치 않게 켜거나 공유하지 않도록 계약 분리 |
| 소속/권한 | auth store로 Employee/Employer 헤더. Lab 일반 전환은 서버 활성화·ID검증·query취소/제거 후 새소속 공개. 일반 딥링크 sideEffect는 직접store변경 경로 존재 | 모든 진입이 같은 완료 절차를 거친다고 가정하지 않음. 이전 계정/소속의 늦은 응답 폐기·새 요청 헤더 일치·실패 복구 보존 |
| 분석 | 웹 notification_click/item_click/filter_click, 앱 push_click 기존 사용 | 새 PRD opened/sent/settings_viewed와 중복/책임/파라미터 합의. 분석 pushType을 읽음 ID나 새 설정 enum으로 간주하지 않음 |

코드 근거(아래 조사 revision 기준):

- 웹: `shared/models/src/messages/messages.apis.clinic.ts:19,38,72,89,109`, 동명 lab파일 `:19,56,73,93`; `clinic/src/components/Notifications/useNotificationsPagination.tsx:34,110,133,149`, Lab 동명 `:25,100,121`; `shared/ui/src/NotificationUI/NotificationUI.tsx:114,176,200,241,278,295`; 각 `services/messages/messages.query.ts`; Clinic `Layout/Header.tsx:104`, Lab `Layout/HeaderActions.tsx:47,108`와 `NavigationMobile.tsx:155`.
- Office: `src/queries/useAppQueries.ts:29`, `src/libs/usePersonalOrdersPreference.ts:31,65,100`, `src/configs/utils/fetcher.ts:92`, `src/libs/useEmployeeProfile.ts:38,103`, `src/navigations/RootNavigator.tsx:107,313,343,451`, `src/services/app.service.ts:138`; `src/libs/useNavigationConfig.ts:81,88,163,198,203,340,625,682,946`, `src/configs/utils/fcmHandler.ts:108,119`, `src/configs/constants/deepLink.ts:20`.
- Lab main: `src/libs/useEmployeeProfile.ts:38`, `src/libs/useNavigationConfig.ts:79`, `src/hooks/useProfileNotification.ts:46`, `src/libs/usePersonalOrdersPreference.ts:1`. Native 생성 `src/models/Api.ts` 메서드 존재는 실제 연동 증거가 아님.
- 앞선 OS 조사에 있는 PermissionProvider/ProfileNotificationSection/usePermissionStore/useAppState/HomeScreen도 재사용 검토 지점이다. 정확한 줄은 추후 변경될 수 있으므로 revision과 실제 호출을 다시 확인한다.

### 선행 권한 작업에서 인계받아 보존할 내용

- 10/25 운영 Git/Actions·Office/Lab Production OTA 활성은 권한 기능 전달 기록이다. 모든 설치 앱의 적용·실기기 QA 완료나 MEMBER 적용 조건 해제, 알림센터 완성을 뜻하지 않는다. 이번에는 기존 배포 검증을 반복하지 않았다.
- MEMBER는 담당 주문이1건 이상인 환자의 전체 케이스·주문을 읽을 수 있지만, 타 담당자 주문 행동은 읽기 전용이고 본인 담당 주문 행동은 허용한다. 같은 환자라는 이유로 모든 알림을 수신시키지 않는다. BE 발송 대상 제한과 Inbox/집계 필터를 함께 확인해야 한다.
- Employee별 역할, activeEmployeeId와 profile.id 일치 후 판단, 소속/역할별 캐시 분리·이전 응답 폐기를 보존한다. Office 소속 전환 code2131과 접근 거절2152, Lab 접근 거절1018의 기존 처리를 구분한다. 모든403이 로그아웃되지 않는다는 뜻은 아니다. 조사한 Office `fetcher.ts:147~160`은2005/2152를 별도 처리하고2004 외 나머지403에 토큰 만료 처리를 하므로, 새 알림의 오류도 HTTP 상태만으로 임의 분류하지 않고 실제 서버 code/호출 경로를 확인한다.
- 10/20 DL-16859 Member LinkTalk 목록·미읽음·배지의 본인 주문 한정은 저장 preference/PUSH 변경 없이 적용한 기존 보호다. 이를 홈 필터 공유 정책이나 알림센터 수신 구현 완료로 사용하지 않는다.

### 이번 코드 조사 위치 — 구현 위치로 배정하지 않음

| 저장소 | 실제 checkout·상태 | 읽은 기준과 한계 |
| --- | --- | --- |
| `/Users/parkjongsun/Repository/dentlink-client` | `feature/DL-17011@9dcb644d566cee06fa0019c16b7f47cdf10e8d36`, upstream0/0·clean | `origin/master@c597f1fb3e7f5c03a76237926c3effad5bb84983`, 실제 원격 동일. 조사 알림 파일은 checkout과 차이 없음 |
| `/Users/parkjongsun/Repository/dentlink-app` | `main@49031ad64983715f87f92b4998284da1dbae7c23`, upstream0/0·clean | 실제 원격 main 동일, 조사 파일은 develop `fc127bd6…`와 차이 없음 |
| `/Users/parkjongsun/Repository/dentlink-lab-app` | `QA/DL-16917@06e8dfde967502a4830e9a93c018ce150702dc7c`, upstream0/0·clean | main `51441039751b63a08c82a1be9695c805c8af1539`를 git show로 읽고 원격 main 일치 확인. 조사 도중 원격 develop `58a551e717af1a4d1642e03963d34be0c0293591` 변경을 관찰했으나 후속 코드 미검증 |

웹 등록 worktree는 기본 checkout과 `dentlink-client-dlds` detached `c597f1fb…`; 두 앱은 기본 checkout 하나다. 이번 확대 조사에서는 제품 fetch/pull/checkout을 하지 않았다. 당일 앞선 OS 조사에서의 동기화는 별도 이력이다. 현재 branch는 다른 작업용이므로 구현 전 활성 작성자·변경 범위·최신 Git을 다시 확인한다.

### 준비된 작업 묶음·검증 후보·다음 시작점

아래는 구현 계획의 분해이며 착수/기한/담당자 배정/제품 Git 권한을 뜻하지 않는다.

1. **정책·계약 정렬:** 위 충돌 질문을 PM/디자인/BE에 확인하고 최종 카탈로그·role/Employee·읽음/집계·설정·랜딩 계약을 연결한다. 이번에는 외부 댓글/질문을 게시하지 않았다.
2. **웹 목록·설정:** 기존 서비스/query·반응형 진입을 살피며 All/Unread pagination, 클릭 읽음/Read all, 설정 진입·지원 채널, 다른 소속 안내를 새 계약에 맞춰 계획한다.
3. **Office/Lab native:** Inbox route/screen/service/query, 설정 이동, OS 안내·저장값 보존, 배지 기준을 제품별로 준비한다. OS 재허용으로 서버 선택을 자동 변경하지 않는 초기화 계약이 선행된다.
4. **공통 딥링크:** 기존/신규 URL과 동작을 매핑하고 로그인/deferred/FCM/Airbridge/병원 전환·읽음 연결의 순서와 실패 정책을 정한다. 특수 동작·권한 가드·전환 중 응답 폐기를 유지한다.
5. **검증·전달 준비:** 계약 확정 후 제품별 FE Jira·작업 checkout·base/PR 대상·release를 메인과 조율하고, 승인된 범위에서 구현·검증한다. 구현/코드 검증/사용자 QA/review/merge/release 포함/배포/운영 확인은 별도 단계로 기록한다.

검증 시나리오는 아직 실행하지 않았다: OS OFF에서 저장값 유지·PUSH만 비활성, OS 재허용 뒤 기존 OFF 보존; 신규/기존/초대/다중 소속의 초기값; 첫 노출·스크롤은 읽음 변경 없음; 클릭·Read all 범위/실패; 같은 화면 다른 알림과 동일 알림 중복 콜백; 로그아웃·로그인 전 링크·소속 전환 중 지연 응답·탈퇴·권한 상실·삭제 대상; MEMBER 담당 범위의 목록/배지/PUSH/메일; 필터·페이지 경계와 count; 웹·앱의 다음 REST 조회 일치; 지원하지 않는 채널 비노출·지역 문구.

- Jira 현 상태: DL-16141/16142/16278/16303 기획·조사 Done; DL-16781/16788/16790 디자인 진행 중, DL-16789/16791 목록·Lab 확인 할 일; DL-16905 정책 분석·DL-17029 운영 템플릿 분석 진행 중; DL-16906 BE 설계 할 일. 티켓 상태는 구현·배포 증거가 아니다.
- **다음 시작점:** 이 절의 출처별 변경 사항·미정 질문을 기준으로 추가 자료/답변만 반영한다. 이미 얻은 권한·기존 API 조사부터 처음 다시 시작하지 않는다. 실제 착수 요청이 오면 최신 Git/Swagger/디자인과 해결된 계약을 재확인하며, 현재는 사전 준비 완료·제품 구현 미착수다.

## 당일 초기 기록 — 2026-10-26

아래는 링크 종합 조사 전의 상태다. 현재 사전 준비 결과·보완된 정책·메인 답변은 문서 맨 위 최신 절을 따른다.

- **이번 메인 작업 공간 정리와 무관한 세션이므로 유지한다.** 메인이 정리 범위를 넓게 해석해 통합알림센터 세션 `01a065e6-afb2-75a0-b465-61c3e488a894`를 보관했으나, 사용자가 정정해 즉시 보관 해제했다. 제품 코드 변경·구현 재개·완료 처리는 아니다. 아래 사전 검토·REST 방향·미정 요구사항은 그대로 보존한다.
- 다시 요청받으면 이 문서와 최신 메인 조율 정본을 읽고 현재 master 및 API/요구사항을 대조해 필요한 환경만 준비한다. 아래 권한관리 미착수 등 9/29 상태는 당시 이력이며 현재 상태는 담당 정본을 따른다. 이번에는 구현을 재개하지 않았다.

### 사용자 재확인 — 작업 전 준비와 선행 권한 작업

- 오늘 OS 알림 상태 인지·안내 배너·서버 수신 설정 분리 질문은 **PM에게 코드 기준 구현 가능성을 설명하기 위한 작업 전 준비**다. 사용자는 지금 바로 작업을 진행하는 것이 아니라고 재확인했다. 조사 결과를 구체적인 기획 확정이나 구현 착수 승인으로 확대하지 않는다.
- 이전 선행 작업은 [DL-16317 역할·담당자 권한관리](dentlink-permission-management.md)다. 최신 정본에는 해당 작업의 운영 반영·완료/보관이 기록돼 있으므로 아래 9/29 미착수 이력을 현재 상태로 사용하지 않는다. 이번에는 해당 배포·제품 코드를 다시 검증하지 않았다.
- 권한관리 정본은 알림센터 Inbox·수신 설정·치과 전환 배지·발송 DB 개편을 별도 기능으로 분리한다. 역할/담당자 권한 작업 완료를 OS 권한과 서버 수신 설정 분리 완료로 취급하지 않는다.
- 과거 PRD에는 권한 체계 선배포와 MEMBER 실제 지정·신규 가입 기본값 적용 시점을 알림센터 릴리즈와 구분한 기록이 있다. 이후 권한 후속 작업도 있으므로 실제 알림 수신 범위·권한 정책·적용 시점은 착수 전 최신 근거로 확인한다. 과거 기록만으로 현재 정책을 확정하지 않는다.
- 사용자는 필요한 선행 정보가 있으면 보관된 권한관리 세션이나 메인세션에 문의하도록 허용했다. 이 초기 조사에서는 정본만 확인했으나, 이후 ‘부족한 정보를 지금 확인’ 지시에 따라 보관 세션을 읽고 메인 답변까지 받았다. 결과는 문서 맨 위 최신 절에 기록했다. 구현은 시작하지 않는다.

### OS 알림 권한과 서버 수신 설정 조사 — 2026-10-26

- 사용자 요청은 **현재 앱 구조 조사만**이다. OS 권한은 별도로 확인·설정 이동을 안내하고, 앱 수신 설정은 서버에 별도 보관하려는 방향을 제시했다. 구체적인 화면·문구·기본값·저장 범위나 구현 착수를 승인한 것은 아니다. 기존 REST 알림센터·읽음 정책의 확정/미정 경계는 유지한다.
- 현재 Office와 Lab은 별도 저장소다. 개인 컨텍스트를 `git pull --ff-only`한 뒤 아래 앱 저장소도 동기화했다. branch 전환·생성, 제품 코드 수정·commit·push·PR·배포는 하지 않았다.

| 조사 대상 | 실제 checkout 및 조사 기준 |
| --- | --- |
| Office `/Users/parkjongsun/Repository/dentlink-app` | `main@49031ad64983715f87f92b4998284da1dbae7c23`, `origin/main` 대비 0/0·clean. 기존 main을 fast-forward pull한 코드 기준 |
| Lab `/Users/parkjongsun/Repository/dentlink-lab-app` | 기존 `QA/DL-16917@06e8dfde967502a4830e9a93c018ce150702dc7c` 유지, upstream 대비 0/0·clean. 조사에는 `git show`로 최신 `origin/main@51441039751b63a08c82a1be9695c805c8af1539` 사용 |

- 위 두 앱의 조사 대상 알림 권한·설정 파일은 각 `origin/develop`과 차이가 없었다. 이는 현재 설치된 앱 버전이나 배포·실기기 동작까지 확인했다는 의미는 아니다. 웹은 이번 조사 범위에 포함하지 않았다.
- **완전한 양방향 동기화가 아니다.** `ProfileNotificationSection.getSettingEnabled`는 OS 미허용이면 서버 개별 `enable` 값과 무관하게 모든 스위치를 OFF로 표시한다. 변경/전체 켜기 시도도 OS 설정 안내 후 중단한다. OS OFF 시 서버 설정 전체를 false로 저장하는 호출은 조사 범위에서 확인되지 않았다.
- **OS 허용이 서버 설정을 바꾸는 연결은 있다.** `PermissionProvider`는 저장된 이전 OS 상태와 달라져 `granted`가 되면 설정 초기화 POST를 호출한다. OS 허용 상태에서 서버 전체 `pushEnable`이 false이거나 필수 항목이 누락돼도 같은 초기화를 시도한다. 초기화에는 중복 시도 제어가 있다.
- 개발 [Swagger JSON](https://dev-api.dentlink.io/v3/api-docs)을 당일 읽기 조회했다. `POST /app/users/own/push-preferences` 설명은 **타입 수가 다르면 신규 타입만 true, 같으면 모든 타입을 true**다. 따라서 OS를 다시 허용할 때 기존 개별 OFF 선택까지 켜질 가능성이 코드와 계약상 있다. 실제 계정 변경 요청이나 서버 DB 직접 확인으로 재현한 결과는 아니다.
- 서버 설정 연동은 이미 존재한다. 실제 service/query/hook이 `GET/POST /app/users/own/push-preferences`, `PATCH /app/users/own/push-preferences/{preferenceId}`, `PATCH /app/users/own/push-settings/{pushSettingId}`를 사용한다. 응답은 전체 `pushEnable`, `enablePersonalOrders`, 개별 `settings[].id/type/enable`을 구분한다. Employee-Id/Employer-Id 헤더 계약도 있으나 실제 DB의 계정·소속·앱별 저장 단위는 이번 조사로 확정하지 않았다.
- **권한 감지는 로그인·앱 상태 변경 시 재조회다.** `PermissionProvider`가 `checkNotifications()`를 비동기로 호출하고 Zustand/AsyncStorage에 마지막 상태를 보관한다. OS 설정에서 앱으로 복귀할 때 재확인하는 구조이며, 종료·백그라운드 중 실시간 감지나 지연 없는 반영을 보장하지 않는다. 공통 판정은 `status === granted`이며 iOS 표시 세부 설정·Android 채널 차단을 모두 반영하는 판정은 아니다. 홈에는 OS 미허용 안내 배너가 이미 있다.
- 사용자 방향으로 분리할 때 검토할 곳: 서버 저장값을 OS 표시값과 분리하고, OS 허용에 따른 자동 POST를 누락 항목 생성/기존 선택 보존과 구분한다. 후속 10/26 Slack/PRD는 **OS OFF에서도 저장값 보존·표시, PUSH 조작은 비활성**이라고 명시했으므로 OS에 따른 수정 제한까지 없애는 구현은 하지 않는다. Office의 `usePersonalOrdersPreference`는 수신 범위 변경 PATCH에 `pushEnable: true`도 넣으므로 전체 수신 OFF 정책과 함께 확인해야 한다. 새 API나 DB가 반드시 필요하다고 가정하지 않는다.
- 근거 파일(두 앱 공통): `src/features/common/components/PermissionProvider.tsx`, `src/features/profile/sections/ProfileNotificationSection.tsx`, `src/hooks/useProfileNotification.ts`, `src/hooks/useAppState.ts`, `src/store/usePermissionStore.ts`, `src/services/app.service.ts`, `src/queries/useAppQueries.ts`, `src/features/home/screens/HomeScreen.tsx`. Lab은 로컬 QA 파일과 다르므로 위 main SHA를 기준으로 읽는다.
- **초기 조사 완료 경계:** 코드·개발 Swagger 조사만 완료했고 제품 수정·실행 테스트·실기기 QA·배포 확인은 하지 않았다. 이후 자료 종합으로 OS 분리·기본값·클릭 읽음 방향은 보완됐다. 읽음 대상 식별과 실패 정책, 실제 설정 저장/초기화 계약 등 남은 사항은 맨 위 최신 절을 따른다.

## 이전 체크포인트 — 2026-09-29

### 목적·범위와 선행 작업

- 기능명은 가칭 `통합알림센터`다. 이 문서가 기능의 상세 결정·진행 정본이며,
  제품 저장소에 개인 세션 상태나 임시 인계 문서를 추가하지 않는다.
- **Dentlink FE 최상위 세션 아래의 통합알림센터 기능 세션**이다. Clinic/Lab 웹과
  Office/Lab 앱의 알림 목록·읽음·삭제, 공통 딥링크의 로그인 준비 → 병원·소속
  확인/전환 → 화면 이동 또는 동작 실행 → 필요한 REST 읽음 연결을 함께 담당한다.
  기존·신규 딥링크 모두 검토 대상이며, 웹·앱이라는 이유로 세션을 나누지 않는다.
- **기존 REST 기반과 기기 간 실시간 동기화 제외는 확정**이다. 알림 전용 SSE,
  읽음·삭제 동기화용 silent/data FCM, 대체 주기적 polling은 추가하지 않는다.
  기존 Lab 배송·픽업 SSE와 사용자 노출 FCM·Notifee 푸시는 유지한다. 서버 상태가
  정본이며 다른 기기는 다음 REST 조회 때 반영해도 된다. OS 푸시 삭제는 범위 밖이다.
- 2026-09-28 사용자 결정으로 [DL-16317 권한관리](dentlink-permission-management.md)를
  선행 작업으로 둔다. 해당 9/29 정본은 **Office API 4개 사용처 조사 완료 /
  권한관리 본 요구사항 분석·설계·구현 미착수·대기**다. 선행 작업의 구현이 끝났거나
  통합알림센터와의 구체적인 권한/API 의존 계약까지 정해졌다는 뜻은 아니다.
  착수 순서와 공통 계약은 [최상위 조율 정본](dentlink-fe.md)에서 조율한다.
- 별도 제품 폴더/worktree 없이 두 제품 저장소를 참조하는 기존 범위를 유지한다.
  아래 현재 checkout은 이 기능의 구현 위치로 배정된 것이 아니다. 제품 Git 이력과
  권한은 각각 유지하며 새 폴더·branch/worktree를 임의로 만들거나 전환하지 않는다.

### 완료한 내용과 미착수 범위

| 구분 | 현재 상태와 근거 |
| --- | --- |
| 방향·사전 조사 | REST 방향, 제외 범위, 공통 딥링크 조사와 미정 정책 정리 완료. 아래 9/3·9/11 기록이 근거이며, 오늘 제품 코드를 다시 검증한 것은 아님 |
| 제품 구현 | 이 세션의 통합알림센터 구현과 앱 공통 알림 읽음 REST 연결은 미착수. 오늘 최신 제품 코드에서의 구현 유무를 전수 재조사하지 않음 |
| Jira·작업 위치 | 전용 Jira, 구현 branch/worktree, base·PR 대상·release 미정. 권한관리 DL-16317을 이 기능의 Jira로 사용하지 않음 |
| 제품 검증·전달 | 이 기능의 실행 테스트·사용자 QA·제품 PR/review·merge·release 포함·배포·운영 확인 미착수. 과거 Git·코드·Swagger 읽기 확인과 구분 |
| 이번 작업 | 개인 정본 한 파일의 정리·commit·push와 원격 확인만 승인. 제품 코드/Git 변경, 외부 요구사항 재조사, 테스트·서버 실행은 하지 않음 |
| 재개 상태 | 기존 세션과 대기 상태 유지. 사용자 별도 조사/구현 재개 지시 전에는 다음 작업을 자동 시작하지 않음 |

- 9/3 개발 Swagger에서 기존 `PATCH /messages/notifications/read/partial`과
  `NotificationReadUpdateDto.unreadNotificationIds` 배열, Bearer 및
  Employee-Id/Employer-Id 헤더를 확인했다. 웹 동일 REST 호출과 앱 생성 API 정의를
  조사했지만, API 정의 자체가 앱 실제 연결·요청 성공의 증거는 아니다. 이 기록은
  당시 계약이며 구현 시 최신 코드·Swagger로 확인한다. 새 읽음 API 필요를 먼저 가정하지 않는다.
- 9/11 운영 정렬 및 이후 인수인계는 제품 구현 승인이 아니었다. 이번 9/29 승인도
  다른 기기에서 상태를 복구하기 위한 개인 기록 정리에 한정한다. 완료한 다른 기능을
  재시작하지 않으며 공통 딥링크 변경 시 기존 검증 동작을 보존한다.

### 미정 정책과 사용자·PM·BE 확인 사항

- 목록의 노출·스크롤·클릭 중 언제 읽음으로 볼지와 웹·앱 적용 범위는 미정이다.
  기존 웹 동작을 최종 정책으로 단정하지 않는다. 앱 알림센터 화면/UI의 구체적
  구현 범위와 설계도 실제 요구사항을 받아 확인한다.
- **notificationId 직접 전달은 필수가 아니다.** 여러 정보를 조합할 수도 있으며,
  사용할 정보·URL query/기존 FCM payload 전달 위치와 key·FE/BE 판별 책임·기존
  REST와의 연결 방식은 미정이다. 업무 데이터 ID나 화면 주소만으로 읽음 대상을 추측하지 않는다.
- 푸시 딥링크 클릭 시 읽음 요구는 있으나 상세 조회 실패·대상 삭제·이미 읽은 알림의
  재요청/읽음 실패 처리, 같은 대상의 과거 알림까지 읽을지 여부는 미정이다.
  근거 없이 일괄 읽음으로 확장하지 않는다.
- 선행 권한관리의 실제 결과 중 무엇이 알림 조회·읽음·딥링크 소속 전환에 영향을
  주는지, 구현 시점·범위·작업 위치와 release는 재개 시 조율한다. 지금 새 정책을
  정하거나 권한관리 완료를 추정해 이 기능을 시작하지 않는다.

### 저장소·Git 상태 — 2026-09-29 읽기 확인

개인 컨텍스트는 `main / b2d428ca603c6ee5c663310cd9403a4db84a59f8`에서
`git pull --ff-only` 후 `origin/main` 대비 0/0·clean임을 확인하고 기록을 시작했다.
메인세션이 순차 기록 차례를 배정했으며 이 파일만 수정한다. 공통 색인·HANDOFF·FE
조율 문서는 메인세션이 취합한다.

제품은 `status`, HEAD/upstream, 등록 worktree와 `ls-remote`만 읽었다.
제품 fetch/pull/checkout은 하지 않았으므로 아래 로컬 추적 ref와 실제 원격을 구분한다.

| 참조 저장소·경로 | 로컬 branch / HEAD / upstream | 작업 상태·원격 확인 |
| --- | --- | --- |
| [dentlink-client](https://github.com/Innvoaid/dentlink-client), `/Users/parkjongsun/Repository/dentlink-client` | `feature/DL-16387` / `347909945b091324e7134673525203de14e122fd` / `origin/feature/DL-16387` | clean·미추적 없음, 추적 ref 대비 0/0. 해당 원격 branch SHA도 일치. LBX 작업 위치이며 알림센터용으로 재사용하지 않음 |
| [dentlink-app](https://github.com/Innvoaid/dentlink-app), `/Users/parkjongsun/Repository/dentlink-app` | `main` / `7403721151f3d2135799a995bccdd2214783822d` / `origin/main` | clean·미추적 없음, 로컬 추적 ref 대비 0/0. 실제 원격 main은 `a681df51e3864f37720b1f2178c939cfe734fdf4`로 달라 최신 원격 동기화 상태가 아님 |

- 앱 최신 원격 대비 ahead/behind와 코드 차이는 이번에 확인하지 않았다. 웹·앱의
  과거 9/3·9/11 branch/HEAD를 현재 작업 위치로 사용하지 않는다.
- 웹에는 기본 checkout과 다른 기능의 `/Users/parkjongsun/Repository/dentlink-client-dlds`
  (`feature/DL-16466 / 85002472fe6823da903138cbc577d0883bf72d0c`)가 등록돼 있다.
  앱은 기본 checkout 하나다. 알림센터 전용 제품 branch/worktree·미푸시 구현 코드는
  이 세션에서 만들지 않았다. 다른 기능의 활성 작성자·실행 프로세스는 이번에
  조사하지 않았으므로 실제 제품 변경 직전에 소유권을 다시 확인한다.

### 새 기기 복구·재개 조건과 로컬 자료의 한계

1. [codex-personal-context](https://github.com/jongsunP/codex-personal-context)를
   clone하거나 pull하고 `BOOTSTRAP.md`, `SESSION_WORKFLOW.md`의 순서대로 공통
   지침·프로젝트 색인·이 문서를 읽는다. 최상위와 권한관리 정본을 함께 확인하고,
   웹·앱의 관련 최신 체크포인트를 필요한 범위에서 읽는다. 첫 대화에서도 현재 상태를
   **기존 기술 방향·딥링크 조사 정리 완료 / 구현 미착수 / 사용자 재개 지시 대기**로 복구한다.
2. 코드 확인이나 구현이 다시 지시되면 위 웹·앱 저장소를 각각 준비하고 정확한 경로,
   branch·HEAD·upstream·dirty/미추적·등록 worktree·활성 작성자를 확인한다.
   허용된 범위에서 필요한 Git을 동기화하고 최신 요구사항·코드·Swagger를 대조한다.
   오래된 조사 결과를 현재 사실로 재사용하거나 기록의 branch를 자동 선택하지 않는다.
3. 구현 착수에는 사용자 재개 지시와 범위 확인이 필요하다. 선행 권한관리 상태,
   위 미정 정책·계약, 전용 Jira·작업 checkout·공통 파일 작성 범위·웹/앱별
   base/PR 대상/release를 조율한다. 일반적인 진행 지시를 제품 commit·push·branch·
   PR·merge·배포 권한으로 확대하지 않는다. 현재 인수인계만으로 구현을 시작하지 않는다.
4. 정적 확인에는 두 비공개 제품 저장소의 접근 권한과 Git/검색 도구가 필요하다.
   실행 검증을 요청받을 때만 각 저장소 지침에 따라 의존성·Node/package manager·
   네이티브 도구·환경파일·테스트 계정·Jira/Figma 등 연결 인증을 확인한다.
   이 세션은 새 기기의 런타임 준비를 검증하지 않았다. 인증·환경변수·설치 의존성·
   서버/시뮬레이터·로그인 세션은 Git 문서로 복원되지 않으며 비밀값은 여기에 적지 않는다.
5. 현재 기기의 컨텍스트 폴더는 `/Users/parkjongsun/Documents/ChatGPT/통합알림센터 프로젝트`다.
   오늘 확인한 폴더 내부 항목은 `.git`뿐이며 작업 branch의 commit·remote는 없다.
   이 폴더 자체는 원격 보존 수단이나 제품 checkout이 아니다. 별도 로컬 산출물 없이
   이 문서와 제품 저장소로 업무 상태를 복구한다. 옛 `통합알림센터` 경로는 없으므로
   기록된 cwd에 의존하지 말고 존재하는 절대 workdir을 명시한다.

- 2026-09-03 세션 개설, 9/11 기능 세션 역할 정렬, 9/28 사용자에 의한 컨텍스트
  폴더·앱 연결 경로 변경을 거쳤으며 각 정리는 구현 재개를 뜻하지 않는다.
- 기존 **통합알림센터세션** `01a065e6-afb2-75a0-b465-61c3e488a894`과 이력을 유지한다.
  이 ID와 기기 경로는 연결 참고값이며 새 기기에 동일 세션·앱 프로젝트·대화 전체가
  자동 복원된다는 보장은 아니다. 원격 개인 정본이 복구 기준이고 `~/.codex` 메모리는
  보조 자료다. `claude-personal-context`는 활성 정본이 아니다.
- 현재 확인된 대기는 기술 장애가 아니라 사용자 지시와 선행 작업·정책 조율 대기다.
  이번 기록을 저장한 뒤 추가 조사·구현·자동 감시 없이 대기한다.

## 이전 운영 정렬과 검증 — 2026-09-11

- 개인 컨텍스트를 `git pull --ff-only`하고 사용자 지정 순서로 공통 지침,
  `projects/dentlink-fe.md`, 웹·앱 체크포인트와 이 문서를 대조했다. 9/3 이후 이
  세션의 후속 구현·정책 확정은 없으며 기존 조사·결정·미정 사항을 보존한다.
  `claude-personal-context`는 활성 정본으로 사용하지 않는다.
- 아래 상태는 이번 읽기 검증 시점의 참조 위치다. 통합알림센터 구현 위치로
  배정된 것은 아니며, 현재 branch/HEAD를 새 작업의 base로 임의 사용하지 않는다.
  - 웹: `/Users/parkjongsun/Repository/dentlink-client`, `release/v1.86.0`,
    HEAD `0e0878ef1c5b1cc2dbec44c57a740e0e072cdad7`,
    upstream `origin/release/v1.86.0`, ahead/behind `0/0`, clean·미추적 없음.
  - 앱: `/Users/parkjongsun/Repository/dentlink-app`, `feature/DL-16061`,
    HEAD `a8f3a6cbb81c218b7ab16bed8e7d4b71fab45dd7`,
    upstream `origin/feature/DL-16061`, ahead/behind `0/0`, clean·미추적 없음.
  - 각 저장소의 등록 worktree는 위 main checkout 하나뿐이다. 필요한 원격
    branch만 fetch했으며 제품 파일·checkout branch는 변경하지 않았다.
- 현재 앱 PR #286의 `develop` squash merge를 GitHub에서 확인했다.
  merge 시각은 2026-09-11 15:09:46 KST,
  commit은 `c205fe0752e06c17866bc3873c94a5b6e2e492c2`다. 위 feature HEAD와
  결과 tree가 같고, 현재 `origin/develop`
  `f75d7d9b27a3bb32e69726dd6e6f8792c756a710`에 포함된다. 상세 이력·QA·배포
  상태는 `projects/dentlink-app.md`를 따른다. 완료 branch는 재사용하지 않는다.
- 웹의 기존 알림 REST 읽음 호출과 앱 공통 service/query/libs의 알림센터 읽음
  미연결 상태를 코드로 대조했다. 이번에 완료한 것은 운영·문서 정렬과 제한된
  Git·코드 검증이다. 새 기능 구현·테스트·사용자 QA·리뷰·배포를 수행하지 않았다.
  9/3 Swagger 확인은 당시 기록으로 보존하며, 실제 구현 시 필요한 계약을 다시 확인한다.
- 문서 변경 전 personal-context는 clean이었다. 앱 task 목록에서 이 기능 세션은
  active, 최상위 `메인세션`은 idle이며 다른 활성 제품 작성 세션은 확인되지 않았다.
  이는 당시 관찰이며, 구현 전 정확한 worktree·활성 작성자를 다시 확인한다.
- 한 worktree에는 활성 작성 세션을 하나만 둔다. 딥링크·인증·병원 전환 등 공통
  파일의 작업이 겹치면 최상위와 범위·작성자를 조율한다. 신규 일반 branch는
  `feature/<Jira>`이고, 작은 작업의 별도 worktree 필요 여부는 생성 전에 사용자에게
  확인한다. 현재 전용 Jira·구현 branch·base/PR 대상·release는 미정이다.
- 이번 정렬을 막는 미해결 운영 충돌은 없다. 목록 읽음 기준, 읽음 대상 식별·
  전달 방식, 실패·대상 삭제·재요청 정책은 기존 미정 상태이며 후속 결정 대상이다.
  ID 직접 전달과 여러 정보 조합 중 어느 방식도 임의 확정하지 않는다.

## 현재 사용자 확정 방향 — REST 기반

2026-09-03 후속 지침이 앞서 확정했던 실시간 동기화 요약을 대체한다. 구현 명세가
아닌 FE 작업 방향 요약이며, 상세 구현 목록·QA·인프라 항목을 불필요하게 늘리지 않는다.
아래의 당시 삭제 기능·읽음 정책 미정 설명은 10/26 최신 사전 준비 절의 삭제 UI 제외·클릭 읽음 방향으로 보완됐다. REST와 실시간 동기화 제외라는 사용자 결정은 유지한다.

### 웹 — Clinic / Lab

- 기존 알림 REST API와 React Query 흐름을 유지합니다. 알림 조회·읽음·삭제를
  REST로 처리하며, 기기 간 즉시 동기화를 위한 연결을 추가하지 않습니다.
- 알림 전용 SSE 상시 연결은 추가하지 않습니다. 기존 Lab 배송·픽업 SSE는
  이번 변경과 관계없이 그대로 유지합니다.

### 앱 — Office / Lab

- 알림센터를 구현한다면 목록·읽음·삭제는 기존 알림 REST API 연동을 기준으로
  검토합니다. 화면 진입 등 필요한 시점에 조회하며 기기 간 즉시 일치는 요구하지
  않습니다.
- 읽음·삭제 동기화를 위한 데이터 전용 FCM 처리는 추가하지 않습니다. 기존
  사용자 노출 푸시 및 FCM·Notifee 기능은 별개로 유지하며 제거하지 않습니다.
- 푸시 딥링크를 클릭해 진입할 때 해당 알림을 기존 REST로 읽음 처리하려는 요구가
  추가됐습니다. 기존·신규 딥링크 모두 공통 흐름으로 대응하는 방향이며, 구체적인
  읽음 대상 식별·처리 방식과 실패 시 읽음 기준은 미정으로 유지합니다.

### 공통 검토

- 알림센터 목록 자체의 노출·스크롤·클릭에 대한 **웹·앱 읽음 기준 통일이 필요**합니다.
  해당 정책은 PM 답변 대기이며, 푸시 딥링크 클릭 시 읽음 요구와 구분합니다.
- 현재 기기에서 REST로 읽음·삭제한 결과는 기존 React Query 갱신 방식에 맞춰
  반영합니다. 조회 시점·캐시 갱신은 실제 화면 정책과 기존 구현에 맞춰 검토합니다.
- 실시간 이벤트용 부분 갱신·중복 제거·순서 보정·재연결 처리는 범위에서 제외합니다.
  실시간 동기화를 대신하는 주기적 폴링도 별도 요구 없이 추가하지 않습니다.

## 확정 방향과 미정 사항의 경계

- REST 기반과 기기 간 실시간 동기화 제외는 확정됐으나 실제 구현이 완료됐다는
  뜻은 아니다. 웹의 통신 구조는 기존과 큰 차이가 없지만, 앱 알림센터 화면과
  REST 서비스 연동 같은 기능/UI 범위는 실제 작업 요구사항으로 별도 확인한다.
- **읽음 처리를 반드시 알림 ID 직접 전달 방식으로 구현하는 것은 아니다.**
  여러 정보를 조합해 읽음 대상을 판별·처리할 가능성도 열어 둔다. 어떤 정보를
  어디에 전달하고 FE/BE 중 어디에서 조합·처리할지는 미정이다. 기존 Swagger의
  ID 배열 계약은 확인한 현재 API의 사실이며, 최종 식별 방식까지 확정한 근거는 아니다.
- 알림센터 목록의 읽음 기준은 PM 답변 대기다. 클릭/노출/스크롤 중 하나를 임의로
  정하거나 기존 동작이 그대로 최종 정책이라고 가정하지 않는다. 푸시 클릭 시
  읽음 요구가 추가됐어도 상세 조회 실패·대상 삭제 시의 읽음 기준까지 확정된 것은 아니다.
- 기존 REST의 사용자·직원·사업장 범위와 실제 알림 화면 요구사항은 구현 시작 시
  확인한다. 신규 SSE endpoint, FCM 상태 동기화 이벤트 및 그 식별자/순서 계약은
  더 이상 현재 작업의 선행 조건이 아니다.
- 이전 대화의 실시간 이벤트 JSON과 무표시 FCM 논의는 과거 검토 자료다. 이를
  근거로 이벤트 인프라·앱 수신 로직을 구현하거나 필수 작업으로 보고하지 않는다.
- 이미 표시된 OS 푸시 삭제도 이번 변경에 포함되지 않는다.

## 사용자 경험에 맞춘 안내·보고 기준

- 사용자 실시간 메신저 웹 개발 경험의 원문 기준은 `PROFILE.md`의
  `실시간 웹 개발 경험과 안내 수준`이다. 근무 서비스명 자체는 저장하지 않는다.
- 이 경험은 Slack처럼 채팅·읽음·알림이 중심인 팀 협업 메신저의 웹 개발 맥락으로
  받아들인다. 제품의 성격을 바탕으로 사용자가 익숙한 실시간 상호작용을 파악하되,
  서비스 브랜드나 특정 제품의 내부 구현을 비교·추정하는 데 초점을 두지 않는다.
- REST 초기 조회 후 서버 이벤트로 상태를 갱신하는 개념과 구현의 큰 그림은 이미
  이해하고 있다는 전제에서 설명한다. 과거 경험과의 비교를 주된 보고 방식으로
  삼거나 기초 개념을 반복하지 않는다.
- 반대로 현재 Dentlink 코드, React Query와 모바일 플랫폼 세부 사항까지 모두
  안다고 가정하지 않는다. 변경된 REST 범위 안에서 다음 적용 지점을 짚는다.
  - 로그인/로그아웃·사업장 전환에 따른 REST 조회 범위와 캐시 처리
  - 읽음·삭제 mutation 후 캐시 반영/재조회와 화면 진입 시 조회 정책
  - 기존 웹 기능을 재사용할 부분과 앱 알림센터 UI/API 연동에 필요한 부분
  - FE에서 처리할 내용과 PM 읽음 정책·기존 BE REST 계약 확인이 필요한 내용의 경계
- 현재 코드에 있는 것, 추가해야 하는 것, 외부 정책/계약 대기를 구분하여 간략히
  보고한다. 사용자가 모를 수 있는 중요한 적용 조건은 질문을 기다리지 않고
  설명하되, 요청하지 않은 장황한 구현 명세나 기술 비교표는 만들지 않는다.
- 이 세션의 브리핑은 통합알림센터의 목적·작업·필요한 미정 사항에 집중한다.
  피드백 관련 부연이나 범위 밖 이야기를 반복하지 않는다. 실시간 동기화 제외는
  범위를 설명할 때 짧게 언급해도 된다.
- 위 안내 기준은 별도 세션/worktree로 이동하더라도 유지한다. 사용자 실시간 개발
  경험이 있다는 이유로 제외된 실시간 기능을 다시 제안하지 않는다. 구현 미착수·
  PM 읽음 정책 대기 상태는 유지한다.

## 코드 근거와 저장소

2026-09-03에 아래 경로를 읽어 기존 구조를 확인했다. 구현 시작 시 live Git과
해당 코드가 바뀌었는지 다시 확인한다.

- 웹: `https://github.com/Innvoaid/dentlink-client`
  - 기본 경로: `~/Repository/dentlink-client`
  - `clinic/src/components/Notifications/useNotificationsPagination.tsx`
  - `lab/src/components/Notifications/useNotificationsPagination.tsx`
  - `shared/ui/src/NotificationUI/NotificationUI.tsx`
  - `shared/models/src/messages/messages.apis.clinic.ts`, `messages.apis.lab.ts`
  - `lab/src/components/ServerSentEvent/ServerSentEvent.tsx`
  - 기존 알림 UI/REST/React Query와 Clinic 타 치과 알림 안내가 있다. Lab SSE는
    배송·픽업 작업 단위 연결이다. 웹 공통 UI에는 노출·스크롤 기반 읽음 처리가 있다.
- 앱: `https://github.com/Innvoaid/dentlink-app`
  - 기본 경로: `~/Repository/dentlink-app`
  - `shared/configs/utils/fcmHandler.ts`, `notifee.ts`
  - `shared/navigations/RootNavigator.tsx`
  - `shared/models/Api.ts`
  - 기존 FCM 수신/Notifee 표시 및 특정 채팅의 화면 갱신 후 표시 생략 분기가 있다.
    웹 같은 통합 알림센터 화면·알림 서비스 연동은 아직 없다. 기존 앱 복귀 시 OS
    badgeCount를 0으로 초기화하는 동작은 실제 구현 시 미읽음 정책과 함께 검토한다.
- SSE/FCM 경로는 기존 기능의 코드 근거일 뿐, 현재 알림센터 실시간 구현 대상은 아니다.

## 앱 딥링크·읽음 처리 조사 인계 — 2026-09-03

앱 피드백 세션의 조사 결과를 기존 계획과 대조해 반영했다. 기존 피드백 작업을
재시작하거나 알림센터 구현을 완료한 기록이 아니다.

### 당시 Git과 작업 경계 — 역사 기록

아래 Git·PR 상태는 2026-09-03 조사 당시 기록이다. 현재 위치·역할과 재개 조건은
최상단의 최신 체크포인트를 따르며, 과거 branch/HEAD를 신규 작업에 재사용하지 않는다.

- 앱 `~/Repository/dentlink-app`: `feature/DL-16061`,
  `c6355a33521c69ed0c3d4cb656245ac7b2ed5e9e`. 이번 fetch 후 원격과 같은 clean
  상태를 확인했고 인계 당시 HEAD와 일치한다.
- 웹 `~/Repository/dentlink-client`: `feature/DL-16258-release-hold`,
  `af496bb345aa4ad28790de699156ebc9cc85635f`. 이번 fetch 후 원격과 같은 clean
  상태를 확인했다. 세션 개설 때의 `feature/DL-16269`에서 바뀌었으므로 옛 브랜치를
  현재 작업 위치로 가정하지 않는다. 이 세션에서 브랜치를 변경하지 않았다.
- 두 세션이 같은 앱 체크아웃을 참조할 수 있다. 실제 구현 지시가 생기면 현재
  브랜치와 파일 작업 범위를 먼저 확인하고, 피드백 브랜치에 알림센터 작업을
  임의로 섞거나 다른 세션의 브랜치를 바꾸지 않는다. 사용자 지시 없이 worktree를
  만들지 않는다. 구현할 브랜치와 파일 소유 범위는 아직 정하지 않았다.
- 이번 검증은 Git·코드·개발 Swagger의 읽기 확인이다. 실제 읽음 PATCH, 앱 실행,
  런타임 QA, PR 변경이나 배포는 하지 않았다. 인계의 PR #286 상태는 당시 기록이며
  이번 대조에서 PR 상태를 새로 확인하지 않았다.

### 공통 흐름과 식별자

- 요구 흐름: 로그인 준비 → 대상 병원과 사용자 소속 확인·전환 → 지정 화면 또는
  동작 실행 → 필요하면 해당 알림을 기존 REST로 읽음 처리한다. 이 순서가 모든
  현재 딥링크에 이미 구현돼 있다는 뜻은 아니다.
- `employerId`는 병원/사업장 ID, `employeeId`는 로그인 사용자의 해당 병원 소속 ID,
  `orderId` 등은 랜딩 화면의 업무 데이터 ID다. `notificationId`를 사용하는 안에서는
  읽을 알림 레코드 ID를 뜻하지만, 이 필드를 필수 전달값으로 확정하지 않았다.
  사용자가 병원 전환을 employeeId로 표현했더라도 현재 URL의 병원 계약은
  employerId 기준이다. 앱은 사용자 소속 목록에서 대응하는 employeeId를 찾는다.
- 같은 화면으로 오는 생성/수정/재수정 알림은 읽음 정책에 맞게 대상을 구별할
  근거가 필요하다. 알림 ID를 직접 쓰거나 여러 정보를 조합하는 방식 모두 검토
  가능하며, 정보 조합의 구성과 판별 규칙을 임의로 정하지 않는다.
- `/lists/item?notificationId=1001`, `1002`, `1003`과
  `unreadNotificationIds: [1003]`은 인계 당시 ID 직접 전달안을 설명한 예시다.
  최신 사용자 보완에 따라 필수 구현 방향으로 취급하지 않는다. 화면 주소만으로
  읽음 대상을 추측하지 않고, 사용할 정보와 처리 규칙은 실제 계약으로 확인한다.

### 기존 코드에서 재확인한 사실

- `shared/configs/constants/deepLink.ts`는 Office/Lab 경로, screen/action,
  `setEmployerId` sideEffect를 정의한다. Home/Profile 등 탭 경로는
  `shared/libs/useNavigationConfig.ts`에도 있으므로 이 설정 파일만의 변경으로
  전체 경로를 처리했다고 볼 수 없다.
- `useNavigationConfig.ts`는 URL 해석·소속 매핑·이동·중복 방지와
  Linking/Airbridge/deferred 경로를 담당한다. `applyDeeplinkEmployerId`는 소속을
  찾지 못해도 employerId만 변경하고 기존 employeeId를 남길 수 있다. 향후 읽음
  요청 전에는 대상 소속이 확인되고 실제 요청 헤더에 적용됐는지 확인해야 한다.
- `shared/libs/useEmployeeProfile.ts`의 `handleChangeEmployee`에는 서버 활성화,
  관련 query 갱신과 실패 시 복원 흐름이 있다. 현재 딥링크 sideEffect의 store
  변경은 이 비동기 활성화 완료와 같지 않으므로 공통 처리 순서를 따로 검토한다.
- `shared/configs/utils/fcmHandler.ts`는 기존 `data.deeplink` URL에 `landBy=push`,
  `pushTitle`을 붙여 전달한다. 별도 FCM data 필드를 선택한다면 URL만 넘기는
  경계에서 읽음 처리에 필요한 정보를 명시적으로 보존해야 한다.
- `RootNavigator.tsx`는 로그인·CodePush·navigation 준비 후 보관한 URL을 다시
  처리한다. 9/3 조사 당시 Airbridge와 피드백 이동의 읽음 정보 보존은 연결되지
  않았다. 피드백 이동 자체는 9/8 상세 직접 진입으로 변경됐으므로 아래 최신
  보호 동작을 따른다. 읽음 대상 식별·정보 보존은 별도로 계약을 확인한다.
- URL/경로 기반 이동 중복 방지와 읽음 대상별 처리를 분리해야 한다. 같은
  화면으로 오는 서로 다른 알림을 버리지 않고, 같은 알림의 FCM/Linking/Notifee
  중복 콜백에 따른 읽음 중복 요청은 제어한다. 이 처리는 제외된 실시간 동기화용
  이벤트 처리와 구분한다.
- 앱의 `shared/services`, `shared/queries`, 관련 공통 훅·피드백 코드에서
  알림센터 읽음 REST 호출 연결을 찾지 못했다. 생성된 `shared/models/Api.ts`의
  모델/메서드 존재는 실제 호출 증거가 아니다. OS 배지 0 처리·채팅 읽음은 별개다.

### 개발 Swagger 재확인과 미정 계약

- 2026-09-03 **17:23 KST**, 저장소의 생성 스크립트가 참조하는
  [개발 Swagger](https://dev-api.dentlink.io/v3/api-docs)를 HTTP 200으로 다시 조회했다.
  인계의 15:09 KST 조사와 동일하게 `PATCH /messages/notifications/read/partial`은
  `NotificationReadUpdateDto`의 `unreadNotificationIds` 정수 배열을 받는다.
  예시 body는 `{"unreadNotificationIds":[789]}`이며, 알림 목록의
  `NotificationDto.id`는 알림 ID로 정의돼 있다. 새 읽음 API가 필요하다고 가정하지 않는다.
- Swagger는 Bearer 인증과 Employee-Id / Employer-Id 헤더를 명시한다. 앱
  `shared/configs/utils/fetcher.ts`가 현재 auth store에서 이 헤더를 설정하는 것과
  웹 Clinic/Lab의 기존 동일 endpoint 호출을 코드로 확인했다. 실제 요청 성공이나
  서버 권한 검증 동작까지 시험한 것은 아니다.
- 아직 미정: ID 직접 전달 또는 여러 정보 조합 등 읽음 대상 식별·처리 방식,
  필요한 정보와 URL query/기존 FCM payload 등 전달 위치·key, FE/BE 처리 책임과
  REST 계약 연결 방식, 이미 읽은 알림의 재요청 동작, 상세 조회 실패/대상 삭제 시
  읽음 여부, 같은 대상의 과거 알림까지 함께 읽을지 여부다. notificationId query는
  후보 중 하나이며 BE 확정·구현 완료 계약으로 취급하지 않는다.
  별도 요구가 없다면 클릭한 알림 하나만 읽는 방향으로 두고 임의 일괄 처리는 하지 않는다.

### 보존할 동작과 향후 구현 조건

- 기존 링크의 이동·동작은 유지한다. notificationId가 없다는 이유만으로 읽음
  가능 여부를 결정하지 않고, 최종 계약의 정보로 읽음 대상을 특정할 수 있는지
  확인한다. 병원 정보가 없는 링크는 기존 문맥을 유지하되, 타 병원 알림은 목표
  병원이 확실하게 전달되도록 계약을 확인한다. 계정/병원 전환 중 다른 소속으로
  읽음 요청이 나가지 않아야 한다.
- BE도 로그인 사용자/소속이 해당 알림을 읽을 권한이 있는지 검증해야 한다.
  읽음 실패를 성공으로 기록하지 않으며, 읽음 실패가 정상 랜딩을 막지 않도록 하는
  방향을 권장한다. 상세 조회 실패 시의 읽음 정책은 위 미정 상태를 유지한다.
- 채널톡 action, 주문 상태별 분기, 이미 열린 채팅 유지 등 특수 동작을 일반적인
  screen navigation으로 덮어쓰지 않는다. Airbridge query 전달과 로그인 전 보관·
  재진입 경로도 공통 범위에서 확인한다.
- 피드백 정본은 목록 `dentlink://feedback/{employerId}`, 상세
  `dentlink://feedback/{employerId}?orderId={orderId}`다. **9/3의 목록 경유 설명은
  9/8 직접 진입 변경으로 대체됐다.** 유효한 외부 상세 URL은 목록 없이 native
  상세를 직접 열며 해당 진입의 뒤로/닫기/Submit 성공/조회 실패는 Home으로 돌아간다.
  9/11 `shared/configs/utils/deepLink.ts`와 `useNavigationConfig.ts`에서 직접
  진입 stack을 확인했다. 사용자 정상 동작 확인은 최신 앱 체크포인트에 기록돼
  있으며 이번에 재실행한 QA는 아니다. 기존 다른 진입 경로의 복귀 동작을 보존한다.
- 이미 구현된 피드백 Amplitude `push_click` 분류는 알림 읽음 ID 계약이나 수신
  설정 API의 pushType과 별개다. 기존 피드백 기능·설정 후속 작업은 피드백 세션의
  `projects/dentlink-app.md`를 따른다.
- 터미널은 최신 `AI_WORKFLOW.md`에 따라 정확한 checkout의 사용자에게 보이는
  Codex 관리 터미널을 사용하고, 작업에 필요할 때 열어 명령 작업 후 닫는다.
  과거 IDE 터미널 규칙은 대체됐으며 사용자가 관리하는 IDE 터미널을 조작하거나
  의존하지 않는다. 운영 정렬은 제품 구현·커밋·푸시·branch/worktree·PR·배포
  권한을 추가하지 않는다. 기존 명시적 권한은 보존하고 일반적인 진행 지시로 확대하지 않는다.

## 방향 변경 이력 — 2026-09-03

- 초기 검토: 웹 알림 전용 상시 SSE + REST, 앱 무표시 데이터 FCM + REST로
  다중 기기 읽음·삭제 동기화를 검토하고 공유 요약을 확정했었다.
- 후속 사용자 결정: 실시간 동기화를 제외하고 각 기기의 화면 상태가 즉시 맞지
  않아도 진행한다. **현재 기준은 REST 기반**이며 초기 실시간안은 더 이상 유효한
  구현 지침이 아니다. 가칭 통합알림센터와 사용자 경험/보고 선호는 유지한다.
- 읽음 식별 방식 보완: 알림 ID 직접 전달은 필수가 아니며 여러 정보를 조합해
  처리할 가능성도 있다. 구체적인 식별·전달·처리 계약은 아직 정하지 않았다.

## 다음 시작점

사용자의 별도 재개 지시가 있을 때만 아래를 진행한다. 최상단 9/29 체크포인트의
선행 권한관리 관계·복구 조건·대기 상태를 우선한다.

1. 개인 컨텍스트를 pull하고 최신 공통 지침, `PROJECTS.md`,
   `projects/dentlink-fe.md`, 관련 웹·앱 체크포인트와 이 문서를 읽는다.
2. REST 기반과 이번 공통 딥링크 인계를 함께 기준으로 삼는다. PM의 목록 읽음
   정책, 읽음 대상 식별·정보 전달·처리 계약과 재요청·실패 정책, Jira·설계가
   추가되면 확정/미정을 갱신한다.
3. 실제 구현 지시가 생기면 최상위와 정확한 작업 위치·base/PR 대상·release·
   공통 파일 작성 범위를 조율한다. 변경 전 각 저장소의 branch·HEAD·upstream·
   ahead/behind·dirty/미추적·worktree·활성 작성자를 확인하고, 필요한 Git·코드·
   Swagger를 대조한다. 로그인·소속 전환·이동/동작·읽음 연결과 최신 직접 진입
   동작을 함께 보존하며 완료된 기능을 다시 시작하지 않는다.
4. 현재는 조사·계획 단계다. 별도 폴더/worktree 없이 두 저장소를 참조하며,
   이번 운영 정렬만으로 제품 코드 수정이나 branch/worktree 생성을 시작하지 않는다.
5. 의미 있는 마무리에는 이 문서의 상세 기록을 정리해 개인 컨텍스트만 commit·push한다.
   최상위에는 기능 범위·결정, 웹/앱 작업 위치·Git 상태, 구현/검증 근거, 미정·질문,
   공통 변경 영향, 남은 작업·다음 시작점을 요약한다. `projects/dentlink-fe.md`에는
   기능 간 결정·조율 상태만 두며 상세 이력을 복제하지 않는다. 구현·코드 검증·
   사용자 QA·review·merge·release 포함·배포·운영 확인은 각각 구분한다.
