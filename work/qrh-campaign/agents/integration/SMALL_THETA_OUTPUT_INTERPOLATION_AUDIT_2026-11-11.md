# Small-theta output, interpolation and sign compatibility

2026-11-11. Bounded paper/source audit. No analytic values, transforms, zeros, builds or source edits. The new interpolation construction below has exact rational metadata, not an executed numerical certificate or a Lean proof.

## Outcome

The accepted small-conductor backend supplies the full amplitude needed for interpolation, not merely a sign proxy. Its Y is pi^(-alpha) times the completed function in Platt's section 6, with alpha=(2a+1)/4. This factor is positive and independent of height. Consequently a correct interpolation theorem for Platt's function transfers linearly to Y, including its error. No Gamma magnitude evaluation is needed to make that conversion.

There is still a real gap in adopting the historical Gaussian/sinc schedule as a complete current evaluator: the source's final omitted-sample lemma says only “for large enough t0”, and the current whole-family inventory has not selected and proved full-range interpolation parameters and guard coverage. Sign equivalence does not discharge that gap.

A concrete alternative removes this analytic gap for ordinary eightfold refinement throughout the admitted interval. Interpolate the backend's finite Fourier polynomial, with 340 centered grid samples and exact rational Lagrange weights. Its global derivative bound proves the interpolation error uniformly, including near zero and the top of the interval. Periodic wrapping is permitted for this polynomial alone. Tightening its time-transform arithmetic by a factor 16 suffices under the allocation below; no new Gaussian or character-transform work is required. The extra interpolation work, storage, and time precision are real costs. This construction is sufficient, not claimed cheapest.

## 1. Exact amplitudes and accepted source boundary

Let chi be an actual primitive nonprincipal character of conductor c, a in {0,1} its parity, alpha=(2a+1)/4 and w=alpha+it/2. Fix the same unit epsilon at all heights, with epsilon^2 W_chi=1. The accepted entire completion gives, on the critical line,

    completedLFunction_chi(1/2+it)
      =pi^(-alpha-it/2) Gamma(w) L(1/2+it,chi).

This follows from `LFunction_eq_completed_div_gammaFactor` and the even/odd Gamma factor, using Gamma nonvanishing for Re(w)>0. It does not replace the entire continuation at Gamma poles. The exact Mathlib sources are `NumberTheory/LSeries/DirichletContinuation.lean:258–286` and `Analysis/SpecialFunctions/Gamma/Deligne.lean:45–72` at the previously pinned checkout.

The inventory's actual output is

    Y_chi(t)=exp(pi*t/4) epsilon c^(it/2)
                        completedLFunction_chi(1/2+it).

Platt's definition, in the pinned text at lines 64–76, is

    Lambda_P(t)=epsilon (c/pi)^(it/2) Gamma(w)
                         exp(pi*t/4) L(1/2+it,chi).

Therefore Y=pi^(-alpha) Lambda_P exactly, with phases aligned. Platt's epsilon may be chosen to be this fixed epsilon; two independently chosen opposite phases must first be identified. The constant is below one, so an absolute interpolation bound E for Lambda_P also conservatively bounds Y, or can be sharpened to pi^(-alpha)E. Relative to the conductor-completed Hardy function Z=epsilon*c^((s+a)/2)*completedLFunction(s), the relation is Y=c^(-alpha)exp(pi*t/4)Z. These two comparisons should not be confused.

The earlier `FINITE_U_HARDY_NORMALIZATION` instead constructs a positive-cosine sign proxy. That proxy's amplitude is not Y. Its accepted sign equivalence is sufficient for a separately evaluated endpoint, but does not permit inserting proxy samples into a Y interpolation array.

Negative-height values also require their amplitude adapter. With kappa=epsilon_chi*epsilon_(chi^-1) in {+1,-1},

    Y_chi(-t)=kappa exp(-pi*t/2) Y_(chi^-1)(t).

The two positive channels of a nonreal pair remain distinct. The frequency identity G_chi(-x)=conj(G_chi(x)) is a different identity and does not justify reusing the same character's positive-height samples as negative Y samples.

## 2. What the historical interpolation interface still needs

The pinned primary text, lines 715–917, applies Weiss's theorem to

    W(t)=Lambda_P(t) exp(-(t-t0)^2/(2h_I^2)).

At t0, W equals Lambda_P. Its finite sampled sum needs both the Fourier alias bound and the omitted-sample bound. The Fourier transform must be integrable and of bounded variation, with the specified value at any jump. Lemmas 6.4–6.5 give a contour-shift/Gamma bound with t0>=0; Lemmas 6.6–6.7 supply the sample-tail argument, with the final “large enough t0” qualification. The displayed Lemma 6.6 also starts with an on-grid center. The general off-grid finite kernel used in campaign cost notes therefore remains a candidate until its offset, low-height and guard hypotheses are supplied.

