# 통합알림센터 재개 감사 이후 개발 배포·마감 · 2026-11-12

사용자는 전체 검토 결과를 받은 뒤 웹 DEV 배포·양 앱 Development CodePush, 기존 검토 PR 유지, 본인 Jira 정리와 실제 미완료 작업 카드 생성, 기억 정리 후 대기를 승인했다. Slack은 읽기 전용이며 배포 스크립트의 자동 Slack 발송도 끄고 실행했다.

이 문서는 같은 날 [동기화](dentlink-unified-notification-center-sync-2026-11-12.md) → [규약·요구사항 검토/수정](dentlink-unified-notification-center-review-2026-11-12.md) 이후의 전달 결과다. 앞 문서의 '배포 없음'은 당시 단계의 기록이다.

## 다른 에이전트 작업과 이번 작업의 구분

| 항목 | 받아들인 기존 변경 | 이번 확인·조치 |
| --- | --- | --- |
| 알림 설정 API | `{view, setting}`에서 `{user, employee}` 및 서버 순서로 이전. 전체 PUT·읽기용 메타 제외·숨긴 값 보존 | 최신 BE44978/사용자44994·Swagger/DEV GET·소비 코드와 대조. 임의 새 키/정책 추가 없음 |
| 앱 규약/응답 검증 | 수작업 NotificationApi 제거, 생성 모델·중첩 null 검증으로 이전 | 남은 StyleSheet 정리, 기존 화면까지 최종 양OS 검증, 앱 개발자 리뷰3건 해결 |
| 웹 규약/문구 | 새 설정 렌더와 일부 리뷰 대응 | models와 UI 책임 분리, 임의 오류 문구는 기존 공통 UI/문구로 정리, 확정 선택 문구 반영 |
| 진입/랜딩 | appLandingUrl·deliveryId 푸시 읽음·앱 목록은 기존 구현 | Lab 웹의 별도/밀링 헤더 누락, Office 배송 경로의 employerId 포함 형식 누락 보완. 시트 현재173행 기준 대조 |
| Android 네이티브 | Notifee 별도 PR348/44가 11/11 release/v2.2.5·v1.0.6에 병합 | 이번 JS 배포에 합치지 않음. Git merge가 스토어 심사 완료의 증거는 아님 |
| iOS 중복 배너 | 11/10 JS 보완 배포 및 사용자 실기기 확인 완료 | 과거 확인 대기로 되돌리지 않음. 이번 배포는 후속 JS 변경 |
| 공통 운영 | 사무실/집·Claude/Codex별 일반 메인과 상시 기능 세션, inbox/이중 기록 | 현재 Codex 구조 유지, 필요한 기록/지침 동기화, 중복 감독·자동 추적 없음 |
| 개발 환경 | 외부 실행·양OS/Reactotron·별도 테스트 브라우저, 번역 ko/en 코드만·생성 모델 손수정 금지 | 개인 앱 플레이북/최종 diff 검토 규칙 보완. 별도 OpenAI 이름 로컬 Git 저장소는 찾지 못했고 현재 Codex 설정/메모리/채팅으로 대조 |

## 배포 결과

### 앱 Development

| 제품 | 소스 | iOS | Android | 바이너리 대상 |
| --- | --- | --- | --- | --- |
| Office | feature/DL-17059 · a624b5985a7d6bc2f045f7b989aacf92a95e66fb | v142 → **v143**, 20:42:10 KST | v142 → **v143**, 20:42:42 KST | 2.2.4 |
| Lab | feature/DL-17060 · d018b85530ca0fd698e372948b5cbf72e3c826e7 | v40 → **v42**, 20:38:36 KST | v40 → **v41**, 20:39:13 KST | 1.0.5 |

- 네 건 모두 enabled, mandatory, rollout100 확인. 실제 대상 앱·플랫폼·버전·소스와 라벨을 이력에서 각1회 확인했다. 실제 기기 수신/실행은 확인하거나 폴링하지 않았다.
- 직전 배포 소스 Office d4de608 / Lab e9108b8 대비 native·package/lock·patches·entry/Metro 설정 변경0. 양 앱 feature/원격 clean·0/0, 기존 PR346/42는 그대로 유지.
- 이번 배포는 2.2.4/1.0.5용이다. 별도 Android 네이티브 개선 릴리즈의 2.2.5/1.0.6 바이너리에 자동 전달됐다고 하지 않는다.
- 최종 패키지 hash: Office iOS `1e32736ea731f6af840b7b50ae277eb5e6a5d7bdcb8f8ed4e217b0e06614fd9a`, Android `bad9c9e1925b476e546793b3f250a0a5e2e1a5e35cc53ea9d1800b8a413e77e6`; Lab iOS `c312e787e12322ee9b080811e13b65bbec3595c6a70e3084dba4f7052d2a44ad`, Android `7f5fdf0b80ba4245710541f9660bf036a6d6fff5d541a9a8f3e80aedc2b9649e`.

