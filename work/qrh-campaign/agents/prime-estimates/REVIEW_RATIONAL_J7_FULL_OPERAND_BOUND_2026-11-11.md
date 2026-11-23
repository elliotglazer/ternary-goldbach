# Independent review: full rational j7 operand bound

2026-11-11. **PASS at paper/source level.** No missing intended-path arithmetic stage or incorrect size inference was found. The argument bounds raw products before Fraction reduction and gives a sufficient margin below the frozen 65,536-bit work guard. It does not establish completion, successful containment, runtime, memory consumption, or a Lean theorem.

Neither evaluator nor the author's scalar script was imported or executed in this review. I read their source, the complete note and receipt, and checked file hashes. The independent calculations below are elementary paper bounds, not function evaluations.

## Frozen inputs

Paths are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
| --- | --- |
| `major-constants/RATIONAL_J7_FULL_OPERAND_BOUND_2026-11-11.md` | `69B9FA33FF8C90F6691F642B4311FC6870D96E99A1045903B4156CA97B914C20` |
| `major-constants/rational_j7_full_operand_bound_20261111.py` | `3DAC91E058BE3EB023BCC4793290CA3FCBC1F68C161737DBADE30BB629404146` |
| `major-constants/rational_j7_full_operand_bound_20261111.json` | `4C8EF2DB872312EFE3665B2C4EF6CC81922F74ED86A266F9CE8A4DE6A8B49E01` |
| `integration/rational_direct_g_j7_producer_20261111.py` | `B633D322F0B696CDF59FEDB668CE62F4EE13E5BFAC28BC0959E9AF13E37315D7` |
| `moebius/rational_direct_g_j7_independent_20261111.py` | `4762265952B7DD4E5382BC0426205A84BB766EFA43A872DDD6E148EF15674FDC` |
| `integration/small_em_batch_candidate_20261111_01.json` | `2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E` |

The previously completed structural review is `prime-estimates/REVIEW_RATIONAL_DIRECT_G_J7_STRUCTURE_2026-11-11.md`, SHA256 `479FC1667184AABD2271D48102A6E5E7D342EF8BB13B49B3486B74C33152A80B`.

## Raw operations and induction order

The reduced-rational invariant is denominator q<2^20000 and magnitude |p/q|<2^6000, hence |p|<2^26000. Multiplication and division numerator/denominator products are below 2^52000; the sum of two raw cross-products is below 2^52001. The producer's early product bit test cannot reject a product with these bounds. Native Fraction comparisons and the few native sums have operands in the same classes; cancellation is not needed to justify their temporary products.

The proof does not infer closure under arbitrary rational division. It separately classifies the actual denominators at each call, then restores the reduced invariant after the raw operation. This resolves the important ordering issue: the common denominator bounds are not incorrectly used as bounds on the preceding unreduced cross-products.

At a gate g<=1081, the rounded integer has magnitude below 2^7082. Consequently the signed comparison products `(2m+-1)q`, `2qm`, `2p*2^g`, and the remainder construction fit the separate 2^27090 bound. Negative inputs and ties do not change these absolute-size estimates. The note does not replace the actual gate exponents by arbitrary parser-supported exponents.

## Complete finite-g path

The common-denominator argument matches both implementations. Center denominators divide 10000. The Bernoulli induction is valid: earlier `(k+1)!` divide n!, so division of the binomial sum by n+1 gives denominator dividing `(n+1)!`. All normalized corrections are therefore covered without assuming a numerical Bernoulli table.

For h<=15, a normalized logarithm power has denominator dividing `2^(1057h)*h!`; multiplying by one fresh phase gives at most sixteen factors of the grid denominator. This is a common denominator for every head summand and partial head sum, not a product repeated 1024 times. The rising-polynomial, half-term, signed correction, affine Q construction, convolution, final phase multiplication and final assembly are covered by

`D_G = 2*10000^32*33!*32!*1025^31*15!*2^(16*1057)`.

The independent implementation's different polynomial association does not change this divisibility statement: every intermediate coefficient is a partial sum of products with nonnegative degrees and the same denominator factors. Coordinate products in complex multiplication share the corresponding common denominator. The final dyadic gates reset, rather than enlarge, these bounds.

Independently of the reported exact bit count 17,929, the simple bounds `10000<2^14`, `33!<2^198`, `32!<2^160`, `1025^31<2^341`, and `15!<2^60` give `D_G<2^18120<2^20000`. The loose magnitude proof also suffices: Bernoulli values below 2^560, rising-product norm below 2^372, Q norm below 2^952, logarithm powers below 2^45, and the coarse phase bound below 2^1100 keep every complete correction and assembly stage below 2^2200. It is not necessary to assume the later computed Q/phase norm checks succeed to obtain this size bound.

## Elementary, scalar, image, and control paths

The elementary denominator analysis covers both Horner and forward recurrences. The exact phase argument denominator `625*2^1062`, inner grid 1081, small integer divisors, exact log-reduction denominators and pi-period quotient all remain below the stated 2^2200 reduced-denominator bound. Ignoring cancellation in the complex recurrences still gives the coarse 2^1040 polynomial and 2^1100 final-phase bounds. The four real squarings fit the separate coarse 2^40 estimate.

The scalar validators have a separate common denominator D_S; they are not incorrectly assigned D_G. Using only `513!<2^5130`, `3^1025<2^2050`, and `5^513<2^1539` gives the independent coarse bound `D_S<2^10336<2^20000`, sufficient without replaying the reported 8,315-bit count. The explicitly constructed integer `2^513*513!` is below 2^5643, hence below the magnitude ceiling. The smaller factorials, powers and rational coefficients fit as well.

I inspected the author's size-only traversal: it binds the original target hash, visits selected parameters, budget, j7 coefficients and three images, separately handles expanded dyadic numerator sizes, and scans integer literals elsewhere. Thus the reported 192-bit expanded dyadic numerator bound, 184-bit common dyadic exponent and 648-bit rational fields are the relevant encoded quantities; mantissa length alone would not have sufficed. The receipt's exact observed maxima are author-generated finite data, not an independently rerun experiment here.

The image proof retains the old squares and actual offset interval, giving denominator dividing 2^(184+64) before padding. Both pads divide D_pad. With `6150<2^13`, one independently gets `D_pad<2^459`. The reciprocal denominator construction uses the two fixed positive norm-square numerators, each below 2^50, and d=10000. Thus an independently sufficient coarse final image denominator bound is 2^821, still far below 2^20000. Corner selection and interval squaring introduce no additional denominator factors. There is no inversion of a small computed function value in this path.

The fixed negative controls only change small constants, signs, labels, a pad, or the +B term; their relevant arithmetic stays in these classes. Fresh/old containment differences and the independent replay comparisons are included. The statement correctly excludes arbitrary malformed receipts from the claim that the work guard cannot reject.

## Acceptance scope

This closes the paper-level size argument for explicitly checked arithmetic on the intended two schedules, including operations before fraction cancellation. There is no reason from this argument to increase the frozen integer cap. The exact runtime implementation of Python allocation, factorial internals, JSON, hashing and OS telemetry is outside this arithmetic proof. Size bounds do not imply a 512 MiB or deadline bound, and the external supervisor remains mandatory.

No function values or successful numerical comparisons follow from this review. The result does not replace the arithmetic review, an actual complete independent acceptance run, its resource seal, or a future kernel-checked implementation.
