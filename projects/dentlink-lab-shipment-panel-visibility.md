# 기공소 배송 업데이트 내역 패널 노출 제한 — DL-17625

## 현재 상태 — 2026-11-25 작업 접수·별도 세션 인계

- 세션 `기공소 배송 업데이트 패널 노출 · DL-17625` (`01a21141-e9b6-7ab0-becc-65412540bce1`), 메인 프로젝트 폴더/local 등록·최초 구현 준비 시작을 확인했다. 이번 사용자 요청과 일치하는 메인 turn의 모델/추론 `gpt-6-astra`/`xhigh`를 생성 전에 확인했고 새 세션 실제 첫 turn에서도 동일함을 확인했다. 전용 worktree 생성·구현 결과는 담당 세션이 이어 기록하며 메인은 추가 폴링하지 않는다.
- 사용자 요청: [DL-17625](https://innovaid.atlassian.net/browse/DL-17625)를 확인하고 별도 세션·별도 worktree에서 작업한다. 다른 작업 공간은 사용 중이므로 보존한다. 구현·검증 및 작업 공간 준비 승인, 제품 commit/push/PR/merge/배포는 별도 지시 범위로 구분한다.
- 본인 하위 카드 DL-17625는 Frankie 담당·해야 할 일·본문/댓글 없음. 상위 [DL-17624](https://innovaid.atlassian.net/browse/DL-17624)에 ‘배송 + 픽업 페이지에서만 노출’이 명시되어 있다. 상위 댓글45287에서 Tom이 1.95.0 연결 및 라벨 작업과 함께 진행 요청을 남겼다. 사용자는 별도 작업 세션/worktree를 지시했으므로 라벨 브랜치에 합치지 않는다.
- [Slack 원문](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794386830573219): 모든 페이지에 패널이 나타나 CTA를 가리는 문제. 최종 Tom 답변은 배송·픽업 페이지만 노출. 패널 제거·알림으로 대체는 사용성 확인 이후 고려할 별도 제안이며 이번 구현 요구가 아니다.

## 제품·작업 공간

- 대상은 `dentlink-client`의 기공소 웹 전역 `FloatShipmentCreateController`다. 현행 mobile 제외 조건이 있고 `_app.tsx`에서 인증 후 전역으로 렌더한다. 치과/어드민/네이티브 앱 변경은 현재 확인된 범위가 아니다. 기존 모바일 미노출을 임의로 확장하지 않는다.
- 원본 `/Users/parkjongsun/Repository/dentlink-client`의 `feat/DL-17583`는 출력 세션이 사용 중이며 미커밋 변경이 있다. `notification-history-followup` worktree의 `feat/DL-16140-history-followup`도 다른 세션 소유다. 어느 쪽도 재사용·수정하지 않는다.
- 새 작업 branch `feat/DL-17625`, 최신 `origin/master` 기준으로 별도 managed worktree 생성. 확인 당시 master=`9084878eaa93ea4fe39df0f376afa4456c5fec55`, PR 예정 대상 release/v1.95.0=`b0e04eafe00e86836f472bea114e5fce867b4cad`. 이 작업 신규 브랜치 원격 없음. 패널 관련 경로는 master/release 사이 diff 없음. 최종 PR diff는 담당 세션에서 별도 확인한다.
- worktree 생성 도구·올바른 브랜치명 검증·동일 저장소 eligible ignored/untracked 로컬 env 불투명 상속을 적용한다. 제품 폴더를 새로 만들지 않고 메인 프로젝트 폴더의 새 채팅에서 진행한다.

## 확인한 코드와 구현 경계

- `lab/src/components/FloatShipmentCreateController/FloatShipmentCreateController.tsx`: 현재 `isShowFloatShipmentUI && !isMobile && !isHiddenPage`로 노출하며 `isHiddenPage`는 밀링/설비·자재 route만 제외한다. 그래서 주문 등 다른 화면에도 나타난다.
- 관련 기존 테스트 `FloatShipmentCreateController.test.tsx`는 `/orders` 노출과 `/mc/equipment`, `/mc/materials/stock` 미노출을 검증한다. 새 요구와 충돌하는 주문 노출 기대를 고치고 배송/픽업과 일반 페이지 간 이동에서 노출 조건을 검증한다.
- 실제 page routes는 `/shipping`, `/shipping/[shipping_id]`, `/shipping/scan`, `/pickup`, `/pickup/[pickup_id]`다. 담당 세션에서 경로와 페이지 역할을 대조해 허용 범위를 명시한다. 목록/상세/스캔 범위가 문맥으로 결정되지 않으면 필요한 범위만 사용자에게 확인한다.
- 변경은 노출 조건에 집중한다. SSE·비동기 배송/픽업 작업·내역 상태·토글·재진입 동작을 임의 제거하거나 전역 hook 연결을 끊지 않는다. 다른 세션의 라벨 출력 항목 수정은 포함하지 않는다. 문구 변경이 필요 없다면 i18n 변경도 만들지 않는다.

## 다음 시작점

- 담당 새 세션에서 실제 전용 worktree·branch를 기록하고 구현·영향 범위 검증 후 사용자에게 직접 결과를 보고한다. Jira는 기존 본인 하위카드에 작업 정의/필요 진행 기록을 정리하고 상위 댓글은 쓰지 않는다. 메인은 등록·전달 확인 후 폴링하거나 중복 검증하지 않는다.
