# Dentlink Lab Shipping Print UX — DL-17101

## Current checkpoint — 2026-10-30 common label/sticker restored; attachment-only settings; PR 4805 ready

- **사용자 최종 변경 승인:** 기존 라벨·스티커는 모든 기공소가 공통 사용하고, INTERNAL에만 `라벨(부착용)`을 마지막 컬럼/일괄 메뉴로 추가한다. 배송용 라벨·배송용 주문서 분리는 종료하고 기존 통합 라벨(운송장 + 인쇄 안내 + Order List)로 복원한다. 새 설정 패널·실시간 미리보기·확장 출력창은 명시적 INTERNAL 부착용에만 적용한다. 아래 3종 분리/3종 설정·유지 결정은 이전 이력이며 이 최종 합의가 우선한다.
- 원본 `/Users/parkjongsun/Repository/dentlink-client-dl-17101`: `feature/DL-17101@a7aa540a268d63b5d9fafc13e4b3d7f85d499c1b`, 정상 커밋·푸시 완료·origin 일치·clean. origin/master 대비0 behind/5 ahead이며 원본에 추가 커밋만 누적했고 develop을 섞지 않았다.
- 배포 `/Users/parkjongsun/Repository/dentlink-client-dl-17101-develop`: 최신 `origin/develop@61da80eaee3d272216e7784b00806007e36b3b56`에서 새 `feature/DL-17101-common-print-develop@46bb74fd65dc7409be5541e15d625f48108c9d28`를 만들고 이번 원본 커밋만 cherry-pick·푸시했다. 이전 배포 브랜치 `feature/DL-17101-print-settings-develop@9e64614a8` 등과 원본 worktree는 보존했다.
- [PR #4805](https://github.com/Innvoaid/dentlink-client/pull/4805): develop 대상, OPEN·non-draft·MERGEABLE·미병합을 생성 후 조회 확인했다. 열린 DL-17101 PR은 이것 하나다. PR4802는 이미 develop 병합된 이전 이력이다. 이번 병합·배포는 사용자가 진행하며 CI/CodeRabbit 완료 또는 실제 배포 성공으로 보고하지 않는다.
- 변경16파일의 내용 및 patch-id `00e15bd1cd1d49bef0494acbe2ccd0ff44458268`가 원본/배포에서 일치한다. 배송/주문 상세 스티커를 복원했고 해당 주문 상세·배송 주문정보 파일은 origin/master와 동일하다. PRE_DELIVERY 재시도는 공통 라벨 한 곳에 유지한다. 기존 SHIPPING/ORDER_SHEET URL은 공통 라벨로 열리며 형식 전환 메뉴는 제거했다.
- 배송 수정 후 자동창은 기존 조건/SSE를 유지하고 기본 공통 라벨을 연다. 배송 업무/API/주문 상태/라벨10건·스티커30건 제한은 유지했다. 기존 qs 파싱 기본 한계 때문에 스티커22~30건이 배열로 복원되지 않는 문제를 `arrayLimit:30`으로 보정했고 실제 PrintPage 테스트로 확인했다. 공통 일괄 라벨의 exportTradeCodes 미전달은 master의 기존 제한 그대로이며 코드 안내 줄을 별도 개선하지 않았다.
- 저장값: 부착용 `shipmentPrintSettings:ATTACHMENT`만 신규 UI에서 사용한다. 과거 SHIPPING/ORDER_SHEET 키는 삭제하지 않고 공통 라벨에 적용하지 않는다. 스티커는 기존 `stickerProperties`·기존 크기 설정/계산을 유지한다. 브라우저·프로필·origin 기준 저장이며 계정별/PC간 공유는 아니다.
- **최종 코드 검증:** 양쪽 focused6 suites/120tests(신규38 + 기존82), Clinic·Lab·Admin 타입, 정상 push훅 lint/Admin guard9/shared coverage 모두 통과했다. 독립 source/delivery 리뷰 finding없음, E2E NO_IMPACT mark/check 완료. develop에 가드스크립트가 없어 원본의 동일 스크립트를 배포 cwd에서 실행했다. 실제 E2E/배송변경 요청은 하지 않았다.
- **Chrome 로컬:** 실제 INTERNAL 배송 목록 컬럼/일괄 메뉴 `라벨 → 스티커 → 라벨(부착용)`, 부착용에서 공통 라벨로 선택 전환 시 형식/체크박스 초기화, 실제2건 일괄 URL·출력 확인. 부착용 설정 패널·즉시 회전·취소 복원, 스티커 기존50×25mm/100% 크기 설정, 배송 상세 공통+부착용/주문별 스티커, 주문 상세 스티커, 과거 SHIPPING URL의 통합 라벨 호환을 확인했다. 사용자 저장값은 변경하지 않았다.
- **native 인쇄 미리보기:** 부착용2건=2장(운송장만), 공통 라벨2건=4장(운송장·Order List 및 기존 인쇄 안내)을 확인하고 취소했다. 실물 출력/비INTERNAL 실제 계정/긴 주문서 실제 데이터/자동배송수정 전체흐름은 미검증이다. 배포 checkout은 브라우저를 따로 실행하지 않고 파일동일성·타입·테스트로 검증했다.
- 이번 후속 수정의 locale JSON diff는0이며 기존 키만 사용했다. audit 기존누락1키, export missing1781/stale2/conflicts3, check10파일 stale를 재확인했다. 동시편집 중단 미확보·기존 충돌 때문에 시트 쓰기/강제 생성은 하지 않았고 기존 번역 보류는 유지한다.
- 하위 DL-17101 설명을 최종 정의로 교체하고 댓글44725에 결과·PR·남은 실물 확인을 기록했다. 상태 Ready for Deploy 유지. 상위 DL-17099 수정·댓글 없음.
- 검증 서버 PID11691/11685의 cwd가 원본 `/lab`·port3005임을 확인 후 종료했고 부모11677/3005 listener도 없음을 확인했다. 검증 탭4개만 닫고 사용자 Figma 탭은 유지했다. 제품 두 worktree는 origin 일치·clean이며 원본·이전 배포·새 배포 브랜치 및 기존 ignored env를 유지했다. env값 조회/변경은 없었다. 로그 `/tmp/dl17101-common-label-*`는 임시 증거이므로 후속 시 현재 코드와 일치를 재확인한다.
- **다음 시작점:** 사용자 PR4805 리뷰·병합·개발서버 배포/실물 프린터 피드백을 기다린다. 추가 구현·공용 설정 적용·번역 시트·CI/배포 감시·CodeRabbit 대응은 자동으로 재개하지 않는다.

## Previous checkpoint — 2026-10-30 three-format implementation before the final scope change

- **최종 결정: 추가 수정 없이 현재 구현 유지.** 사용자가 일반적인 출력 UX 접근과 기존 대비 방향성을 확인한 뒤 “실제 프린터로 확인해보고 문제 있으면 다시 말할게”라고 확정했다. 현재 검토 범위에서 필수 추가 수정이나 전면 재설계 필요사항은 확인되지 않았다. 프리셋·고급 설정 분리는 선택적인 개선 후보이며 구현 요구/필수 후속 작업으로 전환하지 않는다. 실물 프린터 검증은 아직 완료되지 않았고 사용자의 결과/문제 전달을 기다린다.
- **공통 설정 패널·실시간 미리보기 검토 종료, 구현 보류.** 사용자가 기존 결과가 의도대로임을 확인한 뒤 다른 기공소에도 설정/미리보기 UX만 공통 적용할 수 있는지 읽기 전용 검토를 요청했다. 검토 후 “더 진행은 하지 않아도 되니 정리하고 메모리 … 대기”로 확정했다. 공통 적용 또는 기존 구현의 추가 개선·변경을 사용자가 다시 요청할 때만 재개한다. 추가 조사·구현·테스트·서버 시작·자동 감시는 하지 않는다.
- 기존 자체기공소 구현은 사용자 최종 로컬 확인 완료 상태를 유지한다. 이번 후속 검토/종료에서는 제품 코드·브랜치·PR·Jira·배포를 변경하지 않았다. 아래 구현/병합/QA 증거는 앞선 완료 작업의 기록이며 이번에 재검증한 것으로 해석하지 않는다.
- [PR #4802](https://github.com/Innvoaid/dentlink-client/pull/4802)는 **2026-10-30 00:22:59 KST develop 병합 완료**(GitHub read-back, merge SHA `61da80eaee3d272216e7784b00806007e36b3b56`). 사용자 확인과 별도로 병합을 실조회했다. 개발서버 배포 결과·실물 출력 완료로 확대 해석하지 않는다.
- 원본 `/Users/parkjongsun/Repository/dentlink-client-dl-17101`: `feature/DL-17101@3132e836fb3d9e2997aa2251a89162ed7d45d54e`, origin 일치·clean. origin/master 대비0 behind/4 ahead. 메인 master 및 이전 배포 브랜치는 보존했다.
- 배포 `/Users/parkjongsun/Repository/dentlink-client-dl-17101-develop`: `feature/DL-17101-print-settings-develop@9e64614a88483113a97156facba4c155910739aa`, origin 일치·clean. 최신 추가 패치13파일의 patch-id `701f73a1044925ea455e32a63dacc383c559b2f4`가 원본과 일치하고 배포 변경18파일 내용도 동일하다. 두 worktree와 원본 branch를 함께 유지한다.
- 사용자 목적은 여러 프린터 환경에서 사용자가 원하는 용지/크기/회전/배치를 **출력물 3종별로 독립 저장**할 기반이다. 프린터 자동 선택·서버/다른 PC 동기화는 없다. 같은 origin/브라우저의 같은 형식 창에는 저장값이 공유된다.
- v3 설정은 가로 left/center/right, 세로 top/center/bottom을 추가한다. 새 기본은 가로 가운데·세로 위이며, 기존 v2/무버전 저장값은 left/top으로 읽기 이행해 종전 위치를 보존한다. 자동 저장 덮어쓰기는 없다. 정렬 후 signed offset을 적용하며 회전·배율·안내 공간을 계산에 반영한다.
- 설정 UI는360px 우측 패널(640px 이하 하단50dvh)이며 유효 입력을 즉시 옆의 미리보기에 반영한다. 저장 때만 보존하고 취소/닫기/Esc/형식 전환 때 임시값을 해제한다. 화면에 맞춘 축소는 인쇄 때 제거하며 실제 용지/콘텐츠 치수를 바꾸지 않는다. 배송 안내는 용지 가로 가운데에 두고 운송장은 선택한 정렬로 배치한다. 주문서 원본 캔버스의 내부 여백·내용은 자동으로 잘라내지 않는다.
- 새 INTERNAL LABEL 출력창은 단건·일괄·배송수정 자동창에 공통 helper로 적용한다. 부모 내부 영역/화면 가용치의90%, 최대 요청1200×900, 부모 중심 배치이며 다른 기공소·스티커는 기존800×600을 유지한다. window.open은 콘텐츠치수를 받으므로 outer가 아닌 innerWidth/innerHeight를 기준으로 보완했다. URL·배송업무·API·자동창조건·SSE 변경 없음.
- **최종 원본 Chrome 확인:** 가로·세로 가운데의 동등 여백(가로70% 배율 등), 회전·배율 즉시 미리보기, 취소 복원, 빈 너비 저장 차단, 저장 후 reload/새 창 유지, 형식별 독립 설정.800px 우측패널/600px 하단패널 확인 후 viewport override 해제. 배송 안내/라벨의 중심490.498px 일치 확인.
- **최종 native 인쇄 미리보기:** 부착용·배송용·주문서 각각1건=1장 및2건=2장 확인. 배송용 안내 포함, 주문서90°회전, 편집 중 임시 미리보기의 인쇄 축소 해제 확인. 일괄 URL은 배송목록 실제 두 링크로 구성했으며 이번에 목록 선택 UI를 재검증한 것은 아니다. 실제 종이 인쇄/배송 수정 API 요청은 실행하지 않았다.
- 목록 버튼으로 최종 새 창을 실제 열어 본 페이지 outer2056×1290보다 작은 outer1200×966(콘텐츠1200×843)을 확인했다. 브라우저 창틀/정책에 따라 실제 치수는 다르다. 이전 전달 시 사용자 기존 출력창을 원래 부착용 단건 URL로 복원하고 확인용 탭1025191265를 유지했으나, 이번 종료 점검에서 브라우저 도구에 남은 탭은0개였다. 별도 브라우저 탭 닫기는 실행하지 않았다. 스크린샷 `/tmp/dl17101-alignment-preview.png`.
- 사용자 부착용 저장값210×297mm·여백10·100%·270°·이동0은 유지하고 가로 가운데/세로 위를 UI에서 저장해 확인했다. 배송용/주문서 임시 회전·정렬 변경은 취소하여 기존각A4·여백10·100%·0°·이동0·left/top 저장값을 보존했다.
- 원본/배포 Clinic·Lab·Admin 타입 검사, 모델·배치 Jest82개, 양쪽 정상 push훅 lint·Admin가드·공유테스트/coverage 통과(기존 경고 유지). 독립 리뷰에서 추가 회귀 finding없음. E2E NO_IMPACT, 원본/배포 mark/check 통과, E2E실행없음. 검증로그 `/tmp/dl17101-alignment-*`.
- 하위 DL-17101 설명에 정렬·미리보기·창확대 정의를 추가했고 댓글44709에 사용자 관찰 결과/PR/남은 확인을 기록했다. 종료 시 하위 상태는 Ready for Deploy 그대로였으며 임의로 완료 전환하지 않았다. 댓글44710에 사용자 확인·develop 병합·작업 종료를 추가 기록했다. 상위 DL-17099는 수정/댓글 없음.
- 종료 직전 localhost3005 PID76183/부모76177 cwd 원본 `/lab`을 확인한 뒤 SIGTERM으로 종료했다. 두 프로세스와 상위76158 종료,3005 listener없음을 재확인했다. 협업 에이전트3개도 모두 completed이며 진행 작업은 없다. env 상속의 공통 Local Env Inheritance 지침은 이미 정리되어 이번에 재변경하지 않았다. 실제 env값 열람/변경 없음.
- **별도 후속 범위(자동 재개하지 않음):** PR 병합은 완료, 배포 결과와 실제 라벨/A4 프린터 드라이버/용지/인쇄 불가여백, 배송수정/SSE 전체흐름, 비INTERNAL 실제계정, 긴 주문서 실제다페이지 데이터. 배포 checkout의 별도 브라우저 실행 대신 소스와파일동일성/타입·테스트 확인. 번역 시트 동기화·PM 검토는 아래 보류 조건 유지.
- 공통 적용 검토 종료 시 원본/배포 worktree의 위 HEAD·branch·clean 및 기록된 upstream 일치를 읽기 전용으로 재확인했다. 종료 점검 자체에서는 fetch/pull을 하지 않았으며 3005 LISTEN 프로세스도 없었다. 협업 검토 작업은 완료했고 worktree/branch는 보존했다.

## Read-only common settings and live-preview review — 2026-10-30, not implemented

- **사용자 의도:** 출력물 구성은 현재 `labType` 분기를 유지한다(INTERNAL 3종, 다른 기공소 기존 통합 라벨·스티커). 현재 설정 패널과 실시간 미리보기의 사용 방식이 좋아 보여 다른 기공소에도 적용할 수 있는지 영향만 검토했다. 공통 적용을 확정하거나 구현 승인한 것은 아니다.
- **확인/제안:** 같은 Lab `/print` 페이지의 패널 배치·저장/취소·유효 임시값 미리보기·화면 전용 축소를 재사용할 수 있다. 현재 에디터는 INTERNAL 3형식/용지 모델에 결합되어 있으므로 단순 `labType` 조건 제거로 끝나지 않는다. 출력물별 설정 항목과 출력 계산은 유지하는 접근을 추천했다. 기존 목록·상세·일괄 메뉴, 배송 처리/API/SSE 조건을 바꿀 필요는 없다.
- **기존 통합 라벨:** 운송장·안내문구·주문서의 구성을 유지해야 한다. `PrintShipmentLabelList`는 현재 `labelFormat`이 있을 때만 설정을 전달하고, 주문서는 설정이 없으면 인쇄 시 연속 문서의 브라우저 페이지 나눔을 사용한다. 공통 적용 시 여러 페이지의 설정 적용·페이지 나눔·안내문구·잘림을 검증해야 한다. 일반 라벨 설정은 INTERNAL 3종과 별도 저장 범위가 필요하다.
- **기존 스티커:** `PrintSizeEdit`의 너비/높이는 용지가 아니라 생성 HTML 표 크기다. 기존 표/글꼴 배율 계산, 0/90도 회전, 페이지 나눔, `stickerProperties` 저장값을 보존한 채 패널·임시 미리보기를 연결할 수 있다. 신규 용지/여백/정렬 계산을 그대로 적용하면 기존 출력 치수가 달라진다. 모든 신규 설정 항목을 스티커에 도입하는 것은 별도 설계/호환 검토 범위다.
- **저장 경계 재확인:** `shipmentPrintSettings:ATTACHMENT`, `shipmentPrintSettings:SHIPPING`, `shipmentPrintSettings:ORDER_SHEET`가 각각 독립 localStorage 키다. 저장은 브라우저·프로필·origin 기준이며 계정별이 아니다. 같은 환경에서 계정이 달라도 같은 형식 설정을 사용하고 PC/다른 브라우저/다른 origin과 자동 공유하지 않는다. 기존 스티커 키와 혼합하지 않는다.
- **영향/검증 후보:** Lab 배송 단건·일괄·배송 상세·주문 상세에서 연결된 출력 화면, 작은 출력창의 패널/미리보기 공간, 기존 저장값 유지 및 저장/취소/재진입, 긴 통합 라벨의 페이지 수·안내문구, 스티커 크기·회전·글꼴을 확인한다. 화면 미리보기 축소가 실제 인쇄 배율로 적용되지 않아야 한다. 별도 QR/Order 출력, Clinic/Admin 출력은 이번 검토 범위 밖이다. 난이도는 중간 수준의 정성 판단이며 일정/SP 추정이나 런타임 검증 완료가 아니다.
- 현재 코드를 읽고 독립 스티커 검토를 합쳤다. 서버/브라우저 실행·테스트·제품 수정·Jira/PR 변경은 하지 않았다. 사용자 재개 요청 전에는 위 후보를 실행하지 않는다.

## Design approach discussion — 2026-10-30, no additional implementation

- 사용자는 외부 지침 없이 PDF/이미지의 크기·회전·배치를 조절하고 출력물별로 저장하는 접근을 선택한 것이 일반적인 제품 관점에서도 타당한지 질문했다. 작은 라벨 프린터와 A4 장비를 함께 쓰고 규격을 고정하지 않는 확인된 요구에 맞는 접근으로 평가했다. 기존 정해진 출력 방식에 목적별 분리·사용자 환경 조정·저장/미리보기를 더한 것이며, 업무 로직을 유지한 범위도 적절하다고 설명했다. 이 평가는 모든 실제 장비에서의 정상 출력 보장이 아니다.
- 실제 사례를 공식 문서로 확인했다: [Adobe Acrobat](https://helpx.adobe.com/in/acrobat/kb/scale-or-resize-printed-pages.html)은 용지 맞춤/사용자 배율, [Shopify](https://help.shopify.com/en/manual/fulfillment/fulfilling-orders/shipping-labels/managing-labels/printing-shipping-documents)는 출력물별 용지 선택/배치, [ShipStation](https://help.shipstation.com/hc/en-us/articles/360026138171-Poor-Quality-or-Misaligned-Labels)은 라벨 형식/해상도와 PC 프린터 설정 일치를 안내한다. 유사한 접근의 사례이며 동일한 UI·자유 조정 범위가 업계의 단일 표준이라는 주장은 하지 않는다.
- 향후 품질 판단은 옵션 수보다 기본값·배율 기준의 명확성·미리보기와 실제 출력의 예측 가능성에 둔다. 프리셋/고급 설정 분리는 사용 피드백에 따른 선택 후보일 뿐 현재 추가하지 않는다. 사용자가 실제 라벨/A4 프린터에서 크기·잘림·글자 가독성·바코드/QR 인식을 확인하고 문제를 전달하면 그 범위만 조사/보완한다. 새 브라우저/실물 검증이나 제품/Git/PR/Jira 변경 없이 논의만 기록했다.

## Previous checkpoint — paper settings (2026-10-29 23:12 KST, superseded)

- **추가 구현·원본/배포용 커밋·푸시·PR 정리 완료, 사용자 병합/배포 및 실물 QA 대기.** 열린 DL-17101 PR은 [#4802](https://github.com/Innvoaid/dentlink-client/pull/4802) 1개다. 최신 제목은 `[DL-17101] 자체기공소 출력물별 용지·회전·배치 설정`, open/non-draft/unmerged/mergeable이며 develop 대상 2커밋·14파일(+1469/-55). CI 완료나 배포 성공을 뜻하지 않는다. 사용자 요청 없이 병합·배포·추가 구현·반복 감시는 하지 않는다.
- 사용자 최종 목적: 여러 프린터를 사용하는 사람이 자기 환경에 맞는 값을 넣고 **출력물 3종별로 독립 기억하는 기반**이다. 특정 프린터/용지 규격을 고정하거나 프린터 자동 선택/서버 공유 기능을 만드는 것이 아니다.
- 원본 전용 `/Users/parkjongsun/Repository/dentlink-client-dl-17101`: `feature/DL-17101@3a1efad6fbb4ac23fcbd250373fc6667587ab2dc`, origin 일치·clean. `origin/master@57bb759ca` 직계 0 behind/3 ahead. 이후 구현도 이 경로와 원본 브랜치를 사용한다.
- 별도 배포 checkout `/Users/parkjongsun/Repository/dentlink-client-dl-17101-develop`: `feature/DL-17101-print-settings-develop@e34c1b805fa8387feb6eb18a7922a9385ed52adc`, origin 일치·clean. 최신 `origin/develop@9a745cfb2` 위 설정2커밋이다. 새 추가 커밋과 원본 patch-id `cd61b2591f381d33c2afbeeacc1cf33b318c3635` 일치, 14개 변경 파일 내용도 동일하다. 이전 설정 patch-id `6203bc4d50c253f1ffd66117477d35596d4695c4` 일치 기록 유지.
- 이전 배포 `feature/DL-17101-develop@8ee2b9ec7`와 원본·배포 워크트리를 보존한다. 메인 master 및 다른 작업 checkout은 건드리지 않았다. 두 작업 checkout은 수동 Git worktree이므로 명령 cwd를 매번 명시한다.
- 설정 모달에 용지 너비/높이(mm/cm), 상하좌우 공통 여백, 회전0/90/180/270°, 배율1–300%, 가로·세로 signed 이동을 제공한다. mm/cm 변경은 치수·여백·이동값을 함께 환산한다. 기본 새 설정은 A4·여백10mm이나 모두 사용자가 바꿀 수 있다.
- `shipmentPrintSettings:ATTACHMENT/SHIPPING/ORDER_SHEET` 각각 저장한다. 같은 브라우저+origin+같은 형식의 다른 창에는 storage event로 전달되지만 형식끼리 섞이지 않으며 PC/브라우저/서버 계정 동기화는 없다. version2에서 width/height는 **용지 크기**이며 구버전 저장값은 크기·회전·배율 유지, 여백/이동0으로 읽기 변환한다(자동 저장 덮어쓰기 없음).
- 콘텐츠100%는 여백과 배송 안내 공간을 제외한 영역 안에 비율을 유지해 맞춘다. 기본은 왼쪽 위이며 강제 가로 중앙정렬을 제거했다. 회전 내부 중앙 transform은 콘텐츠의 회전 경계를 맞추는 용도다. 용지·여백을 화면에 표시하고 `@page size/margin`과 동일 배치를 인쇄한다. 확대/이동으로 실제 용지 밖으로 벗어나면 화면에서 잘림 경고와 잘린 결과를 보여준다.
- 배송용 안내 문구는 회전하지 않고 같은 용지 안에 폭/높이를 맞춰 확보하며 운송장은 남은 공간을 사용한다. 주문서는 기존 페이지별 내용을 조정한다. 설정 없음/비INTERNAL/스티커/배송 API·업무 규칙은 기존 경로를 유지한다. 실물 프린터·대응 용지·인쇄 배율 선택은 브라우저 대화상자에서 사용자 담당이다.
- 원본·배포 반영 코드 Clinic/Lab/Admin 타입 검사 통과, 설정/레이아웃 Jest **56개** 통과. 양쪽 정상 push 훅의 lint·Admin DLOS 가드·공유 테스트/coverage 통과(기존 lint 경고 유지, 훅 우회 없음). 독립 코드 리뷰 지적1건(print display:block이 비INTERNAL까지 적용)은 설정 있는 INTERNAL에만 제한해 반영했다.
- 최종 원본 Chrome: 기존 A4210×297mm·100%·270° 부착용은 **1장**(기존2장 밀림 해소), 이미지 왼쪽 위 좌표=용지 원점 확인. 100×150mm·여백3mm·80%·90°·X2/Y3mm, cm 환산/새로고침 저장 유지,150% 확대 잘림 경고를 확인했다. 배송용 안내 포함1장,90°회전 주문서1장, 3형식 각2건=각2장 native 인쇄 미리보기 확인. 일괄 검증 URL은 배송목록의 실제 두 링크에서 구성했으며 목록 선택 UI를 이번에 재검증한 것은 아니다.
- 사용자 원래 부착용 값은 이 재개 시210×297mm·100%·270°였으며 최종 해당값+여백0/이동0으로 복원했다. 배송용과 주문서는 새 기본 A4·여백10·100%·0°·이동0 설정을 저장해 확인했다. 다른 창으로 옮겨도 형식별 설정을 유지했다. 임시 일괄검증 탭만 닫고 사용자 기존 부착용 출력창과 배송목록을 유지했다.
- localhost:3005 PID76183 cwd는 원본 `/lab`임을 최종 재확인했고 서버를 유지했다. 설정 UI 증거 `/tmp/dl17101-paper-settings.png`; 타입/테스트/commit/push/i18n 로그 `/tmp/dl17101-paper-*`. 임시 로그 존재와 코드 일치는 재개 시 확인한다.
- E2E 가드 `NO_IMPACT`: 04_labShipment/05_labStatus/원본08_orderFeedback helper의 locator·API 대기·업무 단계 계약 보존. 원본 mark/커밋 후 check, 배포 mark/열린 PR push check 통과. E2E 수정·실행은 없으며 브라우저 인쇄 증거와 구분한다.
- 하위 [DL-17101](https://innovaid.atlassian.net/browse/DL-17101) 설명의 설정 범위를 최종 목적/용지 기준으로 갱신하고 댓글 **44708**에 PR·검증·남은 범위를 기록했다. **Ready for Deploy** 유지 및 설명 read-back 일치 확인. 상위 DL-17099는 수정/댓글 없음.
- **남은 확인:** 실제 라벨/A4 프린터의 용지 지원·인쇄 불가 여백/드라이버 설정, 배송 수정부터 SSE 자동창까지 전체 흐름, 비INTERNAL 실제 계정 런타임, 대량 행 주문서의 실제 다페이지 데이터. 배포 checkout 별도 서버 런타임은 실행하지 않았고 파일 동일성·타입/테스트로 확인했다. 운영 번역 시트 동기화/PM 검토는 아래 조건으로 보류다.
- env 상속 지침은 이미 공통 AGENTS/SESSION_WORKFLOW의 **Local Env Inheritance** 및 전역 ~/.codex에 반영·일치 확인했다. 새 세션/워크트리의 승인된 로컬 준비는 메인의 해당 서비스 env를 값 열람 없이 상속하고 기존 대상 보존·Git ignore·실제 cwd/port를 확인한다. 이번 추가 작업은 env/전역 지침을 다시 변경하지 않았다.

## Previous checkpoint — content-size settings (superseded)

- 최초 출력물별 설정은 원본 `2945333b9`/배포 `025919c0a`와 PR4802로 준비했고 회전/저장 테스트27개를 통과했다. 이때 width/height는 콘텐츠 영역이었으며 A4100%에서 실제 여백 때문에2장으로 나뉘었다. 현재 용지 기준 구현과56개 검증이 이 한계를 대체한다.
- 라벨 세로 원본을 자동90° 정렬하던 기존 화면을0°로 보고 사용자 회전을 합산한다. 이 기준은 현재도 유지된다. 샘플 PDF는270°가 정방향이며 다른 원본의 방향을 강제로 정방향이라 보장하지 않는다.

## Local environment decision

- 새 원본 워크트리에 env가 없어 로그인 요청이 localhost로 향했던 것을 확인했다. 비밀번호 표시의 기존 `sharedUi.password.show/hide/clear` 번역 누락은 별도 표시 문제다.
- 사용자가 현재와 앞으로 새 세션/워크트리의 로컬 준비 시 **메인 워크트리의 해당 서비스 env를 그대로 상속**하도록 명시 승인했다. 메인 Lab `.env.local`·`.env.development`를 값 조회/노출 없이 복사했고 Git ignore를 확인했다. 값 변경·문서 기록·GitHub Variables/Secrets 변경 허가는 아니다. SESSION_WORKFLOW.md에 이 원칙을 반영했다.
- source Lab에서3005 서버를 재시작했고 로그인 페이지HTTP200 확인 후 사용자가 실제 로그인해 출력 화면을 열었다. 이후 에이전트는 로그인된 로컬 출력 화면에서 회전 문제를 검증했다. 서버 재개 시 해당 cwd/port를 다시 확인하며 비밀값을 조회하지 않는다.

## Previous delivery — print separation

- 원본 `ee59a7e2a`, 이전 배포 `8ee2b9ec7`, [PR #4801](https://github.com/Innvoaid/dentlink-client/pull/4801)은2026-10-29 17:58:21 KST에 develop으로 병합됐다. merge SHA `9a745cfb2`,19파일(+412/-148). 원본·반영 patch-id `66016ba691ee96fd21576e4c2b2af0720ec7c8b2` 일치.
- 사용자가 개발서버 배포를 진행했다고 전달했다. 에이전트는 병합만 실조회했고 배포 결과·서빙 revision·배포 후 QA는 확인하지 않았다. 하위 댓글44705/44706에 기록했다.
- 이후 사용자 요청으로 원본 브랜치를 전용 워크트리로 옮기고 메인 checkout을 master로 돌렸다. 분리 당시 실행 환경이 없었지만 이후 위 명시 승인으로 env 상속/의존성 준비를 완료했다.

## Confirmed behavior — original print separation


- INTERNAL 배송 목록의 기존 라벨·스티커를 `라벨(부착용)`, `라벨(배송용)`, `주문서(배송용)` 3열로 바꾸고 상단 일괄 출력 메뉴와 배송 상세 상단에도 같은 선택지를 제공한다.
- 부착용은 운송장 이미지/PDF만, 배송용은 운송장과 기존 인쇄 전용 수출신고 안내, 주문서용은 기존 Order List만 출력한다.
- 기존 `printType=LABEL/STICKER`와 URL/API 구조를 유지하고 INTERNAL LABEL에만 optional `labelFormat=ATTACHMENT/SHIPPING/ORDER_SHEET`를 추가했다. 출력창에서 같은 창의 메뉴로 바꾸며 URL에 선택이 남는다. 다른 타입은 format을 무시하여 기존 통합 라벨·스티커 동작을 유지한다.
- INTERNAL 배송 상세의 주문별 스티커, 주문 상세의 기존 스티커만 숨긴다. 주문 상세의 별도 QR `라벨 출력`과 `Order` 출력은 유지한다.
- 배송 주문 구성 수정 후 자동 출력창을 여는 기존 SSE 조건을 유지한다. INTERNAL 기본은 부착용이고 새 라벨 안내 및 3종 전환을 제공한다. 화면 선택에 필요한 기존 exportTradeCodes를 INTERNAL 경로에만 전달했다.
- LABEL 최대10건/STICKER 최대30건, labelUrl 필수, CREATING_WAYBILL 비활성화, PRE_DELIVERY 재시도 조건을 유지한다. INTERNAL 재시도는 첫 열/상세 상단에 한 번만 노출한다.
- INTERNAL 출력에서는 QA·TanStack 개발 버튼이 종이에 찍히지 않게 인쇄 CSS로 숨겼다. 출력 메뉴는 PopupMenu customToggleUI를 사용해 실제 800px 팝업에서 정렬을 확인했다.

## Verification — original print separation only


- 원본 commit 훅과 별도 배포 checkout에서 Clinic·Lab·Admin 타입 검사 통과. 양쪽 push 전 lint·test·coverage 검사도 통과했으며 기존 경고는 남아 있다. 배포 checkout의 누락된 Next 타입 선언/Husky 설치/coverage 기준선을 정상 생성한 뒤 검사했다. coverage 기준선은 실제 미변경 origin/develop에서 생성했으며 훅을 우회하지 않았다.
- 배포 diff 독립 리뷰 결과 원본 19파일과 동일하고 develop 인접 코드와 충돌하지 않는다. E2E 영향 가드 **NO_IMPACT**: 04_labShipment·05_labStatus·08_orderFeedback의 locator·경로·API 대기·업무 단계 계약을 유지한다. E2E 수정·실행은 없으며 PR 직전 guard check 통과. 배포 checkout의 별도 브라우저 런타임은 실행하지 않았고 아래 런타임 증거는 최종 원본 코드 기준이다.
- 최종 Lab TypeScript exit0, 공유 UI를 소비하는 Clinic TypeScript exit0. 변경 파일 ESLint 오류0, 경고13개는 HEAD 원본과 동일. 기존 root/shared Storybook 플러그인 중복 문제로 Lab/shared 검사를 분리했다. Prettier와 git diff --check 통과.
- 저장소 밖 `/tmp` Jest/jsdom 검증 **13개 통과**: 실제 URL 훅·LabelList/Item의 INTERNAL 기본/3형식, 비INTERNAL 기존 URL/통합 문서, 자동출력 플래그, 스티커 URL, 2건 순번, 안내 포함/제외, PDF 분기. API와 이미지/PDF leaf는 mock이며 실제 브라우저 증거와 구분한다.
- Chrome localhost 실제 INTERNAL: 목록3열·일괄3메뉴, 개별 부착용, 각 형식 2건 일괄 열기, 선택 초기화, 11건 선택 시 출력 비활성화(기존 동작), 배송 상세3버튼/스티커 제외, 주문 상세 QR·Order 유지/스티커 제외를 확인했다.
- Chrome native 인쇄 미리보기: 부착용1건=운송장1페이지/안내없음, 부착용2건=운송장2페이지, 배송용2건=기존 통관안내 포함2페이지, 주문서2건=Order List2페이지/첫 빈페이지없음. 최종 부착용과 주문서에서 개발 버튼 미출력도 확인했다. 실제 종이 인쇄는 하지 않았다.
- 출력창 내3종 전환·새로고침 유지 확인. 기존 형식 URL에 isUpdateShipping 플래그를 넣어 INTERNAL 부착용 기본/새 라벨 안내를 확인했다. **실제 배송 수정 요청/SSE 전체 시나리오는 실행하지 않았다.**
- 비INTERNAL 실제 계정 전환/브라우저 실측은 없으며 기존 동작 보존은 diff 리뷰·타입검사·13개 회귀테스트로 확인했다. 동일 계정의 Admin 타입을 바꿔 시험하지 않았다.
- 실행 로그: `/tmp/dl17101-lab-final-types.log`, `/tmp/dl17101-clinic-types.log`, `/tmp/dl17101-eslint-lab.log`, `/tmp/dl17101-eslint-shared-ui.log`, `/tmp/dl-17101-print-regression.log`, `/tmp/dl17101-source-commit.log`, `/tmp/dl17101-source-push.log`, `/tmp/dl17101-delivery-push.log`. 임시 파일이므로 다음 세션에는 존재와 소스 일치를 다시 확인한다.

## Translation pending

- 기존 출력 분리4키와 설정33키(최초12+용지11+정렬/패널10)를 shipping en/ko에 반영했다. 이번 정렬 작업에서 기존 help2개도 수정했다. 신규 설정 문구는 로컬 화면에서 확인했으며 운영 시트는 아직 미동기화다.
- 최신 읽기 전용 export preview: 로컬3377키, missing1781/stale2/conflicts3. 충돌은 labHeadline(ko), readyInHours(en/ko), stale2는 기존 master 삭제가 시트에 남은 것이다.
- audit:i18n은 기존 OFFICE 분기 account.auth.actions.logIn 누락으로 실패했고 이번 신규 누락은 없다. check:i18n은10파일 stale이며 shipping2개에 설정33키와 문구 변경 차이가 있고 나머지8개는 기존 불일치다.
- 운영 가이드의 동시편집 중단 조건을 확보하지 못해 시트 쓰기/전체 덮어쓰기/강제 생성을 하지 않았다. 번역 완료로 보고하지 않는다. 승인 범위37키를 기존 타 작업·PM 문구를 보존하며 동기화할 방법과 편집중단 조건을 다음에 정리한다.

## Resume point

1. 최종 범위는 **공통 라벨·스티커 + INTERNAL 부착용 추가**, 신규 설정은 부착용만이다. 사용자의 후속 요청이 있으면 개인 컨텍스트와 원본 `feature/DL-17101`의 live Git을 갱신하고 전용 cwd에서 시작한다. 과거3종 분리/3종 설정을 현재 요구로 복원하지 않는다.
2. PR #4805는 develop 대상 미병합으로 준비했다. 사용자 리뷰·병합·배포/실물 프린터 결과를 기다리며 요청 없이 PR 병합·배포·CI 반복 조회·CodeRabbit 대응을 하지 않는다. 원본·이전 배포·새 배포 브랜치 및 두 worktree를 유지한다.
3. 로컬 검증 서버/검증 탭은 종료했다. 후속 실행 시 메인의 해당 서비스 env를 값 조회 없이 상속하는 standing authorization을 따르고 기존 대상 env는 보존한다. 실제 라벨/A4 프린터별 용지·인쇄 불가 여백·배율은 미검증이다. 이전3종 사용자QA는 이전 코드의 증거이며 이번2+1 최종 범위의 사용자QA를 대신하지 않는다.
4. 번역 시트는 자동 재개하지 않는다. 사용자가 후속 작업을 요청하고 동시편집·충돌 조건이 해결된 경우 승인 범위 동기화를 진행한다. Jira 기록은DL-17101에만 남기며 상위DL-17099는 수정하지 않는다.

## Session identity


- 공유기공소·밀링센터 세션 `01a18682-0535-7aa3-9d30-9440b0b90a01`, 기존 Mac local 호스트. FE 메인 `01a08f0c-2057-7852-ae8d-0cf950a91fd3`와 분리해 구현한다.
- 코드 변경 범위는 Lab 출력 컴포넌트/훅/배송목록·상세/주문상세, 공용 일괄선택 UI의 optional props, shipping 번역 리소스다. 개인 체크포인트는 제품 저장소에 추가하지 않았다.
