# 통합알림센터 기본 흐름 재검증 — 2026-11-05

현재 상태: **세 제품 수정·최종 영향 검증·commit/push 완료.** 이 기록은 전체 제품 QA나 새 BE 연결 완료를 뜻하지 않는다. 기기 사용 충돌을 조율한 뒤 Office→Lab 양OS 최종 검증을 마쳤고, 양 기기를 같은 Office8081/Home으로 복원했다. PR·merge·배포는 하지 않았다.

## 범위와 작업 위치

- 사용자가 웹·병원앱·기공소앱 이번 작업의 기본 흐름을 다시 점검하고 실제 재현된 문제를 수정·검증·commit/push·메모리 정리하도록 승인했다. PR·merge·배포는 제외한다.
- Web: `/Users/parkjongsun/Repository/dentlink-client-notification-center`, `feature/DL-17058`, 시작 `fe17a4074` → `dea89193f78e4004b8fb260ddd709b48ffd5b139` 원격 일치·clean·ahead/behind0/0.
- Office: `/Users/parkjongsun/Repository/dentlink-app`, `feature/DL-17059`, 시작 `52bbdfa179fdd1034653c12f968606b2bc8bfdb7`. 수정3파일+회귀1파일 `933d054b6744a619de3825716982aadf871461dd` 원격 일치·clean·ahead/behind0/0.
- Lab: `/Users/parkjongsun/Repository/dentlink-lab-app`, `feature/DL-17060`, 시작 `a5b4480bd8555405c57d523f459333e67a24bfc6`. 수정3파일+회귀1파일 `a6432e279c8eeb3d86821442f4e4149954f62213` 원격 일치·clean·ahead/behind0/0.
- 각 checkout 시작 시 clean과 upstream을 확인하고 ff-only pull했다. 기존 사용자 웹 IDE 서버3000/3005와 로그인·창 배치를 유지했다. 앱8081/8082의 소스 확인과 실제 전면 native bundle 확인은 별개다.

## 재현·수정 결과

| 제품 | 수정 전 확인 | 수정 내용 | 검증 / 한계 |
| --- | --- | --- | --- |
| Clinic/Lab 웹 | 실제 host에서도 데모용 다른 소속의 미읽음을 합산하여 Read All 후 빨간 점이 남음 | 독립 데모에만 가짜 소속을 생성하고 제품 host는 전달된 현재 preview 문맥만 사용 | 실제 컴포넌트 전/후 및 로그인 PC·모바일에서 Read All→숫자·점 제거 확인. 실서버 다른 소속 집계 계약으로 확대하지 않음 |
| Lab 웹 | 전환 가능한 소속이 없어져도 과거 캐시 행이 있으면 다른 소속 진입점이 남음 | 기존 canSwitch 기준으로 진입점 제한 | 실제 host·QueryClient 회귀 통과. 실제 로그인은 INTERNAL·단일소속이라 실서버 다중소속은 미검증 |
| Clinic/Lab 웹 | 첫 소속 GET 실패를 소속0개처럼 처리하여 재시도 진입점 없음 | 확인된 다른 소속/기존 전환 가능 상태에서 진입점 유지, 기존 loading/error/Retry/empty 연결 | Clinic 실제 로그인 조회503→재시도→복구, 활성화 실패 시 원소속 유지·지연 성공·원소속 복원 PC/모바일 통과. Lab은 실제 host 회귀와 실제 UI 상태로 검증 |
| Office | 소속 전환 응답 대기 중 현재 소속 Home 딥링크로 화면이 사라져도 늦은 응답이 소속을 바꿈 | 화면·요청 유효성을 기존 활성화 guard에 전달, blur/unmount 후 응답·피드백 무효화 | Office JS에서 서버쓰기 차단·지연 응답으로 전/후 경계 재현. 양OS 최종 실제 소속 행 터치·합성 지연응답에서 정상 성공/실패 복구·중복 방지·화면 이탈 후 원소속 유지 확인 |
| Office | 직원/권한 조회 중 설정 항목도 로딩도 없는 빈 영역 | 기존 조회의 isFetching/refetch 노출, 초기/재시도 로딩과 기존 Retry 연결 | 실제 JS의 빈 상태와 회귀 테스트, 양OS 최종 로딩→오류→Retry중 로더→정상 복구 확인 |
| Office/Lab | OS 권한 확인 전·오류를 정상처럼 취급하여 직접 Push 선택을 변경할 수 있음 | 미확인 중 직접 Push 항목/채널만 잠금, 기존 로딩·재시도 제공 | Office 실제 JS 및 테스트, Lab 실제 화면·그룹 격리 검증. 부모 토글/Email 정책은 유지. Office/Lab 각각 양OS에서 직접 Push 잠금·조회 재시도·정상 상태 복구 및 기존 설정 안내 왕복 확인. 실제 권한값 변경과 제어된 응답은 아래 구분 |
| Lab 앱 | 소속 재조회 실패 시 같은 사용자의 성공 캐시가 사라져 행·진입점이 없어짐 | 사용자별 캐시 행 유지, 선택 때 재조회 성공/소속 유효성 확인 유지, 최초 무데이터 실패 Retry 연결 | 최종 hook24개·화면 격리8개 및 양OS 오류/재시도/원소속 유지 확인. 실제 다중소속 계정 부재는 계속 한계 |
| Lab iOS | 실제 실패 Toast.show 호출 직후에도 FullWindowOverlay 선택 시트 뒤에 오류 안내가 가려짐 | 시트 dismiss 완료 후 기존 문구 1회 표시, 이탈·문맥 변경 때 폐기. 공용 Toast/시트 동작과 정상 성공 경로 유지 | `/tmp/lab-basic-toast-observed-ios-1105.png`와 실제 호출 계측으로 재현. 수정 후 `/tmp/lab-basic-toast-fixed-{ios,android}-1105.png`에서 양OS 오류 안내 노출 확인 |

