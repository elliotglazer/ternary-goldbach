# Independent review of the small-conductor theta backend

2026-11-11. **PASS as a conditional paper algorithm and exact metadata model.** No mathematical correction requested. Reviewed `prime-estimates/NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md`, SHA256 **6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043**. This does not accept an implemented evaluator, a complete priced elementary-operation subtotal, successful signs, Turing closure, or a measured runtime advantage.

## 1. Source normalization and aliases

I read the pinned Gaussian, off-critical and tilted-slab derivations and the mixed-radix precision contract. Their actual primitive nonprincipal completion, fixed root phase and angular Fourier conventions agree with this report. In particular the conductor phase c^(it/2) and positive prefactor c^(-k/2) remain present. The theta identity includes both parities and its factor 2. The principal conductor is excluded; its constant/pole corrections cannot be obtained from this formula.

At sigma=1/2 the chosen epsilon makes F_b real on the entire real t-axis. Conjugating its absolutely convergent Fourier integral therefore gives G_b(-x)=conj(G_b(x)). This is same-character frequency reuse after the actual root phase. It does not identify positive-height outputs for two different inverse labels. Making the zero-frequency center real is a nonexpansive projection onto its known actual carrier. The common Y output differs from F_b by exp(theta*t/V)>0 and is independent of which tilt was used. An arbitrary sign proxy cannot replace its amplitudes in an interpolation array.

The specialization of the off-critical bounds to sigma=1/2 is justified explicitly: c^(1/4)/sqrt(q)<=c/q and 2c^(1/4)/(pi*q)<=c/q for c>1 and 0<q<=1. With V>=2theta, b and Rlog lie strictly inside the log-plane strip. The sine lower bounds give cos(2b)>=theta/V and cos(2Rlog)>=theta/(2V); Rlog+b>1/2. Thus the displayed Q, L1 and positive/negative time bounds follow from the accepted contour-shift proof. No finite-RH hypothesis is used in that analytic step.

The time periodization proof has the correct orientation: for t>=0, positive copies begin at P+t and negative copies at P-t. The chosen period makes each numerator at most exp(-K) and each denominator greater than 1/2, giving the 32W² geometric allocation. Frequency omission is a separate error. J=ceil(PX/6), pi>3 imply (J+1)omega>X; both omitted signs are covered by the decreasing Q bound. The condition on X gives exp(2X)/W>2X+L, hence 6Q(X)<12W exp(-L). Neither tail was replaced by a single omitted coefficient.

The grid condition ensures J<N/2, so no Nyquist collision occurs. The time transform is positive-exponent, with multiplier omega for the unnormalized transform or omega*N for the normalized transform. The character-transform multiplier phi(c) is not substituted for either. Only grid nodes through floor(V/Delta)*Delta are covered; interpolation, non-grid endpoints and any farther guard nodes remain admission obligations.

## 2. Variable Gaussian cutoff and stable recurrence

The cutoff conditions imply d_j u_j²>=v0 exp(x_j). The omitted-term ratio is at most exp(-z_j). To check z_j>=z0, put A=exp(x_j/2)>=1 and use u_j>=n0/A. The resulting lower expression is

    (6n0/W)A³+(3/W)A⁴-A/n0.

Its derivative is positive for A>=1 because 3n0²/W>=2. The prefactor times the first omitted Gaussian is controlled by exp(3x/2-v0 exp x), whose derivative is negative for x>=0. These facts prove the uniform series-tail allocation for both parities. The interval for choosing u_j has an integer with room for certified inequalities; at j=0 the exact choice u_0=n0 is supplied. No exact transcendental floor test is required.

The bound M_j<=n0 exp(-j omega/2)+1 sums to (9). The estimate uses an infinite geometric upper bound for a finite nonnegative sum, not a claimed observed workload. Both parity buckets may use the same g_n, with exact integer n scaling in the odd channel.

The unit-disk gate is valid. If the first rounding has error eta, the stored norm is at most 1+eta. Shrinking by 1-2eta and rounding again gives norm at most 1-2eta² and error at most 4eta+2eta²<=5eta. This proves the invariant; merely observing a floating modulus would not. Initial q must satisfy the same certified disk condition.

With d=q² and h_1=q*d, the initial error bounds are 2delta+gamma and 3delta+2gamma. Unit-norm nonexpansiveness gives, inductively,

    e(h_(n+1))<=e(h_n)+e(d)+gamma,
    e(g_(n+1))<=e(g_n)+e(h_n)+gamma.

Their solutions are (2n+1)delta+2n gamma and n²delta+(n²−1)gamma, respectively. No exponential perturbation factor is hidden. To obtain M>=2 terms requires two setup products, M−1 g updates and M−2 h updates, exactly 2M−1 gates. M=0,1 require no such products. The cost of each gate includes both roundings and the shrink.

