# Dentlink 통합알림센터 — 현재 체크포인트

최종 갱신: 2026-11-03 — 사용자 지시로 알림센터·추가 앱 목록과 이메일 작업의 범위를 분리했다. 이번에는 Notion·Jira·개인 컨텍스트만 정리했으며 제품 코드·branch/worktree·PR·배포·서버는 변경하지 않았다. 다음 코드 작업은 사용자 재개 지시를 받은 뒤 진행한다.

## 현재 범위와 완료 경계

- **이번 기능:** Clinic/Lab 웹 알림함·수신 설정, Office/Lab 앱 알림함·수신 설정, 인박스 알림(NOTIFICATION) 클릭 및 앱 푸시(PUSH) 클릭의 랜딩·딥링크·REST 읽음 연결, 합의된 추가 앱 조회 목록이다.
- **추가 조회 목록:** Office 크레딧 잔액·이력과 청구서 목록(DL-17202). 결제내역·PDF·Pay Now 등 미확정 후보를 자동 포함하지 않는다.
- **사용자 확정:** 추가 목록은 노티·푸시 외 별도 메뉴가 없어도 수용한다. 메뉴 개선은 후속이며 현재 작업의 선행 조건이 아니다. 이미 목록이 생겼다는 이유로 시트의 ‘알림센터 오픈’이나 이동 없음 정책까지 임의 변경하지 않는다.
- **이메일은 완전히 별도:** 이메일 CTA·앱 설치 여부에 따른 웹/앱 연결·웹 fallback·SES·이메일 분석/클릭 추적은 이 기능의 검토·구현·검증·완료 조건에 포함하지 않는다. [별도 이메일 체크포인트](dentlink-email-cta-tracking.md)와 DL-17183→DL-17187에서 관리한다.
- 기존 알림 설정의 **Email 수신 채널 표시·저장**은 이메일 CTA/추적과 다른 기능이다. 이번 분리를 승인된 수신 설정 UI 삭제 근거로 확대하지 않는다.
- **현재 구현:** 실제 진입점에 연결한 알림 UI 선행 개발 + 추가 Office 목록의 기존 REST 연결까지 있다. 알림 목록·읽음·수신 설정·소속 전환의 실제 BE 연결은 미완료다. PR·merge·배포·최종 QA 완료가 아니다.

## 이번 문서 정리 완료 — 2026-11-03

### Notion: 같은 상위 위치의 세 영역

세 기존 페이지를 Development Documents data-source(`26366594-1ec5-423c-b7c3-35abe1e047f2`) 직속으로 정렬했다. 기존 페이지 ID와 공유 링크를 유지했고 실제 부모·제목·자식 관계를 확인했다.

