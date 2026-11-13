# 해외 사용자 포털 접속·API 통신 실패 조사

## 현재 체크포인트 — 2026-11-13 1차 조사 완료

- **최신 사용자 범위:** 홈의 모든 API 대응이 아니라 **홈 진입에 필수인 로그인 상태·`user/own`·`employee/own` 관계의 최소 대응만** 정리한다. 정상 대다수 사용자의 리스크 최소화가 우선이다. 비개발자에게 노션으로 공유할 수 있는 짧은 문안이 필요하다. 아래 전체 엣지 케이스 목록은 후순위 참고로 보존하며 현재 범위가 아니다. 구현·노션 게시 완료를 뜻하지 않는다.
- **확인한 것:** 원 제보·개발 논의·연결된 과거 방화벽 사례의 Slack 스레드, 원 제보 첨부 화면 2개, 실제 Clinic PRD Actions 이력, 사건 전후 핵심 코드, 제한된 Datadog RUM 원본을 읽었다. 제품 코드·설정·외부 데이터는 변경하지 않았다.
- **현재 판단:** 데스크톱/병원망의 API 접속 경로 문제가 우선 가설이다. 고객의 모바일 정상 진술과 병원 IT의 해외 사이트 제한 가능성 진술이 이를 지지하지만, 이번 건의 실제 차단 로그·HTTP 상태·실패 코드가 없어 원인은 확정하지 않았다. 자사 BE가 해외 사용자를 차단했다는 증거도 없다.
- **별도로 확인한 FE 문제:** 최초 user/소속 조회 실패가 `Find Your Office / No Office Yet`로 보일 수 있고, State 조회 로딩·실패·정상 빈 결과·검색 불일치가 `No Result`로 보일 수 있다. 코드 경로 확인이며 이번 사건의 실행 재현은 아니다.
- **정상 사용자 영향:** 현재도 user 첫 조회 pending에는 `_app`이 `null`을 반환한다. 실패 상태만 별도로 처리하는 안은 대다수 정상 사용자에게 새 전역 대기를 추가하는 것과 다르다. `isFetching`이나 `!activeEmployee`로 전역을 막는 안은 정상 refetch·미소속·승인대기 사용자까지 막을 수 있어 구분한다.
- **관측:** RUM init은 user API와 독립, RUM `setUser`는 user/activeEmployee 결과에 의존한다. 해당 회원 ID 필터의 마지막 기록이 11/3이라는 진술은 한정된 원본 조회로 뒷받침했다. RUM 전체 미수집·API 서버 미도달을 증명한 것은 아니다.
- **남은 것:** 사건의 정확한 시간대·PC/모바일 연결망, 브라우저 Network/Console, ALB/WAF 등 계층별 로그, 리플레이 직접 열람. Amplitude는 인앱 브라우저 로그인 화면까지만 접근됐다. 지속 열람에는 Amplitude 직접 커넥터(MCP) 연결을 먼저 제안하며 우회 로그인·고객 계정 재로그인은 하지 않았다.
- **다음 시작점:** 아래의 최소 추가 자료로 가설을 좁힌다. 사용자가 이 조사 세션에서 이어 질문한다. 구현·네트워크 변경·재현 실험·외부 메시지·모니터링은 수행하지 않았으며 자동으로 시작하지 않는다. 별개 앱 주문상세 403 사건과 동일 원인으로 묶지 않는다.

## 비개발자 공유용 상황별 대응안 — 2026-11-13

### 현재 최소 범위 — 노션 공유용 문안

**홈 진입 오류 최소 대응안**

목적: 홈 진입에 필요한 정보를 받지 못했을 때, ‘소속 병원이 없다’는 잘못된 안내나 끝없는 빈 화면·로딩을 줄인다.

대상은 로그인 상태, 내 계정·소속 목록(`user/own`), 현재 병원의 소속·권한 정보(`employee/own`)다. 화면 판단에 필요한 정보를 확인하며 두 API를 모든 사용자에게 일괄 성공 요구하는 방식으로 바꾸지 않는다.

| 상황 | 최소 조치 |
| --- | --- |
| 기본 정보가 아직 확인되지 않거나 응답이 오래 걸림 | 확인 중임을 표시하고, 지연이 길어지면 안내와 재시도를 제공한다. 너무 짧은 대기 기준으로 느린 정상 사용자를 실패시키지 않는다. |
| 기본 정보 조회가 실패함 | 소속 없음·승인 대기로 추정하지 않고 ‘홈 정보를 불러오지 못했다’고 안내한다. 단순 통신 실패만으로 강제 로그아웃하지 않는다. |
| 필요한 정보 또는 인증 만료가 확인됨 | 정상 홈·실제 미소속·승인 대기는 기존 흐름을 유지한다. 확인된 인증 만료도 기존 로그인 절차를 따른다. |

FE에서 상태 구분·안내·재시도를 검토할 수 있다. 실제 서버·통신 장애 복구는 **백엔드/인프라 필요**, 기존 응답으로 상태를 구별할 수 없는 부분만 **백엔드 확인 필요**다. 정상 사용자에게 새 전역 대기·강제 새로고침을 추가하지 않는 방향이다. 아직 구현·실행 검증 전 제안이다.

구현 검토 참고: user/own·employee/own은 기존 병렬 흐름을 전제로 한다. 정상 미소속 사용자에게 불필요한 employee/own 성공을 요구하지 않는다. 상위 Auth의 pending→null 접점까지 홈에 한정해 안내가 보이게 해야 하며, 모든 페이지 인증 게이트 제거·employee query enabled 단순 변경은 하지 않는다. 카드별 데이터/로딩, 로그 신설, 캐시·공통 토큰 갱신 구조 개편, State는 이번 최소 범위에서 제외한다. 정상 홈·미소속·승인대기·느린 성공·최초 실패/무응답·복구·기존 만료 처리의 영향 검증이 필요하다.

### 이전 홈 전체 엣지 케이스 후보 — 현재 최소 범위 밖의 참고

목표는 **정상 홈의 기존 이용 흐름을 유지하면서, 문제가 생겼을 때 잘못된 안내·흰 화면·끝없는 로딩을 줄이고 복구 방법을 제공하는 것**이다. 구현·실행 검증 전 제안이며 실제 사건에서 모든 문제가 발생했다는 뜻은 아니다. FE 가능은 백엔드 변경 없이 검토할 수 있다는 의미이며 화면·문구 검토와 검증은 필요하다.

