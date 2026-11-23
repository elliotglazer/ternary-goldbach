# Independent review: original trace-normalized Poisson identity

Date: 2026-11-11. Verdict: **PASS for the stated bounded mathematical/source implication.** No correction is required to the frozen author report. This does not establish successful Lean elaboration, transitive axiom closure, or validity of the entire QRH provider.

Reviewed author: `integration/QRH_ORIGINAL_POISSON_ANALYTIC_AUDIT_2026-11-11.md`, SHA256 `DE7237156824F7503A51F36A9E4A777F57647F2FC98F82D624D000E5D5C12AFA`. I read the full report and independently traced its principal analytic normalization and summability chain. All eighteen source/manifest pins were reconciled with current bytes by `check_original_poisson_source_20261111.py`; its receipt is the same stem with `.json`. That script performs only byte reads and hashing.

Source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, expected provider commit `4eaee87548250b2682affda7d05d947c05554bae`. Whole-file hashes are preserved in the receipt and the author inventory. Report paths are relative to `work/qrh-campaign/agents/`. No Lean source was modified, no build was attempted, and no analytic numerical value was evaluated.

## 1. Independently reconstructed lattice normalization

Write omega=-1/2+i sqrt(3)/2. The real-linear map A_c sends x+iy to c(x+omega y), with determinant |c|² sqrt(3)/2. Therefore its inverse Jacobian is 2/(sqrt(3)|c|²). The c!=0 hypothesis is necessary and supplied before the map, dual map, and all divisions are formed. `Poisson/EisensteinLattice.lean:61–133,144–269` proves the general change of variables and applies it to this exact lattice.

The inverse-adjoint frequency at the integer pair (k,l) is

`[k+i(k+2l)/sqrt(3)]/conj(c)`.

The integer map (k,l) -> eval(k+l,k), whose inverse on Eisenstein coordinates (a,b) is (b,a-b), has determinant -1. It is thus a bijection onto the full lattice, including zero, not a restriction to primitive points or unit classes. See `Poisson/OscillatoryGaussian.lean:270–294` and `Poisson/EisensteinLattice.lean:400–466`.

For h=eval(k+l,k), direct real and imaginary part calculation gives the same frequency as `(2i/sqrt(3))*conj(h/c)`. The source's `paperE(z)=exp(4pi i Im(z)/sqrt(3))` is exactly the standard positive Fourier character paired with that frequency. Its Fourier integral uses `paperE(-zu)`. The positive translation phase and negative integral phase are consistent; no conjugation or sign is being supplied by convention after the fact.

The paper Fourier transform is `(2/sqrt(3))*standardFourier` at this transformed frequency. It therefore absorbs the factor 2/sqrt(3) in the inverse Jacobian, leaving precisely 1/|c|². The trace generator here is `eisLam=1+2omega=i sqrt(3)`; it is not silently identified with another good-prime generator. I checked the actual exponential and periodicity adapter in `ChineseRemainder/AdditiveCharacters.lean:510–574`, `Arithmetic/EisensteinEmbedding.lean:272–298`, and `GaussSum/SexticRadialPoisson.lean:232–404`.

## 2. Radial scale and actual character

`paperRadialFourier(W,t)` evaluates the paper transform of W(|z|²) at sqrt(t). Rotation invariance is proved by a unit complex change of variables, with the zero argument handled separately. Scaling z by 1/sqrt(K), K>0, contributes the real Jacobian K. Thus the final radial transform is

`K * paperRadialFourier(W, K*|u|²)`.

There is no further 4/3 in the radial argument: 4/3 belongs to the norm of the standard transformed frequency and has already entered the definition of the paper radial transform. Every argument used in the radial formula is nonnegative, so the definition at negative real inputs is irrelevant. `GaussSum/SexticRadialPoisson.lean:406–549` constructs the scaled Schwartz test and proves this identity rather than assuming radial decay alone.

For a finite residue weight P, the resulting identity has prefactor K/|c|² and the exact finite coefficient `sum_r P(r)*psi(h*r)`. The additive character is the source trace character on O/(c), and the representative-independence follows from its proved periodicity.

The canonical sextic specialization uses nontrivial local powers 1 through 5. Its finite transform is `conj(row(h))*G`, including nonunit and zero h. This identity does not require dividing by G, a nonzero Gauss sum, trace primitivity, or a unit-norm Gauss estimate. The later normalization `G/|c|` divides only by a proved nonzero modulus norm. These distinctions hold in `GaussSum/SexticRadialPoisson.lean:58–179,614–773`; the finite CRT factorization is explicit in `Poisson/EisensteinLattice.lean:518–630`. The local character-order and finite-field Gauss foundations remain below this review's cut.

## 3. Genuine convergence before interchange

