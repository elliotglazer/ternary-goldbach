# moebius route — 2026-11-13

## 04:42:24 UTC · Final

Wrote [SPECTRAL_STRATEGY.md](../../../work/backend-costs-20261112/forecast-audit-20261113/SPECTRAL_STRATEGY.md).

It recommends compact checked source-to-sign blocks and the accepted half-length time transform, with explicit missing proofs, retained costs and backend constraints. No builds or numerical evaluations ran.

SHA256: `4D0DE21D…96052B`.

## 05:00:43 UTC · Final

Wrote [RawLogTail.lean](../../../work/lean-pilots/raw-head/RawLogTail.lean) with the general remainder, the `N=45` bound, and exact range reduction for `k≤18`.

Compilation is pending root’s sequential run. No builds or other file changes were made.

## 05:04:53 UTC · Final

Fixed both proof issues in the owned file. New SHA256: `2D6E8E9A…52AB55`. No build run; root has the updated source pin.

## 05:20:36 UTC · Final

Wrote [RawExpTail.lean](../../../work/lean-pilots/raw-head/RawExpTail.lean).

It contains the 73-term tail bound and pure-imaginary phase transport with Lipschitz constant one. Compilation is pending root’s serialized run.

SHA256: `2E0CCA22…3DB7DC`.

## 05:36:08 UTC · Final

Wrote [RawExpInteger.lean](../../../work/lean-pilots/raw-head/RawExpInteger.lean).

SHA256: `21C4BF2E…3795F72`.

## 06:04:42 UTC · Final

Generator ready: `work/lean-pilots/raw-head/generate_state_fixture.py`.

SHA256: `1184BE11036B39C3B8E80D634B6BDB0BB92B88052B8D7D052B7438E8B64CDAFE`

No generator execution or Lean processes launched. `state_fixture.json` remains absent.

## 06:40:58 UTC · Final

Confirmed all generated files are unchanged and match the emitter. Shared setup costs remain explicit.

No known mathematical issue; Lean compilation is still pending. No edits or builds performed.

## 06:47:44 UTC · Final

Repaired proof bodies and synced generator templates. Failed source preserved; literal data unchanged.

New source hash: `F501CDB3DAF8B2B41489B430057AA822854391902802DA091608EB31136756A6`.

No builds run. Ready for root’s retry.

## 08:09:20 UTC · Final

Wrote [PRECISION_RESEARCH.md](../../../work/backend-costs-20261112/hol-platt/PRECISION_RESEARCH.md).

The high precision mainly comes from an inherited uniform accuracy budget and conservative error propagation. Proposed next step: accept signs using individually certified complete error radii, with explicit refinement for failures.

This does not establish that double precision suffices. No builds, numerical evaluations, or forecast changes made.

## 08:16:37 UTC · Final

Created [SMALL_FAMILY_PILOT.md](../../../work/backend-costs-20261112/hol-platt/SMALL_FAMILY_PILOT.md).

It specifies conductor 10000, a full 524,288-point FFT, exact source requirements, and a two-channel adaptive-radius test. The main missing piece is a complete coefficient producer for this row.

No numerical evaluations or builds run.

## 08:47:47 UTC · Final

Completed [NATIVE_SIGN_EXPERIMENT.md](../../../work/backend-costs-20261112/hol-platt/NATIVE_SIGN_EXPERIMENT.md).

It specifies eight actual conductor-10000 evaluations and a rigorous threshold for testing the proposed precision reduction. Canonical phase, full-transform costs, repairs and HOL proof obligations remain explicit.

SHA256: `52B4442E3F44B2CC28AC37DC1043865A18DC60FC75E66A6C63694E9AFB216B70`

No builds or numerical evaluations ran.

## 08:50:52 UTC · Final

Prepared the [worker, bounded runner and launch instructions](../../../work/backend-costs-20261112/hol-platt/native-sign-screen/README.md).

The worker saves each result immediately and stops on any mismatch or inconclusive margin. The runner enforces 2 GiB memory and 300-second limits.

No scripts, FLINT evaluations or builds were run.

## 08:59:22 UTC · Final

Prepared V3 diagnostics; no rerun.

- Runner: `7BE45553…B0618`
- [Diagnostic revision note](../../../work/backend-costs-20261112/hol-platt/native-sign-screen/JOB_DIAGNOSTIC_REVISION.md)
- Worker V2 remains unchanged.

V3 preserves raw process observations before assertions and checks them before releasing the worker. The lifetime-count check remains intact.

## 09:08:32 UTC · Final

Saved [REFERENCE_PRECISION_REVIEW.md](../../../work/backend-costs-20261112/hol-platt/native-sign-screen/REFERENCE_PRECISION_REVIEW.md).

The API uses a 4000-residue Hurwitz computation per call. A 256-bit reference run can use the unchanged rigorous acceptance test, but success and runtime remain uncertain.

No worker changes, evaluations or process-control actions were made.

## 09:14:00 UTC · Final

Completed [POST_EXIT_REVIEW.md](../../../work/backend-costs-20261112/hol-platt/native-sign-screen/POST_EXIT_REVIEW.md).

All eight saved margin comparisons pass exact rational rechecking. The supervisor receipt remains failed, with missing terminal evidence documented.

V6 corrects post-exit identity handling. Fourteen synthetic policy tests passed; no numerical workload was rerun.

## 09:16:22 UTC · Final

Saved [ADAPTIVE_SMALL_FAMILY_ENTRY.md](../../../work/backend-costs-20261112/hol-platt/ADAPTIVE_SMALL_FAMILY_ENTRY.md).

It specifies lower-width FFT operations, unchanged source budgets, strict acceptance gates, fallback reuse and full-cost measurements. Input regridding is explicitly charged rather than assumed free.

No evaluations, worker edits or forecast credit.

## 09:23:22 UTC · Final

Prepared the source-only candidate:

- `natural-offset/NaturalOffsetRoundScript.sml` — SHA `76182607…981A356`
- `natural-offset/README.md` — SHA `2A421F63…AC44156`

The algebra and signed tie convention agree with `round_scaled`. The output requires bias \(2B\). No builds, evaluations, or performance claims; proof scripts await stock HOL4 checking.
