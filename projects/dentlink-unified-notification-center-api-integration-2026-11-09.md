# 통합알림센터 신규 REST 연결 — 2026-11-09

## 완료 위치와 범위

사용자는 명세가 공개된 API를 Web·Office·Lab에 연결하고 검증·commit/push·개인 기록을 완료하도록 승인했다. PR·merge·배포는 하지 않는다. 외부 문서와 댓글은 읽기 전용이다.

| 제품 | 체크아웃 / 브랜치 | 최종 커밋 |
| --- | --- | --- |
| Web Clinic/Lab | `/Users/parkjongsun/Repository/dentlink-client-notification-center` / `feature/DL-17058` | `8b9cd986cf58ef4deb64b72d20b0d0b37527b8b4` |
| Office 앱 | `/Users/parkjongsun/Repository/dentlink-app` / `feature/DL-17059` | `c18673e9b1d9ae8c083ccd0457332d0d6314e209` |
| Lab 앱 | `/Users/parkjongsun/Repository/dentlink-lab-app` / `feature/DL-17060` | `c516f3caf397389c5cb0e0d0513e91332b2e6a64` |

세 브랜치 모두 push 후 `ls-remote`와 HEAD 일치, clean을 확인했다. 기존 브랜치명을 유지했으며 새 branch/worktree·PR은 만들지 않았다.

- Office/Lab 각각 `GET/PUT /notifications/settings`, `GET /notifications/inbox`, `GET /notifications/inbox/unread`, `GET /notifications/inbox/employers/unread`, `PATCH /notifications/inbox/read/partial`, `PATCH /notifications/inbox/read/all`을 해당 `/office`·`/lab` prefix로 연결했다.
- 실 목록·All/Unread·추가 페이지·개별/전체 읽음·미읽음·다른 소속 집계를 연결했다. 기존 실제 소속 활성화/랜딩/토스트 동작은 재사용한다. 표시용 mock store/목록을 제거하고 production에서도 새 알림센터 진입을 사용한다.
- server `view`의 허용 카테고리·채널·범위를 표시한다. 상위 OFF도 자식값은 보존하고, 전체 PUT 전에 최신 GET에 사용자 변경 한 항목만 합성한다. 웹에서 숨긴 PUSH 및 미노출 USER 설정도 보존한다. 미설정 category는 계약상 전부 ON을 먼저 구성한다.
- 소속·계정·로그인 수명 변경과 A→B→A 재진입은 이전 저장/읽음 의도를 폐기한다. 웹 token refresh 시 명시한 소속 헤더를 유지하고 재시도 전에 같은 문맥인지 검사한다. 비알림 요청의 기존 refresh 동작은 유지한다.
- 양 앱의 OS 권한 변화에 따른 구 push-preferences 자동 저장과 구 설정 진입을 정리했다. OS 권한과 서버 수신 설정은 독립적이다. 정상 OS 설정 복귀 시 사용자가 선택했던 항목만 새 PUT으로 저장한다.
- 읽음 요청 실패를 성공으로 바꾸지 않으며, 정상 랜딩은 가능한 범위에서 별도로 진행한다. 동일 행의 중복 탭을 차단하고 앱 개별 읽음에는 5초 timeout을 적용한다. 읽음 성공 뒤 Unread 페이지는 처음부터 갱신해 offset 누락을 방지한다.
- 푸시 읽음의 `read/push {deliveryId}`는 양 앱 service/type만 준비했다. 실제 FCM에서 deliveryId를 받는 위치가 미확정이므로 푸시 클릭 호출은 연결하지 않았다. OS 배지·이메일 작업·실시간 동기화·신규 삭제 API는 추가하지 않았다.

## 실제 서버에서 발견하고 반영한 사항

