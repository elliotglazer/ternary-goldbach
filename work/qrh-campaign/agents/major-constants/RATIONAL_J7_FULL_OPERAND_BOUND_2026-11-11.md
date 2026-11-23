# Full integer-operand bound for the frozen rational j7 schedules

2026-11-11. Paper proof and exact scalar/encoding-size checks only. Neither evaluator was imported or run. No logarithm, exponential, finite-g coefficient, or interval image was evaluated.

## Claim and its limits

For the intended deterministic producer and independent schedules, with the fixed old target and the prescribed source/manifest data, every explicitly checked arithmetic integer has fewer than 65,536 bits. A deliberately loose bound for raw rational-helper products and sums is 52,001 bits. Rounding-witness arithmetic is below 27,090 bits. This covers raw products **before** Fraction reduction, not only reduced denominators.

The claim includes the positive arithmetic path, scalar validators, complete finite-g construction, exact old-image reconstruction, and the fixed arithmetic negative controls. It is a size result, not a successful run, containment result, resource estimate, or runtime authorization. A different malformed receipt can of course hit a size guard. There is no claim that every adversarial input admitted by an initial parser bound must pass all later guards. OS/JSON/hash implementation internals are not rational arithmetic proof steps.

Frozen programs:

| File, relative to `work/qrh-campaign/agents/` | SHA256 |
| --- | --- |
| `integration/rational_direct_g_j7_producer_20261111.py` | `B633D322F0B696CDF59FEDB668CE62F4EE13E5BFAC28BC0959E9AF13E37315D7` |
| `moebius/rational_direct_g_j7_independent_20261111.py` | `4762265952B7DD4E5382BC0426205A84BB766EFA43A872DDD6E148EF15674FDC` |
| `integration/small_em_batch_candidate_20261111_01.json` | `2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E` |

The previous denominator note `FINITE_EM_RATIONAL_PROOF_COST_DESIGN_2026-11-11.md`, hash `19DB61735647D0267954692733C2CF045B977D540A4CF55B5DBDB1145EE82CB8`, does not by itself bound these raw operations. Its 15,929-bit head example uses a phase already rounded to grid 513. The present fresh-phase schedules use grids 1025 and 1057. Both changes are included below.

## 1. A sufficient class for reduced rationals

For each reduced rational p/q actually passed between the arithmetic helpers, q>0, use the common bounds

```
q < 2^20000,       |p/q| < 2^6000.
```

Then |p|<2^26000. The producer `add`, `mul`, and `div` explicitly form numerator cross-products and denominator products before constructing a Fraction. The independent helpers do the same. Each raw product is below 2^52000; the addition/subtraction of two such products is below 2^52001. This generous bound also covers native Fraction addition/comparison at the few source sites not routed through these wrappers. It does not assume that a common denominator is selected before those products.

After a helper constructs its Fraction, the *mathematical* common-denominator statements below prove the stronger reduced bound again. This is a valid induction through the actual ordering: raw products first satisfy their own 52,001-bit bound, and only then is reduction used to recover the invariant. One must not use the reduced denominator to claim that the earlier raw multiplication was smaller.

For clarity, the denominator proof is specific to the actual calls. Arbitrarily dividing two members of this class need not produce another member. The divisions used here have explicit integer denominators, bounded phase reductions, or the positive fixed image norm-square described below.

## 2. Elementary schedules and rounding witnesses

Both schedules use inner grids at most 1081 and canonical grids at most 1057. The exact real and imaginary exponential arguments have a common denominator dividing

```
d = 625 * 2^1062.
```

This includes multiplication by the center coordinates 629/1250 and 31985/16, division of the real argument by 16, and reduction by twice an integer times the dyadic pi center. The producer's smaller grids divide the same denominator. The phase-period quotient can instead have the pi-center numerator in its denominator, but its numerator and denominator are each below 2^2200: the center, log and pi inputs have the stated fixed dyadic/rational denominators, pi is between 3 and 4, and the unreduced phase is below 2^14. Its integer floor is performed before the reduced-angle computation.

An exponential Horner or forward-term update has reduced denominator dividing `d*2^1081*k` for 1<=k<=512. The forward accumulator adds a grid-1081 number and has that same grid before its next gate. The four real squarings and final real-times-cis product have denominator dividing 2^2162. These are below 2^2200. All raw products inside the helpers are separately covered by section 1; these smaller reduced-denominator bounds are not substituted for the raw ones.