### 앱 배포 도중 임시 출력 충돌과 복구

- 두 저장소 CodePush를 병렬 실행해 Revopush의 공용 `os.tmpdir()/CodePush`, `CodePushSourceMap`이 충돌했다. 별도 checkout만으로 빌드 출력은 격리되지 않았다.
- Office iOS는 업로드 전 Hermes Invalid UTF-8로 실패했고 기존 v142가 유지됐다. 별도 TMPDIR를 검증한 뒤 공식 dev all --mute를 순차 실행해 양OS v143 발행 완료.
- Lab 초기 iOS v41은 게시됐으며 정상 v42와 JS bundleHash는 같았지만 assetHash가 달랐다. 전용 TMPDIR에서 같은 소스를 다시 생성한 v42는 기존 Lab v40 assetHash와 일치했다. v41 게시 후 56초 안에 v42로 교체했고 Android는 처음부터 분리 경로로 발행했다.
- **Lab iOS v41을 롤백 대상으로 사용하지 않는다.** 그 짧은 기간의 기기 수신 여부는 미확인이다. '배포 중 문제가 전혀 없었다'고 보고하지 않는다.
- 공통 SESSION_WORKFLOW에 기본 순차 실행·병렬 시 제품/OS별 TMPDIR와 실제 출력 경로 확인·실패 시 패키지 무결성 확인을 추가했다.

### 웹 DEV