The existing selected-sign and reduced-cost reports explicitly retained these obligations. Their finite damped-sinc formula and convolution acceleration are valid algebraic schedules, not a completed uniform tail certificate. The whole-small-family inventory fixes tau=2^-80, Delta=5/64, and admitted Y values only at its stated nonnegative grid prefix. It neither certifies negative guard values by copying nor grants an extra unpriced top halo. A new Gaussian/sinc admission proof could resolve this route, but is not presumed here.

## 3. The finite polynomial already produced by the backend

Use the inventory's tilt parameter theta in {64,128}, interval 0<=t<=V, X=10, period P=N*Delta and omega=2pi/P. Let J=ceil(PX/6)<N/2. Denote the exact stored coefficient centers by A_j, with A_0 real and negative indices assigned by exact conjugation. Define the real polynomial

    T(t)=omega [A_0+2 Re sum_(j=1)^J A_j exp(i*j*omega*t)].

The notation T here denotes a finite function, not a Turing height. All its coefficients are the actual stored centers; changing a center changes the function being interpolated. Its period is P. No infinite series convergence is needed for the following interpolation argument.

Let eps=tau/(4*3^theta). The accepted backend separates three errors before the time-transform arithmetic:

* Time periodization, uniformly at every real t in [0,V], is below eps/4.
* Omitted positive and negative frequencies, already multiplied by omega, contribute below eps/4.
* Coefficient truncation and finite coefficient arithmetic contribute at most eps/4, uniformly because every exponential at real t has unit norm.

Thus |F_b(t)-T(t)|<3eps/4 throughout [0,V], where b=pi/4-theta/V. This follows from `NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST` lines 63–78 and 125–153. The grid enters the FFT evaluation of T, not these three inequalities. The whole-family admission checks instantiate their hypotheses for every selected conductor and guard scenario. No assertion outside [0,V] about F_b is needed.

The accepted coefficient bound is |A_j|<=B=2Wbar^2+1. Since omega(2J+1)<4(X+1)=44,

    |T^(r)(t)|<=M Omega^r for every real t and integer r>=0,
    M=44B, Omega=J*omega <= pi*X/3+2pi/P <=242/21.

Here P>=6 and pi<22/7. Across both tilts and conductor cohorts, Wbar<=1250000, so M<=137500000000044<2^48. This derivative estimate is global for T, even though the comparison to F_b is only on [0,V].

## 4. A uniform rational local interpolation theorem

At target t=(k+xi)Delta with 0<=xi<=1, interpolate T at the 2m points

    (k+j)Delta, j=-m+1,...,m.

Use the exact Lagrange weights l_j(xi). For the ordinary eightfold grid xi=ell/8, ell=1,...,7, these are rational constants shared by every conductor, parity, tilt, k and N. Coarse targets use their existing sample directly.

The real interpolation remainder and the derivative bound give

    |T(t)-sum_j l_j(xi) T((k+j)Delta)|
      <= M (Omega Delta)^(2m)/(2m)! * product_j |xi-j|.

Writing u=xi(1-xi), the product equals

    u product_(j=1)^(m-1) [j(j+1)+u]
      <= [(2m)!/(4^m m!)]^2.

Every factor increases with u in [0,1/4], which proves the inequality also at the endpoint zeros. Since binomial(2m,m)<=4^m, the remainder is at most

    M (Omega Delta/2)^(2m).

For Delta=5/64, Omega Delta/2<=605/1344<1/2. Fix m=170, with no search over parameters. The exact rational metadata verifies

    44(2*1250000^2+1) (605/1344)^340
      < [2^-80/(4*3^128)]/16.

It therefore fits eps/16 in every whole-family row. No hypothesis about zero spacing, t being large, or analytic continuation of Y is used here.

For the seven offsets the exact sums Lambda_xi=sum_j |l_j(xi)| have the following upward roundings:

| xi | Lambda_xi upper |
|---|---:|
|1/8,7/8|1.675|
|1/4,3/4|2.222|
|3/8,5/8|2.578|
|1/2|2.701|

In particular every Lambda_xi<4. The companion script constructs all 2380 rational weights, checks reproduction of constants, linear and quadratic polynomials as metadata controls, and verifies these norms. The general interpolation identity and remainder are the paper argument above, not inferred from those three controls. The receipt retains the exact norms and reproducibility digests; a future checker must actually establish its kernel constants, not trust a digest.

## 5. Complete arithmetic and boundary contract

The samples in this new route must enclose T itself. A radius for F_b or Y cannot silently be relabeled as the same radius for T. Retain or reconstruct the time-FFT intermediate before its final Y scaling, bound to the exact A array and omega.

