# Finite psi gap: a concrete certificate design and its cost

Date: 2026-11-11. Research only. No Lean build, canonical edit, new axiom, or prime enumeration was performed. The interval envelope is not proved here. This note specifies a finite certificate whose successful proof-producing replay would fill the gap, identifies an existing certified seed, and separates the small certificate output from the much larger task of validating prime counts.

## Target, overlap, and exact arithmetic artifact

The missing target is E: for every integer v>=10^9,

    abs(psiN(v)-v) <= .01*v/log(v).

The integration note `integration/RESUME_PSI_FROM_FINITE_STRIP_2026-11-11.md` provides a conditional paper tail for real x>=exp(35). Its finite-strip input and QRH provider remain validation obligations; this note does not silently discharge them. It is sufficient to certify integers in [A,B], where

    A=1000000000, B=1600000000000000.

There is genuine overlap: (2.7182818286)^35<B, so exp(35)<B using the source upper bound for exp(1). Also (2.7)^36>B, so log B<36 using the source lower bound for exp(1). These are exact rational checks in `resume_psi_finite_gap_20261111.py`; its output JSON records the grid, scalar bounds, and workload. The script does not calculate any prime count and therefore cannot by itself establish E.

## 1. A grid that needs no logarithms in its interpolation checks

Start a_0=A and repeatedly set

    a_(i+1)=min(B, a_i+floor(a_i/6000)).

Exact integer replay produces 85,721 windows and 85,722 endpoints, including A and B. Every interval has positive integer width h<=a/6000 and b<=a*(1+1/6000). The first width is166666, and the maximum width is266611317847. The checkpoint condition to certify is simply

    a-a/24000 <= theta(a) <= a+a/24000.                 (C)

Here theta(a)=sum_{p<=a, p prime}log p. The condition is an explicit test to be discharged by finite count/log certificates, not a new hypothesis allowed in the final theorem.

Using the separately reviewed full P6 paper repair gives, for all t>=A,

    0<=psi(t)-theta(t)<1.4262sqrt(t)<=17*t/360000.       (PP)

Indeed sqrt(A)>31622 and1.4262/31622<17/360000; the ratio1/sqrt(t) decreases. This slightly coarse uniform allowance avoids per-checkpoint logarithms or prime-power enumeration.

For a<=v<=b, monotonicity and (C) give

    v-psi(v) <= b-theta(a) <= h+a/24000 <= a/4800,
    psi(v)-v <= theta(b)+17*b/360000-a
              <= h+(1/24000+17/360000)*b
              <= (17251/67500000)*a.

Both coefficients are strictly below1/3600. Since a<=v and log v<=log B<36,

    abs(psi(v)-v)<v/3600<.01*v/log v.

Thus this grid plus (C) proves the exact E contract on the whole finite gap. It even proves the analogous real statement on [A,B], without a separate floor correction, because it directly uses the monotonic real step functions theta and psi. No interval or integer endpoint is lost when the final grid step is clipped to B.

For comparison, an adaptive grid proportional to a/log(a) can save endpoints, but it complicates log verification. The fixed rational grid is a complete, conservative design whose count and all interpolation constants have been replayed exactly.

## 2. The first checkpoint is already present, including the endpoint10^9

The public theorem `Prelim/PsiSieveMain.lean:28160`, `sieve_table3`, has strict upper endpoint t<10^9. However its actual producer at line28149, `SieveTab.stg2813`, contains the stronger terminal invariant

    InvT 1000000000
      999967635190289132
      999970323068320645.

`InvT` at `PsiSieve.lean:417` divides these integers by `SmallTab.S=10^9` (`SmallPsiTable.lean:216`). Consequently the existing source proves

    999967635.190289132 <= theta(10^9)
                       <= 999970323.068320645.

Both endpoints lie inside 10^9 +/-10^9/24000. This was independently checked with rational arithmetic. Thus the first checkpoint does not require even a one-integer extension of the sieve. Its bracket width is2687.878031513. The approximate actual theta value is not needed or asserted.

This observation also gives E at v=10^9 immediately, once the reviewed P6 repair is formalized. It does not extrapolate the strong sieve error indefinitely.

## 3. Small output certificate: counts, not a log for every prime

For each window(a,b], obtain an exact certified integer

    c_i = #{p prime : a<p<=b}.

