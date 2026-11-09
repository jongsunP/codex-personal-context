# 통합알림센터 Jira 정리 및 당일 결과 — 2026-11-09

> **최종 상태 정정:** 사용자의 후속 지시로 남은/미착수=투두, 실제 작업 중=진행 중, 불필요=완료, 작업된 것=개발완료를 적용했다. **개발완료10 / 투두3 / 진행 중0 / 불필요 완료0 / ON HOLD0**. 아래 최초 ON HOLD 처리 설명은 이력이고 현재 상태는 이 문단과 매핑 표가 우선이다. 기존 SP·담당자·부모는 모두 동일하다.

## 요청·권한과 완료 범위

사용자는 구현 마무리 후 DL-16140 하위 본인 카드의 초기 계획을 현재 실제 작업과 맞추고, 오늘 지시한 항목과 결과를 간단히 정리하도록 요청했다. 불필요한 카드의 보관, 남은 카드 제목/상태 정리는 승인했으며 **스토리포인트는 유지**하도록 했다.

- 현재 Atlassian 연결 사용자 `642a7f9580f8c2b1220fba09` = Frankie(박종선)를 확인하고 `parent = DL-16140 AND assignee = currentUser()`의 전체13개(isLast=true)를 읽었다.
- 초기10/27 설명·10/29 UI 선행 댓글을 최신 Git-backed 구현/검증 기록 및 필요한 Home 실제 코드와 대조했다. 기존 댓글은 유지하고 12개 카드의 제목/정의/현재 결과 댓글을 정리했다. UX 완료 카드17048은 그대로다.
- 결과: **완료2 / 개발 완료 Ready for Deploy8 / ON HOLD3**. “요구사항에 대해 개발 완료” 전이의 실제 도착 상태가 Ready for Deploy이며 PR/리뷰/QA/배포 완료 의미로 사용하지 않는다.
- 명백한 중복·불필요 카드 전체는 없어 **보관/삭제0**. 미정 업무가 남은 카드를 보관해 누락시키지 않았다. Lab My Orders 제외는17068의 제목/범위에서 반영했다. 완료한 OS 안내를 Home 온보딩 잔여로 중복 계산하지 않는다.
- 기존 `customfield_10016`을 쓰지 않았고 재조회에서 13개 각 SP·담당자·부모 유지, 제목·상태·본문 기대값 일치를 확인했다. SP 합계31은 기존 카드 공수 합이며 새 산정/병행 소요일이 아니다.
- 다른 담당자 카드·상위 DL-16140 본문/댓글·별도 DL-17202·Notion·Slack·Sheet를 이번 정리에서 변경하지 않았다. 제품 코드/런타임 추가 작업·PR·merge·배포 없음.

## Jira 최종 매핑

| 카드 | 제목 | 상태 변화 | 기존 SP 유지 | 새 진행 댓글 |
| --- | --- | --- | --- | --- |
| DL-17048 | 알림센터 웹·앱 UX 사전 검토 | 완료 → Ready for Deploy | 1 | — |
| DL-17057 | 알림센터 공통 정책·API 계약 정리 | 진행 중 → 완료 → Ready for Deploy | 0.5 | 44954 |
| DL-17058 | 웹(Clinic/Lab) 알림함·읽음 API 연결 | 진행 중 → Ready for Deploy | 2.5 | 44955 |
| DL-17059 | Office 앱 알림함·읽음 API 연결 | 진행 중 → Ready for Deploy | 4 | 44956 |
| DL-17060 | Lab 앱 알림함·읽음 API 연결 | 진행 중 → Ready for Deploy | 2.75 | 44957 |
| DL-17061 | 웹(Clinic/Lab) 알림 수신 설정 API 연결 | 진행 중 → Ready for Deploy | 2 | 44958 |
| DL-17062 | 웹(Clinic/Lab) 병원 선택·알림 랜딩·Home 연계 | 진행 중 → ON HOLD → 해야 할 일 | 4 | 44963 |
| DL-17063 | Office 앱 수신 설정 API·OS 알림 안내 | 진행 중 → Ready for Deploy | 3 | 44959 |
| DL-17064 | Office 앱 소속 선택·알림 랜딩·푸시 클릭 읽음 | 진행 중 → Ready for Deploy | 2.5 | 44961 |
| DL-17065 | Office 앱 Home My Orders·최초 안내 정책 확인 및 연계 | 해야 할 일 → ON HOLD → 해야 할 일 | 2 | 44964 |
| DL-17066 | Lab 앱 수신 설정 API·OS 알림 안내 | 진행 중 → Ready for Deploy | 2.25 | 44960 |
| DL-17067 | Lab 앱 소속 선택·알림 랜딩·푸시 클릭 읽음 | 진행 중 → Ready for Deploy | 2.25 | 44962 |
| DL-17068 | Lab 앱 Home 최근 메시지·LinkTalk 정책 확인 및 연계 | 해야 할 일 → ON HOLD → 해야 할 일 | 2.25 | 44965 |

