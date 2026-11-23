# qrh integration — 2026-11-13

## 04:56:38 UTC · Final

Completed the [end-to-end model](../../../work/backend-costs-20261112/forecast-audit-20261113/END_TO_END_MODEL.md). Independent review passed 792 checks without correction.

Planning scenarios: HOL4 **523**, Candle **784**, stock Lean **77,805 core-years**. These are conditional implementation scenarios—not measured full-proof costs or best-possible bounds. All source, counting, finite, setup, engineering and I/O assumptions remain explicit.

## 05:05:29 UTC · Final

Wrote [RawLogHorner.lean](../../../work/lean-pilots/raw-head/RawLogHorner.lean) with the requested integer algorithm and proof bodies for `roundDiv_error` and `logCenter_error`.

No build started, as instructed. Compilation remains unverified. Source hash: `0BFB7931…A0C99DD`.

## 05:07:31 UTC · Final

Fixed both reported issues in `RawLogHorner.lean`. Stable SHA: `0A38965C…FCCC1A0`. No build started.

## 05:23:33 UTC · Final

Wrote `RawExpHorner.lean` with the exact Taylor-sum bridge and internal rounding bounds of `77δ` and `81δ`. Root notified with hash `258193AA…`. No build started; compilation remains pending.

## 05:35:09 UTC · Final

Fixed the reported API mismatches in `RawExpHorner.lean`; theorem signatures and Taylor bridge are unchanged. Root has the new hash `CB1BBBBB…` for the serialized retry. No build started.

## 05:38:17 UTC · Final

Wrote `RawStepProducer.lean` with the reusable `stepFromLog` program and the actual stored-step error proof. It has no certificate-error premises. Root has hash `0F8A08E3…`; compilation is pending, with no build started.

## 05:58:14 UTC · Final

Confirmed `RawStepProducer.lean` is ready and unchanged: SHA `AE8465E9…`. No builds or edits performed; root owns the pending compile.

## 06:04:37 UTC · Final

Fixed the final triangle-bound join and tactic warning. Stable hash: `A3076365…`. Statements unchanged; no build started.

## 06:16:42 UTC · Final

Wrote `RawCachedLoop.lean` with cached initialization/step inputs, an `N+1`-entry trace using `N` updates, and exact bridges to `rawStateNumerator`.

Hash: `9C372DB0…`. Root notified; no build or fixture generation performed.

## 06:37:51 UTC · Final

Prepared `RawTraceCertificate.lean` with exact Boolean checking, consecutive-edge composition, cached-trace equality, and actual per-index error transport. Hash: `92F583E9…`.

No build started; dependent-index and checker proofs await root’s compile. `RawCachedLoop.lean` remains unchanged.

## 06:42:56 UTC · Final

Prepared the computed full-trace counterpart: eight kernel-evaluated trace equalities plus shared-source bindings and per-index analytic bounds. No Lean builds run.

Repaired `RawTraceCertificate.lean` from root’s diagnostics; current hash `BDDF288F…`. Root has both handoffs.

## 06:48:03 UTC · Final

Repaired the optional-index transport and switched computed error proofs to the shared certificate helper. Root has updated hashes. Eight arithmetic modules are unchanged; no builds run.

## 06:54:52 UTC · Final

Prepared `RawStateComputedPacked.lean`: identical eight arithmetic proofs, assembly, and `full_output_checked` in one module. Hash `5728AD9F…`.

Original files remain unchanged. No build started.

## 06:56:19 UTC · Final

Fixed base 1 in the assembly and packed module; preserved the failed assembly byte-for-byte. Generator updated, not rerun. Root has the new hashes; no builds started.

## 07:40:41 UTC · Final

QRH helps a researched alternative, but **no end-to-end runtime saving has been demonstrated**.

- It supplies all-height tail bounds and a replacement minor-energy estimate below `.65·x log x`.
- That alternative still needs much stronger finite zero-location information—typically `.555`, with a conditional `.565` high-conductor variant—and separate principal information.
- The current costed **R132900 / principal RH through 10⁸** baseline does **not** consume QRH. Its demonstrated QRH-attributable savings are therefore zero.
- Importing the QRH theorem is distinct from implementing and validating its new Goldbach consumer proofs.

