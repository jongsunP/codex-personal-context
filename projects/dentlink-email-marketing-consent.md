# 치과 마케팅 수신 동의 — DL-17208

## 조사 완료·구현 전 — 2026-11-13

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

1. 사용자가 진행을 지시하면 별도 기능 세션에서 웹·Office를 함께 관리하되 저장소별 branch/검증/PR은 구분한다. 기존 FE 카드 DL-17231을 먼저 재사용하고 제품별 카드 분리는 구현 접수 승인 범위에서 정리한다.
2. 완료된 디자인의 실제 Figma와 BE의 Email 조회·저장/가입 요청 필드, 기본값·기존 사용자 정책을 확인한다. 이번 조사는 Figma 픽셀/상호작용 검토·Swagger/실API 검증·런타임 QA가 아니다. 본문 배경 링크는 HTTP200·문서 제목만 확인돼 전체 내용을 읽었다고 하지 않는다.
3. [알림센터 정본](dentlink-unified-notification-center.md)의 Profile/USER 수신 정책 접점만 필요한 범위에서 대조한다. 이메일 CTA·유입 추적 [DL-17183/17187](dentlink-email-cta-tracking.md)과도 별도 기능이다. 알림센터 세션을 폴링하거나 그 작업을 재개하지 않았다.

