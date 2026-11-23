# Independent review: actual long two-pass estimate

Date: 2026-11-11. Verdict: **PASS for the bounded, conditional mathematical source assembly described below.** No correction remains requested in the frozen author report. This does not validate the entire QRH provider, prove its child moments, or establish compiled axiom closure. No Lean/Lake command, analytic evaluation, or source modification was used.

Reviewed author: [QRH_TWO_PASS_ANALYTIC_AUDIT_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/zero-sum/QRH_TWO_PASS_ANALYTIC_AUDIT_2026-11-11.md), SHA-256 **15A32FFB650E713609A2DB97F2C7BCE8ACA4B7881EDC04DDA57B2778A271A8F5**.

Provider revision: `4eaee87548250b2682affda7d05d947c05554bae`. All 47 author source-file hashes match the accessible files. An additional 21 source files used for independent checks are pinned in [the read-only hash receipt](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/qrh_two_pass_source_pin_review_20261111.json), SHA-256 **3FA3494691A01667E3234245B5604E2548540FC11174F89CC2014D210804B0C3**. A file hash identifies bytes; it does not imply review of every declaration in the file.

## 1. Exact claim and quantifiers

The entry points are [actual_marked_bin_uniform_test](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/CanonicalLongUniformTestBin.lean:16) and [reopening_twisted_moment_squared](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/CanonicalReopeningHeight.lean:35). The actual prime pool, primary generators, cube coefficients, excluded-prime factor, marked rows and live source keys survive the adapters. In particular, the coefficient parameter `m * excludedGenerator S` is not substituted for the main row parameter `m`.

The four compact child profiles and their support window are chosen before `epsFirst`, `epsSecond`, the child degree and actual arithmetic data. They can depend on the already-fixed capacity, cutoff and mass/deletion parameters. The later constants are uniform in the actual pool, labels, coefficients, real height and reopening frequency. The two `ChildBounds` assumptions, one for each first-pass sign, each contain both second-pass sides: these are four genuine child-moment obligations, not consequences of this estimate.

The assumptions quantify over every reopening frequency and every resulting actual live key, then every applicable ray, core, assignment, second cell, real modulation and actual triple. Bounds at selected frequencies would not suffice. Closed cube norm windows, squarefree nonzero labels, disjoint mark lists, the physical support inequality and all smallness/capacity conditions remain present. In particular, `Z^eta >= 2` makes the admissible case `eta = 0` empty; the theorem does not silently turn that impossible parameter choice into a useful estimate.

Writing \(F=r+3\ell+V\) and \(\Gamma=C_{\rm coef}(eZ^\ell)^{\varepsilon_1}\), the conclusion is the claimed bound
\[
 Z^{-V}\mathcal E(\text{actual reopened rows};Z^M)
 \le C\Gamma^2(1+A)Z^{F+\mathrm{lossFinal}}
 \left(\int |a(\xi)|(1+|\xi|)^d\,d\xi\right)^2.
\]
Here \(a\) is the actual reopening coefficient and \(d=\operatorname{momentOrder}(\operatorname{firstDegree}(\mathrm{degree}))\). This abbreviation does not replace the complete source hypotheses.

## 2. Finite rows, actual integrals and first-pass splitting

I checked the finite row expansion in `ReopenedSource` and `ReopenedBlocks`, and its consumption in [original_reopened_physical_split](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/ReopenedPhysicalSplit.lean:41). Pair coefficients and conjugation are retained. The first Fourier split is not a rearrangement of an unproved infinite sum: [actualFirstKernel_truncate](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/GaussSum/BranchScaling.lean:616) explicitly consumes [actualFirstKernel_summable](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/MeanSquare/PoissonSource.lean:459). The latter reduces to finitely many `canonicalPairMode_summable` instances. The foundational proof of those Poisson/summability inputs remains outside this review.

The resulting first-pass inequality has three terms:
\[
 \mathcal E\le |\mathrm{physicalZero}|+
 K|\mathrm{retained}|+|\mathrm{tail}|.
\]
The original row-zero square removed to form the nonzero-row energy is nonnegative. It is a different object from the physical dual zero-frequency term, which stays on the right. The factor \(K\) multiplying the retained expression is preserved.

In [first_family_cauchy](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/FirstFamilyEnergy.lean:34), the common weight is replaced by its norm and the outer phase has modulus one. Weighted Cauchy therefore yields \(\sqrt{B_1B_2}W_J\), with no extra source-cardinality factor. The unequal-energy integral version uses exactly this product.

A generic norm-of-integral inequality alone would not prove that an arbitrary input is Bochner-integrable. Here [integrable_first_block_density](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/FirstFamilySource.lean:16) expands the actual integrand as finitely many integrable densities times unit phases; `first_family_density_sum:41` then justifies the finite sum/interchange. The common Fourier measure separately supplies weighted integrability. This distinction is correctly retained in the final author report.

The first physical prefactor cancellation uses both child square-root normalizations, not just one. Live-key counting also remains explicit. The draft attribution of its final \(+\varepsilon_1\) loss was corrected: `FirstDyadicRetainedEnergy` retains a key cardinality, and `FirstDyadicRetainedBudget` bounds it using `original_live_joint_small_power`.

## 3. Second-pass normalization and deleted-source transport

The geometric restriction in [original_retained_geometry_sum](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/GlobalRetainedGatesGeometry.lean:71) is an equality: outside the filter, the compactly supported first window is zero. It is not deletion of complex summands by a positivity argument. The actual `wholeRow_eq` keeps the signed source weight, quotient puncture and both remaining mark lists.