A reduced logarithm has t=(n-2^k)/(n+2^k), n<=1025. The denominator of t is at most 2049. Horner/forward powers use its exact square; after a gate each state is on grid 1081. Thus even a term division by an odd integer at most 1023 gives a reduced denominator below `2049^2*2^1081*1023 < 2^1120`. The arctangent denominator is at most 239, so its analogous bound is smaller. Raw log-two is retained on its inner grid; the integer multiplier k<=10 and subsequent canonical gate introduce no new odd denominator. The same analysis covers the independent initial-power roundings and every forward term/sum gate.

For a crude size bound, log and arctangent Horner states stay below 4, while their forward accumulators stay below 2^12 even if cancellation is ignored. The real exponential uses |x|<=1/2, so its polynomial states are below 4; four squarings remain below 2^40. A deliberately much weaker bound for either complex exponential schedule is 2^1040: iterate |v_next|<=1+4|v|+1 for at most 512 updates, or bound each forward term this way and sum 513 terms. The final canonical phase is consequently below 2^1100 in norm. These estimates require no computed elementary value and are ample for section 1. The actual accuracy proof is much sharper.

At a named gate the code has g<=1081, |p|<2^26000 and q<2^20000. Its rounded integer satisfies |m|<2^7082. Therefore `2*p*2^g`, `(2*m-1)*q`, `(2*m+1)*q`, `2*q*m`, and the Euclidean remainder expression are all below 2^27090. This includes the independent signed-witness check. The negative rounding controls use only small explicit integers. Generic parser-supported exponents are not substituted for the actual named gate exponents.

## 3. Bernoulli generation and the common finite-g denominator

Set D_c=10000 and g=1057. Both center coordinates have denominator dividing D_c. The Bernoulli recurrence used by the programs proves, by induction,

```
denominator(B_n) divides (n+1)!,       0<=n<=32.
```

Indeed each earlier denominator (k+1)! divides n!, so the binomial sum has denominator dividing n!; division by n+1 yields the claim. The complete normalized correction factor has denominator dividing `(2m+1)!*(2m)!*1025^(2m-1)`. Consequently the following single integer is a common multiple of the reduced denominators throughout all finite-g stages:

```
D_G = 2 * D_c^32 * 33! * 32! * 1025^31 * 15! * 2^(16*g).
```

Its exact bit length is 17,929, below 20,000. There is no dependence here on a numerically generated Bernoulli table or a cancellation conjecture.

The structural checks are as follows.

* Rising polynomials of length at most 31 have coefficient denominators dividing D_c^31. Truncation below degree 16 preserves this statement. Adding all sixteen signed normalized correction terms and the half term is covered by the factor `2*D_c^31*33!*32!*1025^31`. Multiplication by c-1+z and addition of B give the extra D_c in D_G.
* A normalized log power of order h<=15 has denominator dividing `2^(g*h)*h!`. Multiplying by a fresh dyadic phase adds at most another g binary places. Every summand of a fixed head coefficient, and every partial sum over n, therefore has denominator dividing `2^(16*g)*15!`. The number 1024 of summands does not multiply this denominator.
* In the correction, exactly one phase and at most fifteen log powers occur in each term. Multiplication by a coefficient of Q and every partial convolution sum therefore have denominator dividing D_G. This covers the producer's scalar-power convolution followed by phase multiplication and the independent checker's separate complex polynomial product.
* Head/correction gates reset their denominators to 2^513 or 2^545. Final affine assembly, its predecessor term, and its gate remain covered by D_G. All real and imaginary parts in complex multiplication share the corresponding common denominator, so its internal addition also reduces to a divisor of that same denominator.

For magnitudes one may ignore the actual small Bernoulli values. If M_n=max(1,|B_0|,...,|B_n|), the recurrence gives M_n<=2^(n+1)*M_(n-1); hence M_32<2^560. Each rising affine factor has coefficient l1 norm below 2^12, so its length-31 product has norm below 2^372. Dropping the beneficial factors 1025^(-(2m-1)) and factorial reciprocals still gives C norm below 2^938 and Q norm below 2^952. The log powers are below 8^15=2^45 once the explicit log-range checks have passed. Using the deliberately loose phase bound 2^1100 from section 2, every correction partial sum and final g stage is below 2^2200. Head partial sums are smaller. Rounding adds less than one. Thus section 1's magnitude exponent 6000 has ample room even without using the computed phase or Q norm checks.

The full negative-control correction with the B term omitted, and the sign-flipped Bernoulli test, obey the same size bounds. A different mathematical sign can invalidate acceptance without increasing the size estimate.

## 4. Scalar validators and exact constants

The scalar validators do not inherit D_G, so they need a separate check. A common denominator for their reduced rational expressions is

```
D_S = 6 * 2^1593 * 513! * 1025 * 3^1025 * 513 * 5^513.
```

