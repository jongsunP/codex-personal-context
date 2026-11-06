# 통합알림센터 앱 테스트 — 2026-11-06

## 범위와 판정 기준

**후속 사용자 확인(11/6):** 이번 기공소앱은 단일소속 전제이며 밀링센터 계정 전환은 이번 소속 검증 범위와 무관하다. 따라서 Lab 다중소속 계정 확보/성공 전환을 남은 작업이나 완료 조건으로 요구하지 않는다. 아래 당시 실행 사실은 보존하되, 실제 미검증 사실과 이번 범위의 잔여 작업을 구분한다. 기존 밀링 알림이나 공통 코드 삭제 지시로 확대하지 않는다.

사용자가 정한 4축인 **OS 알림 설정 / 병원·기공소 전환 / 권한별 메뉴 / 기본 알림 흐름**을 기준으로 점검했다. 실패·지연·화면 이탈·늦은 응답·중복 처리도 해당 흐름에 포함한다. 화면 표시만 맞는지와 실제 API 동작을 구분한다.

- Office: `/Users/parkjongsun/Repository/dentlink-app`, `feature/DL-17059`, HEAD `933d054b6744a619de3825716982aadf871461dd` + 로컬 변경.
- Lab: `/Users/parkjongsun/Repository/dentlink-lab-app`, `feature/DL-17060`, HEAD `a6432e279c8eeb3d86821442f4e4149954f62213` + 로컬 변경.
- 기기: iPhone 17 Pro/iOS26.5 및 Dentlink_API_36/emulator-5554. 제품별 두 기기를 같은 DEV 소스·환경으로 전환했다. Office Metro8081, Lab8082.
- 실제 로그인: Office OWNER·다중소속, Lab OWNER/INTERNAL·단일소속. 다른 역할은 응답/캐시를 제어한 화면 검증과 구분한다.
- 웹은 이번 검증 범위가 아니며 기존 실행·창 배치는 유지했다. 신규 BE 계약·서버 수신 설정·알림 읽음/삭제 API를 가정하거나 연결하지 않았다.

## 4개 축 결과

최신11/5 정책을 적용한다. **설정 화면 파란 배너는 OS OFF 동안 상시 노출**, 자동 OS 안내 팝업만 기기별1회다. 이전 배너1회 정책으로 되돌리지 않는다.

| 테스트 축 | 병원앱(Office) | 기공소앱(Lab) | 구분해야 할 한계 |
|---|---|---|---|
| OS 설정·앱 복귀 | Android 실제 OFF/ON→앱 복귀, 안내 취소/허용 안 함, 선택한 Push만 ON 확인. 자동 팝업 첫 표시 이력·재시작 후 중복 미노출 확인 | Android 실제 OFF/ON 및 선택한 Design만 ON·Updates OFF 확인. 기존 팝업 확인 이력에서 중복 미노출 | iOS는 실제 권한 상태·Settings 왕복에 제어된 권한 응답을 보완했다. 실제 OS 토글 OFF→ON을 직접 확인한 것으로 표현하지 않는다 |
| 병원·기공소 전환 | 양 OS에서 기존 실제 활성화 API로 A→B 및 원래 A 복귀. 알림센터 경유는 새 소속 인박스, 기존 Home 경유는 Home 유지. 두 토스트의 위치/컴포넌트는 같고 문구만 다름 | 실제 소속 조회 결과 1개, 현재 소속을 제외한 다른 기공소 버튼 없음. 조회 실패→Retry→실제 조회 복구 확인. 기존 전환 helper/토스트 코드 대조 | Lab 다중소속/밀링센터 계정 전환은 이번 범위에서 제외(11/6 사용자 확인). Office 다른 병원 미읽음 집계는 미연결 |
| 권한·제품별 메뉴 | 실제 OWNER에서 결제·수신 범위 표시. 제어한 PAYMENT_MANAGER는 결제·범위 표시, EDITOR/VIEWER는 결제 숨김·범위 표시, MEMBER는 둘 다 숨김. MEMBER는 양 OS 확인 | 현재 OWNER/INTERNAL에서 LinkTalk·Support·Design·Order Updates·Milling Updates의 Push 메뉴 확인. 병원앱의 결제·Email·수신 범위가 섞이지 않음 | Office 비OWNER는 직원 query 응답을 제어한 FE 검증이며 실제 계정/서버 권한 검증 아님. Lab 전체 역할/외부 기공소 조합은 미검증. USER 설정/집계 정책 미정은 유지 |
| 기본 알림 | 양 OS 실제 벨·All/Unread·개별 읽음·Read All·0 배지 제거·빈 화면·설정 왕복 확인. iOS Profile/Orders/LinkTalk 벨 확인 | 양 OS 실제 벨·All/Unread·개별 읽음·Read All·0 배지 제거·전체 목록·설정 확인. iOS Profile/Orders 벨 확인 | 목록·읽음·설정은 DEV mock. 서버 영속화, 실제 FCM 발송→클릭→읽음 REST까지 통과한 결과는 아님 |

