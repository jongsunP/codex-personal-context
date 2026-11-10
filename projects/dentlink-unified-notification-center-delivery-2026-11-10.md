# 통합알림센터 본체 — 개발 배포 준비와 후속

## 이번 승인과 전달 경계

- 2026-11-10 사용자는 조사·계획 논의 후 배포 **준비**와 남은 문서/Jira 정리를 승인했다.
- Web: 최신 `master`를 작업 브랜치에 통합하고 **PR 2개**를 만든다. 본작업은 `release/v1.94.0`, 개발서버용은 `develop` 대상이다. 사용자가 직접 웹 배포를 처리한다.
- 기존 원격 `develop` 삭제·최신 master 재생성은 사용자가 다시 명시 승인했다. 기존 자동 배포가 재생성 자체에 반응할 가능성도 설명한 상태다. PR 병합/수동 배포는 하지 않는다.
- Office/Lab: 최신 `main`을 각각 작업 브랜치에 통합하고 **이번 PR은 사용자 예외 지시로 main 대상**이다. 일반적인 앱 release 정책을 전역 변경한 것은 아니다.
- 앱 CodePush는 **작업 브랜치 → Development**, 최종 준비 결과를 확인한 사용자의 **별도 실행 승인 후** 진행한다. 현재 Git push와 CodePush 배포를 혼동하지 않는다.
- 사용자는 이번 준비에서 웹 E2E를 제외하라고 명시했다. 실제 데이터 E2E/추가 대응은 실행하지 않으며, 기존 E2E 코드나 CI를 삭제·비활성화하는 별도 변경으로 확대하지 않는다.

## 완료한 배포 준비

