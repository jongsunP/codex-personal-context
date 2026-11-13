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

## 로컬 확인 후 개발 배포 승인 · 같은 날 후속

- 사용자: “지금 로컬에서 본것들 다 괜찮아”로 본인이 본 로컬 동작을 확인하고 웹·양앱 개발 배포를 명시 승인했다. 이를 모든 실기기/전체 역할 QA 완료로 확대하지 않는다.
- 기존 검토 PR은 유지하고 웹은 기존 원격 develop 재생성/DEV PR 병합 경로, 앱은 작업브랜치로 Development에만 CodePush한다. 사용자 요청대로 이후 실기기 테스트 결과를 기다리며 자동 결과 감시/추가 작업을 하지 않는다.
- 추가 질문 답변: 웹·앱 모두 PUT 뒤 GET은 실제 저장값 확인을 위해 저장 로직이 명시적으로 수행한다. React Query가 모든 PUT 뒤 자동으로 붙이는 동작이 아니다. 정상은 확인 GET1회, 이전값 반환 때만 기존 제한 내 재확인으로 불필요한 반복 조회와 구분한다.
- 배포 결과와 Jira/문서 마감을 실제 확인된 결과로 아래에 기록했다.

### PUT 뒤 GET이 두 번 보인다는 추가 질문

- 사용자 관찰은 PUT 후 GET이 약2회이며 하나가 명시적조회, 하나가 React Query/포커스 자동조회인지 우려한 것이다. “저장 확인GET은 필요”를 모든 추가GET도 필요하다는 뜻으로 확대하지 않는다.
- 해당 경로만 live코드 재대조: 웹 설정query는 `refetchOnWindowFocus:false`/`refetchOnReconnect:false`, 저장성공은 확인응답 `setQueryData` 후 다른 소속 설정만 invalidate한다. Office/Lab도 성공 후 현재소속 설정은 제외하고 다른소속만 invalidate하며, navigation focus effect는 저장상태 변화에 재실행되는 의존성이 아니다.
- 정상 저장은 저장전GET1+PUT1+확인GET1. PUT뒤 첫GET이 이전값이면 `[0,200,500,1000]`의 제한된 readback으로 GET2회 이상이 될 수 있다. 이 제한은 기존 DEV의 저장 직후 구값 응답에 대응한 것이며 이번 즉시표시 변경이 추가한 조회가 아니다. 실패복구GET/실제화면 재진입조회는 별도이다.
- 일반 저장에서 React Query가 현재 설정GET을 무조건 한 번 더 붙이는 코드 경로는 확인되지 않았다. 직전 최종 웹 fixture 정상저장도 총3요청으로 확인됐다. 사용자가 본 바로 그 두요청의 응답/initiator 캡처는 없어 발생원인을 단정하지 않는다. 해당관찰을 확인된 중복결함으로 만들거나 추가개발/재배포할근거는 현재없다. 이후 정상값 응답인데도 같은설정GET이 반복되는 실제근거가 나오면 그때 재검토한다.

## 최종 개발 전달·마감

