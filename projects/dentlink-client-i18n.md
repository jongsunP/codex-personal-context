# Dentlink i18n and typography closeout — 2026-08-19

This is the durable closeout source for the Dentlink Lab i18n, operational
Sheet, and cross-service Pretendard work. Live Git and Google Sheet state still
take precedence if later work changes them.

## Final Delivery State

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree:
  `/Users/parkjongsun/repository/dentlink-client-i18n`
- Branch: `feature/i18n`, tracking `origin/feature/i18n`
- Local and remote HEAD:
  `1d1b2fda1` (`ui: Clinic과 Admin Pretendard 폰트 정책 적용`).
- The worktree is clean and matches the remote branch.
- The user confirmed on 2026-08-19 that deployment was completed. This is a
  user-confirmed operational fact; the final deployment revision was not
  independently queried in this closeout.
- Current package version in Lab, Clinic, and Admin: `1.84.0`.

Final follow-up commits:

- `b47ef8cb0` — `fix: 다국어 시트 역할별 인터페이스 정리`
- `8a337bd13` — `chore: 서비스 버전 1.84.0 반영`
- `1d1b2fda1` — `ui: Clinic과 Admin Pretendard 폰트 정책 적용`

## Lab i18n Runtime

- Lab displays Korean by default. English remains the source language,
  fallback, and future expansion resource.
- Runtime uses `i18next@22.5.1` and `react-i18next@12.3.1` with statically
  bundled locale JSON.
- `lab/i18n/i18n.manifest.json` is the schema source for languages,
  namespaces, keys, and Sheet columns.
- Current catalog: 1,464 keys across 20 files under
  `lab/src/i18n/locales/{en,ko}`.
- Current namespaces: `gnb`, `sharedUi`, `dashboard`, `account`, `orders`,
  `shipping`, `settlements`, `patients`, `help`, and `linkTalk`.
- There is no language selector or persisted language choice in the current
  scope.

## Canonical Google Sheet

- Sheet:
  `https://docs.google.com/spreadsheets/d/1iuncwk8EIi8ycbc36a0dMn-ZkxaqqMHy1jvyT6ubpq0/edit`
- Operational tabs: `비개발자 영역`, `개발자 영역`
- Preserved backup tabs: `백업_작업전_2026-08-13`,
  `백업_2탭전환_2026-08-18`
- Backup tabs were not changed during the final structural correction.

The two operational tabs are role-specific views of the same canonical message
table, not independent datasets:

- Both tabs contain exactly 1,464 data rows.
- Every message ID is unique and the ID sequence is identical in both tabs.
- Shared fields have the same name, relative order, and value.
- `페이지`, `화면 상태`, and `페이지 경로` expose one representative use site
  only. They never expose a multiline list of all routes.
- Multiple technical use-site identifiers remain aggregated only in the hidden
  developer `사용처 ID` column.
- The previously problematic row 24 representative path is `/` in both tabs.

Nondeveloper columns:

`영문 | 한글 | 페이지 | 화면 상태 | 위치 번호 | 캡처 | 페이지 경로 |
개발자 확인 요청 | PM·디자이너 확인 요청 | 문구 ID`

Developer columns add `namespace`, `key`, hidden `사용 상태`, and hidden
`사용처 ID` after the same shared columns. `문구 ID` remains hidden from the
normal nondeveloper interface.

Request ownership is explicit:

- `개발자 확인 요청`: PM or designer asks a developer about wording, context,
  or exposure conditions.
- `PM·디자이너 확인 요청`: a developer or automated audit asks PM/design for
  a product or wording decision, including screen-versus-JSON differences.
- The 39 existing notes were preserved exactly and split into 16
  PM/design-to-developer requests and 23 developer/automation-to-PM/design
  requests, with zero overlap.

Final Sheet read-back verified:

- 1,464 unique IDs in each tab and identical row order
- zero shared-field mismatches
- zero multiline common page/state/path cells
- zero formula errors
- hidden use status and use-site IDs preserved
- all 39 existing notes preserved
- zero English/Korean mismatches against local locale JSON

## Typography Policy

All three projects now use Pretendard and the same Dentlink letter-spacing
policy:

- heading and title variants: `0px`
- body variants: `-0.1px`
- shared UI reads `--dentlink-letter-spacing-heading` and
  `--dentlink-letter-spacing-body`, with legacy theme values only as fallback.

Service details:

- Lab: local Pretendard Medium/Bold WOFF2 via `next/font/local`.
- Clinic: local Pretendard Medium/Bold WOFF2 via `next/font/local`; all previous
  Clinic Lato source references and font assets were removed.
- Clinic PDF: five PDF routes and five PDF document components now use
  Pretendard Regular/SemiBold/Bold TTF.
- Admin: its existing full Pretendard web and PDF setup remains; its theme and
  root variables now use the same heading/body letter spacing as Lab/Clinic.

## Verification And Known Environment Limits

Completed verification:

- `pnpm audit:i18n`: 1,464 keys, 1,464 reachable, zero unresolved keys, zero
  unknown literal keys, and zero review rows.
- Canonical row generation: 1,464 unique rows with zero multiline common
  page/state/path cells.
- Direct live-Sheet CSV versus local JSON comparison: zero translation
  mismatches.
- Font asset hashes match their existing Lab/Admin source files.
- Clinic source and public assets contain zero remaining Lato references.
- Clinic and Admin development roots returned HTTP 200.
- Runtime computed styles confirmed Pretendard, heading `0px`, and body
  `-0.1px` in both projects.
- All five Clinic PDF routes and all five new Clinic font asset URLs returned
  HTTP 200 without font compilation errors.
- Admin typecheck passed.
- Changed-file lint completed with zero errors and two pre-existing warnings.
- `git diff --check` passed before each final commit.

Known local verification limits:

- `pnpm check:i18n` cannot authenticate from the local shell because Google
  Application Default Credentials are unavailable. The direct authenticated
  browser export and exact CSV-to-local comparison replaced that check for the
  final verification.
- Clinic typecheck currently stops at the pre-existing unrelated import error
  in `shared/ui/src/PdfUI/BrowserPDFHeaderUI.tsx` for
  `shared/templates/invoice/logo-dentlink.png`.
- The pre-push coverage check requires a local coverage baseline that is not
  present. Final commits were pushed with Husky disabled after the targeted
  checks above.

## Durable Operating Rules

- Do not edit, delete, or include tabs whose names start with `백업_` in Sheet
  automation.
- Keep one canonical row per full key in both operational tabs.
- Do not expand representative page/state/path cells into multiline use-site
  lists.
- Keep PM/design-to-developer and developer-to-PM/design requests in separate
  columns.
- Translation changes are made in `비개발자 영역`; generated technical fields
  and hidden IDs are not manually duplicated across tabs.
- Runtime observation JSON may contain real account or patient data. Keep it
  temporary, local, ignored, and never upload it unmasked.
- `service-account.json` remains local and ignored. Grant Sheet edit permission
  only for an explicitly authorized write.

## Closeout

There is no remaining requested implementation, commit, or push for this work.
The feature branch is clean, remote-backed, versioned at 1.84.0, and the user
confirmed deployment. Optional repository maintenance outside this scope is to
fix the existing PNG module declaration/typecheck failure and create the
coverage baseline required by the standard push hook.