## 웹 최종 코드 근거

- Clinic 회귀5/5, Lab 회귀4/4. 실제 host·Jotai·QueryClient를 실행하며 네트워크만 제어했다. 회귀 테스트에서 간소화한 UI는 실제 컴포넌트 Chromium 검증으로 보완했다.
- Clinic/Lab 각각 PC1280·모바일390에서 진입→필터→설정 토글·뒤로→Read All→점 제거→닫고 재진입을 확인했다. DEV mock 설정/읽음을 서버 영속화로 표현하지 않는다.
- Clinic 실제 소속 GET503·재시도 지연·닫기/재오픈·활성화503·성공·홈 알림함 복원·원소속 복원을 확인했다. Lab 실제 계정은 소속1개라 다중소속 실제 API 성공은 확인하지 못했다.
- Lab 모바일 하단 GNB를 가리는 개발용 Devtools/테스트 위젯은 임시 headless 페이지에서만 숨겨 제품 버튼을 검증했다. 사용자 브라우저/제품 코드/환경 설정은 바꾸지 않았다. Clinic 기존 홈 공지 팝업도 정상 닫고 재확인했다.
- 타입검사 Clinic/Lab 및 commit hook의 Admin 통과. push hook Clinic/Lab/Admin lint 오류0·기존 경고 유지, Admin guard9·configs21·hooks32·coverage baseline 통과. hook 우회 없음.
- i18n 새 키·문구 추가 없음. 기존 감사의 `account.auth.actions.logIn` 누락과 export preview missing1751/stale2/conflicts3은 기존 상태다. unrelated 번역시트/다른 작업을 덮지 않았다.
- 보고서 `/tmp/notification-web-final-review-1105.md`, push `/tmp/notification-basic-web-push-1105.log`, 기본흐름 `/tmp/notification-live-basic-final-1105.log`, Lab 모바일 `/tmp/notification-live-basic-lab-mobile-final-1105.log`. 임시 파일 보존은 장기 보장하지 않으므로 결과·한계는 본문을 정본으로 삼는다.

## 앱 검사와 기기 충돌

