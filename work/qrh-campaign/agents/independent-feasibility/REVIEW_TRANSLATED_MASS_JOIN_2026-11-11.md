# Independent review of the translated zeta mass join

Verdict: **PASS at paper/source level**, 2026-11-11. The two arguments compose to the stated finite, multiplicity-weighted inequality for every real translate. I found no remaining mathematical gap in this composition. No new Lean proof, elaboration, build, numerical function evaluation, spectral certificate, or transitive kernel-axiom audit was performed. The conclusion below is a reviewed paper proof using the cited existing source theorems, not a claim that the new theorem has been formalized.

## Frozen inputs and checks

Paths are relative to `work/qrh-campaign/agents/`.

| Input | SHA256 |
| --- | --- |
| `prime-estimates/TRANSLATED_MASS_DIGAMMA_JOIN_2026-11-11.md` | `DAE3AC2179E3DC43FC0C91DA0297D412DF01A444D96AE3ED27214BE165166115` |
| `zero-sum/FINITE_MASS_ORDER_TRANSPORT_2026-11-11.md` | `C62CB504C15A02CB954C35F8F5DAB5B551C483014F6FEE1F957FF37C444C5E0D` |

Both reports were read in full. I inspected the actual definitions and relevant proofs/signatures in `Explicit/XiPartial.lean`, `Xi.lean`, `WeilBridge.lean`, `Landau.lean`, `ZetaZeroSums.lean`, and `ZetaDatum.lean`; and Mathlib's Gamma `Beta`, `Basic`, `Digamma`, `LocallyUniformLimit`, dominated-convergence, sum/integral-comparison and von Mangoldt L-series interfaces. The source roots and commit identifiers are those stated in the frozen author reports.

The companion `translated_mass_source_review_20261111.py` independently checked both report hashes, all **23 distinct source-file hashes** in their source tables, and the rational constant arithmetic. Its exclusive output `translated_mass_source_review_20261111.json` has SHA256 `3402E4FB6EABC660911CE3FDD50F4131770A60B322DED0B8538ECF8C9C8ED295`. It imports no target code. The analytic review is the argument below, not a conclusion inferred from those hash or scalar checks.

## Exact finite carrier and multiplicities

The exported `xi_partial_approx` really provides only **T > 0**. Its simultaneous conclusions give approximation at every eligible evaluation point, inclusion of every zero in the fixed M-ball, and the fact that all square entries are genuine xiF zeros. Its implementation happens to choose a large height, but a consumer cannot strengthen the exported conclusion from that fact.

For a fixed finite selected set S and s with Re(s)>1, the proposed M is nonnegative and contains s and every selected zero. The same M is used for every positive epsilon. From membership in `sqZeros T`, the actual `zerosIn` definition and `mem_zerosIn` give norm(rho-1/2)<3T<6T. Thus the containing closed-ball hypothesis of `divB_eq_of_analyticOrderAt_eq` holds using only T>0. The stale `R=4T` comment does not override the definition's 6T.

Original `zerosRectD zetaF U` membership supplies the other containing ball and, when there is any selected element, U>0. `analyticOrderAt_xiF_eq` applies in the strict right half-plane. Hence equality of divisor values, followed by `.toNat`, identifies the **original** `multRectD` weights with the returned square's `mult` weights. The convenience lemma `multRectD_eq_mult`, which needs T>=1, is not used without its hypothesis.

The true-order interpretation is also valid: xiF is entire and not identically zero (xiF(1)=1), so every zero has finite positive analytic order. Near a strict-strip zero the factors linking xiF, zetaF and zeta are analytic and nonzero. Orders therefore agree. Replacing each multiplicity by 1, duplicating a zero with its full order, or changing the containing square without proving new approximation would not be valid; neither report does so.

All returned square zeros have 0<Re(rho)<1 by the actual xiF zero-free half-plane results. At Re(s)>1 every kernel Re(1/(s-rho)) is positive. The source approximation has `(rho-s)^(-1)`, so it is norm(L-Q)<=epsilon with Q the sum of `(s-rho)^(-1)` terms. Consequently the selected weighted sum is at most Re(Q), which is at most Re(L)+epsilon. Its left side and true weights are independent of the epsilon-dependent T. Choosing epsilon half a hypothetical positive gap proves the exact inequality. No infinite-zero-series limit, pairing, simplicity, count bound, or finite RH premise enters.