Tighten the old total time-transform evaluation allowance from eps/4 to eps/64 for every one of the N outputs. This includes twiddle/FFT arithmetic, omega approximation and final scaling. Multiplying those sufficient error allocations by 1/16 costs four additional fractional bits under the same gate scheme. It does not require a change to the Gaussian seeds, buckets, coefficient centers or character-transform precision. The algebraic FFT output error is uniform at all N indices, including indices whose F_b/Y interpretation was not previously exported.

At a requested eighth-grid point, sample uncertainty contributes below 4*(eps/64)=eps/16. Allow another eps/16 for kernel quantization and finite evaluation. For example, quantize each of the 340 weights to absolute error at most eps/[32*340*(M+1)] and bound all product/accumulation rounding together by eps/32. The sample centers have magnitude at most M+1. The kernel and arithmetic contributions then total at most eps/16 without an independence assumption.

The final F_b enclosure has radius below

    3eps/4 + eps/16 + eps/16 + eps/16 =15eps/16 <eps.

The first term is the analytic/coefficient comparison at the TARGET once. It is not multiplied by the interpolation norm: the sampled function is T. This is why the coefficient and character stages need not be refined by that norm.

Reduce the integer indices k+j modulo N when necessary. This is exact periodic wrapping of T. It does not assert periodicity of F_b or Y, and it does not use negative F_b/Y data. Near zero or V, the derivative proof still uses the unwrapped real nodes, whose T values equal the wrapped ones. The inventory has V>=2700 and P>=V, hence N>340, although the periodic identity itself is more general. No new analytic guard domain is required for this route; all final targets must still lie in [0,V].

For numerical Y values, use Y(t)=exp(theta*t/V)F_b(t). Its positive scale is at most 3^theta. The old final-scale error allocation tau/[4B] and final multiplication error tau/4 then give Y error below3tau/4, since the F_b center remains bounded by B. This scale must be evaluated at the new target, not copied from a neighbor. One economical option reuses the coarse scale at kDelta and seven fixed offset factors exp(theta*xi*Delta/V). Tighten the coarse scale radius to one quarter of the old allowance s=tau/[4B], certify each offset factor to s/[4(3^theta+1)], and allow s/4 for the product. Since the true offset factor is below2 and the stored coarse scale is bounded by3^theta+1, the product error is at most s. These seven new real exponential leaves are shared per conductor/tilt/V; they are not free.

For a strict SIGN alone the positive rescaling can be omitted entirely. An F_b enclosure excluding zero proves the corresponding Y and canonical Hardy sign. Its record must cite the exact positive identity and fixed epsilon. This sign shortcut does not permit mixing F_b samples from different tilts in a single interpolation array.

## 6. Work, storage, and what is still unpriced

This construction adds a concrete complete off-grid option to the earlier inventory; it does not retroactively include its costs there.

| Component | Additional requirement |
|---|---|
| Coefficient/Gaussian/character stage | No new operations or precision from this adapter; retain its existing proofs and centers. |
| Time FFT and omega scaling | Same N and operation counts, four more fractional bits for the stated total error allocations. |
| Local queries | 340 real weighted terms per distinct requested noncoarse endpoint, plus checked accumulation and one strict sign test. |
| Kernel setup | 2380 shared rational weights, their error/norm proofs and any rounded representations at required precisions. |
| Samples/storage | Enough wrapped T-grid samples for the union of requested stencils, or a checked full array/replay. The old exported Y prefix alone is insufficient. |
| Numerical Y output | Shared off-grid positive-scale setup and products as above; unnecessary for a sign-only endpoint. |
| Unresolved outputs | Refine the responsible error component or use a separately justified direct endpoint method. The fixed tau floor does not guarantee a sign. |

For Q=1775431871117 current small-family coarse values and n=18477108 labels, ordinary dense eightfold refinement would request 7(Q-n)=12427893758063 new endpoints. Evaluating this particular stencil separately everywhere would cost4225483877741420 real weighted terms. These are exact schedule counts, not a recommendation or a time forecast. Selected queries can be much fewer, but no success distribution has been established.

Dense polyphase convolution of the same finite kernels or an enlarged zero-padded time transform can share work. The former must price its transforms, kernel setup, rounding and storage; the latter evaluates T exactly before roundoff and needs a newly checked longer-transform allowance. They use the same coefficient array and do not require a fresh character transform at each target. Their arithmetic comparison is a separate task; no winner is assumed. Direct evaluation of the finite Fourier sum is also a sound fallback if its own arithmetic error fits eps/4, but O(J) work per query is not an economical default claim.