- DEV 전용 [PR4884](https://github.com/Innvoaid/dentlink-client/pull/4884)를 develop에 병합했다. 최종 develop SHA는 `e72bbafbee803bac973ea8e5015731c7407b2df8`.
- [Clinic workflow43211888815](https://github.com/Innvoaid/dentlink-client/actions/runs/43211888815), [Lab workflow43211888799](https://github.com/Innvoaid/dentlink-client/actions/runs/43211888799)가 위 SHA로 in_progress 시작했음을 각1회 확인 후 추적 종료. 배포 완료/운영 화면 성공까지 확인한 것은 아니다.
- 기존 feature `7e23e709b`와 release PR4862→release/v1.94.0는 OPEN/Draft 상태로 유지했다. 사용자의 'PR 유지'는 검토 중인 원 PR을 뜻하며 DEV 전달용 PR만 병합했다.
- latest develop `a9c0a5224`에 기존 FILE PR4866·최근 밀링 QA가 있어 전체 덮어쓰지 않았다. 전달 브랜치 `feat/DL-17058-develop@b248516dc11058532e0366b83edf78418baf2b48`에서 이전 DEV 반영 이후 알림 변경을 통합하고, 밀링 상세의 기존 뒤로가기 제거는 유지한 채 알림 진입만 보완했다. develop을 또 삭제/재생성하지 않았다.
- 전달 worktree: `/Users/parkjongsun/.codex/worktrees/dentlink-notification-dev/dentlink-client-notification-center`. 원격0/0·clean이며 원 알림 worktree도 clean. 자동 삭제하지 않았다.
- 공식 Swagger 재생성 시 빠지는 기존 FILE 입력/조회 계약은 생성 파일을 손으로 고치지 않고 기존 소비 타입으로 옮겼다. FILE UI/동작은 보존. 이 통합 보정은 이후1.94릴리즈 통합 때도 대조한다.
- 통합 후 Clinic/Lab/Admin 타입 검사, 관련73tests, 실제 로그인 대표5화면(pageerror0·알림host1개), 일반 commit/push훅 통과. 새 worktree의 Git 제외 coverage-baseline 누락은 검증된 기존 baseline을 상속해 해결했으며 가드를 우회하거나 새 기준을 임의 생성하지 않았다.
- 사용자 지시에 따라 직접 E2E는 실행하지 않고 SKIPPED. 저장소의 기존 Clinic 배포 뒤 workflow_run E2E 자동 연결은 변경하지 않았다. 그 실행 여부/결과도 추적하지 않았다.
- 본인 검증 서버는 종료했다. 증거 `/tmp/dentlink-notification-dev-1112/results.json`.

## Jira 정리

- 기존 설정 카드 DL-17061/17063/17066 설명을 최신 user/employee 구조·전체 저장·OS 정책으로 바로잡았다. 기존 제품 개발 완료 카드는 Ready for Deploy를 유지한다. DEV 배포를 Staging 배포/QA 완료로 바꾸지 않는다. 현재 Ready 상태의 다음 전이는 'Staging 배포'→READY FOR QA여서 이번 DEV 전달에 사용하지 않았다.
- 본인 제품/설정/계약 하위 카드에 이번 검증·전달 결과를 기록했다. 상위 카드·다른 사람 카드·스토리포인트는 변경하지 않는다.
- 새로 만든 실제 후속 구현 카드(모두 본인 담당·DL-16140 하위·**해야 할 일**):

| 카드 | 범위 | 시작 조건 |
| --- | --- | --- |
| DL-17415 | 웹 설정 노출 플랫폼·개인 설정 정책 반영 | BE 노출 키/개인 알림 정책 확정 |
| DL-17416 | Office 설정의 같은 확정 계약 반영 | 위와 동일 |
| DL-17417 | Lab 설정의 같은 확정 계약 반영 | 위와 동일 |
| DL-17418 | 본체 외 Office OS 배지 집계 개선 | PM·BE가 개선 정책/계약 결정 |
| DL-17419 | 본체 외 Lab OS 배지 집계 개선 | 위와 동일 |
| DL-17420 | 웹1.94 릴리즈의 기존 밀링 FILE 변경 통합 | 완료 PR4866의 릴리즈 통합 순서 결정 |

- 'API 확인해주세요' 같은 단순 질문 카드는 만들지 않았다. 현재 API 연결의 개발 완료를 위 미래 정책 카드 때문에 미완료로 돌리지 않는다.
- 기존 본체 외 Home3 DL-17062/17065/17068와 이메일 DL-17187은 To Do 그대로. 앱 추가 목록 DL-17202는 기존 개발 완료, 후보 조사 DL-17179는 완료 그대로. 선택적 CodeRabbit 주석 커버리지 경고는 사용자 보류 기록으로 유지하며 필수 작업으로 승격하지 않는다.

## 사용자에게 전달할 BE 확인/주의점

1. DL-17114 댓글44994에서 요청한 설정의 웹/앱 노출 기준이 아직 확정되지 않았다. toggleChannel 자체로 플랫폼을 판단하지 않는 계약이 나오면 후속 FE를 진행한다. 이미 질문을 보냈으므로 같은 요청을 중복할 필요는 없다.
2. 구 API 중 Office에서 아래 두 경로는 Home/주문/채팅 담당 필터가 사용한다. 삭제하지 말아야 하며 변경 계획이 있으면 대체 계약/일정을 함께 정해야 한다.
   - GET `/app/users/own/push-preferences`
   - PATCH `/app/users/own/push-preferences/{preferenceId}`
3. 나머지 구 API의 현재 FE 호출이 없다는 조사 결과만으로 이전 배포 클라이언트의 사용 종료를 보장하지 않는다. Admin 별도 경로·현재 badge-count PATCH도 삭제 대상으로 합치지 않는다.

## 남은 검증 / 다음 시작점

- 사용자 개발서버·실기기: 설정 변경 후 재진입/유지, 병원 선택과 인박스 랜딩·Back, 실제 푸시 클릭의 단일 이동과 읽음. Office shipping 포함 실제 발송 확인은 로컬 URL 검사와 구분한다.
- 기존 Android 구 바이너리 푸시 클릭 문제는 별도 native 릴리즈에 있으며 이번 OTA가 해결했다고 보고하지 않는다. 테스트할 앱 버전과 배포 타깃을 맞춘다.
- 웹의 FILE 리뷰1건은 개발서버에 기존 구현이 있어도 release PR에는 아직 없으므로 DL-17420에서 추적한다. 원래 PR의 리뷰를 거짓으로 resolve하지 않는다.
- 앱 tsc 기존 Office6/Lab5진단, Office XCTest 종료 자동화 crash와 재실행 후 정상 결과, 실제 서버 쓰기/FCM/전체 권한 QA 한계는 같은 날 review 문서의 증거를 유지한다.
- 배포 후 자동 모니터링·재개 예약을 만들지 않고, 사용자가 개발서버·실기기를 본 뒤 요청하면 재개한다. 확인된 계약 밖의 개인 설정/배지/Home/이메일/네이티브 작업을 자동 시작하지 않는다.

임시 증거: `/tmp/office-development-codepush-1112/summary.json`, `/tmp/lab-1112-codepush-summary.md`. 핵심 SHA·라벨·검증 한계는 이 정본에 보존했다.

## 로컬 작업 환경 재확인 답변

사용자는 마감 중 '로컬 PC 시뮬/에뮬 포함 세팅도 됐고 앞으로 알림 작업만 보면 되는지'를 질문했다. 기존 실행 환경·외부 프로세스·양OS/Reactotron 연결 확인 방식·작업 지침은 정리돼 있어 새로 세팅을 시작할 필요는 없다. 현재는 본인 검증 서버·기기를 종료한 상태이며, 다음 실행 때 정확한 branch/source/환경과 양OS 디버거 연결을 확인한다. 환경 정리 완료를 지금 모든 프로그램이 켜져 있거나 앞으로 점검이 전혀 불필요하다는 뜻으로 확대하지 않는다.
