# major constants — 2026-11-13

## 04:50:26 UTC · Final

Created [C10004_PARAMETER_PACKET.md](../../../work/backend-costs-20261112/forecast-audit-20261113/C10004_PARAMETER_PACKET.md).

Pinned 4,800 inputs, 2,301 primitive outputs, p81 baseline versus p75 successor, ordered transform dependencies and source profile. The saved plan has no Bluestein leaf. Concrete unit maps and numerical certificates remain explicit prerequisites.

SHA256: `2B8102E8134B8BC9DA5BD93DD2105673EE6614B2D3D721B7E701F3A38C09F8EF`.

## 05:03:06 UTC · Final

Wrote [RawRecurrence.lean](../../../work/lean-pilots/raw-head/RawRecurrence.lean).

Includes the cross-term recurrence, finite-prefix bound and proposed \(j\le90000\) corollary. No `sorry`, custom axioms or setting overrides. **Not compiled**, as requested; ready for the serialized build.

## 05:09:27 UTC · Final

Fixed both addition-bound orientations and narrowed tactic imports. No build run.

Stable SHA256: `BF637C71E398F4F53FA999CE97434C7D189F47D4DB4735685F5792B463BC5CC7`.

## 05:35:40 UTC · Final

Wrote [RawStepAssembly.lean](../../../work/lean-pilots/raw-head/RawStepAssembly.lean): actual log-center phase bound, exponential transport and numerical error join.

No build run. SHA256: `139C591941B9756F28A50B4E6BB0FF2CD0CCA1D5D9E00C6A2575D67D23B23B0A`.

## 05:40:17 UTC · Final

Fixed the three local proof issues; theorem names and statements are unchanged. No build run.

Stable SHA256: `D8E72587BA40FBA79DC6554B42F8CC352513A142ACF925F31076CBB5849DAF42`.

## 05:51:26 UTC · Final

Wrote [RawDyadicProduct.lean](../../../work/lean-pilots/raw-head/RawDyadicProduct.lean) with literal multiplication, exact coordinates and the \(1/S\) rounding bound.

No build run. SHA256: `655FD30D73CB50ADCE330329A3C145FE67829F8D19B89DB6863BD969688AA624`.

## 05:57:28 UTC · Final

`RawDyadicProduct.lean` is ready at SHA256 `655FD30D73CB50ADCE330329A3C145FE67829F8D19B89DB6863BD969688AA624`.

It defines literal `mulStep`, proves the exact coordinate identity and the ≤1/S error bound. Not compiled. No work remains active.

## 06:04:26 UTC · Final

Wrote [RawStateProducer.lean](../../../work/lean-pilots/raw-head/RawStateProducer.lean).

The final theorem discharges initialization, step and rounding errors internally. No build run; cast simplifications and pending dependencies remain unvalidated.

SHA256: `A97F7DF07F116CB2367017231F9F017ABE5DAFAB43244FCAF6196F6B31C12EED`.

## 06:14:00 UTC · Final

Cleaned both files without building; statements unchanged.

- `RawDyadicProduct.lean`: `95C2BB6F0D336646DA77C29BECF76655EC14AE4B66CFBED06CCEBEB1B7E4214A`
- `RawStateProducer.lean`: `E5335116BA0B90DD92D500FCD0EFA5A89586D08C334D64C0F9EC01AB12D9B961`

## 06:42:56 UTC · Final

Prepared the fixed explicit certificate proposal; no Lean build run.

- Generator SHA256: `18D635420F532E74F2B426315535BAF9FA075ABA8F15E3F82065A32A2E956FC2`
- `RawStateExplicit.lean`: 1,024 literal update equalities, eight full traces and matching analytic exports.
- Source SHA256: `1FBB110EA8382DC3AC3218A6103A9D5EBDFC456C1A591A72F317111AADE3EDDE`

Validation under default limits remains pending.

## 07:03:02 UTC · Final

Split the unchanged workload into support, eight per-base modules and the final aggregate. All 1,024 edge proofs remain under `RawStateExplicit`; the failed whole source is preserved.

Build order sent to root. No builds or resource changes. Memory fit remains unvalidated.

Aggregate SHA256: `16247C42B1934E79AD225C70FF035DC34AD28187903766E47AB86F50C1A9B83E`.

## 08:10:49 UTC · Final

Prepared the [source-only specialization](../../../work/backend-costs-20261112/hol-platt/round-specialization/README.md).

It includes ordinary HOL equivalence proofs, the alternate butterfly, and separate CV translation. Negative division uses one natural quotient. Build order and hashes sent to root.

No builds or evaluations run; existing sources remain unchanged.

## 08:17:56 UTC · Final

Prepared the [matched experiment](../../../work/backend-costs-20261112/hol-platt/round-specialization/dependent/README.md): old/one-quotient rounding × stock/retained conversion, all four depths and five false controls.

All 788 original decimal strings are preserved. Source hashes and the separate core proof repair were sent to root. No builds or evaluations run.

## 08:36:34 UTC · Final

Prepared the separate [CV inspection driver](../../../work/backend-costs-20261112/hol-platt/round-specialization/cv-inspection/README.md). It prints compiled equation closures, qualified DIV/MOD counts, branch structure, and the stock-divider contrast.

Hashes sent to root. No builds, evaluations, or benchmark-source edits.

## 08:39:35 UTC · Final

Audit passed. For valid integer inputs and positive scale, the new butterfly dispatches two natural quotients and no remainder operations. The stock path dispatches two quotients plus up to two remainders.

No timing claim follows from this alone. [Audit report](../../../work/backend-costs-20261112/hol-platt/round-specialization/cv-inspection/RESULT_AUDIT.md) sent to root; no builds or numerical work run.

## 08:41:43 UTC · Final

Added the missing direct ancestor and updated the binding. No similar theorem-reference issue found.

Prior files are archived; definitions, fixtures, driver and runner are unchanged. Hashes sent to root. No build run.

## 08:49:28 UTC · Final

Prepared the recursive-translation repair: generated layer/run preconditions now have unconditional induction proofs.

Semantic claims, scalar rounding, driver and fixtures are unchanged. Prior files are archived; hashes sent to root. No builds run.

## 08:52:52 UTC · Final

Source review passed with no blocking defect. The formula, exact threshold, character checks and outward dyadic exports match the proposal and versioned FLINT API.

[Review](../../../work/backend-costs-20261112/hol-platt/native-sign-screen/WORKER_SOURCE_REVIEW.md) sent to root. No imports, evaluations or builds performed.

## 09:12:24 UTC · Final

Review saved as `C10004_LIVE_DATA_REVIEW.md`, SHA256 `46309058BF9C57B3F4C1643DA90035FE03326701EACCAD0B78A79BDABC24DA67`.

Counts and conditional widths check out. The review identifies the required map permutation and missing producer, analytic, storage and sign interfaces. It supports the proposed design, not a forecast adjustment. No builds or evaluations ran.

## 09:20:31 UTC · Final

Prepared the unbuilt source candidate and proof-gap notes in `hol-platt/source-producer`.

The module preserves raw and EM grids separately, including the EM 83-term step and both final roundings. Rational log, initialization and persistent-state interfaces are explicit. No analytic producer theorem is claimed.

No builds or evaluations ran. Source SHA256: `0B19AD2A223A9069C288B00C79B8CE7EE82D60C0E2ABD8A11A1E29C09C36D875`.
