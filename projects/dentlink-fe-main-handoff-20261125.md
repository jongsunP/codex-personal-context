# Dentlink FE 메인세션 교체 인계 — 2026-11-25

## 목적과 승인

- 새 메인 ID는 `01a2123a-7636-7d21-a102-4a0aba0b0033`, 제목은 `Dentlink FE 메인세션`이다. 원본 cwd 및 실제 실행 `gpt-6-astra` / `xhigh`를 확인했다. 앱 목록 등록과 이전 세션/임시 worktree 정리 완료 여부는 공통 체크포인트를 따른다.
- 기존 메인 `01a08f0c-2057-7852-ae8d-0cf950a91fd3`의 앱 cwd가 복구용 worktree에 고정되어, 사용자가 새 메인 생성·인계·불필요한 worktree 정리·기존 메인 보관을 명시 승인했다. 새 메인 정상 연결 후 기존 메인을 보관한다. 기존 메인 영구 삭제나 제품 작업 재개는 요청하지 않았다.
- 새 메인의 실제 cwd는 `/Users/parkjongsun/Repository/codex-personal-context` 원본이다. 개인 컨텍스트를 복제하거나 새 worktree를 만들지 않는다. 기존 메인 프로젝트 묶음은 재사용할 수 있으며 앱의 그룹과 실제 Git 경로는 별개다.
- 최종 모델 지정: 사용자가 `GPT-6-Astra / ultra` 응답 직후 **Extra High로 변경**했다. 신규 메인은 `gpt-6-astra` / `xhigh`로 생성·확인한다.

## 역할과 정본

- 새 메인은 사무실 Codex의 Dentlink FE 통제센터다. 접수·제품 범위 구분·공통 계약·release/배포·구현 세션 인계·개인 컨텍스트·로컬 정리를 조율한다. 구현은 기본적으로 기능별 담당 세션에서 하며 인계 후 폴링하지 않는다. 새 메인은 이후 계속 유지하고, 대상이 모호한 보관 요청은 되묻는다.
- 개인 지침과 기록은 이 원본 저장소 하나가 정본이며 의미 있는 마감 때 commit/push한다. Claude 메모리에도 대응 기록을 남긴다. `BOOTSTRAP.md`의 읽기 순서와 `AGENT_INBOX.md`를 따른다. `PROJECTS.md`는 탐색 인덱스, `projects/dentlink-fe.md`는 공통 결정·세션 소유권, 각 기능 문서는 상세 이력이다.
- 웹·관리자 `/Users/parkjongsun/Repository/dentlink-client`, 치과앱 `/Users/parkjongsun/Repository/dentlink-app`, 기공소앱 `/Users/parkjongsun/Repository/dentlink-lab-app`은 독립 저장소다. 제품 코드·branch·commit/push·PR·merge·배포는 사용자 승인 범위를 구분하고 현재 live 상태를 확인한다.

## 이번에 확정된 운영 규칙

- 모든 디바이스·에이전트에서 실제 Git checkout/worktree는 이미 있는 Repository/repository 루트 한곳 아래에 둔다. 세션 그룹에 따라 예외를 만들지 않는다. 신규 세션은 실제 폴더·Git 등록·persisted cwd 일치까지 검증한다.
- `codex-personal-context`는 로컬 하나만 둔다. 메인 프로젝트 소속 기능 세션이 별도 제품 worktree를 갖는 것은 허용하며, 개인 컨텍스트 복사본을 상시 유지한다는 의미가 아니다.
- 기존 기능 세션의 경고는 사용자 지시로 완료/보관까지 그대로 둔다. 수리·이동·상태 폴링을 자동 재개하지 않는다. 새 메인은 처음부터 존재하는 정확한 경로로 시작한다.
- 화면·포커스·공유 마우스/키보드를 가져가려면 먼저 현재 사용 가능 여부를 질문하고 답변을 기다린다. 과거 승인을 다음 점유 구간에 재사용하지 않는다. 비가시적 CLI·커넥터 작업은 병행 가능하며 도구의 안전상 제한을 우회하지 않는다.
- 한국어 존댓말로 짧게 답하며 상태 보고는 완료한 것 → 현재 영향 → 남은 일 순서다. 공유용 문구·프롬프트는 한 번에 복사 가능한 형태로 제공한다.

## 기존 업무의 연속성

