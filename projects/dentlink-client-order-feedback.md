# Dentlink 주문 피드백 수집 — DL-15828

이 문서는 치과 주문 피드백 수집 기능의 개인 체크포인트다. 다음 세션에서는 이
기록보다 live Git, Jira, Notion, Figma와 배포된 Swagger 상태를 우선한다. 기획
검토, 구현, 로컬 QA, 앱 검증, release 전달, 스테이징 QA와 배포를 구분한다.

## 범위와 자료

- 상위 Jira: [DL-15828](https://innovaid.atlassian.net/browse/DL-15828)
- 기획 문서:
  [Notion](https://app.notion.com/p/innovaid/3b1ce072e82f8105aec7e513995abc18)
- Figma:
  - [전체](https://www.figma.com/design/Lu8GEh1TUU5hOfj2FCPRYn/0101.-%EC%B9%98%EA%B3%BC--%EC%A3%BC%EB%AC%B8-%ED%94%BC%EB%93%9C%EB%B0%B1-%EC%88%98%EC%A7%91?node-id=60-9606&p=f&m=dev)
  - [마이페이지](https://www.figma.com/design/Lu8GEh1TUU5hOfj2FCPRYn/0101.-%EC%B9%98%EA%B3%BC--%EC%A3%BC%EB%AC%B8-%ED%94%BC%EB%93%9C%EB%B0%B1-%EC%88%98%EC%A7%91?node-id=160-38938&m=dev)
  - [피드백 목록·상세](https://www.figma.com/design/Lu8GEh1TUU5hOfj2FCPRYn/0101.-%EC%B9%98%EA%B3%BC--%EC%A3%BC%EB%AC%B8-%ED%94%BC%EB%93%9C%EB%B0%B1-%EC%88%98%EC%A7%91?node-id=160-40593&m=dev)
  - [주문 상세](https://www.figma.com/design/Lu8GEh1TUU5hOfj2FCPRYn/0101.-%EC%B9%98%EA%B3%BC--%EC%A3%BC%EB%AC%B8-%ED%94%BC%EB%93%9C%EB%B0%B1-%EC%88%98%EC%A7%91?node-id=160-38179&m=dev)
- 제품 범위: Clinic PC·모바일 웹과 Dentlink App의 주문 피드백 진입, 목록,
  작성·수정 및 주문 상세 연동
- 알림센터 구축과 ChannelTalk 중앙 진입점 대체는 2차 범위로 제외한다.

## 현재 체크포인트 — 2026-08-20

- 전용 worktree:
  `/Users/parkjongsun/Repository/dentlink-client-order-feedback`
- branch: `feature/DL-15828`
- base/current HEAD:
  `origin/master` / `9b57bec96be7b8f63c48ef4fb67ff46fbe2d2928`
  (`Release/v1.83.0 (#4507)`)
- worktree: clean
- upstream: 없음. 빈 feature branch는 아직 원격에 push하지 않았다.
- `pnpm install --frozen-lockfile`과 Husky 설치를 완료했다.
- 설치는 성공했으며 `shared/configs`와 `shared/models`의 순환 workspace 의존성과
  optional `canvas@2.11.2` 설치 생략 경고만 있었다.
- 제품 코드 수정, project commit/push, PR, 신규 구현 세션은 아직 없다.

## FE Jira 구조와 스토리포인트

Dentlink의 시간 기반 산정인 `1 point = 6 planned work hours`를 적용한다.

- [DL-15830](https://innovaid.atlassian.net/browse/DL-15830)
  `[FE] 개발 플래닝`: 0.5
- [DL-16063](https://innovaid.atlassian.net/browse/DL-16063)
  `[FE] 주문 피드백 공통 API 및 상태 관리 기반 작업`: 1
- [DL-16056](https://innovaid.atlassian.net/browse/DL-16056)
  `[FE] 마이페이지 Quick Links 및 리뷰 진입점 작업`: 0.5
- [DL-16057](https://innovaid.atlassian.net/browse/DL-16057)
  `[FE] 피드백 목록 페이지 작업`: 1
- [DL-16058](https://innovaid.atlassian.net/browse/DL-16058)
  `[FE] 피드백 상세 입력·수정 작업`: 1.5
- [DL-16060](https://innovaid.atlassian.net/browse/DL-16060)
  `[FE] 주문 상세 피드백 영역 작업`: 0.5
- [DL-16064](https://innovaid.atlassian.net/browse/DL-16064)
  `[FE] 앱 피드백 개발환경 및 WebView/native 연동 범위 검증`: 미산정
- [DL-16061](https://innovaid.atlassian.net/browse/DL-16061)
  `[FE] 앱 피드백 화면 및 native 연동 구현`: 미산정

앱을 제외한 확정 합계는 플래닝 포함 5 points다. 총 8개 카드이며 앱 기술
검증과 구현 2개 카드는 작업 범위에 포함하지만 스토리포인트 합계에서는 제외한다.
모든 카드는 `DL-15828`의 하위 작업, 담당자 Frankie(박종선), 상태 `해야 할 일`로
마지막 확인했다.

## 확인된 제품 정책

- 피드백 단위는 주문이며 Good / Bad 선택만으로 응답 완료 처리한다.
- 상세 사유와 자유서술은 추가 입력이며 등록 후에도 수정할 수 있다.
- 삭제는 지원하지 않는다.
- 배포 이후 원주문이 최초 COMPLETED된 경우만 대상이다.
- 피드백 목록에서는 주문 상태가 이후 변경되어도 계속 조회·수정할 수 있다.
- 주문 상세 유도 영역은 현재 주문 상태가 COMPLETED인 동안만 노출한다.
- 담당 의사가 변경되면 담당 의사별 피드백을 구분한다.
- 사용자 노출 문구는 영어다.
- 웹과 앱은 동일한 서버 데이터와 공통 query/cache 규칙을 사용한다.

## 구현 전 남은 확인

- 목록 정렬 기준
- Bad 선택 후 상세 화면 자동 진입 여부
- 상세 사유가 완전 선택 사항인지 여부
- Figma의 상품별 사유와 Notion의 Shade / Fit / Material / Other 사이 최종 계약
- BE DTO, eligibility, pagination, count, category/reason 계약
- App 저장소와 실행·빌드·디바이스 검증 환경
- Clinic WebView와 native app의 화면, navigation, back, safe-area, deep-link 책임
- 현재 `origin/master` generated model에는 주문 피드백 API contract가 없으므로
  구현 시작 시 배포된 Swagger를 재확인해야 한다.

## 다음 시작점

1. 신규 Codex 프로젝트/세션을
   `/Users/parkjongsun/Repository/dentlink-client-order-feedback`에 연결한다.
2. 개인 컨텍스트를 pull하고 이 문서와 live Git/Jira/Notion/Figma를 reconcile한다.
3. `git fetch --all --prune`, `git status -sb`, HEAD와 `origin/master` 차이를 확인한다.
4. 배포된 Swagger와 BE 계약을 확인한 뒤 DL-16063 공통 데이터 기반부터 시작한다.
5. DL-16056, DL-16057, DL-16058, DL-16060 순서와 의존성을 실제 코드 구조에
   맞게 조정하며 웹 범위를 구현한다.
6. 앱 구현 전에 DL-16064로 앱 환경과 WebView/native 책임을 확인하고, 그 결과로
   DL-16061의 범위와 스토리포인트를 확정한다.
7. shared 저장소의 commit, push, PR은 사용자의 명시 지시가 있을 때만 수행한다.
