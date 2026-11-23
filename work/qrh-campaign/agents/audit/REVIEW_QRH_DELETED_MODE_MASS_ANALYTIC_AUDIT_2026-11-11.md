# Independent review: deleted-mode energy and normalized mass

2026-11-11. **PASS at bounded, conditional mathematical source scope.** No correction is requested in the frozen author report. This is not a full QRH-provider validation, compiled proof check, or axiom-closure result. No Lean/Lake command, analytic evaluator or source modification was used.

Reviewed author: [QRH_DELETED_MODE_MASS_ANALYTIC_AUDIT_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/zero-sum/QRH_DELETED_MODE_MASS_ANALYTIC_AUDIT_2026-11-11.md), SHA-256 **B7575C743474BBF80AA421937AFDAD10590EA76BE21FB421B6225DDEC8CAA859**. All 28 source pins match. Five additional files inspected are pinned in [the hash receipt](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/qrh_deleted_mode_mass_source_pin_review_20261111.json), SHA-256 **F134EAC0DFAF6936ED633AF055B8AE65A50326981B458F1AFA6B6FE9054A8FDA**. A file pin does not mean every declaration in that file was audited. Provider revision remains 4eaee87548250b2682affda7d05d947c05554bae.

## 1. Targets, quantifiers and actual coefficients

The targets are [actual_second_deleted_mode_branch_energy](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/SecondDeletedModeEnergy.lean:18) and [actual_second_normalized_mass](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/SecondActualMass.lean:35). The former is a finite pointwise estimate for supplied windows, source rows and modulation parameters. It does not itself assume or prove a child moment bound. The latter has a constant chosen from K and positive epsilon before the prime family, finite source, units and real scale parameters. The author's references to eventual child moments concern subsequent consumption, not an extra premise in these two finite estimates.

The prime-generator, maximal-ideal, coprimality, injectivity, primary-congruence, characteristic-not-two and actual source-admissibility hypotheses are retained where needed. No unrestricted source is substituted for the admissible source. The monoid character has norm at most one at every required argument.

[SecondWeights](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/SecondWeights.lean:15) retains the squared norm of the actual input coefficient, the Möbius factor and the actual common weight. The source-dependent puncture includes the quotient generator; it is not replaced by the bare outer parameter. The additional phase is the supplied bounded coefficient times secondModeOuter, whose norm is one. This review does not infer a bound on arbitrary extracted marks: those marks are expanded into assignments and charged separately.

I followed the common-weight bound through [FrequencyTwists](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Fourier/FrequencyTwists.lean:591). It is a product of two precolumn bounds and a unit-norm Möbius factor. The precolumn uses the normalized column Gauss factor and the finite squarefree row bound. [The row bound](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/PrimeRows/IdealGenerators.lean:526) follows from its exact self-pair/coprimality-mask identity; [that identity](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/GaussSum/SecondPoissonScale.lean:191) is a finite product, zero if any local argument vanishes and one otherwise. The deeper normalized Gauss/CRT calculation remains an imported foundation, not a new result of this review.

## 2. Fibers, Cauchy and deletion

The map from actual sources to child triples can have repeated values. [SecondSourceEncoding](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/SecondSourceEncoding.lean:31) first injects admissible sources into the structured original tuples. The cube is recovered from a nonzero product and its three divisor keys: [SmoothTests](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Eisenstein/SmoothTests.lean:601) cancels the left product to recover the right, then recovers both exponent functions and both bit supports. Source validity in CubeSource is proved using the cube factorization and actual assignment support.

For fixed outer triple (q,t,r), label f and row k, [SecondFibers](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/SecondFibers.lean) encodes a valid tuple by four divisors of f, one divisor of (qf)^2, three divisors of qf, and its old/new assignments. Remaining factors and the frequency are recovered by cancellation of nonzero ideals/generators. Thus the fiber bound is

\[
d(f)^4d((qf)^2)d(qf)^3d(qft)^{J_o}d(fr)^{J_n}
\le d(f)^{9+J_o+J_n}d(q)^{5+J_o}d(t)^{J_o}d(r)^{J_n}.
\]