## 3. Full finite-accuracy allocation

I checked each stage against the accepted absolute complex-norm gate contract, rather than identifying that contract with a coordinate precision.

The seed/recurrence allocation bounds all weighted n^a errors by eps/(32 C Bpref); additions contribute at most the same amount. Their bucket l1 sum is therefore at most eps/(16 C Bpref). A character output has unit-modulus coefficients, so this l1 error is not multiplied by phi(c) again. The intrinsic character-transform error is different: applying the normalized precision bound then returning to the unnormalized output gives eps/(64 C Bpref) under the specified u_char. Its cached Bluestein kernel errors remain included.

For the prefactor product, use exact-prefactor times contraction error plus prefactor error times the stored contraction. This accounts for the cross term without dropping it. The two eps/(64 C) terms and the eps/(32 C) final rounding sum to eps/(16 C); together with input error this is eps/(8 C). Summing the complete coefficient tail and arithmetic over the retained signed frequencies costs at most eps/4 because omega(2J+1)<C. Negative-frequency copying duplicates this error only through those already counted weights.

The coefficient magnitude 2W²+1 is valid: for u=exp(x)>=1, exp(u²/W)>=u²/W gives Q(x)<=2W²/u<=2W². The extra unit safely covers the admitted coefficient approximation. The time-stage tolerance is for the normalized transform, then scaled by omega*N<7/Delta. It gives eps/8 intrinsic output error. Approximation of omega and the final multiplication supply the additional eps/8. Thus the four allocations—time aliases, omitted frequencies, finite coefficients and time arithmetic—give F error below eps.

Finally |F_center|<=2W²+1, exp(theta*t/V)<=3^theta and eps=tau/(4*3^theta). The exact scaling of the F error, uncertainty in the scale, and final rounding cost at most tau/4 each. The claimed error below 3tau/4 for Y is sound. All these requirements are still certificates to be produced, including the actual root phase and the argument errors of the exponential seed.

## 4. Finite selector, metadata and costs

All integer selections terminate for fixed admitted c,V,theta,tau: geometric K/L tests, exponential-over-linear X growth, dyadic refinement of Delta, power-of-two growth of N, and quadratic-exponential decay for doubled n0. This is finite-accuracy termination only. No argument ensures that a fixed tau discovers strict signs or handles all multiple/nearby zeros.

I independently validated all fifteen rows, including the minimal K,L,X,N and seed-bit tests, Gaussian cutoff inequalities, group shapes, full-axis butterfly/product counts, output counts and ratios. The cyclic axes for 1000 are 2,2,100 and for 10000 are 2,4,500; their primitive counts are 160 and 1600. These examples use a conservative whole-axis Bluestein schedule where needed, not an assertion that it is the optimal mixed-radix schedule.

The storage distinction is material. A frequency-streamed bucket array does not remove the label-by-frequency transpose required by time transforms. Without checked stored intermediates, processing only r labels at a time repeats the frequency/character work ceil(n/r) times. Setup roots, kernel generation, raw product widths, external storage and proof acceptance remain separate from butterfly totals. The old H=10^8/c plus 1000 scenario is explicit; it is not an accepted guard width or a replacement for the complete current height union.

**Cost qualification:** “one exponential per retained frequency” counts the outer q_j=exp(-z_j). Constructing z_j=pi*exp(2x_j+2ib)/c, the real radial factors, full prefactors and root-number phases is additional elementary work. The report lists such leaves separately but does not give a complete count or a proved shared geometric-generation schedule for them. I do not interpret Rfreq as the total elementary-operation bill. Likewise the reported seed bits do not prescribe every other stage's precision. This limits pricing, not the conditional error proof, which requires the complete q and prefactor enclosures.

The model is therefore useful for comparing concrete admitted implementations once those leaves, widths, transpose and repairs are priced. It establishes neither a runtime winner nor a successful spectral output.

## Evidence

All nine author-table pins match. The independent script imports no author module, evaluates no analytic function, and checks only finite rational/integer metadata and scalar identities. **259 checks passed across all 15 rows.**

* `integration/review_small_conductor_backend_20261111.py`, SHA256 **FEAC1FCC48FEB7BE4FE72451F7F676F8DA83BB26164C5C997DD4F0154A3F6D22**.
* `integration/review_small_conductor_backend_20261111.json`, SHA256 **504566998B9156E982304FE54AF88A5F566E7093F005512DBD5A180B1CB4F5EF**.

The accepted analytic predecessors are used at their pinned paper/source boundaries; their entire lower libraries are not recursively re-audited here. No Lean/MM0 declarations, implementation, build, evaluated coefficient, sign certificate or final-root acceptance is supplied. Existing artifacts were unchanged.