It has bit length 8315. This covers the real exponential tail `2/(2^513*513!)`, the complex tail `2*4^513/513!`, logarithm tail `22/(1025*(8/9)*3^1025)`, Machin tail `20/(513*5^513)`, all dyadic error allocations through 2^-1080, and the rational coefficients 77/4, 145/6 and 46720/3. Partial denominators during construction also divide D_S. No code constructs D_S as a rational magnitude; it is a proof device for their common reduced denominators.

The largest integer-valued factorial expression needed in these validator calls, `2^513*513!`, is below 2^6000. The other positive integer powers and factorials are smaller. Subsequent error sums and products are far smaller than that bound. The EM and Taylor padding expressions use powers only through 32 and are covered independently in section 5. Binomial/factorial construction through 33, fixed counters, labels, and exact negative-control constants are also below 2^6000. Python's internal factorial implementation is not being modeled instruction by instruction; the mathematical integers it returns and the explicitly checked operations using them are bounded here.

## 5. Immutable old data and interval images

The companion script reads only encodings and measures sizes; it does not reconstruct any image. In the selected target parameters, budget, j7 coefficients, panel and endpoints:

* rational numerator and denominator lengths are at most 648 bits;
* old dyadic mantissas are at most 192 bits;
* every old coefficient denominator divides 2^184;
* every JSON integer literal in the entire old file has at most 27 bits.

The last item covers the independent loader's traversal of unused metadata. Numeric strings are only decoded at the subsequent selected-input sites. Fresh valid dyadic leaf/coefficient mantissas have at most 3300 bits by their magnitude bounds and grids; thus the producer's intermediate `Q(mantissa)` in its dyadic decoder also fits the magnitude bound. Encoded rational numerators are constructed together with their denominator, not inserted as standalone rational magnitudes.

For rectangular Horner, the actual offset interval is i*[-1/16,1/16] or one of its singleton endpoints. All old input coefficient denominators divide 2^184. After sixteen padded Horner iterations every reduced denominator divides 2^(184+64). Min/max selection of a corner does not enlarge this common denominator.

Define

```
D_pad = 63 * 6150^32 * 15 * 2^33.
```

Its bit length is 446. Both exact padding errors have denominator dividing D_pad; all padded numerator-rectangle endpoints have denominator dividing `2^(184+64)*D_pad`.

For the reciprocal rectangle, all coordinates of s-1 have denominator dividing d=10000. The endpoint numerators of its exact norm-square, when written over d^2, are positive integers less than 2^50. Call the smallest and largest such numerators n_lo and n_hi. Each reciprocal-coordinate endpoint then has a denominator dividing `d*n_lo*n_hi`, which is below 2^114. This deliberately retains an unnecessary factor d. The intermediate norm-square addition and reciprocal products have the same small explicit bounds; positivity is fixed by imaginary height at least 1999. There is no division by a potentially tiny computed function value.

The final complex rectangle product therefore has common denominator below

```
2^(184+64) * D_pad * 2^114 < 2^808.
```

This applies to intermediate real/imaginary products and their reduced sums. Raw cross-products before reduction are still charged by section 1. Stored old-image endpoints have their independently measured 648-bit encodings; equality and negative-control comparisons are safely covered too.

The old coefficient magnitudes are below 2^192 from their encodings. Ignoring the contraction by 1/16, their sixteen-term Horner value is below 2^197. The fixed norm-square reciprocal has magnitude below 2^28, so even very crude multiplication bounds keep all image-stage magnitudes below 2^300. Adding or deleting the exact padding, or shifting the tested old endpoint by one, does not approach 2^6000.

## 6. What the bound does and does not settle

Sections 2 through 5 establish the reduced-rational class at every actual arithmetic stage. Section 1 then covers every raw helper product/sum prior to reduction. The raw nearest-rounding witness needs its separate 27,090-bit bound, also below the cap. Native Fraction operations in Bernoulli checks, fixed scalar expressions, comparisons, and recorded margins use the same classified operands. String conversion does not need more than the prescribed 20,000 decimal digits: even 2^52001 is below 10^17334, before a possible sign character.

The result gives no reason to alter the frozen 65,536-bit limit for these two intended schedules. It does not claim that either job finishes within its wall-time or memory limits, that every numerical comparison succeeds, or that an arbitrary false receipt cannot cause rejection. Those remain separate finite observations. The proof uses common-denominator reduction only after the code's checked raw operations; it does not require a different Fraction implementation or a new cancellation-before-guard optimization.

Companion files: `rational_j7_full_operand_bound_20261111.py` and `.json`. Their execution consisted only of exact scalar integers and immutable encoding-size inspection. The bound remains a paper proof, not a Lean theorem or a run of either evaluator.