- 기존 기능 세션은 그대로 둔다. 요청 없이 조사/개발/배포를 재개하거나 진행 상황을 조회하지 않는다.
- 최근 관련 정본: 피드백 Amplitude 코드 조사는 `projects/dentlink-feedback-amplitude-audit.md`, 이벤트 DL-17604는 `projects/dentlink-amplitude-event-audit-dl17604.md`, 라벨 출력은 `projects/dentlink-lab-batch-label-print.md`, 배송 패널은 `projects/dentlink-lab-shipment-panel-visibility.md`를 참고한다. 나머지는 PROJECTS.md와 각 작업 정본에서 필요한 범위만 찾는다.
- 피드백 조사 기존 채팅은 `01a211d5-91e6-7a70-bfd6-a25bd4ed22dc`다. 웹/모바일웹/앱 native/WebView 코드상 이벤트 조사이며 원래 인계가 완료된 별도 기능 세션이다. 새 메인 초기화 때문에 해당 세션을 다시 호출하지 않는다.

## 교체 시 정리 대상과 검증

- 유일한 정리 대상은 `/Users/parkjongsun/Repository/dentlink-fe-main-context/codex-personal-context`와 비게 되는 상위 `dentlink-fe-main-context` 폴더다. 제품 worktree와 다른 세션은 보존한다.
- 직전 확인에서 이 임시 worktree는 detached `5d2a2b7`이며 tracked/untracked/ignored 변경이 없고, 해당 커밋은 원본 main에 포함돼 있다. 삭제 전 실제 상태를 다시 확인하고 managed worktree는 공식 archive_worktree를 사용한다.
- 기존 메인에서 원본 attach는 linked worktree 요구로 거절됐다. CLI `/cd` 성공 메시지를 사용자가 확인했으나 앱 메타데이터와 실행 cwd는 여전히 임시 worktree였다. 앱·CLI 양쪽 연결이 일치했다고 주장하지 않는다. 사용자 화면에는 Hand off 메뉴도 없었다.
- `.zshrc`의 오래된 CODEX_BIN 경로는 실제 번들 CLI 경로로 수정했고 새 interactive zsh에서 실행을 검증했다. 추가 shell 변경은 필요 없다.
- 새 메인 생성·cwd/모델 검증·앱 등록·인계 후 기존 메인을 보관하고 임시 worktree를 정리한다. 실행 중 worktree 보호로 정리가 막히면 우회 삭제하지 말고 소유 세션 종료 후 처리한다. 완료 여부·새 메인 ID는 `projects/dentlink-fe.md` 최상단과 소유권 표에 갱신한다.

## 새 메인 첫 행동

원본 cwd와 지침을 확인하고 필요한 정본을 읽은 뒤 인계 수신을 짧게 브리핑한다. 초기화 때문에 제품 작업이나 기존 세션 조사를 시작하지 않는다. 생성 세션이 교체 마감을 수행하는 동안 같은 개인 문서를 동시에 수정하지 말고, 별도 요청 전에는 읽기와 사용자 응답으로 한정한다.

## 현재 인계 결과

- 초기 인계 읽기를 완료한 채팅을 공식 same-directory fork하여 위 최종 새 메인으로 등록했다. 실제 원본 cwd·idle·고정 목록 노출·공식 화면 열기 확인 완료. 새 메인은 프로젝트 미지정이며 프로젝트 이동은 도구의 출처 폴더 검증 제한으로 보류했다.
- 준비용 CLI 채팅 `01a21230-85b5-75f2-aaeb-97c5700d0ee2`는 최종 메인이 아니다. 첫 실패한 초기화 `01a2122f-8155-7593-be39-72b4b8da2941`와 함께 보관 대상으로 구분한다.
- 사용자 최종 승인: "진행해. 이거 보관되고 불필요한폴더사라질때까지해. 화면 전환등 다 허락". 이번 마감에 필요한 화면 전환과 구 메인 보관은 재질문하지 않는다.
- 임시 worktree는 clean·원본 main에 포함됐으나 archive_worktree가 primary checkout 보호로 거절했다. 새 메인이 공식 handoff_thread로 구 메인을 sourceCwd인 원본에 돌려놓고, 구 메인 후속 프롬프트에서 자신의 첨부 worktree 보관·빈 부모 폴더 제거·정본/Claude 기록·commit/push·자기 보관을 수행한다. 제한을 raw Git/rm으로 우회하지 않는다.
