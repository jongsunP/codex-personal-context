# 치과 마케팅 수신 동의 — DL-17208

## 현재: 선행 준비 완료·디자인/API 공유 대기 — 2026-11-13

- **사용자 결정:** 별도로 받은 최종 Figma·API 공유는 없으며, Jira에 내용이 없으면 아직 전달되지 않은 것으로 보고 준비만 마친 뒤 작업 대기한다. 새 자료를 추정해 구현하거나 자동 재조회/폴링하지 않는다. 사용자가 이 기능 세션에서 재개한다.
- **완료 범위:** Jira 상위/기획/FE/BE/디자인 카드와 연결·댓글, 부모 첨부, 관련 Figma Profile·댓글, 배경 문서 전체, DEV/STG Swagger, 양 저장소 최신 기본 브랜치·소비 타입·서비스를 확인했다. 제품별 전용 branch/worktree와 의존성 설치까지 준비했다. **제품 코드 수정·제품 commit/push/PR·Jira/Slack 변경·배포 없음.** 실제 웹/앱 실행과 QA는 수행하지 않았다.
- 세션은 `01a1d2b2-0d2f-7441-a68b-fa68affceafc`, local Mac의 기존 메인 프로젝트이며 두 worktree가 이 채팅에 정상 첨부된 것을 확인했다. 휴대폰 실제 목록 노출을 확인한 것은 아니다. 메인으로 별도 진행 메시지는 보내지 않았다.

### 준비한 작업 공간

| 제품 | 전용 worktree | branch / 시작 revision |
| --- | --- | --- |
| 웹 Clinic | `/Users/parkjongsun/.codex/worktrees/dl17208-web/dentlink-client` | `feat/DL-17231`, 최신 `origin/master@9c4418a8fb4b18cbadb5afb25fa32503b59febae` |
| Office 앱 | `/Users/parkjongsun/.codex/worktrees/dl17208-office/dentlink-app` | `feat/DL-17231`, 최신 `origin/main@bf0567d7232ee88a46c1d693de507989c5957719` |

- 기존 FE 카드 DL-17231을 근거로 각 저장소에 같은 이름의 별도 로컬 브랜치를 만들었다. 두 저장소의 Git은 독립이며 upstream/push는 없다. Office 제품별 카드 분리 등 Jira 변경은 승인 후 처리한다.
- 웹: Node `v24.4.1` / pnpm `8.6.9`, `HUSKY=0 pnpm install --frozen-lockfile` exit 0, tracked diff 없음. Clinic `.env.development`만 검증한 main worktree에서 값 열람 없이 복사했고 동일성·0600·ignore/untracked를 확인했다. **주의:** optional `canvas@2.11.2`는 Node24 ARM64 사전 빌드 및 `pkg-config` 부재로 빌드 경고가 남았다. 전체 설치 성공과 실제 서버 실행 성공을 구분한다. 현재 별도 서버는 실행하지 않았다.
- Office: Node `v24.4.1` / Yarn `4.9.1`, `yarn install --immutable --inline-builds` exit 0, native patch 3개 적용 성공, tracked diff 없음. 기존 peer/optional 의존성 경고는 남아 있으며 이를 수정하지 않았다. `env/.env.*`는 원래 추적 중인 checkout 파일이므로 추가 복사·값 열람/수정하지 않았다. Pods·네이티브 빌드·Metro·기기 전환은 수행하지 않았다.
- 다른 작업 기본 checkout은 보존했다. Office 조사 중 기존 알림센터 checkout에 다른 세션 변경이 있었고 최종 준비 전에는 `feature/DL-17059@f78f7a08`로 진행돼 있었다. 이 기능의 base로 가져오거나 수정하지 않았다. 기존 Office Metro8081도 건드리지 않았다.

### 디자인·정책 근거와 미확정 부분