### 진입 경로별 토스트 차이

- Office의 명시적 소속 선택: 알림센터는 `Switched to …`, 기존 Home은 `Office has been successfully changed`. 양 OS 실제 전환에서 동일한 기존 토스트 위치/방식임을 확인했다.
- Office의 알림 항목 딥링크 자동 전환은 기존 흐름대로 성공 토스트 없이 대상 화면으로 이동한다. 이번에는 실패 안내 누락만 보완했다.
- Lab은 코드상 기존 Home 일반 전환에 성공 토스트가 없고, 알림센터 경유 전환만 새 알림함 복원과 성공 토스트가 있다. 확정된 기존 동작을 임의로 통일하지 않았다. 이번 사용자 범위는 단일소속이므로 Lab 다중소속 성공 검증을 잔여 작업으로 두지 않는다.

### 다른 병원 알림의 랜딩

- 기본 mock 행에는 `landingUrl`이 없으므로 기존 행에 이미 지원되는 링크만 일시 주입해 실제 터치했다. 제품 소스에 테스트 URL은 추가하지 않았다.
- Office iOS: 같은 병원 `dentlink://office/credit?employerId=1409` → native Office Credits 화면·기존 조회 API 정상 실행.
- Office Android: 다른 병원 `employerId=86` → 실제 활성화 API 성공 → 대상 병원 Office Credits 화면. 이후 기존 Home 전환으로 원래1409/1889 복원.
- 일반 소속 선택도 딥링크도 기존 활성화 API를 사용한다. 로그인 사용자 소속 확인·활성화 응답 검증 후 새 소속으로 조회한다.
- 새 알림센터 읽음은 여전히 mock이며, 실제 푸시의 알림 식별·읽음·클릭 이력 계약은 이번 테스트로 확정하지 않는다.

## 오늘 발견하여 보완한 결함

| 결함 | 조치 | 검증 |
|---|---|---|
| DEV 신규 설정을 시험하는 동안 기존 PermissionProvider가 OS 권한을 legacy 수신 설정 API에 반영하려는 경로 | DEV에서 legacy 초기화 쓰기 분리. 비DEV 기존 동작 유지 | 수정 전 호출 시도를 전송 전에 차단해 실제 전송0. 수정 후 양 앱 OS 복귀에서 호출0. Provider 검사8건 |
| 설정 화면을 벗어난 뒤 늦게 도착한 OS 허용 응답이 이전 Push 선택을 적용할 수 있음 | blur/unmount/문맥 변경 시 pending 취소, 적용 직전 화면 focus 확인 | 기존 Office 컴포넌트·hook 회귀26건. 실제 Settings 왕복의 정상 적용 유지. 별도 native 지연 race를 모두 검증했다고 확대하지 않음 |
| 다른 소속 딥링크 활성화 실패 시 기존 화면만 남고 실패 안내 없음 | Office/Lab 각각 기존 소속 전환 오류 토스트 재사용. 최신 요청·원계정/원소속 유지 실패만 안내 | Office Android 기존 코드에서 실제 행 클릭으로 무안내 재현. 양 앱 최종 코드는 제어한 활성화 실패로 가시성·원소속 유지를 검증 |
| Lab 실패한 deferred 딥링크가 재렌더 때 자동 재처리되어 활성화 요청이 반복됨 | 준비 전에는 대기하되, 소속 준비를 시도한 실패/무효 요청은 소비. 명시 재클릭은 재시도 허용 | 양 OS에서 재현(서버 전송은 서비스 응답 제어로0). 수정 후 양 OS 한 번 클릭→활성화1/토스트1·pending 제거, 명시적으로 다시 클릭→각각 총2회만 확인. 반복 경계6건: 40회 재렌더에도1회, 재클릭 시 추가1회 |

