# Dentlink 이메일 CTA 웹·앱 연결·추적

최종 갱신: 2026-11-04 — 이메일 작업의 별도 범위를 유지한다. 알림센터 feature에 남았던 이메일 유래 Android 브라우저 모듈까지 정리했고 공통 노티/푸시 동작은 기존 기능으로 유지했다. 원 이력·조사는 보존하며 이메일 작업의 별도 재개 지시 전에는 구현·배포·검증을 진행하지 않는다.

## 현재 범위와 작업 경계

- **이메일 CTA, 앱 설치 여부에 따른 웹/앱 연결, 웹 fallback, SES, 이메일 분석·클릭 추적은 통합알림센터의 검토·개발·완료 조건에서 완전히 제외한다.** 단순히 배포 시점만 분리한 것이 아니다.
- 이메일 정본 Jira는 [DL-17183 — 시스템 발송 메일 읽음 여부 추적](https://innovaid.atlassian.net/browse/DL-17183), FE 구현 기록은 그 하위 [DL-17187 — 이메일 CTA 웹·앱 연결 및 추적 연동](https://innovaid.atlassian.net/browse/DL-17187)이다.
- 통합알림센터는 노티/푸시 클릭 처리와 웹·앱 알림함/설정, 합의된 추가 앱 목록을 담당한다. [알림센터 정본](dentlink-unified-notification-center.md)과 DL-17202에 이메일 작업을 다시 섞지 않는다.
- 알림설정에 이미 포함된 Email 수신 채널의 표시·저장은 이메일 CTA/추적과 구분한다. 이번 분리를 기존 승인 UI의 삭제 근거로 확대하지 않는다.
- 관련 변경이 이미 같은 제품 feature에 들어 있다는 사실과 이번 알림센터 배포에 포함해도 된다는 판단은 다르다. **11/3 후속 승인으로 이메일 전용 OS 진입 설정을 알림센터 feature의 현재 변경에서 분리했다.** 공통 URL 처리와 이전 원 커밋은 유지한다.

## 2026-11-03 알림센터 범위 분리 반영

- 별도 이메일 구현을 시작한 것이 아니라, 승인된 알림센터 코드에서 이메일 전용 진입 설정만 제외했다. Web의 `6dca5142b` 16파일은 직전 상태로 복원했고 Office portal native 등록·Lab q외 신규 HTTPS 등록을 제거했다. 원 이력은 남겼다.
- FCM/인박스가 앱에 전달한 URL의 파싱·지원 경로 변환·소속 활성화·로그인 대기, 기존 Airbridge와 Lab `/q/*`, 공통 browser fallback은 알림센터/기존 기능에서 사용해 보존했다.
- **11/4 후속 정리 완료:** 위 보존 이력은 새 Android `BrowserPackage`가 알림센터에 필수라는 판단이 아니었다. 사용자 승인으로 양 앱의 모듈·등록을 제거하고 공통 웹 링크 열기를 기존 `Linking.openURL`로 대체했다. Office의 raw Airbridge 수신 재전달 방지와 Lab의 기존 QR/도메인 분기를 유지·검증했다. 모듈 없는 Android 빌드와 양 OS 영향 실행 완료, 누적 native/라이브러리 변경0. 기준은 심사 회피가 아닌 확정된 작업 범위이며 상세 SHA/검증·마감은 알림센터 정본을 따른다. 이메일 연결·추적을 재개한 것은 아니다.
- 아래 마지막 HEAD 표와 14:05 절은 **분리 전 복구/조사 근거**다. 최신 제품 위치와 SHA는 [알림센터 현재 정본](dentlink-unified-notification-center.md)을 따른다. 이메일 재개 시 원 커밋의 전용 설정만 필요한 범위로 다시 검토하며 공통 기능 전체를 다시 적용하지 않는다.

## 팀 공유 문서와 근거

- 이메일 대문: [이메일 CTA 웹·앱 연결·추적](https://app.notion.com/p/innovaid/40dce072e82f819ca557c474effabaea).
- 범위·진행 상세: [이메일 CTA — 작업 범위·진행 정리](https://app.notion.com/p/innovaid/40cce072e82f81fda0e2d123259d5501). 기존 공유 링크는 그대로다.
- 비교 문서: [FE 선행과 BE 선행 방식 비교](https://app.notion.com/p/innovaid/40cce072e82f81e491c2ec9420136498).
- 기술 조사: [SES·Airbridge·BE 추적 구조](https://app.notion.com/p/innovaid/40cce072e82f81a5909ee40aef18985f).
- **문서 분리 확인:** 사용자 후속 정정에 따라 새 이메일 대문을 원 모바일웹 비교 대문·앱 지원 추가 항목 단일 문서와 같은 Development Documents data-source 직속에 만들었다. 기존 범위·진행 정리, 비교, SES 세 상세 페이지를 새 대문의 직접 하위에 나란히 배치했다. 11/3 fetch로 최종 부모·자식 관계와 본문 보존을 확인했으며 기존 상세 페이지 ID/공유 링크를 유지했다.
- [메일 CTA 현황표](https://docs.google.com/spreadsheets/d/1XCtAfe5nwsH90APhw1BxsMAmuAzWouqYoJfJCxPvFJU/edit?gid=1262427502#gid=1262427502)는 이메일용이다. 알림센터의 NOTIFICATION/PUSH 랜딩 시트와 목적지를 혼용하지 않는다.
- [이메일 회의 Slack](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793589700410469): 마지막 조사 근거는 11/2 22:05:57 KST 답글까지이며, 11/3 신규 댓글 조회 결과가 아니다. 폴링하지 않는다.
- 이전 상세 이력은 [범위 분리 전 기록](archive/dentlink-unified-notification-center-through-2026-11-03.md)의 날짜가 붙은 11/2 절에 보존한다. 그 안의 이메일 다음 작업은 이 문서의 최신 분리 지시보다 우선하지 않는다.

## 분리 전 구현 위치 — 복구용 이력

아래 HEAD는 **2026-11-03 문서 정리 중 로컬 Git으로 재확인**했고 세 checkout 모두 clean이다. 구현·기기 실행 근거는 11/2이며 이번에 런타임·원격 배포를 새로 검증한 것이 아니다. 재개 전에 live Git으로 다시 확인한다.

| 제품 | checkout / branch | 마지막 확인 HEAD |
| --- | --- | --- |
| Web | `/Users/parkjongsun/Repository/dentlink-client-notification-center` / `feature/DL-17058` | `6dca5142ba4b179c92d580bc19a4b089f9718b6d` |
| Office | `/Users/parkjongsun/Repository/dentlink-app` / `feature/DL-17059` | `e983956b17202e436ebda323eb2b471403ba2b38` |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app` / `feature/DL-17060` | `c3120118a1d9628be900fa96051e5eae36c59ce4` |

- 기존 feature에는 공통 URL 해석·로그인 대기 복원·연속 링크 보호와 이메일 연결을 고려한 HTTPS/native 도메인 설정이 함께 있다. 선행 커밋·푸시 기록은 있으나 별도 이메일 feature/PR로 분리한 상태는 아니다.
- 웹은 환경별 AASA/assetlinks 제공과 지원 경로 연결, Office는 portal native 도메인·지원 금융 URL 처리, Lab은 기존 QR 밖 지원 HTTPS 경로 보완이 있다. `app-links.ts`는 연결 JSON 선택 코드이며 클릭 저장·앱 설치 감지 서버가 아니다.
- Office iOS/Android와 Lab 양 OS에서 선행 URL/화면 처리의 제한된 로컬 실행 검증을 했다. 명시적으로 앱에 전달한 HTTPS 검증과 실제 수신 이메일에서 OS가 앱을 자동 여는 검증은 다르다.
- PR·merge·웹/앱 배포·CodePush는 완료되지 않았다. 이메일 전용 분석 이벤트·최종 발송 URL·추적 연결까지 구현 완료된 것도 아니다.
- Office staging Android 배포 서명, 공개 도메인 적용 후 실제 이메일 클라이언트별 동작은 남는다. native 변경은 CodePush만으로 전부 반영되지 않는다.
- 웹 크레딧/청구서는 활성 소속으로 조회하며 URL의 employerId를 자동 적용하는 상태가 아니다. 특정 병원의 이메일 목적지는 기존 소속 전환과 최종 URL 계약을 함께 확인해야 한다.

## 보존된 방향과 추가 조사 결과

- 앞선 구두 합의는 이메일에서 지원하는 웹/앱에 진입한 뒤 필요한 유입 정보를 Amplitude로 기록하고, 필요할 때 FE→BE 기록을 연결하는 방향이었다. 진입 전에 중단된 클릭까지 모두 수집하는 구조는 아니며 누락 가능성을 감안했다.
- 이후 SES 사용 가능성이 제기돼 서버 선행 추적을 추가 조사했다. **SES 채택·직접 BE redirect 채택·Airbridge 재도입 중 어느 것도 새 확정 계약이 아니다.**
- SES 후보는 사용자 이동 `이메일→SES 추적 URL→기존 HTTPS 목적지→웹/앱`, 기록 수집 `SES→SNS/EventBridge 등→BE→DB`를 분리한다. DB 수집은 비동기이므로 우리 DB 저장 완료 후에만 이동한다는 보장은 없다.
- 사내 SES 실제 발송 경로·configuration set·Open/Click 활성화·기존 이벤트 수집기는 미확인이다. 새 클릭 API를 먼저 요구하지 않고 기존 기능 재사용 가능성부터 확인한다.
- 직접 BE 방식도 가능하다. 메일 앱/브라우저의 GET에 BE가 기록 후 302/Location을 반환하고 요청 클라이언트가 다음 주소로 이동한다. 웹소켓이나 BE의 원격 앱 실행이 아니며, BE 요청이 필수라면 최초 추적 URL을 OS가 먼저 앱으로 넘기지 않도록 설계한다.
- Airbridge도 동적 path/query를 지원하므로 동적 주소라는 이유만으로 불가능하다고 일반화하지 않는다. Airbridge 캠페인과 자체 유입 metadata/Amplitude는 구분한다. 기존 앱 Airbridge SDK 제거 지시도 아니다.
- 최종 앱 실행은 OS의 Universal Links/App Links 검증과 메일 앱·브라우저·사용자 설정에 영향을 받는다. SES나 BE의 redirect만으로 모든 설치 환경의 자동 앱 실행을 보장하지 않는다.
- SES custom tracking domain/`ses:custom-path` 앱 연결은 추가 후보다. 앱이 받은 SES URL의 목적지 복원과 HTTP를 우회한 클릭 관측까지 검증되지 않았으므로 도메인 추가만으로 완성됐다고 취급하지 않는다.

## 지표와 연결 계약

- Delivery는 수신 메일 서버 전달, Open은 추적 이미지 요청, Click은 추적 URL 요청, FE 진입은 실제 계측 코드 실행이다. 알림센터의 인증 REST 읽음과 별개다.
- SES Open/Click은 HTML 메일 대상이다. 이미지 차단·프록시·캐시·보안 스캐너 때문에 사람의 실제 열람/클릭과 차이가 난다. `isBotEvent`는 가능성 판단이며 사람 여부의 완전한 증명이 아니다.
- SES 발송 ID·SNS 전달 ID·업무 ID·알림 ID를 구분한다. 같은 메일의 정상 재클릭과 같은 이벤트의 재전송도 구분한다.
- SES 발송/링크 태그는 최종 FE URL에 자동 전달되지 않는다. 메일 종류·버튼·발송 건과 FE 진입을 연결할 정보가 실제로 보존되는지 계약을 맞춘다.
- 요청 userAgent와 실제 웹/앱 실행 기기는 다를 수 있고, 전달된 이메일의 원 수신자와 로그인 사용자도 같다고 단정하지 않는다.
- 실제 이벤트명·key·자체 DB API·추적 방식은 후속 계약으로 정한다. 예시 필드나 조사 문서를 구현 완료·확정 명세로 바꾸지 않는다.

## 코드 분리 전 조사 이력 — 2026-11-03 14:05 KST

- 알림센터 코드 범위 점검에서 현재 feature diff를 읽어 분류했다. 이메일 구현을 재개하거나 제품 코드를 분리/제거한 것은 아니다. 아래는 실제 분리 전 조사 시점이며 이후 승인 구현으로 이메일 전용 설정 분리를 완료했다. 상세 근거는 [11/3 작업 이력](archive/dentlink-unified-notification-center-2026-11-03-worklog.md)의14:05 코드 범위 점검 절에 보존한다. 최신 완료 경계는 [알림센터 현재 정본](dentlink-unified-notification-center.md)을 따른다.
- Web `6dca5142b`는 Clinic association 파일/handler/rewrite 신규와 Lab AASA 경로 확대16파일로, 앞의 알림 UI4커밋과 구분된다. 기존 Lab `/q/*`·handler·assetlinks는 base부터 존재하므로 전체 폴더 제거 대상이 아니다.
- Office `9ae3cf3`의 portal native 도메인/OS 입구와 Lab `28ebcd8`의 q외 HTTPS/native browser fallback은 분리 후보지만, 같은 커밋에 공통 화면 route·소속 활성화·안전한 URL 변환이 섞여 있다. 전체 커밋 revert를 하지 않는다.
- FCM이 이미 `convertURLForApp`을 호출하므로 앱 내부 HTTPS→앱 경로 변환은 이메일 전용이 아니다. 로그인 pending·최신 링크 보존·기존 밀링 소비자 보호·추가 Office 조회 route도 알림센터에서 보존한다. browser fallback은 JS 호출부와 native 등록을 함께 검토하는 혼재 영역이다.
- 기존 Airbridge SDK/scheme·push_click·Email 수신 설정은 유지한다. SES·이메일 신규 이벤트/DB 추적은 이 범위 점검으로 구현된 것이 아니다.

## 이메일 작업 재개 순서

1. 이메일 작업의 별도 재개 지시를 받은 뒤 최신 Git·DL-17183/17187·메일 CTA 시트·BE 계약을 대조한다.
2. 11/3 분리 이후 live Git과 보존한 원 커밋을 대조한다. 필요한 이메일 전용 설정의 작업/전달 단위를 정하고, 공통 노티/푸시 기능을 전체 revert하거나 원 혼합 커밋을 그대로 다시 적용하지 않는다.
3. 실제 SES 사용·추적 활성화·기존 수집 여부와 요구 지표를 확인해 현재 FE 중심/SES 재사용/자체 BE/Airbridge 필요성을 판단한다.
4. 최종 목적지·소속·연결 식별 정보·분석 계약을 맞추고 승인된 범위만 구현한다. 기존 기능으로 가능한데 새 API나 별도 서버를 일괄 요구하지 않는다.
5. 실제 발송한 대표 메일로 설치/미설치·iOS/Android·로그인 전후·소속·주요 메일 앱과 기록을 대조한다. SES/BE 기록과 FE 진입은 단계별로 검증한다.
6. 이메일 코드 검증·사용자 QA·PR·release·배포·운영 확인을 구분한다. 위 항목을 통합알림센터 완료의 선행 조건으로 되돌리지 않는다.
