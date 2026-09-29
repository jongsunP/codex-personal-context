# Dentlink 요구사항 외 UI 변경 조사

## 목적·승인 범위 — 2026-09-29

- 사용자는 피드백 조회 실패의 Retry 버튼을 계기로, Codex가 요구사항 근거 없이
  추가한 사용자 노출 UI·문구·동작이 더 있는지 별도 세션에서 조사하도록 요청했다.
- **조사 → 근거와 문제·수정안 보고 → 사용자 승인 → 승인된 항목만 수정** 순서다.
  지금은 조사·보고만 승인됐으며 제품 코드 변경·삭제·테스트 데이터 변경·PR·배포는
  승인되지 않았다. 기존 UI 전부가 잘못됐다고 전제하거나 근거 부재만으로 제거하지 않는다.
- 공통 지침은 `DEVELOPMENT_STYLE.md`의 **Requirement And Design Scope**를 따른다.
  PM/디자인/사용자 원문과 AI가 작성한 Jira·계획·완료 기록을 구분한다.

## 제품 위치·브랜치

- 원격: https://github.com/Innvoaid/dentlink-client
- 사용자가 지정한 checkout: `/Users/parkjongsun/Repository/dentlink-client`.
- 새 로컬 브랜치: `feature/ui-requirements-audit`.
- 시작 기준: 2026-09-29 조회·fetch한 `origin/master`
  **`9bed1f7bd753e229478302413c0ec9a7e7a11dc2`**. 제품 변경/추가 커밋/원격 브랜치 push 없음.
- 기존 LBX `feature/DL-16387`은 로컬·원격
  `347909945b091324e7134673525203de14e122fd`로 보존했다. LBX 보류를 해제하지 않는다.
  기본 checkout만 사용자 요청의 새 조사 브랜치로 전환했다.
- `/Users/parkjongsun/Repository/dentlink-client-dlds`의 `feature/DL-16466`은 별도
  디자인시스템정비세션 소유다. 이 조사에서 수정하거나 QA/E2E 작업을 대신하지 않는다.
- 새 기기는 원격 master와 실제 상태를 다시 확인하고, 아직 원격에 없는 조사 브랜치를
  복구할 때 위 시작 SHA와 최신 master 차이를 먼저 확인한다. 고정 SHA로 강제 초기화하지 않는다.

## 확인된 출발 근거

1. `clinic/src/components/Feedback/FeedbackPageContent.tsx`에 목록/건수 조회 실패 시
   `Unable to load feedback.` / `Please try again.` / `Retry`와 refetch가 있다.
2. 최초 원본 커밋은 **`0e35c3f714c07f3c731a722d997a0b05d53214ce`**, 2026-08-21
   17:23:33 KST이며 Git author/committer는 jongsunP다. `d980889c6`은 9월4일
   PR #4555 squash 병합본이므로 최초 작성 날짜와 구분한다.
3. 당시 Codex 작업 원본에서 2026-08-21 15:29:03 KST의 패치가 직접 추가한 것이 확인됐다.
   사용자 요청은 API 없이 목데이터로 가능한 화면을 진행하라는 것이었고, Codex는
   로딩·오류·빈 상태 보완을 제안했다. Retry 문구·위치를 직접 요청받거나 별도로
   승인받은 근거는 확인되지 않았다. 같은 작업에서 상세 질문 조회 실패 Retry도
   추가했지만, 현재 코드에 그대로 남았는지는 현재 master를 기준으로 확인한다.
4. 그 전부터 OrganizationLayout/OrganizationOffices에는 같은 EmptyDataInfo·Retry·refetch
   패턴이 있었다. 오류 복구 관례를 적용했다는 추론을 뒷받침하지만 피드백의 요구사항
   또는 특정 파일을 복사했다는 증거는 아니다.