| 대상 | 전달 결과 | source |
| --- | --- | --- |
| Clinic/Lab 웹 | DEV PR [4891](https://github.com/Innvoaid/dentlink-client/pull/4891) 병합 → develop `7c8eef28c0d788972b59cbdaf567b16d904e8b7a`; 16:59:23 KST 양 workflow 배포 시작 확인 | `542b0c4e8969ac6a3443631fd3a15811fdc1cf71` |
| Office iOS/Android | Development **v147 / v147**, target2.2.4, 게시·활성 | `a6ee48c7f51555bbfb5dfcebae91b6342184d7da` |
| Lab iOS/Android | Development **v46 / v45**, target1.0.5, 게시·활성 | `2c638fa0d7424aac44f4578e636be70e7dd35cde` |

- 웹은 기존 develop `b8ce6c6ae`를 복구 bundle에 보관·verify 후 expected-SHA lease로 삭제, 최신 master `9c4418a8fb4b18cbadb5afb25fa32503b59febae`에서 nonexistence lease로 재생성했다. master→feature 경로 Clinic7/Lab31이 실제 workflow trigger를 충족함을 확인하고 DEV PR만 병합했다. 최종 develop tree=검증 source tree이며 새 제품 코드/빈커밋/manual dispatch 없음.
- 웹 [Clinic run43389706697](https://github.com/Innvoaid/dentlink-client/actions/runs/43389706697)·[Lab run43389706714](https://github.com/Innvoaid/dentlink-client/actions/runs/43389706714)에서 위 exact SHA의 in_progress를1회 확인하고 종료했다. 최종 배포 성공·실서버 반영을 재조회하지 않았다.
- 앱4건은 직전배포→이번source 전체diff가 각 TS/TSX5파일이며 native/package/lock/assets/config 무변경, Office2.2.4/Lab1.0.5 version validation 통과. 제품/OS별 TMPDIR를 격리하고 네번 직렬로 직접 Revopush 게시(Slack 쓰기없음), 각 history1회로 enabled/mandatory/100%·source·target을 확인했다. 네 assetHash는 모두 직전과 동일하다.
- packageHash: OfficeiOS `04675a8e1b2ebdc70e4b6249d17a7ff38c14ae8e7062afb6c4dc73ce6ffa686a`, OfficeAndroid `9e4d4b479da4ff46ea60168beeb95fcae4492274e745a8edd0dc6c4ef799eb36`, LabiOS `7dda10f90571f371ce2d52598bf185c38e116a54aec033ad3e33945b28dc7e16`, LabAndroid `db3e7f20a1bf214ce5db4eab4c233d4f09e8d28c06ca5b1b1e6f0908ad382b4e`.
- 기존 검토 PR4862→release/v1.94.0, PR346/42→main 유지. 원PR merge/운영·스테이징·스토어 전달 없음. 모든 feature source는 변동없이 clean이며 최종코드 검증·사용자 로컬 확인 근거를 재사용했다.
- Jira 본인 카드에 이번 기대 동작과 실제 전달 단계만 기록: [DL-17058#45032](https://innovaid.atlassian.net/browse/DL-17058?focusedCommentId=45032), [DL-17059#45033](https://innovaid.atlassian.net/browse/DL-17059?focusedCommentId=45033), [DL-17060#45034](https://innovaid.atlassian.net/browse/DL-17060?focusedCommentId=45034). 모두 **Ready for Deploy** 유지, QA/운영완료로 바꾸지 않았다. 작업정의·스토리포인트·부모·타인카드 불변.
- 공유 Notion의 배지정책/개발참고 문서는 이번 저장UX/개발배포로 정책이 달라진 것이 없어 무수정이 적절함을 확인했다. 불필요한 배포 이력을 정책문서에 중복하지 않는다. 개인/Claude/Codex 기록은 최신 전달상태로 보완한다.
- 배포 전 최종 양OS 확인범위에서 새 crash/회귀는 없었고 사용자는 본인이 본 로컬이 괜찮다고 확인했다. 실제 OTA 수신·실기기 테스트는 사용자가 이후 진행하고 이상시 알려주기로 했다. 별도 추가 체크리스트나 자동 모니터링을 만들지 않는다. 사용자 로컬 앱/외부 터미널/Reactotron/창은 그대로 유지했다.
- 임시 배포근거 `/tmp/notification-web-immediate-delivery-1113.md`, `/tmp/notification-apps-immediate-delivery-1113.md`, `/tmp/notification-apps-immediate-delivery-1113/publication-summary.json`, `/tmp/notification-closeout-records-1113.md`.

오늘 마지막 결론: 이번 승인된 수정의 코드 전달·기록 마감 완료. PUT뒤GET 경로는 추가수정 필요를 발견하지 못해 현행유지. 웹 최종배포결과/실기기QA는 사용자확인이며 자동 재조회/추가개발 없이 대기한다.

## 오늘 요청 대비 마감 요약

오늘(2026-11-13)의 프롬프트/당일 기록에 한정한다. 이전에 끝낸 크레딧·청구서 보완이나 구필터 API 제거를 오늘 신규개발로 다시 세지 않는다.

| 오늘 요청 | 결과 |
| --- | --- |
| 최신 Figma·Jira/소속선택 디자인·문구 확인 | 확정 변경 반영: 일반 선택 문구, 앱 범위 선택 중복 제목 제거, 알림 배지 최대999, Lab 선택창 구성·확정 문구/OS 배너. 기존 기능/권한 유지 |
| 구API 제거·설정 정책 재확인 | 이미 구현된 로컬 조회필터/새 수신설정 분리를 확인. 일반 소속과 알림 소속 조회 API 차이 설명. 기존 미정 노출계약을 임의 확정하지 않음 |
| 알림센터 외 범위 정리 | 밀링 FILE/1.93 담당 작업을 본체 필수잔여에서 제외, 원본주체 유지. 1.94 작업은 추후 master 통합으로 수용 |
| 개발환경 배포·가능 테스트 | 당일 앞선 DEV 실제 화면/API와 앱 양OS 확인, 이후 각 수정은 최종 관련 화면/지연·실패 fixture로 검증. 실제 푸시·실기기 OTA QA는 별도 |
| 저장 시 깜박임·기공소앱 누락 | 웹·양앱 저장 중 외형/위치 유지와 입력 차단, 실패 복구 보완. 같은 동작의 제품별 누락을 추가 대조 |
| 설정 조작 반응 지연 | 웹·양앱 클릭 즉시 표시/성공 유지/실패 복구 완료. 기존 전체 PUT·권한·상하위 변경 유지 |
| Amplitude 요청·추가 이벤트 확인 | DL-17425 명세상 클릭/조회/설정 이벤트 구현·SDK 경계 검증. 후속 재확인에서 새 이벤트 추가 없음 |
| 알림센터 API 중복 및 PUT→GET | 실제 진입 조회 취소/재요청 중복 감소. 저장 확인 GET은 필요하며 현재 코드의 추가 수정사항 없음 |
| iOS 아이콘 실행 시 OS 배너 제보 | 이번 변경의 회귀 근거 미확정, 기존 수신 경로와 구분하여 기록만. 해결한 것으로 보고하지 않음 |
| 개인 알림/다른 소속 카운트 정책 | 개인 알림은 다른소속 목록/count에서 제외, 인박스에서는 포함하는 확정 정책과 기존 API 연결이 일치. 이 정책질문만 해결, 다른 설정계약 대기는 별도 |
| 로컬 환경·공통 지침·최종 전달/기록 | Office 양OS/외부실행터미널/Reactotron 준비, 웹 위치 안내. 반응성·실패복구·동등 제품 점검 지침 보완. 사용자 로컬 확인 후 웹 양서비스 배포 시작·양앱 DEV 게시/활성, Jira/메모리 마감 |

상세 당일 근거: [기본 체크포인트](dentlink-unified-notification-center.md), [DEV 검증/디자인·깜박임](dentlink-unified-notification-center-dev-test-2026-11-13.md), [DL-17425](dentlink-unified-notification-center-analytics-2026-11-13.md), [제품 간 누락·API·정책](dentlink-unified-notification-center-parity-2026-11-13.md). 로컬 Codex 지침 복사본도 변경된 DEVELOPMENT_STYLE/PROJECTS에 맞춰 보존 백업 후 동기화 완료했다.

## 마감 후 요청 · 실제 DEV API의 PUT→GET 직접 확인

사용자가 코드/fixture 검증과 별개로 지금 로컬에서 실제 API까지 확인해 달라고 요청했다. 웹과 앱 설정 쓰기를 직렬로 진행하고, 각 제품의 한 항목을 한 번 변경한 뒤 원복했다. 서버 응답/지연/payload를 대체하지 않았다. 웹은 실제 UI 클릭과 CDP network initiator, 앱은 기존 화면의 handler/실제 touch 및 Axios pass-through 관찰을 사용했다. 분석 송신만 테스트용 capture로 차단했고 종료 때 원복했다.

| 최종 코드·검증 환경 | PUT 뒤 확인 GET: 변경 / 원복 | 관측 |
| --- | --- | --- |
| Clinic 웹542b0c4e8 / localhost3030 + DEV | **2회 / 1회** | 변경: 첫GET MAIL=ON(구값), 약202ms 후 OFF. 원복: 첫GET ON으로 완료 |
| Lab 웹542b0c4e8 / localhost3035 + DEV | **1회 / 2회** | 원복: 첫GET 상위=OFF(구값), 약204ms 후 ON |
| Office 앱a6ee48c7 / 대표iOS + DEV | **2회 / 1회** | 변경: 첫GET MAIL=ON(구값), 약204ms 후 OFF. 원복: 첫GET ON |
| Lab 앱2c638fa / 대표Android + DEV | **1회 / 2회** | 원복: 첫GET 채널=OFF(구값), 약210ms 후 ON |

- 네 경우 모두 PUT은 **HTTP200, code0001, data:null**로 최종 설정 객체를 반환하지 않았다. GET은 code0000과 설정값을 반환했다. 모든 성공 저장에는 PUT 전 최신값GET1회가 별도로 있고, 최초화면조회·최종원복확인GET은 표의 저장후GET 집계에서 제외했다.
- 이번에 GET2회인 사례는 첫 응답이 구값이어서 기존 `[0,200,500,1000]` 확인루프가 재시도한 것이다. 최초 GET이 변경값을 주면 추가GET은 없었다. 웹은 두 GET의 CDP initiator가 동일 saveMutation 저장확인 지점임을 확인, 앱은 화면focus변경 없이 mutation경로의 query signal 없는 요청과 200ms 재시도·값 변화를 확인했다.
- 결론: 현재 실응답에 맞는 제한된 확인이므로 **추가 수정 없이 유지**한다. 서버 내부 replica/cache 등 구값이 반환된 구체 원인은 이번 범위에서 조사하지 않았다. 사용자가 처음 본 네트워크 요청 자체를 소급 식별한 것은 아니지만 동일한 두 번의 GET 현상을 실제 응답으로 재현했다.
- 정상 검사의 실제 PUT은 제품별 변경1+원복1이다. 웹은 최종 새로고침GET으로 전체 employee/user 값의 원본 hash일치를 확인했고, Office/Lab 앱도 사전GET과 최종별도GET의 전체 정규화 JSON exact equality=true를 확인했다. 의도한 항목/종속채널 외 값 보존, 최종 idle·입력복구·앱LogBox0 확인.
- 검사 범위는 네 구현의 대표 실제 요청이다. 앱의 모든OS에서 실API쓰기를 반복한 전수검사로 확대하지 않는다. 기존 최종양OS UI/fixture 검증과 구분한다.
- 계측 도구 오류 구분: Office 첫 임시 service wrapper가 get/save를 잘못 묶어 HTTP400 요청이 나갔다. 즉시 원서비스를 복원했고 해당 실행은 정상제품/API 근거에서 제외했다. 당시 대상값 유지/400거절은 확인했으나 초기 전체hash가 없어 그 실패실행 전후 전체동일을 소급 증명하지 않는다. 이후 service를 건드리지 않는 Axios-only 관찰은 사전기준부터 확보해 정상변경·전체원복을 확인했다. 제품코드 결함이나 서버 응답 fixture가 아니다.
- 원관측기/SDK capture 모두 제거. 자체 웹3030/3035/브라우저와 Lab8082만 종료, 사용자 Office 외부Metro8081·두기기DEV소스·Reactotron 두연결/선택기를 복원·유지했다. Reactotronconnected=true/socketState1, fixture없음/LogBox0.
- 세 제품 HEAD/clean은 root가 다시 확인했고 코드·커밋·PR·배포 변경 없음. 기존 웹DEV7c8eef28c, Officev147both/LabiOSv46·Androidv45 전달상태 유지. 관련 개인/Claude 기록만 보완하고 사용자 실기기 결과를 기다린다.
- 실제 근거: `/tmp/notification-web-live-put-get-1113.md`/동명json, `/tmp/notification-office-real-api-1113.md` 및 `/tmp/office-real-settings-api-1113.json`, `/tmp/notification-lab-live-put-get-1113.md`. 인증정보·전체서버응답·개인정보는 Git에 기록하지 않았다.
