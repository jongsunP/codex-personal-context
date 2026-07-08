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