Correction: the `N(1500)` and reciprocal-sum requirements belong to alternative routes, not the selected original-RH baseline.

## 07:53:06 UTC · Final

Wrote [ANALYTIC_BLOCK_PLAN.md](../../../work/backend-costs-20261112/hol-platt/ANALYTIC_BLOCK_PLAN.md).

It specifies the c10004 two-height block, existing HOL APIs, missing analytic proofs, implementation order, and complete measurement boundaries. The main gap is actual L-function/EM/completion semantics—not integer execution.

SHA256: `55E63C1849DC9D9007DD8085D0FD4EEE2CD98CEBDA57E14554A5DB23A9F3AD1C`.

No builds or existing-source edits.

## 08:05:43 UTC · Final

Prepared [RawPairRoundScript.sml](../../../work/backend-costs-20261112/hol-platt/raw-analytic/RawPairRoundScript.sml) and [README](../../../work/backend-costs-20261112/hol-platt/raw-analytic/README.md).

The helper derives complex multiplication error ≤ \(1/g\) from the existing integer-rounding residual, allowing distinct positive state and step grids.

Source APIs checked; compilation remains unvalidated because required real/complex objects are absent. No builds or transcendental-source claims.

## 08:11:56 UTC · Final

Prepared [DEPENDENCY_BUILD_PLAN.md](../../../work/backend-costs-20261112/hol-platt/raw-analytic/DEPENDENCY_BUILD_PLAN.md).

It specifies 45 source files, read-only reuse of existing compiled modules, a fresh isolated build directory, and a dependency-graph check before execution. Initial limits: one job, 4 GiB memory, three hours total.

No files were copied and no builds ran.

## 08:16:07 UTC · Final

Prepared the [runnable preflight and instructions](../../../work/backend-costs-20261112/hol-platt/raw-analytic/RUNNER_README.md).

The first command stages 45 pinned files and validates the dependency graph only. Dependency and helper builds require separate commands. External compilation is rejected.

No staging or builds ran; existing sources remain unchanged.

## 08:18:50 UTC · Final

Prepared the [Windows preflight adapter](../../../work/backend-costs-20261112/hol-platt/raw-analytic/WINDOWS_PREFLIGHT.md).

It uses the installed Windows Python, passes mapped paths positionally through WSL, and performs staging plus graph validation only. Original scripts are preserved.

No execution or installation occurred.

## 08:26:34 UTC · Final

Prepared the unexecuted recovery script and root-cause report.

- Recovery reuses the existing stage and preserves its partial build.
- Removing the positional target reaches Holmake’s actual JSON-only branch.
- All 108 pinned source/boundary checks matched.
- Existing outputs include four completed theories; `realTheory` remains incomplete.

Sent root the exact command, artifact hashes, and validation limits. No build or recovery execution performed.

## 08:31:15 UTC · Final

Offline validation passed without rerunning HOL.

- Preserved the raw output; removed only the exact `Holmake: ` prefix in a separate copy.
- Verified the helper’s 777-node dependency closure; all external dependencies are satisfied.
- Confirmed all 108 input checks and 40 object files remain unchanged.
- Preserved both earlier failures and their evidence.

Report and pinned receipt sent to root for the separate build decision.

## 08:36:46 UTC · Final

Prepared the separate build runner; it remains unexecuted.

It reuses the validated stage, preserves prior evidence, runs one target with a three-hour limit, and records CPU, wall time and peak memory. Source and artifact checks run before and after.

Sent root the command, limitations and exact file hashes.

## 09:23:05 UTC · Final

Source review completed with no formula blocker for a focused build.

Prepared unexecuted `run_source.sh`, `source_audit.sml`, and a pinned input manifest. The audit checks exact theorem statements, closed hypotheses, and standard HOL ancestry.

Analytic log, exponential, inverse-root, recurrence and transform-to-sign proofs remain explicit prerequisites. No builds or evaluations were run.

## 09:25:01 UTC · Final

Review saved with no mathematical blocker before a focused build.

Checked the three-product algebra, all subtraction bounds, output bias `2B`, and negative half-ties against signed floor division. Actual operand bounds, compiled proofs and performance remain unverified.

Sent root the frozen review hash. No builds or evaluations performed.