The deleted-prime condition is substantial: each deleted prime belongs to cube support or the first common set, or divides the actual quotient ideal. `SecondDeletedOriginalBound:18` transports through the varying-assigned and assigned triple sets only with nonnegative `tripleDivisorWeight`. The geometric two-energy estimate is linear in the common bound \(A\). The two unit sectors and remaining subset sums account for \(36\,2^{|S_1|+|S_2|}\); these are not treated as one uncharged row.

A useful independent check is [normalizedColumnEnergy](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/InitialClippedColumns.lean:199). It puts \(Z^{-F_c/2}\) inside each row norm; thus raw column energy equals \(Z^{F_c}\) times normalized energy. The actual child hypothesis is normalized energy at most \(A Z^{F_c+\varepsilon_{\rm child}}\) times its height weight. Restoring normalization therefore gives
\[
 A Z^{2F_c+\varepsilon_{\rm child}},\qquad F_c=\max(0,N)+V_{\rm lab}.
\]
This agrees with `SecondDeletedPhysicalRecursive`; neither the exponent nor \(A\) is squared again.

The physical coefficient remains
\[
 e^{6L}\left|Y\,\mathrm{ray}/(E V X)\right|.
\]
The exact exponent identity \(\kappa+\lambda+q+2(N+V_0)=F\) in `PhysicalExponents:50` checks by expansion. Its losses are \(28\eta+\tau\) from the physical and mass factors, at most \(12\eta\) from twice the clipping width, and \(8\eta\) from twice the label padding. This gives \(F+48\eta+\tau+\pi+\varepsilon_{\rm child}\), including the mass allowance \(\pi\). No \(N\ge0\) assumption is needed.

The density in [SecondProfileUniform.common_measure](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/SecondProfileUniform.lean:198) is the actual product of translated Fourier profiles, two twisted source transforms and the radial coefficient. Its normalization is retained; unit phases only disappear after taking norms. Weighted integrability is explicit at line 113. The underlying radial separation and uniform Fourier seminorm bounds remain named lower inputs.

## 4. Tail budgets and final scalar absorption

Both passes keep zero, retained and complement-tail branches. I independently checked the following exponent bookkeeping.

* The first global tail aggregates a \(B^5L_0^2\) count with \(B^4L_0^2\) from two marks and label mass \(Z^{V+\eta}\). With \(B=Z^{\ell+\eta}\), \(L_0=Z^{r+\eta}\), this costs \(Z^{9\ell+4r+V+14\eta}\). Since \(9\ell+4r+V\le4F\le4F_{\max}\), the requested local saving \(\mathrm{saving}+4F_{\max}+14\eta\) pays it.
* `FirstDyadicFullEnergy` requests an additional \(\eta\) before applying \(Z^{-r-2\ell-V}\le Z^\eta\).
* `GlobalPriorityTail` requests an additional \(13L_{\rm cap}\) for source/mark mass. `GlobalPriorityTailPhysical` requests another \(L_{\rm cap}\), then uses \(Z^\kappa e^{9\eta\log Z/2}\le Z^{L_{\rm cap}}\). This is a finite capacity allowance, not a claim that the second tail vanishes.
* The four-coordinate logarithmic key cost is absorbed with the separate positive \(\varepsilon_2\) allowance before invoking the final requested loss.

Finally [two_pass_scalar](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/TwoPassScalar.lean:10) bounds the zero, retained and tail exponents separately. It needs the stated \(M-\ell\le F\), principal-loss inequality, retained-loss inequality and \(-\mathrm{saving}\le F+\mathrm{lossFinal}\). It uses \(1+A\ge1\) and height weight at least one when enlarging zero/tail terms. None of those conditions is inferred merely from nonnegativity of constants.

## 5. Reopening and height

The finite-vector energy inequality is [rowFamilyEnergy_integral_polynomial](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/CubicSieve/DensityBudgets.lean:279); its coordinates are the finite labels and finite nonzero frequency disk, with square roots of nonnegative row-majorant weights. The actual varying separated rows are integrable by [ReopenedIntegralEnergy](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/ReopenedIntegralEnergy.lean:16).

For \(B=Z^\ell\) and length \(Z^r\), the reopened row has prefactor \((B\sqrt{Z^r})^{-1}\). Squaring and applying the outer normalization gives precisely
\[
 Z^{-V}(B^2Z^r)^{-1}Z^{r+2\ell+V}=1.
\]
This is the explicit cancellation in [CanonicalLongIntegral](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/CanonicalLongIntegral.lean:13).

The reopening coefficient is the Fourier transform of the frequency-twisted logarithmic source. Its weighted moment grows by \((1+|\theta|)^{J+\mathrm{integrablePower}}\); squaring doubles that exponent. Nonnegativity justifies the square. The consumer `CanonicalLongHeightBin:94` explicitly supplies smoothness of `normTwistedSource`, so the auxiliary proof parameter is not an unaddressed vacuity at that call site.

## 6. Remaining boundaries and outcome

The frozen report's conditional verdict is appropriate. This review does not discharge:

1. The four actual child moments and their eventual induction/base cases.
2. Foundational first/second Poisson, local Gauss/CRT and absolute-summability estimates.
3. Retained push/live-key divisor estimates, deleted-mode branch energy, and normalized divisor-mass estimates below the inspected finite transports.
4. The uniform radial/Fourier seminorm foundations and local rapid-decay estimates beneath the checked global tail budgets.
5. Elaboration, exact exported types, or complete transitive axiom validation.

No circular use of the two-pass conclusion was found in the inspected assembly. This is a local statement, not a complete dependency-graph certificate. The review changes no final premise or selected spectral requirement. The target remains unconditional `TernaryGoldbachFrom (10^27)`; the full statement retains only its original inclusive `BinaryGoldbachInput` through \(4\cdot10^{18}\). Neither target, nor the global QRH provider needed by the strategy, is proved by this source review.

