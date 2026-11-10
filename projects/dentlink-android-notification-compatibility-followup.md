# Android 알림 라이브러리 호환 오류 — 별도 후속

> **후속 준비 — 2026-11-10:** 사용자의 별도 승인으로 최신 main을 통합하고 Office Draft PR[#346](https://github.com/Innvoaid/dentlink-app/pull/346)·Lab Draft PR[#42](https://github.com/Innvoaid/dentlink-lab-app/pull/42)를 main 대상으로 만들었다. 현재 HEAD는 Office `5ad23a1`, Lab `3632931`이며 Android 호환 패치는 계속 제외한다. 양OS JS bundle 생성과 기본 화면 확인은 실제 대상 바이너리의 OS 푸시 클릭 성공 증거와 구분한다. CodePush/merge는 미실행. [배포 준비와 남은 확인](dentlink-unified-notification-center-delivery-2026-11-10.md).

## 범위 결정 — 2026-11-10

- 사용자는 이번 통합알림센터의 푸시 변경을 **기존 클릭 흐름에 deliveryId를 보존하고 읽음 REST를 호출하는 JS 작업**으로 구분했다. 검증 중 발견한 기존 Android 네이티브 호환 문제는 이번 요구사항과 분리해 기록하고 코드에서 제외할 수 있는지 **조사**를 요청했다.
- **권한 해석 오류:** Codex가 제외 가능성 질문을 실행 승인으로 잘못 해석해 양 앱에서 파일 삭제·검증·Git 커밋/푸시까지 진행했다. 사용자가 “조사만이라고 말했는데”라고 정정했고, Codex는 잘못을 인정했다. 사용자는 이미 진행했다면 계속하라고 하여 남은 기록/환경 정리만 마무리했다. 실제 CodePush 배포·PR·병합은 하지 않았다. 가능성 검토 질문을 제품 변경 승인으로 확대하지 않는다.
- 따라서 이 패치만을 이유로 알림센터 본체를 개발 미완료 또는 새 스토어 심사가 필수인 작업으로 분류하지 않는다. 이번 JS가 기존 앱에서 새 회귀를 만드는지와 기존부터 있던 네이티브 문제는 따로 판정한다.
- 다음 이메일 작업 등이 실제로 네이티브 배포를 필요로 할 때 이 수정을 함께 검토할 수 있다. 이메일 작업 자체가 반드시 새 빌드/심사를 요구한다고 미리 확정하지 않는다.
- 별도 패치 보류는 오류 해결을 뜻하지 않는다. 실제 운영 바이너리의 동일 현상은 아직 확인하지 않았으며, 개발 APK의 재현을 운영 장애 확정으로 확대하지 않는다.

## 발견한 문제와 기존 기능의 관계

- 2026-11-09 Office/Lab Android 개발 환경에서 OS 알림을 직접 누르면 JS 콜백 이전에 `UnsupportedOperationException: ReactInstanceManager.createReactContext is unsupported`가 발생해 랜딩·읽음이 실행되지 않았다.
- 확인한 feature/main/release 소스 모두 React Native 0.82.1, Notifee 7.8.2 및 New Architecture를 사용했다. 이번 알림센터에서 이 버전을 업그레이드한 것은 아니다. 원래 푸시 랜딩도 같은 Notifee PRESS 전달 경로를 사용한다.
- 임시로 포함했던 패치는 Notifee `NotifeeReactUtils.java`의 ReactHost 초기화·이벤트/HeadlessJS 전달을 보완하는 Android 전용 변경이다. 기존 iOS delegate 패치와 별개이며 새 deliveryId 읽음 API만을 위한 수정이 아니다.
- 패치 후 개발 빌드에서 background/cold-start 클릭을 확인한 과거 증거는 **패치 없는 빌드의 성공 증거로 재사용하지 않는다**.

## 복원 근거

| 제품 | 원본 저장소 / 패치 보존 커밋 |
| --- | --- |
| Office | `/Users/parkjongsun/Repository/dentlink-app`, `676e7fc6e87783dd6c8dbcef0fbe56600084c0b9` |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app`, `f9ca872b147a1c1ec1faf6320d40d2c9c39588fc` |

- 원본 경로: `patches/native/@notifee+react-native+7.8.2.patch`. 두 원본 커밋의 이력은 보존한다.
- 후속 승인을 받은 경우에만 당시 RN/Notifee 및 설치 바이너리와 다시 대조하고 필요한 수정만 복원한다. 이전 커밋을 무조건 전체 cherry-pick하거나 패치를 자동 적용하지 않는다.
- `patches/@notifee+react-native+7.8.2.patch`의 기존 iOS 패치, 라이브러리 버전, deliveryId 읽음·랜딩·OS 배지 정책은 이번 분리에서 변경하지 않는다.
- 설치된 node_modules에도 적용된 Android 패치를 reverse-check 후 원복하고, Yarn의 pristine 7.8.2 Java와 byte 일치를 확인한다. 파일 삭제만으로 기존 로컬 APK까지 패치가 사라졌다고 판단하지 않는다.

## 후속 확인 기준

1. 실제 전달할 기존 Android 바이너리와 이번 JS의 호환성을 확인한다. Production CodePush 이력만으로 네이티브 바이너리 소스를 확정하지 않는다.
2. 기존 JS/이번 JS에서 같은 푸시 클릭 경로를 비교해 기존 결함과 신규 회귀를 구분한다. 이번 변경으로 발생한 회귀는 알림센터에서 수정한다.
3. 새 빌드가 필요하다면 해당 패치의 최종 코드로 foreground/background/cold-start, 클릭 전달·랜딩·읽음 및 앱 안정성을 검증한다.
4. 네이티브 수정을 실제 운영에 반영하는 시점에는 Android 바이너리 업데이트/스토어 배포 절차가 필요하다. JS CodePush에는 이 Java 수정이 실리지 않는다.

## 제외 후 검증 — 2026-11-10

- Office `feature/DL-17059@9e2a1fc15b2d8cbf8872b1b9c38cca8a74997f59`, Lab `feature/DL-17060@4756446a8ef296780a70295a79a336caf987d032`로 삭제 변경을 커밋·푸시했고 원격 SHA 일치·clean을 확인했다. PR·merge·배포는 없다.
- 두 앱에서 Android 패치98줄이 담긴 파일 각각1개만 삭제했다. 설치 의존성의 Java는 Yarn pristine 7.8.2와 byte 단위 동일함을 확인했다. 해당 파일 외 JS·기존 iOS 패치·package/lock·native 원본은 이번 수정에서 변경하지 않았다.
- Office/Lab `assembleDevelopmentDebug` 성공(각42초/33초). 해당 APK를 Android API36 에뮬레이터에 재설치해 실제 패치가 없는 최종 실행을 검증했다. 데이터 초기화 없이 기존 로그인을 유지했다.
- 양 앱 Home 및 알림함 진입·렌더를 확인했고 마지막 화면의 LogBox는 비어 있었다. 라이브러리 변경이 없는 iOS는 기존 실행 근거를 유지하고, 제품 전환 시 iOS/Android를 함께 전환했다.
- **별도 결함 재현:** `deliveryId`를 포함하지 않은 임시 로컬 알림을 표시하고 OS 알림창에서 직접 눌렀을 때 양 앱 모두 동일한 `ReactInstanceManager.createReactContext is unsupported`를 기록했고 Home에 머물렀다. 즉 패치 없는 해당 개발 APK에서 클릭→랜딩 성공으로 보고하지 않는다. 이 검사는 실제 BE FCM 발송이나 운영 설치 바이너리 비교가 아니다.
- 이 오류는 JS 읽음 요청 이전의 기존 네이티브 경로 문제라는 근거를 남긴다. 신규 JS를 제외한 기존 운영 설치본 A/B 테스트까지 완료한 것은 아니므로 운영 장애 여부·모든 회귀 부재를 확정하지 않는다. 사용자 결정대로 이번 본체 요구에 패치를 다시 끼워 넣지 않았다.
- **추가 관찰:** Lab 개발앱에서 Metro 재연결/수동 reload·디버거 조회가 겹친 재확인 구간에 `SIGSEGV / MountingCoordinator::pullTransaction` 네이티브 종료1건을 확인했다. 과거 Office에서도 같은 함수의 종료 기록은 있으나 같은 원인이라고 확정하지 않는다. 패치 제외·이번 JS와의 인과관계는 미확정이며, 이 증거를 일반적인 운영 크래시나 ‘기존 문제라 무시 가능’으로 단정하지 않는다. 이후 재실행에서는 Home 화면과 알림함 헤더·탭·미읽음 숫자 표시를 확인했다. 마지막 LogBox는 빈 상태지만 해당 종료 원인 해결/운영 전체 검증 완료는 아니다. 상세 crash buffer는 `/tmp/dentlink-native-exclusion-1110/android-crash-buffer.txt`에 보존한다.
- 테스트 알림을 제거했고 실제 서버에 가짜 deliveryId를 보내지 않았다. 검증용 Lab Metro8082와 Lab 앱은 종료하고, 기존 외부 Terminal의 Office Metro8081 및 사용자 시뮬레이터·에뮬레이터·Reactotron 미리보기 구성은 유지한다. 사용자 웹/IDE 배치는 변경하지 않는다.
- 독립 diff 검토에서도 삭제 각각1개와 기능 공통조상 대비 native/package/lock 순변경0을 확인했다. 최신 main 후속 변경이 기능 브랜치에 모두 통합됐다는 뜻은 아니다.
- 임시 근거: `/tmp/dentlink-native-exclusion-1110/*-after-click.json`, `*-native-errors.json`, `*-inbox.json`, `*-inbox.png`; 빌드 로그는 `/tmp/office-notifee-exclude-build-20261110.log`, `/tmp/dentlink-lab-unpatched-build-1110.log`. 임시 파일의 영구 보존은 보장하지 않는다.
