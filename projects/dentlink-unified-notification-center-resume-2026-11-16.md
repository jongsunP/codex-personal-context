# 통합알림센터 재개 현황 — 2026-11-16

현재 상황 파악 요청에 따라 읽기 전용으로 확인했다. 제품 코드·PR·Jira·배포·기기/서버는 변경하지 않았다. 개인 정본은 pull 결과 최신이고 기존 전체 지침 필요 시 동기화·번역시트 중단 규칙을 적용했다.

## 코드와 Development

| 제품 | worktree / branch | HEAD | PR | Development |
| --- | --- | --- | --- | --- |
| Web Clinic/Lab | dentlink-client-notification-center / feature/DL-17058 | a67e1e215 | #4862 OPEN Draft → release/v1.94.0 | develop7c8eef28c의 Clinic43389706697/Lab43389706714 모두 success. 마지막 Messages/스타일 구조 정리는 미배포 |
| Office | dentlink-app / feature/DL-17059 | a6ee48c7 | #346 OPEN Draft → main | iOS/Androidv147, target2.2.4 |
| Lab | dentlink-lab-app / feature/DL-17060 | 2c638fa | #42 OPEN Draft → main | iOSv46/Androidv45, target1.0.5 |

위 경로 루트는 /Users/parkjongsun/Repository. 세 제품 clean·원격동일(0/0). 앱별/OS별 CodePush history를1회조회해 최신 sourceSHA 일치·disabled=false·rollout100을 확인했다. 실제 기기 적용/QA는 이번에 확인한 것이 아니다. 웹 feature와 develop 차이는 마지막 코드 구성 정리 및 release의1.94.0 package버전 반영이다. 웹 master9c4418a8f/release1.94.0 32853e794 유지.

최초 조회 당시 PR본문은 이전 배포를 설명하고 있었다. 이후 사용자 승인으로 아래와 같이 세 PR 본문을 최신화했다. 웹 리뷰8개중 알림센터 지적은 해결 상태이며 기존 밀링FILE1건은 본체 범위 밖으로 유지, 새로 처리하지 않았다.

## Jira와 후속

11/16 10:31KST current Atlassian 조회: 본인 하위22건 전체(isLast=true), **ToDo10/개발완료11/완료1**, 11/13마감 이후 카드변경없음.

- PM [45036](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=45036): **11/17 STG QA 예정**. 부모 fixVersion v1.94.0, releaseDate **11/23**, unreleased.
- BE [DL17114#44994](https://innovaid.atlassian.net/browse/DL-17114?focusedCommentId=44994) 노출키 질문은 댓글전체2건에후속답변없음. [DL16140#45009](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=45009) 상하위 저장/실제수신 확인도 최신15댓글에서후속답변없음.
- ToDo10: 설정계약17415/16/17, 본체외Home17062/65/68, 향후배지17418/19, 별도E2E17426, Office주문상세17436. 밀링범위제외17420은완료. Figma/Notion 전체재조사는안했으므로 디자인변경없음을live확정한것은아니다.
- Office 자체주문상세는 **release/v2.2.5@ca259592**, 11/13 17:12 DL17175 PR341에있다. origin/main/알림feature에는없다. Git포함관계로1.93제품배포완료를단정하지않고 DL17436유지. 1.93배포/통합기준확보후치과앱만appLandingUrl/pushdeeplink·권한/복귀/read·대상바이너리호환대조. 기공소앱제외.

## 다음 시작점

완료한본체/DEV상태와 미배포웹정리·STGQA일정을먼저브리핑. PR본문최신화는후속승인으로완료. BE계약/본체외Home·배지·별도E2E/Office새화면후속은분리한다. 번역시트후속없음. 별도지시없는배포·구현·추가감시는하지않는다.

## 후속 승인: 배포 없이 PR 설명·기록 정리 완료

사용자는 웹의 마지막 리팩터링을 배포하지 않고 현재 개발서버로 기능 QA를 이어가며, 웹·앱 PR 설명과 메모리만 정리하도록 승인했다. 미배포 변경은 문구 훅 명칭·스타일 코드 구성과 릴리즈 버전 표기로 기존 화면/문구/API/동작을 유지한다. 현재 개발서버 QA가 미배포 리팩터링 자체의 배포 검증이라는 뜻은 아니며, 해당 커밋의 로컬 검증은 11/13 기록을 따른다.

- Web PR4862: DEVPR4891/7c8eef28c·양배포 success, 설정 즉시 표시/실패 복구, 실제 저장 확인 GET 근거, 마지막 Messages/스타일 리팩터링 미배포를 반영했다.
- Office PR346: Development v147 양OS/target2.2.4/sourcea6ee48c7, 즉시 반응·65 tests·양OS 검증·대표 iOS 실제 API 원복과 실기기 QA 경계를 반영했다. 자체 주문 상세 연결은 DL17436 후속이다.
- Lab PR42: iOSv46/Androidv45/target1.0.5/source2c638fa, 동일 저장 UX·16 tests·양OS 검증·대표 Android 실제 API 원복과 실기기 QA 경계를 반영했다.
- 세 PR 본문을 재조회해 반영 및 title/base/Draft/head 불변을 확인했다. Office에는 Jira 연동의 DL17436 링크 정의만 자동 추가됐다. Lab 커넥터 접근 제한은 gh로 보완했다. 리뷰/상태/머지/댓글 추가는 하지 않았다.
- 제품3저장소 clean, 새 코드·제품 커밋·배포 없음. 새 정책이나 작업 상태 변경이 없어 Jira/Notion은 수정하지 않았다. 문서 수정이므로 기존 최종 코드 검증 근거를 사용하고 테스트를 재실행하지 않았다.
- 현재 DEV로 QA 계속 가능. Web a67e1e215 미배포 유지, 앱 추가 CodePush 불필요. PR 설명 최신화는 남은 일에서 제외한다. 별도 요청 전 STG/추가 배포·구현·감시 없음.