5. 기획 Notion의 조회된 본문, Figma 피드백 목록·상세 레이어, PR에서 이 Retry를
   명시한 요구는 찾지 못했다. Notion은 truncated=true/미확인 블록1개였으므로 전체
   문서의 부재로 단정하지 않는다. DL-16057의 일반 error/retry 문구는 AI 작성 FE
   정리일 수 있어 PM/디자인의 독립적인 요구 근거로 사용하지 않는다.

### 원문·이력

- [기획](https://app.notion.com/p/innovaid/3b1ce072e82f8105aec7e513995abc18)
- [Figma 목록·상세](https://www.figma.com/design/Lu8GEh1TUU5hOfj2FCPRYn/0101?node-id=160-40593&m=dev)
- [Jira 상위](https://innovaid.atlassian.net/browse/DL-15828),
  [FE 목록](https://innovaid.atlassian.net/browse/DL-16057)
- [PR #4555](https://github.com/Innvoaid/dentlink-client/pull/4555),
  [원본 commit](https://github.com/Innvoaid/dentlink-client/commit/0e35c3f714c07f3c731a722d997a0b05d53214ce)
- 기존 개인 이력: `projects/dentlink-client-order-feedback.md`.
- 이 기기의 보조 증거: `~/.codex/archived_sessions/rollout-2026-08-20T19-29-50-01a01eb8-4e4b-7061-9107-29255464d532.jsonl`.
  사용자 진행 요청2639행, 공개 응답2644행, 실제 patch2731행, 적용 기록2732행.
  다른 기기에 이 대화 원본이 없더라도 위 Git/요구사항과 이 검증 요약으로 이어간다.

## 조사 방법·보고 형태

- 피드백부터 시작해 Codex가 구현한 변경과 관련 화면으로 조사 범위를 넓힌다.
  오류/빈/로딩 안내, 토스트, 재시도·확인 버튼, 자동 이동·닫힘, 상태 유지/초기화 등을
  요구사항·Figma·명시적인 사용자 결정·도입 이력과 대조한다.
- 각 항목은 **앱/페이지·현재 동작·도입 근거·요구사항 근거·문제/추가 판단 여부·
  사용자 영향·제안 수정**으로 간결하게 보고한다. 확정 위반/검토 후보/근거 미확인을 구분한다.
- 근거를 못 찾았다는 이유만으로 잘못된 기능이라고 단정하지 않는다. 전체 저장소를
  빠짐없이 검사했다고 과장하지 않고 조사한 범위와 남은 범위를 밝힌다.
- 제품 파일·검증 결과·기존 서버를 변경하지 않는다. E2E/실데이터 조작 없이 코드·
  원문·기존 로그를 우선 읽고, 별도 환경이나 변경이 필요하면 보고한다.
- 개인 조사 결과는 이 파일에 정리할 수 있다. 공유 제품 저장소에 개인 조사/세션
  보고서를 추가하지 않는다. 보고가 끝나면 사용자 승인을 기다린다.

## 현재 인계 상태

- 별도 채팅 **요구사항 외 UI 변경 조사**를 생성했다.
  thread ID: `01a0eb99-f3b0-77d2-8e03-45524bc45ba6`, host: `local`.
- 앱의 채팅 분류는 **메인 프로젝트 폴더**이며, 실제 제품 조사 명령의 workdir는
  `/Users/parkjongsun/Repository/dentlink-client`로 명시했다. 제품 폴더에 대응하는
  앱 등록 프로젝트가 없어 기존 메인 프로젝트 아래에 채팅만 생성했다.
- 원문 근거·브랜치·조사/보고/승인 순서와 제품 수정 금지를 전달했다. 최초 진행은
  읽기 전용 조사이며, 사용자에게 결과를 보고한 뒤 승인 대기한다.
- 연결 정보 저장 완료 후 담당 채팅이 이 정본의 조사 결과를 갱신한다. 다른 기능의
  체크포인트나 DLDS 제품 작업을 대신 변경하지 않는다.