- 기기 충돌 해소 후 Office 양OS 정확 전면에서 홈 벨→All/Unread→개별읽음→Read All0→설정 부모/Email 변경·복귀, 직원조회 pending/실패/Retry중 로더/성공복원을 확인했다. OS unknown/error에서 Push만 비활성·Email 유지, 재시도·안내 취소·실제 OS 설정 진입/복귀도 확인했다. 소속 행 실제 터치→진행표시/중복차단→합성 실패·성공·화면 이탈 후 늦은 응답 무효화를 확인하고 원상복원했다. 일반 조회는 실API이며 활성화 PATCH/권한결과는 제어된 응답이라 실서버 다중소속 활성화·실제 OS권한변경 성공으로 확대하지 않는다. 이후 Lab에 기기 페어를 인계했다.
- Office 관련3suite29테스트 통과·scoped ESLint 오류0·전체 타입 기존6진단 동일. `/tmp/office-basic-review-1105.md` 및 `/tmp/office-basic-review-jest-1105.log`.
- Lab 최종 hook24테스트·실제 화면/그룹 격리8테스트 통과·scoped ESLint/diff 통과·전체 타입 기존5진단 동일. `/tmp/lab-notification-basic-review-runtime-1105.md`. Toast 추가 수정 후 독립 diff 리뷰와 양OS 가시성 검증도 통과했다.
- 별도 독립 diff 리뷰에서 추가 확정 결함은 찾지 못했다. 코드 리뷰는 최종 native 실행 확인을 대체하지 않는다.
- 19:43 Office native bundle을 양쪽에 명시 실행한 뒤에도19:46 다른 작업 Lab Home으로 바뀜을 확인했다. 별도 사용자 채팅 **치과앱 완료·취소 주문 지연 라벨**(`01a1aa21-103b-7e82-b530-9b203c18cfe9`)이 Lab `feat/DL-17262` worktree로 같은 기기에서 검증 중임을 읽기 확인했다. 서로 전면 앱을 덮지 않도록 이번 세션의 기기 조작을 중단했다.
- 다른 채팅 메시지 도구의 직접 승인 요건 때문에 사용자에게 기기 순서 조율 메시지 승인을 요청했다. 이후 해당 채팅의 turn completed·idle을 확인하여 메시지 없이 충돌이 해소됐고, 사용자에게 승인 답변이 불필요해졌음을 안내했다. Office→Lab 순서로 검증을 재개했다. 이후 사용자에게서 명시적 메시지 승인이 도착하여 상대 채팅에 Office8081→Lab8082 페어 사용 및 완료 인계 전 재조작 금지를 전달했다. 상대 코드/Metro는 변경하지 않았다. 검증 완료 후 같은 승인 범위로 기기 점유 종료·Office8081/Home 복원 상태를 전달했다. 상대 작업 재개/추가 QA/배포 지시로 확대하지 않았다.
- 기존 Office CDP 연결/JS 검증과 실제 native 전면 검증을 구분한다. 다른 bundle이 보인 캡처는 Office 최종 QA로 사용하지 않는다. 초기 XCTest 자동화 프로세스 오류도 제품 크래시로 단정하지 않는다.
- 양 앱 임시 런타임 주입·query/mock/auth 상태를 복원했다. 서버 활성화 PATCH는 제어된 응답으로 처리했고 실제 서버 쓰기는 차단했다. Lab Android 설정 복귀 시 기존 권한 관련 쓰기3시도도 차단했으며 전송0이다. 네이티브 scheme/설치 데이터/로그인·실제 OS권한을 변경하지 않았다.

## Lab 최종 런타임과 제한