Choose rational log boxes l(a)<=log a<=u(a), l(b)<=log b<=u(b), with proposed width at most1/D_log, where D_log=10^7. This width scale is separate from the unchanged seed denominator D_seed=10^9. Box endpoints may use a finer rational denominator; D_log specifies the allowed width, not a required endpoint lattice. The existing `Small.chkLow`/`Small.le_log_of_chk` and `Small.chkStep`/`Small.log_lt_of_chk` APIs give soundness when their rational Taylor checks succeed. No full table of successful log checks has been generated here, and the width ceiling alone does not certify any actual box. With lower/upper theta brackets L_i,U_i define

    L_(i+1)=L_i+c_i*l(a),
    U_(i+1)=U_i+c_i*u(b).

Each prime in(a,b] has log between these endpoints, so these recurrences are sound, including a prime equal to b and excluding one equal to a. Starting from stg2813, verify at every endpoint

    L_i >= a_i-a_i/24000,  U_i <= a_i+a_i/24000.

These are rational arithmetic tests after the count and log correctness proofs. A future certificate should carry the count, log endpoints, updated theta bracket, and a proof-producing count witness or checked algorithm result for every window. It must not merely assert that the supplied integer c_i is the true count.

The uncertainty caused by this cheap log weighting is small enough to make the design credible. Since log(b/a)<=1/6000, each window adds at most c_i*(1/6000+2/D_log) bracket width. The unconditional existing Chebyshev bound theta(x)<=log(4)*x<1.387x and log A>20 imply

    sum_{windows through x}c_i <= theta(x)/log A <=1.387x/20.

Therefore total added bracket width is at most

    [1.387/120000 + 2/D_log]*x = (1411/120000000)*x,

plus the initial2687.878031513 width. The added width is about1.17584e-5*x. Even after adding the seed width, the total is at most (1411/120000000 + 2687.878031513/10^9)*x < x/12000 for x>=A. This exact comparison is checked by the script. This calculation controls rounding and log-bucket uncertainty only. It does NOT prove that the true theta values are centered near x; the checkpoint inequalities still require actual certified counts.

A count-only record for85,721 windows is modest: one 64-bit integer per count is685768 bytes; adding integer endpoints and several fixed-scale bounds gives a table on the order of a few megabytes before proof data. The correctness witnesses and Lean proof terms may be much larger. No runtime or memory promise for kernel checking follows from the raw table size.

### Precision correction from independent review

The first draft requested log boxes of width1e-9. That was not justified by the existing checker: its lower/upper approximations to exp(1), raised to powers20 through35, already introduce a gap of several times1e-9 before the Taylor residual. Integration replayed the actual rational checker at A and B and found successful brackets of widths4e-9 and5e-9. The corrected design allows1e-7 and recomputes the uncertainty bound above. This neither rescales the theta seed nor claims all85,722 logarithm boxes have passed. Generating and checking those boxes, and especially proving the85,721 missing window counts, remain work.

## 4. Exact prime-power treatment, if P6 is to be avoided inside the finite computation

The preferred budget uses the reviewed P6 result (PP) and does not enumerate proper prime powers. There is also an exact finite identity:

    psiN(N)=theta(N)+sum_{k=2}^{50}theta(floor(N^(1/k))), N<=B.

For every prime p, its contribution counts each exponent k with p^k<=N once. Since2^50<=B<2^51, there are no missing terms with k>50. Compute each integer root by binary search and certify r^k<=N<(r+1)^k; do not use floating roots as evidence.

The maximum integer roots over this entire gap are:

| exponent k | floor(B^(1/k)) |
|---|---:|
| 2 |40000000|
| 3 |116960|
| 4 |6324|
| 5 |1098|
| 50 |2|

Every root is below10^9, inside the domain of the already present finite source machinery. The square-root range above10^6 uses `sieve_table3`; the smaller roots can use SmallTab/SmallPsi tables or direct checked prime-power/log tables. One need not enumerate prime powers anywhere near B. There are at most49 root queries per checkpoint, about4.2million small-range queries; they can be cached or bounded together. Existing finite upper/lower theta envelopes may suffice rather than computing exact theta at every root. A future implementation must transport these source bounds to the integer-root carrier explicitly.