| 제품 | 작업 위치 / feature HEAD | 통합한 기준 | PR |
| --- | --- | --- | --- |
| Web Clinic/Lab | `/Users/parkjongsun/Repository/dentlink-client-notification-center` · `feature/DL-17058` · `2635a55b06e4e01e01c042230d1316e10ac7e090` | `master@bafb0b1b6430a4e2d65ffd15d2316f83829ba84d` | [#4862 → release/v1.94.0](https://github.com/Innvoaid/dentlink-client/pull/4862), [#4863 → develop](https://github.com/Innvoaid/dentlink-client/pull/4863) |
| Office app | `/Users/parkjongsun/Repository/dentlink-app` · `feature/DL-17059` · `5ad23a1e311003a3c5b4a06a009fe4a882c051f0` | `main@fd775498f20e38a642b317f9d7713f66c005423a` | [Draft #346 → main](https://github.com/Innvoaid/dentlink-app/pull/346) |
| Lab app | `/Users/parkjongsun/Repository/dentlink-lab-app` · `feature/DL-17060` · `36329315202e5ba1495fb107de072e2ee510449b` | `main@a3f5a06366b7ea86b461a5ef05355abdd5660017` | [Draft #42 → main](https://github.com/Innvoaid/dentlink-lab-app/pull/42) |

- 세 제품은 기존 checkout/feature를 유지했다. 신규 worktree/feature를 만들지 않았다. Office는 충돌 없이 통합했고 Lab 번역 registry의 독립 추가 항목은 양쪽 모두 보존했다.
- 앱 PR 자동화가 base를 release로 변경한 후, 사용자가 정한 `main`으로 복구·확인했다. 앱은 실제 대상 바이너리의 푸시 검증이 남아 **Draft + DRAFT 라벨 + `[WIP] ` 제목**을 유지한다. Draft는 본체의 미구현을 뜻하지 않는다.
- 웹 최종 PR diff는 두 대상 모두41파일, Clinic7/Lab8파일을 포함한다. 실제 workflow의 `push: develop` + `clinic/**` / `lab/**` 조건과 일치하므로 develop PR 병합 시 두 서비스가 배포 대상이다. Admin 변경은 없다.
- 기존 develop `b3db1b9f86678ea057fdac4dca378bc0b510f735`는 expected-SHA lease로 삭제하고 master SHA로 nonexistence lease 생성했다. 복구 bundle: `/Users/parkjongsun/.codex/backups/dentlink-client-develop-before-notification-20261110.bundle`(검증 성공). 원격 develop/master/release/v1.94.0이 같은 SHA임을 확인했다.
- 재생성 직후 Actions 조회1회에서는 새 develop 실행이 보이지 않았고 과거 실행만 반환됐다. 추가 감시/수동 실행은 하지 않았다. 이를 전체 배포 성공 또는 앞으로 실행되지 않는다는 보장으로 표현하지 않는다.

## 검증과 남은 한계

| 범위 | 확인 결과 | 남겨 둔 구분 |
| --- | --- | --- |
| Web | 기존 알림 테스트26개(공통17/Clinic5/Lab4), 양 서비스 전체 TypeScript, pre-push lint 오류0, diff-check 통과 | E2E는 사용자 지시로 이번 범위 제외. 개발서버의 실제 데이터 QA/배포 성공 미확인 |
| Office | 관련13 suites/167 tests, lint 오류0, 버전2.2.4 일치, iOS/Android release JS bundle 생성 | 기존 전체 tsc6진단 유지. 실제 기존 바이너리의 BE 푸시/읽음 통합 검증 미완 |
| Lab | 관련7 suites/59 tests, lint 오류0, 버전1.0.5 일치, iOS/Android release JS bundle 생성 | 기존 전체 tsc5진단 유지. 실제 기존 바이너리의 BE 푸시/읽음 통합 검증 미완 |

- 양 앱 최종 main 대비 native/package/lock/patch/config 변경0이다. 기존 Notifee·FCM·권한 API를 활용하는 JS 변경이며, 이번 본체는 **CodePush 우선**으로 준비한다. 새 native 권한/SDK/scheme를 요구하지 않는다.
- 이것은 실제 설치 바이너리·OTA 적용·상용 QA까지 검증됐다는 뜻이 아니다. 개발 APK에서 재현한 Android Notifee 클릭 전달 오류는 JS 이전에 발생한다. 현재 운영 바이너리와 기존/신규 JS의 A/B는 아직 없으며, 실제 대상에서도 필수 푸시 클릭이 막힌다면 네이티브 조치를 앞당길지 판단한다.
- Lab 수동 reload 중 관찰된 Fabric `MountingCoordinator::pullTransaction` 종료도 원인 미확정으로 유지한다. 새 JS 회귀 또는 무관한 기존 문제라고 어느 쪽으로도 단정하지 않는다.
- Android 호환 패치의 제외·원본·복구·검증 한계는 [별도 후속](dentlink-android-notification-compatibility-followup.md)에 보존했다. 추후 이메일 배포와 묶을 수 있지만, 본체 필수 동작에 문제가 생기면 자동으로 미루지 않는다.
- 최종 통합 코드의 제한된 양OS 기본 화면 검증을 완료했다. 아래 범위만 확인했으며 광범위한 최종 QA나 실제 FCM/APNs 발송 검증으로 확대하지 않는다.

## 이후 순서

1. **개발 환경 전달:** 웹은 사용자 develop PR 병합·개발서버 확인. 앱은 별도 승인 후 feature의 동일 검증 SHA를 Development에 CodePush한다. 앱 PR의 main 대상과 CodePush 소스 브랜치를 혼동하지 않는다.
2. **본체 실데이터 QA:** 목록/빈목록/오류/페이지 추가, All·Unread·홈 레드닷, 개별/전체 읽음, 개인 알림과 소속별 집계, 설정 저장 후 재조회, 서비스·역할별 노출, 일반/알림 소속 전환, 랜딩과 뒤로가기를 확인한다.
3. **앱 전달 QA:** 실제 `deliveryId` 푸시를 받아 foreground/background/종료 상태의 클릭→랜딩→서버 읽음, 중복 콜백/같은 URL의 다른 발송, 로그인·계정/병원 변경을 확인한다. OS 권한 OFF→안내/복귀/선택 항목 처리, 취소/중단과 크래시도 영향 범위로 확인한다. 실제 iOS 권한 변경 등 실기기 확인과 에뮬레이터 근거를 구분한다.
4. **재현 문제 수정·리뷰:** 본체 결함만 수정하고 바뀐 범위의 최종 코드로 검증한다. CodeRabbit 리뷰가 별도로 요청되면 기존 공통 정책의 검토·수정·답변·스레드 정리 순서를 적용한다. review/QA완료와 merge/배포완료를 구분한다.
5. **상용 배포 직전 최신 근거 재점검:** 아래 문서의 마지막 확인 이후 변경분을 비교한다. 정책/BE계약을 우선하고 미반영 필수 변경과 본체 외 후속을 나눈다. 배포 일정 때문에 미정을 임의 확정하거나 이전 제안을 구현 완료로 바꾸지 않는다.
6. **승인된 상용 전달과 인계:** 최종 base/head·binary/native 호환·환경·버전·payload를 확인하고 승인된 경로로 전달한다. 앱은 CodePush 활성화/라벨, 웹은 승인된 배포 시작1회 확인까지가 기본 범위다. 실제 운영 기능 확인은 사용자 QA와 구분하며 자동 폴링하지 않는다.

### 배포 직전 다시 볼 정본

- [Notion 정책](https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd): 본문 수정시각·댓글·확정 정책.
- [랜딩 Sheet](https://docs.google.com/spreadsheets/d/1w1xwwEWRE0KgiJsOvldxIFbtNgWguohurf5kemIrW_g/edit?gid=614410508): **NOTIFICATION/PUSH**의 Web/App 랜딩·지원 여부·스킴·동적 식별값. 이메일 CTA는 이번 범위 밖이다.
- [Figma](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=2-6): 관련 본문·신규 댓글·병원 선택 변경, 이미 확인한 본인 메모 위치를 보존하고 변경분만 대조한다.
- [FigJam](https://www.figma.com/board/U9Qpm6ACzjGFKyrCoaAuvA?node-id=68-463): 새 기획 결정이 있는 경우 관련 흐름만 확인한다.
- [Jira DL-16140](https://innovaid.atlassian.net/browse/DL-16140): BE 계약·사용자 확정 댓글, 특히 deliveryId와 현행 배지44950. 댓글의 제안/확정/구현 상태를 구분한다.
- Swagger: 대상 환경의 `/v3/api-docs/swagger-config`에서 Office/Lab notification settings/inbox 그룹을 다시 대조한다. 기준 DEV는 `https://dev-api.dentlink.io`; 실제 대상 서버 계약을 우선한다. API묶음4개와 HTTP작업16개를 혼동하지 않는다.
- 위 재점검은 **배포 직전 수행할 계획**이며 이번 PR 준비에서 모든 외부 원문을 새로 전수 확인했다는 의미가 아니다.

## 본체와 분리된 남은 일

| 구분 | 업무 | 재개 기준 |
| --- | --- | --- |
| 본체 외 · 같은 부모 유지 | [DL-17062](https://innovaid.atlassian.net/browse/DL-17062) 웹 Home 시스템 메시지 제외 | 제외 정책과 기존 목록/미읽음 응답에 이미 적용됐는지 확인. 새 API나 FE 필터를 먼저 가정하지 않음 |
| 본체 외 · 같은 부모 유지 | [DL-17065](https://innovaid.atlassian.net/browse/DL-17065) Office Home 필터·최초 안내 | 정확한 홈 적용 영역, 저장 계약, 안내 위치/문구 대조 |
| 본체 외 · 같은 부모 유지 | [DL-17068](https://innovaid.atlassian.net/browse/DL-17068) Lab Home 최신 Support 메시지 | 기존 Support API의 최근1건 재사용 우선. 디자인/세부 기획 대기, 신규 API 대기로 표현하지 않음 |
| 별도 프로젝트 범위 | [DL-17183](https://innovaid.atlassian.net/browse/DL-17183) / [FE DL-17187](https://innovaid.atlassian.net/browse/DL-17187) 이메일 CTA·추적 | SES·FE 진입 후 계측·BE 선행 추적 중 필요한 구조와 지표 확인. 기존 공통 딥링크 재사용. 이메일이 무조건 새 심사를 요구한다고 선결정하지 않음 |
| 별도 기술 후속 | Android 알림 라이브러리 호환 오류 | 실제 대상 바이너리 대조→해결 방식→네이티브 전달 판단. 단순 ‘버전업’으로 축약하지 않음 |
| 정책 후속 · 이번 필수 아님 | [DL-17235](https://innovaid.atlassian.net/browse/DL-17235) USER Promotion/Benefits 수신 설정 | 정책/와이어프레임 확정 후 기존 user 설정 계약과 대조. 자동으로 이번 출시 차단으로 올리지 않음 |
| 보류 | Statements View | 청구서 번호로 검색한 결제내역 화면. 기존 앱에서 그대로 재사용 가능한 동일 화면이 없어 별도 범위 결정 필요 |
| 이번 제외 | PDF·Pay Now·결제내역 전체 확장, 추가 메뉴 재편, 실제 미읽음 OS 배지 고도화 | 승인 없이 다음 필수 개발로 만들지 않음 |

- [DL-17202](https://innovaid.atlassian.net/browse/DL-17202)의 크레딧/청구서 조회·User Credits Auto-apply·설명·아이콘·Learn More 연결과 알림 랜딩은 구현된 범위로 유지한다. 별도 메뉴 없이 노티/푸시로 진입하는 것은 수용된 방향이다. Learn More DEV 콘텐츠404는 목적지 콘텐츠 확인 잔여이며 FE 연결 누락과 구분한다.
- PM Sheet의 P175 밀링 접수 랜딩은 ‘밀링센터는 일단 보류’로 정리돼 있어 이번 필수 문의로 다시 올리지 않는다.
- 본체용 신규 API를 일괄 추가 요청할 근거는 없다. 실제 푸시 QA 데이터가 없다면 BE에 발송 협조를 요청하고, 확인된 계약/실응답 차이만 구체적으로 문의한다.

## 보고 기준

**본체 개발 완료 → 본체 검증·배포의 현재 단계 → 별도 후속** 순서로 답한다. Home3건·이메일·네이티브 후속을 이유로 본체 전체가 미개발이라고 표현하지 않는다. 당일 작업 요약은 그날 사용자 프롬프트를 기준으로 작성하고, 이전 완료 작업을 오늘 한 일에 섞거나 당일 요청을 누락하지 않는다.

## 최종 기본 화면 확인 및 기록 정리

- Office 최종 `5ad23a1`: iOS/Android의 Home → 알림함 → 설정 → 알림함 → Home. 실제 서버 미읽음1건과 설정 응답을 표시했다. iOS는 렌더 핸들러/탐색 호출 후 실제 스크린샷, Android는 설정 좌표 탭·하드웨어 뒤로가기 포함. 마지막 양OS LogBox는 비어 있고 Reactotron socket1이었다.
- Lab 최종 `3632931`: 같은 기본 경로와 Home 기공소 프로필 시트 열기·닫기를 양OS에서 확인했다. 실제 서버 미읽음5건을 표시했고 iOS OS권한OFF 배너/회색 Push와 Android 권한ON 표시를 관찰했다. iOS 렌더 핸들러/탐색·시트 ref 호출 후 실제 화면, Android 설정 탭·하드웨어 뒤로가기·배경 탭 닫기 포함. 최종 양OS Home, LogBox 비어 있음·Reactotron socket1. 이번 제한된 확인 전후 Android crash buffer가 byte 동일해 새 종료 기록은 없었다. 이전 종료 원인의 해결 증거로 쓰지 않는다.
- 새 mock이나 가짜 deliveryId를 주입하지 않았고, 이번 기본 확인에서 서버 읽음·설정 저장·소속 변경 요청은 실행하지 않았다. 태블릿·전체 권한·실제 FCM/APNs 및 기존 배포 바이너리 검증은 위 기본 화면 근거에 포함하지 않는다.
- 실행 근거는 `/tmp/notification-delivery-prep-1110/office-*`, `lab-*` JSON/PNG와 crash-before/after 파일이다. 임시 파일의 영구 보존은 보장하지 않으며 핵심 결과를 이 문서와 각 앱 PR 본문에 남겼다.
- **Jira:** DL-17062/17065/17068 `[본체 외]`·ToDo 유지, DL-17058/17059/17060 PR/appLandingUrl 반영, DL-17064/17067 패치 분리·실제 대상 푸시 검증 미완 정정, 별도 DL-17202 개발완료, DL-17187 이메일 별도 범위·진행 중 유지. 변경10개 카드 read-back에서 제목/본문·parent/assignee/SP 불변을 확인했다. 본체 부모 하위 본인13개는 개발완료10·ToDo3이며 타인/상위 댓글은 변경하지 않았다.
- **Notion:** [FE 참고](https://app.notion.com/p/413ce072e82f814b917ec5868f047420)의4개 작은 구간에서 JS 읽음 완료·실제 푸시 QA 미완·기존 패치 검증의 한계·네이티브 후속을 정렬했다. [PM/BE 공유](https://app.notion.com/p/413ce072e82f81968f43c0563590b495)는 재확인 후 사용자가 정한 배지 현행유지 표를 그대로 유지했다. 새 페이지/계층 변경은 없다.
- API 연결/Jira11/09 이력 및 Android 별도 후속 문서에는 현재 준비 상태를 우선하는 날짜 링크를 추가했다. 과거 원문을 삭제하거나 당시 패치 검증을 현재 미패치 검증으로 바꾸지 않았다.

- **환경 복귀:** 검증용 Lab 앱 양기기와 root가 시작한 Metro8082만 종료했다. 기존 macOS Terminal 소유 Office Metro8081은 유지하고 iOS/Android 병원앱을 다시 실행했다. 마지막 양기기 Home·LogBox 빈 상태·Reactotron socket1, Lab8082 listener 없음 확인. 사용자 브라우저/IDE 배치는 변경하지 않았다.
- **Git 마감 확인13:46 KST:** 제품3개 모두 clean·upstream ahead/behind0/0·remote feature SHA 일치. 위 master/main 원격이 로컬 기준과 일치하고 각 feature의 조상으로 포함됐다. 개인 컨텍스트만 별도 commit/push로 체크포인트를 보존한다.
