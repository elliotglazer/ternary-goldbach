# Independent review: small-theta output and finite-polynomial interpolation

Date: 2026-11-11. Verdict: PASS as a conditional paper evaluator and source-interface audit, with no correction required. This does not certify any function value, sign, zero count or finite RH assertion, and does not establish that this interpolation schedule is the cheapest one.

Author: `integration/SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md`, SHA-256 `19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081`. Scalar script: `5222B885C5BF9B506356C0EEFAEF2C1970AEC55BC0EFDFE24A3D267342949445`. Receipt: `F3A780AEFBD7C31BAE7CF6A7355FF5699143A3E1FFEE04B9AA00A03C667E9406`.

I read the frozen note, the small-conductor backend, the whole-family inventory, the selected-sign contract, relevant primary Platt text, and the actual Mathlib completion/Gamma formulas. All 17 author source/support pins match. Independent rational work reconstructed the seven kernels by a different weight recurrence, checked reproduction of degrees0 through6, reproduced every exact Lebesgue norm, and checked the uniform remainder, error sum and schedule counts. No author script was executed or imported. No analytic values, transforms, builds or source edits were made.

## Normalization and the historical gap

Mathlib `NumberTheory/LSeries/DirichletContinuation.lean:258` identifies L with the completed L-function divided by its Gamma factor. On the critical line, Gamma nonvanishing follows from positive real part. `Analysis/SpecialFunctions/Gamma/Deligne.lean:46,69` gives GammaR(s)=pi^(-s/2)Gamma(s/2) and its nonvanishing. Thus the author's completion formula is valid without making any assertion about totalized Gamma values at poles.

With alpha=(2a+1)/4 and a fixed compatible epsilon, the backend Y equals pi^(-alpha) times Platt's Lambda_P, as defined in the retained primary text at lines64–76. It is a positive height-independent factor. The separate conductor-completed Hardy normalization differs by c^(-alpha)exp(pi*t/4), as stated. These are amplitude identities, stronger than mere sign equivalence. The unrelated positive-cosine sign proxy cannot be substituted as a Y interpolation sample.

The negative-ordinate identity uses the inverse character and the sign kappa=epsilon_chi*epsilon_inverse, with kappa in {+1,-1}; it includes exp(-pi*t/2). It is not the frequency conjugation identity and does not merge the two positive channels of a nonreal orbit.

The primary text really does leave the final omitted-sample lemma6.7 at “large enough t0” (line909), and lemma6.6 uses its specified center geometry. Consequently the old finite Gaussian/sinc cost schedules alone do not prove uniform low-height and off-grid tail admission. The new construction does not silently complete that historical proof: it supplies a separate finite-polynomial route.

## The function being interpolated

The exact stored phase-normalized coefficient centers define a real periodic trigonometric polynomial T. The zero coefficient is real and the negative coefficients are exact conjugates. These conditions must be enforced on the actual retained array. T has period P=N*Delta and is globally smooth.

The accepted backend bounds time aliasing, omitted frequencies and coefficient errors uniformly for every real target t in [0,V]. Their sum is less than 3eps/4. They therefore bound F_b(t)-T(t) at the target independently of any grid. The time FFT, in contrast, evaluates this exact finite T and has a separate arithmetic error. The distinction is essential: applying Lagrange weights to uncertain actual F_b samples would amplify their analytic errors and would not justify the displayed allocation.

For the inventory parameters X=10, P>=6, Delta=5/64, J=ceil(PX/6), and coefficient norm at most B=2Wbar^2+1, the exact bounds are

    omega(2J+1)<44,
    J*omega<=pi*X/3+2pi/P<=242/21,
    |T^(r)(t)|<=M*Omega^r,
    M=44B<=137500000000044<2^48.

They hold globally for T, not merely at admitted physical heights. The mass estimate includes both frequency signs and the zero slot. The transform normalization is omega times the unnormalized positive sum, or omega*N times the normalized inverse transform.

## Interpolation and independent rational checks

Use nodes j=-m+1,...,m, m=170, centered about target coordinate xi in [0,1]. The real Lagrange remainder has derivative order2m. Directly pairing opposite factors gives

    product_j |xi-j|=u product_(j=1)^(m-1)(j(j+1)+u),
    u=xi(1-xi).

Each factor increases for 0<=u<=1/4. At u=1/4 the product equals [ (2m)!/(4^m*m!) ]^2. Dividing by (2m)! and using binomial(2m,m)<=4^m proves the uniform remainder M*(Omega*Delta/2)^(2m). This includes xi=0,1, where the product vanishes.

