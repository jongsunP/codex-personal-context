# 기공소 주문·배송 목록 라벨 및 스티커 출력

## 현재 상태 — 2026-11-24 현장 출력 개선 메모·단계별 플래닝

- 사용자 목적: DL-17549·DL-17565를 함께 다루며 FE 단독으로 현장의 라벨·스티커 출력 효율을 개선한다. 현재는 사용자가 현장 문제와 아이디어를 추가하며 하나씩 플래닝하는 단계다. 아래 내용은 요구 메모·검토 후보이며 최종 UI·설계·일정 또는 구현 승인이 아니다.
- 담당 채팅: **기공소 라벨·스티커 출력 · DL-17549·DL-17565**, `01a20bee-0fb0-72b0-83df-9619645cb73a`.
- 기존 메인 프로젝트 폴더 `/Users/parkjongsun/Documents/ChatGPT/메인 프로젝트`, host `local`. 신규 폴더·제품 branch·worktree 없음.
- 이번 사용자 요청과 일치하는 메인 현재 turn metadata에서 `gpt-6-astra / xhigh`를 확인해 그대로 생성했고, 새 채팅의 실제 적용 모델·effort·cwd와 초기 조사 시작을 확인했다. 고정 최고값을 사용하지 않았다.
- 메인은 기본 Jira 조회와 인계·등록·초기 기록만 완료했다. 담당 채팅이 사용자에게 직접 브리핑하며, 메인은 자동 진행 조회나 중복 코드 조사 없이 대기한다.

## Jira에서 확인된 기본 범위