The largest inventory N is2^31 for theta64 and2^30 for theta128. Even a local stencil does not make generation of that full transform cheap or storage-free. The accepted streaming/sharding obligations remain. Shared proof objects require exact coefficient, grid, tilt and normalization identities, rather than hash-only imports.

## 7. Sign intervals and Turing conclusions

The existing endpoint/count contract can consume these strict signs directly. Opposite signs of the same canonical real function at rational endpoints give an interior critical-line zero; multiplication by any proved positive factor preserves those signs. Disjoint intervals give a lower count, not simplicity or completeness. For nonreal characters retain both positive channels; real-character reflection, central lower-count evidence and the default central contribution zero remain as in the accepted contract.

The canonical Turing phase and its integrated error are unchanged. Neither pi^(-alpha), the positive tilt removal, nor the finite sign proxy changes those phase definitions. The accepted finite-RH-only rule remains U<K+2 with K a certified critical-line lower count, while an exact-count consumer still needs its stronger condition. Nothing in the interpolation proof supplies K, auxiliary weights, a successful surplus, or a bound on the number of repairs. Each target and any enlarged auxiliary interval must still be admitted by the selected V and full coefficient budget.

The result is therefore full amplitude compatibility, plus one explicit global-in-domain interpolation proof with a finite arithmetic allocation. Actual data, the implemented proof checker, and successful sign/Turing packets remain required. No final mathematical premise or family height is changed.

## Evidence

The companion `small_theta_polynomial_interpolation_20261111.py` and JSON contain 33 exact checks, including the remainder and all seven interpolation norms. They evaluate rational polynomials only. The source and report pins below identify the reused boundaries; their prior reviews are not reattributed to this audit.

| File | SHA-256 |
|---|---|
| `work/qrh-campaign/agents/prime-estimates/WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md` | `74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE` |
| `work/qrh-campaign/agents/audit/REVIEW_WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md` | `34FB45C1CEBFF34A49C7C450BF1C78223593AB188EFEFC7C3EE7FE7658CB0AFE` |
| `work/qrh-campaign/agents/prime-estimates/NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md` | `6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043` |
| `work/qrh-campaign/agents/integration/REVIEW_NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md` | `80F6CF2D828922D1654391FEC58720603503059618542B2CE5E049A1C61584EB` |
| `work/qrh-campaign/agents/integration/SMALL_CONDUCTOR_SHARED_ELEMENTARY_CIRCUIT_2026-11-11.md` | `A8AC4A3B594C8671476FCC92C67A45DCF42EFF0060F522023F929BA440835A4B` |
| `work/qrh-campaign/agents/prime-estimates/FINITE_U_HARDY_NORMALIZATION_2026-11-11.md` | `06C9D3BF785BB183339D8EC64BE0B5AAD05331184C35356F575A8C126ADB724E` |
| `work/qrh-campaign/agents/zero-sum/REVIEW_FINITE_U_HARDY_NORMALIZATION_2026-11-11.md` | `96AE06D3F4D1701B13E0CFD529C0E53A0E9647A3B079DD19D03E66C734064EC1` |
| `work/qrh-campaign/agents/zero-sum/FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md` | `5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41` |
| `work/qrh-campaign/agents/zero-sum/SELECTED_SIGN_CHECKER_COST_SUPPLEMENT_2026-11-11.md` | `D4507C3C7F7B513621240AC2BB4B0142B371465FC7AFD5892C2993F0404F4C41` |
| `work/qrh-campaign/agents/zero-sum/REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md` | `B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC` |
| `work/qrh-campaign/agents/integration/R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md` | `F718551E44C343FB874AAD919290D002F402760B5B6B44772B534C087AF2D054` |
| `work/qrh-campaign/agents/major-constants/TURING_SPECTRAL_SURPLUS_REDUCTION_2026-11-11.md` | `6E7CD152D57679AFBEF754D9A1C0060AAA3F28C6E2DB1F6EFB4BD24A6B15C401` |
| `work/qrh-campaign/agents/audit/platt_turing_1305_3087.txt` | `2A2EABBCA321E6B29BC3E0BAE4339245C819B5234C0C4CC222C65E981E84E3E9` |
| `work/qrh-campaign/agents/integration/small_theta_polynomial_interpolation_20261111.py` | `5222B885C5BF9B506356C0EEFAEF2C1970AEC55BC0EFDFE24A3D267342949445` |
| `work/qrh-campaign/agents/integration/small_theta_polynomial_interpolation_20261111.json` | `F3A780AEFBD7C31BAE7CF6A7355FF5699143A3E1FFEE04B9AA00A03C667E9406` |
| `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/NumberTheory/LSeries/DirichletContinuation.lean` | `ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1` |
| `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean` | `C49C714067E797E8DD0F40CCBF39593C754C1DF3AD5A54C7A6F17188F97C7F45` |
