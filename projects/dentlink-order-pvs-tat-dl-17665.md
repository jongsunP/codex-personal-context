# 주문 PVS·픽업 변경 시 TAT 요구 조사 — DL-17665

## 현재 체크포인트 — 2026-11-27

- 사용자 요청: 새 업무의 뜻부터 조사해 설명한다. 구현 전 요구 해석 단계다.
- Jira: [DL-17665](https://innovaid.atlassian.net/browse/DL-17665), 상위 [DL-17654](https://innovaid.atlassian.net/browse/DL-17654).
- 담당 채팅: `주문 PVS·픽업 변경 시 TAT 요구 조사 · DL-17665`, `01a21b8e-7123-75b0-9688-08e7c882c406` (local). 실제 turn `gpt-6-astra / xhigh` 확인.
- 조사 worktree: `/Users/parkjongsun/Repository/dentlink-client-dl-17665/dentlink-client`, detached `023057ab6109e54d263079a6c64c139407f02a6b` (fetch한 origin/master). 실제 경로·Git 등록·채팅 persisted cwd 일치. 제품 clean.
- 주 checkout의 master `96bdacda6`와 타 작업은 그대로 유지. 동일 저장소 main의 eligible ignored/untracked env6개를 opaque 복사, 동일성·ignore 확인. 설치·서버·브라우저·테스트 실행 없음.
- 권한: 조사와 위 worktree 준비만. 제품 코드/branch·commit/push/PR·Jira 쓰기·배포는 미승인. 개인 기록만 유지한다.
- 확인 중: 주문 작성/수정4단계의 재사용, PVS 추가·해제와 픽업일 변경의 차이, 기존 TAT 초기화/서버 날짜 UI, 웹·앱 WebView 영향.

## 원문에서 구분할 사항

- 하위 제목은 픽업 날짜 수정, 본문은 PVS 추가·해제 시 기존 TAT 초기화와 서버가 준 가장 빠른 날짜를 선택하는 UI다. Frankie 담당/해야 할 일/댓글0.
- 상위는 새 주문4단계 정상(Scan 12/10, PVS 11/27 추가 시12/17), 접수 후 주문 수정은 기존12/10 유지가 문제라 재선택을 요구한다.
- 상위의 별도 픽업 추가는 기존 납기가 새 계산보다 빠른 경우만 자동 지연·+3/+5 영업일·안내 팝업이라는 별도 흐름이다. 하위 범위에 자동 포함하지 않는다.
- “예전에 테스트했다”는 작성자 기억이다. 실제 회귀와 현재 서버 응답·운영 재현은 아직 확인하지 않았다.

## 다음 시작점

현재 base의 호출·form 상태 흐름을 읽고, 쉬운 예시 → 코드로 확인한 범위 → 꼭 필요한 질문과 최소 작업안 순서로 직접 보고한다. 메인 공통 파일은 편집하거나 자동 보고/폴링하지 않는다.