- iPhone17Pro iOS26.5·emulator-5554 API36에서 정확한 Lab native bundle·Metro8082·최종 소스를 확인했다. 실제 로그인은 단일 INTERNAL 소속이고 추가 행만 테스트 응답으로 만들었다. 화면의 실제 React callback과 native screenshot을 대조했으며 실제 서버 다중소속 활성화 성공으로 보고하지 않는다.
- 최초 소속 오류→다시시도→로딩→진입 복구, 캐시 재조회 오류 후 행 유지·활성화0회·원소속 유지, 수정 후 시트 닫힘·기존 오류 토스트 노출을 양OS에서 확인했다.
- 권한 지연/오류 중 Push 비활성·값 유지·부모 설정 유지, Retry 후 실제 OS 상태 회복을 확인했다. iOS 실제 blocked에서 기존 안내와 Settings 진입/복귀를 확인했으나 시뮬레이터에서는 Settings 최상위가 열려 앱별 설정 목적지 보증으로 확대하지 않는다. Android 실제 granted를 복원했고 blocked 안내 분기는 합성 결과로 앱 알림 설정 진입을 확인했다. OS 값을 실제로 바꾸지 않았다.
- All/Unread·Read All2→0·숫자 숨김/빈 상태·설정→알림함→Home 복귀 확인. 지연 취소/로그아웃/소속경합은 hook, dismiss 전 Toast0→완료1·중복0·blur/context 폐기는 화면 격리 테스트로 보완했다. 무관한 역할/화면 조합을 반복하지 않았다.
- 최종4파일은 runtime source manifest와 SHA256 일치 확인 후 커밋했다. 소스 조합 `677fd3bc9d5e4f2556849afbe68b0a9996704e005309122dd56cd38bd277620f`; `/tmp/lab-notification-basic-review-sourcehash-1105.json`.
- 양OS `restored:true/scopeUnchanged:true/installed:false`로 주입 제거를 확인하고 Office8081/Home을 정확한 native bundle로 복원했다. `/tmp/lab-basic-final-restored-{ios,android}-1105.json`, `/tmp/lab-basic-office-restored-{ios,android}-1105.png`.

## 마감과 다음 시작점

- 세 제품 모두 최종 검증 소스 그대로 commit/push했고 원격 SHA 일치·clean·upstream0/0을 확인했다. 개인 체크포인트와 본 실행 기록도 함께 저장한다. PR·merge·배포는 없다.
- Office 일반조회 실API·활성화 합성·실제벨/행 터치·기타 렌더 callback을 분리한 `/tmp/office-basic-review-1105.md`가 임시 상세 근거다. `activationOverrideRemoved/permissionOverrideRemoved/scopeRestored=true`, `hasHarness=false` 확인 후 Lab에 인계했고 마지막에는 양OS Office Home으로 복원했다.
- 기존 사용자 IDE 웹3000/3005·Office8081·Lab8082·로그인·창 배치는 유지했다. 상대 세션8093은 조작하지 않았다. 본 세션 기기 점유 종료를 승인된 채팅 메시지로 전달했으므로 이후 다른 작업이 기기를 사용하면 실행 소스를 다시 확인해야 한다.
- 이번에 재현한 FE 결함은 모두 보완했으며 최종 관찰한 영향 흐름에서 추가 크래시는 없었다. 실제 서버 다중소속·전체 권한·실물 OS 조합까지 문제가 없다는 보증이나 최종 제품 QA 완료로 표현하지 않는다. 앱 기존 타입 오류Office6/Lab5와 기존 웹 번역 감사 오류는 별도 기준선으로 남긴다.
- 새 알림 API·읽음/설정 서버 저장·다른 소속 unread 집계·실제 FCM/read 연결·USER 설정/집계·Lab Home 최근 메시지는 계속 BE/정책 확인 대기다. 이번 실패 복구를 위해 새 계약을 가정하지 않았다. 기존 추가 조회 화면/공통 딥링크는 바꾸지 않았으며 이전 영향 검증을 무효화하는 변경이 없다.
- 다음은 새 Swagger/정책 전달 시 기존 DEV UI와 실제 계약을 연결하고 실데이터/다중소속/역할 범위를 검증하는 것이다. 현재 승인한 기본 흐름 보완의 미완 항목은 없다. 새로운 결함이나 요구를 받기 전 임의 구현·전수 재검증·폴링을 추가하지 않는다.
