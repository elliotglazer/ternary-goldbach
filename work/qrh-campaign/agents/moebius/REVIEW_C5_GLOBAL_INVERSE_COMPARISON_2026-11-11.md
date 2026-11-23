# Independent review of the bounded conductor-5 inverse comparison

2026-11-11. **PASS as an accurately scoped incomplete experiment. No full-rectangle inverse certificate was obtained.** The fixed candidate and the two proposed acceptance criteria have the required analytic meaning. The capped run left part of the left edge unchecked. Neither the sampled fit nor the accepted prefix panels establishes nonvanishing on the entire rectangle.

## Frozen inputs and independent work

The reviewed author note is `../zero-sum/C5_GLOBAL_INVERSE_COMPARISON_2026-11-11.md`, SHA256 `5A90D21D95740ADA04F599CC36321411BCAE50CAD09690AC7AC7BE2921E747A7`.

Its candidate generator has SHA256 `3F86D07FB695EAD08F677E7C1F9BBDFE9D9BB0FF5F74F269D9B0B3DA0AEB321B`; the exact candidate JSON has SHA256 `02C623629D3DF9218AFB7689F39698AF5C4F4D6FB6776056C4B275220D148E6E`. The acceptance script has SHA256 `D51E0EBDAAA3F7176151D02E05C35E88CC48C2B02862AB967955B6D3746392A8`; its incomplete receipt has SHA256 `7FAA8640C48E48C6BB03CE3AA0921CE77042F42A464E1F371221E888AEE946EA`. The read-only partial replay has SHA256 `437392A1550BFF8E5D13C6F9B6DBC3C28DB1353784BED6F6EE605DB741EB63BA`.

I ran that full partial replay without `--structure-only`. It exited0 after recomputing all19,015 distinct accepted panels used by the two methods, reproducing every stored upper-bound inequality. Its status remained `INCOMPLETE_PARTIAL_BOUNDS_REPLAY`, with `full_rectangle_certified: false`. The reported numerical loop took51.23 seconds. This is a full replay of the retained prefix bounds using the author's implementation, distinct from the alternate independent calculation below; it is not a replay of a nonexistent complete contour certificate.

The independent program in this directory is `review_c5_inverse_20261111.py`, SHA256 `311C0C35D6F4AF7B2ED88F51D50484E95CA57DD2C41D46B402CBAE5BFF56EC1F`; its receipt has SHA256 `D6516C94A5650C55F653359C892868403CA60CF913818D9E5E50EDA6C5302216`. It checks every exact candidate row, all 30,000 stored attempt records against the accepted/failed counters, both exact prefix geometries, and every stored accepted-bound inequality. It also independently recomputes 48 selected parent panels, selected deterministically by position, largest bound, and largest width.

The independent numerical calculation uses 192-bit arithmetic, N=80 and M=24, freshly computed logarithm/Bernoulli constants, and an exprel polynomial of degree24 with its explicit degree25 tail. It computes actual L-values by the three positive character transforms, then forms `1-L B` and the inverse character transform of that residual. Thus its moment calculation is the direct sum of the three 32nd powers, not the author's repeated group convolutions. Two selected parents required one bisection with this enclosure rule; all 50 resulting leaf panels passed the relevant strict bound. No builtin L, zeta, Gamma, or zero oracle is used. This is an independent analytic enclosure argument using alternate finite parameters, not an overlap test between numerical answers.

The initial independent attempt without those two bisections failed its sufficient interval inequality. That did not refute the author: different arithmetic expressions can have different interval widths. The recorded final calculation retains the failed parent bounds and the exact subdivision, so this review does not hide that distinction.

## Exact character and global candidate

For the cyclic units modulo5, the order `[1,2,4,3]` is the sequence of powers of2. The positive transform is `sum_j a_j i^(k j)`. The labels k=1,2,3 are all primitive, with parities odd, even, odd. The omitted k=0 label is principal. The unnormalized cyclic convolution is diagonalized by this transform without any additional factor4.

The independent exact check converts each of the 386 rows of three rational complex coefficients to four coefficients by

`b_j=(1/4) sum_(k=1..3) B_k i^(-k j)`.

For every row it verifies that the four coefficients sum to zero and their three positive transforms reproduce the original row exactly. This proves the needed primitive support and normalization for the constant coefficient and every pole residue. In particular the factor1/4 appears in the inverse transform, not in the convolution or in the three actual L-values.

All 385 distinct poles are exactly `1/2+i*j/16`, -192<=j<=192. Their horizontal distance from the entire rectangle `[111/200,2]+i[-12,12]` is at least11/200. The same rational function therefore extends holomorphically to an open neighborhood of that closed rectangle, for example by enlarging each side by less than11/200. There is no panel-dependent candidate, fitted coefficient interpolation, or hidden pole cancellation premise. The frozen binary rational coefficients define the witness; the least-squares computation is untrusted witness generation only.

## Actual entire L-function adapter and error bounds

