# Independent review of large-branch precision and repair

2026-11-11. PASS at conditional paper-policy scope, without a required correction to the frozen author. Reviewed `audit/LARGE_BRANCH_PRECISION_REPAIR_POLICY_2026-11-11.md`, SHA256 `CEE051ACA50EBFF46E422E104B4978603FFD7CA427672B30FF8AC1529841D567`. Paths below are relative to `work/qrh-campaign/agents`.

I read the complete frozen policy, the stability allocation and its independent review, and the applicable error, guard, sparse-evidence and count interfaces. I verified all six pins in the author's input table and the additional pins below. This review produced no function values, signs, zero evidence, inventories, declarations, proof objects or builds. The analytic foundations remain those of the cited source reviews.

## Precision changes and the complete radius

The proposed coefficient 135 is valid under the stated stability hypotheses. Exact completion has magnitude below 27, and the exact m41 interpolation kernels have total absolute value below 5. The exact inverse-character damping is at most one. Consequently the intrinsic transform radius contributes at most `135*C_T*2^-p`, where `C_T=1266*202305920*2^14`. This calculation uses the exact-factor error split. It does not replace a sum of stored kernel magnitudes plus radii by 5 without justification.

For p at least 112, the inherited input, safety and cache conditions give uniform stored-magnitude bounds used in the other error terms. Those conditions remain premises. In particular, a larger p does not create finer source data, elementary factors or cached kernel enclosures. Holding their sufficient bounds fixed gives the valid policy expression

    r(p) <= R_fixed + 135*C_T*2^-p.

The complete alpha allowance already contains Taylor truncation, shifted-source errors, source numerical errors and scaled polynomial evaluation. The policy neither adds these a second time nor omits them when selecting another downstream evaluator. Head, representation, conductor scale, actual completion phase, inverse adapter, interpolation kernel and accumulation remain separately charged according to the chosen circuit.

For a requested bound tau, the displayed sufficient estimate can close only after `R_fixed<tau`; the remaining intrinsic inequality and safety conditions then suffice. This is a statement about that estimate. Neither R_fixed nor its analytic part is a lower bound on actual error. A sharper proof may lower the allowance without changing the true function or even its stored centers.

The actual acceptance test is `|center|>radius`, with both objects bound to the same candidate. New centers cannot inherit an old apparent margin solely because a new radius is smaller. For a known true-value margin mu, the author's added condition `2r<mu` is a correct uniform sufficient test: soundness gives `|center|>=mu-r>r`. The weaker condition `r<mu` alone is insufficient. For example, a true value mu and center mu-r can be sound yet fail the strict test when r is at least mu/2. This explicit condition governs any reading of older informal margin language in the sparse-schedule packet.

## Repairs that change the analytic problem or dependency set

The fixed Fourier allowance does not decrease merely by increasing the number m of retained samples. Increasing m reduces the omitted-sample bound, subject to its admitted hypotheses. Changing Gaussian width h changes both tails and the kernels; it requires the full joint estimate again. Reducing the coarse spacing Delta raises the Nyquist parameter but also reduces m*Delta at fixed m. Refining target offsets on an unchanged coarse lattice does not do either.

The exact dependency union uses `floor(t/Delta)-m` through `floor(t/Delta)+m`. This agrees with the reviewed closed-endpoint guard construction, including grid targets, off-grid targets and zero. Any new target set, lattice or m needs its own union and source-domain check. An old globally available seed prefix does not prove that the required character samples have been generated. Negative samples retain the inverse-character label, exact fixed phase sign and positive attenuation enclosure. Their errors cannot be copied unchanged from positive samples.

Direct actual-L/Hardy sign evaluation can bypass this particular interpolation tail. It still requires its complete source and phase contract. A sign-equivalent positive-cosine proxy is useful only through its proved sign relation; it is not an actual canonical sample or Gamma-phase integral. The policy makes no unsupported arbitrary-accuracy promise for a fixed-budget direct evaluator.

## Zero evidence and count closure