1. 설정 PUT 및 읽음 PATCH는 HTTP200/`code=0001`/`No Content`가 정상 성공이다. 세 제품 mutation에서 0000/0001을 수용하고 GET은 정상 envelope/예상 data를 검사한다.
2. PUT 성공 직후 GET이 이전 값을 반환하고 1초 뒤 새 값을 반환하는 현상을 Office/Lab에서 재현했다. UI가 즉시 이전 값으로 되돌아갈 수 있어, 저장한 항목에 한해 즉시 GET + 불일치 시 200/500/1000ms의 최대 3회 추가 확인을 한다. 총 최대 4회이며 저장 중 잠금을 유지한다. 확인 실패·HTTP 실패·문맥 변경은 기존 오류/취소 처리이며 성공으로 표시하지 않는다. 서버가 정규화한 다른 값은 그대로 따른다. 이는 저장 한 건의 제한적인 확인이며 정기 polling이 아니다.
3. 버전/ETag 없는 전체 PUT은 다른 기기의 GET→PUT 사이 경합까지 원자적으로 해결하지 못한다. 현재는 최신 GET 합성, 동일 사용자 저장 직렬화, scope guard의 보장 범위다.

재현 원문은 `/tmp/notification-settings-consistency-1109.json`에 traceId와 값만 보관했다. 예: Office false 저장 trace `20261109040706881XVT8053`, 즉시 GET true `202611090407069097i98054`, 1초 후 false `20261109040707937Lz68055`. BE 내부 지연 원인은 확인하지 않았으며 replica/cache 구조를 추정하지 않는다.

## 검증 근거와 한계

| 범위 | 확인한 결과 | 한계 |
| --- | --- | --- |
| 실제 DEV REST | 양 서비스 설정·목록·미읽음·다른 소속 GET, 설정 OFF/ON 저장·재조회·원값 복구, 빈 인박스 전체 읽음의 0001 응답 | 실 발송 알림은 목록0/집계0. 실제 발송→실제 목록 ID 읽음→FCM E2E 미완료 |
| Clinic/Lab 웹 | 격리 Chromium에서 실제 설정 저장·숨긴 값 보존·503 실패 유지. 제어 응답으로 페이지 추가/개별 읽음 후 기존 랜딩/실패 시 미읽음 유지/전체 읽음/All 유지 | headless 자동화이며 사용자 가시 창 물리 조작/실제 발송 QA와 다름 |
| Office/Lab × iOS/Android | 현재 최종 코드·로그인 계정으로 실제 설정 저장·복구, 제어 응답 목록 25건으로 페이지/개별·전체 읽음/중복 탭/실패/기존 상세 랜딩·복귀 확인 | 렌더된 실제 handler/native stack과 화면 캡처 근거. 테스트 알림 ID는 서버에 보내지 않음. 모든 실제 권한/다중소속 계정 QA로 확대하지 않음 |
| Android OS 복귀 | 양 앱 실제 OS 알림 화면 이동, 허용 후 앱 복귀 때 선택한 PUSH만 1회 저장·서버 재조회. OS 허용 이전 저장0 | OS 허용 전환은 테스트 중 ADB로 수행. 실제 FCM 수신/런처 숫자 테스트가 아님 |
| iOS OS 관련 | Lab OS 차단 상태의 안내 팝업/취소 시 저장0, Office OS 허용 상태의 일반 PUSH 토글 저장 | iOS 실제 알림 허용 변경→복귀 전체는 이번에 검증하지 않음. 실기기 확인 잔여 유지 |
| 정적/회귀 | Web 관련17회귀·기존 소속9, Clinic/Lab/Admin type 및 pre-push lint/공유 coverage 검사 통과. Office 기존 관련8 suites/96 및 후속4 suites/32, Lab 기존43·임시 adapter/readback 검증 통과. 변경 lint/diff-check 통과 | 앱 전체 TS는 Office 기존6·Lab 기존5 오류 동일. 웹 공통 i18n 감사는 기존 키/원격 불일치 한계, 신규 알림 로컬 en/ko 누락 없음 |
| 안정성/원복 | 최종 API 검증 구간 13:10 이후 새 Dentlink/SpringBoard iOS 보고서0, Android crash buffer 변화 없음. 서버 설정은 오전 최초 실제 GET과 전체 동일, Android 양 앱 OS 권한은 원래 granted로 복구 | 이전 11:54 Office native cold-start SIGSEGV 원인은 해결됐다고 주장하지 않음. 이번 구간에서 재발하지 않은 것 |