## 투두3개를 남긴 근거

- **DL-17062 Web:** 일반/알림 병원 선택·전환·팝업 재열기·랜딩과 최신 디자인은 구현/검증 완료다. 카드에 남아 있던 Home LinkTalk 자동 이벤트 메시지의 표시 위치·목록/집계 적용은 미정이므로 전체 완료로 뭉뚱그리지 않는다. 알림 선택 제목·안내 문구도 확정 전 기존값을 유지한다.
- **DL-17065 Office Home:** 실제 `src/libs/useHomeOrdersData.ts:30`은 `myOrderOnly:false`다. 신규 Home My Orders·최초 안내가 완료됐다는 근거가 없다. 정본에 남은 역할/기본값/저장·초기화 조건을 확정한 범위만 연결한다. 실제 `src/libs/usePersonalOrdersPreference.ts:65–69`의 `enablePersonalOrders`와 `pushEnable:true` 결합이 남아 있어 ‘모든 기존 preference 결합 제거 완료’라고 확대하지 않는다. 알림 수신 설정과 조회 필터를 임의로 합치지 않는다.
- **DL-17068 Lab Home:** Lab My Orders는 제외 확정. 현재 Home에는 신규 최근 메시지 섹션이 없으며 최근 메시지/Support 배치와 시스템 메시지 처리 범위가 미정이다. 기존 `src/features/chat/components/message/Message.tsx`의 SYSTEM 표시와 새 Home 노출/집계 요구는 구분한다.
- Web Clinic/Lab `useDashboardLinkTalk`는 기존 최신 채팅/ORDER unread API를 사용하며 공유 LinkTalkListItem은 SYSTEM을 렌더한다. 서버 생성/조회에서 제외하는 정책이면 FE 필터가 필요 없을 수도 있고, FE 표시에서 제외하는 정책이면 별도 변경이 필요하다. 현재 근거로 정책을 결정하거나 새 구현을 시작하지 않는다.
- 이는 오늘 새 요구를 추가한 것이 아니라 **초기 카드에 남아 있던 미정 범위를 복원해 명시한 것**이다. 이미 완료된 알림센터 본체·공개 API·푸시 읽음 구현을 다시 미완료로 되돌리지 않는다. 즉시 독립적으로 추가할 FE 구현은 현재 발견하지 못했다.

## 오늘 요청과 결과

**보고 기준 정정:** 사용자의 ‘오늘’은 커밋 일자나 누적 작업 이력이 아니라 오늘 준 프롬프트 범위다. 크레딧·청구서 보완을 제외하면서 API·랜딩·시트까지 제외한 후속 정정은 오류였다. 사용자가 오늘 제공한 [Jira44913](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44913) 및 ‘명세가 나온 API는 웹·병원앱·기공소앱 모두 연결’ 요청과 이어진 세 안건을 기준으로 아래에 복원했다. 크레딧·청구서 보완은 기존 수행 이력으로 보존하되 이번 당일 요청 보고에서는 제외한다. 보고 범위 정정과 실제 구현 완료 여부/작업 일자는 구분한다.