알림 목록 터치 시 mock 읽음이 먼저 적용되는 기존 동작은 변경하지 않았다. 랜딩 실패/대상 삭제에 대한 실제 읽음 정책을 새로 결정한 것이 아니다.

## 화면 아래 오류 문구와 실행 상태

**결론:** 재현된 알림 FE 결함은 수정했고 마지막 기능 검증은 통과했다. 실패 테스트용 토스트는 정상 안내다. Android의 일시적 실행 멈춤은 현재 정상화됐지만 원인을 확정하지 못했으므로 해결 완료로 단정하지 않는다. 이 현상과 알림 기능의 확정 잔여 구현을 혼동하지 않는다.

- 전환 실패·조회 실패 테스트에서 의도적으로 띄운 빨간 토스트/Retry는 정상적인 실패 안내다. 오류를 숨기거나 성공으로 바꾼 것이 아니다.
- 앞선 OS 테스트 도중 hook 수정의 Fast Refresh에서 `Rendered more hooks than during the previous render`가 나타났다. 무시 가능한 문구로 분류하지 않고 앱을 완전히 재시작한 최종 코드에서 재검증했다. 동일 오류의 재발은 관찰하지 않았다.
- Android 실행 시작의 ANR/번들 로드 실패 및 이번 조작 지연은 별도 실행 환경 이슈로 남긴다. ADB reverse/연결 재등록 후 정상화됐으나 최초 ANR의 원인은 확정하지 않았다. 이번 조회한 로그에 Dentlink fatal/ANR 기록은 없었고 최종 앱 LogBox는 비어 있었다. 과거 ANR이 없었다고 소급하지 않는다.
- 일부 Maestro 실패는 잘못된 화면 문구(`Notifications` 대신 실제 `Notification`), 전환 대기/선택자 문제였다. 실제 화면과 상태를 확인해 올바른 selector로 재검증했으며 제품 결함으로 집계하지 않았다.
- 사용자가 보았던 모든 문구의 정확한 원문을 확인한 것은 아니므로, 모든 하단 메시지가 무해하다고 일반화하지 않는다.

## 아직 실데이터로 확인해야 하는 것

