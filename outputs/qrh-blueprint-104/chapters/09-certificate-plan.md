# Kernel-checkable replay plan for the principal Gram certificate

Status: planning only. The complete Arb certificate and its root replay remain unchanged. No Lean compiler and no full numerical job were run for this task. The existing kernel rules remain binding: no new axioms, no assumed Gram enclosures, no native_decide/ofReduceBool shortcut, and no heartbeat overrides.

## Recommended route

Use a small verified fixed-point interval checker, rational quadrature rules with certified moment defects, and a compressed height cover. External Arb calculations may propose certificate data, but every accepted inequality must be reconstructed from exact integer/rational arithmetic and a proved soundness theorem. Importing the recorded N0_upper values as hypotheses would not accomplish this.

Do NOT begin by formalizing the exact180 Gauss-Legendre roots or translating the52-second Acb execution trace. The installed Mathlib has basic shifted Legendre polynomials and Rodrigues' formula in RingTheory/Polynomial/ShiftedLegendre.lean; the inspected source did not supply the complete Gauss rule used here. Developing root ordering, orthogonality, weight positivity, and degree359 exactness would be a substantial detour.

Instead choose rational nodes t_i and nonnegative rational weights w_i on[-1,1], with sum w_i=2, close to the numerical Gauss rule. Let

    mu_k=0 for odd k, mu_k=2/(k+1) for even k,
    Delta_k=mu_k-sum_i w_i*t_i^k.

For f analytic and bounded by M in a disk of radius R about c, q=h/R<1, prove the generic bound

    |integral_(c-h)^(c+h) f - h*sum_i w_i*f(c+h*t_i)|
      <= h*M*(sum_(k<n) q^k*|Delta_k| +4*q^n/(1-q)).

It is a direct Taylor/Cauchy coefficient bound plus positive-weight remainder estimate. It needs no claim that the nodes are algebraic Gauss roots. The existing analytic error budgets have ample room for tiny rational moment defects. Replacing nodes does require replaying their function bounds and finite sums; the old Acb answers do not automatically become answers for the new rational rule.

## Concrete reusable certificate format

1. Dyadic endpoints, represented by signed integers and a shared binary scale. Prove soundness of add, subtract, multiply, divide away from zero, square, and square-root comparison. Use outward integer quotient/remainder bounds; do not repeatedly normalize large Rat expressions.
2. Closed elementary-function certificates for exp, sin, cos, and log2/pi range reduction. Bound a short Taylor polynomial and its proved remainder with exact arithmetic. Halving/squaring handles exp; certified integer multiples of2pi reduce phase arguments before sin/cos evaluation. All phases here are bounded (approximately[-300,52]), so unrestricted transcendental decision procedures are unnecessary.
3. Rational quadrature node/weight tables and moment-defect certificates. Suggested initial scales:160 bits for the26-node u rule and448 bits for the180-node delta rule. These are design estimates. The delta disk majorant1e90 forces defects roughly below1e-109 if retaining the current1e-17 budget;128-bit node data alone is insufficient for this replacement.
4. Per-height certified Gram bounds produced by the verified evaluator, not imported as trusted literals. Cache common u-node/base-amplitude and delta-phase certificates. Check complex dot products in bounded chunks and prove chunk concatenation.
5. Rational height intervals whose union covers[16,75], with a closed proof of every CELL inequality. The beta reduction, true etaPlus perturbation, outer ranges, and weighted mass are independent analytic theorems consuming the resulting closed Gram theorem.

The repository already uses small exact certificates: Prelim/SmallPsi.lean defines chkStep and proves log_lt_of_chk; Prelim/SmallMertens.lean defines chkLow and proves le_log_of_chk. Many SmallG certificates use `decide +kernel`. Reuse their proof-producing pattern and elementary bounds where applicable. Inspect generated proof terms and axiom output; the final literal certificate application must be closed and must not contain ofReduceBool or a new oracle. Ordinary norm_num proofs and kernel reduction of small checker blocks are acceptable; unbounded one-shot reduction is not a performance plan.

## Compression available before a new Gram computation

I reused the existing2750 certified N0 enclosures and the already proved.626 Lipschitz formula, with no new Gram evaluation. For each old center I binary-searched a rational radius in units1/20000 for which the same CELL inequality holds, then greedily covered[16,75]. This produced a cover using243 existing centers (radius range.0227 to.8554). This is a computational compression observation, not a Lean certificate or a promised optimal cover. The radii were chosen close to the threshold; an exporter should reserve an explicit rounding margin, which may increase the count.

