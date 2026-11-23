# Half-transform applicability at each selected tilt

2026-11-11. Paper applicability supplement. No values, transforms, builds, parameter search or new operation inventory. The frozen half-transform report and all earlier ledgers remain unchanged.

## 1. Exact extension

`HERMITIAN_HALF_TIME_TRANSFORM_2026-11-11.md`, SHA16BA0E67BF7B674FD29748303DB44CBF0E43808727D053FCC008B3C22886F8A6, fixes the uniform coefficient majorant Bmax=3125000000001 when presenting its numeric checks and fixed-theta totals. This supplement states the arithmetic estimate parametrically and binds the selected minimal-theta rows. It does not treat the uniform-B receipt as a replay of their precision requirements.

For this note B always denotes a COEFFICIENT magnitude bound. It is not the unrelated Gaussian-series constant called B=3^11 in the minimal-theta selector.

Fix a real B>=1, 0<eps<=1, Delta=5/64, N=2^k with 18<=k<=31, m=N/2 and J=ceil(25N/192). Let the exact stored centers satisfy A_0 real, |A_j|<=B, and A_-j=conj(A_j), with zero outside the signed support. Suppose the finite polynomial has its already proved target comparison

    |F_b(t)-omega U(t)|<3eps/4,  omega=2*pi/(N Delta).

Take roots and named complex roundings at absolute norm error at most

    u <= min(1/(16k), eps*Delta/[448*(2k+4)*(B+1)]).       (1)

Then the half-transform packing and normalized butterfly circuit from the frozen report, including its optional signed polyphase preparation, returns every raw sample with error <eps/(64H), H=44/(7N Delta). This is the same sufficient sample interface used by the reviewed raw sign ledger. It does not require replacing B by Bmax in (1).

## 2. Parametric proof

The exact packing has magnitude <=2B. Base packing has error <=(B+2)u. Signed polyphase preparation first introduces a=(B+1)u. Formula (1) gives

    a <= eps*Delta/[448*(2k+4)] <1.

The product/addition decomposition in the original proof therefore gives packed input error <=(3B+5)u, independently of the numerical value of B. The explicit C_0 round contributes at most u and is included. Negative coefficients are exact conjugate assignments of the positive centers; they are not independently rounded replacements.

At depth k-1, the normalized half FFT has error at most

    e <= [2(3B+5)+(k-1)(2B+4)]u
       = [(2k+4)B+4k+6]u
       <= (2k+4)(B+2)u.                                 (2)

The geometric amplification proof needs u<=1/(2k), which follows from the stronger first term in (1). All inequalities in (2) are affine in B and hold for every B>=1. Furthermore

    e <= eps*Delta*(B+2)/[448(B+1)]
      <= 3eps*Delta/896 <1.

The last estimate uses (B+2)/(B+1)<=3/2 for B>=1. Thus every magnitude assumption used in propagating the errors is justified.

Exact reconstruction multiplies the relevant real or imaginary component by m. Consequently

    raw error <= m e
      <= eps*N*Delta*(B+2)/[896(B+1)]
       < eps*N*Delta/448
       < 7eps*N*Delta/2816 = eps/(64H).                  (3)

The strict second inequality uses (B+2)/(B+1)<2. The final rational inequality is 1/448<7/2816. These are general symbolic comparisons, not endpoint sampling in B or theta.

For a nonzero polyphase class, all exact phase-modified coefficients still have magnitude <=B and preserve Hermitian symmetry by conjugate assignment. Its preparation errors were already included in (2). Thus the same row-specific u suffices for every phase class admitted by the original finite-polynomial identity. The transform length remains N in this polyphase construction. A length-dN padded transform requires its own N/depth admission and is not silently covered beyond the stated domain.

The raw reconstruction is an exact dyadic shift by m, with error and grid both multiplied by m. Source-coefficient denominator widths, packed-node integer parts, exact temporary products and root-generation costs retain their original separate qualifications. Formula (3) is not a claim of extra output precision without those representation changes.

## 3. Binding the selected minimal-theta rows

Read the selected-tilt note together with its mandatory bucket-rounding clarification and independent review. The original sentence claiming exact bucket accumulation is not used. Each of its 29,996 conductor/guard choices has integer theta in [64,128], the same N as the admitted theta128 row, and

    eps = 2^-82/3^theta,
    Wbar = 40000000/theta for odd conductors,
    Wbar = 80000000/theta for even conductors,
    B_row = 2 Wbar^2+1.

The reviewed admission gives 1<=cV/theta<=Wbar<=1250000, V>=2theta, N a power of two and the period/frequency conditions. The selected lengths lie in the earlier theta128 range, hence in [2^18,2^31]. In particular J<N/4 follows from N>=2^18 and its explicit ceiling formula, strengthening the inherited J<N/2 exactly as in the half-transform proof. We have 1<=B_row<=Bmax and 0<eps<1, so section 1 applies.