With both slot counts at most 2K this becomes \(d(f)^{9+4K}D_K(q,t,r)\), exactly the label and outer weights used downstream. There is no extra free frequency or source-cardinality factor. The unit change of the actual frequency is injective, and [SecondPhysicalRows](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/SecondPhysicalRows.lean:42) transports the nonzero cutoff by an exact squared-norm identity, preserving its multiplier and radius.

[ActualSecondEnergy](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/ActualSecondEnergy.lean:80) groups by the actual child and charges the full fiber multiplicity. Weighted Cauchy gives the product of square roots of the two weighted label-row energies. A common energy bound A consequently contributes \(A\sum D_K\), not \(A^2\sum D_K\). Enlargements are made only to nonnegative energies, never to the original complex sum.

The nonzero-weight filter is an equality of finite sums. [SecondSquarefree](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/SecondSquarefree.lean:134) proves squarefreeness from the actual surviving masks rather than assuming it for all source labels.

For a permitted deleted prime, SecondParentLists proves divisibility of the raw puncture times the raw label. [Canonical](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/Canonical.lean:82) then restores a list term by term: a column avoiding the deleted primes has an unchanged mark, and a column meeting one vanishes on both sides. SecondModeParentLists transfers this through equality of the relevant principal ideals. Only the lists inside the child polynomials are restored. Outer deleted marks remain restricted, and SecondVaryingLists expands them into an actual varying assigned-source filter with \(J_1.card+J_2.card\le2K\). This pays their multiplicity in the preceding fiber bound.

## 3. Small-power mass and exact normalization

[FiniteOperator](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/QuadraticSieve/FiniteOperator.lean:339) supplies a genuine small-power divisor proof: split prime ideals at a finite norm cutoff, use \(e+1\le2^e\) above it and a uniform geometric bound below it, then multiply using norm factorization. The constant is uniform in the ideal but not in epsilon approaching zero. TripleMass applies this at epsilon/(j+1) and obtains

\[
D_K(q,t,r)\le C_{K,\epsilon}(Nq\,Nt\,Nr)^\epsilon.
\]

This exponent is epsilon on the product, not three epsilon on the product. The finite ideal count is also explicit: a chosen-generator injection and the Eisenstein quadratic-form lattice box give \(64(D+1)\); flooring gives \(128H\) for \(H\ge1\). Three coordinate images then give \(128^3BTR\). No analytic ideal-counting asymptotic is used here.

SecondActualMass handles an empty triple set directly. Otherwise each nonzero ideal norm is at least one, so positive bounds B,T,R automatically satisfy B,T,R>=1. This is essential: the source does not silently assume positive scale exponents.

Writing \(N((z))=\|\mathrm{eisEmbedding}(z)\|^2\), SeedDefects derives the needed q0 estimate from \((b_0J)^2=b_1b_2s\), the active-support bound and positive label norm. The actual three norm bounds multiply to \(Z^\kappa\), where

\[
\kappa=\ell+R/2-j+t+g-\theta+11\eta/2.
\]

For every Z>0 and supplied admissible norm bounds,

\[
Z^{-\kappa}\sum_{\gamma}D_K(\gamma)
\le C_{K,\epsilon}Z^{\kappa\epsilon}.
\]

Neither kappa>=0 nor Z>=1 is added. Multiplication by the positive \(Z^\kappa\) yields the unnormalized exponent \(\kappa(1+\epsilon)\). This is consistent with the later two-pass budget. All sums here are finite; there is no hidden interchange of a limit and an integral or a totalized divergent series.

## 4. Exact remaining boundary

This review accepts the stated finite source-to-fiber, Cauchy, deletion and mass reductions. It does not discharge:

- The underlying local normalized Gauss/CRT identities, finite-field character construction and associated zero-mask facts not proved in the bounded readings above.
- The foundational ideal factorization, chosen/primary-generator and coordinate identities, or every foundational cube-bit identity.
- The four child moment producers and the analytic Poisson/Fourier/integrability/rapid-tail inputs required by the surrounding long two-pass argument.

The present audit advances the boundary below the abstract deleted-energy and mass wrappers. It does not validate the entire global provider or supply finite spectral data. The selected Goldbach strategy and final statements are unchanged: the intended large-number result remains unconditional TernaryGoldbachFrom(10^27), and the full Statement retains only its original BinaryGoldbachInput. No new assumption has been proposed for either final root.