The inherited explicit Euler–Maclaurin evaluator is the already reviewed c5 source at SHA256 `C5125697833CC998C79D854F73D8D6D80B442C6972885C1AC35675F128851FC8`. Its common pole subtraction is identical for all four Hurwitz residue classes. Subtracting the mean removes any common scalar term. Multiplying by5^(-s) then gives primitive transforms equal to actual L(s,chi_k), first by the absolutely convergent series in Re(s)>1 and then by analytic continuation.

This argument uses entire Hurwitz *differences*. It does not identify an individually pole-subtracted numerical Hurwitz value at s=1 with Mathlib's totalized Hurwitz value there. The established source convention, including the GammaR term in the individual regularization, therefore causes no discrepancy in these nonprincipal combinations.

The new group evaluator reproduces the same finite expressions and the same Euler–Maclaurin remainder with real-part floor111/200. Every actual point of each tested boundary segment has that real-part bound; outward rounding of its enclosing complex box does not change this analytic premise. All finite-expression interval operations enclose the actual points. The checker explicitly reports that the inherited constants were formed at128 bits, even though subsequent arithmetic is160-bit. Those constants retain their radii and are not silently treated as exact160-bit values.

The local safe-exprel adapter replaces the uncertain real norm ball by its outward upper endpoint R and uses `exp(R) R^19/20!`. Monotonicity for R>=0 makes this a valid enlargement of the previously proved tail. There is one nonblocking wording error in the note: the finite expression has **19 terms, degree18**, rather than degree19. The code and the degree19 remainder are correct. No frozen producer file was changed for this review.

## What a completed residual test would imply

The exact projector is e=(3/4,-1/4,-1/4,-1/4). Both a and b are primitive-supported, so `r=e-a*b` has primitive transforms `1-L B` and zero principal transform. Thus

`sum_j |r_j|<1`

implies each primitive scalar residual has modulus below1. Finite orthogonality also gives exactly

`4 sum_j |r^{*16}_j|^2 = sum_(k=1..3) |1-L_k B_k|^32`.

The author's four squarings compute the 16th convolution power; the fifth convolution in its per-call accounting is a*b. The final nonnegative norm squares give a valid upper bound. Neither the norm nor the moment is holomorphic, and the argument does not apply maximum modulus to them. If a complete finite boundary cover passed either test, its strict finite maximum would bound each *holomorphic scalar residual* below1 on the boundary and then throughout the rectangle. At a zero of L its residual would equal1, a contradiction. Boundary zeros would likewise be excluded. This covers both signs of the imaginary part, the real axis, and multiplicities without needing a winding count.

That implication needs the entire boundary. The current prefix data do not satisfy it.

## Exact incomplete geometry and counters

The independent geometry checks reproduce:

| Quantity | l1 | T16 |
| --- | ---: | ---: |
| Accepted panels | 10,985 | 14,999 |
| Failed active tests | 10,985 | 15,001 |
| Final prefix endpoint | 111/200 - (16893/4096)i | 111/200 - (33783/8192)i |
| Covered length | 4404661/102400 | 8809247/204800 |
| Required length | 5089/100 | 5089/100 |

Both sequences start at the bottom-left corner, cover the entire bottom, right, and top sides in counterclockwise order, and continue down only a prefix of the left side. Every successive endpoint agrees exactly. Each stored pass/fail counter matches the 30,000 attempt records with the appropriate active-method flag. The run stopped at its predeclared evaluation limit, not because of a proved pointwise residual failure or an identified zero. The fact that the script exits0 while saving an incomplete status is clearly disclosed; exit status alone is not an acceptance test.

## Failure history and comparison scope

The first 193-pole fit missed the selected sampled residual target .3. It was not subjected to a full-boundary certificate test. The selected 385-pole fit met that diagnostic target, but the rigorous boundary run still stopped incomplete. The earlier real-axis NaN and its conservative arithmetic repair are also disclosed. The additional historical count1037, reconstructed as217+818+2 earlier vector evaluations, is author-reported from interactive diagnostic loops; there is no retained command-output artifact sufficient for independent verification of that history. It is not included in the independently checked30,000 acceptance calls or1,632 successful fitting point evaluations.

The source loops support the displayed per-panel operation counts:256 finite-term exponentials,385 reciprocal evaluations,1540 candidate coefficient products, and80 products from five four-component convolutions, besides further EM and scaling arithmetic. Multiplying these by30,000 gives the reported totals. These are counts of different operations, not interchangeable cost units.

The previous complete c5 polygon certificate used3034 shared panels and6064 vector panel calls. This incomplete inverse run used30,000 vector panel calls and a substantially larger witness/log. It therefore provides no evidence of a speedup under the implemented representation. The old and new timings are not a controlled benchmark, and the diagnostic attempt log is not a minimal proof format. Neither this observation nor interval refinement proves that global inverse certificates must be slower in another implementation.

The proposed four-panel centered-Taylor follow-up is outside this review. It must retain the same frozen candidate, justify the actual L Taylor and truncation errors, and cannot fill the missing boundary merely by succeeding on those four panels. No full-height, family, historical GRH, or Lean-kernel result is claimed.