This exact identity is mathematically independent of a theta checkpoint assertion. It provides a route to a direct psi checkpoint checker with asymmetric budgets; the simpler proven interpolation design above uses P6 and does not rely on this alternate checker being implemented.

## 5. The real computational cost: validating the window counts

The current source `PsiSieve3.cnt3_spec:166` only handles windows W<=32768 with n+W<1000014129, using all primes up to31622. It cannot be called at B. Its bit-mask and popcount proofs provide a template, but the base-prime list and height parameters must be generalized and proved correct.

A direct segmented Eratosthenes verifier through B needs base primes up to sqrt(B)=40000000. The existing32768-wide architecture would require

    ceil((B-A)/32768)=48828094483

blocks. There are1599999000000000 integer positions in the gap; a single conceptual full-span bitset uses199999875000000 bytes, about200TB. A segmented implementation does not hold that all in memory, but still processes the span. Odd-only or wheel sieving reduces constants without eliminating the enormous span. Repeating all base-prime mask work in every tiny window would be especially unsuitable. An external count table or a hash of a sieve run is not a formal correctness witness.

As a diagnostic only, x/log x estimates about4.57e13 primes up to B and about2.29e6 base primes up to40million. These are PNT estimates of workload, not certified prime counts used in any inequality. Counting bits avoids storing or emitting every prime but does not make the direct span traversal disappear. No machine-time claim is made.

A concrete alternative is a verified combinatorial prime-count algorithm supplying pi(a_i), hence c_i=pi(a_(i+1))-pi(a_i), without sieving every integer to B. The primary Lagarias-Miller-Odlyzko paper proves a Meissel-Lehmer refinement with O(x^(2/3+epsilon)) time and O(x^(1/3+epsilon)) storage per value, and gives exact partial-sieve recurrences and stopping identities. Those arithmetic identities are a possible Lean development target; published numerical values are not a provider here. See [the authors' paper](https://www-users.cse.umn.edu/~odlyzko/doc/arch/meissel.lehmer.pdf), Theorem A and Sections2-3.

Computing85,722 independent values is still substantial: ignoring logarithmic factors and constants, the geometric grid's sum of x^(2/3) is approximately9000*B^(2/3), about1.2e14 power-scale units. This is a cost diagnostic, not a proven runtime bound. Sharing partial-sieve tables and floor-quotient values across endpoints, or using certified interval counts directly, would be needed before calling the design efficient in wall-clock or kernel time. No such batched verifier exists in the inspected source. A new bounded engineering study should compare this approach with a larger-block proof-producing segmented sieve before a full certificate run is authorized.

## 6. Already proved elementary estimates do not fill this interval

The current unconditional theta<=log(4)*x and psi<=log(4)*x+2sqrt(x)log(x) have a leading relative error about.386. The required error here is only .01/log(x), between about.000483 and.000286. They cannot establish E by arithmetic tightening or by adding the P6 prime-power bound. The new harmonic P2/P3 contracts control sums of Lambda/n with fixed additive constants and do not directly supply this much sharper local psi error.

For an external elementary comparison, the primary Isabelle AFP entry proves0.9x<=psi(x) andpsi(x)<=1.2x by factorial estimates and finite checks. Even those stronger elementary constants miss the present precision by hundreds of times. This is evidence about these available bounds, not an impossibility theorem for future elementary methods. See [Concrete bounds for Chebyshev's prime counting functions](https://isa-afp.org/entries/Chebyshev_Prime_Bounds.html). No Isabelle result is being imported as an already proved Lean provider.

No published finite prime or bounded-RH computation was accepted in this note. A sharper explicit analytic theorem could reduce the endpoint B or replace much of the computation, but its finite computational inputs would need their own genuine proof-producing validation. The integration estimate's diagnostic crossover near6.67e14 is not yet its certified threshold and was not substituted for exp35 here.

## Deliverable and remaining obligation

The exact grid, seed check, overlap bounds, prime-power budget, and interpolation all pass the accompanying Fraction/integer script. The seed is an existing unconditional source theorem. The rest is a concrete finite certificate specification with85,721 exact prime-count obligations and inexpensive rational postprocessing. None of those new counts has been generated or verified here. Therefore E and the full Goldbach conclusion remain open; the original10^27 and BinaryGoldbachInput are unchanged.