임시 증거: `/tmp/notification-{office,lab}-{real-settings,fixture,os-return}-proof-1109.json`, `/tmp/notification-web-{real-settings,fixture}-proof-1109.json`, `/tmp/notification-final-server-check-1109.json`, `/tmp/notification-api-crash-proof-1109.json`, 각 최종 PNG. 임시 파일의 영구 보존은 보장하지 않으므로 결과·한계를 이 문서에 함께 남긴다.

## 남은 세 안건 — 사용자와 먼저 논의, BE 미전달

사용자는 앞서 제안한 BE 질문을 아직 전달하지 않았다. API 작업을 먼저 끝낸 뒤 아래 세 주제로 설명·합의를 진행한다. 미정값을 코드에 임의 적용하지 않는다.

### 1. 시트 App 랜딩 URL 하나로 충분한가

- 같은 앱 목적지이면 앱 인박스 클릭과 푸시 클릭에 같은 최종 URL을 재사용할 수 있다. 단지 진입 경로가 다르다는 이유로 App URL key를 추가하지 않는다.
- NOTIFICATION/PUSH 행별로 실제 목적지가 다른 정의는 유지한다. 기존 파서가 지원하지 않는 표현/주소는 실행 가능한 실제 딥링크로 FE에서 매핑하고 계약에 반영한다.
- 현재 코드의 구 `pushType`은 ORDER_UPDATE 등 알림 종류다. 목적지 화면, 병원, 주문 ID를 대신하지 않는다. 신규 inbox DTO에는 domain/category/landingUrl이 있으며 pushType이 없다. 다른 type을 추가하면 무엇이 해결되는지 먼저 설명하고 불필요한 key 요구를 하지 않는다.
- 별개로 **공용 inbox 응답의 landingUrl 하나에 시트 Web/App 중 무엇을 담는지**는 아직 명확하지 않다. ‘앱 진입별 URL을 더 달라’와 같은 문제가 아니다. 이메일은 별도 카드/범위다.

### 2. 푸시 읽음 payload 예시

확정 계약이 아닌 제안 예시:

```json
{
  "data": {
    "deeplink": "dentlink://order/1409/7000012592",
    "deliveryId": "12345"
  }
}
```

- URL은 이동, deliveryId는 BE가 기록한 이번 발송 건 식별이다. FCM data는 문자열로 전달하고, 앱이 `PATCH /office/notifications/inbox/read/push {"deliveryId":12345}`(Lab은 /lab)를 호출한다.
- 새 읽음 API를 추가 요청할 필요는 없다. 기존 payload의 정확한 key/형식을 확정해 로그인 전 보관·병원 전환·FCM/Notifee 중복 처리까지 보존해야 한다. 같은 URL의 서로 다른 발송을 URL 중복 방지로 함께 버리면 안 된다.
- 인박스 클릭은 목록 id를 `read/partial.unreadNotificationIds`로 보내는 현재 연결을 사용한다. 목록 ID와 deliveryId를 혼용하지 않는다.

### 3. OS 아이콘 배지

