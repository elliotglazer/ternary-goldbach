# Independent static review of the rational j7 external host

Verdict: **PASS for the frozen H source and its stated interface, at static-preparation scope only.** No unresolved source correction remains from this review. The additional H/R/S/W nesting capability, separate S/R review, runtime authorization and actual completed executions are distinct gates. No target module, native API or numerical evaluator was executed here.

## Frozen inputs

Paths are relative to `work/qrh-campaign/agents/`.

| File | SHA256 |
|---|---|
| `audit/rational_j7_host_20261111.py` | `5E54971F8D8B8B008556C60648C0D451F5270DCB99FDB5161954C88543BF31FB` |
| `audit/RATIONAL_J7_HOST_PREPARATION_2026-11-11.md` | `37A792EC451CB94D61EED6F7565F6E8160158861657681501A2FABCE7A0EF9E3` |
| `audit/rational_j7_host_preparation_20261111.json` | `1A8A994ABDB46F99301C324151DBE9FCC4E92DA9790111055BEEE810C313931A` |
| `integration/rational_j7_supervision_20261111_common.py` | `0BB49255BCF82307BACFB3BA353A3D83217C2023D37DCCDAFE6DDE98623CF154` |
| `integration/rational_j7_supervision_20261111_managed.py` | `F90F2DCC39A2659C2AF372EFEC19CCA73A3E679CE2AFDDAC12DABC0E209423C9` |
| `integration/rational_j7_supervision_20261111_native.py` | `CFC956B179C45AFAEAB5EA1DB42B05C06C643D0A10EC1682CBE0433248248E13` |
| `integration/rational_j7_supervision_20261111_run.py` | `755300B91BA4780D5713DEC6C192E6F60AF50ABE6330F1C258F95C59DD28486C` |

Independent AST/hash receipt: `independent-feasibility/rational_j7_host_static_review_20261111.json`, SHA256 `4E067121C677BA8580BF6F4D3A4DDCDC4E1E396463A62C980E6107472C64B54F`.

The review read the complete H source, its contract, the ownership/final-validator interfaces and inherited managed lifecycle, against design `E3FF0DD6…B6E60150` and review `DC0A0E11…DF769CA0`. All seven input hashes match. The source and dependency syntax checks compile text without executing it. This is not an independent repetition of the scientific worker arithmetic review or the full S/R review.

## Launch, identity and containment

H can launch only the pinned Python and fixed R entry with `-I -S -B`, the exact authorization path and integration working directory. Its sole CreateProcessW call uses `0x8000C`: detached, suspended, extended startup. The explicit inherited list contains NUL input and the two intended pipe writers; job/process handles are excluded. Original identity is captured, R is assigned to the H job, explicit membership and read-back limits are checked, and a fresh deadline check precedes the single resume.

The H job has active limit three, kill-on-close and no breakaway. It contains R and therefore its subsequently created S/W descendants, including the interval before those descendants enter narrower jobs. Initial failure before R's H-job assignment is handled through the original R process handle. This closes the identified outer preassignment gap in the source design.

H keeps that original handle through observed exit, the exit-code query and post-exit identity comparison. It binds R's startup seal to the same PID, creation time and image identity. It does not substitute a PID-reopened handle for R's lifetime evidence. Raw H accounting/PID observations and the exact total-three/zero-limit-termination requirements are carried into the host record and checked by the common validator.

The extra job layer was **not exercised by V5**. Authorization separately requires a `host_capability` evidence/review pair for topology H/R/S/W and active limits 3/2/1. The parser's required PASS fields are an interface, not proof that the test occurred: the coordinator must inspect genuine evidence and its review. Runtime membership/read-back checks remain mandatory even after that gate. This review supplies no such capability packet.

## Time, ownership and final acceptance

H supplies its own early monotonic timestamp; the caller cannot provide `host_start_ns`. The 750/1050-second whole-phase limit includes authorization serialization, R execution, validation and host publication. A 30-second prelaunch guard continues through resume. Polling checks the deadline after signaled exit as well as before waits. The host record's elapsed value is captured before publication; later guards enforce the same deadline through final validation. It is not a serialized measurement of H's future shutdown.

The coordinator must still observe actual H exit zero and apply its external completion/timing requirements. The pure `validate_host_chain` result cannot by itself prove that H really ran or exited normally. This is especially important for a late error after a success-shaped host file exists.

H checks the frozen infrastructure bytes before importing that infrastructure at authorized runtime, and fully validates the newly written authorization before constructing native bindings. It imports neither scientific worker. The 21,000-digit Python conversion limit now matches S/R; the shared parser's tighter field limit still applies. This avoids rejecting valid intended decimal fields at Python's default limit without weakening their semantic bounds.

The authorization and phase/output names must be fresh. R normally creates the owned directory. H keeps R streams in bounded memory until R exits or cleanup runs, then writes only its designated stream files. If R failed before directory creation, H may create the fresh directory for failure evidence. It does not preempt R's normal ownership check.

R streams retain at most 16 KiB each, with an overrun counted and rejected rather than silently accepted after truncation. Success requires both streams empty. Host stdout is silent, including bounded-argument/preownership failures: exact argument parsing and the top-level BaseException handler avoid an unaccounted traceback path. The same phase inventory and stream/metadata sublimits still apply; any externally retained request or coordinator logs need their own accounting.

The host record includes source/authorization/seal bindings, pre/post R identity, observed exit and launch, H limits/accounting, stream hashes and additional capability reference. Its total-byte field is stabilized against its own encoded size, then checked against the actual postpublication inventory. Publication uses the common exclusive pending-file protocol. Final validation reopens the S/R/candidate chain, checks fixed arguments, identities, resource evidence, source and target hashes, and rejects failure/pending files. This preserves all scientific acceptance requirements rather than replacing them with lifecycle success.

## Failure paths and scope

Failure cleanup requests termination of the H-owned job and, where necessary, R's original handle. One shared two-second cleanup budget covers its waits and at most eight bounded PID-list observations. Later PID handles are used only for membership/exit observation, never PID-based termination. `cleanup_other_members_absent` is distinct from R exit; `cleanup_complete` requires both. Missing or inconclusive observations do not prove absence.

The local `release()` clears handle state before callers test its result, preventing the earlier draft's second cleanup pass over already-closed handle values. Close failure cannot become success. The source attempts bounded failure publication; if caps or I/O prevent it, missing final evidence and nonzero H exit remain failure. No output is deleted to recover apparent compliance.

H does not claim full-lifetime memory measurement for itself or R. W and S retain their required original-handle post-exit limits in S/R; R's 128-MiB evidence remains its specified sampled self-peak scope. The full 16-MiB phase accounting includes host files. None of these bounds is an instantaneous OS quota against unseen transient excess.

The final source incorporates the requested cleanup-state repairs, silent preownership failure handling and decimal-parser compatibility. It still needs the separate nesting test/review and explicit runtime decision before use. No request, authorization, process probe, fixture, numerical run, source dependency change or Lean build was created by this review.
