# Exact arithmetic coverage of the direct branch

Research diagnostic, 2026-11-10. No Lean compiler was run. The analytic input is the reviewed Type I/II envelope, which still depends on PlattGRH in the current repository. This calculation does not discharge that input.

For the reduced denominator Q of 2alpha, put f=Q/phi(Q). The current envelope is

    U(Q) = 1.254 * [
      (.68 log(2Q)+.8764)/sqrt(2 phi(Q))
      + 2.526/sqrt(2Q)
      + (3.25 log(2Q)+7.82)/phi(Q)
      + (13.66 log(2Q)+37.55)/Q + .000428
    ] + .000709002.

For Q>=4, the monotonicity of log(t)/sqrt(t), 1/sqrt(t), log(t)/t, and 1/t on t>=2Q permits this envelope. The original proof uses R<.68, w in [.05,8], the actual Gaussian convolution, and the two trivial tails. Every coefficient multiplying a logarithm or reciprocal square root in this displayed expression is positive. Independent review accepted the exhaustive extension and reproduced its entire accepted list using a different totient recurrence and logarithm implementation. The review is `agents/audit/BASE_GAP_CLASSIFIER_REVIEW.md`.

The script `work/qrh-campaign/base_gap_classifier.py` evaluates an upper rational enclosure of U(Q) for every integer 4<=Q<=150000. It computes phi by an integer sieve. For the logarithm, it rounds Q up to the next multiple of 1000 and uses a positive atanh series with a proved geometric tail, followed by upward rounding to 10^-9. The reciprocal square root uses an integer square root and upward rounding; each resulting square inequality is asserted exactly. Floating-point values are printed only for readability and never decide coverage.

The acceptance test is U_upper(Q)<=.04712. The previously reviewed lower bound ghatY(y,150000)>.04712 holds for all y>=1e25, so accepted denominators meet the actual consumer allowance, conditional on the Type I/II inputs.

## Result

The exact run accepts 49,034 denominators, including 7,717 primes and 41,317 composites. The smallest accepted denominator is 60,859. All 8,268 denominators in the old rectangular branch are accepted, giving 40,766 additional cases. The output JSON stores the full accepted list and selected exact rational bounds.

The remaining 100,966 denominators in 1..150000 include Q=1,2,3, which this classifier deliberately does not test. Rejection means only that this sufficient envelope did not certify the case. It is not evidence that the desired bound is false. In particular the smooth examples 90090 and 120120 fail this coarse envelope and are subjects of the separate binned estimates.

The sharper binned method retains the y-dependent R coefficient and compares it with an affine lower bound for ghatY. Its five sufficient rectangles also passed independent paper/source review and exact replay. Its coverage is recorded separately. Neither coverage count is a fraction of the whole Goldbach proof completed.

The integer union of those five rectangles contains 73,578 denominators: 8,715 primes and 64,863 composites. It contains the entire 49,034-element coarse list, so the combined coverage is still 73,578. The smallest covered denominator is 50003. Exactly 76,422 denominators remain in 1..150000, with maximum119910. The script `agents/major-constants/base_gap_coverage_counts.py` stores both complete lists and checks the partition; the coordinator reproduced its counts. The analytic rectangle certificates and their formal proof obligations are unchanged by this counting step.

## Proof obligations preserved

1. Replace the prime, Mobius, Liouville, and other inputs actually consumed by Type I/II.
2. Formalize the convolution and monotonicity argument and replay the finite rational checks in Lean, or replace them with simpler sufficient rectangles.
3. Cover every remaining base-gap denominator and twist.
4. Retain the separate off-larger-arcs and global totient obligations.

The previous conversational Fermi-estimate turn did not change proof state. This continuation makes research progress by computing exact coverage and producing reproducible evidence. It does not seal a theorem.

    DRAFT_ANCHORS: 0
    UNREGISTERED_SORRIES: 0 introduced
    DRAFT_IMPORT_VIOLATIONS: 0
    SEALED_THIS_TURN: 0