| 요청/타이틀 | 결과 |
| --- | --- |
| BE 명세 확인·신규 알림 API 연결 | Jira/Swagger 확인 후 Web Clinic/Lab·Office/Lab 앱의 설정/목록/미읽음/개별·전체 읽음 연결, 임시 목록 제거, 검증·push |
| APP 랜딩 URL·딥링크 검토/연결 | 인박스·푸시의 같은 목적지 URL 재사용 기준 정리, 양 앱 인박스 경로 등록 및 파서 수정, 업무·Credits/Statements 주소 대조·양 OS 확인 |
| PM 시트 요청·반영 확인 | 요청62셀 모두 일치, 누락·오반영0, writer 권한 확인. PM 수정 반영과 FE 구현을 구분 |
| OS 배지 회의 결정 | 이번 배포는 새 푸시 수/기존0 초기화 유지, LinkTalk·다른 소속 포함, 새 unread 숫자 payload 없음. Notion·개인 기록 갱신 |
| 일반/알림 병원 선택 디자인 통일 | Web·Office의 카드/행/스크롤/높이를 통일, 기존 기능·Payment 권한 보존. 전환 후 이전 현재병원 표시 문제 재현·수정·검증·push |
| 푸시 클릭 읽음 | 두 앱 data.deliveryId→기존 read/push 연결, 중복·로그인 전·계정 변경·실패/재클릭 검증·push |
| Android 실제 알림 클릭 오류 | 기존 RN/Notifee 오류 재현, 최소 native patch·개발 빌드, 실제 OS 탭과 종료 후 진입 재검증·push |
| Jira·개인 기록 | 본인13개 대조/12개 갱신, SP13개 원값 확인. 오늘 결과·잔여·다음 시작점 정리 |

## 현재 Git·검증·다음

| 제품 | checkout·branch | 현재 HEAD |
| --- | --- | --- |
| Web | `/Users/parkjongsun/Repository/dentlink-client-notification-center` · `feature/DL-17058` | `ed88f08384f624f0171de9fd38cd9dffcc9ec7b2` |
| Office | `/Users/parkjongsun/Repository/dentlink-app` · `feature/DL-17059` | `676e7fc6e87783dd6c8dbcef0fbe56600084c0b9` |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app` · `feature/DL-17060` | `f9ca872b147a1c1ec1faf6320d40d2c9c39588fc` |

이번 정리에서도 3곳 clean·local upstream0/0을 확인했다. 각 구현 시 push/원격 SHA 확인은 선행 보고서에 있다.

- 실제 BE 발송 deliveryId→서버 읽음 저장과 FCM/APNs 전체 흐름, 실제 집계/권한 데이터 검증은 남아 있다. 제어 응답/로컬 Notifee 검사와 구분한다.
- **Android 이번 호환 패치는 네이티브 재빌드가 필요하고 CodePush만으로 적용되지 않는다.** iOS native 변경은 없으며 운영 바이너리 동일 장애/스토어 제출 필요 여부까지 확정한 것은 아니다. 적용 대상/전달 방법은 배포 준비 때 확인한다.
- iOS 실제 OS 권한 변경·복귀 실기기 확인, 미정 USER 설정 위치/서버 catalog 차이·알림 선택 문구는 기존 잔여다.
- 정책 확정 또는 실제 발송 데이터가 오면 해당 카드부터 재개한다. 이메일/SES·View/PDF·실제 미읽음 배지 개선을 자동 재개하지 않는다.
- 개인 컨텍스트 commit/push 후 대기하며 자동 모니터링·추가 질문/외부 연락은 시작하지 않는다.

