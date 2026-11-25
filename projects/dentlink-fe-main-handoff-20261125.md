# 메인세션 교체 시도 종료·기존 메인 유지 — 2026-11-25

이 문서는 종료된 교체 시도의 기록이다. 새 메인 생성·기존 메인 보관·복구 시도를 다시 실행하지 않는다.

## 최종 상태

- 기존 `메인세션` (`01a08f0c-2057-7852-ae8d-0cf950a91fd3`)를 유지한다. 기본 실행 pwd와 저장된 채팅 cwd는 `/Users/parkjongsun/Repository`로 일치한다.
- 사용자가 경로를 변경하고 불필요한 `/Users/parkjongsun/Repository/dentlink-fe-main-context` 폴더를 삭제했다. 에이전트가 실제 부재를 확인하고 남은 첨부 및 Git worktree 등록을 정리했다.
- `/Users/parkjongsun/Repository/codex-personal-context`의 main이 유일한 개인 기록 checkout이다. 메인의 cwd와 기록 저장소는 달라도 된다. 별도 감싸는 폴더·복제본·관리용 worktree는 필요 없다.
- 기존 제품 세션·제품 코드·제품 checkout은 그대로다. 상세 업무 연속성은 PROJECTS.md와 각 projects 문서에서 필요한 범위만 확인한다.

## 보관된 후보 채팅

| ID | 용도 | 최종 상태 |
| --- | --- | --- |
| `01a21225-fce1-7061-b7ae-d1c0e723614d` | CLI 경로 복구 중 생긴 메인 복사본 | 보관 |
| `01a21227-6648-7cf2-8169-77b50d6b629f` | CLI 경로 확인 중 생긴 메인 복사본 | 보관 |
| `01a2122f-8155-7593-be39-72b4b8da2941` | 첫 exec 초기화 | 중단·보관 |
| `01a21230-85b5-75f2-aaeb-97c5700d0ee2` | CLI 새 메인 후보 | 보관 |
| `01a2123a-7636-7d21-a102-4a0aba0b0033` | 앱에 등록한 새 메인 후보 | 중단·보관 |

## 재발 방지

- 세션 묶음, 채팅 cwd, 개인 기록 저장소, 제품 worktree를 구분한다. 단순 경로 경고 해결을 새 메인/개인 컨텍스트 복제 구조로 확대하지 않는다.
- 당시 archive_worktree는 primary checkout 보호로, handoff_thread는 source checkout 탐색 실패로 거절됐다. CLI에서 보인 /cd 결과는 원래 앱 세션 변경 증거가 아니었다. 도구 제한을 우회하지 않았고 해결했다고 반복 단정한 안내는 잘못이었다.
- `.zshrc`의 오래된 CODEX_BIN은 설치된 번들 CLI 경로로 수정·실행 검증했다. 이 수정은 유지하며 추가 shell 변경은 없다.
- 신규 제품 worktree는 Repository/repository 아래에 만들고 담당 세션에서 연결한다. 기존 작업 세션을 자동으로 고치거나 폴링하지 않는다.
- 현재 상태와 소유권 정본은 `projects/dentlink-fe.md`다.
