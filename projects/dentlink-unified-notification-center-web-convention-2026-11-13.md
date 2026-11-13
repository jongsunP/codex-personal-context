# 알림센터 웹 문구·스타일 구성 정리 — 2026-11-13

## 요청과 결과

- 사용자 승인: 웹 코드의 Copy 이름을 명확히 하고 기존 코드의 주된 스타일 배치에 맞춘 뒤 커밋·푸시한다. 개발서버 배포는 하지 않는다.
- `useNotificationCopy`를 `useNotificationMessages`로 변경했다. 기존 Copy는 복사 동작이 아닌 화면 문구를 의미했으며, 문구값·번역 키·언어별 표시는 그대로다.
- `NotificationInbox.styles.ts`, `NotificationSettings.styles.ts`를 제거하고 스타일 선언을 해당 컴포넌트 하단으로 옮겼다. 별도 스타일 파일의 사례가 있다는 것과 그것이 팀의 주된 규약이라는 것은 다르다. 11/12 기록의 스타일 분리를 팀 규약으로 단정한 표현도 바로잡았다.
- 거대한 TSX 하나로 합치지 않고 기존 UI 단위 5개(Header/Toolbar/ListItem/SettingsGroup/SettingsOrderScope)로 나눴다. 변경 컴포넌트는 각각 200줄 이하이며 새 화면·문구·동작·API·권한·경로·스토리북은 추가하지 않았다.

## 코드와 전달 경계

