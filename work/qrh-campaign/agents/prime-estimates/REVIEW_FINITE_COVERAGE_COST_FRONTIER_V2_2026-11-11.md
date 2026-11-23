# Independent review of finite coverage cost frontier V2

2026-11-11. PASS for the stated conditional geometry and cost models. No substantive correction requested. The reverse mandatory suffix, finite step-price integral bound and supplied-pool Pareto rule are sound. None supplies a prime pool, a successful coverage certificate or an unconditional runtime bound.

## Frozen evidence

Author objects are in `work/qrh-campaign/agents/independent-feasibility`.

| Object | SHA256 |
|---|---|
| FINITE_COVERAGE_COST_FRONTIER_V2_2026-11-11.md | F512044F2F5E9B55A7DFC9B5DAE8D094F4D290C41B5A9AB9202E42DD69901753 |
| finite_coverage_cost_frontier_v2_20261111.py | DA3FBF545ED5AC5DC34529DC87AA09C39CFABE003CD09094EDA827CBAB6F99FF |
| finite_coverage_cost_frontier_v2_20261111.json | 4026FD4C556DCC475367AE7E1CEE5DCB2E654914E8568130FAA3140C54E2E39C |

I read the full report and script, the actual SmallCases reduction and Ladder/Spec criterion, and compared the size-band and binary geometry interfaces with their retained reports. All twelve source/report pins match. The source still has the old binary cutoff and target literals. The new parameterized reduction remains a paper replacement, as the author says.

The independent script `review_finite_frontier_v2_20261111.py` passed43871 exact checks without importing the author program. It reproduced all seven large histograms by intersecting their arithmetic-progression indices with each price band. It also checked the nonuniform integral inequality on small geometries, and a separate two-variant, two-price Pareto recurrence against every subset path and certificate choice. Synthetic odd labels were used only as combinatorial data, not as primes.

| Independent object in prime-estimates | SHA256 |
|---|---|
| review_finite_frontier_v2_20261111.py | 7BA1611B516BEB00D6AEAD023B5E19E442402C5E4E3D5F7B30750702AB1B7C59 |
| review_finite_frontier_v2_20261111.json | 540E31FD0741C353CF5A00BECF134606251CFFAF144176E6E44BFD25A475B703 |

## Coverage and reverse suffix

For even B and D=B-2, the intervals of odd targets `[p+4,p+B]` meet without missing an odd target exactly when the adjacent gap is at most D. Starting at p0=3 covers7; the last condition covers T. All remainders are even and in the binary certificate's closed interval. The top-prime restriction pK<=T-4 ensures the last interval actually starts within the target range. The separate initial binary block and final short block, including its single point when L divides B/2, are preserved.

The forward bound `pK<=3+KD` and terminal inequality imply `K>=ceil((T-5)/D)-1`. Reversing the actual edges gives `p_(K-j)>=T-B-jD`. The first Kmin of these are distinct actual records, independent of any additional early primes.

Let A=T-5 and k=ceil(A/D)-1. Then `0<A-kD<=D`. Since A and D are even, the smallest reverse label is `A+3-kD`, an odd integer in `[5,D+3]`. Thus all price arguments are in the declared domain. Nonnegative extra records may be discarded in the lower bound, and nondecreasing c permits replacing each actual mandatory record by its reverse lower label. This proves the stated sum inequality.

The compressed histogram uses the correct strict order thresholds `(2^j+1)^2` and bit-length thresholds `2^j`. Equality at an order threshold belongs to the next order band. No primality of these surrogate price arguments is asserted. All displayed counts and weighted sums match independently.

## Price and integration conditions

The supplied-root price `e(p) S(w(p))+O(w(p))` is nondecreasing when S and O are nonnegative nondecreasing schedules. That is a model assumption or a proved implementation lower envelope, not a consequence of choosing Lean or MM0. A lower bound for this direct-record architecture cannot be imposed on unrelated primality formats, CRT batches or proof compression. The author's restricted scope and need for a common lower price in the mixed-format case are necessary.

For the integral comparison, order the reverse labels increasingly as x1,...,xk=Y, with spacing D. The preceding endpoint x0=x1-D is below5. Extend c by zero below5. The adjacent cells cover `[5,Y]` plus only a zero-priced initial interval. Monotonicity gives

`D sum_(i=0..k-1)c(x_i) <= integral_(x0..Y)c(t)dt <= D sum_(i=1..k)c(x_i)`.

The two sums differ by `c(Y)-c(x0)=c(Y)`. This proves the exact one-top-record bound, including threshold equalities and the incomplete first cell. No smoothness or prime-density approximation is used.

The later identity `J(B)=Jstar-c_top D` applies when the whole removed interval `[T-B,T-2]` lies in the same constant top-price band. This is the precise interpretation of the report's top-band condition. Without it, the finite step integral still works, but that simplified stationary-point formula does not. The equal-price strict bound `<a+c` presupposes a+c>0; when both prices are zero its difference is exactly zero. The subsequent quadratic formula already assumes a>0. These are scope clarifications, not changes to the positive-price examples or main conclusions.

An incumbent screen additionally needs genuine lower costs for every admitted architecture and a genuine feasible upper cost. Shared setup must be allocated without overlap before adding BinaryLB, Smin and the suffix lower bound. The report explicitly preserves these conditions. Its width-squared example is a sensitivity basis, not a measured proof-operation count.

## Joint cutoff/path optimization

At a fixed vertex, extending both labels by the same edge and certificate variant preserves componentwise order in the cutoff and additive price coordinates. The terminal maximum also preserves it. This proves the dominance deletion and exact fixed-pool frontier. The final cutoff is even and is one of4, a terminal difference or an edge gap plus two. The final checker need not prove that this optimizer was optimal; it needs the actual selected certificates and coverage edges.

Choosing the smallest admitted cutoff minimizes a nondecreasing complete binary price. A nonmonotone quoted implementation price needs the reported larger-cutoff search or its charged restriction envelope. Logical restrictability alone does not prove cost monotonicity. Shared factor caches, batch certificates and live-state costs require additional state before the dominance rule can be applied; the text retains that requirement. Search/generation already spent on the supplied pool is not refunded by selecting fewer vertices.

I found no production-versus-verification conflation. The shorter supplied-root proof does not erase the producer's original search, root construction or conversion. Product-modulus widths and CRT work remain distinct. Native arithmetic, ordinary PA proof applications, Lean reduction and serialized proof costs are not equated.

## Acceptance limit

The report advances a sound conditional decision framework. The feasible pool, binary/source certificates, exact implementation prices, failed-search costs, source reduction changes and standard-axiom checking remain outstanding. No evaluations, builds or frozen author edits were performed in this review.
