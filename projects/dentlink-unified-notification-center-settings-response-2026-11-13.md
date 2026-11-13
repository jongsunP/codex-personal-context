# 알림 설정 즉시 표시 보완 · 2026-11-13

## 요청과 결정

- 사용자 QA: 전체 깜박임은 없어졌지만 웹·치과앱·기공소앱의 토글/채널이 서버 저장 뒤에만 바뀌어 답답하다. live 코드에서도 `최신 GET → 전체 PUT → 확인 GET → 화면 변경` 순서를 확인했다. 이 대기를 깜박임 수정이 새로 추가한 것은 아니며, 기존 저장 확인 방식이 남아 있었다.
- 승인 범위: 세 제품 수정·검증·커밋·푸시. **배포 금지. 사용자가 로컬에서 확인한 뒤 별도로 배포를 승인한다.** 기존 PR/대상/현재 개발 배포는 유지한다.
- 선택: 클릭한 값은 즉시 표시하고, 성공하면 유지하며 실패하면 서버 상태를 확인해 복구한다. 실패를 다음 방문까지 방치하거나 입력을 계속 막아두지 않는다.
- 일반적인 낙관적 UI 중 서버 캐시를 직접 바꾸지 않는 표시 방식이다. [TanStack Query 공식 설명](https://tanstack.com/query/latest/docs/framework/react/guides/optimistic-updates)의 pending mutation variables 기반 흐름을 따른다.
- 이 제품의 이유 있는 제약: 현재 PUT은 화면 전체를 교체하므로 기존 저장 전 최신값 조회·저장 후 제한된 확인·저장 중 입력 차단을 유지한다. 빠른 순차 클릭도 요청이 겹칠 수 있기 때문이다. 별도 요청 큐·debounce·새 API·실시간 동기화를 추가하지 않는다.

## 구현 기준

- 현재 저장 요청의 선택값만 같은 계정·소속에서 화면에 합성한다. 서버 query cache에는 확인된 응답만 보관한다.
- 기존 전체 PUT 생성 함수를 재사용하되, 화면용 `domain`, `toggleChannel`, `orderScopeOptions` 등 메타를 제거하지 않는다. 다른 범위·카테고리의 값은 보존한다.
- 상위 토글은 해당 하위 채널을 함께 변경하고, 채널 단독 변경은 해당 값만 바꾼다. Office 주문 알림 범위 선택도 즉시 표시한다.
- OS 권한 안내·차단과 서버 권한/노출 규칙을 유지한다. 분석 이벤트는 서버 저장이 확인된 성공에만 기록한다.
- 계정·소속 변경 시 이전 요청의 표시값을 버린다. Lab은 늦은 성공/실패 콜백에도 요청 당시 문맥을 검사한다.
- 기존 깜박임 방지와 입력 차단을 유지한다. 새 사용자 문구, Storybook, 네이티브, 푸시/배지, 이메일 범위 변경은 없다.

## 검증과 전달

최종 구현·별도 코드 리뷰·로컬 런타임 검증 후 세 제품을 커밋·푸시했다. root가 HEAD/upstream 일치·ahead/behind 0/0·clean을 재확인했다. 기존 PR head만 갱신되며 PR 대상·본문·Draft 및 배포는 변경하지 않았다.

| 제품 | 작업 위치 / 브랜치 | 최종 커밋 | 검증 |
| --- | --- | --- | --- |
| Clinic/Lab 웹 | `/Users/parkjongsun/Repository/dentlink-client-notification-center` · `feature/DL-17058` | `542b0c4e8969ac6a3443631fd3a15811fdc1cf71` | 관련 테스트24개, Clinic/Lab 실제 로컬 렌더15조건, 웹3서비스 type·정상 Git 훅 통과 |
| Office 앱 | `/Users/parkjongsun/Repository/dentlink-app` · `feature/DL-17059` | `a6ee48c7f51555bbfb5dfcebae91b6342184d7da` | 관련 테스트65개, 최종 같은 소스 iOS·Android 저장/실패 복구 |
| Lab 앱 | `/Users/parkjongsun/Repository/dentlink-lab-app` · `feature/DL-17060` | `2c638fa0d7424aac44f4578e636be70e7dd35cde` | 관련 테스트16개, 최종 같은 소스 iOS·Android 저장/실패 복구 |

- 첫 저장 전 GET 지연부터 선택이 즉시 표시된다. PUT·이전 값 확인 응답 중에도 유지하며 성공 뒤 반전/전체 깜박임이 없다. 실패 시 확인값 복구·잠금 해제·재시도가 가능하다.
- 중복 입력에도 PUT1회, 상하위 연동과 화면 메타 유지, 저장 성공 이벤트1회/실패0 확인. 소속·계정 변경/늦은 응답은 query observer 테스트로 분리 검증했다.
- 웹 정상 저장은 기존 GET→PUT→GET3회, 확인 불일치만 기존 상한 GET5회+PUT1회다. 즉시 표시를 위한 추가 요청은 없다. 정식 E2E suite는 사용자 제외 지시를 유지했다.
- 앱 실제 설정 화면 callback·네이티브 캡처/좌표/스타일 대조, Office Android 범위 선택 재시도는 실제 adb 터치도 확인했다. 기존 OS guard는 관련 테스트와 Lab iOS OFF 안내/save0로 확인했다. 이번에 실제 OS 권한 왕복·실푸시·실기기 OTA QA를 재실행한 것은 아니다.
- 최종 양앱 양OS LogBox0, Android 앱 crash buffer 새 오류0. 통제된 지연/실패는 fixture로 재현했고 실제 설정 쓰기·분석 송신0, 원복 후 실제 GET 정상 확인했다. root가 제품 diff/관련 테스트와 대표 캡처를 별도로 확인했다.
- 전체 앱 tsc는 기존 Office6건/Lab5건이 남으며 변경 파일의 신규 오류는 없다. 웹 ESLint 기존 effect dependency 경고1개는 유지한다. 전체 앱 typecheck 성공으로 보고하지 않는다.
- 임시 세부 근거: `/tmp/notification-web-immediate-1113.md`, `/tmp/notification-office-immediate-1113.md`, `/tmp/notification-lab-immediate-1113.md`. 최종 기능/검증 요약은 임시파일 소실에 대비해 이 Git 문서에 보존한다.

배포 기준은 변경하지 않았다: Web DEV `b8ce6c6ae`(feature `b6cffe2f8`), Office Development iOS/Android `v146`(2.2.4, `1eaa023`), Lab iOS `v45`/Android `v44`(1.0.5, `3a6624e`). 이 요청의 새 코드는 아직 해당 배포에 포함되지 않는다.

## 다음 시작점과 사용자 확인

- 이번 범위의 알려진 FE 수정은 완료했다. 사용자의 로컬 확인 후 별도 배포 승인 전까지 배포하지 않는다. 실기기 확인/기존 BE 후속은 기존 기록과 구분한다.
- 사용자가 마감 중 직접 로컬 확인 환경을 요청했다. 웹은 실행하지 않고 위 worktree/branch와 Clinic/Lab 실행 디렉터리를 안내한다. 앱은 Office 최종 코드로 양OS·외부 실행 터미널·Reactotron 양기기 연결을 확인해 켜두었다. 아래 실행 상태를 확인했다.
- 공통 지침에는 깜박임 제거만으로 완료하지 않고 반응 속도·성공/실패 복구·계정/소속 경계·동등 제품까지 함께 보도록 보완했다. 별도 복잡한 저장 시스템이나 정책을 만들라는 지시가 아니다.

### 사용자 로컬 미리보기 준비 완료

- Office `feature/DL-17059@a6ee48c7`, `/Users/parkjongsun/Repository/dentlink-app`. iOS iPhone17Pro/26.5와 Android Dentlink_API_36 모두 같은 DEV Metro8081에 연결, 최신 즉시 표시 helper 로드·fixture 없음 확인. iOS 알림설정/Android 홈 상태이며 사용자 조작·창배치를 유지했다.
- 외부 Terminal PID72827의 login/zsh 아래 Metro72866(`ttys001`, cwd 위 Office 경로) 실행, Android emulator72936(`ttys000`)도 외부 터미널 소유. 지속 실행용 터미널2개만 유지한다. Codex 종료 생존 시험을 한 것은 아니며 프로세스 ancestry로 실행 분리를 확인했다.
- Reactotron 두 기기 connected=true/socket readyState1, 하단 기기선택기 펼침. 양OS LogBox0·Android crash buffer0. 사용자 직접 확인을 위해 앱·기기·터미널·Reactotron을 켜둔다.
- 웹은 사용자가 직접 실행한다. worktree `/Users/parkjongsun/Repository/dentlink-client-notification-center`, branch `feature/DL-17058`, Clinic은 `clinic`에서 `yarn dev`(3000), Lab은 `lab`에서 `yarn dev`(3005). 웹을 추가 실행하거나 사용자 브라우저를 조작하지 않았다.
- 로컬 근거: `/tmp/office-preview-{ios,android}-final-1113.png`, `/tmp/office-preview-desktop-1113.png`.