| 영역 | 현재 문서 | 보존·분리한 내용 |
| --- | --- | --- |
| 원본 앱 미지원 조사 | [모바일 웹 대비 앱 미지원 기능 현황](https://app.notion.com/p/innovaid/3fece072e82f80d5a02fda9a76cd51b7) | Clinic/Lab 1차 조사·통합 회의 원본 그대로 유지 |
| 알림센터 병행 앱 목록 | [앱 지원 추가 항목 검토·구현](https://app.notion.com/p/innovaid/40cce072e82f81439d7bc253192e966b) | 최신 구현 범위·진입점 원칙을 상단에 명시. 기존 후보 표·사용자 의견은 이전 검토 이력으로 보존 |
| 별도 이메일 작업 | [이메일 CTA 웹·앱 연결·추적](https://app.notion.com/p/innovaid/40cce072e82f81fda0e2d123259d5501) | 이메일 내용과 과거 후보 표의 이메일 행을 이동. FE/BE 비교·SES 조사 두 페이지를 이 대문 바로 아래로 이동 |

- 후보 표의 이메일 행만 분리했으며 나머지 6개 후보 행·사용자 의견은 보존했다. 과거 ‘앱 화면 없음/미선정’ 설명은 현재 구현 상태가 아니라 이전 조사임을 표시했다.
- 팀 공유 Notion에는 범위·상태·일반 기술 근거를 두고 개인 확인 순서·작업 권한·기록 관리는 개인 컨텍스트에 둔다.
- PRD·Figma·FigJam·Sheet·Slack 기획 원문은 수정하지 않았다. 이번 정리는 원문 전체의 신규 업데이트 조사나 폴링이 아니다.

### Jira: 기존 카드 정리

- [DL-17202](https://innovaid.atlassian.net/browse/DL-17202), DL-17174 하위: Office 크레딧·청구서 목록과 노티/푸시 진입 연결·검증. 메뉴 결정 대기를 제거하고 미확정 결제내역은 제외했다.
- [DL-17179](https://innovaid.atlassian.net/browse/DL-17179), DL-17174 하위: 후보 검토 완료 이력과 문서 제목·DL-17202 연결을 정리했다. 이메일은 현재 후보 검토 범위에서 제외했다.
- [DL-17187](https://innovaid.atlassian.net/browse/DL-17187), DL-17183 하위: 이메일 CTA 웹·앱 연결·분석/SES·BE 연동을 별도 담당한다. 배포일뿐 아니라 알림센터 개발·완료 범위에서도 분리했다.
- 기존 담당·상태를 유지했다. 새 카드·댓글·상위 카드·다른 담당 카드 변경은 없다. 저장 응답으로 최종 본문을 확인했다.

## 제품 작업 위치와 검증 근거

아래는 **2026-11-03 문서 정리 중 로컬 Git 재확인** 결과다. 세 checkout 모두 clean이며 로컬 tracking 대비 차이 표시가 없다. 마지막 구현·commit/push·기기 실행 근거는 11/2 이력이다. 이번 정리에서 원격 제품 배포나 새 런타임 검증을 수행한 것은 아니다.

| 제품 | checkout | branch | HEAD |
| --- | --- | --- | --- |
| Web | `/Users/parkjongsun/Repository/dentlink-client-notification-center` | `feature/DL-17058` | `6dca5142ba4b179c92d580bc19a4b089f9718b6d` |
| Office | `/Users/parkjongsun/Repository/dentlink-app` | `feature/DL-17059` | `e983956b17202e436ebda323eb2b471403ba2b38` |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app` | `feature/DL-17060` | `c3120118a1d9628be900fa96051e5eae36c59ce4` |

- **Web:** 실제 헤더·모바일 메뉴에 알림함·수신 설정·소속 선택 UI를 연결했다. 전체/안읽음·목록 상태·전체읽음·소속 이동 토스트 등은 선행 UI이며 새 알림 데이터/설정/활성화는 메모리 mock 상태다.
- **두 앱:** 실제 Home bell/Root 경로의 알림함·설정·소속 선택, OS 상태 조회/설정 안내와 전역 OS OFF 1회 팝업을 선행 구현했다. 서버 설정 저장·실제 소속 활성화·푸시 읽음 연결은 아직 아니다.
- **Office 추가 목록:** 크레딧 잔액·이력과 청구서 목록에 기존 REST를 연결했다. 지정된 노티/푸시의 최종 진입·계정/소속·권한은 실제 계약과 맞춰 검증해야 한다.
- **공통 URL 처리:** 로그인 전 URL 보관·탭 복원·최신 URL 소비·늦은 이전 요청의 화면 덮어쓰기 방지를 보완했다. 기존 특수 동작과 다른 기능 소비자를 보존해야 한다.
- 웹 PC/모바일 및 양 앱 iOS/Android UI 실행 검증 이력이 있다. 11/2 최종 코드의 Office Credits/Statements 실조회, 두 앱 탭/deferred·주문/Help 검증과 제한은 [전체 이력](archive/dentlink-unified-notification-center-through-2026-11-03.md)에 보존했다.
- 실제 로그아웃·재로그인 전체 경로, 실제 푸시 중복 콜백, 전체 역할·권한 및 최종 BE 연결 QA를 모두 끝낸 것은 아니다. 전체 tsc/lint의 기존 범위 밖 오류와 변경 범위 통과를 구분한다. 이후 코드 변경 시 영향 화면·소비자·역할을 최종 코드로 다시 실행 검증한다.
- 새 Storybook 파일은 제거했다. 실제 화면을 구현하며 불필요한 Storybook·개인 인계 파일을 제품 저장소에 추가하지 않는다.

### 문서 분리와 코드 분리

- 기존 feature에는 공통 URL 처리와 이메일을 고려한 HTTPS/native 도메인·AASA/assetlinks 변경이 함께 있다. **이번에는 코드 분리·제거를 하지 않았다.**
- 다음 코드 작업 첫 단계에서 공통 노티/푸시 필요 변경·추가 목록·이메일 전용 변경을 분류한다. 공통 동작을 확인하기 전에 임의 revert·cherry-pick·새 branch로 분리하지 않는다.
- 이메일 전용 검증/서명·배포 문제를 알림센터 차단 조건으로 되돌리지 않는다. 실제 공통 코드나 전달 단위에 영향이 있는 부분만 이 기능에서 다룬다.

## 유지할 기능 정책

### 알림 목록·읽음·랜딩

- 목록·읽음은 기존 REST를 우선 재사용한다. 기기 간 실시간 동기화·알림 전용 SSE·읽음 동기화용 silent/data FCM·대체 주기적 폴링은 제외한다. 기존 사용자 노출 FCM/Notifee와 Lab 배송·픽업 SSE는 유지한다.
- 소속별 최신순, 전체/안읽음 탭, LinkTalk 인박스 제외가 기준이다. 노출·스크롤만으로 읽지 않으며 개별 클릭·전체읽음·푸시 클릭을 읽음 계기로 삼는다. ‘개별 읽음 제외’는 별도 읽음 버튼을 두지 않는 의미다.
- 현재 요구에는 삭제 UI·신규 FE 삭제 호출이 없다. 기존 DELETE API 폐기나 다른 사용처 제거까지 확정한 것은 아니다.
- [PM 10/29 13:55 답변](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793249757598429)에 따라 푸시는 클릭 기준이며 대상 삭제·권한 없음으로 랜딩하지 못해도 읽음 대상이다. 인증·해당 소속 준비 후 요청하고 요청 실패는 읽음 완료로 기록하지 않는다.
- `notificationId` 직접 전달은 필수가 아니다. 다른 정보 조합도 가능하되 같은 화면으로 가는 서로 다른 알림을 구분해야 한다. 업무 ID·랜딩 URL만으로 알림 identity를 추측하거나 과거 알림까지 임의 일괄 읽음 처리하지 않는다.
- 알림 읽음과 자체 BE 푸시 클릭 이력은 별개다. BE가 한 API에서 읽음까지 처리할지 FE가 따로 호출할지·식별정보/전달 위치는 최신 계약으로 확인한다.
- 같은 알림의 FCM/Linking/Notifee 중복 콜백 제어와 같은 화면으로 가는 다른 알림 처리는 구분한다. 로그인 대기·employerId→해당 employeeId 확인/활성화·특수 딥링크 동작을 보존한다.
- Web/App 및 NOTIFICATION/PUSH 랜딩은 [알림 현황표](https://docs.google.com/spreadsheets/d/1w1xwwEWRE0KgiJsOvldxIFbtNgWguohurf5kemIrW_g/edit?gid=614410508#gid=614410508)로 대조한다. 이메일 CTA 표와 혼용하지 않는다.

### 수신 설정·OS 권한

- Employee 기준 서버 수신 설정을 웹·앱에서 공유하고 기기 OS 권한은 분리한다. 웹 PUSH 조작은 숨긴다. Office/Lab 지원 채널을 구분하며 Office 구성을 Lab에 그대로 복제하지 않는다.
- 신규 가입·신규 소속 PUSH ON, 기존 PUSH 선택 보존 방향을 유지한다. 실제 초기값·마이그레이션은 BE 계약으로 확인한다. **Lab My Orders는 제외 확정**이며 과거 제안/티켓 제목으로 되살리지 않는다.
- 상위 OFF는 하위 OFF, 상위 다시 ON은 하위 기본 ON이다. 하위를 모두 OFF해도 상위까지 자동 OFF하지 않는다. 숨긴 채널을 저장 시 덮어쓰지 않도록 실제 catalog/저장 규칙과 맞춘다.
- MEMBER의 My Orders 수신은 Assigned Dentist 기준이다. 알림 수신 설정과 홈/주문/LinkTalk 조회 필터는 이름만으로 합치지 않는다. Office `usePersonalOrdersPreference`의 `pushEnable:true` 결합도 함께 점검한다.
- LinkTalk/Support Push 설정은 자동 이벤트 채팅 자체를 끄는 의미가 아니다.
- OS OFF에서 특정 PUSH 선택→OS 설정→정상 복귀 후 권한 ON이면 선택한 항목만 저장한다. 재시작·계정/소속 변경 등 흐름이 끊기면 과거 선택을 버리고 서버 저장값을 유지한다. 임의 유효시간이나 복잡한 복구 정책을 발명하지 않는다.
- 기존 `PermissionProvider`의 OS 허용과 서버 preference 초기화/upsert 결합은 남아 있다. 새 OS 조회 hook이 있다는 이유로 분리가 완료됐다고 판단하지 않는다.
- **전역 OS OFF 팝업:** 10/30 17:30 기기별 로컬 1회 노출 선행 구현 완료. 실제 표시 후 기록하며 계정·병원 변경으로 초기화하지 않는다. 재설치·이력 유실로 재노출되는 것은 수용한다.
- **설정 화면 파란 배너:** 마지막 조사에서 노출 주기·닫기/재노출 정책은 미정이었다. 전역 팝업과 같은 UI로 취급하거나 팝업까지 미구현으로 되돌리지 않는다.
- **도메인/카테고리 표시:** 10/30 18:01 사용자 결정으로 BE 계층/명칭을 그대로 노출할 의무가 없다. 같은 원본 row 안에서 하위 카테고리를 상위처럼 보이게 하거나 도메인을 숨길 수 있다. 저장 식별자를 유지하고 무관한 row는 합치지 않는다. `title`, `key/label` 분리는 준비됐지만 실제 enum/catalog adapter는 미확정이다. [디자인 기준](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=314-23253)

### 소속 전환·미읽음 표시

- 올바른 employer/employee 활성화 후 해당 소속 알림을 보여준다. 웹은 성공 후 대상 알림 팝업 한 번 자동 열기·토스트까지 가능한 방향이며 앱은 대상 스크린으로 연결한다.
- 알림에서 이동했는지, 이전/이후 병원명은 이번 이동의 임시 정보로 처리할 수 있다. 이 목적만으로 영속 저장·신규 BE API를 요구하지 않는다. 현재 선택/토스트 mock을 실제 활성화 완료로 보고하지 않는다.
- 벨 미읽음 점은 모든 소속 중 미읽음 존재 여부, 현재 목록·전체읽음은 현재 소속 기준이다. 위치별 숫자/점과 집계 응답은 최종 디자인·BE 계약에 맞춘다.

## 남은 일과 다음 코드 작업 순서

지금은 문서 정리 완료 후 대기한다. 아래는 **다음 사용자 재개 요청 시 진행할 순서**이며 이번에 구현을 시작하지 않는다.

1. 정확한 checkout·Git·활성 작성자를 확인하고 현재 diff의 알림센터/추가 목록/공통 딥링크/이메일 전용 경계를 분류한다. 기존 완료 작업을 보존하고 전달 단위만 필요한 만큼 정리한다.
2. 최신 Notion 정책·Figma 변경 및 DEV Swagger를 현재 구현과 대조한다. 과거 조사 전체를 재시작하지 않는다. 새 API를 요구하기 전에 실제 명세를 확인한다.
3. 목록·미읽음/소속별 집계·수신 catalog/default/migration·읽음/푸시 클릭·Web/App 랜딩 계약에 맞춰 연결 범위를 정한다. 미확정 BE payload/enum을 임의 확정하지 않는다.
4. 노티/푸시→로그인 준비→올바른 소속→지정 화면/동작 및 정책상 읽음을 연결한다. 추가 Office 목록도 시트에서 정한 진입으로 검증한다. 별도 메뉴·이메일 자동 앱 실행을 선행 조건으로 추가하지 않는다.
5. 실제 API 연결 시 임시 catalog/ID/mock store·data·개발 분기를 정확히 제거한다. OS/preference 결합·숨긴 채널·소속/계정 전환·중복 콜백도 함께 검증한다.
6. 최종 코드로 웹 PC/모바일과 두 앱 iOS/Android의 영향 화면·공통 소비자·역할/권한을 실행 검증한다. 정적 검사·에이전트 검증·사용자 QA·PR·merge·release·배포를 구분한다.

남은 구체적 확인은 목록/집계·설정 catalog·기존값 보존·푸시 식별/클릭 계약, 파란 설정 배너 정책, Lab Home 최근 메시지/Support·자동 메시지 숨김의 실제 범위 등이다. **해당 구현에 도달했을 때 최신 문서/코드로 먼저 해결하고 정말 남는 결정만 사용자에게 질문한다.** 전체 기획·BE가 미완성이라는 이유로 확정 UI까지 다시 미착수로 돌리지 않는다.

## 정본 자료·Jira·이력

- 정책: [Notion PRD](https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd). 화면: [Figma](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=2-6). 원 기획: [FigJam](https://www.figma.com/board/U9Qpm6ACzjGFKyrCoaAuvA?node-id=33-3714).
- 결정 근거: [UX 논의](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793063024060739), [푸시 클릭/읽음](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793244658608799), [앱 추가 목록 회의](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793596568281269). 최신 명시적 사용자 정정과 날짜 있는 후속 결정을 오래된 문장보다 우선한다.
- 알림센터 상위 [DL-16140](https://innovaid.atlassian.net/browse/DL-16140). 공통 DL-17057, Web DL-17058/17061/17062, Office DL-17059/17063/17064/17065, Lab DL-17060/17066/17067/17068, UX 사전 검토 DL-17048. 실제 카드 상태·범위는 재개 시 확인하며 카드명만으로 제외 범위를 복원하지 않는다.
- 추가 목록: DL-17174→DL-17202, 후보 검토 DL-17179. 원본 앱 비교 세션 역할은 [모바일웹/앱 차이 체크포인트](dentlink-mobile-web-app-parity.md)를 참조한다.
- 마지막 DEV Swagger 조사: **11/2 11:35**. 기존 `PATCH /messages/notifications/read/partial`, body `unreadNotificationIds: []`, Bearer·Employee-Id/Employer-Id 맥락을 확인했다. 오늘 새 조회한 명세가 아니며 최신 목록/설정/클릭 API 확인을 대체하지 않는다.
- 과거 FE API 제안서는 확정 BE 계약이 아니다. 상세 조사·UX 합의·소스/기기 증거·공수 산정·이전 정확한 Git 이력은 [2026-11-03 분리 전 전체 이력](archive/dentlink-unified-notification-center-through-2026-11-03.md)에 보존했다. 과거 ‘현재/다음’ 지시는 최신 범위를 되돌리지 않는다.

## 운영 경계

- 이 세션은 통합알림센터 기능을 Web/Office/Lab 함께 담당하며 [FE 상위 세션](dentlink-fe.md)은 공통 조율을 담당한다. 새 세션·worktree를 자동 생성하지 않는다.
- 제품마다 정확한 저장소·활성 작성자를 확인한다. Web 신규 일반 작업은 최신 origin/master, 두 앱은 origin/main 기반 feature/<Jira>→해당 release→main이다. 남은 develop을 신규 기준으로 쓰지 않는다.
- 제품 commit/push는 기존 명시 권한 범위에서만 수행하고 PR·merge·배포는 별도 권한이다. 현재 요청은 문서 정리이므로 제품 변경/실행을 재개하지 않는다.
- Slack은 읽기 전용이며 자동 폴링은 중단 상태를 유지한다. 팀 공유 문서와 개인 작업 메모를 구분하고 의미 있는 마감에 개인 컨텍스트만 commit/push한다.