An empty selected set is included, even for U<=0. Closed requested ordinate windows can be placed in a strictly larger auxiliary rectangle. Hypothetical real strict-strip zeros cause no exception; 0 and 1 themselves are excluded by the actual xiF values.

## Actual digamma, rather than a formal series

The GammaSeq formula and its finite integral representation match the source, including the product from 0 through N and N>0. For 0<a<=b the majorant exp(-t)*(t^(a-1)+t^(b-1)) is integrable: both endpoint exponents have positive Gamma parameters. On t>0 the cutoff kernels q_N lie between 0 and exp(-t), converge pointwise to exp(-t), and multiply a complex power whose norm depends only on Re(s). These facts give the common real error J_N tending to zero and the uniform bound for the entire closed vertical strip. They are stronger than the source's pointwise GammaSeq convergence and justify the added local-uniform claim.

Taking N=n+1 avoids the zero-index exception. Each approximant is holomorphic on Re(s)>0: none of its denominator factors vanishes there. The actual `TendstoLocallyUniformlyOn.deriv` interface has exactly the needed eventual holomorphy and open-set hypotheses. Gamma is nonzero there, so convergence of the derivative and function permits the logarithmic-derivative quotient limit.

Subtracting finite logarithmic derivatives at 1+iv and 1 cancels log N. The resulting summand is iv/[n(n+iv)] with norm at most |v|/n^2. Absolute convergence and the existing digamma value at 1 therefore identify the series with the actual `Complex.digamma`, for all real v including 0. The real-part passage is continuous and does not differentiate or rearrange a merely conditional series.

The real summand v^2/[t(t^2+v^2)] is nonnegative and antitone for t>0. The source sum/integral theorem gives the proposed indices after the first summand is separated. Its primitive log t - (1/2)log(t^2+v^2) is valid also at v=0 on this domain. The finite upper bound passes to the convergent series and yields Re(digamma(1+iv))<=1+log(1+|v|). No improper-integral limit or unproved large-height restriction is needed.

## Completed normalization and strict constants

At s=2+ic the source identities give exactly

    xiF'/xiF = 1/s + 1/(s-1) - (log pi)/2
               + digamma(s/2)/2 + zeta'/zeta.

All nonzero and differentiability hypotheses hold at this real part. This uses the actual source completion, and requires no choice of a logarithm of Gamma or xiF.

For the zeta term, the absolutely convergent von Mangoldt L-series and Lambda(n)<=log n give the norm bound by sum log(n)/n^2 starting at n=2. The finite antitone sum comparison gives a common **non-strict** bound

    sum <= 1/2 + (3/4)log 2.

That same bound survives the limit. Only then use log 2<7/10 to obtain the strict norm bound <41/40. Merely passing individual strict <41/40 bounds to a limit would not justify strictness; the reports supply the stronger intermediate bound needed here.

The reciprocal real parts total at most 3/2, log pi>=1 follows from exp(1)<3<pi, and the digamma term contributes at most (1+log(1+|c|/2))/2. Thus

    Re(logDeriv xiF(2+ic)) < 101/40 + (1/2)log(1+|c|/2)
                          < 3 + (1/2)log(1+|c|/2).

The second gap is exactly 19/40, uniformly for every real c. Combining this with the finite-order transport proves, in particular, the requested non-strict bound on the selected weighted mass with constant 3. Signs of c and the reversal between c-Im(rho) and Im(rho)-c do not affect the squared denominator.

## Accepted scope and remaining work

No correction to the frozen author notes is required. The selected source statements carry no finite RH or QRH hypothesis; the nearby `rh_upto_1e8` declaration in `ZetaZeroSums` is not used by `zerosRectD_zetaF_strip`. This source review is not a substitute for a future transitive compiled axiom report.

The new formal work remains: uniform GammaSeq convergence and its derivative application; the finite log-derivative computation and digamma difference series; the two finite sum bounds and completed constant; and the finite carrier/order/epsilon transport. These must still be implemented and checked in Lean, with source integration and axiom auditing. The present result supplies the paper argument for the translated-mass input; it neither supplies other sharper reciprocal moments nor proves any finite spectral certificate or the full Goldbach goal.