| 어떤 상황인가 | 홈에서 할 수 있는 조치 | 담당·적용 시 주의 |
| --- | --- | --- |
| 홈은 열리지만 백엔드만 오류 또는 무응답 | 확인하지 못한 상태를 ‘소속 없음’으로 표시하지 않고 조회 실패·재시도를 안내한다. 원인 불명이면 인터넷 단절로 단정하지 않는다. | **FE 가능.** 실제 서버·접속 경로 복구는 **백엔드/인프라 필요**. |
| 응답 없이 계속 기다리거나 연결이 매우 느림 | 충분히 기다린 뒤 지연 안내와 복구 수단을 제공한다. 요청에도 적절한 한도를 두되 늦게 정상 응답이 오면 정상 화면으로 회복한다. | **FE 가능.** 안내와 요청 중단 시점을 구분한다. 실제 지연 분포를 보고 기준을 정하며 전역에 짧은 timeout을 넣지 않는다. |
| 사용자·선택 병원·권한이 준비되지 않아 조회가 시작되지 않음 | 준비 중·조회 중·준비 실패·조회 실패를 구분하고 막힌 단계에 맞춰 안내한다. | **FE 검토.** 미시작 요청을 네트워크 timeout으로 오판하거나 임의 소속/권한을 채우지 않는다. |
| 홈을 보던 중 FE 자산·API 모두 추가로 받지 못함 | 이미 실행 중인 홈과 같은 계정·같은 병원의 마지막 정상 내용을 유지하고 갱신 실패를 알린다. 조회가 성공하면 안내를 해제한다. | **FE 가능.** 자동 새로고침으로 현재 화면을 버리지 않는다. 아직 받지 못한 화면 파일·기능까지 동작한다고 보장할 수 없다. |
| 처음부터 홈 화면 파일 자체를 못 받아 실행되지 않음 | 홈 내부 안내도 실행할 수 없다. 배포 자산·CDN·접속 경로와 가능한 별도 장애 안내를 검토한다. | **인프라 보완 필요**, 안내 파일은 FE 협업. 전체 인터넷 단절이면 서버의 별도 안내도 못 받는다. 완전 오프라인 캐시는 별도 설계. |
| 주문·메시지·픽업 등 일부 조회만 실패 | 성공한 부분은 보존하고 실패한 영역에 안내·재시도를 제공한다. 실패를 0건·픽업 없음으로 확정하지 않는다. | **FE 가능.** 현재 전체 로딩을 카드별로 분리하면 정상 표시 순서도 달라져 별도 UI/회귀 검증이 필요하다. |
| 이미 보던 내용의 최신 조회만 실패 | 기존 내용을 유지하되 최신 정보가 아닐 수 있음을 표시한다. | **FE 가능.** 같은 계정·같은 병원에 한정. 만료·권한 상실이 확인되면 기존 정책을 따른다. 과거 데이터를 최신 조회·저장 성공으로 표시하지 않는다. |
| 설정 상태를 못 받거나 실제 데이터가 없음 | 미확인·실패와 정상 0건·미설정을 구분한다. 실패만으로 첫 주문·재설정·가입 안내를 내보내지 않는다. | **FE 가능.** 정상 미소속·승인대기·웰컴·진짜 빈 목록은 보존. 의미가 불명확한 응답만 **백엔드 계약 확인 필요**. |
| 잘못된 응답·화면 표시 오류로 홈이 깨짐 | 필요한 데이터 구조를 확인하고 처리 가능한 오류는 해당 영역의 안내로 전환한다. | **FE 방어 가능**, 실제 응답 계약 위반은 **백엔드 보완 필요**. 정상 optional/null은 허용하며 오류를 빈 정상 목록으로 덮지 않는다. 오류 경계 위치·범위 검증 필요. |
| 로그인 만료·권한 거절과 단순 통신 실패가 섞임 | 확인된 인증/권한 결과는 기존 처리에 따르고, 무응답만으로 강제 로그아웃·소속 해제하지 않는다. | **홈 표현은 FE 검토.** 특수 401/403 처리 보존. 갱신 전체 개편은 별도 공통 작업. 불명확한 오류 의미는 **백엔드 확인 필요**. |
| 병원·계정 변경 중 이전 요청이 늦게 도착하거나 선택 정보 불일치 | 현재 계정·선택 병원에 맞는 결과만 표시하고 이전 요청이 현재 화면을 덮지 않게 한다. 필요한 정보만 다시 확인한다. | **FE 검토.** 전체 저장소/캐시 무조건 삭제 금지. 공통 전환·인증 변경은 별도 회귀 검증, 서버 전환 결과가 모호하면 **백엔드 확인 필요**. |
| 재시도 연타·재연결·탭 복귀로 요청 중복 | 중복 요청·알림을 제한하고 실패한 조회 위주로 복구한다. 성공 후 오류 표시도 해제한다. | **FE 가능.** 기존 Query 복구 동작과 중복 구현하지 않는다. 전역 retry 확대·무한 반복·자동 reload를 피한다. 저장 요청은 조회처럼 자동 반복하지 않는다. |
| 배너·이미지·분석 서비스만 실패 | 대체 이미지 등 해당 부분만 처리한다. 이미 있는 배너 실패 처리와 분석 SDK의 비차단 동작을 유지한다. | **FE 가능.** 분석 도구를 기다리느라 홈을 막지 않는다. |
| 재발 원인을 구별할 기록이 없음 | 기존 수집 도구에 실패 단계·종류·시각 등 최소 기록을 비동기로 남긴다. 반복 제한·민감정보 제외. | **기존 수집 활용은 FE 가능.** 별도 수집 경로는 **인프라 보완 필요**, 서버 로그 연결은 **백엔드·인프라 협의**. 완전 단절 시 전송 불가. |

**최소 리스크 적용 순서:** 먼저 실패/미확인과 실제 없음/0건을 구분하고, 홈 첫 진입 실패·장기 대기에만 안내/수동 재시도를 제공한다. 기존 성공 화면 보존·재시도 중복 방지를 함께 검토한다. 정상 응답에 새 전역 대기·추가 상태확인 API·강제 로그아웃·전체 캐시 삭제를 넣지 않는다. 카드별 표시 순서 변경, 새 렌더 오류 경계, 공통 병원 전환/토큰 갱신 구조 변경, 자동 재시도 확대, 영속 오프라인 캐시는 각각 영향 확인 후 별도 판단한다. 리스크 0이나 모든 흰 화면 방지를 보장하지 않는다.

**필요 검증:** 정상 홈·정상 무소속/승인대기/웰컴·실제 빈 목록, 느린 정상 성공, 최초 실패·무응답·오프라인 대기, 일부 조회 실패·갱신 실패·복구, 계정/병원 전환 중 늦은 응답을 변경 영향에 맞춰 확인한다. 인증/권한 변경 시 관련 역할·세션 경로를 확장한다. 이번에는 정적 조사만 했으며 실패 주입·실제 계정 로그인·실행 QA는 하지 않았다.

### 홈 추가 조사 근거와 한계 — 2026-11-13