- 사용자 전달에 따르면 현재 서버 숫자의 의미는 **푸시 알림 수**다. FE는 로그인/foreground 때 `PATCH /app/users/own/devices/badge-count {badgeCount:0}` 후 로컬0으로 지운다. 사용자가 말한 PUT은 실제로 PATCH다. 현재 인박스 미읽음과 연동하지 않는다.
- 사용자의 제안: 푸시는 별도 전달 채널, 읽음은 푸시 클릭/인박스 클릭의 REST, OS 숫자는 서버 unread GET이 정본. 이 구조로 변경 가능하다. **GET은 숫자를 가져오고 앱이 OS에 적용하는 단계가 별도로 필요**하다.
- iOS는 Notifee setter로 반영 가능하다. 다음 푸시 APNs badge도 같은 집계를 써야 한다. Android는 활성 OS 알림/런처 지원에 영향을 받으며 같은 setter가 동작하지 않는다. 양 플랫폼에서 정확히 같은 숫자를 보장한다고 말하지 않는다.
- 일반적인 선택지는 ‘앱 열면 지우는 새 소식 표시’와 ‘서버 미읽음을 나타내는 숫자’다. 업계 유일 표준으로 단정하지 않는다. 알림센터와 수를 맞추려는 목표에는 후자가 일관적이다.
- 현재 GET 현재 소속+개인, 다른 소속 GET 그룹만이라는 계약이다. 앱 전체 배지를 원하면 개인을 한 번만 포함한 전체 소속 범위와 채팅 포함 여부를 정한다. 기존 GET 조합으로 충분한지 먼저 보고 무조건 새 API를 요구하지 않는다.
- 이미 읽은 푸시의 OS 알림 제거와 icon badge, DB 읽음은 별개다. 다른 기기/웹의 변경이 닫힌 앱 배지에 즉시 동기화되는 기능은 추가하지 않는다.
- 근거: [Notifee setBadgeCount](https://notifee.app/react-native/reference/setbadgecount/), [iOS badge](https://notifee.app/react-native/docs/ios/badges/), [Android notification badges](https://developer.android.com/develop/ui/views/notifications/badges).

## 그 외 계약 경계와 다음 시작점

- 개인 USER:CREDITS 설정 위치는 정책 본문/열린 항목에서 아직 확정되지 않았다. UI를 임의 배치하지 않고 전체 PUT에서 보존한다.
- Office employee:CREDITS 실제 catalog가 PUSH만 제공하여 앞선 Credit Email 요구와 차이가 있다. 미지원 MAIL을 만들어 보내지 않는다. CASE_PREFERENCE도 신규 catalog에 없다.
- 기존 신규 삭제 명세가 없으므로 구 messages 삭제에 신규 inbox ID를 보내지 않는다.
- 다음은 세 안건 설명·BE 계약 정리 → 실제 발송 payload 수신 → 푸시 read/push 연결 및 실 알림/소속/권한 QA다. 이번 API 연결 commit/push를 실제 발송 검증·최종 QA·release 완료와 구분한다.

## 랜딩 안건 1 후속 — 시트 반영 승인·권한 제한

2026-11-09 사용자는 App URL 재사용/딥링크 설명을 BE 전달용으로 정리하고, 현재 지원 주소는 시트에 기입하며 아직 준비되지 않은 것은 후속 기입 표시를 하도록 승인했다. 이번에는 제품 코드·푸시 읽음·배지·이메일 구현을 시작하지 않는다.

- 같은 최종 앱 목적지 URL을 인박스·푸시에서 재사용하고 향후 이메일의 최종 앱 목적지로도 재사용할 수 있다. 단 이메일 버튼의 HTTPS 진입 주소·OS 앱 열기·미설치 웹 연결과는 구분한다. 인박스/푸시/이메일별 App URL 컬럼을 단지 진입 방식 때문에 추가할 필요는 없다. 실제 목적지가 다르면 채널별 행의 주소는 다르게 유지한다.
- `dentlink://...` 자체가 커스텀 스킴 딥링크이며 Airbridge 주소 생성은 필수 절차가 아니다. 현재 앱에 등록된 경로는 주소를 명시할 수 있다. Office DEV/STG scheme은 `dentlink-dev://`/`dentlink-staging://`다.
- live Sheet `전체 알림(PM)`(gid614410508)의 A127:P150 및 셀 메타데이터를 재확인했다. 아래 P열 대상은 일반 텍스트이며 validation/formula/chip/기존 note가 없었다. 같은 목적지의 Web 주소를 근거로 Office 구현 주소를 대조했다.

| 대상 셀 | 현재 값 | 확인된 주소 / 기입 대기안 |
| --- | --- | --- |
| P141, P145 — 개인 Credits NOTIFICATION | 알림센터 오픈 | `dentlink://credit`. 셀 메모에 지원 주소를 기록하고 본문은 `알림센터 오픈 · 크레딧 목록 연결 검토`로 표시할 안 |
| P147, P149 — Office Credits NOTIFICATION | 알림센터 오픈 | `dentlink://office/credit?employerId=${employerId}`. 위와 같이 실제 목록 목적지 전환 여부를 구분 |
| P128, P130, P135, P137, P139 — 웹 /billing/statement 대응 NOTIFICATION | 액션 없음 | `dentlink://billing/statement?employerId=${employerId}`. 셀 메모에 지원 주소를 기록하고 본문은 `액션 없음 · 청구서 목록 연결 검토`로 표시할 안. 기존 OWNER/PAYMENT_MANAGER 조회 권한 유지, 결제 실행/PDF 의미 아님 |
| P142, P146, P148, P150 — Credits PUSH | 알림 인박스 오픈 | 목적지는 유지. `알림 인박스 오픈 · URL 연결 예정`으로 표시하고, 양 앱 인박스 외부 딥링크 경로 등록·검증 후 실제 URI 기입. Airbridge 발급 대기가 아님 |

**중요:** 화면/경로 구현 가능 여부와 `알림센터 오픈→Credits`, `액션 없음→Statements`의 실제 목적지 변경은 다르다. 기존 목적지와 연결안을 구분해 기록하며 시트 기입 권한을 목적지 정책 확정으로 확대하지 않는다. Office에만 있는 추가 목록을 Lab에 그대로 반영하지 않는다.

**시트 쓰기 결과:** 위 13개 셀과 P1 안내 note를 하나의 batchUpdate로 요청했으나 Google API가 `403 PERMISSION_DENIED: Write access is required, comment-only access is not sufficient`를 반환했다. 요청은 적용되지 않았고 원본을 다시 읽어 변경 없음 확인했다. 별도 계정·브라우저로 권한을 우회하거나 댓글을 대신 게시하지 않았다. **시트 반영 완료로 보고하지 않으며**, 편집 권한 확보 후 대상 셀 최신값을 다시 확인하고 반영한다. 범위 밖 Web 랜딩/MAIL/기타 목적지는 변경하지 않는다.

- 현재 구현 근거: Office `src/configs/constants/deepLink.ts:151`의 credit/office-credit/billing-statement, 공통 useNavigationConfig의 소속 전환. 양 앱 NotificationCenterScreen은 내부 진입만 있으며 외부 URL route 등록은 아직 없다.
- BE 답변은 이 채팅에 복사용으로만 제공한다. Slack/Jira 메시지를 직접 보내지 않는다. 별도 API `landingUrl`의 Web/App 반환 구분은 계속 미확정이다.

## 로컬 마감

- 이번 검증용 Clinic3000/Lab3005, Office8081/Lab8082 및 격리 headless Chromium9233을 종료했다. 사용자 일반 Chrome·IDE·외부 터미널 배치는 변경하지 않았다.
- 양 앱 실행을 닫았으며 기기 데이터/로그인/OS 권한은 보존했다. 공유 시뮬레이터·에뮬레이터 장치 자체는 부팅 상태를 유지했다.
- 기기 사용 충돌은 다른 채팅의 검증 완료·대기 상태를 확인한 뒤 해결했고 메시지는 보내지 않았다. 별도 주문 상태 작업의 코드/기록/후속 진행은 이 기능에 합치지 않는다.