The two-dimensional Poisson theorem is not used as an unproved shorthand for a possibly default-valued tsum. `GaussSum/SecondPoissonScale.lean:536–949` supplies three separate product-lattice summability witnesses: for the Schwartz function, its Fourier transform, and the intermediate partial Fourier transform.

For the first two, seminorms of orders 0,2,4 dominate the function by a constant times `1/((1+x²)(1+y²))`. The integer Cauchy weights are summable by the p=2 series, and their product is summable. For the intermediate transform, continuity follows from an integrable uniform vertical majorant. Integrability and the product Fourier identity give the actual partial transform; Fourier inversion identifies it with the constructed Schwartz slice. Two horizontal derivatives then provide the second coordinate's decay. Hence the product-sum commutations in `integer_pair_poisson:935` have actual summability hypotheses. The misleadingly specific name `partialFourier_gaussian_summable_norm:853` has an arbitrary Schwartz-function binder.

The affine/coset version inherits norm summability from the Schwartz pullback. A finite residue weight is bounded by the sum of its absolute values. `GaussSum/QuadraticNormalization.lean:364–387,465–510` partitions only a summable series and uses the actual bijection w -> representative+c*w for each fiber. On the dual side, `Poisson/EisensteinLattice.lean:333–398` obtains norm summability before moving the finite residue sum inside the infinite Fourier sum. No measurable choice of representatives or uniform modulus estimate is needed for these discrete finite operations.

## 4. Masks, units, and the original input

`PrimeRows/IdealGenerators.lean:98–290` performs finite mask inclusion-exclusion using summable indicators. Each divisor ideal is represented by a nonzero generator e, and reindexing the ideal fiber changes the radial scale to K/|e|². This gives one factor `mu(E)*row(e)/|e|²`, not two copies of the dilation factor. Positivity of the reduced scale is explicitly proved.

The source-selected modulus generator can differ from the product of prime generators by a unit. `GaussSum/CubicTrace.lean:427–526` retains the corresponding row phase, then cancels it against the conjugate row after reindexing the entire frequency lattice by multiplication by that unit. Norms and zero are preserved. The equality of the two normalized Gauss constants is required only inside these radial sums; they need not be pointwise equal before phase transport.

I also read the actual masked pair formula and body in `CubicSieve/SecondPoisson.lean:83–154`. It specializes the active row to `conj(row_T)*row_S`, with S and T disjoint, and supplies the active nontrivial exponents. The prefactor is Y/|n|; the remaining divisor and conjugate-row factors appear explicitly in the dual summand.

`CubicSieve/ChildTransfer.lean:447–565` establishes summability for every finite overlap summand before taking the three finite sums through tsum. Its branch with a false disjointness condition is the zero function; no nonzero pair is discarded by this representation. The squared-row overlap identity at :179 reindexes all pairs by common support and disjoint residual supports.

Finally `Inversion/InitialRayAttachment.lean:224–296` substitutes Y=Z^m and extracts the exact normalized-square factor Z^-D from |Z^(-D/2)|². Only Z>0 is needed for this identity, without an extra nonnegativity assumption on m or D. The identification of the resulting physical summand uses the already separated ray/kernel identities. This review checks their interface and normalization; it does not newly prove all underlying Gauss reciprocity or finite ray expansions.

## 5. Zero mode, limits, and remaining proof boundary

Zero is retained by the integer, coset, and unit bijections. The marked-zero formula is a separate arithmetic evaluation of that summand; it is not obtained from high-frequency decay. The previously reviewed `InitialPhysicalLimit.lean:49–108` forms a genuine HasSum of the finite arithmetic family of summable modes before splitting zero and taking the nonzero-frequency estimate. The radial summability input in `QuadraticSieve/PrimePools.lean:472–505` uses a positive scale and a bounded finite Gauss factor. The finite dyadic decomposition is applied to finite nonzero-frequency sets before this limiting argument.

No limit over all prime pools is asserted here. Each arithmetic pool is finite; each required lattice series is summable for its fixed data. Later estimates supply their own uniform constants. This distinction is explicit in the author report and is mathematically sufficient for this identity.

The surviving lower foundations are Mathlib's one-dimensional Schwartz Poisson theorem, Fourier inversion/Fubini and Haar-change formulas, the Schwartz composition/transform infrastructure, the canonical character-order and finite-field Gauss facts, and the transitive Eisenstein/PID/ideal-coordinate and ray-conversion foundations. The inspected bodies supply the hypotheses of these inputs but do not constitute an independent proof or kernel check of every input.

The report's claimed scope is therefore accurate. This bounded implication introduces no new final premise and reveals no normalization, zero-frequency, or convergence defect. Full provider semantics, compilation and permitted transitive axioms remain separate gates.