1. 신규 API 연결 후 목록·읽음·삭제·수신 설정 저장/재조회와 실패 복구.
2. 소속별 미읽음 집계와 USER/Employee 알림 정책. Office의 다른 병원 안내/헤더 점 일부는 현재 fixture이므로 Read All 뒤 점이 남는 것이 실제 집계 결과는 아니다.
3. 실제 푸시 수신·클릭→대상 소속/화면→읽음 API·클릭 이력. 알림 식별자는 notificationId 직접 전달로 임의 확정하지 않는다.
4. 실제 Office 비OWNER 계정의 서버 권한 검증. OS 설정 확인의 남은 범위는 iOS의 실제 OFF/ON 전환이며, 지원되는 실기기/환경에서 확인한다. Android는 에뮬레이터의 실제 OS 설정으로 이미 확인했다.
5. 미정 USER 설정/집계(#20–22), Lab Home 최근 메시지(#19)는 기존 대기 범위로 유지한다.

## 검사·근거

- 기존 OS 관련 Office Jest26건, Lab 소속 전환 hook24건, 양 앱 pushPreference 각3건, Provider8건 근거 재사용. 해당 최종 OS 파일은 이번 후속에서 변경하지 않았다.
- 딥링크 변경 관련 Office 기존 Jest29건/Lab6건 통과. 실제 함수 소스를 사용한 임시 guard30건+Lab deferred6건 통과. 양 앱 변경 파일 lint/diff-check 통과.
- 실제 화면 근거: `/tmp/appqa-office-home-toast-*-1106-*.png`, `/tmp/appqa-office-notification-toast-*-1106-*.png`, `/tmp/appqa-office-cross-credit-android-1106.png`, `/tmp/appqa-office-role-*-ios-1106.json`, `/tmp/appqa-office-member-*-1106.png`, `/tmp/appqa-lab-settings-*-1106.png`, `/tmp/appqa-lab-load-failure-ios-1106.png`, `/tmp/appqa-lab-link-once-*-1106-*.png`.
- 실행 실패와 최종 성공을 분리하여 본문의 결과를 정본으로 삼는다. `/tmp` 파일은 장기 보존을 보장하지 않는다.

## 마감

- 오늘 수정은 Office6파일·Lab4파일이다. 앞선 OS2건에 딥링크 실패 안내 및 Lab 반복 처리 방지를 추가했다. 최초 보고 시 로컬 변경이었으며, 후속 사용자 승인으로 아래 commit/push를 완료했다. PR·배포는 없다.
- 테스트 중 바꾼 서비스 함수·권한 응답·권한 캐시·목록 URL·mock 상태를 원복했다. Lab 실패 검증의 임시 소속은 `getState` 읽기 응답만 제어했고 실제 auth 저장/서버 전송은 없었다. 마지막 양OS 각각 실패1회·사용자 재클릭 시 총2회, 임시 함수 복원·실제 단일소속85/212 유지까지 확인했다.
- Office 실제 서버 전환은 원래1409/1889로 복귀했고, 기기 페어를 같은 Office DEV/Metro8081의 Home으로 복원했고 마지막 양OS LogBox0을 확인했다. OS 설정·설치·로그인은 보존하며 서버/창 배치는 유지한다.
- 새 BE 계약을 받으면 남은 실데이터 검증을 이어간다. 최종 제품 QA·배포 가능 판정으로 확대하지 않는다. 후속 사용자 승인에 따른 제품 commit/push와 실행 종료는 아래 최신 마감을 따른다.

## 후속 마감 — Android 제한 재확인·제품 push·종료

- 사용자는 조작 겹침/Reactotron shake를 앞선 멈춤의 가능성으로 제시했고, 원인으로 단정하지 않은 채 Android만 짧게 확인한 뒤 웹으로 넘어가도록 승인했다. 전체 기능·iOS 검증을 반복하지 않았다.
- Android Office/Lab 각각 앱 완전 종료·재실행 → 홈 벨 → 알림함 → 설정 → 뒤로 → 홈을 실제 Maestro 조작으로 통과했다. 시작 시 지연은 있었지만 이번 구간의 새 Dentlink `am_anr`/`am_crash` 이벤트0, 최종 두 JS LogBox0이다. 최초 멈춤 원인을 해결한 것으로 표현하지 않는다.
- 최종 diff 독립 읽기 리뷰·diff-check 통과. 코드 변경 없이 오늘의 관련 Jest/lint/양 OS 실패 재현 검증을 재사용했다. commit-changes 스킬을 설치 경로에서 찾지 못해 저장소의 한글 커밋 규칙과 목적별 분리를 적용했다.
- Office `13bc0b5`(권한 복귀)·`1b1e449d66a96ef261c80b6603ade52721a3f6d7`(딥링크 실패 안내), Lab `b981863`(권한 복귀)·`93c5e8742906e08a38a6000d02e517beb5a94cc2`(딥링크 실패 반복 방지)를 각각 기존 feature 브랜치에 commit/push했다. 원격 SHA 일치·clean·upstream 일치를 확인했다.
- 사용자 요청으로 앱 종료 후 emulator-5554와 iPhone17Pro 시뮬레이터를 종료하고 본 세션의 Metro8081/8082(PID5435/5477)를 종료했다. 로그인·설치·권한 데이터는 삭제하지 않았다. 웹 IDE 서버3000/3005와 사용자 Chrome은 유지했다.
- 근거: `/tmp/app-closeout-{office,lab}-1106.log`, `/tmp/app-closeout-{office,lab}-home-1106.png`, `/tmp/app-closeout-office-state-1106.json`, `/tmp/app-closeout-lab-final-state-1106.json`, `/tmp/app-closeout-android-events-1106.json`.