At an exact zero a sound strict-sign certificate cannot succeed. A failed sign enclosure does not prove a zero, its order or its location. Opposite signs yield a critical-line lower count on a valid interval, not an exact order. Even-order critical zeros need not change sign. Moving or subdividing points therefore has no unconditional termination guarantee and gives no free multiplicity evidence. Replacement brackets must satisfy the disjoint-evidence rule; a parent and its nested children cannot all be charged as new roots.

The central point and real off-critical zeros remain distinct issues. Central evidence is never doubled merely because positive-height evidence is doubled for a real character. A failed central sign does not exclude off-critical real roots. For nonreal characters, positive data from the inverse partner supplies the opposite-height channel with the actual conjugation and multiplicity conventions.

The count test is correctly kept separate from value precision:

    h_T*(K+2) - Abar + W - 2*Bbar > 0.

Its hypotheses include primitive nonprincipal scope, the applicable Turing domain, a full closed-height multiplicity upper count, and a nonnegative integer K supported entirely on critical zeros. Same-character reflection sends an off-critical zero to a distinct zero with the same ordinate. Thus an off-critical pair would force C>=K+2, contradicting the strict test. This includes boundary ordinates and real off-critical zeros. The test can leave one unrepresented critical multiplicity. It does not give exact count saturation, simplicity or a complete zero list.

More value precision helps this test only if it produces new valid evidence. Narrower auxiliary brackets may increase W; better canonical integral bounds may lower Abar. Changing the auxiliary length h_T changes the weights, integral, allowance and required samples. It does not permit reusing the old measured deficit. Principal certification stays separate. No separate principal N1500/Q1500 consumer is introduced by this policy.

The conditional eventual-sign statement is sound: at a fixed nonzero value, sound radii tending to zero eventually pass the strict test. The policy supplies neither nonzeroness for every selected point nor radii tending to zero under the fixed window. It therefore assigns no repair count or success frequency.

## Work accounting and remaining implementation requirements

The typed attempt records preserve the data needed to price real work: target set, actual character channels, evaluator, source and arithmetic precisions, Gaussian parameters, dependency union and cache identities. Direct interpolation has 2m+1 real products and 2m additions per target before gate widths, rounding, serialization and proof transport. Source generation, completion, count integrals and alternative root evidence are separate.

Generation pays failed and discarded attempts. A checker may retain only the successful dependency DAG, but must still check its complete bindings and count joins. Exact shared objects can be paid once within their checked lifetime. A changed source vector, phase, grid, kernel or precision needs explicit compatibility before reuse. Hash equality identifies bytes and is not an analytic proof.

This is a policy, not an executable bounded repair scheduler. A later implementation must set its attempt, memory, time and output caps and leave unresolved cases incomplete. No actual precision distribution, sign success, completeness success, runtime saving or core-hour forecast follows from this PASS.

## Additional pinned interfaces

The six author-table hashes were checked directly and remain unchanged. The following additional evidence fixes the count and guard interpretation used here.

| File | SHA256 |
|---|---|
| major-constants/TURING_SPECTRAL_SURPLUS_REDUCTION_2026-11-11.md | 6E7CD152D57679AFBEF754D9A1C0060AAA3F28C6E2DB1F6EFB4BD24A6B15C401 |
| independent-feasibility/REVIEW_FINITE_RH_PAIR_DEFICIT_2026-11-11.md | 97645AB7A3A9EC3B807DD4BFDD022175455A0F1DEF46F676141E6C587164C7E5 |
| zero-sum/SPARSE_AUXILIARY_CERTIFICATE_SCHEDULE_2026-11-11.md | 63E77B1CACD9209FB7D475F6CAA8C0D097281F6CA7B5F19475BD02827B8F0CCD |
| moebius/REVIEW_SPARSE_AUXILIARY_CERTIFICATE_SCHEDULE_2026-11-11.md | 2344439D09F01A9B0A28823008768EC551DA0DF7416F914FE9061514E99B5B88 |
| zero-sum/REVIEW_SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md | 15BA744A36D5D85D1A2E4E2C797B235475A39D2258D9BA07B6472EE45A64C5AA |

No scalar companion was needed for this policy review. The arithmetic allocation was independently checked in the pinned stability review; this report checks its use, the strict implications and the repair boundaries.