The independent exact calculation verifies M*(605/1344)^340 < eps_min/16 for eps_min=2^-80/(4*3^128). Hence the same fixed order works for both tilts and all admitted cohorts. It requires no assumption about zero spacing or the size of a sign margin.

For each xi=ell/8, ell=1,...,7, I formed the first Lagrange weight by a direct product and generated subsequent weights by

    l_(j+1)/l_j = (xi-j)/(xi-j-1) * (-(m-j)/(j+m)).

The resulting exact norms agree with the receipt. Their upward thousandth bounds are respectively 1.675,2.222,2.578,2.701,2.578,2.222,1.675. All are strictly below4. Polynomial reproduction through degree6 passed as a check of these kernels; the general interpolation theorem follows from the product formula and remainder proof, not from these finitely many checks.

## Arithmetic, wrapping and output semantics

Every consumed sample must enclose T itself to eps/64, including twiddles, FFT arithmetic, omega approximation and final scaling. This is a factor16 tightening of the old total eps/4 time-evaluation allowance. Four additional fractional bits suffice for those linear sufficient tolerances under the same checked scheme; this is not a claim that all operand widths or runtime grow by a universal fixed percentage. Root construction, rounding, scale accuracy and the retained proof obligations still have to implement those tolerances.

Exact kernel weights amplify the sample errors by less than4. Quantizing each weight within eps/[32*340*(M+1)] contributes at most eps/32, since the sample centers have magnitude at most M+1. A separate eps/32 allowance for all product/accumulation rounding completes the finite evaluation budget. Decomposing with the exact weights first avoids double counting or omitting the weight/sample cross error. The total target F_b radius is strictly less than

    3eps/4 + eps/16 + eps/16 + eps/16 =15eps/16.

The first term occurs at the target once and is not multiplied by the interpolation norm.

The unwrapped stencil can cross zero or V. Its samples are reduced modulo N only because T is exactly P-periodic. The algebraic FFT error applies to all N outputs of this finite polynomial, even where no F_b or Y output was admitted. No periodicity of the actual L-function or unproved negative/top guard values is used. The old exported Y prefix alone is insufficient: the retained/recomputed T array and its complete arithmetic linkage are needed. All final physical targets still must lie in [0,V].

For numerical Y values, positive rescaling at the new target is required and is charged. The proposed reuse of a coarse scale and one of seven offset factors is sound: the true offset factor is below2, coarse error s/4 contributes at most s/2, offset error s/[4(3^theta+1)] contributes at most s/4, and product rounding contributes s/4. For a strict sign only, the positive rescaling can instead be omitted, with its exact identity recorded. Neither option permits mixing coefficient arrays with different tilts or phases.

## Costs, completeness and retained inputs

The count 7*(1775431871117-18477108)=12427893758063 new dense eighth-grid points is correct. Multiplication by340 gives 4225483877741420 real weighted terms for this direct stencil schedule. These count identities neither forecast time nor show superiority to a dense convolution or enlarged time transform. The existing large FFT/storage/transposition costs remain; selected-sign endpoints may still consume most of the coarse array. Shared rational kernels and their correctness proofs are not free hash inputs.

The sign-to-count interface remains unchanged. Strict opposite signs for the same actual normalized function give an interior critical-line zero, not its simplicity or the total count. Both nonreal positive channels and the separate central handling remain necessary. The finite-RH-only U<K+2 rule has its previously reviewed critical-line lower-count and reflection hypotheses; exact-count consumers require their stronger rule. The new interpolation supplies none of the required successful signs, auxiliary weights or surplus. No guaranteed completion or repair rate follows from eps or tau.

The relevant reviewed backend and inventory pins are respectively `6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043` and `74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE`. The selected-sign contract is `D4507C3C7F7B513621240AC2BB4B0142B371465FC7AFD5892C2993F0404F4C41`. Primary Platt text is `2A2EABBCA321E6B29BC3E0BAE4339245C819B5234C0C4CC222C65E981E84E3E9`; Mathlib completion and Gamma files are `ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1` and `C49C714067E797E8DD0F40CCBF39593C754C1DF3AD5A54C7A6F17188F97C7F45`. The verified author ledger binds the remaining support boundaries.

This review accepts one complete in-domain interpolation proof and its conditional finite-arithmetic interface. Actual coefficient data, ordinary-rule implementations, source/array identity checks and successful spectral certificates remain outstanding.