- [상위 DL-17208](https://innovaid.atlassian.net/browse/DL-17208)의 최신 요구는 **웹 가입 2단계 Email 선택 동의(기본 미선택)**와 웹/Office Profile 마케팅 SMS·Email 설정이다. 앱 가입 화면, Lab, 알림함·주문 알림 설정, Email CTA 추적, BigQuery 구현은 이번 FE 범위가 아니다.
- [DL-17230](https://innovaid.atlassian.net/browse/DL-17230)·[DL-17351](https://innovaid.atlassian.net/browse/DL-17351)은 11/10 16:49 KST 완료 상태이나 본문·댓글·외부 연결에 최종 Figma가 없다. [BE DL-17232](https://innovaid.atlassian.net/browse/DL-17232)와 [FE DL-17231](https://innovaid.atlassian.net/browse/DL-17231)에는 구체 API 명세/댓글이 없다.
- 부모 첨부 `image-20261110-015332.png`(31941)를 육안 확인했다. 가입 시안은 `Promotions & news (optional)` / `Texts` / `Email`과 `You can change these anytime in Profile.`이며 Profile에는 별도 `Promotions & news` 카드가 있다. 이 첨부만으로 최종 픽셀·모바일·인터랙션 확정으로 보고 구현하지 않았다.
- 관련 [Figma Profile 517:24607](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=517-24607)의 실제 화면은 Preferences 안 `Promotions & News` 펼침행 후보이다. [댓글2001066057](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=517-24607#2001066057)의 11/10 13:43 KST Oli 후속은 **기획이 바뀌었으니 디자인·플로우 확정 전 이 디자인은 무시**라고 명시한다. 이 댓글보다 디자인 카드 완료 시각이 늦으므로 디자인 전체가 현재 미완료라고 단정하지 않는다. 다만 확인된 링크를 최종본으로 사용할 수 없어 최종 가입/웹·앱 Profile 노드 확보가 필요하다. 읽기 호출만 했고 댓글/읽음상태를 변경하지 않았다.
- [11/3 Doss 배경 요청서](https://dentl.ink/documents/2026-11-03-portal-email-consent-request.html)는 정상 공개 viewer의 `/api/documents/2026-11-03-portal-email-consent-request.html`에서 전체를 확인했다. 신규 기본 미체크·선택, 가입/설정에서 같은 동의값 갱신, 기존 사용자는 **email 묶음 전체 값 없음 유지·소급하지 않음**을 요청한다. 기존 사용자 null을 UI에서 OFF로 표시할지와 실제 응답 형태는 이 문서로 확정되지 않는다.
- 배경의 가입 **1단계**, `Send me lab updates by email.`, `emailMarketingEnabled`, `POST /office/users/register`, `userPreference.email.*`는 원요청/예시다. 후속 Jira의 가입2단계가 우선하며 이 예시를 확정 API DTO나 최종 문구로 사용하지 않는다.

### 확인한 API와 구현 재개점

- 11/13 11:19 KST 전후 [DEV `/v3/api-docs`](https://dev-api.dentlink.io/v3/api-docs) HTTP200. Email 마케팅의 Profile 조회 필드·저장 endpoint·가입 필드는 명세에 없다. [STG `/v3/api-docs`](https://stg-api.dentlink.io/v3/api-docs)는 HTTP404. **STG 서버 미구현/미배포라는 뜻이 아니며 실제 응답은 미확인**이다. 운영 API·실제 계정 조회/설정 변경은 하지 않았다.
- 기존 SMS: GET `/office/users/own` → `userPreference.sms.marketingEnabled`; PATCH `/office/users/own/sms/marketing` → `{ enabled: boolean }`(필수). preference/sms/marketingEnabled 응답의 required/null/default는 명세에 없으므로 Email 기본값으로 전용하지 않는다.
- 일반/초대 가입 POST `/office/users`의 `OfficeUserJoinDto`에는 `smsEnabled`, `marketingEnabled`만 있다(optional boolean, Swagger default=true). 현 FE는 SMS `smsEnabled=true`, `marketingEnabled=false`를 명시한다. 임시가입의 `joinVerifiedUser` → POST `/office/users/register`도 존재하지만 현재 DEV Swagger에 없어, 새 Email 지원 시 **일반·초대·임시가입 모두의 계약**을 확인해야 한다.
- Web 소비 타입은 `shared/models/src/user/user.types.ts`와 `shared/models/index.ts` export이다. generated `shared/models/src/data-contracts.ts`만 갱신해도 화면 타입이 바뀌지 않는다. 생성 결과는 손편집하지 않으며 대상 환경 계약에 따라 실제 FE 타입을 정렬한다.
- Web 변경 지점: `clinic/src/lib/AuthSignupForm/useSignupForm.tsx`, `shared/ui/src/AuthUI/SignupStepper/SignupStepperStep2.tsx`, `clinic/src/components/My/UserSetting.tsx`의 desktop/mobile, `clinic/src/pages/my/index.tsx`와 기존 `useUpdateProfileSms`/`UserApisClinic` 흐름. Stepper의 현재 실행 소비자는 Clinic뿐이나 기존 `signup.marketingAgreement` 번역 key는 Lab도 사용하므로 해당 공용 문구 변경으로 Lab을 건드리지 않는다.
- Office 변경 지점: `src/services/user.service.ts`, `src/queries/useUserQueries.ts`의 `[QUERY_KEYS.USER, serviceType]`, `src/libs/useUser.ts` auth 반영, Profile 조립·styled-components 디자인 시스템. 현재 마케팅 SMS 실제 저장 호출도 없으며 generated `src/models/Api.ts` 선언만으로 앱 구현 완료라 하지 않는다. `src/models`는 생성 전용이고 서비스 경계에서 소비 응답의 shape/null을 계약대로 검증한다.

### 재개 조건·검증 경계

1. 사용자 재개 요청 후 개인 컨텍스트 및 양 repo 원격을 필요한 범위에서 동기화한다. 최종 Figma(가입2단계·웹 PC/모바일 Profile·Office Profile)와 BE의 **대상 환경, Email 응답 경로/타입/required/null, 저장 method/path/body/응답, 가입 경로별 필드, 기존 사용자/미설정 처리**를 확보한다.
2. 확정된 UI부터 기존 구조로 구현하고 실제 API 계약에 연결한다. 그전에는 추정 DTO·가짜 저장·기본 동의 정책·미확정 토글을 만들지 않는다. 현재 준비는 부분 구현이나 최종 QA 완료가 아니다.
3. 웹은 준비한 worktree에서 `pnpm dev:clinic`(충돌 시 확인한 별도 포트), Office는 기존 런타임 소유권을 먼저 확인한 뒤 iOS·Android를 같은 source/env로 함께 전환한다. 의존성 설치만 됐으므로 실제 서버/네이티브 실행 가능성은 재개 때 확인한다.
4. **사용자 결정과 기술 판단: 기능 개발은 독립적으로 하고 릴리즈 통합 시 Profile 접점을 조율한다.** 현재 확인한 목적·API는 분리돼 있고 직접 접점은 Profile 조립 파일이므로 지금 두 기능을 묶을 이유가 없다. 독립 개발 중에도 공통 Profile 수정은 최소화하고 `ProfileScreen.tsx`의 종 버튼과 `ProfileOfficeSection.tsx`의 기존 push 영역 제거를 보존한다. Marketing 영역은 확정 디자인대로 조립한다. 지금 알림센터를 선행 병합하지 않는다. 릴리즈 병합 준비 때 대상 branch의 실제 diff를 비교하고 Git 충돌 해결뿐 아니라 합쳐진 최종 코드의 프로필 배치·알림센터 진입·각 설정 저장/상태 유지가 함께 정상인지 iOS·Android에서 검증한다. 실제 diff가 공통 서비스/상태까지 넓어지면 그 영향도 검증 범위에 포함하며 무조건 두 파일만 보겠다고 제한하지 않는다. 단독 QA를 통합 QA로 보고하지 않는다. 사용자는 단순 동의 대신 이 판단의 근거·한계까지 고려한 의견을 요청했다.
5. 이번 준비에서는 웹 런타임·앱 양OS·실제 저장·통합 QA를 하지 않았다. 코드 최종 실행 증거 전에는 최종 QA/merge 준비 완료라 하지 않는다. 제품 commit/push/PR/merge/배포와 Jira 변경은 별도 승인이다. 이 기능 세션을 유지하며 사용자 요청 전 자동 확인/모니터링은 하지 않는다.

## 기능 세션 인계 완료 — 2026-11-13

- 사용자 승인으로 **치과 마케팅 수신 동의 · DL-17208** 세션 `01a1d2b2-0d2f-7441-a68b-fa68affceafc`를 현재 메인 프로젝트에 생성했다. 실행 host는 기존 Mac `local`, projectId는 `4a13e754-960d-4ca3-b716-8f7a19311b64`, cwd는 `/Users/parkjongsun/Documents/ChatGPT/메인 프로젝트`다. 새 프로젝트 폴더는 만들지 않았다.
- 메인의 실제 설정과 같은 `gpt-6-astra` / `ultra`를 명시했고, 신규 세션의 turn_context에서도 적용을 확인했다. 프롬프트 전달과 작업 시작 확인은 1회로 마쳤다. 이후 메인은 자동 추적·폴링하지 않는다.
- 웹·Office를 이 한 기능 세션에서 관리한다. 실제 디자인·API부터 확인한 뒤 확정 범위의 로컬 준비·구현을 진행한다. 미확정 디자인/필드/정책을 추정하지 않고 가능한 선행 작업과 정확한 보류·재개 지점을 남긴다. 제품별 Git·검증·PR·배포 경계는 유지하며 제품 commit/push/PR/배포·Jira 변경의 별도 승인 범위도 전달했다.
- 사용자가 **앱 프로필 화면 중복**을 재확인했다. 별도 세션 운영은 유지하되 알림센터의 종 버튼·기존 push 영역 변경을 보존한다. 향후 병합 준비에서 대상 브랜치와 해당 파일 차이를 대조하고, 양 기능을 합친 최종 프로필의 배치·진입·설정 동작을 검증한다. 단독 코드 검증을 통합 검증으로 보고하지 않는다. 지금 알림센터 병합/감독을 지시한 것은 아니다.
- 메인은 전달·등록 기록만 정리했다. 이후 디자인/API 조사·구현·검증·보류 해소는 새 세션에서 사용자와 이어간다.

## 최초 조사 — 2026-11-13

- 사용자 요청은 [DL-17208](https://innovaid.atlassian.net/browse/DL-17208)의 범위 파악과 알림센터 별도 세션 적합성 판단이다. 조사만 수행했으며 신규 세션/branch/worktree·구현·Jira 변경은 하지 않았다.
- **판단:** 치과 회원가입·프로필의 마케팅 SMS/Email 동의라는 별도 기능으로, 웹과 Office 앱을 함께 맡는 새 작업 세션이 적절하다. 알림센터의 알림함·주문 알림 설정 구현을 선행해야 하는 코드 의존성은 확인되지 않았다. 완전한 파일 독립을 의미하지는 않는다.

## Jira에서 확인한 요구와 상태

| 대상 | 요구 |
| --- | --- |
| 치과 웹 회원가입 2단계 | UI 일부 수정, 이메일 수신 동의 체크박스 추가, 기본 미선택 |
| 치과 웹·치과앱 Profile | Marketing 섹션 추가, Text messages 명칭 변경·툴팁 제거, Email 옵션 추가 |
| BE | 상위 본문에 users_email_preference 추가 명시. 이는 저장 구조 설명이며 FE가 쓸 필드명/조회·저장 API 확정 근거는 아님 |

- 상위는 진행 중, 계획된 수정버전 v1.94.0(2026-11-23)이다. 기획 DL-17226과 디자인 DL-17230(웹 가입)/DL-17351(웹·앱 Profile)은 완료. Frankie FE **DL-17231**과 Crong BE **DL-17232**는 해야 할 일이다. FE/BE 하위의 설명·댓글에 구체 API 명세는 없었다. Jira 상태만으로 서버 구현/배포 여부를 단정하지 않는다.
- 상위 댓글44969(11/10 Jun)은 알림센터와 연관돼 같이 작업해 달라고 하면서 Web/App 프로필의 마케팅/이메일 on/off를 언급했다. 이 조율 요청과 별도 기능 세션 운영은 양립 가능하다. 기공소까지 확대할 요구는 확인되지 않았다.
- 본문은 BigQuery users_privacy도 언급하지만 FE 구현 범위로 임의 편입하지 않는다. 계획된 웹 release 버전은 신규 작업의 기본 branch를 바꾸는 근거로 쓰지 않는다.

## 코드로 확인한 경계

- Web 기본 checkout은 `feat/DL-17141-delay-cleanup@a4f70d33`, clean·upstream 동일. fetch한 origin/master는 `9c4418a8`. 확인한 signup/Profile 페이지·훅은 master와 차이 없다. 기존 가입 폼은 smsEnabled=true, marketingEnabled=false를 사용한다. 새 Email 동의와 기존 SMS 동의를 섞지 않는다.
- Web `/auth/signup`의 2단계는 Name/Phone/Marketing이고, `/my`의 `UserSetting.tsx`에 데스크톱·모바일 Promotional SMS 토글/툴팁이 있다. `useUpdateProfileSms.tsx` → `UserApisClinic.updateSmsMarketingEnabled` → PATCH `/office/users/own/sms/marketing`을 실제 사용한다. 상태는 `userPreference.sms.marketingEnabled`다.
- Office 기본 checkout은 `feature/DL-17059@f152f6cd`, clean·upstream 동일, 등록 worktree 하나. fetch한 origin/main은 `bf0567d7`. 최신 main과 알림센터 feature 모두 네이티브 Profile 마케팅 SMS/Email 토글·실제 저장 호출은 없었다. generated Api.ts의 기존 SMS 선언만으로 앱 구현 완료라 하지 않는다.
- Office에 네이티브 가입 화면/라우트가 확인되지 않아 이번 가입 단계는 웹 범위로 분류한다. Office Profile은 GET `/office/users/own`, 알림센터 설정은 별도 GET/PUT `/office/notifications/settings`다.
- **겹치는 파일:** 알림센터는 `src/features/profile/screens/ProfileScreen.tsx`에 종 버튼을 추가하고 `src/features/profile/sections/ProfileOfficeSection.tsx`의 기존 push 설정 영역을 정리했다. 새 Marketing 섹션 배치·병합 시 해당 변경을 보존해야 한다. 동일 파일 접점 때문에 기능 세션 전체를 합칠 필요는 없다.

## 다음 시작점과 확인 한계

1. 등록한 기능 세션에서 웹·Office를 함께 관리하되 저장소별 branch/검증/PR은 구분한다. 기존 FE 카드 DL-17231을 먼저 확인하고 제품별 카드 분리는 외부 변경 승인 범위에서 정리한다.
2. 완료된 디자인의 실제 Figma와 BE의 Email 조회·저장/가입 요청 필드, 기본값·기존 사용자 정책을 확인한다. 이번 조사는 Figma 픽셀/상호작용 검토·Swagger/실API 검증·런타임 QA가 아니다. 본문 배경 링크는 HTTP200·문서 제목만 확인돼 전체 내용을 읽었다고 하지 않는다.
3. [알림센터 정본](dentlink-unified-notification-center.md)의 Profile/USER 수신 정책 접점만 필요한 범위에서 대조한다. 이메일 CTA·유입 추적 [DL-17183/17187](dentlink-email-cta-tracking.md)과도 별도 기능이다. 알림센터 세션을 폴링하거나 그 작업을 재개하지 않았다.

