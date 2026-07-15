# Dentlink Invite current checkpoint - 2026-07-15

This is the current personal work checkpoint. Verify it against the live shared
repository and external project tools when work resumes.

Repo: `/Users/parkjongsun/repository/dentlink-client`
Canonical branch: `feature/DL-14232`
Pushed HEAD: `648822fcc [DL-14232] fix: 의도된 공용 UI 및 Layout 변경 복구`
Remote: `origin/feature/DL-14232` matched local HEAD
Worktree: clean
Canonical PR: [#4353](https://github.com/Innvoaid/dentlink-client/pull/4353),
Open Draft, base `master`, head `feature/DL-14232`, mergeable/CLEAN with
CodeRabbit success
Develop API PR: [#4376](https://github.com/Innvoaid/dentlink-client/pull/4376),
merged into `develop` as `44e6220c5227ae2b4a44f6df30d6959acb664d37`
Develop follow-up PR:
[#4378](https://github.com/Innvoaid/dentlink-client/pull/4378), merged into
`develop` as `c0356438e9555fee2840d239903a3f4fd796e225`
Develop follow-up worktree:
`/Users/parkjongsun/repository/dentlink-client-invitation-api-develop`
Current branch: `develop`, matching `origin/develop` at `c0356438e`

## Final handoff for the next device

- This session is complete. No additional code change is currently required on
  `feature/DL-14232` or `develop`.
- `develop` is only the development-environment delivery and QA path. The needed
  code was already merged through PR #4378; no follow-up develop PR is required.
- The actual final objective is canonical PR #4353 from `feature/DL-14232` to
  `master`, for final review and production integration.
- The mistaken scope-reduction commit `fdb9fd8c3` and corrective commit
  `648822fcc` cancel at tree level. The final feature content matches the intended
  pre-review tree, and develop never received the mistaken revert.
- Resume with PR #4353 review or requested QA only. Do not make new implementation
  changes, monitor downstream workflows, or reopen closed PR #4379 unless the
  user gives new feedback or an explicit request.

## 2026-07-15 completed work

- Regenerated Office API models and connected
  `POST /office/employees/invitations/accept` with body
  `{ employerId: number }` for existing-member invitation acceptance.
- After acceptance, the flow refetches accepted invitation state, fetches the
  employee list, switches to the invited office, and continues to Office home.
- Removed frontend `firstFunnelChannel` and `secondFunnelChannel` values from
  invitation signup payloads because Jira confirms those fields are set by the
  server. Spread order was corrected so stale form values cannot leak through.
- Added the missing DL-15575 `onboarding_click` event with documented
  `onboardingType` values: `fee schedule`, `scanner`, and `payment`.
- Kept Clinic `create_account_complete` at the exact signup API success point
  for both ordinary and verified signup. Removed the later authenticated-app
  handoff because it could miss or delay completed signups when auto-login or
  user-profile loading failed.
- Added all eight DL-15570 invitation-management events and eight documented
  properties, including pending-member actions, dropdown changes, chip delete,
  and invite send click/success/failure.
- Removed the separately added signup-tracking and invitation-analytics helper
  and test files by user direction. The runtime behavior remains in the existing
  `useSignupForm` and `useOfficePendingMembers` files.
- Pushed follow-up commits `0700fa572`, `5e52c5b3b`, `1675ef418`, and
  cleanup commit `1be4ee8db`, followed by direct signup-success tracking commit
  `58d16969d`. The equivalent develop follow-up HEAD `0c3edf7b4` was merged by
  PR #4378 as `c0356438e`.
- Updated PR #4353 body to include DL-14232, DL-15575, DL-15570, exact review
  points, verification, and remaining live QA.
- Updated the relevant Notion taxonomy: DL-15575's missing event/property and
  all DL-15570 events/properties are marked complete; the DL-15570 parent Office
  task is also complete.
- The isolated develop API PR was deployed successfully and its post-deploy
  E2E job completed successfully.
- Develop follow-up PR #4378 was merged for the post-API payload and analytics
  commits. Downstream merge/deployment operation is user-owned and outside this
  task; do not monitor or report it unless explicitly requested.
- Updated both PR descriptions to state that `create_account_complete` fires at
  signup API success rather than after authenticated user identification.
- Re-audited the full 93-file final diff by commit origin and requirement history.
  Every remaining change maps to DL-15489, DL-15493, DL-14232 design/API work,
  the explicitly requested Layout prop cleanup, or DL-15570/DL-15575 analytics.
- A scope-review pass briefly reverted the shared Button design, `ChartDropdown`,
  and Layout transient-prop work in `fdb9fd8c3`. That judgment was incorrect:
  Button/ChartDropdown are intentional design changes and `$isFull` is the
  requested invalid-DOM-prop correction. Corrective commit `648822fcc` restores
  the exact pre-review tree; develop was never changed by the bad revert.
- Develop cleanup PR #4379 was closed without merge. Do not merge its branch.
- Final canonical and develop worktrees are clean and match their remotes.

## Scope review rule learned on 2026-07-15

- Judge over-spec by causal relationship to the requirement, design, explicit
  user direction, and existing branch history, not by whether a file is shared
  or the diff is large.
- Before removing a suspicious change, inspect the introducing commit, Jira
  comments/child cards, Notion/Figma context, user instructions, and the as-is
  behavior it corrects. Ask before reverting when that context is ambiguous.
- Shared Button/theme changes and a specialized shared dropdown are in scope
  when they implement the approved design. Transient props such as `$isFull`
  are correctness work when they prevent style-only props from leaking to DOM.
- A true over-spec example in this work was moving signup analytics delivery to
  `_app` with an analytics-only `sessionStorage` handoff even though the signup
  mutation success callback already owns the exact completion point.
- Other red flags are unrequested test/analysis/helper artifacts, unrelated
  global lifecycle state, duplicated side effects, or behavior with no traceable
  requirement/history. None remain in the final branch.

## Review sources and findings

- Reviewed Jira DL-14232, DL-15570, and DL-15575, including comments, child
  cards, assignee/reporter relationships, and user mentions.
- Reviewed FigJam node `3:4698` and Figma design node `296:50698` in the desktop
  files. The current UI and flow are materially aligned with the documented
  member, Pending Members, Invite Members, and recipient-invitation scope.
- Jira comments establish that signup code is optional, valid/expired signup
  sends `invitation: { employerId }`, canceled invitation sends `null`, and
  first/second funnel values are server-owned.
- The latest generated accept API matches the frontend call: no email field and
  a void response. Generic error UX remains; no contract-specific error code
  presentation is currently defined.
- Open related Jira work remains outside this frontend implementation or needs
  integrated QA: DL-15490 email link/template, DL-15491 cookie, DL-15492 home
  notification, DL-15499 QA, and DL-15559 backend work.

## Jira status snapshot checked on 2026-07-15

- DL-15162: complete.
- DL-15489, DL-15493, DL-15494, DL-15495, and DL-15503: Ready for Deploy.
- DL-15490, DL-15491, and DL-15492: In Progress.
- DL-15499: QA Todo; DL-15544 and DL-15559: In Progress.
- DL-15570 and DL-15575 remain Todo in Jira even though the requested frontend
  implementation and Notion development taxonomy updates are complete. Jira
  status/comments were not mutated in this session.
- Re-read Jira comments and relevant child cards where the user is assignee,
  reporter, or mentioned. Recheck live Jira before changing ownership/status.

## Analytics contract and deliberate interpretations

- DL-15575 adds `onboarding_click` with `onboardingType` values
  `fee schedule`, `scanner`, and `payment`; `create_account_complete` fires
  directly in the successful ordinary or verified signup mutation callback.
- No `_app` effect or analytics-only `sessionStorage` marker remains. The
  separate `sessionStorage` in `pages/auth/signup.tsx` is pre-existing
  multi-step form navigation/recovery state, not event delivery state.
- DL-15570 event names are exactly `pending_members_button_click`,
  `invite_members_button_click`, `pending_members_action_click`,
  `pending_members_dropdown_changed`, `invite_email_chip_delete`,
  `invite_send_clicked`, `invite_send_succeeded`, and `invite_send_failed`.
- Documented properties are exactly `isAlert`, `actionType`, `memberStatus`,
  `isFormatError`, `inviteCount`, `roleType`, `authorityType`, and
  `roleAuthorityCombinations`.
- Event calls and property mapping remain in existing feature files. Do not
  recreate separate analytics mapper or feature-specific test files unless the
  user explicitly requests them.

- Notion names the property `isFormatError` but explicitly defines normal chip
  as `true` and error chip as `false`; implementation follows the documented
  values rather than the misleading name.
- Success properties are typed String while one event may contain multiple
  invitations. Role, authority, and role-authority combinations are serialized
  as comma-joined values so every invitation remains represented.
- Notion lists Admin, Billing Manager, and Member authority examples, while the
  approved UI also exposes Viewer. Viewer is tracked with the same mapping and
  remains a documentation gap to confirm with product/data owners.

## API contract details

- Register validation posts `{ employerId, email }`.
- Existing-member acceptance posts `{ employerId }` to
  `/office/employees/invitations/accept`; the response is void.
- Invitation signup sends `code: null` and `invitation: { employerId }` while
  omitting role, referral, funnel, first-funnel, and second-funnel values.
- Generated accept error codes reviewed: 2140 no invitation/wrong account,
  2134 already accepted, 2135 canceled, 2112 expired, 2020 already an office
  member, 2023 pending approval, 2024 suspended, and 2053 affiliation limit.
- Current UI presents generic acceptance failure except for account-email
  mismatch. Do not invent per-code copy or success recovery without an explicit
  product decision.

## Verification

- Clinic TypeScript check passed; the final commit hook also passed Clinic,
  Lab, and Admin TypeScript checks.
- No feature-specific test files remain after the user-requested cleanup. The
  repository's default Jest command still fails to parse
  `clinic/jest.config.ts` because it imports `next/jest` instead of the
  ESM-compatible `next/jest.js`; this also reproduces on `origin/master`.
- Changed-file Prettier and Clinic ESLint passed. ESLint reported six existing
  warnings and no errors.
- The final push hook passed full Clinic/Lab/Admin lint and shared coverage.
  It reported 419 repository-existing warnings and no errors.
- Isolated shared-UI ESLint is blocked by the repository's duplicate Storybook
  plugin versions, but the full push hook lint succeeded.
- On current `origin/develop`, standalone Clinic and Lab TypeScript have a
  baseline PNG module declaration error in `BrowserPDFHeaderUI.tsx`; Admin type
  passes. Do not attribute it to PR #4378 or the final scope review.

## Development server QA

- Rechecked the successfully deployed API-only develop build in desktop and
  390x844 mobile viewports.
- Verified invalid invitation query handling and Close routing to sign-in.
- Verified a real existing-user valid invitation and a real new-user valid
  invitation against employer 86. The existing-user link preserved the invite
  query through sign-in; the new-user link opened the two-step invitation
  signup with its email prefilled and disabled.
- Verified an uninvited new email falls back to ordinary signup after the
  invalid-invitation popup.
- With an authenticated owner session, verified the managed-member Pending
  Members entry, All/Pending/Expired tabs and counts, expired empty state, and
  Invite Members modal email-chip validation states.
- Did not execute final Join Office, account creation, resend, cancel, approve,
  reject, delete, or send mutations because those operations change shared
  development data. The latest DL-15575/DL-15570 analytics commits were also
  intentionally not included in the API-only develop deployment, so their live
  event delivery was not claimed; their code paths, type checks, lint, and
  formatting checks passed.

## Remaining work

1. If live analytics QA is explicitly requested later, first verify the exact
   deployed revision; until then, do not monitor deployment or claim events live.
2. Verify actual Amplitude network delivery for the exact event/property names.
3. Run state-changing end-to-end QA for final account creation, existing-account
   acceptance, active-office switching, and mutation failure recovery in an
   isolated test account/office.
4. Verify actual email-link/template, invitation cookie, and home-notification
   entry paths with DL-15490, DL-15491, and DL-15492 integrated.
5. Complete the DL-15499 QA pass across member management, Pending Members,
   Invite Members, recipient flow, responsive states, and analytics delivery.
6. Confirm the `isFormatError` naming/value inversion, multi-invite String
   serialization, and Viewer authority taxonomy with product/data owners if
   they require different reporting semantics.
7. Decide whether accept-API race codes such as already accepted/already a
   member should receive dedicated success recovery; no product copy or explicit
   frontend behavior is currently specified, so the UI keeps generic failure UX.

## Resume order

1. Pull `codex-personal-context`, fetch the shared repository, and confirm PR
   #4353 still targets `master` with HEAD at least `648822fcc`.
2. Read current Jira comments and child-card status before deciding whether a
   failure belongs to frontend, backend, email, cookie, notification, or QA.
3. Continue only the remaining state-changing/integrated QA before adding
   speculative error-code UX.

---

# Historical checkpoint - 2026-07-14

This is a historical snapshot and may describe APIs, branch state, or remaining
work that has since changed. Use the 2026-07-15 section above as the current
checkpoint.

Repo: `/Users/parkjongsun/Repository/dentlink-client-invite`
Branch: `feature/DL-14232`
Pushed HEAD: `91a630fef [DL-14232] fix: 초대장 UI 및 가입 API 계약 반영`
Remote: `origin/feature/DL-14232` matched local HEAD (`0/0` ahead/behind)
Worktree: clean
PR: [#4371](https://github.com/Innvoaid/dentlink-client/pull/4371), merged into
`develop`; Auto Assign and CodeRabbit checks succeeded
Develop merge SHA: `b5749bea76d2113459c43594ef68838c02050655`
Legacy comparison PR: [#4353](https://github.com/Innvoaid/dentlink-client/pull/4353),
Open Draft, base `master`, intentionally untouched

## Pushed baseline

- Admin, Lab, and Clinic sender-side invitation management APIs and generated
  models are connected for the currently available contract.
- Clinic member list, member detail drawer, Pending Members page, Invite Members
  modal, role/authority actions, and invitation actions are implemented.
- Clinic recipient entry uses
  `/invitations?type=INVITATION&employerId={id}&email={email}`.
- An additional email-link `id` parameter is currently ignored by Clinic;
  validation uses `employerId` and `email`.
- `/invitations` owns invitation validation for email and notification entry,
  then routes according to validation status, existing-account state, and auth.
- Valid or expired new-account signup uses the invitation flow and sends
  `code: null` with `invitation: { employerId }`; ordinary entry without valid
  invitation data keeps the normal verification-code signup flow and sends
  `invitation: null`.
- Invitation signup no longer overrides `firstFunnelChannel` or
  `secondFunnelChannel`; the existing frontend funnel resolution remains in
  place until the backend-generated contract is available.
- Referral and invitation funnel cookies remain separate, while the latest
  funnel entry replaces the previous funnel cookie.
- The temporary frontend `roleType` fallback requested during backend debugging
  was removed after the API accepted the real signup value.

## Recipient flow QA observed

- Existing account, signed out, valid invitation to another office:
  validation returned `VALID` with `isExistingUser: true`; sign-in and return to
  the invitation flow worked in user QA.
- New account, signed out, valid invitation:
  `/invitations` displayed its validation loading spinner and routed to signup
  step 0 after `VALID` with `isExistingUser: false`.
- The spinner before signup is owned by `/invitations` and
  `useOfficeInvitation` while router readiness and validation resolve.
- The final `Close` action returns an existing user to the current office home.
- Final `Join Office` Employee bypass still depends on the dedicated backend
  API that is expected separately.

## Terminology and backend work split

- `Signup 회원가입 수정` means the new-account flow through
  `POST /office/users`: nullable `code` and `invitation: { employerId }` for a
  valid or expired invitation. Do not call this Employee bypass.
- `Join Office Employee bypass` means the existing-account flow from the
  `/invitations` page: click Join Office, call the separate bypass API, receive
  the Employee result, switch the active office, and go home.

## Latest pushed review checkpoint

- Develop follow-up PR [#4371](https://github.com/Innvoaid/dentlink-client/pull/4371)
  was merged with two new commits after the previous develop deployment:
  `ae44eb60e [DL-14232] refactor: 레이아웃 transient prop 정리` and
  `91a630fef [DL-14232] fix: 초대장 UI 및 가입 API 계약 반영`.
- Recipient invitation page `296:71550` now uses the final product decision:
  no expiration display, `Close / Join Office`, actions in normal mobile
  document flow rather than a fixed footer, a filled office icon, and the
  phone icon without its embedded white rectangle.
- `validation-register.expiresAt` remains in the response model and mapper but
  is no longer consumed by invitation presentation, cookie lifetime, or signup.
- Account mismatch uses the generic Invalid Invitation copy instead of the
  removed design-external `Invitation email mismatch` message.
- `OfficeUserJoinDto.code` is nullable and optional, and the provisional
  frontend model includes nullable invitation data with an employer ID. These
  generated-model edits must be regenerated and compared after backend deploy.
- The branch-wide code and Figma review requested after `ad951b4f5` is complete
  and was committed and pushed as `e7ac68537`.
- The committed review covers Admin, Clinic, and shared UI files. It contains
  the final code corrections identified before backend-complete QA.
- Follow-up commit `838ac53ad` documents the missing backend Join contract at
  its exact integration point without introducing a speculative HTTP request.
- Review focus is project-method alignment, not cosmetic naming alone:
  component composition, existing props, hook boundaries and naming,
  query/mutation behavior, state ownership, responsive layout, loading/error
  behavior, and shared-component side effects.
- The pushed work includes the Admin invitation-hook naming alignment, recipient
  flow corrections, member/pending-list responsive cleanup, and minimal shared
  UI corrections.
- `PendingMemberEditableField` now has a Clinic domain alias used consistently
  by the pending-member hook and components.
- Popup Escape propagation now uses the existing opt-in prop to stop later
  listeners on the same target, so a removal popup does not also close its
  member drawer. The default shared Popup behavior is unchanged.
- Invitation validation again follows the app's default window-focus refetch
  behavior so an invitation changed while the tab was away is revalidated.
- The mobile member list no longer displays the obsolete Requested state;
  requested users remain in Pending Members as specified by Figma.
- Recipient office addresses now combine state and ZIP code in the existing
  US address presentation.
- No ad hoc test file was added.

## Latest static verification

- Commits `ae44eb60e` and `91a630fef` passed the commit hook's Clinic, Lab, and
  Admin type checks.
- The final push passed Clinic/Admin/Lab full lint and the shared coverage
  guard. Existing repository warnings remained but did not fail the push.
- Admin, Clinic, and Lab type checks passed for the current review set.
- Clinic, Admin, and Lab app lint checks passed with repository-existing
  warnings only; no changed invite/member file introduced a warning.
- The three changed shared UI files passed ESLint when run with the shared UI
  package's own config. Running them through the root config remains invalid
  because the repository resolves two `react-hooks` plugin versions.
- All changed files passed Prettier check. The command still reports the
  repository's existing unknown import-order option warnings.
- `git diff --check` passed.
- Commit hooks passed Clinic, Lab, and Admin type checks.
- Push hooks passed app lint and the shared coverage guard; repository-existing
  lint warnings remained but did not fail the push.
- The recipient invitation page was visually checked in local Chrome during
  implementation for desktop and mobile layout before the final commit. The
  new signup request cannot be end-to-end verified until the backend contract
  is deployed.

## Current stage

- Frontend implementation, final invitation-page design, and the provisional
  new signup contract were pushed and merged into develop through PR #4371.
- The backend Signup 회원가입 수정 contract described by the team is not
  deployed yet. FE
  currently assumes `code: null` and `invitation: { employerId }` for valid or
  expired invitation signup, and `invitation: null` for ordinary/canceled flow.
- Until the dedicated Join acceptance API is available, the useful next work
  is browser QA of all frontend-complete states rather than speculative API
  implementation.
- `officeInvitation.api.ts` contains a `TODO(DL-14232)` at the exact Join Office
  Employee bypass integration point. The pending generated API must accept the
  invitation's employer ID and email, create or return the Employee, then
  return its `employeeId` for the existing active-office switch flow.
- QA should cover member list/detail, Pending Members, Invite Members modal
  validation and server-classified email errors, recipient validation and auth
  routing, signup invitation mode, notification entry, responsive behavior,
  and mutation loading/error recovery.
- Record failures by route, account/auth state, invitation status, expected
  Figma state, actual UI, and network response so backend blockers remain
  separate from frontend defects.

## Figma review scope

- Clinic member list and mobile variants
- Clinic member detail drawer and mobile fullscreen presentation
- Pending Members page: `224:46661`
- Invite Members modal and error states: `296:50698`
- Recipient invitation page: `296:71550`
- Signup role step: `275:11988`
- End-to-end invitation flow: `362:45613`

## Remaining work

1. After the Signup 회원가입 수정 backend deploys, regenerate shared API models
   and compare field naming, requiredness, and nullability with the provisional
   FE types.
2. Re-run valid, expired, canceled, and ordinary signup network QA and verify
   the exact `code`, `invitation`, and funnel payloads.
3. Connect the `Join Office` Employee bypass API when its dedicated backend
   contract is generated and confirmed, then re-run active-office switching
   and error recovery QA.
4. Commit or push any future shared Dentlink changes only on explicit user
   request.

## Resume on another device

1. Pull `codex-personal-context` and read this current checkpoint before using
   chat or runtime memory.
2. Fetch the shared repository, checkout `develop`, and fast-forward it to at
   least merge SHA `b5749bea7`.
3. Start backend follow-up work from the latest `origin/develop`, not directly
   on the old `feature/DL-14232` history. PR #4371 was squash-merged: the old
   feature branch and develop currently have the same tree, but their histories
   report `1/2` divergence.
4. Confirm the deployed signup schema before editing: regenerate models and
   inspect `OfficeUserJoinDto.code` and `invitation.employerId` nullability.
5. Resume with valid/expired/canceled/ordinary Signup 회원가입 수정 network QA,
   then connect the separate Join Office Employee bypass API when its generated
   client becomes available.

## Durable implementation rules

- In Dentlink and repositories derived from `dentlink-client`, matching the
  project means matching the complete implementation method, not only CSS or
  naming.
- Use the closest equivalent in the current app, base, and installed library
  version for components, props, hooks, API/query/mutation style, state, types,
  errors, routing, responsive layout, imports, and naming.
- Choose responsive breakpoint direction and layout composition from the
  surrounding current implementation; a valid `maxTablet` alternative is not a
  reason to ignore an established mobile-first `tablet` pattern.
- A concrete user comment is a request to audit the full changed scope for the
  same root pattern.
- Prefer existing primitives and usage composition. Deviate only for a concrete
  unmet requirement, keep the change minimal and additive, preserve defaults,
  and review all affected consumers.
- Shared project code commits, pushes, and PR mutations require explicit user
  authorization. Personal-context closeout synchronization does not.
- Jira remains out of scope until the user requests it again.

---

# Historical checkpoint - 2026-07-10 closeout

This is a historical snapshot and is preserved for the user's project history.
Use the 2026-07-14 section above for the current checkpoint.

Repo: `/Users/parkjongsun/Repository/dentlink-client-invite`
Branch: `feature/DL-14232`
Remote HEAD: `470c45c55 [DL-14232] feat: 치과 회원가입 역할 선택 항목 추가`
Status: local and remote SHA matched; worktree clean at closeout
PR: [#4353](https://github.com/Innvoaid/dentlink-client/pull/4353), Open Draft,
base `master`, merge state `DIRTY`

## Latest signup Step 3 update

- Figma source: `kOTUAdts2gBFsF9Yr3Q5PL`, node `275:11988`.
- `/auth/signup?step=3` now shows the required role options in the Figma order:
  Dentist, Office Manager, Assistant, and Hygienist.
- API values are `DENTIST`, `OFFICE_MANAGER`, `DENTAL_ASSISTANCE`, and
  `HYGIENIST` respectively.
- `OfficeUserJoinDto.roleType` now uses the existing shared
  `EnumTypes.RoleType`, matching the updated generated API contract.
- The existing signup submit path spreads `roleType` into the payload sent to
  `POST /office/users`; invited/verified signup sends the same value to
  `POST /office/users/register`.
- Verification passed: direct Clinic type check, Clinic lint with existing
  warnings, commit-hook Clinic/Lab/Admin type checks, and push-hook app lint plus
  shared coverage guard.
- Actual browser/network QA was not run for this small follow-up.

## Resume order

1. Pull `codex-personal-context` and read this latest section.
2. Pull `/Users/parkjongsun/Repository/dentlink-client-invite`.
3. Check branch, `git status`, remote HEAD, PR state, and latest `master` before
   changing files.
4. Continue from the recipient invitation page/API workflow described below.
5. Do not inspect or update Jira unless the user requests it again.

## Branch-wide completed invite scope

### Admin

- Office/Lab invitation list and pagination
- Email validation and invitation creation
- Role/Authority update
- Resend/Delete
- Target selection and `USER` permission guard

### Lab

- Existing member invitation flow aligned to the new API structure
- Email validation and invitation submission connected
- Duplicate interaction guarded during validation/submission

### Clinic member management

- Member list Role/Authority display including `VIEWER`
- Member detail moved from standalone route to desktop side drawer/mobile
  fullscreen drawer
- OWNER authority update and member removal
- OWNER-only Pending Members entry on desktop

### Clinic Pending Members and Invite Members

- `/office/managed/invites` with `All / Pending / Expired`
- Employee approval requests and email invitations shown in one API-backed list
- Role/Authority updates
- Approve/Reject for employee requests
- Resend/Cancel/Delete for invitation rows
- Row/field-scoped mutation loading plus optimistic cache update/rollback where
  applicable
- Invite Members modal with up to ten emails, server validation,
  registered/invited/invalid classification, Role/Authority selection, and
  invitation creation
- Mobile entry and Invite Members modal remain intentionally unsupported by the
  confirmed requirement and are not an omission

### Shared/API foundation

- Admin/Lab/Clinic generated invitation management APIs and DTOs are present
- Clinic sender-side validate/create/resend/delete/update role/update authority
  APIs are connected
- `ChartDropdown`, `SlideDrawer`, Button design-system changes, Modal,
  MultiChipInput, Popup, and PopupMenu corrections are included

## Current partial scope: recipient invitation page

- Figma file: `kOTUAdts2gBFsF9Yr3Q5PL`
- Figma section: `296:71550`
- Route: `/invitations/[invitation_id]`
- Page: `clinic/src/pages/invitations/[invitation_id].tsx`
- UI: `clinic/src/components/OfficeInvitation/OfficeInvitationPage.tsx`
- Desktop/mobile design and long office-name/address behavior are implemented.
- The route still renders Figma preview data and does not read
  `invitation_id`.
- `Join Office` and `Remind Me Later` have no connected callbacks.
- Login redirect and return flow is not implemented. Intended shape:
  `/auth/signin?next=/invitations/{id}`.
- Recipient invitation detail, Join/Accept, loading, invalid, expired, and
  already-processed states remain.
- The generated Clinic model currently exposes sender-side management APIs but
  no confirmed recipient detail/Join API.

## Latest master integration blocker

Latest `origin/master` has moved to Next.js 16, React Query v5, and
styled-components 6. The feature branch still contains React Query v4-style
mutation syntax in invite work, so conflict resolution must preserve the
feature while migrating to the current base conventions.

`git merge-tree --write-tree origin/master HEAD` reported seven conflicts:

- `admin/src/lib/Invitation/useResendInvitation.ts`
- `admin/src/services/common/queryKeys.ts`
- `clinic/src/components/OfficeMemberList/OfficeMemberList.tsx`
- `clinic/src/pages/office/managed/members/[employee_id].tsx` (master modified,
  branch deleted)
- `clinic/src/services/employer/employer.query.ts`
- `lab/src/lib/members/useInviteCreate.tsx`
- `shared/ui/src/Button/Button.tsx`

The internal invite-management implementation works in the current branch
environment, but the PR is not merge-ready until these conflicts and major
dependency migrations are handled.

## Verification and test gaps

- Clinic type/lint passed before the latest WIP commit.
- Commit hook passed Clinic/Lab/Admin type checks.
- Push hook passed all three app lints with existing warnings and the shared
  coverage guard with no baseline change.
- `/invitations/preview` compiled and returned HTTP 200.
- No dedicated invitation test/spec/story covers email classification,
  source-type action routing, optimistic rollback, or recipient auth/Join.

## Next work

1. Confirm or generate recipient invitation detail/Join API contracts.
2. Read `invitation_id` and connect server data and page states.
3. Implement unauthenticated sign-in redirect and return to the invitation.
4. Implement Join Office and confirm Remind Me Later destination policy.
5. Merge latest `master`, resolve seven conflicts, and migrate invite code to
   current React Query/Next/styled-components conventions.
6. Recheck shared UI side effects and Admin/Lab/Clinic regressions.
7. Add focused tests, run type/lint and actual UI/API QA, then clean up the
   Draft PR.

## Durable user rules from this work

- `메모리` means the Git-backed `codex-personal-context` repository by default.
- Pull this personal context and the project repository at work start.
- Intermediate steps do not require constant memory commits, but meaningful
  closeout must update, commit, and push the personal context. Explicit
  commit/push permission is required for the shared Dentlink repository, not
  for personal memory synchronization.
- Reuse existing project components and props before introducing wrappers or
  new shared behavior.
- One feedback example should trigger a search for equivalent occurrences.
- `진행해` does not authorize commit, push, or PR mutation. Require explicit
  wording such as `커밋해`, `푸시해`, or `PR 수정해`.
- Jira is out of scope until the user asks again.

---

# Dentlink Invite checkpoint - 2026-07-09 design QA

Repo: /Users/parkjongsun/Repository/dentlink-client-invite
Branch: feature/DL-14232
Latest pushed commit: f00341b5d [DL-14232] fix: 멤버 상세 정보 보더 수정
Status: pushed, worktree clean

## Session 2026-07-09 post-QA follow-up

- Follow-up commit pushed after member-detail visual review:
  - `f00341b5d [DL-14232] fix: 멤버 상세 정보 보더 수정`
- Member detail `Member Info` no longer has an outer border/radius/overflow wrapper.
- Row-to-row divider lines remain, matching the intended non-table-like Figma structure.
- Jira DL-14232 comment `43085` records the follow-up commit and verification.
- Verification for this follow-up:
  - `git diff --check` passed.
  - `pnpm --filter dentlink-clinic-web type` passed.
  - `pnpm --filter dentlink-clinic-web lint` exited 0 with existing project warnings.
  - Commit hook ran clinic/lab/admin type checks and passed.
  - Push hook ran lint and shared coverage guard and passed with existing warnings/output.

## Session 2026-07-09 design QA completed work

- Figma source used for the latest QA pass:
  - Invite page node: `224:46661`
  - Pending Members design area: `224:46663`
  - Invite modal section/frame checked through Figma MCP screenshot/context
- Added shared `ChartDropdown` for chart/table-internal compact dropdowns:
  - Built as a DropdownBase/PopupMenu-style shared UI component, not a one-off table implementation.
  - Menu is portaled to `modal-root` and uses fixed positioning so it is not clipped inside list/table containers.
  - Trigger height, typography, hover/focus/open state, selected-row background, and menu sizing were aligned to the Figma chart dropdown requirement.
- Clinic invite page/table QA fixes:
  - `/office/managed/invites` table min height now follows the design intent: 44px header + 300px body minimum, not an arbitrary 548px fixed/min height.
  - Header background, row height, first/last column padding, top/bottom borders, last-row border behavior, title spacing, help-link typography, and status dot/label colors were adjusted.
  - Mobile invite page entry remains unsupported/hidden by requirement.
- Invite Members modal QA fixes:
  - Modal width/min-height, left/right columns, email input copy, Member Info table header/body sizing, empty state copy, draft table scroll behavior, and footer button widths were aligned to Figma.
- Member list/detail QA fixes:
  - Member detail profile header now allows full-name wrapping without ellipsis and keeps authority badge plus `(Me)` beside the badge.
  - Member Info row separators and text typography were normalized to shared Typography variants and palette tokens; outer list border was removed in the follow-up commit so it does not read as a table box.
  - Member authority dropdown selected-check icon was removed per design.
  - PopupMenu outside-click detection was fixed so clicking drawer blank/dim areas closes the dropdown instead of treating the entire portal root as inside.
- Jira DL-14232 was updated with the latest pushed commit and verification summary.

## Verification for latest design QA commit

- `git diff --check` passed.
- `clinic` direct TypeScript check passed with `cd clinic && ./node_modules/.bin/tsc --noEmit`.
- Commit hook ran clinic/lab/admin type checks and passed.
- Push hook ran lint-staged, clinic/lab/admin lint, and coverage guard; it completed successfully with existing project warnings.
- Build and Computer Use QA were intentionally not run in this Codex pass because the user excluded them and planned to do Computer Use QA directly.

## Current remaining work

- Real clinic invite APIs for create/resend/cancel/delete/update are still not generated/available in the clinic model.
- DL-15494 / BE-side invite API readiness is still the blocker for replacing mock/local invite create and invitation-source actions.
- After the user completes Computer Use visual QA, continue with code-level review in three scopes if requested:
  - today design QA scope
  - clinic invite/member-management scope
  - full branch invite-related scope

## Session 2026-07-09 completed work

### API 연동 (/office/managed/invites — DL-15493 범위)

- `usePendingMembersQuery(status)` 생성 — `findEmployerOwnPendingMembers({ status })` API 호출
- `useOfficePendingMembers` 훅: mock 로컬 상태 → 실제 API 기반 전환
- 탭 상태: URL query `?status=ALL|PENDING|EXPIRED` 로 관리 (Next.js router.push shallow)
- 탭 카운트: `OfficePendingMemberListDto.counts.all/pending/expired` 직접 참조 (별도 카운트 API 없음)
- `useEmployeeApproveMutate` / `useEmployeeRejectMutate`: success 시 `EMPLOYER_OWN_PENDING_MEMBERS` query invalidate

### 코드 리뷰 수정 (15개 파일 — 커밋 e4fc864a8)

- `canRemoveMember` undefined guard 추가
- `OfficeMemberAuthorityChip`: 로컬 타입 → `EnumTypes.AuthorityTypes`
- `OfficeMemberDetailDrawer`: inline `matchMedia` → `useIsBelowTablet()` hook
- `(Me)` 라벨: `body3 gray700` → **`body2 bold information`** (Figma node 103-13728 반영)
  - `OfficeMemberList` (데스크탑 테이블), `OfficeMemberMobileList` (모바일 카드) 모두 수정
- `InviteMembersModal`: `Date.now()` ID → `useRef` 카운터 (`draftIdCounter.current += 1`)
- `MAX_INVITE_EMAIL_COUNT = 10`: `InviteMembersModal.types.ts`에 중앙화, Modal/EmailPanel 양쪽 import
- `OfficePendingMembersDropdown`: `option.label === value` 매칭 제거 (value만 사용)
- Page/Table 네이밍·flex 컨벤션 통일 (`StyledPageWrapper`, `StyledSection`, `DisplayFlexRow/Col`)
- `SlideDrawer`: 스크롤 락 타이밍을 `$isOpen` → `isMounted` 기준으로 변경
  - (닫힘 300ms 애니메이션 중에도 스크롤 잠금 유지)
- admin `useInvitations`: query 로직 hook 내부로 이동
- admin `useInviteCreate`: `ApiResponseDto` import를 `@dentlink/models` → `@models/common/base`로 수정; `handleSubmit` 두 번째 인자 제거 (react-hook-form 타입 에러)

### 버그 수정

- **`handleInviteMembers` lint 에러** (`c5ba31238`): `@typescript-eslint/no-empty-function` — 멀티라인 빈 함수를 한 줄로 collapse하고 eslint-disable-next-line 적용
- **`StyledMobileList` display:none 깨짐** (`50dbae903`): `styled(DisplayFlexCol)` → `styled.div` 원복
  - 원인: styled-components CSS 주입 순서로 `DisplayFlexCol`의 `display: flex`가 `display: none`을 덮어씀
  - 교훈: `display` 속성을 동적으로 제어해야 하는 래퍼는 `styled(DisplayFlexCol)` 확장 불가. `styled.div`로 작성 후 미디어쿼리 안에 `display: flex; flex-direction: column` 명시

## Remaining work (DL-15494)

- 초대 생성 API (`createInvitation`) 연동 — BE 준비 대기
- Resend / Cancel / Delete mutation — invitationId 기반, BE 미준비
- Role / Authority 수정 API — sourceType별 분기 (`EMPLOYEE`: updateEmployeeRole/Authority, `INVITATION`: BE 미준비)
- 모바일 초대 페이지 디자인 미확정 — Figma 확정 후 반영

---

# Dentlink Invite checkpoint - 2026-07-08

Repo: /Users/parkjongsun/repository/dentlink-client
Branch: feature/DL-14232
Latest pushed commit: 3cafb25f0 [DL-14232] docs: 프로젝트 Claude 가이드 복구
Status: pushed, worktree clean at the time of handoff

## User direction / constraints

- Always answer the user in Korean honorific style.
- Goal for clinic invite work: complete UI/design work up to immediately before real invite API integration.
- Do not call invite APIs directly while checking UI.
- No e2e required for this task; only UI click/smoke checks were requested.
- Use existing project UI/design system first. New styling/components are allowed only when there is no suitable existing component or when a local adapter is needed.
- Figma is the reference, but implementation should follow existing project conventions where exact Figma parity conflicts with established components.
- Do not commit additional changes unless the user explicitly asks.
- Mobile scope rule: judge mobile completion only against mobile designs that actually exist in Figma. Do not mark an area incomplete only because responsive code is not obvious when no mobile design was provided.

## Branch-wide invite-related completed work

### Admin completed

- Included branch commit: 150345436 feat: 어드민 초대 기능 신규 API 전체 대응 및 기공소 리팩토링 (DL-15489)
- Admin invitation list was updated for the new invite API flow.
- Admin member invite creation was added through MemberInvitesAdmin.
- Admin invitation email validation/create hooks were added.
- Admin invitation resend and delete flows are wired.
- Admin invitation list filtering/query handling and query key were updated.

### Lab completed

- Lab member invite creation logic was refactored.
- Lab invite UI continues through the shared MemberInvitesUI flow.
- Existing Lab invite list/update/resend/cancel flow remains in place.

### Clinic member management completed

- Included branch commits: DL-15493 series 95d993e1a, 370f122dc, e261acc11, 291dfb61c.
- /office/managed member list shows Pending Members entry point only for OWNER authority.
- OFFICE_MANAGED_INVITES link constant points to /office/managed/invites.
- Member list authority chip was added/normalized.
- Member detail was changed to drawer-based UI; old standalone detail route/components were removed.
- Member detail drawer and authority UI were adjusted to existing project UI primitives.

### Clinic invite page and modal completed

- Included branch commits: faad6f8a4, ef4a0606a, 1043ad396, 34e9c0ee8.
- Added /office/managed/invites route guarded by OWNER authority.
- Added OfficePendingMembersPage using mock/local state.
- Added mock invite data, invite types, and useOfficePendingMembers local-state hook.
- Implemented All / Pending / Expired tabs.
- Implemented Pending Members table with Email / Role / Authority / Status / Action columns.
- Implemented role and authority dropdowns using existing DropdownBase through a clinic-local adapter.
- Implemented status labels for Pending Acceptance, Pending Approval, and Invitation Expired.
- Implemented action buttons for Resend / Cancel / Approve / Reject / Delete as UI/local handlers.
- Implemented responsive/mobile list representation.
- Implemented Invite Members modal against the later-provided Figma modal design node, using existing project UI primitives/components where possible.
- Invite modal uses existing Modal, Button, Typography, Icon, MultiChipInput, and clinic-local dropdown/table composition.
- Invite modal follows the lab-style invite concept: email pre-validation first, then later send/create invite API when Clinic APIs are available. Real Clinic invite APIs are not available yet, so current submit remains mock/local.
- Role/authority dropdown option data uses available code APIs with mock fallback.
- Reworked invite page to use existing UI primitives: Tabs, DataListTable, DropdownBase, Modal, Button, Chip, Typography, Icon.
- Removed over-splitting where possible; kept local table/dropdown/modal components because they are clinic invite specific adapters/compositions.

### Figma/design notes confirmed

- Figma source: 0097. 치과 employee 초대 기능, node 101:4640 / invite page area 224:48715.
- Invite modal Figma node used during the session: 224:31671.
- Confirmed invite layout: toolbar height 54, tab compact instances, Invite Members button, Pending_chart/card, 55px card header, table header 44px, rows 72px, role/authority dropdowns 160x37.
- Help link text: Check role & authority differences.
- Help icon is Arrow/diagonal-line; screen used SvgArrowDiagonalLine but icon/style was reviewed against Figma.
- Pagination/stepper should not be shown because it was removed/hidden recently.
- Mobile completion must be judged only against provided Figma mobile screens. At closeout, code-level responsive existence alone was not used as the source of truth.
- Figma Desktop MCP reconnect was later confirmed. The specific invite modal section node `224:31671` is accessible, but it returns sparse section metadata; future agents should inspect actual child frames/screenshots before making new design-completion claims.
- Codex in-app browser Figma web SSO was attempted so Figma could be used without Desktop MCP, but it stopped on a blank `finish_google_sso` callback page. Treat Desktop MCP as the reliable Figma path unless web auth is completed separately.

## Verification already done

- Commit hook type checks passed when committing ef4a0606a.
- Push to origin/feature/DL-14232 succeeded.
- Browser UI smoke checked without direct API calls:
  - /office/managed/invites rendered.
  - All/Pending/Expired tab interaction worked.
  - Role/authority dropdowns opened and selection responded.
  - Invite Members modal opened/closed.
  - /office/managed member list rendered.
  - Member detail drawer opened.
- Additional final branch verification completed later:
  - master comparison PR created: https://github.com/Innvoaid/dentlink-client/pull/4353
  - develop comparison PR #4352 was merged; user later said only master comparison matters.
  - Project memory files were removed from the master PR diff where they were not part of the branch scope; `claude.md` was restored to the master version instead of deleting upstream content.
- Push hook produced existing lint/coverage output but did not block push.

## Remaining work

### Clinic remaining before completion/release

- Connect real clinic invite APIs.
- Replace mock data/local hook with API/query/mutation hooks.
- Map API DTO values for role, authority, status, expiration dates, and actions.
- Wire create invite, resend, cancel, approve, reject, and delete to real mutations.
- Add server-backed loading/error/empty behavior.
- Revisit Invite Members modal only if Figma changes or API integration requires behavior changes.
- Do final QA after API integration.

### Jira correction / important warning

- Do not treat `DL-15495` (`[FE] 디자인시스템 변경 대응`) as part of the known user-approved DL-14232 invite scope.
- In this session, `DL-15495` was mistakenly updated in Jira. The incorrect comment was edited to mark it invalid, and the DL-14232 parent comment was corrected to exclude DL-15495.
- DL-15495 status was later rechecked through Jira MCP and confirmed back in Todo / `해야 할 일`.

### Current overall judgment

- Admin/Lab invite API-related work is already included in this branch and should be treated as completed scope unless new regressions are found.
- Clinic invite work is complete only to the API-before stage: UI shell, design-system cleanup, routing, owner-only entry point, and local/mock interactions are done.
- The main remaining blocker is real Clinic invite API integration.


---

# Dentlink Invite: Office Member Detail Drawer checkpoint

Date: 2026-07-07
Repo: /Users/parkjongsun/Repository/dentlink-client-invite
Branch: feature/DL-14232
Related work: DL-14232 / DL-15493 member management invite flow

## Confirmed direction

- Member detail is no longer a standalone route/page experience.
- Desktop and mobile both open member detail from /office/managed list interaction.
- Desktop presentation is a right-side drawer.
- Mobile presentation is fullscreen via the same drawer shell behavior.
- X closes back to the member list; mobile does not navigate to /office/managed/members/[employee_id].
- The new drawer layout is a reusable shared UI component, not member-specific code.
- This page composes that reusable drawer with Office-specific member detail content.

## Implemented structure

- shared/ui/src/SlideDrawer/SlideDrawer.tsx: reusable portal-based slide drawer with dim, Escape close, body scroll lock, right-to-left animation, responsive 100% mobile width.
- clinic/src/components/OfficeMemberList/OfficeMemberDetail/OfficeMemberDetailDrawer.tsx: page-specific shell using SlideDrawer and member detail query.
- clinic/src/components/OfficeMemberList/OfficeMemberDetail/OfficeMemberDetailContent.tsx: Figma-based member detail UI and logic.
- OfficeMemberList and OfficeMemberMobileList both keep selectedEmployee state and open OfficeMemberDetailDrawer instead of navigating.
- employeeSnapshot from list is used for immediate render; useEmployeeDetailQuery(employeeId) refreshes with detail data.
- Authority change and Remove Member logic moved into OfficeMemberDetailContent.

## Removed old route/code

- Deleted /office/managed/members/[employee_id].tsx.
- Deleted old Grid-based detail components: MemberDetailLayer, MemberInfo, MemberDelete, MemberRequest.
- Removed OFFICE_MANAGED_MEMBERS link constant usage and menu entry.
- Existing member detail route was verified as 404 after deletion.

## Figma/design notes

- Source design: 0097. 치과 employee 초대 기능, Office & Member Details, drawer1-1 variants.
- Figma requirements followed: profile header, full name without ellipsis, authority chip, Me beside chip, Member Info rows, authority dropdown arrow for admin-editable case, Remove Member for valid admin case, desktop right drawer, mobile fullscreen, X close.
- Figma Make animation guidance followed in SlideDrawer: open 500ms, close 300ms, fade/slide ease-in-out.

## Verification

- pnpm --filter dentlink-clinic-web type passed.
- Next dev compile for /office/managed succeeded.
- /office/managed returned 200.
- /office/managed/members/1 returned 404 after route removal.
- validateDOMNesting warning from PopupMenu trigger was fixed by changing the authority trigger from button to div.

## Next start point

- Code is committed and pushed on `feature/DL-14232`. Latest commit: `291dfb61c ui: 멤버 상세 권한 메뉴 스타일 보정 (DL-15493)`.
- Authority dropdown now uses the existing project `PopupMenu` with `useFixedPortal` so it is not clipped by drawer content or the Remove Member area.
- Member detail content was aligned to existing project UI primitives (`Typography`, `Button`, `PopupMenu`, `ProfileImage`, `Icon`) rather than raw one-off styled text/buttons where practical.
- Local `HEAD` and `origin/feature/DL-14232` matched `291dfb61c`; worktree was clean after push.
- Jira access was later confirmed in Codex. DL-15495 was rechecked and confirmed back in Todo / `해야 할 일`; do not include DL-15495 in the known DL-14232 invite scope.
