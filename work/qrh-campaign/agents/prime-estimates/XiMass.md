# Xi mass at s = 2

Status: exact Python Fraction replay passed; complete Lean draft is uncompiled.
No QRH, PlattGRH, new axiom, or missing-result hypothesis is used in the draft.
Do not treat the declarations as kernel-checked until the build scheduler grants
and completes a focused compilation plus axiom audit.

## Exact target

`TernaryGoldbach.Explicit.XiMass.re_logDeriv_xiF_two_le`:
`(logDeriv xiF (2 : Complex)).re <= 0.07`.

Existing `Explicit/ZeroFreeRegion.lean:re_vM_eq` specializes to

`D = 3/2 - log(pi)/2 - gamma/2 - Re LSeries(vonMangoldt, 2)`.

Existing `log_pi_ge` supplies `log(pi) >= 1.1447`.
The new finite certificates supply `gamma >= 0.576715` and
`Re LSeries(vonMangoldt, 2) >= 0.56945`.  The resulting rational upper bound is
`0.0698425`, leaving `0.0001575` below the target.

## Cheap finite certificate

The 303 table entries give lower bounds `c_p / 1000000 <= log(p)` for primes up
to 2000.  The Python generator independently verifies each with the exact
existing `Prelim.Small.chkLow` predicate (Taylor degree 12 and rational upper
bound for e).  Lean recomputes these predicates with `decide +kernel`.

Rather than use infinite prime-power sums, define the rational lower term using
the *same* `IsPrimePow` and `Nat.minFac` branch as Mathlib's definition of
`ArithmeticFunction.vonMangoldt`.  No additional primality theorem or
geometric-series interchange is required.  The 333 nonzero terms in
`sum_{n in range 2001} lower(n)/n^2` yield approximately
`0.5694599657696959`, safely above `0.56945`.

The n=0 summand is zero under the field convention, matching Lambda(0)=0.
`hasSum_re_vM` at sigma=2, tau=0 identifies the real L-series with the
nonnegative sum Lambda(n)/n^2. `sum_le_hasSum` discards the omitted terms.

For gamma the certificate uses:

* `harmonic 1000 >= 7.48547086` (exact rational computation),
* `log(1001) < 6.908755` (`Small.chkStep` rational lower exponential bound),
* Mathlib's `Real.eulerMascheroniSeq_lt_eulerMascheroniConstant 1000`.

Thus gamma is strictly greater than `0.57671586`; the draft only consumes
`0.576715`.  All displayed decimal constants are exact rationals in the proofs.

## Imports and compile order

Existing source modules:

1. `TernaryGoldbach.Explicit.ZeroFreeRegion` (already imports the xi identity,
   digamma, von Mangoldt L-series, and logarithmic pi bound).
2. `TernaryGoldbach.Prelim.SmallMertens` (imports SmallPsi; supplies `chkLow`,
   `chkStep`, and soundness theorems).
3. `Mathlib.NumberTheory.Harmonic.EulerMascheroni`.
4. New scratch module `XiMass`.

Potential elaboration cost is confined to the finite rational `decide +kernel`
certificates.  No runtime/native decision axiom is requested.  No heartbeat or recursion overrides are used. If computation exceeds default limits, split the certificates into bounded chunks and compose them.
The analytical bridge has no missing mathematical input found in source review.

## Normalization for consumers

`pair_approx` uses a paired Phi sum approximating twice the logarithmic
 derivative.  Consequently the finite paired mass is at most `0.14 + 2*epsilon`.
For the unpaired real sum `Re sum mult(rho)/(2-rho)`, the bound is
`0.07 + epsilon`.  A limiting total W2 mass therefore has upper bound `0.07`
when W2 denotes the latter normalization.

The optional s=1 identity would avoid the finite Lambda certificate but needs
an additional Laurent-constant/derivative bridge not presently provided by
this draft; the s=2 route uses the existing exact API directly.