The corresponding direct replay shrinks from605 million to53,450,280 complex quadrature products. That is still too large to assume cheap kernel evaluation. Its common phase table has219,960 entries and its height phase table296,946 entries. Exporting about0.52 million interval values would occupy roughly50-150 MB as textual certificate data (estimate), before proof terms. Recording every intermediate arithmetic operation could easily require gigabytes and should be avoided.

A further analytic compression is worth testing before a large export. The compact second log-moment satisfies

    ||partial_gamma^2 M^O||_2^2
      <= sum_(k=0)^6 [24*(-1)^k*binom(6,k)*2^(6-k)/(6+k)^5]
         +sum_(k=0)^6 [(-1)^k*binom(6,k)/(2k+5)]
      =.05082977265... <.226^2.

Together with ||M^O||_2<.9 and first derivative<.313, the phase-pair Gram matrix Q=T* T has ||Q''||<2.411. Interpolate the MATRIX or its weighted version, not the generally nonsmooth norm N0 or |C|. A chord-error theorem then costs O(h^2), instead of the present O(h) Lipschitz allowance. This may reduce the height count substantially, but no count or improved certificate is claimed until the weighted endpoint inequalities are checked. Piecewise polynomial/Taylor Gram bounds are preferable to an unproved fitted curve or an unverified polynomial approximation.

## Missing analytic APIs and proofs

- The rational moment-defect quadrature theorem above, for complex or Hilbert-valued functions. Mathlib.Analysis.Complex.CauchyIntegral and TaylorSeries contain the power-series/Cauchy machinery; the exact assembled norm estimate is new. A search did find MeasureTheory/Integral/IntervalIntegral/TrapezoidalRule.lean and trapezoidal_error_le, but replacing the high-order rule by its second-order estimate would require a much denser grid.
- Kernel proofs of the complex-disk majorants1e18 and1e90, the small-r tail, and the explicit quadrature error arithmetic. The existing paper derivation supplies exact domains and constants.
- A soundness theorem for the specialized elementary-function interval evaluator, including the argument enclosures induced by log2, pi, and all rational node/weight operations.
- Plancherel in delta for the actual smoothing, beta/gamma derivative moment bounds, the2-by2 phase Gram identity, and continuous CELL interpolation. Existing Plancherel and Gaussian integral results are ingredients, not this finished theorem.
- For the optional compression: the second-derivative matrix chord bound and a weighted version that retains the gamma-dependent prefactor.
- The separate analytic chain already listed in JointPrincipalL2.md: etaPlus-minus-etaO pointwise Fourier tail, signed contour and compact connecting-arc bounds, positive xi weighted mass, multiplicity-preserving zero orbits, and explicit-formula/Hilbert-space limit. The finite arithmetic certificate does not discharge these.

No endpoint test can replace the quadrature soundness theorem, and no generic theorem with unproved node-enclosure premises counts as the closed Gram result.

## First bounded implementation target

Implement ONLY the rational moment checker for the26-node normalized u rule, together with its exact arithmetic soundness, and prove one closed declaration:

    nodes lie in[-1,1], weights are nonnegative, weights sum to2,
    sum_(k<52) (1/4)^k*|Delta_k| <=2^(-120).

The exporter may propose160-bit dyadic data. It must also supply the exact adjustment making the weight sum2, and the Lean checker must validate every property. There are1352 node-power contributions, small enough to expose arithmetic costs before a large replay. Then prove the generic moment-defect quadrature theorem and connect this first rule to a real u-panel bound. This gives useful closed output even if the full replay is later redesigned.

Acceptance gate: the unmodified kernel checks the literal certificate with narrow imports, ordinary options, printed exact type and standard axioms only. Measure elaboration and kernel-checking time separately through the integration worker. If even this small benchmark exceeds the agreed bounded slot, optimize the data/checker or change representation; do not increase heartbeats or switch to an oracle.

Only after that gate should one benchmark one complete height near26.545 (the worst region), then decide whether243-height replay is realistic. No credible wall-time estimate for the full kernel computation exists yet. Operation-count planning suggests millions of exact arithmetic steps for the static tables and tens of millions for direct Gram replay; hours to days is a risk, not a measured prediction. The52-second Arb run is not evidence of Lean kernel runtime. The rational-rule tables alone should be tens of kilobytes; the full per-height data and proof terms dominate size.

The likely smallest final architecture is: a few closed rational quadrature and elementary-function lemmas, compressed proved Gram blocks, one finite cover theorem, and the existing analytic reduction. There is currently no formal closure claim and no need for an additional assumption in the target theorem.