The independently reviewed corrected minimal-theta interpolation supplement establishes the same analytic/coefficient comparison for every selected intermediate theta. Its full selector checks are not replaced by interpolation between theta64 and theta128. Gaussian truncation, coefficient prefactors, phase, intrinsic character-transform error and all rounded bucket additions remain charged. Changing theta requires new actual coefficient centers for that theta.

The selected coarse time tolerance is

    u_time = min(1/(2k), eps*Delta/[56*(2k+4)*(B_row+1)]).

The reviewed sign-only successor specifies u_raw=u_time/8. Therefore u_raw is exactly the right side of (1), with B=B_row. A dyadic gate chosen at the recorded coarse fractional precision plus three bits is no larger than that tolerance. The new packed-input products, packed sums and C_0 round must use this same raw tolerance; their operations are new work, not omitted because their precision is already sufficient.

This proves row-wise arithmetic applicability with each row's own B, eps and gate budget. It does not replace the selected 241–343 fractional-bit range by the uniform-B alternatives in the original half-transform receipt. A shared root cache still needs the strictest allowance of its actual consumers. Exact source-array identities and root certificates remain required before an actual run can consume that cache.

## 4. Consumer and ledger boundary

The selected sign-only successor exports canonical signs through the raw polynomial and the rational threshold 109eps*N*Delta/704. It does not export the deleted numerical Y-amplitude API. The half circuit can supply its raw samples through (3), and can supply same-polynomial polyphase targets inside [0,V]. It neither changes that threshold nor grants a successful strict sign. The sampled function, conductor, actual character, fixed phase, coefficient array, target and precision must all match the record.

Both positive channels of nonreal inverse characters remain. Root phases, closed heights, central lower-count conventions, multiplicity, auxiliary intervals and the separate canonical Turing arithmetic remain unchanged. Polynomial periodicity supports only polynomial index wrapping. No periodicity or zero-set identity is asserted for the actual L-function.

This supplement changes no saved count. The original half-transform totals were composed against fixed theta64/theta128 inventory rows. Although selected minimal-theta lengths equal N128, joining all selected operation categories, precision metadata, packing work, roots and representation changes into a successor ledger is a separate metadata task. In particular the old full-transform counters must not simply be relabeled as already half-sized, and packed setup must not be discarded.

## 5. Frozen evidence

The following files were read and their hashes checked. No author generator or numerical evaluator was run for this supplement. The proof is the parametric algebra in section 2 plus the independently reviewed row-admission facts. This is not an additional replay of the 29,996 selectors.

Paths are relative to `work/qrh-campaign/agents`.

|File|SHA-256|
|---|---|
|major-constants/HERMITIAN_HALF_TIME_TRANSFORM_2026-11-11.md|16BA0E67BF7B674FD29748303DB44CBF0E43808727D053FCC008B3C22886F8A6|
|independent-feasibility/REVIEW_HERMITIAN_HALF_TIME_TRANSFORM_2026-11-11.md|519450342B34823AC596C3C778E90CDFA1EB96944F5EA0DF4E793F748EE505AE|
|prime-estimates/MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md|73337A5EB2688E5B1A5196A901232A314D89F3E48B5EEFC013CA178A8FFA238A|
|prime-estimates/CLARIFICATION_MINIMAL_THETA_BUCKET_ROUNDING_2026-11-11.md|4ACF800D0F7C773FA5A2DF013BD5F1341ED3CC98C0F9D257D81A2EE63B480D41|
|audit/REVIEW_MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md|58215EA3A0D697D229AD746F6FCE340DE913165D63599DC197798E705392308B|
|integration/MINIMAL_THETA_INTERPOLATION_APPLICABILITY_2026-11-11.md|BEE442CFF66187EAEEC930441D0AE414725A198A72B394A47701DB27E1D6B8FC|
|moebius/REVIEW_MINIMAL_THETA_INTERPOLATION_APPLICABILITY_2026-11-11.md|2C922C1F77D8FAAD335723F30898ED767781BA47E87CCA93BAAED743A44D0F54|
|prime-estimates/SIGN_ONLY_MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md|C1D2C360A296C961BD2FA46576521FEDB1AFE01527610DF1D21CC145E5565918|
|zero-sum/REVIEW_SIGN_ONLY_MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md|1D8FBDA28124B7FEE3CCDF500311809265463ECE38056ACD9E8F2F4053861300|

Actual data, ordinary-proof circuit implementation and complete sign/count certificates remain unprovided by this paper supplement. No runtime or total proof-cost claim is made.
