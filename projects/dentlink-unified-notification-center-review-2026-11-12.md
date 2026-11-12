# 통합알림센터 전체 변경 재검토 · 2026-11-12

상태: 승인된 명확한 제품 수정·최종 검증·commit/push·리뷰 재확인 완료. 별도 밀링 FILE 통합 리뷰1건과 미정 BE 항목은 아래와 같이 분리한다. merge·배포 없음.

## 이번 사용자 요청과 범위

- 다른 에이전트 작업을 받아들인 재개 동기화에 이어, [본인 Slack 잔여 목록](https://innovaidhq.slack.com/archives/D051EPNM9NW/p1794479074320419)을 먼저 읽고 웹·Office·Lab 알림센터 전체 변경을 규약/요구사항 기준으로 검토·수정한다.
- 앱 개발자/CodeRabbit 리뷰 검증, 기존 PR 유지, commit/push까지 승인. 배포·merge는 하지 않는다. 배지 개선·추가 사용자 설정은 BE 협력 대상이므로 이번 구현에서 제외한다.
- 추가 지시로 Jira에서 BE가 알림 설정 API 변경을 알린 댓글과 사용자 후속 의견도 원문 대조했다. '오늘' 결과는 이 요청에서 실제로 확인·변경한 내용만이며 과거 구현을 이번 완료로 섞지 않는다.
- 원래 Codex 구현뿐 아니라 11/10~12 다른 에이전트의 설정 DTO/렌더/검증 변경과 Swagger 재생성에 따른 공용 소비처까지 검토한다. 생성 DTO 전체의 의미나 전체 제품 QA를 전수 검증했다고 주장하지 않는다.

## 확인한 요구사항과 현재 판단

| 근거 | 확인 결과와 처리 |
| --- | --- |
| [BE DL-17114 댓글44978](https://innovaid.atlassian.net/browse/DL-17114?focusedCommentId=44978), 11/10 22:09 KST | GET/PUT 경로는 그대로. 새 GET employee/user, categories/channels 배열순서, Lab orderScope=null/options=[], Office MEMBER 단일 옵션, 전체 PUT에서 생략 시 초기화, readonly 메타 제거 계약을 세 제품 코드/기존 테스트와 대조. 다른 에이전트가 이미 이전한 코드가 기반이며 이번 신규 API 개발이라고 보고하지 않는다. |
| [사용자 댓글44994](https://innovaid.atlassian.net/browse/DL-17114?focusedCommentId=44994), 11/12 17:04 KST | toggleChannel은 노출 플랫폼이 아니라 토글 채널이라는 지적. platforms 등 별도 키 요청에 답변 없음. 임시 웹 PUSH 숨김을 확정 계약으로 바꾸지 않는다. 숨긴 설정 값은 전체 PUT에 보존한다. Jira 알림 목록 자체를 읽었다고 하지 않으며 실제 관련 카드 댓글 원문을 조회했다. |
| [헤더 노출 확정](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794294732127519) | PM/사용자가 Lab 밀링 포함 모든 관련 desktop/mobile 헤더에 우선 노출하기로 함. 기존 custom rightContent·hiddenOnDesktop·밀링 별도 헤더에서 빠지는 부분을 보완한다. 로그인/비공개 권한 경계는 유지한다. |
| [병원 선택 디자인/문구](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794211574467219), Figma490:25079 하위 | PM이 확인한 첨부 이미지와 현재 Figma를 대조. Clinic 문구는 'Unread at Other Offices' / 'Unread Notifications'. 웹은 현재/다른 소속 동일 스크롤, 앱은 현재 소속·Payment 영역 고정/하위 목록 스크롤. 과거 '문구 미정' 기록을 그대로 재사용하지 않는다. |
| [API 삭제 전 사용처 요청](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794363519212339) | 새 삭제 UI 요청이 아니라 구형 API 10개 사용처 조사다. 아래 실제 호출 경로와 선언/고아 코드를 구분했다. Slack에는 직접 쓰지 않았다. |
| [앱 개발자 리뷰 안내](https://innovaidhq.slack.com/archives/C09613TBE5A/p1794469158591269), Lab PR42 | 모델 생성 경계, styled-components, null 원소/중첩 컬렉션 검증, 기존 공용 소비처 QA를 함께 확인. 코드 반영과 스레드 해결/최종 런타임은 별도 상태로 기록한다. |

## 시트 랜딩 재대조

- [알림 현황표](https://docs.google.com/spreadsheets/d/1w1xwwEWRE0KgiJsOvldxIFbtNgWguohurf5kemIrW_g/edit?gid=614410508)의 현재 `전체 알림(PM)` 173행 A:L/M:P를 읽기 전용으로 확인. 과거 행 번호를 사용하지 않았다.
- 목적지가 기입된 APP 주소는 수신 대상과 각 앱 등록 경로/실제 파라미터 소비를 함께 대조했다. `${scheme}`는 발송 대상에 맞게 실제 scheme으로 치환할 템플릿이며 앱이 그대로 받는 주소가 아니다.
- **실제 누락:** P120:P121, OFFICE 배송 예정일 변경의 `order/${employerId}/${orderId}/shipment/${shipmentId}/tracking-details`. 기존 앱은 employerId 없는 짧은 경로만 등록했다. Office에서 소속 확인/전환을 유지하는 경로를 추가하고 기존 경로도 유지한다. 수신 대상이 OFFICE이므로 Lab 경로를 불필요하게 추가하지 않는다.
- 피드백 P123:P126도 OFFICE 대상이라 Lab의 미등록을 오류로 보지 않는다. 크레딧/청구서/알림함·주문/컨펌/채팅/선호/밀링 등록과 대조했다. P159 밀링 신규 주문은 명시적 보류이며 임의 목적지를 만들지 않는다. 이메일 외부 진입은 이번 범위가 아니다.
- 이는 등록 경로/소비 코드 및 수정 경로 검증이며 모든 실제 발송 건의 랜딩 QA 완료를 뜻하지 않는다.

## 구형 API 삭제 검토 (정적 호출 경로)

| BE가 물은 API | 현재 feature 코드의 실제 사용 |
| --- | --- |
| GET `/app/users/own/push-preferences` | **Office 사용 중.** `usePersonalOrdersPreference` → query → AppService. Home/탭, 주문 검색, LinkTalk/채팅의 담당 주문 필터와 연결. |
| PATCH `/app/users/own/push-preferences/{preferenceId}` | **Office 사용 중.** 위 필터 변경 및 rollback 경로. 신규 알림 설정 API로 임의 치환하지 않았다. |
| POST `/app/users/own/push-preferences` | 현재 live 호출 없음. 앱의 구 ProfileNotificationSection→useProfileNotification 연결은 화면에서 import되지 않는 고아 경로이며 선언은 남아 있음. |
| PATCH `/app/users/own/push-settings/{pushSettingId}` | 위와 동일. 현재 live 호출을 찾지 못했으며 생성 메서드가 있다는 이유로 사용 중이라 하지 않음. |
| GET `/messages/notifications`, `/unread`, `/employers` | 새 Clinic/Lab 알림센터 live 경로에서는 사용하지 않음. 기존 웹 useNotificationsPagination/query/API 선언은 고아 경로로 남아 있음. |
| PATCH `/messages/notifications/read/all`, `/read/partial` | 현재 새 알림센터 live 호출 없음. 구형 웹 고아 코드/생성 선언과 구분. |
| DELETE `/messages/notifications/{notificationId}` | 현재 새 알림센터 live 호출 없음. 삭제 기능을 새로 추가하라는 요청으로 해석하지 않음. |

- Lab의 담당 주문 설정은 로컬 저장이라 위 GET/PATCH를 호출하지 않는다. 구 ProfileNotificationSection은 실제 화면에서 미사용이다.
- Admin의 `/admin/messages/notifications`는 CRM/메시지 이력에서 **현재 사용 중인 별도 경로**이므로 위 목록과 합치지 않는다.
- 배지 PATCH `/app/users/own/devices/badge-count`는 이번 삭제 목록이 아니며 현행 유지한다.
- **이 결과만으로 BE 즉시 삭제 불가:** Office GET/PATCH 실제 사용과 이전 배포 웹/앱의 사용 가능성이 남는다. 전체 구형 API 삭제 승인을 하지 않았고, 불필요한 고아 코드 대량 정리도 하지 않는다.

## 별도 밀링 리뷰 경계

- 웹 PR4862에는 새 설정 관련 지적 외에 Swagger 재생성에 따른 밀링 wire/FILE 지적 2개가 있다.
- 문자열 입력은 생성 schema 구조와 설명이 다르지만 설명은 문자열 또는 `{fileIds}`라고 명시한다. 기존 완료된 [PR4866](https://github.com/Innvoaid/dentlink-client/pull/4866)의 서버 검증 기록도 string/{fileIds} 허용, `{text}` 거절을 기록한다. 생성 파일을 손으로 고치지 않고 FE 가공 타입을 유지하는 근거다.
- FILE 배열을 `Record<string,string>`으로 강제하면 trim 오류/전체 정정 시 fileIds 누락 위험은 실제로 남는다. 해당 완성 구현은 DL-17292 및 PR4866을 통해 release/v1.93.0에 병합돼 있고, 현재 feature/target release/v1.94.0에는 없다.
- 여기서 FILE UI/저장 구조를 중복 개발하거나 별도 릴리즈 전체를 임의 병합하지 않는다. 이 스레드는 안전하게 해결됐다고 닫지 않고 릴리즈 통합 시 확인할 별도 항목으로 남긴다. 알림센터 배포/merge 준비 완료의 근거로 감추지 않는다.

## 최종 구현·검증·Git/리뷰 결과

### 이번 수정

- **Web:** `shared/models`에는 API/도메인/PUT 변환을 남기고 화면 그룹화·표시 규칙을 `shared/ui`로 이동. 신규 오류 UI/문구는 기존 EmptyDataInfo·공통 오류 문구로 통일. query key·스타일 파일 분리 등 팀 규약 정리. Lab의 별도 상세·밀링 헤더 알림 누락을 보완하되 기존 모바일 하단 알림 진입점은 유지하며 화면당 노출 1개를 확인했다. 확정 Clinic 병원 선택 문구를 반영했다.
- **Office:** 알림/공용 병원 선택·배너·크레딧의 남은 StyleSheet를 styled-components로 정리. 확정 병원 선택 문구와 기존 오류 문구 적용. 시트 P120:P121 배송 경로에 employerId 포함 alias 추가, 기존 경로 유지와 비소속 접근 방어 검증.
- **Lab:** 알림 소속 선택/배너의 남은 StyleSheet 정리. 설정/읽음 실패에 임의 추가했던 문구 대신 기존 공통 오류 문구를 사용하고 미사용 번역 key 제거.
- **다른 에이전트의 선행 변경:** 생성모델 이전·nested null 검증·새 설정 API 렌더/전체 PUT을 그대로 받아들여 현재 계약과 회귀 테스트/최종 화면을 대조했다. 이를 이번 신규 API 구현이라고 표현하지 않는다.
- **지침:** 앱의 models/styled 규칙은 원래 팀 문서에 있었다. 원인은 규칙 부재보다 구현·최종 diff 대조 누락이었다. 개인 앱 구현 지침·플레이북 보완에 이어, 웹 models의 수동 API/도메인 역할과 UI 표시 규칙 위치를 분명히 했다. 앱의 생성 전용 models 규칙을 웹 전체에 무조건 적용하지 않는다. 팀 저장소 AGENTS/CLAUDE는 불필요하게 다시 쓰지 않았다.

### 최종 코드 검증과 한계

| 대상 | 정적 검사 | 현재 코드 런타임 |
| --- | --- | --- |
| Clinic/Lab 웹 | 알림 관련 36 tests, Clinic/Lab/Admin tsc 통과, ESLint 오류0(기존 Header 의존성 경고1) | 로그인된 DEV 조회로 설정·일반 소속 선택·대표 헤더와 팝업, 390/1440 크기 확인. 제한적 GET 실패 후 Retry 복구. 최종 헤더/밀링 검사 pageerror0. |
| Office 앱 | 13 suites/190 tests, 변경14파일 lint/Prettier/diff-check 통과. tsc 기존6진단 | 동일 DEV 소스의 iOS/Android에서 홈·인박스·설정·실패/Retry·scope/소속 시트·배너·크레딧 확인. OS 배송 URL→주문 상세와 기존 tracking 메시지 전달 확인. |
| Lab 앱 | 5 suites/50 tests, 변경6파일 lint/diff-check 통과. tsc 기존5진단 | 동일 DEV 소스의 양OS에서 실제 인박스/설정 GET, 잘못된 nested channels 응답→실패/Retry, 인박스→주문상세→Back, 기존 Home/Orders/LinkTalk/Profile/Support 확인. |

- 웹·Office의 실제 다른 소속 미읽음이 0이라 **실제 소속 데이터에 카운트만 제어 주입**해 레이아웃/스크롤을 검증했다. Lab은 단일 소속 계정으로 실제 타기공소 전환 대상이 없다. 오류·권한·저장 실패의 일부는 임시 서비스/렌더 핸들러 대체로 확인 후 원복했다. 서버의 실제 설정 저장·다른 소속 집계 QA로 확대하지 않는다.
- Office의 배송 테스트는 실제 DEV 주문에 테스트 shipmentId=123을 전달해 URL·WebView 메시지 연결을 확인한 것이다. 실제 배송 레코드의 팝업 전체 QA나 실제 FCM/APNs 발송 검증이 아니다.
- **iOS 자동화 장애:** Office 검사 중 Maestro 종료 시 앱과 SpringBoard가 같은 XCTest 내부 프레임에서 EXC_BAD_ACCESS로 종료됐다. 재실행 후 해당 종료 자동화를 사용하지 않은 검사에서는 재발하지 않았다. Lab 검사에서는 새 Lab/SpringBoard crash가 없었다. 두 제품 최종 Android crash buffer/LogBox는 비었다. 실제 앱 결함으로 확정하거나 전체 실행이 무조건 crash-free였다고 하지 않는다.
- 기존 DEV 설치 바이너리 위 최종 JS 검증이다. 설치 바이너리 build SHA/별도 native 패치 포함이나 실제 배포 호환성의 증거로 사용하지 않는다. 사용자 실기기·실제 푸시 QA는 별도다.
- Office tsc의 주문 DTO 관련 2진단은 origin/main·Swagger 재생성 전·현재 원문이 동일함을 확인했다. 기존6/5 진단을 통과로 보고하지 않고 이번 신규 오류와 구분한다.
- 런타임 상세: `/tmp/office-1112-runtime-summary.md`, `/tmp/lab-1112-runtime-summary.md`, `/tmp/dentlink-notification-web-1112/`. 임시 파일은 장기 정본이 아니므로 핵심 결과·한계는 이 문서에 남겼다.

### 남은 범위 / 다음 시작점

1. BE `platforms` 등 웹/앱 노출 키 답변을 받으면 현재 임시 PUSH 판별을 교체한다. 별도 사용자 설정·배지 개선은 협업 대기이며 임의 구현하지 않는다.
2. 기존 Office 담당 주문 필터가 구 push-preferences GET/PATCH를 계속 사용한다. 삭제 전 마이그레이션 범위/계약을 정해야 한다. 지금 BE의 구 API 10개 일괄 삭제를 승인하면 안 된다.
3. 웹 밀링 FILE 리뷰는 다른 릴리즈의 완료 코드가 현재 대상에 없어서 남는다. 해당 릴리즈 통합 시 PR4866 반영 여부를 먼저 확인하고 중복 구현하지 않는다.
4. 최신 코드의 개발 배포는 사용자 승인 후 별도 진행. 실제 FCM/APNs·서버 쓰기·최종 바이너리 QA도 별도이며 이번 로컬 검사로 대체하지 않는다.
5. 이전 Empty 보조 문구 일부는 이번 bounded Figma 대조에서 정확한 출처를 찾지 못했다. 임의 문구를 추가하지 않았고, 모든 문구의 확정 출처를 검증했다고 주장하지 않는다.
6. 이메일/Home3/별도 Android 패치 및 선택적 CodeRabbit 주석 커버리지 경고는 기존대로 본체 밖/보류 범위다.

### Git·리뷰·실행 정리

| 제품 | 커밋 / 브랜치 | 유지한 PR / 대상 |
| --- | --- | --- |
| Web | `7e23e709bb49bf3113553012042a4cac734b9b63` / feature/DL-17058 | #4862 / release/v1.94.0 |
| Office | `a624b5985a7d6bc2f045f7b989aacf92a95e66fb` / feature/DL-17059 | #346 / main |
| Lab | `d018b85530ca0fd698e372948b5cbf72e3c826e7` / feature/DL-17060 | #42 / main |

- 세 제품 원격 SHA 일치·ahead/behind0/0·clean을 확인했다. 기존 Draft/[WIP]/DRAFT와 base를 유지하고 PR 본문을 현재 최종 구현·검증·한계로 갱신했다. CodePush/merge/배포·새 branch/worktree/PR 없음.
- Web 일반 훅(타입/lint/Admin DLDS guard/shared coverage) 통과, 공통 hooks59 tests 통과. E2E guard는 사용자 명시 제외에 따라 실제 SKIPPED로 기록했고 훅을 우회하지 않았다. shared/configs baseline 대비 -0.1% 출력은 정보성으로 hook exit0이었다.
- Lab42 모델·StyleSheet·nested null 리뷰3건을 근거 답변 후 resolve. Office346 열린 inline0. Web4862 새설정2건/wire1건 처리, 기존 알림 label 지적도 해결 상태 확인. **별도 밀링 FILE thread `PRRT_kwDOJnA7-862hGtQ`는 실제 통합 미완료로 열어 둔다.**
- CodeRabbit 자동 검토가 pause 상태라 `@coderabbitai review` 단회 요청(20:05KST). **20:12KST 최신 `7e23e709b` 검토 완료, 새 actionable comment 없음**을 봇의 Last reviewed commit/Review finished와 재조회한 스레드로 확인했다. 별도 FILE1건만 미해결이며 자동 검토 pause 설정은 유지했다. 자동 감시 예약을 만들지 않았다.
- 본인이 시작한 웹3000/3005·Office8081·Lab8082 서버와 검증용 양기기는 종료. 기존 사용자 창과 Reactotron은 유지했다. 로컬 실행 정리를 앱/웹 배포로 혼동하지 않는다.