- 위치: `/Users/parkjongsun/Repository/dentlink-client-notification-center`
- 브랜치: `feature/DL-17058`
- 시작 시 원격의 릴리즈 통합/버전 변경 3개 커밋만 확인해 fast-forward했다. 기준 `b75ed0a531c92d27b3fcdf111d9155b187284851`.
- 완료 커밋: **`a67e1e215c49f21c3139df6edd5df8d901771294`** — `refactor: 알림 문구 훅과 컴포넌트 스타일 구성 정리`
- 정상 commit/push hook을 통과하고 원격 SHA 일치·작업트리 clean을 확인했다.
- 기존 [PR4862](https://github.com/Innvoaid/dentlink-client/pull/4862) head에 자동 반영됨. OPEN/Draft·`release/v1.94.0` 대상 유지. PR 병합·develop 변경·개발 배포 없음.
- Office/Lab 앱 코드·CodePush 변경 없음. 기존 개발 전달 기준은 웹 develop `7c8eef28c`, Office v147/v147, Lab iOS v46/Android v45다. 웹의 이전 배포 결과를 이번에 다시 추적하지 않았다.

## 검증

| 범위 | 확인 결과 |
| --- | --- |
| 독립 코드 비교 | 기존 스타일 39개 정의의 누락/값 변경 0. 지역 소유를 위해 같은 StyledText 정의가 반복되어 총44개. 문구 훅은 이름 외 내용 동일. 불필요한 DOM 래퍼 없음, 타입 참조는 import type. |
| 정적·기존 테스트 | Clinic/Lab 기존 host tests 5+4 통과. 변경 파일 포맷·diff 확인. 정상 pre-commit의 Clinic/Lab/Admin tsc 전부 통과. 정상 pre-push의 저장소 필수 검증 통과. 새 테스트/스토리 추가 없음. |
| 최종 브라우저 | 현재 최종 코드로 Clinic 5개/Lab 4개 확인 묶음 통과. 인박스·All/Unread·단일/전체 읽음·빈 상태·설정 토글/상하위·뒤로가기/재진입·Clinic 범위 선택·영문/한글을 확인. 두 제품 새 pageerror 0, 화면 캡처 검토. |
| 검증 한계 | 저장된 로그인 세션을 사용했지만 알림 조회/쓰기 응답은 fixture다. 실제 설정/읽음 쓰기 0·분석 전송 0. 실제 BE/푸시/전체 QA 완료 근거로 확대하지 않는다. |
| E2E | 이번 리팩터링 delta는 독립 영향 검토 NO_IMPACT. 전체 기능 브랜치 E2E 실행은 기존 사용자 지시에 따라 SKIPPED이며 새 실행하지 않음. 두 결론을 혼동하지 않는다. |
| 환경 | 자체 headless 브라우저와 3030/3035 서버만 종료. 사용자 창·앱·Metro·Reactotron 배치/실행은 유지했다. 최종 runtime 소스 23개 해시가 커밋 후 파일과 동일. |

Shared 기본 lint 실행의 기존 Storybook config 중복은 shared의 기존 config를 명시하여 검증했다. 변경 영역 0 errors, 기존 NotificationCenter dependency warning 1개다. 이 리팩터링에서 config를 바꾸지 않았다.

임시 실행 근거: `/tmp/notification-web-convention-1113.md`, `...-runtime-1113.md/json`, `...-runtime-source-1113.json`, `...-e2e-1113.json`, `...-static-1113.json`, `/tmp/notification-web-convention-push-1113.log`.

## 번역 지침 정정과 다음 시작점

- i18n 전후 비교: keys3600/unresolved211/unknownLiteral1/reachable3364/dynamic209/usageRows4706 유지. 기존 unknown literal은 SigninForm의 `account.auth.actions.logIn`이며 이번 변경과 무관하다. 전체 i18n 감사가 오류 0이라고 표현하지 않는다.
- 파일 이동에 따른 sourceLocation/사용처 ID 변경은 코드 감사 메타데이터 차이일 뿐, **번역 시트 후속 업무가 아니다**. SESSION_WORKFLOW.md의 2026-11-11 변경은 코드 ko/en만 관리·검증하고 시트는 그대로 두도록 정한다. 이번에 시트 갱신이 필요하다고 안내한 것은 옛 팀 지침을 우선한 오류였으며 사용자의 11/13 지적으로 바로잡았다. 실제 시트 수정·동기화는 없었다.
- 최신 공통 지침과 웹·Lab 앱 번역 체크포인트에는 이미 올바른 정책이 명시되어 있어 규칙을 새로 추가하지 않았다. 기존 시트 스크립트·팀 문서도 그대로 둔다. 향후 작업에서도 시트 행/사용처 갱신을 미완료나 후속으로 만들지 않으며, 시트 기반 생성이 코드 ko/en 값을 덮지 않도록 확인한다.
- 재개 시: 현재 웹 리팩터링은 커밋·푸시 완료 / 미배포임을 먼저 구분한다. 배포는 별도 지시 후 진행한다. 기존 BE 답변·실기기 QA 대기는 별도 기록을 유지하며 자동 확인하지 않는다.
- [Office 주문 상세 후속](dentlink-unified-notification-center-office-native-detail-followup.md): DL-17436, 1.93.0 배포 후 치과앱 자체 주문 상세와 알림 랜딩을 대조. **기공소앱은 제외**. 이 기록은 지금 앱 구현을 시작하라는 지시가 아니다.

## 최종 대기 및 지침 적용 보완

- 사용자는 11/13 정리 후 대기를 요청하면서 지침 동기화를 날짜별 의무 확인이 아닌 자동 처리로 희망했다. 기존 시작·재개 자동 동기화는 유지하고, 진행 중 업데이트 안내/규칙 충돌 때도 관련 최신 정본을 재확인하도록 SESSION_WORKFLOW의 기존 규칙 적용 항목을 보완했다. 이번 문제는 미동기화가 아니라 최신 정책 적용 누락이었음을 구분한다.
- 제품 코드는 a67e1e215 커밋·푸시 완료 / 미배포 그대로다. 번역시트 후속 없음. Office DL-17436은 향후1.93배포 후 후속이며 즉시 재개하지 않는다. 추가 구현·배포·자동 감시 없이 사용자 재개 요청까지 대기한다.

- 사용자 최종 명확화: 자동 동기화 원칙은 번역에 한정하지 않고 **전체 작업지침**에 적용한다. 필요한 변경만 적시에 확인·반영하며 무조건 전체 조회하지 않는다.
- **오늘 마감·다음 재개 브리핑:** 사용자가 다음 재개 시 배포 및 남은 일을 먼저 설명하도록 요청했다. Web a67e1e215는 push/기존 PR 반영 완료·아직 미배포, 앱은 이번 코드 정리에서 변경 없음. 재개 시 해당 시점의 실제 Git/배포 기록과 대조해 완료한 것→현재 영향→남은 일 순으로 안내한다. 미배포 웹 반영 여부, 별도 BE/디자인 답변·사용자 QA 결과, 1.93.0 이후 Office native 상세 후속 DL-17436을 구분한다. 브리핑 요청 자체로 배포·구현을 시작하지 않는다. 번역시트 갱신은 남은 일에서 제외한다. 오늘 추가 작업은 종료하고 자동 감시 없이 대기한다.
