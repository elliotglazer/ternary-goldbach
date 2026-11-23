# Rational j7 containment: repaired-source review amendment

2026-11-11. **The local persistence and identity repairs are verified by source inspection. Execution readiness and capability acceptance remain unestablished.** This amendment preserves the earlier review, SHA256 `DB0BEBD37792358F0118E083A5214949E8FB630B5E4B9B71EE83059424F7259D`, unchanged.

No inspected module was imported or executed. The only Python check parsed/compiled source text and verified file hashes; no native API, fixture, evaluator, runtime manifest or Lean build was used.

## Frozen inputs

| Artifact | SHA256 |
|---|---|
| `integration/rational_j7_containment_20261111.py` | `B39872907A8308551ABB6E78C5261F49BA3438460924EF37890C394CE3882732` |
| `integration/RATIONAL_J7_CONTAINMENT_PREFLIGHT_2026-11-11.md` | `F50E3C9D8189C93A07B57BD586972E01F01E88482B7DEA36636A2F88871B8598` |
| `audit/RATIONAL_J7_HOST_PREPARATION_2026-11-11.md` | `37A792EC451CB94D61EED6F7565F6E8160158861657681501A2FABCE7A0EF9E3` |
| `integration/rational_j7_supervision_20261111_common.py` | `0BB49255BCF82307BACFB3BA353A3D83217C2023D37DCCDAFE6DDE98623CF154` |
| Independent syntax/hash receipt, `audit/rational_j7_containment_static_amendment_20261111.json` | `F7769F15F5E396F9DFB913D576718F950B5111EB00B3C20F8A12003C4232A649` |

Paths are relative to the campaign agents directory. All four source/specification bindings were read; the two new author pins and unchanged earlier review were checked locally. The syntax check found one native CreateProcessW site with the intended `0x8000C` flags. It does not establish any Windows behavior.

## Local repairs checked

1. `account` now appends the raw native accounting and PID-list observation before testing query success, lengths or counts. The PID buffer requires assigned=list length at most eight, positive distinct PIDs, and `8+8*listed <= returned_length <= sizeof(buffer)`. `assign_resume` checks total one, zero limit terminations and the exact original-PID singleton before ResumeThread. These repair the missing length/singleton checks.
2. `wait_exit` saves exit-query success, exit code, memory and identity in the event array before its exit-code/peak predicates. Membership observations likewise precede rejection. The final H record refers to its raw arrays, so an ordinary caught failure retains the observations already appended.
3. `startup` checks the source hash, manifest nonce, valid native identity, PID, creation FILETIME and image spelling. Window validation checks nonce, exact command/flags, creator PID/creation time and the transferred process's image/PID/creation time. This binds the successful normal path to the actual created objects and their source, not just an arbitrary positive PID.
4. The subordinate exception wrapper now calls `failure_file` with its own process-local accounting/events. H's globals no longer stand in for R/S/W failure diagnostics. An intentional TerminateProcess does not run Python exception cleanup, so the specification correctly does not require a late subordinate failure file in forced-kill cases.
5. `cleanup_process` and `cleanup_job` record termination results and available observed waits. The case-failure loop records its per-handle waits; original handles remain the targets. These records distinguish an attempted termination, a signaled exit, and mere handle closure. An unavailable diagnostic or failed cleanup cannot produce a successful capability certificate.

Persistence remains conditional on reaching the handler and successfully writing within the bounds. The code does not make crash-atomic or asynchronous-kill durability claims. Raw arrays are bounded; the failure writer may explicitly mark truncation. A truncated failure record is not a successful certificate. If diagnostics themselves fail to serialize or fit, actual nonzero H exit and missing evidence must remain failure.

## Topology, count and identity scope

The three fresh chains retain the intended counts: normal H/R/S jobs 3/2/1; suspended-S gap H/R jobs 2/0; suspended-W gap H/R/S jobs 3/2/0. All require zero limit-triggered terminations. Counts are never pooled or relaxed. Normal exits are zero; forced exits require `0xC8F6`.

S is checked in H's job and outside its future R job; W is checked in H's and R's jobs and outside its future S job. The source ordering holds each created child suspended until H acknowledges the window. An unsignaled wait alone would not establish suspension; the checked CreateProcess/ack/ResumeThread ordering supplies that part of the claim.

DuplicateHandle preserves the original process/job object rather than rediscovering it from a possibly reused PID. The creator verifies H's PID/creation time before transferring handles. The extra H-held job handles change last-handle-close timing, so this test establishes inherited containment plus **explicit** H-job termination, not timing equivalence of kill-on-close with the numerical program. The repaired specification states this limit correctly. [Microsoft DuplicateHandle](https://learn.microsoft.com/en-us/windows/win32/api/handleapi/nf-handleapi-duplicatehandle), [Nested Jobs](https://learn.microsoft.com/en-us/windows/win32/procthread/nested-jobs).

## Remaining qualifications

**External launch gate is still open.** The specification explicitly identifies the internal 45-second guard's inability to interrupt a blocked native call, the need for actual external H exit/hash observation, and the initial H-to-R create-before-assignment gap. It supplies no external endpoint that safely terminates that gap. This is not repaired by adding another ordinary create-then-assign supervisor, and this review authorizes no such layer. No runtime manifest should be issued from this packet alone.

**One bound is worded too broadly.** The specification's phrase “a 3-second cleanup interval” must not be read as a single end-to-end cleanup deadline. `cleanup_process` has its own 3000-ms wait; a create failure can reach an enclosing cleanup path with another wait, and `run_case` starts a fresh three-second loop budget. The source supports bounded individual waits/loops, not one shared three-second deadline across all unwinding layers. The author was notified. This does not allow late success: H still checks the overall deadline before accepting its result, and an externally bounded real exit remains mandatory. A later source/specification revision must retain that distinction.

The 128-MiB per-process checks and the sum of H's observed peak plus up to three postexit process peaks are conservative individual-peak accounting, not a simultaneous process-tree measurement. H's final self-query is still pre-exit. The 2-MiB output cap includes the authorization and owned files; a future external wrapper's additional retained files/streams must also be counted. Fixed source paths, source hashes, exclusive token-derived directories and no worker/evaluator imports remain intact.

## Verdict

The identified local raw-record, self-binding and ordinary failure-persistence gaps have been repaired at the pinned source level. The planned membership/count experiment is coherent and keeps its narrow evidentiary scope. This is **not** an unqualified launch approval: the external timeout/initial-gap endpoint and the cleanup-bound wording above remain explicit. No capability PASS, postexit-query success or numerical result follows from this source review. A later actual result requires all three complete cases, unchanged hashes, actual observed H exit zero within its external bound, output/resource review, and independent assessment of the full evidence—not merely the shared validator's accepted header.
