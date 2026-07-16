# Dentlink PDF label conversion - completed 2026-07-16

This is a completed personal project checkpoint. Verify live Git again only if
new work is requested for this feature.

Shared repo: `/Users/parkjongsun/Repository/dentlink-client`
Former worktree: `/Users/parkjongsun/Repository/dentlink-client-pdf`
Delivery branch: `feature/DL-15438`
Final branch HEAD: `b9682ee27 refactor: PDF 변환 큐 크기 제한 제거`
PR: [#4366](https://github.com/Innvoaid/dentlink-client/pull/4366), merged
into `release/v1.77.2` on 2026-07-13
Squash merge commit: `8267e89f1201a16c00e2e5958109a135f1898736`
Integration proof: the final branch and squash merge commit have identical
trees
Local state: the former worktree was removed on 2026-07-16; the local branch
was intentionally retained

## Completed scope

- Replaced browser-dependent label PDF rendering in Clinic and Lab with a
  Next.js server API that renders the first PDF page to PNG through PDF.js and
  `@napi-rs/canvas`.
- Kept only the DHL label fonts proven necessary for the current scope:
  Liberation Sans Regular/Bold and their license. CMap files and unused fonts
  were not committed.
- Statically imported the PDF.js worker so Next.js standalone tracing includes
  it without adding a separate public worker asset.
- Limited active conversions to two, retained an LRU/TTL result cache, blocked
  redirects and unapproved PDF hosts, and aborts PDF loading/rendering when the
  30-second timeout expires.
- Removed the bounded queue-size fast-fail in the final review commit; queued
  requests now wait behind the two active conversion slots.
- Preserved print-image race protection so a stale image load cannot overwrite
  dimensions after the source changes.

## Verification and decisions

- The user confirmed that the final local DHL PDF displays its text correctly.
- Clinic and Lab production builds passed during implementation; Clinic, Lab,
  and Admin TypeScript checks also passed.
- A Lab standalone smoke test sent eight simultaneous requests and received
  eight successful, identical PNG outputs with visible text.
- The final worker was present in the standalone output. The minimal font set
  was chosen deliberately for DHL; additional fonts or CMaps should be added
  only if a new real label format proves they are needed.
- The final two review commits added redirect blocking and abort-on-timeout,
  then removed the queue-size cap. GitHub lists both in the merged PR.

## Final handoff

- This task and worktree are complete. No additional commit, push, PR update,
  or local worktree action remains.
- Do not recreate the deleted worktree or resume this branch unless a new PDF
  rendering defect or explicit follow-up request appears.
- The retained local branch can be deleted separately later only with explicit
  user direction.