| 상위 | 제목 | Frankie 담당 하위 |
| --- | --- | --- |
| [DL-17549](https://innovaid.atlassian.net/browse/DL-17549) | [기공소] 주문 목록 선택 후 라벨 및 스티커 출력 | [DL-17582](https://innovaid.atlassian.net/browse/DL-17582) |
| [DL-17565](https://innovaid.atlassian.net/browse/DL-17565) | [기공소] 배송 목록에서 라벨 및 스티커 일괄 출력 기능 | [DL-17583](https://innovaid.atlassian.net/browse/DL-17583) |

- 2026-11-24 초기 조회: 상위 담당 Tom, 하위 담당 Frankie, 네 카드 모두 `해야 할 일`, 본문 설명 없음·댓글 0개. 세부 정책·디자인·API·앱 포함 여부는 미확정이다.
- 기초 코드 확인은 `/Users/parkjongsun/Repository/dentlink-client` 기공소 웹의 현재 Git 상태 및 기존 주문·배송 목록 출력 진입점/구성 위치로 한정한다.
- 기존 [DL-17101 배송 출력 UX](dentlink-lab-shipping-print.md)는 재사용 가능성 참고이며 이번 두 작업의 요구사항을 대체하지 않는다.
- 치과/기공소 앱은 별도 저장소이며 이번 제목만으로 앱 범위를 추가하지 않는다.

## 승인 경계와 다음 시작점

- 현재는 소스·공식 문서 확인과 계획 메모 정리만 한다. 제품 변경, 신규 branch/worktree, 제품 checkout/pull, 실행/설치/테스트, Jira/Notion 변경, PR·배포는 승인되지 않았다. 개인 컨텍스트와 Claude 자체 메모리에는 이번 메모를 동기화한다.
- 다음에는 사용자가 고른 항목부터 구체화한다. 5·6번과 데스크톱 인쇄는 탐색 단계이며 당장 조치하지 않을 수 있다. 웹 개선 가능성 확인과 Electron 도입 결정을 분리한다.
- Jira 정리 후보는 주문 쪽 Frankie 하위 DL-17582, 배송 쪽 DL-17583이다. 현재 카드 본문/상태/댓글은 변경하지 않았다. 새 카드나 상위 댓글을 만들지 않는다.

## 사용자 업무 메모 — 2026-11-24

사용자가 전체 목적을 직접 설명했고, 우선 이해한 내용의 브리핑을 요청했다. 번호는 사용자 원문 기준이다.

| 항목 | 목적·검토 내용 | 확정 수준 |
| --- | --- | --- |
| 1 | FE 단독으로 현장 출력의 효율을 높일 업무 목록을 준비하고, 합의된 내용을 메모리·Jira에 정리할 기반을 만든다. | 공통 목적 |
| 2 | 배송 라벨/라벨(부착용) 출력에 날짜·웹주소·경로·페이지 수가 붙는 현상: 코드 제어 가능 여부, 프린트 설정과 현장 운영 방법 확인. | 현상은 사용자 보고, 실물 재현 전 |
| 3 | 주문 상세의 QR 라벨과 스티커를 한 번의 프린트로 함께 출력하고 싶다. | 두 내용을 결합하는 방향으로 이해했으며 배치·용지·매수 미정 |
| 4 | 3번 출력을 주문 목록에서도 이용하도록 확장한다. | 상세 진입 반복을 줄이는 방향, 선택 UI 미정 |
| 5 | QR 스캔 배송의 전체 라벨 생성 후 배송 목록에서 다시 수동 출력하는 과정을 개선한다. 서버의 실제 생성 시간이 있어 요청 직후 링크를 여는 것만으로는 부족하다. | 계속 발전시킬 탐색 과제, 당장 변경 없을 수 있음 |
| 6 | 현재 출력 메뉴→형식 선택→별도 목록 선택 모달 구조를 확인하고, 표 체크박스·병행 작업 패널·선택 항목을 모아두는 영역을 비교한다. 페이지네이션 시 선택 유지가 쟁점이다. | 탐색 과제, 특정 UI 채택 안 함 |
| 추가 | 배송 라벨의 2장 세트를 현장에서는 1장은 작은 용지, 2장은 다른 용지로 프린터를 바꿔 출력한다. 한 화면에서 문서별 크기/프린터를 설정하거나 iframe·미리보기 생략으로 인쇄를 줄일 수 있는지 묻는다. 다운로드가 목적은 아니다. | 사용자 현장 설명, 프린터 모델·실제 용지·OS 미확인 |
| 추가 질문 | 일반 웹의 한계가 있다면 Electron 등 JS 개발자가 구현 가능한 대안과, 웹 배포마다 앱 관리가 필요한지 및 운영 위험을 함께 설명해 달라고 요청했다. | 기술·운영 검토만 승인, 데스크톱 도입/구현 미승인 |

## 확인한 코드와 기술 범위

- 웹 checkout은 `feat/DL-17604@2206940145aaa2f44359217c88ae094e3f0f52a5`, 추적/비추적 변경 없음으로 관측했다. 다른 작업 브랜치를 읽었으며 제품 fetch/pull·checkout·변경·실행은 하지 않았다. 배포 서비스의 현재 코드라고 단정하지 않는다.
- 주문 상세 `lab/src/pages/orders/[order_id]/index.tsx`: `OrderQrLabelButton`(QR 라벨)과 `PrintLabelStickerButtons`(주문 스티커)가 별도다. 주문 목록은 `lab/src/pages/orders/index.tsx`와 `lib/OrderList/useOrderList.tsx`가 출발점이다.
- 배송 목록 `lab/src/pages/shipping/index.tsx`: 행별 라벨/스티커와 상단 `PrintLabelStickerDropdown`이 있다. 별도 선택 모달은 `shared/ui/src/ShippingPickupUI/PrintLabelStickerUI/`에 있으며 `useShippingListInfiniteScroll`의 독립 검색·조회 상태를 사용한다. 메인 표의 현재 필터/선택을 그대로 넘기는 구조는 아니다. 현재 일괄 선택 제한은 라벨10/스티커30건이며 이번에 바꿀 정책으로 확정하지 않았다.
- 출력 페이지 `lab/src/pages/print/index.tsx`: 스티커와 부착용의 용지 설정 적용 경로에는 `@page margin:0`이 있다. 일반 라벨 경로와 조건이 다르다. 보고된 부가 문구는 브라우저 머리글/바닥글일 가능성이 높지만 실제 프린트 설정/실물은 미검증이다.
- 공통 배송 라벨은 `PrintShipmentLabelListItem.tsx`에서 운송장 이미지/PDF와 `PrintShipmentDetails`를 분리된 구성으로 렌더하고, 배송정보 앞에 인쇄 페이지 나눔을 둔다. 기본 목록은 배송당2페이지로 계산한다. 긴 주문서의 실제 페이지 수를 항상2장이라고 보장하지 않는다. 1장 분리 시 기존 인쇄 안내를 어떻게 유지할지도 합의해야 하며 라벨 첫 장과 부착용을 무조건 같은 내용으로 취급하지 않는다.
- QR 스캔 생성 `useShippingScan.ts`: 요청 시 기존 SSE 연결을 켜고 결과는 배송 진행 플로팅에서 처리한다. `useShippingRegister.tsx`에는 기존 완료 신호 이후 상세 재조회/출력창 연결 사례가 있다. 이번 생성 묶음별 완료/실패·준비된 labelUrl 식별에 재사용 가능한지는 미검증이다.
- 일반 웹 `window.print()`는 인쇄 대화상자를 열며 프린터 지정 인자가 없다. 숨겨진 iframe으로 문서별 내용·CSS를 분리해 출력할 수 있으나 프린터 자동 선택·대화상자 생략 권한이 생기지는 않는다. 앱의 미리보기 생략과 브라우저/OS 인쇄창 생략을 구분한다.
- Electron은 화면 렌더러와 별도로 Node.js 기반 main process를 가지며 `getPrintersAsync`와 `webContents.print({silent,deviceName,pageSize,...})`를 제공한다. 한 화면에서 두 문서를 각각 다른 프린터/크기의 두 인쇄 작업으로 보내는 구조를 JS/TS로 구현할 수 있다. 실제 프린터·드라이버·용지 지원 및 인쇄 품질은 별도 실물 검증이 필요하다.
- 검토 방향: 기존 온라인 웹을 Electron에서 열고 제한된 인쇄 기능만 연결하면 일반 웹 UI 변경은 웹 배포로 반영할 수 있다. main/preload·인쇄 연결·Electron 런타임 변경은 앱 패키지 업데이트가 필요하다. 웹 코드까지 앱에 묶는 방식은 웹 변경도 앱 배포 대상이 된다. 어느 방식도 아직 채택하지 않았다.
- 운영 검토 항목: 현장 설치/업데이트·코드 서명, Electron/Chromium 보안 업데이트, 최신 웹과 설치된 인쇄 연결 버전의 호환성, 프린터 이름/드라이버/용지 변경, 인쇄 중 업데이트 방지와 실패분만 재시도, 앱 로그인·장애 시 기존 웹 출력 대안. 자동 업데이트는 별도 제품 BE API 없이 정적 배포 저장소로도 구성 가능한 공식 경로가 있으나 설치/운영 책임은 남는다.
- 대안 후보 QZ Tray: 일반 브라우저와 로컬 인쇄 프로그램을 연결해 프린터별 설정·직접 출력을 지원한다. 별도 설치·신뢰/서명 구성이 필요하며 서버 서명이 권장되어 순수 웹 FE 변경만으로 완성된다고 단정하지 않는다. 아직 도입 비교/선정 안 함.

## 공식 근거와 검증 한계

- [Chrome 인쇄 여백·자동 머리글](https://developer.chrome.com/blog/print-margins?hl=en)
- [MDN window.print](https://developer.mozilla.org/en-US/docs/Web/API/Window/print), [숨겨진 iframe 인쇄](https://developer.mozilla.org/en-US/docs/Web/CSS/Guides/Media_queries/Printing)
- [Electron 인쇄 API](https://www.electronjs.org/docs/latest/api/web-contents#contentsprintoptions-callback), [프로세스와 기존 웹 래퍼](https://www.electronjs.org/docs/latest/tutorial/process-model)
- [Electron 자동 업데이트](https://www.electronjs.org/docs/latest/tutorial/updates), [보안](https://www.electronjs.org/docs/latest/tutorial/security), [코드 서명](https://www.electronjs.org/docs/latest/tutorial/code-signing)
- [QZ 프린터 설정](https://qz.io/api/qz.configs), [서명](https://qz.io/docs/signing)
- 코드 정적 확인과 공식 문서 조사만 수행했다. 브라우저 인쇄·장치 실행·실물 출력·프로토타입 검증·설치/배포는 하지 않았다.