- `ls-remote`로 `origin/master=9c4418a8fb4b18cbadb5afb25fa32503b59febae` 재확인. 추가 조사한 Dashboard·관련 hook/query 및 핵심 인증 파일은 사건 인근 PRD `1948696376a92410671ac42ee7c32f4f6e28bdec`와 diff가 없었다. 사건 브라우저 build는 미확인이며 타 작업 checkout을 변경하지 않았다.
- [`_app.tsx:442`](https://github.com/Innvoaid/dentlink-client/blob/9c4418a8fb4b18cbadb5afb25fa32503b59febae/clinic/src/pages/_app.tsx#L442)의 상위 Auth는 user pending에 `null`을 반환한다. 홈 컴포넌트 내부 안내만으로 이 대기는 해결되지 않아 **홈 경로에 한정한 상위 인증 접점** 검토가 필요하다. 인증 확인을 우회해 보호 데이터를 보여주자는 뜻은 아니다.
- [`index.tsx:22`](https://github.com/Innvoaid/dentlink-client/blob/9c4418a8fb4b18cbadb5afb25fa32503b59febae/clinic/src/pages/index.tsx#L22)의 소속 분기는 미확인/실패와 실제 없음 구분이 부족하다. 웰컴 redirect의 미제공 필드 방어는 이미 존재하므로 보존한다.
- [`Dashboard.tsx:173`](https://github.com/Innvoaid/dentlink-client/blob/9c4418a8fb4b18cbadb5afb25fa32503b59febae/clinic/src/components/Dashboard/Dashboard.tsx#L173)는 여러 조회 중 하나라도 로딩이면 전체 skeleton. 설정 응답 부재는 false로 이어질 수 있다. [`useDashboardBubble.ts:88`](https://github.com/Innvoaid/dentlink-client/blob/9c4418a8fb4b18cbadb5afb25fa32503b59febae/clinic/src/lib/Dashboard/useDashboardBubble.ts#L88)는 주문 응답 부재도 0건으로 계산해 첫 주문/샘플 안내에 사용한다. LinkTalk 응답 부재도 count 0, 픽업 오류는 영역 미표시, 카테고리 error 후 undefined는 spinner로 남을 수 있다.
- [`useDashboardLinkTalk.ts:115`](https://github.com/Innvoaid/dentlink-client/blob/9c4418a8fb4b18cbadb5afb25fa32503b59febae/clinic/src/lib/Dashboard/useDashboardLinkTalk.ts#L115)와 주문 query는 직원/권한 등 선행 조건이 없으면 조회·초기화를 시작하지 않는다. pending은 요청 실행 중이라는 증거가 아니며 오프라인 paused도 구분해야 한다. [TanStack network mode](https://tanstack.com/query/latest/docs/framework/react/guides/network-mode)
- 직원 query key에는 직원 ID가 있고 일반 로그아웃은 조회 취소·캐시·atom 정리를 이미 수행한다. 반면 [병원 선택 모달](https://github.com/Innvoaid/dentlink-client/blob/9c4418a8fb4b18cbadb5afb25fa32503b59febae/clinic/src/components/Office/OfficeSelectListModal.tsx#L31)은 서버 성공 전 선택 ID를 반영하며 사용자 query key는 고정이다. 계정 혼선·경합은 정적 위험 후보이지 실제 발생 확인이 아니다. 실제 전송 취소에는 AbortSignal 전달 확인이 필요하다. [TanStack cancellation](https://tanstack.com/query/latest/docs/framework/react/guides/query-cancellation)
- 공통 Axios의 명시적 timeout 없음·query 기본 retry 0을 전역 변경하자는 제안이 아니다. 기존 특수 `403 / code 2131` [소속 전환 처리](https://github.com/Innvoaid/dentlink-client/blob/9c4418a8fb4b18cbadb5afb25fa32503b59febae/clinic/src/lib/OfficeSwitchRequired/officeSwitchRequired.ts#L183)와 인증 갱신 규칙을 보존한다.
- 여러 홈 표시 경로에 row/null 직접 접근이 있으나 실제 malformed 응답은 미확인. 조사한 홈 route/provider에서 명시적 홈 오류 경계는 확인하지 못했다. 오류 경계는 하위 렌더 오류를 처리하며 이벤트·일반 비동기·SSR 전체를 포괄하지 않고 코드 자체 미로딩에는 실행될 수 없다. [React 오류 경계](https://react.dev/reference/react/Component#catching-rendering-errors-with-an-error-boundary)
- 브라우저 online 정보만으로 API 접근을 보장하거나 전체 홈을 잠그지 않는다. [MDN Navigator.onLine](https://developer.mozilla.org/en-US/docs/Web/API/Navigator/onLine). 탭 복귀/재연결은 기존 동작을 우선 재사용한다. [TanStack focus refetch](https://tanstack.com/query/latest/docs/framework/react/guides/window-focus-refetching)
- 배너에는 이미 실패 시 미표시 처리가 있고 Amplitude는 children을 즉시 표시하며 init/replay 오류를 잡는다. 분석 SDK 대기가 홈을 막는 원인으로 단정하지 않는다. 이미지 src 부재 fallback과 다운로드 실패 방어는 별개다.

### 이전 간단안 및 전체 후보 보관 — 로그인·State는 현재 홈 범위 밖

1. 홈에 처음 들어와 필요한 정보를 받는 중에는 불러오는 상태를 표현하고, 아직 확인되지 않은 소속 없음/미승인 화면을 확정해 보여주지 않는다.
2. 요청이 실패하거나 정해진 대기 한도를 넘기면 ‘홈 정보를 불러오지 못했다’는 안내와 다시 시도를 제공한다. 흰 화면·무한 로딩으로 남기지 않는 방향이며 시간 기준·문구·디자인은 미확정이다.
3. 정상 응답이면 기존 홈을 보여준다. 실제 미소속·승인대기는 확인된 응답대로 기존 흐름을 유지한다. 이미 정상 홈을 보던 중 단순 재조회 실패라면 기존 화면을 유지하고 오류를 알린다. 인증 만료·권한 변경 확인은 별도 처리한다.

정상 성공 흐름에 새로운 전역 대기를 추가하지 않고 최초 실패/무응답을 구분하는 검토안이다. 로그인 연결오류 안내, 기존 수집 서비스의 최소 오류기록, 인프라/BE 협의는 별도 항목이며 State는 후순위다. 아래 상세 표는 전체 후보 보관용이다.

사용자 요청에 따라 FE 조치와 인프라·백엔드 협의 사항을 구분했다. **가능한 대응안이며 아직 구현·검증 전이다.** 아래 문구는 설명용 예시이고 확정된 제품 문구가 아니다. “FE 가능”은 백엔드 변경 없이 FE에서 구현을 검토할 수 있다는 뜻이며, 화면·문구 검토와 실행 검증을 생략한다는 뜻이 아니다. 정상 이용 흐름을 유지하고 문제가 발생한 영역을 안내하는 방향이다.

| 상황 | FE에서 가능한 조치 |
| --- | --- |
| 포털에 들어왔지만 병원 정보를 받지 못함 | ‘등록된 병원이 없다’고 표시하지 않고, ‘정보를 불러오지 못했습니다’처럼 조회 실패를 안내하고 다시 시도를 제공한다. 실제 미소속·승인대기는 정상 응답으로 확인됐을 때 기존 안내를 유지한다. |
| State 목록을 열었는데 데이터를 받지 못함 | 아직 불러오는 중인지, 불러오기에 실패했는지, 정상 조회했지만 결과가 없는지를 구분한다. 실패했을 때는 State 항목 안에서 다시 시도할 수 있게 한다. |
| 이미 화면을 보고 있는데 새 정보를 불러오는 데 실패함 | 단순 조회 실패라면 기존 내용을 유지하고 ‘최신 정보를 불러오지 못했다’고 알린다. 로그인 만료·접근 권한 변경이 확인된 경우에는 해당 인증/권한 처리를 따른다. |
| 연결이 느려 오랫동안 로딩만 계속됨 | 충분히 기다린 뒤 지연 안내와 다시 시도를 제공한다. 기다리는 시간과 자동 재시도 횟수에 한도를 두되, 느린 정상 사용자까지 너무 빨리 실패로 분류하지 않도록 기준을 검증한다. |
| 로그인 요청이 통신 문제로 실패함 | 비밀번호가 틀렸다고 단정하지 않고 연결 문제로 안내한다. 사용 중 일시적인 통신 실패도 곧바로 강제 로그아웃 사유로 삼지 않는다. 실제 인증 만료가 확인되면 기존 인증 처리를 따른다. |
| 같은 장애가 다시 발생함 | 기존 Amplitude/RUM 같은 수집 서비스를 활용해 발생 시각·실패한 기능·오류 종류 등 최소한의 진단 정보를 남긴다. 개인정보·로그인 비밀 값은 제외하고 반복 전송을 제한한다. 수집 서비스까지 막히면 이 기록도 전송되지 않을 수 있다. |

**일반 사용자 불편을 줄이는 조건:** 모든 화면을 흰 화면으로 바꾸거나 모든 요청이 끝날 때까지 기다리게 하지 않는다. 정상 성공 흐름에는 추가 대기를 요구하지 않는 방향으로 설계한다. State만 실패하면 State 영역을 안내하고, 단순 재조회 실패는 기존 화면을 유지한다. 처음 접속해 필수 정보를 전혀 받지 못한 경우에는 해당 정보가 필요한 부분에 로딩/오류 안내가 필요하다. 아무것도 모르는 상태에서 정상 화면처럼 꾸며 보여주지 않는다. 저장 요청은 조회처럼 무조건 자동 반복하지 않는다. 정상·지연·실패·복구와 정상 미소속/승인대기 상태의 실행 검증은 구현 이후 필요하다.

| 협의 구분 | 어떤 경우에 필요한가 |
| --- | --- |
| **(인프라·병원 IT 협의 필요)** 실제 연결 복구 | 병원망이나 서버 앞단에서 접속을 막는 경우, 차단 정책·허용 주소·접속 경로 개선을 확인한다. CDN 도입 등은 이 범주의 검토안이며 FE 화면 변경만으로 차단을 해제할 수 없다. |
| **(백엔드 확인·필요시 보완)** 상태와 오류 구분 | 현재 서버 응답만으로 ‘정상 미소속·승인대기’, ‘인증 만료’, ‘조회 실패’를 구분할 수 없는 부분이 있으면 응답 의미를 확인하고 필요한 경우 보완한다. 기존 응답으로 구분 가능하면 백엔드 수정은 불필요하다. 원인이 미확정이어도 FE는 조회 실패 안내를 제공할 수 있다. |
| **(인프라 보완 필요)** 새로운 오류 수집 경로 | 기존 수집 서비스 활용은 FE 후보지만, 그것도 차단돼 별도 수집 경로를 새로 마련해야 하면 인프라 협의가 필요하다. 어떤 경로도 항상 전달된다고 보장할 수는 없다. |
| **(백엔드·인프라 협의 필요, 선택적 강화)** 장애 위치의 정확한 추적 | 브라우저의 실패 기록과 서버 앞단·백엔드 기록을 같은 요청으로 연결하려면 기존 추적 체계의 지원 범위를 확인하고 필요시 보완한다. FE 오류 안내를 먼저 검토하는 데 반드시 선행해야 하는 작업은 아니다. |

기술적 근거와 한계는 아래 1차 조사에 보존한다. 이 정리는 구현·디자인/문구 확정·네트워크 변경·외부 게시 승인이 아니다.

## 조사 세션 등록 — 2026-11-13

- 사용자 요청: 현재 코드와 Slack·관련 링크를 바탕으로 원인 후보, 가능한 서버/인프라·FE 조치, 관측 방법과 부작용을 분석한다. **개발·실제 조치가 아닌 조사 전용**이다.
- 세션: **해외 사용자 포털 접속·API 실패 원인 조사**, `01a1d352-b346-7872-b537-6fe5ffaf4f87`. 메인 프로젝트 `4a13e754-960d-4ca3-b716-8f7a19311b64`, 기존 사무실 Mac `local`에서 운영한다. 메인과 동일한 `gpt-6-astra` / `ultra` 적용과 전달·시작을 1회 확인했다.
- 새 프로젝트 폴더·branch·worktree를 만들지 않는다. 주 대상은 웹 저장소의 읽기 전용 분석이며 관련성 근거가 있을 때만 다른 저장소를 읽는다. 제품 코드·실제 env·외부 데이터·Jira/Slack·PR·배포 변경은 승인되지 않았다. 개인정보·토큰을 기록하지 않는다.
- 메인은 접수·전달·개인 기록만 담당했다. 이후 조사는 새 세션에서 사용자와 직접 진행하며 메인은 자동 추적·폴링하지 않는다.

## 접수 시 출처와 증거 수준 — 이후 확인 결과는 위 체크포인트 참고

- [포털 접속 이슈 Slack](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794356148497849): 메인이 스레드 전체를 읽었다. [연결된 원 제보](https://innovaidhq.slack.com/archives/C063KNZEDBN/p1794319377986159)·리플레이·현재/사건 당시 코드·원본 로그 조사는 새 세션에 맡겼다.
- 사용자 추정은 이미 로그인했던 해외 사용자의 accessToken은 남아 있고 BE API만 차단돼, FE 화면이 실제 승인대기/소속없음처럼 보여 혼란이 생겼다는 것이다. **토큰 유효성, 이번 로그인 성공, 해외 차단, 서버 미도달은 아직 확정 사실이 아니다.**
- Slack에서 Tom은 Amplitude상 로그인 후 랜딩/State 목록 문제를 언급했다. 최근 로그인 일시는 내부 테스트로 갱신됐고, `2026/11/11 09:03:35` 이후 기록은 제외하라고 했다. 그 시각의 시간대와 실제 사건/내부 재현 구분이 필요하다.
- Joy는 RUM 마지막 기록이 11/3이었다고, Leo는 API 로그에도 공백이 있었다고 말했다. 이는 동료의 관측 진술이며 원본 로그 재검증 완료가 아니다. Kyle은 네트워크 실패/서버 미도달 가능성과 STG 유사 재현 가능성을 언급했다.
- Tom의 결론은 “Amplitude는 정상인데 자사 API 지연 원인은 불명확, 실패 상황 대응은 필요”였다. Kyle의 Seoul LB 앞 CloudFront 제안은 검토안이며 효과/적용이 확정되지 않았다. 원문의 “미국에서 해외 서버로 인식하지 않도록”이라는 의도와 CDN 실제 전달 경로·origin 지역·차단 원인을 구분한다.

## 맡긴 조사와 재개 기준

1. 사건 환경·시간·관련 배포 revision·원본 자료를 정리하고, 인증→user/own·employee/own→소속/승인 분기→랜딩 및 State 조회를 실제 호출 체인으로 추적한다. 현재 코드가 사건 당시 코드와 같다고 가정하지 않는다.
2. 확인된 사실/가설/반증 방법을 구분한다. DNS/TLS/네트워크·프록시/보안·WAF/LB, 브라우저 CORS·preflight, timeout, 인증·갱신, FE 분기 등의 후보를 증거에 따라 좁힌다. HTTP 오류와 응답 자체 없는 실패를 구분한다.
3. API 실패를 미승인/빈 결과로 오인하지 않는 FE 대응, 복구/재시도, 서버/인프라 대안을 비교한다. 전역 로딩·흰화면·영구 spinner·과도한 retry 등 정상 사용자에 미치는 영향을 함께 다룬다. 승인 전에 구현하지 않는다.
4. API/FE 자산/Amplitude/RUM의 독립 전달 경로, SDK 초기화·sampling/consent/filter 등의 원인을 코드/공식 자료로 확인한다. 자사 API가 막히면 동일 API 진단 로그도 실패하는 한계와 독립 관측 대안을 검토한다.
5. 필요한 추가 자료/담당자 질문을 정리한다. 실제 사용자 재로그인이나 네트워크 변경으로 사건 로그를 오염시키지 않고, 필요 실험은 제안부터 한다. 결과는 원인 확정 여부와 실패 상황 UX 개선 필요성을 나눠 해당 세션에서 보고한다.

상세 조사 결과와 다음 시작점은 이 문서에 이어 기록하고 Claude 로컬 메모리와 함께 관리한다.

## 1차 조사 근거와 한계

### 사건 자료의 직접 관찰과 동료 진술

| 자료 | 이번 조사에서 확인한 내용 | 해석의 한계 |
| --- | --- | --- |
| [원 제보 스레드](https://innovaidhq.slack.com/archives/C063KNZEDBN/p1794319377986159) | 11/10 23시대 KST 제보에서 전날부터 포털 내용이 보이지 않는다고 전달. 첨부 사진의 주소는 `portal.dentlink.io`, 화면은 `Find Your Office`, `No Office Yet` | 사진으로 실제 login API 성공·token 유효성·어떤 요청의 실패인지 알 수 없음 |
| 같은 스레드 11/12 첨부 대화 | 고객은 모바일에서는 되고 PC에서는 안 된다고 말함. 근무처 IT에서 해외 사이트를 제한하는 경우가 있다는 추정, 평소에는 바로 포털로 들어갔으나 이번 주 월요일 로그인 화면이 나타났다는 경험을 전달 | 모바일 앱/모바일 웹, Wi-Fi/셀룰러, 동일 시각·계정 여부는 확인되지 않음. 고객의 방화벽 추정은 차단 로그가 아님 |
| [개발 논의](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794356148497849) | 내부 로그인 테스트가 정상이고 최근 로그인 시각을 덮었음. `2026/11/11 09:03:35` 이후 로그인 로그를 제외하라는 지시 | Slack 메시지 표시는 KST이나 본문에 적힌 경계 시각 자체의 시간대는 명시되지 않음. 실제 고객의 POST login 성공을 확정할 자료가 아님 |
| 같은 개발 논의 | State `No Result`, API/RUM 공백, 네트워크 이슈 및 STG 유사 재현 가능성을 동료가 언급 | 이 조사에서 당시 HAR·BE/edge 원본 로그·STG 재현 결과는 받지 않음 |
| [과거 치과 방화벽 사례](https://innovaidhq.slack.com/archives/C063KNZEDBN/p1784596186070489) | 해당 스레드에는 치과 보안 업체 allowlist 요청, 이후 접속 가능하다는 고객 확인 전달이 있음 | 다른 치과의 과거 사례. 이번 사건의 차단 제품·정책·해결을 증명하지 않음 |
| Amplitude 공유 링크 | 링크 끝 숫자를 epoch milliseconds로 해석하면 2026-11-09 21:47:44.683 UTC / 11/10 06:47:44.683 KST | replay URL 시간의 의미와 실제 사건 구간은 UI에서 검증하지 못함. 로그인 화면으로 이동해 재생하지 못했음 |

개인 문서에는 고객 이름·회원번호·주문번호·IP·토큰·원본 스크린샷을 복제하지 않는다. 원문이 필요한 경우 위 Slack 링크의 권한 있는 원본에서 확인한다. 원인 확정과 실패 상황 UX 개선 필요성은 별도로 판단한다.

### 코드 revision과 배포 근거

- 제품 checkout `/Users/parkjongsun/Repository/dentlink-client`는 타 작업 `feat/DL-17141-delay-cleanup`, HEAD `a4f70d33c5d4fb61767512530c8783067132d7e7`, 시작·종료 모두 clean이었다. checkout을 변경하는 pull/checkout 대신 `git fetch origin master --no-tags` 및 `git show <SHA>:<path>`로 읽었다. 새 branch/worktree를 만들지 않았다.
- fetch 시 `origin/master`는 `9c4418a8fb4b18cbadb5afb25fa32503b59febae`(11/12 hotfix merge). **master 최신과 실제 Clinic PRD 배포 revision을 동일시하지 않았다.**
- [Clinic PRD run 42592263606](https://github.com/Innvoaid/dentlink-client/actions/runs/42592263606): `prd/clinic/v1.92.0`, SHA `1948696376a92410671ac42ee7c32f4f6e28bdec`. 11/9 18:17:30 KST 시작, Seoul job 18:37:16·Ohio job 18:52:00 success, 전체 18:52:01 success를 Actions API에서 확인했다.
- 직전 [v1.91.0 run](https://github.com/Innvoaid/dentlink-client/actions/runs/41417250873)은 `046c51434756b926ad5fb33f4d5bb0d7b95aeecf`, 11/2 배포 성공 이력이다. 제보의 시작 시점은 배포 전후를 정확히 특정하지 못하므로 이 둘을 비교했다.
- 인증/프로필/활성 소속/홈/State/관련 Axios·Query 설정/RUM·Amplitude의 조사 대상 핵심 파일은 위 두 PRD SHA와 `9c4418a8` 사이 diff가 없었다. 전체 서비스 코드가 동일하다는 의미가 아니다.
- 실제 사건 브라우저가 로드한 build ID/자산 revision, 현 serving revision, 당시 DNS/LB/WAF 설정은 직접 검증하지 못했다. Actions 성공 이력을 실제 고객 브라우저 코드의 증명으로 취급하지 않는다.
- 현재 PRD workflow는 FE를 Seoul·Ohio에 배포하고 정적 자산을 S3에 올리는 구조다. BE LB가 Seoul이라는 내용은 동료 설명이며 AWS 현 설정을 조회하지 않았다. FE·API의 제공 경로가 다를 수 있다는 코드 근거이지, 당시 고객의 DNS 선택·캐시 사용 여부의 증거는 아니다.

### Datadog 원본 조회 범위

Datadog MCP의 `generic` RUM syntax 및 `datadog/code-exec` 스킬을 읽고 read-only `RUMApi.searchRUMEvents`만 사용했다. 원문 payload·고객 식별 정보는 문서에 저장하지 않았다.

| 조회 | 결과 | 한계 |
| --- | --- | --- |
| `service:dentlink-clinic env:production @usr.id:<원 제보 대상>`; 11/1 00:00 UTC~11/10 14:59:59 UTC(11/10 23:59:59 KST); 최신 1건 | 마지막 반환 event는 11/3 14:23:11.580 UTC, resource 200, Chrome Desktop, version 1.90.0 | 이 필터·기간의 최신 event 확인. `hasMore=true`는 그 이전 데이터가 더 있다는 뜻. 전체 수집 부재를 뜻하지 않음. 내부 테스트 경계의 시간대 불확실성을 피해 전날까지만 조회 |
| portal host view; 11/9 21:40~22:10 UTC; 최초 3건 sample | 21:45 시각의 version 1.92.0 view들, 식별 정보가 없는 view도 존재 | 다른 사용자일 수 있으며 대상 고객으로 연결하지 않았음. 전체 수집률 추정 불가 |
| 같은 service/env/portal host, user ID 없는 error; 21:45~22:00 UTC | 0건 | SDK 초기화·수집·event 유형·필터 및 attribution 한계 때문에 네트워크 실패 없음을 뜻하지 않음 |
| 같은 조건의 user ID 없는 view; 21:47~21:50 UTC | 0건 | view timestamp가 세션 시작과 같다고 보장하지 않음. replay 시간 해석도 미확인. 이 결과로 고객 RUM 전체 부재를 확정하지 않음 |

추가 범위 확장·반복 조회는 하지 않았다. BE 앱/ALB/WAF 원본 로그는 이번 조사에서 조회하지 못했으며, 해당 공백에 대한 근거는 동료 진술에 머문다.

## 실제 코드 흐름

아래 코드 링크는 사건 시각의 PRD 후보 `1948696376a92410671ac42ee7c32f4f6e28bdec`에 고정한다.

| 흐름 | 코드 사실·의미 | 근거 |
| --- | --- | --- |
| 로그인·저장값 | `POST /office/auth/login` 성공 callback에서 token/employee ID 저장. token은 storage atom, user/activeEmployee 객체는 메모리 atom. RUM login action은 요청 전 기록이므로 성공 증거가 아님 | [useSigninCommon](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/lib/AuthSignin/useSigninCommon.tsx#L35-L113), [atoms](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/atoms/common.ts#L6-L45) |
| 프로필·활성 소속 | `GET /office/users/own`은 token 존재 시 실행. `GET /office/employee/own`은 `_app`에서 나란히 실행되어 user 성공 후 직렬 호출이 아님 | [user query](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/services/user/hooks/useUserQuery.ts#L7-L16), [Auth 호출](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/pages/_app.tsx#L284-L299) |
| 인증 화면 이탈 | 저장 token이 있으면 `/auth/`에서 새 로그인 성공 없이 이동 가능. 명시적 next가 없으면 user data **또는 error**가 생길 때 기본 랜딩 결정 | [_app NonAuth](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/pages/_app.tsx#L489-L530) |
| 보호 화면 렌더 | `isPending || !accessToken`이면 null. user 오류/성공 여부는 렌더 gate에 없음 | [_app Auth](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/pages/_app.tsx#L440-L444) |
| 소속 없는 홈 | activeEmployee 또는 employee 배열이 있으면 Dashboard, 없으면 DashboardNonEmployee. 데이터 부재의 이유를 분리하지 않음 | [Home](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/pages/index.tsx#L22-L66) |
| 실제 승인대기 | `Find Your Office` 자체는 승인대기 판정이 아님. 소속 item의 employee/employer 상태 값으로 대기 badge를 결정 | [EmployerItem](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/shared/ui/src/EmployerUI/EmployerItem.tsx#L89-L104) |
| My Office | `/office/users/own/employee?type=all` 데이터 부재도 빈 목록으로 처리하여 No Office Yet 가능 | [DashboardNonEmployee](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/components/Dashboard/DashboardNonEmployee.tsx#L30-L35), [filter](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/lib/user/filterAffiliatedEmployeesForDisplay.ts#L32-L36) |
| State | `GET /codes/state-code?countryCode=...`. publicApi도 저장 Authorization/employee-id와 zone-id를 붙일 수 있음. 무인증·preflight 없음으로 해석하면 안 됨 | [code API](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/shared/models/src/code/code.apis.ts#L47-L54), [Axios](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/shared/models/src/common/axiosInstance.ts#L25-L37) |
| State 화면 | hook의 `data?.stateCodes ?? []`, 화면은 query pending/error를 사용하지 않고 options만 전달. Combobox 필터 결과 0이면 No Result | [hook](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/services/code/hooks/useStateCodeQuery.ts#L10-L30), [화면](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/shared/ui/src/OfficeFindUI/OfficeFindStep1Search.tsx#L177-L191), [Combobox](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/shared/dlds/src/components/DropdownUI/ComboboxDropdown.tsx#L350-L355) |

**성립 가능한 경로:** 과거 저장 token 존재 → user/employee 조회 실패 → token 유지 → user pending 종료 → 홈 렌더 → 소속 데이터 없음 → Find Your Office/No Office Yet. 저장 token 보유·유효성·이번 요청 실패는 사건 원본으로 확인되지 않았으므로 이 경로를 확정 재현으로 쓰지 않는다.

- 공통 Axios는 HTTP 401과 특정 application code를 기준으로 token 제거/refresh를 수행한다. 응답 없는 실패는 해당 분기에 들지 않아 token이 유지될 수 있다. 403 중 code 2131은 office-switch 처리로 별도 분기한다. [인터셉터](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/shared/models/src/common/axiosInstance.ts#L48-L154)
- 핵심 Query 기본 retry는 0, 전역 error toast는 `meta.showErrorToast`가 있어야 한다. user/employee/State는 해당 meta가 없다. 핵심 Axios/호출에 명시적 timeout이 없어 지정된 시간 후 반드시 실패로 전환한다는 보장도 없다. [AppProviders](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/components/providers/AppProviders.tsx#L43-L57)
- 핵심 요청은 shared officeApi/publicApi를 사용하므로 clinic legacy fetcher의 수동 `DD_RUM.addError`를 경유하지 않는다. 자동 RUM 네트워크 수집 여부는 별도로 확인해야 한다.
- login 실패의 특수 오류 외 일반 경로는 `Invalid user` 표시여서 통신 실패도 계정 문제로 오해할 가능성이 있다. 이번 화면에서 그 문구가 나타났다는 증거는 없다.
- 정상 미소속 계정의 `/office/employee/own` status/application code 계약은 미확인이다. employee data 부재만으로 승인대기·차단을 분류할 수 없다.

## 전달·관측 경로의 구분

- FE는 HTML·JS·정적 자산, API는 별도 baseURL, Amplitude analytics/replay 및 Datadog은 각 수집 경로를 가진다. Amplitude가 된다고 API도 되거나, 화면이 보인다고 그 순간 FE origin에서 새 파일을 받았다고 할 수 없다. 기존 탭·HTTP 캐시 가능성은 있으나 이번에 사용됐다는 증거는 없다. Clinic 조사 범위에서 service worker/Workbox/Cache API 등록은 찾지 못했고, root lockfile의 next-pwa 의존성만으로 서비스워커 동작을 주장하지 않는다. [assetPrefix](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/next.config.js#L47-L50), [MDN HTTP cache](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Caching)
- Amplitude init/autocapture/replay는 user API 성공을 기다리지 않는다. 새 Identify는 user/employee에 의존하지만 SDK가 이전 userId를 복원할 수 있으므로 회원 연결·버튼 클릭·페이지 이동이 이번 login 성공 증거는 아니다. [init](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/common/hooks/useAmplitudeInit.ts#L49-L97), [공식 identity](https://www.amplitude.com/docs/sdks/analytics/browser/browser-sdk-2/instrument-and-configure), [별도 Replay endpoints](https://www.amplitude.com/docs/sdks/session-replay/session-replay-plugin#api-endpoints)
- RUM init은 `_app` 최상위에서 production·applicationId/clientToken 존재만 조건으로 실행한다. **user API 실패로 init 자체가 막힌다는 가설은 코드와 맞지 않는다.** 다만 동적 SDK chunk 로딩/수집 경로 실패는 가능하다. [RUM init](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/common/hooks/useDatadogRUMInit.ts#L11-L42)
- RUM `setUser`는 accessToken/userInfo/activeEmployee가 모두 있어야 한다. SDK 로드 전 optional call이 스킵되는 식별 race도 코드상 후보이며 실제 발생은 미확인이다. user ID 필터로는 익명 event를 놓칠 수 있다. [setUser](https://github.com/Innvoaid/dentlink-client/blob/1948696376a92410671ac42ee7c32f4f6e28bdec/clinic/src/pages/_app.tsx#L319-L338), [Datadog user 식별](https://docs.datadoghq.com/real_user_monitoring/application_monitoring/browser/advanced_configuration/#identify-user-session)
- 코드상 RUM sessionSampleRate 100, replay 0, 내부 telemetry 0이다. replay 0과 일반 RUM 미수집을 혼동하지 않는다. 일반 RUM sampling 탈락은 이 코드 기준 낮은 후보이며 배포 시 실제 init 조건 충족은 별개다. 명시적 consent/beforeSend/proxy 설정은 조사 범위에서 찾지 못했다. 광고차단·보안제품·CSP·수집 도메인 차단·조회 필터/기간은 남은 후보다. [sampling](https://docs.datadoghq.com/real_user_monitoring/guide/sampling-browser-plans/), [troubleshooting](https://docs.datadoghq.com/real_user_monitoring/application_monitoring/browser/troubleshooting/)
- lockfile과 사건 인근 RUM sample에서 Datadog SDK 5.17.1을 확인했다. Amplitude lockfile은 Browser 2.43.0/Replay plugin 1.31.1. 최신 SDK 7 전용 기능을 사건 당시 동작으로 소급하지 않는다.

## 원인 후보와 반증 방법

우선순위는 현재 자료에서 먼저 확인할 순서이며 확률 수치나 원인 확정이 아니다. 네트워크 원인과 FE 오인 표시가 동시에 존재할 수 있다.

| 후보 | 지지하는 자료·현재 판단 | 구분/반증에 필요한 최소 자료 |
| --- | --- | --- |
| 1. PC/병원망의 목적지 도메인·IP·국가/평판 차단, 프록시/TLS 검사 | 모바일 정상·PC 실패 진술, 고객의 해외 사이트 제한 경험, 과거 다른 치과 allowlist 사례가 부합. 이번 차단 로그는 없음 | 동일 PC의 원본 Network/Console 오류 및 병원 IT 정책 로그. 모바일과 PC의 실제 연결망 차이. 같은 PC의 승인된 다른 망 비교 실험은 제안만 함 |
| 2. DNS/TLS/인터넷 경로·특정 구간 지연 | API/FE/관측 경로가 달라 API만 문제일 수 있음. 공백과 양립하지만 이번 DNS·TLS·시간 측정은 없음 | DNS resolution, TLS/연결 실패 코드, 요청 timing; 해당 시각 edge 도달·응답 여부 |
| 3. 브라우저 CORS/preflight·확장프로그램/endpoint 보안 | custom headers를 포함한 별도 API 요청 경로와 부합. 전역 CORS 오류라면 다른 사용자도 영향 받을 가능성이 있어 현재 근거는 약함 | OPTIONS와 실제 GET/POST 발생 여부, CORS response headers, 브라우저 오류. CORS 문구만으로 정책 오류라고 단정하지 않음 |
| 4. 자사 WAF/LB geo/IP/rate-limit 또는 라우팅/target 장애 | 앱 로그 공백이어도 edge 차단 가능. 다만 현재는 실제 WAF rule/action·LB 상태 증거 없음 | WAF action/terminating rule, ALB elb_status·target_status·actions_executed·timing. 403 응답의 생성 계층 확인 |
| 5. 만료/잘못된 token·갱신 실패·권한/활성 소속 문제 | 월요일 새 로그인 화면 진술 및 저장 token 경로와 양립. No Result도 publicApi에 token이 붙어 완전히 배제할 수 없음 | login/own/refresh 실제 HTTP status+application code, 성공 callback/응답 시각. 토큰 원문 수집 없이 서버 검증 결과만 확인 |
| 6. FE 초기화·캐시/상태 불일치 | 실패를 소속 없음으로 보이는 경로는 확인. 이것만으로 최초 API 실패 원인은 설명되지 않음 | 사건 build와 요청 시작 여부, query status/data/cached 여부, activeEmployee 초기화 순서. 별도 승인 후 재현 |

**무응답의 의미:** JS에 `response`가 없더라도 어떤 서버에도 도달하지 않았다는 뜻은 아니다. preflight만 도달했거나 실제 응답을 CORS가 가렸을 수 있다. 반대로 HTTP 401/403이 있다는 사실만으로 BE 인증 오류라고 할 수도 없고 WAF·프록시 응답일 수 있다. [MDN CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CORS), [CORS request did not succeed](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CORS/Errors/CORSDidNotSucceed)

## 대응 아이디어와 trade-off — 적용 승인 아님

| 구분·안 | 해결하는 문제 | 해결하지 못하는 문제·정상 영향·주의 | 필요한 검증 |
| --- | --- | --- | --- |
| 병원 IT에 정확한 필요 도메인 allowlist 확인 | 실제 고객망 정책이 원인이면 해당 경로 복구 | 전체 해외 차단 해제처럼 광범위 정책 완화를 전제로 하지 않음. 해당 원인이 아니면 무효 | 차단 제품/정책과 대상 도메인 확인, 최소 범위 적용 전후 비교. 외부 요청 메시지는 보내지 않음 |
| 자사 WAF/LB/DNS/TLS 원인별 교정 | 실제 rule·인증서·target·라우팅 문제 해결 | 증거 없이 geo 보안 정책 해제/전체 allow는 부적절. 기존 요청 영향 가능 | edge/app 계층 로그, 제한된 영향 검증·복구 계획 |
| API 앞 CloudFront | 가까운 edge와 AWS 경유 경로로 일부 지연/라우팅 문제 완화 가능 | 미국 서비스 인식·도메인 차단 해제·auth/CORS/BE 오류 해결 보장 없음. 추가 hop·비용·설정·timeout·로그 복잡성 | 아래 CloudFront 검토 항목, 기존 경로 대비 오류율/지연 |
| 최초 user 조회 실패를 별도 상태로 표현 | 소속 없음·승인대기 오인 방지 | 통신 차단은 남음. 현재 첫 pending 대기는 이미 존재; 전역 gate 확대와 구별 | 정상 소속/미소속/승인대기, 최초 오류, 느린 성공, 이후 복구 |
| State 필드에서 loading/error/empty/search-no-match 분리 | No Result 오인 방지·해당 영역 재시도 | 전체 흰 화면 불필요. 정상 사용자는 필드의 짧은 로딩 표시 가능 | 네 가지 상태와 성공 캐시 보존·country 변경 |
| 이전 성공 데이터가 있는 재조회 실패는 기존 화면+오류 표시 | 일시 오류로 화면 전체가 사라지는 영향 감소 | 오래된 권한/승인 데이터를 최신 판정으로 간주하면 안 됨. 계정/소속 전환 시 캐시 혼합 방지 | 최초 실패와 background failure 구분, 전환·수정 성공/실패 |
| 조회 timeout·제한 retry·수동 재시도 | 영구 pending 방지, 순간 지연 복구 | 짧은 timeout은 느린 정상 사용자도 실패 처리, 과한 retry는 지연/부하 증가. 쓰기는 중복·성공 여부 불명 위험 | 관측 지연 분포 기준 시간값 검토, backoff/jitter/상한, mutation 별도 정책 |
| 연결 오류와 인증 오류를 분리 | Invalid user·불필요 logout 오해 완화 | 무응답을 곧바로 token 만료로 취급하지 않음. 401/403도 application code/발생 계층 확인 | login/refresh/own 오류 분류 및 정상 세션 보존 |
| 독립 진단 수집과 SDK 준비 순서 개선 | API 실패를 나중에 구별할 가능성 증가 | 같은 BE 진단 전송은 함께 실패. 다른 collector도 차단 가능. 초기 SDK 로딩은 성능/수집 비용 발생 | 첫 API 이전 수집 준비, 익명 event, collector 장애, 중복/샘플링 |

`isFetching`을 전역 gate로 쓰면 정상 background refetch에도 화면이 사라질 수 있다. `!userInfo || !activeEmployee`만 더하면 실패 시 무한 빈 화면 및 정상 미소속 사용자 차단 가능성이 있다. 기존 employee query는 401→tokenExpired→로그인 이동에도 연결되어 있어 단순 enabled 변경은 전체 인증 흐름을 함께 검토해야 한다. 새로운 UI/문구/정책은 이번 조사에서 확정하지 않았다.

### CloudFront 제안을 읽는 정확한 방식

1. “미국에서 서버를 해외로 인식하지 않도록”은 **고객망이 목적지를 제한**하는 문제일 수 있다. **자사 WAF가 요청자 국가를 제한**하는 문제와 반대 방향이다. 두 방향을 분리해 질문한다.
2. CloudFront는 Ohio 단일 서버가 아니라 글로벌 POP 서비스다. 사용자는 지연상 적합한 edge에 연결하고, 동적 요청은 origin으로 간다. origin을 서울 ALB로 유지하면 BE 처리 위치는 서울이다. Ohio가 별도 origin/Origin Shield 등을 뜻했는지 제안자의 의도는 미확인이다. [AWS 구조](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/HowCloudFrontWorks.html)
3. 고객망의 API 도메인 차단·URL 분류·보안제품 정책은 CloudFront 도입 후에도 남을 수 있다. geo-IP 판정은 보장되지 않는다. 도입 후 개선되어도 국가 차단이 원인이었다는 증명은 아니다. 자사 WAF geo rule은 원 사용자 IP/X-Forwarded-For 처리와 별도로 검토한다. [WAF geo match](https://docs.aws.amazon.com/waf/latest/developerguide/waf-rule-statement-type-geo-match.html)
4. 인증/개인화 API는 캐시 비활성화에서 검토하고 Authorization·쿠키·query·method·Origin/preflight·Host 전달을 확인한다. 최소 TTL>0이면 origin의 private/no-store에도 캐시될 수 있어 사용자 응답 혼합을 막아야 한다. 공용 State 캐시는 별도 후보이나 최신성/국가 key를 검토한다. [Authorization](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/add-origin-custom-headers.html), [cache behavior](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/DownloadDistValuesCacheBehavior.html)
5. CloudFront의 origin 연결/응답/전체완료 timeout을 FE·ALB와 대조한다. 업로드 전송과 업로드 뒤 BE 처리/응답 시간을 구분한다. 응답 timeout 뒤 저장됐는지 모르는 쓰기를 자동 반복하지 않는다. 인증/갱신/GET/저장/OPTIONS/느린 업로드/사용자간 캐시 분리/원 IP 기반 정책을 검증해야 한다. [origin timeout](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/DownloadDistValuesOrigin.html), [origin 요청 처리](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/RequestAndResponseBehaviorCustomOrigin.html)

## 어느 계층에 어떤 로그가 필요한가

| 계층 | 최소 정보 | 해석상 한계 |
| --- | --- | --- |
| FE 공통 요청 경계 | 요청 분류명/경로 템플릿, method, 시작 시각·duration, response 존재 여부·status·정규화 오류 code, build, 초기화 단계, retry 횟수, 짧은 수명의 correlation ID | 브라우저가 DNS/TLS/CORS 상세 원인을 JS에 제공하지 않을 수 있음. raw query/body/header/token/회원·환자 정보는 제외 |
| 브라우저 원본 증거 | 민감정보 제거한 Network/Console 실패 코드, OPTIONS/실제 요청 존재, timing | HAR에는 token·쿠키·PII가 포함될 수 있어 원본 통째 수집을 기본으로 하지 않음. 고객 재로그인으로 기존 사건을 덮지 않음 |
| 독립 collector/RUM | 익명 세션 수집·SDK init 성공/시점, API 실패 event의 도착 여부 | 같은 BE로 보내면 같은 장애에 막힘. 독립 경로도 보장 없음. user ID 검색만으로 전체 미수집 판정 금지 |
| ALB | elb/target status, actions_executed, 처리시간·시각, trace/request 연결 | target까지 안 간 요청도 access log에 있을 수 있음. optional/best-effort라 로그 공백이 미도달 증명 아님. ALB에 도달한 연결의 TLS handshake 문제는 connection log 활성 여부를 확인한다. DNS 실패·ALB 도달 전 경로 차단은 해당 로그로 확인하지 못할 수 있음 |
| WAF | terminating action/rule, 국가/IP 판정 방식, correlation | WAF block과 BE 401/403을 분리. 고객 IP 원문을 개인 문서에 복제하지 않음 |
| BE | endpoint 분류·status/app code·duration·서버 request id·인증 검증 결과 | 앱에 도달한 요청만 설명. 로그 filter/retention·인증 전 로깅 범위도 확인 |

ALB에서 최종 action `waf` 및 default 403/target status `-`는 WAF 거절을 구분하는 단서다. connection log로 TLS 단계 관측이 가능하나 실제 로그 활성 여부는 미확인이다. [ALB access log](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html), [connection log](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-connection-logs.html), [WAF log fields](https://docs.aws.amazon.com/waf/latest/developerguide/logging-fields.html)

response request-id를 FE가 읽으려면 CORS expose headers가 필요할 수 있다. 새 진단 요청 헤더는 preflight 조건/allow-headers를 바꿀 수 있어 기존 ID 체계 재사용을 우선 검토한다. 통신 실패 자체로 response ID를 못 받으면 client ID만 남을 수 있다. [MDN expose headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Access-Control-Expose-Headers)

## 다음에 필요한 최소 자료와 질문

1. **사건 범위:** 실패 PC의 브라우저/버전·정확한 시각/시간대, 모바일은 앱/웹인지와 동일 Wi-Fi인지. `09:03:35` 내부 테스트 경계의 시간대. 기존 자료부터 확인하고 재로그인을 먼저 요구하지 않는다.
2. **요청 증거:** login, users/own, employee/own, state-code 중 당시 실제 요청한 것의 status/정규화 오류/timing·OPTIONS 유무. token 원문 대신 보유/만료/갱신 검증 결과만 필요하다.
3. **BE/인프라 담당자:** 해당 시각 app 로그뿐 아니라 ALB/WAF 로그가 활성화됐는지, 필터 없이 요청 전후 계층이 연결되는지, 병원 IT 차단 로그/allowlist 결과가 있는지. “CloudFront Ohio”의 정확한 의도와 현재 API 네트워크 구성을 확인한다.
4. **관측 담당자:** Amplitude 직접 열람 연결, replay 실제 시각과 이벤트 종류, RUM user/service/env/time 필터·익명 세션 포함 여부. 이미 확인한 제한 범위 결과를 반복해서 원인 확정 자료로 쓰지 않는다.

읽기 전용 1차 분석과 아이데이션은 완료했다. 원인 확정은 위 자료가 필요하다. 제품 변경·계정 테스트·재현 실험·Slack/Jira 게시·배포는 수행하지 않았고 사용자의 다음 요청까지 자동 추적하지 않는다.
