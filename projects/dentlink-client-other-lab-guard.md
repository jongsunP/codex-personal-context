# 타기공소 주문 조회 가드 — DL-16596

## 2026-10-06 구현 및 PR 체크포인트 (디자인 승인 제한은 아래 재검토로 정정)

- 메인 세션: `01a08f0c-2057-7852-ae8d-0cf950a91fd3`. 위임 범위는 구현·검증·commit/push·release/v1.88.0 대상 PR·임시 worktree 정리. merge/deploy/Jira/Notion 변경 제외.
- PR: https://github.com/Innvoaid/dentlink-client/pull/4662
- 전달 브랜치: `feature/DL-16596-v1.88.0`, base `release/v1.88.0` (`faaa1498189e3e584cfc6fce215ce97feca156f7`). 최종 head `df13137567a86192f4d9c0062bd83f35b772b2a4`.
- 커밋: `9d975bf7a83ad55251e6411bcccf3e9ea7cd98dd` 타기공소 주문 조회와 읽음 요청 가드; `df13137567a86192f4d9c0062bd83f35b772b2a4` 채팅 조회 권한 전환 시 페이지 초기화.
- 최초 최신 master `6b79c9756cc56313fe833aad463bddb1f8c385fa` 기반 `feature/DL-16596` 구현 커밋 `3d9e91f27279601313679e004fc6920f96f5fd33` 이후, 무관한 master 커밋이 release PR에 포함되는 것을 피하도록 릴리즈 전달 브랜치에 기능만 cherry-pick. 원본 로컬 브랜치는 보존.

## 변경

Lab 6개 파일만 변경. `useOrderExtraFeeForm.ts`에서 활성 직원·기공소 소유 확인 전/타기공소 extra-fee GET 및 관련 옵션 조회 차단, 자기기공소 초기 건수와 생성·취소 후 재조회 유지. LinkTalk 본문·캐러셀 읽음 callback에 동일 가드 및 지연 callback 검증. 주문·직원·조회 권한 변경 시 메시지/페이지/최초 읽음 상태 초기화. SSR orderId가 문자열로 들어오는 실제 경로는 숫자 정규화 비교.

`useOrderApprovalPage.ts`와 승인 페이지는 이력 진입과 siblings 읽기를 유지하고 타기공소 승인 버튼·모달·요청을 제한. 서버의 실제 디자인 자료 읽기 권한 해결을 의미하지 않음. AppProviders 및 최근 컨펌 직접 조회에서 HTTP 403 AND code 1018만 서버 message를 기존 ERROR 토스트로 그대로 표시. 나머지 기존 오류 정책 유지.

## 확인

- Clinic/Lab/Admin 타입 검사 통과. push hook lint, Admin DLOS guard baseline60/current60, guard 테스트, 공유 테스트53개, 공유 커버리지 변화 없음 통과. 기존 lint 경고 존재.
- 임시 실제 React Query 격리 harness 통과: 소유 확인 로딩/타기공소/직접 추가금 링크, 자기기공소 초기 건수/생성·취소 재조회, 캐시 및 직원 전환, 본문·캐러셀·폴링 읽음 가드, 지연 callback, 자기기공소 최초/새 메시지 읽음, 페이지1 이후 직원 변경 페이지0 초기화, 승인 읽기/쓰기 분리, 정확한403/1018 및 기타 오류.
- 실제 Chrome 로컬 Lab + 로컬 fixture API: 타기공소 일반/재진입/직접 추가금 링크 extra-fee GET 및 chat read POST0건. 자기기공소 추가금 GET1건·탭 건수·입력창·최초 read POST1건 유지. 이력 클릭으로 컨펌 페이지 및 siblings 조회, 승인 버튼 없음. 서버 문구 그대로 표시와 기존 빨간 ERROR 토스트 확인.
- 최종 PR head/6파일/base 확인. release merge-tree 충돌 없음. STG 사용자 탭은 조회만 했고 인증 read POST/주문 쓰기 요청 안 함.
- QA 증거: `/tmp/dl-16596-verify/` 임시 harness/API/검사 로그. 보존 화면: `/Users/parkjongsun/.codex/visualizations/2026/10/06/01a10f22-340a-7703-b5e6-2fc0d0f313cd/qa/design-readonly.png` (로컬 fixture).

## 남은 일 / 다음 시작점

- 실제 STG 타기공소 디자인 자료·파일 접근 권한은 BE 연동 및 사용자 QA 필요. fixture 파일 목록은 비어 있어 실제 미리보기/다운로드 증명 없음.
- release 통합 QA와 사용자 최종 확인 필요. merge/deploy 미실행. 일반 PR 생성 범위이므로 CodeRabbit 자동 리뷰 사이클 미실행.
- 원격 전달 브랜치와 PR에서 재개. 다른 MEDIT/DLDS/권한 worktree는 수정하지 않음.
- 로컬 QA 탭 닫음,3116/3117 서버 중지. 임시 worktree는 추적/비추적 변경 없음 및 생성된 ignored 산출물만 있음을 확인 후 제거. 개인 체크포인트는 이 파일만 기록하며 프로젝트 index 연결은 메인 세션 담당.


## 2026-10-06 사용자 요구사항 재검토 — 수정 대기

사용자가 같은 기능 세션에서 의도를 재확인했습니다. 타기공소 주문 상세의 extra-fee GET 및 lastReadMessageId 읽음 POST는 불필요하므로 차단하고, 디자인 확인 데이터는 보여야 합니다. 기존 디자인 확인 동작에 새 타기공소 제한을 추가하라는 요구는 없었습니다.

- live PR #4662는 OPEN, head `df13137567a86192f4d9c0062bd83f35b772b2a4`, base release/v1.88.0. 제품코드/PR은 이번 조사에서 변경하지 않았습니다.
- 원래 사용자 요청·메인 인계·Jira DL-16596/16597을 다시 대조. 디자인 확인 siblings/recent/files 조회 차단은 새로 넣지 않았습니다.
- **확인된 범위 밖 변경:** `useOrderApprovalPage.ts`에 activeEmployee/주문 기공소 일치로 canApprove를 제한하고 handleApprove를 차단함. 이를 위해 원래 없던 useOrderShowQuery 호출도 추가. 승인 페이지는 해당 조건으로 승인 모달을 숨김. 타기공소와 주문정보 로딩/실패 시 기존 승인 UI·요청이 바뀜.
- 위 승인 제한은 기존 정책 유지라는 인계를 신규 제한 요구로 확대 해석한 결과. 이전 체크포인트의 승인 제한 완료 및 이를 정당화하는 QA 기록은 구현 사실의 기록이며 요구 충족 근거로 사용하면 안 됩니다.
- 임시 harness도 foreign approve blocked를 기대값으로 검사했고, 로컬 fixture의 design files는 비어 있었습니다. 따라서 검사 통과·스크린샷으로 요구 충족이나 실제 디자인 파일 표시까지 증명하지 못함.
- 수정 방향: 승인 페이지의 신규 조건부 modal 변경 원복, hook의 신규 소유 조건·추가 주문조회·handleApprove 조건 원복. 기존 디자인 조회/승인 흐름 및 요구된403+1018 서버 메시지 처리는 유지. extra-fee와 chat read 차단은 유지.
- 현재 요청은 작업 재확인이므로 감사 결과를 보고하고 제품 수정은 대기. 임시 worktree는 여전히 제거된 상태이며 다음 수정 시 원격 PR head에서 안전하게 복원해야 함.
